Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505626F5735
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 13:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjECLer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 07:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjECLea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 07:34:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C3159DA
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 04:34:28 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C896D66056D3;
        Wed,  3 May 2023 12:34:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683113667;
        bh=S4CgoCQHjSzDV+ANF2xZcYt7UKYACrFS841NHZgYjfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bSzjfc7ECNNyEtLKzke72Nb5BjqW2QRpVPcqoSbpFvF2xwjJF/b3svXSVsbbdU4uZ
         bMqzFyVFxfom3DZbQXCoUehXnTHeLY0zPw5sFMYuMmRBHmq94rQNIvTvx/VG8I9lXs
         ms1IL3A7BR6+xmjT0tUQa8e8/RLAvzRS7q8dDlwTSzAZ7BPpKsQiKDtKxRigCQIpge
         Ul1dP+WZxhnSfh0wF9j07b13taAGJvaVTKPTVarIpZ8oaIPiIKT5bhtIXuY+A06Ggz
         Yb63e99gTZD3e5yyndqPBAF00RCApXbRhoSDI+brPP1T34lSJAkcSTZ5ZiWA2AUl3M
         OOWgt+6u7ci6A==
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
Subject: [PATCH 4/5] ASoC: mediatek: mt8195-afe-pcm: Simplify with dev_err_probe()
Date:   Wed,  3 May 2023 13:34:12 +0200
Message-Id: <20230503113413.149235-5-angelogioacchino.delregno@collabora.com>
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

Shorten the probe function by switching to dev_err_probe() where
possible.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c | 45 +++++++---------------
 1 file changed, 14 insertions(+), 31 deletions(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
index a54c16e0aa05..105db11eecec 100644
--- a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
+++ b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
@@ -3062,10 +3062,8 @@ static int mt8195_afe_pcm_dev_probe(struct platform_device *pdev)
 	struct snd_soc_component *component;
 
 	ret = of_reserved_mem_device_init(dev);
-	if (ret) {
-		dev_err(dev, "failed to assign memory region: %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to assign memory region\n");
 
 	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(33));
 	if (ret)
@@ -3089,24 +3087,17 @@ static int mt8195_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	/* initial audio related clock */
 	ret = mt8195_afe_init_clock(afe);
-	if (ret) {
-		dev_err(dev, "init clock error\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "init clock error\n");
 
 	/* reset controller to reset audio regs before regmap cache */
 	rstc = devm_reset_control_get_exclusive(dev, "audiosys");
-	if (IS_ERR(rstc)) {
-		ret = PTR_ERR(rstc);
-		dev_err(dev, "could not get audiosys reset:%d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(rstc))
+		return dev_err_probe(dev, PTR_ERR(rstc), "could not get audiosys reset\n");
 
 	ret = reset_control_reset(rstc);
-	if (ret) {
-		dev_err(dev, "failed to trigger audio reset:%d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to trigger audio reset\n");
 
 	spin_lock_init(&afe_priv->afe_ctrl_lock);
 
@@ -3143,30 +3134,22 @@ static int mt8195_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(dev, irq_id, mt8195_afe_irq_handler,
 			       IRQF_TRIGGER_NONE, "asys-isr", (void *)afe);
-	if (ret) {
-		dev_err(dev, "could not request_irq for asys-isr\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "could not request_irq for asys-isr\n");
 
 	/* init sub_dais */
 	INIT_LIST_HEAD(&afe->sub_dais);
 
 	for (i = 0; i < ARRAY_SIZE(dai_register_cbs); i++) {
 		ret = dai_register_cbs[i](afe);
-		if (ret) {
-			dev_warn(dev, "dai register i %d fail, ret %d\n",
-				 i, ret);
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret, "dai cb%i register fail\n", i);
 	}
 
 	/* init dai_driver and component_driver */
 	ret = mtk_afe_combine_sub_dai(afe);
-	if (ret) {
-		dev_warn(dev, "mtk_afe_combine_sub_dai fail, ret %d\n",
-			 ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "mtk_afe_combine_sub_dai fail\n");
 
 	afe->mtk_afe_hardware = &mt8195_afe_hardware;
 	afe->memif_fs = mt8195_memif_fs;
-- 
2.40.1

