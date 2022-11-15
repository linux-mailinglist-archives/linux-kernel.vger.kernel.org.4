Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522A7629C6A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237725AbiKOOlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiKOOkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:40:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0003A2792A;
        Tue, 15 Nov 2022 06:40:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 940A9617DA;
        Tue, 15 Nov 2022 14:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90408C4315F;
        Tue, 15 Nov 2022 14:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668523252;
        bh=xBE3xRLPSUJdKiquHXqse0uzhf1AkKR2IvO/OpTcHpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bQYyRLGKF4E9ZDPNbfw6IlQkqSHAKqIkFkQk5iyKU2Zg8jhN6j0g25swUq/Sr1ACa
         KtuCPo7FEcmj5OaOIJBTKuqpJg9B85F7zeGL/hjabaSf0OVgWPr5OYJ+9lu4Oa2NKS
         qZ5IO95XjfArLgmg5msdOzDO8KyGi0PNEnvbBW5rH4tHaoVYXEiaDZClJOQYsrcdbQ
         hZ3FE+2AfE4iL2NqxBYI9iz3GtRix2TpFBzfvr6XB/RUDcUE5apRLzEvN7iP+uRkA9
         s6XOtPvMovBllLssbXZqWnxas1QxR95HGe0KougABK3ttlCZgU7uSuuki+96ZY8CqX
         3+EtuUKTuhEZQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oux6s-0000fX-VX; Tue, 15 Nov 2022 15:40:23 +0100
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
Subject: [PATCH v2 06/15] phy: qcom-qmp-combo: drop redundant clock structure
Date:   Tue, 15 Nov 2022 15:39:56 +0100
Message-Id: <20221115144005.2478-7-johan+linaro@kernel.org>
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

Drop the unnecessary DP clock structure and instead store the clocks
directly in the driver data.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 52 ++++++++---------------
 1 file changed, 17 insertions(+), 35 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 7434955c8898..ebfefecffd86 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -859,12 +859,6 @@ struct qmp_phy_cfg {
 
 };
 
