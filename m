Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9346255FB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbiKKI6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiKKI50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:57:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6823E7B216;
        Fri, 11 Nov 2022 00:57:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C47F561F00;
        Fri, 11 Nov 2022 08:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7130EC4FF6F;
        Fri, 11 Nov 2022 08:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668157044;
        bh=tzzv/2IUf51zIndxEGFdxmR/cOQZxXaH04+b5SHvS30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rA8F1HOe9h4H4WtOqZz+7x3xJTVGdHXdY4gP2FhyTA4vJKHKtNCqg7dUixWobMJWZ
         t+XrcMf507HnNUzPnf6551GsXpkqmb9CWk25LhSZTu4Yn9qZaaUcvl3DIMmuFWoYn2
         sY4I23mm4cQI55CQA8s2tZy3sV7BwU5t30kHEjaV0Ogky0nNvcrEdLuQDLKawDgu/e
         2zYYO45tcaHjyWebKknbQdFUxb/q2+WaA53UnDjlPnww+TWVDjthOZBD/SIx5GWWSB
         WuYWeuqq5UmePAvRWbMUtKep94RQ6MJ3pwT2/LTiGx7wM7GAP3DBAq/tc2vE1VaZFq
         XJSPoxKLUAZug==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1otPqK-0002Up-PC; Fri, 11 Nov 2022 09:56:56 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 22/22] phy: qcom-qmp-combo: clean up DP callback names
Date:   Fri, 11 Nov 2022 09:56:43 +0100
Message-Id: <20221111085643.9478-23-johan+linaro@kernel.org>
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

Clean up and unify the DP callbacks by dropping the redundant "qcom" and
"phy" prefix and infix and by using a common naming scheme ("qmp" +
version + callback name).

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 82 +++++++++++------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 6d98d37f8562..51a03ac05c91 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -905,17 +905,17 @@ struct qmp_combo {
 	struct qmp_phy_dp_clks *dp_clks;
 };
 
-static void qcom_qmp_v3_phy_dp_aux_init(struct qmp_combo *qmp);
-static void qcom_qmp_v3_phy_configure_dp_tx(struct qmp_combo *qmp);
-static int qcom_qmp_v3_phy_configure_dp_phy(struct qmp_combo *qmp);
-static int qcom_qmp_v3_dp_phy_calibrate(struct qmp_combo *qmp);
+static void qmp_v3_dp_aux_init(struct qmp_combo *qmp);
+static void qmp_v3_configure_dp_tx(struct qmp_combo *qmp);
+static int qmp_v3_configure_dp_phy(struct qmp_combo *qmp);
+static int qmp_v3_calibrate_dp_phy(struct qmp_combo *qmp);
 
-static void qcom_qmp_v4_phy_dp_aux_init(struct qmp_combo *qmp);
-static void qcom_qmp_v4_phy_configure_dp_tx(struct qmp_combo *qmp);
-static int qcom_qmp_v4_phy_configure_dp_phy(struct qmp_combo *qmp);
-static int qcom_qmp_v4_dp_phy_calibrate(struct qmp_combo *qmp);
+static void qmp_v4_dp_aux_init(struct qmp_combo *qmp);
+static void qmp_v4_configure_dp_tx(struct qmp_combo *qmp);
+static int qmp_v4_configure_dp_phy(struct qmp_combo *qmp);
+static int qmp_v4_calibrate_dp_phy(struct qmp_combo *qmp);
 
