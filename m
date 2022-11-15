Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D059B629C74
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238445AbiKOOmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbiKOOk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:40:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03F327CFA;
        Tue, 15 Nov 2022 06:40:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3A57617DC;
        Tue, 15 Nov 2022 14:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2681C4FF0D;
        Tue, 15 Nov 2022 14:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668523253;
        bh=ewU3Baa1QStipHyL7o/oq4pVac9NfkbMr787am7ssUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PFQvGYv5A4xCoZCsKPfezBt6LVRN/DER3DBQfx4RP69SaS2/mpHLONm9hV4LZ8C0B
         W3nxmLnUf4G2Cd0p3sHHyjUrxd+yQY/z23vyjbF0lO18xW4qLOSLE79BqENbmAkH9S
         MnwolQcSSbOKCYQiebw0UZ/0DpQkKZ4IIQeqJWgu0/pj/vthh5x6pouMz2EsSku58L
         n/pSnKcS7roh4HFtKfJCZBdiPsliOZqQ3/zc0Blinun9hiitXqgnjHk44zdJ2HWMTe
         MlSBdgxQ2iUbNyhs3KJFEFMKv7oQ186ydXrnHW52+5KSxIjJcI1n8t+NgU4x9CB+3S
         40jgY/+7HlEkw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oux6t-0000fv-Fq; Tue, 15 Nov 2022 15:40:23 +0100
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
Subject: [PATCH v2 12/15] phy: qcom-qmp-combo: rename DP_PHY register pointer
Date:   Tue, 15 Nov 2022 15:40:02 +0100
Message-Id: <20221115144005.2478-13-johan+linaro@kernel.org>
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

The DP_PHY registers have erroneously been referred to as "PCS"
registers since DisplayPort support was added to the QMP drivers
(including in the devicetree binding).

Rename the corresponding pointer to match the register names.

Note that the repeated "dp" in the field name is intentional and this DP
register block is called "DP_PHY" (not just "PHY").

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 139 +++++++++++-----------
 1 file changed, 70 insertions(+), 69 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 5777bd1f76b3..b82bd0a221d6 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -878,7 +878,7 @@ struct qmp_combo {
 	void __iomem *dp_serdes;
 	void __iomem *dp_tx;
 	void __iomem *dp_tx2;
-	void __iomem *dp_pcs;
+	void __iomem *dp_dp_phy;
 
 	struct clk *pipe_clk;
 	struct clk_bulk_data *clks;
@@ -1252,20 +1252,20 @@ static void qmp_v3_dp_aux_init(struct qmp_combo *qmp)
 {
 	writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
 	       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
-	       qmp->dp_pcs + QSERDES_DP_PHY_PD_CTL);
+	       qmp->dp_dp_phy + QSERDES_DP_PHY_PD_CTL);
 
 	/* Turn on BIAS current for PHY/PLL */
 	writel(QSERDES_V3_COM_BIAS_EN | QSERDES_V3_COM_BIAS_EN_MUX |
 	       QSERDES_V3_COM_CLKBUF_L_EN | QSERDES_V3_COM_EN_SYSCLK_TX_SEL,
 	       qmp->dp_serdes + QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN);
 
-	writel(DP_PHY_PD_CTL_PSR_PWRDN, qmp->dp_pcs + QSERDES_DP_PHY_PD_CTL);
+	writel(DP_PHY_PD_CTL_PSR_PWRDN, qmp->dp_dp_phy + QSERDES_DP_PHY_PD_CTL);
 
 	writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
 	       DP_PHY_PD_CTL_LANE_0_1_PWRDN |
 	       DP_PHY_PD_CTL_LANE_2_3_PWRDN | DP_PHY_PD_CTL_PLL_PWRDN |
 	       DP_PHY_PD_CTL_DP_CLAMP_EN,
