Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A920673AE7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjASN6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjASN6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:58:43 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34E830D2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 05:58:41 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JCtwhW016895;
        Thu, 19 Jan 2023 07:58:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=71UJS90Fru6+1gt12wgeEohU5xeIncuHvx2xIj/e4k0=;
 b=URroD3fIIaJYXUp4aEfuFPhvVEPDrN9DcDc+f6utaiVhFjtcvLx9EcX5XF0KqTJtTGYY
 3zvF44HHo0gbOSNakFIPHShX8+dRahUrj0GuamJshWpypMgAelI65sOrFnMXG/V1HwtJ
 JW1A6okBZKKgHxwDhya0B+2sp/ZtGeRJIDrc+DK2BWUdNtUviJlvldQ/TfJDiM7shOjy
 zDJA5jJvwprze6VuxXA1c9d0Uw0ZEEMyRccrsF+U2LHHtHcS/5OOqb5VXIT+JauveYuu
 HRfncA6oeIlCrYFU3Cna49aMosHZEV2vyVyyg/8+BZFBVMFzkEYLOIKQebE6j2jNkeaY Tw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3n3tp6fyk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 07:58:28 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Thu, 19 Jan
 2023 07:58:26 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.7 via Frontend Transport; Thu, 19 Jan 2023 07:58:26 -0600
Received: from [198.61.64.248] (EDIN4L06LR3.ad.cirrus.com [198.61.64.248])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 46BA511CA;
        Thu, 19 Jan 2023 13:58:26 +0000 (UTC)
Message-ID: <418f6b73-b5ac-8d87-a856-3413ec103f91@opensource.cirrus.com>
Date:   Thu, 19 Jan 2023 13:58:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 6/8] ASoC: cs42l42: Add Soundwire support
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20230118160452.2385494-1-sbinding@opensource.cirrus.com>
 <20230118160452.2385494-7-sbinding@opensource.cirrus.com>
 <33130336-b2ce-330e-fdec-166eee977e13@linux.intel.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <33130336-b2ce-330e-fdec-166eee977e13@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4OeBL0e7RdgAivu9JlLWWJA-uTcuKkeF
X-Proofpoint-GUID: 4OeBL0e7RdgAivu9JlLWWJA-uTcuKkeF
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/1/23 17:41, Pierre-Louis Bossart wrote:
> 
> nitpick: please use the MIPI SoundWire spelling
> 
>> This adds support for using CS42L42 as a Soundwire device.
>>
>> Soundwire-specifics are kept separate from the I2S implementation as
>> much as possible, aiming to limit the risk of breaking the I2C+I2S
>> support.
>>
>> There are some important differences in the silicon behaviour between
>> I2S and Soundwire mode that are reflected in the implementation:
>>
>> - ASP (I2S) most not be used in Soundwire mode because the two interfaces
>>    share pins.
>>
>> - The Soundwire capture (record) port only supports 1 channel. It does
>>    not have left-to-right duplication like the ASP.
>>
>> - DP2 can only be prepared if the HP has powered-up. DP1 can only be
>>    prepared if the ADC has powered-up. (This ordering restriction does
>>    not exist for ASPs.) The Soundwire core port-prepare step is
>>    triggered by the DAI-link prepare(). This happens before the
>>    codec DAI prepare() or the DAPM sequence so these cannot be used
>>    to enable HP/ADC. Instead the HP/ADC enable/disable are done during
>>    the port_prep callback.
>>
>> - The SRCs are an integral part of the audio chain but in silicon their
>>    power control is linked to the ASP. There is no equivalent power link
>>    to Soundwire DPs so the driver must take "manual" control of SRC power.
>>
>> - The Soundwire control registers occupy the lower part of the Soundwire
>>    address space so cs42l42 registers are offset by 0x8000 (non-paged) in
>>    Soundwire mode.
>>
>> - Register addresses are 8-bit paged in I2C mode but 16-bit unpaged in
>>    Soundwire.
>>
>> - Special procedures are needed on register read/writes to (a) ensure
>>    that the previous internal bus transaction has completed, and
>>    (b) handle delayed read results, when the read value could not be
>>    returned within the Soundwire read command.
>>
>> There are also some differences in driver implementation between I2S
>> and Soundwire operation:
>>
>> - CS42L42 does not runtime_suspend, but runtime_suspend/resume are required
>>    in Soundwire mode as the most convenient way to power-up the bus manager
>>    and to handle the unattach_request condition.
> That's an impressive commit message indeed.
> 
> I couldn't really follow this paragraph though. The main reason why
> having suspend/resume routines is to wait for initialization to be
> complete, as well as handle the regcache status to deal with access to
> regmap'ed registers, if any, while the bus is stopped or resuming.
> 

