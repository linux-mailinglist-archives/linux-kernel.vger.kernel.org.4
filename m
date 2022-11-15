Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981F7629C5F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237900AbiKOOlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiKOOky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:40:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5E723173;
        Tue, 15 Nov 2022 06:40:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AE38617D7;
        Tue, 15 Nov 2022 14:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581AEC4347C;
        Tue, 15 Nov 2022 14:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668523252;
        bh=RD0ClmUmxYYlwRNJhu/83cib/wDXg9GnJNKnNdHDLho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lxuAihXfmJu2U7YJE5MpdCiO9jwh6z/+Kbs0dzbOsxw8/WQesSDxHaQNADmHcIlVu
         7jNJl/GTTgNSpziGkaT8kbIdtud6b18yClYpTJFIuUlTAH7ylOjTspYnk4nVitITz5
         53+9QS7OfZaMIBH8KJXJ9DVl7RtWVaOE6JQ5S4n/6pDr2faoTXd3oCwiD6ygCDxF0r
         SCcDaq1FqopyZnJhB+tlDTFtPUsMi02EaGisFE1Km7ctzNkZ3kqdCfzPzCXL5Qel7K
         NWsDqbP2SB01ORvgkJzJb0x08Mk5DTFi/SHg3Kr0ojvlWkqJZYrHRx/lQD4iSzxou5
         xRm7rYt5rjgug==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oux6s-0000fR-Qn; Tue, 15 Nov 2022 15:40:22 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 04/15] phy: qcom-qmp-combo: restructure PHY creation
Date:   Tue, 15 Nov 2022 15:39:54 +0100
Message-Id: <20221115144005.2478-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221115144005.2478-1-johan+linaro@kernel.org>
References: <20221115144005.2478-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for supporting devicetree bindings which do not use child
nodes, move the PHY creation to probe() proper and parse the serdes,
dp_com and dp_serdes resources in a dedicated legacy devicetree helper.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 89 ++++++++++++-----------
 1 file changed, 48 insertions(+), 41 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 5da42a4e5bf6..85def6560e43 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -2471,11 +2471,9 @@ static int phy_dp_clks_register(struct qmp_combo *qmp, struct device_node *np)
 	return devm_add_action_or_reset(qmp->dev, phy_clk_release_provider, np);
 }
 
