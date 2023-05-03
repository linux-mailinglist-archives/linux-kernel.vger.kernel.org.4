Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF416F5734
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 13:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjECLei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 07:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjECLe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 07:34:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75A25273
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 04:34:26 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2552766056D2;
        Wed,  3 May 2023 12:34:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683113665;
        bh=lJinXQ8uqP7CnqlUjGVARURr70ufEO+/YnYRE0JoVQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HSzFx8GbrJ8qs8mBrbeP+h7EcY1pogSEhyzSPpiZVHTaiFRSXaGbp5P86Vt16B/07
         c7V+Xj5slpef3GSmiz/Pf9bnkDA025Mw3wy8GD8HVuedzDpHs1REkrHXWHXaQs8nYw
         /J5brCacAgQ3HeDaNVMLMDpgZ4lkPe+LCU+SB0SksECniQJvf0vdahY0Yx7//fAURU
         +GvoQmfEw4XOQawfFSXrCABO/+LpP1qxWI3y1jQiPDuCe0ey0iPu9Y/FJmCXAqzLTy
         oh2aaralDRQaWp++iEIUJHa+6Lm4w+kgiByyia77GGEm8NnOE4N083/yLbzxO3FkNI
         2+9iNKO5hHbrA==
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
Subject: [PATCH 3/5] ASoC: mediatek: mt8195-afe-pcm: Simplify runtime PM during probe
Date:   Wed,  3 May 2023 13:34:11 +0200
Message-Id: <20230503113413.149235-4-angelogioacchino.delregno@collabora.com>
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

Use devm_pm_runtime_enable() and pm_runtime_resume_and_get() to
to simplify the probe function.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
index 9e45efeada55..a54c16e0aa05 100644
--- a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
+++ b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
@@ -3179,16 +3179,16 @@ static int mt8195_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	mt8195_afe_parse_of(afe, pdev->dev.of_node);
 
-	pm_runtime_enable(dev);
-	if (!pm_runtime_enabled(dev)) {
-		ret = mt8195_afe_runtime_resume(dev);
-		if (ret)
-			return ret;
-	}
-
 	/* enable clock for regcache get default value from hw */
 	afe_priv->pm_runtime_bypass_reg_ctl = true;
-	pm_runtime_get_sync(dev);
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to resume device\n");
 
 	afe->regmap = devm_regmap_init_mmio(&pdev->dev, afe->base_addr,
 					    &mt8195_afe_regmap_config);
@@ -3238,7 +3238,10 @@ static int mt8195_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	mt8195_afe_init_registers(afe);
 
-	pm_runtime_put_sync(dev);
+	ret = pm_runtime_put_sync(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to suspend device\n");
+
 	afe_priv->pm_runtime_bypass_reg_ctl = false;
 
 	regcache_cache_only(afe->regmap, true);
@@ -3248,7 +3251,6 @@ static int mt8195_afe_pcm_dev_probe(struct platform_device *pdev)
 
 err_pm_put:
 	pm_runtime_put_sync(dev);
-	pm_runtime_disable(dev);
 
 	return ret;
 }
-- 
2.40.1

