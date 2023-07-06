Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE51749BC7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjGFMay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjGFMah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:30:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70711BC9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 05:30:36 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 07B4F6606FCD;
        Thu,  6 Jul 2023 13:30:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688646635;
        bh=SDqfcPu1Xm6TXPZRhcStnENnmo+lyeo6d7YVf6Sycu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=euhM+DGkPbR6J+sZeCx8RXgfRJH2oDNdzh6srd6wwkNDIOx+BzpPxg31HoBZ8zEZl
         mSMnLCiYl8JSzXxyFJwBsjHcKeppF5MwIpMCSf7quGyOpC0vPEAzLDzcvvYGUEJYlS
         Oc9//UfCPrS65h5BlDNQbu3h5zJZ5df0lTcsMsC7wyJqjudio3JQjuTui7ee0Fcky+
         LcDFJ/I9fEAnHYhJw7V1WlpGhSPR7o4hozevRh5MKJi8dJO9L83p57KyCZaoV1AQS8
         0WOFbJWezUoCJ+Zi15vWy88V1E8vwxzazZtBHLqRu3o003rw0TCikG8jV6j88w6GZi
         WTTTr7uJqjUGw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org, nfraprado@collabora.com
Subject: [PATCH v4 6/9] drm/mediatek: dp: Enable event interrupt only when bridge attached
Date:   Thu,  6 Jul 2023 14:30:22 +0200
Message-Id: <20230706123025.208408-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230706123025.208408-1-angelogioacchino.delregno@collabora.com>
References: <20230706123025.208408-1-angelogioacchino.delregno@collabora.com>
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
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 274119356dfb..eebcb32e67ee 100644
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
@@ -2147,6 +2148,8 @@ static int mtk_dp_bridge_attach(struct drm_bridge *bridge,
 
 	mtk_dp->drm_dev = bridge->dev;
 
+	irq_clear_status_flags(mtk_dp->irq, IRQ_NOAUTOEN);
+	enable_irq(mtk_dp->irq);
 	mtk_dp_hwirq_enable(mtk_dp, true);
 
 	return 0;
@@ -2163,6 +2166,7 @@ static void mtk_dp_bridge_detach(struct drm_bridge *bridge)
 	struct mtk_dp *mtk_dp = mtk_dp_from_bridge(bridge);
 
 	mtk_dp_hwirq_enable(mtk_dp, false);
+	disable_irq(mtk_dp->irq);
 	mtk_dp->drm_dev = NULL;
 	mtk_dp_poweroff(mtk_dp);
 	drm_dp_aux_unregister(&mtk_dp->aux);
@@ -2481,7 +2485,7 @@ static int mtk_dp_probe(struct platform_device *pdev)
 {
 	struct mtk_dp *mtk_dp;
 	struct device *dev = &pdev->dev;
-	int ret, irq_num;
+	int ret;
 
 	mtk_dp = devm_kzalloc(dev, sizeof(*mtk_dp), GFP_KERNEL);
 	if (!mtk_dp)
@@ -2490,9 +2494,9 @@ static int mtk_dp_probe(struct platform_device *pdev)
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
@@ -2513,7 +2517,8 @@ static int mtk_dp_probe(struct platform_device *pdev)
 
 	spin_lock_init(&mtk_dp->irq_thread_lock);
 
-	ret = devm_request_threaded_irq(dev, irq_num, mtk_dp_hpd_event,
+	irq_set_status_flags(mtk_dp->irq, IRQ_NOAUTOEN);
+	ret = devm_request_threaded_irq(dev, mtk_dp->irq, mtk_dp_hpd_event,
 					mtk_dp_hpd_event_thread,
 					IRQ_TYPE_LEVEL_HIGH, dev_name(dev),
 					mtk_dp);
-- 
2.40.1

