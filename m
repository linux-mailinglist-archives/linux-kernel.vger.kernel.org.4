Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F9A677C83
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjAWNam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjAWNa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:30:29 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6514322A10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:30:26 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id az20so30528964ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vItZId2qjHoqHEQiookDEl4j8ijl0eOr3aln9UWpQCU=;
        b=SgBgxCCrYzD932YwV3j+OEWw5/eNUyc2ibTXx8y6ue0ayDYKeiIdmA247MKvw70Gcb
         yGFVidyLxZVzDKbydX3QWz2QaCphXcowwrK+GbQ7il3OZbY+Kdr4dhSH+fRzlPBOfXns
         lLFy7jgyGGf/NIG7kx8LkoZ91uGy9BLyDU5Al+iavbBP0gb7Ol1w4sKV1E0/ri1tF9o2
         /8jfmpnVVAMoFgWH1EGrj6FPVUt59UMeQ0LTwZwEqtT9kS7GlK6lFTqBvD/TQB1hwx0S
         ktmDzJV+VMyVOyQ/Io6giCJcRlMYqOsopWDI+7TXtKw9oq83oFghcybz76Uc8bqw7zC7
         R2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vItZId2qjHoqHEQiookDEl4j8ijl0eOr3aln9UWpQCU=;
        b=MkdXE5EzKdH9Pyz6hRpUokRuafvyWgh4XDyMYD2LTmWxYvgJrgrgBdLj6EtjLli5C5
         Yx18Cce0E9EF5zOkVkiSFYoWX5wYlo++CRwBuet0lT3HUYGSF/CXlkM2P1KQHgB9X7ne
         KcY/9jZJ5WI/RkjUhotbTdJAs8zPKQffb1c5kJQZCvUtq4gKHZPpzqmdY8xIu7BFKVKc
         W4RfaPN+wSYhhOFEvyfO0DfK7EJeI23k5oJ8P529K4Gn3e6m6mR+R+jonf5P+IMBR4ij
         eCyKwi0WSmA1ociBEeS2WFtZd8kwV8RbZlu+/R5B6TUtINglbfZBFUiqqJUSVDDFlhgl
         YuRw==
X-Gm-Message-State: AFqh2krNJ/vy22ODmxUSIPwXzWkrazzu1bSzoJphFtuJT00MnoEWXqV3
        znTFH0ckaTmcx5nJQaLsXYlJ5w==
X-Google-Smtp-Source: AMrXdXuY9rKKiTew8gsyGNx7jQ4dFMtk0GuYbZsRrfsMqIpZ1Ciap58f3VqjQphqL25U4JIsQ8I0NA==
X-Received: by 2002:a17:907:2096:b0:7c1:2075:199a with SMTP id pv22-20020a170907209600b007c12075199amr25748955ejb.76.1674480624781;
        Mon, 23 Jan 2023 05:30:24 -0800 (PST)
Received: from [172.16.220.87] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id s5-20020a170906c30500b008552bc8399dsm18410066ejz.172.2023.01.23.05.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 05:30:24 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Mon, 23 Jan 2023 14:29:50 +0100
Subject: [PATCH v4 2/3] phy: qcom-qmp-combo: Add config for SM6350
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230120-sm6350-usbphy-v4-2-4d700a90ba16@fairphone.com>
References: <20230120-sm6350-usbphy-v4-0-4d700a90ba16@fairphone.com>
In-Reply-To: <20230120-sm6350-usbphy-v4-0-4d700a90ba16@fairphone.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the tables and config for the combo phy found on SM6350.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 139 +++++++++++++++++++++++++++++-
 1 file changed, 137 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 1f022e580407..82b46f4c6df0 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -309,6 +309,70 @@ static const struct qmp_phy_init_tbl qmp_v3_usb3_pcs_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_RUN_TIME, 0x13),
 };
 
