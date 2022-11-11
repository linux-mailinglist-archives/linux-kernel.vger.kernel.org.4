Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F004D6255A1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiKKIpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbiKKIo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:44:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7C67C8EC;
        Fri, 11 Nov 2022 00:44:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25A3561EF8;
        Fri, 11 Nov 2022 08:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC23C4315C;
        Fri, 11 Nov 2022 08:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668156294;
        bh=GOkeZXFvRBATroumnNo6PXdgXEhOj5gelgwu1q1W47o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lRyqQOTcF+8h8LwiUSVFsFjk6qdhxCBaWBdcXxBCnWRRzz3ph156sR22WeYcTMctR
         VrChpFQxxNnhvJeF/LgudRQSeuszZlF2Fq6w5St2nSBllP9mde3ne2c+7Q0uRIaB3D
         idBbDRotJeh4tZJYbEwLytkQYZVZW6AM5laDdW4yOwQh3mFXrtzSJPi8kZPsTWhsYk
         yw2d5Nzq0wiqHiLW6WhH2SoSxuTkWEuCq+2BSq/3e2PMpq+dBDihpOeJe3EAdLheY/
         L6sOllLuwSh6FxUc+/WVo4SoeArxDCeVviXdYXDoa9iSTbCBwCN5JEOH9mTDFuCpcC
         qABcZsDH99q7A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1otPeE-0002Mx-0F; Fri, 11 Nov 2022 09:44:26 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 6/6] phy: qcom-qmp-combo: clean up common initialisation
Date:   Fri, 11 Nov 2022 09:42:55 +0100
Message-Id: <20221111084255.8963-7-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221111084255.8963-1-johan+linaro@kernel.org>
References: <20221111084255.8963-1-johan+linaro@kernel.org>
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

