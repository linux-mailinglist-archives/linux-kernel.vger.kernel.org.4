Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C19569A9EE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjBQLLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjBQLKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:10:38 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17D05B75B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:09:58 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 54E9466021CE;
        Fri, 17 Feb 2023 11:09:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676632176;
        bh=Kwd+z51GyilBatKyRaOXykYfGSgdgInb9P6BCS/XdpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lqfdgdTtxMe5XOJK3Nb4Uk62NI0c4UfJKrHh5cksS6ihBGWdEX/sv0t9PCkTu9MYe
         W/Kx1unge/kkub0VpnCyWfWHXU/ecQ7U3q56GSc5WT7tvDOjSdoMhOfL2jUnQMdhss
         5n9UNzv9ppea5DNZEoo5esAdIOPeqqdJ2SvR2jPxK7gJ+87KCkuEoPgZF5gUcRuAMr
         fWFFNT1lxR/cYtyISwEcgtS8GPMbfTh7Aa7x532XANRmUc0OgslyQcG5CIFsY7Z1Gs
         yBEXPyQ2+4f/Gns9wXZ3LD8pDnkaefsXx21kMcW54HIwTp8onyYh1veX15T4nJrdZG
         WzUYrp7c6M2CA==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Lucas Tanure <lucas.tanure@collabora.com>, kernel@collabora.com
Subject: [PATCH v2 8/9] ASoC: amd: vangogh: Centralize strings definition
Date:   Fri, 17 Feb 2023 11:08:49 +0000
Message-Id: <20230217110850.1045250-9-lucas.tanure@collabora.com>
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

Replace occurrences of strings by their definition, avoiding
bugs where the string changed, but not all places have been modified.
While at it rename defines to use NAU8821 codec name instead of NUVOTON
and align with the other defines.

Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
---
 sound/soc/amd/vangogh/acp5x-mach.c | 31 ++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/sound/soc/amd/vangogh/acp5x-mach.c b/sound/soc/amd/vangogh/acp5x-mach.c
index 153ce9e84a23..367570e5c60f 100644
--- a/sound/soc/amd/vangogh/acp5x-mach.c
+++ b/sound/soc/amd/vangogh/acp5x-mach.c
@@ -22,10 +22,14 @@
 
 #define DRV_NAME			"acp5x_mach"
 #define DUAL_CHANNEL			2
-#define ACP5X_NUVOTON_CODEC_DAI		"nau8821-hifi"
 #define VG_JUPITER			1
-#define ACP5X_NUVOTON_BCLK		3072000
+#define ACP5X_NAU8821_BCLK		3072000
 #define ACP5X_NAU8821_FREQ_OUT		12288000
+#define ACP5X_NAU8821_COMP_NAME 	"i2c-NVTN2020:00"
+#define ACP5X_NAU8821_DAI_NAME		"nau8821-hifi"
+#define ACP5X_CS35L41_COMP_LNAME	"spi-VLV1776:00"
+#define ACP5X_CS35L41_COMP_RNAME	"spi-VLV1776:01"
+#define ACP5X_CS35L41_DAI_NAME		"cs35l41-pcm"
 
 static unsigned long acp5x_machine_id;
 static struct snd_soc_jack vg_headset;
@@ -33,7 +37,8 @@ static struct snd_soc_jack vg_headset;
 SND_SOC_DAILINK_DEF(platform,  DAILINK_COMP_ARRAY(COMP_PLATFORM("acp5x_i2s_dma.0")));
 SND_SOC_DAILINK_DEF(acp5x_i2s, DAILINK_COMP_ARRAY(COMP_CPU("acp5x_i2s_playcap.0")));
 SND_SOC_DAILINK_DEF(acp5x_bt,  DAILINK_COMP_ARRAY(COMP_CPU("acp5x_i2s_playcap.1")));
