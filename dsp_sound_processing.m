
%Uncomment certain blocks to read that output

[y, Fs] = wavread('sample.wav');
Fs
left=y(:,1);
right=y(:,2);
time=(1/Fs)*length(left);
t=linspace(0,time,length(left));
Nsamps = length(left);

%To play sound
%soundsc(left,fs);
%soundsc(right,fs);
%spectrogram(left);

max_freq= Fs*(Nsamps/2 -1 )/Nsamps;

[d c] = butter(4,3000/max_freq); %Low Pass ButterWorth filter of order 5 and cut off frequency of 3.5 kHz
LowPassfilt_left = filter(d,c,left);
LowPassfilt_right = filter(d,c,right);

[d4 c4] = butter(6,[ 300/max_freq 3500/max_freq]); % Butter Worth Filter of order 8 with cutoff frequency of 0.5kHz and  3.5kHz , normalised with respect to 22KHz
BandPassfilter_left = filter(d4,c4,left);
BandPassfilter_right = filter(d4,c4,right);


%soundsc(LowPassfilt,fs)

% figure
% freqz(d,c) % 0.1591 normalised cut off frequency
% title('Frequency Response of Low-Pass Filter ')
% figure
% freqz(d4,c4)
% title('Frequency Response of Band-Pass Filter ')




figure
subplot(3,1,1)
pwelch(left)
title('Welch Power Spectral Density Estimate of  Original Signal ')
subplot(3,1,2)
pwelch(LowPassfilt_left)
title('Welch Power Spectral Density Estimate  of  Low-Pass Filtered Signal ')
subplot(3,1,3)
pwelch(BandPassfilter_left)
title('Welch Power Spectral Density Estimate  of  Band-Pass Filtered Signal ')

figure
subplot(3,1,1)
plot(t,left)
title('Original Signal');
xlabel('time (s)')
subplot(3,1,2)
plot(t,LowPassfilt_left)
title('Low Pass Filtered Signal')
xlabel('time (s)')
subplot(3,1,3)
plot(t,BandPassfilter_left)
xlabel('time (s)')
title('Band Pass Filtered Signal')

wavwrite([LowPassfilt_left LowPassfilt_right],Fs,32,'Low_pass_filt.wav');
wavwrite([BandPassfilter_left BandPassfilter_right],Fs,32,'Band_pass_filt.wav');