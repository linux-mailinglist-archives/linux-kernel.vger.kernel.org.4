Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9285A654263
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbiLVOKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbiLVOKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:10:23 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC842B257
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:10:20 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id u4-20020a17090a518400b00223f7eba2c4so1961355pjh.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cc7r9O2TO3pF/bzpTzvG4eE42PWinenWOWxZc+pKlHA=;
        b=evQOTlT+ScdTzw7R0+cnw30Kh4LVQVb71IGJvJANVBN1kZNocX8LcwnbqIiV/KPTgl
         Y7gD3vZkqzAtHGfjj306ruMQFxWVMmX++xXspCl9y6sJdNDHKp8PUD9QPVrXN5JhKg6F
         PKILgrk+0Ux3/NYIGVnceyLfbMaTjp2JzYhEtd1knXZWW0u4F11nahLQKowKzAJM0qqE
         ZyYkYoBhCEJOH6Rrhqlf53q0KRVT8Mmw/CQOesTDplKV2/v+OZggjH+qlvktQrNi6LVi
         yJokU9WSql4qWt03hz8YdiLvi5xOPdS/D9Nu/t0sJ/3ChZHge1Px9m0NsQNoc9+p2uTf
         TM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cc7r9O2TO3pF/bzpTzvG4eE42PWinenWOWxZc+pKlHA=;
        b=UDFlTRVq7hAW1rWgtstuyQugxNz3+9VnOl85Z8FImPi53tAxB9BuuFePSU4MXtBhFB
         0PXtTVt2SkZXc8pH5IOu9dEhZZkUpVWbe3cM456hyZn+xCZHfYNnRW6XeFyUzQUZd6/1
         vnmo7ialQbfNDf/1kUKp7cT79HwJJq3vog1oRL9+6HrHJcf+b4HPPlGLvrUQnm4pi3KG
         oidJNkR2fgq/uxd/PTuww1uviZwZ+TjVRzKB3/tNLeFMk80/RAoCQ05gY/HDo37HkhFW
         80zwjN51xwrfTUuAgKaR+HcwX9VXX5BIe6cCp0eCyVfiqJtMblOAbFENn7UHO2Nb4tz9
         Xq8A==
X-Gm-Message-State: AFqh2kqOGHVU5bLcaGDPApZdcOECBXuUo5CMIvtWLtBrCAWamC3W3F9u
        HQ466uVgB8uyDGghtSsvJkRq
X-Google-Smtp-Source: AMrXdXtc4PCcTsoEdGQ+r4p32wV7MJDvmK01njLPLzq3o3houTlMXljlyqQ2qxrApPwC8d8CcROeCA==
X-Received: by 2002:a05:6a20:a88a:b0:b2:75d0:b702 with SMTP id ca10-20020a056a20a88a00b000b275d0b702mr5911195pzb.18.1671718220019;
        Thu, 22 Dec 2022 06:10:20 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.177])
        by smtp.gmail.com with ESMTPSA id f8-20020a655908000000b0047829d1b8eesm832031pgu.31.2022.12.22.06.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 06:10:19 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org
Cc:     quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        abel.vesa@linaro.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 01/23] phy: qcom-qmp-ufs: Remove _tbl suffix from qmp_phy_init_tbl definitions
Date:   Thu, 22 Dec 2022 19:39:39 +0530
Message-Id: <20221222141001.54849-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222141001.54849-1-manivannan.sadhasivam@linaro.org>
References: <20221222141001.54849-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the other QMP PHY drivers like PCIe, let's remove the "_tbl"
suffix from the qmp_phy_init_tbl definitions. This helps in maintaining
the uniformity across all of the QMP PHY drivers.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # Qdrive3/sa8540p-ride
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 146 ++++++++++++------------
 1 file changed, 73 insertions(+), 73 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 318eea35b972..20fcdbef8c77 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -94,7 +94,7 @@ static const unsigned int sm8150_ufsphy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V4_PCS_UFS_POWER_DOWN_CONTROL,
 };
 
