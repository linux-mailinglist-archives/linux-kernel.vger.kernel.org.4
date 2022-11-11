Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FA2625605
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbiKKI6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbiKKI53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:57:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF6E7E997;
        Fri, 11 Nov 2022 00:57:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0574D61EFA;
        Fri, 11 Nov 2022 08:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E8DC4FEE2;
        Fri, 11 Nov 2022 08:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668157043;
        bh=fP1QOh8RM0qP+P4pU9D34/ZZVOjPMoHn8Vlr3Ym//HQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WyE8e8AJuhgRS2xS4oTUOr+aKITCQS7u/DsYbbwOloMSvvqiOk/1DKaQUVAQRpZxM
         W5NFuzP+LJ3qn/0RYnp4mudMUyj3gzne5tDkenID2NpqShhS4nuDkJqnmBxrze18oJ
         JYCLyOnHtPCpIFITiNNB8JM6V8UNRx/zyPGgdcTgaaHyPPPzVfgeIXMLJunCf+rFco
         qDXrc2rEbdDAq3zj39G+DYwHMlouJvADYx20KLsKuya3Z012spXxCIxdNM4JnL5bcg
         XQITOMJ7XQk+VFEaJ/Fc4wsnN9ORzYTNL1DgkX5RcT2jULbqkCmTxH1l3dtXHkS8nr
         Z6QcX085/BogA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1otPqJ-0002UO-UP; Fri, 11 Nov 2022 09:56:55 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 13/22] phy: qcom-qmp-combo: add dedicated DP iomem pointers
Date:   Fri, 11 Nov 2022 09:56:34 +0100
Message-Id: <20221111085643.9478-14-johan+linaro@kernel.org>
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

