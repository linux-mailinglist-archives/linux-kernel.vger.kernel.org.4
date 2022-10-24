Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF6E609D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiJXJC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJXJBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:01:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CF227CD8;
        Mon, 24 Oct 2022 02:01:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADE42B80FC9;
        Mon, 24 Oct 2022 09:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA8DC4347C;
        Mon, 24 Oct 2022 09:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666602097;
        bh=XfrhZZ3hdURm8ajGKt9NS2MAtDQc+KzKurmU2+Tfeyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eNspZSZecXgQUmn8Zwgwx9XYXoY1InofeQu7HDGa9EpGPRKQGwm0apmG4hLL7w5TT
         4kQtFjv6txcDuJhMGWtgrQ+ooek/DvoRNY9bVIcVpG8mAtFvWm3MWtvQkLhj3uhlti
         XujkM/GEAWqmaiFjvC3UpDqT1IqcaIN0wVxaitEiQLIam55dKfJXuACpW57bGve1sW
         NzaESSVdmVoRkNnrCMx/anGuvwZLGB5jilU3grNDHJTyqsDG+oycUxPJ97IYTgywNV
         1gPWRl619ZYYIhJxQoR85YpTmR1U9i1CwBolrQBmIF13wjz4Yem2PyT3x9usMHJo+g
         JMJuGWjwd5veg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1omtKj-00056P-3y; Mon, 24 Oct 2022 11:01:21 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 02/10] phy: qcom-qmp-ufs: merge driver data
