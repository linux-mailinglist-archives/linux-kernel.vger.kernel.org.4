Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45529609D58
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiJXJCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJXJBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:01:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622F94DB46;
        Mon, 24 Oct 2022 02:01:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E44DF61090;
        Mon, 24 Oct 2022 09:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA06C43147;
        Mon, 24 Oct 2022 09:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666602097;
        bh=kUu1wS6SClje+mygFdWFEMGHxt8IMZqWUdrDHplK5nY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dvo6dhROYScXXqv0k2xgGWLSEeqM6ukZdFGsRK4Z0Mnpr4aAidbU3mSDuKq3PFiwy
         5NIJojb+xTo15iRn0PyhN0LCbzoNxFwxLOj1D5K9TQOOCjxhL+w/LoAHo8jg9adzq6
         BJFssNvdQmcT1+Jv1JPEwVLiVkI5OGRWt1Z2p1BYJo9YKMpe8rf5fp1utslcyoQihs
         VQhyD+MiXbmkJPgb1mzskEj4hJhFheroEmiDdAiSAN+eZS3kXHkaf4LvA95ZZ96aQu
         cZglcLoumMk36/Zt3QcwhH7cqqgQ16XlrYFQu0KvaRG9Cyd/iaXxHmPTdluSOSNbC3
         oZJkssKTDICEA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1omtKj-00056T-Ao; Mon, 24 Oct 2022 11:01:21 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 04/10] phy: qcom-qmp-ufs: clean up probe initialisation
Date:   Mon, 24 Oct 2022 11:00:35 +0200
Message-Id: <20221024090041.19574-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024090041.19574-1-johan+linaro@kernel.org>
References: <20221024090041.19574-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop abusing the driver data pointer and instead pass the driver state
structure directly to the initialisation helpers during probe.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 37 ++++++++++++-------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 25744b3576f3..057f9a3fdd6d 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -945,9 +945,10 @@ static int qmp_ufs_disable(struct phy *phy)
 	return qmp_ufs_exit(phy);
 }
 
-static int qmp_ufs_vreg_init(struct device *dev, const struct qmp_phy_cfg *cfg)
+static int qmp_ufs_vreg_init(struct qmp_ufs *qmp)
 {
-	struct qmp_ufs *qmp = dev_get_drvdata(dev);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	struct device *dev = qmp->dev;
 	int num = cfg->num_vregs;
 	int i;
 
@@ -961,9 +962,10 @@ static int qmp_ufs_vreg_init(struct device *dev, const struct qmp_phy_cfg *cfg)
 	return devm_regulator_bulk_get(dev, num, qmp->vregs);
 }
 
-static int qmp_ufs_clk_init(struct device *dev, const struct qmp_phy_cfg *cfg)
+static int qmp_ufs_clk_init(struct qmp_ufs *qmp)
 {
-	struct qmp_ufs *qmp = dev_get_drvdata(dev);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	struct device *dev = qmp->dev;
 	int num = cfg->num_clks;
 	int i;
 
@@ -983,15 +985,13 @@ static const struct phy_ops qcom_qmp_ufs_ops = {
 	.owner		= THIS_MODULE,
 };
 
-static int qmp_ufs_create(struct device *dev, struct device_node *np,
-			void __iomem *serdes, const struct qmp_phy_cfg *cfg)
+static int qmp_ufs_create(struct qmp_ufs *qmp, struct device_node *np)
 {
-	struct qmp_ufs *qmp = dev_get_drvdata(dev);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	struct device *dev = qmp->dev;
 	struct phy *generic_phy;
 	int ret;
 
-	qmp->cfg = cfg;
-	qmp->serdes = serdes;
 	/*
 	 * Get memory resources for the PHY:
 	 * Resources are indexed as: tx -> 0; rx -> 1; pcs -> 2.
@@ -1045,8 +1045,6 @@ static int qmp_ufs_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *child;
 	struct phy_provider *phy_provider;
-	void __iomem *serdes;
-	const struct qmp_phy_cfg *cfg = NULL;
 	struct qmp_ufs *qmp;
 	int ret;
 
@@ -1055,21 +1053,20 @@ static int qmp_ufs_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	qmp->dev = dev;
-	dev_set_drvdata(dev, qmp);
 
-	cfg = of_device_get_match_data(dev);
-	if (!cfg)
+	qmp->cfg = of_device_get_match_data(dev);
+	if (!qmp->cfg)
 		return -EINVAL;
 
-	serdes = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(serdes))
-		return PTR_ERR(serdes);
+	qmp->serdes = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(qmp->serdes))
+		return PTR_ERR(qmp->serdes);
 
-	ret = qmp_ufs_clk_init(dev, cfg);
+	ret = qmp_ufs_clk_init(qmp);
 	if (ret)
 		return ret;
 
-	ret = qmp_ufs_vreg_init(dev, cfg);
+	ret = qmp_ufs_vreg_init(qmp);
 	if (ret)
 		return ret;
 
@@ -1077,7 +1074,7 @@ static int qmp_ufs_probe(struct platform_device *pdev)
 	if (!child)
 		return -EINVAL;
 
-	ret = qmp_ufs_create(dev, child, serdes, cfg);
+	ret = qmp_ufs_create(qmp, child);
 	if (ret)
 		goto err_node_put;
 
-- 
2.37.3

