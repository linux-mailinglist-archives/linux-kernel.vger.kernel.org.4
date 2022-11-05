Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A4861DB7D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 16:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiKEPDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 11:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiKEPCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 11:02:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8CE10B55;
        Sat,  5 Nov 2022 08:02:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9750EB802C5;
        Sat,  5 Nov 2022 15:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2753CC4314F;
        Sat,  5 Nov 2022 15:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667660570;
        bh=UaJpUEbLZGW1YgFbVEBuV3PiJ/2kjT8GfCFOcFWI9uo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YBTh6Rke31ovsSLC57SM8mdYntGJASWHEEaTCTlli/bm12x4tVvLBpP64XnPWUFR5
         OrIzLF9AneeebI96iIM0aU9MSFkr2LFro9JJBp2rF2sEIfKssC1y+TGZxeKI4BQRuV
         wkUd4qtTxCZtXLyBau11r5cmHSYYn8bedFRvDd88ZwjBOC11qrjy56Pgemnbg8mSqb
         BfJdN/fcTJErvfDTSkdnD9iha1lXMvNVnBkCAzG/Jv9DYZnr7GouqPw9qnrI5DfHfR
         DYTSdtAvGRuinueSEnim95clyw2BzvwdWWnGdInIBsMbCvxfQcHj2L95YjwX4P5mur
         WXNC6O15LzXew==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1orKgp-0005KQ-2q; Sat, 05 Nov 2022 16:02:31 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v5 05/16] phy: qcom-qmp-pcie: clean up probe initialisation
Date:   Sat,  5 Nov 2022 15:59:28 +0100
Message-Id: <20221105145939.20318-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221105145939.20318-1-johan+linaro@kernel.org>
References: <20221105145939.20318-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop abusing the driver data pointer and instead pass the driver state
structure directly to the initialisation helpers during probe.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
2.37.4

