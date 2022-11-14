Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3809C627BAE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbiKNLIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236655AbiKNLH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:07:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A224B20F74;
        Mon, 14 Nov 2022 03:07:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 460EEB80DEE;
        Mon, 14 Nov 2022 11:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F494C4FF08;
        Mon, 14 Nov 2022 11:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668424034;
        bh=jhtHjMkGRNFv0HJnu2HoO5cINqCvlJtY6fSx3SmTivs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GouxSM7mL8jgDptvwwhGGAtitxLAFRESUX4PjeZa8NDdWBLkoY9HiJ25wkcPMfUQn
         EgM8fK/O1hEeS6RaMHuk7ZIWVkgBXD6VJJTQMn6f2P60kC9l7QEewjK00aIqYy19QG
         jcPbgjXa6X37oLPFJxdKoKcXC09IU+JvZwdSw3aTdxB9v8cW1yKREBGz4Npn9z1Kax
         qmNLxCpSXonjHO2ykwgiYccvSFB0c4r3wEYILkiCgVYM1O+nU/CvNZA33G9h4700S6
         7233W0mGlSN9FlHFNSn4sgVnK6RiqmfsddVL2fd7MeipH5Uwn+2WmYiY0TKe2cuA2Y
         86M8vYmBH4DPA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ouXIY-0001Ew-PL; Mon, 14 Nov 2022 12:06:42 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 12/22] phy: qcom-qmp-combo: separate USB and DP devicetree parsing
Date:   Mon, 14 Nov 2022 12:06:11 +0100
Message-Id: <20221114110621.4639-13-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221114110621.4639-1-johan+linaro@kernel.org>
References: <20221114110621.4639-1-johan+linaro@kernel.org>
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

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 82 ++++++++++++++++-------
 1 file changed, 58 insertions(+), 24 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index c059e4aeecdb..9c4528dff316 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -2576,13 +2576,12 @@ static int phy_dp_clks_register(struct qcom_qmp *qmp, struct qmp_phy *qphy,
 	return devm_add_action_or_reset(qmp->dev, phy_clk_release_provider, np);
 }
 
-static int qmp_combo_create(struct device *dev, struct device_node *np, int id,
+static int qmp_combo_create_dp(struct device *dev, struct device_node *np, int id,
 			void __iomem *serdes, const struct qmp_phy_cfg *cfg)
 {
 	struct qcom_qmp *qmp = dev_get_drvdata(dev);
 	struct phy *generic_phy;
 	struct qmp_phy *qphy;
-	const struct phy_ops *ops;
 	int ret;
 
 	qphy = devm_kzalloc(dev, sizeof(*qphy), GFP_KERNEL);
@@ -2592,7 +2591,57 @@ static int qmp_combo_create(struct device *dev, struct device_node *np, int id,
 	qphy->cfg = cfg;
 	qphy->serdes = serdes;
 	/*
-	 * Get memory resources for each PHY:
+	 * Get memory resources from the DP child node:
+	 * Resources are indexed as: tx -> 0; rx -> 1; pcs -> 2.
+	 * For dual lane PHYs: tx2 -> 3, rx2 -> 4
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
+	 * Get memory resources from the USB child node:
 	 * Resources are indexed as: tx -> 0; rx -> 1; pcs -> 2.
 	 * For dual lane PHYs: tx2 -> 3, rx2 -> 4, pcs_misc (optional) -> 5
 	 * For single lane PHYs: pcs_misc (optional) -> 3.
@@ -2631,31 +2680,16 @@ static int qmp_combo_create(struct device *dev, struct device_node *np, int id,
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
 
@@ -2752,7 +2786,7 @@ static int qmp_combo_probe(struct platform_device *pdev)
 			serdes = dp_serdes;
 
 			/* Create per-lane phy */
-			ret = qmp_combo_create(dev, child, id, serdes, cfg);
+			ret = qmp_combo_create_dp(dev, child, id, serdes, cfg);
 			if (ret) {
 				dev_err(dev, "failed to create lane%d phy, %d\n",
 					id, ret);
@@ -2770,7 +2804,7 @@ static int qmp_combo_probe(struct platform_device *pdev)
 			serdes = usb_serdes;
 
 			/* Create per-lane phy */
-			ret = qmp_combo_create(dev, child, id, serdes, cfg);
+			ret = qmp_combo_create_usb(dev, child, id, serdes, cfg);
 			if (ret) {
 				dev_err(dev, "failed to create lane%d phy, %d\n",
 					id, ret);
-- 
2.37.4

