Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0654261DB82
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 16:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiKEPD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 11:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiKEPC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 11:02:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4896110B56;
        Sat,  5 Nov 2022 08:02:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC569B803F4;
        Sat,  5 Nov 2022 15:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1449FC4FF65;
        Sat,  5 Nov 2022 15:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667660571;
        bh=ac7zfZ2v73KKq2vUMHNM8WE8k/tJLCb+tX+qP/emxfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NkMPYrIyR8U7Aw9E8i5nQVGjUdW5x0uU/0SCHX3uDTDddEq5vr/fAuKm1Y51THtLE
         OrVgOkK6UtOFHhsxCruet/4MBmPDtjTBHwczwLu0PO3Uej3C94Ey235OuFRahb1Qob
         MTOvpU0nQnx0p6QDCBSlXFdbfFd7k0fI5Tvt4LW/6hTagB4+2eBu20eLunm3Snz8MG
         3rOzySVfjz7p4naY/ey9DnK11eIQ1Sgfgq1TbTnzDWvCTWxF6XTTP75gEfAeCdv3J5
         i6NoCr6W69rTN0bh8aJ1oJGHA5OOXB11M5iCZ2NJwef8U72k3PIN/i+IqN9gw8WVbX
         StSbrDd2V2SWA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1orKgq-0005Ky-4D; Sat, 05 Nov 2022 16:02:32 +0100
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
Subject: [PATCH v5 16/16] phy: qcom-qmp-pcie: add support for sc8280xp 4-lane PHYs
Date:   Sat,  5 Nov 2022 15:59:39 +0100
Message-Id: <20221105145939.20318-17-johan+linaro@kernel.org>
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

The PCIe2 and PCIe3 controllers and PHYs on SC8280XP can be used in
4-lane mode or as separate controllers and PHYs in 2-lane mode (e.g. as
PCIe2A and PCIe2B).

Add support for fetching the 4-lane configuration from the TCSR and
programming the lane registers of the second port when in 4-lane mode.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/Kconfig             |   1 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 117 +++++++++++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
index 5c98850f5a36..eb9ddc685b38 100644
--- a/drivers/phy/qualcomm/Kconfig
+++ b/drivers/phy/qualcomm/Kconfig
@@ -54,6 +54,7 @@ config PHY_QCOM_QMP
 	tristate "Qualcomm QMP PHY Driver"
 	depends on OF && COMMON_CLK && (ARCH_QCOM || COMPILE_TEST)
 	select GENERIC_PHY
+	select MFD_SYSCON
 	help
 	  Enable this to support the QMP PHY transceiver that is used
 	  with controllers such as PCIe, UFS, and USB on Qualcomm chips.
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index f507a67a8361..111716e25b17 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -10,6 +10,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -17,6 +18,7 @@
 #include <linux/phy/pcie.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
@@ -886,6 +888,10 @@ static const struct qmp_phy_init_tbl sc8280xp_qmp_gen3x2_pcie_rc_serdes_tbl[] =
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIAS_EN_CLKBUFLR_EN, 0x14),
 };
 
+static const struct qmp_phy_init_tbl sc8280xp_qmp_gen3x4_pcie_serdes_4ln_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIAS_EN_CLKBUFLR_EN, 0x1c),
+};
+
 static const struct qmp_phy_init_tbl sc8280xp_qmp_gen3x1_pcie_tx_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_TX_PI_QEC_CTRL, 0x20),
 	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_1, 0x75),
