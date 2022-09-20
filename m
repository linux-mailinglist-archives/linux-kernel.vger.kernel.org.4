Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5905BDE89
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiITHkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiITHjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:39:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99567606B4;
        Tue, 20 Sep 2022 00:39:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D531DB82576;
        Tue, 20 Sep 2022 07:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6437C4FF0C;
        Tue, 20 Sep 2022 07:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663659539;
        bh=SbqQNBmBFgO/Vj8yFLzzLz53WBQ+Ygs7T+itjrvLL9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U56OzQAL+ncdDRubhSEt6uawttgT4UT0Cs4B5kRzVHizgsM/e0zg6DxTtoDQbljew
         bizC64IrD+hTswXfUzNW5QI+IJLwdSMEM91+x9ylfpLJEHexnY52GYK3TYwVD09MSr
         yHzzE9fBXCyrl79ZkU6W2JrVycoWe8gMM8JtJBc5K4jAVZ7woMTzSjrjK3KLit9YaH
         1+KE4R19CucoOT/EkwhsGLgnFraX4wJI2iXfoR9Q/vfZAa8rWiP0NZriWI9FByP9iR
         lgGjnD0sdbhlSzsybXp+CMUvqQyl9iUTiVozWoHY9y2PzE0K35ktQa0dxY3T4q64QM
         HMpmGPd+HOBmQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oaXqQ-0005RF-GR; Tue, 20 Sep 2022 09:39:02 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 14/17] phy: qcom-qmp-combo: consolidate lane config
Date:   Tue, 20 Sep 2022 09:38:23 +0200
Message-Id: <20220920073826.20811-15-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220920073826.20811-1-johan+linaro@kernel.org>
References: <20220920073826.20811-1-johan+linaro@kernel.org>
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

For legacy reasons, there are two configuration parameters that appear
to describe the number of lanes a PHY has, even if "nlanes" was actually
used for a different purpose.

