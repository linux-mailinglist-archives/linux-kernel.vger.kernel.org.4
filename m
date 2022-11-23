Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C93A635149
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 08:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbiKWHtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 02:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236054AbiKWHsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 02:48:55 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDAFFA717
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 23:48:54 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 62so16061459pgb.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 23:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikUhsMB1K+IImCkguofeQ85gazjJuE8IZCvzMOqkVlc=;
        b=N6BWzgRM3GU2/ZA+dngSkO6sddxPS8QvVv9bGitcc/SXgncaMWgeCWJNRTPBh9w0Fp
         HoELivWACbVF6BP8dLXxT8Cq4N5u//RgqiIK+iDDXqhASkd4P2A+DWcUIIL53EkqKMO+
         yL/tT6pYGM2SiugPqnnE9k++/AT6+gXji7fHMAzv9gxe94fAopacgp8kwNsE6a5VpNTD
         LsKA29379+w5qrrgDNv22B6ccCpUwDVrrR3Eg3xlIW1kwCvW/kfTZAsO08FPtuB0ARtX
         na4jAKntKm1PDnVZ06+cxi/B1/Z5hSfmWEqTVVWbHur9zwoWIhQt3FHiWpxOKNi2TeVK
         hhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikUhsMB1K+IImCkguofeQ85gazjJuE8IZCvzMOqkVlc=;
        b=RDgzQOwC7Gf+xLbDLhJSvqGVJmz8JmNfQzxQtN8AlnB5uVSgA2+D2rZXSHnGgzNkGO
         1XHsRlIIeBpWikS0eNyvM9rD+LahDa/rLPp8asXopCuhDaglY2tS+IFoqX1w3AccMJrD
         7kqFjDLIYzYPxceQMmvgX3ZasmE5/mNPlDa6ovuNl5R76ph8qm1pq3G1s9kon9x+Fict
         dBLb/uc6Xkj/b4G2ipIfzhCyOUt18tjoT7qx7KIK21SGMJN16OlACbbslKY1j90rkIzn
         iq4J5CoV+SHcABHUKqTbeEBxqSSc9HOYj21NLvMfFDc8VExZDBDUfUvL0UtrXIQYMvMw
         uYcg==
X-Gm-Message-State: ANoB5pmFiKVhp8R4GBnTpncV9KMVW5BN1KfveOCBIO3UGFXdHPkYIot4
        vw9lA8AexQ0UOw8n0VSGBaoP
X-Google-Smtp-Source: AA0mqf7F0L+mYTQ2+e6gAYvmxg1wwhlAoeAH8qLK20IrK9dx+Rymck5OAcM9bwT77aVUN2iN7mbS8w==
X-Received: by 2002:a63:f003:0:b0:45f:bf86:c917 with SMTP id k3-20020a63f003000000b0045fbf86c917mr25393662pgh.201.1669189733521;
        Tue, 22 Nov 2022 23:48:53 -0800 (PST)
Received: from localhost.localdomain ([117.202.191.0])
        by smtp.gmail.com with ESMTPSA id s16-20020a170902a51000b001869f2120a5sm13334059plq.34.2022.11.22.23.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 23:48:52 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org
Cc:     quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        abel.vesa@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 03/20] phy: qcom-qmp-ufs: Move register settings to qmp_phy_cfg_tbls struct
Date:   Wed, 23 Nov 2022 13:18:09 +0530
Message-Id: <20221123074826.95369-4-manivannan.sadhasivam@linaro.org>
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

