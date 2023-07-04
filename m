Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14717477E2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 19:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjGDReC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 13:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjGDRdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 13:33:54 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C94DA;
        Tue,  4 Jul 2023 10:33:52 -0700 (PDT)
Received: from ipservice-092-217-072-126.092.217.pools.vodafone-ip.de ([92.217.72.126] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qGjuP-0000yT-Uj; Tue, 04 Jul 2023 19:33:50 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Joshua Henderson <joshua.henderson@microchip.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 4/4] hwrng: pic32 - enable TRNG only while it's used
Date:   Tue,  4 Jul 2023 19:32:03 +0200
Message-Id: <20230704173203.70706-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230704173203.70706-1-martin@kaiser.cx>
References: <20230704173203.70706-1-martin@kaiser.cx>
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

The probe function enables the TRNG hardware before registering the
driver. If registration fails, probe returns an error, but the TRNG
remains enabled.

Define init and cleanup functions, enable and disable the hardware there.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/pic32-rng.c | 41 ++++++++++++++----------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/char/hw_random/pic32-rng.c b/drivers/char/hw_random/pic32-rng.c
index c1b3f5915f03..1902f4389a3f 100644
--- a/drivers/char/hw_random/pic32-rng.c
+++ b/drivers/char/hw_random/pic32-rng.c
@@ -38,6 +38,15 @@ struct pic32_rng {
  */
 #define RNG_TIMEOUT 500
 
+static int pic32_rng_init(struct hwrng *rng)
+{
+	struct pic32_rng *priv = container_of(rng, struct pic32_rng, rng);
+
+	/* enable TRNG in enhanced mode */
+	writel(TRNGEN | TRNGMOD, priv->base + RNGCON);
+	return 0;
+}
+
 static int pic32_rng_read(struct hwrng *rng, void *buf, size_t max,
 			  bool wait)
 {
@@ -59,12 +68,17 @@ static int pic32_rng_read(struct hwrng *rng, void *buf, size_t max,
 	return -EIO;
 }
 
+static void pic32_rng_cleanup(struct hwrng *rng)
+{
+	struct pic32_rng *priv = container_of(rng, struct pic32_rng, rng);
+
+	writel(0, priv->base + RNGCON);
+}
+
 static int pic32_rng_probe(struct platform_device *pdev)
 {
 	struct pic32_rng *priv;
 	struct clk *clk;
-	u32 v;
-	int ret;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -78,28 +92,12 @@ static int pic32_rng_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	/* enable TRNG in enhanced mode */
-	v = TRNGEN | TRNGMOD;
-	writel(v, priv->base + RNGCON);
-
 	priv->rng.name = pdev->name;
+	priv->rng.init = pic32_rng_init;
 	priv->rng.read = pic32_rng_read;
+	priv->rng.cleanup = pic32_rng_cleanup;
 
-	ret = devm_hwrng_register(&pdev->dev, &priv->rng);
-	if (ret)
-		return ret;
-
-	platform_set_drvdata(pdev, priv);
-
-	return 0;
-}
-
-static int pic32_rng_remove(struct platform_device *pdev)
-{
-	struct pic32_rng *rng = platform_get_drvdata(pdev);
-
-	writel(0, rng->base + RNGCON);
-	return 0;
+	return devm_hwrng_register(&pdev->dev, &priv->rng);
 }
 
 static const struct of_device_id pic32_rng_of_match[] __maybe_unused = {
@@ -110,7 +108,6 @@ MODULE_DEVICE_TABLE(of, pic32_rng_of_match);
 
 static struct platform_driver pic32_rng_driver = {
 	.probe		= pic32_rng_probe,
-	.remove		= pic32_rng_remove,
 	.driver		= {
 		.name	= "pic32-rng",
 		.of_match_table = of_match_ptr(pic32_rng_of_match),
-- 
2.30.2

