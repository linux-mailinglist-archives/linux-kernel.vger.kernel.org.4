Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D349B6D5DF6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbjDDKsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbjDDKsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:48:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009452107
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 03:48:11 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2C524660320F;
        Tue,  4 Apr 2023 11:48:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680605290;
        bh=piJKx8AJRTNo3xZLCBhwQ0b5ZyuIg8W2w0zGxP4Udgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QvnhtDxpm5FEQgsz+h24rX861+Xfdo7zKks0F+FXwMkDyZ+ODrvhCqRdElDkT3XtR
         CQHzgk3CUfVn8LJQKckgq5FGfF8Mbi9AgaDIs5siaOGw1rtGynZsA5g/rLvFHvDYQY
         QGS01Dbfv46uDaCnksm8zWy4ftQrwkWrPO4uCCaG8ggyRdAIGm8yL+NvaN7Kj86KJt
         a9Jpl8HxYu1OLrVOQRDEZeSzhozk/4Ipa8i2vc+ZStFpYZYURN9e7ViS6ODwDltu9q
         VzXbh6G9DcKKHIr4mWs9gXebXjJ9p9TumusV9t3c0RIJrFQLG+jTw9q5B5UCLOVqq9
         6LOu3KclKU6iw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
Subject: [PATCH v3 6/9] drm/mediatek: dp: Enable event interrupt only when bridge attached
Date:   Tue,  4 Apr 2023 12:47:57 +0200
Message-Id: <20230404104800.301150-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230404104800.301150-1-angelogioacchino.delregno@collabora.com>
References: <20230404104800.301150-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for implementing support for aux-bus in this driver,
add a IRQ_NOAUTOEN flag to the event interrupt that we request at
probe time and manage the enablement of the ISR at bridge_attach
and detach time.

When aux-bus will be implemented, enabling the interrupt before
attaching the bridge will create an event storm and hang the kernel
during boot.
In any case, the interrupt handler anyway requires resources that
are initialized by mtk_dp_bridge_attach(), so it cannot do anything
meaningful without... and even crash, but that's not happening in
the current code because the HW remains unpowered until resources
are made available.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 19b145cf2e05..6aaf162a6bfe 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -100,6 +100,7 @@ struct mtk_dp_efuse_fmt {
 struct mtk_dp {
 	bool enabled;
 	bool need_debounce;
+	int irq;
 	u8 max_lanes;
 	u8 max_linkrate;
 	u8 rx_cap[DP_RECEIVER_CAP_SIZE];
@@ -2148,6 +2149,8 @@ static int mtk_dp_bridge_attach(struct drm_bridge *bridge,
 
 	mtk_dp->drm_dev = bridge->dev;
 
+	irq_clear_status_flags(mtk_dp->irq, IRQ_NOAUTOEN);
+	enable_irq(mtk_dp->irq);
 	mtk_dp_hwirq_enable(mtk_dp, true);
 
 	return 0;
@@ -2164,6 +2167,7 @@ static void mtk_dp_bridge_detach(struct drm_bridge *bridge)
 	struct mtk_dp *mtk_dp = mtk_dp_from_bridge(bridge);
 
 	mtk_dp_hwirq_enable(mtk_dp, false);
+	disable_irq(mtk_dp->irq);
 	mtk_dp->drm_dev = NULL;
 	mtk_dp_poweroff(mtk_dp);
 	drm_dp_aux_unregister(&mtk_dp->aux);
@@ -2482,7 +2486,7 @@ static int mtk_dp_probe(struct platform_device *pdev)
 {
 	struct mtk_dp *mtk_dp;
 	struct device *dev = &pdev->dev;
-	int ret, irq_num;
+	int ret;
 
 	mtk_dp = devm_kzalloc(dev, sizeof(*mtk_dp), GFP_KERNEL);
 	if (!mtk_dp)
@@ -2491,9 +2495,9 @@ static int mtk_dp_probe(struct platform_device *pdev)
 	mtk_dp->dev = dev;
 	mtk_dp->data = (struct mtk_dp_data *)of_device_get_match_data(dev);
 
-	irq_num = platform_get_irq(pdev, 0);
-	if (irq_num < 0)
-		return dev_err_probe(dev, irq_num,
+	mtk_dp->irq = platform_get_irq(pdev, 0);
+	if (mtk_dp->irq < 0)
+		return dev_err_probe(dev, mtk_dp->irq,
 				     "failed to request dp irq resource\n");
 
 	mtk_dp->next_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 1, 0);
@@ -2514,7 +2518,8 @@ static int mtk_dp_probe(struct platform_device *pdev)
 
 	spin_lock_init(&mtk_dp->irq_thread_lock);
 
-	ret = devm_request_threaded_irq(dev, irq_num, mtk_dp_hpd_event,
+	irq_set_status_flags(mtk_dp->irq, IRQ_NOAUTOEN);
+	ret = devm_request_threaded_irq(dev, mtk_dp->irq, mtk_dp_hpd_event,
 					mtk_dp_hpd_event_thread,
 					IRQ_TYPE_LEVEL_HIGH, dev_name(dev),
 					mtk_dp);
-- 
2.40.0

