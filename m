Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A14F6DF449
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjDLLxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjDLLxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:53:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA464EC5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:52:59 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8C3746603255;
        Wed, 12 Apr 2023 12:52:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681300378;
        bh=vgCzOfsjHqzxe3JGHPEHxks0hGKSfmPemepHaQkMDtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NpXmWnzd7n6i6f8IL8PsTjmmrcY+PxcIlozvsyLlO/nXiUoAiHOT7hrz5UxEIXlTy
         BK7p1M7If7Z1qv+9SnxnR8kBT/4JPGKFkPxGUDPE4u5BWkJBNz700V3/VTE6bIaosU
         x8ybm+BOw1k5P5nJO8ycE+/7xpDYRBFTx+Dwb+CSSOv7H1znWtEZxz82ZJhWjG3v1S
         goFaCI6im7cJ/RR3/UiAIswySZFnRftqFEmxnqQl4edQYYk5e/lMwYJfNZLXfPHUmJ
         qNIPMD12PwyO2c331b8V1gr0SIwB7tTbrLopgwI8CuqzjpnuoIym6vKW429R7QcNLG
         4TgxMu5iIuHMQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 4/4] drm/mediatek: mtk_dpi: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 12 Apr 2023 13:52:50 +0200
Message-Id: <20230412115250.164899-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230412115250.164899-1-angelogioacchino.delregno@collabora.com>
References: <20230412115250.164899-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        TVD_SPACE_RATIO,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of the open-coded platform_get_resource, devm_ioremap_resource
switch to devm_platform_get_and_ioremap_resource(), doing exactly the
same.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 9025111013d3..45535dc7970f 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -1038,8 +1038,7 @@ static int mtk_dpi_probe(struct platform_device *pdev)
 			dev_dbg(&pdev->dev, "Cannot find pinctrl active!\n");
 		}
 	}
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dpi->regs = devm_ioremap_resource(dev, mem);
+	dpi->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
 	if (IS_ERR(dpi->regs))
 		return dev_err_probe(dev, PTR_ERR(dpi->regs),
 				     "Failed to ioremap mem resource\n");
-- 
2.40.0

