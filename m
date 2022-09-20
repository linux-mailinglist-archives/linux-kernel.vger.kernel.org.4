Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B345BDE81
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiITHjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiITHjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:39:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF36E606B6;
        Tue, 20 Sep 2022 00:39:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31B03624DC;
        Tue, 20 Sep 2022 07:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C5CC4FEBE;
        Tue, 20 Sep 2022 07:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663659539;
        bh=2N1qlywxBzlo6dwex6S7zihG6+wnQQ4IgjeWP6M/abA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Aj7lv7fpl0SOiiLu3qFX0BA6hzVJBt/GuZSsHLcrKoSIHCr7MXdIJDP/x99WqPhT5
         /FbKP1gtYDLPQOOiME9c2xG7RhrTLaggUam2dPb/Mhh7uM65cM06bFFvUFYTrrU5BH
         neM8tsVVmoj44c0P7993jw/gbi5QhIvbROxEjgKW4/mFE9xDE14ehOZISrR8AXO8gu
         Z8eE1B/jZq8/nSvHBGCYa7g/52NSJjUZqWpkqo9m0r5Fr7w9YYPiKZ1zz0v5AeO3+6
         Zbhe7decu+rX4jfek9txRtARg4gE8E0TBnMN9lDkSqYJ5GwMFQjojyhS8zLDuZoth9
         VkxqGZKxLetKw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oaXqQ-0005R9-AP; Tue, 20 Sep 2022 09:39:02 +0200
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
Subject: [PATCH 12/17] phy: qcom-qmp-pcie: consolidate lane config
Date:   Tue, 20 Sep 2022 09:38:21 +0200
Message-Id: <20220920073826.20811-13-johan+linaro@kernel.org>
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

For legacy reasons, there are two configuration parameters that describe
the number of lanes a PHY has.

Replace them both with a new field simply named "lanes".

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 39 ++++++++++--------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 387abed33727..dde398105f03 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1302,8 +1302,7 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_pcs_misc_tbl[] = {
 
 /* struct qmp_phy_cfg - per-PHY initialization config */
 struct qmp_phy_cfg {
-	/* number of lanes provided by phy */
-	int nlanes;
+	int lanes;
 
 	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
 	const struct qmp_phy_init_tbl *serdes_tbl;
@@ -1351,9 +1350,6 @@ struct qmp_phy_cfg {
 	int pwrdn_delay_min;
 	int pwrdn_delay_max;
 
-	/* true, if PHY has secondary tx/rx lanes to be configured */
-	bool is_dual_lane_phy;
-
 	/* QMP PHY pipe clock interface rate */
 	unsigned long pipe_clock_rate;
 };
@@ -1461,7 +1457,7 @@ static const char * const sdm845_pciephy_reset_l[] = {
 };
 
 static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
-	.nlanes			= 1,
+	.lanes			= 1,
 
 	.serdes_tbl		= ipq8074_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(ipq8074_pcie_serdes_tbl),
@@ -1489,7 +1485,7 @@ static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
 };
 
 static const struct qmp_phy_cfg ipq8074_pciephy_gen3_cfg = {
-	.nlanes			= 1,
+	.lanes			= 1,
 
 	.serdes_tbl		= ipq8074_pcie_gen3_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(ipq8074_pcie_gen3_serdes_tbl),
@@ -1518,7 +1514,7 @@ static const struct qmp_phy_cfg ipq8074_pciephy_gen3_cfg = {
 };
 
 static const struct qmp_phy_cfg ipq6018_pciephy_cfg = {
-	.nlanes			= 1,
+	.lanes			= 1,
 
 	.serdes_tbl		= ipq6018_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(ipq6018_pcie_serdes_tbl),
@@ -1547,7 +1543,7 @@ static const struct qmp_phy_cfg ipq6018_pciephy_cfg = {
 };
 
 static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
-	.nlanes = 1,
+	.lanes			= 1,
 
 	.serdes_tbl		= sdm845_qmp_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sdm845_qmp_pcie_serdes_tbl),
@@ -1577,7 +1573,7 @@ static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
 };
 
 static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
-	.nlanes = 1,
+	.lanes			= 1,
 
 	.serdes_tbl		= sdm845_qhp_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sdm845_qhp_pcie_serdes_tbl),
@@ -1605,7 +1601,7 @@ static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
 };
 
 static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
-	.nlanes = 1,
+	.lanes			= 1,
 
 	.serdes_tbl		= sm8250_qmp_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_serdes_tbl),
@@ -1643,7 +1639,7 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
 };
 
 static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