-static const struct qmp_phy_init_tbl msm8996_ufs_serdes_tbl[] = {
+static const struct qmp_phy_init_tbl msm8996_ufs_serdes[] = {
 	QMP_PHY_INIT_CFG(QSERDES_COM_CMN_CONFIG, 0x0e),
 	QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0xd7),
 	QMP_PHY_INIT_CFG(QSERDES_COM_CLK_SELECT, 0x30),
@@ -143,12 +143,12 @@ static const struct qmp_phy_init_tbl msm8996_ufs_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE1, 0x00),
 };
 
-static const struct qmp_phy_init_tbl msm8996_ufs_tx_tbl[] = {
+static const struct qmp_phy_init_tbl msm8996_ufs_tx[] = {
 	QMP_PHY_INIT_CFG(QSERDES_TX_HIGHZ_TRANSCEIVEREN_BIAS_DRVR_EN, 0x45),
 	QMP_PHY_INIT_CFG(QSERDES_TX_LANE_MODE, 0x02),
 };
 
-static const struct qmp_phy_init_tbl msm8996_ufs_rx_tbl[] = {
+static const struct qmp_phy_init_tbl msm8996_ufs_rx[] = {
 	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_LVL, 0x24),
 	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_CNTRL, 0x02),
 	QMP_PHY_INIT_CFG(QSERDES_RX_RX_INTERFACE_MODE, 0x00),
@@ -162,7 +162,7 @@ static const struct qmp_phy_init_tbl msm8996_ufs_rx_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0E),
 };
 
-static const struct qmp_phy_init_tbl sm6115_ufsphy_serdes_tbl[] = {
+static const struct qmp_phy_init_tbl sm6115_ufsphy_serdes[] = {
 	QMP_PHY_INIT_CFG(QSERDES_COM_CMN_CONFIG, 0x0e),
 	QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0x14),
 	QMP_PHY_INIT_CFG(QSERDES_COM_CLK_SELECT, 0x30),
@@ -218,12 +218,12 @@ static const struct qmp_phy_init_tbl sm6115_ufsphy_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_MAP, 0x44),
 };
 
-static const struct qmp_phy_init_tbl sm6115_ufsphy_tx_tbl[] = {
+static const struct qmp_phy_init_tbl sm6115_ufsphy_tx[] = {
 	QMP_PHY_INIT_CFG(QSERDES_TX_HIGHZ_TRANSCEIVEREN_BIAS_DRVR_EN, 0x45),
 	QMP_PHY_INIT_CFG(QSERDES_TX_LANE_MODE, 0x06),
 };
 
-static const struct qmp_phy_init_tbl sm6115_ufsphy_rx_tbl[] = {
+static const struct qmp_phy_init_tbl sm6115_ufsphy_rx[] = {
 	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_LVL, 0x24),
 	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_CNTRL, 0x0F),
 	QMP_PHY_INIT_CFG(QSERDES_RX_RX_INTERFACE_MODE, 0x40),
@@ -241,7 +241,7 @@ static const struct qmp_phy_init_tbl sm6115_ufsphy_rx_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x5B),
 };
 
-static const struct qmp_phy_init_tbl sm6115_ufsphy_pcs_tbl[] = {
+static const struct qmp_phy_init_tbl sm6115_ufsphy_pcs[] = {
 	QMP_PHY_INIT_CFG(QPHY_V2_PCS_RX_PWM_GEAR_BAND, 0x15),
 	QMP_PHY_INIT_CFG(QPHY_V2_PCS_RX_SIGDET_CTRL2, 0x6d),
 	QMP_PHY_INIT_CFG(QPHY_V2_PCS_TX_LARGE_AMP_DRV_LVL, 0x0f),
@@ -253,7 +253,7 @@ static const struct qmp_phy_init_tbl sm6115_ufsphy_pcs_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V2_PCS_RX_MIN_HIBERN8_TIME, 0x9a), /* 8 us */
 };
 
