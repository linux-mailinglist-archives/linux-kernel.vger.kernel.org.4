Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98C874777E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 19:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjGDRIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 13:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjGDRIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 13:08:31 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25776F3;
        Tue,  4 Jul 2023 10:08:29 -0700 (PDT)
Received: from ipservice-092-217-072-126.092.217.pools.vodafone-ip.de ([92.217.72.126] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qGjVr-0000ky-1q; Tue, 04 Jul 2023 19:08:27 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] hwrng: imx-rngc - use dev_err_probe
Date:   Tue,  4 Jul 2023 19:06:44 +0200
Message-Id: <20230704170644.69669-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
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

Simplify the code by calling dev_err_probe instead of dev_err and return.

While at it, use the same device for all error messages.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/imx-rngc.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index bf07f17f78c8..e4b385b01b11 100644
--- a/drivers/char/hw_random/imx-rngc.c
+++ b/drivers/char/hw_random/imx-rngc.c
@@ -239,10 +239,8 @@ static int __init imx_rngc_probe(struct platform_device *pdev)
 		return PTR_ERR(rngc->base);
 
 	rngc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
-	if (IS_ERR(rngc->clk)) {
-		dev_err(&pdev->dev, "Can not get rng_clk\n");
-		return PTR_ERR(rngc->clk);
-	}
+	if (IS_ERR(rngc->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rngc->clk), "Cannot get rng_clk\n");
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -272,24 +270,18 @@ static int __init imx_rngc_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(&pdev->dev,
 			irq, imx_rngc_irq, 0, pdev->name, (void *)rngc);
-	if (ret) {
-		dev_err(rngc->dev, "Can't get interrupt working.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Can't get interrupt working.\n");
 
 	if (self_test) {
 		ret = imx_rngc_self_test(rngc);
-		if (ret) {
-			dev_err(rngc->dev, "self test failed\n");
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret, "self test failed\n");
 	}
 
 	ret = devm_hwrng_register(&pdev->dev, &rngc->rng);
-	if (ret) {
-		dev_err(&pdev->dev, "hwrng registration failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "hwrng registration failed\n");
 
 	dev_info(&pdev->dev,
 		"Freescale RNG%c registered (HW revision %d.%02d)\n",
-- 
2.30.2