As done for Qcom PCIe PHY driver, let's move the register settings to the
common qmp_phy_cfg_tbls struct. This helps in adding any additional PHY
settings needed for functionalities like HS-G4 in the future by adding one
more instance of the qmp_phy_cfg_tbls.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 192 ++++++++++++++----------
 1 file changed, 112 insertions(+), 80 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 443f2714a8f1..3b7b36e32f5d 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -531,19 +531,24 @@ static const struct qmp_phy_init_tbl sm8350_ufsphy_pcs[] = {
 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
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
@@ -660,12 +665,14 @@ static const char * const qmp_phy_vreg_l[] = {
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
@@ -685,14 +692,16 @@ static const struct qmp_phy_cfg msm8996_ufsphy_cfg = {
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
@@ -709,14 +718,16 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
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
@@ -732,14 +743,16 @@ static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
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
@@ -754,14 +767,16 @@ static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
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
@@ -776,14 +791,16 @@ static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
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
@@ -826,16 +843,50 @@ static void qmp_ufs_configure(void __iomem *base,
 	qmp_ufs_configure_lane(base, regs, tbl, num, 0xff);
 }
 
-static int qmp_ufs_serdes_init(struct qmp_phy *qphy)
+static void qmp_ufs_serdes_init(struct qmp_phy *qphy, const struct qmp_phy_cfg_tbls *tbls)
 {
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
 	void __iomem *serdes = qphy->serdes;
-	const struct qmp_phy_init_tbl *serdes_tbl = cfg->serdes_tbl;
-	int serdes_tbl_num = cfg->serdes_tbl_num;
 
-	qmp_ufs_configure(serdes, cfg->regs, serdes_tbl, serdes_tbl_num);
+	if (!tbls)
+		return;
+
+	qmp_ufs_configure(serdes, cfg->regs, tbls->serdes, tbls->serdes_num);
+}
 
-	return 0;
+static void qmp_ufs_lanes_init(struct qmp_phy *qphy, const struct qmp_phy_cfg_tbls *tbls)
+{
+	const struct qmp_phy_cfg *cfg = qphy->cfg;
+	void __iomem *tx = qphy->tx;
+	void __iomem *rx = qphy->rx;
+
+	qmp_ufs_configure_lane(tx, cfg->regs, tbls->tx, tbls->tx_num, 1);
+
+	if (cfg->lanes >= 2)
+		qmp_ufs_configure_lane(qphy->tx2, cfg->regs, tbls->tx, tbls->tx_num, 2);
+
+	qmp_ufs_configure_lane(rx, cfg->regs, tbls->rx, tbls->rx_num, 1);
+
+	if (cfg->lanes >= 2)
+		qmp_ufs_configure_lane(qphy->rx2, cfg->regs, tbls->rx, tbls->rx_num, 2);
+}
+
+static void qmp_ufs_pcs_init(struct qmp_phy *qphy, const struct qmp_phy_cfg_tbls *tbls)
+{
+	const struct qmp_phy_cfg *cfg = qphy->cfg;
+	void __iomem *pcs = qphy->pcs;
+
+	if (!tbls)
+		return;
+
+	qmp_ufs_configure(pcs, cfg->regs, tbls->pcs, tbls->pcs_num);
+}
+
+static void qmp_ufs_init_registers(struct qmp_phy *qphy, const struct qmp_phy_cfg *cfg)
+{
+	qmp_ufs_serdes_init(qphy, &cfg->tbls);
+	qmp_ufs_lanes_init(qphy, &cfg->tbls);
+	qmp_ufs_pcs_init(qphy, &cfg->tbls);
 }
 
 static int qmp_ufs_com_init(struct qmp_phy *qphy)
@@ -933,31 +984,12 @@ static int qmp_ufs_power_on(struct phy *phy)
 	struct qmp_phy *qphy = phy_get_drvdata(phy);
 	struct qcom_qmp *qmp = qphy->qmp;
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
-	void __iomem *tx = qphy->tx;
-	void __iomem *rx = qphy->rx;
 	void __iomem *pcs = qphy->pcs;
 	void __iomem *status;
 	unsigned int mask, val, ready;
 	int ret;
 
-	qmp_ufs_serdes_init(qphy);
-
-	/* Tx, Rx, and PCS configurations */
-	qmp_ufs_configure_lane(tx, cfg->regs, cfg->tx_tbl, cfg->tx_tbl_num, 1);
-
-	if (cfg->lanes >= 2) {
-		qmp_ufs_configure_lane(qphy->tx2, cfg->regs,
-					cfg->tx_tbl, cfg->tx_tbl_num, 2);
-	}
-
-	qmp_ufs_configure_lane(rx, cfg->regs, cfg->rx_tbl, cfg->rx_tbl_num, 1);
-
-	if (cfg->lanes >= 2) {
-		qmp_ufs_configure_lane(qphy->rx2, cfg->regs,
-					cfg->rx_tbl, cfg->rx_tbl_num, 2);
-	}
-
-	qmp_ufs_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
+	qmp_ufs_init_registers(qphy, cfg);
 
 	ret = reset_control_deassert(qmp->ufs_reset);
 	if (ret)
-- 
2.25.1

