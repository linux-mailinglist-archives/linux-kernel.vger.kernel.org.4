Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E84574DF49
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjGJU3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjGJU3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:29:36 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E2D1AB;
        Mon, 10 Jul 2023 13:29:32 -0700 (PDT)
Received: from 250.57.4.146.static.wline.lns.sme.cust.swisscom.ch ([146.4.57.250] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qIxVh-0002mg-Uz; Mon, 10 Jul 2023 22:29:29 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     aric.pzqi@ingenic.com, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 7/7] hwrng: ingenic - switch to device managed registration
Date:   Mon, 10 Jul 2023 22:27:33 +0200
Message-Id: <20230710202733.116133-8-martin@kaiser.cx>
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

Call devm_hwrng_register for device managed registration of the
ingenic-trng driver. ingenic_trng_remove can then be deleted.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/ingenic-trng.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/char/hw_random/ingenic-trng.c b/drivers/char/hw_random/ingenic-trng.c
index 9c54721f8399..3967a8dbe967 100644
--- a/drivers/char/hw_random/ingenic-trng.c
+++ b/drivers/char/hw_random/ingenic-trng.c
@@ -98,7 +98,7 @@ static int ingenic_trng_probe(struct platform_device *pdev)
 	trng->rng.cleanup = ingenic_trng_cleanup;
 	trng->rng.read = ingenic_trng_read;
 
-	ret = hwrng_register(&trng->rng);
+	ret = devm_hwrng_register(&pdev->dev, &trng->rng);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "Failed to register hwrng\n");
 
@@ -108,15 +108,6 @@ static int ingenic_trng_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ingenic_trng_remove(struct platform_device *pdev)
-{
-	struct ingenic_trng *trng = platform_get_drvdata(pdev);
-
-	hwrng_unregister(&trng->rng);
-
-	return 0;
-}
-
 static const struct of_device_id ingenic_trng_of_match[] = {
 	{ .compatible = "ingenic,x1830-dtrng" },
 	{ /* sentinel */ }
@@ -125,7 +116,6 @@ MODULE_DEVICE_TABLE(of, ingenic_trng_of_match);
 
 static struct platform_driver ingenic_trng_driver = {
 	.probe		= ingenic_trng_probe,
-	.remove		= ingenic_trng_remove,
 	.driver		= {
 		.name	= "ingenic-trng",
 		.of_match_table = ingenic_trng_of_match,
-- 
2.30.2

