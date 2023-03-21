Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E2E6C3D9B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 23:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCUWSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 18:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjCUWSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 18:18:40 -0400
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77321E2BE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:18:39 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id 04DE516C0008;
        Wed, 22 Mar 2023 00:18:37 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id E3HaXk0NAyie; Wed, 22 Mar 2023 00:18:33 +0200 (EET)
From:   Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1679437113; bh=esiCyKOeRzOLdYIVhVrXW6XDb+dUfcaBNizQSQbemhA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Gs+vK6HPaIqLXChtT2Kk/SmmFCHQ5yHmyT9ThRurlMegTjCiW8/aT95i8jdmIioPq
         iHeLYuz8urbvwB+u0F8MSPQWdbIWthONiiIhavj2vNGRb9aMV+l6IwWfW8Me5Af+9y
         sD+UY2i9lHYR6sRn0xbBuEuzuh1IvuqQXrmBXK9k=
To:     Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 3/4] ASoC: amd: acp: Add machine driver that enables
 sound for systems with a ES8336 codec
In-Reply-To: <141a3320-ff65-459f-9d00-c8bed691dcfc@sirena.org.uk>
References: <20230320203519.20137-1-posteuca@mutex.one>
 <20230320203519.20137-4-posteuca@mutex.one>
 <141a3320-ff65-459f-9d00-c8bed691dcfc@sirena.org.uk>
Date:   Wed, 22 Mar 2023 00:17:24 +0200
Message-ID: <87lejpwxzf.fsf@mutex.one>
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

>> +static int acp3x_es83xx_speaker_power_event(struct snd_soc_dapm_widget *w,
>> +					    struct snd_kcontrol *kcontrol, int event)
>> +{
>> +	struct acp3x_es83xx_private *priv = get_mach_priv(w->dapm->card);
>> +
>> +	dev_dbg(priv->codec_dev, "speaker power event: %d\n", event);
>> +	if (SND_SOC_DAPM_EVENT_ON(event))
>> +		acp3x_es83xx_set_gpios_values(priv, 1, 0);
>> +	else
>> +		acp3x_es83xx_set_gpios_values(priv, 0, 1);
>
> Why are these two GPIOs tied together like this?
>

These GPIOs represent the speaker and the headphone switches. When
activating the speaker GPIO you have to deactivate the headphone GPIO
and vice versa. The logic is taken from the discussion on the sofproject
pull request:
https://github.com/thesofproject/linux/pull/4112/commits/810d03e0aecdf0caf580a5179ee6873fb33485ab
and
https://github.com/thesofproject/linux/pull/4066

>> +static int acp3x_es83xx_suspend_pre(struct snd_soc_card *card)
>> +{
>> +	struct acp3x_es83xx_private *priv = get_mach_priv(card);
>> +
>> +	dev_dbg(priv->codec_dev, "card suspend\n");
>> +	snd_soc_component_set_jack(priv->codec, NULL, NULL);
>> +	return 0;
>> +}
>
> That's weird, why do that?

This is needed because if suspending the laptop with the headphones
inserted, when resuming, the sound is not working anymore. Sound stops
working on speakers and headphones. Reinsertion and removals of the
headphone doesn't solve the problem.

This seems to be caused by the fact
that the GPIO IRQ stops working in es8316_irq() after resume.
Now the call to snd_soc_component_set_jack() in suspend disables the
GPIO IRQ and in resume the GPIO IRQ is reactivated.
By the way this sequence is also used in bytcht_es8316.c in suspend and
resume:

static int byt_cht_es8316_suspend(struct snd_soc_card *card)
{
	struct snd_soc_component *component;

	for_each_card_components(card, component) {
		if (!strcmp(component->name, codec_name)) {
			dev_dbg(component->dev, "disabling jack detect before suspend\n");
			snd_soc_component_set_jack(component, NULL, NULL);
			break;
		}
	}

	return 0;
}

static int byt_cht_es8316_resume(struct snd_soc_card *card)
{
	struct byt_cht_es8316_private *priv = snd_soc_card_get_drvdata(card);
	struct snd_soc_component *component;

	for_each_card_components(card, component) {
		if (!strcmp(component->name, codec_name)) {
			dev_dbg(component->dev, "re-enabling jack detect after resume\n");
			snd_soc_component_set_jack(component, &priv->jack, NULL);
			break;
		}
	}