Commit 52e013d0bffa ("phy: qcom-qmp: Add support for DP in USB3+DP combo
phy") added support for the DisplayPort part of QMP PHYs but
unfortunately did so by duplicating parts of the shared configuration,
something which has lead to subtle bugs depending on probe order.

As the resources have always been requested based on the USB
configuration, make sure to not rely on fields from the DP configuration
when using them (e.g. in case they get out of sync) and remove the now
unused fields from the DP configurations.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 47 ++---------------------
 1 file changed, 4 insertions(+), 43 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index fde30205f332..c7a926d548d8 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -1043,14 +1043,6 @@ static const struct qmp_phy_cfg sc7180_dpphy_cfg = {
 	.swing_hbr3_hbr2	= &qmp_dp_v3_voltage_swing_hbr3_hbr2,
 	.pre_emphasis_hbr3_hbr2 = &qmp_dp_v3_pre_emphasis_hbr3_hbr2,
 
-	.clk_list		= qmp_v3_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(qmp_v3_phy_clk_l),
-	.reset_list		= sc7180_usb3phy_reset_l,
-	.num_resets		= ARRAY_SIZE(sc7180_usb3phy_reset_l),
-	.vreg_list		= qmp_phy_vreg_l,
-	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
-	.regs			= qmp_v3_usb3phy_regs_layout,
-
 	.dp_aux_init = qcom_qmp_v3_phy_dp_aux_init,
 	.configure_dp_tx = qcom_qmp_v3_phy_configure_dp_tx,
 	.configure_dp_phy = qcom_qmp_v3_phy_configure_dp_phy,
@@ -1108,14 +1100,6 @@ static const struct qmp_phy_cfg sdm845_dpphy_cfg = {
 	.swing_hbr3_hbr2	= &qmp_dp_v3_voltage_swing_hbr3_hbr2,
 	.pre_emphasis_hbr3_hbr2 = &qmp_dp_v3_pre_emphasis_hbr3_hbr2,
 
-	.clk_list		= qmp_v3_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(qmp_v3_phy_clk_l),
-	.reset_list		= msm8996_usb3phy_reset_l,
-	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
-	.vreg_list		= qmp_phy_vreg_l,
-	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
-	.regs			= qmp_v3_usb3phy_regs_layout,
-
 	.dp_aux_init = qcom_qmp_v3_phy_dp_aux_init,
 	.configure_dp_tx = qcom_qmp_v3_phy_configure_dp_tx,
 	.configure_dp_phy = qcom_qmp_v3_phy_configure_dp_phy,
@@ -1176,14 +1160,6 @@ static const struct qmp_phy_cfg sc8180x_dpphy_cfg = {
 	.swing_hbr3_hbr2	= &qmp_dp_v3_voltage_swing_hbr3_hbr2,
 	.pre_emphasis_hbr3_hbr2 = &qmp_dp_v3_pre_emphasis_hbr3_hbr2,
 
-	.clk_list		= qmp_v3_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(qmp_v3_phy_clk_l),
-	.reset_list		= msm8996_usb3phy_reset_l,
-	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
-	.vreg_list		= qmp_phy_vreg_l,
-	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
-	.regs			= qmp_v3_usb3phy_regs_layout,
-
 	.dp_aux_init = qcom_qmp_v4_phy_dp_aux_init,
 	.configure_dp_tx = qcom_qmp_v4_phy_configure_dp_tx,
 	.configure_dp_phy = qcom_qmp_v4_phy_configure_dp_phy,
@@ -1240,14 +1216,6 @@ static const struct qmp_phy_cfg sc8280xp_usb43dp_dp_cfg = {
 	.swing_hbr3_hbr2	= &qmp_dp_v5_voltage_swing_hbr3_hbr2,
 	.pre_emphasis_hbr3_hbr2 = &qmp_dp_v5_pre_emphasis_hbr3_hbr2,
 
-	.clk_list		= qmp_v4_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(qmp_v4_phy_clk_l),
-	.reset_list		= msm8996_usb3phy_reset_l,
-	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
-	.vreg_list		= qmp_phy_vreg_l,
-	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
-	.regs			= qmp_v4_usb3phy_regs_layout,
-
 	.dp_aux_init = qcom_qmp_v4_phy_dp_aux_init,
 	.configure_dp_tx = qcom_qmp_v4_phy_configure_dp_tx,
 	.configure_dp_phy = qcom_qmp_v5_phy_configure_dp_phy,
@@ -1308,14 +1276,6 @@ static const struct qmp_phy_cfg sm8250_dpphy_cfg = {
 	.swing_hbr3_hbr2	= &qmp_dp_v3_voltage_swing_hbr3_hbr2,
 	.pre_emphasis_hbr3_hbr2 = &qmp_dp_v3_pre_emphasis_hbr3_hbr2,
 
-	.clk_list		= qmp_v4_sm8250_usbphy_clk_l,
-	.num_clks		= ARRAY_SIZE(qmp_v4_sm8250_usbphy_clk_l),
-	.reset_list		= msm8996_usb3phy_reset_l,
-	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
-	.vreg_list		= qmp_phy_vreg_l,
-	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
-	.regs			= qmp_v4_usb3phy_regs_layout,
-
 	.dp_aux_init = qcom_qmp_v4_phy_dp_aux_init,
 	.configure_dp_tx = qcom_qmp_v4_phy_configure_dp_tx,
 	.configure_dp_phy = qcom_qmp_v4_phy_configure_dp_phy,
@@ -1911,8 +1871,8 @@ static int qcom_qmp_dp_phy_calibrate(struct phy *phy)
 static int qmp_combo_com_init(struct qmp_phy *qphy)
 {
 	struct qcom_qmp *qmp = qphy->qmp;
-	const struct qmp_phy_cfg *cfg = qphy->cfg;
 	struct qmp_phy *usb_phy = qmp->usb_phy;
+	const struct qmp_phy_cfg *cfg = usb_phy->cfg;
 	void __iomem *dp_com = qmp->dp_com;
 	int ret;
 
@@ -1964,7 +1924,7 @@ static int qmp_combo_com_init(struct qmp_phy *qphy)
 	qphy_clrbits(dp_com, QPHY_V3_DP_COM_SWI_CTRL, 0x03);
 	qphy_clrbits(dp_com, QPHY_V3_DP_COM_SW_RESET, SW_RESET);
 
-	qphy_setbits(usb_phy->pcs, usb_phy->cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
+	qphy_setbits(usb_phy->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
 			SW_PWRDN);
 
 	mutex_unlock(&qmp->phy_mutex);
@@ -1984,7 +1944,8 @@ static int qmp_combo_com_init(struct qmp_phy *qphy)
 static int qmp_combo_com_exit(struct qmp_phy *qphy)
 {
 	struct qcom_qmp *qmp = qphy->qmp;
-	const struct qmp_phy_cfg *cfg = qphy->cfg;
+	struct qmp_phy *usb_phy = qmp->usb_phy;
+	const struct qmp_phy_cfg *cfg = usb_phy->cfg;
 
 	mutex_lock(&qmp->phy_mutex);
 	if (--qmp->init_count) {
-- 
2.37.4

