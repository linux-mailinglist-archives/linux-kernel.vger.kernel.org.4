Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899556F5F3F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjECTjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjECTjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:39:31 -0400
X-Greylist: delayed 436 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 03 May 2023 12:39:29 PDT
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFB2619E
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 12:39:29 -0700 (PDT)
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 668F011E6;
        Wed,  3 May 2023 21:32:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 668F011E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1683142329; bh=134enEbGMk+lh5qLFrd6rCqMfaAzngLEWDoCerDp574=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=mH1R4hNdkw8mc5omaYOxBvqB+s5qmt34wH6OTqYXyqhtLd+v5/ly3hUNwGdvhf8wb
         arX4muFNRvDyhnoLlqXydwS43CBhirbD6HeSl1N2/cX8uT2TWV/mx1mDndmqsx/yiP
         ss92gGVOymJwisBmUZ0Hw/HYgbRRiVgNGOinb5KE=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Wed,  3 May 2023 21:32:03 +0200 (CEST)
Message-ID: <7b80ef1e-23dd-c523-0663-4bf311c1823a@perex.cz>
Date:   Wed, 3 May 2023 21:32:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     Jeff Chua <jeff.chua.linux@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        ALSA development <alsa-devel@alsa-project.org>
References: <CAAJw_ZsbTVd3Es373x_wTNDF7RknGhCD0r+NKUSwAO7HpLAkYA@mail.gmail.com>
 <ZE9ngFLRqLkN6faH@ugly> <87wn1pmm4d.wl-tiwai@suse.de>
From:   Jaroslav Kysela <perex@perex.cz>
Subject: Re: linux-6.4 alsa sound broken
In-Reply-To: <87wn1pmm4d.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03. 05. 23 18:10, Takashi Iwai wrote:
> On Mon, 01 May 2023 09:17:20 +0200,
> Oswald Buddenhagen wrote:
>>
>> On Mon, May 01, 2023 at 11:59:12AM +0800, Jeff Chua wrote:
>>> Latest git pull from Linus's tree ... playing a simple sound file will
>>> resulted in a lot of echo.
>>>
>> how _exactly_ does it sound?
>> have you recorded a file through loopback for us to investigate? best
>> would be a short sample of a clean wave (sine or sawtooth) with some
>> leading and trailing silence.
>>
>>> Running on Lenovo X1 with ..
>>> 00:1f.3 Audio device: Intel Corporation Alder Lake PCH-P High
>>> Definition Audio Controller (rev 01)
>>>
>>> I've bisected and reverted the following patch fixed the problem.
>>>
>> this seems weird. so my first thought is: are you _sure_ that your
>> bisect isn't "contaminated" somehow? is the effect consistent across
>> several reboots with the same build? does re-applying my patch
>> immediately re-introduce the problem?
>>
>> - this code is about silencing. getting dropouts or no playback at all
>> would be plausible, while echo (that is, repetition) seems surprising.
>>    theoretically, the driver may be setting a bad fill_silence()
>> callback   which copies some garbage instead of zeroing, but the HDA
>> driver   doesn't set one at all (i.e., uses the default one).
>> - this code must be explicitly enabled, which for all i know is done
>> by   almost nothing. what players did you try? did you get consistent
>> results? did you try taking out audio servers from the equation?
>> - the affected hardware belongs to the extremely widely used HDA
>> family,   which at the layer the patch is even remotely connected with
>> is   completely standardized. so _a lot_ of people should be affected,
>> and   we should be getting reports like yours by the dozen. are we?
>>
>> of course i can't exclude the possibility that my patch is affected by
>> an uninitialized variable or memory corruption (or in the worst case
>> causes it), which would of course have very hard to predict
>> effects. but that should be investigated properly instead of just
>> reverting, lest we might be papering over a much more serious problem.
> 
> Oswald, this looks like a real regression by the patch.
> Specially, this happens with dmix, and the issue doesn't seem specific
> to the driver.  It happens also with USB-audio, not only with
> HD-audio.  Just aplay /usr/share/sounds/alsa/Side_Left.wav or whatever
> there with the dmix config showed the problem.
> 
> The dmix uses the silence_size=boundary as a fill-all operation, and
> it's a free-wheel mode, so supposedly something was overlooked in your
> code refactoring.
> 
> Could you check it and address quickly?  I'd like to fix it before
> 6.4-rc1 release, so if no fix comes up in a couple of days, I'll have
> to revert the change for 6.4-rc1.