In preparation for merging the driver data, add separate iomem pointers
for the DP part of the PHY.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 246 +++++++++++-----------
 1 file changed, 126 insertions(+), 120 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 52a00b51f09a..bd7b6f72e866 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -895,6 +895,12 @@ struct qmp_phy {
 	void __iomem *rx2;
 	void __iomem *pcs_misc;
 	void __iomem *pcs_usb;
+
+	void __iomem *dp_serdes;
+	void __iomem *dp_tx;
+	void __iomem *dp_tx2;
+	void __iomem *dp_pcs;
+
 	struct clk *pipe_clk;
 	struct qcom_qmp *qmp;
 	enum phy_mode mode;
@@ -1316,7 +1322,7 @@ static void qmp_combo_configure(void __iomem *base,
 static int qmp_combo_dp_serdes_init(struct qmp_phy *qphy)
 {
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
-	void __iomem *serdes = qphy->serdes;
+	void __iomem *serdes = qphy->dp_serdes;
 	const struct phy_configure_opts_dp *dp_opts = &qphy->dp_opts;
 	const struct qmp_phy_init_tbl *serdes_tbl = cfg->serdes_tbl;
 	int serdes_tbl_num = cfg->serdes_tbl_num;
@@ -1352,43 +1358,43 @@ static void qcom_qmp_v3_phy_dp_aux_init(struct qmp_phy *qphy)
 {
 	writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
 	       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
-	       qphy->pcs + QSERDES_DP_PHY_PD_CTL);
+	       qphy->dp_pcs + QSERDES_DP_PHY_PD_CTL);
 
 	/* Turn on BIAS current for PHY/PLL */
 	writel(QSERDES_V3_COM_BIAS_EN | QSERDES_V3_COM_BIAS_EN_MUX |
 	       QSERDES_V3_COM_CLKBUF_L_EN | QSERDES_V3_COM_EN_SYSCLK_TX_SEL,
-	       qphy->serdes + QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN);
+	       qphy->dp_serdes + QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN);
 
-	writel(DP_PHY_PD_CTL_PSR_PWRDN, qphy->pcs + QSERDES_DP_PHY_PD_CTL);
+	writel(DP_PHY_PD_CTL_PSR_PWRDN, qphy->dp_pcs + QSERDES_DP_PHY_PD_CTL);
 
 	writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
 	       DP_PHY_PD_CTL_LANE_0_1_PWRDN |
 	       DP_PHY_PD_CTL_LANE_2_3_PWRDN | DP_PHY_PD_CTL_PLL_PWRDN |
 	       DP_PHY_PD_CTL_DP_CLAMP_EN,
-	       qphy->pcs + QSERDES_DP_PHY_PD_CTL);
+	       qphy->dp_pcs + QSERDES_DP_PHY_PD_CTL);
 
 	writel(QSERDES_V3_COM_BIAS_EN |
 	       QSERDES_V3_COM_BIAS_EN_MUX | QSERDES_V3_COM_CLKBUF_R_EN |
 	       QSERDES_V3_COM_CLKBUF_L_EN | QSERDES_V3_COM_EN_SYSCLK_TX_SEL |
 	       QSERDES_V3_COM_CLKBUF_RX_DRIVE_L,
-	       qphy->serdes + QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN);
-
-	writel(0x00, qphy->pcs + QSERDES_DP_PHY_AUX_CFG0);
-	writel(0x13, qphy->pcs + QSERDES_DP_PHY_AUX_CFG1);
-	writel(0x24, qphy->pcs + QSERDES_DP_PHY_AUX_CFG2);
-	writel(0x00, qphy->pcs + QSERDES_DP_PHY_AUX_CFG3);
-	writel(0x0a, qphy->pcs + QSERDES_DP_PHY_AUX_CFG4);
-	writel(0x26, qphy->pcs + QSERDES_DP_PHY_AUX_CFG5);
-	writel(0x0a, qphy->pcs + QSERDES_DP_PHY_AUX_CFG6);
-	writel(0x03, qphy->pcs + QSERDES_DP_PHY_AUX_CFG7);
-	writel(0xbb, qphy->pcs + QSERDES_DP_PHY_AUX_CFG8);
-	writel(0x03, qphy->pcs + QSERDES_DP_PHY_AUX_CFG9);
+	       qphy->dp_serdes + QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN);
+
+	writel(0x00, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG0);
+	writel(0x13, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG1);
+	writel(0x24, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG2);
+	writel(0x00, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG3);
+	writel(0x0a, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG4);
+	writel(0x26, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG5);
+	writel(0x0a, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG6);
+	writel(0x03, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG7);
+	writel(0xbb, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG8);
+	writel(0x03, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG9);
 	qphy->dp_aux_cfg = 0;
 
 	writel(PHY_AUX_STOP_ERR_MASK | PHY_AUX_DEC_ERR_MASK |
 	       PHY_AUX_SYNC_ERR_MASK | PHY_AUX_ALIGN_ERR_MASK |
 	       PHY_AUX_REQ_ERR_MASK,
-	       qphy->pcs + QSERDES_V3_DP_PHY_AUX_INTERRUPT_MASK);
+	       qphy->dp_pcs + QSERDES_V3_DP_PHY_AUX_INTERRUPT_MASK);
 }
 
 static int qmp_combo_configure_dp_swing(struct qmp_phy *qphy,
@@ -1421,10 +1427,10 @@ static int qmp_combo_configure_dp_swing(struct qmp_phy *qphy,
 	voltage_swing_cfg |= DP_PHY_TXn_TX_DRV_LVL_MUX_EN;
 	pre_emphasis_cfg |= DP_PHY_TXn_TX_EMP_POST1_LVL_MUX_EN;
 
-	writel(voltage_swing_cfg, qphy->tx + drv_lvl_reg);
-	writel(pre_emphasis_cfg, qphy->tx + emp_post_reg);
-	writel(voltage_swing_cfg, qphy->tx2 + drv_lvl_reg);
-	writel(pre_emphasis_cfg, qphy->tx2 + emp_post_reg);
+	writel(voltage_swing_cfg, qphy->dp_tx + drv_lvl_reg);
+	writel(pre_emphasis_cfg, qphy->dp_tx + emp_post_reg);
+	writel(voltage_swing_cfg, qphy->dp_tx2 + drv_lvl_reg);
+	writel(pre_emphasis_cfg, qphy->dp_tx2 + emp_post_reg);
 
 	return 0;
 }
@@ -1446,10 +1452,10 @@ static void qcom_qmp_v3_phy_configure_dp_tx(struct qmp_phy *qphy)
 		drvr_en = 0x10;
 	}
 
