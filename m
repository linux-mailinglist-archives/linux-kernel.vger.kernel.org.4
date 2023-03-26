Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DCB6C944C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 14:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjCZMiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 08:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjCZMiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 08:38:00 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67C076A3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 05:37:58 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id gPd9pANE3TpvfgPd9p9CXS; Sun, 26 Mar 2023 14:37:56 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 26 Mar 2023 14:37:56 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH] iommu/exynos: Use the devm_clk_get_optional() helper
Date:   Sun, 26 Mar 2023 14:37:50 +0200
Message-Id: <99c0d5ce643737ee0952df41fd60433a0bbeb447.1679834256.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_clk_get_optional() instead of hand writing it.
This saves some loC and improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/iommu/exynos-iommu.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 483aaaeb6dae..867f409e0325 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -747,22 +747,16 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	data->clk = devm_clk_get(dev, "sysmmu");
-	if (PTR_ERR(data->clk) == -ENOENT)
-		data->clk = NULL;
-	else if (IS_ERR(data->clk))
+	data->clk = devm_clk_get_optional(dev, "sysmmu");
+	if (IS_ERR(data->clk))
 		return PTR_ERR(data->clk);
 
-	data->aclk = devm_clk_get(dev, "aclk");
-	if (PTR_ERR(data->aclk) == -ENOENT)
-		data->aclk = NULL;
-	else if (IS_ERR(data->aclk))
+	data->aclk = devm_clk_get_optional(dev, "aclk");
+	if (IS_ERR(data->aclk))
 		return PTR_ERR(data->aclk);
 
-	data->pclk = devm_clk_get(dev, "pclk");
-	if (PTR_ERR(data->pclk) == -ENOENT)
-		data->pclk = NULL;
-	else if (IS_ERR(data->pclk))
+	data->pclk = devm_clk_get_optional(dev, "pclk");
+	if (IS_ERR(data->pclk))
 		return PTR_ERR(data->pclk);
 
 	if (!data->clk && (!data->aclk || !data->pclk)) {
@@ -770,10 +764,8 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 		return -ENOSYS;
 	}
 
-	data->clk_master = devm_clk_get(dev, "master");
-	if (PTR_ERR(data->clk_master) == -ENOENT)
-		data->clk_master = NULL;
-	else if (IS_ERR(data->clk_master))
+	data->clk_master = devm_clk_get_optional(dev, "master");
+	if (IS_ERR(data->clk_master))
 		return PTR_ERR(data->clk_master);
 
 	data->sysmmu = dev;
-- 
2.34.1

