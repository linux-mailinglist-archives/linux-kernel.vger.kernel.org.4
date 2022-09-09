Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6345B3A43
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbiIINzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiIINy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:54:58 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB9C13E00;
        Fri,  9 Sep 2022 06:54:46 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1662731681; bh=KIoZwOlRFJ7dE2DxduY2/mMDMwdqNFAf6PavHAbjvoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LZIyPbKLBD4bETUL0FoaFO8LlEyTFa0pnRxbjEGvGGJCTwJsFE7mYetjHv21niuZa
         44gBqk2M7pKGs20t7mcFN9Tvc47GLK3Ky5JhEi0jxoO2E++GddEErqcm9eHsg50Nyv
         GVh2TUWdUGFu3lpU2lUtnkyYIymsRz6xKTe9TO0Y=
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Matt Flax <flatmax@flatmax.com>,
        - <patches@opensource.cirrus.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: [PATCH 09/10] ASoC: cs42l83: Extend CS42L42 support to new part
Date:   Fri,  9 Sep 2022 15:53:33 +0200
Message-Id: <20220909135334.98220-10-povik+lin@cutebit.org>
In-Reply-To: <20220909135334.98220-1-povik+lin@cutebit.org>
References: <20220909135334.98220-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CS42L83 part is a headphone jack codec found in recent Apple
machines. It is a publicly undocumented part but as far as can be told
it is identical to CS42L42 except for two points:

 * The chip ID is different.

 * Of those registers for which we have a default value in the existing
   CS42L42 kernel driver, one register (MCLK_CTL) differs in its reset
   value on CS42L83.

To address those two points (and only those), add to the CS42L42 driver
a separate CS42L83 front.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
There's a simpler alternative to the full cs42l83-i2c.c duplication:
We could drop the default

  { CS42L42_MCLK_CTL,     0x02 },

from the CS42L42 regmap, and not distinguish between the parts -- that
would work too.

 MAINTAINERS                    |   1 +
 include/sound/cs42l42.h        |   1 +
 sound/soc/codecs/Kconfig       |   7 +
 sound/soc/codecs/Makefile      |   2 +
 sound/soc/codecs/cs42l42-i2c.c |   1 +
 sound/soc/codecs/cs42l42.c     |   9 +-
 sound/soc/codecs/cs42l42.h     |   1 +
 sound/soc/codecs/cs42l83-i2c.c | 248 +++++++++++++++++++++++++++++++++
 8 files changed, 266 insertions(+), 4 deletions(-)
 create mode 100644 sound/soc/codecs/cs42l83-i2c.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 895e8ace80dd..363e207c164d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1906,6 +1906,7 @@ L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/apple,*
 F:	sound/soc/apple/*
+F:	sound/soc/codecs/cs42l83-i2c.c
 
 ARM/ARTPEC MACHINE SUPPORT
 M:	Jesper Nilsson <jesper.nilsson@axis.com>
diff --git a/include/sound/cs42l42.h b/include/sound/cs42l42.h
index a55d522f1772..1d1c24fdd0ca 100644
--- a/include/sound/cs42l42.h
+++ b/include/sound/cs42l42.h
@@ -40,6 +40,7 @@
 #define CS42L42_PAGE_30		0x3000
 
 #define CS42L42_CHIP_ID		0x42A42
+#define CS42L83_CHIP_ID		0x42A83
 
 /* Page 0x10 Global Registers */
 #define CS42L42_DEVID_AB		(CS42L42_PAGE_10 + 0x01)
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 01725d0a9500..444cee829a26 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -722,6 +722,13 @@ config SND_SOC_CS42L73
 	tristate "Cirrus Logic CS42L73 CODEC"
 	depends on I2C
 
+config SND_SOC_CS42L83
+	tristate "Cirrus Logic CS42L83 CODEC"
+	depends on I2C
+	select REGMAP
+	select REGMAP_I2C
+	select SND_SOC_CS42L42_CORE
+
 config SND_SOC_CS4234
 	tristate "Cirrus Logic CS4234 CODEC"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 5b7020a0b234..9170ee1447dd 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -71,6 +71,7 @@ snd-soc-cs42l51-i2c-objs := cs42l51-i2c.o
 snd-soc-cs42l52-objs := cs42l52.o
 snd-soc-cs42l56-objs := cs42l56.o
 snd-soc-cs42l73-objs := cs42l73.o
