Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6E36A1483
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 02:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjBXBIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 20:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBXBIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 20:08:35 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5940138022;
        Thu, 23 Feb 2023 17:08:32 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id il18-20020a17090b165200b0023127b2d602so1138929pjb.2;
        Thu, 23 Feb 2023 17:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=31xKklCBZ9Vsy2a5ShL4qjkE6yxlBwnMW0g3zJdvC5A=;
        b=JeKDCY0QdYt0tPrfC/WZPMVaOnUxRcHw23t591JcVOOc4XcO/8M+tKjtLIzAlTwAFG
         uYkhe0fbDlogKdwe1tUg+VdrRsOxH1+AOrRPiFzwqs6DtG8XwxfJoRo8SCaCYR+x6kUB
         +uwzD/0ynpwewpyF6dOse7HHxuZEv07YDcragY6Y9MtGnNQqegjh1ZmVu4jBRor2Dpgz
         gLX2yAfBnK2HYzqMkiaStiUdOpEiFoOLe8pN9nUYZEBkTe4z88utztRE9CxpHf142P6E
         uFnkQrcujj8yofBpZONgL1VgqsN6eBDsbxREB+Sy/lGjUIdnz+Ko56F6HoHhzdpC7oqY
         p0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=31xKklCBZ9Vsy2a5ShL4qjkE6yxlBwnMW0g3zJdvC5A=;
        b=Sb3vPYWHYyt9yW+Qb1XZ42oinz2er8jPpSeeWIyWz4cvVVezZff2A2UJBRJvCg6mtY
         ukXcUkD+DiBZsghMUfu2TW15bjYsaONxtbnneJzxkk2wsmkIOcymnkjEcNTXQ/bycQuf
         yjZXNBxToZLPkMNmCI5W79lQJ/DOjYA+LOaZtEq7pYbqhXWrUKOvSjnetHyBV/21tS6U
         vt3lTxK9u5t8J9fjow9OZ4qlstaQJ/oTayJdqnQ/LcwKv5yzVKD+4LICmrkoNufThK9v
         FU+GgGqgc4JFmLYIRQ6rucPR3XyebFowpANCE0D2e3kwiAKxmcciIq1M8U0FeMUEJEGr
         Cc4Q==
X-Gm-Message-State: AO0yUKUXQwKi1npeWelbnTq5FWYyITIw78ENyrxUseueqPg0XM4M46dT
        PpF6PZO2k7JAWsZmOyThyok=
X-Google-Smtp-Source: AK7set8zm8WEcNC/6gXOO3+qN54sz9KhRTFlyyi5qJwe/78PRottCPHsiLQ2yKFl3cHoOmytO9+60A==
X-Received: by 2002:a17:902:ab0c:b0:19c:d316:309a with SMTP id ik12-20020a170902ab0c00b0019cd316309amr735204plb.4.1677200911490;
        Thu, 23 Feb 2023 17:08:31 -0800 (PST)
Received: from ryan-ThinkPad-T470.. (c-24-6-63-212.hsd1.ca.comcast.net. [24.6.63.212])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902a40500b0019adfb96084sm3821008plq.36.2023.02.23.17.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 17:08:31 -0800 (PST)
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
Subject: [PATCH 1/2] ASoC: max98363: add soundwire amplifier driver
Date:   Thu, 23 Feb 2023 17:08:13 -0800
Message-Id: <20230224010814.504016-1-ryan.lee.analog@gmail.com>
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
 sound/soc/codecs/Kconfig    |  11 +
 sound/soc/codecs/Makefile   |   2 +
 sound/soc/codecs/max98363.c | 699 ++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/max98363.h | 108 ++++++
 4 files changed, 820 insertions(+)
 create mode 100644 sound/soc/codecs/max98363.c
 create mode 100644 sound/soc/codecs/max98363.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 4621674e68bf..0638b27c6494 100644
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
@@ -1094,6 +1095,16 @@ config SND_SOC_MAX98520
 
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
index a0a61554548e..f4fbeceed816 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -144,6 +144,7 @@ snd-soc-max98925-objs := max98925.o
 snd-soc-max98926-objs := max98926.o
 snd-soc-max98927-objs := max98927.o
 snd-soc-max98520-objs := max98520.o
