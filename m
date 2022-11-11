Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18276625604
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbiKKI6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbiKKI53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:57:29 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3267B216;
        Fri, 11 Nov 2022 00:57:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 42458CE2609;
        Fri, 11 Nov 2022 08:57:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FDAC4FF17;
        Fri, 11 Nov 2022 08:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668157043;
        bh=M6PMy71TxpnUyb6Ky8baPh4FO70qJkNnvZrbWxWlYXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z7MGCxpemNxM+5ozhYkYo5FcuYBf5u1Fore9VvfWfvgSDHy9U7ILkqLFS3SUUGwBU
         HoVO2SgVgPlqGVGUeBxEcP7LDrlaZsmcga5aUEfnkaVQ4HpCEKsuY5r1hZQzKmhDN6
         xcsulP9jrE4b3fLqdDWNCnX2DNKOUmAJYDY2I4ROk8AuhlgRjoy6izdwl1VDGh4K5n
         jO0q/5073oc7aebCufriI+XpiLDwbd5eZLl6xLFzIFafSoBlrm9RpvP5YTzkgAnoXO
         qPu6JJBDoL5YQhMqSkIS1ANmXpqIOzxMydC8CoChFCiPFQSJFkCYY4psnsxOVEetfj
         s64uKMBoAtxew==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1otPqK-0002UW-63; Fri, 11 Nov 2022 09:56:56 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 16/22] phy: qcom-qmp-combo: add DP configuration tables
