Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E2D5F64E8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 13:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiJFLKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 07:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiJFLJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 07:09:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3515586
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 04:09:40 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5A61766022F9;
        Thu,  6 Oct 2022 12:09:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665054579;
        bh=HaMjBUnn0XP2R6tqIgzWDxijRENloQ+oZZWaIxT+XMY=;
        h=From:To:Cc:Subject:Date:From;
        b=S2XPIqIl4XEBq6BBtHS99Mn2AoFFc3pEx/KdumCdajL2VmOl3rb9C3ZR2yOlk1ohK
         sde1jTKKH/VMrsPwr6Xo87H+UMccKSW9IH9c82dF3JdDick1uv7FV7BuVesSsiYIcZ
         yceziv4oW/eeB9RwRPCPhRu8BA8oXWQNJqU4wgz+pqlPW2SZ+hbajlc57DrTa4aE9H
         S6Qxlc+AKDF6LMQ2OO8FkrLJiV3u0ubg0SS72pzltyAXEN047IbmT1QHSdHyN2SKdw
         kP+SgBt3oKCPoW3Df//T/Yp3UNBNWs0EmSP1TiTgTWKaegS/7vFXQKFO82ayI6+g34
         1YZ8DMvB7UpGw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] soc: mediatek: mtk-devapc: Switch to devm_clk_get_enabled()
Date:   Thu,  6 Oct 2022 13:09:35 +0200
Message-Id: <20221006110935.59695-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
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

This driver does exactly devm_clk_get() and clk_prepare_enable() right
after, which is exactly what devm_clk_get_enabled() does: clean that
up by switching to the latter.

This commit brings no functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-devapc.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
index fc13334db1b1..bad139cb117e 100644
--- a/drivers/soc/mediatek/mtk-devapc.c
+++ b/drivers/soc/mediatek/mtk-devapc.c
@@ -276,19 +276,14 @@ static int mtk_devapc_probe(struct platform_device *pdev)
 	if (!devapc_irq)
 		return -EINVAL;
 
-	ctx->infra_clk = devm_clk_get(&pdev->dev, "devapc-infra-clock");
+	ctx->infra_clk = devm_clk_get_enabled(&pdev->dev, "devapc-infra-clock");
 	if (IS_ERR(ctx->infra_clk))
 		return -EINVAL;
 
-	if (clk_prepare_enable(ctx->infra_clk))
-		return -EINVAL;
-
 	ret = devm_request_irq(&pdev->dev, devapc_irq, devapc_violation_irq,
 			       IRQF_TRIGGER_NONE, "devapc", ctx);
-	if (ret) {
-		clk_disable_unprepare(ctx->infra_clk);
+	if (ret)
 		return ret;
-	}
 
 	platform_set_drvdata(pdev, ctx);
 
@@ -303,8 +298,6 @@ static int mtk_devapc_remove(struct platform_device *pdev)
 
 	stop_devapc(ctx);
 
-	clk_disable_unprepare(ctx->infra_clk);
-
 	return 0;
 }
 
-- 
2.37.2