-	       qmp->dp_pcs + QSERDES_DP_PHY_PD_CTL);
+	       qmp->dp_dp_phy + QSERDES_DP_PHY_PD_CTL);
 
 	writel(QSERDES_V3_COM_BIAS_EN |
 	       QSERDES_V3_COM_BIAS_EN_MUX | QSERDES_V3_COM_CLKBUF_R_EN |
@@ -1273,22 +1273,22 @@ static void qmp_v3_dp_aux_init(struct qmp_combo *qmp)
 	       QSERDES_V3_COM_CLKBUF_RX_DRIVE_L,
 	       qmp->dp_serdes + QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN);
 
-	writel(0x00, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG0);
-	writel(0x13, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG1);
-	writel(0x24, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG2);
-	writel(0x00, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG3);
-	writel(0x0a, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG4);
-	writel(0x26, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG5);
-	writel(0x0a, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG6);
-	writel(0x03, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG7);
-	writel(0xbb, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG8);
-	writel(0x03, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG9);
+	writel(0x00, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG0);
+	writel(0x13, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG1);
+	writel(0x24, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG2);
+	writel(0x00, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG3);
+	writel(0x0a, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG4);
+	writel(0x26, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG5);
+	writel(0x0a, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG6);
+	writel(0x03, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG7);
+	writel(0xbb, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG8);
+	writel(0x03, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG9);
 	qmp->dp_aux_cfg = 0;
 
 	writel(PHY_AUX_STOP_ERR_MASK | PHY_AUX_DEC_ERR_MASK |
 	       PHY_AUX_SYNC_ERR_MASK | PHY_AUX_ALIGN_ERR_MASK |
 	       PHY_AUX_REQ_ERR_MASK,
-	       qmp->dp_pcs + QSERDES_V3_DP_PHY_AUX_INTERRUPT_MASK);
+	       qmp->dp_dp_phy + QSERDES_V3_DP_PHY_AUX_INTERRUPT_MASK);
 }
 
 static int qmp_combo_configure_dp_swing(struct qmp_combo *qmp,
@@ -1372,12 +1372,12 @@ static bool qmp_combo_configure_dp_mode(struct qmp_combo *qmp)
 	 * if (lane_cnt == 4 || orientation == ORIENTATION_CC1)
 	 *	val |= DP_PHY_PD_CTL_LANE_2_3_PWRDN;
 	 * if (orientation == ORIENTATION_CC2)
-	 *	writel(0x4c, qmp->dp_pcs + QSERDES_V3_DP_PHY_MODE);
+	 *	writel(0x4c, qmp->dp_dp_phy + QSERDES_V3_DP_PHY_MODE);
 	 */
 	val |= DP_PHY_PD_CTL_LANE_2_3_PWRDN;
-	writel(val, qmp->dp_pcs + QSERDES_DP_PHY_PD_CTL);
+	writel(val, qmp->dp_dp_phy + QSERDES_DP_PHY_PD_CTL);
 
-	writel(0x5c, qmp->dp_pcs + QSERDES_DP_PHY_MODE);
+	writel(0x5c, qmp->dp_dp_phy + QSERDES_DP_PHY_MODE);
 
 	return reverse;
 }
@@ -1390,8 +1390,8 @@ static int qmp_v3_configure_dp_phy(struct qmp_combo *qmp)
 
 	qmp_combo_configure_dp_mode(qmp);
 
-	writel(0x05, qmp->dp_pcs + QSERDES_V3_DP_PHY_TX0_TX1_LANE_CTL);
-	writel(0x05, qmp->dp_pcs + QSERDES_V3_DP_PHY_TX2_TX3_LANE_CTL);
+	writel(0x05, qmp->dp_dp_phy + QSERDES_V3_DP_PHY_TX0_TX1_LANE_CTL);
+	writel(0x05, qmp->dp_dp_phy + QSERDES_V3_DP_PHY_TX2_TX3_LANE_CTL);
 
 	switch (dp_opts->link_rate) {
 	case 1620:
@@ -1414,16 +1414,16 @@ static int qmp_v3_configure_dp_phy(struct qmp_combo *qmp)
 		/* Other link rates aren't supported */
 		return -EINVAL;
 	}