-static const struct qmp_phy_init_tbl sdm845_ufsphy_serdes_tbl[] = {
+static const struct qmp_phy_init_tbl sdm845_ufsphy_serdes[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYS_CLK_CTRL, 0x02),
 	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN, 0x04),
 	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BG_TIMER, 0x0a),
@@ -295,13 +295,13 @@ static const struct qmp_phy_init_tbl sdm845_ufsphy_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_MAP, 0x44),
 };
 
-static const struct qmp_phy_init_tbl sdm845_ufsphy_tx_tbl[] = {
+static const struct qmp_phy_init_tbl sdm845_ufsphy_tx[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V3_TX_LANE_MODE_1, 0x06),
 	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_TX, 0x04),
 	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_RX, 0x07),
 };
 
-static const struct qmp_phy_init_tbl sdm845_ufsphy_rx_tbl[] = {
+static const struct qmp_phy_init_tbl sdm845_ufsphy_rx[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_LVL, 0x24),
 	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_CNTRL, 0x0f),
 	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_DEGLITCH_CNTRL, 0x1e),
@@ -320,7 +320,7 @@ static const struct qmp_phy_init_tbl sdm845_ufsphy_rx_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_MODE_00, 0x59),
 };
 
-static const struct qmp_phy_init_tbl sdm845_ufsphy_pcs_tbl[] = {
+static const struct qmp_phy_init_tbl sdm845_ufsphy_pcs[] = {
 	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_RX_SIGDET_CTRL2, 0x6e),
 	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0a),
 	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_TX_SMALL_AMP_DRV_LVL, 0x02),
@@ -331,7 +331,7 @@ static const struct qmp_phy_init_tbl sdm845_ufsphy_pcs_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
 };
 
-static const struct qmp_phy_init_tbl sm8150_ufsphy_serdes_tbl[] = {
+static const struct qmp_phy_init_tbl sm8150_ufsphy_serdes[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYSCLK_EN_SEL, 0xd9),
 	QMP_PHY_INIT_CFG(QSERDES_V4_COM_HSCLK_SEL, 0x11),
 	QMP_PHY_INIT_CFG(QSERDES_V4_COM_HSCLK_HS_SWITCH_SEL, 0x00),
@@ -361,7 +361,7 @@ static const struct qmp_phy_init_tbl sm8150_ufsphy_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE_MAP, 0x06),
 };
 
-static const struct qmp_phy_init_tbl sm8150_ufsphy_tx_tbl[] = {
+static const struct qmp_phy_init_tbl sm8150_ufsphy_tx[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V4_TX_PWM_GEAR_1_DIVIDER_BAND0_1, 0x06),
 	QMP_PHY_INIT_CFG(QSERDES_V4_TX_PWM_GEAR_2_DIVIDER_BAND0_1, 0x03),
 	QMP_PHY_INIT_CFG(QSERDES_V4_TX_PWM_GEAR_3_DIVIDER_BAND0_1, 0x01),
@@ -370,7 +370,7 @@ static const struct qmp_phy_init_tbl sm8150_ufsphy_tx_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V4_TX_TRAN_DRVR_EMP_EN, 0x0c),
 };
 
-static const struct qmp_phy_init_tbl sm8150_ufsphy_rx_tbl[] = {
+static const struct qmp_phy_init_tbl sm8150_ufsphy_rx[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_LVL, 0x24),
 	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_CNTRL, 0x0f),
 	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_DEGLITCH_CNTRL, 0x1e),
@@ -408,7 +408,7 @@ static const struct qmp_phy_init_tbl sm8150_ufsphy_rx_tbl[] = {
 
 };
 
