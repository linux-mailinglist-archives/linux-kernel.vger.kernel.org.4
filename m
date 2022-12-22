Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801D265426A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbiLVOKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbiLVOKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:10:41 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0101A2B264
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:10:32 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso5812316pjp.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSdeYPXBZcLgtJpfdwsHsq49aCAnxIPn+ssC5xgP++w=;
        b=OQ4qTfwsaOnG6O+eSZKtRlHUkA53Dmf4ySsl27jGUfvwWLv4RpnT3hIZmVL+7UNf/S
         nnxuUJnrUHXVKBep+uxXdSwSI9mYGN8wOlk148F33gYqL0rWHJEflpEGHkSn2qC6SC4/
         wdQ9jeW/rUWHFfUCQGfL6FhSRRilCYq6sk8fxxHMpT22IgUxexveh3Df7CDgCTaVtsJy
         GWnSl6QhX3+4ReqjPW8R9XL1kEwo6TlNdWYU0qz6qapeJdI2bFpPxpwJjx8o6w+da26l
         MT4Gj1iq9FpksLTcTokVeNv4jo9Nx9YF9MdPEAGEtVhmYFBO6jxbIo5bDt/5MoOAajhs
         nSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSdeYPXBZcLgtJpfdwsHsq49aCAnxIPn+ssC5xgP++w=;
        b=5mbmcth7nl7kedHmbD1OYBdu76CvcECJfjyG+H61tp6op7XtYB7RM/fVU8vP0uIq3p
         gRP1RJOxBI2BZF1hil1anR1xQM6mFXMkT3TQw56c1eZp4n0jeqFyOzQKgDVvbphmy8xV
         U9VatIDzCe9cHVLnjL8YtQVQDkQzGvDMWo39fs97fFRf9wmhUWr0W2dUP+hbMlxFp6yg
         WTeDZmu7aZUD3xSzuAmFTxOAcjmsa54Ebdosq5HWDBrLKYZbO8ync7RZLic+GRpdMc19
         BSHugOXOfOnLUk5HvmA2v9fuCETw2aBLEAmmAlPTOCeL3AKk5+Soi5xh5InV+4+L4C0g
         w6NA==
X-Gm-Message-State: AFqh2kqn0NF5Es8TLGSFe8lPQDLglqc8ipdvTO8Vxc44WslxyE/Xe6Cu
        o1oL/GmC5z74X42MNLgL5NTi
X-Google-Smtp-Source: AMrXdXsncJgqGErka7sTdFIFIY8UVd8h2btWbSv6eSQTZXSBkyl+OrmPScXc3J04eCaJGpH8qWyRWQ==
X-Received: by 2002:a05:6a21:3988:b0:ad:a09c:5734 with SMTP id ad8-20020a056a21398800b000ada09c5734mr7991871pzc.44.1671718232612;
        Thu, 22 Dec 2022 06:10:32 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.177])
        by smtp.gmail.com with ESMTPSA id f8-20020a655908000000b0047829d1b8eesm832031pgu.31.2022.12.22.06.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 06:10:31 -0800 (PST)
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
Subject: [PATCH v5 03/23] phy: qcom-qmp-ufs: Move register settings to qmp_phy_cfg_tbls struct
Date:   Thu, 22 Dec 2022 19:39:41 +0530
Message-Id: <20221222141001.54849-4-manivannan.sadhasivam@linaro.org>
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

As done for Qcom PCIe PHY driver, let's move the register settings to the
common qmp_phy_cfg_tbls struct. This helps in adding any additional PHY
settings needed for functionalities like HS-G4 in the future by adding one
more instance of the qmp_phy_cfg_tbls.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # Qdrive3/sa8540p-ride
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 196 ++++++++++++++----------
 1 file changed, 113 insertions(+), 83 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 35b77cd79e57..516027e356f0 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -527,21 +527,26 @@ struct qmp_ufs_offsets {
 	u16 rx2;
 };
 
