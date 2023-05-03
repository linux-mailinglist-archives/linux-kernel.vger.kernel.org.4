Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB946F5736
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 13:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjECLew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 07:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjECLei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 07:34:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F4D46B8
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 04:34:30 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 743AE66056D4;
        Wed,  3 May 2023 12:34:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683113668;
        bh=oygimjOCk8FTKzESWYFnGtWGKI3xuJTfmDm18J1tugE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nnSLnjd9bpSYeCY/2/NZVqduUmxCHwexohgvPshz2JTllUkmyRo/njwEw9d4MwMJT
         7WEzj0+RlugeL+084Qu1byhLz321QBuV8Sp92WcW9OzgyfZhtdh9RnF9AP4e5g/EHW
         wZvTDMxTRy+WptLhVtHFLPGx8Ifv3Vg6GQiytY7PaF4r5l1Qti/S0P4uF6QHP4VZ0S
         uYa3FmhoPtjBPdT4YwwzCHzPe8XQAyhTpqzOo4CW4+mImzfQm5qUEWB1WEordvvWqk
         Onn4CAvpadjEBcP9u3b3WgmRzKWsJ3zxVdgaTHuF3A+t+/U+XHxKLbGXCt2O6Cov0N
         i+M3I5tgi8W/A==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, nicolas.ferre@microchip.com,
        u.kleine-koenig@pengutronix.de, chunxu.li@mediatek.com,
        tinghan.shen@mediatek.com, error27@gmail.com, ribalda@chromium.org,
        yc.hung@mediatek.com, Allen-KH.Cheng@mediatek.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        sound-open-firmware@alsa-project.org, kernel@collabora.com
Subject: [PATCH 5/5] ASoC: mediatek: mt8195-afe-pcm: Clean up unnecessary functions
Date:   Wed,  3 May 2023 13:34:13 +0200
Message-Id: <20230503113413.149235-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230503113413.149235-1-angelogioacchino.delregno@collabora.com>
References: <20230503113413.149235-1-angelogioacchino.delregno@collabora.com>
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

Function mt8195_afe_init_registers() performs just a single call to
regmap_multi_reg_write(), it returns int and it's not error checked;
move that call to the probe function and also add some error check.

While at it, also move the contents of mt8195_afe_parse_of() to the
probe function as well: since this is getting a handle to topckgen
and since that's optional, the ifdef for CONFIG_SND_SOC_MT6359 can
also be removed.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c | 32 ++++++----------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
index 105db11eecec..d22cf1664d8a 100644
--- a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
+++ b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
@@ -3030,28 +3030,6 @@ static const struct reg_sequence mt8195_cg_patch[] = {
 	{ AUDIO_TOP_CON1, 0xfffffff8 },
 };
 
-static int mt8195_afe_init_registers(struct mtk_base_afe *afe)
-{
-	return regmap_multi_reg_write(afe->regmap,
-			mt8195_afe_reg_defaults,
-			ARRAY_SIZE(mt8195_afe_reg_defaults));
-}
-
-static void mt8195_afe_parse_of(struct mtk_base_afe *afe,
-				struct device_node *np)
-{
-#if IS_ENABLED(CONFIG_SND_SOC_MT6359)
-	struct mt8195_afe_private *afe_priv = afe->platform_priv;
-
-	afe_priv->topckgen = syscon_regmap_lookup_by_phandle(afe->dev->of_node,
-							     "mediatek,topckgen");
-	if (IS_ERR(afe_priv->topckgen)) {
-		dev_info(afe->dev, "%s() Cannot find topckgen controller: %ld\n",
-			 __func__, PTR_ERR(afe_priv->topckgen));
-	}
-#endif
-}
-
 static int mt8195_afe_pcm_dev_probe(struct platform_device *pdev)
 {
 	struct mtk_base_afe *afe;
@@ -3160,7 +3138,10 @@ static int mt8195_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, afe);
 
-	mt8195_afe_parse_of(afe, pdev->dev.of_node);
+	afe_priv->topckgen = syscon_regmap_lookup_by_phandle(dev->of_node, "mediatek,topckgen");
+	if (IS_ERR(afe_priv->topckgen))
+		dev_dbg(afe->dev, "Cannot find topckgen controller: %ld\n",
+			PTR_ERR(afe_priv->topckgen));
 
 	/* enable clock for regcache get default value from hw */
 	afe_priv->pm_runtime_bypass_reg_ctl = true;
@@ -3219,7 +3200,10 @@ static int mt8195_afe_pcm_dev_probe(struct platform_device *pdev)
 		goto err_pm_put;
 	}
 
-	mt8195_afe_init_registers(afe);
+	ret = regmap_multi_reg_write(afe->regmap, mt8195_afe_reg_defaults,
+				     ARRAY_SIZE(mt8195_afe_reg_defaults));
+	if (ret)
+		goto err_pm_put;
 
 	ret = pm_runtime_put_sync(dev);
 	if (ret)
-- 
2.40.1