-	writel(drvr_en, qphy->tx + QSERDES_V3_TX_HIGHZ_DRVR_EN);
-	writel(bias_en, qphy->tx + QSERDES_V3_TX_TRANSCEIVER_BIAS_EN);
-	writel(drvr_en, qphy->tx2 + QSERDES_V3_TX_HIGHZ_DRVR_EN);
-	writel(bias_en, qphy->tx2 + QSERDES_V3_TX_TRANSCEIVER_BIAS_EN);
+	writel(drvr_en, qphy->dp_tx + QSERDES_V3_TX_HIGHZ_DRVR_EN);
+	writel(bias_en, qphy->dp_tx + QSERDES_V3_TX_TRANSCEIVER_BIAS_EN);
+	writel(drvr_en, qphy->dp_tx2 + QSERDES_V3_TX_HIGHZ_DRVR_EN);
+	writel(bias_en, qphy->dp_tx2 + QSERDES_V3_TX_TRANSCEIVER_BIAS_EN);
 }
 
 static bool qmp_combo_configure_dp_mode(struct qmp_phy *qphy)
@@ -1472,12 +1478,12 @@ static bool qmp_combo_configure_dp_mode(struct qmp_phy *qphy)
 	 * if (lane_cnt == 4 || orientation == ORIENTATION_CC1)
 	 *	val |= DP_PHY_PD_CTL_LANE_2_3_PWRDN;
 	 * if (orientation == ORIENTATION_CC2)
-	 *	writel(0x4c, qphy->pcs + QSERDES_V3_DP_PHY_MODE);
+	 *	writel(0x4c, qphy->dp_pcs + QSERDES_V3_DP_PHY_MODE);
 	 */
 	val |= DP_PHY_PD_CTL_LANE_2_3_PWRDN;
-	writel(val, qphy->pcs + QSERDES_DP_PHY_PD_CTL);
+	writel(val, qphy->dp_pcs + QSERDES_DP_PHY_PD_CTL);
 
-	writel(0x5c, qphy->pcs + QSERDES_DP_PHY_MODE);
+	writel(0x5c, qphy->dp_pcs + QSERDES_DP_PHY_MODE);
 
 	return reverse;
 }
@@ -1491,8 +1497,8 @@ static int qcom_qmp_v3_phy_configure_dp_phy(struct qmp_phy *qphy)
 
 	qmp_combo_configure_dp_mode(qphy);
 
-	writel(0x05, qphy->pcs + QSERDES_V3_DP_PHY_TX0_TX1_LANE_CTL);
-	writel(0x05, qphy->pcs + QSERDES_V3_DP_PHY_TX2_TX3_LANE_CTL);
+	writel(0x05, qphy->dp_pcs + QSERDES_V3_DP_PHY_TX0_TX1_LANE_CTL);
+	writel(0x05, qphy->dp_pcs + QSERDES_V3_DP_PHY_TX2_TX3_LANE_CTL);
 
 	switch (dp_opts->link_rate) {
 	case 1620:
@@ -1515,40 +1521,40 @@ static int qcom_qmp_v3_phy_configure_dp_phy(struct qmp_phy *qphy)
 		/* Other link rates aren't supported */
 		return -EINVAL;
 	}
-	writel(phy_vco_div, qphy->pcs + QSERDES_V3_DP_PHY_VCO_DIV);
+	writel(phy_vco_div, qphy->dp_pcs + QSERDES_V3_DP_PHY_VCO_DIV);
 
 	clk_set_rate(dp_clks->dp_link_hw.clk, dp_opts->link_rate * 100000);
 	clk_set_rate(dp_clks->dp_pixel_hw.clk, pixel_freq);
 
-	writel(0x04, qphy->pcs + QSERDES_DP_PHY_AUX_CFG2);
-	writel(0x01, qphy->pcs + QSERDES_DP_PHY_CFG);
-	writel(0x05, qphy->pcs + QSERDES_DP_PHY_CFG);
-	writel(0x01, qphy->pcs + QSERDES_DP_PHY_CFG);
-	writel(0x09, qphy->pcs + QSERDES_DP_PHY_CFG);
+	writel(0x04, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG2);
+	writel(0x01, qphy->dp_pcs + QSERDES_DP_PHY_CFG);
+	writel(0x05, qphy->dp_pcs + QSERDES_DP_PHY_CFG);
+	writel(0x01, qphy->dp_pcs + QSERDES_DP_PHY_CFG);
+	writel(0x09, qphy->dp_pcs + QSERDES_DP_PHY_CFG);
 
-	writel(0x20, qphy->serdes + QSERDES_V3_COM_RESETSM_CNTRL);
+	writel(0x20, qphy->dp_serdes + QSERDES_V3_COM_RESETSM_CNTRL);
 