+static const struct qmp_phy_init_tbl sm6350_usb3_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_FO_GAIN, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4e),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL4, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x77),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_CNTRL, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_DEGLITCH_CNTRL, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_MODE_00, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x75),
+};
+
+static const struct qmp_phy_init_tbl sm6350_usb3_pcs_tbl[] = {
+	/* FLL settings */
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL2, 0x83),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_L, 0x09),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_H_TOL, 0xa2),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_MAN_CODE, 0x40),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL1, 0x02),
+
+	/* Lock Det settings */
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG1, 0xd1),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG2, 0x1f),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG3, 0x47),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_POWER_STATE_CONFIG2, 0x1b),
+
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RX_SIGDET_LVL, 0xcc),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXMGN_V0, 0x9f),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXMGN_V1, 0x9f),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXMGN_V2, 0xb7),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXMGN_V3, 0x4e),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXMGN_V4, 0x65),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXMGN_LS, 0x6b),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V0, 0x15),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V0, 0x0d),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V1, 0x15),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V1, 0x0d),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V2, 0x15),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V2, 0x0d),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V3, 0x15),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V3, 0x1d),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V4, 0x15),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V4, 0x0d),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_LS, 0x15),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_LS, 0x0d),
+
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RATE_SLEW_CNTRL, 0x02),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_PWRUP_RESET_DLY_TIME_AUXCLK, 0x04),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TSYNC_RSYNC_TIME, 0x44),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_PWRUP_RESET_DLY_TIME_AUXCLK, 0x04),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_L, 0x40),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_H, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_WAIT_TIME, 0x75),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LFPS_TX_ECSTART_EQTLOCK, 0x86),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_RUN_TIME, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LFPS_DET_HIGH_COUNT_VAL, 0x04),
+
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_REFGEN_REQ_CONFIG1, 0x21),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_REFGEN_REQ_CONFIG2, 0x60),
+};
+
 static const struct qmp_phy_init_tbl sm8150_usb3_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_EN_CENTER, 0x01),
 	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_PER1, 0x31),
@@ -807,6 +871,8 @@ struct qmp_combo_offsets {
 	u16 usb3_pcs;
 	u16 usb3_pcs_usb;
 	u16 dp_serdes;
+	u16 dp_txa;
+	u16 dp_txb;
 	u16 dp_dp_phy;
 };
 
@@ -973,6 +1039,21 @@ static const char * const sc7180_usb3phy_reset_l[] = {
 	"phy",
 };
 
