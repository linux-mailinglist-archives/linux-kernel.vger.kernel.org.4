Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529F95B3A1F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbiIINzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiIINyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:54:53 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E261D2983B;
        Fri,  9 Sep 2022 06:54:46 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1662731680; bh=1J3C3+t0s4a1N6T4iHaixOcDU1xaMFwinugzdJ01JrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=h7b7Fs9WIl3MrNvp44Ve9HI1AjxtgC6ijA4Ec+IB9m61/75uUmNa6lZM7aL+NXM6N
         CAnzc6LSxPxYv3qwo9K7+Kv8VPiem6LSErI6WlmcDY63rQAzBYBiyU/A/oKLoiwMPL
         BKM0z63GmD8cgP0o/mOWQ6LAMsjNlvklirp0OsTw=
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
Subject: [PATCH 07/10] ASoC: cs42l42: Split I2C identity into separate module
Date:   Fri,  9 Sep 2022 15:53:31 +0200
Message-Id: <20220909135334.98220-8-povik+lin@cutebit.org>
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

From: Richard Fitzgerald <rf@opensource.cirrus.com>

Split the I2C bus driver definition and probe()/remove() into a
separate module so that a Soundwire build of CS42L42 support does
not have a spurious dependency on I2C.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/codecs/Kconfig       |   8 ++-
 sound/soc/codecs/Makefile      |   4 +-
 sound/soc/codecs/cs42l42-i2c.c | 111 +++++++++++++++++++++++++++++++
 sound/soc/codecs/cs42l42.c     | 115 ++++++---------------------------
 sound/soc/codecs/cs42l42.h     |  15 +++++
 5 files changed, 156 insertions(+), 97 deletions(-)
 create mode 100644 sound/soc/codecs/cs42l42-i2c.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index c7d83fe999e9..01725d0a9500 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -692,9 +692,15 @@ config SND_SOC_CS35L45_I2C
 	  Enable support for Cirrus Logic CS35L45 smart speaker amplifier
 	  with I2C control.
 
+config SND_SOC_CS42L42_CORE
+	tristate
+
 config SND_SOC_CS42L42
-	tristate "Cirrus Logic CS42L42 CODEC"
+	tristate "Cirrus Logic CS42L42 CODEC (I2C)"
 	depends on I2C
+	select REGMAP
+	select REGMAP_I2C
+	select SND_SOC_CS42L42_CORE
 
 config SND_SOC_CS42L51
 	tristate
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 16a01635dd04..5b7020a0b234 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -65,6 +65,7 @@ snd-soc-cs35l45-objs := cs35l45.o
 snd-soc-cs35l45-spi-objs := cs35l45-spi.o
 snd-soc-cs35l45-i2c-objs := cs35l45-i2c.o
 snd-soc-cs42l42-objs := cs42l42.o
+snd-soc-cs42l42-i2c-objs := cs42l42-i2c.o
 snd-soc-cs42l51-objs := cs42l51.o
 snd-soc-cs42l51-i2c-objs := cs42l51-i2c.o
 snd-soc-cs42l52-objs := cs42l52.o
@@ -422,7 +423,8 @@ obj-$(CONFIG_SND_SOC_CS35L45_TABLES)	+= snd-soc-cs35l45-tables.o
 obj-$(CONFIG_SND_SOC_CS35L45)	+= snd-soc-cs35l45.o
 obj-$(CONFIG_SND_SOC_CS35L45_SPI)	+= snd-soc-cs35l45-spi.o
 obj-$(CONFIG_SND_SOC_CS35L45_I2C)	+= snd-soc-cs35l45-i2c.o
-obj-$(CONFIG_SND_SOC_CS42L42)	+= snd-soc-cs42l42.o
+obj-$(CONFIG_SND_SOC_CS42L42_CORE)	+= snd-soc-cs42l42.o
+obj-$(CONFIG_SND_SOC_CS42L42)	+= snd-soc-cs42l42-i2c.o
 obj-$(CONFIG_SND_SOC_CS42L51)	+= snd-soc-cs42l51.o
 obj-$(CONFIG_SND_SOC_CS42L51_I2C)	+= snd-soc-cs42l51-i2c.o
 obj-$(CONFIG_SND_SOC_CS42L52)	+= snd-soc-cs42l52.o
