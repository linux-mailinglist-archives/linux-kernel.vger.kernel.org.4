Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086D767EB96
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbjA0QwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbjA0Qvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:51:43 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D725E7E070
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:51:40 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30R9k8LR030633;
        Fri, 27 Jan 2023 10:51:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=2GuCNVfLGRe7rNDTqEPrTG5jHgqX26vmE0hBZIpPF+w=;
 b=B+2P1aeV9pqknC+aMKybsa81p0uPrme3trI2G0Q30fr/oQJQYpAB/HCHF9FA6FnoZnhz
 GlaBN7LfVM07v2epEjJtwpbVIfZjUKfth/+n7PP3d7wtWY5OyGCNly4H2nl4wDnLjL0p
 mv25Wwb6gnaz4E+yUUMDxf4Abs8Z7ruxyptiodBAg8tmMaMDDnOHHm5Zen4/265aBQzN
 pJE/fB6H/cqQnFv2nGlAogsJK8qpJ7977R15m6Ua2cM3mZ80120aRpFs7xynTp2CwmTt
 65JfL0ASm4MFIM6fL63EhTi1kCNhCbw+MR+IYuzbHjXle68RisivRfCChDDngu/nEgpF qg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3n8dbsvrd3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 10:51:31 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Fri, 27 Jan
 2023 10:51:29 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Fri, 27 Jan 2023 10:51:29 -0600
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.202.160])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2D07411DC;
        Fri, 27 Jan 2023 16:51:29 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v3 6/8] ASoC: cs42l42: Add SoundWire support
Date:   Fri, 27 Jan 2023 16:51:09 +0000
Message-ID: <20230127165111.3010960-7-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127165111.3010960-1-sbinding@opensource.cirrus.com>
References: <20230127165111.3010960-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: EbFNMr3LTixAZLOpbY0DagbJuvEpQW-u
X-Proofpoint-GUID: EbFNMr3LTixAZLOpbY0DagbJuvEpQW-u
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Fitzgerald <rf@opensource.cirrus.com>

This adds support for using CS42L42 as a SoundWire device.

SoundWire-specifics are kept separate from the I2S implementation as
much as possible, aiming to limit the risk of breaking the I2C+I2S
support.

There are some important differences in the silicon behaviour between
I2S and SoundWire mode that are reflected in the implementation:

- ASP (I2S) most not be used in SoundWire mode because the two interfaces
  share pins.

- The SoundWire capture (record) port only supports 1 channel. It does
  not have left-to-right duplication like the ASP.

- DP2 can only be prepared if the HP has powered-up. DP1 can only be
  prepared if the ADC has powered-up. (This ordering restriction does
  not exist for ASPs.) The SoundWire core port-prepare step is
  triggered by the DAI-link prepare(). This happens before the
  codec DAI prepare() or the DAPM sequence so these cannot be used
  to enable HP/ADC. Instead the HP/ADC enable/disable are done during
  the port_prep callback.

- The SRCs are an integral part of the audio chain but in silicon their
  power control is linked to the ASP. There is no equivalent power link
  to SoundWire DPs so the driver must take "manual" control of SRC power.

- The SoundWire control registers occupy the lower part of the SoundWire
  address space so cs42l42 registers are offset by 0x8000 (non-paged) in
  SoundWire mode.

- Register addresses are 8-bit paged in I2C mode but 16-bit unpaged in
  SoundWire.

- Special procedures are needed on register read/writes to (a) ensure
  that the previous internal bus transaction has completed, and
  (b) handle delayed read results, when the read value could not be
  returned within the SoundWire read command.

There are also some differences in driver implementation between I2S
and SoundWire operation:

- CS42L42 I2S does not runtime_suspend, but runtime_suspend/resume support
  has been added into the driver in SoundWire mode as the most convenient
  way to power-up the bus manager and to handle the unattach_request
  condition, though the CS42L42 chip does not itself suspend or resume.

- Intel SoundWire host controllers have a low-power clock-stop mode that
  requires resetting all peripherals when resuming. This means that the
  interrupt registers will be reset in between the interrupt being
  generated and the interrupt being handled, and since the interrupt
  status is debounced, these values may not be accurate immediately,
  and may cause spurious unplug events before settling.