-static int qcom_qmp_v5_phy_configure_dp_phy(struct qmp_combo *qmp);
+static int qmp_v5_configure_dp_phy(struct qmp_combo *qmp);
 
 static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
 {
@@ -995,10 +995,10 @@ static const struct qmp_phy_cfg sc7180_usb3dpphy_cfg = {
 	.swing_hbr3_hbr2	= &qmp_dp_v3_voltage_swing_hbr3_hbr2,
 	.pre_emphasis_hbr3_hbr2 = &qmp_dp_v3_pre_emphasis_hbr3_hbr2,
 
-	.dp_aux_init		= qcom_qmp_v3_phy_dp_aux_init,
-	.configure_dp_tx	= qcom_qmp_v3_phy_configure_dp_tx,
-	.configure_dp_phy	= qcom_qmp_v3_phy_configure_dp_phy,
-	.calibrate_dp_phy	= qcom_qmp_v3_dp_phy_calibrate,
+	.dp_aux_init		= qmp_v3_dp_aux_init,
+	.configure_dp_tx	= qmp_v3_configure_dp_tx,
+	.configure_dp_phy	= qmp_v3_configure_dp_phy,
+	.calibrate_dp_phy	= qmp_v3_calibrate_dp_phy,
 
 	.clk_list		= qmp_v3_phy_clk_l,
 	.num_clks		= ARRAY_SIZE(qmp_v3_phy_clk_l),
@@ -1042,10 +1042,10 @@ static const struct qmp_phy_cfg sdm845_usb3dpphy_cfg = {
 	.swing_hbr3_hbr2	= &qmp_dp_v3_voltage_swing_hbr3_hbr2,
 	.pre_emphasis_hbr3_hbr2 = &qmp_dp_v3_pre_emphasis_hbr3_hbr2,
 
-	.dp_aux_init		= qcom_qmp_v3_phy_dp_aux_init,
-	.configure_dp_tx	= qcom_qmp_v3_phy_configure_dp_tx,
-	.configure_dp_phy	= qcom_qmp_v3_phy_configure_dp_phy,
-	.calibrate_dp_phy	= qcom_qmp_v3_dp_phy_calibrate,
+	.dp_aux_init		= qmp_v3_dp_aux_init,
+	.configure_dp_tx	= qmp_v3_configure_dp_tx,
+	.configure_dp_phy	= qmp_v3_configure_dp_phy,
+	.calibrate_dp_phy	= qmp_v3_calibrate_dp_phy,
 
 	.clk_list		= qmp_v3_phy_clk_l,
 	.num_clks		= ARRAY_SIZE(qmp_v3_phy_clk_l),
@@ -1090,10 +1090,10 @@ static const struct qmp_phy_cfg sc8180x_usb3dpphy_cfg = {
 	.swing_hbr3_hbr2	= &qmp_dp_v3_voltage_swing_hbr3_hbr2,
 	.pre_emphasis_hbr3_hbr2 = &qmp_dp_v3_pre_emphasis_hbr3_hbr2,
 
-	.dp_aux_init		= qcom_qmp_v4_phy_dp_aux_init,
-	.configure_dp_tx	= qcom_qmp_v4_phy_configure_dp_tx,
-	.configure_dp_phy	= qcom_qmp_v4_phy_configure_dp_phy,
-	.calibrate_dp_phy	= qcom_qmp_v4_dp_phy_calibrate,
+	.dp_aux_init		= qmp_v4_dp_aux_init,
+	.configure_dp_tx	= qmp_v4_configure_dp_tx,
+	.configure_dp_phy	= qmp_v4_configure_dp_phy,
+	.calibrate_dp_phy	= qmp_v4_calibrate_dp_phy,
 
 	.clk_list		= qmp_v4_phy_clk_l,
 	.num_clks		= ARRAY_SIZE(qmp_v4_phy_clk_l),
@@ -1138,10 +1138,10 @@ static const struct qmp_phy_cfg sc8280xp_usb43dpphy_cfg = {
 	.swing_hbr3_hbr2	= &qmp_dp_v5_voltage_swing_hbr3_hbr2,
 	.pre_emphasis_hbr3_hbr2 = &qmp_dp_v5_pre_emphasis_hbr3_hbr2,
 
-	.dp_aux_init		= qcom_qmp_v4_phy_dp_aux_init,
-	.configure_dp_tx	= qcom_qmp_v4_phy_configure_dp_tx,
-	.configure_dp_phy	= qcom_qmp_v5_phy_configure_dp_phy,
-	.calibrate_dp_phy	= qcom_qmp_v4_dp_phy_calibrate,
+	.dp_aux_init		= qmp_v4_dp_aux_init,
+	.configure_dp_tx	= qmp_v4_configure_dp_tx,
+	.configure_dp_phy	= qmp_v5_configure_dp_phy,
+	.calibrate_dp_phy	= qmp_v4_calibrate_dp_phy,
 
 	.clk_list		= qmp_v4_phy_clk_l,
 	.num_clks		= ARRAY_SIZE(qmp_v4_phy_clk_l),
@@ -1186,10 +1186,10 @@ static const struct qmp_phy_cfg sm8250_usb3dpphy_cfg = {
 	.swing_hbr3_hbr2	= &qmp_dp_v3_voltage_swing_hbr3_hbr2,
 	.pre_emphasis_hbr3_hbr2 = &qmp_dp_v3_pre_emphasis_hbr3_hbr2,
 
-	.dp_aux_init		= qcom_qmp_v4_phy_dp_aux_init,
-	.configure_dp_tx	= qcom_qmp_v4_phy_configure_dp_tx,
-	.configure_dp_phy	= qcom_qmp_v4_phy_configure_dp_phy,
-	.calibrate_dp_phy	= qcom_qmp_v4_dp_phy_calibrate,
+	.dp_aux_init		= qmp_v4_dp_aux_init,
+	.configure_dp_tx	= qmp_v4_configure_dp_tx,
+	.configure_dp_phy	= qmp_v4_configure_dp_phy,
+	.calibrate_dp_phy	= qmp_v4_calibrate_dp_phy,
 
 	.clk_list		= qmp_v4_sm8250_usbphy_clk_l,
 	.num_clks		= ARRAY_SIZE(qmp_v4_sm8250_usbphy_clk_l),
@@ -1262,7 +1262,7 @@ static int qmp_combo_dp_serdes_init(struct qmp_combo *qmp)
 	return 0;
 }
 
-static void qcom_qmp_v3_phy_dp_aux_init(struct qmp_combo *qmp)
+static void qmp_v3_dp_aux_init(struct qmp_combo *qmp)
 {
 	writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
 	       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
@@ -1343,7 +1343,7 @@ static int qmp_combo_configure_dp_swing(struct qmp_combo *qmp,
 	return 0;
 }
 
-static void qcom_qmp_v3_phy_configure_dp_tx(struct qmp_combo *qmp)
+static void qmp_v3_configure_dp_tx(struct qmp_combo *qmp)
 {
 	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
 	u32 bias_en, drvr_en;
@@ -1396,7 +1396,7 @@ static bool qmp_combo_configure_dp_mode(struct qmp_combo *qmp)
 	return reverse;
 }
 
-static int qcom_qmp_v3_phy_configure_dp_phy(struct qmp_combo *qmp)
+static int qmp_v3_configure_dp_phy(struct qmp_combo *qmp)
 {
 	const struct qmp_phy_dp_clks *dp_clks = qmp->dp_clks;
 	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
@@ -1473,7 +1473,7 @@ static int qcom_qmp_v3_phy_configure_dp_phy(struct qmp_combo *qmp)
  * We need to calibrate the aux setting here as many times
  * as the caller tries
  */
-static int qcom_qmp_v3_dp_phy_calibrate(struct qmp_combo *qmp)
+static int qmp_v3_calibrate_dp_phy(struct qmp_combo *qmp)
 {
 	static const u8 cfg1_settings[] = { 0x13, 0x23, 0x1d };
 	u8 val;
@@ -1487,7 +1487,7 @@ static int qcom_qmp_v3_dp_phy_calibrate(struct qmp_combo *qmp)
 	return 0;
 }
 
-static void qcom_qmp_v4_phy_dp_aux_init(struct qmp_combo *qmp)
+static void qmp_v4_dp_aux_init(struct qmp_combo *qmp)
 {
 	writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_PSR_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
 	       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
@@ -1514,7 +1514,7 @@ static void qcom_qmp_v4_phy_dp_aux_init(struct qmp_combo *qmp)
 	       qmp->dp_pcs + QSERDES_V4_DP_PHY_AUX_INTERRUPT_MASK);
 }
 
-static void qcom_qmp_v4_phy_configure_dp_tx(struct qmp_combo *qmp)
+static void qmp_v4_configure_dp_tx(struct qmp_combo *qmp)
 {
 	/* Program default values before writing proper values */
 	writel(0x27, qmp->dp_tx + QSERDES_V4_TX_TX_DRV_LVL);
@@ -1527,7 +1527,7 @@ static void qcom_qmp_v4_phy_configure_dp_tx(struct qmp_combo *qmp)
 			QSERDES_V4_TX_TX_EMP_POST1_LVL);
 }
 
-static int qcom_qmp_v45_phy_configure_dp_phy(struct qmp_combo *qmp)
+static int qmp_v45_configure_dp_phy(struct qmp_combo *qmp)
 {
 	const struct qmp_phy_dp_clks *dp_clks = qmp->dp_clks;
 	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
@@ -1617,7 +1617,7 @@ static int qcom_qmp_v45_phy_configure_dp_phy(struct qmp_combo *qmp)
 	return 0;
 }
 
-static int qcom_qmp_v4_phy_configure_dp_phy(struct qmp_combo *qmp)
+static int qmp_v4_configure_dp_phy(struct qmp_combo *qmp)
 {
 	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
 	u32 bias0_en, drvr0_en, bias1_en, drvr1_en;
@@ -1625,7 +1625,7 @@ static int qcom_qmp_v4_phy_configure_dp_phy(struct qmp_combo *qmp)
 	u32 status;
 	int ret;
 
-	ret = qcom_qmp_v45_phy_configure_dp_phy(qmp);
+	ret = qmp_v45_configure_dp_phy(qmp);
 	if (ret < 0)
 		return ret;
 
@@ -1679,7 +1679,7 @@ static int qcom_qmp_v4_phy_configure_dp_phy(struct qmp_combo *qmp)
 	return 0;
 }
 
-static int qcom_qmp_v5_phy_configure_dp_phy(struct qmp_combo *qmp)
+static int qmp_v5_configure_dp_phy(struct qmp_combo *qmp)
 {
 	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
 	u32 bias0_en, drvr0_en, bias1_en, drvr1_en;
@@ -1687,7 +1687,7 @@ static int qcom_qmp_v5_phy_configure_dp_phy(struct qmp_combo *qmp)
 	u32 status;
 	int ret;
 
-	ret = qcom_qmp_v45_phy_configure_dp_phy(qmp);
+	ret = qmp_v45_configure_dp_phy(qmp);
 	if (ret < 0)
 		return ret;
 
@@ -1740,7 +1740,7 @@ static int qcom_qmp_v5_phy_configure_dp_phy(struct qmp_combo *qmp)
  * We need to calibrate the aux setting here as many times
  * as the caller tries
  */
-static int qcom_qmp_v4_dp_phy_calibrate(struct qmp_combo *qmp)
+static int qmp_v4_calibrate_dp_phy(struct qmp_combo *qmp)
 {
 	static const u8 cfg1_settings[] = { 0x20, 0x13, 0x23, 0x1d };
 	u8 val;
-- 
2.37.4

