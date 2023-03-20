Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFDA6C232B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjCTUx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjCTUxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:53:45 -0400
X-Greylist: delayed 1087 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Mar 2023 13:53:36 PDT
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5545A34319
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:53:36 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id 69F2D16C0055;
        Mon, 20 Mar 2023 22:35:29 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YBJ1tyd7JdxF; Mon, 20 Mar 2023 22:35:27 +0200 (EET)
From:   Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1679344527; bh=3K+HfyPQjIbBIoDLQUwDUdraZ5M4IxrG2vAebklpJHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mVDuEfLnU4h7PO9rqdJpGKlDnttj41EDc3enI4A9o6a6GoV/PJOnaMUz5g2HVj/RT
         m52HVBh6yGhfLUgkD4E1j4ryz2+W9pW1fiNLJW1Mmjj5aKOpcFYMSHcl2xahE797x+
         Ri38U5ziZHhGGry+yufasnCQnMwTCYwEugl0+MXM=
To:     Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Marian Postevca <posteuca@mutex.one>
Subject: [PATCH 3/4] ASoC: amd: acp: Add machine driver that enables sound for systems with a ES8336 codec
Date:   Mon, 20 Mar 2023 22:35:18 +0200
Message-Id: <20230320203519.20137-4-posteuca@mutex.one>
In-Reply-To: <20230320203519.20137-1-posteuca@mutex.one>
References: <20230320203519.20137-1-posteuca@mutex.one>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit enables sound for a line of Huawei laptops that use
the ES8336 codec which is connected to the ACP3X module.

Signed-off-by: Marian Postevca <posteuca@mutex.one>
---
 sound/soc/amd/acp-config.c                    |  70 +++
 sound/soc/amd/acp/Makefile                    |   2 +-
 sound/soc/amd/acp/acp-legacy-mach.c           | 105 +++-
 sound/soc/amd/acp/acp-mach-common.c           |   8 +
 sound/soc/amd/acp/acp-mach.h                  |   2 +
 sound/soc/amd/acp/acp-renoir.c                |   4 +
 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c | 471 ++++++++++++++++++
 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.h |  12 +
 8 files changed, 657 insertions(+), 17 deletions(-)
 create mode 100644 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c
 create mode 100644 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.h

diff --git a/sound/soc/amd/acp-config.c b/sound/soc/amd/acp-config.c
index 0932473b6394..76e65c0ad140 100644
--- a/sound/soc/amd/acp-config.c
+++ b/sound/soc/amd/acp-config.c
@@ -47,6 +47,76 @@ static const struct config_entry config_table[] = {
 			{}
 		},
 	},
+	{
+		.flags = FLAG_AMD_LEGACY,
+		.device = ACP_PCI_DEV_ID,
+		.dmi_table = (const struct dmi_system_id []) {
+			{
+				.matches = {
+					DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "HUAWEI"),
+					DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "KLVL-WXXW"),
+					DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "M1010"),
+				},
+			},
+			{}
+		},
+	},
+	{
+		.flags = FLAG_AMD_LEGACY,
+		.device = ACP_PCI_DEV_ID,
+		.dmi_table = (const struct dmi_system_id []) {
+			{
+				.matches = {
+					DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "HUAWEI"),
+					DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "KLVL-WXX9"),
+					DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "M1010"),
+				},
+			},
+			{}
+		},
+	},
+	{
+		.flags = FLAG_AMD_LEGACY,
+		.device = ACP_PCI_DEV_ID,
+		.dmi_table = (const struct dmi_system_id []) {
+			{
+				.matches = {
+					DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "HUAWEI"),
+					DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "BOM-WXX9"),
+					DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "M1010"),
+				},
+			},
+			{}
+		},
+	},
+	{
+		.flags = FLAG_AMD_LEGACY,
+		.device = ACP_PCI_DEV_ID,
+		.dmi_table = (const struct dmi_system_id []) {
+			{
+				.matches = {
+					DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "HUAWEI"),
+					DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "HVY-WXX9"),
+					DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "M1020"),
+				},
+			},
+			{}
+		},
+	},
+	{
+		.flags = FLAG_AMD_LEGACY,
+		.device = ACP_PCI_DEV_ID,
+		.dmi_table = (const struct dmi_system_id []) {
+			{
+				.matches = {
+					DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "HUAWEI"),
+					DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "HVY-WXX9"),
+					DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "M1040"),
+				},
+			},
+			{}
+		},
+	},
 };
 
 int snd_amd_acp_find_config(struct pci_dev *pci)
