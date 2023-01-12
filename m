Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463266672E9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjALNGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjALNGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:06:02 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B5360D5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 05:05:59 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id hw16so32737009ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 05:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0QhPI3IEWZUgBJhkds+oNc1kecb4XG5aSnwS1qpLSY=;
        b=EIHWOMg6fqJgKbj1/dpHrk7BlWNfQ0XdNiihkAzRpzqeLQiAidabsIgt6b7ruWftlg
         DK7kjtMzp/iHnkuR+eNgKET+PvPnbeAMjHqqzlwy7cGa5czu23ej6ZGGunc/Gtuu0EdD
         0bnfrkOK95FBiBoBbJHcTkFXjeS4e+a6iM7loOkeKf6APx2GWVnlZSFtIAceDMTHfmI6
         WxNJ40wMUPYBXUzMHQTDqveNmfyJs2MywOOKWqAHRNPDxyer0NEtxD4Vknt4Q+Vvn5zg
         IhGJoe387zMkGvRyluWG8udYZkxMsRRjLxIMXKIgBjz5DJtuvdOF5qTHfOM4dA2QmZ3X
         vGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0QhPI3IEWZUgBJhkds+oNc1kecb4XG5aSnwS1qpLSY=;
        b=cCHDbS1zXW4cPf9RdIDY+Gi1xsu6wSr4DsDcmafetjexGk/8mKNqCkjkbdJ3jkqg4N
         O0B67NiZ2+Swc8jrjyKEWAOc79XUMynWjOFApuXoyxAPEcSh8TPGDRa8GNjNA7eiKjYd
         hRGe7HZE6/ukucqt9eQUDO88ftOYqOgeUmdoQ7Cs7tw8+B2EnZAs4Zkf+s6m4hRw9jEt
         Hi+2o67aL3G+O/mqfPMDi+TH+f7nYT2+a8DOqEhtoZ1Dgp6vfalgC2UR0DnF1Dy5x+zD
         MDxSArbWTqOIVjR1oLYuhpEOcboPtkU0wp/1dHK9utc1Y8OrbrKfYy2sXDPLWPqjeDuy
         lauw==
X-Gm-Message-State: AFqh2kq6zstxSGMWRlk9pQNsoW5xmJ2LyWED7QxmO0vPfX7KUo1Bq428
        ikry0KMcMDpCpcWWEzmhzcVmtg==
X-Google-Smtp-Source: AMrXdXuHYHkRj25o5Yr1gYbbQjH4fNjHC11ABs1RNKJ1cW+9A8rSFYOYIaA4tKG9lwaLVBu7SOEUVA==
X-Received: by 2002:a17:906:6dd4:b0:836:e6f7:8138 with SMTP id j20-20020a1709066dd400b00836e6f78138mr78744185ejt.13.1673528758457;
        Thu, 12 Jan 2023 05:05:58 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id 11-20020a170906318b00b0078d3f96d293sm7427668ejy.30.2023.01.12.05.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 05:05:58 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 6/6] phy: qcom-qmp-ufs: Add SM8550 support
Date:   Thu, 12 Jan 2023 15:05:42 +0200
Message-Id: <20230112130542.1399921-7-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230112130542.1399921-1-abel.vesa@linaro.org>
References: <20230112130542.1399921-1-abel.vesa@linaro.org>
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

Add SM8550 specific register layout and table configs.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 100 ++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 5936a3a05002..a9b666f32f59 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -95,6 +95,13 @@ static const unsigned int sm8150_ufsphy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V4_PCS_UFS_POWER_DOWN_CONTROL,
 };
 
+static const unsigned int sm8550_ufsphy_regs_layout[QPHY_LAYOUT_SIZE] = {
+	[QPHY_START_CTRL]		= QPHY_V6_PCS_UFS_PHY_START,
+	[QPHY_PCS_READY_STATUS]		= QPHY_V6_PCS_UFS_READY_STATUS,
+	[QPHY_SW_RESET]			= QPHY_V6_PCS_UFS_SW_RESET,
+	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V6_PCS_UFS_POWER_DOWN_CONTROL,
+};
+
 static const struct qmp_phy_init_tbl msm8996_ufsphy_serdes[] = {
 	QMP_PHY_INIT_CFG(QSERDES_COM_CMN_CONFIG, 0x0e),
 	QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0xd7),