- As in I2S mode, the PLL is only used while audio is active because
  of clocking quirks in the silicon. For SoundWire the cs42l42_pll_config()
  is deferred until the DAI prepare(), to allow the cs42l42_bus_config()
  callback to set the SCLK.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/soc/codecs/Kconfig       |   8 +
 sound/soc/codecs/Makefile      |   2 +
 sound/soc/codecs/cs42l42-sdw.c | 602 +++++++++++++++++++++++++++++++++
 sound/soc/codecs/cs42l42.c     |  27 ++
 sound/soc/codecs/cs42l42.h     |   3 +
 5 files changed, 642 insertions(+)
 create mode 100644 sound/soc/codecs/cs42l42-sdw.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 6b4ee14640abc..1e5558f0c7b2a 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -68,6 +68,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_CS35L45_I2C
 	imply SND_SOC_CS35L45_SPI
 	imply SND_SOC_CS42L42
+	imply SND_SOC_CS42L42_SDW
 	imply SND_SOC_CS42L51_I2C
 	imply SND_SOC_CS42L52
 	imply SND_SOC_CS42L56
@@ -703,6 +704,13 @@ config SND_SOC_CS42L42
 	select REGMAP_I2C
 	select SND_SOC_CS42L42_CORE
 
+config SND_SOC_CS42L42_SDW
+	tristate "Cirrus Logic CS42L42 CODEC on Soundwire"
+	depends on SOUNDWIRE
+	select SND_SOC_CS42L42_CORE
+	help
+	  Enable support for Cirrus Logic CS42L42 codec with Soundwire control
+
 config SND_SOC_CS42L51
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 71d3ce5867e4f..31c8921028cce 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -66,6 +66,7 @@ snd-soc-cs35l45-spi-objs := cs35l45-spi.o
 snd-soc-cs35l45-i2c-objs := cs35l45-i2c.o
 snd-soc-cs42l42-objs := cs42l42.o
 snd-soc-cs42l42-i2c-objs := cs42l42-i2c.o
+snd-soc-cs42l42-sdw-objs := cs42l42-sdw.o
 snd-soc-cs42l51-objs := cs42l51.o
 snd-soc-cs42l51-i2c-objs := cs42l51-i2c.o
 snd-soc-cs42l52-objs := cs42l52.o
@@ -427,6 +428,7 @@ obj-$(CONFIG_SND_SOC_CS35L45_SPI)	+= snd-soc-cs35l45-spi.o
 obj-$(CONFIG_SND_SOC_CS35L45_I2C)	+= snd-soc-cs35l45-i2c.o
 obj-$(CONFIG_SND_SOC_CS42L42_CORE)	+= snd-soc-cs42l42.o
 obj-$(CONFIG_SND_SOC_CS42L42)	+= snd-soc-cs42l42-i2c.o
+obj-$(CONFIG_SND_SOC_CS42L42_SDW)	+= snd-soc-cs42l42-sdw.o
 obj-$(CONFIG_SND_SOC_CS42L51)	+= snd-soc-cs42l51.o
 obj-$(CONFIG_SND_SOC_CS42L51_I2C)	+= snd-soc-cs42l51-i2c.o
 obj-$(CONFIG_SND_SOC_CS42L52)	+= snd-soc-cs42l52.o