Can be re-worded. The point was that the CS42L42 driver doesn't have any
pm_runtime support, so why add it for SoundWire? Answer: because it's
simpler to make use of the automatic suspend/resume of the host
controller that comes with having pm_runtime enabled. It's much nicer
than having to manually pm_runtime_get_sync() the bus manager and check
for unattach_request every time we want to do a register transfer.

> Edit after reaching the end of this patch: that's actually what is done
> in the implementation below so you may want to clarify this part.
> 
>> - Intel Soundwire host controllers have a low-power clock-stop mode that
>>    requires resetting all peripherals when resuming. This means that the
>>    interrupt registers will be reset in between the interrupt being
>>    generated and the interrupt being handled, and since the interrupt
>>    status is debounced, these values may not be accurrate immediately,
> 
> accurate
> 
> 
>> diff --git a/sound/soc/codecs/cs42l42-sdw.c b/sound/soc/codecs/cs42l42-sdw.c
>> new file mode 100644
>> index 0000000000000..67800b275e422
>> --- /dev/null
>> +++ b/sound/soc/codecs/cs42l42-sdw.c
>> @@ -0,0 +1,595 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +// cs42l42-sdw.c -- CS42L42 ALSA SoC audio driver Soundwire binding
> 
> binding?
> 
>> +//
>> +// Copyright (C) 2022 Cirrus Logic, Inc. and
>> +//                    Cirrus Logic International Semiconductor Ltd.
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/device.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/module.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/soundwire/sdw.h>
>> +#include <linux/soundwire/sdw_registers.h>
>> +#include <linux/soundwire/sdw_type.h>
>> +#include <sound/pcm.h>
>> +#include <sound/pcm_params.h>
>> +#include <sound/sdw.h>
>> +#include <sound/soc.h>
>> +
>> +#include "cs42l42.h"
>> +
>> +#define CS42L42_SDW_CAPTURE_PORT	1
>> +#define CS42L42_SDW_PLAYBACK_PORT	2
>> +
>> +/* Register addresses are offset when sent over Soundwire */
> 
> nitpick: SoundWire
> 
>> +#define CS42L42_SDW_ADDR_OFFSET		0x8000
>> +
>> +#define CS42L42_SDW_MEM_ACCESS_STATUS	0xd0
>> +#define CS42L42_SDW_MEM_READ_DATA	0xd8
>> +
>> +#define CS42L42_SDW_LAST_LATE		BIT(3)
>> +#define CS42L42_SDW_CMD_IN_PROGRESS	BIT(2)
>> +#define CS42L42_SDW_RDATA_RDY		BIT(0)
>> +
>> +#define CS42L42_DELAYED_READ_POLL_US	1
>> +#define CS42L42_DELAYED_READ_TIMEOUT_US	100
>> +
>> +static const struct snd_soc_dapm_route cs42l42_sdw_audio_map[] = {
>> +	/* Playback Path */
>> +	{ "HP", NULL, "MIXER" },
>> +	{ "MIXER", NULL, "DACSRC" },
>> +	{ "DACSRC", NULL, "Playback" },
>> +
>> +	/* Capture Path */
>> +	{ "ADCSRC", NULL, "HS" },
>> +	{ "Capture", NULL, "ADCSRC" },
>> +};
>> +
>> +static int cs42l42_sdw_dai_startup(struct snd_pcm_substream *substream,
>> +				   struct snd_soc_dai *dai)
>> +{
>> +	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(dai->component);
>> +
>> +	if (!cs42l42->init_done)
>> +		return -ENODEV;
> 
> Can this happen? IIRC the ASoC framework would use
> pm_runtime_resume_and_get() before .startup, which would guarantee that
> the device is initialized, no?
> 

Yes, this can happen. Because of the way that the SoundWire enumeration
was implemented in the core code, it isn't a probe event so we cannot
call snd_soc_register_component() on enumeration because -EPROBE_DEFER
wouldn't be handled. So the snd_soc_register_component() must be called
from probe(). This leaves a limbo situation where we've registered the
driver but in fact don't yet have any hardware. ALSA/ASoC doesn't know
that we've registered before we are functional so they are happy to
go ahead and try to use the soundcard. If for some reason the hardware
failed to enumerate we can get here without having enumerated.

>> +
>> +	return 0;
>> +}
>> +
>> +static int cs42l42_sdw_dai_hw_params(struct snd_pcm_substream *substream,
>> +				     struct snd_pcm_hw_params *params,
>> +				     struct snd_soc_dai *dai)
>> +{
>> +	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(dai->component);
>> +	struct sdw_stream_runtime *sdw_stream = snd_soc_dai_get_dma_data(dai, substream);
>> +	struct sdw_stream_config stream_config = {0};
>> +	struct sdw_port_config port_config = {0};
>> +	int ret;
>> +
>> +	if (!sdw_stream)
>> +		return -EINVAL;
>> +
>> +	/* Needed for PLL configuration when we are notified of new bus config */
>> +	cs42l42->sample_rate = params_rate(params);
> 
> wouldn't it be better to check if the sample_rate is supported by the
> PLL here, instead of in the .prepare step ...
> 
It depends on the soundwire bus clock. We need to know both to determine
whether they are valid. IFF we can assume that the call to
sdw_stream_add_slave() will always invoke the bus_config() callback we
can call cs42l42_pll_config() from cs42l42_sdw_bus_config() and return
an error from cs42l42_sdw_bus_config() if the {swire_clk, sample_rate}
pair isn't valid.

>> +
>> +	snd_sdw_params_to_config(substream, params, &stream_config, &port_config);
>> +
>> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>> +		port_config.num = CS42L42_SDW_PLAYBACK_PORT;
>> +	else
>> +		port_config.num = CS42L42_SDW_CAPTURE_PORT;
>> +
>> +	ret = sdw_stream_add_slave(cs42l42->sdw_peripheral, &stream_config, &port_config, 1,
>> +				   sdw_stream);
>> +	if (ret) {
>> +		dev_err(dai->dev, "Failed to add sdw stream: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	cs42l42_src_config(dai->component, params_rate(params));
>> +
>> +	return 0;
>> +}
>> +
>> +static int cs42l42_sdw_dai_prepare(struct snd_pcm_substream *substream,
>> +				   struct snd_soc_dai *dai)
>> +{
>> +	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(dai->component);
>> +
>> +	dev_dbg(dai->dev, "dai_prepare: sclk=%u rate=%u\n", cs42l42->sclk, cs42l42->sample_rate);
>> +
>> +	if (!cs42l42->sclk || !cs42l42->sample_rate)
>> +		return -EINVAL;
>> +
>> +	return cs42l42_pll_config(dai->component, cs42l42->sclk, cs42l42->sample_rate);
> 
> ... it's a bit late to verify the sample_rate is indeed supported, no?
> 
>> +}
>> +
>> +static int cs42l42_sdw_dai_hw_free(struct snd_pcm_substream *substream,
>> +				   struct snd_soc_dai *dai)
>> +{
>> +	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(dai->component);
>> +	struct sdw_stream_runtime *sdw_stream = snd_soc_dai_get_dma_data(dai, substream);
>> +
>> +	sdw_stream_remove_slave(cs42l42->sdw_peripheral, sdw_stream);
>> +	cs42l42->sample_rate = 0;
>> +
>> +	return 0;
>> +}
> 
>> +static int cs42l42_sdw_dai_set_sdw_stream(struct snd_soc_dai *dai, void *sdw_stream,
>> +					  int direction)
>> +{
>> +	if (!sdw_stream)
>> +		return 0;
>> +
>> +	if (direction == SNDRV_PCM_STREAM_PLAYBACK)
>> +		dai->playback_dma_data = sdw_stream;
>> +	else
>> +		dai->capture_dma_data = sdw_stream;
>> +
>> +	return 0;
> 
> Humm, this is interesting, you are not using the sdw_stream_data that
> all other codecs use, but in hindsight I have no idea why we allocate
> something to only store a pointer.
> 

Indeed. I can see no reason to wrap this pointer in another struct when
we can store the pointer direct so I dropped the wrapper struct.

> 
>> +
>> +static struct snd_soc_dai_driver cs42l42_sdw_dai = {
>> +	.name = "cs42l42-sdw",
>> +	.playback = {
>> +		.stream_name = "Playback",
>> +		.channels_min = 1,
>> +		.channels_max = 2,
>> +		.rates = SNDRV_PCM_RATE_8000_96000,
>> +		.formats = SNDRV_PCM_FMTBIT_S16_LE |
>> +			   SNDRV_PCM_FMTBIT_S24_LE |
>> +			   SNDRV_PCM_FMTBIT_S32_LE,
>> +	},
>> +	.capture = {
>> +		.stream_name = "Capture",
>> +		.channels_min = 1,
>> +		.channels_max = 1,
>> +		.rates = SNDRV_PCM_RATE_8000_96000,
>> +		.formats = SNDRV_PCM_FMTBIT_S16_LE |
>> +			   SNDRV_PCM_FMTBIT_S24_LE |
>> +			   SNDRV_PCM_FMTBIT_S32_LE,
> 
> Are the rates and formats needed? IIRC only the channels are used.
>

These are the only rates and formats we support so we want ASoC to
create parameter constraints so ALSA will refine any app requests down
to a supported combination.

>> +	},
>> +	.symmetric_rate = 1,
>> +	.ops = &cs42l42_sdw_dai_ops,
>> +};
>> +
> 
>> +static void cs42l42_sdw_init(struct sdw_slave *peripheral)
>> +{
>> +	struct cs42l42_private *cs42l42 = dev_get_drvdata(&peripheral->dev);
>> +	int ret = 0;
> 
> unnecessary init
> 
>> +
>> +	regcache_cache_only(cs42l42->regmap, false);
>> +
>> +	ret = cs42l42_init(cs42l42);
>> +	if (ret < 0) {
>> +		regcache_cache_only(cs42l42->regmap, true);
>> +		return;
>> +	}
>> +
>> +	/* Write out any cached changes that happened between probe and attach */
>> +	ret = regcache_sync(cs42l42->regmap);
>> +	if (ret < 0)
>> +		dev_warn(cs42l42->dev, "Failed to sync cache: %d\n", ret);
>> +
>> +	/* Disable internal logic that makes clock-stop conditional */
>> +	regmap_clear_bits(cs42l42->regmap, CS42L42_PWR_CTL3, CS42L42_SW_CLK_STP_STAT_SEL_MASK);
>> +
>> +	/*
>> +	 * pm_runtime is needed to control bus manager suspend, and to
>> +	 * recover from an unattach_request when the manager suspends.
>> +	 * Autosuspend delay must be long enough to enumerate.
>> +	 */
>> +	pm_runtime_set_autosuspend_delay(cs42l42->dev, 3000);
>> +	pm_runtime_use_autosuspend(cs42l42->dev);
>> +	pm_runtime_set_active(cs42l42->dev);
>> +	pm_runtime_enable(cs42l42->dev);
> 
> you would want to set all this once during the first initialization.
> 
>> +	pm_runtime_mark_last_busy(cs42l42->dev);
> 
> usually this is added before the pm_runtime_enable()
> 
>> +	pm_runtime_idle(cs42l42->dev);
> 
> is this needed?
> 
>> +static int cs42l42_sdw_update_status(struct sdw_slave *peripheral,
>> +				     enum sdw_slave_status status)
>> +{
>> +	struct cs42l42_private *cs42l42 = dev_get_drvdata(&peripheral->dev);
>> +
>> +	switch (status) {
>> +	case SDW_SLAVE_ATTACHED:
>> +		dev_dbg(cs42l42->dev, "ATTACHED\n");
>> +		if (!cs42l42->init_done)
>> +			cs42l42_sdw_init(peripheral);
> 
> unclear to me what happens is the bus suspends, how would you redo the init?
> 

We don't need to re-run the init(). A regcache_sync() will restore
settings.

>> +		break;
>> +	case SDW_SLAVE_UNATTACHED:
>> +		dev_dbg(cs42l42->dev, "UNATTACHED\n");
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return 0;
>> +}
> 
>> +static int __maybe_unused cs42l42_sdw_clk_stop(struct sdw_slave *peripheral,
>> +				enum sdw_clk_stop_mode mode,
>> +				enum sdw_clk_stop_type type)
>> +{
>> +	struct cs42l42_private *cs42l42 = dev_get_drvdata(&peripheral->dev);
>> +
>> +	dev_dbg(cs42l42->dev, "clk_stop mode:%d type:%d\n", mode, type);
>> +
>> +	return 0;
> 
> that doesn't sound terribly useful?
> 

Well, it's _very_ useful for debug but this function could be
dropped.

>> +}
>> +
>> +static const struct sdw_slave_ops cs42l42_sdw_ops = {
>> +	.read_prop = cs42l42_sdw_read_prop,
>> +	.update_status = cs42l42_sdw_update_status,
> 
> what about .interrupt_callback?
>

Not used. That's a for later patch if we can get CS42L42 to issue
SoundWire wakeup events in any useful way. Currently the only
chip interrupt we use is for jack detect and that needs the
hard INT line because it cannot issue a SoundWire WAKE during
clock-stop.

> I vaguely remember something about not using the in-band wake mechanism
> and having a separate interrupt line, if that's what happens it's worthy
> of a comment here.

Yes, we can add a comment

> 
>> +	.bus_config = cs42l42_sdw_bus_config,
>> +	.port_prep = cs42l42_sdw_port_prep,
>> +#ifdef DEBUG
>> +	.clk_stop = cs42l42_sdw_clk_stop,
>> +#endif
>> +};
> 
>> +static int cs42l42_sdw_remove(struct sdw_slave *peripheral)
>> +{
>> +	struct cs42l42_private *cs42l42 = dev_get_drvdata(&peripheral->dev);
>> +
>> +	/* Resume so that cs42l42_remove() can access registers */
>> +	pm_runtime_get_sync(cs42l42->dev);
> 
> is this necessary? I thought the device framework always did that.
>

You're correct. There's other drivers that do this so I was cautious
but yes this can be removed.

>> +	cs42l42_common_remove(cs42l42);
>> +	pm_runtime_put(cs42l42->dev);
>> +	pm_runtime_disable(cs42l42->dev);
>> +
>> +	return 0;
>> +}
> 
