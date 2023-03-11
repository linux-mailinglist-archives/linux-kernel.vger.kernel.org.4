Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38ED6B574B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 02:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCKBO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 20:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCKBOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 20:14:25 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246A812DC28;
        Fri, 10 Mar 2023 17:14:23 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id y2so6931948pjg.3;
        Fri, 10 Mar 2023 17:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678497262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3rOEPgETAL0rtEYn1RlbKN9zeXDU+MZ/JhUdeK2eDT4=;
        b=ni0A0dnfdvkjppx3+yjv60apZzshsaC72BsSPado8+lUV8OSBiWTlA9L72DoNmVmPw
         3ayxg/RZ3M8AkC5vZzn++PqIVqatvm4vUbuDvdDeTqdbFoxfASCNKb1itKncMn3GcGtx
         e4dR8E8ESvCeeXeGGAE2ms/S/ROo5lLaGdRC7xfLipi2F43xHAjcyzZAC16Ah2JaQMBK
         Q1MKKNBhsTfgAojR8iaqzO60N1R7cLfTV9cfLqVLCKPrBoo81gBk4UQLQPg2/TQc5J0x
         7G51Xhv2mh+g5vNdzJNgGLK/nyHyL6cqVRQMmelFyyKlg/SyBpcl7xPXV6hUSWd1+TWm
         uqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678497262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3rOEPgETAL0rtEYn1RlbKN9zeXDU+MZ/JhUdeK2eDT4=;
        b=wQuQZ6TLO3ZU10y6oEJ1yWzjjQlIOlJkD81KnjoenWMOcc5Pcp3toZx2ACYsH1kIoN
         CJLicFlLUsD0K0fcMaPSdeJiPmHBEhU7rN5FAR3m50FjMRrYzRROi9wbix2WidUgJdy9
         r+3/0BFlWf1yplVJO1CYC/Mhp634u04CyD6cVStTTR6J6Mp2LaZh9m9OL51Zu582c3wx
         PnkZyu3Tni0qDNYeZZuiZatDFwsyt/VOtMZ95SCiMe2vevd5QDwrJ1HMyIhjik1b+L2t
         07HdhCe5o60OO7P6mSnk50e562Qu61ANZZ4jTkW04sYyu0R4o1SgvMy02PywfYqunJG7
         fAOQ==
X-Gm-Message-State: AO0yUKWG1jUcSIKXMRS/9uOVXyZ9ruGayZtb8u5Xxo8u1Tki0P6jXeP6
        HCfNpaOvNNkNOr1Ab4UX2dM=
X-Google-Smtp-Source: AK7set+bSqWIDVZs+47tZYVlxk04ZvNU+rIggmtIhGuDfI6FqdUSoTEL5zjXu0FhxGkuASJMf4w9tg==
X-Received: by 2002:a17:90b:4c50:b0:234:d3a:2a38 with SMTP id np16-20020a17090b4c5000b002340d3a2a38mr28341579pjb.43.1678497262474;
        Fri, 10 Mar 2023 17:14:22 -0800 (PST)
Received: from ryan-ThinkPad-T470.. (c-24-6-63-212.hsd1.ca.comcast.net. [24.6.63.212])
        by smtp.gmail.com with ESMTPSA id r20-20020a17090b051400b002376d85844dsm475323pjz.51.2023.03.10.17.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 17:14:21 -0800 (PST)
From:   =?UTF-8?q?=E2=80=9CRyan?= <ryan.lee.analog@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, krzysztof.kozlowski@linaro.org,
        rf@opensource.cirrus.com, ckeepax@opensource.cirrus.com,
        pierre-louis.bossart@linux.intel.com, herve.codina@bootlin.com,
        wangweidong.a@awinic.com, james.schulman@cirrus.com,
        ajye_huang@compal.corp-partner.google.com, shumingf@realtek.com,
        povik+lin@cutebit.org, flatmax@flatmax.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        ryans.lee@analog.com
Subject: [PATCH V2 1/2] ASoC: max98363: add soundwire amplifier driver
Date:   Fri, 10 Mar 2023 17:14:08 -0800
Message-Id: <20230311011409.210014-1-ryan.lee.analog@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Lee <ryans.lee@analog.com>

Added Analog Devices MAX98363 SoundWire Amplifier Driver.
The MAX98363 is a SoundWire peripheral device that supports
MIPI SoundWire v1.2-compatible digital interface for audio and
control data.

