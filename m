Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BEB60122E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 17:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiJQPAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 11:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiJQO6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:58:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7FD6B67C;
        Mon, 17 Oct 2022 07:56:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D2C7B818FF;
        Mon, 17 Oct 2022 14:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94CEC43144;
        Mon, 17 Oct 2022 14:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666018478;
        bh=X8dGKcEatEcWeJmdLOuulVQ9QOL8lBrkv9IoBNpoAeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qqpNC7B874/uqH4V8Y83zmAndAVovma0aZyhPci19XN5yVIejT7BcM8d/fIVyaI6x
         +/h1fINT3JiK2oC1HMlbok0MMyj0dLDoGGNUQHDcpv/ytX6UM+ElwG/vlkQKExTN8H
         XNg2Asz3r+KDdFQAkH4uKrBXW0p1OkxJp0TQi+pO7WFVA4B5xb9SK0hUU6ORMA3nXj
         bjLlG+BpLZi20D20rDb6jSp9ZeI44AHKtljUWHYGHo0CctGm9wAC7ymUMsZAywOABo
         3hFTuPac9Ec0o8ImjmHHBTve4o3CgvNTdFcxPpa+WDdHobdI00SawT2mloL6exJhg4
         Zk/0215eZPw9w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1okRVc-0005m7-SE; Mon, 17 Oct 2022 16:54:28 +0200
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
Subject: [PATCH 05/15] phy: qcom-qmp-pcie: clean up probe initialisation
Date:   Mon, 17 Oct 2022 16:53:18 +0200
Message-Id: <20221017145328.22090-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221017145328.22090-1-johan+linaro@kernel.org>
References: <20221017145328.22090-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 49 +++++++++++-------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index bc96518ad6b0..e30cbc94cbf6 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -2037,9 +2037,10 @@ static int qmp_pcie_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	return 0;
 }
 
-static int qmp_pcie_vreg_init(struct device *dev, const struct qmp_phy_cfg *cfg)
+static int qmp_pcie_vreg_init(struct qmp_pcie *qmp)
 {
-	struct qmp_pcie *qmp = dev_get_drvdata(dev);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	struct device *dev = qmp->dev;
 	int num = cfg->num_vregs;
 	int i;
 
@@ -2053,9 +2054,10 @@ static int qmp_pcie_vreg_init(struct device *dev, const struct qmp_phy_cfg *cfg)
 	return devm_regulator_bulk_get(dev, num, qmp->vregs);
 }
 
-static int qmp_pcie_reset_init(struct device *dev, const struct qmp_phy_cfg *cfg)
+static int qmp_pcie_reset_init(struct qmp_pcie *qmp)
 {
-	struct qmp_pcie *qmp = dev_get_drvdata(dev);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	struct device *dev = qmp->dev;
 	int i;
 	int ret;
 
@@ -2074,9 +2076,10 @@ static int qmp_pcie_reset_init(struct device *dev, const struct qmp_phy_cfg *cfg
 	return 0;
 }
 
-static int qmp_pcie_clk_init(struct device *dev, const struct qmp_phy_cfg *cfg)
+static int qmp_pcie_clk_init(struct qmp_pcie *qmp)
 {
-	struct qmp_pcie *qmp = dev_get_drvdata(dev);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	struct device *dev = qmp->dev;
 	int num = cfg->num_clks;
 	int i;
 
@@ -2164,18 +2167,15 @@ static const struct phy_ops qmp_pcie_ops = {
 	.owner		= THIS_MODULE,
 };
 
-static int qmp_pcie_create(struct device *dev, struct device_node *np,
-			void __iomem *serdes, const struct qmp_phy_cfg *cfg)
+static int qmp_pcie_create(struct qmp_pcie *qmp, struct device_node *np)
 {
-	struct qmp_pcie *qmp = dev_get_drvdata(dev);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	struct device *dev = qmp->dev;
 	struct phy *generic_phy;
 	int ret;
 
 	qmp->mode = PHY_MODE_PCIE_RC;
 
-	qmp->cfg = cfg;
-	qmp->serdes = serdes;
-
 	/*
 	 * Get memory resources for the PHY:
 	 * Resources are indexed as: tx -> 0; rx -> 1; pcs -> 2.
@@ -2247,8 +2247,6 @@ static int qmp_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *child;
 	struct phy_provider *phy_provider;
-	void __iomem *serdes;
-	const struct qmp_phy_cfg *cfg = NULL;
 	struct qmp_pcie *qmp;
 	int ret;
 
@@ -2257,28 +2255,27 @@ static int qmp_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	qmp->dev = dev;
-	dev_set_drvdata(dev, qmp);
 
-	cfg = of_device_get_match_data(dev);
-	if (!cfg)
+	qmp->cfg = of_device_get_match_data(dev);
+	if (!qmp->cfg)
 		return -EINVAL;
 
-	WARN_ON_ONCE(!cfg->pwrdn_ctrl);
-	WARN_ON_ONCE(!cfg->phy_status);
+	WARN_ON_ONCE(!qmp->cfg->pwrdn_ctrl);
+	WARN_ON_ONCE(!qmp->cfg->phy_status);
 
-	serdes = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(serdes))
-		return PTR_ERR(serdes);
+	qmp->serdes = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(qmp->serdes))
+		return PTR_ERR(qmp->serdes);
 
-	ret = qmp_pcie_clk_init(dev, cfg);
+	ret = qmp_pcie_clk_init(qmp);
 	if (ret)
 		return ret;
 
-	ret = qmp_pcie_reset_init(dev, cfg);
+	ret = qmp_pcie_reset_init(qmp);
 	if (ret)
 		return ret;
 
-	ret = qmp_pcie_vreg_init(dev, cfg);
+	ret = qmp_pcie_vreg_init(qmp);
 	if (ret)
 		return ret;
 
@@ -2286,7 +2283,7 @@ static int qmp_pcie_probe(struct platform_device *pdev)
 	if (!child)
 		return -EINVAL;
 
-	ret = qmp_pcie_create(dev, child, serdes, cfg);
+	ret = qmp_pcie_create(qmp, child);
 	if (ret)
 		goto err_node_put;
 
-- 
2.37.3

