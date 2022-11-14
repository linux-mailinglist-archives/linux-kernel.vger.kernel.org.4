Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D9C627BB5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236453AbiKNLJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbiKNLH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:07:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2D52127A;
        Mon, 14 Nov 2022 03:07:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D8A8B80DEF;
        Mon, 14 Nov 2022 11:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D820C4FF13;
        Mon, 14 Nov 2022 11:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668424034;
        bh=xt745uTqHatKVJPFGtD2kfbW2fvcSdzeqVyp5Wsb3G4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=THLWs57FKaZFiMBncC6FQ973xoTZ2ac5vM/mUvQpFJYTAw5lNkRO+6w1UVcGDREYU
         eap8L8fKnIc+AeccTBjfpnE7smxigbCpq+stiThGoXrHVcY3tYvuA6ARHzBdo0kEp/
         LuiUloDVaVuRyUAI5HwVLv/b2gAOs0vhhQJe/9RuBzG+v6R/94igOepvOERY5OYuvk
         sCuPcS3w/wfhdQbV/HZN8vk8EGp9HJtPygFcIzENDw/gYdUL+8KAdj6A7dwVpc1FFf
         86uoMjD9nO2CUgIbasCvZGiV2P0DY7QySfEuAKqoazKD9UluALN1RhufVSnlaXdLD6
         PMKFJW8G09/EQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ouXIY-0001F3-Ub; Mon, 14 Nov 2022 12:06:42 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 14/22] phy: qcom-qmp-combo: clean up DP configurations
Date:   Mon, 14 Nov 2022 12:06:13 +0100
Message-Id: <20221114110621.4639-15-johan+linaro@kernel.org>
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

