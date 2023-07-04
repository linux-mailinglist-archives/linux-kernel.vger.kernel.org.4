Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8287477DE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 19:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjGDRd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 13:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjGDRdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 13:33:52 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A34910D5;
        Tue,  4 Jul 2023 10:33:51 -0700 (PDT)
Received: from ipservice-092-217-072-126.092.217.pools.vodafone-ip.de ([92.217.72.126] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qGjuO-0000yT-DV; Tue, 04 Jul 2023 19:33:48 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Joshua Henderson <joshua.henderson@microchip.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/4] hwrng: pic32 - use devm_clk_get_enabled
Date:   Tue,  4 Jul 2023 19:32:01 +0200
Message-Id: <20230704173203.70706-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230704173203.70706-1-martin@kaiser.cx>
References: <20230704173203.70706-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_clk_get_enabled in the pic32 driver. Ensure that the clock is
enabled as long as the driver is registered with the hwrng core.

Fixes: 7ea39973d1e5 ("hwrng: pic32 - Use device-managed registration API")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/pic32-rng.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/char/hw_random/pic32-rng.c b/drivers/char/hw_random/pic32-rng.c
index 99c8bd0859a1..e04a054e8930 100644
--- a/drivers/char/hw_random/pic32-rng.c
+++ b/drivers/char/hw_random/pic32-rng.c
@@ -36,7 +36,6 @@
 struct pic32_rng {
 	void __iomem	*base;
 	struct hwrng	rng;
-	struct clk	*clk;
 };
 
 /*
@@ -70,6 +69,7 @@ static int pic32_rng_read(struct hwrng *rng, void *buf, size_t max,
 static int pic32_rng_probe(struct platform_device *pdev)
 {
 	struct pic32_rng *priv;
+	struct clk *clk;
 	u32 v;
 	int ret;
 
@@ -81,13 +81,9 @@ static int pic32_rng_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	priv->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(priv->clk))
-		return PTR_ERR(priv->clk);
-
-	ret = clk_prepare_enable(priv->clk);
-	if (ret)
-		return ret;
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 
 	/* enable TRNG in enhanced mode */
 	v = TRNGEN | TRNGMOD;
@@ -98,15 +94,11 @@ static int pic32_rng_probe(struct platform_device *pdev)
 
 	ret = devm_hwrng_register(&pdev->dev, &priv->rng);
 	if (ret)
-		goto err_register;
+		return ret;
 
 	platform_set_drvdata(pdev, priv);
 
 	return 0;
-
-err_register:
-	clk_disable_unprepare(priv->clk);
-	return ret;
 }
 
 static int pic32_rng_remove(struct platform_device *pdev)
@@ -114,7 +106,6 @@ static int pic32_rng_remove(struct platform_device *pdev)
 	struct pic32_rng *rng = platform_get_drvdata(pdev);
 
 	writel(0, rng->base + RNGCON);
-	clk_disable_unprepare(rng->clk);
 	return 0;
 }
 
-- 
2.30.2

