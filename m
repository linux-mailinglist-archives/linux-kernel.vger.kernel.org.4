Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89DB74DF47
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjGJU3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjGJU3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:29:35 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367B419A;
        Mon, 10 Jul 2023 13:29:31 -0700 (PDT)
Received: from 250.57.4.146.static.wline.lns.sme.cust.swisscom.ch ([146.4.57.250] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qIxVg-0002mg-FV; Mon, 10 Jul 2023 22:29:28 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     aric.pzqi@ingenic.com, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 5/7] hwrng: ingenic - use dev_err_probe in error paths
Date:   Mon, 10 Jul 2023 22:27:31 +0200
Message-Id: <20230710202733.116133-6-martin@kaiser.cx>
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

Use dev_err_probe in error paths to make the code a bit shorter.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/ingenic-trng.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/char/hw_random/ingenic-trng.c b/drivers/char/hw_random/ingenic-trng.c
index 906fa78de47e..cc88a941c929 100644
--- a/drivers/char/hw_random/ingenic-trng.c
+++ b/drivers/char/hw_random/ingenic-trng.c
@@ -84,16 +84,14 @@ static int ingenic_trng_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	trng->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(trng->base)) {
-		pr_err("%s: Failed to map DTRNG registers\n", __func__);
-		return PTR_ERR(trng->base);
-	}
+	if (IS_ERR(trng->base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(trng->base),
+				     "%s: Failed to map DTRNG registers\n", __func__);
 
 	clk = devm_clk_get_enabled(&pdev->dev, NULL);
-	if (IS_ERR(clk)) {
-		pr_crit("%s: Cannot get and enable DTRNG clock\n", __func__);
-		return PTR_ERR(clk);
-	}
+	if (IS_ERR(clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
+				     "%s: Cannot get and enable DTRNG clock\n", __func__);
 
 	trng->rng.name = pdev->name;
 	trng->rng.init = ingenic_trng_init;
@@ -101,10 +99,8 @@ static int ingenic_trng_probe(struct platform_device *pdev)
 	trng->rng.read = ingenic_trng_read;
 
 	ret = hwrng_register(&trng->rng);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to register hwrng\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to register hwrng\n");
 
 	platform_set_drvdata(pdev, trng);
 
-- 
2.30.2