-static int qmp_combo_create_dp(struct qmp_combo *qmp, struct device_node *np)
+static int qmp_combo_parse_dt_lecacy_dp(struct qmp_combo *qmp, struct device_node *np)
 {
 	struct device *dev = qmp->dev;
-	struct phy *generic_phy;
-	int ret;
 
 	/*
 	 * Get memory resources from the DP child node:
@@ -2496,25 +2494,13 @@ static int qmp_combo_create_dp(struct qmp_combo *qmp, struct device_node *np)
 	if (IS_ERR(qmp->dp_tx2))
 		return PTR_ERR(qmp->dp_tx2);
 
-	generic_phy = devm_phy_create(dev, np, &qmp_combo_dp_phy_ops);
-	if (IS_ERR(generic_phy)) {
-		ret = PTR_ERR(generic_phy);
-		dev_err(dev, "failed to create DP PHY: %d\n", ret);
-		return ret;
-	}
-
-	qmp->dp_phy = generic_phy;
-	phy_set_drvdata(generic_phy, qmp);
-
 	return 0;
 }
 
-static int qmp_combo_create_usb(struct qmp_combo *qmp, struct device_node *np)
+static int qmp_combo_parse_dt_lecacy_usb(struct qmp_combo *qmp, struct device_node *np)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	struct device *dev = qmp->dev;
-	struct phy *generic_phy;
-	int ret;
 
 	/*
 	 * Get memory resources from the USB child node:
@@ -2556,15 +2542,34 @@ static int qmp_combo_create_usb(struct qmp_combo *qmp, struct device_node *np)
 				     "failed to get pipe clock\n");
 	}
 
-	generic_phy = devm_phy_create(dev, np, &qmp_combo_usb_phy_ops);
-	if (IS_ERR(generic_phy)) {
-		ret = PTR_ERR(generic_phy);
-		dev_err(dev, "failed to create USB PHY: %d\n", ret);
+	return 0;
+}
+
+static int qmp_combo_parse_dt_legacy(struct qmp_combo *qmp, struct device_node *usb_np,
+					struct device_node *dp_np)
+{
+	struct platform_device *pdev = to_platform_device(qmp->dev);
+	int ret;
+
+	qmp->serdes = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(qmp->serdes))
+		return PTR_ERR(qmp->serdes);
+
+	qmp->dp_com = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(qmp->dp_com))
+		return PTR_ERR(qmp->dp_com);
+
+	qmp->dp_serdes = devm_platform_ioremap_resource(pdev, 2);
+	if (IS_ERR(qmp->dp_serdes))
+		return PTR_ERR(qmp->dp_serdes);
+
+	ret = qmp_combo_parse_dt_lecacy_usb(qmp, usb_np);
+	if (ret)
 		return ret;
-	}
 
-	qmp->usb_phy = generic_phy;
-	phy_set_drvdata(generic_phy, qmp);
+	ret = qmp_combo_parse_dt_lecacy_dp(qmp, dp_np);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -2587,18 +2592,6 @@ static int qmp_combo_probe(struct platform_device *pdev)
 	if (!qmp->cfg)
 		return -EINVAL;
 
-	qmp->serdes = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(qmp->serdes))
-		return PTR_ERR(qmp->serdes);
-
-	qmp->dp_com = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(qmp->dp_com))
-		return PTR_ERR(qmp->dp_com);
-
-	qmp->dp_serdes = devm_platform_ioremap_resource(pdev, 2);
-	if (IS_ERR(qmp->dp_serdes))
-		return PTR_ERR(qmp->dp_serdes);
-
 	mutex_init(&qmp->phy_mutex);
 
 	ret = qmp_combo_clk_init(qmp);
@@ -2623,6 +2616,10 @@ static int qmp_combo_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	ret = qmp_combo_parse_dt_legacy(qmp, usb_np, dp_np);
+	if (ret)
+		goto err_node_put;
+
 	pm_runtime_set_active(dev);
 	ret = devm_pm_runtime_enable(dev);
 	if (ret)
@@ -2633,21 +2630,31 @@ static int qmp_combo_probe(struct platform_device *pdev)
 	 */
 	pm_runtime_forbid(dev);
 
-	ret = qmp_combo_create_usb(qmp, usb_np);
+	ret = phy_pipe_clk_register(qmp, usb_np);
 	if (ret)
 		goto err_node_put;
 
-	ret = phy_pipe_clk_register(qmp, usb_np);
+	ret = phy_dp_clks_register(qmp, dp_np);
 	if (ret)
 		goto err_node_put;
 
-	ret = qmp_combo_create_dp(qmp, dp_np);
-	if (ret)
+	qmp->usb_phy = devm_phy_create(dev, usb_np, &qmp_combo_usb_phy_ops);
+	if (IS_ERR(qmp->usb_phy)) {
+		ret = PTR_ERR(qmp->usb_phy);
+		dev_err(dev, "failed to create USB PHY: %d\n", ret);
 		goto err_node_put;
+	}
 
-	ret = phy_dp_clks_register(qmp, dp_np);
-	if (ret)
+	phy_set_drvdata(qmp->usb_phy, qmp);
+
+	qmp->dp_phy = devm_phy_create(dev, dp_np, &qmp_combo_dp_phy_ops);
+	if (IS_ERR(qmp->dp_phy)) {
+		ret = PTR_ERR(qmp->dp_phy);
+		dev_err(dev, "failed to create DP PHY: %d\n", ret);
 		goto err_node_put;
+	}
+
+	phy_set_drvdata(qmp->dp_phy, qmp);
 
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
 
-- 
2.37.4