In preparation for merging the USB and DP configurations, align the
initialisations of the DP function pointers.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 40 +++++++++++------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 43193bfe6e11..50c011d23a9e 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -1049,10 +1049,10 @@ static const struct qmp_phy_cfg sc7180_dpphy_cfg = {
 	.swing_hbr3_hbr2	= &qmp_dp_v3_voltage_swing_hbr3_hbr2,
 	.pre_emphasis_hbr3_hbr2 = &qmp_dp_v3_pre_emphasis_hbr3_hbr2,
 
-	.dp_aux_init = qcom_qmp_v3_phy_dp_aux_init,
-	.configure_dp_tx = qcom_qmp_v3_phy_configure_dp_tx,
-	.configure_dp_phy = qcom_qmp_v3_phy_configure_dp_phy,
-	.calibrate_dp_phy = qcom_qmp_v3_dp_phy_calibrate,
+	.dp_aux_init		= qcom_qmp_v3_phy_dp_aux_init,
+	.configure_dp_tx	= qcom_qmp_v3_phy_configure_dp_tx,
+	.configure_dp_phy	= qcom_qmp_v3_phy_configure_dp_phy,
+	.calibrate_dp_phy	= qcom_qmp_v3_dp_phy_calibrate,
 };
 
 static const struct qmp_phy_combo_cfg sc7180_usb3dpphy_cfg = {
@@ -1106,10 +1106,10 @@ static const struct qmp_phy_cfg sdm845_dpphy_cfg = {
 	.swing_hbr3_hbr2	= &qmp_dp_v3_voltage_swing_hbr3_hbr2,
 	.pre_emphasis_hbr3_hbr2 = &qmp_dp_v3_pre_emphasis_hbr3_hbr2,
 
-	.dp_aux_init = qcom_qmp_v3_phy_dp_aux_init,
-	.configure_dp_tx = qcom_qmp_v3_phy_configure_dp_tx,
-	.configure_dp_phy = qcom_qmp_v3_phy_configure_dp_phy,
-	.calibrate_dp_phy = qcom_qmp_v3_dp_phy_calibrate,
+	.dp_aux_init		= qcom_qmp_v3_phy_dp_aux_init,
+	.configure_dp_tx	= qcom_qmp_v3_phy_configure_dp_tx,
+	.configure_dp_phy	= qcom_qmp_v3_phy_configure_dp_phy,
+	.calibrate_dp_phy	= qcom_qmp_v3_dp_phy_calibrate,
 };
 
 static const struct qmp_phy_combo_cfg sdm845_usb3dpphy_cfg = {
@@ -1166,10 +1166,10 @@ static const struct qmp_phy_cfg sc8180x_dpphy_cfg = {
 	.swing_hbr3_hbr2	= &qmp_dp_v3_voltage_swing_hbr3_hbr2,
 	.pre_emphasis_hbr3_hbr2 = &qmp_dp_v3_pre_emphasis_hbr3_hbr2,
 
-	.dp_aux_init = qcom_qmp_v4_phy_dp_aux_init,
-	.configure_dp_tx = qcom_qmp_v4_phy_configure_dp_tx,
-	.configure_dp_phy = qcom_qmp_v4_phy_configure_dp_phy,
-	.calibrate_dp_phy = qcom_qmp_v4_dp_phy_calibrate,
+	.dp_aux_init		= qcom_qmp_v4_phy_dp_aux_init,
+	.configure_dp_tx	= qcom_qmp_v4_phy_configure_dp_tx,
+	.configure_dp_phy	= qcom_qmp_v4_phy_configure_dp_phy,
+	.calibrate_dp_phy	= qcom_qmp_v4_dp_phy_calibrate,
 };
 
 static const struct qmp_phy_combo_cfg sc8180x_usb3dpphy_cfg = {
@@ -1222,10 +1222,10 @@ static const struct qmp_phy_cfg sc8280xp_usb43dp_dp_cfg = {
 	.swing_hbr3_hbr2	= &qmp_dp_v5_voltage_swing_hbr3_hbr2,
 	.pre_emphasis_hbr3_hbr2 = &qmp_dp_v5_pre_emphasis_hbr3_hbr2,
 
-	.dp_aux_init = qcom_qmp_v4_phy_dp_aux_init,
-	.configure_dp_tx = qcom_qmp_v4_phy_configure_dp_tx,
-	.configure_dp_phy = qcom_qmp_v5_phy_configure_dp_phy,
-	.calibrate_dp_phy = qcom_qmp_v4_dp_phy_calibrate,
+	.dp_aux_init		= qcom_qmp_v4_phy_dp_aux_init,
+	.configure_dp_tx	= qcom_qmp_v4_phy_configure_dp_tx,
+	.configure_dp_phy	= qcom_qmp_v5_phy_configure_dp_phy,
+	.calibrate_dp_phy	= qcom_qmp_v4_dp_phy_calibrate,
 };
 
 static const struct qmp_phy_combo_cfg sc8280xp_usb43dpphy_combo_cfg = {
@@ -1282,10 +1282,10 @@ static const struct qmp_phy_cfg sm8250_dpphy_cfg = {
 	.swing_hbr3_hbr2	= &qmp_dp_v3_voltage_swing_hbr3_hbr2,
 	.pre_emphasis_hbr3_hbr2 = &qmp_dp_v3_pre_emphasis_hbr3_hbr2,
 
-	.dp_aux_init = qcom_qmp_v4_phy_dp_aux_init,
-	.configure_dp_tx = qcom_qmp_v4_phy_configure_dp_tx,
-	.configure_dp_phy = qcom_qmp_v4_phy_configure_dp_phy,
-	.calibrate_dp_phy = qcom_qmp_v4_dp_phy_calibrate,
+	.dp_aux_init		= qcom_qmp_v4_phy_dp_aux_init,
+	.configure_dp_tx	= qcom_qmp_v4_phy_configure_dp_tx,
+	.configure_dp_phy	= qcom_qmp_v4_phy_configure_dp_phy,
+	.calibrate_dp_phy	= qcom_qmp_v4_dp_phy_calibrate,
 };
 
 static const struct qmp_phy_combo_cfg sm8250_usb3dpphy_cfg = {
-- 
2.37.4