diff --git a/sound/soc/amd/acp/Makefile b/sound/soc/amd/acp/Makefile
index d9abb0ee5218..1bf64a9289a2 100644
--- a/sound/soc/amd/acp/Makefile
+++ b/sound/soc/amd/acp/Makefile
@@ -16,7 +16,7 @@ snd-acp-rembrandt-objs  := acp-rembrandt.o
 
 #machine specific driver
 snd-acp-mach-objs     := acp-mach-common.o
-snd-acp-legacy-mach-objs     := acp-legacy-mach.o
+snd-acp-legacy-mach-objs     := acp-legacy-mach.o acp3x-es83xx/acp3x-es83xx.o
 snd-acp-sof-mach-objs     := acp-sof-mach.o
 
 obj-$(CONFIG_SND_SOC_AMD_ACP_PCM) += snd-acp-pcm.o
diff --git a/sound/soc/amd/acp/acp-legacy-mach.c b/sound/soc/amd/acp/acp-legacy-mach.c
index 676ad50638d0..8ecda4780d4a 100644
--- a/sound/soc/amd/acp/acp-legacy-mach.c
+++ b/sound/soc/amd/acp/acp-legacy-mach.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 
 #include "acp-mach.h"
+#include "acp3x-es83xx/acp3x-es83xx.h"
 
 static struct acp_card_drvdata rt5682_rt1019_data = {
 	.hs_cpu_id = I2S_SP,
@@ -51,6 +52,14 @@ static struct acp_card_drvdata rt5682s_rt1019_data = {
 	.tdm_mode = false,
 };
 
+static struct acp_card_drvdata es83xx_rn_data = {
+	.hs_cpu_id = I2S_SP,
+	.dmic_cpu_id = DMIC,
+	.hs_codec_id = ES83XX,
+	.dmic_codec_id = DMIC,
+	.platform = RENOIR,
+};
+
 static struct acp_card_drvdata max_nau8825_data = {
 	.hs_cpu_id = I2S_HS,
 	.amp_cpu_id = I2S_HS,
@@ -92,6 +101,33 @@ static const struct snd_soc_dapm_widget acp_widgets[] = {
 	SND_SOC_DAPM_SPK("Right Spk", NULL),
 };
 
+static bool acp_asoc_init_ops(struct acp_card_drvdata *priv)
+{
+	bool has_ops = false;
+
+	if (priv->hs_codec_id == ES83XX) {
+		has_ops = true;
+		acp3x_es83xx_init_ops(&priv->ops);
+	}
+	return has_ops;
+}
+
+static int acp_asoc_suspend_pre(struct snd_soc_card *card)
+{
+	int ret;
+
+	ret = acp_ops_suspend_pre(card);
+	return ret == 1 ? 0 : ret;
+}
+
+static int acp_asoc_resume_post(struct snd_soc_card *card)
+{
+	int ret;
+
+	ret = acp_ops_resume_post(card);
+	return ret == 1 ? 0 : ret;
+}
+
 static int acp_asoc_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = NULL;
@@ -100,38 +136,70 @@ static int acp_asoc_probe(struct platform_device *pdev)
 	struct acp_card_drvdata *acp_card_drvdata;
 	int ret;
 
-	if (!pdev->id_entry)
-		return -EINVAL;
+	if (!pdev->id_entry) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	card = devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
-	if (!card)
-		return -ENOMEM;
+	if (!card) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
+	card->drvdata = (struct acp_card_drvdata *)pdev->id_entry->driver_data;
+	acp_card_drvdata = card->drvdata;
+	acp_card_drvdata->acpi_mach = (struct snd_soc_acpi_mach *)pdev->dev.platform_data;
 	card->dev = dev;
 	card->owner = THIS_MODULE;
 	card->name = pdev->id_entry->name;
-	card->dapm_widgets = acp_widgets;
-	card->num_dapm_widgets = ARRAY_SIZE(acp_widgets);
-	card->controls = acp_controls;
-	card->num_controls = ARRAY_SIZE(acp_controls);
-	card->drvdata = (struct acp_card_drvdata *)pdev->id_entry->driver_data;
 
-	acp_card_drvdata = card->drvdata;
+	acp_asoc_init_ops(card->drvdata);
+
+	ret = acp_ops_configure_widgets(card);
+	if (ret == 1) {
+		card->dapm_widgets = acp_widgets;
+		card->num_dapm_widgets = ARRAY_SIZE(acp_widgets);
+		card->controls = acp_controls;
+		card->num_controls = ARRAY_SIZE(acp_controls);
+	} else if (ret < 0) {
+		dev_err(&pdev->dev,
+			"Cannot configure widgets for card (%s): %d\n",
+			card->name, ret);
+		goto out;
+	}
+	card->suspend_pre = acp_asoc_suspend_pre;
+	card->resume_post = acp_asoc_resume_post;
+
+	ret = acp_ops_probe(card);
+	if (ret < 0) {
+		dev_err(&pdev->dev,
+			"Cannot probe card (%s): %d\n",
+			card->name, ret);
+		goto out;
+	}
+
 	dmi_id = dmi_first_match(acp_quirk_table);
 	if (dmi_id && dmi_id->driver_data)
 		acp_card_drvdata->tdm_mode = dmi_id->driver_data;
 
-	acp_legacy_dai_links_create(card);
+	ret = acp_legacy_dai_links_create(card);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Cannot create dai links for card (%s): %d\n",
+			card->name, ret);
+		goto out;
+	}
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
 		dev_err(&pdev->dev,
-				"devm_snd_soc_register_card(%s) failed: %d\n",
-				card->name, ret);
-		return ret;
+			"devm_snd_soc_register_card(%s) failed: %d\n",
+			card->name, ret);
+		goto out;
 	}
