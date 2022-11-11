Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C4E625607
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbiKKI7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiKKI53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:57:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F057E98B;
        Fri, 11 Nov 2022 00:57:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5F5461F05;
        Fri, 11 Nov 2022 08:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1155BC4FF0E;
        Fri, 11 Nov 2022 08:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668157044;
        bh=Zk41rYS/mD6UeZ/7xUGOLA6Q2ojmVkgiGVNAlvzFQ9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YmZ+p5aDmdxx9wWoiikPYPVEagKMVHGARyXzBg9+ObGDdASCMYrz7RPkVaq7xDkCO
         +iS/OD0rSXOGv5HxfP72Pmajb68SHBuBbiAEL0sn2vmYHQ7mdrdwTS50fptbRDw7y2
         +8pQJCYJWSIdOc9zaRL5aJi58cf/EAoJG0Nnx1VeToIGXAsaMKy1y7UzDpVTmydMgZ
         z0/lhj5q5F+mOv991FAICcT5g+UWWChMIieZ05yCroApAjx0/iB1hQyYgSSIyPqloO
         MKZSuZrDSL3q1lDQ8IcqXqSoCYlN9uRTLDiBqwILw1w+3aqSj2Etm57hOBXqPPSYaE
         rArNtQ4jiMYdg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1otPqK-0002Ud-Cf; Fri, 11 Nov 2022 09:56:56 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 18/22] phy: qcom-qmp-combo: merge driver data
Date:   Fri, 11 Nov 2022 09:56:39 +0100
Message-Id: <20221111085643.9478-19-johan+linaro@kernel.org>
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

The QMP combo driver manages a single PHY (even if it provides two
interfaces for USB and DP, respectively) so merge the old qcom_qmp and
qmp_phy structures and drop the PHY array.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 690 ++++++++++------------
 1 file changed, 313 insertions(+), 377 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 249912b75964..43b7ea5d2edc 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -796,7 +796,7 @@ static const u8 qmp_dp_v5_voltage_swing_hbr_rbr[4][4] = {
 	{ 0x3f, 0xff, 0xff, 0xff }
 };
 
-struct qmp_phy;
+struct qmp_combo;
 
 struct qmp_phy_cfg {
 	int lanes;
@@ -835,10 +835,10 @@ struct qmp_phy_cfg {
 	const u8 (*pre_emphasis_hbr3_hbr2)[4][4];
 
 	/* DP PHY callbacks */
-	int (*configure_dp_phy)(struct qmp_phy *qphy);
-	void (*configure_dp_tx)(struct qmp_phy *qphy);
-	int (*calibrate_dp_phy)(struct qmp_phy *qphy);
-	void (*dp_aux_init)(struct qmp_phy *qphy);
+	int (*configure_dp_phy)(struct qmp_combo *qmp);
+	void (*configure_dp_tx)(struct qmp_combo *qmp);
+	int (*calibrate_dp_phy)(struct qmp_combo *qmp);
+	void (*dp_aux_init)(struct qmp_combo *qmp);
 
 	/* clock ids to be requested */
 	const char * const *clk_list;
@@ -861,29 +861,19 @@ struct qmp_phy_cfg {
 
 };
 
-/**
- * struct qmp_phy - per-lane phy descriptor
- *
- * @phy: generic phy
- * @cfg: phy specific configuration
- * @serdes: iomapped memory space for phy's serdes (i.e. PLL)
- * @tx: iomapped memory space for lane's tx
- * @rx: iomapped memory space for lane's rx
- * @pcs: iomapped memory space for lane's pcs
- * @tx2: iomapped memory space for second lane's tx (in dual lane PHYs)
- * @rx2: iomapped memory space for second lane's rx (in dual lane PHYs)
- * @pcs_misc: iomapped memory space for lane's pcs_misc
- * @pcs_usb: iomapped memory space for lane's pcs_usb
- * @pipe_clk: pipe clock
- * @qmp: QMP phy to which this lane belongs
- * @mode: current PHY mode
- * @dp_aux_cfg: Display port aux config
- * @dp_opts: Display port optional config
- * @dp_clks: Display port clocks
- */
-struct qmp_phy {
-	struct phy *phy;
+struct qmp_phy_dp_clks {
+	struct qmp_combo *qmp;
+	struct clk_hw dp_link_hw;
+	struct clk_hw dp_pixel_hw;
+};
+
+struct qmp_combo {
+	struct device *dev;
+
 	const struct qmp_phy_cfg *cfg;
+
+	void __iomem *dp_com;
+
 	void __iomem *serdes;
 	void __iomem *tx;
 	void __iomem *rx;
@@ -899,59 +889,33 @@ struct qmp_phy {
 	void __iomem *dp_pcs;
 
 	struct clk *pipe_clk;
-	struct qcom_qmp *qmp;
-	enum phy_mode mode;
-	unsigned int dp_aux_cfg;
-	struct phy_configure_opts_dp dp_opts;
-	struct qmp_phy_dp_clks *dp_clks;
-};
-
-struct qmp_phy_dp_clks {
-	struct qmp_phy *qphy;
-	struct clk_hw dp_link_hw;
-	struct clk_hw dp_pixel_hw;
-};
-
-/**
- * struct qcom_qmp - structure holding QMP phy block attributes
- *
- * @dev: device
- * @dp_com: iomapped memory space for phy's dp_com control block
- *
- * @clks: array of clocks required by phy
- * @resets: array of resets required by phy
- * @vregs: regulator supplies bulk data
- *
- * @phys: array of per-lane phy descriptors
- * @phy_mutex: mutex lock for PHY common block initialization
- * @init_count: phy common block initialization count
- */
-struct qcom_qmp {
-	struct device *dev;
-	void __iomem *dp_com;
-
 	struct clk_bulk_data *clks;
 	struct reset_control_bulk_data *resets;
 	struct regulator_bulk_data *vregs;
 
-	struct qmp_phy **phys;
-	struct qmp_phy *usb_phy;
-
 	struct mutex phy_mutex;
 	int init_count;
+
+	struct phy *usb_phy;
+	enum phy_mode mode;
+
+	struct phy *dp_phy;
+	unsigned int dp_aux_cfg;
+	struct phy_configure_opts_dp dp_opts;
+	struct qmp_phy_dp_clks *dp_clks;
 };
 
-static void qcom_qmp_v3_phy_dp_aux_init(struct qmp_phy *qphy);
-static void qcom_qmp_v3_phy_configure_dp_tx(struct qmp_phy *qphy);
-static int qcom_qmp_v3_phy_configure_dp_phy(struct qmp_phy *qphy);
-static int qcom_qmp_v3_dp_phy_calibrate(struct qmp_phy *qphy);
+static void qcom_qmp_v3_phy_dp_aux_init(struct qmp_combo *qmp);
+static void qcom_qmp_v3_phy_configure_dp_tx(struct qmp_combo *qmp);
+static int qcom_qmp_v3_phy_configure_dp_phy(struct qmp_combo *qmp);
+static int qcom_qmp_v3_dp_phy_calibrate(struct qmp_combo *qmp);
 
-static void qcom_qmp_v4_phy_dp_aux_init(struct qmp_phy *qphy);
-static void qcom_qmp_v4_phy_configure_dp_tx(struct qmp_phy *qphy);
-static int qcom_qmp_v4_phy_configure_dp_phy(struct qmp_phy *qphy);
-static int qcom_qmp_v4_dp_phy_calibrate(struct qmp_phy *qphy);
+static void qcom_qmp_v4_phy_dp_aux_init(struct qmp_combo *qmp);
+static void qcom_qmp_v4_phy_configure_dp_tx(struct qmp_combo *qmp);
+static int qcom_qmp_v4_phy_configure_dp_phy(struct qmp_combo *qmp);
+static int qcom_qmp_v4_dp_phy_calibrate(struct qmp_combo *qmp);
 
-static int qcom_qmp_v5_phy_configure_dp_phy(struct qmp_phy *qphy);
+static int qcom_qmp_v5_phy_configure_dp_phy(struct qmp_combo *qmp);
 
 static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
 {
@@ -1265,11 +1229,11 @@ static void qmp_combo_configure(void __iomem *base,
 	qmp_combo_configure_lane(base, tbl, num, 0xff);
 }
 
-static int qmp_combo_dp_serdes_init(struct qmp_phy *qphy)
+static int qmp_combo_dp_serdes_init(struct qmp_combo *qmp)
 {
-	const struct qmp_phy_cfg *cfg = qphy->cfg;
-	void __iomem *serdes = qphy->dp_serdes;
-	const struct phy_configure_opts_dp *dp_opts = &qphy->dp_opts;
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	void __iomem *serdes = qmp->dp_serdes;
+	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
 
 	qmp_combo_configure(serdes, cfg->dp_serdes_tbl, cfg->dp_serdes_tbl_num);
 
@@ -1298,54 +1262,54 @@ static int qmp_combo_dp_serdes_init(struct qmp_phy *qphy)
 	return 0;
 }
 
-static void qcom_qmp_v3_phy_dp_aux_init(struct qmp_phy *qphy)
+static void qcom_qmp_v3_phy_dp_aux_init(struct qmp_combo *qmp)
 {
 	writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
 	       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
-	       qphy->dp_pcs + QSERDES_DP_PHY_PD_CTL);
+	       qmp->dp_pcs + QSERDES_DP_PHY_PD_CTL);
 
 	/* Turn on BIAS current for PHY/PLL */
 	writel(QSERDES_V3_COM_BIAS_EN | QSERDES_V3_COM_BIAS_EN_MUX |
 	       QSERDES_V3_COM_CLKBUF_L_EN | QSERDES_V3_COM_EN_SYSCLK_TX_SEL,
-	       qphy->dp_serdes + QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN);
+	       qmp->dp_serdes + QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN);
 
-	writel(DP_PHY_PD_CTL_PSR_PWRDN, qphy->dp_pcs + QSERDES_DP_PHY_PD_CTL);
+	writel(DP_PHY_PD_CTL_PSR_PWRDN, qmp->dp_pcs + QSERDES_DP_PHY_PD_CTL);
 
 	writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
 	       DP_PHY_PD_CTL_LANE_0_1_PWRDN |
 	       DP_PHY_PD_CTL_LANE_2_3_PWRDN | DP_PHY_PD_CTL_PLL_PWRDN |
 	       DP_PHY_PD_CTL_DP_CLAMP_EN,
-	       qphy->dp_pcs + QSERDES_DP_PHY_PD_CTL);
+	       qmp->dp_pcs + QSERDES_DP_PHY_PD_CTL);
 
 	writel(QSERDES_V3_COM_BIAS_EN |
 	       QSERDES_V3_COM_BIAS_EN_MUX | QSERDES_V3_COM_CLKBUF_R_EN |
 	       QSERDES_V3_COM_CLKBUF_L_EN | QSERDES_V3_COM_EN_SYSCLK_TX_SEL |
 	       QSERDES_V3_COM_CLKBUF_RX_DRIVE_L,
-	       qphy->dp_serdes + QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN);
-
-	writel(0x00, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG0);
-	writel(0x13, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG1);
-	writel(0x24, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG2);
-	writel(0x00, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG3);
-	writel(0x0a, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG4);
-	writel(0x26, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG5);
-	writel(0x0a, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG6);
-	writel(0x03, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG7);
-	writel(0xbb, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG8);
-	writel(0x03, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG9);
-	qphy->dp_aux_cfg = 0;
+	       qmp->dp_serdes + QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN);
+
+	writel(0x00, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG0);
+	writel(0x13, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG1);
+	writel(0x24, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG2);
+	writel(0x00, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG3);
+	writel(0x0a, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG4);
+	writel(0x26, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG5);
+	writel(0x0a, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG6);
+	writel(0x03, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG7);
+	writel(0xbb, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG8);
+	writel(0x03, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG9);
+	qmp->dp_aux_cfg = 0;
 
 	writel(PHY_AUX_STOP_ERR_MASK | PHY_AUX_DEC_ERR_MASK |
 	       PHY_AUX_SYNC_ERR_MASK | PHY_AUX_ALIGN_ERR_MASK |
 	       PHY_AUX_REQ_ERR_MASK,
-	       qphy->dp_pcs + QSERDES_V3_DP_PHY_AUX_INTERRUPT_MASK);
+	       qmp->dp_pcs + QSERDES_V3_DP_PHY_AUX_INTERRUPT_MASK);
 }
 