Date:   Fri, 11 Nov 2022 09:56:37 +0100
Message-Id: <20221111085643.9478-17-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221111085643.9478-1-johan+linaro@kernel.org>
References: <20221111085643.9478-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for merging the USB and DP configurations, add dedicated
pointers for the DP serdes and tx tables to the configurations.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 45 ++++++++++++-----------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 499368e19e00..b27d1821116c 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -816,6 +816,11 @@ struct qmp_phy_cfg {
 	const struct qmp_phy_init_tbl *pcs_usb_tbl;
 	int pcs_usb_tbl_num;
 
+	const struct qmp_phy_init_tbl *dp_serdes_tbl;
+	int dp_serdes_tbl_num;
+	const struct qmp_phy_init_tbl *dp_tx_tbl;
+	int dp_tx_tbl_num;
+
 	/* Init sequence for DP PHY block link rates */
 	const struct qmp_phy_init_tbl *serdes_tbl_rbr;
 	int serdes_tbl_rbr_num;
@@ -1030,10 +1035,10 @@ static const struct qmp_phy_cfg sc7180_dpphy_cfg = {
 	.type			= PHY_TYPE_DP,
 	.lanes			= 2,
 
-	.serdes_tbl		= qmp_v3_dp_serdes_tbl,
-	.serdes_tbl_num		= ARRAY_SIZE(qmp_v3_dp_serdes_tbl),
-	.tx_tbl			= qmp_v3_dp_tx_tbl,
-	.tx_tbl_num		= ARRAY_SIZE(qmp_v3_dp_tx_tbl),
+	.dp_serdes_tbl		= qmp_v3_dp_serdes_tbl,
+	.dp_serdes_tbl_num	= ARRAY_SIZE(qmp_v3_dp_serdes_tbl),
+	.dp_tx_tbl		= qmp_v3_dp_tx_tbl,
+	.dp_tx_tbl_num		= ARRAY_SIZE(qmp_v3_dp_tx_tbl),
 
 	.serdes_tbl_rbr		= qmp_v3_dp_serdes_tbl_rbr,
 	.serdes_tbl_rbr_num	= ARRAY_SIZE(qmp_v3_dp_serdes_tbl_rbr),
@@ -1147,10 +1152,10 @@ static const struct qmp_phy_cfg sc8180x_dpphy_cfg = {
 	.type			= PHY_TYPE_DP,
 	.lanes			= 2,
 
-	.serdes_tbl		= qmp_v4_dp_serdes_tbl,
-	.serdes_tbl_num		= ARRAY_SIZE(qmp_v4_dp_serdes_tbl),
-	.tx_tbl			= qmp_v4_dp_tx_tbl,
-	.tx_tbl_num		= ARRAY_SIZE(qmp_v4_dp_tx_tbl),
+	.dp_serdes_tbl		= qmp_v4_dp_serdes_tbl,
+	.dp_serdes_tbl_num	= ARRAY_SIZE(qmp_v4_dp_serdes_tbl),
+	.dp_tx_tbl		= qmp_v4_dp_tx_tbl,
+	.dp_tx_tbl_num		= ARRAY_SIZE(qmp_v4_dp_tx_tbl),
 
 	.serdes_tbl_rbr		= qmp_v4_dp_serdes_tbl_rbr,
 	.serdes_tbl_rbr_num	= ARRAY_SIZE(qmp_v4_dp_serdes_tbl_rbr),
@@ -1203,10 +1208,10 @@ static const struct qmp_phy_cfg sc8280xp_usb43dp_dp_cfg = {
 	.type			= PHY_TYPE_DP,
 	.lanes			= 2,
 
-	.serdes_tbl		= qmp_v5_dp_serdes_tbl,
-	.serdes_tbl_num		= ARRAY_SIZE(qmp_v5_dp_serdes_tbl),
-	.tx_tbl			= qmp_v5_5nm_dp_tx_tbl,
-	.tx_tbl_num		= ARRAY_SIZE(qmp_v5_5nm_dp_tx_tbl),
+	.dp_serdes_tbl		= qmp_v5_dp_serdes_tbl,
+	.dp_serdes_tbl_num	= ARRAY_SIZE(qmp_v5_dp_serdes_tbl),
+	.dp_tx_tbl		= qmp_v5_5nm_dp_tx_tbl,
+	.dp_tx_tbl_num		= ARRAY_SIZE(qmp_v5_5nm_dp_tx_tbl),
 
 	.serdes_tbl_rbr		= qmp_v4_dp_serdes_tbl_rbr,
 	.serdes_tbl_rbr_num	= ARRAY_SIZE(qmp_v4_dp_serdes_tbl_rbr),
@@ -1263,10 +1268,10 @@ static const struct qmp_phy_cfg sm8250_dpphy_cfg = {
 	.type			= PHY_TYPE_DP,
 	.lanes			= 2,
 
-	.serdes_tbl		= qmp_v4_dp_serdes_tbl,
-	.serdes_tbl_num		= ARRAY_SIZE(qmp_v4_dp_serdes_tbl),
-	.tx_tbl			= qmp_v4_dp_tx_tbl,
-	.tx_tbl_num		= ARRAY_SIZE(qmp_v4_dp_tx_tbl),
+	.dp_serdes_tbl		= qmp_v4_dp_serdes_tbl,
+	.dp_serdes_tbl_num	= ARRAY_SIZE(qmp_v4_dp_serdes_tbl),
+	.dp_tx_tbl		= qmp_v4_dp_tx_tbl,
+	.dp_tx_tbl_num		= ARRAY_SIZE(qmp_v4_dp_tx_tbl),
 
 	.serdes_tbl_rbr		= qmp_v4_dp_serdes_tbl_rbr,
 	.serdes_tbl_rbr_num	= ARRAY_SIZE(qmp_v4_dp_serdes_tbl_rbr),
@@ -1324,10 +1329,8 @@ static int qmp_combo_dp_serdes_init(struct qmp_phy *qphy)
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
 	void __iomem *serdes = qphy->dp_serdes;
 	const struct phy_configure_opts_dp *dp_opts = &qphy->dp_opts;
-	const struct qmp_phy_init_tbl *serdes_tbl = cfg->serdes_tbl;
-	int serdes_tbl_num = cfg->serdes_tbl_num;
 
-	qmp_combo_configure(serdes, serdes_tbl, serdes_tbl_num);
+	qmp_combo_configure(serdes, cfg->dp_serdes_tbl, cfg->dp_serdes_tbl_num);
 
 	switch (dp_opts->link_rate) {
 	case 1620:
@@ -2000,10 +2003,10 @@ static int qmp_combo_dp_power_on(struct phy *phy)
 
 	qmp_combo_dp_serdes_init(qphy);
 
-	qmp_combo_configure_lane(tx, cfg->tx_tbl, cfg->tx_tbl_num, 1);
+	qmp_combo_configure_lane(tx, cfg->dp_tx_tbl, cfg->dp_tx_tbl_num, 1);
 
 	if (cfg->lanes >= 2)
-		qmp_combo_configure_lane(qphy->dp_tx2, cfg->tx_tbl, cfg->tx_tbl_num, 2);
+		qmp_combo_configure_lane(qphy->dp_tx2, cfg->dp_tx_tbl, cfg->dp_tx_tbl_num, 2);
 
 	/* Configure special DP tx tunings */
 	cfg->configure_dp_tx(qphy);
-- 
2.37.4