+snd-soc-cs42l83-i2c-objs := cs42l83-i2c.o
 snd-soc-cs4234-objs := cs4234.o
 snd-soc-cs4265-objs := cs4265.o
 snd-soc-cs4270-objs := cs4270.o
@@ -430,6 +431,7 @@ obj-$(CONFIG_SND_SOC_CS42L51_I2C)	+= snd-soc-cs42l51-i2c.o
 obj-$(CONFIG_SND_SOC_CS42L52)	+= snd-soc-cs42l52.o
 obj-$(CONFIG_SND_SOC_CS42L56)	+= snd-soc-cs42l56.o
 obj-$(CONFIG_SND_SOC_CS42L73)	+= snd-soc-cs42l73.o
+obj-$(CONFIG_SND_SOC_CS42L83)	+= snd-soc-cs42l83-i2c.o
 obj-$(CONFIG_SND_SOC_CS4234)	+= snd-soc-cs4234.o
 obj-$(CONFIG_SND_SOC_CS4265)	+= snd-soc-cs4265.o
 obj-$(CONFIG_SND_SOC_CS4270)	+= snd-soc-cs4270.o
diff --git a/sound/soc/codecs/cs42l42-i2c.c b/sound/soc/codecs/cs42l42-i2c.c
index e6999f44d0f5..21a277a3cf80 100644
--- a/sound/soc/codecs/cs42l42-i2c.c
+++ b/sound/soc/codecs/cs42l42-i2c.c
@@ -31,6 +31,7 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
 		return ret;
 	}
 
+	cs42l42->devid = CS42L42_CHIP_ID;
 	cs42l42->dev = dev;
 	cs42l42->regmap = regmap;
 	cs42l42->irq = i2c_client->irq;
diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index f7a4d51538dd..3f067cf9131a 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -2319,11 +2319,11 @@ int cs42l42_init(struct cs42l42_private *cs42l42)
 		goto err_disable;
 	}
 
-	if (devid != CS42L42_CHIP_ID) {
+	if (devid != cs42l42->devid) {
 		ret = -ENODEV;
 		dev_err(cs42l42->dev,
-			"CS42L42 Device ID (%X). Expected %X\n",
-			devid, CS42L42_CHIP_ID);
+			"CS42L%x Device ID (%X). Expected %X\n",
+			cs42l42->devid & 0xff, devid, cs42l42->devid);
 		goto err_disable;
 	}
 
