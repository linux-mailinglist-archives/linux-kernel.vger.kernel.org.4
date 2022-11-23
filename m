Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19B9635179
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 08:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbiKWHuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 02:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbiKWHtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 02:49:23 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC86FA735
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 23:49:18 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id j10-20020a17090aeb0a00b00218dfce36e5so1214576pjz.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 23:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTz6Ll8Gs0xoeDCO8dLxC3S4/zJEIzg+DDVekYPXgJQ=;
        b=lI1w6Dh7ejOQk94fGrk7q7JhaZvkFQ0FJvBwUj14wInvjq2B1Q8oOLz0AprW6EosL1
         l1gZMmc2z4Bre77GR/pSuHtt2iELJMhaqDMJ8CPGpGPELO9bWA/nhsy8kNPEJiIMnNJq
         hoTkw2v+3cf8jYcMjq9P32FXtaB1pHyv3iJ4HLxwBE5fe8h5WRM0KUPBBa2kkyOm5pGx
         CQmK7hxDZNGJVK1dpqP+idwEGfViUbX0imL/6fhtdjXL+ZK9czdTLuNWJuuRpZ6oUmI5
         22ws0FvQqUjJm5fl1YtoUgGmEOfwWkWCq7zwDj7NsH0a6V4a1oiRFt66seDX2V9Cc3EU
         QZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTz6Ll8Gs0xoeDCO8dLxC3S4/zJEIzg+DDVekYPXgJQ=;
        b=zpAaoHI77ItrVjQeeNKZi7tTxc2VKYy6RTRNgaA2zq8mTLiInD5IkRJGzqyMRSr9YT
         YH69dQs0vqA9CGeQdeB4tFMNw3T0wUMXPgt2JBcXfQfkfKzKGBYPhyojvn7eU4D78EWF
         RD+/kz9VUSqy8oE7Wvku42u/0OO9SjSR4d/LTJuupI1JWgJ+5GTflZNSC7eDMATuRciN
         ypVvGork2X+iwHlxbyR1tftMyGdIqfeAibw9+wiOCQWxRUupxoGXfzzN2rGLpY8vNXtb
         dT1zgvISShPO41BRf9UoZqQ2sEehqExnsfIR0W+wIuEMDQLmUr3d9lzujA2w5LS3iAUu
         5ddQ==
X-Gm-Message-State: ANoB5pkLwQYhe8xs6gPENs6yIleldGK0LDMSRHfRa7V+JRP8usKsviJO
        Nt4RAgAJGlXpAWihsn/G9ORQ
X-Google-Smtp-Source: AA0mqf7lgRKWCiPjmygSZJxRVBlM43RcPUGb0SERrh7Uy6E3umAnpwWt0zg+O6eZ1pvBoTXnkGFJGw==
X-Received: by 2002:a17:903:2c2:b0:182:631a:ef28 with SMTP id s2-20020a17090302c200b00182631aef28mr7249584plk.46.1669189758029;
        Tue, 22 Nov 2022 23:49:18 -0800 (PST)
Received: from localhost.localdomain ([117.202.191.0])
        by smtp.gmail.com with ESMTPSA id s16-20020a170902a51000b001869f2120a5sm13334059plq.34.2022.11.22.23.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 23:49:17 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org
Cc:     quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        abel.vesa@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 07/20] phy: qcom-qmp-ufs: Add HS G4 mode support to SM8150 SoC
Date:   Wed, 23 Nov 2022 13:18:13 +0530
Message-Id: <20221123074826.95369-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221123074826.95369-1-manivannan.sadhasivam@linaro.org>
References: <20221123074826.95369-1-manivannan.sadhasivam@linaro.org>
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

UFS PHY in SM8150 SoC is capable of operating at HS G4 mode. Hence, add the
required register settings using the tables_hs_g4 struct instance.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 36 +++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index f6a962df9df1..98ebaf898a50 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -388,6 +388,10 @@ static const struct qmp_phy_init_tbl sm8150_ufsphy_tx[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V4_TX_TRAN_DRVR_EMP_EN, 0x0c),
 };
 
+static const struct qmp_phy_init_tbl sm8150_ufsphy_hs_g4_tx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_1, 0x75),
+};
+
 static const struct qmp_phy_init_tbl sm8150_ufsphy_rx[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_LVL, 0x24),
 	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_CNTRL, 0x0f),
@@ -425,6 +429,25 @@ static const struct qmp_phy_init_tbl sm8150_ufsphy_rx[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH4, 0xb1),
 };
 
+static const struct qmp_phy_init_tbl sm8150_ufsphy_hs_g4_rx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x5a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CTRL2, 0x81),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FO_GAIN, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_TERM_BW, 0x6f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_MEASURE_TIME, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_LOW, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH2, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH3, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH4, 0x6c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_LOW, 0x6d),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH, 0x6d),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH2, 0xed),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0x3c),
+};
+
 static const struct qmp_phy_init_tbl sm8150_ufsphy_pcs[] = {
 	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_RX_SIGDET_CTRL2, 0x6d),
 	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0a),
@@ -435,6 +458,11 @@ static const struct qmp_phy_init_tbl sm8150_ufsphy_pcs[] = {
 	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
 };
 
+static const struct qmp_phy_init_tbl sm8150_ufsphy_hs_g4_pcs[] = {
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x10),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_BIST_FIXED_PAT_CTRL, 0x0a),
+};
+
 static const struct qmp_phy_init_tbl sm8350_ufsphy_serdes[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_EN_SEL, 0xd9),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_SEL, 0x11),
@@ -778,6 +806,14 @@ static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
 		.serdes		= sm8150_ufsphy_hs_b_serdes,
 		.serdes_num	= ARRAY_SIZE(sm8150_ufsphy_hs_b_serdes),
 	},
+	.tbls_hs_g4 = {
+		.tx		= sm8150_ufsphy_hs_g4_tx,
+		.tx_num		= ARRAY_SIZE(sm8150_ufsphy_hs_g4_tx),
+		.rx		= sm8150_ufsphy_hs_g4_rx,
+		.rx_num		= ARRAY_SIZE(sm8150_ufsphy_hs_g4_rx),
+		.pcs		= sm8150_ufsphy_hs_g4_pcs,
+		.pcs_num	= ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
+	},
 	.clk_list		= sdm845_ufs_phy_clk_l,
 	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
-- 
2.25.1