-SND_SOC_DAILINK_DEF(nau8821,   DAILINK_COMP_ARRAY(COMP_CODEC("i2c-NVTN2020:00", "nau8821-hifi")));
+SND_SOC_DAILINK_DEF(nau8821,   DAILINK_COMP_ARRAY(COMP_CODEC(ACP5X_NAU8821_COMP_NAME,
+							     ACP5X_NAU8821_DAI_NAME)));
 
 static struct snd_soc_jack_pin acp5x_nau8821_jack_pins[] = {
 	{
@@ -60,7 +65,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 	struct snd_soc_dai *dai;
 	int ret = 0;
 
-	dai = snd_soc_card_get_codec_dai(card, ACP5X_NUVOTON_CODEC_DAI);
+	dai = snd_soc_card_get_codec_dai(card, ACP5X_NAU8821_DAI_NAME);
 	if (!dai) {
 		dev_err(card->dev, "Codec dai not found\n");
 		return -EIO;
@@ -76,7 +81,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 		ret = snd_soc_dai_set_sysclk(dai, NAU8821_CLK_FLL_BLK, 0, SND_SOC_CLOCK_IN);
 		if (ret < 0)
 			dev_err(dai->dev, "can't set BLK clock %d\n", ret);
-		ret = snd_soc_dai_set_pll(dai, 0, 0, ACP5X_NUVOTON_BCLK, ACP5X_NAU8821_FREQ_OUT);
+		ret = snd_soc_dai_set_pll(dai, 0, 0, ACP5X_NAU8821_BCLK, ACP5X_NAU8821_FREQ_OUT);
 		if (ret < 0)
 			dev_err(dai->dev, "can't set FLL: %d\n", ret);
 	}
@@ -161,7 +166,7 @@ static int acp5x_nau8821_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_card *card = rtd->card;
-	struct snd_soc_dai *dai = snd_soc_card_get_codec_dai(card, ACP5X_NUVOTON_CODEC_DAI);
+	struct snd_soc_dai *dai = snd_soc_card_get_codec_dai(card, ACP5X_NAU8821_DAI_NAME);
 	int ret, bclk;
 
 	ret = snd_soc_dai_set_sysclk(dai, NAU8821_CLK_FLL_BLK, 0, SND_SOC_CLOCK_IN);
@@ -221,8 +226,8 @@ static int acp5x_cs35l41_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	for_each_rtd_components(rtd, i, comp) {
-		if (!(strcmp(comp->name, "spi-VLV1776:00")) ||
-		    !(strcmp(comp->name, "spi-VLV1776:01"))) {
+		if (!(strcmp(comp->name, ACP5X_CS35L41_COMP_LNAME)) ||
+		    !(strcmp(comp->name, ACP5X_CS35L41_COMP_RNAME))) {
 			if (!bclk) {
 				dev_err(comp->dev, "Invalid sample rate: 0x%x\n", rate);
 				return -EINVAL;
@@ -247,17 +252,19 @@ static const struct snd_soc_ops acp5x_cs35l41_play_ops = {
 
 static struct snd_soc_codec_conf cs35l41_conf[] = {
 	{
-		.dlc = COMP_CODEC_CONF("spi-VLV1776:00"),
+		.dlc = COMP_CODEC_CONF(ACP5X_CS35L41_COMP_LNAME),
 		.name_prefix = "Left",
 	},
 	{
-		.dlc = COMP_CODEC_CONF("spi-VLV1776:01"),
+		.dlc = COMP_CODEC_CONF(ACP5X_CS35L41_COMP_RNAME),
 		.name_prefix = "Right",
 	},
 };
 
-SND_SOC_DAILINK_DEF(cs35l41, DAILINK_COMP_ARRAY(COMP_CODEC("spi-VLV1776:00", "cs35l41-pcm"),
-						COMP_CODEC("spi-VLV1776:01", "cs35l41-pcm")));
+SND_SOC_DAILINK_DEF(cs35l41, DAILINK_COMP_ARRAY(COMP_CODEC(ACP5X_CS35L41_COMP_LNAME,
+							   ACP5X_CS35L41_DAI_NAME),
+						COMP_CODEC(ACP5X_CS35L41_COMP_RNAME,
+							   ACP5X_CS35L41_DAI_NAME)));
 
 static struct snd_soc_dai_link acp5x_dai[] = {
 	{
-- 
2.39.2