Date:   Mon, 24 Oct 2022 11:00:33 +0200
Message-Id: <20221024090041.19574-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024090041.19574-1-johan+linaro@kernel.org>
References: <20221024090041.19574-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UFS QMP PHY driver only manages a single PHY so merge the old
qcom_qmp and qmp_phy structures and drop the PHY array.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 171 +++++++++---------------
 1 file changed, 63 insertions(+), 108 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index acb8efa1d758..b4c3b3d97f52 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -548,54 +548,24 @@ struct qmp_phy_cfg {
 	bool no_pcs_sw_reset;
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
- * @qmp: QMP phy to which this lane belongs
- */
-struct qmp_phy {
-	struct phy *phy;
+struct qmp_ufs {
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
-	struct qcom_qmp *qmp;
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
- * @ufs_reset: optional UFS PHY reset handle
- */
-struct qcom_qmp {
-	struct device *dev;
 
 	struct clk_bulk_data *clks;
 	struct regulator_bulk_data *vregs;
-
-	struct qmp_phy **phys;
-
 	struct reset_control *ufs_reset;
+
+	struct phy *phy;
 };
 
 static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
@@ -782,10 +752,10 @@ static void qmp_ufs_configure(void __iomem *base,
 	qmp_ufs_configure_lane(base, tbl, num, 0xff);
 }
 
-static int qmp_ufs_serdes_init(struct qmp_phy *qphy)
+static int qmp_ufs_serdes_init(struct qmp_ufs *qmp)
 {
-	const struct qmp_phy_cfg *cfg = qphy->cfg;
-	void __iomem *serdes = qphy->serdes;
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	void __iomem *serdes = qmp->serdes;
 	const struct qmp_phy_init_tbl *serdes_tbl = cfg->serdes_tbl;
 	int serdes_tbl_num = cfg->serdes_tbl_num;
 
@@ -794,11 +764,10 @@ static int qmp_ufs_serdes_init(struct qmp_phy *qphy)
 	return 0;
 }
 
-static int qmp_ufs_com_init(struct qmp_phy *qphy)
+static int qmp_ufs_com_init(struct qmp_ufs *qmp)
 {
-	struct qcom_qmp *qmp = qphy->qmp;
-	const struct qmp_phy_cfg *cfg = qphy->cfg;
-	void __iomem *pcs = qphy->pcs;
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	void __iomem *pcs = qmp->pcs;
 	int ret;
 
 	ret = regulator_bulk_enable(cfg->num_vregs, qmp->vregs);
@@ -821,10 +790,9 @@ static int qmp_ufs_com_init(struct qmp_phy *qphy)
 	return ret;
 }
 
-static int qmp_ufs_com_exit(struct qmp_phy *qphy)
+static int qmp_ufs_com_exit(struct qmp_ufs *qmp)
 {
-	struct qcom_qmp *qmp = qphy->qmp;
-	const struct qmp_phy_cfg *cfg = qphy->cfg;
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
 
 	reset_control_assert(qmp->ufs_reset);
 
@@ -837,9 +805,8 @@ static int qmp_ufs_com_exit(struct qmp_phy *qphy)
 
 static int qmp_ufs_init(struct phy *phy)
 {
-	struct qmp_phy *qphy = phy_get_drvdata(phy);
-	struct qcom_qmp *qmp = qphy->qmp;
-	const struct qmp_phy_cfg *cfg = qphy->cfg;
+	struct qmp_ufs *qmp = phy_get_drvdata(phy);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	int ret;
 	dev_vdbg(qmp->dev, "Initializing QMP phy\n");
 
@@ -870,7 +837,7 @@ static int qmp_ufs_init(struct phy *phy)
 			return ret;
 	}
 
-	ret = qmp_ufs_com_init(qphy);
+	ret = qmp_ufs_com_init(qmp);
 	if (ret)
 		return ret;
 
@@ -879,28 +846,27 @@ static int qmp_ufs_init(struct phy *phy)
 
 static int qmp_ufs_power_on(struct phy *phy)
 {
-	struct qmp_phy *qphy = phy_get_drvdata(phy);
-	struct qcom_qmp *qmp = qphy->qmp;
-	const struct qmp_phy_cfg *cfg = qphy->cfg;
-	void __iomem *tx = qphy->tx;
-	void __iomem *rx = qphy->rx;
-	void __iomem *pcs = qphy->pcs;
+	struct qmp_ufs *qmp = phy_get_drvdata(phy);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	void __iomem *tx = qmp->tx;
+	void __iomem *rx = qmp->rx;
+	void __iomem *pcs = qmp->pcs;
 	void __iomem *status;
 	unsigned int val;
 	int ret;
 
-	qmp_ufs_serdes_init(qphy);
+	qmp_ufs_serdes_init(qmp);
 
 	/* Tx, Rx, and PCS configurations */
 	qmp_ufs_configure_lane(tx, cfg->tx_tbl, cfg->tx_tbl_num, 1);
 
 	if (cfg->lanes >= 2)
-		qmp_ufs_configure_lane(qphy->tx2, cfg->tx_tbl, cfg->tx_tbl_num, 2);
+		qmp_ufs_configure_lane(qmp->tx2, cfg->tx_tbl, cfg->tx_tbl_num, 2);
 
 	qmp_ufs_configure_lane(rx, cfg->rx_tbl, cfg->rx_tbl_num, 1);
 
 	if (cfg->lanes >= 2)
-		qmp_ufs_configure_lane(qphy->rx2, cfg->rx_tbl, cfg->rx_tbl_num, 2);
+		qmp_ufs_configure_lane(qmp->rx2, cfg->rx_tbl, cfg->rx_tbl_num, 2);
 
 	qmp_ufs_configure(pcs, cfg->pcs_tbl, cfg->pcs_tbl_num);
 
@@ -928,18 +894,18 @@ static int qmp_ufs_power_on(struct phy *phy)
 
 static int qmp_ufs_power_off(struct phy *phy)
 {
-	struct qmp_phy *qphy = phy_get_drvdata(phy);
-	const struct qmp_phy_cfg *cfg = qphy->cfg;
+	struct qmp_ufs *qmp = phy_get_drvdata(phy);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
 
 	/* PHY reset */
 	if (!cfg->no_pcs_sw_reset)
-		qphy_setbits(qphy->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
+		qphy_setbits(qmp->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
 
 	/* stop SerDes */
-	qphy_clrbits(qphy->pcs, cfg->regs[QPHY_START_CTRL], SERDES_START);
+	qphy_clrbits(qmp->pcs, cfg->regs[QPHY_START_CTRL], SERDES_START);
 
 	/* Put PHY into POWER DOWN state: active low */
-	qphy_clrbits(qphy->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
+	qphy_clrbits(qmp->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
 			SW_PWRDN);
 
 	return 0;
@@ -947,9 +913,9 @@ static int qmp_ufs_power_off(struct phy *phy)
 
 static int qmp_ufs_exit(struct phy *phy)
 {
-	struct qmp_phy *qphy = phy_get_drvdata(phy);
+	struct qmp_ufs *qmp = phy_get_drvdata(phy);
 
-	qmp_ufs_com_exit(qphy);
+	qmp_ufs_com_exit(qmp);
 
 	return 0;
 }
@@ -981,7 +947,7 @@ static int qmp_ufs_disable(struct phy *phy)
 
 static int qmp_ufs_vreg_init(struct device *dev, const struct qmp_phy_cfg *cfg)
 {
-	struct qcom_qmp *qmp = dev_get_drvdata(dev);
+	struct qmp_ufs *qmp = dev_get_drvdata(dev);
 	int num = cfg->num_vregs;
 	int i;
 
@@ -997,7 +963,7 @@ static int qmp_ufs_vreg_init(struct device *dev, const struct qmp_phy_cfg *cfg)
 
 static int qmp_ufs_clk_init(struct device *dev, const struct qmp_phy_cfg *cfg)
 {
-	struct qcom_qmp *qmp = dev_get_drvdata(dev);
+	struct qmp_ufs *qmp = dev_get_drvdata(dev);
 	int num = cfg->num_clks;
 	int i;
 
@@ -1017,78 +983,71 @@ static const struct phy_ops qcom_qmp_ufs_ops = {
 	.owner		= THIS_MODULE,
 };
 
-static int qmp_ufs_create(struct device *dev, struct device_node *np, int id,
+static int qmp_ufs_create(struct device *dev, struct device_node *np,
 			void __iomem *serdes, const struct qmp_phy_cfg *cfg)
 {
-	struct qcom_qmp *qmp = dev_get_drvdata(dev);
+	struct qmp_ufs *qmp = dev_get_drvdata(dev);
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
 
-	if (IS_ERR(qphy->pcs_misc))
+	if (IS_ERR(qmp->pcs_misc))
 		dev_vdbg(dev, "PHY pcs_misc-reg not used\n");
 
 	generic_phy = devm_phy_create(dev, np, &qcom_qmp_ufs_ops);
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
 
 static int qmp_ufs_probe(struct platform_device *pdev)
 {
-	struct qcom_qmp *qmp;
 	struct device *dev = &pdev->dev;
 	struct device_node *child;
 	struct phy_provider *phy_provider;
 	void __iomem *serdes;
 	const struct qmp_phy_cfg *cfg = NULL;
+	struct qmp_ufs *qmp;
 	int num, id;
 	int ret;
 
@@ -1120,14 +1079,10 @@ static int qmp_ufs_probe(struct platform_device *pdev)
 	if (num > 1)
 		return -EINVAL;
 
-	qmp->phys = devm_kcalloc(dev, num, sizeof(*qmp->phys), GFP_KERNEL);
-	if (!qmp->phys)
-		return -ENOMEM;
-
 	id = 0;
 	for_each_available_child_of_node(dev->of_node, child) {
 		/* Create per-lane phy */
-		ret = qmp_ufs_create(dev, child, id, serdes, cfg);
+		ret = qmp_ufs_create(dev, child, serdes, cfg);
 		if (ret) {
 			dev_err(dev, "failed to create lane%d phy, %d\n",
 				id, ret);
-- 
2.37.3