-static const struct qmp_phy_init_tbl sm8150_ufsphy_pcs_tbl[] = {
+static const struct qmp_phy_init_tbl sm8150_ufsphy_pcs[] = {
 	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_RX_SIGDET_CTRL2, 0x6d),
 	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0a),
 	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_TX_SMALL_AMP_DRV_LVL, 0x02),
@@ -418,7 +418,7 @@ static const struct qmp_phy_init_tbl sm8150_ufsphy_pcs_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
 };
 
-static const struct qmp_phy_init_tbl sm8350_ufsphy_serdes_tbl[] = {
+static const struct qmp_phy_init_tbl sm8350_ufsphy_serdes[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_EN_SEL, 0xd9),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_SEL, 0x11),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_HS_SWITCH_SEL, 0x00),
@@ -448,7 +448,7 @@ static const struct qmp_phy_init_tbl sm8350_ufsphy_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_TUNE_MAP, 0x06),
 };
 
-static const struct qmp_phy_init_tbl sm8350_ufsphy_tx_tbl[] = {
+static const struct qmp_phy_init_tbl sm8350_ufsphy_tx[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_TX_PWM_GEAR_1_DIVIDER_BAND0_1, 0x06),
 	QMP_PHY_INIT_CFG(QSERDES_V5_TX_PWM_GEAR_2_DIVIDER_BAND0_1, 0x03),
 	QMP_PHY_INIT_CFG(QSERDES_V5_TX_PWM_GEAR_3_DIVIDER_BAND0_1, 0x01),
@@ -460,7 +460,7 @@ static const struct qmp_phy_init_tbl sm8350_ufsphy_tx_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_TX_TRAN_DRVR_EMP_EN, 0x0c),
 };
 
-static const struct qmp_phy_init_tbl sm8350_ufsphy_rx_tbl[] = {
+static const struct qmp_phy_init_tbl sm8350_ufsphy_rx[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_LVL, 0x24),
 	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_CNTRL, 0x0f),
 	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_DEGLITCH_CNTRL, 0x1e),
@@ -500,7 +500,7 @@ static const struct qmp_phy_init_tbl sm8350_ufsphy_rx_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_RX_DCC_CTRL1, 0x0c),
 };
 
-static const struct qmp_phy_init_tbl sm8350_ufsphy_pcs_tbl[] = {
+static const struct qmp_phy_init_tbl sm8350_ufsphy_pcs[] = {
 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_RX_SIGDET_CTRL2, 0x6d),
 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0a),
 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_TX_SMALL_AMP_DRV_LVL, 0x02),
@@ -632,12 +632,12 @@ static const struct qmp_ufs_offsets qmp_ufs_offsets_v5 = {
 static const struct qmp_phy_cfg msm8996_ufs_cfg = {
 	.lanes			= 1,
 
-	.serdes_tbl		= msm8996_ufs_serdes_tbl,
-	.serdes_tbl_num		= ARRAY_SIZE(msm8996_ufs_serdes_tbl),
-	.tx_tbl			= msm8996_ufs_tx_tbl,
-	.tx_tbl_num		= ARRAY_SIZE(msm8996_ufs_tx_tbl),
-	.rx_tbl			= msm8996_ufs_rx_tbl,
-	.rx_tbl_num		= ARRAY_SIZE(msm8996_ufs_rx_tbl),
+	.serdes_tbl		= msm8996_ufs_serdes,
+	.serdes_tbl_num		= ARRAY_SIZE(msm8996_ufs_serdes),
+	.tx_tbl			= msm8996_ufs_tx,
+	.tx_tbl_num		= ARRAY_SIZE(msm8996_ufs_tx),
+	.rx_tbl			= msm8996_ufs_rx,
+	.rx_tbl_num		= ARRAY_SIZE(msm8996_ufs_rx),
 
 	.clk_list		= msm8996_ufs_phy_clk_l,
 	.num_clks		= ARRAY_SIZE(msm8996_ufs_phy_clk_l),
@@ -655,14 +655,14 @@ static const struct qmp_phy_cfg sc8280xp_ufsphy_cfg = {
 
 	.offsets		= &qmp_ufs_offsets_v5,
 
-	.serdes_tbl		= sm8350_ufsphy_serdes_tbl,
-	.serdes_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_serdes_tbl),
-	.tx_tbl			= sm8350_ufsphy_tx_tbl,
-	.tx_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_tx_tbl),
-	.rx_tbl			= sm8350_ufsphy_rx_tbl,
-	.rx_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_rx_tbl),
-	.pcs_tbl		= sm8350_ufsphy_pcs_tbl,
-	.pcs_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_pcs_tbl),
+	.serdes_tbl		= sm8350_ufsphy_serdes,
+	.serdes_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_serdes),
+	.tx_tbl			= sm8350_ufsphy_tx,
+	.tx_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_tx),
+	.rx_tbl			= sm8350_ufsphy_rx,
+	.rx_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_rx),
+	.pcs_tbl		= sm8350_ufsphy_pcs,
+	.pcs_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_pcs),
 	.clk_list		= sdm845_ufs_phy_clk_l,
 	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