Signed-off-by: Ryan Lee <ryans.lee@analog.com>
---
Changes from v1:
  Removed the standard SoundWire registers from the amp register table.
  Removed .of_match_table and .acpi_match_table.
  Removed vdd/dvddio control.
  Removed unnecessary source port control in .read_prop.
  Removed legacy from I2S driver not used for SoundWire driver.
  Removed .shutdown, .bus_config, and unused functions.
  Sorted include files in alphabetical order.

 sound/soc/codecs/Kconfig    |  11 +
 sound/soc/codecs/Makefile   |   2 +
 sound/soc/codecs/max98363.c | 468 ++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/max98363.h |  38 +++
 4 files changed, 519 insertions(+)
 create mode 100644 sound/soc/codecs/max98363.c
 create mode 100644 sound/soc/codecs/max98363.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index bd72c426a93d..342e43844af0 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -130,6 +130,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_MAX98925
 	imply SND_SOC_MAX98926
 	imply SND_SOC_MAX98927
+	imply SND_SOC_MAX98363
 	imply SND_SOC_MAX98373_I2C
 	imply SND_SOC_MAX98373_SDW
 	imply SND_SOC_MAX98390
@@ -1089,6 +1090,16 @@ config SND_SOC_MAX98520
 
 	  To compile this driver as a module, choose M here.
 
+config SND_SOC_MAX98363
+	tristate "Analog Devices MAX98363 Soundwire Speaker Amplifier"
+	depends on SOUNDWIRE
+	select REGMAP_SOUNDWIRE
+	help
+	  Enable support for Analog Devices MAX98363 Soundwire
+	  amplifier. MAX98363 supports the MIPI SoundWire v1.2
+	  compatible interface for audio and control data.
+	  This amplifier does not support I2C and I2S.
+
 config SND_SOC_MAX98373
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index f1ca18f7946c..791a425bf38f 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -143,6 +143,7 @@ snd-soc-max98925-objs := max98925.o
 snd-soc-max98926-objs := max98926.o
 snd-soc-max98927-objs := max98927.o
 snd-soc-max98520-objs := max98520.o
+snd-soc-max98363-objs := max98363.o
 snd-soc-max98373-objs := max98373.o
 snd-soc-max98373-i2c-objs := max98373-i2c.o
 snd-soc-max98373-sdw-objs := max98373-sdw.o
@@ -505,6 +506,7 @@ obj-$(CONFIG_SND_SOC_MAX98925)	+= snd-soc-max98925.o
 obj-$(CONFIG_SND_SOC_MAX98926)	+= snd-soc-max98926.o
 obj-$(CONFIG_SND_SOC_MAX98927)	+= snd-soc-max98927.o
 obj-$(CONFIG_SND_SOC_MAX98520)	+= snd-soc-max98520.o
+obj-$(CONFIG_SND_SOC_MAX98363)	+= snd-soc-max98363.o
 obj-$(CONFIG_SND_SOC_MAX98373)	+= snd-soc-max98373.o
 obj-$(CONFIG_SND_SOC_MAX98373_I2C)   += snd-soc-max98373-i2c.o
 obj-$(CONFIG_SND_SOC_MAX98373_SDW)   += snd-soc-max98373-sdw.o