-
-	return 0;
+out:
+	return ret;
 }
 
 static const struct platform_device_id board_ids[] = {
@@ -147,6 +215,10 @@ static const struct platform_device_id board_ids[] = {
 		.name = "acp3xalc5682s1019",
 		.driver_data = (kernel_ulong_t)&rt5682s_rt1019_data,
 	},
+	{
+		.name = "acp3x-es83xx",
+		.driver_data = (kernel_ulong_t)&es83xx_rn_data,
+	},
 	{
 		.name = "rmb-nau8825-max",
 		.driver_data = (kernel_ulong_t)&max_nau8825_data,
@@ -173,6 +245,7 @@ MODULE_DESCRIPTION("ACP chrome audio support");
 MODULE_ALIAS("platform:acp3xalc56821019");
 MODULE_ALIAS("platform:acp3xalc5682sm98360");
 MODULE_ALIAS("platform:acp3xalc5682s1019");
+MODULE_ALIAS("platform:acp3x-es83xx");
 MODULE_ALIAS("platform:rmb-nau8825-max");
 MODULE_ALIAS("platform:rmb-rt5682s-rt1019");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index b4dcce4fbae9..16dfebfbb4b6 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -1053,6 +1053,7 @@ int acp_legacy_dai_links_create(struct snd_soc_card *card)
 	struct device *dev = card->dev;
 	struct acp_card_drvdata *drv_data = card->drvdata;
 	int i = 0, num_links = 0;
+	int rc;
 
 	if (drv_data->hs_cpu_id)
 		num_links++;
@@ -1091,6 +1092,13 @@ int acp_legacy_dai_links_create(struct snd_soc_card *card)
 			links[i].init = acp_card_rt5682s_init;
 			links[i].ops = &acp_card_rt5682s_ops;
 		}
+		if (drv_data->hs_codec_id == ES83XX) {
+			rc = acp_ops_configure_link(card, &links[i]);
+			if (rc != 0) {
+				dev_err(dev, "Failed to configure link for ES83XX: %d\n", rc);
+				return rc;
+			}
+		}
 		i++;
 	}
 