-struct qmp_phy_dp_clks {
-	struct qmp_combo *qmp;
-	struct clk_hw dp_link_hw;
-	struct clk_hw dp_pixel_hw;
-};
-
 struct qmp_combo {
 	struct device *dev;
 
@@ -900,7 +894,9 @@ struct qmp_combo {
 	struct phy *dp_phy;
 	unsigned int dp_aux_cfg;
 	struct phy_configure_opts_dp dp_opts;
-	struct qmp_phy_dp_clks *dp_clks;
+
+	struct clk_hw dp_link_hw;
+	struct clk_hw dp_pixel_hw;
 };
 
 static void qmp_v3_dp_aux_init(struct qmp_combo *qmp);
@@ -1387,7 +1383,6 @@ static bool qmp_combo_configure_dp_mode(struct qmp_combo *qmp)
 
 static int qmp_v3_configure_dp_phy(struct qmp_combo *qmp)
 {
-	const struct qmp_phy_dp_clks *dp_clks = qmp->dp_clks;
 	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
 	u32 phy_vco_div, status;
 	unsigned long pixel_freq;
@@ -1420,8 +1415,8 @@ static int qmp_v3_configure_dp_phy(struct qmp_combo *qmp)
 	}
 	writel(phy_vco_div, qmp->dp_pcs + QSERDES_V3_DP_PHY_VCO_DIV);
 
-	clk_set_rate(dp_clks->dp_link_hw.clk, dp_opts->link_rate * 100000);
-	clk_set_rate(dp_clks->dp_pixel_hw.clk, pixel_freq);
+	clk_set_rate(qmp->dp_link_hw.clk, dp_opts->link_rate * 100000);
+	clk_set_rate(qmp->dp_pixel_hw.clk, pixel_freq);
 
 	writel(0x04, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG2);
 	writel(0x01, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
@@ -1518,7 +1513,6 @@ static void qmp_v4_configure_dp_tx(struct qmp_combo *qmp)
 
 static int qmp_v45_configure_dp_phy(struct qmp_combo *qmp)
 {
-	const struct qmp_phy_dp_clks *dp_clks = qmp->dp_clks;
 	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
 	u32 phy_vco_div, status;
 	unsigned long pixel_freq;
@@ -1556,8 +1550,8 @@ static int qmp_v45_configure_dp_phy(struct qmp_combo *qmp)
 	}
 	writel(phy_vco_div, qmp->dp_pcs + QSERDES_V4_DP_PHY_VCO_DIV);
 
-	clk_set_rate(dp_clks->dp_link_hw.clk, dp_opts->link_rate * 100000);
-	clk_set_rate(dp_clks->dp_pixel_hw.clk, pixel_freq);
+	clk_set_rate(qmp->dp_link_hw.clk, dp_opts->link_rate * 100000);
+	clk_set_rate(qmp->dp_pixel_hw.clk, pixel_freq);
 
 	writel(0x01, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
 	writel(0x05, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
@@ -2342,12 +2336,10 @@ static int qcom_qmp_dp_pixel_clk_determine_rate(struct clk_hw *hw,
 static unsigned long
 qcom_qmp_dp_pixel_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 {
-	const struct qmp_phy_dp_clks *dp_clks;
 	const struct qmp_combo *qmp;
 	const struct phy_configure_opts_dp *dp_opts;
 
-	dp_clks = container_of(hw, struct qmp_phy_dp_clks, dp_pixel_hw);
-	qmp = dp_clks->qmp;
+	qmp = container_of(hw, struct qmp_combo, dp_pixel_hw);
 	dp_opts = &qmp->dp_opts;
 
 	switch (dp_opts->link_rate) {
@@ -2386,12 +2378,10 @@ static int qcom_qmp_dp_link_clk_determine_rate(struct clk_hw *hw,
 static unsigned long
 qcom_qmp_dp_link_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 {
-	const struct qmp_phy_dp_clks *dp_clks;
 	const struct qmp_combo *qmp;
 	const struct phy_configure_opts_dp *dp_opts;
 
-	dp_clks = container_of(hw, struct qmp_phy_dp_clks, dp_link_hw);
-	qmp = dp_clks->qmp;
+	qmp = container_of(hw, struct qmp_combo, dp_link_hw);
 	dp_opts = &qmp->dp_opts;
 
 	switch (dp_opts->link_rate) {
@@ -2413,7 +2403,7 @@ static const struct clk_ops qcom_qmp_dp_link_clk_ops = {
 static struct clk_hw *
 qcom_qmp_dp_clks_hw_get(struct of_phandle_args *clkspec, void *data)
 {
-	struct qmp_phy_dp_clks *dp_clks = data;
+	struct qmp_combo *qmp = data;
 	unsigned int idx = clkspec->args[0];
 
 	if (idx >= 2) {
@@ -2422,42 +2412,34 @@ qcom_qmp_dp_clks_hw_get(struct of_phandle_args *clkspec, void *data)
 	}
 
 	if (idx == 0)
-		return &dp_clks->dp_link_hw;
+		return &qmp->dp_link_hw;
 
-	return &dp_clks->dp_pixel_hw;
+	return &qmp->dp_pixel_hw;
 }
 
 static int phy_dp_clks_register(struct qmp_combo *qmp, struct device_node *np)
 {
 	struct clk_init_data init = { };
-	struct qmp_phy_dp_clks *dp_clks;
 	char name[64];
 	int ret;
 
-	dp_clks = devm_kzalloc(qmp->dev, sizeof(*dp_clks), GFP_KERNEL);
-	if (!dp_clks)
-		return -ENOMEM;
-
-	dp_clks->qmp = qmp;
-	qmp->dp_clks = dp_clks;
-
 	snprintf(name, sizeof(name), "%s::link_clk", dev_name(qmp->dev));
 	init.ops = &qcom_qmp_dp_link_clk_ops;
 	init.name = name;
-	dp_clks->dp_link_hw.init = &init;
-	ret = devm_clk_hw_register(qmp->dev, &dp_clks->dp_link_hw);
+	qmp->dp_link_hw.init = &init;
+	ret = devm_clk_hw_register(qmp->dev, &qmp->dp_link_hw);
 	if (ret)
 		return ret;
 
 	snprintf(name, sizeof(name), "%s::vco_div_clk", dev_name(qmp->dev));
 	init.ops = &qcom_qmp_dp_pixel_clk_ops;
 	init.name = name;
-	dp_clks->dp_pixel_hw.init = &init;
-	ret = devm_clk_hw_register(qmp->dev, &dp_clks->dp_pixel_hw);
+	qmp->dp_pixel_hw.init = &init;
+	ret = devm_clk_hw_register(qmp->dev, &qmp->dp_pixel_hw);
 	if (ret)
 		return ret;
 
-	ret = of_clk_add_hw_provider(np, qcom_qmp_dp_clks_hw_get, dp_clks);
+	ret = of_clk_add_hw_provider(np, qcom_qmp_dp_clks_hw_get, qmp);
 	if (ret)
 		return ret;
 
-- 
2.37.4

