Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360CA7477BB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 19:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjGDRYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 13:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGDRYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 13:24:37 -0400
X-Greylist: delayed 636 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Jul 2023 10:24:35 PDT
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6558E10D5;
        Tue,  4 Jul 2023 10:24:35 -0700 (PDT)
Received: from ipservice-092-217-072-126.092.217.pools.vodafone-ip.de ([92.217.72.126] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qGjb8-0000oy-J7; Tue, 04 Jul 2023 19:13:54 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] hwrng: exynos - switch to DEFINE_SIMPLE_DEV_PM_OPS
Date:   Tue,  4 Jul 2023 19:10:51 +0200
Message-Id: <20230704171051.69763-1-martin@kaiser.cx>
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

SIMPLE_DEV_PM_OPS is deprecated, replace it with DEFINE_SIMPLE_DEV_PM_OPS
and use pm_sleep_ptr for setting the driver's pm routines. We can now
remove the __maybe_unused qualifier in the suspend and resume functions.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
compile-tested only

 drivers/char/hw_random/exynos-trng.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/hw_random/exynos-trng.c b/drivers/char/hw_random/exynos-trng.c
index 9cc3d542dd0f..30207b7ac5f4 100644
--- a/drivers/char/hw_random/exynos-trng.c
+++ b/drivers/char/hw_random/exynos-trng.c
@@ -185,14 +185,14 @@ static int exynos_trng_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused exynos_trng_suspend(struct device *dev)
+static int exynos_trng_suspend(struct device *dev)
 {
 	pm_runtime_put_sync(dev);
 
 	return 0;
 }
 
-static int __maybe_unused exynos_trng_resume(struct device *dev)
+static int exynos_trng_resume(struct device *dev)
 {
 	int ret;
 
@@ -205,7 +205,7 @@ static int __maybe_unused exynos_trng_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(exynos_trng_pm_ops, exynos_trng_suspend,
+static DEFINE_SIMPLE_DEV_PM_OPS(exynos_trng_pm_ops, exynos_trng_suspend,
 			 exynos_trng_resume);
 
 static const struct of_device_id exynos_trng_dt_match[] = {
@@ -219,7 +219,7 @@ MODULE_DEVICE_TABLE(of, exynos_trng_dt_match);
 static struct platform_driver exynos_trng_driver = {
 	.driver = {
 		.name = "exynos-trng",
-		.pm = &exynos_trng_pm_ops,
+		.pm = pm_sleep_ptr(&exynos_trng_pm_ops),
 		.of_match_table = exynos_trng_dt_match,
 	},
 	.probe = exynos_trng_probe,
-- 
2.30.2