diff --git a/sound/soc/amd/acp/acp-mach.h b/sound/soc/amd/acp/acp-mach.h
index 2cade68e6cc3..bb93c8b2dbfa 100644
--- a/sound/soc/amd/acp/acp-mach.h
+++ b/sound/soc/amd/acp/acp-mach.h
@@ -45,6 +45,7 @@ enum codec_endpoints {
 	MAX98360A,
 	RT5682S,
 	NAU8825,
+	ES83XX,
 };
 
 enum platform_end_point {
@@ -72,6 +73,7 @@ struct acp_card_drvdata {
 	struct clk *wclk;
 	struct clk *bclk;
 	struct acp_mach_ops ops;
+	struct snd_soc_acpi_mach *acpi_mach;
 	void *mach_priv;
 	bool soc_mclk;
 	bool tdm_mode;
diff --git a/sound/soc/amd/acp/acp-renoir.c b/sound/soc/amd/acp/acp-renoir.c
index 2a89a0d2e601..1f04e08e15d4 100644
--- a/sound/soc/amd/acp/acp-renoir.c
+++ b/sound/soc/amd/acp/acp-renoir.c
@@ -83,6 +83,10 @@ static struct snd_soc_acpi_mach snd_soc_acpi_amd_acp_machines[] = {
 		.id = "AMDI1019",
 		.drv_name = "renoir-acp",
 	},
+	{
+		.id = "ESSX8336",
+		.drv_name = "acp3x-es83xx",
+	},
 	{},
 };
 
diff --git a/sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c b/sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c
new file mode 100644
index 000000000000..138a7c12669b
--- /dev/null
+++ b/sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c
@@ -0,0 +1,471 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Machine driver for AMD ACP Audio engine using ES8336 codec.
+//
+// Copyright 2023 Marian Postevca <posteuca@mutex.one>
+
+#include <sound/core.h>
+#include <sound/soc.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc-dapm.h>
+#include <sound/jack.h>
+#include <sound/soc-acpi.h>
+#include <linux/clk.h>
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/io.h>
+#include <linux/acpi.h>
+#include <linux/dmi.h>
+#include "../acp-mach.h"
+
+#define get_mach_priv(card) ((struct acp3x_es83xx_private *)((acp_get_drvdata(card))->mach_priv))
+
+/* mclk-div-by-2 + terminating entry */
+#define MAX_NO_PROPS 2
+
+#define DUAL_CHANNEL	2
+
+#define ES83XX_ENABLE_DMIC	BIT(4)
+#define ES83XX_48_MHZ_MCLK	BIT(5)
+
+struct acp3x_es83xx_private {
+	unsigned long quirk;
+	struct snd_soc_component *codec;
+	struct device *codec_dev;
+	struct gpio_desc *gpio_speakers, *gpio_headphone;
+	struct acpi_gpio_params enable_spk_gpio, enable_hp_gpio;
+	struct acpi_gpio_mapping gpio_mapping[3];
+	struct snd_soc_dapm_route mic_map[2];
+};
+
+static const unsigned int rates[] = {
+	8000, 11025, 16000, 22050, 32000,
+	44100, 48000, 64000, 88200, 96000,
+};
+
+static const unsigned int rates_48mhz_mclk[] = {
+	48000, 96000,
+};
+
+static const unsigned int channels[] = {
+	DUAL_CHANNEL,
+};
+
+static const struct snd_pcm_hw_constraint_list hw_constraint_rates_normal = {
+	.count = ARRAY_SIZE(rates),
+	.list = rates,
+	.mask = 0,
+};
+
+static const struct snd_pcm_hw_constraint_list hw_constraint_rates_48mhz = {
+	.count = ARRAY_SIZE(rates_48mhz_mclk),
+	.list = rates_48mhz_mclk,
+	.mask = 0,
+};
+
+static const struct snd_pcm_hw_constraint_list constraints_channels = {
+	.count = ARRAY_SIZE(channels),
+	.list = channels,
+	.mask = 0,
+};
+
+#define ES83xx_12288_KHZ_MCLK_FREQ   (48000 * 256)
+#define ES83xx_48_MHZ_MCLK_FREQ      (48000 * 1000)
+
+static int acp3x_es83xx_speaker_power_event(struct snd_soc_dapm_widget *w,
+					    struct snd_kcontrol *kcontrol, int event);
+
+static void acp3x_es83xx_set_gpios_values(struct acp3x_es83xx_private *priv,
+					  bool speaker, bool headphone)
+{
+	gpiod_set_value_cansleep(priv->gpio_speakers, speaker);
+	gpiod_set_value_cansleep(priv->gpio_headphone, headphone);
+}
+
+static int acp3x_es83xx_create_swnode(struct device *codec_dev)
+{
+	struct property_entry props[MAX_NO_PROPS] = {};
+	struct fwnode_handle *fwnode;
+	int ret;
+
+	props[0] = PROPERTY_ENTRY_BOOL("everest,mclk-div-by-2");
+
+	fwnode = fwnode_create_software_node(props, NULL);
+	if (IS_ERR(fwnode))
+		return PTR_ERR(fwnode);
+
+	ret = device_add_software_node(codec_dev, to_software_node(fwnode));
+
+	fwnode_handle_put(fwnode);
+	return ret;
+}
+
+static int acp3x_es83xx_codec_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai *codec_dai;
+	struct acp3x_es83xx_private *priv;
+	unsigned int freq;
+	int ret;
+
+	runtime = substream->runtime;
+	rtd = asoc_substream_to_rtd(substream);
+	codec_dai = asoc_rtd_to_codec(rtd, 0);
+	priv = get_mach_priv(rtd->card);
+
+	if (priv->quirk & ES83XX_48_MHZ_MCLK) {
+		dev_dbg(priv->codec_dev, "using a 48Mhz MCLK\n");
+		snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+					   &hw_constraint_rates_48mhz);
+		freq = ES83xx_48_MHZ_MCLK_FREQ;
+	} else {
+		dev_dbg(priv->codec_dev, "using a 12.288Mhz MCLK\n");
+		snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+					   &hw_constraint_rates_normal);
+		freq = ES83xx_12288_KHZ_MCLK_FREQ;
+	}
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, freq, SND_SOC_CLOCK_OUT);
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set codec sysclk: %d\n", ret);
+		return ret;
+	}
+
+	ret =  snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+				   | SND_SOC_DAIFMT_CBP_CFP);
+	if (ret < 0) {
+		dev_err(rtd->dev, "failed to set DAI fmt: %d\n", ret);
+		return ret;
+	}
+
+	runtime->hw.channels_max = DUAL_CHANNEL;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				   &constraints_channels);
+	runtime->hw.formats = SNDRV_PCM_FMTBIT_S32_LE;
+
+	return 0;
+}
+
+static struct snd_soc_jack es83xx_jack;
+
+static struct snd_soc_jack_pin es83xx_jack_pins[] = {
+	{
+		.pin	= "Headphone",
+		.mask	= SND_JACK_HEADPHONE,
+	},
+	{
+		.pin	= "Headset Mic",
+		.mask	= SND_JACK_MICROPHONE,
+	},
+};
+
+static const struct snd_soc_dapm_widget acp3x_es83xx_widgets[] = {
+	SND_SOC_DAPM_SPK("Speaker", NULL),
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Internal Mic", NULL),
+
+	SND_SOC_DAPM_SUPPLY("Speaker Power", SND_SOC_NOPM, 0, 0,
+			    acp3x_es83xx_speaker_power_event,
+			    SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
+};
+
+static const struct snd_soc_dapm_route acp3x_es83xx_audio_map[] = {
+	{"Headphone", NULL, "HPOL"},
+	{"Headphone", NULL, "HPOR"},
+
+	/*
+	 * There is no separate speaker output instead the speakers are muxed to
+	 * the HP outputs. The mux is controlled Speaker and/or headphone switch.
+	 */
+	{"Speaker", NULL, "HPOL"},
+	{"Speaker", NULL, "HPOR"},
+	{"Speaker", NULL, "Speaker Power"},
+};
+
+
+static const struct snd_kcontrol_new acp3x_es83xx_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Speaker"),
+	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Internal Mic"),
+};
+
+static int acp3x_es83xx_configure_widgets(struct snd_soc_card *card)
+{
+	card->dapm_widgets = acp3x_es83xx_widgets;
+	card->num_dapm_widgets = ARRAY_SIZE(acp3x_es83xx_widgets);
+	card->controls = acp3x_es83xx_controls;
+	card->num_controls = ARRAY_SIZE(acp3x_es83xx_controls);
+	card->dapm_routes = acp3x_es83xx_audio_map;
+	card->num_dapm_routes = ARRAY_SIZE(acp3x_es83xx_audio_map);
+
+	return 0;
+}
+
+static int acp3x_es83xx_speaker_power_event(struct snd_soc_dapm_widget *w,
+					    struct snd_kcontrol *kcontrol, int event)
+{
+	struct acp3x_es83xx_private *priv = get_mach_priv(w->dapm->card);
+
+	dev_dbg(priv->codec_dev, "speaker power event: %d\n", event);
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		acp3x_es83xx_set_gpios_values(priv, 1, 0);
+	else
+		acp3x_es83xx_set_gpios_values(priv, 0, 1);
+
+	return 0;
+}
+
+static int acp3x_es83xx_suspend_pre(struct snd_soc_card *card)
+{
+	struct acp3x_es83xx_private *priv = get_mach_priv(card);
+
+	dev_dbg(priv->codec_dev, "card suspend\n");
+	snd_soc_component_set_jack(priv->codec, NULL, NULL);
+	return 0;
+}
+
+static int acp3x_es83xx_resume_post(struct snd_soc_card *card)
+{
+	struct acp3x_es83xx_private *priv = get_mach_priv(card);
+
+	dev_dbg(priv->codec_dev, "card resume\n");
+	snd_soc_component_set_jack(priv->codec, &es83xx_jack, NULL);
+	return 0;
+}
+
+static int acp3x_es83xx_configure_gpios(struct acp3x_es83xx_private *priv)
+{
+	int ret = 0;
+
+	priv->enable_spk_gpio.crs_entry_index = 0;
+	priv->enable_hp_gpio.crs_entry_index = 1;
+
+	priv->enable_spk_gpio.active_low = false;
+	priv->enable_hp_gpio.active_low = false;
+
+	priv->gpio_mapping[0].name = "speakers-enable-gpios";
+	priv->gpio_mapping[0].data = &priv->enable_spk_gpio;
+	priv->gpio_mapping[0].size = 1;
+	priv->gpio_mapping[0].quirks = ACPI_GPIO_QUIRK_ONLY_GPIOIO;
+
+	priv->gpio_mapping[1].name = "headphone-enable-gpios";
+	priv->gpio_mapping[1].data = &priv->enable_hp_gpio;
+	priv->gpio_mapping[1].size = 1;
+	priv->gpio_mapping[1].quirks = ACPI_GPIO_QUIRK_ONLY_GPIOIO;
+
+	dev_info(priv->codec_dev, "speaker gpio %d active %s, headphone gpio %d active %s\n",
+		 priv->enable_spk_gpio.crs_entry_index,
+		 priv->enable_spk_gpio.active_low ? "low" : "high",
+		 priv->enable_hp_gpio.crs_entry_index,
+		 priv->enable_hp_gpio.active_low ? "low" : "high");
+	return ret;
+}
+
+static int acp3x_es83xx_configure_mics(struct acp3x_es83xx_private *priv)
+{
+	int num_routes = 0;
+	int i;
+
+	if (!(priv->quirk & ES83XX_ENABLE_DMIC)) {
+		priv->mic_map[num_routes].sink = "MIC1";
+		priv->mic_map[num_routes].source = "Internal Mic";
+		num_routes++;
+	}
+
+	priv->mic_map[num_routes].sink = "MIC2";
+	priv->mic_map[num_routes].source = "Headset Mic";
+	num_routes++;
+
+	for (i = 0; i < num_routes; i++)
+		dev_info(priv->codec_dev, "%s is %s\n",
+			 priv->mic_map[i].source, priv->mic_map[i].sink);
+
+	return num_routes;
+}
+
+static int acp3x_es83xx_init(struct snd_soc_pcm_runtime *runtime)
+{
+	struct snd_soc_component *codec = asoc_rtd_to_codec(runtime, 0)->component;
+	struct snd_soc_card *card = runtime->card;
+	struct acp3x_es83xx_private *priv = get_mach_priv(card);
+	int ret = 0;
+	int num_routes;
+
+	ret = snd_soc_card_jack_new_pins(card, "Headset",
+					 SND_JACK_HEADSET | SND_JACK_BTN_0,
+					 &es83xx_jack, es83xx_jack_pins,
+					 ARRAY_SIZE(es83xx_jack_pins));
+	if (ret) {
+		dev_err(card->dev, "jack creation failed %d\n", ret);
+		return ret;
+	}
+
+	snd_jack_set_key(es83xx_jack.jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
+
+	snd_soc_component_set_jack(codec, &es83xx_jack, NULL);
+
+	priv->codec = codec;
+	acp3x_es83xx_configure_gpios(priv);
+
+	ret = devm_acpi_dev_add_driver_gpios(priv->codec_dev, priv->gpio_mapping);
+	if (ret)
+		dev_warn(priv->codec_dev, "failed to add speaker gpio\n");
+
+	priv->gpio_speakers = gpiod_get_optional(priv->codec_dev, "speakers-enable",
+				priv->enable_spk_gpio.active_low ? GPIOD_OUT_LOW : GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->gpio_speakers)) {
+		dev_err(priv->codec_dev, "could not get speakers-enable GPIO\n");
+		return PTR_ERR(priv->gpio_speakers);
+	}
+
+	priv->gpio_headphone = gpiod_get_optional(priv->codec_dev, "headphone-enable",
+				priv->enable_hp_gpio.active_low ? GPIOD_OUT_LOW : GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->gpio_headphone)) {
+		dev_err(priv->codec_dev, "could not get headphone-enable GPIO\n");
+		return PTR_ERR(priv->gpio_headphone);
+	}
+
+	if (priv->quirk & ES83XX_48_MHZ_MCLK) {
+		ret = acp3x_es83xx_create_swnode(priv->codec_dev);
+		if (ret != 0) {
+			dev_err(priv->codec_dev,
+				"could not create software node inside codec: %d\n", ret);
+			return ret;
+		}
+	}
+
+	num_routes = acp3x_es83xx_configure_mics(priv);
+	if (num_routes > 0) {
+		ret = snd_soc_dapm_add_routes(&card->dapm, priv->mic_map, num_routes);
+		if (ret != 0)
+			device_remove_software_node(priv->codec_dev);
+	}
+
+	return ret;
+}
+
+static const struct snd_soc_ops acp3x_es83xx_ops = {
+	.startup = acp3x_es83xx_codec_startup,
+};
+
+
+SND_SOC_DAILINK_DEF(codec,
+		    DAILINK_COMP_ARRAY(COMP_CODEC("i2c-ESSX8336:00", "ES8316 HiFi")));
+
+static const struct dmi_system_id acp3x_es83xx_dmi_table[] = {
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "HUAWEI"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "KLVL-WXXW"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "M1010"),
+		},
+		.driver_data = (void *)(ES83XX_ENABLE_DMIC),
+	},
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "HUAWEI"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "KLVL-WXX9"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "M1010"),
+		},
+		.driver_data = (void *)(ES83XX_ENABLE_DMIC),
+	},
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "HUAWEI"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "BOM-WXX9"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "M1010"),
+		},
+		.driver_data = (void *)(ES83XX_ENABLE_DMIC|ES83XX_48_MHZ_MCLK),
+	},
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "HUAWEI"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "HVY-WXX9"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "M1020"),
+		},
+		.driver_data = (void *)(ES83XX_ENABLE_DMIC),
+	},
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "HUAWEI"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "HVY-WXX9"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "M1040"),
+		},
+		.driver_data = (void *)(ES83XX_ENABLE_DMIC),
+	},
+	{}
+};
+
+static int acp3x_es83xx_configure_link(struct snd_soc_card *card, struct snd_soc_dai_link *link)
+{
+	link->codecs = codec;
+	link->num_codecs = ARRAY_SIZE(codec);
+	link->init = acp3x_es83xx_init;
+	link->ops = &acp3x_es83xx_ops;
+
+	return 0;
+}
+
+static int acp3x_es83xx_probe(struct snd_soc_card *card)
+{
+	int ret = 0;
+	struct device *dev = card->dev;
+	const struct dmi_system_id *dmi_id;
+
+	dmi_id = dmi_first_match(acp3x_es83xx_dmi_table);
+	if (dmi_id && dmi_id->driver_data) {
+		struct acp3x_es83xx_private *priv;
+		struct acp_card_drvdata *acp_drvdata;
+		struct acpi_device *adev;
+		struct device *codec_dev;
+
+		acp_drvdata = (struct acp_card_drvdata *)card->drvdata;
+
+		dev_info(dev, "matched DMI table with this system, trying to register sound card\n");
+
+		adev = acpi_dev_get_first_match_dev(acp_drvdata->acpi_mach->id, NULL, -1);
+		if (!adev) {
+			dev_err(dev, "Error cannot find '%s' dev\n", acp_drvdata->acpi_mach->id);
+			return -ENXIO;
+		}
+
+		codec_dev = acpi_get_first_physical_node(adev);
+		acpi_dev_put(adev);
+		if (!codec_dev) {
+			dev_warn(dev, "Error cannot find codec device, will defer probe\n");
+			return -EPROBE_DEFER;
+		}
+
+		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+		if (!priv) {
+			put_device(codec_dev);
+			return -ENOMEM;
+		}
+
+		priv->codec_dev = codec_dev;
+		priv->quirk = (unsigned long)dmi_id->driver_data;
+		acp_drvdata->mach_priv = priv;
+		dev_info(dev, "successfully probed the sound card\n");
+	} else {
+		ret = -ENODEV;
+		dev_warn(dev, "this system has a ES83xx codec defined in ACPI, but the driver doesn't have this system registered in DMI table\n");
+	}
+	return ret;
+}
+
+
+void acp3x_es83xx_init_ops(struct acp_mach_ops *ops)
+{
+	ops->probe = acp3x_es83xx_probe;
+	ops->configure_widgets = acp3x_es83xx_configure_widgets;
+	ops->configure_link = acp3x_es83xx_configure_link;
+	ops->suspend_pre = acp3x_es83xx_suspend_pre;
+	ops->resume_post = acp3x_es83xx_resume_post;
+}
diff --git a/sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.h b/sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.h
new file mode 100644
index 000000000000..03551ffdd9da
--- /dev/null
+++ b/sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2023 Marian Postevca <posteuca@mutex.one>
+ */
+
+#ifndef __ACP3X_ES83XX_H
+#define __ACP3X_ES83XX_H
+
+void acp3x_es83xx_init_ops(struct acp_mach_ops *ops);
+
+#endif
+
-- 
2.39.1

