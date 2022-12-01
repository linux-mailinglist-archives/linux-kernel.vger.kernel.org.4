Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E8063F66A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 18:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiLARoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 12:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiLARoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 12:44:05 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF890A8FDA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 09:44:02 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 6so2273601pgm.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 09:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZwPoT1fe/AbrXHiFlm2qDDqAqxU4APIIlW6ei07no0=;
        b=wYUTYSCLYnnTWYviL+MglDv0fMbOdkvYRBnBo2TBoBk7Kxr/egysIiiV4EAMMtoRvT
         L3XSug9m/7i30vh4GMAjfBf4TozMvcs3hp7/exNltA/7/PPUksEYBZlR/FOy2HPuCRvk
         5nHJ0Bn7GCdoXxVZFfu5dJy8EtD6sKlg3TgWoq9Dp/6pa2vnrTYnVg0AIW0m5tb++479
         GhaEaQ02G1A2QB7GgjrMh2wK11VDnhrcBMIzg5bU2TlPM3Ql6aPpAwU1i1Tk6/NChKL+
         PprziLA+6fCXB2bx/nIaqH28flrHTIjf2rP7ne2heFtslgjA4hfGdPHBB1vDmzYA9dy5
         YxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZwPoT1fe/AbrXHiFlm2qDDqAqxU4APIIlW6ei07no0=;
        b=bTCx4Dspik+tgRcnxX6NZ5Q6YA7D0itgJRYPn3aFoI5TmCBIaO4qbctFzGA63ncy32
         F6snIOMoeMq51ANS1ne9fAO87v9zO7K4TuIhVMJDe//MDt1QqAdfW88seOktmBUhEalP
         5XFjSig38jT1C5DpBsOxbW5rZUpsleFinZDwNIaJ+zn/awNq501rOinENkTAGa/mxHzl
         g6QhbucltuQpOgimoQKBvhE9q+o3i25E3gTNlsVFajuZQNOBPn+euj8wGiWnwxRr4EN4
         e4XsAUa8KDRVbpyofhF7uCqq2Nhfd2UoxZT+P54l2Xa3rN5Sswc0ZnRSVizHSahomRRJ
         zplQ==
X-Gm-Message-State: ANoB5pmBkxQhJVKgO8tz+C9Uqi1doUL9pRSFBhw3OW5e69eBRGO1lupD
        51ndi38QRq27SuFL7AKQsrQK
X-Google-Smtp-Source: AA0mqf7YZQ2j/OU29nWieT0uVO4wkBZBzs9BSC8dHcWGu40tE1XcC2P3KuewY6dK9BR6n0wFs7Ap1g==
X-Received: by 2002:a62:3006:0:b0:554:7525:7acf with SMTP id w6-20020a623006000000b0055475257acfmr48097473pfw.44.1669916642275;
        Thu, 01 Dec 2022 09:44:02 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.39])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016d9b101413sm3898743pll.200.2022.12.01.09.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 09:44:01 -0800 (PST)
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
Subject: [PATCH v4 03/23] phy: qcom-qmp-ufs: Move register settings to qmp_phy_cfg_tbls struct
Date:   Thu,  1 Dec 2022 23:13:08 +0530
Message-Id: <20221201174328.870152-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org>
References: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org>
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

As done for Qcom PCIe PHY driver, let's move the register settings to the
common qmp_phy_cfg_tbls struct. This helps in adding any additional PHY
settings needed for functionalities like HS-G4 in the future by adding one
more instance of the qmp_phy_cfg_tbls.

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