@@ -2334,7 +2334,8 @@ int cs42l42_init(struct cs42l42_private *cs42l42)
 	}
 
 	dev_info(cs42l42->dev,
-		 "Cirrus Logic CS42L42, Revision: %02X\n", reg & 0xFF);
+		 "Cirrus Logic CS42L%x, Revision: %02X\n",
+		 cs42l42->devid & 0xff, reg & 0xFF);
 
 	/* Power up the codec */
 	regmap_update_bits(cs42l42->regmap, CS42L42_PWR_CTL1,
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index be6f979c82ec..bc51bb09da5c 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -31,6 +31,7 @@ struct  cs42l42_private {
 	struct completion pdn_done;
 	struct snd_soc_jack *jack;
 	struct mutex irq_lock;
+	int devid;
 	int irq;
 	int pll_config;
 	u32 sclk;
diff --git a/sound/soc/codecs/cs42l83-i2c.c b/sound/soc/codecs/cs42l83-i2c.c
new file mode 100644
index 000000000000..83edcefc57ed
--- /dev/null
+++ b/sound/soc/codecs/cs42l83-i2c.c
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * cs42l83-i2c.c -- CS42L83 ALSA SoC audio driver for I2C
+ *
+ * Based on cs42l42-i2c.c:
+ *   Copyright 2016, 2022 Cirrus Logic, Inc.
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include "cs42l42.h"
+
+static const struct reg_default cs42l83_reg_defaults[] = {
+	{ CS42L42_FRZ_CTL,			0x00 },
+	{ CS42L42_SRC_CTL,			0x10 },
+	{ CS42L42_MCLK_CTL,			0x00 }, /* <- only deviation from CS42L42 */
+	{ CS42L42_SFTRAMP_RATE,			0xA4 },
+	{ CS42L42_SLOW_START_ENABLE,		0x70 },
+	{ CS42L42_I2C_DEBOUNCE,			0x88 },
+	{ CS42L42_I2C_STRETCH,			0x03 },
+	{ CS42L42_I2C_TIMEOUT,			0xB7 },
+	{ CS42L42_PWR_CTL1,			0xFF },
+	{ CS42L42_PWR_CTL2,			0x84 },
+	{ CS42L42_PWR_CTL3,			0x20 },
+	{ CS42L42_RSENSE_CTL1,			0x40 },
+	{ CS42L42_RSENSE_CTL2,			0x00 },
+	{ CS42L42_OSC_SWITCH,			0x00 },
+	{ CS42L42_RSENSE_CTL3,			0x1B },
+	{ CS42L42_TSENSE_CTL,			0x1B },
+	{ CS42L42_TSRS_INT_DISABLE,		0x00 },
+	{ CS42L42_HSDET_CTL1,			0x77 },
+	{ CS42L42_HSDET_CTL2,			0x00 },
+	{ CS42L42_HS_SWITCH_CTL,		0xF3 },
+	{ CS42L42_HS_CLAMP_DISABLE,		0x00 },
+	{ CS42L42_MCLK_SRC_SEL,			0x00 },
+	{ CS42L42_SPDIF_CLK_CFG,		0x00 },
+	{ CS42L42_FSYNC_PW_LOWER,		0x00 },
+	{ CS42L42_FSYNC_PW_UPPER,		0x00 },
+	{ CS42L42_FSYNC_P_LOWER,		0xF9 },
+	{ CS42L42_FSYNC_P_UPPER,		0x00 },
+	{ CS42L42_ASP_CLK_CFG,			0x00 },
+	{ CS42L42_ASP_FRM_CFG,			0x10 },
+	{ CS42L42_FS_RATE_EN,			0x00 },
+	{ CS42L42_IN_ASRC_CLK,			0x00 },
+	{ CS42L42_OUT_ASRC_CLK,			0x00 },
+	{ CS42L42_PLL_DIV_CFG1,			0x00 },
+	{ CS42L42_ADC_OVFL_INT_MASK,		0x01 },
+	{ CS42L42_MIXER_INT_MASK,		0x0F },
+	{ CS42L42_SRC_INT_MASK,			0x0F },
+	{ CS42L42_ASP_RX_INT_MASK,		0x1F },
+	{ CS42L42_ASP_TX_INT_MASK,		0x0F },
+	{ CS42L42_CODEC_INT_MASK,		0x03 },
+	{ CS42L42_SRCPL_INT_MASK,		0x7F },
+	{ CS42L42_VPMON_INT_MASK,		0x01 },
+	{ CS42L42_PLL_LOCK_INT_MASK,		0x01 },
+	{ CS42L42_TSRS_PLUG_INT_MASK,		0x0F },
+	{ CS42L42_PLL_CTL1,			0x00 },
+	{ CS42L42_PLL_DIV_FRAC0,		0x00 },
+	{ CS42L42_PLL_DIV_FRAC1,		0x00 },
+	{ CS42L42_PLL_DIV_FRAC2,		0x00 },
+	{ CS42L42_PLL_DIV_INT,			0x40 },
+	{ CS42L42_PLL_CTL3,			0x10 },
+	{ CS42L42_PLL_CAL_RATIO,		0x80 },
+	{ CS42L42_PLL_CTL4,			0x03 },
+	{ CS42L42_LOAD_DET_EN,			0x00 },
+	{ CS42L42_HSBIAS_SC_AUTOCTL,		0x03 },
+	{ CS42L42_WAKE_CTL,			0xC0 },
+	{ CS42L42_ADC_DISABLE_MUTE,		0x00 },
+	{ CS42L42_TIPSENSE_CTL,			0x02 },
+	{ CS42L42_MISC_DET_CTL,			0x03 },
+	{ CS42L42_MIC_DET_CTL1,			0x1F },
+	{ CS42L42_MIC_DET_CTL2,			0x2F },
+	{ CS42L42_DET_INT1_MASK,		0xE0 },
+	{ CS42L42_DET_INT2_MASK,		0xFF },
+	{ CS42L42_HS_BIAS_CTL,			0xC2 },
+	{ CS42L42_ADC_CTL,			0x00 },
+	{ CS42L42_ADC_VOLUME,			0x00 },
+	{ CS42L42_ADC_WNF_HPF_CTL,		0x71 },
+	{ CS42L42_DAC_CTL1,			0x00 },
+	{ CS42L42_DAC_CTL2,			0x02 },
+	{ CS42L42_HP_CTL,			0x0D },
+	{ CS42L42_CLASSH_CTL,			0x07 },
+	{ CS42L42_MIXER_CHA_VOL,		0x3F },
+	{ CS42L42_MIXER_ADC_VOL,		0x3F },
+	{ CS42L42_MIXER_CHB_VOL,		0x3F },
+	{ CS42L42_EQ_COEF_IN0,			0x00 },
+	{ CS42L42_EQ_COEF_IN1,			0x00 },
+	{ CS42L42_EQ_COEF_IN2,			0x00 },
+	{ CS42L42_EQ_COEF_IN3,			0x00 },
+	{ CS42L42_EQ_COEF_RW,			0x00 },
+	{ CS42L42_EQ_COEF_OUT0,			0x00 },
+	{ CS42L42_EQ_COEF_OUT1,			0x00 },
+	{ CS42L42_EQ_COEF_OUT2,			0x00 },
+	{ CS42L42_EQ_COEF_OUT3,			0x00 },
+	{ CS42L42_EQ_INIT_STAT,			0x00 },
+	{ CS42L42_EQ_START_FILT,		0x00 },
+	{ CS42L42_EQ_MUTE_CTL,			0x00 },
+	{ CS42L42_SP_RX_CH_SEL,			0x04 },
+	{ CS42L42_SP_RX_ISOC_CTL,		0x04 },
+	{ CS42L42_SP_RX_FS,			0x8C },
+	{ CS42l42_SPDIF_CH_SEL,			0x0E },
+	{ CS42L42_SP_TX_ISOC_CTL,		0x04 },
+	{ CS42L42_SP_TX_FS,			0xCC },
+	{ CS42L42_SPDIF_SW_CTL1,		0x3F },
+	{ CS42L42_SRC_SDIN_FS,			0x40 },
+	{ CS42L42_SRC_SDOUT_FS,			0x40 },
+	{ CS42L42_SPDIF_CTL1,			0x01 },
+	{ CS42L42_SPDIF_CTL2,			0x00 },
+	{ CS42L42_SPDIF_CTL3,			0x00 },
+	{ CS42L42_SPDIF_CTL4,			0x42 },
+	{ CS42L42_ASP_TX_SZ_EN,			0x00 },
+	{ CS42L42_ASP_TX_CH_EN,			0x00 },
+	{ CS42L42_ASP_TX_CH_AP_RES,		0x0F },
+	{ CS42L42_ASP_TX_CH1_BIT_MSB,		0x00 },
+	{ CS42L42_ASP_TX_CH1_BIT_LSB,		0x00 },
+	{ CS42L42_ASP_TX_HIZ_DLY_CFG,		0x00 },
+	{ CS42L42_ASP_TX_CH2_BIT_MSB,		0x00 },
+	{ CS42L42_ASP_TX_CH2_BIT_LSB,		0x00 },
+	{ CS42L42_ASP_RX_DAI0_EN,		0x00 },
+	{ CS42L42_ASP_RX_DAI0_CH1_AP_RES,	0x03 },
+	{ CS42L42_ASP_RX_DAI0_CH1_BIT_MSB,	0x00 },
+	{ CS42L42_ASP_RX_DAI0_CH1_BIT_LSB,	0x00 },
+	{ CS42L42_ASP_RX_DAI0_CH2_AP_RES,	0x03 },
+	{ CS42L42_ASP_RX_DAI0_CH2_BIT_MSB,	0x00 },
+	{ CS42L42_ASP_RX_DAI0_CH2_BIT_LSB,	0x00 },
+	{ CS42L42_ASP_RX_DAI0_CH3_AP_RES,	0x03 },
+	{ CS42L42_ASP_RX_DAI0_CH3_BIT_MSB,	0x00 },
+	{ CS42L42_ASP_RX_DAI0_CH3_BIT_LSB,	0x00 },
+	{ CS42L42_ASP_RX_DAI0_CH4_AP_RES,	0x03 },
+	{ CS42L42_ASP_RX_DAI0_CH4_BIT_MSB,	0x00 },
+	{ CS42L42_ASP_RX_DAI0_CH4_BIT_LSB,	0x00 },
+	{ CS42L42_ASP_RX_DAI1_CH1_AP_RES,	0x03 },
+	{ CS42L42_ASP_RX_DAI1_CH1_BIT_MSB,	0x00 },
+	{ CS42L42_ASP_RX_DAI1_CH1_BIT_LSB,	0x00 },
+	{ CS42L42_ASP_RX_DAI1_CH2_AP_RES,	0x03 },
+	{ CS42L42_ASP_RX_DAI1_CH2_BIT_MSB,	0x00 },
+	{ CS42L42_ASP_RX_DAI1_CH2_BIT_LSB,	0x00 },
+};
+
+/*
+ * This is all the same as for CS42L42 but we
+ * replace the on-reset register defaults.
+ */
+const struct regmap_config cs42l83_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.readable_reg = cs42l42_readable_register,
+	.volatile_reg = cs42l42_volatile_register,
+
+	.ranges = &cs42l42_page_range,
+	.num_ranges = 1,
+
+	.max_register = CS42L42_MAX_REGISTER,
+	.reg_defaults = cs42l83_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(cs42l83_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+
+	.use_single_read = true,
+	.use_single_write = true,
+};
+
+static int cs42l83_i2c_probe(struct i2c_client *i2c_client)
+{
+	struct device *dev = &i2c_client->dev;
+	struct cs42l42_private *cs42l83;
+	struct regmap *regmap;
+	int ret;
+
+	cs42l83 = devm_kzalloc(dev, sizeof(*cs42l83), GFP_KERNEL);
+	if (!cs42l83)
+		return -ENOMEM;
+
+	regmap = devm_regmap_init_i2c(i2c_client, &cs42l83_regmap);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		dev_err(&i2c_client->dev, "regmap_init() failed: %d\n", ret);
+		return ret;
+	}
+
+	cs42l83->devid = CS42L83_CHIP_ID;
+	cs42l83->dev = dev;
+	cs42l83->regmap = regmap;
+	cs42l83->irq = i2c_client->irq;
+
+	ret = cs42l42_common_probe(cs42l83, &cs42l42_soc_component, &cs42l42_dai);
+	if (ret)
+		return ret;
+
+	ret = cs42l42_init(cs42l83);
+	if (ret)
+		cs42l42_common_remove(cs42l83);
+
+	return ret;
+}
+
+static int cs42l83_i2c_remove(struct i2c_client *i2c_client)
+{
+	struct cs42l42_private *cs42l83 = dev_get_drvdata(&i2c_client->dev);
+
+	cs42l42_common_remove(cs42l83);
+
+	return 0;
+}
+
+static int __maybe_unused cs42l83_i2c_resume(struct device *dev)
+{
+	int ret;
+
+	ret = cs42l42_resume(dev);
+	if (ret)
+		return ret;
+
+	cs42l42_resume_restore(dev);
+
+	return 0;
+}
+
+static const struct dev_pm_ops cs42l83_i2c_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(cs42l42_suspend, cs42l83_i2c_resume)
+};
+
+static const struct of_device_id __maybe_unused cs42l83_of_match[] = {
+	{ .compatible = "cirrus,cs42l83", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, cs42l83_of_match);
+
+static struct i2c_driver cs42l83_i2c_driver = {
+	.driver = {
+		.name = "cs42l83",
+		.pm = &cs42l83_i2c_pm_ops,
+		.of_match_table = of_match_ptr(cs42l83_of_match),
+		},
+	.probe_new = cs42l83_i2c_probe,
+	.remove = cs42l83_i2c_remove,
+};
+
+module_i2c_driver(cs42l83_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC CS42L83 I2C driver");
+MODULE_AUTHOR("Martin Povišer <povik+lin@cutebit.org>");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(SND_SOC_CS42L42_CORE);
-- 
2.33.0