@@ -673,14 +673,14 @@ static const struct qmp_phy_cfg sc8280xp_ufsphy_cfg = {
 static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
 	.lanes			= 2,
 
-	.serdes_tbl		= sdm845_ufsphy_serdes_tbl,
-	.serdes_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_serdes_tbl),
-	.tx_tbl			= sdm845_ufsphy_tx_tbl,
-	.tx_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_tx_tbl),
-	.rx_tbl			= sdm845_ufsphy_rx_tbl,
-	.rx_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_rx_tbl),
-	.pcs_tbl		= sdm845_ufsphy_pcs_tbl,
-	.pcs_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_pcs_tbl),
+	.serdes_tbl		= sdm845_ufsphy_serdes,
+	.serdes_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_serdes),
+	.tx_tbl			= sdm845_ufsphy_tx,
+	.tx_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_tx),
+	.rx_tbl			= sdm845_ufsphy_rx,
+	.rx_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_rx),
+	.pcs_tbl		= sdm845_ufsphy_pcs,
+	.pcs_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_pcs),
 	.clk_list		= sdm845_ufs_phy_clk_l,
 	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
@@ -693,14 +693,14 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
 static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
 	.lanes			= 1,
 
-	.serdes_tbl		= sm6115_ufsphy_serdes_tbl,
-	.serdes_tbl_num		= ARRAY_SIZE(sm6115_ufsphy_serdes_tbl),
-	.tx_tbl			= sm6115_ufsphy_tx_tbl,
-	.tx_tbl_num		= ARRAY_SIZE(sm6115_ufsphy_tx_tbl),
-	.rx_tbl			= sm6115_ufsphy_rx_tbl,
-	.rx_tbl_num		= ARRAY_SIZE(sm6115_ufsphy_rx_tbl),
-	.pcs_tbl		= sm6115_ufsphy_pcs_tbl,
-	.pcs_tbl_num		= ARRAY_SIZE(sm6115_ufsphy_pcs_tbl),
+	.serdes_tbl		= sm6115_ufsphy_serdes,
+	.serdes_tbl_num		= ARRAY_SIZE(sm6115_ufsphy_serdes),
+	.tx_tbl			= sm6115_ufsphy_tx,
+	.tx_tbl_num		= ARRAY_SIZE(sm6115_ufsphy_tx),
+	.rx_tbl			= sm6115_ufsphy_rx,
+	.rx_tbl_num		= ARRAY_SIZE(sm6115_ufsphy_rx),
+	.pcs_tbl		= sm6115_ufsphy_pcs,
+	.pcs_tbl_num		= ARRAY_SIZE(sm6115_ufsphy_pcs),
 	.clk_list		= sdm845_ufs_phy_clk_l,
 	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
