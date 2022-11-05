Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB83761DB80
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 16:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiKEPDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 11:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiKEPC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 11:02:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259441055E;
        Sat,  5 Nov 2022 08:02:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B356B801BE;
        Sat,  5 Nov 2022 15:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3312AC43150;
        Sat,  5 Nov 2022 15:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667660570;
        bh=1IHCgdVtlGJxtcJ/nnfwi72XD/RA4ih8LTuzKR2YTOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XgQNHXfwFWbwKrr+pr39XTrqDdeMB9uiGXPCkR4RZUIWMNC42j87PSiOWW8Zng031
         yAuOy9Gw76v2573bcopzJQv8Xv6z2AYFsIO6W/4mlqS9NWsE5cDKbRCgQuiKZISx7i
         dX2c3ceZetUmUyfjH8yV+00X4I9CguFefSdN8mMrxI+hpRDLyalNt+uCngUGBd/QOS
         0nO4ge1eQccxTSqomr5UYsilwkElOe8WTYnubxNTt3mW2kN34MnxaSB9zqTn/aYnJ6
         yp9TJCtdyi2C9a6f0pKKIm/FNSWi7D1W2UWskemc3FhuV27uled09kLLC4Vp/Xnc9c
         gu83yrvE3FA2Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1orKgo-0005KL-T0; Sat, 05 Nov 2022 16:02:30 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v5 03/16] phy: qcom-qmp-pcie: merge driver data