diff --git a/sound/soc/codecs/cs42l42-sdw.c b/sound/soc/codecs/cs42l42-sdw.c
new file mode 100644
index 0000000000000..0de370b40eaf0
--- /dev/null
+++ b/sound/soc/codecs/cs42l42-sdw.c
@@ -0,0 +1,602 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// cs42l42-sdw.c -- CS42L42 ALSA SoC audio driver SoundWire driver
+//
+// Copyright (C) 2022 Cirrus Logic, Inc. and
+//                    Cirrus Logic International Semiconductor Ltd.
+
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/of_irq.h>
+#include <linux/pm_runtime.h>
+#include <linux/soundwire/sdw.h>
+#include <linux/soundwire/sdw_registers.h>
+#include <linux/soundwire/sdw_type.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/sdw.h>
+#include <sound/soc.h>
+
+#include "cs42l42.h"
+
+#define CS42L42_SDW_CAPTURE_PORT	1
+#define CS42L42_SDW_PLAYBACK_PORT	2
+
+/* Register addresses are offset when sent over SoundWire */
+#define CS42L42_SDW_ADDR_OFFSET		0x8000
+
+#define CS42L42_SDW_MEM_ACCESS_STATUS	0xd0
+#define CS42L42_SDW_MEM_READ_DATA	0xd8
+
+#define CS42L42_SDW_LAST_LATE		BIT(3)
+#define CS42L42_SDW_CMD_IN_PROGRESS	BIT(2)
+#define CS42L42_SDW_RDATA_RDY		BIT(0)
+
+#define CS42L42_DELAYED_READ_POLL_US	1
+#define CS42L42_DELAYED_READ_TIMEOUT_US	100
+
+static const struct snd_soc_dapm_route cs42l42_sdw_audio_map[] = {
+	/* Playback Path */
+	{ "HP", NULL, "MIXER" },
+	{ "MIXER", NULL, "DACSRC" },
+	{ "DACSRC", NULL, "Playback" },
+
+	/* Capture Path */
+	{ "ADCSRC", NULL, "HS" },
+	{ "Capture", NULL, "ADCSRC" },
+};
+
+static int cs42l42_sdw_dai_startup(struct snd_pcm_substream *substream,
+				   struct snd_soc_dai *dai)
+{
+	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(dai->component);
+
+	if (!cs42l42->init_done)
+		return -ENODEV;
+
+	return 0;
+}
+
+static int cs42l42_sdw_dai_hw_params(struct snd_pcm_substream *substream,
+				     struct snd_pcm_hw_params *params,
+				     struct snd_soc_dai *dai)
+{
+	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(dai->component);
+	struct sdw_stream_runtime *sdw_stream = snd_soc_dai_get_dma_data(dai, substream);
+	struct sdw_stream_config stream_config = {0};
+	struct sdw_port_config port_config = {0};
+	int ret;
+
+	if (!sdw_stream)
+		return -EINVAL;
+
+	/* Needed for PLL configuration when we are notified of new bus config */
+	cs42l42->sample_rate = params_rate(params);
+
+	snd_sdw_params_to_config(substream, params, &stream_config, &port_config);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		port_config.num = CS42L42_SDW_PLAYBACK_PORT;
+	else
+		port_config.num = CS42L42_SDW_CAPTURE_PORT;
+
+	ret = sdw_stream_add_slave(cs42l42->sdw_peripheral, &stream_config, &port_config, 1,
+				   sdw_stream);
+	if (ret) {
+		dev_err(dai->dev, "Failed to add sdw stream: %d\n", ret);
+		return ret;
+	}
+
+	cs42l42_src_config(dai->component, params_rate(params));
+
+	return 0;
+}
+
+static int cs42l42_sdw_dai_prepare(struct snd_pcm_substream *substream,
+				   struct snd_soc_dai *dai)
+{
+	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(dai->component);
+
+	dev_dbg(dai->dev, "dai_prepare: sclk=%u rate=%u\n", cs42l42->sclk, cs42l42->sample_rate);
+
+	if (!cs42l42->sclk || !cs42l42->sample_rate)
+		return -EINVAL;
+
+	/*
+	 * At this point we know the sample rate from hw_params, and the SWIRE_CLK from bus_config()
+	 * callback. This could only fail if the ACPI or machine driver are misconfigured to allow
+	 * an unsupported SWIRE_CLK and sample_rate combination.
+	 */
+
+	return cs42l42_pll_config(dai->component, cs42l42->sclk, cs42l42->sample_rate);
+}
+
+static int cs42l42_sdw_dai_hw_free(struct snd_pcm_substream *substream,
+				   struct snd_soc_dai *dai)
+{
+	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(dai->component);
+	struct sdw_stream_runtime *sdw_stream = snd_soc_dai_get_dma_data(dai, substream);
+
+	sdw_stream_remove_slave(cs42l42->sdw_peripheral, sdw_stream);
+	cs42l42->sample_rate = 0;
+
+	return 0;
+}
+
+static int cs42l42_sdw_port_prep(struct sdw_slave *slave,
+				 struct sdw_prepare_ch *prepare_ch,
+				 enum sdw_port_prep_ops state)
+{
+	struct cs42l42_private *cs42l42 = dev_get_drvdata(&slave->dev);
+	unsigned int pdn_mask;
+
+	if (prepare_ch->num == CS42L42_SDW_PLAYBACK_PORT)
+		pdn_mask = CS42L42_HP_PDN_MASK;
+	else
+		pdn_mask = CS42L42_ADC_PDN_MASK;
+
+	if (state == SDW_OPS_PORT_PRE_PREP) {
+		dev_dbg(cs42l42->dev, "Prep Port pdn_mask:%x\n", pdn_mask);
+		regmap_clear_bits(cs42l42->regmap, CS42L42_PWR_CTL1, pdn_mask);
+		usleep_range(CS42L42_HP_ADC_EN_TIME_US, CS42L42_HP_ADC_EN_TIME_US + 1000);
+	} else if (state == SDW_OPS_PORT_POST_DEPREP) {
+		dev_dbg(cs42l42->dev, "Deprep Port pdn_mask:%x\n", pdn_mask);
+		regmap_set_bits(cs42l42->regmap, CS42L42_PWR_CTL1, pdn_mask);
+	}
+
+	return 0;
+}
+
+static int cs42l42_sdw_dai_set_sdw_stream(struct snd_soc_dai *dai, void *sdw_stream,
+					  int direction)
+{
+	if (!sdw_stream)
+		return 0;
+
+	if (direction == SNDRV_PCM_STREAM_PLAYBACK)
+		dai->playback_dma_data = sdw_stream;
+	else
+		dai->capture_dma_data = sdw_stream;
+
+	return 0;
+}
+
+static void cs42l42_sdw_dai_shutdown(struct snd_pcm_substream *substream,
+				     struct snd_soc_dai *dai)
+{
+	snd_soc_dai_set_dma_data(dai, substream, NULL);
+}
+
+static const struct snd_soc_dai_ops cs42l42_sdw_dai_ops = {
+	.startup	= cs42l42_sdw_dai_startup,
+	.shutdown	= cs42l42_sdw_dai_shutdown,
+	.hw_params	= cs42l42_sdw_dai_hw_params,
+	.prepare	= cs42l42_sdw_dai_prepare,
+	.hw_free	= cs42l42_sdw_dai_hw_free,
+	.mute_stream	= cs42l42_mute_stream,
+	.set_stream	= cs42l42_sdw_dai_set_sdw_stream,
+};
+
+static struct snd_soc_dai_driver cs42l42_sdw_dai = {
+	.name = "cs42l42-sdw",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		/* Restrict which rates and formats are supported */
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE |
+			   SNDRV_PCM_FMTBIT_S24_LE |
+			   SNDRV_PCM_FMTBIT_S32_LE,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 1,
+		/* Restrict which rates and formats are supported */
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE |
+			   SNDRV_PCM_FMTBIT_S24_LE |
+			   SNDRV_PCM_FMTBIT_S32_LE,
+	},
+	.symmetric_rate = 1,
+	.ops = &cs42l42_sdw_dai_ops,
+};
+
+static int cs42l42_sdw_poll_status(struct sdw_slave *peripheral, u8 mask, u8 match)
+{
+	int ret, sdwret;
+
+	ret = read_poll_timeout(sdw_read_no_pm, sdwret,
+				(sdwret < 0) || ((sdwret & mask) == match),
+				CS42L42_DELAYED_READ_POLL_US, CS42L42_DELAYED_READ_TIMEOUT_US,
+				false, peripheral, CS42L42_SDW_MEM_ACCESS_STATUS);
+	if (ret == 0)
+		ret = sdwret;
+
+	if (ret < 0)
+		dev_err(&peripheral->dev, "MEM_ACCESS_STATUS & %#x for %#x fail: %d\n",
+			mask, match, ret);
+
+	return ret;
+}
+
+static int cs42l42_sdw_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct sdw_slave *peripheral = context;
+	u8 data;
+	int ret;
+
+	reg += CS42L42_SDW_ADDR_OFFSET;
+
+	ret = cs42l42_sdw_poll_status(peripheral, CS42L42_SDW_CMD_IN_PROGRESS, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = sdw_read_no_pm(peripheral, reg);
+	if (ret < 0) {
+		dev_err(&peripheral->dev, "Failed to issue read @0x%x: %d\n", reg, ret);
+		return ret;
+	}
+
+	data = (u8)ret;	/* possible non-delayed read value */
+	ret = sdw_read_no_pm(peripheral, CS42L42_SDW_MEM_ACCESS_STATUS);
+	if (ret < 0) {
+		dev_err(&peripheral->dev, "Failed to read MEM_ACCESS_STATUS: %d\n", ret);
+		return ret;
+	}
+
+	/* If read was not delayed we already have the result */
+	if ((ret & CS42L42_SDW_LAST_LATE) == 0) {
+		*val = data;
+		return 0;
+	}
+
+	/* Poll for delayed read completion */
+	if ((ret & CS42L42_SDW_RDATA_RDY) == 0) {
+		ret = cs42l42_sdw_poll_status(peripheral,
+					      CS42L42_SDW_RDATA_RDY, CS42L42_SDW_RDATA_RDY);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = sdw_read_no_pm(peripheral, CS42L42_SDW_MEM_READ_DATA);
+	if (ret < 0) {
+		dev_err(&peripheral->dev, "Failed to read READ_DATA: %d\n", ret);
+		return ret;
+	}
+
+	*val = (u8)ret;
+
+	return 0;
+}
+
+static int cs42l42_sdw_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct sdw_slave *peripheral = context;
+	int ret;
+
+	ret = cs42l42_sdw_poll_status(peripheral, CS42L42_SDW_CMD_IN_PROGRESS, 0);
+	if (ret < 0)
+		return ret;
+
+	return sdw_write_no_pm(peripheral, reg + CS42L42_SDW_ADDR_OFFSET, (u8)val);
+}
+
+/* Initialise cs42l42 using SoundWire - this is only called once, during initialisation */
+static void cs42l42_sdw_init(struct sdw_slave *peripheral)
+{
+	struct cs42l42_private *cs42l42 = dev_get_drvdata(&peripheral->dev);
+	int ret;
+
+	regcache_cache_only(cs42l42->regmap, false);
+
+	ret = cs42l42_init(cs42l42);
+	if (ret < 0) {
+		regcache_cache_only(cs42l42->regmap, true);
+		goto err;
+	}
+
+	/* Write out any cached changes that happened between probe and attach */
+	ret = regcache_sync(cs42l42->regmap);
+	if (ret < 0)
+		dev_warn(cs42l42->dev, "Failed to sync cache: %d\n", ret);
+
+	/* Disable internal logic that makes clock-stop conditional */
+	regmap_clear_bits(cs42l42->regmap, CS42L42_PWR_CTL3, CS42L42_SW_CLK_STP_STAT_SEL_MASK);
+
+err:
+	/* This cancels the pm_runtime_get_noresume() call from cs42l42_sdw_probe(). */
+	pm_runtime_put_autosuspend(cs42l42->dev);
+}
+
+static int cs42l42_sdw_read_prop(struct sdw_slave *peripheral)
+{
+	struct cs42l42_private *cs42l42 = dev_get_drvdata(&peripheral->dev);
+	struct sdw_slave_prop *prop = &peripheral->prop;
+	struct sdw_dpn_prop *ports;
+
+	ports = devm_kcalloc(cs42l42->dev, 2, sizeof(*ports), GFP_KERNEL);
+	if (!ports)
+		return -ENOMEM;
+
+	prop->source_ports = BIT(CS42L42_SDW_CAPTURE_PORT);
+	prop->sink_ports = BIT(CS42L42_SDW_PLAYBACK_PORT);
+	prop->quirks = SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY;
+	prop->scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
+
+	/* DP1 - capture */
+	ports[0].num = CS42L42_SDW_CAPTURE_PORT,
+	ports[0].type = SDW_DPN_FULL,
+	ports[0].ch_prep_timeout = 10,
+	prop->src_dpn_prop = &ports[0];
+
+	/* DP2 - playback */
+	ports[1].num = CS42L42_SDW_PLAYBACK_PORT,
+	ports[1].type = SDW_DPN_FULL,
+	ports[1].ch_prep_timeout = 10,
+	prop->sink_dpn_prop = &ports[1];
+
+	return 0;
+}
+
+static int cs42l42_sdw_update_status(struct sdw_slave *peripheral,
+				     enum sdw_slave_status status)
+{
+	struct cs42l42_private *cs42l42 = dev_get_drvdata(&peripheral->dev);
+
+	switch (status) {
+	case SDW_SLAVE_ATTACHED:
+		dev_dbg(cs42l42->dev, "ATTACHED\n");
+		/*
+		 * Initialise codec, this only needs to be done once.
+		 * When resuming from suspend, resume callback will handle re-init of codec,
+		 * using regcache_sync().
+		 */
+		if (!cs42l42->init_done)
+			cs42l42_sdw_init(peripheral);
+		break;
+	case SDW_SLAVE_UNATTACHED:
+		dev_dbg(cs42l42->dev, "UNATTACHED\n");
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int cs42l42_sdw_bus_config(struct sdw_slave *peripheral,
+				  struct sdw_bus_params *params)
+{
+	struct cs42l42_private *cs42l42 = dev_get_drvdata(&peripheral->dev);
+	unsigned int new_sclk = params->curr_dr_freq / 2;
+
+	/* The cs42l42 cannot support a glitchless SWIRE_CLK change. */
+	if ((new_sclk != cs42l42->sclk) && cs42l42->stream_use) {
+		dev_warn(cs42l42->dev, "Rejected SCLK change while audio active\n");
+		return -EBUSY;
+	}
+
+	cs42l42->sclk = new_sclk;
+
+	dev_dbg(cs42l42->dev, "bus_config: sclk=%u c=%u r=%u\n",
+		cs42l42->sclk, params->col, params->row);
+
+	return 0;
+}
+
+static const struct sdw_slave_ops cs42l42_sdw_ops = {
+/* No interrupt callback because only hardware INT is supported for Jack Detect in the CS42L42 */
+	.read_prop = cs42l42_sdw_read_prop,
+	.update_status = cs42l42_sdw_update_status,
+	.bus_config = cs42l42_sdw_bus_config,
+	.port_prep = cs42l42_sdw_port_prep,
+};
+
+static int __maybe_unused cs42l42_sdw_runtime_suspend(struct device *dev)
+{
+	struct cs42l42_private *cs42l42 = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "Runtime suspend\n");
+
+	if (!cs42l42->init_done)
+		return 0;
+
+	/* The host controller could suspend, which would mean no register access */
+	regcache_cache_only(cs42l42->regmap, true);
+
+	return 0;
+}
+
+static const struct reg_sequence __maybe_unused cs42l42_soft_reboot_seq[] = {
+	REG_SEQ0(CS42L42_SOFT_RESET_REBOOT, 0x1e),
+};
+
+static int __maybe_unused cs42l42_sdw_handle_unattach(struct cs42l42_private *cs42l42)
+{
+	struct sdw_slave *peripheral = cs42l42->sdw_peripheral;
+
+	if (!peripheral->unattach_request)
+		return 0;
+
+	/* Cannot access registers until master re-attaches. */
+	dev_dbg(&peripheral->dev, "Wait for initialization_complete\n");
+	if (!wait_for_completion_timeout(&peripheral->initialization_complete,
+					 msecs_to_jiffies(5000))) {
+		dev_err(&peripheral->dev, "initialization_complete timed out\n");
+		return -ETIMEDOUT;
+	}
+
+	peripheral->unattach_request = 0;
+
+	/*
+	 * After a bus reset there must be a reconfiguration reset to
+	 * reinitialize the internal state of CS42L42.
+	 */
+	regmap_multi_reg_write_bypassed(cs42l42->regmap,
+					cs42l42_soft_reboot_seq,
+					ARRAY_SIZE(cs42l42_soft_reboot_seq));
+	usleep_range(CS42L42_BOOT_TIME_US, CS42L42_BOOT_TIME_US * 2);
+	regcache_mark_dirty(cs42l42->regmap);
+
+	return 0;
+}
+
+static int __maybe_unused cs42l42_sdw_runtime_resume(struct device *dev)
+{
+	struct cs42l42_private *cs42l42 = dev_get_drvdata(dev);
+	int ret;
+
+	dev_dbg(dev, "Runtime resume\n");
+
+	if (!cs42l42->init_done)
+		return 0;
+
+	ret = cs42l42_sdw_handle_unattach(cs42l42);
+	if (ret < 0)
+		return ret;
+
+	regcache_cache_only(cs42l42->regmap, false);
+
+	/* Sync LATCH_TO_VP first so the VP domain registers sync correctly */
+	regcache_sync_region(cs42l42->regmap, CS42L42_MIC_DET_CTL1, CS42L42_MIC_DET_CTL1);
+	regcache_sync(cs42l42->regmap);
+
+	return 0;
+}
+
+static int __maybe_unused cs42l42_sdw_resume(struct device *dev)
+{
+	struct cs42l42_private *cs42l42 = dev_get_drvdata(dev);
+	int ret;
+
+	dev_dbg(dev, "System resume\n");
+
+	/* Power-up so it can re-enumerate */
+	ret = cs42l42_resume(dev);
+	if (ret)
+		return ret;
+
+	/* Wait for re-attach */
+	ret = cs42l42_sdw_handle_unattach(cs42l42);
+	if (ret < 0)
+		return ret;
+
+	cs42l42_resume_restore(dev);
+
+	return 0;
+}
+
+static int cs42l42_sdw_probe(struct sdw_slave *peripheral, const struct sdw_device_id *id)
+{
+	struct snd_soc_component_driver *component_drv;
+	struct device *dev = &peripheral->dev;
+	struct cs42l42_private *cs42l42;
+	struct regmap_config *regmap_conf;
+	struct regmap *regmap;
+	int irq, ret;
+
+	cs42l42 = devm_kzalloc(dev, sizeof(*cs42l42), GFP_KERNEL);
+	if (!cs42l42)
+		return -ENOMEM;
+
+	if (has_acpi_companion(dev))
+		irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(dev), 0);
+	else
+		irq = of_irq_get(dev->of_node, 0);
+
+	if (irq == -ENOENT)
+		irq = 0;
+	else if (irq < 0)
+		return dev_err_probe(dev, irq, "Failed to get IRQ\n");
+
+	regmap_conf = devm_kmemdup(dev, &cs42l42_regmap, sizeof(cs42l42_regmap), GFP_KERNEL);
+	if (!regmap_conf)
+		return -ENOMEM;
+	regmap_conf->reg_bits = 16;
+	regmap_conf->num_ranges = 0;
+	regmap_conf->reg_read = cs42l42_sdw_read;
+	regmap_conf->reg_write = cs42l42_sdw_write;
+
+	regmap = devm_regmap_init(dev, NULL, peripheral, regmap_conf);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to allocate register map\n");
+
+	/* Start in cache-only until device is enumerated */
+	regcache_cache_only(regmap, true);
+
+	component_drv = devm_kmemdup(dev,
+				     &cs42l42_soc_component,
+				     sizeof(cs42l42_soc_component),
+				     GFP_KERNEL);
+	if (!component_drv)
+		return -ENOMEM;
+
+	component_drv->dapm_routes = cs42l42_sdw_audio_map;
+	component_drv->num_dapm_routes = ARRAY_SIZE(cs42l42_sdw_audio_map);
+
+	cs42l42->dev = dev;
+	cs42l42->regmap = regmap;
+	cs42l42->sdw_peripheral = peripheral;
+	cs42l42->irq = irq;
+	cs42l42->devid = CS42L42_CHIP_ID;
+
+	/*
+	 * pm_runtime is needed to control bus manager suspend, and to
+	 * recover from an unattach_request when the manager suspends.
+	 */
+	pm_runtime_set_autosuspend_delay(cs42l42->dev, 3000);
+	pm_runtime_use_autosuspend(cs42l42->dev);
+	pm_runtime_mark_last_busy(cs42l42->dev);
+	pm_runtime_set_active(cs42l42->dev);
+	pm_runtime_get_noresume(cs42l42->dev);
+	pm_runtime_enable(cs42l42->dev);
+
+	ret = cs42l42_common_probe(cs42l42, component_drv, &cs42l42_sdw_dai);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int cs42l42_sdw_remove(struct sdw_slave *peripheral)
+{
+	struct cs42l42_private *cs42l42 = dev_get_drvdata(&peripheral->dev);
+
+	cs42l42_common_remove(cs42l42);
+	pm_runtime_disable(cs42l42->dev);
+
+	return 0;
+}
+
+static const struct dev_pm_ops cs42l42_sdw_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(cs42l42_suspend, cs42l42_sdw_resume)
+	SET_RUNTIME_PM_OPS(cs42l42_sdw_runtime_suspend, cs42l42_sdw_runtime_resume, NULL)
+};
+
+static const struct sdw_device_id cs42l42_sdw_id[] = {
+	SDW_SLAVE_ENTRY(0x01FA, 0x4242, 0),
+	{},
+};
+MODULE_DEVICE_TABLE(sdw, cs42l42_sdw_id);
+
+static struct sdw_driver cs42l42_sdw_driver = {
+	.driver = {
+		.name = "cs42l42-sdw",
+		.pm = &cs42l42_sdw_pm,
+	},
+	.probe = cs42l42_sdw_probe,
+	.remove = cs42l42_sdw_remove,
+	.ops = &cs42l42_sdw_ops,
+	.id_table = cs42l42_sdw_id,
+};
+
+module_sdw_driver(cs42l42_sdw_driver);
+
+MODULE_DESCRIPTION("ASoC CS42L42 SoundWire driver");
+MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(SND_SOC_CS42L42_CORE);
diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index cefefd7061689..aa8d724432ab8 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -20,6 +20,7 @@
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/gpio/consumer.h>
@@ -525,6 +526,10 @@ static const struct snd_soc_dapm_widget cs42l42_dapm_widgets[] = {
 
 	/* Playback/Capture Requirements */
 	SND_SOC_DAPM_SUPPLY("SCLK", CS42L42_ASP_CLK_CFG, CS42L42_ASP_SCLK_EN_SHIFT, 0, NULL, 0),
+
+	/* Soundwire SRC power control */
+	SND_SOC_DAPM_PGA("DACSRC", CS42L42_PWR_CTL2, CS42L42_DAC_SRC_PDNB_SHIFT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("ADCSRC", CS42L42_PWR_CTL2, CS42L42_ADC_SRC_PDNB_SHIFT, 0, NULL, 0),
 };
 
 static const struct snd_soc_dapm_route cs42l42_audio_map[] = {
@@ -1660,9 +1665,11 @@ irqreturn_t cs42l42_irq_thread(int irq, void *data)
 	unsigned int current_button_status;
 	unsigned int i;
 
+	pm_runtime_get_sync(cs42l42->dev);
 	mutex_lock(&cs42l42->irq_lock);
 	if (cs42l42->suspended || !cs42l42->init_done) {
 		mutex_unlock(&cs42l42->irq_lock);
+		pm_runtime_put_autosuspend(cs42l42->dev);
 		return IRQ_NONE;
 	}
 
@@ -1765,6 +1772,8 @@ irqreturn_t cs42l42_irq_thread(int irq, void *data)
 	}
 
 	mutex_unlock(&cs42l42->irq_lock);
+	pm_runtime_mark_last_busy(cs42l42->dev);
+	pm_runtime_put_autosuspend(cs42l42->dev);
 
 	return IRQ_HANDLED;
 }
