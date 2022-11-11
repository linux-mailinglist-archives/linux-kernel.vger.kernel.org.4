Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939556256C7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbiKKJ0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbiKKJ0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:26:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FD978785;
        Fri, 11 Nov 2022 01:26:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FC81B824A9;
        Fri, 11 Nov 2022 09:26:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A362EC433C1;
        Fri, 11 Nov 2022 09:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668158764;
        bh=DSsASXt+L3MVWR9JIQoZ+ghKyfK/dDKTRjA4nYf+2oA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R3sgsNRrRBY0wD6g2qXTlGlggaEeSNYB508i/8+RejqW3mvFvLtIG/b0MsY4LgTyr
         QOUVFew260Ku58gh4OoIh0SOgznHI9WuZ2cl/Z52lyObnFOJ0vhWogENzDXjqDtJlE
         48duHFTIvBn5ACbAuDXrL2tAjycr9mb/taD/+e8PmWRPviCvPGxMghBS3MY1TQbfN5
         O51uVEZxZ4kRP2W/8ov5ozA3lHZjxio7Ee3T+lk42uTujZDeu0fnlQFR9ivZranb09
         WPAWw6LfVW7KJRDjFCwuWGnyKxJjD9fDJaHOPotlh5+N6+TMWwelHH5P6xaVLmPB0P
         k1cM0D8EMjM8g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1otQI4-0002kv-Qx; Fri, 11 Nov 2022 10:25:36 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 04/14] phy: qcom-qmp-combo: restructure PHY creation
Date:   Fri, 11 Nov 2022 10:24:47 +0100
Message-Id: <20221111092457.10546-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221111092457.10546-1-johan+linaro@kernel.org>
References: <20221111092457.10546-1-johan+linaro@kernel.org>
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

Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 89 ++++++++++++-----------
 1 file changed, 48 insertions(+), 41 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index e6c7cf723b19..1bc8567a8605 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -2483,12 +2483,10 @@ static int phy_dp_clks_register(struct qmp_combo *qmp, struct device_node *np)
 	return devm_add_action_or_reset(qmp->dev, phy_clk_release_provider, np);
 }
 
-static int qmp_combo_create_dp(struct qmp_combo *qmp, struct device_node *np)
+static int qmp_combo_parse_dt_lecacy_dp(struct qmp_combo *qmp, struct device_node *np)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	struct device *dev = qmp->dev;
-	struct phy *generic_phy;
-	int ret;
 
 	/*
 	 * Get memory resources for each PHY:
@@ -2512,25 +2510,13 @@ static int qmp_combo_create_dp(struct qmp_combo *qmp, struct device_node *np)
 			return PTR_ERR(qmp->dp_tx2);
 	}
 
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
 	 * Get memory resources for each PHY:
@@ -2578,15 +2564,34 @@ static int qmp_combo_create_usb(struct qmp_combo *qmp, struct device_node *np)
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
@@ -2609,18 +2614,6 @@ static int qmp_combo_probe(struct platform_device *pdev)
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
@@ -2645,6 +2638,10 @@ static int qmp_combo_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	ret = qmp_combo_parse_dt_legacy(qmp, usb_np, dp_np);
+	if (ret)
+		goto err_node_put;
+
 	pm_runtime_set_active(dev);
 	ret = devm_pm_runtime_enable(dev);
 	if (ret)
@@ -2655,21 +2652,31 @@ static int qmp_combo_probe(struct platform_device *pdev)
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

