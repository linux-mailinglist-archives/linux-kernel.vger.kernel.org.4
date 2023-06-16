Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDDF732A03
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245717AbjFPIhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245619AbjFPIho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:37:44 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30672194;
        Fri, 16 Jun 2023 01:37:41 -0700 (PDT)
Received: from [167.98.155.120] (helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qA4xg-0000Wd-Io; Fri, 16 Jun 2023 10:37:40 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/2] hwrng: st - keep clock enabled while hwrng is registered
Date:   Fri, 16 Jun 2023 09:36:18 +0100
Message-Id: <20230616083618.1320824-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230616083618.1320824-1-martin@kaiser.cx>
References: <20230616083618.1320824-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The st-rng driver uses devres to register itself with the hwrng core,
the driver will be unregistered from hwrng when its device goes out of
scope. This happens after the driver's remove function is called.

However, st-rng's clock is disabled in the remove function. There's a
short timeframe where st-rng is still registered with the hwrng core
although its clock is disabled. I suppose the clock must be active to
access the hardware and serve requests from the hwrng core.

Switch to devm_clk_get_enabled and let devres handle both clock and hwrng
registration. This avoids the race condition.

Fixes: 3e75241be808 ("hwrng: drivers - Use device-managed registration API")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/st-rng.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/char/hw_random/st-rng.c b/drivers/char/hw_random/st-rng.c
index 15ba1e6fae4d..7a4e439d34d7 100644
--- a/drivers/char/hw_random/st-rng.c
+++ b/drivers/char/hw_random/st-rng.c
@@ -42,7 +42,6 @@
 
 struct st_rng_data {
 	void __iomem	*base;
-	struct clk	*clk;
 	struct hwrng	ops;
 };
 
@@ -85,19 +84,14 @@ static int st_rng_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	clk = devm_clk_get(&pdev->dev, NULL);
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		return ret;
-
 	ddata->ops.priv	= (unsigned long)ddata;
 	ddata->ops.read	= st_rng_read;
 	ddata->ops.name	= pdev->name;
 	ddata->base	= base;
-	ddata->clk	= clk;
 
 	dev_set_drvdata(&pdev->dev, ddata);
 
@@ -113,15 +107,6 @@ static int st_rng_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int st_rng_remove(struct platform_device *pdev)
-{
-	struct st_rng_data *ddata = dev_get_drvdata(&pdev->dev);
-
-	clk_disable_unprepare(ddata->clk);
-
-	return 0;
-}
-
 static const struct of_device_id st_rng_match[] __maybe_unused = {
 	{ .compatible = "st,rng" },
 	{},
@@ -134,7 +119,6 @@ static struct platform_driver st_rng_driver = {
 		.of_match_table = of_match_ptr(st_rng_match),
 	},
 	.probe = st_rng_probe,
-	.remove = st_rng_remove
 };
 
 module_platform_driver(st_rng_driver);
-- 
2.30.2

