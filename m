Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1372561DB81
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 16:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiKEPDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 11:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiKEPC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 11:02:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A97110B55;
        Sat,  5 Nov 2022 08:02:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFCAEB803F5;
        Sat,  5 Nov 2022 15:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187BFC4FF67;
        Sat,  5 Nov 2022 15:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667660571;
        bh=JyD+3VJqoJdssPyT6a+cb/LciAnZxKaG0GOdqXo9yNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J43naN9pPoui2mB5hOVEg4neeEbq25jS1drglIX7Z1nhyVfbZdOghhwVQ0y5UzrGP
         89/q3l9fxYeeUpSE40gMvOKhuKb+e+rkm0kHrWVgZfXLM19DTbMbPm2D2uCHIIg8p2
         /UCu2zWgg0GPEPs38RZmdguJp4p976fCE39Uul2OtdJ0A7MizVnbjsCjUOqNuMev37
         Qi/RQi5/qNKequhUnkSZS+hcIWLJfXDBTnHIc5PYUQP2shqovmgQPToAOBtOdVTqn0
         0x0R+nUG71Qug5QZn73P8qU2/sVSdVxzJMJqcd1+fZM1AaDp/iGtmXLaPRVjAMCUqv
         wUyExiqH1j8rQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1orKgq-0005Kv-11; Sat, 05 Nov 2022 16:02:32 +0100
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
Subject: [PATCH v5 15/16] phy: qcom-qmp-pcie: add support for sc8280xp
Date:   Sat,  5 Nov 2022 15:59:38 +0100
Message-Id: <20221105145939.20318-16-johan+linaro@kernel.org>
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

Add support for the single and dual-lane PHYs found on SC8280XP.

Note that the SC8280XP binding does not try to describe every register
subregion and instead the driver holds the corresponding offsets.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 299 +++++++++++++++++-
 .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h   |   2 +
 2 files changed, 291 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index d671b05c73dd..f507a67a8361 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -834,6 +834,143 @@ static const struct qmp_phy_init_tbl sc8180x_qmp_pcie_pcs_misc_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xc1),
 };
 
+static const struct qmp_phy_init_tbl sc8280xp_qmp_pcie_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_EN_CENTER, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_PER1, 0x31),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_PER2, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE1_MODE0, 0xde),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE2_MODE0, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE1_MODE1, 0x4c),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE2_MODE1, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CLK_ENABLE1, 0x90),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_IVCO, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CP_CTRL_MODE0, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CP_CTRL_MODE1, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_RCTRL_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE1, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_EN_SEL, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP_EN, 0x42),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP1_MODE0, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP2_MODE0, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP1_MODE1, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP2_MODE1, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DEC_START_MODE0, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DEC_START_MODE1, 0x68),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START1_MODE0, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START2_MODE0, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START3_MODE0, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START1_MODE1, 0xab),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START2_MODE1, 0xaa),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START3_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_TUNE_MAP, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_TUNE1_MODE0, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_TUNE1_MODE1, 0xb4),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_TUNE2_MODE1, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CLK_SELECT, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_SEL, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CORECLK_DIV_MODE1, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0xb9),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE2_MODE0, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE1_MODE1, 0x94),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE2_MODE1, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIN_VCOCAL_HSCLK_SEL, 0x11),
+};
+
+static const struct qmp_phy_init_tbl sc8280xp_qmp_gen3x1_pcie_rc_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_BUF_ENABLE, 0x07),
+};
+
+static const struct qmp_phy_init_tbl sc8280xp_qmp_gen3x2_pcie_rc_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIAS_EN_CLKBUFLR_EN, 0x14),
+};
+
+static const struct qmp_phy_init_tbl sc8280xp_qmp_gen3x1_pcie_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_PI_QEC_CTRL, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_1, 0x75),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_4, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_RES_CODE_LANE_OFFSET_TX, 0x1d),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_RES_CODE_LANE_OFFSET_RX, 0x0c),
+};
+
+static const struct qmp_phy_init_tbl sc8280xp_qmp_gen3x1_pcie_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_LOW, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH2, 0xbf),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH3, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH4, 0xd8),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_LOW, 0xdc),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH, 0xdc),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH2, 0x5c),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH3, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH4, 0xa6),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_TX_ADAPT_POST_THRESH, 0xf0),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_10_HIGH3, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_VGA_CAL_CNTRL2, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_GM_CAL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_THRESH1, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_THRESH2, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_PI_CONTROLS, 0xf0),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
+};
+
+static const struct qmp_phy_init_tbl sc8280xp_qmp_gen3x1_pcie_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_REFGEN_REQ_CONFIG1, 0x05),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_RX_SIGDET_LVL, 0x77),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_RATE_SLEW_CNTRL1, 0x0b),
+};
+
+static const struct qmp_phy_init_tbl sc8280xp_qmp_gen3x1_pcie_pcs_misc_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_ACTIONS, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_INT_AUX_CLK_CONFIG1, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_EQ_CONFIG2, 0x0f),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xc1),
+};
+
+static const struct qmp_phy_init_tbl sc8280xp_qmp_gen3x2_pcie_tx_tbl[] = {
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V5_TX_PI_QEC_CTRL, 0x02, 1),
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V5_TX_PI_QEC_CTRL, 0x04, 2),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_1, 0xd5),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_4, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_RES_CODE_LANE_OFFSET_TX, 0x11),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_RES_CODE_LANE_OFFSET_RX, 0x0c),
+};
+
+static const struct qmp_phy_init_tbl sc8280xp_qmp_gen3x2_pcie_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_LOW, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH2, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH3, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH4, 0xd8),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_LOW, 0xdc),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH, 0xdc),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH2, 0x5c),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH3, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH4, 0xa6),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_10_HIGH3, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_VGA_CAL_CNTRL2, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_GM_CAL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_THRESH1, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_THRESH2, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_PI_CONTROLS, 0xf0),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
+};
+
+static const struct qmp_phy_init_tbl sc8280xp_qmp_gen3x2_pcie_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_REFGEN_REQ_CONFIG1, 0x05),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_RX_SIGDET_LVL, 0x88),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_RATE_SLEW_CNTRL1, 0x0b),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_EQ_CONFIG3, 0x0f),
+};
+
+static const struct qmp_phy_init_tbl sc8280xp_qmp_gen3x2_pcie_pcs_misc_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG2, 0x1d),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG4, 0x07),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xc1),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_ACTIONS, 0x00),
+};
+
 static const struct qmp_phy_init_tbl sm8250_qmp_pcie_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYSCLK_EN_SEL, 0x08),
 	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CLK_SELECT, 0x34),