I would revert this patch. It seems that this "do silence right after the playback is finished" mechanism is not handled in the updated code (and I overlooked that, too):

-       ofs = runtime->status->hw_ptr;
-       frames = new_hw_ptr - ofs;
-       if ((snd_pcm_sframes_t)frames < 0)
-           frames += runtime->boundary;
-       runtime->silence_filled -= frames;
-       if ((snd_pcm_sframes_t)runtime->silence_filled < 0) {
-           runtime->silence_filled = 0;
-           runtime->silence_start = new_hw_ptr;
-       } else {
-           runtime->silence_start = ofs;
-       }

It requires to track the old and new hw_ptr, so the removal of the new_hw_ptr argument is not valid. I don't see any easy way to fix this.

I would probably fix the snd_pcm_playback_hw_avail() call with the old hw_ptr which seems like the only one issue with the original code, because it makes the threshold inaccurate (it is expected to fill more silent samples). Another issue is wrong silence_start for the incremental silence calls.

The patch to fix the original code may look like:

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index af1eb136feb0..70795a83e50a 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -45,7 +45,7 @@ static int fill_silence_frames(struct snd_pcm_substream *substream,
  void snd_pcm_playback_silence(struct snd_pcm_substream *substream, snd_pcm_uframes_t new_hw_ptr)
  {
  	struct snd_pcm_runtime *runtime = substream->runtime;
-	snd_pcm_uframes_t frames, ofs, transfer;
+	snd_pcm_uframes_t start, frames, ofs, transfer;
  	int err;
  
  	if (runtime->silence_size < runtime->boundary) {
@@ -63,12 +63,17 @@ void snd_pcm_playback_silence(struct snd_pcm_substream *substream, snd_pcm_ufram
  		}
  		if (runtime->silence_filled >= runtime->buffer_size)
  			return;
+		/* use appl_ptr as a temporary variable */
+		appl_ptr = runtime->status->hw_ptr;
+		runtime->status->hw_ptr = new_hw_ptr;
  		noise_dist = snd_pcm_playback_hw_avail(runtime) + runtime->silence_filled;
+		runtime->status->hw_ptr = appl_ptr;
  		if (noise_dist >= (snd_pcm_sframes_t) runtime->silence_threshold)
  			return;
  		frames = runtime->silence_threshold - noise_dist;
  		if (frames > runtime->silence_size)
  			frames = runtime->silence_size;
+		start = (runtime->silence_start + runtime->silence_filled) % runtime->boundary;
  	} else {
  		if (new_hw_ptr == ULONG_MAX) {	/* initialization */
  			snd_pcm_sframes_t avail = snd_pcm_playback_hw_avail(runtime);
@@ -92,12 +97,13 @@ void snd_pcm_playback_silence(struct snd_pcm_substream *substream, snd_pcm_ufram
  			}
  		}
  		frames = runtime->buffer_size - runtime->silence_filled;
+		start = runtime->silence_start;
  	}
  	if (snd_BUG_ON(frames > runtime->buffer_size))
  		return;
  	if (frames == 0)
  		return;
-	ofs = runtime->silence_start % runtime->buffer_size;
+	ofs = start % runtime->buffer_size;
  	while (frames > 0) {
  		transfer = ofs + frames > runtime->buffer_size ? runtime->buffer_size - ofs : frames;
  		err = fill_silence_frames(substream, ofs, transfer);

I'll post a complete patch when we agree on this solution. The runtime->status->hw_ptr may not be even preserved, because it is no used in the rest of code in snd_pcm_update_hw_ptr0(), but the code looks more sane.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

