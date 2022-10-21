Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6E56075CB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 13:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiJULLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 07:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiJULKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 07:10:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBB0130D58;
        Fri, 21 Oct 2022 04:10:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1CA061E68;
        Fri, 21 Oct 2022 11:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8E5C4FEBA;
        Fri, 21 Oct 2022 11:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666350644;
        bh=3KMG8nKUfsK556dcluPR1X8C5si2ibVB5wsNOm4GQn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PrTCtP7RZxpyUxgeG3Rm4Ezts/1R8N7MDil3tGUFKtcBfQM1CnmFwMmBMGcg/huZf
         JzUx/l77y8+QBOJYS/N6rYPQX+5YRNbDQak9Cc2byW8qUXyivFebukFfYQjNHFIXZa
         PWdrOeblMfRXyFlhhlZNwdfVaFJrA7ZFCkeGfQhUCEATNiZsjNcmCIrVQ9jnn80ab2
         rg6G2O8YWtmSGMlMruCDTxa0r7V7LcR6ul2WAWbWr8mLRjg/Sb9HHREKCEDHA3vUv/
         YrZ9n83Tlf0LPu6najJVFZtsN7K5C+HqODepmYPVGugxLl8TzbqiaACMx9Acub+uOH
         TM/vsYyqeEjPQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1olpv5-0007Kw-91; Fri, 21 Oct 2022 13:10:31 +0200
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
Subject: [PATCH v3 11/15] phy: qcom-qmp-pcie: restructure PHY creation
Date:   Fri, 21 Oct 2022 13:09:43 +0200
Message-Id: <20221021110947.28103-12-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221021110947.28103-1-johan+linaro@kernel.org>
References: <20221021110947.28103-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for supporting devicetree bindings which do not use a
child node, move the PHY creation to probe() proper and parse the serdes
resource in what is now the legacy devicetree helper.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 36 +++++++++++-------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index f57d10f20277..2f4bdef73395 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -2147,14 +2147,15 @@ static int phy_pipe_clk_register(struct qmp_pcie *qmp, struct device_node *np)
 	return devm_add_action_or_reset(qmp->dev, phy_clk_release_provider, np);
 }
 
-static int qmp_pcie_create(struct qmp_pcie *qmp, struct device_node *np)
+static int qmp_pcie_parse_dt_legacy(struct qmp_pcie *qmp, struct device_node *np)
 {
+	struct platform_device *pdev = to_platform_device(qmp->dev);
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	struct device *dev = qmp->dev;
-	struct phy *generic_phy;
-	int ret;
 
-	qmp->mode = PHY_MODE_PCIE_RC;
+	qmp->serdes = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(qmp->serdes))
+		return PTR_ERR(qmp->serdes);
 
 	/*
 	 * Get memory resources for the PHY:
@@ -2209,16 +2210,6 @@ static int qmp_pcie_create(struct qmp_pcie *qmp, struct device_node *np)
 				     "failed to get pipe clock\n");
 	}
 
-	generic_phy = devm_phy_create(dev, np, &qmp_pcie_phy_ops);
-	if (IS_ERR(generic_phy)) {
-		ret = PTR_ERR(generic_phy);
-		dev_err(dev, "failed to create PHY: %d\n", ret);
-		return ret;
-	}
-
-	qmp->phy = generic_phy;
-	phy_set_drvdata(generic_phy, qmp);
-
 	return 0;
 }
 
@@ -2243,10 +2234,6 @@ static int qmp_pcie_probe(struct platform_device *pdev)
 	WARN_ON_ONCE(!qmp->cfg->pwrdn_ctrl);
 	WARN_ON_ONCE(!qmp->cfg->phy_status);
 
-	qmp->serdes = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(qmp->serdes))
-		return PTR_ERR(qmp->serdes);
-
 	ret = qmp_pcie_clk_init(qmp);
 	if (ret)
 		return ret;
@@ -2263,7 +2250,7 @@ static int qmp_pcie_probe(struct platform_device *pdev)
 	if (!child)
 		return -EINVAL;
 
-	ret = qmp_pcie_create(qmp, child);
+	ret = qmp_pcie_parse_dt_legacy(qmp, child);
 	if (ret)
 		goto err_node_put;
 
@@ -2271,6 +2258,17 @@ static int qmp_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_node_put;
 
+	qmp->mode = PHY_MODE_PCIE_RC;
+
+	qmp->phy = devm_phy_create(dev, child, &qmp_pcie_phy_ops);
+	if (IS_ERR(qmp->phy)) {
+		ret = PTR_ERR(qmp->phy);
+		dev_err(dev, "failed to create PHY: %d\n", ret);
+		goto err_node_put;
+	}
+
+	phy_set_drvdata(qmp->phy, qmp);
+
 	of_node_put(child);
 
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
-- 
2.37.3

