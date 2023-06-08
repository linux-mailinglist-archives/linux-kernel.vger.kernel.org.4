Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C82727A63
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbjFHIsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235565AbjFHIrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:47:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82D52D43
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 01:47:41 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9D7766606F19;
        Thu,  8 Jun 2023 09:47:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686214060;
        bh=GnnvLVruG/Y33qFCquYPrGvofADRKh+faHOxi3VmkPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K3FR3YDRoNDC3LYRTZPIk5Rn0nu9jgsm8EPFVdYkLRCBkIRuQVlLT9BdgMshZzk9D
         2S8qEh6Y/Wl0WGnCL51l/+Vl0bg1d64uivRaGNfXfpmFY+OqFtYV9hfUg+XJiZ7xVV
         LQt1KyKn/DLUA9gRc5j+Rv5OXwIfmUftXMLZxkRYnBzWvZXFxB5Ek1BwzJhHhtJK66
         OwOpZYksqB7grpu1ZNzENrQNmTDGNrgs7Q9mbyVQFalxRnPhlhYuGGUpGmAI9xn10J
         gYb9Q42zm03N+gmDaJyOJjPOkFBF/BDgUdnD77G1mc/3nPXa5pv4guep0tu3gjgzfg
         ZGZ/uzDnU0zcA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        trevor.wu@mediatek.com, amergnat@baylibre.com,
        dan.carpenter@linaro.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 4/5] ASoC: mediatek: mt8188-mt6359: Clean up log levels
Date:   Thu,  8 Jun 2023 10:47:26 +0200
Message-Id: <20230608084727.74403-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230608084727.74403-1-angelogioacchino.delregno@collabora.com>
References: <20230608084727.74403-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change some dev_info prints to dev_err() and some to dev_dbg(),
depending on the actual severity of them.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/mediatek/mt8188/mt8188-mt6359.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
index 260cace408b9..5b2660139421 100644
--- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
+++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
@@ -337,9 +337,8 @@ static int mt8188_mt6359_mtkaif_calibration(struct snd_soc_pcm_runtime *rtd)
 
 			/* handle if never test done */
 			if (++counter > 10000) {
-				dev_info(afe->dev, "%s(), test fail, cycle_1 %d, cycle_2 %d, monitor 0x%x\n",
-					 __func__,
-					 cycle_1, cycle_2, monitor);
+				dev_err(afe->dev, "%s(), test fail, cycle_1 %d, cycle_2 %d, monitor 0x%x\n",
+					__func__, cycle_1, cycle_2, monitor);
 				mtkaif_calibration_ok = false;
 				break;
 			}
@@ -398,8 +397,8 @@ static int mt8188_mt6359_mtkaif_calibration(struct snd_soc_pcm_runtime *rtd)
 	for (i = 0; i < MT8188_MTKAIF_MISO_NUM; i++)
 		param->mtkaif_phase_cycle[i] = mtkaif_phase_cycle[i];
 
-	dev_info(afe->dev, "%s(), end, calibration ok %d\n",
-		 __func__, param->mtkaif_calibration_ok);
+	dev_dbg(afe->dev, "%s(), end, calibration ok %d\n",
+		__func__, param->mtkaif_calibration_ok);
 
 	return 0;
 }
@@ -486,14 +485,14 @@ static int mt8188_hdmi_codec_init(struct snd_soc_pcm_runtime *rtd)
 					 mt8188_hdmi_jack_pins,
 					 ARRAY_SIZE(mt8188_hdmi_jack_pins));
 	if (ret) {
-		dev_info(rtd->dev, "%s, new jack failed: %d\n", __func__, ret);
+		dev_err(rtd->dev, "%s, new jack failed: %d\n", __func__, ret);
 		return ret;
 	}
 
 	ret = snd_soc_component_set_jack(component, &priv->hdmi_jack, NULL);
 	if (ret) {
-		dev_info(rtd->dev, "%s, set jack failed on %s (ret=%d)\n",
-			 __func__, component->name, ret);
+		dev_err(rtd->dev, "%s, set jack failed on %s (ret=%d)\n",
+			__func__, component->name, ret);
 		return ret;
 	}
 
@@ -510,14 +509,14 @@ static int mt8188_dptx_codec_init(struct snd_soc_pcm_runtime *rtd)
 					 &priv->dp_jack, mt8188_dp_jack_pins,
 					 ARRAY_SIZE(mt8188_dp_jack_pins));
 	if (ret) {
-		dev_info(rtd->dev, "%s, new jack failed: %d\n", __func__, ret);
+		dev_err(rtd->dev, "%s, new jack failed: %d\n", __func__, ret);
 		return ret;
 	}
 
 	ret = snd_soc_component_set_jack(component, &priv->dp_jack, NULL);
 	if (ret) {
-		dev_info(rtd->dev, "%s, set jack failed on %s (ret=%d)\n",
-			 __func__, component->name, ret);
+		dev_err(rtd->dev, "%s, set jack failed on %s (ret=%d)\n",
+			__func__, component->name, ret);
 		return ret;
 	}
 
-- 
2.40.1