-	writel(phy_vco_div, qmp->dp_pcs + QSERDES_V3_DP_PHY_VCO_DIV);
+	writel(phy_vco_div, qmp->dp_dp_phy + QSERDES_V3_DP_PHY_VCO_DIV);
 
 	clk_set_rate(qmp->dp_link_hw.clk, dp_opts->link_rate * 100000);
 	clk_set_rate(qmp->dp_pixel_hw.clk, pixel_freq);
 
-	writel(0x04, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG2);
-	writel(0x01, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
-	writel(0x05, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
-	writel(0x01, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
-	writel(0x09, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
+	writel(0x04, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG2);
+	writel(0x01, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
+	writel(0x05, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
+	writel(0x01, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
+	writel(0x09, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
 
 	writel(0x20, qmp->dp_serdes + QSERDES_V3_COM_RESETSM_CNTRL);
 
@@ -1434,20 +1434,20 @@ static int qmp_v3_configure_dp_phy(struct qmp_combo *qmp)
 			10000))
 		return -ETIMEDOUT;
 
-	writel(0x19, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
+	writel(0x19, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
 
-	if (readl_poll_timeout(qmp->dp_pcs + QSERDES_V3_DP_PHY_STATUS,
+	if (readl_poll_timeout(qmp->dp_dp_phy + QSERDES_V3_DP_PHY_STATUS,
 			status,
 			((status & BIT(1)) > 0),
 			500,
 			10000))
 		return -ETIMEDOUT;
 
-	writel(0x18, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
+	writel(0x18, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
 	udelay(2000);
-	writel(0x19, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
+	writel(0x19, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
 
-	return readl_poll_timeout(qmp->dp_pcs + QSERDES_V3_DP_PHY_STATUS,
+	return readl_poll_timeout(qmp->dp_dp_phy + QSERDES_V3_DP_PHY_STATUS,
 			status,
 			((status & BIT(1)) > 0),
 			500,
@@ -1467,7 +1467,7 @@ static int qmp_v3_calibrate_dp_phy(struct qmp_combo *qmp)
 	qmp->dp_aux_cfg %= ARRAY_SIZE(cfg1_settings);
 	val = cfg1_settings[qmp->dp_aux_cfg];
 
-	writel(val, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG1);
+	writel(val, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG1);
 
 	return 0;
 }
@@ -1476,27 +1476,27 @@ static void qmp_v4_dp_aux_init(struct qmp_combo *qmp)
 {
 	writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_PSR_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
 	       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
-	       qmp->dp_pcs + QSERDES_DP_PHY_PD_CTL);
+	       qmp->dp_dp_phy + QSERDES_DP_PHY_PD_CTL);
 
 	/* Turn on BIAS current for PHY/PLL */
 	writel(0x17, qmp->dp_serdes + QSERDES_V4_COM_BIAS_EN_CLKBUFLR_EN);
 
-	writel(0x00, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG0);
-	writel(0x13, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG1);
-	writel(0xa4, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG2);
-	writel(0x00, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG3);
-	writel(0x0a, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG4);
-	writel(0x26, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG5);
-	writel(0x0a, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG6);
-	writel(0x03, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG7);
-	writel(0xb7, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG8);
-	writel(0x03, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG9);
+	writel(0x00, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG0);
+	writel(0x13, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG1);
+	writel(0xa4, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG2);
+	writel(0x00, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG3);
+	writel(0x0a, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG4);
+	writel(0x26, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG5);
+	writel(0x0a, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG6);
+	writel(0x03, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG7);
+	writel(0xb7, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG8);
+	writel(0x03, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG9);
 	qmp->dp_aux_cfg = 0;
 
 	writel(PHY_AUX_STOP_ERR_MASK | PHY_AUX_DEC_ERR_MASK |
 	       PHY_AUX_SYNC_ERR_MASK | PHY_AUX_ALIGN_ERR_MASK |
 	       PHY_AUX_REQ_ERR_MASK,
-	       qmp->dp_pcs + QSERDES_V4_DP_PHY_AUX_INTERRUPT_MASK);
+	       qmp->dp_dp_phy + QSERDES_V4_DP_PHY_AUX_INTERRUPT_MASK);
 }
 
 static void qmp_v4_configure_dp_tx(struct qmp_combo *qmp)
@@ -1518,15 +1518,15 @@ static int qmp_v45_configure_dp_phy(struct qmp_combo *qmp)
 	u32 phy_vco_div, status;
 	unsigned long pixel_freq;
 
-	writel(0x0f, qmp->dp_pcs + QSERDES_V4_DP_PHY_CFG_1);
+	writel(0x0f, qmp->dp_dp_phy + QSERDES_V4_DP_PHY_CFG_1);
 
 	qmp_combo_configure_dp_mode(qmp);
 
-	writel(0x13, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG1);
-	writel(0xa4, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG2);
+	writel(0x13, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG1);
+	writel(0xa4, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG2);
 
-	writel(0x05, qmp->dp_pcs + QSERDES_V4_DP_PHY_TX0_TX1_LANE_CTL);
-	writel(0x05, qmp->dp_pcs + QSERDES_V4_DP_PHY_TX2_TX3_LANE_CTL);
+	writel(0x05, qmp->dp_dp_phy + QSERDES_V4_DP_PHY_TX0_TX1_LANE_CTL);
+	writel(0x05, qmp->dp_dp_phy + QSERDES_V4_DP_PHY_TX2_TX3_LANE_CTL);
 
 	switch (dp_opts->link_rate) {
 	case 1620:
@@ -1549,15 +1549,15 @@ static int qmp_v45_configure_dp_phy(struct qmp_combo *qmp)
 		/* Other link rates aren't supported */
 		return -EINVAL;
 	}
-	writel(phy_vco_div, qmp->dp_pcs + QSERDES_V4_DP_PHY_VCO_DIV);
+	writel(phy_vco_div, qmp->dp_dp_phy + QSERDES_V4_DP_PHY_VCO_DIV);
 
 	clk_set_rate(qmp->dp_link_hw.clk, dp_opts->link_rate * 100000);
 	clk_set_rate(qmp->dp_pixel_hw.clk, pixel_freq);
 
-	writel(0x01, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
-	writel(0x05, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
-	writel(0x01, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
-	writel(0x09, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
+	writel(0x01, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
+	writel(0x05, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
+	writel(0x01, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
+	writel(0x09, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
 
 	writel(0x20, qmp->dp_serdes + QSERDES_V4_COM_RESETSM_CNTRL);
 
@@ -1582,16 +1582,16 @@ static int qmp_v45_configure_dp_phy(struct qmp_combo *qmp)
 			10000))
 		return -ETIMEDOUT;
 
-	writel(0x19, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
+	writel(0x19, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
 
-	if (readl_poll_timeout(qmp->dp_pcs + QSERDES_V4_DP_PHY_STATUS,
+	if (readl_poll_timeout(qmp->dp_dp_phy + QSERDES_V4_DP_PHY_STATUS,
 			status,
 			((status & BIT(0)) > 0),
 			500,
 			10000))
 		return -ETIMEDOUT;
 
-	if (readl_poll_timeout(qmp->dp_pcs + QSERDES_V4_DP_PHY_STATUS,
+	if (readl_poll_timeout(qmp->dp_dp_phy + QSERDES_V4_DP_PHY_STATUS,
 			status,
 			((status & BIT(1)) > 0),
 			500,
@@ -1640,11 +1640,11 @@ static int qmp_v4_configure_dp_phy(struct qmp_combo *qmp)
 	writel(drvr1_en, qmp->dp_tx2 + QSERDES_V4_TX_HIGHZ_DRVR_EN);
 	writel(bias1_en, qmp->dp_tx2 + QSERDES_V4_TX_TRANSCEIVER_BIAS_EN);
 
-	writel(0x18, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
+	writel(0x18, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
 	udelay(2000);
-	writel(0x19, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
+	writel(0x19, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
 
-	if (readl_poll_timeout(qmp->dp_pcs + QSERDES_V4_DP_PHY_STATUS,
+	if (readl_poll_timeout(qmp->dp_dp_phy + QSERDES_V4_DP_PHY_STATUS,
 			status,
 			((status & BIT(1)) > 0),
 			500,
@@ -1697,11 +1697,11 @@ static int qmp_v5_configure_dp_phy(struct qmp_combo *qmp)
 	writel(drvr1_en, qmp->dp_tx2 + QSERDES_V5_5NM_TX_HIGHZ_DRVR_EN);
 	writel(bias1_en, qmp->dp_tx2 + QSERDES_V5_5NM_TX_TRANSCEIVER_BIAS_EN);
 
-	writel(0x18, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
+	writel(0x18, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
 	udelay(2000);
-	writel(0x19, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
+	writel(0x19, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
 
-	if (readl_poll_timeout(qmp->dp_pcs + QSERDES_V4_DP_PHY_STATUS,
+	if (readl_poll_timeout(qmp->dp_dp_phy + QSERDES_V4_DP_PHY_STATUS,
 			status,
 			((status & BIT(1)) > 0),
 			500,
@@ -1733,7 +1733,7 @@ static int qmp_v4_calibrate_dp_phy(struct qmp_combo *qmp)
 	qmp->dp_aux_cfg %= ARRAY_SIZE(cfg1_settings);
 	val = cfg1_settings[qmp->dp_aux_cfg];
 
-	writel(val, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG1);
+	writel(val, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG1);
 
 	return 0;
 }
@@ -1906,7 +1906,7 @@ static int qmp_combo_dp_power_off(struct phy *phy)
 	struct qmp_combo *qmp = phy_get_drvdata(phy);
 
 	/* Assert DP PHY power down */
-	writel(DP_PHY_PD_CTL_PSR_PWRDN, qmp->dp_pcs + QSERDES_DP_PHY_PD_CTL);
+	writel(DP_PHY_PD_CTL_PSR_PWRDN, qmp->dp_dp_phy + QSERDES_DP_PHY_PD_CTL);
 
 	return 0;
 }
@@ -2463,15 +2463,16 @@ static int qmp_combo_parse_dt_lecacy_dp(struct qmp_combo *qmp, struct device_nod
 	 * Resources are indexed as: tx -> 0; rx -> 1; pcs -> 2;
 	 * tx2 -> 3; rx2 -> 4
 	 *
-	 * Note that only tx/tx2 and pcs are used by the DP implementation.
+	 * Note that only tx/tx2 and pcs (dp_phy) are used by the DP
+	 * implementation.
 	 */
 	qmp->dp_tx = devm_of_iomap(dev, np, 0, NULL);
 	if (IS_ERR(qmp->dp_tx))
 		return PTR_ERR(qmp->dp_tx);
 
-	qmp->dp_pcs = devm_of_iomap(dev, np, 2, NULL);
-	if (IS_ERR(qmp->dp_pcs))
-		return PTR_ERR(qmp->dp_pcs);
+	qmp->dp_dp_phy = devm_of_iomap(dev, np, 2, NULL);
+	if (IS_ERR(qmp->dp_dp_phy))
+		return PTR_ERR(qmp->dp_dp_phy);
 
 	qmp->dp_tx2 = devm_of_iomap(dev, np, 3, NULL);
 	if (IS_ERR(qmp->dp_tx2))
-- 
2.37.4

