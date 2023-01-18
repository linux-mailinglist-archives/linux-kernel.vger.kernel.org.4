Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783E3672733
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjARSid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjARSiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:38:18 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D026B65BC
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674067097; x=1705603097;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=Mxky+plx16rPsgtojIjqis3Gy4qDWU96AbOKvkoFz5U=;
  b=aVYccRfFGwKsQLetOA5M1WYr944Hyuec7mFiSm0qCVOgq7YBVDisrCtb
   XtxaIEV59gkAA0FNdAiWV0pbSrQM2b3HIvs9gXIiqOkY/EZC/7CLYpErf
   3dXJgCOinur7N30zjJBykUbimivz/smJHq9yi0flZdblyhasM935/78Zg
   ZyB3W/qpO1/EDzEDiMW6EibIgWHKV0Dfqb2HqVa01WGvlDMfD2A9SoNQG
   hbRSHY0gVPMN7RLcijpM3OYY8+M0wDSZ70kf0M/0OuC6pwoKvGzhH7aOW
   MS6xRKbGFs/64s6iCABBx53PA+Df3eavwK2ulO7uHiQ2PGBOwwIpDfN49
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="327138531"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="327138531"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 10:37:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="783777264"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="783777264"
Received: from jaibarra-mobl.amr.corp.intel.com (HELO [10.209.131.1]) ([10.209.131.1])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 10:37:58 -0800
Message-ID: <33130336-b2ce-330e-fdec-166eee977e13@linux.intel.com>
Date:   Wed, 18 Jan 2023 11:41:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 6/8] ASoC: cs42l42: Add Soundwire support
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>
References: <20230118160452.2385494-1-sbinding@opensource.cirrus.com>
 <20230118160452.2385494-7-sbinding@opensource.cirrus.com>
Content-Language: en-US
In-Reply-To: <20230118160452.2385494-7-sbinding@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


nitpick: please use the MIPI SoundWire spelling

> This adds support for using CS42L42 as a Soundwire device.
> 
> Soundwire-specifics are kept separate from the I2S implementation as
> much as possible, aiming to limit the risk of breaking the I2C+I2S
> support.
> 
> There are some important differences in the silicon behaviour between
> I2S and Soundwire mode that are reflected in the implementation:
> 
> - ASP (I2S) most not be used in Soundwire mode because the two interfaces
>   share pins.
> 
> - The Soundwire capture (record) port only supports 1 channel. It does
>   not have left-to-right duplication like the ASP.
> 
> - DP2 can only be prepared if the HP has powered-up. DP1 can only be
>   prepared if the ADC has powered-up. (This ordering restriction does
>   not exist for ASPs.) The Soundwire core port-prepare step is
>   triggered by the DAI-link prepare(). This happens before the
>   codec DAI prepare() or the DAPM sequence so these cannot be used
>   to enable HP/ADC. Instead the HP/ADC enable/disable are done during
>   the port_prep callback.
> 
> - The SRCs are an integral part of the audio chain but in silicon their
>   power control is linked to the ASP. There is no equivalent power link
>   to Soundwire DPs so the driver must take "manual" control of SRC power.
> 
> - The Soundwire control registers occupy the lower part of the Soundwire
>   address space so cs42l42 registers are offset by 0x8000 (non-paged) in
>   Soundwire mode.
> 
> - Register addresses are 8-bit paged in I2C mode but 16-bit unpaged in
>   Soundwire.
> 
> - Special procedures are needed on register read/writes to (a) ensure
>   that the previous internal bus transaction has completed, and
>   (b) handle delayed read results, when the read value could not be
>   returned within the Soundwire read command.
> 
> There are also some differences in driver implementation between I2S
> and Soundwire operation:
> 
> - CS42L42 does not runtime_suspend, but runtime_suspend/resume are required
>   in Soundwire mode as the most convenient way to power-up the bus manager
>   and to handle the unattach_request condition.
That's an impressive commit message indeed.