@@ -2144,6 +2153,9 @@ int cs42l42_suspend(struct device *dev)
 	u8 save_regs[ARRAY_SIZE(cs42l42_shutdown_seq)];
 	int i, ret;
 
+	if (!cs42l42->init_done)
+		return 0;
+
 	/*
 	 * Wait for threaded irq handler to be idle and stop it processing
 	 * future interrupts. This ensures a safe disable if the interrupt
@@ -2204,6 +2216,9 @@ int cs42l42_resume(struct device *dev)
 	struct cs42l42_private *cs42l42 = dev_get_drvdata(dev);
 	int ret;
 
+	if (!cs42l42->init_done)
+		return 0;
+
 	/*
 	 * If jack was unplugged and re-plugged during suspend it could
 	 * have changed type but the tip-sense state hasn't changed.
@@ -2388,6 +2403,18 @@ int cs42l42_init(struct cs42l42_private *cs42l42)
 	if (ret != 0)
 		goto err_shutdown;
 
+	/*
+	 * SRC power is linked to ASP power so doesn't work in Soundwire mode.
+	 * Override it and use DAPM to control SRC power for Soundwire.
+	 */
+	if (cs42l42->sdw_peripheral) {
+		regmap_update_bits(cs42l42->regmap, CS42L42_PWR_CTL2,
+				   CS42L42_SRC_PDN_OVERRIDE_MASK |
+				   CS42L42_DAC_SRC_PDNB_MASK |
+				   CS42L42_ADC_SRC_PDNB_MASK,
+				   CS42L42_SRC_PDN_OVERRIDE_MASK);
+	}
+
 	/* Setup headset detection */
 	cs42l42_setup_hs_type_detect(cs42l42);
 
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index ef8219f489100..4bd7b85a57471 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -18,6 +18,7 @@
 #include <linux/mutex.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/soundwire/sdw.h>
 #include <sound/jack.h>
 #include <sound/cs42l42.h>
 #include <sound/soc-component.h>
@@ -30,11 +31,13 @@ struct  cs42l42_private {
 	struct gpio_desc *reset_gpio;
 	struct completion pdn_done;
 	struct snd_soc_jack *jack;
+	struct sdw_slave *sdw_peripheral;
 	struct mutex irq_lock;
 	int devid;
 	int irq;
 	int pll_config;
 	u32 sclk;
+	u32 sample_rate;
 	u32 bclk_ratio;
 	u8 plug_state;
 	u8 hs_type;
-- 
2.34.1