+static const struct qmp_combo_offsets qmp_combo_offsets_v3 = {
+	.com		= 0x0000,
+	.txa		= 0x1200,
+	.rxa		= 0x1400,
+	.txb		= 0x1600,
+	.rxb		= 0x1800,
+	.usb3_serdes	= 0x1000,
+	.usb3_pcs_misc	= 0x1a00,
+	.usb3_pcs	= 0x1c00,
+	.dp_serdes	= 0x2000,
+	.dp_txa		= 0x2200,
+	.dp_txb		= 0x2600,
+	.dp_dp_phy	= 0x2a00,
+};
+
 static const struct qmp_combo_offsets qmp_combo_offsets_v5 = {
 	.com		= 0x0000,
 	.txa		= 0x0400,
@@ -1170,6 +1251,51 @@ static const struct qmp_phy_cfg sc8280xp_usb43dpphy_cfg = {
 	.regs			= qmp_v4_usb3phy_regs_layout,
 };
 
+static const struct qmp_phy_cfg sm6350_usb3dpphy_cfg = {
+	.offsets		= &qmp_combo_offsets_v3,
+
+	.serdes_tbl		= qmp_v3_usb3_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_serdes_tbl),
+	.tx_tbl			= qmp_v3_usb3_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_tx_tbl),
+	.rx_tbl			= sm6350_usb3_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sm6350_usb3_rx_tbl),
+	.pcs_tbl		= sm6350_usb3_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sm6350_usb3_pcs_tbl),
+
+	.dp_serdes_tbl		= qmp_v3_dp_serdes_tbl,
+	.dp_serdes_tbl_num	= ARRAY_SIZE(qmp_v3_dp_serdes_tbl),
+	.dp_tx_tbl		= qmp_v3_dp_tx_tbl,
+	.dp_tx_tbl_num		= ARRAY_SIZE(qmp_v3_dp_tx_tbl),
+
+	.serdes_tbl_rbr		= qmp_v3_dp_serdes_tbl_rbr,
+	.serdes_tbl_rbr_num	= ARRAY_SIZE(qmp_v3_dp_serdes_tbl_rbr),
+	.serdes_tbl_hbr		= qmp_v3_dp_serdes_tbl_hbr,
+	.serdes_tbl_hbr_num	= ARRAY_SIZE(qmp_v3_dp_serdes_tbl_hbr),
+	.serdes_tbl_hbr2	= qmp_v3_dp_serdes_tbl_hbr2,
+	.serdes_tbl_hbr2_num	= ARRAY_SIZE(qmp_v3_dp_serdes_tbl_hbr2),
+	.serdes_tbl_hbr3	= qmp_v3_dp_serdes_tbl_hbr3,
+	.serdes_tbl_hbr3_num	= ARRAY_SIZE(qmp_v3_dp_serdes_tbl_hbr3),
+
+	.swing_hbr_rbr		= &qmp_dp_v3_voltage_swing_hbr_rbr,
+	.pre_emphasis_hbr_rbr	= &qmp_dp_v3_pre_emphasis_hbr_rbr,
+	.swing_hbr3_hbr2	= &qmp_dp_v3_voltage_swing_hbr3_hbr2,
+	.pre_emphasis_hbr3_hbr2 = &qmp_dp_v3_pre_emphasis_hbr3_hbr2,
+
+	.dp_aux_init		= qmp_v3_dp_aux_init,
+	.configure_dp_tx	= qmp_v3_configure_dp_tx,
+	.configure_dp_phy	= qmp_v3_configure_dp_phy,
+	.calibrate_dp_phy	= qmp_v3_calibrate_dp_phy,
+
+	.clk_list		= qmp_v4_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(qmp_v4_phy_clk_l),
+	.reset_list		= msm8996_usb3phy_reset_l,
+	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v3_usb3phy_regs_layout,
+};
+
 static const struct qmp_phy_cfg sm8250_usb3dpphy_cfg = {
 	.serdes_tbl		= sm8150_usb3_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_serdes_tbl),
@@ -2639,8 +2765,13 @@ static int qmp_combo_parse_dt(struct qmp_combo *qmp)
 	qmp->pcs_usb = base + offs->usb3_pcs_usb;
 
 	qmp->dp_serdes = base + offs->dp_serdes;
-	qmp->dp_tx = base + offs->txa;
-	qmp->dp_tx2 = base + offs->txb;
+	if (offs->dp_txa) {
+		qmp->dp_tx = base + offs->dp_txa;
+		qmp->dp_tx2 = base + offs->dp_txb;
+	} else {
+		qmp->dp_tx = base + offs->txa;
+		qmp->dp_tx2 = base + offs->txb;
+	}
 	qmp->dp_dp_phy = base + offs->dp_dp_phy;
 
 	qmp->pipe_clk = devm_clk_get(dev, "usb3_pipe");
@@ -2787,6 +2918,10 @@ static const struct of_device_id qmp_combo_of_match_table[] = {
 		.compatible = "qcom,sdm845-qmp-usb3-dp-phy",
 		.data = &sdm845_usb3dpphy_cfg,
 	},
+	{
+		.compatible = "qcom,sm6350-qmp-usb3-dp-phy",
+		.data = &sm6350_usb3dpphy_cfg,
+	},
 	{
 		.compatible = "qcom,sm8250-qmp-usb3-dp-phy",
 		.data = &sm8250_usb3dpphy_cfg,

-- 
2.39.1

