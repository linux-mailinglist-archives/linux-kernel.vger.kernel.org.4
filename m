Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E396C5821
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 21:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjCVUuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 16:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjCVUuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 16:50:35 -0400
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B2D5ADD7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:48:34 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id 6BD4616C0008;
        Wed, 22 Mar 2023 22:48:32 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5D_69F_8jHUO; Wed, 22 Mar 2023 22:48:31 +0200 (EET)
From:   Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1679518111; bh=UGI4wuqk28si00gqCk+pXZy1oVhNUVal257IJk22lcA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NMckDuv5o61W0GTAMnDxZYomYSjRDvNjw2n9tfnDDAipdtO80UIWbF8O6iq+58nl5
         fCy4eAxEWvy3bgxhjzzyZIE4/SKKpQ6F1XvSAHs2/wVoORoUGR/XK+vYiA65Igati2
         XR3es+DN0t0kKnjmLkUiDN+OBObA4KNmfyoe8BPI=
To:     Mark Brown <broonie@kernel.org>,
        =?utf-8?B?5rKI5LiA6LaF?= <zhuning0077@gmail.com>,
        yangxiaohua <yangxiaohua@everest-semi.com>,
        Zhu Ning <zhuning@everest-semi.com>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 3/4] ASoC: amd: acp: Add machine driver that enables
 sound for systems with a ES8336 codec
In-Reply-To: <ZBr9rJn50ovG1w9W@sirena.org.uk>
References: <20230320203519.20137-1-posteuca@mutex.one>
 <20230320203519.20137-4-posteuca@mutex.one>
 <141a3320-ff65-459f-9d00-c8bed691dcfc@sirena.org.uk>
 <87lejpwxzf.fsf@mutex.one> <ZBr9rJn50ovG1w9W@sirena.org.uk>
Date:   Wed, 22 Mar 2023 22:48:28 +0200
Message-ID: <87ttycjyw3.fsf@mutex.one>
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

> On Wed, Mar 22, 2023 at 12:17:24AM +0200, Marian Postevca wrote:
>> Mark Brown <broonie@kernel.org> writes:
>
>> >> +	if (SND_SOC_DAPM_EVENT_ON(event))
>> >> +		acp3x_es83xx_set_gpios_values(priv, 1, 0);
>> >> +	else
>> >> +		acp3x_es83xx_set_gpios_values(priv, 0, 1);
>
>> > Why are these two GPIOs tied together like this?
>
>> These GPIOs represent the speaker and the headphone switches. When
>> activating the speaker GPIO you have to deactivate the headphone GPIO
>> and vice versa. The logic is taken from the discussion on the sofproject
>> pull request:
>> https://github.com/thesofproject/linux/pull/4112/commits/810d03e0aecdf0caf580a5179ee6873fb33485ab
>> and
>> https://github.com/thesofproject/linux/pull/4066
>
> Sure, but that doesn't answer the question.  What is the reason
> they're tied together - what if someone wants to play back from
> both speaker and headphones simultaneously?
>

The GPIO handling is not documented in the codec datasheet, so I
constructed this logic by looking at the existing implementations of
machine drivers for this codec (sof_es8336.c, bytcht_es8316.c) and
comments of Everest Semiconductor engineers on the sofproject
pull requests. I'm saying all of this because I don't know the reasons
why these GPIOs work the way they do.

According to the Everest Semiconductor engineers this is the recommended
way to switch these GPIOs:

+--------------+--------------+----------------+
|              | Speaker GPIO | Headphone GPIO |
+--------------+--------------+----------------+
| Speaker on   | active       | inactive       |
| Headphone on | inactive     | active         |
| Suspended    | inactive     | inactive       |
+--------------+--------------+----------------+
(https://github.com/thesofproject/linux/pull/4066/commits/b7f12e46a36b74a9992920154a65cd55f5b0cdb4#r1041693056)

This lockstep between these two GPIOs can be seen in sof_es8336.c in
pcm_pop_work_events() too.

Regarding playing the speaker and headphone simultaneously, is not
something I took into account. Is this even a valid usecase? The intel driver
for es8336 doesn't seem to support it.

Maybe someone from Everest Semiconductor can comment on this GPIO handling?

>> >> +static int acp3x_es83xx_suspend_pre(struct snd_soc_card *card)
>> >> +{
>> >> +	struct acp3x_es83xx_private *priv = get_mach_priv(card);
>> >> +
>> >> +	dev_dbg(priv->codec_dev, "card suspend\n");
>> >> +	snd_soc_component_set_jack(priv->codec, NULL, NULL);
>> >> +	return 0;
>> >> +}
>
>> > That's weird, why do that?
>
>> This is needed because if suspending the laptop with the headphones
>> inserted, when resuming, the sound is not working anymore. Sound stops
>> working on speakers and headphones. Reinsertion and removals of the
>> headphone doesn't solve the problem.
>
>> This seems to be caused by the fact
>> that the GPIO IRQ stops working in es8316_irq() after resume.
>
> That's a bug that should be fixed.

Agreed, but I don't know how easy it is to fix, and I would like to
first offer users of these laptops a working sound driver.
Afterwards this issue can be analyzed and properly fixed.


