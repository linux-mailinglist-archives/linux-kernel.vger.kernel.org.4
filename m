Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0625BDE84
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiITHj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiITHjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:39:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69D8606BC;
        Tue, 20 Sep 2022 00:39:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EAC4624F4;
        Tue, 20 Sep 2022 07:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E09C4FF16;
        Tue, 20 Sep 2022 07:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663659539;
        bh=xr6/dxBGTfXXLfcmOXWkhvGUoSIv7RHJBfx0JC7hLSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B2/10kf7a0vScK6H7GxgaTKYrA96KJt3mgHPL2oxp14teZDNK/kz1wcTJvgluQUzG
         V80RrbzD1TdJtAPmUUbmhnZe8JWgIe45O0BQpBqD++84yH8iYTML/I6vr5tg8MrFhB
         fIfso7+ontydXAvFzm5XYIJk3EnVARsbhLLWJaDC93tll28lB/SWAFtpY3/btjQtkA
         Vgj+uWE8gRquFZ6SNJFbxlwtiriLBcFDlu35U8U4D2RGmGBe5cXtJzree3yzuXZxkz
         860PcikhYkU6ae0Xs0HnI5KmvODjbTWEXYYVLdJPk9jgBKXqeKVzZ4i1hm/CZJYXDM
         BcmYQaueKNPRQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oaXqQ-0005RP-PZ; Tue, 20 Sep 2022 09:39:02 +0200
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
Subject: [PATCH 17/17] phy: qcom-qmp-combo: drop redundant DP config flag
Date:   Tue, 20 Sep 2022 09:38:26 +0200
Message-Id: <20220920073826.20811-18-johan+linaro@kernel.org>
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