Date:   Sat,  5 Nov 2022 15:59:26 +0100
Message-Id: <20221105145939.20318-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221105145939.20318-1-johan+linaro@kernel.org>
References: <20221105145939.20318-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCIe QMP PHY driver only manages a single PHY so merge the old
qcom_qmp and qmp_phy structures and drop the PHY array.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 218 +++++++++--------------
 1 file changed, 88 insertions(+), 130 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index e66f6adc404b..667a87e7c917 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1365,56 +1365,26 @@ struct qmp_phy_cfg {
 	unsigned long pipe_clock_rate;
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
- * @pipe_clk: pipe clock
- * @qmp: QMP phy to which this lane belongs
- * @mode: currently selected PHY mode
- */
-struct qmp_phy {
-	struct phy *phy;
+struct qmp_pcie {
+	struct device *dev;
+
 	const struct qmp_phy_cfg *cfg;
+
 	void __iomem *serdes;
+	void __iomem *pcs;
+	void __iomem *pcs_misc;
 	void __iomem *tx;
 	void __iomem *rx;
-	void __iomem *pcs;
 	void __iomem *tx2;
 	void __iomem *rx2;
-	void __iomem *pcs_misc;
-	struct clk *pipe_clk;
-	struct qcom_qmp *qmp;
-	int mode;
-};
-
-/**
- * struct qcom_qmp - structure holding QMP phy block attributes
- *
- * @dev: device
- *
- * @clks: array of clocks required by phy
- * @resets: array of resets required by phy
- * @vregs: regulator supplies bulk data
- *
- * @phys: array of per-lane phy descriptors
- */
-struct qcom_qmp {
-	struct device *dev;
 
+	struct clk *pipe_clk;
 	struct clk_bulk_data *clks;
 	struct reset_control_bulk_data *resets;
 	struct regulator_bulk_data *vregs;
 
-	struct qmp_phy **phys;
+	struct phy *phy;
+	int mode;
 };
 
 static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
@@ -1850,9 +1820,9 @@ static void qmp_pcie_configure(void __iomem *base,
 	qmp_pcie_configure_lane(base, tbl, num, 0xff);
 }
 
-static void qmp_pcie_serdes_init(struct qmp_phy *qphy, const struct qmp_phy_cfg_tables *tables)
+static void qmp_pcie_serdes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tables)
 {
-	void __iomem *serdes = qphy->serdes;
+	void __iomem *serdes = qmp->serdes;
 
 	if (!tables)
 		return;
@@ -1860,11 +1830,11 @@ static void qmp_pcie_serdes_init(struct qmp_phy *qphy, const struct qmp_phy_cfg_
 	qmp_pcie_configure(serdes, tables->serdes, tables->serdes_num);
 }
 
-static void qmp_pcie_lanes_init(struct qmp_phy *qphy, const struct qmp_phy_cfg_tables *tables)
+static void qmp_pcie_lanes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tables)
 {
-	const struct qmp_phy_cfg *cfg = qphy->cfg;
-	void __iomem *tx = qphy->tx;
-	void __iomem *rx = qphy->rx;
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	void __iomem *tx = qmp->tx;
+	void __iomem *rx = qmp->rx;
 
 	if (!tables)
 		return;
@@ -1872,17 +1842,17 @@ static void qmp_pcie_lanes_init(struct qmp_phy *qphy, const struct qmp_phy_cfg_t
 	qmp_pcie_configure_lane(tx, tables->tx, tables->tx_num, 1);
 
 	if (cfg->lanes >= 2)
-		qmp_pcie_configure_lane(qphy->tx2, tables->tx, tables->tx_num, 2);
+		qmp_pcie_configure_lane(qmp->tx2, tables->tx, tables->tx_num, 2);
 
 	qmp_pcie_configure_lane(rx, tables->rx, tables->rx_num, 1);
 	if (cfg->lanes >= 2)
-		qmp_pcie_configure_lane(qphy->rx2, tables->rx, tables->rx_num, 2);
+		qmp_pcie_configure_lane(qmp->rx2, tables->rx, tables->rx_num, 2);
 }
 
-static void qmp_pcie_pcs_init(struct qmp_phy *qphy, const struct qmp_phy_cfg_tables *tables)
+static void qmp_pcie_pcs_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tables)
 {
-	void __iomem *pcs = qphy->pcs;
-	void __iomem *pcs_misc = qphy->pcs_misc;
+	void __iomem *pcs = qmp->pcs;
+	void __iomem *pcs_misc = qmp->pcs_misc;
 
 	if (!tables)
 		return;
@@ -1893,9 +1863,8 @@ static void qmp_pcie_pcs_init(struct qmp_phy *qphy, const struct qmp_phy_cfg_tab
 
 static int qmp_pcie_init(struct phy *phy)
 {
-	struct qmp_phy *qphy = phy_get_drvdata(phy);
-	struct qcom_qmp *qmp = qphy->qmp;
-	const struct qmp_phy_cfg *cfg = qphy->cfg;
+	struct qmp_pcie *qmp = phy_get_drvdata(phy);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	int ret;
 
 	ret = regulator_bulk_enable(cfg->num_vregs, qmp->vregs);
@@ -1932,9 +1901,8 @@ static int qmp_pcie_init(struct phy *phy)
 
 static int qmp_pcie_exit(struct phy *phy)
 {
-	struct qmp_phy *qphy = phy_get_drvdata(phy);
-	struct qcom_qmp *qmp = qphy->qmp;
-	const struct qmp_phy_cfg *cfg = qphy->cfg;
+	struct qmp_pcie *qmp = phy_get_drvdata(phy);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
 
 	reset_control_bulk_assert(cfg->num_resets, qmp->resets);
 
@@ -1947,11 +1915,10 @@ static int qmp_pcie_exit(struct phy *phy)
 
 static int qmp_pcie_power_on(struct phy *phy)
 {
-	struct qmp_phy *qphy = phy_get_drvdata(phy);
-	struct qcom_qmp *qmp = qphy->qmp;
-	const struct qmp_phy_cfg *cfg = qphy->cfg;
+	struct qmp_pcie *qmp = phy_get_drvdata(phy);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	const struct qmp_phy_cfg_tables *mode_tables;
-	void __iomem *pcs = qphy->pcs;
+	void __iomem *pcs = qmp->pcs;
 	void __iomem *status;
 	unsigned int mask, val;
 	int ret;
@@ -1959,26 +1926,26 @@ static int qmp_pcie_power_on(struct phy *phy)
 	qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
 			cfg->pwrdn_ctrl);
 
-	if (qphy->mode == PHY_MODE_PCIE_RC)
+	if (qmp->mode == PHY_MODE_PCIE_RC)
 		mode_tables = cfg->tables_rc;
 	else
 		mode_tables = cfg->tables_ep;
 
-	qmp_pcie_serdes_init(qphy, &cfg->tables);
-	qmp_pcie_serdes_init(qphy, mode_tables);
+	qmp_pcie_serdes_init(qmp, &cfg->tables);
+	qmp_pcie_serdes_init(qmp, mode_tables);
 
-	ret = clk_prepare_enable(qphy->pipe_clk);
+	ret = clk_prepare_enable(qmp->pipe_clk);
 	if (ret) {
 		dev_err(qmp->dev, "pipe_clk enable failed err=%d\n", ret);
 		return ret;
 	}
 
 	/* Tx, Rx, and PCS configurations */
-	qmp_pcie_lanes_init(qphy, &cfg->tables);
-	qmp_pcie_lanes_init(qphy, mode_tables);
+	qmp_pcie_lanes_init(qmp, &cfg->tables);
+	qmp_pcie_lanes_init(qmp, mode_tables);
 
-	qmp_pcie_pcs_init(qphy, &cfg->tables);
-	qmp_pcie_pcs_init(qphy, mode_tables);
+	qmp_pcie_pcs_init(qmp, &cfg->tables);
+	qmp_pcie_pcs_init(qmp, mode_tables);
 
 	/* Pull PHY out of reset state */
 	qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
@@ -2001,27 +1968,27 @@ static int qmp_pcie_power_on(struct phy *phy)
 	return 0;
 
 err_disable_pipe_clk:
-	clk_disable_unprepare(qphy->pipe_clk);
+	clk_disable_unprepare(qmp->pipe_clk);
 
 	return ret;
 }
 
 static int qmp_pcie_power_off(struct phy *phy)
 {
-	struct qmp_phy *qphy = phy_get_drvdata(phy);
-	const struct qmp_phy_cfg *cfg = qphy->cfg;
+	struct qmp_pcie *qmp = phy_get_drvdata(phy);
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
 			cfg->pwrdn_ctrl);
 
 	return 0;
@@ -2055,12 +2022,12 @@ static int qmp_pcie_disable(struct phy *phy)
 
 static int qmp_pcie_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 {
-	struct qmp_phy *qphy = phy_get_drvdata(phy);
+	struct qmp_pcie *qmp = phy_get_drvdata(phy);
 
 	switch (submode) {
 	case PHY_MODE_PCIE_RC:
 	case PHY_MODE_PCIE_EP:
-		qphy->mode = submode;
+		qmp->mode = submode;
 		break;
 	default:
 		dev_err(&phy->dev, "Unsupported submode %d\n", submode);
@@ -2072,7 +2039,7 @@ static int qmp_pcie_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 
 static int qmp_pcie_vreg_init(struct device *dev, const struct qmp_phy_cfg *cfg)
 {
-	struct qcom_qmp *qmp = dev_get_drvdata(dev);
+	struct qmp_pcie *qmp = dev_get_drvdata(dev);
 	int num = cfg->num_vregs;
 	int i;
 
@@ -2088,7 +2055,7 @@ static int qmp_pcie_vreg_init(struct device *dev, const struct qmp_phy_cfg *cfg)
 
 static int qmp_pcie_reset_init(struct device *dev, const struct qmp_phy_cfg *cfg)
 {
-	struct qcom_qmp *qmp = dev_get_drvdata(dev);
+	struct qmp_pcie *qmp = dev_get_drvdata(dev);
 	int i;
 	int ret;
 
@@ -2109,7 +2076,7 @@ static int qmp_pcie_reset_init(struct device *dev, const struct qmp_phy_cfg *cfg
 
 static int qmp_pcie_clk_init(struct device *dev, const struct qmp_phy_cfg *cfg)
 {
-	struct qcom_qmp *qmp = dev_get_drvdata(dev);
+	struct qmp_pcie *qmp = dev_get_drvdata(dev);
 	int num = cfg->num_clks;
 	int i;
 
@@ -2146,7 +2113,7 @@ static void phy_clk_release_provider(void *res)
  *    clk  |   +-------+   |                   +-----+
  *         +---------------+
  */
-static int phy_pipe_clk_register(struct qcom_qmp *qmp, struct device_node *np)
+static int phy_pipe_clk_register(struct qmp_pcie *qmp, struct device_node *np)
 {
 	struct clk_fixed_rate *fixed;
 	struct clk_init_data init = { };
@@ -2168,8 +2135,8 @@ static int phy_pipe_clk_register(struct qcom_qmp *qmp, struct device_node *np)
 	 * Controllers using QMP PHY-s use 125MHz pipe clock interface
 	 * unless other frequency is specified in the PHY config.
 	 */
-	if (qmp->phys[0]->cfg->pipe_clock_rate)
-		fixed->fixed_rate = qmp->phys[0]->cfg->pipe_clock_rate;
+	if (qmp->cfg->pipe_clock_rate)
+		fixed->fixed_rate = qmp->cfg->pipe_clock_rate;
 	else
 		fixed->fixed_rate = 125000000;
 
@@ -2197,97 +2164,92 @@ static const struct phy_ops qmp_pcie_ops = {
 	.owner		= THIS_MODULE,
 };
 
-static int qmp_pcie_create(struct device *dev, struct device_node *np, int id,
+static int qmp_pcie_create(struct device *dev, struct device_node *np,
 			void __iomem *serdes, const struct qmp_phy_cfg *cfg)
 {
-	struct qcom_qmp *qmp = dev_get_drvdata(dev);
+	struct qmp_pcie *qmp = dev_get_drvdata(dev);
 	struct phy *generic_phy;
-	struct qmp_phy *qphy;
 	int ret;
 
-	qphy = devm_kzalloc(dev, sizeof(*qphy), GFP_KERNEL);
-	if (!qphy)
-		return -ENOMEM;
+	qmp->mode = PHY_MODE_PCIE_RC;
 
-	qphy->mode = PHY_MODE_PCIE_RC;
+	qmp->cfg = cfg;
+	qmp->serdes = serdes;
 
-	qphy->cfg = cfg;
-	qphy->serdes = serdes;
 	/*
 	 * Get memory resources for the PHY:
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
 
 	if (of_device_is_compatible(dev->of_node, "qcom,sdm845-qhp-pcie-phy"))
-		qphy->rx = qphy->tx;
+		qmp->rx = qmp->tx;
 	else
-		qphy->rx = devm_of_iomap(dev, np, 1, NULL);
-	if (IS_ERR(qphy->rx))
-		return PTR_ERR(qphy->rx);
+		qmp->rx = devm_of_iomap(dev, np, 1, NULL);
+	if (IS_ERR(qmp->rx))
+		return PTR_ERR(qmp->rx);
 
-	qphy->pcs = devm_of_iomap(dev, np, 2, NULL);
-	if (IS_ERR(qphy->pcs))
-		return PTR_ERR(qphy->pcs);
+	qmp->pcs = devm_of_iomap(dev, np, 2, NULL);
+	if (IS_ERR(qmp->pcs))
+		return PTR_ERR(qmp->pcs);
 
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
 
-	if (IS_ERR(qphy->pcs_misc) &&
+	if (IS_ERR(qmp->pcs_misc) &&
 	    of_device_is_compatible(dev->of_node, "qcom,ipq6018-qmp-pcie-phy"))
-		qphy->pcs_misc = qphy->pcs + 0x400;
+		qmp->pcs_misc = qmp->pcs + 0x400;
 
-	if (IS_ERR(qphy->pcs_misc)) {
+	if (IS_ERR(qmp->pcs_misc)) {
 		if (cfg->tables.pcs_misc ||
 		    (cfg->tables_rc && cfg->tables_rc->pcs_misc) ||
-		    (cfg->tables_ep && cfg->tables_ep->pcs_misc))
-			return PTR_ERR(qphy->pcs_misc);
+		    (cfg->tables_ep && cfg->tables_ep->pcs_misc)) {
+			return PTR_ERR(qmp->pcs_misc);
+		}
 	}
 
-	qphy->pipe_clk = devm_get_clk_from_child(dev, np, NULL);
-	if (IS_ERR(qphy->pipe_clk)) {
-		return dev_err_probe(dev, PTR_ERR(qphy->pipe_clk),
-				     "failed to get lane%d pipe clock\n", id);
+	qmp->pipe_clk = devm_get_clk_from_child(dev, np, NULL);
+	if (IS_ERR(qmp->pipe_clk)) {
+		return dev_err_probe(dev, PTR_ERR(qmp->pipe_clk),
+				     "failed to get pipe clock\n");
 	}
 
 	generic_phy = devm_phy_create(dev, np, &qmp_pcie_ops);
 	if (IS_ERR(generic_phy)) {
 		ret = PTR_ERR(generic_phy);
-		dev_err(dev, "failed to create qphy %d\n", ret);
+		dev_err(dev, "failed to create PHY: %d\n", ret);
 		return ret;
 	}
 
-	qphy->phy = generic_phy;
-	qphy->qmp = qmp;
-	qmp->phys[id] = qphy;
-	phy_set_drvdata(generic_phy, qphy);
+	qmp->phy = generic_phy;
+	phy_set_drvdata(generic_phy, qmp);
 
 	return 0;
 }
 
 static int qmp_pcie_probe(struct platform_device *pdev)
 {
-	struct qcom_qmp *qmp;
 	struct device *dev = &pdev->dev;
 	struct device_node *child;
 	struct phy_provider *phy_provider;
 	void __iomem *serdes;
 	const struct qmp_phy_cfg *cfg = NULL;
+	struct qmp_pcie *qmp;
 	int num, id;
 	int ret;
 
@@ -2326,14 +2288,10 @@ static int qmp_pcie_probe(struct platform_device *pdev)
 	if (num > 1)
 		return -EINVAL;
 
-	qmp->phys = devm_kcalloc(dev, num, sizeof(*qmp->phys), GFP_KERNEL);
-	if (!qmp->phys)
-		return -ENOMEM;
-
 	id = 0;
 	for_each_available_child_of_node(dev->of_node, child) {
 		/* Create per-lane phy */
-		ret = qmp_pcie_create(dev, child, id, serdes, cfg);
+		ret = qmp_pcie_create(dev, child, serdes, cfg);
 		if (ret) {
 			dev_err(dev, "failed to create lane%d phy, %d\n",
 				id, ret);
-- 
2.37.4