@@ -599,6 +606,61 @@ static const struct qmp_phy_init_tbl sm8350_ufsphy_g4_pcs[] = {
 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_BIST_FIXED_PAT_CTRL, 0x0a),
 };
 
+static const struct qmp_phy_init_tbl sm8550_ufsphy_serdes[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYSCLK_EN_SEL, 0xd9),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_CONFIG_1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x11),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_HS_SWITCH_SEL_1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_EN, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_INITVAL2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x41),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x4c),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x99),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x07),
+};
+
+static const struct qmp_phy_init_tbl sm8550_ufsphy_tx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_LANE_MODE_1, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_TX, 0x07),
+};
+
+static const struct qmp_phy_init_tbl sm8550_ufsphy_rx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE2, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE4, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL, 0x0e),
+
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0, 0xc2),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B1, 0xc2),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B3, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B6, 0x60),
+
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE2_B3, 0x9e),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE2_B6, 0x60),
+
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B3, 0x9e),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B4, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B5, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B8, 0x02),
+};
+
+static const struct qmp_phy_init_tbl sm8550_ufsphy_pcs[] = {
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_SIGDET_CTRL2, 0x69),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0f),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1, 0x43),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x2b),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
+};
+
 struct qmp_ufs_offsets {
 	u16 serdes;
 	u16 pcs;
@@ -703,6 +765,10 @@ static const char * const sm8450_ufs_phy_clk_l[] = {
 	"qref", "ref", "ref_aux",
 };
 
+static const char * const sm8550_ufs_phy_clk_l[] = {
+	"qref", "ref",
+};
+
 static const char * const sdm845_ufs_phy_clk_l[] = {
 	"ref", "ref_aux",
 };
@@ -721,6 +787,15 @@ static const struct qmp_ufs_offsets qmp_ufs_offsets_v5 = {
 	.rx2		= 0xa00,
 };
 
+static const struct qmp_ufs_offsets qmp_ufs_offsets_v6 = {
+	.serdes		= 0,
+	.pcs		= 0x400,
+	.tx		= 0x1000,
+	.rx		= 0x1200,
+	.tx2		= 0x1800,
+	.rx2		= 0x1a00,
+};
+
 static const struct qmp_phy_cfg msm8996_ufsphy_cfg = {
 	.lanes			= 1,
 
@@ -958,6 +1033,28 @@ static const struct qmp_phy_cfg sm8450_ufsphy_cfg = {
 	.regs			= sm8150_ufsphy_regs_layout,
 };
 
+static const struct qmp_phy_cfg sm8550_ufsphy_cfg = {
+	.lanes			= 2,
+
+	.offsets		= &qmp_ufs_offsets_v6,
+
+	.tbls = {
+		.serdes		= sm8550_ufsphy_serdes,
+		.serdes_num	= ARRAY_SIZE(sm8550_ufsphy_serdes),
+		.tx		= sm8550_ufsphy_tx,
+		.tx_num		= ARRAY_SIZE(sm8550_ufsphy_tx),
+		.rx		= sm8550_ufsphy_rx,
+		.rx_num		= ARRAY_SIZE(sm8550_ufsphy_rx),
+		.pcs		= sm8550_ufsphy_pcs,
+		.pcs_num	= ARRAY_SIZE(sm8550_ufsphy_pcs),
+	},
+	.clk_list		= sm8550_ufs_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(sm8550_ufs_phy_clk_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= sm8550_ufsphy_regs_layout,
+};
+
 static void qmp_ufs_configure_lane(void __iomem *base,
 					const struct qmp_phy_init_tbl tbl[],
 					int num,
@@ -1467,6 +1564,9 @@ static const struct of_device_id qmp_ufs_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sm8450-qmp-ufs-phy",
 		.data = &sm8450_ufsphy_cfg,
+	}, {
+		.compatible = "qcom,sm8550-qmp-ufs-phy",
+		.data = &sm8550_ufsphy_cfg,
 	},
 	{ },
 };
-- 
2.34.1

