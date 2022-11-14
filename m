Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471F6627BAB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbiKNLIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236619AbiKNLH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:07:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4C220F6D;
        Mon, 14 Nov 2022 03:07:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C335961028;
        Mon, 14 Nov 2022 11:07:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BCEC4FF64;
        Mon, 14 Nov 2022 11:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668424035;
        bh=jkw5mWTUG3R4cnFs5kDliGl+BmBVwAn3gIGahPrFN0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lFM7VpB5kmfNU1YGFMQWCU0xUcYsBSo0qUj7/+hyOLpg5ezjpFfH/uswvwMe0sgHD
         o5uAtNTpwQHPKIUjmiS2vlgjoIxVKOjHDVhwp/Nih8dxnKDz1fuC/jk0IP46cmpfyg
         SuumH3DSaq/YZz0JWoqE4C883hJSdok9xOjApmRbWmZexhBfl5EMywB2HCqMERB5I6
         fcS3anCctOrMenM51np7uGK1ZXzL955yWOQN+s1JbObuxbXLzAuc7noWXnPOthxpkc
         jDC8ZKK8VDiuc8oOAjcB6mGN1UEg3jA9ImzD3gkZGYfVp/cbEN7o0+nyDZRNA/KYgr
         9+PBZ9KC8Z89A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ouXIZ-0001FE-AS; Mon, 14 Nov 2022 12:06:43 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 18/22] phy: qcom-qmp-combo: merge USB and DP configurations
Date:   Mon, 14 Nov 2022 12:06:17 +0100
Message-Id: <20221114110621.4639-19-johan+linaro@kernel.org>
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