@@ -1313,6 +1450,16 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_ep_pcs_misc_tbl[] =
 	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5, 0x08),
 };
 
+struct qmp_pcie_offsets {
+	u16 serdes;
+	u16 pcs;
+	u16 pcs_misc;
+	u16 tx;
+	u16 rx;
+	u16 tx2;
+	u16 rx2;
+};
+
 struct qmp_phy_cfg_tbls {
 	const struct qmp_phy_init_tbl *serdes;
 	int serdes_num;
@@ -1330,6 +1477,8 @@ struct qmp_phy_cfg_tbls {
 struct qmp_phy_cfg {
 	int lanes;
 
+	const struct qmp_pcie_offsets *offsets;
+
 	/* Main init sequence for PHY blocks - serdes, tx, rx, pcs */
 	const struct qmp_phy_cfg_tbls tbls;
 	/*
@@ -1422,6 +1571,9 @@ static const char * const msm8996_phy_clk_l[] = {
 	"aux", "cfg_ahb", "ref",
 };
 
+static const char * const sc8280xp_pciephy_clk_l[] = {
+	"aux", "cfg_ahb", "ref", "rchng",
+};
 
 static const char * const sdm845_pciephy_clk_l[] = {
 	"aux", "cfg_ahb", "ref", "refgen",
@@ -1441,6 +1593,16 @@ static const char * const sdm845_pciephy_reset_l[] = {
 	"phy",
 };
 
+static const struct qmp_pcie_offsets qmp_pcie_offsets_v5 = {
+	.serdes		= 0,
+	.pcs		= 0x0200,
+	.pcs_misc	= 0x0600,
+	.tx		= 0x0e00,
+	.rx		= 0x1000,
+	.tx2		= 0x1600,
+	.rx2		= 0x1800,
+};
+
 static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
 	.lanes			= 1,
 
@@ -1700,6 +1862,76 @@ static const struct qmp_phy_cfg sc8180x_pciephy_cfg = {
 	.phy_status		= PHYSTATUS,
 };
 
+static const struct qmp_phy_cfg sc8280xp_qmp_gen3x1_pciephy_cfg = {
+	.lanes			= 1,
+
+	.offsets		= &qmp_pcie_offsets_v5,
+
+	.tbls = {
+		.serdes		= sc8280xp_qmp_pcie_serdes_tbl,
+		.serdes_num	= ARRAY_SIZE(sc8280xp_qmp_pcie_serdes_tbl),
+		.tx		= sc8280xp_qmp_gen3x1_pcie_tx_tbl,
+		.tx_num		= ARRAY_SIZE(sc8280xp_qmp_gen3x1_pcie_tx_tbl),
+		.rx		= sc8280xp_qmp_gen3x1_pcie_rx_tbl,
+		.rx_num		= ARRAY_SIZE(sc8280xp_qmp_gen3x1_pcie_rx_tbl),
+		.pcs		= sc8280xp_qmp_gen3x1_pcie_pcs_tbl,
+		.pcs_num	= ARRAY_SIZE(sc8280xp_qmp_gen3x1_pcie_pcs_tbl),
+		.pcs_misc	= sc8280xp_qmp_gen3x1_pcie_pcs_misc_tbl,
+		.pcs_misc_num	= ARRAY_SIZE(sc8280xp_qmp_gen3x1_pcie_pcs_misc_tbl),
+	},
+
+	.tbls_rc = &(const struct qmp_phy_cfg_tbls) {
+		.serdes		= sc8280xp_qmp_gen3x1_pcie_rc_serdes_tbl,
+		.serdes_num	= ARRAY_SIZE(sc8280xp_qmp_gen3x1_pcie_rc_serdes_tbl),
+	},
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
+static const struct qmp_phy_cfg sc8280xp_qmp_gen3x2_pciephy_cfg = {
+	.lanes			= 2,
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
 
@@ -2220,11 +2452,49 @@ static int qmp_pcie_parse_dt_legacy(struct qmp_pcie *qmp, struct device_node *np
 	return 0;
 }
 
+static int qmp_pcie_parse_dt(struct qmp_pcie *qmp)
+{
+	struct platform_device *pdev = to_platform_device(qmp->dev);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	const struct qmp_pcie_offsets *offs = cfg->offsets;
+	struct device *dev = qmp->dev;
+	void __iomem *base;
+	int ret;
+
+	if (!offs)
+		return -EINVAL;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	qmp->serdes = base + offs->serdes;
+	qmp->pcs = base + offs->pcs;
+	qmp->pcs_misc = base + offs->pcs_misc;
+	qmp->tx = base + offs->tx;
+	qmp->rx = base + offs->rx;
+
+	if (cfg->lanes >= 2) {
+		qmp->tx2 = base + offs->tx2;
+		qmp->rx2 = base + offs->rx2;
+	}
+
+	qmp->num_pipe_clks = 2;
+	qmp->pipe_clks[0].id = "pipe";
+	qmp->pipe_clks[1].id = "pipediv2";
+
+	ret = devm_clk_bulk_get(dev, qmp->num_pipe_clks, qmp->pipe_clks);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int qmp_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *child;
 	struct phy_provider *phy_provider;
+	struct device_node *np;
 	struct qmp_pcie *qmp;
 	int ret;
 
@@ -2253,21 +2523,24 @@ static int qmp_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	child = of_get_next_available_child(dev->of_node, NULL);
-	if (!child)
-		return -EINVAL;
-
-	ret = qmp_pcie_parse_dt_legacy(qmp, child);
+	/* Check for legacy binding with child node. */
+	np = of_get_next_available_child(dev->of_node, NULL);
+	if (np) {
+		ret = qmp_pcie_parse_dt_legacy(qmp, np);
+	} else {
+		np = of_node_get(dev->of_node);
+		ret = qmp_pcie_parse_dt(qmp);
+	}
 	if (ret)
 		goto err_node_put;
 
-	ret = phy_pipe_clk_register(qmp, child);
+	ret = phy_pipe_clk_register(qmp, np);
 	if (ret)
 		goto err_node_put;
 
 	qmp->mode = PHY_MODE_PCIE_RC;
 
-	qmp->phy = devm_phy_create(dev, child, &qmp_pcie_phy_ops);
+	qmp->phy = devm_phy_create(dev, np, &qmp_pcie_phy_ops);
 	if (IS_ERR(qmp->phy)) {
 		ret = PTR_ERR(qmp->phy);
 		dev_err(dev, "failed to create PHY: %d\n", ret);
@@ -2276,14 +2549,14 @@ static int qmp_pcie_probe(struct platform_device *pdev)
 
 	phy_set_drvdata(qmp->phy, qmp);
 
-	of_node_put(child);
+	of_node_put(np);
 
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
 
 	return PTR_ERR_OR_ZERO(phy_provider);
 
 err_node_put:
-	of_node_put(child);
+	of_node_put(np);
 	return ret;
 }
 
@@ -2303,6 +2576,12 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sc8180x-qmp-pcie-phy",
 		.data = &sc8180x_pciephy_cfg,
+	}, {
+		.compatible = "qcom,sc8280xp-qmp-gen3x1-pcie-phy",
+		.data = &sc8280xp_qmp_gen3x1_pciephy_cfg,
+	}, {
+		.compatible = "qcom,sc8280xp-qmp-gen3x2-pcie-phy",
+		.data = &sc8280xp_qmp_gen3x2_pciephy_cfg,
 	}, {
 		.compatible = "qcom,sdm845-qhp-pcie-phy",
 		.data = &sdm845_qhp_pciephy_cfg,
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h
index 2e19fb3f051e..a469ae2a10a1 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h
@@ -8,6 +8,8 @@
 #define QCOM_PHY_QMP_PCS_PCIE_V5_H_
 
 /* Only for QMP V5 PHY - PCS_PCIE registers */
+#define QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG2		0x0c
+#define QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG4		0x14
 #define QPHY_V5_PCS_PCIE_ENDPOINT_REFCLK_DRIVE		0x20
 #define QPHY_V5_PCS_PCIE_INT_AUX_CLK_CONFIG1		0x54
 #define QPHY_V5_PCS_PCIE_OSC_DTCT_ACTIONS		0x94
-- 
2.37.4

