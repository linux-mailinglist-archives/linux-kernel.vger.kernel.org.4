Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C77969A9EA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjBQLLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjBQLKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:10:36 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E406744D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:09:53 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 80BE266021C5;
        Fri, 17 Feb 2023 11:09:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676632175;
        bh=j0T197P1YELVItgZWtEGBCaEB/XtoykOAuZbhiemsIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q3x8mb05DCpL7U9Co6mIqtV0E1aJzClgwueGgeknBCroY+WPnkHgYxyyUMg6gV2NR
         ZTYt2Bfe3IHuNQNUpwuzYW+B1ghPxsGNYsRjIxIFLXUdv2AyQ8kNIfzuUghtUUdjyS
         p/1zRi2HZpyfFKJOR4UbP+PdcrakJRR8iAUam26Vj/FTLM9xT0TDKHe1MqkqdVzJ8S
         UShTnSWTilgXmtsTIW8gRffZUyEFyp2d/KV/BmpIFrPJ4LMBG8h7FzeornzMbDLDgF
         IMyKaOSC2fjWZhxWhvMgcbvh7NElDUWoS3qMiYGOV+nuzNRhCdBj+Nbn7RPIu/p2Ka
         H8oHOO9c5BBPA==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Lucas Tanure <lucas.tanure@collabora.com>, kernel@collabora.com
Subject: [PATCH v2 5/9] ASoC: amd: vangogh: use for_each_rtd_components instead of for
Date:   Fri, 17 Feb 2023 11:08:46 +0000
Message-Id: <20230217110850.1045250-6-lucas.tanure@collabora.com>
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

To iterate over components use for_each_rtd_components
And compare to component name, so asoc_rtd_to_codec and the dai code can
be removed

Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
---
 sound/soc/amd/vangogh/acp5x-mach.c | 42 ++++++++++++++++--------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/sound/soc/amd/vangogh/acp5x-mach.c b/sound/soc/amd/vangogh/acp5x-mach.c
index a1cd52e58574..e7183d8ac3a2 100644
--- a/sound/soc/amd/vangogh/acp5x-mach.c
+++ b/sound/soc/amd/vangogh/acp5x-mach.c
@@ -153,35 +153,37 @@ static int acp5x_cs35l41_hw_params(struct snd_pcm_substream *substream,
 				   struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
-	unsigned int num_codecs = rtd->dai_link->num_codecs;
-	struct snd_soc_card *card = rtd->card;
-	struct snd_soc_dai *dai;
-	unsigned int bclk_val;
+	unsigned int bclk, rate = params_rate(params);
+	struct snd_soc_component *comp;
 	int ret, i;
 
-	ret = 0;
-	for (i = 0; i < num_codecs; i++) {
-		dai = asoc_rtd_to_codec(rtd, i);
-		if (strcmp(dai->name, "cs35l41-pcm") == 0) {
-			switch (params_rate(params)) {
-			case 48000:
-				bclk_val = 1536000;
-				break;
-			default:
-				dev_err(card->dev, "Invalid Samplerate:0x%x\n",
-					params_rate(params));
+	switch (rate) {
+	case 48000:
+		bclk = 1536000;
+		break;
+	default:
+		bclk = 0;
+		break;
+	}
+
+	for_each_rtd_components(rtd, i, comp) {
+		if (!(strcmp(comp->name, "spi-VLV1776:00")) ||
+		    !(strcmp(comp->name, "spi-VLV1776:01"))) {
+			if (!bclk) {
+				dev_err(comp->dev, "Invalid sample rate: 0x%x\n", rate);
 				return -EINVAL;
 			}
-			ret = snd_soc_component_set_sysclk(dai->component, 0, 0,
-							   bclk_val, SND_SOC_CLOCK_IN);
-			if (ret < 0) {
-				dev_err(card->dev, "failed to set sysclk for CS35l41 dai\n");
+
+			ret = snd_soc_component_set_sysclk(comp, 0, 0, bclk, SND_SOC_CLOCK_IN);
+			if (ret) {
+				dev_err(comp->dev, "failed to set SYSCLK: %d\n", ret);
 				return ret;
 			}
 		}
 	}
 
-	return ret;
+	return 0;
+
 }
 
 static const struct snd_soc_ops acp5x_8821_ops = {
-- 
2.39.2