+struct qmp_phy_cfg_tbls {
+	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
+	const struct qmp_phy_init_tbl *serdes;
+	int serdes_num;
+	const struct qmp_phy_init_tbl *tx;
+	int tx_num;
+	const struct qmp_phy_init_tbl *rx;
+	int rx_num;
+	const struct qmp_phy_init_tbl *pcs;
+	int pcs_num;
+};
+
 /* struct qmp_phy_cfg - per-PHY initialization config */
 struct qmp_phy_cfg {
 	int lanes;
 
 	const struct qmp_ufs_offsets *offsets;
 
-	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
-	const struct qmp_phy_init_tbl *serdes_tbl;
-	int serdes_tbl_num;
-	const struct qmp_phy_init_tbl *tx_tbl;
-	int tx_tbl_num;
-	const struct qmp_phy_init_tbl *rx_tbl;
-	int rx_tbl_num;
-	const struct qmp_phy_init_tbl *pcs_tbl;
-	int pcs_tbl_num;
+	/* Main init sequence for PHY blocks - serdes, tx, rx, pcs */
+	const struct qmp_phy_cfg_tbls tbls;
 
 	/* clock ids to be requested */
 	const char * const *clk_list;
@@ -632,12 +637,14 @@ static const struct qmp_ufs_offsets qmp_ufs_offsets_v5 = {
 static const struct qmp_phy_cfg msm8996_ufsphy_cfg = {
 	.lanes			= 1,
 
-	.serdes_tbl		= msm8996_ufsphy_serdes,
-	.serdes_tbl_num		= ARRAY_SIZE(msm8996_ufsphy_serdes),
-	.tx_tbl			= msm8996_ufsphy_tx,
-	.tx_tbl_num		= ARRAY_SIZE(msm8996_ufsphy_tx),
-	.rx_tbl			= msm8996_ufsphy_rx,
-	.rx_tbl_num		= ARRAY_SIZE(msm8996_ufsphy_rx),
+	.tbls = {
+		.serdes		= msm8996_ufsphy_serdes,
+		.serdes_num	= ARRAY_SIZE(msm8996_ufsphy_serdes),
+		.tx		= msm8996_ufsphy_tx,
+		.tx_num		= ARRAY_SIZE(msm8996_ufsphy_tx),
+		.rx		= msm8996_ufsphy_rx,
+		.rx_num		= ARRAY_SIZE(msm8996_ufsphy_rx),
+	},
 
 	.clk_list		= msm8996_ufs_phy_clk_l,
 	.num_clks		= ARRAY_SIZE(msm8996_ufs_phy_clk_l),
@@ -655,14 +662,16 @@ static const struct qmp_phy_cfg sc8280xp_ufsphy_cfg = {
 
 	.offsets		= &qmp_ufs_offsets_v5,
 
-	.serdes_tbl		= sm8350_ufsphy_serdes,
-	.serdes_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_serdes),
-	.tx_tbl			= sm8350_ufsphy_tx,
-	.tx_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_tx),
-	.rx_tbl			= sm8350_ufsphy_rx,
-	.rx_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_rx),
-	.pcs_tbl		= sm8350_ufsphy_pcs,
-	.pcs_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_pcs),
+	.tbls = {
+		.serdes		= sm8350_ufsphy_serdes,
+		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_serdes),
+		.tx		= sm8350_ufsphy_tx,
+		.tx_num		= ARRAY_SIZE(sm8350_ufsphy_tx),
+		.rx		= sm8350_ufsphy_rx,
+		.rx_num		= ARRAY_SIZE(sm8350_ufsphy_rx),
+		.pcs		= sm8350_ufsphy_pcs,
+		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_pcs),
+	},
 	.clk_list		= sdm845_ufs_phy_clk_l,
 	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
@@ -673,14 +682,16 @@ static const struct qmp_phy_cfg sc8280xp_ufsphy_cfg = {
 static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
 	.lanes			= 2,
 
-	.serdes_tbl		= sdm845_ufsphy_serdes,
-	.serdes_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_serdes),
-	.tx_tbl			= sdm845_ufsphy_tx,
-	.tx_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_tx),
-	.rx_tbl			= sdm845_ufsphy_rx,
-	.rx_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_rx),
-	.pcs_tbl		= sdm845_ufsphy_pcs,
-	.pcs_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_pcs),
+	.tbls = {
+		.serdes		= sdm845_ufsphy_serdes,
+		.serdes_num	= ARRAY_SIZE(sdm845_ufsphy_serdes),
+		.tx		= sdm845_ufsphy_tx,
+		.tx_num		= ARRAY_SIZE(sdm845_ufsphy_tx),
+		.rx		= sdm845_ufsphy_rx,
+		.rx_num		= ARRAY_SIZE(sdm845_ufsphy_rx),
+		.pcs		= sdm845_ufsphy_pcs,
+		.pcs_num	= ARRAY_SIZE(sdm845_ufsphy_pcs),
+	},
 	.clk_list		= sdm845_ufs_phy_clk_l,
 	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