diff --git a/sound/soc/codecs/max98363.c b/sound/soc/codecs/max98363.c
new file mode 100644
index 000000000000..69d66af4fb36
--- /dev/null
+++ b/sound/soc/codecs/max98363.c
@@ -0,0 +1,468 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2022, Analog Devices Inc.
+
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/soundwire/sdw.h>
+#include <linux/soundwire/sdw_registers.h>
+#include <linux/soundwire/sdw_type.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+#include "max98363.h"
+
+static struct reg_default max98363_reg[] = {
+	{MAX98363_R2001_INTR_RAW, 0x0},
+	{MAX98363_R2003_INTR_STATE, 0x0},
+	{MAX98363_R2005_INTR_FALG, 0x0},
+	{MAX98363_R2007_INTR_EN, 0x0},
+	{MAX98363_R2009_INTR_CLR, 0x0},
+	{MAX98363_R2021_ERR_MON_CTRL, 0x0},
+	{MAX98363_R2022_SPK_MON_THRESH, 0x0},
+	{MAX98363_R2023_SPK_MON_DURATION, 0x0},
+	{MAX98363_R2030_TONE_GEN_CFG, 0x0},
+	{MAX98363_R203F_TONE_GEN_EN, 0x0},
+	{MAX98363_R2040_AMP_VOL, 0x0},
+	{MAX98363_R2041_AMP_GAIN, 0x5},
+	{MAX98363_R2042_DSP_CFG, 0x0},
+	{MAX98363_R21FF_REV_ID, 0x0},
+};
+
+static bool max98363_readable_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MAX98363_R2001_INTR_RAW:
+	case MAX98363_R2003_INTR_STATE:
+	case MAX98363_R2005_INTR_FALG:
+	case MAX98363_R2007_INTR_EN:
+	case MAX98363_R2009_INTR_CLR:
+	case MAX98363_R2021_ERR_MON_CTRL ... MAX98363_R2023_SPK_MON_DURATION:
+	case MAX98363_R2030_TONE_GEN_CFG:
+	case MAX98363_R203F_TONE_GEN_EN:
+	case MAX98363_R2040_AMP_VOL:
+	case MAX98363_R2041_AMP_GAIN:
+	case MAX98363_R2042_DSP_CFG:
+	case MAX98363_R21FF_REV_ID:
+		return true;
+	default:
+		return false;
+	}
+};
+
+static bool max98363_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MAX98363_R2001_INTR_RAW:
+	case MAX98363_R2003_INTR_STATE:
+	case MAX98363_R2005_INTR_FALG:
+	case MAX98363_R2007_INTR_EN:
+	case MAX98363_R2009_INTR_CLR:
+	case MAX98363_R21FF_REV_ID:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config max98363_sdw_regmap = {
+	.reg_bits = 32,
+	.val_bits = 8,
+	.max_register = MAX98363_R21FF_REV_ID,
+	.reg_defaults  = max98363_reg,
+	.num_reg_defaults = ARRAY_SIZE(max98363_reg),
+	.readable_reg = max98363_readable_register,
+	.volatile_reg = max98363_volatile_reg,
+	.cache_type = REGCACHE_RBTREE,
+	.use_single_read = true,
+	.use_single_write = true,
+};
+
+static int max98363_suspend(struct device *dev)
+{
+	struct max98363_priv *max98363 = dev_get_drvdata(dev);
+
+	regcache_cache_only(max98363->regmap, true);
+	regcache_mark_dirty(max98363->regmap);
+
+	return 0;
+}
+
+#define MAX98363_PROBE_TIMEOUT 5000
+
+static int max98363_resume(struct device *dev)
+{
+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	struct max98363_priv *max98363 = dev_get_drvdata(dev);
+	unsigned long time;
+
+	if (!max98363->first_hw_init)
+		return 0;
+
+	if (!slave->unattach_request)
+		goto regmap_sync;
+
+	time = wait_for_completion_timeout(&slave->initialization_complete,
+					   msecs_to_jiffies(MAX98363_PROBE_TIMEOUT));
+	if (!time) {
+		dev_err(dev, "Initialization not complete, timed out\n");
+		return -ETIMEDOUT;
+	}
+
+regmap_sync:
+
+	slave->unattach_request = 0;
+	regcache_cache_only(max98363->regmap, false);
+	regcache_sync(max98363->regmap);
+
+	return 0;
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(max98363_pm, max98363_suspend, max98363_resume, NULL);
+
+static int max98363_read_prop(struct sdw_slave *slave)
+{
+	struct sdw_slave_prop *prop = &slave->prop;
+	int nval, i;
+	u32 bit;
+	unsigned long addr;
+	struct sdw_dpn_prop *dpn;
+
+	prop->scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
+
+	/* BITMAP: 00000010  Dataport 1 is active */
+	prop->sink_ports = BIT(1);
+	prop->paging_support = true;
+	prop->clk_stop_timeout = 20;
+	prop->simple_clk_stop_capable = true;
+	prop->clock_reg_supported = true;
+
+	nval = hweight32(prop->sink_ports);
+	prop->sink_dpn_prop = devm_kcalloc(&slave->dev, nval,
+					   sizeof(*prop->sink_dpn_prop),
+					   GFP_KERNEL);
+	if (!prop->sink_dpn_prop)
+		return -ENOMEM;
+
+	i = 0;
+	dpn = prop->sink_dpn_prop;
+	addr = prop->sink_ports;
+	for_each_set_bit(bit, &addr, 32) {
+		dpn[i].num = bit;
+		dpn[i].type = SDW_DPN_FULL;
+		dpn[i].simple_ch_prep_sm = true;
+		dpn[i].ch_prep_timeout = 10;
+		i++;
+	}
+
+	return 0;
+}
+
+static int max98363_io_init(struct sdw_slave *slave)
+{
+	struct device *dev = &slave->dev;
+	struct max98363_priv *max98363 = dev_get_drvdata(dev);
+	int ret, reg;
+
+	if (max98363->first_hw_init) {
+		regcache_cache_only(max98363->regmap, false);
+		regcache_cache_bypass(max98363->regmap, true);
+	}
+
+	/*
+	 * PM runtime is only enabled when a Slave reports as Attached
+	 */
+	if (!max98363->first_hw_init) {
+		/* set autosuspend parameters */
+		pm_runtime_set_autosuspend_delay(dev, 3000);
+		pm_runtime_use_autosuspend(dev);
+
+		/* update count of parent 'active' children */
+		pm_runtime_set_active(dev);
+
+		/* make sure the device does not suspend immediately */
+		pm_runtime_mark_last_busy(dev);
+
+		pm_runtime_enable(dev);
+	}
+
+	pm_runtime_get_noresume(dev);
+
+	ret = regmap_read(max98363->regmap, MAX98363_R21FF_REV_ID, &reg);
+	if (!ret) {
+		dev_info(dev, "Revision ID: %X\n", reg);
+		return ret;
+	}
+
+	if (max98363->first_hw_init) {
+		regcache_cache_bypass(max98363->regmap, false);
+		regcache_mark_dirty(max98363->regmap);
+	}
+
+	max98363->first_hw_init = true;
+	max98363->hw_init = true;
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+}
+
+#define MAX98363_RATES SNDRV_PCM_RATE_8000_192000
+#define MAX98363_FORMATS (SNDRV_PCM_FMTBIT_S32_LE)
+
+static int max98363_sdw_dai_hw_params(struct snd_pcm_substream *substream,
+				      struct snd_pcm_hw_params *params,
+				      struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct max98363_priv *max98363 =
+		snd_soc_component_get_drvdata(component);
+
+	struct sdw_stream_config stream_config;
+	struct sdw_port_config port_config;
+	enum sdw_data_direction direction;
+	struct sdw_stream_runtime *stream;
+	int ret;
+
+	stream = snd_soc_dai_get_dma_data(dai, substream);
+
+	if (!stream)
+		return -EINVAL;
+
+	if (!max98363->slave)
+		return -EINVAL;
+
+	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
+		return -EINVAL;
+
+	direction = SDW_DATA_DIR_RX;
+	port_config.num = 1;
+
+	stream_config.frame_rate = params_rate(params);
+	stream_config.bps = snd_pcm_format_width(params_format(params));
+	stream_config.direction = direction;
+
+	if (max98363->slot) {
+		stream_config.ch_count = max98363->slot;
+		port_config.ch_mask = max98363->rx_mask;
+	} else {
+		stream_config.ch_count = params_channels(params);
+		port_config.ch_mask = GENMASK((int)stream_config.ch_count - 1, 0);
+	}
+
+	ret = sdw_stream_add_slave(max98363->slave, &stream_config,
+				   &port_config, 1, stream);
+	if (ret) {
+		dev_err(dai->dev, "Unable to configure port\n");
+		return ret;
+	}
+
+	if (params_channels(params) > 16) {
+		dev_err(component->dev, "Unsupported channels %d\n",
+			params_channels(params));
+		return -EINVAL;
+	}
+
+	dev_dbg(component->dev, "Format supported %d", params_format(params));
+
+	return 0;
+}
+
+static int max98363_pcm_hw_free(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct max98363_priv *max98363 =
+		snd_soc_component_get_drvdata(component);
+	struct sdw_stream_runtime *stream =
+		snd_soc_dai_get_dma_data(dai, substream);
+
+	if (!max98363->slave)
+		return -EINVAL;
+
+	sdw_stream_remove_slave(max98363->slave, stream);
+
+	return 0;
+}
+
+static int max98363_set_sdw_stream(struct snd_soc_dai *dai,
+				   void *sdw_stream, int direction)
+{
+	snd_soc_dai_dma_data_set(dai, direction, sdw_stream);
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops max98363_dai_sdw_ops = {
+	.hw_params = max98363_sdw_dai_hw_params,
+	.hw_free = max98363_pcm_hw_free,
+	.set_stream = max98363_set_sdw_stream,
+};
+
+static struct snd_soc_dai_driver max98363_dai[] = {
+	{
+		.name = "max98363-aif1",
+		.playback = {
+			.stream_name = "HiFi Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MAX98363_RATES,
+			.formats = MAX98363_FORMATS,
+		},
+		.ops = &max98363_dai_sdw_ops,
+	}
+};
+
+static int max98363_update_status(struct sdw_slave *slave,
+				  enum sdw_slave_status status)
+{
+	struct max98363_priv *max98363 = dev_get_drvdata(&slave->dev);
+
+	if (status == SDW_SLAVE_UNATTACHED)
+		max98363->hw_init = false;
+
+	/*
+	 * Perform initialization only if slave status is SDW_SLAVE_ATTACHED
+	 */
+	if (max98363->hw_init || status != SDW_SLAVE_ATTACHED)
+		return 0;
+
+	/* perform I/O transfers required for Slave initialization */
+	return max98363_io_init(slave);
+}
+
+static struct sdw_slave_ops max98363_slave_ops = {
+	.read_prop = max98363_read_prop,
+	.update_status = max98363_update_status,
+};
+
+static DECLARE_TLV_DB_SCALE(max98363_digital_tlv, -6350, 50, 1);
+static const DECLARE_TLV_DB_RANGE(max98363_spk_tlv,
+	0, 5, TLV_DB_SCALE_ITEM(-300, 300, 0),
+);
+
+static const char * const max98363_tone_cfg_text[] = {
+	"Reserved", "0", "+FS/2", "-FS/2", "1KHz",
+	"12KHz", "8KHz", "6KHz", "4KHz", "3KHz",
+	"2KHz",	"1.5KHz", "Reserved", "500Hz", "250Hz"
+};
+
+static SOC_ENUM_SINGLE_DECL(max98363_tone_cfg_enum,
+			    MAX98363_R2030_TONE_GEN_CFG, 0,
+			    max98363_tone_cfg_text);
+
+static const char * const max98363_spkmon_duration_text[] = {
+	"8ms", "20ms", "40ms", "60ms",
+	"80ms", "160ms", "240ms", "320ms",
+	"400ms", "480ms", "560ms", "640ms",
+	"720ms", "800ms", "880ms", "960ms"
+};
+
+static SOC_ENUM_SINGLE_DECL(max98363_spkmon_duration_enum,
+			    MAX98363_R2023_SPK_MON_DURATION, 0,
+			    max98363_spkmon_duration_text);
+
+static const struct snd_kcontrol_new max98363_snd_controls[] = {
+	SOC_SINGLE_TLV("Digital Volume", MAX98363_R2040_AMP_VOL,
+		       0, 0x7F, 1, max98363_digital_tlv),
+	SOC_SINGLE_TLV("Speaker Volume", MAX98363_R2041_AMP_GAIN,
+		       0, 10, 0, max98363_spk_tlv),
+	SOC_SINGLE("Tone Generator Switch", MAX98363_R203F_TONE_GEN_EN,
+		   0, 1, 0),
+	SOC_ENUM("Tone Config", max98363_tone_cfg_enum),
+	SOC_SINGLE("Ramp Switch", MAX98363_R2042_DSP_CFG,
+		   MAX98363_AMP_DSP_CFG_RMP_SHIFT, 1, 0),
+	SOC_SINGLE("CLK Monitor Switch", MAX98363_R2021_ERR_MON_CTRL,
+		   MAX98363_CLOCK_MON_SHIFT, 1, 0),
+	SOC_SINGLE("SPKMON Monitor Switch", MAX98363_R2021_ERR_MON_CTRL,
+		   MAX98363_SPKMON_SHIFT, 1, 0),
+	SOC_SINGLE("SPKMON Thresh", MAX98363_R2022_SPK_MON_THRESH, 0, 0xFF, 0),
+	SOC_ENUM("SPKMON Duration", max98363_spkmon_duration_enum),
+};
+
+static const struct snd_soc_dapm_widget max98363_dapm_widgets[] = {
+	SND_SOC_DAPM_AIF_IN("AIFIN", "HiFi Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_OUTPUT("BE_OUT"),
+};
+
+static const struct snd_soc_dapm_route max98363_audio_map[] = {
+	/* Plabyack */
+	{"BE_OUT", NULL, "AIFIN"},
+};
+
+const struct snd_soc_component_driver soc_codec_dev_max98363 = {
+	.controls		= max98363_snd_controls,
+	.num_controls		= ARRAY_SIZE(max98363_snd_controls),
+	.dapm_widgets		= max98363_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(max98363_dapm_widgets),
+	.dapm_routes		= max98363_audio_map,
+	.num_dapm_routes	= ARRAY_SIZE(max98363_audio_map),
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+};
+
+static int max98363_init(struct sdw_slave *slave, struct regmap *regmap)
+{
+	struct max98363_priv *max98363;
+	int ret;
+	struct device *dev = &slave->dev;
+
+	/*  Allocate and assign private driver data structure  */
+	max98363 = devm_kzalloc(dev, sizeof(*max98363), GFP_KERNEL);
+	if (!max98363)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, max98363);
+	max98363->regmap = regmap;
+	max98363->slave = slave;
+
+	max98363->hw_init = false;
+	max98363->first_hw_init = false;
+
+	/* codec registration  */
+	ret = devm_snd_soc_register_component(dev, &soc_codec_dev_max98363,
+					      max98363_dai,
+					      ARRAY_SIZE(max98363_dai));
+	if (ret < 0)
+		dev_err(dev, "Failed to register codec: %d\n", ret);
+
+	return ret;
+}
+
+static int max98363_sdw_probe(struct sdw_slave *slave,
+			      const struct sdw_device_id *id)
+{
+	struct regmap *regmap;
+
+	/* Regmap Initialization */
+	regmap = devm_regmap_init_sdw(slave, &max98363_sdw_regmap);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return max98363_init(slave, regmap);
+}
+
+static const struct sdw_device_id max98363_id[] = {
+	SDW_SLAVE_ENTRY(0x019F, 0x8363, 0),
+	{},
+};
+MODULE_DEVICE_TABLE(sdw, max98363_id);
+
+static struct sdw_driver max98363_sdw_driver = {
+	.driver = {
+		.name = "max98363",
+		.pm = pm_ptr(&max98363_pm),
+	},
+	.probe = max98363_sdw_probe,
+	.ops = &max98363_slave_ops,
+	.id_table = max98363_id,
+};
+
+module_sdw_driver(max98363_sdw_driver);
+
+MODULE_DESCRIPTION("ASoC MAX98363 driver SDW");
+MODULE_AUTHOR("Ryan Lee <ryans.lee@analog.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/max98363.h b/sound/soc/codecs/max98363.h
new file mode 100644
index 000000000000..f2703fcb6335
--- /dev/null
+++ b/sound/soc/codecs/max98363.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2022 Analog Devices Inc. */
+
+#ifndef _MAX98363_H
+#define _MAX98363_H
+
+#define MAX98363_R2000_SW_RESET			0x2000
+#define MAX98363_R2001_INTR_RAW			0x2001
+#define MAX98363_R2003_INTR_STATE		0x2003
+#define MAX98363_R2005_INTR_FALG		0x2005
+#define MAX98363_R2007_INTR_EN			0x2007
+#define MAX98363_R2009_INTR_CLR			0x2009
+#define MAX98363_R2021_ERR_MON_CTRL		0x2021
+#define MAX98363_R2022_SPK_MON_THRESH		0x2022
+#define MAX98363_R2023_SPK_MON_DURATION		0x2023
+#define MAX98363_R2030_TONE_GEN_CFG		0x2030
+#define MAX98363_R203F_TONE_GEN_EN		0x203F
+#define MAX98363_R2040_AMP_VOL			0x2040
+#define MAX98363_R2041_AMP_GAIN			0x2041
+#define MAX98363_R2042_DSP_CFG			0x2042
+#define MAX98363_R21FF_REV_ID			0x21FF
+
+/* MAX98363_R2021_ERR_MON_CTRL */
+#define MAX98363_SPKMON_SHIFT			(3)
+#define MAX98363_CLOCK_MON_SHIFT		(0)
+
+/* MAX98363_R2042_DSP_CFG */
+#define MAX98363_AMP_DSP_CFG_RMP_SHIFT		(3)
+
+struct max98363_priv {
+	struct regmap *regmap;
+	struct sdw_slave *slave;
+	int slot;
+	unsigned int rx_mask;
+	bool hw_init;
+	bool first_hw_init;
+};
+#endif
-- 
2.34.1