-	.nlanes = 2,
+	.lanes			= 2,
 
 	.serdes_tbl		= sm8250_qmp_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_serdes_tbl),
@@ -1675,14 +1671,13 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 	.phy_status		= PHYSTATUS,
 
-	.is_dual_lane_phy	= true,
 	.has_pwrdn_delay	= true,
 	.pwrdn_delay_min	= 995,		/* us */
 	.pwrdn_delay_max	= 1005,		/* us */
 };
 
 static const struct qmp_phy_cfg msm8998_pciephy_cfg = {
-	.nlanes			= 1,
+	.lanes			= 1,
 
 	.serdes_tbl		= msm8998_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(msm8998_pcie_serdes_tbl),
@@ -1706,7 +1701,7 @@ static const struct qmp_phy_cfg msm8998_pciephy_cfg = {
 };
 
 static const struct qmp_phy_cfg sc8180x_pciephy_cfg = {
-	.nlanes = 1,
+	.lanes			= 1,
 
 	.serdes_tbl		= sc8180x_qmp_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sc8180x_qmp_pcie_serdes_tbl),
@@ -1735,7 +1730,7 @@ static const struct qmp_phy_cfg sc8180x_pciephy_cfg = {
 };
 
 static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
-	.nlanes = 2,
+	.lanes			= 2,
 
 	.serdes_tbl		= sdx55_qmp_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sdx55_qmp_pcie_serdes_tbl),
@@ -1759,14 +1754,13 @@ static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
 	.pwrdn_ctrl		= SW_PWRDN,
 	.phy_status		= PHYSTATUS_4_20,
 
-	.is_dual_lane_phy	= true,
 	.has_pwrdn_delay	= true,
 	.pwrdn_delay_min	= 995,		/* us */
 	.pwrdn_delay_max	= 1005,		/* us */
 };
 
 static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
-	.nlanes = 1,
+	.lanes			= 1,
 
 	.serdes_tbl		= sm8450_qmp_gen3x1_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sm8450_qmp_gen3x1_pcie_serdes_tbl),
@@ -1796,7 +1790,7 @@ static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
 };
 
 static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
-	.nlanes = 2,
+	.lanes			= 2,
 
 	.serdes_tbl		= sm8450_qmp_gen4x2_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_serdes_tbl),
@@ -1820,7 +1814,6 @@ static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 	.phy_status		= PHYSTATUS_4_20,
 
-	.is_dual_lane_phy	= true,
 	.has_pwrdn_delay	= true,
 	.pwrdn_delay_min	= 995,		/* us */
 	.pwrdn_delay_max	= 1005,		/* us */
@@ -1959,7 +1952,7 @@ static int qmp_pcie_power_on(struct phy *phy)
 	qmp_pcie_configure_lane(tx, cfg->regs, cfg->tx_tbl, cfg->tx_tbl_num, 1);
 	qmp_pcie_configure_lane(tx, cfg->regs, cfg->tx_tbl_sec, cfg->tx_tbl_num_sec, 1);
 
-	if (cfg->is_dual_lane_phy) {
+	if (cfg->lanes >= 2) {
 		qmp_pcie_configure_lane(qphy->tx2, cfg->regs, cfg->tx_tbl,
 					cfg->tx_tbl_num, 2);
 		qmp_pcie_configure_lane(qphy->tx2, cfg->regs, cfg->tx_tbl_sec,
@@ -1969,7 +1962,7 @@ static int qmp_pcie_power_on(struct phy *phy)
 	qmp_pcie_configure_lane(rx, cfg->regs, cfg->rx_tbl, cfg->rx_tbl_num, 1);
 	qmp_pcie_configure_lane(rx, cfg->regs, cfg->rx_tbl_sec, cfg->rx_tbl_num_sec, 1);
 
-	if (cfg->is_dual_lane_phy) {
+	if (cfg->lanes >= 2) {
 		qmp_pcie_configure_lane(qphy->rx2, cfg->regs, cfg->rx_tbl,
 					cfg->rx_tbl_num, 2);
 		qmp_pcie_configure_lane(qphy->rx2, cfg->regs, cfg->rx_tbl_sec,
@@ -2225,7 +2218,7 @@ static int qmp_pcie_create(struct device *dev, struct device_node *np, int id,
 	if (IS_ERR(qphy->pcs))
 		return PTR_ERR(qphy->pcs);
 
-	if (cfg->is_dual_lane_phy) {
+	if (cfg->lanes >= 2) {
 		qphy->tx2 = devm_of_iomap(dev, np, 3, NULL);
 		if (IS_ERR(qphy->tx2))
 			return PTR_ERR(qphy->tx2);
-- 
2.35.1

