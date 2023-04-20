Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A396E971B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 16:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjDTOam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 10:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjDTOaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:30:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B99469E;
        Thu, 20 Apr 2023 07:30:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 971E7616EA;
        Thu, 20 Apr 2023 14:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB43C433D2;
        Thu, 20 Apr 2023 14:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682001034;
        bh=I4cEvv+GEdKfbFZhbGFcR+MrvoiSBuicUviURQnyCxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sWfvXyFjP1McpPH6RJDeQFET1qGveIMfqOOQgly3qSPIKcw6HTD8Wtz7LenrL4Mq7
         lnxGO4Be2FI+4gRhv4q+SrvpuB5U2Wtw1PHPxQJ3LAu8ufHf89D93xUU12kbI2pVNb
         GeIpiv7ToI2j8GUqURu6JLFLYGLiYdEk3Z7rCul0Z3TdD9TgBk5jX72vnz6s/bF1BX
         C7D9HoWqeK29fOURGKWHryym+sOHwQJW49pe36XkgS+yYkCXZaNNCAy05k+8EwERqv
         w8vrZxTL9ANbBRvzn8iryNXnEzk9MBvgdGWJhx3F7FOeRku9SxuLkq3Fkd+WWS6mXD
         g528GhxhTGSJA==
Date:   Thu, 20 Apr 2023 15:30:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/4] ASoC: starfive: Add JH7110 TDM driver
Message-ID: <27e57746-d05b-4983-a631-29306851a478@sirena.org.uk>
References: <20230420024118.22677-1-walker.chen@starfivetech.com>
 <20230420024118.22677-4-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NI6GNQYuRDrkmma6"
Content-Disposition: inline
In-Reply-To: <20230420024118.22677-4-walker.chen@starfivetech.com>
X-Cookie: Above all else -- sky.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NI6GNQYuRDrkmma6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 20, 2023 at 10:41:17AM +0800, Walker Chen wrote:
> Add tdm driver support for the StarFive JH7110 SoC.

This is mostly fine, though the code all feels a bit messy somehow.
A lot of this is just coding style, I've highlighted a bunch of things
below.  There's also a couple of more substantial issues.

> @@ -0,0 +1,579 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TDM driver for the StarFive JH7110 SoC
> + *
> + * Copyright (C) 2023 StarFive Technology Co., Ltd.

Please make the entire comment a C++ one so things look more
intentional.

