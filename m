Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D514627BAF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbiKNLI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbiKNLH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:07:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B74620F64;
        Mon, 14 Nov 2022 03:07:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBFF061026;
        Mon, 14 Nov 2022 11:07:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AE3C4FF16;
        Mon, 14 Nov 2022 11:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668424034;
        bh=mWt8PFozCsI1kYucsrLaOeaUWYh9viu9gem7uGrTlfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PVEbT93Xchff7wg9pA41l/8RS9Ii8KLCklPGIEkuVyrRuGMXpV36pE/3Es5qcFrF/
         2jUr/K54gsJrW1GhMuCAfRQWlmimLRX21Os4ACzy12E634FGhTQzoRYraziOgujkAI
         odMmCVXvYtFuf9VbX5bFOPF9hflGHVGu+0Efga8xaM++3BvG8kEBaSx6Zs6X9o+muj
         W8Epe6B1y+aWqutPatc762v+u6ZMg5k6YqdphjEiYLOwhftO9VmIT5vg7iC+h6OD0x
         hszhjfc5gg5fbNbbaqWYUyNW2b/d8xbnzFz3OTe7c+WCZ5s5J6XJqSEmNG/m7GDYSv
         qeOfZY/zEtaFQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ouXIZ-0001FB-79; Mon, 14 Nov 2022 12:06:43 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 17/22] phy: qcom-qmp-combo: drop lanes config parameter
Date:   Mon, 14 Nov 2022 12:06:16 +0100
Message-Id: <20221114110621.4639-18-johan+linaro@kernel.org>
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