-	if (readl_poll_timeout(qphy->serdes + QSERDES_V3_COM_C_READY_STATUS,
+	if (readl_poll_timeout(qphy->dp_serdes + QSERDES_V3_COM_C_READY_STATUS,
 			status,
 			((status & BIT(0)) > 0),
 			500,
 			10000))
 		return -ETIMEDOUT;
 
-	writel(0x19, qphy->pcs + QSERDES_DP_PHY_CFG);
+	writel(0x19, qphy->dp_pcs + QSERDES_DP_PHY_CFG);
 
-	if (readl_poll_timeout(qphy->pcs + QSERDES_V3_DP_PHY_STATUS,
+	if (readl_poll_timeout(qphy->dp_pcs + QSERDES_V3_DP_PHY_STATUS,
 			status,
 			((status & BIT(1)) > 0),
 			500,
 			10000))
 		return -ETIMEDOUT;
 
-	writel(0x18, qphy->pcs + QSERDES_DP_PHY_CFG);
+	writel(0x18, qphy->dp_pcs + QSERDES_DP_PHY_CFG);
 	udelay(2000);
-	writel(0x19, qphy->pcs + QSERDES_DP_PHY_CFG);
+	writel(0x19, qphy->dp_pcs + QSERDES_DP_PHY_CFG);
 
-	return readl_poll_timeout(qphy->pcs + QSERDES_V3_DP_PHY_STATUS,
+	return readl_poll_timeout(qphy->dp_pcs + QSERDES_V3_DP_PHY_STATUS,
 			status,
 			((status & BIT(1)) > 0),
 			500,
@@ -1568,7 +1574,7 @@ static int qcom_qmp_v3_dp_phy_calibrate(struct qmp_phy *qphy)
 	qphy->dp_aux_cfg %= ARRAY_SIZE(cfg1_settings);
 	val = cfg1_settings[qphy->dp_aux_cfg];
 
-	writel(val, qphy->pcs + QSERDES_DP_PHY_AUX_CFG1);
+	writel(val, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG1);
 
 	return 0;
 }
@@ -1577,37 +1583,37 @@ static void qcom_qmp_v4_phy_dp_aux_init(struct qmp_phy *qphy)
 {
 	writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_PSR_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
 	       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
-	       qphy->pcs + QSERDES_DP_PHY_PD_CTL);
+	       qphy->dp_pcs + QSERDES_DP_PHY_PD_CTL);
 
 	/* Turn on BIAS current for PHY/PLL */
-	writel(0x17, qphy->serdes + QSERDES_V4_COM_BIAS_EN_CLKBUFLR_EN);
-
-	writel(0x00, qphy->pcs + QSERDES_DP_PHY_AUX_CFG0);
-	writel(0x13, qphy->pcs + QSERDES_DP_PHY_AUX_CFG1);
-	writel(0xa4, qphy->pcs + QSERDES_DP_PHY_AUX_CFG2);
-	writel(0x00, qphy->pcs + QSERDES_DP_PHY_AUX_CFG3);
-	writel(0x0a, qphy->pcs + QSERDES_DP_PHY_AUX_CFG4);
-	writel(0x26, qphy->pcs + QSERDES_DP_PHY_AUX_CFG5);
-	writel(0x0a, qphy->pcs + QSERDES_DP_PHY_AUX_CFG6);
-	writel(0x03, qphy->pcs + QSERDES_DP_PHY_AUX_CFG7);
-	writel(0xb7, qphy->pcs + QSERDES_DP_PHY_AUX_CFG8);
-	writel(0x03, qphy->pcs + QSERDES_DP_PHY_AUX_CFG9);
+	writel(0x17, qphy->dp_serdes + QSERDES_V4_COM_BIAS_EN_CLKBUFLR_EN);
+
+	writel(0x00, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG0);
+	writel(0x13, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG1);
+	writel(0xa4, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG2);
+	writel(0x00, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG3);
+	writel(0x0a, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG4);
+	writel(0x26, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG5);
+	writel(0x0a, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG6);
+	writel(0x03, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG7);
+	writel(0xb7, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG8);
+	writel(0x03, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG9);
 	qphy->dp_aux_cfg = 0;
 
 	writel(PHY_AUX_STOP_ERR_MASK | PHY_AUX_DEC_ERR_MASK |
 	       PHY_AUX_SYNC_ERR_MASK | PHY_AUX_ALIGN_ERR_MASK |
 	       PHY_AUX_REQ_ERR_MASK,
-	       qphy->pcs + QSERDES_V4_DP_PHY_AUX_INTERRUPT_MASK);
+	       qphy->dp_pcs + QSERDES_V4_DP_PHY_AUX_INTERRUPT_MASK);
 }
 
 static void qcom_qmp_v4_phy_configure_dp_tx(struct qmp_phy *qphy)
 {
 	/* Program default values before writing proper values */
-	writel(0x27, qphy->tx + QSERDES_V4_TX_TX_DRV_LVL);
-	writel(0x27, qphy->tx2 + QSERDES_V4_TX_TX_DRV_LVL);
+	writel(0x27, qphy->dp_tx + QSERDES_V4_TX_TX_DRV_LVL);
+	writel(0x27, qphy->dp_tx2 + QSERDES_V4_TX_TX_DRV_LVL);
 
-	writel(0x20, qphy->tx + QSERDES_V4_TX_TX_EMP_POST1_LVL);
-	writel(0x20, qphy->tx2 + QSERDES_V4_TX_TX_EMP_POST1_LVL);
+	writel(0x20, qphy->dp_tx + QSERDES_V4_TX_TX_EMP_POST1_LVL);
+	writel(0x20, qphy->dp_tx2 + QSERDES_V4_TX_TX_EMP_POST1_LVL);
 
 	qmp_combo_configure_dp_swing(qphy, QSERDES_V4_TX_TX_DRV_LVL,
 			QSERDES_V4_TX_TX_EMP_POST1_LVL);
@@ -1620,15 +1626,15 @@ static int qcom_qmp_v45_phy_configure_dp_phy(struct qmp_phy *qphy)
 	u32 phy_vco_div, status;
 	unsigned long pixel_freq;
 
-	writel(0x0f, qphy->pcs + QSERDES_V4_DP_PHY_CFG_1);
+	writel(0x0f, qphy->dp_pcs + QSERDES_V4_DP_PHY_CFG_1);
 
 	qmp_combo_configure_dp_mode(qphy);
 
-	writel(0x13, qphy->pcs + QSERDES_DP_PHY_AUX_CFG1);
-	writel(0xa4, qphy->pcs + QSERDES_DP_PHY_AUX_CFG2);
+	writel(0x13, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG1);
+	writel(0xa4, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG2);
 
-	writel(0x05, qphy->pcs + QSERDES_V4_DP_PHY_TX0_TX1_LANE_CTL);
-	writel(0x05, qphy->pcs + QSERDES_V4_DP_PHY_TX2_TX3_LANE_CTL);
+	writel(0x05, qphy->dp_pcs + QSERDES_V4_DP_PHY_TX0_TX1_LANE_CTL);
+	writel(0x05, qphy->dp_pcs + QSERDES_V4_DP_PHY_TX2_TX3_LANE_CTL);
 
 	switch (dp_opts->link_rate) {
 	case 1620:
@@ -1651,49 +1657,49 @@ static int qcom_qmp_v45_phy_configure_dp_phy(struct qmp_phy *qphy)
 		/* Other link rates aren't supported */
 		return -EINVAL;
 	}
-	writel(phy_vco_div, qphy->pcs + QSERDES_V4_DP_PHY_VCO_DIV);
+	writel(phy_vco_div, qphy->dp_pcs + QSERDES_V4_DP_PHY_VCO_DIV);
 
 	clk_set_rate(dp_clks->dp_link_hw.clk, dp_opts->link_rate * 100000);
 	clk_set_rate(dp_clks->dp_pixel_hw.clk, pixel_freq);
 
-	writel(0x01, qphy->pcs + QSERDES_DP_PHY_CFG);
-	writel(0x05, qphy->pcs + QSERDES_DP_PHY_CFG);
-	writel(0x01, qphy->pcs + QSERDES_DP_PHY_CFG);
-	writel(0x09, qphy->pcs + QSERDES_DP_PHY_CFG);
+	writel(0x01, qphy->dp_pcs + QSERDES_DP_PHY_CFG);
+	writel(0x05, qphy->dp_pcs + QSERDES_DP_PHY_CFG);
+	writel(0x01, qphy->dp_pcs + QSERDES_DP_PHY_CFG);
+	writel(0x09, qphy->dp_pcs + QSERDES_DP_PHY_CFG);
 
-	writel(0x20, qphy->serdes + QSERDES_V4_COM_RESETSM_CNTRL);
+	writel(0x20, qphy->dp_serdes + QSERDES_V4_COM_RESETSM_CNTRL);
 
-	if (readl_poll_timeout(qphy->serdes + QSERDES_V4_COM_C_READY_STATUS,
+	if (readl_poll_timeout(qphy->dp_serdes + QSERDES_V4_COM_C_READY_STATUS,
 			status,
 			((status & BIT(0)) > 0),
 			500,
 			10000))
 		return -ETIMEDOUT;
 
-	if (readl_poll_timeout(qphy->serdes + QSERDES_V4_COM_CMN_STATUS,
+	if (readl_poll_timeout(qphy->dp_serdes + QSERDES_V4_COM_CMN_STATUS,
 			status,
 			((status & BIT(0)) > 0),
 			500,
 			10000))
 		return -ETIMEDOUT;
 
-	if (readl_poll_timeout(qphy->serdes + QSERDES_V4_COM_CMN_STATUS,
+	if (readl_poll_timeout(qphy->dp_serdes + QSERDES_V4_COM_CMN_STATUS,
 			status,
 			((status & BIT(1)) > 0),
 			500,
 			10000))
 		return -ETIMEDOUT;
 
-	writel(0x19, qphy->pcs + QSERDES_DP_PHY_CFG);
+	writel(0x19, qphy->dp_pcs + QSERDES_DP_PHY_CFG);
 
-	if (readl_poll_timeout(qphy->pcs + QSERDES_V4_DP_PHY_STATUS,
+	if (readl_poll_timeout(qphy->dp_pcs + QSERDES_V4_DP_PHY_STATUS,
 			status,
 			((status & BIT(0)) > 0),
 			500,
 			10000))
 		return -ETIMEDOUT;
 
-	if (readl_poll_timeout(qphy->pcs + QSERDES_V4_DP_PHY_STATUS,
+	if (readl_poll_timeout(qphy->dp_pcs + QSERDES_V4_DP_PHY_STATUS,
 			status,
 			((status & BIT(1)) > 0),
 			500,
@@ -1737,30 +1743,30 @@ static int qcom_qmp_v4_phy_configure_dp_phy(struct qmp_phy *qphy)
 		drvr1_en = 0x10;
 	}
 
-	writel(drvr0_en, qphy->tx + QSERDES_V4_TX_HIGHZ_DRVR_EN);
-	writel(bias0_en, qphy->tx + QSERDES_V4_TX_TRANSCEIVER_BIAS_EN);
-	writel(drvr1_en, qphy->tx2 + QSERDES_V4_TX_HIGHZ_DRVR_EN);
-	writel(bias1_en, qphy->tx2 + QSERDES_V4_TX_TRANSCEIVER_BIAS_EN);
+	writel(drvr0_en, qphy->dp_tx + QSERDES_V4_TX_HIGHZ_DRVR_EN);
+	writel(bias0_en, qphy->dp_tx + QSERDES_V4_TX_TRANSCEIVER_BIAS_EN);
+	writel(drvr1_en, qphy->dp_tx2 + QSERDES_V4_TX_HIGHZ_DRVR_EN);
+	writel(bias1_en, qphy->dp_tx2 + QSERDES_V4_TX_TRANSCEIVER_BIAS_EN);
 
-	writel(0x18, qphy->pcs + QSERDES_DP_PHY_CFG);
+	writel(0x18, qphy->dp_pcs + QSERDES_DP_PHY_CFG);
 	udelay(2000);
-	writel(0x19, qphy->pcs + QSERDES_DP_PHY_CFG);
+	writel(0x19, qphy->dp_pcs + QSERDES_DP_PHY_CFG);
 
-	if (readl_poll_timeout(qphy->pcs + QSERDES_V4_DP_PHY_STATUS,
+	if (readl_poll_timeout(qphy->dp_pcs + QSERDES_V4_DP_PHY_STATUS,
 			status,
 			((status & BIT(1)) > 0),
 			500,
 			10000))
 		return -ETIMEDOUT;
 
-	writel(0x0a, qphy->tx + QSERDES_V4_TX_TX_POL_INV);
-	writel(0x0a, qphy->tx2 + QSERDES_V4_TX_TX_POL_INV);
+	writel(0x0a, qphy->dp_tx + QSERDES_V4_TX_TX_POL_INV);
+	writel(0x0a, qphy->dp_tx2 + QSERDES_V4_TX_TX_POL_INV);
 
-	writel(0x27, qphy->tx + QSERDES_V4_TX_TX_DRV_LVL);
-	writel(0x27, qphy->tx2 + QSERDES_V4_TX_TX_DRV_LVL);
+	writel(0x27, qphy->dp_tx + QSERDES_V4_TX_TX_DRV_LVL);
+	writel(0x27, qphy->dp_tx2 + QSERDES_V4_TX_TX_DRV_LVL);
 
-	writel(0x20, qphy->tx + QSERDES_V4_TX_TX_EMP_POST1_LVL);
-	writel(0x20, qphy->tx2 + QSERDES_V4_TX_TX_EMP_POST1_LVL);
+	writel(0x20, qphy->dp_tx + QSERDES_V4_TX_TX_EMP_POST1_LVL);
+	writel(0x20, qphy->dp_tx2 + QSERDES_V4_TX_TX_EMP_POST1_LVL);
 
 	return 0;
 }
@@ -1794,30 +1800,30 @@ static int qcom_qmp_v5_phy_configure_dp_phy(struct qmp_phy *qphy)
 		drvr1_en = 0x10;
 	}
 
-	writel(drvr0_en, qphy->tx + QSERDES_V5_5NM_TX_HIGHZ_DRVR_EN);
-	writel(bias0_en, qphy->tx + QSERDES_V5_5NM_TX_TRANSCEIVER_BIAS_EN);
-	writel(drvr1_en, qphy->tx2 + QSERDES_V5_5NM_TX_HIGHZ_DRVR_EN);
-	writel(bias1_en, qphy->tx2 + QSERDES_V5_5NM_TX_TRANSCEIVER_BIAS_EN);
+	writel(drvr0_en, qphy->dp_tx + QSERDES_V5_5NM_TX_HIGHZ_DRVR_EN);
+	writel(bias0_en, qphy->dp_tx + QSERDES_V5_5NM_TX_TRANSCEIVER_BIAS_EN);
+	writel(drvr1_en, qphy->dp_tx2 + QSERDES_V5_5NM_TX_HIGHZ_DRVR_EN);
+	writel(bias1_en, qphy->dp_tx2 + QSERDES_V5_5NM_TX_TRANSCEIVER_BIAS_EN);
 
-	writel(0x18, qphy->pcs + QSERDES_DP_PHY_CFG);
+	writel(0x18, qphy->dp_pcs + QSERDES_DP_PHY_CFG);
 	udelay(2000);
-	writel(0x19, qphy->pcs + QSERDES_DP_PHY_CFG);
+	writel(0x19, qphy->dp_pcs + QSERDES_DP_PHY_CFG);
 
-	if (readl_poll_timeout(qphy->pcs + QSERDES_V4_DP_PHY_STATUS,
+	if (readl_poll_timeout(qphy->dp_pcs + QSERDES_V4_DP_PHY_STATUS,
 			status,
 			((status & BIT(1)) > 0),
 			500,
 			10000))
 		return -ETIMEDOUT;
 
-	writel(0x0a, qphy->tx + QSERDES_V5_5NM_TX_TX_POL_INV);
-	writel(0x0a, qphy->tx2 + QSERDES_V5_5NM_TX_TX_POL_INV);
+	writel(0x0a, qphy->dp_tx + QSERDES_V5_5NM_TX_TX_POL_INV);
+	writel(0x0a, qphy->dp_tx2 + QSERDES_V5_5NM_TX_TX_POL_INV);
 
-	writel(0x27, qphy->tx + QSERDES_V5_5NM_TX_TX_DRV_LVL);
-	writel(0x27, qphy->tx2 + QSERDES_V5_5NM_TX_TX_DRV_LVL);
+	writel(0x27, qphy->dp_tx + QSERDES_V5_5NM_TX_TX_DRV_LVL);
+	writel(0x27, qphy->dp_tx2 + QSERDES_V5_5NM_TX_TX_DRV_LVL);
 
-	writel(0x20, qphy->tx + QSERDES_V5_5NM_TX_TX_EMP_POST1_LVL);
-	writel(0x20, qphy->tx2 + QSERDES_V5_5NM_TX_TX_EMP_POST1_LVL);
+	writel(0x20, qphy->dp_tx + QSERDES_V5_5NM_TX_TX_EMP_POST1_LVL);
+	writel(0x20, qphy->dp_tx2 + QSERDES_V5_5NM_TX_TX_EMP_POST1_LVL);
 
 	return 0;
 }
@@ -1835,7 +1841,7 @@ static int qcom_qmp_v4_dp_phy_calibrate(struct qmp_phy *qphy)
 	qphy->dp_aux_cfg %= ARRAY_SIZE(cfg1_settings);
 	val = cfg1_settings[qphy->dp_aux_cfg];
 
-	writel(val, qphy->pcs + QSERDES_DP_PHY_AUX_CFG1);
+	writel(val, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG1);
 
 	return 0;
 }
@@ -1990,14 +1996,14 @@ static int qmp_combo_dp_power_on(struct phy *phy)
 {
 	struct qmp_phy *qphy = phy_get_drvdata(phy);
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
-	void __iomem *tx = qphy->tx;
+	void __iomem *tx = qphy->dp_tx;
 
 	qmp_combo_dp_serdes_init(qphy);
 
 	qmp_combo_configure_lane(tx, cfg->tx_tbl, cfg->tx_tbl_num, 1);
 
 	if (cfg->lanes >= 2)
-		qmp_combo_configure_lane(qphy->tx2, cfg->tx_tbl, cfg->tx_tbl_num, 2);
+		qmp_combo_configure_lane(qphy->dp_tx2, cfg->tx_tbl, cfg->tx_tbl_num, 2);
 
 	/* Configure special DP tx tunings */
 	cfg->configure_dp_tx(qphy);
@@ -2013,7 +2019,7 @@ static int qmp_combo_dp_power_off(struct phy *phy)
 	struct qmp_phy *qphy = phy_get_drvdata(phy);
 
 	/* Assert DP PHY power down */
-	writel(DP_PHY_PD_CTL_PSR_PWRDN, qphy->pcs + QSERDES_DP_PHY_PD_CTL);
+	writel(DP_PHY_PD_CTL_PSR_PWRDN, qphy->dp_pcs + QSERDES_DP_PHY_PD_CTL);
 
 	return 0;
 }
@@ -2589,7 +2595,7 @@ static int qmp_combo_create_dp(struct device *dev, struct device_node *np, int i
 		return -ENOMEM;
 
 	qphy->cfg = cfg;
-	qphy->serdes = serdes;
+	qphy->dp_serdes = serdes;
 	/*
 	 * Get memory resources for each PHY:
 	 * Resources are indexed as: tx -> 0; rx -> 1; pcs -> 2.
@@ -2598,18 +2604,18 @@ static int qmp_combo_create_dp(struct device *dev, struct device_node *np, int i
 	 *
 	 * Note that only tx/tx2 and pcs are used by the DP implementation.
 	 */
-	qphy->tx = devm_of_iomap(dev, np, 0, NULL);
-	if (IS_ERR(qphy->tx))
-		return PTR_ERR(qphy->tx);
+	qphy->dp_tx = devm_of_iomap(dev, np, 0, NULL);
+	if (IS_ERR(qphy->dp_tx))
+		return PTR_ERR(qphy->dp_tx);
 
-	qphy->pcs = devm_of_iomap(dev, np, 2, NULL);
-	if (IS_ERR(qphy->pcs))
-		return PTR_ERR(qphy->pcs);
+	qphy->dp_pcs = devm_of_iomap(dev, np, 2, NULL);
+	if (IS_ERR(qphy->dp_pcs))
+		return PTR_ERR(qphy->dp_pcs);
 
 	if (cfg->lanes >= 2) {
-		qphy->tx2 = devm_of_iomap(dev, np, 3, NULL);
-		if (IS_ERR(qphy->tx2))
-			return PTR_ERR(qphy->tx2);
+		qphy->dp_tx2 = devm_of_iomap(dev, np, 3, NULL);
+		if (IS_ERR(qphy->dp_tx2))
+			return PTR_ERR(qphy->dp_tx2);
 	}
 
 	generic_phy = devm_phy_create(dev, np, &qmp_combo_dp_phy_ops);
-- 
2.37.4

