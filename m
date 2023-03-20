Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A066C232D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjCTUzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCTUzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:55:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23181D50E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:54:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EB1FB8100E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 20:54:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9948C433A0;
        Mon, 20 Mar 2023 20:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679345668;
        bh=MZj38O/W/p2Sts3TdUPlHpLMxwEzR0oUA5rPgwYg7+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=usO8YYEd0Opfv8bzMub5hflWtFIy5FBj8Cn3yUAXTmTfeWM7Nl9omOIqzdwrnbaN8
         cVA7IioabHmBlt4fc1xKDmhJae1akbROvGI4Zw7GPkf3O8sRcNykasE0ZF64vVvWz+
         9m/V5d6KmVbVBBzpS9CMJPAyxMUt8jUGMrXbAHSzlzFX8TbX6HzligNTM9Lgw5SsdH
         Va6fiuFXma0lqrZIjKBPaXpeEcxZhTI4CzOYJQhdKWbS/aP+PPOPLNrJ5mrk5w14Zf
         S5yuMK/PnW/DuG9SgfgCrKimqj8+wEEbaSHv7iU66vwShlfaCe+RB1MxKITN2qNBVJ
         1w/75ab/wXd5w==
Date:   Mon, 20 Mar 2023 20:54:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marian Postevca <posteuca@mutex.one>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 3/4] ASoC: amd: acp: Add machine driver that enables
 sound for systems with a ES8336 codec
Message-ID: <141a3320-ff65-459f-9d00-c8bed691dcfc@sirena.org.uk>
References: <20230320203519.20137-1-posteuca@mutex.one>
 <20230320203519.20137-4-posteuca@mutex.one>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HjbsShExCSghonkH"
Content-Disposition: inline
In-Reply-To: <20230320203519.20137-4-posteuca@mutex.one>
X-Cookie: Keep away from fire or flame.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HjbsShExCSghonkH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 20, 2023 at 10:35:18PM +0200, Marian Postevca wrote:

> +static int acp_asoc_suspend_pre(struct snd_soc_card *card)
> +{
> +	int ret;
> +
> +	ret = acp_ops_suspend_pre(card);
> +	return ret == 1 ? 0 : ret;

Please write normal conditional statements to improve legibility (or
just have the function that's being called return a directly usable
value?).

> +	if (priv->quirk & ES83XX_48_MHZ_MCLK) {
> +		dev_dbg(priv->codec_dev, "using a 48Mhz MCLK\n");
> +		snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
> +					   &hw_constraint_rates_48mhz);
> +		freq = ES83xx_48_MHZ_MCLK_FREQ;
> +	} else {
> +		dev_dbg(priv->codec_dev, "using a 12.288Mhz MCLK\n");
> +		snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
> +					   &hw_constraint_rates_normal);
> +		freq = ES83xx_12288_KHZ_MCLK_FREQ;
> +	}

The CODEC driver should be able to set these constraints for itself.

> +	ret =  snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
> +				   | SND_SOC_DAIFMT_CBP_CFP);

Set this in the dai_link.

> +static int acp3x_es83xx_speaker_power_event(struct snd_soc_dapm_widget *w,
> +					    struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct acp3x_es83xx_private *priv = get_mach_priv(w->dapm->card);
> +
> +	dev_dbg(priv->codec_dev, "speaker power event: %d\n", event);
> +	if (SND_SOC_DAPM_EVENT_ON(event))
> +		acp3x_es83xx_set_gpios_values(priv, 1, 0);
> +	else
> +		acp3x_es83xx_set_gpios_values(priv, 0, 1);

Why are these two GPIOs tied together like this?

> +static int acp3x_es83xx_suspend_pre(struct snd_soc_card *card)
> +{
> +	struct acp3x_es83xx_private *priv = get_mach_priv(card);
> +
> +	dev_dbg(priv->codec_dev, "card suspend\n");
> +	snd_soc_component_set_jack(priv->codec, NULL, NULL);
> +	return 0;
> +}

That's weird, why do that?

--HjbsShExCSghonkH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQYx/4ACgkQJNaLcl1U
h9D+Wwf/bKdQ7lKzAYzNiRwqoNAblsODFOoW6si8H9tMBez8Xe8oxGGlginVJFzV
v3p2/ostjrMN/wu3reCAtpfGI3yDt674B00qSL0dk9zZZVjSBPrFwVE8vgRnxo1w
1Hbkq1HSHdyIv07ec7+rqfzfhfHt20q7sXro0D/Gq6D36SgnHc1Pq/oi0ffSahOW
bLcA0xUMTV0yJ8oK2Gzg/p83GMtzIC7IrInQF8Cuz04tSSgnwMwAVCQP5Bdui6sK
1+vjnVbAuiO8C/D6l80tLvXKE5Pg9gKyIgFgDZqW28zC+JIAfdV5+8ds9qlQXhU0
pzEQagoJ5lMgF5jxD1r5hBQ6YrXyWg==
=Y9Xp
-----END PGP SIGNATURE-----

--HjbsShExCSghonkH--