Since the QMP driver split there is really no need for the 'lanes'
configuration parameter as all of these USB-C PHYs support dual-lane
SuperSpeed USB and quad-lane (uni-directional) DP (even if the driver
still only supports CC1 orientation using lanes 2 and 3).

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 62 ++++++++---------------
 1 file changed, 20 insertions(+), 42 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 2588cfa5e81e..a0abeb7c3bca 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -802,7 +802,6 @@ struct qmp_phy;
 struct qmp_phy_cfg {
 	/* phy-type - PCIE/UFS/USB */
 	unsigned int type;
-	int lanes;
 
 	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
 	const struct qmp_phy_init_tbl *serdes_tbl;
@@ -1010,7 +1009,6 @@ static const char * const sc7180_usb3phy_reset_l[] = {
 
 static const struct qmp_phy_cfg sc7180_usb3phy_cfg = {
 	.type			= PHY_TYPE_USB3,
-	.lanes			= 2,
 
 	.serdes_tbl		= qmp_v3_usb3_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_serdes_tbl),
@@ -1033,7 +1031,6 @@ static const struct qmp_phy_cfg sc7180_usb3phy_cfg = {
 
 static const struct qmp_phy_cfg sc7180_dpphy_cfg = {
 	.type			= PHY_TYPE_DP,
-	.lanes			= 2,
 
 	.dp_serdes_tbl		= qmp_v3_dp_serdes_tbl,
 	.dp_serdes_tbl_num	= ARRAY_SIZE(qmp_v3_dp_serdes_tbl),
@@ -1067,7 +1064,6 @@ static const struct qmp_phy_combo_cfg sc7180_usb3dpphy_cfg = {
 
 static const struct qmp_phy_cfg sdm845_usb3phy_cfg = {
 	.type			= PHY_TYPE_USB3,
-	.lanes			= 2,
 
 	.serdes_tbl		= qmp_v3_usb3_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_serdes_tbl),
@@ -1090,7 +1086,6 @@ static const struct qmp_phy_cfg sdm845_usb3phy_cfg = {
 
 static const struct qmp_phy_cfg sdm845_dpphy_cfg = {
 	.type			= PHY_TYPE_DP,
-	.lanes			= 2,
 
 	.serdes_tbl		= qmp_v3_dp_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(qmp_v3_dp_serdes_tbl),
@@ -1124,7 +1119,6 @@ static const struct qmp_phy_combo_cfg sdm845_usb3dpphy_cfg = {
 
 static const struct qmp_phy_cfg sm8150_usb3phy_cfg = {
 	.type			= PHY_TYPE_USB3,
-	.lanes			= 2,
 
 	.serdes_tbl		= sm8150_usb3_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_serdes_tbl),
@@ -1150,7 +1144,6 @@ static const struct qmp_phy_cfg sm8150_usb3phy_cfg = {
 
 static const struct qmp_phy_cfg sc8180x_dpphy_cfg = {
 	.type			= PHY_TYPE_DP,
-	.lanes			= 2,
 
 	.dp_serdes_tbl		= qmp_v4_dp_serdes_tbl,
 	.dp_serdes_tbl_num	= ARRAY_SIZE(qmp_v4_dp_serdes_tbl),
@@ -1184,7 +1177,6 @@ static const struct qmp_phy_combo_cfg sc8180x_usb3dpphy_cfg = {
 
 static const struct qmp_phy_cfg sc8280xp_usb43dp_usb_cfg = {
 	.type			= PHY_TYPE_USB3,
-	.lanes			= 2,
 
 	.serdes_tbl		= sc8280xp_usb43dp_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sc8280xp_usb43dp_serdes_tbl),
@@ -1206,7 +1198,6 @@ static const struct qmp_phy_cfg sc8280xp_usb43dp_usb_cfg = {
 
 static const struct qmp_phy_cfg sc8280xp_usb43dp_dp_cfg = {
 	.type			= PHY_TYPE_DP,
-	.lanes			= 2,
 
 	.dp_serdes_tbl		= qmp_v5_dp_serdes_tbl,
 	.dp_serdes_tbl_num	= ARRAY_SIZE(qmp_v5_dp_serdes_tbl),
@@ -1240,7 +1231,6 @@ static const struct qmp_phy_combo_cfg sc8280xp_usb43dpphy_cfg = {
 
 static const struct qmp_phy_cfg sm8250_usb3phy_cfg = {
 	.type			= PHY_TYPE_USB3,
-	.lanes			= 2,
 
 	.serdes_tbl		= sm8150_usb3_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_serdes_tbl),
@@ -1266,7 +1256,6 @@ static const struct qmp_phy_cfg sm8250_usb3phy_cfg = {
 
 static const struct qmp_phy_cfg sm8250_dpphy_cfg = {
 	.type			= PHY_TYPE_DP,
-	.lanes			= 2,
 
 	.dp_serdes_tbl		= qmp_v4_dp_serdes_tbl,
 	.dp_serdes_tbl_num	= ARRAY_SIZE(qmp_v4_dp_serdes_tbl),
@@ -2000,13 +1989,12 @@ static int qmp_combo_dp_power_on(struct phy *phy)
 	struct qmp_phy *qphy = phy_get_drvdata(phy);
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
 	void __iomem *tx = qphy->dp_tx;
+	void __iomem *tx2 = qphy->dp_tx2;
 
 	qmp_combo_dp_serdes_init(qphy);
 
 	qmp_combo_configure_lane(tx, cfg->dp_tx_tbl, cfg->dp_tx_tbl_num, 1);
-
-	if (cfg->lanes >= 2)
-		qmp_combo_configure_lane(qphy->dp_tx2, cfg->dp_tx_tbl, cfg->dp_tx_tbl_num, 2);
+	qmp_combo_configure_lane(tx2, cfg->dp_tx_tbl, cfg->dp_tx_tbl_num, 2);
 
 	/* Configure special DP tx tunings */
 	cfg->configure_dp_tx(qphy);
@@ -2035,6 +2023,8 @@ static int qmp_combo_usb_power_on(struct phy *phy)
 	void __iomem *serdes = qphy->serdes;
 	void __iomem *tx = qphy->tx;
 	void __iomem *rx = qphy->rx;
+	void __iomem *tx2 = qphy->tx2;
+	void __iomem *rx2 = qphy->rx2;
 	void __iomem *pcs = qphy->pcs;
 	void __iomem *status;
 	unsigned int val;
@@ -2050,14 +2040,10 @@ static int qmp_combo_usb_power_on(struct phy *phy)
 
 	/* Tx, Rx, and PCS configurations */
 	qmp_combo_configure_lane(tx, cfg->tx_tbl, cfg->tx_tbl_num, 1);
-
-	if (cfg->lanes >= 2)
-		qmp_combo_configure_lane(qphy->tx2, cfg->tx_tbl, cfg->tx_tbl_num, 2);
+	qmp_combo_configure_lane(tx2, cfg->tx_tbl, cfg->tx_tbl_num, 2);
 
 	qmp_combo_configure_lane(rx, cfg->rx_tbl, cfg->rx_tbl_num, 1);
-
-	if (cfg->lanes >= 2)
-		qmp_combo_configure_lane(qphy->rx2, cfg->rx_tbl, cfg->rx_tbl_num, 2);
+	qmp_combo_configure_lane(rx2, cfg->rx_tbl, cfg->rx_tbl_num, 2);
 
 	qmp_combo_configure(pcs, cfg->pcs_tbl, cfg->pcs_tbl_num);
 
@@ -2601,8 +2587,8 @@ static int qmp_combo_create_dp(struct device *dev, struct device_node *np, int i
 	qphy->dp_serdes = serdes;
 	/*
 	 * Get memory resources from the DP child node:
-	 * Resources are indexed as: tx -> 0; rx -> 1; pcs -> 2.
-	 * For dual lane PHYs: tx2 -> 3, rx2 -> 4
+	 * Resources are indexed as: tx -> 0; rx -> 1; pcs -> 2;
+	 * tx2 -> 3; rx2 -> 4
 	 *
 	 * Note that only tx/tx2 and pcs are used by the DP implementation.
 	 */
@@ -2614,11 +2600,9 @@ static int qmp_combo_create_dp(struct device *dev, struct device_node *np, int i
 	if (IS_ERR(qphy->dp_pcs))
 		return PTR_ERR(qphy->dp_pcs);
 
-	if (cfg->lanes >= 2) {
-		qphy->dp_tx2 = devm_of_iomap(dev, np, 3, NULL);
-		if (IS_ERR(qphy->dp_tx2))
-			return PTR_ERR(qphy->dp_tx2);
-	}
+	qphy->dp_tx2 = devm_of_iomap(dev, np, 3, NULL);
+	if (IS_ERR(qphy->dp_tx2))
+		return PTR_ERR(qphy->dp_tx2);
 
 	generic_phy = devm_phy_create(dev, np, &qmp_combo_dp_phy_ops);
 	if (IS_ERR(generic_phy)) {
@@ -2651,9 +2635,8 @@ static int qmp_combo_create_usb(struct device *dev, struct device_node *np, int
 	qphy->serdes = serdes;
 	/*
 	 * Get memory resources from the USB child node:
-	 * Resources are indexed as: tx -> 0; rx -> 1; pcs -> 2.
-	 * For dual lane PHYs: tx2 -> 3, rx2 -> 4, pcs_misc (optional) -> 5
-	 * For single lane PHYs: pcs_misc (optional) -> 3.
+	 * Resources are indexed as: tx -> 0; rx -> 1; pcs -> 2;
+	 * tx2 -> 3; rx2 -> 4; pcs_misc (optional) -> 5
 	 */
 	qphy->tx = devm_of_iomap(dev, np, 0, NULL);
 	if (IS_ERR(qphy->tx))
@@ -2670,20 +2653,15 @@ static int qmp_combo_create_usb(struct device *dev, struct device_node *np, int
 	if (cfg->pcs_usb_offset)
 		qphy->pcs_usb = qphy->pcs + cfg->pcs_usb_offset;
 
-	if (cfg->lanes >= 2) {
-		qphy->tx2 = devm_of_iomap(dev, np, 3, NULL);
-		if (IS_ERR(qphy->tx2))
-			return PTR_ERR(qphy->tx2);
+	qphy->tx2 = devm_of_iomap(dev, np, 3, NULL);
+	if (IS_ERR(qphy->tx2))
+		return PTR_ERR(qphy->tx2);
 
-		qphy->rx2 = devm_of_iomap(dev, np, 4, NULL);
-		if (IS_ERR(qphy->rx2))
-			return PTR_ERR(qphy->rx2);
-
-		qphy->pcs_misc = devm_of_iomap(dev, np, 5, NULL);
-	} else {
-		qphy->pcs_misc = devm_of_iomap(dev, np, 3, NULL);
-	}
+	qphy->rx2 = devm_of_iomap(dev, np, 4, NULL);
+	if (IS_ERR(qphy->rx2))
+		return PTR_ERR(qphy->rx2);
 
+	qphy->pcs_misc = devm_of_iomap(dev, np, 5, NULL);
 	if (IS_ERR(qphy->pcs_misc)) {
 		dev_vdbg(dev, "PHY pcs_misc-reg not used\n");
 		qphy->pcs_misc = NULL;
-- 
2.37.4

