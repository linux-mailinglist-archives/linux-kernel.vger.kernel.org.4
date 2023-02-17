Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EC769A9EB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjBQLLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjBQLKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:10:37 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A346744B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:09:55 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 132F366021CA;
        Fri, 17 Feb 2023 11:09:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676632176;
        bh=V1DmDXBuEU2N+OWQ6l6wu98aHxvRRwoLqb+Y0J5Zxg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iPjG/6+rnzqDx7/fqJEnD/LNQBclM54RsSYkLH/KY/8U2KN8wOSpYAxRWNDQyhSD/
         DI0VrybksNpNJLj2/TB8wGCk2grkJl862MgPorDabo+YW+ma5bCa/GEaZyRj9+YmYq
         XzFUaMMM/gzs170K5pD9bl+ThLSbfJDH1dYYMd41BebGMYtZFxur4c3wJgt+qMIg7u
         HUa/YzY1swpk6SC8v32WiOYAlilJx4MUgZcgn2ZcuFbI37CR4y8hkJHBPr9Lk/yplX
         JchrM0/yTnn1zxqQB24BiR4R8mIoGHw7LFb/yWh8+XEjZDvQ8BccVMmi0Wso3AIkPk
         RlUatD2OscfdQ==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Lucas Tanure <lucas.tanure@collabora.com>, kernel@collabora.com
Subject: [PATCH v2 7/9] ASoC: amd: vangogh: Move nau8821 and CPU side code up for future platform
Date:   Fri, 17 Feb 2023 11:08:48 +0000
Message-Id: <20230217110850.1045250-8-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230217110850.1045250-1-lucas.tanure@collabora.com>
References: <20230217110850.1045250-1-lucas.tanure@collabora.com>
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

Move nau8821 and CPU side code up in the source so future platforms can
be added.

Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
---
 sound/soc/amd/vangogh/acp5x-mach.c | 97 +++++++++++++++---------------
 1 file changed, 50 insertions(+), 47 deletions(-)

diff --git a/sound/soc/amd/vangogh/acp5x-mach.c b/sound/soc/amd/vangogh/acp5x-mach.c
index c746605b63a1..153ce9e84a23 100644
--- a/sound/soc/amd/vangogh/acp5x-mach.c
+++ b/sound/soc/amd/vangogh/acp5x-mach.c
@@ -30,6 +30,11 @@
 static unsigned long acp5x_machine_id;
 static struct snd_soc_jack vg_headset;
 
+SND_SOC_DAILINK_DEF(platform,  DAILINK_COMP_ARRAY(COMP_PLATFORM("acp5x_i2s_dma.0")));
+SND_SOC_DAILINK_DEF(acp5x_i2s, DAILINK_COMP_ARRAY(COMP_CPU("acp5x_i2s_playcap.0")));
+SND_SOC_DAILINK_DEF(acp5x_bt,  DAILINK_COMP_ARRAY(COMP_CPU("acp5x_i2s_playcap.1")));
+SND_SOC_DAILINK_DEF(nau8821,   DAILINK_COMP_ARRAY(COMP_CODEC("i2c-NVTN2020:00", "nau8821-hifi")));
+
 static struct snd_soc_jack_pin acp5x_nau8821_jack_pins[] = {
 	{
 		.pin	= "Headphone",
@@ -41,6 +46,44 @@ static struct snd_soc_jack_pin acp5x_nau8821_jack_pins[] = {
 	},
 };
 
+static const struct snd_kcontrol_new acp5x_8821_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Int Mic"),
+};
+
+static int platform_clock_control(struct snd_soc_dapm_widget *w,
+				  struct snd_kcontrol *k, int event)
+{
+	struct snd_soc_dapm_context *dapm = w->dapm;
+	struct snd_soc_card *card = dapm->card;
+	struct snd_soc_dai *dai;
+	int ret = 0;
+
+	dai = snd_soc_card_get_codec_dai(card, ACP5X_NUVOTON_CODEC_DAI);
+	if (!dai) {
+		dev_err(card->dev, "Codec dai not found\n");
+		return -EIO;
+	}
+
+	if (SND_SOC_DAPM_EVENT_OFF(event)) {
+		ret = snd_soc_dai_set_sysclk(dai, NAU8821_CLK_INTERNAL, 0, SND_SOC_CLOCK_IN);
+		if (ret < 0) {
+			dev_err(card->dev, "set sysclk err = %d\n", ret);
+			return -EIO;
+		}
+	} else {
+		ret = snd_soc_dai_set_sysclk(dai, NAU8821_CLK_FLL_BLK, 0, SND_SOC_CLOCK_IN);
+		if (ret < 0)
+			dev_err(dai->dev, "can't set BLK clock %d\n", ret);
+		ret = snd_soc_dai_set_pll(dai, 0, 0, ACP5X_NUVOTON_BCLK, ACP5X_NAU8821_FREQ_OUT);
+		if (ret < 0)
+			dev_err(dai->dev, "can't set FLL: %d\n", ret);
+	}
+
+	return ret;
+}
+
 static int acp5x_8821_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_component *component = asoc_rtd_to_codec(rtd, 0)->component;