> +static int jh7110_tdm_syncdiv(struct jh7110_tdm_dev *tdm)
> +{
> +	u32 sl, sscale, syncdiv;
> +
> +	sl = (tdm->rx.sl >= tdm->tx.sl) ? tdm->rx.sl : tdm->tx.sl;
> +	sscale = (tdm->rx.sscale >= tdm->tx.sscale) ? tdm->rx.sscale : tdm->tx.sscale;

Please write normal conditional statements to improve legibility.

> +static int jh7110_tdm_clk_enable(struct jh7110_tdm_dev *tdm)
> +{

> +       ret = clk_set_parent(tdm->clk_tdm, tdm->clk_tdm_ext);
> +       if (ret) {
> +               dev_err(tdm->dev, "Can't set clock source for clk_tdm: %d\n",
> +ret);
> +               goto dis_tdm_clk;
> +       }

It's a bit weird to enable clocks and then reparent afterwards, that
seems more likely to run into issues with glitches doing something bad
than reparenting with the clock disabled.

This parenting looks like a system specific configuration (what if
the SoC is driving the audio bus?), and might be better done by using
the clock bindings.  It's also strange that the driver is reparenting
every single time it enables the clocks rather than doing that once on
init.

> +static int jh7110_tdm_suspend(struct snd_soc_component *component)
> +{
> +	return pm_runtime_force_suspend(component->dev);
> +}
> +
> +static int jh7110_tdm_resume(struct snd_soc_component *component)
> +{
> +	struct jh7110_tdm_dev *tdm = snd_soc_component_get_drvdata(component);
> +
> +	/* restore context */
> +	jh7110_tdm_writel(tdm, TDM_PCMGBCR, tdm->saved_pcmgbcr);
> +	jh7110_tdm_writel(tdm, TDM_PCMDIV, tdm->saved_pcmdiv);
> +
> +	return pm_runtime_force_resume(component->dev);
> +}

It is weird that we restore context that we don't save on suspend, the
code *works* but it looks off.

> +static int jh7110_tdm_hw_params(struct snd_pcm_substream *substream,
> +				struct snd_pcm_hw_params *params,
> +				struct snd_soc_dai *dai)
> +{
> +	struct jh7110_tdm_dev *tdm = snd_soc_dai_get_drvdata(dai);
> +	int chan_wl, chan_sl, chan_nr;
> +	unsigned int data_width;
> +	unsigned int dma_bus_width;
> +	struct snd_dmaengine_dai_dma_data *dma_data = NULL;
> +	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
> +	struct snd_soc_dai_link *dai_link = rtd->dai_link;
> +
> +	dai_link->stop_dma_first = 1;

A driver shouldn't be forcing dai_link settings, and hw_params is
claerly the wrong place to be configuring something like this which
never varies at runtime - it should be done on init().  If the DAI
really needs this you should extend the core so there's a flag in the
dai_driver which gets checked.

> +	switch (chan_nr) {
> +	case ONE_CHANNEL_SUPPORT:
> +	case TWO_CHANNEL_SUPPORT:
> +	case FOUR_CHANNEL_SUPPORT:
> +	case SIX_CHANNEL_SUPPORT:
> +	case EIGHT_CHANNEL_SUPPORT:

I am having a *really* hard time finding these definitions (which aren't
namespaced...) helpful.  Just write the numbers directly.

> +static int jh7110_tdm_trigger(struct snd_pcm_substream *substream,
> +			      int cmd, struct snd_soc_dai *dai)
> +{
> +	struct jh7110_tdm_dev *tdm = snd_soc_dai_get_drvdata(dai);
> +	int ret = 0;
> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		/* restore context */
> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +			jh7110_tdm_writel(tdm, TDM_PCMTXCR, tdm->saved_pcmtxcr);
> +		else
> +			jh7110_tdm_writel(tdm, TDM_PCMRXCR, tdm->saved_pcmrxcr);
> +
> +		jh7110_tdm_start(tdm, substream);

Why is the write to CR not part of start()?

> +static void jh7110_tdm_init_params(struct jh7110_tdm_dev *tdm)
> +{
> +	tdm->clkpolity = TDM_TX_RASING_RX_FALLING;
> +	if (tdm->frame_mode == SHORT_LATER) {
> +		tdm->elm = TDM_ELM_LATE;
> +		tdm->syncm = TDM_SYNCM_SHORT;
> +	} else if (tdm->frame_mode == SHORT_EARLY) {
> +		tdm->elm = TDM_ELM_EARLY;
> +		tdm->syncm = TDM_SYNCM_SHORT;
> +	} else {
> +		tdm->elm = TDM_ELM_EARLY;
> +		tdm->syncm = TDM_SYNCM_LONG;
> +	}

This looks like it should be a switch statement, and the defintiions
namespaced.  I can't see anyhwere where this ever gets configured to
anything other than SHORT_LATER ever being used so might be better to
just delete.

> +	tdm->ms_mode = TDM_AS_SLAVE;

Please use the modern provider/consumer terminology for clocking.

> +	tdm->clk_tdm_ahb = clks[0].clk;
> +	tdm->clk_tdm_apb = clks[1].clk;
> +	tdm->clk_tdm_internal = clks[2].clk;
> +	tdm->clk_tdm = clks[3].clk;
> +	tdm->clk_mclk_inner = clks[4].clk;
> +	tdm->clk_tdm_ext = clks[5].clk;

Given that the driver only ever interacts with the clocks en masse is
there any point in having all the specific named variables, that'd mean
that the enable/disable could just use loops.

> +/*  DMA registers */
> +#define TDM_FIFO			0x170c0000
> +#define TDM_FIFO_DEPTH			32

None of the defines in the header are namespaced and some of them (like
the above) seem generic enough to be likely to result in conflicts.

--NI6GNQYuRDrkmma6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRBTHgACgkQJNaLcl1U
h9DqOAgAhThQ/9yrzRRMXGDWY1z3TSWn/xy6/6JIXnBgvSysHQy5F2YXZhipWYBt
IIIelfg5I4OzL/ZNHEWAcCL/9J88ua+xM9dSRZOKUF33zfMb4woVoesNhLCLICXw
M8jy8naVp0QAD5gIbmvm+hB3DCQAIdlog2kCKQN6OJpfJP/6A4MEAHK7/LKIrseK
Jt63A+1xcCUxK7UJhvR7g2zHS4Zn4z8lU1W7+Jxtx9tDpimn616OcPMmjDo6TwVy
sP8l2dDec7rbcL65a/acq3gZI3CHIurh6nHzXOshSCOkB8aHXVCjMmjRwvKSRLV1
WWjH8VLGisYWBAxzBmLkSlEvs2bjew==
=wfqy
-----END PGP SIGNATURE-----

--NI6GNQYuRDrkmma6--
