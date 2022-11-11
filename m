Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7750F6255F9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbiKKI5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiKKI50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:57:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9FB7833D;
        Fri, 11 Nov 2022 00:57:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF1C861EF7;
        Fri, 11 Nov 2022 08:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821EBC43470;
        Fri, 11 Nov 2022 08:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668157043;
        bh=fh/aqnYcDidigo48XuRvbr/aFFT5zxzhUQfJq7vVMG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rfxiPQRHfzAt95l4LJpnuAF7Pzw9Gp4/ZwqO7Zty+yVe2Tcu+BxnblSQCqryF4dQO
         mkDuzFRtapMYFAb9TcOSgQ0URJkzPbYIvXa4fladf71F2b2PmI5i3f8c8Qsy2aZL3z
         UEqNc+UHxvOpQQVmPVe9xGBajROG+/nsSs/Y/qVlnMqqv/0HMP4CfRRWgtraYSJ2+7
         CiMZOO/05485peqK96J84zq0vypzJ2JeSZK860g+PTWy3Dduud8HQkd1iZ2irYL6uR
         3Ghg1ykCjXX/Rm5SupmugRq5nfX0CmpCHuOnVjCHvf+Sm6yvqrKqzsNiA+G+Ea0w+j
         BxeW51ad7bBtg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1otPqJ-0002UK-RQ; Fri, 11 Nov 2022 09:56:55 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 12/22] phy: qcom-qmp-combo: separate USB and DP devicetree parsing
Date:   Fri, 11 Nov 2022 09:56:33 +0100
Message-Id: <20221111085643.9478-13-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221111085643.9478-1-johan+linaro@kernel.org>
References: <20221111085643.9478-1-johan+linaro@kernel.org>
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

Separate the devicetree parsing of the USB and DP child nodes in two
dedicated helpers in preparation for merging the driver data.

Note that only the USB part of the PHY has a pipe clock and that the DP
implementation only uses the tx/tx2 and pcs register regions.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 81 ++++++++++++++++-------
 1 file changed, 58 insertions(+), 23 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index c059e4aeecdb..52a00b51f09a 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -2576,13 +2576,63 @@ static int phy_dp_clks_register(struct qcom_qmp *qmp, struct qmp_phy *qphy,
 	return devm_add_action_or_reset(qmp->dev, phy_clk_release_provider, np);
 }
 
-static int qmp_combo_create(struct device *dev, struct device_node *np, int id,
+static int qmp_combo_create_dp(struct device *dev, struct device_node *np, int id,
+			void __iomem *serdes, const struct qmp_phy_cfg *cfg)
+{
+	struct qcom_qmp *qmp = dev_get_drvdata(dev);
+	struct phy *generic_phy;
+	struct qmp_phy *qphy;
+	int ret;
+
+	qphy = devm_kzalloc(dev, sizeof(*qphy), GFP_KERNEL);
+	if (!qphy)
+		return -ENOMEM;
+
+	qphy->cfg = cfg;
+	qphy->serdes = serdes;
+	/*
+	 * Get memory resources for each PHY:
+	 * Resources are indexed as: tx -> 0; rx -> 1; pcs -> 2.
+	 * For dual lane PHYs: tx2 -> 3, rx2 -> 4, pcs_misc (optional) -> 5
+	 * For single lane PHYs: pcs_misc (optional) -> 3.
+	 *
+	 * Note that only tx/tx2 and pcs are used by the DP implementation.
+	 */
+	qphy->tx = devm_of_iomap(dev, np, 0, NULL);
+	if (IS_ERR(qphy->tx))
+		return PTR_ERR(qphy->tx);
+
+	qphy->pcs = devm_of_iomap(dev, np, 2, NULL);
+	if (IS_ERR(qphy->pcs))
+		return PTR_ERR(qphy->pcs);
+
+	if (cfg->lanes >= 2) {
+		qphy->tx2 = devm_of_iomap(dev, np, 3, NULL);
+		if (IS_ERR(qphy->tx2))
+			return PTR_ERR(qphy->tx2);
+	}
+
+	generic_phy = devm_phy_create(dev, np, &qmp_combo_dp_phy_ops);
+	if (IS_ERR(generic_phy)) {
+		ret = PTR_ERR(generic_phy);
+		dev_err(dev, "failed to create DP PHY: %d\n", ret);
+		return ret;
+	}
+
+	qphy->phy = generic_phy;
+	qphy->qmp = qmp;
+	qmp->phys[id] = qphy;
+	phy_set_drvdata(generic_phy, qphy);
+
+	return 0;
+}
+
+static int qmp_combo_create_usb(struct device *dev, struct device_node *np, int id,
 			void __iomem *serdes, const struct qmp_phy_cfg *cfg)
 {
 	struct qcom_qmp *qmp = dev_get_drvdata(dev);
 	struct phy *generic_phy;
 	struct qmp_phy *qphy;
-	const struct phy_ops *ops;
 	int ret;
 
 	qphy = devm_kzalloc(dev, sizeof(*qphy), GFP_KERNEL);
@@ -2631,31 +2681,16 @@ static int qmp_combo_create(struct device *dev, struct device_node *np, int id,
 		qphy->pcs_misc = NULL;
 	}
 
-	/*
-	 * Get PHY's Pipe clock, if any. USB3 and PCIe are PIPE3
-	 * based phys, so they essentially have pipe clock. So,
-	 * we return error in case phy is USB3 or PIPE type.
-	 * Otherwise, we initialize pipe clock to NULL for
-	 * all phys that don't need this.
-	 */
 	qphy->pipe_clk = devm_get_clk_from_child(dev, np, NULL);
 	if (IS_ERR(qphy->pipe_clk)) {
-		if (cfg->type == PHY_TYPE_USB3)
-			return dev_err_probe(dev, PTR_ERR(qphy->pipe_clk),
-					     "failed to get lane%d pipe_clk\n",
-					     id);
-		qphy->pipe_clk = NULL;
+		return dev_err_probe(dev, PTR_ERR(qphy->pipe_clk),
+				     "failed to get lane%d pipe_clk\n", id);
 	}
 
-	if (cfg->type == PHY_TYPE_DP)
-		ops = &qmp_combo_dp_phy_ops;
-	else
-		ops = &qmp_combo_usb_phy_ops;
-
-	generic_phy = devm_phy_create(dev, np, ops);
+	generic_phy = devm_phy_create(dev, np, &qmp_combo_usb_phy_ops);
 	if (IS_ERR(generic_phy)) {
 		ret = PTR_ERR(generic_phy);
-		dev_err(dev, "failed to create qphy %d\n", ret);
+		dev_err(dev, "failed to create USB PHY: %d\n", ret);
 		return ret;
 	}
 
@@ -2752,7 +2787,7 @@ static int qmp_combo_probe(struct platform_device *pdev)
 			serdes = dp_serdes;
 
 			/* Create per-lane phy */
-			ret = qmp_combo_create(dev, child, id, serdes, cfg);
+			ret = qmp_combo_create_dp(dev, child, id, serdes, cfg);
 			if (ret) {
 				dev_err(dev, "failed to create lane%d phy, %d\n",
 					id, ret);
@@ -2770,7 +2805,7 @@ static int qmp_combo_probe(struct platform_device *pdev)
 			serdes = usb_serdes;
 
 			/* Create per-lane phy */
-			ret = qmp_combo_create(dev, child, id, serdes, cfg);
+			ret = qmp_combo_create_usb(dev, child, id, serdes, cfg);
 			if (ret) {
 				dev_err(dev, "failed to create lane%d phy, %d\n",
 					id, ret);
-- 
2.37.4

