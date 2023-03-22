Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACEF6C5857
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 22:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjCVVB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 17:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCVVBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 17:01:54 -0400
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D5E131
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 14:01:53 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id 5836116C0008;
        Wed, 22 Mar 2023 23:01:52 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Nphm6PsD5iIt; Wed, 22 Mar 2023 23:01:50 +0200 (EET)
From:   Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1679518910; bh=Qb0DCB9GnOZWIWTpK2flB93CdhdyhfwNaN1lSFU0oNA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TO+7w9ZKS0P1CHWXiF/YmH3IQ4w0a6oeAqxZNDIHBNPujD2W6vxkggKIk2lIxDcWK
         Mq0pMKaHauI+4hGRKYz193ScwivpDmShRlD3expIDcmniGFii1LJyIOioRjyrtPaVQ
         YiILjmItA5qzE8/cjao/ZcRB2GzlHFaRd8M8aAf8=
To:     Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 4/4] ASoC: amd: acp: Improve support for speaker power
 events
In-Reply-To: <0989fc51-fee7-4558-ba2c-084cc4fb6833@sirena.org.uk>
References: <20230320203519.20137-1-posteuca@mutex.one>
 <20230320203519.20137-5-posteuca@mutex.one>
 <0989fc51-fee7-4558-ba2c-084cc4fb6833@sirena.org.uk>
Date:   Wed, 22 Mar 2023 23:01:48 +0200
Message-ID: <87r0tgjy9v.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> writes:

> On Mon, Mar 20, 2023 at 10:35:19PM +0200, Marian Postevca wrote:
>> In order to reduce the audible pops when speaker or headphones
>> are activated or disabled we need to delay the switching of the
>> GPIOs.
>
> The usual mechanism for doing this is with the standard kernel delay
> functions.  Why not use them in the DAPM event?
>

I just followed the logic from sof_es8336.c, the reason for the change
there is given in commit log of 89cdb224f2abe37ec:

commit 89cdb224f2abe37ec4ac21ba0d9ddeb5a6a9cf68
Author: Zhu Ning <zhuning0077@gmail.com>
Date:   Fri Oct 28 10:04:56 2022 +0800

    ASoC: sof_es8336: reduce pop noise on speaker
    
    The Speaker GPIO needs to be turned on slightly behind the codec turned on.
    It also need to be turned off slightly before the codec turned down.
    Current code uses delay in DAPM_EVENT to do it but the mdelay delays the
    DAPM itself and thus has no effect. A delayed_work is added to turn on the
    speaker.
    The Speaker is turned off in .trigger since trigger is called slightly
    before the DAPM events.
    
  
>> We need to also disable/enable the speaker/headphones GPIOs when
>> the audio stream is stopped/started. To avoid race conditions
>> between the speaker power event callback and the trigger callback
>> we use a ring buffer to save the events that we need to process
>> in the delayed work callback.
>
> Why is this required?  DAPM is integrated with stream start and stop,
> and there's a mute callback to mask any noise played back from the SoC
> while it stops and starts without requiring all this complexity.  If
> there is any audible noise then why would it only affect the speaker?
>

Same reason as above, just followed the logic in sof_es8336.c

>> +static int acp3x_es83xx_trigger(struct snd_pcm_substream *substream, int cmd)
>> +{
>> +	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
>> +	struct snd_soc_card *card = rtd->card;
>> +	struct acp3x_es83xx_private *priv = get_mach_priv(card);
>> +
>> +	switch (cmd) {
>> +	case SNDRV_PCM_TRIGGER_START:
>> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>> +	case SNDRV_PCM_TRIGGER_RESUME:
>> +		if (substream->stream == 0) {
>> +			dev_dbg(priv->codec_dev, "trigger start/release/resume, activating GPIOs\n");
>> +			mutex_lock(&priv->rb_lock);
>
> Triggers run in atomic context, you can't use mutexes in atomic context.
> lockdep should tell you this.

Sorry, I didn't run lockdep before sending the patches, I will rework
the locking code.
