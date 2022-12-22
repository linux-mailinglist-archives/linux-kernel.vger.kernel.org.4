Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55E5654278
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbiLVOL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbiLVOL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:11:26 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59FD2B63D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:11:08 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id n4so2142460plp.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjhqEcZi9Td36RUK5eNAZ85GKHfRYtV+dPqbkSJsJUI=;
        b=h0iHwq+TqY6y0bCUn7TWl0d91/6+m06yVi973wp+qILsZAsWL5EzITF7n5WsEvf2Ez
         BjK+Ca4wK4bIOTSCmVpCMy1TUUBZU4QwenKSjIXrAPi9R6us/zpftMjYWolbtkdUq7IX
         QEJNI+03MPc+UaSch/m2u2DQO5005GjMMjjl4UdU6wjb7Y0SAoz3vggWQzrmSkkWxMDc
         XqMj63nTUkECAqzq8+GnIglfLjwGLh0a8DQ5S+kynuxUC9qJZKF+tT5sQb8Z/xBtu6M7
         ljSAsfHg7knLpPQD8y7BbpLNkJllWxaz5w0EIKJVMXoDcq7+l4up9LcbXZnpt+fgnfIA
         VFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjhqEcZi9Td36RUK5eNAZ85GKHfRYtV+dPqbkSJsJUI=;
        b=E24Qv+MQ7WBYwG4ZbIbIOlLT3pDOlj2T3wMCBa6m7ZbeAnF6WNnbqciSmIOEAHjawN
         cfFMG9/MgVkRJHli/Y6HlYgkT42bMZgRamkHsDjOgQCquWjchBkM6wcFGs7KzhPim7aL
         Ja9L6q3jUq+Ep4GUFXabF2naDgUSQe9b/YTmK4NEy/WX36Up3+PAyyD/CdPK8dZmmbAq
         kRYpIqVZYqKpk45cMjFUe7xFwB/K3hXVqbJP6yrBYbMCBul2rEU4mmLBiMrRUyzQH5zD
         rC2PgW6WbV1xw1lBibhd3Cbqx7BspdKW+cFf0DXLXtNh9++bYCqIwe+es8uoU2j8Y3oo
         uG/w==
X-Gm-Message-State: AFqh2kpF/UJImjXUaucEnfQgUnkuY6r70N1W9AVxSA2eQuSvmMNBeyMq
        yAjeNxrhFGit3UVhEwfLANDE
X-Google-Smtp-Source: AMrXdXvRZVK96O95OohJLaWDGCtpytRcTiaE0nBK56jaYF7DFH4I6NtmMbZ96ysZGMtOIQNSgwS1Ew==
X-Received: by 2002:a05:6a20:94c3:b0:ad:dcdf:aaad with SMTP id ht3-20020a056a2094c300b000addcdfaaadmr7969416pzb.19.1671718268296;
        Thu, 22 Dec 2022 06:11:08 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.177])
        by smtp.gmail.com with ESMTPSA id f8-20020a655908000000b0047829d1b8eesm832031pgu.31.2022.12.22.06.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 06:11:06 -0800 (PST)
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
Subject: [PATCH v5 08/23] phy: qcom-qmp-ufs: Add HS G4 mode support to SM8250 SoC
Date:   Thu, 22 Dec 2022 19:39:46 +0530
Message-Id: <20221222141001.54849-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222141001.54849-1-manivannan.sadhasivam@linaro.org>
References: <20221222141001.54849-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UFS PHY in SM8250 SoC is capable of operating at HS G4 mode. Hence, add the
required register settings using the tables_hs_g4 struct instance. This
also requires a separate qmp_phy_cfg for SM8250 instead of reusing SM8150.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # Qdrive3/sa8540p-ride
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../phy/qualcomm/phy-qcom-qmp-pcs-ufs-v5.h    |  1 +
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       | 62 ++++++++++++++++++-
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v5.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v5.h
index bcca23493b7e..3aa4232f84a6 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v5.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v5.h
@@ -13,6 +13,7 @@
 #define QPHY_V5_PCS_UFS_PLL_CNTL			0x02c
 #define QPHY_V5_PCS_UFS_TX_LARGE_AMP_DRV_LVL		0x030
 #define QPHY_V5_PCS_UFS_TX_SMALL_AMP_DRV_LVL		0x038