diff --git a/sound/soc/codecs/cs42l42-i2c.c b/sound/soc/codecs/cs42l42-i2c.c
new file mode 100644
index 000000000000..e6999f44d0f5
--- /dev/null
+++ b/sound/soc/codecs/cs42l42-i2c.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * cs42l42-i2c.c -- CS42L42 ALSA SoC audio driver for I2C
+ *
+ * Copyright 2016, 2022 Cirrus Logic, Inc.
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
+static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
+{
+	struct device *dev = &i2c_client->dev;
+	struct cs42l42_private *cs42l42;
+	struct regmap *regmap;
+	int ret;
+
+	cs42l42 = devm_kzalloc(dev, sizeof(*cs42l42), GFP_KERNEL);
+	if (!cs42l42)
+		return -ENOMEM;
+
+	regmap = devm_regmap_init_i2c(i2c_client, &cs42l42_regmap);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		dev_err(&i2c_client->dev, "regmap_init() failed: %d\n", ret);
+		return ret;
+	}
+
+	cs42l42->dev = dev;
+	cs42l42->regmap = regmap;
+	cs42l42->irq = i2c_client->irq;
+
+	ret = cs42l42_common_probe(cs42l42, &cs42l42_soc_component, &cs42l42_dai);
+	if (ret)
+		return ret;
+
+	ret = cs42l42_init(cs42l42);
+	if (ret)
+		cs42l42_common_remove(cs42l42);
+
+	return ret;
+}
+
+static int cs42l42_i2c_remove(struct i2c_client *i2c_client)
+{
+	struct cs42l42_private *cs42l42 = dev_get_drvdata(&i2c_client->dev);
+
+	cs42l42_common_remove(cs42l42);
+
+	return 0;
+}
+
+static int __maybe_unused cs42l42_i2c_resume(struct device *dev)
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
+static const struct dev_pm_ops cs42l42_i2c_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(cs42l42_suspend, cs42l42_i2c_resume)
+};
+
+static const struct of_device_id __maybe_unused cs42l42_of_match[] = {
+	{ .compatible = "cirrus,cs42l42", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, cs42l42_of_match);
+
+static const struct acpi_device_id __maybe_unused cs42l42_acpi_match[] = {
+	{"10134242", 0,},
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, cs42l42_acpi_match);
+
+static const struct i2c_device_id cs42l42_id[] = {
+	{"cs42l42", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, cs42l42_id);
+
+static struct i2c_driver cs42l42_i2c_driver = {
+	.driver = {
+		.name = "cs42l42",
+		.pm = &cs42l42_i2c_pm_ops,
+		.of_match_table = of_match_ptr(cs42l42_of_match),
+		.acpi_match_table = ACPI_PTR(cs42l42_acpi_match),
+		},
+	.id_table = cs42l42_id,
+	.probe_new = cs42l42_i2c_probe,
+	.remove = cs42l42_i2c_remove,
+};
+
+module_i2c_driver(cs42l42_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC CS42L42 I2C driver");
+MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(SND_SOC_CS42L42_CORE);
diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index bffe0347bec0..a22d84db356c 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -15,7 +15,6 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-#include <linux/i2c.h>
 #include <linux/gpio.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -375,7 +374,7 @@ static const struct regmap_range_cfg cs42l42_page_range = {
 	.window_len = 256,
 };
 
-static const struct regmap_config cs42l42_regmap = {
+const struct regmap_config cs42l42_regmap = {
 	.reg_bits = 8,
 	.val_bits = 8,
 
@@ -393,6 +392,7 @@ static const struct regmap_config cs42l42_regmap = {
 	.use_single_read = true,
 	.use_single_write = true,
 };
+EXPORT_SYMBOL_NS_GPL(cs42l42_regmap, SND_SOC_CS42L42_CORE);
 
 static DECLARE_TLV_DB_SCALE(adc_tlv, -9700, 100, true);
 static DECLARE_TLV_DB_SCALE(mixer_tlv, -6300, 100, true);
@@ -579,7 +579,7 @@ static int cs42l42_set_jack(struct snd_soc_component *component, struct snd_soc_
 	return 0;
 }
 
-static const struct snd_soc_component_driver cs42l42_soc_component = {
+const struct snd_soc_component_driver cs42l42_soc_component = {
 	.set_jack		= cs42l42_set_jack,
 	.dapm_widgets		= cs42l42_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(cs42l42_dapm_widgets),
@@ -590,6 +590,7 @@ static const struct snd_soc_component_driver cs42l42_soc_component = {
 	.idle_bias_on		= 1,
 	.endianness		= 1,
 };
+EXPORT_SYMBOL_NS_GPL(cs42l42_soc_component, SND_SOC_CS42L42_CORE);
 
 /* Switch to SCLK. Atomic delay after the write to allow the switch to complete. */
 static const struct reg_sequence cs42l42_to_sclk_seq[] = {
@@ -1086,7 +1087,7 @@ static const struct snd_soc_dai_ops cs42l42_ops = {
 	.mute_stream	= cs42l42_mute_stream,
 };
 
-static struct snd_soc_dai_driver cs42l42_dai = {
+struct snd_soc_dai_driver cs42l42_dai = {
 		.name = "cs42l42",
 		.playback = {
 			.stream_name = "Playback",
@@ -1106,6 +1107,7 @@ static struct snd_soc_dai_driver cs42l42_dai = {
 		.symmetric_sample_bits = 1,
 		.ops = &cs42l42_ops,
 };
+EXPORT_SYMBOL_NS_GPL(cs42l42_dai, SND_SOC_CS42L42_CORE);
 
 static void cs42l42_manual_hs_type_detect(struct cs42l42_private *cs42l42)
 {
@@ -2100,7 +2102,7 @@ static const struct reg_sequence __maybe_unused cs42l42_shutdown_seq[] = {
 	REG_SEQ0(CS42L42_PWR_CTL1,		0xFF)
 };
 
-static int __maybe_unused cs42l42_suspend(struct device *dev)
+int cs42l42_suspend(struct device *dev)
 {
 	struct cs42l42_private *cs42l42 = dev_get_drvdata(dev);
 	unsigned int reg;
@@ -2160,8 +2162,9 @@ static int __maybe_unused cs42l42_suspend(struct device *dev)
 	return 0;
 
 }
+EXPORT_SYMBOL_NS_GPL(cs42l42_suspend, SND_SOC_CS42L42_CORE);
 
-static int __maybe_unused cs42l42_resume(struct device *dev)
+int cs42l42_resume(struct device *dev)
 {
 	struct cs42l42_private *cs42l42 = dev_get_drvdata(dev);
 	int ret;
@@ -2187,8 +2190,9 @@ static int __maybe_unused cs42l42_resume(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(cs42l42_resume, SND_SOC_CS42L42_CORE);
 
-static void __maybe_unused cs42l42_resume_restore(struct device *dev)
+void cs42l42_resume_restore(struct device *dev)
 {
 	struct cs42l42_private *cs42l42 = dev_get_drvdata(dev);
 
@@ -2205,6 +2209,7 @@ static void __maybe_unused cs42l42_resume_restore(struct device *dev)
 
 	dev_dbg(dev, "System resumed\n");
 }
+EXPORT_SYMBOL_NS_GPL(cs42l42_resume_restore, SND_SOC_CS42L42_CORE);
 
 static int __maybe_unused cs42l42_i2c_resume(struct device *dev)
 {
@@ -2219,9 +2224,9 @@ static int __maybe_unused cs42l42_i2c_resume(struct device *dev)
 	return 0;
 }
 
-static int cs42l42_common_probe(struct cs42l42_private *cs42l42,
-				const struct snd_soc_component_driver *component_drv,
-				struct snd_soc_dai_driver *dai)
+int cs42l42_common_probe(struct cs42l42_private *cs42l42,
+			 const struct snd_soc_component_driver *component_drv,
+			 struct snd_soc_dai_driver *dai)
 {
 	int ret, i;
 
@@ -2296,8 +2301,9 @@ static int cs42l42_common_probe(struct cs42l42_private *cs42l42,
 
 	return ret;
 }
+EXPORT_SYMBOL_NS_GPL(cs42l42_common_probe, SND_SOC_CS42L42_CORE);
 
-static int cs42l42_init(struct cs42l42_private *cs42l42)
+int cs42l42_init(struct cs42l42_private *cs42l42)
 {
 	unsigned int reg;
 	int devid, ret;
@@ -2373,8 +2379,9 @@ static int cs42l42_init(struct cs42l42_private *cs42l42)
 				cs42l42->supplies);
 	return ret;
 }
+EXPORT_SYMBOL_NS_GPL(cs42l42_init, SND_SOC_CS42L42_CORE);
 
-static void cs42l42_common_remove(struct cs42l42_private *cs42l42)
+void cs42l42_common_remove(struct cs42l42_private *cs42l42)
 {
 	if (cs42l42->irq)
 		free_irq(cs42l42->irq, cs42l42);
@@ -2392,89 +2399,7 @@ static void cs42l42_common_remove(struct cs42l42_private *cs42l42)
 	gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
 	regulator_bulk_disable(ARRAY_SIZE(cs42l42->supplies), cs42l42->supplies);
 }
-
-static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
-{
-	struct device *dev = &i2c_client->dev;
-	struct cs42l42_private *cs42l42;
-	struct regmap *regmap;
-	int ret;
-
-	cs42l42 = devm_kzalloc(dev, sizeof(struct cs42l42_private), GFP_KERNEL);
-	if (!cs42l42)
-		return -ENOMEM;
-
-	regmap = devm_regmap_init_i2c(i2c_client, &cs42l42_regmap);
-	if (IS_ERR(regmap)) {
-		ret = PTR_ERR(regmap);
-		dev_err(&i2c_client->dev, "regmap_init() failed: %d\n", ret);
-		return ret;
-	}
-
-	cs42l42->dev = dev;
-	cs42l42->regmap = regmap;
-	cs42l42->irq = i2c_client->irq;
-
-	ret = cs42l42_common_probe(cs42l42, &cs42l42_soc_component, &cs42l42_dai);
-	if (ret)
-		return ret;
-
-	ret = cs42l42_init(cs42l42);
-	if (ret)
-		cs42l42_common_remove(cs42l42);
-
-	return ret;
-}
-
-static int cs42l42_i2c_remove(struct i2c_client *i2c_client)
-{
-	struct cs42l42_private *cs42l42 = dev_get_drvdata(&i2c_client->dev);
-
-	cs42l42_common_remove(cs42l42);
-
-	return 0;
-}
-
-static const struct dev_pm_ops cs42l42_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(cs42l42_suspend, cs42l42_i2c_resume)
-};
-
-#ifdef CONFIG_OF
-static const struct of_device_id cs42l42_of_match[] = {
-	{ .compatible = "cirrus,cs42l42", },
-	{}
-};
-MODULE_DEVICE_TABLE(of, cs42l42_of_match);
-#endif
-
-#ifdef CONFIG_ACPI
-static const struct acpi_device_id cs42l42_acpi_match[] = {
-	{"10134242", 0,},
-	{}
-};
-MODULE_DEVICE_TABLE(acpi, cs42l42_acpi_match);
-#endif
-
-static const struct i2c_device_id cs42l42_id[] = {
-	{"cs42l42", 0},
-	{}
-};
-
-MODULE_DEVICE_TABLE(i2c, cs42l42_id);
-
-static struct i2c_driver cs42l42_i2c_driver = {
-	.driver = {
-		.name = "cs42l42",
-		.pm = &cs42l42_pm_ops,
-		.of_match_table = of_match_ptr(cs42l42_of_match),
-		.acpi_match_table = ACPI_PTR(cs42l42_acpi_match),
-		},
-	.id_table = cs42l42_id,
-	.probe_new = cs42l42_i2c_probe,
-	.remove = cs42l42_i2c_remove,
-};
-
-module_i2c_driver(cs42l42_i2c_driver);
+EXPORT_SYMBOL_NS_GPL(cs42l42_common_remove, SND_SOC_CS42L42_CORE);
 
 MODULE_DESCRIPTION("ASoC CS42L42 driver");
 MODULE_AUTHOR("James Schulman, Cirrus Logic Inc, <james.schulman@cirrus.com>");
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index a8e0d5b414a5..2a9f178f6190 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -20,6 +20,8 @@
 #include <linux/regulator/consumer.h>
 #include <sound/jack.h>
 #include <sound/cs42l42.h>
+#include <sound/soc-component.h>
+#include <sound/soc-dai.h>
 
 struct  cs42l42_private {
 	struct regmap *regmap;
@@ -50,4 +52,17 @@ struct  cs42l42_private {
 	bool init_done;
 };
 
+extern const struct regmap_config cs42l42_regmap;
+extern const struct snd_soc_component_driver cs42l42_soc_component;
+extern struct snd_soc_dai_driver cs42l42_dai;
+
+int cs42l42_suspend(struct device *dev);
+int cs42l42_resume(struct device *dev);
+void cs42l42_resume_restore(struct device *dev);
+int cs42l42_common_probe(struct cs42l42_private *cs42l42,
+			 const struct snd_soc_component_driver *component_drv,
+			 struct snd_soc_dai_driver *dai);
+int cs42l42_init(struct cs42l42_private *cs42l42);
+void cs42l42_common_remove(struct cs42l42_private *cs42l42);
+
 #endif /* __CS42L42_H__ */
-- 
2.33.0