+snd-soc-max98363-objs := max98363.o
 snd-soc-max98373-objs := max98373.o
 snd-soc-max98373-i2c-objs := max98373-i2c.o
 snd-soc-max98373-sdw-objs := max98373-sdw.o
@@ -507,6 +508,7 @@ obj-$(CONFIG_SND_SOC_MAX98925)	+= snd-soc-max98925.o
 obj-$(CONFIG_SND_SOC_MAX98926)	+= snd-soc-max98926.o
 obj-$(CONFIG_SND_SOC_MAX98927)	+= snd-soc-max98927.o
 obj-$(CONFIG_SND_SOC_MAX98520)	+= snd-soc-max98520.o
+obj-$(CONFIG_SND_SOC_MAX98363)	+= snd-soc-max98363.o
 obj-$(CONFIG_SND_SOC_MAX98373)	+= snd-soc-max98373.o
 obj-$(CONFIG_SND_SOC_MAX98373_I2C)   += snd-soc-max98373-i2c.o
 obj-$(CONFIG_SND_SOC_MAX98373_SDW)   += snd-soc-max98373-sdw.o
diff --git a/sound/soc/codecs/max98363.c b/sound/soc/codecs/max98363.c
new file mode 100644
index 000000000000..e766c733f8e4
--- /dev/null
+++ b/sound/soc/codecs/max98363.c
@@ -0,0 +1,699 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2022, Analog Devices Inc.
+
+#include <linux/acpi.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+#include <linux/of.h>
+#include <linux/soundwire/sdw.h>
+#include <linux/soundwire/sdw_type.h>
+#include <linux/soundwire/sdw_registers.h>
+#include <linux/regulator/consumer.h>
+#include "max98363.h"
+
+struct sdw_stream_data {
+	struct sdw_stream_runtime *sdw_stream;
+};
+
+static struct reg_default max98363_reg[] = {
+	{MAX98363_R0040_SCP_INIT_STAT_1, 0x00},
+	{MAX98363_R0041_SCP_INIT_MASK_1, 0x00},
+	{MAX98363_R0042_SCP_INIT_STAT_2, 0x00},
+	{MAX98363_R0044_SCP_CTRL, 0x00},
+	{MAX98363_R0045_SCP_SYSTEM_CTRL, 0x00},
+	{MAX98363_R0046_SCP_DEV_NUMBER, 0x00},
+	{MAX98363_R004D_SCP_BUS_CLK, 0x00},
+	{MAX98363_R0050_SCP_DEV_ID_0, 0x21},
+	{MAX98363_R0051_SCP_DEV_ID_1, 0x01},
+	{MAX98363_R0052_SCP_DEV_ID_2, 0x9F},
+	{MAX98363_R0053_SCP_DEV_ID_3, 0x87},
+	{MAX98363_R0054_SCP_DEV_ID_4, 0x08},
+	{MAX98363_R0055_SCP_DEV_ID_5, 0x00},
+	{MAX98363_R0060_SCP_FRAME_CTRL, 0x00},
+	{MAX98363_R0062_SCP_CLK_SCALE_BANK0, 0x00},
+	{MAX98363_R0070_SCP_FRAME_CTRL, 0x00},
+	{MAX98363_R0072_SCP_CLK_SCALE_BANK1, 0x00},
+	{MAX98363_R0080_SCP_PHYOUTCTRL_0, 0x00},
+	{MAX98363_R0100_DP1_INIT_STAT, 0x00},
+	{MAX98363_R0101_DP1_INIT_MASK, 0x00},
+	{MAX98363_R0102_DP1_PORT_CTRL, 0x00},
+	{MAX98363_R0103_DP1_BLOCK_CTRL_1, 0x00},
+	{MAX98363_R0104_DP1_PREPARE_STATUS, 0x00},
+	{MAX98363_R0105_DP1_PREPARE_CTRL, 0x00},
+	{MAX98363_R0120_DP1_CHANNEL_EN, 0x00},
+	{MAX98363_R0122_DP1_SAMPLE_CTRL1, 0x00},
+	{MAX98363_R0123_DP1_SAMPLE_CTRL2, 0x00},
+	{MAX98363_R0124_DP1_OFFSET_CTRL1, 0x00},
+	{MAX98363_R0125_DP1_OFFSET_CTRL2, 0x00},
+	{MAX98363_R0126_DP1_HCTRL, 0x00},
+	{MAX98363_R0127_DP1_BLOCK_CTRL3, 0x00},
+	{MAX98363_R0130_DP1_CHANNEL_EN, 0x00},
+	{MAX98363_R0132_DP1_SAMPLE_CTRL1, 0x00},
+	{MAX98363_R0133_DP1_SAMPLE_CTRL2, 0x00},
+	{MAX98363_R0134_DP1_OFFSET_CTRL1, 0x00},
+	{MAX98363_R0135_DP1_OFFSET_CTRL2, 0x00},
+	{MAX98363_R0136_DP1_HCTRL, 0x0136},
+	{MAX98363_R0137_DP1_BLOCK_CTRL3, 0x00},
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
+	/* SoundWire Control Port Registers */
+	case MAX98363_R0040_SCP_INIT_STAT_1 ... MAX98363_R0046_SCP_DEV_NUMBER:
+	case MAX98363_R004D_SCP_BUS_CLK:
+	case MAX98363_R0050_SCP_DEV_ID_0 ... MAX98363_R0055_SCP_DEV_ID_5:
+	case MAX98363_R0062_SCP_CLK_SCALE_BANK0:
+	case MAX98363_R0072_SCP_CLK_SCALE_BANK1:
+	case MAX98363_R0080_SCP_PHYOUTCTRL_0:
+	/* Soundwire Data Port 1 Registers */
+	case MAX98363_R0100_DP1_INIT_STAT ... MAX98363_R0105_DP1_PREPARE_CTRL:
+	case MAX98363_R0120_DP1_CHANNEL_EN ... MAX98363_R0127_DP1_BLOCK_CTRL3:
+	case MAX98363_R0130_DP1_CHANNEL_EN:
+	case MAX98363_R0132_DP1_SAMPLE_CTRL1... MAX98363_R0137_DP1_BLOCK_CTRL3:
+	/* MAX98363 Amp Control Registers */
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
+	/* SoundWire Control Port Registers */
+	case MAX98363_R0040_SCP_INIT_STAT_1 ... MAX98363_R0046_SCP_DEV_NUMBER:
+	case MAX98363_R004D_SCP_BUS_CLK:
+	case MAX98363_R0050_SCP_DEV_ID_0 ... MAX98363_R0055_SCP_DEV_ID_5:
+	case MAX98363_R0062_SCP_CLK_SCALE_BANK0:
+	case MAX98363_R0072_SCP_CLK_SCALE_BANK1:
+	case MAX98363_R0080_SCP_PHYOUTCTRL_0:
+	/* Soundwire Data Port 1 Registers */
+	case MAX98363_R0100_DP1_INIT_STAT ... MAX98363_R0105_DP1_PREPARE_CTRL:
+	case MAX98363_R0120_DP1_CHANNEL_EN ... MAX98363_R0127_DP1_BLOCK_CTRL3:
+	case MAX98363_R0130_DP1_CHANNEL_EN:
+	case MAX98363_R0132_DP1_SAMPLE_CTRL1... MAX98363_R0137_DP1_BLOCK_CTRL3:
+	/* MAX98363 Amp Control Registers */
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
+static __maybe_unused int max98363_suspend(struct device *dev)
+{
+	struct max98363_priv *max98363 = dev_get_drvdata(dev);
+
+	regcache_cache_only(max98363->regmap, true);
+	regcache_mark_dirty(max98363->regmap);
+
+	if (max98363->dvddio)
+		regulator_disable(max98363->dvddio);
+
+	if (max98363->vdd)
+		regulator_disable(max98363->vdd);
+
+	return 0;
+}
+
+#define MAX98363_PROBE_TIMEOUT 5000
+
+static __maybe_unused int max98363_resume(struct device *dev)
+{
+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	struct max98363_priv *max98363 = dev_get_drvdata(dev);
+	unsigned long time;
+	int ret;
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
+	if (max98363->dvddio) {
+		ret = regulator_enable(max98363->dvddio);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (max98363->vdd) {
+		ret = regulator_enable(max98363->vdd);
+		if (ret < 0)
+			return ret;
+	}
+
+	slave->unattach_request = 0;
+	regcache_cache_only(max98363->regmap, false);
+	regcache_sync(max98363->regmap);
+
+	return 0;
+}
+
+static const struct dev_pm_ops max98363_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(max98363_suspend, max98363_resume)
+	SET_RUNTIME_PM_OPS(max98363_suspend, max98363_resume, NULL)
+};
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
+
+	nval = hweight32(prop->source_ports);
+	prop->src_dpn_prop = devm_kcalloc(&slave->dev, nval,
+					  sizeof(*prop->src_dpn_prop),
+					  GFP_KERNEL);
+	if (!prop->src_dpn_prop)
+		return -ENOMEM;
+
+	i = 0;
+	dpn = prop->src_dpn_prop;
+	addr = prop->source_ports;
+	for_each_set_bit(bit, &addr, 32) {
+		dpn[i].num = bit;
+		dpn[i].type = SDW_DPN_FULL;
+		dpn[i].simple_ch_prep_sm = true;
+		dpn[i].ch_prep_timeout = 10;
+		i++;
+	}
+
+	/* do this again for sink now */
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
+	/* set the timeout values */
+	prop->clk_stop_timeout = 20;
+	prop->simple_clk_stop_capable = true;
+	prop->clock_reg_supported = true;
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
+	struct sdw_stream_data *stream;
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
+				   &port_config, 1, stream->sdw_stream);
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
+	struct sdw_stream_data *stream =
+		snd_soc_dai_get_dma_data(dai, substream);
+
+	if (!max98363->slave)
+		return -EINVAL;
+
+	sdw_stream_remove_slave(max98363->slave, stream->sdw_stream);
+
+	return 0;
+}
+
+static int max98363_set_sdw_stream(struct snd_soc_dai *dai,
+				   void *sdw_stream, int direction)
+{
+	struct sdw_stream_data *stream;
+
+	if (!sdw_stream)
+		return 0;
+
+	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
+	if (!stream)
+		return -ENOMEM;
+
+	stream->sdw_stream = sdw_stream;
+
+	/* Use tx_mask or rx_mask to configure stream tag and set dma_data */
+	snd_soc_dai_dma_data_set(dai, direction, stream);
+
+	return 0;
+}
+
+static void max98363_shutdown(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *dai)
+{
+	struct sdw_stream_data *stream;
+
+	stream = snd_soc_dai_get_dma_data(dai, substream);
+	snd_soc_dai_set_dma_data(dai, substream, NULL);
+	kfree(stream);
+}
+
+static int max98363_sdw_set_tdm_slot(struct snd_soc_dai *dai,
+				     unsigned int tx_mask,
+				     unsigned int rx_mask,
+				     int slots, int slot_width)
+{
+	struct snd_soc_component *component = dai->component;
+	struct max98363_priv *max98363 =
+		snd_soc_component_get_drvdata(component);
+
+	/* tx_mask is not supported */
+	if (tx_mask)
+		return -EINVAL;
+
+	if (!rx_mask && !slots && !slot_width)
+		max98363->tdm_mode = false;
+	else
+		max98363->tdm_mode = true;
+
+	max98363->rx_mask = rx_mask;
+	max98363->slot = slots;
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops max98363_dai_sdw_ops = {
+	.hw_params = max98363_sdw_dai_hw_params,
+	.hw_free = max98363_pcm_hw_free,
+	.set_stream = max98363_set_sdw_stream,
+	.shutdown = max98363_shutdown,
+	.set_tdm_slot = max98363_sdw_set_tdm_slot,
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
+/*
+ * slave_ops: callbacks for get_clock_stop_mode, clock_stop and
+ * port_prep are not defined for now
+ */
+static struct sdw_slave_ops max98363_slave_ops = {
+	.read_prop = max98363_read_prop,
+	.update_status = max98363_update_status,
+	.bus_config = NULL,
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
+	.probe			= NULL,
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
+static void max98363_supply_disable(void *r)
+{
+	regulator_disable((struct regulator *)r);
+}
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
+	max98363->vdd = devm_regulator_get_optional(dev, "vdd");
+	if (IS_ERR(max98363->vdd)) {
+		if (PTR_ERR(max98363->vdd) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		max98363->vdd = NULL;
+	}
+	max98363->dvddio = devm_regulator_get_optional(dev, "dvddio");
+	if (IS_ERR(max98363->dvddio)) {
+		if (PTR_ERR(max98363->dvddio) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		max98363->dvddio = NULL;
+	}
+
+	if (max98363->vdd) {
+		ret = regulator_enable(max98363->vdd);
+		if (ret < 0)
+			return ret;
+
+		ret = devm_add_action_or_reset(dev,
+					       max98363_supply_disable,
+					       max98363->vdd);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (max98363->dvddio) {
+		ret = regulator_enable(max98363->dvddio);
+		if (ret < 0)
+			return ret;
+
+		ret = devm_add_action_or_reset(dev,
+					       max98363_supply_disable,
+					       max98363->dvddio);
+		if (ret < 0)
+			return ret;
+	}
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
+#if defined(CONFIG_OF)
+static const struct of_device_id max98363_of_match[] = {
+	{ .compatible = "adi,max98363", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, max98363_of_match);
+#endif
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id max98363_acpi_match[] = {
+	{ "ADS8363", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, max98363_acpi_match);
+#endif
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
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(max98363_of_match),
+		.acpi_match_table = ACPI_PTR(max98363_acpi_match),
+		.pm = &max98363_pm,
+	},
+	.probe = max98363_sdw_probe,
+	.remove = NULL,
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
index 000000000000..1c55017a9fc0
--- /dev/null
+++ b/sound/soc/codecs/max98363.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2022 Analog Devices Inc. */
+
+#ifndef _MAX98363_H
+#define _MAX98363_H
+
+/* SoundWire Slave Control Port (SCP)  */
+#define MAX98363_R0040_SCP_INIT_STAT_1		0x0040
+#define MAX98363_R0041_SCP_INIT_MASK_1		0x0041
+#define MAX98363_R0042_SCP_INIT_STAT_2		0x0042
+#define MAX98363_R0044_SCP_CTRL			0x0044
+#define MAX98363_R0045_SCP_SYSTEM_CTRL		0x0045
+#define MAX98363_R0046_SCP_DEV_NUMBER		0x0046
+#define MAX98363_R004D_SCP_BUS_CLK		0x004D
+#define MAX98363_R0050_SCP_DEV_ID_0		0x0050
+#define MAX98363_R0051_SCP_DEV_ID_1		0x0051
+#define MAX98363_R0052_SCP_DEV_ID_2		0x0052
+#define MAX98363_R0053_SCP_DEV_ID_3		0x0053
+#define MAX98363_R0054_SCP_DEV_ID_4		0x0054
+#define MAX98363_R0055_SCP_DEV_ID_5		0x0055
+#define MAX98363_R0060_SCP_FRAME_CTRL		0x0060
+#define MAX98363_R0062_SCP_CLK_SCALE_BANK0	0x0062
+#define MAX98363_R0070_SCP_FRAME_CTRL		0x0070
+#define MAX98363_R0072_SCP_CLK_SCALE_BANK1	0x0072
+#define MAX98363_R0080_SCP_PHYOUTCTRL_0		0x0080
+
+/* SoundWire Device Data Port (DP)  */
+/* Data Port 1 Registers */
+#define MAX98363_R0100_DP1_INIT_STAT		0x0100
+#define MAX98363_R0101_DP1_INIT_MASK		0x0101
+#define MAX98363_R0102_DP1_PORT_CTRL		0x0102
+#define MAX98363_R0103_DP1_BLOCK_CTRL_1		0x0103
+#define MAX98363_R0104_DP1_PREPARE_STATUS	0x0104
+#define MAX98363_R0105_DP1_PREPARE_CTRL		0x0105
+/* Data Port 1 Bank 0 Registers */
+#define MAX98363_R0120_DP1_CHANNEL_EN		0x0120
+#define MAX98363_R0122_DP1_SAMPLE_CTRL1		0x0122
+#define MAX98363_R0123_DP1_SAMPLE_CTRL2		0x0123
+#define MAX98363_R0124_DP1_OFFSET_CTRL1		0x0124
+#define MAX98363_R0125_DP1_OFFSET_CTRL2		0x0125
+#define MAX98363_R0126_DP1_HCTRL		0x0126
+#define MAX98363_R0127_DP1_BLOCK_CTRL3		0x0127
+/* Data Port 1 Bank 1 Registers */
+#define MAX98363_R0130_DP1_CHANNEL_EN		0x0130
+#define MAX98363_R0132_DP1_SAMPLE_CTRL1		0x0132
+#define MAX98363_R0133_DP1_SAMPLE_CTRL2		0x0133
+#define MAX98363_R0134_DP1_OFFSET_CTRL1		0x0134
+#define MAX98363_R0135_DP1_OFFSET_CTRL2		0x0135
+#define MAX98363_R0136_DP1_HCTRL		0x0136
+#define MAX98363_R0137_DP1_BLOCK_CTRL3		0x0137
+/* Data Port 3 Registers */
+#define MAX98363_R0300_DP3_INIT_STAT		0x0300
+#define MAX98363_R0301_DP3_INIT_MASK		0x0301
+#define MAX98363_R0302_DP3_PORT_CTRL		0x0302
+#define MAX98363_R0303_DP3_BLOCK_CTRL_1		0x0303
+#define MAX98363_R0304_DP3_PREPARE_STATUS	0x0304
+#define MAX98363_R0305_DP3_PREPARE_CTRL		0x0305
+/* Data Port 3 Bank 0 Registers */
+#define MAX98363_R0320_DP3_CHANNEL_EN		0x0320
+#define MAX98363_R0322_DP3_SAMPLE_CTRL1		0x0322
+#define MAX98363_R0323_DP3_SAMPLE_CTRL2		0x0323
+#define MAX98363_R0324_DP3_OFFSET_CTRL1		0x0324
+#define MAX98363_R0325_DP3_OFFSET_CTRL2		0x0325
+#define MAX98363_R0326_DP3_HCTRL		0x0326
+#define MAX98363_R0327_DP3_BLOCK_CTRL3		0x0327
+/* Data Port 3 Bank 1 Registers */
+#define MAX98363_R0330_DP3_CHANNEL_EN		0x0330
+#define MAX98363_R0332_DP3_SAMPLE_CTRL1		0x0332
+#define MAX98363_R0333_DP3_SAMPLE_CTRL2		0x0333
+#define MAX98363_R0334_DP3_OFFSET_CTRL1		0x0334
+#define MAX98363_R0335_DP3_OFFSET_CTRL2		0x0335
+#define MAX98363_R0336_DP3_HCTRL		0x0336
+#define MAX98363_R0337_DP3_BLOCK_CTRL3		0x0337
+/* Amp custom registers */
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
+	struct regulator *vdd, *dvddio;
+	bool tdm_mode;
+	struct sdw_slave *slave;
+	int slot;
+	unsigned int rx_mask;
+	bool hw_init;
+	bool first_hw_init;
+};
+#endif
-- 
2.34.1