Replace them both with a new field simply named "lanes".

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 38 ++++++++---------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 08e96e383a29..417e0fcf1a9f 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -816,8 +816,7 @@ struct qmp_phy;
 struct qmp_phy_cfg {
 	/* phy-type - PCIE/UFS/USB */
 	unsigned int type;
-	/* number of lanes provided by phy */
-	int nlanes;
+	int lanes;
 
 	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
 	const struct qmp_phy_init_tbl *serdes_tbl;
@@ -879,8 +878,6 @@ struct qmp_phy_cfg {
 
 	/* true, if PHY has a separate DP_COM control block */
 	bool has_phy_dp_com_ctrl;
-	/* true, if PHY has secondary tx/rx lanes to be configured */
-	bool is_dual_lane_phy;
 
 	/* Offset from PCS to PCS_USB region */
 	unsigned int pcs_usb_offset;
@@ -1029,7 +1026,7 @@ static const char * const sc7180_usb3phy_reset_l[] = {
 
 static const struct qmp_phy_cfg sc7180_usb3phy_cfg = {
 	.type			= PHY_TYPE_USB3,
-	.nlanes			= 1,
+	.lanes			= 2,
 
 	.serdes_tbl		= qmp_v3_usb3_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_serdes_tbl),
@@ -1056,12 +1053,11 @@ static const struct qmp_phy_cfg sc7180_usb3phy_cfg = {
 	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
 
 	.has_phy_dp_com_ctrl	= true,
-	.is_dual_lane_phy	= true,
 };
 
 static const struct qmp_phy_cfg sc7180_dpphy_cfg = {
 	.type			= PHY_TYPE_DP,
-	.nlanes			= 1,
+	.lanes			= 2,
 
 	.serdes_tbl		= qmp_v3_dp_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(qmp_v3_dp_serdes_tbl),
@@ -1091,7 +1087,6 @@ static const struct qmp_phy_cfg sc7180_dpphy_cfg = {
 	.regs			= qmp_v3_usb3phy_regs_layout,
 
 	.has_phy_dp_com_ctrl	= true,
-	.is_dual_lane_phy	= true,
 
 	.dp_aux_init = qcom_qmp_v3_phy_dp_aux_init,
 	.configure_dp_tx = qcom_qmp_v3_phy_configure_dp_tx,
@@ -1106,7 +1101,7 @@ static const struct qmp_phy_combo_cfg sc7180_usb3dpphy_cfg = {
 
 static const struct qmp_phy_cfg sdm845_usb3phy_cfg = {
 	.type			= PHY_TYPE_USB3,
-	.nlanes			= 1,
+	.lanes			= 2,
 
 	.serdes_tbl		= qmp_v3_usb3_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_serdes_tbl),
@@ -1133,7 +1128,6 @@ static const struct qmp_phy_cfg sdm845_usb3phy_cfg = {
 	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
 
 	.has_phy_dp_com_ctrl	= true,
-	.is_dual_lane_phy	= true,
 };
 
 static const struct qmp_phy_combo_cfg sdm845_usb3dpphy_cfg = {
@@ -1143,7 +1137,7 @@ static const struct qmp_phy_combo_cfg sdm845_usb3dpphy_cfg = {
 
 static const struct qmp_phy_cfg sm8150_usb3phy_cfg = {
 	.type			= PHY_TYPE_USB3,
-	.nlanes			= 1,
+	.lanes			= 2,
 
 	.serdes_tbl		= sm8150_usb3_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_serdes_tbl),
@@ -1174,12 +1168,11 @@ static const struct qmp_phy_cfg sm8150_usb3phy_cfg = {
 	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
 
 	.has_phy_dp_com_ctrl	= true,
-	.is_dual_lane_phy	= true,
 };
 
 static const struct qmp_phy_cfg sc8180x_dpphy_cfg = {
 	.type			= PHY_TYPE_DP,
-	.nlanes			= 1,
+	.lanes			= 2,
 
 	.serdes_tbl		= qmp_v4_dp_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(qmp_v4_dp_serdes_tbl),
@@ -1209,7 +1202,6 @@ static const struct qmp_phy_cfg sc8180x_dpphy_cfg = {
 	.regs			= qmp_v3_usb3phy_regs_layout,
 
 	.has_phy_dp_com_ctrl	= true,
-	.is_dual_lane_phy	= true,
 
 	.dp_aux_init = qcom_qmp_v4_phy_dp_aux_init,
 	.configure_dp_tx = qcom_qmp_v4_phy_configure_dp_tx,
@@ -1224,7 +1216,7 @@ static const struct qmp_phy_combo_cfg sc8180x_usb3dpphy_cfg = {
 
 static const struct qmp_phy_cfg sc8280xp_usb43dp_usb_cfg = {
 	.type			= PHY_TYPE_USB3,
-	.nlanes			= 1,
+	.lanes			= 2,
 
 	.serdes_tbl		= sc8280xp_usb43dp_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sc8280xp_usb43dp_serdes_tbl),
@@ -1252,12 +1244,11 @@ static const struct qmp_phy_cfg sc8280xp_usb43dp_usb_cfg = {
 	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
 
 	.has_phy_dp_com_ctrl	= true,
-	.is_dual_lane_phy	= true,
 };
 
 static const struct qmp_phy_cfg sc8280xp_usb43dp_dp_cfg = {
 	.type			= PHY_TYPE_DP,
-	.nlanes			= 1,
+	.lanes			= 2,
 
 	.serdes_tbl		= qmp_v5_dp_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(qmp_v5_dp_serdes_tbl),
@@ -1287,7 +1278,6 @@ static const struct qmp_phy_cfg sc8280xp_usb43dp_dp_cfg = {
 	.regs			= qmp_v4_usb3phy_regs_layout,
 
 	.has_phy_dp_com_ctrl	= true,
-	.is_dual_lane_phy	= true,
 
 	.dp_aux_init = qcom_qmp_v4_phy_dp_aux_init,
 	.configure_dp_tx = qcom_qmp_v4_phy_configure_dp_tx,
@@ -1302,7 +1292,7 @@ static const struct qmp_phy_combo_cfg sc8280xp_usb43dpphy_combo_cfg = {
 
 static const struct qmp_phy_cfg sm8250_usb3phy_cfg = {
 	.type			= PHY_TYPE_USB3,
-	.nlanes			= 1,
+	.lanes			= 2,
 
 	.serdes_tbl		= sm8150_usb3_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_serdes_tbl),
@@ -1332,12 +1322,11 @@ static const struct qmp_phy_cfg sm8250_usb3phy_cfg = {
 	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
 
 	.has_phy_dp_com_ctrl	= true,
-	.is_dual_lane_phy	= true,
 };
 
 static const struct qmp_phy_cfg sm8250_dpphy_cfg = {
 	.type			= PHY_TYPE_DP,
-	.nlanes			= 1,
+	.lanes			= 2,
 
 	.serdes_tbl		= qmp_v4_dp_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(qmp_v4_dp_serdes_tbl),
@@ -1367,7 +1356,6 @@ static const struct qmp_phy_cfg sm8250_dpphy_cfg = {
 	.regs			= qmp_v4_usb3phy_regs_layout,
 
 	.has_phy_dp_com_ctrl	= true,
-	.is_dual_lane_phy	= true,
 
 	.dp_aux_init = qcom_qmp_v4_phy_dp_aux_init,
 	.configure_dp_tx = qcom_qmp_v4_phy_configure_dp_tx,
@@ -2117,7 +2105,7 @@ static int qmp_combo_power_on(struct phy *phy)
 	/* Tx, Rx, and PCS configurations */
 	qmp_combo_configure_lane(tx, cfg->regs, cfg->tx_tbl, cfg->tx_tbl_num, 1);
 
-	if (cfg->is_dual_lane_phy) {
+	if (cfg->lanes >= 2) {
 		qmp_combo_configure_lane(qphy->tx2, cfg->regs, cfg->tx_tbl,
 					 cfg->tx_tbl_num, 2);
 	}
@@ -2128,7 +2116,7 @@ static int qmp_combo_power_on(struct phy *phy)
 
 	qmp_combo_configure_lane(rx, cfg->regs, cfg->rx_tbl, cfg->rx_tbl_num, 1);
 
-	if (cfg->is_dual_lane_phy) {
+	if (cfg->lanes >= 2) {
 		qmp_combo_configure_lane(qphy->rx2, cfg->regs, cfg->rx_tbl,
 					 cfg->rx_tbl_num, 2);
 	}
@@ -2725,7 +2713,7 @@ static int qmp_combo_create(struct device *dev, struct device_node *np, int id,
 	if (cfg->pcs_usb_offset)
 		qphy->pcs_usb = qphy->pcs + cfg->pcs_usb_offset;
 
-	if (cfg->is_dual_lane_phy) {
+	if (cfg->lanes >= 2) {
 		qphy->tx2 = devm_of_iomap(dev, np, 3, NULL);
 		if (IS_ERR(qphy->tx2))
 			return PTR_ERR(qphy->tx2);
-- 
2.35.1

