Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00096E36C1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 11:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjDPJpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 05:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjDPJpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 05:45:52 -0400
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E278270E
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 02:45:50 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id nyx8pERD6B8bjnyx8pG0XW; Sun, 16 Apr 2023 11:45:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
        s=t20230301; t=1681638348;
        bh=dXigaYMwb+m2xTiuf4ebRXnogGfAxTaA5Lp2S1H6688=;
        h=From:To:Cc:Subject:Date;
        b=Zmmc/sbB94VZ+7wayt/SSi8OckpymgDv2PTvp3KxkKDJjTkBYiYE9Be5z0V3LwaSF
         Q0V2u3ThYQBWM2VG2SfZMp4O6MzooqbHyLTB/i1upDYalEeeUU0u2IOx6RuNkuQ6bB
         n1zBQJp5H9gdlYR8GtbdYo3rGGWe2Qcs0rEFPmODGwFldLhc8g20uIGo8KOAhFwEJg
         IC+qBILIY3OLbkDBdo/+Exk5zZOWS88VaUjy8Au9pqUvxakcqugC2doQoQSv5STOhH
         KpvuJCHevmsXSLnTXKsC1vCxdoFSqYYbx7hQ9nIzQgnZDsCP1UZG7g7ZAGgHv+hLdr
         2jMMOi66asH0w==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 16 Apr 2023 11:45:48 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev
Subject: [PATCH] iommu/msm: Use the devm_clk_get_prepared() helper function
Date:   Sun, 16 Apr 2023 11:45:45 +0200
Message-Id: <14a5928a91fc8addf7f87a76428188ddc4271727.1681638224.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the devm_clk_get_prepared() helper function instead of hand-writing it.
It saves some lines of code.

It also makes the error handling path of the probe and the remove function
useless.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch has been cross-compiled only.
---
 drivers/iommu/msm_iommu.c | 62 ++++++++++-----------------------------
 1 file changed, 15 insertions(+), 47 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 79d89bad5132..5a9bbbd185cf 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -712,48 +712,30 @@ static int msm_iommu_probe(struct platform_device *pdev)
 	iommu->dev = &pdev->dev;
 	INIT_LIST_HEAD(&iommu->ctx_list);
 
-	iommu->pclk = devm_clk_get(iommu->dev, "smmu_pclk");
+	iommu->pclk = devm_clk_get_prepared(iommu->dev, "smmu_pclk");
 	if (IS_ERR(iommu->pclk))
 		return dev_err_probe(iommu->dev, PTR_ERR(iommu->pclk),
 				     "could not get smmu_pclk\n");
 
-	ret = clk_prepare(iommu->pclk);
-	if (ret)
-		return dev_err_probe(iommu->dev, ret,
-				     "could not prepare smmu_pclk\n");
-
-	iommu->clk = devm_clk_get(iommu->dev, "iommu_clk");
-	if (IS_ERR(iommu->clk)) {
-		clk_unprepare(iommu->pclk);
+	iommu->clk = devm_clk_get_prepared(iommu->dev, "iommu_clk");
+	if (IS_ERR(iommu->clk))
 		return dev_err_probe(iommu->dev, PTR_ERR(iommu->clk),
 				     "could not get iommu_clk\n");
-	}
-
-	ret = clk_prepare(iommu->clk);
-	if (ret) {
-		clk_unprepare(iommu->pclk);
-		return dev_err_probe(iommu->dev, ret, "could not prepare iommu_clk\n");
-	}
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	iommu->base = devm_ioremap_resource(iommu->dev, r);
-	if (IS_ERR(iommu->base)) {
-		ret = dev_err_probe(iommu->dev, PTR_ERR(iommu->base), "could not get iommu base\n");
-		goto fail;
-	}
+	if (IS_ERR(iommu->base))
+		return dev_err_probe(iommu->dev, PTR_ERR(iommu->base),
+				     "could not get iommu base\n");
 	ioaddr = r->start;
 
 	iommu->irq = platform_get_irq(pdev, 0);
-	if (iommu->irq < 0) {
-		ret = -ENODEV;
-		goto fail;
-	}
+	if (iommu->irq < 0)
+		return -ENODEV;
 
 	ret = of_property_read_u32(iommu->dev->of_node, "qcom,ncb", &val);
-	if (ret) {
-		dev_err(iommu->dev, "could not get ncb\n");
-		goto fail;
-	}
+	if (ret)
+		return dev_err_probe(iommu->dev, ret, "could not get ncb\n");
 	iommu->ncb = val;
 
 	msm_iommu_reset(iommu->base, iommu->ncb);
@@ -767,8 +749,7 @@ static int msm_iommu_probe(struct platform_device *pdev)
 
 	if (!par) {
 		pr_err("Invalid PAR value detected\n");
-		ret = -ENODEV;
-		goto fail;
+		return -ENODEV;
 	}
 
 	ret = devm_request_threaded_irq(iommu->dev, iommu->irq, NULL,
@@ -778,7 +759,7 @@ static int msm_iommu_probe(struct platform_device *pdev)
 					iommu);
 	if (ret) {
 		pr_err("Request IRQ %d failed with ret=%d\n", iommu->irq, ret);
-		goto fail;
+		return ret;
 	}
 
 	list_add(&iommu->dev_node, &qcom_iommu_devices);
@@ -787,23 +768,19 @@ static int msm_iommu_probe(struct platform_device *pdev)
 				     "msm-smmu.%pa", &ioaddr);
 	if (ret) {
 		pr_err("Could not add msm-smmu at %pa to sysfs\n", &ioaddr);
-		goto fail;
+		return ret;
 	}
 
 	ret = iommu_device_register(&iommu->iommu, &msm_iommu_ops, &pdev->dev);
 	if (ret) {
 		pr_err("Could not register msm-smmu at %pa\n", &ioaddr);
-		goto fail;
+		return ret;
 	}
 
 	pr_info("device mapped at %p, irq %d with %d ctx banks\n",
 		iommu->base, iommu->irq, iommu->ncb);
 
-	return ret;
-fail:
-	clk_unprepare(iommu->clk);
-	clk_unprepare(iommu->pclk);
-	return ret;
+	return 0;
 }
 
 static const struct of_device_id msm_iommu_dt_match[] = {
@@ -811,20 +788,11 @@ static const struct of_device_id msm_iommu_dt_match[] = {
 	{}
 };
 
-static void msm_iommu_remove(struct platform_device *pdev)
-{
-	struct msm_iommu_dev *iommu = platform_get_drvdata(pdev);
-
-	clk_unprepare(iommu->clk);
-	clk_unprepare(iommu->pclk);
-}
-
 static struct platform_driver msm_iommu_driver = {
 	.driver = {
 		.name	= "msm_iommu",
 		.of_match_table = msm_iommu_dt_match,
 	},
 	.probe		= msm_iommu_probe,
-	.remove_new	= msm_iommu_remove,
 };
 builtin_platform_driver(msm_iommu_driver);
-- 
2.34.1

