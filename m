Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9223C66A9D2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 08:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjANHK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 02:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjANHKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 02:10:32 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F8DC13E2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 23:10:29 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id y1so25574980plb.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 23:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j77vUojmaXNdiq5PPtL4B2CuOmOYtzouMqHjRpQWvt4=;
        b=e/9z0M1Tg0JDphRL8TPRj5fcG3gvkB8PcU/daHFx54Kf6n9TM5bxHh6+ZM7+zT4Byr
         6Khb1HHDON239/A1opdtdSZKFygnbha2Vbh8X20Jzu+tlIAaNKHbjyUJ4+9/ohAUUk0z
         lfikVvixMzjHM0mSf9F++auv8VTFt59xfrLR1Hz7sO3wig2SqCE5CkCaOyVlHFeZ+q5y
         p4AynxEtr/lcTqQSa5lqBV7tDIqyMUYZpO36/Of08SokNb7Um2buNB1gKjHEzE/gYWv+
         CO6p7vkOt8sUQ73KwFBjTDw/kMZLhldlmJGT3JBe3q/OlZ/+Ux0Ij7hqXKiBV8wzip5x
         4UiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j77vUojmaXNdiq5PPtL4B2CuOmOYtzouMqHjRpQWvt4=;
        b=tcjURFwXIZTmKiIiYeFU9NhdPOtAiQUobNaQYNMkvSJAdM4BKq6MP55dyJl1pFb8IG
         BvyH/cazvkNaLGJCb9AInFFk0xjRR3vkAbPVhYcHHp11IE1Y4Tzyi5E+y6XFU/46XJ4i
         5tZES6fqx8JcFy07W0Hq8bDe9to96FlTptzctgfZ9WCXpFIx/8qYRguIlb+dPx+7CtRx
         jCWBVzkZU88eTkjWACfUJ0ZBp+4ocSRjdyoXcZpjNbjKOey2u+Xyvh3zzOce1uF2r7pR
         HknpTyFESfgm81sN4t+Y3JpH+u6mc690p0NQZwEw+hDop6MAq4ZEuhDTyncGvOHbZkYq
         lZEQ==
X-Gm-Message-State: AFqh2kq4wXO3UEuAIQXH6A0szCX0BcAbAoy+kIEHzqA9eBwHojFp6Xvq
        K+dNTMHg9rn59mAVN9zrHySD
X-Google-Smtp-Source: AMrXdXuww1adpz4ksLJ7RgO1ub/cvKIY/nkbIgG+tE5LCqriiOvOgti1zl7LGae0/59U0HzZT6ZrrQ==
X-Received: by 2002:a17:903:324b:b0:194:5066:fc20 with SMTP id ji11-20020a170903324b00b001945066fc20mr11902074plb.40.1673680228508;
        Fri, 13 Jan 2023 23:10:28 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.156])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902e30a00b00192a04bc620sm15225358plc.295.2023.01.13.23.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 23:10:27 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vkoul@kernel.org
Cc:     andersson@kernel.org, quic_cang@quicinc.com,
        quic_asutoshd@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        abel.vesa@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 03/12] phy: qcom-qmp-ufs: Move register settings to qmp_phy_cfg_tbls struct
Date:   Sat, 14 Jan 2023 12:40:00 +0530
Message-Id: <20230114071009.88102-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230114071009.88102-1-manivannan.sadhasivam@linaro.org>
References: <20230114071009.88102-1-manivannan.sadhasivam@linaro.org>
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
index 5645637e7773..90d644fb321b 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -532,21 +532,26 @@ struct qmp_ufs_offsets {
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
@@ -637,12 +642,14 @@ static const struct qmp_ufs_offsets qmp_ufs_offsets_v5 = {
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
@@ -660,14 +667,16 @@ static const struct qmp_phy_cfg sc8280xp_ufsphy_cfg = {
 
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
@@ -678,14 +687,16 @@ static const struct qmp_phy_cfg sc8280xp_ufsphy_cfg = {
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
@@ -700,14 +711,16 @@ static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
 
 	.offsets		= &qmp_ufs_offsets_v5,
 
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
@@ -720,14 +733,16 @@ static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
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
@@ -738,14 +753,16 @@ static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
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
@@ -756,14 +773,16 @@ static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
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
@@ -797,16 +816,40 @@ static void qmp_ufs_configure(void __iomem *base,
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
@@ -893,25 +936,12 @@ static int qmp_ufs_power_on(struct phy *phy)
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

