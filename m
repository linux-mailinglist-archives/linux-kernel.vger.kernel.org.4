Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887CF6DF44B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjDLLxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjDLLxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:53:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9729119A9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:52:58 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C01186603239;
        Wed, 12 Apr 2023 12:52:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681300377;
        bh=4FBue3qHRI25FXn0MBkODyzRRRK4GfsWagmvjRhDO5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eCDzv+FOppqjQwIZrSpLGamwEACPh8hraG9vIjR0E0AgYoBxv+sPdCf2/Luumn17G
         qhi0/SDnLZ8wgejRJhNmWA/61b3g3TWrK2Gjh3OzYuQHWCv1ct7H4xSOkYRVJoLEV9
         hjBzIAhAXCLMxutGeXBMLU/pUQRXWYhe3aN4oI3QXqR9ei3BsRXd8AhOYtQ+kgQa6M
         Te6guvGzaM3roCpgBvuqeE+cDk84GztJ07AfRfVrmLHdX2764kUJJEyKkjaft311KB
         fFuBafK5G7ZYGZwHgUiRYt1da5+UwiqbfzeOTm1GNY3fMjCOG6YfFJcrCiXsG5G9rQ
         yVRV+Rem0Elkw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 3/4] drm/mediatek: mtk_dpi: Switch to devm_drm_of_get_bridge()
Date:   Wed, 12 Apr 2023 13:52:49 +0200
Message-Id: <20230412115250.164899-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230412115250.164899-1-angelogioacchino.delregno@collabora.com>
References: <20230412115250.164899-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function drm_of_find_panel_or_bridge() is marked as deprecated: since
the usage of that in this driver exactly corresponds to the new function
devm_drm_of_get_bridge(), switch to it.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 6be65ea21f8f..9025111013d3 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -1063,10 +1063,9 @@ static int mtk_dpi_probe(struct platform_device *pdev)
 	if (dpi->irq <= 0)
 		return -EINVAL;
 
-	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
-					  NULL, &dpi->next_bridge);
-	if (ret)
-		return ret;
+	dpi->next_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 0, 0);
+	if (IS_ERR(dpi->next_bridge))
+		return PTR_ERR(dpi->next_bridge);
 
 	dev_info(dev, "Found bridge node: %pOF\n", dpi->next_bridge->of_node);
 
-- 
2.40.0