I couldn't really follow this paragraph though. The main reason why
having suspend/resume routines is to wait for initialization to be
complete, as well as handle the regcache status to deal with access to
regmap'ed registers, if any, while the bus is stopped or resuming.

Edit after reaching the end of this patch: that's actually what is done
in the implementation below so you may want to clarify this part.

> - Intel Soundwire host controllers have a low-power clock-stop mode that
>   requires resetting all peripherals when resuming. This means that the
>   interrupt registers will be reset in between the interrupt being
>   generated and the interrupt being handled, and since the interrupt
>   status is debounced, these values may not be accurrate immediately,

accurate


> diff --git a/sound/soc/codecs/cs42l42-sdw.c b/sound/soc/codecs/cs42l42-sdw.c
> new file mode 100644
> index 0000000000000..67800b275e422
> --- /dev/null
> +++ b/sound/soc/codecs/cs42l42-sdw.c
> @@ -0,0 +1,595 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// cs42l42-sdw.c -- CS42L42 ALSA SoC audio driver Soundwire binding

binding?

> +//
> +// Copyright (C) 2022 Cirrus Logic, Inc. and
> +//                    Cirrus Logic International Semiconductor Ltd.
> +
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/of_irq.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/soundwire/sdw.h>
> +#include <linux/soundwire/sdw_registers.h>
> +#include <linux/soundwire/sdw_type.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/sdw.h>
> +#include <sound/soc.h>
> +
> +#include "cs42l42.h"
> +
> +#define CS42L42_SDW_CAPTURE_PORT	1
> +#define CS42L42_SDW_PLAYBACK_PORT	2
> +
> +/* Register addresses are offset when sent over Soundwire */

nitpick: SoundWire

> +#define CS42L42_SDW_ADDR_OFFSET		0x8000
> +
> +#define CS42L42_SDW_MEM_ACCESS_STATUS	0xd0
> +#define CS42L42_SDW_MEM_READ_DATA	0xd8
> +
> +#define CS42L42_SDW_LAST_LATE		BIT(3)
> +#define CS42L42_SDW_CMD_IN_PROGRESS	BIT(2)
> +#define CS42L42_SDW_RDATA_RDY		BIT(0)
> +
> +#define CS42L42_DELAYED_READ_POLL_US	1
> +#define CS42L42_DELAYED_READ_TIMEOUT_US	100
> +
> +static const struct snd_soc_dapm_route cs42l42_sdw_audio_map[] = {
> +	/* Playback Path */
> +	{ "HP", NULL, "MIXER" },
> +	{ "MIXER", NULL, "DACSRC" },
> +	{ "DACSRC", NULL, "Playback" },
> +
> +	/* Capture Path */
> +	{ "ADCSRC", NULL, "HS" },
> +	{ "Capture", NULL, "ADCSRC" },
> +};
> +
> +static int cs42l42_sdw_dai_startup(struct snd_pcm_substream *substream,
> +				   struct snd_soc_dai *dai)
> +{
> +	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(dai->component);
> +
> +	if (!cs42l42->init_done)
> +		return -ENODEV;

Can this happen? IIRC the ASoC framework would use
pm_runtime_resume_and_get() before .startup, which would guarantee that
the device is initialized, no?

> +
> +	return 0;
> +}
> +
> +static int cs42l42_sdw_dai_hw_params(struct snd_pcm_substream *substream,
> +				     struct snd_pcm_hw_params *params,
> +				     struct snd_soc_dai *dai)
> +{
> +	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(dai->component);
> +	struct sdw_stream_runtime *sdw_stream = snd_soc_dai_get_dma_data(dai, substream);
> +	struct sdw_stream_config stream_config = {0};
> +	struct sdw_port_config port_config = {0};
> +	int ret;
> +
> +	if (!sdw_stream)
> +		return -EINVAL;
> +
> +	/* Needed for PLL configuration when we are notified of new bus config */
> +	cs42l42->sample_rate = params_rate(params);

wouldn't it be better to check if the sample_rate is supported by the
PLL here, instead of in the .prepare step ...

> +
> +	snd_sdw_params_to_config(substream, params, &stream_config, &port_config);
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		port_config.num = CS42L42_SDW_PLAYBACK_PORT;
> +	else
> +		port_config.num = CS42L42_SDW_CAPTURE_PORT;
> +
> +	ret = sdw_stream_add_slave(cs42l42->sdw_peripheral, &stream_config, &port_config, 1,
> +				   sdw_stream);
> +	if (ret) {
> +		dev_err(dai->dev, "Failed to add sdw stream: %d\n", ret);
> +		return ret;
> +	}
> +
> +	cs42l42_src_config(dai->component, params_rate(params));
> +
> +	return 0;
> +}
> +
> +static int cs42l42_sdw_dai_prepare(struct snd_pcm_substream *substream,
> +				   struct snd_soc_dai *dai)
> +{
> +	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(dai->component);
> +
> +	dev_dbg(dai->dev, "dai_prepare: sclk=%u rate=%u\n", cs42l42->sclk, cs42l42->sample_rate);
> +
> +	if (!cs42l42->sclk || !cs42l42->sample_rate)
> +		return -EINVAL;
> +
> +	return cs42l42_pll_config(dai->component, cs42l42->sclk, cs42l42->sample_rate);

... it's a bit late to verify the sample_rate is indeed supported, no?

> +}
> +
> +static int cs42l42_sdw_dai_hw_free(struct snd_pcm_substream *substream,
> +				   struct snd_soc_dai *dai)
> +{
> +	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(dai->component);
> +	struct sdw_stream_runtime *sdw_stream = snd_soc_dai_get_dma_data(dai, substream);
> +
> +	sdw_stream_remove_slave(cs42l42->sdw_peripheral, sdw_stream);
> +	cs42l42->sample_rate = 0;
> +
> +	return 0;
> +}

