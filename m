Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99B2748546
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjGENoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjGENn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:43:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4820171B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 06:43:55 -0700 (PDT)
Received: from localhost (unknown [188.24.137.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9BE1B6606FB9;
        Wed,  5 Jul 2023 14:43:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688564634;
        bh=RDOqL2QvBsWdGDtjLILdg3uwJMqeZ/zmgqZTS73BrJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R9+hXXfoQBhv2BkO+lcoUezRvdGuWvPh2dbcGjdiUWAMbQPVeqJwnAqnbekAXIlsR
         6yzZVNYDX0U+bebjeEmbrL/imbi57wYBrbKbJoQM9syAQMeqr4sRW9LwiwBk4qMpjw
         +lgaaq6iKNBnL//EygYNxObX2Z/i+KxPk0R05yP+0ZZCoDw0DLJeZTXmcw2hK56+tW
         3xqyG0wUtWFEafTvk5bFZwnypQCz72y+7/CiXEjqw6L4N+QDhXDlPHVDA27kRnC+aw
         z96Ik8w3KnlzUWAjdQmrz7wRcam7smUIs85hwYlGUghJ5XU5ZmCR6iU0Sj+UWuuQgB
         Em761I+1rgGyQ==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v2 3/3] ASoC: amd: vangogh: Add support for NAU8821/MAX98388 variant
Date:   Wed,  5 Jul 2023 16:43:41 +0300
Message-ID: <20230705134341.175889-4-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705134341.175889-1-cristian.ciocaltea@collabora.com>
References: <20230705134341.175889-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the Vangogh machine driver to support a variant based on the
Nuvoton NAU88L21 Codec and the Analog Devices MAX98388 Speaker
Amplifier.

Additionally, enable probing via ACPI match table for this and future
hardware revisions.

Co-developed-by: Lucas Tanure <lucas.tanure@collabora.com>
Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/amd/Kconfig              |   5 +-
 sound/soc/amd/vangogh/acp5x-mach.c | 155 +++++++++++++++++++++++++++--
 2 files changed, 150 insertions(+), 10 deletions(-)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 1dd8579e8034..273688c05317 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -79,14 +79,15 @@ config SND_SOC_AMD_ACP5x
 	 ACP DMA driver, CPU DAI driver.
 
 config SND_SOC_AMD_VANGOGH_MACH
-	tristate "AMD Vangogh support for NAU8821 CS35L41"
+	tristate "AMD Vangogh support for NAU8821/CS35L41/MAX98388"
 	select SND_SOC_NAU8821
 	select SND_SOC_CS35L41_SPI
+	select SND_SOC_MAX98388
 	select SND_AMD_ACP_CONFIG
 	depends on SND_SOC_AMD_ACP5x && I2C && SPI_MASTER
 	help
 	  This option enables machine driver for Vangogh platform
-	  using NAU8821 and CS35L41 codecs.
+	  using NAU8821 and either CS35L41 or MAX98388 codecs.
 	  Say m if you have such a device.
 	  If unsure select "N".
 
diff --git a/sound/soc/amd/vangogh/acp5x-mach.c b/sound/soc/amd/vangogh/acp5x-mach.c
index 1efa8f8b77ab..42e37f4f1495 100644
--- a/sound/soc/amd/vangogh/acp5x-mach.c
+++ b/sound/soc/amd/vangogh/acp5x-mach.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Machine driver for AMD Vangogh platform using NAU8821 & CS35L41
- * codecs.
+ * Machine driver for AMD Vangogh platform using either
+ * NAU8821 & CS35L41 or NAU8821 & MAX98388 codecs.
  *
  * Copyright 2021 Advanced Micro Devices, Inc.
  */
@@ -29,6 +29,9 @@
 #define ACP5X_CS35L41_COMP_LNAME	"spi-VLV1776:00"
 #define ACP5X_CS35L41_COMP_RNAME	"spi-VLV1776:01"
 #define ACP5X_CS35L41_DAI_NAME		"cs35l41-pcm"
+#define ACP5X_MAX98388_COMP_LNAME	"i2c-ADS8388:00"
+#define ACP5X_MAX98388_COMP_RNAME	"i2c-ADS8388:01"
+#define ACP5X_MAX98388_DAI_NAME		"max98388-aif1"
 
 static struct snd_soc_jack vg_headset;
 
@@ -326,6 +329,126 @@ static struct snd_soc_card acp5x_8821_35l41_card = {
 	.num_controls = ARRAY_SIZE(acp5x_8821_controls),
 };
 
+static int acp5x_max98388_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct acp5x_platform_info *machine = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	machine->play_i2s_instance = I2S_HS_INSTANCE;
+
+	runtime->hw.channels_max = DUAL_CHANNEL;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				   &constraints_channels);
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				   &constraints_rates);
+	return 0;
+}
+
+static int acp5x_max98388_hw_params(struct snd_pcm_substream *substream,
+				    struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_dai *dai = snd_soc_card_get_codec_dai(rtd->card,
+							     ACP5X_MAX98388_DAI_NAME);
+	int ret;
+
+	ret = snd_soc_dai_set_fmt(dai,
+				  SND_SOC_DAIFMT_CBS_CFS | SND_SOC_DAIFMT_I2S |
+				  SND_SOC_DAIFMT_NB_NF);
+	if (ret < 0)
+		dev_err(dai->dev, "Failed to set format: %d\n", ret);
+
+	return ret;
+}
+
+static const struct snd_soc_ops acp5x_max98388_play_ops = {
+	.startup = acp5x_max98388_startup,
+	.hw_params = acp5x_max98388_hw_params,
+};
+
+static struct snd_soc_codec_conf acp5x_max98388_conf[] = {
+	{
+		.dlc = COMP_CODEC_CONF(ACP5X_MAX98388_COMP_LNAME),
+		.name_prefix = "Left",
+	},
+	{
+		.dlc = COMP_CODEC_CONF(ACP5X_MAX98388_COMP_RNAME),
+		.name_prefix = "Right",
+	},
+};
+
+SND_SOC_DAILINK_DEF(max98388, DAILINK_COMP_ARRAY(COMP_CODEC(ACP5X_MAX98388_COMP_LNAME,
+							    ACP5X_MAX98388_DAI_NAME),
+						 COMP_CODEC(ACP5X_MAX98388_COMP_RNAME,
+							    ACP5X_MAX98388_DAI_NAME)));
+
+static struct snd_soc_dai_link acp5x_8821_98388_dai[] = {
+	{
+		.name = "acp5x-8821-play",
+		.stream_name = "Playback/Capture",
+		.dai_fmt = SND_SOC_DAIFMT_I2S |
+			   SND_SOC_DAIFMT_NB_NF |
+			   SND_SOC_DAIFMT_CBC_CFC,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ops = &acp5x_8821_ops,
+		.init = acp5x_8821_init,
+		SND_SOC_DAILINK_REG(acp5x_i2s, nau8821, platform),
+	},
+	{
+		.name = "acp5x-max98388-play",
+		.stream_name = "MAX98388 Playback",
+		.dai_fmt = SND_SOC_DAIFMT_I2S |
+			   SND_SOC_DAIFMT_NB_NF |
+			   SND_SOC_DAIFMT_CBC_CFC,
+		.dpcm_playback = 1,
+		.playback_only = 1,
+		.ops = &acp5x_max98388_play_ops,
+		SND_SOC_DAILINK_REG(acp5x_bt, max98388, platform),
+	},
+};
+
+static const struct snd_soc_dapm_widget acp5x_8821_98388_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Int Mic", NULL),
+	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
+			    platform_clock_control,
+			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SPK("SPK", NULL),
+};
+
+static const struct snd_soc_dapm_route acp5x_8821_98388_route[] = {
+	{ "Headphone", NULL, "HPOL" },
+	{ "Headphone", NULL, "HPOR" },
+	{ "MICL", NULL, "Headset Mic" },
+	{ "MICR", NULL, "Headset Mic" },
+	{ "DMIC", NULL, "Int Mic" },
+
+	{ "Headphone", NULL, "Platform Clock" },
+	{ "Headset Mic", NULL, "Platform Clock" },
+	{ "Int Mic", NULL, "Platform Clock" },
+
+	{ "SPK", NULL, "Left BE_OUT" },
+	{ "SPK", NULL, "Right BE_OUT" },
+};
+
+static struct snd_soc_card acp5x_8821_98388_card = {
+	.name = "acp5x-max98388",
+	.owner = THIS_MODULE,
+	.dai_link = acp5x_8821_98388_dai,
+	.num_links = ARRAY_SIZE(acp5x_8821_98388_dai),
+	.dapm_widgets = acp5x_8821_98388_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(acp5x_8821_98388_widgets),
+	.dapm_routes = acp5x_8821_98388_route,
+	.num_dapm_routes = ARRAY_SIZE(acp5x_8821_98388_route),
+	.codec_conf = acp5x_max98388_conf,
+	.num_configs = ARRAY_SIZE(acp5x_max98388_conf),
+	.controls = acp5x_8821_controls,
+	.num_controls = ARRAY_SIZE(acp5x_8821_controls),
+};
+
 static const struct dmi_system_id acp5x_vg_quirk_table[] = {
 	{
 		.matches = {
@@ -344,11 +467,20 @@ static int acp5x_probe(struct platform_device *pdev)
 	struct snd_soc_card *card;
 	int ret;
 
-	dmi_id = dmi_first_match(acp5x_vg_quirk_table);
-	if (!dmi_id)
-		return -ENODEV;
-
-	card = &acp5x_8821_35l41_card;
+	card = (struct snd_soc_card *)device_get_match_data(dev);
+	if (!card) {
+		/*
+		 * This is normally the result of directly probing the driver
+		 * in pci-acp5x through platform_device_register_full(), which
+		 * is necessary for the CS35L41 variant, as it doesn't support
+		 * ACPI probing and relies on DMI quirks.
+		 */
+		dmi_id = dmi_first_match(acp5x_vg_quirk_table);
+		if (!dmi_id)
+			return -ENODEV;
+
+		card = &acp5x_8821_35l41_card;
+	}
 
 	machine = devm_kzalloc(dev, sizeof(*machine), GFP_KERNEL);
 	if (!machine)
@@ -365,10 +497,17 @@ static int acp5x_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct acpi_device_id acp5x_acpi_match[] = {
+	{ "AMDI8821", (kernel_ulong_t)&acp5x_8821_98388_card },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, acp5x_acpi_match);
+
 static struct platform_driver acp5x_mach_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.pm = &snd_soc_pm_ops,
+		.acpi_match_table = acp5x_acpi_match,
 	},
 	.probe = acp5x_probe,
 };
@@ -376,6 +515,6 @@ static struct platform_driver acp5x_mach_driver = {
 module_platform_driver(acp5x_mach_driver);
 
 MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
-MODULE_DESCRIPTION("NAU8821 & CS35L41 audio support");
+MODULE_DESCRIPTION("NAU8821/CS35L41 & NAU8821/MAX98388 audio support");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.41.0