@@ -138,6 +181,11 @@ static int acp5x_nau8821_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
+static const struct snd_soc_ops acp5x_8821_ops = {
+	.startup = acp5x_8821_startup,
+	.hw_params = acp5x_nau8821_hw_params,
+};
+
 static int acp5x_cs35l41_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
@@ -192,11 +240,6 @@ static int acp5x_cs35l41_hw_params(struct snd_pcm_substream *substream,
 
 }
 
-static const struct snd_soc_ops acp5x_8821_ops = {
-	.startup = acp5x_8821_startup,
-	.hw_params = acp5x_nau8821_hw_params,
-};
-
 static const struct snd_soc_ops acp5x_cs35l41_play_ops = {
 	.startup = acp5x_cs35l41_startup,
 	.hw_params = acp5x_cs35l41_hw_params,
@@ -213,12 +256,8 @@ static struct snd_soc_codec_conf cs35l41_conf[] = {
 	},
 };
 
-SND_SOC_DAILINK_DEF(platform,  DAILINK_COMP_ARRAY(COMP_PLATFORM("acp5x_i2s_dma.0")));
-SND_SOC_DAILINK_DEF(acp5x_i2s, DAILINK_COMP_ARRAY(COMP_CPU("acp5x_i2s_playcap.0")));
-SND_SOC_DAILINK_DEF(acp5x_bt,  DAILINK_COMP_ARRAY(COMP_CPU("acp5x_i2s_playcap.1")));
-SND_SOC_DAILINK_DEF(nau8821,   DAILINK_COMP_ARRAY(COMP_CODEC("i2c-NVTN2020:00", "nau8821-hifi")));
-SND_SOC_DAILINK_DEF(cs35l41,   DAILINK_COMP_ARRAY(COMP_CODEC("spi-VLV1776:00", "cs35l41-pcm"),
-						  COMP_CODEC("spi-VLV1776:01", "cs35l41-pcm")));
+SND_SOC_DAILINK_DEF(cs35l41, DAILINK_COMP_ARRAY(COMP_CODEC("spi-VLV1776:00", "cs35l41-pcm"),
+						COMP_CODEC("spi-VLV1776:01", "cs35l41-pcm")));
 
 static struct snd_soc_dai_link acp5x_dai[] = {
 	{
@@ -246,43 +285,7 @@ static struct snd_soc_dai_link acp5x_dai[] = {
 	},
 };
 
-static int platform_clock_control(struct snd_soc_dapm_widget *w,
-				  struct snd_kcontrol *k, int event)
-{
-	struct snd_soc_dapm_context *dapm = w->dapm;
-	struct snd_soc_card *card = dapm->card;
-	struct snd_soc_dai *dai;
-	int ret = 0;
-
-	dai = snd_soc_card_get_codec_dai(card, ACP5X_NUVOTON_CODEC_DAI);
-	if (!dai) {
-		dev_err(card->dev, "Codec dai not found\n");
-		return -EIO;
-	}
-
-	if (SND_SOC_DAPM_EVENT_OFF(event)) {
-		ret = snd_soc_dai_set_sysclk(dai, NAU8821_CLK_INTERNAL, 0, SND_SOC_CLOCK_IN);
-		if (ret < 0) {
-			dev_err(card->dev, "set sysclk err = %d\n", ret);
-			return -EIO;
-		}
-	} else {
-		ret = snd_soc_dai_set_sysclk(dai, NAU8821_CLK_FLL_BLK, 0, SND_SOC_CLOCK_IN);
-		if (ret < 0)
-			dev_err(dai->dev, "can't set BLK clock %d\n", ret);
-		ret = snd_soc_dai_set_pll(dai, 0, 0, ACP5X_NUVOTON_BCLK, ACP5X_NAU8821_FREQ_OUT);
-		if (ret < 0)
-			dev_err(dai->dev, "can't set FLL: %d\n", ret);
-	}
-
-	return ret;
-}
 
-static const struct snd_kcontrol_new acp5x_8821_controls[] = {
-	SOC_DAPM_PIN_SWITCH("Headphone"),
-	SOC_DAPM_PIN_SWITCH("Headset Mic"),
-	SOC_DAPM_PIN_SWITCH("Int Mic"),
-};
 
 static const struct snd_soc_dapm_widget acp5x_8821_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
-- 
2.39.2