Drop the DP_COM control block flag from the configuration data, which is
set for all combo PHYs and hence no longer needed since the QMP driver
split.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 63 +++++++----------------
 1 file changed, 18 insertions(+), 45 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 417e0fcf1a9f..ad3b0aa22048 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -876,9 +876,6 @@ struct qmp_phy_cfg {
 	int pwrdn_delay_min;
 	int pwrdn_delay_max;
 
-	/* true, if PHY has a separate DP_COM control block */
-	bool has_phy_dp_com_ctrl;
-
 	/* Offset from PCS to PCS_USB region */
 	unsigned int pcs_usb_offset;
 
@@ -1051,8 +1048,6 @@ static const struct qmp_phy_cfg sc7180_usb3phy_cfg = {
 	.has_pwrdn_delay	= true,
 	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
 	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
-
-	.has_phy_dp_com_ctrl	= true,
 };
 
 static const struct qmp_phy_cfg sc7180_dpphy_cfg = {
@@ -1086,8 +1081,6 @@ static const struct qmp_phy_cfg sc7180_dpphy_cfg = {
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= qmp_v3_usb3phy_regs_layout,
 
-	.has_phy_dp_com_ctrl	= true,
-
 	.dp_aux_init = qcom_qmp_v3_phy_dp_aux_init,
 	.configure_dp_tx = qcom_qmp_v3_phy_configure_dp_tx,
 	.configure_dp_phy = qcom_qmp_v3_phy_configure_dp_phy,
@@ -1126,8 +1119,6 @@ static const struct qmp_phy_cfg sdm845_usb3phy_cfg = {
 	.has_pwrdn_delay	= true,
 	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
 	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
-
-	.has_phy_dp_com_ctrl	= true,
 };
 
 static const struct qmp_phy_combo_cfg sdm845_usb3dpphy_cfg = {
@@ -1166,8 +1157,6 @@ static const struct qmp_phy_cfg sm8150_usb3phy_cfg = {
 	.has_pwrdn_delay	= true,
 	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
 	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
-
-	.has_phy_dp_com_ctrl	= true,
 };
 
 static const struct qmp_phy_cfg sc8180x_dpphy_cfg = {
@@ -1201,8 +1190,6 @@ static const struct qmp_phy_cfg sc8180x_dpphy_cfg = {
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= qmp_v3_usb3phy_regs_layout,
 
-	.has_phy_dp_com_ctrl	= true,
-
 	.dp_aux_init = qcom_qmp_v4_phy_dp_aux_init,
 	.configure_dp_tx = qcom_qmp_v4_phy_configure_dp_tx,
 	.configure_dp_phy = qcom_qmp_v4_phy_configure_dp_phy,
@@ -1242,8 +1229,6 @@ static const struct qmp_phy_cfg sc8280xp_usb43dp_usb_cfg = {
 	.has_pwrdn_delay	= true,
 	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
 	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
-
-	.has_phy_dp_com_ctrl	= true,
 };
 
 static const struct qmp_phy_cfg sc8280xp_usb43dp_dp_cfg = {
@@ -1277,8 +1262,6 @@ static const struct qmp_phy_cfg sc8280xp_usb43dp_dp_cfg = {
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= qmp_v4_usb3phy_regs_layout,
 
-	.has_phy_dp_com_ctrl	= true,
-
 	.dp_aux_init = qcom_qmp_v4_phy_dp_aux_init,
 	.configure_dp_tx = qcom_qmp_v4_phy_configure_dp_tx,
 	.configure_dp_phy = qcom_qmp_v5_phy_configure_dp_phy,
@@ -1320,8 +1303,6 @@ static const struct qmp_phy_cfg sm8250_usb3phy_cfg = {
 	.has_pwrdn_delay	= true,
 	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
 	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
-
-	.has_phy_dp_com_ctrl	= true,
 };
 
 static const struct qmp_phy_cfg sm8250_dpphy_cfg = {
@@ -1355,8 +1336,6 @@ static const struct qmp_phy_cfg sm8250_dpphy_cfg = {
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= qmp_v4_usb3phy_regs_layout,
 
-	.has_phy_dp_com_ctrl	= true,
-
 	.dp_aux_init = qcom_qmp_v4_phy_dp_aux_init,
 	.configure_dp_tx = qcom_qmp_v4_phy_configure_dp_tx,
 	.configure_dp_phy = qcom_qmp_v4_phy_configure_dp_phy,
@@ -1995,28 +1974,25 @@ static int qmp_combo_com_init(struct qmp_phy *qphy)
 	if (ret)
 		goto err_assert_reset;
 
-	if (cfg->has_phy_dp_com_ctrl) {
-		qphy_setbits(dp_com, QPHY_V3_DP_COM_POWER_DOWN_CTRL,
-			     SW_PWRDN);
-		/* override hardware control for reset of qmp phy */
-		qphy_setbits(dp_com, QPHY_V3_DP_COM_RESET_OVRD_CTRL,
-			     SW_DPPHY_RESET_MUX | SW_DPPHY_RESET |
-			     SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
+	qphy_setbits(dp_com, QPHY_V3_DP_COM_POWER_DOWN_CTRL, SW_PWRDN);
 
-		/* Default type-c orientation, i.e CC1 */
-		qphy_setbits(dp_com, QPHY_V3_DP_COM_TYPEC_CTRL, 0x02);
+	/* override hardware control for reset of qmp phy */
+	qphy_setbits(dp_com, QPHY_V3_DP_COM_RESET_OVRD_CTRL,
+			SW_DPPHY_RESET_MUX | SW_DPPHY_RESET |
+			SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
 
-		qphy_setbits(dp_com, QPHY_V3_DP_COM_PHY_MODE_CTRL,
-			     USB3_MODE | DP_MODE);
+	/* Default type-c orientation, i.e CC1 */
+	qphy_setbits(dp_com, QPHY_V3_DP_COM_TYPEC_CTRL, 0x02);
 
-		/* bring both QMP USB and QMP DP PHYs PCS block out of reset */
-		qphy_clrbits(dp_com, QPHY_V3_DP_COM_RESET_OVRD_CTRL,
-			     SW_DPPHY_RESET_MUX | SW_DPPHY_RESET |
-			     SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
+	qphy_setbits(dp_com, QPHY_V3_DP_COM_PHY_MODE_CTRL, USB3_MODE | DP_MODE);
 
-		qphy_clrbits(dp_com, QPHY_V3_DP_COM_SWI_CTRL, 0x03);
-		qphy_clrbits(dp_com, QPHY_V3_DP_COM_SW_RESET, SW_RESET);
-	}
+	/* bring both QMP USB and QMP DP PHYs PCS block out of reset */
+	qphy_clrbits(dp_com, QPHY_V3_DP_COM_RESET_OVRD_CTRL,
+			SW_DPPHY_RESET_MUX | SW_DPPHY_RESET |
+			SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
+
+	qphy_clrbits(dp_com, QPHY_V3_DP_COM_SWI_CTRL, 0x03);
+	qphy_clrbits(dp_com, QPHY_V3_DP_COM_SW_RESET, SW_RESET);
 
 	if (cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL])
 		qphy_setbits(pcs,
@@ -2838,12 +2814,9 @@ static int qmp_combo_probe(struct platform_device *pdev)
 	if (IS_ERR(serdes))
 		return PTR_ERR(serdes);
 
-	/* per PHY dp_com; if PHY has dp_com control block */
-	if (cfg->has_phy_dp_com_ctrl) {
-		qmp->dp_com = devm_platform_ioremap_resource(pdev, 1);
-		if (IS_ERR(qmp->dp_com))
-			return PTR_ERR(qmp->dp_com);
-	}
+	qmp->dp_com = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(qmp->dp_com))
+		return PTR_ERR(qmp->dp_com);
 
 	/* Only two serdes for combo PHY */
 	dp_serdes = devm_platform_ioremap_resource(pdev, 2);
-- 
2.35.1