-static int qmp_combo_configure_dp_swing(struct qmp_phy *qphy,
+static int qmp_combo_configure_dp_swing(struct qmp_combo *qmp,
 		unsigned int drv_lvl_reg, unsigned int emp_post_reg)
 {
-	const struct phy_configure_opts_dp *dp_opts = &qphy->dp_opts;
-	const struct qmp_phy_cfg *cfg = qphy->cfg;
+	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	unsigned int v_level = 0, p_level = 0;
 	u8 voltage_swing_cfg, pre_emphasis_cfg;
 	int i;
@@ -1371,20 +1335,20 @@ static int qmp_combo_configure_dp_swing(struct qmp_phy *qphy,
 	voltage_swing_cfg |= DP_PHY_TXn_TX_DRV_LVL_MUX_EN;
 	pre_emphasis_cfg |= DP_PHY_TXn_TX_EMP_POST1_LVL_MUX_EN;
 
-	writel(voltage_swing_cfg, qphy->dp_tx + drv_lvl_reg);
-	writel(pre_emphasis_cfg, qphy->dp_tx + emp_post_reg);
-	writel(voltage_swing_cfg, qphy->dp_tx2 + drv_lvl_reg);
-	writel(pre_emphasis_cfg, qphy->dp_tx2 + emp_post_reg);
+	writel(voltage_swing_cfg, qmp->dp_tx + drv_lvl_reg);
+	writel(pre_emphasis_cfg, qmp->dp_tx + emp_post_reg);
+	writel(voltage_swing_cfg, qmp->dp_tx2 + drv_lvl_reg);
+	writel(pre_emphasis_cfg, qmp->dp_tx2 + emp_post_reg);
 
 	return 0;
 }
 
-static void qcom_qmp_v3_phy_configure_dp_tx(struct qmp_phy *qphy)
+static void qcom_qmp_v3_phy_configure_dp_tx(struct qmp_combo *qmp)
 {
-	const struct phy_configure_opts_dp *dp_opts = &qphy->dp_opts;
+	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
 	u32 bias_en, drvr_en;
 
-	if (qmp_combo_configure_dp_swing(qphy, QSERDES_V3_TX_TX_DRV_LVL,
+	if (qmp_combo_configure_dp_swing(qmp, QSERDES_V3_TX_TX_DRV_LVL,
 				QSERDES_V3_TX_TX_EMP_POST1_LVL) < 0)
 		return;
 
@@ -1396,13 +1360,13 @@ static void qcom_qmp_v3_phy_configure_dp_tx(struct qmp_phy *qphy)
 		drvr_en = 0x10;
 	}
 
-	writel(drvr_en, qphy->dp_tx + QSERDES_V3_TX_HIGHZ_DRVR_EN);
-	writel(bias_en, qphy->dp_tx + QSERDES_V3_TX_TRANSCEIVER_BIAS_EN);
-	writel(drvr_en, qphy->dp_tx2 + QSERDES_V3_TX_HIGHZ_DRVR_EN);
-	writel(bias_en, qphy->dp_tx2 + QSERDES_V3_TX_TRANSCEIVER_BIAS_EN);
+	writel(drvr_en, qmp->dp_tx + QSERDES_V3_TX_HIGHZ_DRVR_EN);
+	writel(bias_en, qmp->dp_tx + QSERDES_V3_TX_TRANSCEIVER_BIAS_EN);
+	writel(drvr_en, qmp->dp_tx2 + QSERDES_V3_TX_HIGHZ_DRVR_EN);
+	writel(bias_en, qmp->dp_tx2 + QSERDES_V3_TX_TRANSCEIVER_BIAS_EN);
 }
 
-static bool qmp_combo_configure_dp_mode(struct qmp_phy *qphy)
+static bool qmp_combo_configure_dp_mode(struct qmp_combo *qmp)
 {
 	u32 val;
 	bool reverse = false;
@@ -1422,27 +1386,27 @@ static bool qmp_combo_configure_dp_mode(struct qmp_phy *qphy)
 	 * if (lane_cnt == 4 || orientation == ORIENTATION_CC1)
 	 *	val |= DP_PHY_PD_CTL_LANE_2_3_PWRDN;
 	 * if (orientation == ORIENTATION_CC2)
-	 *	writel(0x4c, qphy->dp_pcs + QSERDES_V3_DP_PHY_MODE);
+	 *	writel(0x4c, qmp->dp_pcs + QSERDES_V3_DP_PHY_MODE);
 	 */
 	val |= DP_PHY_PD_CTL_LANE_2_3_PWRDN;
-	writel(val, qphy->dp_pcs + QSERDES_DP_PHY_PD_CTL);
+	writel(val, qmp->dp_pcs + QSERDES_DP_PHY_PD_CTL);
 
-	writel(0x5c, qphy->dp_pcs + QSERDES_DP_PHY_MODE);
+	writel(0x5c, qmp->dp_pcs + QSERDES_DP_PHY_MODE);
 
 	return reverse;
 }
 
-static int qcom_qmp_v3_phy_configure_dp_phy(struct qmp_phy *qphy)
+static int qcom_qmp_v3_phy_configure_dp_phy(struct qmp_combo *qmp)
 {
-	const struct qmp_phy_dp_clks *dp_clks = qphy->dp_clks;
-	const struct phy_configure_opts_dp *dp_opts = &qphy->dp_opts;
+	const struct qmp_phy_dp_clks *dp_clks = qmp->dp_clks;
+	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
 	u32 phy_vco_div, status;
 	unsigned long pixel_freq;
 
-	qmp_combo_configure_dp_mode(qphy);
+	qmp_combo_configure_dp_mode(qmp);
 
-	writel(0x05, qphy->dp_pcs + QSERDES_V3_DP_PHY_TX0_TX1_LANE_CTL);
-	writel(0x05, qphy->dp_pcs + QSERDES_V3_DP_PHY_TX2_TX3_LANE_CTL);
+	writel(0x05, qmp->dp_pcs + QSERDES_V3_DP_PHY_TX0_TX1_LANE_CTL);
+	writel(0x05, qmp->dp_pcs + QSERDES_V3_DP_PHY_TX2_TX3_LANE_CTL);
 
 	switch (dp_opts->link_rate) {
 	case 1620:
@@ -1465,40 +1429,40 @@ static int qcom_qmp_v3_phy_configure_dp_phy(struct qmp_phy *qphy)
 		/* Other link rates aren't supported */
 		return -EINVAL;
 	}
-	writel(phy_vco_div, qphy->dp_pcs + QSERDES_V3_DP_PHY_VCO_DIV);
+	writel(phy_vco_div, qmp->dp_pcs + QSERDES_V3_DP_PHY_VCO_DIV);
 
 	clk_set_rate(dp_clks->dp_link_hw.clk, dp_opts->link_rate * 100000);
 	clk_set_rate(dp_clks->dp_pixel_hw.clk, pixel_freq);
 
-	writel(0x04, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG2);
-	writel(0x01, qphy->dp_pcs + QSERDES_DP_PHY_CFG);
-	writel(0x05, qphy->dp_pcs + QSERDES_DP_PHY_CFG);
-	writel(0x01, qphy->dp_pcs + QSERDES_DP_PHY_CFG);
-	writel(0x09, qphy->dp_pcs + QSERDES_DP_PHY_CFG);
+	writel(0x04, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG2);
+	writel(0x01, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
+	writel(0x05, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
+	writel(0x01, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
+	writel(0x09, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
 
-	writel(0x20, qphy->dp_serdes + QSERDES_V3_COM_RESETSM_CNTRL);
+	writel(0x20, qmp->dp_serdes + QSERDES_V3_COM_RESETSM_CNTRL);
 
-	if (readl_poll_timeout(qphy->dp_serdes + QSERDES_V3_COM_C_READY_STATUS,
+	if (readl_poll_timeout(qmp->dp_serdes + QSERDES_V3_COM_C_READY_STATUS,
 			status,
 			((status & BIT(0)) > 0),
 			500,
 			10000))
 		return -ETIMEDOUT;
 
-	writel(0x19, qphy->dp_pcs + QSERDES_DP_PHY_CFG);
+	writel(0x19, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
 
-	if (readl_poll_timeout(qphy->dp_pcs + QSERDES_V3_DP_PHY_STATUS,
+	if (readl_poll_timeout(qmp->dp_pcs + QSERDES_V3_DP_PHY_STATUS,
 			status,
 			((status & BIT(1)) > 0),
 			500,
 			10000))
 		return -ETIMEDOUT;
 
-	writel(0x18, qphy->dp_pcs + QSERDES_DP_PHY_CFG);
+	writel(0x18, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
 	udelay(2000);
-	writel(0x19, qphy->dp_pcs + QSERDES_DP_PHY_CFG);
+	writel(0x19, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
 
-	return readl_poll_timeout(qphy->dp_pcs + QSERDES_V3_DP_PHY_STATUS,
+	return readl_poll_timeout(qmp->dp_pcs + QSERDES_V3_DP_PHY_STATUS,
 			status,
 			((status & BIT(1)) > 0),
 			500,
@@ -1509,76 +1473,76 @@ static int qcom_qmp_v3_phy_configure_dp_phy(struct qmp_phy *qphy)
  * We need to calibrate the aux setting here as many times
  * as the caller tries
  */
-static int qcom_qmp_v3_dp_phy_calibrate(struct qmp_phy *qphy)
+static int qcom_qmp_v3_dp_phy_calibrate(struct qmp_combo *qmp)
 {
 	static const u8 cfg1_settings[] = { 0x13, 0x23, 0x1d };
 	u8 val;
 
-	qphy->dp_aux_cfg++;
-	qphy->dp_aux_cfg %= ARRAY_SIZE(cfg1_settings);
-	val = cfg1_settings[qphy->dp_aux_cfg];
+	qmp->dp_aux_cfg++;
+	qmp->dp_aux_cfg %= ARRAY_SIZE(cfg1_settings);
+	val = cfg1_settings[qmp->dp_aux_cfg];
 
-	writel(val, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG1);
+	writel(val, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG1);
 
 	return 0;
 }
 
-static void qcom_qmp_v4_phy_dp_aux_init(struct qmp_phy *qphy)
+static void qcom_qmp_v4_phy_dp_aux_init(struct qmp_combo *qmp)
 {
 	writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_PSR_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
 	       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
-	       qphy->dp_pcs + QSERDES_DP_PHY_PD_CTL);
+	       qmp->dp_pcs + QSERDES_DP_PHY_PD_CTL);
 
 	/* Turn on BIAS current for PHY/PLL */
-	writel(0x17, qphy->dp_serdes + QSERDES_V4_COM_BIAS_EN_CLKBUFLR_EN);
-
-	writel(0x00, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG0);
-	writel(0x13, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG1);
-	writel(0xa4, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG2);
-	writel(0x00, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG3);
-	writel(0x0a, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG4);
-	writel(0x26, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG5);
-	writel(0x0a, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG6);
-	writel(0x03, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG7);
-	writel(0xb7, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG8);
-	writel(0x03, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG9);
-	qphy->dp_aux_cfg = 0;
+	writel(0x17, qmp->dp_serdes + QSERDES_V4_COM_BIAS_EN_CLKBUFLR_EN);
+
+	writel(0x00, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG0);
+	writel(0x13, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG1);
+	writel(0xa4, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG2);
+	writel(0x00, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG3);
+	writel(0x0a, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG4);
+	writel(0x26, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG5);
+	writel(0x0a, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG6);
+	writel(0x03, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG7);
+	writel(0xb7, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG8);
+	writel(0x03, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG9);
+	qmp->dp_aux_cfg = 0;
 
 	writel(PHY_AUX_STOP_ERR_MASK | PHY_AUX_DEC_ERR_MASK |
 	       PHY_AUX_SYNC_ERR_MASK | PHY_AUX_ALIGN_ERR_MASK |
 	       PHY_AUX_REQ_ERR_MASK,
-	       qphy->dp_pcs + QSERDES_V4_DP_PHY_AUX_INTERRUPT_MASK);
+	       qmp->dp_pcs + QSERDES_V4_DP_PHY_AUX_INTERRUPT_MASK);
 }
 
-static void qcom_qmp_v4_phy_configure_dp_tx(struct qmp_phy *qphy)
+static void qcom_qmp_v4_phy_configure_dp_tx(struct qmp_combo *qmp)
 {
 	/* Program default values before writing proper values */
-	writel(0x27, qphy->dp_tx + QSERDES_V4_TX_TX_DRV_LVL);
-	writel(0x27, qphy->dp_tx2 + QSERDES_V4_TX_TX_DRV_LVL);
+	writel(0x27, qmp->dp_tx + QSERDES_V4_TX_TX_DRV_LVL);
+	writel(0x27, qmp->dp_tx2 + QSERDES_V4_TX_TX_DRV_LVL);
 
-	writel(0x20, qphy->dp_tx + QSERDES_V4_TX_TX_EMP_POST1_LVL);
-	writel(0x20, qphy->dp_tx2 + QSERDES_V4_TX_TX_EMP_POST1_LVL);
+	writel(0x20, qmp->dp_tx + QSERDES_V4_TX_TX_EMP_POST1_LVL);
+	writel(0x20, qmp->dp_tx2 + QSERDES_V4_TX_TX_EMP_POST1_LVL);
 
-	qmp_combo_configure_dp_swing(qphy, QSERDES_V4_TX_TX_DRV_LVL,
+	qmp_combo_configure_dp_swing(qmp, QSERDES_V4_TX_TX_DRV_LVL,
 			QSERDES_V4_TX_TX_EMP_POST1_LVL);
 }
 
-static int qcom_qmp_v45_phy_configure_dp_phy(struct qmp_phy *qphy)
+static int qcom_qmp_v45_phy_configure_dp_phy(struct qmp_combo *qmp)
 {
-	const struct qmp_phy_dp_clks *dp_clks = qphy->dp_clks;
-	const struct phy_configure_opts_dp *dp_opts = &qphy->dp_opts;
+	const struct qmp_phy_dp_clks *dp_clks = qmp->dp_clks;
+	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
 	u32 phy_vco_div, status;
 	unsigned long pixel_freq;
 
-	writel(0x0f, qphy->dp_pcs + QSERDES_V4_DP_PHY_CFG_1);
+	writel(0x0f, qmp->dp_pcs + QSERDES_V4_DP_PHY_CFG_1);
 
-	qmp_combo_configure_dp_mode(qphy);
+	qmp_combo_configure_dp_mode(qmp);
 
-	writel(0x13, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG1);
-	writel(0xa4, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG2);
+	writel(0x13, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG1);
+	writel(0xa4, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG2);
 
-	writel(0x05, qphy->dp_pcs + QSERDES_V4_DP_PHY_TX0_TX1_LANE_CTL);
-	writel(0x05, qphy->dp_pcs + QSERDES_V4_DP_PHY_TX2_TX3_LANE_CTL);
+	writel(0x05, qmp->dp_pcs + QSERDES_V4_DP_PHY_TX0_TX1_LANE_CTL);
+	writel(0x05, qmp->dp_pcs + QSERDES_V4_DP_PHY_TX2_TX3_LANE_CTL);
 
 	switch (dp_opts->link_rate) {
 	case 1620:
@@ -1601,49 +1565,49 @@ static int qcom_qmp_v45_phy_configure_dp_phy(struct qmp_phy *qphy)
 		/* Other link rates aren't supported */
 		return -EINVAL;
 	}
-	writel(phy_vco_div, qphy->dp_pcs + QSERDES_V4_DP_PHY_VCO_DIV);
+	writel(phy_vco_div, qmp->dp_pcs + QSERDES_V4_DP_PHY_VCO_DIV);
 
 	clk_set_rate(dp_clks->dp_link_hw.clk, dp_opts->link_rate * 100000);
 	clk_set_rate(dp_clks->dp_pixel_hw.clk, pixel_freq);
 
-	writel(0x01, qphy->dp_pcs + QSERDES_DP_PHY_CFG);
-	writel(0x05, qphy->dp_pcs + QSERDES_DP_PHY_CFG);
-	writel(0x01, qphy->dp_pcs + QSERDES_DP_PHY_CFG);
-	writel(0x09, qphy->dp_pcs + QSERDES_DP_PHY_CFG);
+	writel(0x01, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
+	writel(0x05, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
+	writel(0x01, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
+	writel(0x09, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
 
-	writel(0x20, qphy->dp_serdes + QSERDES_V4_COM_RESETSM_CNTRL);
+	writel(0x20, qmp->dp_serdes + QSERDES_V4_COM_RESETSM_CNTRL);
 
-	if (readl_poll_timeout(qphy->dp_serdes + QSERDES_V4_COM_C_READY_STATUS,
+	if (readl_poll_timeout(qmp->dp_serdes + QSERDES_V4_COM_C_READY_STATUS,
 			status,
 			((status & BIT(0)) > 0),
 			500,
 			10000))
 		return -ETIMEDOUT;
 
-	if (readl_poll_timeout(qphy->dp_serdes + QSERDES_V4_COM_CMN_STATUS,
+	if (readl_poll_timeout(qmp->dp_serdes + QSERDES_V4_COM_CMN_STATUS,
 			status,
 			((status & BIT(0)) > 0),
 			500,
 			10000))
 		return -ETIMEDOUT;
 
-	if (readl_poll_timeout(qphy->dp_serdes + QSERDES_V4_COM_CMN_STATUS,
+	if (readl_poll_timeout(qmp->dp_serdes + QSERDES_V4_COM_CMN_STATUS,
 			status,
 			((status & BIT(1)) > 0),
 			500,
 			10000))
 		return -ETIMEDOUT;
 
-	writel(0x19, qphy->dp_pcs + QSERDES_DP_PHY_CFG);
+	writel(0x19, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
 
-	if (readl_poll_timeout(qphy->dp_pcs + QSERDES_V4_DP_PHY_STATUS,
+	if (readl_poll_timeout(qmp->dp_pcs + QSERDES_V4_DP_PHY_STATUS,
 			status,
 			((status & BIT(0)) > 0),
 			500,
 			10000))
 		return -ETIMEDOUT;
 
-	if (readl_poll_timeout(qphy->dp_pcs + QSERDES_V4_DP_PHY_STATUS,
+	if (readl_poll_timeout(qmp->dp_pcs + QSERDES_V4_DP_PHY_STATUS,
 			status,
 			((status & BIT(1)) > 0),
 			500,
@@ -1653,15 +1617,15 @@ static int qcom_qmp_v45_phy_configure_dp_phy(struct qmp_phy *qphy)
 	return 0;
 }
 
-static int qcom_qmp_v4_phy_configure_dp_phy(struct qmp_phy *qphy)
+static int qcom_qmp_v4_phy_configure_dp_phy(struct qmp_combo *qmp)
 {
-	const struct phy_configure_opts_dp *dp_opts = &qphy->dp_opts;
+	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
 	u32 bias0_en, drvr0_en, bias1_en, drvr1_en;
 	bool reverse = false;
 	u32 status;
 	int ret;
 
-	ret = qcom_qmp_v45_phy_configure_dp_phy(qphy);
+	ret = qcom_qmp_v45_phy_configure_dp_phy(qmp);
 	if (ret < 0)
 		return ret;
 
@@ -1687,43 +1651,43 @@ static int qcom_qmp_v4_phy_configure_dp_phy(struct qmp_phy *qphy)
 		drvr1_en = 0x10;
 	}
 
-	writel(drvr0_en, qphy->dp_tx + QSERDES_V4_TX_HIGHZ_DRVR_EN);
-	writel(bias0_en, qphy->dp_tx + QSERDES_V4_TX_TRANSCEIVER_BIAS_EN);
-	writel(drvr1_en, qphy->dp_tx2 + QSERDES_V4_TX_HIGHZ_DRVR_EN);
-	writel(bias1_en, qphy->dp_tx2 + QSERDES_V4_TX_TRANSCEIVER_BIAS_EN);
+	writel(drvr0_en, qmp->dp_tx + QSERDES_V4_TX_HIGHZ_DRVR_EN);
+	writel(bias0_en, qmp->dp_tx + QSERDES_V4_TX_TRANSCEIVER_BIAS_EN);
+	writel(drvr1_en, qmp->dp_tx2 + QSERDES_V4_TX_HIGHZ_DRVR_EN);
+	writel(bias1_en, qmp->dp_tx2 + QSERDES_V4_TX_TRANSCEIVER_BIAS_EN);
 
-	writel(0x18, qphy->dp_pcs + QSERDES_DP_PHY_CFG);
+	writel(0x18, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
 	udelay(2000);
-	writel(0x19, qphy->dp_pcs + QSERDES_DP_PHY_CFG);
+	writel(0x19, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
 
-	if (readl_poll_timeout(qphy->dp_pcs + QSERDES_V4_DP_PHY_STATUS,
+	if (readl_poll_timeout(qmp->dp_pcs + QSERDES_V4_DP_PHY_STATUS,
 			status,
 			((status & BIT(1)) > 0),
 			500,
 			10000))
 		return -ETIMEDOUT;
 
-	writel(0x0a, qphy->dp_tx + QSERDES_V4_TX_TX_POL_INV);
-	writel(0x0a, qphy->dp_tx2 + QSERDES_V4_TX_TX_POL_INV);
+	writel(0x0a, qmp->dp_tx + QSERDES_V4_TX_TX_POL_INV);
+	writel(0x0a, qmp->dp_tx2 + QSERDES_V4_TX_TX_POL_INV);
 
-	writel(0x27, qphy->dp_tx + QSERDES_V4_TX_TX_DRV_LVL);
-	writel(0x27, qphy->dp_tx2 + QSERDES_V4_TX_TX_DRV_LVL);
+	writel(0x27, qmp->dp_tx + QSERDES_V4_TX_TX_DRV_LVL);
+	writel(0x27, qmp->dp_tx2 + QSERDES_V4_TX_TX_DRV_LVL);
 
-	writel(0x20, qphy->dp_tx + QSERDES_V4_TX_TX_EMP_POST1_LVL);
-	writel(0x20, qphy->dp_tx2 + QSERDES_V4_TX_TX_EMP_POST1_LVL);
+	writel(0x20, qmp->dp_tx + QSERDES_V4_TX_TX_EMP_POST1_LVL);
+	writel(0x20, qmp->dp_tx2 + QSERDES_V4_TX_TX_EMP_POST1_LVL);
 
 	return 0;
 }
 
-static int qcom_qmp_v5_phy_configure_dp_phy(struct qmp_phy *qphy)
+static int qcom_qmp_v5_phy_configure_dp_phy(struct qmp_combo *qmp)
 {
-	const struct phy_configure_opts_dp *dp_opts = &qphy->dp_opts;
+	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
 	u32 bias0_en, drvr0_en, bias1_en, drvr1_en;
 	bool reverse = false;
 	u32 status;
 	int ret;
 
-	ret = qcom_qmp_v45_phy_configure_dp_phy(qphy);
+	ret = qcom_qmp_v45_phy_configure_dp_phy(qmp);
 	if (ret < 0)
 		return ret;
 
@@ -1744,30 +1708,30 @@ static int qcom_qmp_v5_phy_configure_dp_phy(struct qmp_phy *qphy)
 		drvr1_en = 0x10;
 	}
 
-	writel(drvr0_en, qphy->dp_tx + QSERDES_V5_5NM_TX_HIGHZ_DRVR_EN);
-	writel(bias0_en, qphy->dp_tx + QSERDES_V5_5NM_TX_TRANSCEIVER_BIAS_EN);
-	writel(drvr1_en, qphy->dp_tx2 + QSERDES_V5_5NM_TX_HIGHZ_DRVR_EN);
-	writel(bias1_en, qphy->dp_tx2 + QSERDES_V5_5NM_TX_TRANSCEIVER_BIAS_EN);
+	writel(drvr0_en, qmp->dp_tx + QSERDES_V5_5NM_TX_HIGHZ_DRVR_EN);
+	writel(bias0_en, qmp->dp_tx + QSERDES_V5_5NM_TX_TRANSCEIVER_BIAS_EN);
+	writel(drvr1_en, qmp->dp_tx2 + QSERDES_V5_5NM_TX_HIGHZ_DRVR_EN);
+	writel(bias1_en, qmp->dp_tx2 + QSERDES_V5_5NM_TX_TRANSCEIVER_BIAS_EN);
 
-	writel(0x18, qphy->dp_pcs + QSERDES_DP_PHY_CFG);
+	writel(0x18, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
 	udelay(2000);
-	writel(0x19, qphy->dp_pcs + QSERDES_DP_PHY_CFG);
+	writel(0x19, qmp->dp_pcs + QSERDES_DP_PHY_CFG);
 
-	if (readl_poll_timeout(qphy->dp_pcs + QSERDES_V4_DP_PHY_STATUS,
+	if (readl_poll_timeout(qmp->dp_pcs + QSERDES_V4_DP_PHY_STATUS,
 			status,
 			((status & BIT(1)) > 0),
 			500,
 			10000))
 		return -ETIMEDOUT;
 
-	writel(0x0a, qphy->dp_tx + QSERDES_V5_5NM_TX_TX_POL_INV);
-	writel(0x0a, qphy->dp_tx2 + QSERDES_V5_5NM_TX_TX_POL_INV);
+	writel(0x0a, qmp->dp_tx + QSERDES_V5_5NM_TX_TX_POL_INV);
+	writel(0x0a, qmp->dp_tx2 + QSERDES_V5_5NM_TX_TX_POL_INV);
 
-	writel(0x27, qphy->dp_tx + QSERDES_V5_5NM_TX_TX_DRV_LVL);
-	writel(0x27, qphy->dp_tx2 + QSERDES_V5_5NM_TX_TX_DRV_LVL);
+	writel(0x27, qmp->dp_tx + QSERDES_V5_5NM_TX_TX_DRV_LVL);
+	writel(0x27, qmp->dp_tx2 + QSERDES_V5_5NM_TX_TX_DRV_LVL);
 
-	writel(0x20, qphy->dp_tx + QSERDES_V5_5NM_TX_TX_EMP_POST1_LVL);
-	writel(0x20, qphy->dp_tx2 + QSERDES_V5_5NM_TX_TX_EMP_POST1_LVL);
+	writel(0x20, qmp->dp_tx + QSERDES_V5_5NM_TX_TX_EMP_POST1_LVL);
+	writel(0x20, qmp->dp_tx2 + QSERDES_V5_5NM_TX_TX_EMP_POST1_LVL);
 
 	return 0;
 }
@@ -1776,16 +1740,16 @@ static int qcom_qmp_v5_phy_configure_dp_phy(struct qmp_phy *qphy)
  * We need to calibrate the aux setting here as many times
  * as the caller tries
  */
-static int qcom_qmp_v4_dp_phy_calibrate(struct qmp_phy *qphy)
+static int qcom_qmp_v4_dp_phy_calibrate(struct qmp_combo *qmp)
 {
 	static const u8 cfg1_settings[] = { 0x20, 0x13, 0x23, 0x1d };
 	u8 val;
 
-	qphy->dp_aux_cfg++;
-	qphy->dp_aux_cfg %= ARRAY_SIZE(cfg1_settings);
-	val = cfg1_settings[qphy->dp_aux_cfg];
+	qmp->dp_aux_cfg++;
+	qmp->dp_aux_cfg %= ARRAY_SIZE(cfg1_settings);
+	val = cfg1_settings[qmp->dp_aux_cfg];
 
-	writel(val, qphy->dp_pcs + QSERDES_DP_PHY_AUX_CFG1);
+	writel(val, qmp->dp_pcs + QSERDES_DP_PHY_AUX_CFG1);
 
 	return 0;
 }
@@ -1793,13 +1757,13 @@ static int qcom_qmp_v4_dp_phy_calibrate(struct qmp_phy *qphy)
 static int qmp_combo_dp_configure(struct phy *phy, union phy_configure_opts *opts)
 {
 	const struct phy_configure_opts_dp *dp_opts = &opts->dp;
-	struct qmp_phy *qphy = phy_get_drvdata(phy);
-	const struct qmp_phy_cfg *cfg = qphy->cfg;
+	struct qmp_combo *qmp = phy_get_drvdata(phy);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
 
-	memcpy(&qphy->dp_opts, dp_opts, sizeof(*dp_opts));
-	if (qphy->dp_opts.set_voltages) {
-		cfg->configure_dp_tx(qphy);
-		qphy->dp_opts.set_voltages = 0;
+	memcpy(&qmp->dp_opts, dp_opts, sizeof(*dp_opts));
+	if (qmp->dp_opts.set_voltages) {
+		cfg->configure_dp_tx(qmp);
+		qmp->dp_opts.set_voltages = 0;
 	}
 
 	return 0;
@@ -1807,20 +1771,18 @@ static int qmp_combo_dp_configure(struct phy *phy, union phy_configure_opts *opt
 
 static int qmp_combo_dp_calibrate(struct phy *phy)
 {
-	struct qmp_phy *qphy = phy_get_drvdata(phy);
-	const struct qmp_phy_cfg *cfg = qphy->cfg;
+	struct qmp_combo *qmp = phy_get_drvdata(phy);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
 
 	if (cfg->calibrate_dp_phy)
-		return cfg->calibrate_dp_phy(qphy);
+		return cfg->calibrate_dp_phy(qmp);
 
 	return 0;
 }
 
-static int qmp_combo_com_init(struct qmp_phy *qphy)
+static int qmp_combo_com_init(struct qmp_combo *qmp)
 {
-	struct qcom_qmp *qmp = qphy->qmp;
-	struct qmp_phy *usb_phy = qmp->usb_phy;
-	const struct qmp_phy_cfg *cfg = usb_phy->cfg;
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	void __iomem *dp_com = qmp->dp_com;
 	int ret;
 
@@ -1872,7 +1834,7 @@ static int qmp_combo_com_init(struct qmp_phy *qphy)
 	qphy_clrbits(dp_com, QPHY_V3_DP_COM_SWI_CTRL, 0x03);
 	qphy_clrbits(dp_com, QPHY_V3_DP_COM_SW_RESET, SW_RESET);
 
-	qphy_setbits(usb_phy->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
+	qphy_setbits(qmp->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
 			SW_PWRDN);
 
 	mutex_unlock(&qmp->phy_mutex);
@@ -1889,11 +1851,9 @@ static int qmp_combo_com_init(struct qmp_phy *qphy)
 	return ret;
 }
 
-static int qmp_combo_com_exit(struct qmp_phy *qphy)
+static int qmp_combo_com_exit(struct qmp_combo *qmp)
 {
-	struct qcom_qmp *qmp = qphy->qmp;
-	struct qmp_phy *usb_phy = qmp->usb_phy;
-	const struct qmp_phy_cfg *cfg = usb_phy->cfg;
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
 
 	mutex_lock(&qmp->phy_mutex);
 	if (--qmp->init_count) {
@@ -1914,76 +1874,75 @@ static int qmp_combo_com_exit(struct qmp_phy *qphy)
 
 static int qmp_combo_dp_init(struct phy *phy)
 {
-	struct qmp_phy *qphy = phy_get_drvdata(phy);
-	const struct qmp_phy_cfg *cfg = qphy->cfg;
+	struct qmp_combo *qmp = phy_get_drvdata(phy);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	int ret;
 
-	ret = qmp_combo_com_init(qphy);
+	ret = qmp_combo_com_init(qmp);
 	if (ret)
 		return ret;
 
-	cfg->dp_aux_init(qphy);
+	cfg->dp_aux_init(qmp);
 
 	return 0;
 }
 
 static int qmp_combo_dp_exit(struct phy *phy)
 {
-	struct qmp_phy *qphy = phy_get_drvdata(phy);
+	struct qmp_combo *qmp = phy_get_drvdata(phy);
 
-	qmp_combo_com_exit(qphy);
+	qmp_combo_com_exit(qmp);
 
 	return 0;
 }
 
 static int qmp_combo_dp_power_on(struct phy *phy)
 {
-	struct qmp_phy *qphy = phy_get_drvdata(phy);
-	const struct qmp_phy_cfg *cfg = qphy->cfg;
-	void __iomem *tx = qphy->dp_tx;
+	struct qmp_combo *qmp = phy_get_drvdata(phy);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	void __iomem *tx = qmp->dp_tx;
 
-	qmp_combo_dp_serdes_init(qphy);
+	qmp_combo_dp_serdes_init(qmp);
 
 	qmp_combo_configure_lane(tx, cfg->dp_tx_tbl, cfg->dp_tx_tbl_num, 1);
 
 	if (cfg->lanes >= 2)
-		qmp_combo_configure_lane(qphy->dp_tx2, cfg->dp_tx_tbl, cfg->dp_tx_tbl_num, 2);
+		qmp_combo_configure_lane(qmp->dp_tx2, cfg->dp_tx_tbl, cfg->dp_tx_tbl_num, 2);
 
 	/* Configure special DP tx tunings */
-	cfg->configure_dp_tx(qphy);
+	cfg->configure_dp_tx(qmp);
 
 	/* Configure link rate, swing, etc. */
-	cfg->configure_dp_phy(qphy);
+	cfg->configure_dp_phy(qmp);
 
 	return 0;
 }
 
 static int qmp_combo_dp_power_off(struct phy *phy)
 {
-	struct qmp_phy *qphy = phy_get_drvdata(phy);
+	struct qmp_combo *qmp = phy_get_drvdata(phy);
 
 	/* Assert DP PHY power down */
-	writel(DP_PHY_PD_CTL_PSR_PWRDN, qphy->dp_pcs + QSERDES_DP_PHY_PD_CTL);
+	writel(DP_PHY_PD_CTL_PSR_PWRDN, qmp->dp_pcs + QSERDES_DP_PHY_PD_CTL);
 
 	return 0;
 }
 
 static int qmp_combo_usb_power_on(struct phy *phy)
 {
-	struct qmp_phy *qphy = phy_get_drvdata(phy);
-	struct qcom_qmp *qmp = qphy->qmp;
-	const struct qmp_phy_cfg *cfg = qphy->cfg;
-	void __iomem *serdes = qphy->serdes;
-	void __iomem *tx = qphy->tx;
-	void __iomem *rx = qphy->rx;
-	void __iomem *pcs = qphy->pcs;
+	struct qmp_combo *qmp = phy_get_drvdata(phy);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	void __iomem *serdes = qmp->serdes;
+	void __iomem *tx = qmp->tx;
+	void __iomem *rx = qmp->rx;
+	void __iomem *pcs = qmp->pcs;
 	void __iomem *status;
 	unsigned int val;
 	int ret;
 
 	qmp_combo_configure(serdes, cfg->serdes_tbl, cfg->serdes_tbl_num);
 
-	ret = clk_prepare_enable(qphy->pipe_clk);
+	ret = clk_prepare_enable(qmp->pipe_clk);
 	if (ret) {
 		dev_err(qmp->dev, "pipe_clk enable failed err=%d\n", ret);
 		return ret;
@@ -1993,12 +1952,12 @@ static int qmp_combo_usb_power_on(struct phy *phy)
 	qmp_combo_configure_lane(tx, cfg->tx_tbl, cfg->tx_tbl_num, 1);
 
 	if (cfg->lanes >= 2)
-		qmp_combo_configure_lane(qphy->tx2, cfg->tx_tbl, cfg->tx_tbl_num, 2);
+		qmp_combo_configure_lane(qmp->tx2, cfg->tx_tbl, cfg->tx_tbl_num, 2);
 
 	qmp_combo_configure_lane(rx, cfg->rx_tbl, cfg->rx_tbl_num, 1);
 
 	if (cfg->lanes >= 2)
-		qmp_combo_configure_lane(qphy->rx2, cfg->rx_tbl, cfg->rx_tbl_num, 2);
+		qmp_combo_configure_lane(qmp->rx2, cfg->rx_tbl, cfg->rx_tbl_num, 2);
 
 	qmp_combo_configure(pcs, cfg->pcs_tbl, cfg->pcs_tbl_num);
 
@@ -2022,27 +1981,27 @@ static int qmp_combo_usb_power_on(struct phy *phy)
 	return 0;
 
 err_disable_pipe_clk:
-	clk_disable_unprepare(qphy->pipe_clk);
+	clk_disable_unprepare(qmp->pipe_clk);
 
 	return ret;
 }
 
 static int qmp_combo_usb_power_off(struct phy *phy)
 {
-	struct qmp_phy *qphy = phy_get_drvdata(phy);
-	const struct qmp_phy_cfg *cfg = qphy->cfg;
+	struct qmp_combo *qmp = phy_get_drvdata(phy);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
 
-	clk_disable_unprepare(qphy->pipe_clk);
+	clk_disable_unprepare(qmp->pipe_clk);
 
 	/* PHY reset */
-	qphy_setbits(qphy->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
+	qphy_setbits(qmp->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
 
 	/* stop SerDes and Phy-Coding-Sublayer */
-	qphy_clrbits(qphy->pcs, cfg->regs[QPHY_START_CTRL],
+	qphy_clrbits(qmp->pcs, cfg->regs[QPHY_START_CTRL],
 			SERDES_START | PCS_START);
 
 	/* Put PHY into POWER DOWN state: active low */
-	qphy_clrbits(qphy->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
+	qphy_clrbits(qmp->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
 			SW_PWRDN);
 
 	return 0;
@@ -2050,37 +2009,37 @@ static int qmp_combo_usb_power_off(struct phy *phy)
 
 static int qmp_combo_usb_init(struct phy *phy)
 {
-	struct qmp_phy *qphy = phy_get_drvdata(phy);
+	struct qmp_combo *qmp = phy_get_drvdata(phy);
 	int ret;
 
-	ret = qmp_combo_com_init(qphy);
+	ret = qmp_combo_com_init(qmp);
 	if (ret)
 		return ret;
 
 	ret = qmp_combo_usb_power_on(phy);
 	if (ret)
-		qmp_combo_com_exit(qphy);
+		qmp_combo_com_exit(qmp);
 
 	return ret;
 }
 
 static int qmp_combo_usb_exit(struct phy *phy)
 {
-	struct qmp_phy *qphy = phy_get_drvdata(phy);
+	struct qmp_combo *qmp = phy_get_drvdata(phy);
 	int ret;
 
 	ret = qmp_combo_usb_power_off(phy);
 	if (ret)
 		return ret;
 
-	return qmp_combo_com_exit(qphy);
+	return qmp_combo_com_exit(qmp);
 }
 
 static int qmp_combo_usb_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 {
-	struct qmp_phy *qphy = phy_get_drvdata(phy);
+	struct qmp_combo *qmp = phy_get_drvdata(phy);
 
-	qphy->mode = mode;
+	qmp->mode = mode;
 
 	return 0;
 }
@@ -2102,15 +2061,15 @@ static const struct phy_ops qmp_combo_dp_phy_ops = {
 	.owner		= THIS_MODULE,
 };
 
-static void qmp_combo_enable_autonomous_mode(struct qmp_phy *qphy)
+static void qmp_combo_enable_autonomous_mode(struct qmp_combo *qmp)
 {
-	const struct qmp_phy_cfg *cfg = qphy->cfg;
-	void __iomem *pcs_usb = qphy->pcs_usb ?: qphy->pcs;
-	void __iomem *pcs_misc = qphy->pcs_misc;
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	void __iomem *pcs_usb = qmp->pcs_usb ?: qmp->pcs;
+	void __iomem *pcs_misc = qmp->pcs_misc;
 	u32 intr_mask;
 
-	if (qphy->mode == PHY_MODE_USB_HOST_SS ||
-	    qphy->mode == PHY_MODE_USB_DEVICE_SS)
+	if (qmp->mode == PHY_MODE_USB_HOST_SS ||
+	    qmp->mode == PHY_MODE_USB_DEVICE_SS)
 		intr_mask = ARCVR_DTCT_EN | ALFPS_DTCT_EN;
 	else
 		intr_mask = ARCVR_DTCT_EN | ARCVR_DTCT_EVENT_SEL;
@@ -2131,11 +2090,11 @@ static void qmp_combo_enable_autonomous_mode(struct qmp_phy *qphy)
 		qphy_clrbits(pcs_misc, QPHY_V3_PCS_MISC_CLAMP_ENABLE, CLAMP_EN);
 }
 
-static void qmp_combo_disable_autonomous_mode(struct qmp_phy *qphy)
+static void qmp_combo_disable_autonomous_mode(struct qmp_combo *qmp)
 {
-	const struct qmp_phy_cfg *cfg = qphy->cfg;
-	void __iomem *pcs_usb = qphy->pcs_usb ?: qphy->pcs;
-	void __iomem *pcs_misc = qphy->pcs_misc;
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	void __iomem *pcs_usb = qmp->pcs_usb ?: qmp->pcs;
+	void __iomem *pcs_misc = qmp->pcs_misc;
 
 	/* Disable i/o clamp_n on resume for normal mode */
 	if (pcs_misc)
@@ -2151,20 +2110,19 @@ static void qmp_combo_disable_autonomous_mode(struct qmp_phy *qphy)
 
 static int __maybe_unused qmp_combo_runtime_suspend(struct device *dev)
 {
-	struct qcom_qmp *qmp = dev_get_drvdata(dev);
-	struct qmp_phy *qphy = qmp->usb_phy;
-	const struct qmp_phy_cfg *cfg = qphy->cfg;
+	struct qmp_combo *qmp = dev_get_drvdata(dev);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
 
-	dev_vdbg(dev, "Suspending QMP phy, mode:%d\n", qphy->mode);
+	dev_vdbg(dev, "Suspending QMP phy, mode:%d\n", qmp->mode);
 
 	if (!qmp->init_count) {
 		dev_vdbg(dev, "PHY not initialized, bailing out\n");
 		return 0;
 	}
 
-	qmp_combo_enable_autonomous_mode(qphy);
+	qmp_combo_enable_autonomous_mode(qmp);
 
-	clk_disable_unprepare(qphy->pipe_clk);
+	clk_disable_unprepare(qmp->pipe_clk);
 	clk_bulk_disable_unprepare(cfg->num_clks, qmp->clks);
 
 	return 0;
@@ -2172,12 +2130,11 @@ static int __maybe_unused qmp_combo_runtime_suspend(struct device *dev)
 
 static int __maybe_unused qmp_combo_runtime_resume(struct device *dev)
 {
-	struct qcom_qmp *qmp = dev_get_drvdata(dev);
-	struct qmp_phy *qphy = qmp->usb_phy;
-	const struct qmp_phy_cfg *cfg = qphy->cfg;
+	struct qmp_combo *qmp = dev_get_drvdata(dev);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	int ret = 0;
 
-	dev_vdbg(dev, "Resuming QMP phy, mode:%d\n", qphy->mode);
+	dev_vdbg(dev, "Resuming QMP phy, mode:%d\n", qmp->mode);
 
 	if (!qmp->init_count) {
 		dev_vdbg(dev, "PHY not initialized, bailing out\n");
@@ -2188,14 +2145,14 @@ static int __maybe_unused qmp_combo_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(qphy->pipe_clk);
+	ret = clk_prepare_enable(qmp->pipe_clk);
 	if (ret) {
 		dev_err(dev, "pipe_clk enable failed, err=%d\n", ret);
 		clk_bulk_disable_unprepare(cfg->num_clks, qmp->clks);
 		return ret;
 	}
 
-	qmp_combo_disable_autonomous_mode(qphy);
+	qmp_combo_disable_autonomous_mode(qmp);
 
 	return 0;
 }
@@ -2207,7 +2164,7 @@ static const struct dev_pm_ops qmp_combo_pm_ops = {
 
 static int qmp_combo_vreg_init(struct device *dev, const struct qmp_phy_cfg *cfg)
 {
-	struct qcom_qmp *qmp = dev_get_drvdata(dev);
+	struct qmp_combo *qmp = dev_get_drvdata(dev);
 	int num = cfg->num_vregs;
 	int ret, i;
 
@@ -2239,7 +2196,7 @@ static int qmp_combo_vreg_init(struct device *dev, const struct qmp_phy_cfg *cfg
 
 static int qmp_combo_reset_init(struct device *dev, const struct qmp_phy_cfg *cfg)
 {
-	struct qcom_qmp *qmp = dev_get_drvdata(dev);
+	struct qmp_combo *qmp = dev_get_drvdata(dev);
 	int i;
 	int ret;
 
@@ -2260,7 +2217,7 @@ static int qmp_combo_reset_init(struct device *dev, const struct qmp_phy_cfg *cf
 
 static int qmp_combo_clk_init(struct device *dev, const struct qmp_phy_cfg *cfg)
 {
-	struct qcom_qmp *qmp = dev_get_drvdata(dev);
+	struct qmp_combo *qmp = dev_get_drvdata(dev);
 	int num = cfg->num_clks;
 	int i;
 
@@ -2297,7 +2254,7 @@ static void phy_clk_release_provider(void *res)
  *    clk  |   +-------+   |                   +-----+
  *         +---------------+
  */
-static int phy_pipe_clk_register(struct qcom_qmp *qmp, struct device_node *np)
+static int phy_pipe_clk_register(struct qmp_combo *qmp, struct device_node *np)
 {
 	struct clk_fixed_rate *fixed;
 	struct clk_init_data init = { };
@@ -2400,12 +2357,12 @@ static unsigned long
 qcom_qmp_dp_pixel_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 {
 	const struct qmp_phy_dp_clks *dp_clks;
-	const struct qmp_phy *qphy;
+	const struct qmp_combo *qmp;
 	const struct phy_configure_opts_dp *dp_opts;
 
 	dp_clks = container_of(hw, struct qmp_phy_dp_clks, dp_pixel_hw);
-	qphy = dp_clks->qphy;
-	dp_opts = &qphy->dp_opts;
+	qmp = dp_clks->qmp;
+	dp_opts = &qmp->dp_opts;
 
 	switch (dp_opts->link_rate) {
 	case 1620:
@@ -2444,12 +2401,12 @@ static unsigned long
 qcom_qmp_dp_link_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 {
 	const struct qmp_phy_dp_clks *dp_clks;
-	const struct qmp_phy *qphy;
+	const struct qmp_combo *qmp;
 	const struct phy_configure_opts_dp *dp_opts;
 
 	dp_clks = container_of(hw, struct qmp_phy_dp_clks, dp_link_hw);
-	qphy = dp_clks->qphy;
-	dp_opts = &qphy->dp_opts;
+	qmp = dp_clks->qmp;
+	dp_opts = &qmp->dp_opts;
 
 	switch (dp_opts->link_rate) {
 	case 1620:
@@ -2484,8 +2441,7 @@ qcom_qmp_dp_clks_hw_get(struct of_phandle_args *clkspec, void *data)
 	return &dp_clks->dp_pixel_hw;
 }
 
-static int phy_dp_clks_register(struct qcom_qmp *qmp, struct qmp_phy *qphy,
-				struct device_node *np)
+static int phy_dp_clks_register(struct qmp_combo *qmp, struct device_node *np)
 {
 	struct clk_init_data init = { };
 	struct qmp_phy_dp_clks *dp_clks;
@@ -2496,8 +2452,8 @@ static int phy_dp_clks_register(struct qcom_qmp *qmp, struct qmp_phy *qphy,
 	if (!dp_clks)
 		return -ENOMEM;
 
-	dp_clks->qphy = qphy;
-	qphy->dp_clks = dp_clks;
+	dp_clks->qmp = qmp;
+	qmp->dp_clks = dp_clks;
 
 	snprintf(name, sizeof(name), "%s::link_clk", dev_name(qmp->dev));
 	init.ops = &qcom_qmp_dp_link_clk_ops;
@@ -2526,20 +2482,15 @@ static int phy_dp_clks_register(struct qcom_qmp *qmp, struct qmp_phy *qphy,
 	return devm_add_action_or_reset(qmp->dev, phy_clk_release_provider, np);
 }
 
-static int qmp_combo_create_dp(struct device *dev, struct device_node *np, int id,
+static int qmp_combo_create_dp(struct device *dev, struct device_node *np,
 			void __iomem *serdes, const struct qmp_phy_cfg *cfg)
 {
-	struct qcom_qmp *qmp = dev_get_drvdata(dev);
+	struct qmp_combo *qmp = dev_get_drvdata(dev);
 	struct phy *generic_phy;
-	struct qmp_phy *qphy;
 	int ret;
 
-	qphy = devm_kzalloc(dev, sizeof(*qphy), GFP_KERNEL);
-	if (!qphy)
-		return -ENOMEM;
-
-	qphy->cfg = cfg;
-	qphy->dp_serdes = serdes;
+	qmp->cfg = cfg;
+	qmp->dp_serdes = serdes;
 	/*
 	 * Get memory resources for each PHY:
 	 * Resources are indexed as: tx -> 0; rx -> 1; pcs -> 2.
@@ -2548,18 +2499,18 @@ static int qmp_combo_create_dp(struct device *dev, struct device_node *np, int i
 	 *
 	 * Note that only tx/tx2 and pcs are used by the DP implementation.
 	 */
-	qphy->dp_tx = devm_of_iomap(dev, np, 0, NULL);
-	if (IS_ERR(qphy->dp_tx))
-		return PTR_ERR(qphy->dp_tx);
+	qmp->dp_tx = devm_of_iomap(dev, np, 0, NULL);
+	if (IS_ERR(qmp->dp_tx))
+		return PTR_ERR(qmp->dp_tx);
 
-	qphy->dp_pcs = devm_of_iomap(dev, np, 2, NULL);
-	if (IS_ERR(qphy->dp_pcs))
-		return PTR_ERR(qphy->dp_pcs);
+	qmp->dp_pcs = devm_of_iomap(dev, np, 2, NULL);
+	if (IS_ERR(qmp->dp_pcs))
+		return PTR_ERR(qmp->dp_pcs);
 
 	if (cfg->lanes >= 2) {
-		qphy->dp_tx2 = devm_of_iomap(dev, np, 3, NULL);
-		if (IS_ERR(qphy->dp_tx2))
-			return PTR_ERR(qphy->dp_tx2);
+		qmp->dp_tx2 = devm_of_iomap(dev, np, 3, NULL);
+		if (IS_ERR(qmp->dp_tx2))
+			return PTR_ERR(qmp->dp_tx2);
 	}
 
 	generic_phy = devm_phy_create(dev, np, &qmp_combo_dp_phy_ops);
@@ -2569,72 +2520,65 @@ static int qmp_combo_create_dp(struct device *dev, struct device_node *np, int i
 		return ret;
 	}
 
-	qphy->phy = generic_phy;
-	qphy->qmp = qmp;
-	qmp->phys[id] = qphy;
-	phy_set_drvdata(generic_phy, qphy);
+	qmp->dp_phy = generic_phy;
+	phy_set_drvdata(generic_phy, qmp);
 
 	return 0;
 }
 
-static int qmp_combo_create_usb(struct device *dev, struct device_node *np, int id,
+static int qmp_combo_create_usb(struct device *dev, struct device_node *np,
 			void __iomem *serdes, const struct qmp_phy_cfg *cfg)
 {
-	struct qcom_qmp *qmp = dev_get_drvdata(dev);
+	struct qmp_combo *qmp = dev_get_drvdata(dev);
 	struct phy *generic_phy;
-	struct qmp_phy *qphy;
 	int ret;
 
-	qphy = devm_kzalloc(dev, sizeof(*qphy), GFP_KERNEL);
-	if (!qphy)
-		return -ENOMEM;
-
-	qphy->cfg = cfg;
-	qphy->serdes = serdes;
+	qmp->cfg = cfg;
+	qmp->serdes = serdes;
 	/*
 	 * Get memory resources for each PHY:
 	 * Resources are indexed as: tx -> 0; rx -> 1; pcs -> 2.
 	 * For dual lane PHYs: tx2 -> 3, rx2 -> 4, pcs_misc (optional) -> 5
 	 * For single lane PHYs: pcs_misc (optional) -> 3.
 	 */
-	qphy->tx = devm_of_iomap(dev, np, 0, NULL);
-	if (IS_ERR(qphy->tx))
-		return PTR_ERR(qphy->tx);
+	qmp->tx = devm_of_iomap(dev, np, 0, NULL);
+	if (IS_ERR(qmp->tx))
+		return PTR_ERR(qmp->tx);
 
-	qphy->rx = devm_of_iomap(dev, np, 1, NULL);
-	if (IS_ERR(qphy->rx))
-		return PTR_ERR(qphy->rx);
+	qmp->rx = devm_of_iomap(dev, np, 1, NULL);
+	if (IS_ERR(qmp->rx))
+		return PTR_ERR(qmp->rx);
 
-	qphy->pcs = devm_of_iomap(dev, np, 2, NULL);
-	if (IS_ERR(qphy->pcs))
-		return PTR_ERR(qphy->pcs);
+	qmp->pcs = devm_of_iomap(dev, np, 2, NULL);
+	if (IS_ERR(qmp->pcs))
+		return PTR_ERR(qmp->pcs);
 
 	if (cfg->pcs_usb_offset)
-		qphy->pcs_usb = qphy->pcs + cfg->pcs_usb_offset;
+		qmp->pcs_usb = qmp->pcs + cfg->pcs_usb_offset;
 
 	if (cfg->lanes >= 2) {
-		qphy->tx2 = devm_of_iomap(dev, np, 3, NULL);
-		if (IS_ERR(qphy->tx2))
-			return PTR_ERR(qphy->tx2);
+		qmp->tx2 = devm_of_iomap(dev, np, 3, NULL);
+		if (IS_ERR(qmp->tx2))
+			return PTR_ERR(qmp->tx2);
 
-		qphy->rx2 = devm_of_iomap(dev, np, 4, NULL);
-		if (IS_ERR(qphy->rx2))
-			return PTR_ERR(qphy->rx2);
+		qmp->rx2 = devm_of_iomap(dev, np, 4, NULL);
+		if (IS_ERR(qmp->rx2))
+			return PTR_ERR(qmp->rx2);
 
-		qphy->pcs_misc = devm_of_iomap(dev, np, 5, NULL);
+		qmp->pcs_misc = devm_of_iomap(dev, np, 5, NULL);
 	} else {
-		qphy->pcs_misc = devm_of_iomap(dev, np, 3, NULL);
+		qmp->pcs_misc = devm_of_iomap(dev, np, 3, NULL);
 	}
 
-	if (IS_ERR(qphy->pcs_misc)) {
+	if (IS_ERR(qmp->pcs_misc)) {
 		dev_vdbg(dev, "PHY pcs_misc-reg not used\n");
-		qphy->pcs_misc = NULL;
+		qmp->pcs_misc = NULL;
 	}
 
-	qphy->pipe_clk = devm_get_clk_from_child(dev, np, NULL);
-	if (IS_ERR(qphy->pipe_clk)) {
-		return dev_err_probe(dev, PTR_ERR(qphy->pipe_clk),
-				     "failed to get lane%d pipe_clk\n", id);
+	qmp->pipe_clk = devm_get_clk_from_child(dev, np, NULL);
+	if (IS_ERR(qmp->pipe_clk)) {
+		return dev_err_probe(dev, PTR_ERR(qmp->pipe_clk),
+				     "failed to get pipe clock\n");
 	}
 
 	generic_phy = devm_phy_create(dev, np, &qmp_combo_usb_phy_ops);
@@ -2644,17 +2588,15 @@ static int qmp_combo_create_usb(struct device *dev, struct device_node *np, int
 		return ret;
 	}
 
-	qphy->phy = generic_phy;
-	qphy->qmp = qmp;
-	qmp->phys[id] = qphy;
-	phy_set_drvdata(generic_phy, qphy);
+	qmp->usb_phy = generic_phy;
+	phy_set_drvdata(generic_phy, qmp);
 
 	return 0;
 }
 
 static int qmp_combo_probe(struct platform_device *pdev)
 {
-	struct qcom_qmp *qmp;
+	struct qmp_combo *qmp;
 	struct device *dev = &pdev->dev;
 	struct device_node *child;
 	struct phy_provider *phy_provider;
@@ -2709,10 +2651,6 @@ static int qmp_combo_probe(struct platform_device *pdev)
 	if (num > expected_phys)
 		return -EINVAL;
 
-	qmp->phys = devm_kcalloc(dev, num, sizeof(*qmp->phys), GFP_KERNEL);
-	if (!qmp->phys)
-		return -ENOMEM;
-
 	pm_runtime_set_active(dev);
 	ret = devm_pm_runtime_enable(dev);
 	if (ret)
@@ -2729,14 +2667,14 @@ static int qmp_combo_probe(struct platform_device *pdev)
 			serdes = dp_serdes;
 
 			/* Create per-lane phy */
-			ret = qmp_combo_create_dp(dev, child, id, serdes, cfg);
+			ret = qmp_combo_create_dp(dev, child, serdes, cfg);
 			if (ret) {
 				dev_err(dev, "failed to create lane%d phy, %d\n",
 					id, ret);
 				goto err_node_put;
 			}
 
-			ret = phy_dp_clks_register(qmp, qmp->phys[id], child);
+			ret = phy_dp_clks_register(qmp, child);
 			if (ret) {
 				dev_err(qmp->dev,
 					"failed to register DP clock source\n");
@@ -2746,15 +2684,13 @@ static int qmp_combo_probe(struct platform_device *pdev)
 			serdes = usb_serdes;
 
 			/* Create per-lane phy */
-			ret = qmp_combo_create_usb(dev, child, id, serdes, cfg);
+			ret = qmp_combo_create_usb(dev, child, serdes, cfg);
 			if (ret) {
 				dev_err(dev, "failed to create lane%d phy, %d\n",
 					id, ret);
 				goto err_node_put;
 			}
 
-			qmp->usb_phy = qmp->phys[id];
-
 			/*
 			 * Register the pipe clock provided by phy.
 			 * See function description to see details of this pipe clock.
-- 
2.37.4

