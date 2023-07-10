Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033BD74DF44
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjGJU3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjGJU3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:29:34 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87165AD;
        Mon, 10 Jul 2023 13:29:30 -0700 (PDT)
Received: from 250.57.4.146.static.wline.lns.sme.cust.swisscom.ch ([146.4.57.250] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qIxVf-0002mg-OH; Mon, 10 Jul 2023 22:29:27 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     aric.pzqi@ingenic.com, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 4/7] hwrng: ingenic - use devm_clk_get_enabled
Date:   Mon, 10 Jul 2023 22:27:30 +0200
Message-Id: <20230710202733.116133-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230710202733.116133-1-martin@kaiser.cx>
References: <20230710202733.116133-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_clk_get_enabled in the ingenic-trng driver. We don't have to
disable and unprepare the clock any more in error paths or in the remove
function.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/ingenic-trng.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/char/hw_random/ingenic-trng.c b/drivers/char/hw_random/ingenic-trng.c
index bfec28ceab00..906fa78de47e 100644
--- a/drivers/char/hw_random/ingenic-trng.c
+++ b/drivers/char/hw_random/ingenic-trng.c
@@ -29,7 +29,6 @@
 
 struct ingenic_trng {
 	void __iomem *base;
-	struct clk *clk;
 	struct hwrng rng;
 };
 
@@ -77,6 +76,7 @@ static int ingenic_trng_read(struct hwrng *rng, void *buf, size_t max, bool wait
 static int ingenic_trng_probe(struct platform_device *pdev)
 {
 	struct ingenic_trng *trng;
+	struct clk *clk;
 	int ret;
 
 	trng = devm_kzalloc(&pdev->dev, sizeof(*trng), GFP_KERNEL);
@@ -89,16 +89,10 @@ static int ingenic_trng_probe(struct platform_device *pdev)
 		return PTR_ERR(trng->base);
 	}
 
-	trng->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(trng->clk)) {
-		pr_crit("%s: Cannot get DTRNG clock\n", __func__);
-		return PTR_ERR(trng->clk);
-	}
-
-	ret = clk_prepare_enable(trng->clk);
-	if (ret) {
-		pr_crit("%s: Unable to enable DTRNG clock\n", __func__);
-		return ret;
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(clk)) {
+		pr_crit("%s: Cannot get and enable DTRNG clock\n", __func__);
+		return PTR_ERR(clk);
 	}
 
 	trng->rng.name = pdev->name;
@@ -109,17 +103,13 @@ static int ingenic_trng_probe(struct platform_device *pdev)
 	ret = hwrng_register(&trng->rng);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register hwrng\n");
-		goto err_unprepare_clk;
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, trng);
 
 	dev_info(&pdev->dev, "Ingenic DTRNG driver registered\n");
 	return 0;
-
-err_unprepare_clk:
-	clk_disable_unprepare(trng->clk);
-	return ret;
 }
 
 static int ingenic_trng_remove(struct platform_device *pdev)
@@ -133,8 +123,6 @@ static int ingenic_trng_remove(struct platform_device *pdev)
 	ctrl &= ~CFG_GEN_EN;
 	writel(ctrl, trng->base + TRNG_REG_CFG_OFFSET);
 
-	clk_disable_unprepare(trng->clk);
-
 	return 0;
 }
 
-- 
2.30.2