It does not really make any sense to keep separate configuration
structures for the USB and DP parts of the same PHY so merge them.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 182 +++++++---------------
 1 file changed, 57 insertions(+), 125 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index a0abeb7c3bca..298477259ee6 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -798,11 +798,7 @@ static const u8 qmp_dp_v5_voltage_swing_hbr_rbr[4][4] = {
 
 struct qmp_phy;
 
-/* struct qmp_phy_cfg - per-PHY initialization config */
 struct qmp_phy_cfg {
-	/* phy-type - PCIE/UFS/USB */
-	unsigned int type;
-
 	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
 	const struct qmp_phy_init_tbl *serdes_tbl;
 	int serdes_tbl_num;
@@ -863,11 +859,6 @@ struct qmp_phy_cfg {
 
 };
 
-struct qmp_phy_combo_cfg {
-	const struct qmp_phy_cfg *usb_cfg;
-	const struct qmp_phy_cfg *dp_cfg;
-};
-
 /**
  * struct qmp_phy - per-lane phy descriptor
  *
@@ -1007,9 +998,7 @@ static const char * const sc7180_usb3phy_reset_l[] = {
 	"phy",
 };
 
-static const struct qmp_phy_cfg sc7180_usb3phy_cfg = {
-	.type			= PHY_TYPE_USB3,
-
+static const struct qmp_phy_cfg sc7180_usb3dpphy_cfg = {
 	.serdes_tbl		= qmp_v3_usb3_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_serdes_tbl),
 	.tx_tbl			= qmp_v3_usb3_tx_tbl,
@@ -1018,19 +1007,6 @@ static const struct qmp_phy_cfg sc7180_usb3phy_cfg = {
 	.rx_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_rx_tbl),
 	.pcs_tbl		= qmp_v3_usb3_pcs_tbl,
 	.pcs_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_pcs_tbl),
-	.clk_list		= qmp_v3_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(qmp_v3_phy_clk_l),
-	.reset_list		= sc7180_usb3phy_reset_l,
-	.num_resets		= ARRAY_SIZE(sc7180_usb3phy_reset_l),
-	.vreg_list		= qmp_phy_vreg_l,
-	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
-	.regs			= qmp_v3_usb3phy_regs_layout,
-
-	.has_pwrdn_delay	= true,
-};
-
-static const struct qmp_phy_cfg sc7180_dpphy_cfg = {
-	.type			= PHY_TYPE_DP,
 
 	.dp_serdes_tbl		= qmp_v3_dp_serdes_tbl,
 	.dp_serdes_tbl_num	= ARRAY_SIZE(qmp_v3_dp_serdes_tbl),
@@ -1055,16 +1031,19 @@ static const struct qmp_phy_cfg sc7180_dpphy_cfg = {
 	.configure_dp_tx	= qcom_qmp_v3_phy_configure_dp_tx,
 	.configure_dp_phy	= qcom_qmp_v3_phy_configure_dp_phy,
 	.calibrate_dp_phy	= qcom_qmp_v3_dp_phy_calibrate,
-};
 
-static const struct qmp_phy_combo_cfg sc7180_usb3dpphy_cfg = {
-	.usb_cfg		= &sc7180_usb3phy_cfg,
-	.dp_cfg			= &sc7180_dpphy_cfg,
-};
+	.clk_list		= qmp_v3_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(qmp_v3_phy_clk_l),
+	.reset_list		= sc7180_usb3phy_reset_l,
+	.num_resets		= ARRAY_SIZE(sc7180_usb3phy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v3_usb3phy_regs_layout,
 
-static const struct qmp_phy_cfg sdm845_usb3phy_cfg = {
-	.type			= PHY_TYPE_USB3,
+	.has_pwrdn_delay	= true,
+};
 
+static const struct qmp_phy_cfg sdm845_usb3dpphy_cfg = {
 	.serdes_tbl		= qmp_v3_usb3_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_serdes_tbl),
 	.tx_tbl			= qmp_v3_usb3_tx_tbl,
@@ -1073,24 +1052,11 @@ static const struct qmp_phy_cfg sdm845_usb3phy_cfg = {
 	.rx_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_rx_tbl),
 	.pcs_tbl		= qmp_v3_usb3_pcs_tbl,
 	.pcs_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_pcs_tbl),
-	.clk_list		= qmp_v3_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(qmp_v3_phy_clk_l),
-	.reset_list		= msm8996_usb3phy_reset_l,
-	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
-	.vreg_list		= qmp_phy_vreg_l,
-	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
-	.regs			= qmp_v3_usb3phy_regs_layout,
-
-	.has_pwrdn_delay	= true,
-};
 
-static const struct qmp_phy_cfg sdm845_dpphy_cfg = {
-	.type			= PHY_TYPE_DP,
-
-	.serdes_tbl		= qmp_v3_dp_serdes_tbl,
-	.serdes_tbl_num		= ARRAY_SIZE(qmp_v3_dp_serdes_tbl),
-	.tx_tbl			= qmp_v3_dp_tx_tbl,
-	.tx_tbl_num		= ARRAY_SIZE(qmp_v3_dp_tx_tbl),
+	.dp_serdes_tbl		= qmp_v3_dp_serdes_tbl,
+	.dp_serdes_tbl_num	= ARRAY_SIZE(qmp_v3_dp_serdes_tbl),
+	.dp_tx_tbl		= qmp_v3_dp_tx_tbl,
+	.dp_tx_tbl_num		= ARRAY_SIZE(qmp_v3_dp_tx_tbl),
 
 	.serdes_tbl_rbr		= qmp_v3_dp_serdes_tbl_rbr,
 	.serdes_tbl_rbr_num	= ARRAY_SIZE(qmp_v3_dp_serdes_tbl_rbr),
@@ -1110,16 +1076,19 @@ static const struct qmp_phy_cfg sdm845_dpphy_cfg = {
 	.configure_dp_tx	= qcom_qmp_v3_phy_configure_dp_tx,
 	.configure_dp_phy	= qcom_qmp_v3_phy_configure_dp_phy,
 	.calibrate_dp_phy	= qcom_qmp_v3_dp_phy_calibrate,
-};
 
-static const struct qmp_phy_combo_cfg sdm845_usb3dpphy_cfg = {
-	.usb_cfg                = &sdm845_usb3phy_cfg,
-	.dp_cfg                 = &sdm845_dpphy_cfg,
-};
+	.clk_list		= qmp_v3_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(qmp_v3_phy_clk_l),
+	.reset_list		= msm8996_usb3phy_reset_l,
+	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v3_usb3phy_regs_layout,
 
-static const struct qmp_phy_cfg sm8150_usb3phy_cfg = {
-	.type			= PHY_TYPE_USB3,
+	.has_pwrdn_delay	= true,
+};
 
+static const struct qmp_phy_cfg sc8180x_usb3dpphy_cfg = {
 	.serdes_tbl		= sm8150_usb3_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_serdes_tbl),
 	.tx_tbl			= sm8150_usb3_tx_tbl,
@@ -1130,20 +1099,6 @@ static const struct qmp_phy_cfg sm8150_usb3phy_cfg = {
 	.pcs_tbl_num		= ARRAY_SIZE(sm8150_usb3_pcs_tbl),
 	.pcs_usb_tbl		= sm8150_usb3_pcs_usb_tbl,
 	.pcs_usb_tbl_num	= ARRAY_SIZE(sm8150_usb3_pcs_usb_tbl),
-	.clk_list		= qmp_v4_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(qmp_v4_phy_clk_l),
-	.reset_list		= msm8996_usb3phy_reset_l,
-	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
-	.vreg_list		= qmp_phy_vreg_l,
-	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
-	.regs			= qmp_v4_usb3phy_regs_layout,
-	.pcs_usb_offset		= 0x300,
-
-	.has_pwrdn_delay	= true,
-};
-
-static const struct qmp_phy_cfg sc8180x_dpphy_cfg = {
-	.type			= PHY_TYPE_DP,
 
 	.dp_serdes_tbl		= qmp_v4_dp_serdes_tbl,
 	.dp_serdes_tbl_num	= ARRAY_SIZE(qmp_v4_dp_serdes_tbl),
@@ -1168,24 +1123,7 @@ static const struct qmp_phy_cfg sc8180x_dpphy_cfg = {
 	.configure_dp_tx	= qcom_qmp_v4_phy_configure_dp_tx,
 	.configure_dp_phy	= qcom_qmp_v4_phy_configure_dp_phy,
 	.calibrate_dp_phy	= qcom_qmp_v4_dp_phy_calibrate,
-};
-
-static const struct qmp_phy_combo_cfg sc8180x_usb3dpphy_cfg = {
-	.usb_cfg		= &sm8150_usb3phy_cfg,
-	.dp_cfg			= &sc8180x_dpphy_cfg,
-};
-
-static const struct qmp_phy_cfg sc8280xp_usb43dp_usb_cfg = {
-	.type			= PHY_TYPE_USB3,
 
-	.serdes_tbl		= sc8280xp_usb43dp_serdes_tbl,
-	.serdes_tbl_num		= ARRAY_SIZE(sc8280xp_usb43dp_serdes_tbl),
-	.tx_tbl			= sc8280xp_usb43dp_tx_tbl,
-	.tx_tbl_num		= ARRAY_SIZE(sc8280xp_usb43dp_tx_tbl),
-	.rx_tbl			= sc8280xp_usb43dp_rx_tbl,
-	.rx_tbl_num		= ARRAY_SIZE(sc8280xp_usb43dp_rx_tbl),
-	.pcs_tbl		= sc8280xp_usb43dp_pcs_tbl,
-	.pcs_tbl_num		= ARRAY_SIZE(sc8280xp_usb43dp_pcs_tbl),
 	.clk_list		= qmp_v4_phy_clk_l,
 	.num_clks		= ARRAY_SIZE(qmp_v4_phy_clk_l),
 	.reset_list		= msm8996_usb3phy_reset_l,
@@ -1194,10 +1132,19 @@ static const struct qmp_phy_cfg sc8280xp_usb43dp_usb_cfg = {
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= qmp_v4_usb3phy_regs_layout,
 	.pcs_usb_offset		= 0x300,
+
+	.has_pwrdn_delay	= true,
 };
 
-static const struct qmp_phy_cfg sc8280xp_usb43dp_dp_cfg = {
-	.type			= PHY_TYPE_DP,
+static const struct qmp_phy_cfg sc8280xp_usb43dpphy_cfg = {
+	.serdes_tbl		= sc8280xp_usb43dp_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sc8280xp_usb43dp_serdes_tbl),
+	.tx_tbl			= sc8280xp_usb43dp_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(sc8280xp_usb43dp_tx_tbl),
+	.rx_tbl			= sc8280xp_usb43dp_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sc8280xp_usb43dp_rx_tbl),
+	.pcs_tbl		= sc8280xp_usb43dp_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sc8280xp_usb43dp_pcs_tbl),
 
 	.dp_serdes_tbl		= qmp_v5_dp_serdes_tbl,
 	.dp_serdes_tbl_num	= ARRAY_SIZE(qmp_v5_dp_serdes_tbl),
@@ -1222,16 +1169,18 @@ static const struct qmp_phy_cfg sc8280xp_usb43dp_dp_cfg = {
 	.configure_dp_tx	= qcom_qmp_v4_phy_configure_dp_tx,
 	.configure_dp_phy	= qcom_qmp_v5_phy_configure_dp_phy,
 	.calibrate_dp_phy	= qcom_qmp_v4_dp_phy_calibrate,
-};
 
-static const struct qmp_phy_combo_cfg sc8280xp_usb43dpphy_cfg = {
-	.usb_cfg		= &sc8280xp_usb43dp_usb_cfg,
-	.dp_cfg			= &sc8280xp_usb43dp_dp_cfg,
+	.clk_list		= qmp_v4_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(qmp_v4_phy_clk_l),
+	.reset_list		= msm8996_usb3phy_reset_l,
+	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v4_usb3phy_regs_layout,
+	.pcs_usb_offset		= 0x300,
 };
 
-static const struct qmp_phy_cfg sm8250_usb3phy_cfg = {
-	.type			= PHY_TYPE_USB3,
-
+static const struct qmp_phy_cfg sm8250_usb3dpphy_cfg = {
 	.serdes_tbl		= sm8150_usb3_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_serdes_tbl),
 	.tx_tbl			= sm8250_usb3_tx_tbl,
@@ -1242,20 +1191,6 @@ static const struct qmp_phy_cfg sm8250_usb3phy_cfg = {
 	.pcs_tbl_num		= ARRAY_SIZE(sm8250_usb3_pcs_tbl),
 	.pcs_usb_tbl		= sm8250_usb3_pcs_usb_tbl,
 	.pcs_usb_tbl_num	= ARRAY_SIZE(sm8250_usb3_pcs_usb_tbl),
-	.clk_list		= qmp_v4_sm8250_usbphy_clk_l,
-	.num_clks		= ARRAY_SIZE(qmp_v4_sm8250_usbphy_clk_l),
-	.reset_list		= msm8996_usb3phy_reset_l,
-	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
-	.vreg_list		= qmp_phy_vreg_l,
-	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
-	.regs			= qmp_v4_usb3phy_regs_layout,
-	.pcs_usb_offset		= 0x300,
-
-	.has_pwrdn_delay	= true,
-};
-
-static const struct qmp_phy_cfg sm8250_dpphy_cfg = {
-	.type			= PHY_TYPE_DP,
 
 	.dp_serdes_tbl		= qmp_v4_dp_serdes_tbl,
 	.dp_serdes_tbl_num	= ARRAY_SIZE(qmp_v4_dp_serdes_tbl),
@@ -1280,11 +1215,17 @@ static const struct qmp_phy_cfg sm8250_dpphy_cfg = {
 	.configure_dp_tx	= qcom_qmp_v4_phy_configure_dp_tx,
 	.configure_dp_phy	= qcom_qmp_v4_phy_configure_dp_phy,
 	.calibrate_dp_phy	= qcom_qmp_v4_dp_phy_calibrate,
-};
 
-static const struct qmp_phy_combo_cfg sm8250_usb3dpphy_cfg = {
-	.usb_cfg		= &sm8250_usb3phy_cfg,
-	.dp_cfg			= &sm8250_dpphy_cfg,
+	.clk_list		= qmp_v4_sm8250_usbphy_clk_l,
+	.num_clks		= ARRAY_SIZE(qmp_v4_sm8250_usbphy_clk_l),
+	.reset_list		= msm8996_usb3phy_reset_l,
+	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v4_usb3phy_regs_layout,
+	.pcs_usb_offset		= 0x300,
+
+	.has_pwrdn_delay	= true,
 };
 
 static void qmp_combo_configure_lane(void __iomem *base,
@@ -2697,10 +2638,7 @@ static int qmp_combo_probe(struct platform_device *pdev)
 	void __iomem *serdes;
 	void __iomem *usb_serdes;
 	void __iomem *dp_serdes = NULL;
-	const struct qmp_phy_combo_cfg *combo_cfg = NULL;
 	const struct qmp_phy_cfg *cfg = NULL;
-	const struct qmp_phy_cfg *usb_cfg = NULL;
-	const struct qmp_phy_cfg *dp_cfg = NULL;
 	int num, id, expected_phys;
 	int ret;
 
@@ -2711,13 +2649,10 @@ static int qmp_combo_probe(struct platform_device *pdev)
 	qmp->dev = dev;
 	dev_set_drvdata(dev, qmp);
 
-	combo_cfg = of_device_get_match_data(dev);
-	if (!combo_cfg)
+	cfg = of_device_get_match_data(dev);
+	if (!cfg)
 		return -EINVAL;
 
-	usb_cfg = combo_cfg->usb_cfg;
-	cfg = usb_cfg; /* Setup clks and regulators */
-
 	usb_serdes = serdes = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(serdes))
 		return PTR_ERR(serdes);
@@ -2730,7 +2665,6 @@ static int qmp_combo_probe(struct platform_device *pdev)
 	if (IS_ERR(dp_serdes))
 		return PTR_ERR(dp_serdes);
 
-	dp_cfg = combo_cfg->dp_cfg;
 	expected_phys = 2;
 
 	mutex_init(&qmp->phy_mutex);
@@ -2769,7 +2703,6 @@ static int qmp_combo_probe(struct platform_device *pdev)
 	id = 0;
 	for_each_available_child_of_node(dev->of_node, child) {
 		if (of_node_name_eq(child, "dp-phy")) {
-			cfg = dp_cfg;
 			serdes = dp_serdes;
 
 			/* Create per-lane phy */
@@ -2787,7 +2720,6 @@ static int qmp_combo_probe(struct platform_device *pdev)
 				goto err_node_put;
 			}
 		} else if (of_node_name_eq(child, "usb3-phy")) {
-			cfg = usb_cfg;
 			serdes = usb_serdes;
 
 			/* Create per-lane phy */
-- 
2.37.4