@@ -1491,6 +1497,9 @@ struct qmp_phy_cfg {
 	const struct qmp_phy_cfg_tbls *tbls_rc;
 	const struct qmp_phy_cfg_tbls *tbls_ep;
 
+	const struct qmp_phy_init_tbl *serdes_4ln_tbl;
+	int serdes_4ln_num;
+
 	/* clock ids to be requested */
 	const char * const *clk_list;
 	int num_clks;
@@ -1518,6 +1527,7 @@ struct qmp_pcie {
 	struct device *dev;
 
 	const struct qmp_phy_cfg *cfg;
+	bool tcsr_4ln_config;
 
 	void __iomem *serdes;
 	void __iomem *pcs;
@@ -1527,6 +1537,8 @@ struct qmp_pcie {
 	void __iomem *tx2;
 	void __iomem *rx2;
 
+	void __iomem *port_b;
+
 	struct clk_bulk_data *clks;
 	struct clk_bulk_data pipe_clks[2];
 	int num_pipe_clks;
@@ -1932,6 +1944,44 @@ static const struct qmp_phy_cfg sc8280xp_qmp_gen3x2_pciephy_cfg = {
 	.phy_status		= PHYSTATUS,
 };
 
+static const struct qmp_phy_cfg sc8280xp_qmp_gen3x4_pciephy_cfg = {
+	.lanes			= 4,
+
+	.offsets		= &qmp_pcie_offsets_v5,
+
+	.tbls = {
+		.serdes		= sc8280xp_qmp_pcie_serdes_tbl,
+		.serdes_num	= ARRAY_SIZE(sc8280xp_qmp_pcie_serdes_tbl),
+		.tx		= sc8280xp_qmp_gen3x2_pcie_tx_tbl,
+		.tx_num		= ARRAY_SIZE(sc8280xp_qmp_gen3x2_pcie_tx_tbl),
+		.rx		= sc8280xp_qmp_gen3x2_pcie_rx_tbl,
+		.rx_num		= ARRAY_SIZE(sc8280xp_qmp_gen3x2_pcie_rx_tbl),
+		.pcs		= sc8280xp_qmp_gen3x2_pcie_pcs_tbl,
+		.pcs_num	= ARRAY_SIZE(sc8280xp_qmp_gen3x2_pcie_pcs_tbl),
+		.pcs_misc	= sc8280xp_qmp_gen3x2_pcie_pcs_misc_tbl,
+		.pcs_misc_num	= ARRAY_SIZE(sc8280xp_qmp_gen3x2_pcie_pcs_misc_tbl),
+	},
+
+	.tbls_rc = &(const struct qmp_phy_cfg_tbls) {
+		.serdes		= sc8280xp_qmp_gen3x2_pcie_rc_serdes_tbl,
+		.serdes_num	= ARRAY_SIZE(sc8280xp_qmp_gen3x2_pcie_rc_serdes_tbl),
+	},
+
+	.serdes_4ln_tbl		= sc8280xp_qmp_gen3x4_pcie_serdes_4ln_tbl,
+	.serdes_4ln_num		= ARRAY_SIZE(sc8280xp_qmp_gen3x4_pcie_serdes_4ln_tbl),
+
+	.clk_list		= sc8280xp_pciephy_clk_l,
+	.num_clks		= ARRAY_SIZE(sc8280xp_pciephy_clk_l),
+	.reset_list		= sdm845_pciephy_reset_l,
+	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= sm8250_pcie_regs_layout,
+
+	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+	.phy_status		= PHYSTATUS,
+};
+
 static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
 	.lanes			= 2,
 
@@ -2054,6 +2104,24 @@ static void qmp_pcie_configure(void __iomem *base,
 	qmp_pcie_configure_lane(base, tbl, num, 0xff);
 }
 
+static void qmp_pcie_init_port_b(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tbls *tbls)
+{
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	const struct qmp_pcie_offsets *offs = cfg->offsets;
+	void __iomem *tx3, *rx3, *tx4, *rx4;
+
+	tx3 = qmp->port_b + offs->tx;
+	rx3 = qmp->port_b + offs->rx;
+	tx4 = qmp->port_b + offs->tx2;
+	rx4 = qmp->port_b + offs->rx2;
+
+	qmp_pcie_configure_lane(tx3, tbls->tx, tbls->tx_num, 1);
+	qmp_pcie_configure_lane(rx3, tbls->rx, tbls->rx_num, 1);
+
+	qmp_pcie_configure_lane(tx4, tbls->tx, tbls->tx_num, 2);
+	qmp_pcie_configure_lane(rx4, tbls->rx, tbls->rx_num, 2);
+}
+
 static void qmp_pcie_init_registers(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tbls *tbls)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
@@ -2080,6 +2148,11 @@ static void qmp_pcie_init_registers(struct qmp_pcie *qmp, const struct qmp_phy_c
 
 	qmp_pcie_configure(pcs, tbls->pcs, tbls->pcs_num);
 	qmp_pcie_configure(pcs_misc, tbls->pcs_misc, tbls->pcs_misc_num);
+
+	if (cfg->lanes >= 4 && qmp->tcsr_4ln_config) {
+		qmp_pcie_configure(serdes, cfg->serdes_4ln_tbl, cfg->serdes_4ln_num);
+		qmp_pcie_init_port_b(qmp, tbls);
+	}
 }
 
 static int qmp_pcie_init(struct phy *phy)
@@ -2452,6 +2525,37 @@ static int qmp_pcie_parse_dt_legacy(struct qmp_pcie *qmp, struct device_node *np
 	return 0;
 }
 
+static int qmp_pcie_get_4ln_config(struct qmp_pcie *qmp)
+{
+	struct regmap *tcsr;
+	unsigned int args[2];
+	int ret;
+
+	tcsr = syscon_regmap_lookup_by_phandle_args(qmp->dev->of_node,
+						    "qcom,4ln-config-sel",
+						    ARRAY_SIZE(args), args);
+	if (IS_ERR(tcsr)) {
+		ret = PTR_ERR(tcsr);
+		if (ret == -ENOENT)
+			return 0;
+
+		dev_err(qmp->dev, "failed to lookup syscon: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_test_bits(tcsr, args[0], BIT(args[1]));
+	if (ret < 0) {
+		dev_err(qmp->dev, "failed to read tcsr: %d\n", ret);
+		return ret;
+	}
+
+	qmp->tcsr_4ln_config = ret;
+
+	dev_dbg(qmp->dev, "4ln_config_sel = %d\n", qmp->tcsr_4ln_config);
+
+	return 0;
+}
+
 static int qmp_pcie_parse_dt(struct qmp_pcie *qmp)
 {
 	struct platform_device *pdev = to_platform_device(qmp->dev);
@@ -2464,6 +2568,10 @@ static int qmp_pcie_parse_dt(struct qmp_pcie *qmp)
 	if (!offs)
 		return -EINVAL;
 
+	ret = qmp_pcie_get_4ln_config(qmp);
+	if (ret)
+		return ret;
+
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
@@ -2479,6 +2587,12 @@ static int qmp_pcie_parse_dt(struct qmp_pcie *qmp)
 		qmp->rx2 = base + offs->rx2;
 	}
 
+	if (qmp->cfg->lanes >= 4 && qmp->tcsr_4ln_config) {
+		qmp->port_b = devm_platform_ioremap_resource(pdev, 1);
+		if (IS_ERR(qmp->port_b))
+			return PTR_ERR(qmp->port_b);
+	}
+
 	qmp->num_pipe_clks = 2;
 	qmp->pipe_clks[0].id = "pipe";
 	qmp->pipe_clks[1].id = "pipediv2";
@@ -2582,6 +2696,9 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sc8280xp-qmp-gen3x2-pcie-phy",
 		.data = &sc8280xp_qmp_gen3x2_pciephy_cfg,
+	}, {
+		.compatible = "qcom,sc8280xp-qmp-gen3x4-pcie-phy",
+		.data = &sc8280xp_qmp_gen3x4_pciephy_cfg,
 	}, {
 		.compatible = "qcom,sdm845-qhp-pcie-phy",
 		.data = &sdm845_qhp_pciephy_cfg,
-- 
2.37.4