@@ -713,14 +713,14 @@ static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
 static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
 	.lanes			= 2,
 
-	.serdes_tbl		= sm8150_ufsphy_serdes_tbl,
-	.serdes_tbl_num		= ARRAY_SIZE(sm8150_ufsphy_serdes_tbl),
-	.tx_tbl			= sm8150_ufsphy_tx_tbl,
-	.tx_tbl_num		= ARRAY_SIZE(sm8150_ufsphy_tx_tbl),
-	.rx_tbl			= sm8150_ufsphy_rx_tbl,
-	.rx_tbl_num		= ARRAY_SIZE(sm8150_ufsphy_rx_tbl),
-	.pcs_tbl		= sm8150_ufsphy_pcs_tbl,
-	.pcs_tbl_num		= ARRAY_SIZE(sm8150_ufsphy_pcs_tbl),
+	.serdes_tbl		= sm8150_ufsphy_serdes,
+	.serdes_tbl_num		= ARRAY_SIZE(sm8150_ufsphy_serdes),
+	.tx_tbl			= sm8150_ufsphy_tx,
+	.tx_tbl_num		= ARRAY_SIZE(sm8150_ufsphy_tx),
+	.rx_tbl			= sm8150_ufsphy_rx,
+	.rx_tbl_num		= ARRAY_SIZE(sm8150_ufsphy_rx),
+	.pcs_tbl		= sm8150_ufsphy_pcs,
+	.pcs_tbl_num		= ARRAY_SIZE(sm8150_ufsphy_pcs),
 	.clk_list		= sdm845_ufs_phy_clk_l,
 	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
@@ -731,14 +731,14 @@ static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
 static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
 	.lanes			= 2,
 
-	.serdes_tbl		= sm8350_ufsphy_serdes_tbl,
-	.serdes_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_serdes_tbl),
-	.tx_tbl			= sm8350_ufsphy_tx_tbl,
-	.tx_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_tx_tbl),
-	.rx_tbl			= sm8350_ufsphy_rx_tbl,
-	.rx_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_rx_tbl),
-	.pcs_tbl		= sm8350_ufsphy_pcs_tbl,
-	.pcs_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_pcs_tbl),
+	.serdes_tbl		= sm8350_ufsphy_serdes,
+	.serdes_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_serdes),
+	.tx_tbl			= sm8350_ufsphy_tx,
+	.tx_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_tx),
+	.rx_tbl			= sm8350_ufsphy_rx,
+	.rx_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_rx),
+	.pcs_tbl		= sm8350_ufsphy_pcs,
+	.pcs_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_pcs),
 	.clk_list		= sdm845_ufs_phy_clk_l,
 	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
@@ -749,14 +749,14 @@ static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
 static const struct qmp_phy_cfg sm8450_ufsphy_cfg = {
 	.lanes			= 2,
 
-	.serdes_tbl		= sm8350_ufsphy_serdes_tbl,
-	.serdes_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_serdes_tbl),
-	.tx_tbl			= sm8350_ufsphy_tx_tbl,
-	.tx_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_tx_tbl),
-	.rx_tbl			= sm8350_ufsphy_rx_tbl,
-	.rx_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_rx_tbl),
-	.pcs_tbl		= sm8350_ufsphy_pcs_tbl,
-	.pcs_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_pcs_tbl),
+	.serdes_tbl		= sm8350_ufsphy_serdes,
+	.serdes_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_serdes),
+	.tx_tbl			= sm8350_ufsphy_tx,
+	.tx_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_tx),
+	.rx_tbl			= sm8350_ufsphy_rx,
+	.rx_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_rx),
+	.pcs_tbl		= sm8350_ufsphy_pcs,
+	.pcs_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_pcs),
 	.clk_list		= sm8450_ufs_phy_clk_l,
 	.num_clks		= ARRAY_SIZE(sm8450_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
-- 
2.25.1