> +static int cs42l42_sdw_dai_set_sdw_stream(struct snd_soc_dai *dai, void *sdw_stream,
> +					  int direction)
> +{
> +	if (!sdw_stream)
> +		return 0;
> +
> +	if (direction == SNDRV_PCM_STREAM_PLAYBACK)
> +		dai->playback_dma_data = sdw_stream;
> +	else
> +		dai->capture_dma_data = sdw_stream;
> +
> +	return 0;

Humm, this is interesting, you are not using the sdw_stream_data that
all other codecs use, but in hindsight I have no idea why we allocate
something to only store a pointer.


> +
> +static struct snd_soc_dai_driver cs42l42_sdw_dai = {
> +	.name = "cs42l42-sdw",
> +	.playback = {
> +		.stream_name = "Playback",
> +		.channels_min = 1,
> +		.channels_max = 2,
> +		.rates = SNDRV_PCM_RATE_8000_96000,
> +		.formats = SNDRV_PCM_FMTBIT_S16_LE |
> +			   SNDRV_PCM_FMTBIT_S24_LE |
> +			   SNDRV_PCM_FMTBIT_S32_LE,
> +	},
> +	.capture = {
> +		.stream_name = "Capture",
> +		.channels_min = 1,
> +		.channels_max = 1,
> +		.rates = SNDRV_PCM_RATE_8000_96000,
> +		.formats = SNDRV_PCM_FMTBIT_S16_LE |
> +			   SNDRV_PCM_FMTBIT_S24_LE |
> +			   SNDRV_PCM_FMTBIT_S32_LE,

Are the rates and formats needed? IIRC only the channels are used.

> +	},
> +	.symmetric_rate = 1,
> +	.ops = &cs42l42_sdw_dai_ops,
> +};
> +

> +static void cs42l42_sdw_init(struct sdw_slave *peripheral)
> +{
> +	struct cs42l42_private *cs42l42 = dev_get_drvdata(&peripheral->dev);
> +	int ret = 0;

unnecessary init

> +
> +	regcache_cache_only(cs42l42->regmap, false);
> +
> +	ret = cs42l42_init(cs42l42);
> +	if (ret < 0) {
> +		regcache_cache_only(cs42l42->regmap, true);
> +		return;
> +	}
> +
> +	/* Write out any cached changes that happened between probe and attach */
> +	ret = regcache_sync(cs42l42->regmap);
> +	if (ret < 0)
> +		dev_warn(cs42l42->dev, "Failed to sync cache: %d\n", ret);
> +
> +	/* Disable internal logic that makes clock-stop conditional */
> +	regmap_clear_bits(cs42l42->regmap, CS42L42_PWR_CTL3, CS42L42_SW_CLK_STP_STAT_SEL_MASK);
> +
> +	/*
> +	 * pm_runtime is needed to control bus manager suspend, and to
> +	 * recover from an unattach_request when the manager suspends.
> +	 * Autosuspend delay must be long enough to enumerate.
> +	 */
> +	pm_runtime_set_autosuspend_delay(cs42l42->dev, 3000);
> +	pm_runtime_use_autosuspend(cs42l42->dev);
> +	pm_runtime_set_active(cs42l42->dev);
> +	pm_runtime_enable(cs42l42->dev);

you would want to set all this once during the first initialization.

> +	pm_runtime_mark_last_busy(cs42l42->dev);

usually this is added before the pm_runtime_enable()

> +	pm_runtime_idle(cs42l42->dev);

is this needed?

> +static int cs42l42_sdw_update_status(struct sdw_slave *peripheral,
> +				     enum sdw_slave_status status)
> +{
> +	struct cs42l42_private *cs42l42 = dev_get_drvdata(&peripheral->dev);
> +
> +	switch (status) {
> +	case SDW_SLAVE_ATTACHED:
> +		dev_dbg(cs42l42->dev, "ATTACHED\n");
> +		if (!cs42l42->init_done)
> +			cs42l42_sdw_init(peripheral);

unclear to me what happens is the bus suspends, how would you redo the init?

> +		break;
> +	case SDW_SLAVE_UNATTACHED:
> +		dev_dbg(cs42l42->dev, "UNATTACHED\n");
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}

> +static int __maybe_unused cs42l42_sdw_clk_stop(struct sdw_slave *peripheral,
> +				enum sdw_clk_stop_mode mode,
> +				enum sdw_clk_stop_type type)
> +{
> +	struct cs42l42_private *cs42l42 = dev_get_drvdata(&peripheral->dev);
> +
> +	dev_dbg(cs42l42->dev, "clk_stop mode:%d type:%d\n", mode, type);
> +
> +	return 0;

that doesn't sound terribly useful?

> +}
> +
> +static const struct sdw_slave_ops cs42l42_sdw_ops = {
> +	.read_prop = cs42l42_sdw_read_prop,
> +	.update_status = cs42l42_sdw_update_status,

what about .interrupt_callback?

I vaguely remember something about not using the in-band wake mechanism
and having a separate interrupt line, if that's what happens it's worthy
of a comment here.

> +	.bus_config = cs42l42_sdw_bus_config,
> +	.port_prep = cs42l42_sdw_port_prep,
> +#ifdef DEBUG
> +	.clk_stop = cs42l42_sdw_clk_stop,
> +#endif
> +};

> +static int cs42l42_sdw_remove(struct sdw_slave *peripheral)
> +{
> +	struct cs42l42_private *cs42l42 = dev_get_drvdata(&peripheral->dev);
> +
> +	/* Resume so that cs42l42_remove() can access registers */
> +	pm_runtime_get_sync(cs42l42->dev);

is this necessary? I thought the device framework always did that.

> +	cs42l42_common_remove(cs42l42);
> +	pm_runtime_put(cs42l42->dev);
> +	pm_runtime_disable(cs42l42->dev);
> +
> +	return 0;
> +}