+#define QPHY_V5_PCS_UFS_BIST_FIXED_PAT_CTRL		0x060
 #define QPHY_V5_PCS_UFS_TX_HSGEAR_CAPABILITY		0x074
 #define QPHY_V5_PCS_UFS_RX_HSGEAR_CAPABILITY		0x0b4
 #define QPHY_V5_PCS_UFS_DEBUG_BUS_CLKSEL		0x124
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 269f96a0f752..d5324c4e8513 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -449,6 +449,34 @@ static const struct qmp_phy_init_tbl sm8150_ufsphy_hs_g4_pcs[] = {
 	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_BIST_FIXED_PAT_CTRL, 0x0a),
 };
 
+static const struct qmp_phy_init_tbl sm8250_ufsphy_hs_g4_tx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_1, 0xe5),
+};
+
+static const struct qmp_phy_init_tbl sm8250_ufsphy_hs_g4_rx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x5a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CTRL2, 0x81),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FO_GAIN, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_TERM_BW, 0x6f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL3, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL4, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x17),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_MEASURE_TIME, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_LOW, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH2, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH3, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH4, 0x2c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_LOW, 0x6d),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH, 0x6d),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH2, 0xed),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0x3c),
+};
+
 static const struct qmp_phy_init_tbl sm8350_ufsphy_serdes[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_EN_SEL, 0xd9),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_SEL, 0x11),
@@ -805,6 +833,38 @@ static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
 	.regs			= sm8150_ufsphy_regs_layout,
 };
 
+static const struct qmp_phy_cfg sm8250_ufsphy_cfg = {
+	.lanes			= 2,
+
+	.tbls = {
+		.serdes		= sm8150_ufsphy_serdes,
+		.serdes_num	= ARRAY_SIZE(sm8150_ufsphy_serdes),
+		.tx		= sm8150_ufsphy_tx,
+		.tx_num		= ARRAY_SIZE(sm8150_ufsphy_tx),
+		.rx		= sm8150_ufsphy_rx,
+		.rx_num		= ARRAY_SIZE(sm8150_ufsphy_rx),
+		.pcs		= sm8150_ufsphy_pcs,
+		.pcs_num	= ARRAY_SIZE(sm8150_ufsphy_pcs),
+	},
+	.tbls_hs_b = {
+		.serdes		= sm8150_ufsphy_hs_b_serdes,
+		.serdes_num	= ARRAY_SIZE(sm8150_ufsphy_hs_b_serdes),
+	},
+	.tbls_hs_g4 = {
+		.tx		= sm8250_ufsphy_hs_g4_tx,
+		.tx_num		= ARRAY_SIZE(sm8250_ufsphy_hs_g4_tx),
+		.rx		= sm8250_ufsphy_hs_g4_rx,
+		.rx_num		= ARRAY_SIZE(sm8250_ufsphy_hs_g4_rx),
+		.pcs		= sm8150_ufsphy_hs_g4_pcs,
+		.pcs_num	= ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
+	},
+	.clk_list		= sdm845_ufs_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= sm8150_ufsphy_regs_layout,
+};
+
 static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
 	.lanes			= 2,
 
@@ -1297,7 +1357,7 @@ static const struct of_device_id qmp_ufs_of_match_table[] = {
 		.data = &sm8150_ufsphy_cfg,
 	}, {
 		.compatible = "qcom,sm8250-qmp-ufs-phy",
-		.data = &sm8150_ufsphy_cfg,
+		.data = &sm8250_ufsphy_cfg,
 	}, {
 		.compatible = "qcom,sm8350-qmp-ufs-phy",
 		.data = &sm8350_ufsphy_cfg,
-- 
2.25.1