@@ -693,14 +704,16 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
 static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
 	.lanes			= 1,
 
-	.serdes_tbl		= sm6115_ufsphy_serdes,
-	.serdes_tbl_num		= ARRAY_SIZE(sm6115_ufsphy_serdes),
-	.tx_tbl			= sm6115_ufsphy_tx,
-	.tx_tbl_num		= ARRAY_SIZE(sm6115_ufsphy_tx),
-	.rx_tbl			= sm6115_ufsphy_rx,
-	.rx_tbl_num		= ARRAY_SIZE(sm6115_ufsphy_rx),
-	.pcs_tbl		= sm6115_ufsphy_pcs,
-	.pcs_tbl_num		= ARRAY_SIZE(sm6115_ufsphy_pcs),
+	.tbls = {
+		.serdes		= sm6115_ufsphy_serdes,
+		.serdes_num	= ARRAY_SIZE(sm6115_ufsphy_serdes),
+		.tx		= sm6115_ufsphy_tx,
+		.tx_num		= ARRAY_SIZE(sm6115_ufsphy_tx),
+		.rx		= sm6115_ufsphy_rx,
+		.rx_num		= ARRAY_SIZE(sm6115_ufsphy_rx),
+		.pcs		= sm6115_ufsphy_pcs,
+		.pcs_num	= ARRAY_SIZE(sm6115_ufsphy_pcs),
+	},
 	.clk_list		= sdm845_ufs_phy_clk_l,
 	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
@@ -713,14 +726,16 @@ static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
 static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
 	.lanes			= 2,
 
-	.serdes_tbl		= sm8150_ufsphy_serdes,
-	.serdes_tbl_num		= ARRAY_SIZE(sm8150_ufsphy_serdes),
-	.tx_tbl			= sm8150_ufsphy_tx,
-	.tx_tbl_num		= ARRAY_SIZE(sm8150_ufsphy_tx),
-	.rx_tbl			= sm8150_ufsphy_rx,
-	.rx_tbl_num		= ARRAY_SIZE(sm8150_ufsphy_rx),
-	.pcs_tbl		= sm8150_ufsphy_pcs,
-	.pcs_tbl_num		= ARRAY_SIZE(sm8150_ufsphy_pcs),
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
 	.clk_list		= sdm845_ufs_phy_clk_l,
 	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
@@ -731,14 +746,16 @@ static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
 static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
 	.lanes			= 2,
 
-	.serdes_tbl		= sm8350_ufsphy_serdes,
-	.serdes_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_serdes),
-	.tx_tbl			= sm8350_ufsphy_tx,
-	.tx_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_tx),
-	.rx_tbl			= sm8350_ufsphy_rx,
-	.rx_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_rx),
-	.pcs_tbl		= sm8350_ufsphy_pcs,
-	.pcs_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_pcs),
+	.tbls = {
+		.serdes		= sm8350_ufsphy_serdes,
+		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_serdes),
+		.tx		= sm8350_ufsphy_tx,
+		.tx_num		= ARRAY_SIZE(sm8350_ufsphy_tx),
+		.rx		= sm8350_ufsphy_rx,
+		.rx_num		= ARRAY_SIZE(sm8350_ufsphy_rx),
+		.pcs		= sm8350_ufsphy_pcs,
+		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_pcs),
+	},
 	.clk_list		= sdm845_ufs_phy_clk_l,
 	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
@@ -749,14 +766,16 @@ static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
 static const struct qmp_phy_cfg sm8450_ufsphy_cfg = {
 	.lanes			= 2,
 
-	.serdes_tbl		= sm8350_ufsphy_serdes,
-	.serdes_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_serdes),
-	.tx_tbl			= sm8350_ufsphy_tx,
-	.tx_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_tx),
-	.rx_tbl			= sm8350_ufsphy_rx,
-	.rx_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_rx),
-	.pcs_tbl		= sm8350_ufsphy_pcs,
-	.pcs_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_pcs),
+	.tbls = {
+		.serdes		= sm8350_ufsphy_serdes,
+		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_serdes),
+		.tx		= sm8350_ufsphy_tx,
+		.tx_num		= ARRAY_SIZE(sm8350_ufsphy_tx),
+		.rx		= sm8350_ufsphy_rx,
+		.rx_num		= ARRAY_SIZE(sm8350_ufsphy_rx),
+		.pcs		= sm8350_ufsphy_pcs,
+		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_pcs),
+	},
 	.clk_list		= sm8450_ufs_phy_clk_l,
 	.num_clks		= ARRAY_SIZE(sm8450_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
@@ -790,16 +809,40 @@ static void qmp_ufs_configure(void __iomem *base,
 	qmp_ufs_configure_lane(base, tbl, num, 0xff);
 }
 
-static int qmp_ufs_serdes_init(struct qmp_ufs *qmp)
+static void qmp_ufs_serdes_init(struct qmp_ufs *qmp, const struct qmp_phy_cfg_tbls *tbls)
 {
-	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	void __iomem *serdes = qmp->serdes;
-	const struct qmp_phy_init_tbl *serdes_tbl = cfg->serdes_tbl;
-	int serdes_tbl_num = cfg->serdes_tbl_num;
 
-	qmp_ufs_configure(serdes, serdes_tbl, serdes_tbl_num);
+	qmp_ufs_configure(serdes, tbls->serdes, tbls->serdes_num);
+}
 
-	return 0;
+static void qmp_ufs_lanes_init(struct qmp_ufs *qmp, const struct qmp_phy_cfg_tbls *tbls)
+{
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	void __iomem *tx = qmp->tx;
+	void __iomem *rx = qmp->rx;
+
+	qmp_ufs_configure_lane(tx, tbls->tx, tbls->tx_num, 1);
+	qmp_ufs_configure_lane(rx, tbls->rx, tbls->rx_num, 1);
+
+	if (cfg->lanes >= 2) {
+		qmp_ufs_configure_lane(qmp->tx2, tbls->tx, tbls->tx_num, 2);
+		qmp_ufs_configure_lane(qmp->rx2, tbls->rx, tbls->rx_num, 2);
+	}
+}
+
+static void qmp_ufs_pcs_init(struct qmp_ufs *qmp, const struct qmp_phy_cfg_tbls *tbls)
+{
+	void __iomem *pcs = qmp->pcs;
+
+	qmp_ufs_configure(pcs, tbls->pcs, tbls->pcs_num);
+}
+
+static void qmp_ufs_init_registers(struct qmp_ufs *qmp, const struct qmp_phy_cfg *cfg)
+{
+	qmp_ufs_serdes_init(qmp, &cfg->tbls);
+	qmp_ufs_lanes_init(qmp, &cfg->tbls);
+	qmp_ufs_pcs_init(qmp, &cfg->tbls);
 }
 
 static int qmp_ufs_com_init(struct qmp_ufs *qmp)
@@ -886,25 +929,12 @@ static int qmp_ufs_power_on(struct phy *phy)
 {
 	struct qmp_ufs *qmp = phy_get_drvdata(phy);
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
-	void __iomem *tx = qmp->tx;
-	void __iomem *rx = qmp->rx;
 	void __iomem *pcs = qmp->pcs;
 	void __iomem *status;
 	unsigned int val;
 	int ret;
 
-	qmp_ufs_serdes_init(qmp);
-
-	/* Tx, Rx, and PCS configurations */
-	qmp_ufs_configure_lane(tx, cfg->tx_tbl, cfg->tx_tbl_num, 1);
-	qmp_ufs_configure_lane(rx, cfg->rx_tbl, cfg->rx_tbl_num, 1);
-
-	if (cfg->lanes >= 2) {
-		qmp_ufs_configure_lane(qmp->tx2, cfg->tx_tbl, cfg->tx_tbl_num, 2);
-		qmp_ufs_configure_lane(qmp->rx2, cfg->rx_tbl, cfg->rx_tbl_num, 2);
-	}
-
-	qmp_ufs_configure(pcs, cfg->pcs_tbl, cfg->pcs_tbl_num);
+	qmp_ufs_init_registers(qmp, cfg);
 
 	ret = reset_control_deassert(qmp->ufs_reset);
 	if (ret)
-- 
2.25.1

