Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC18627BB0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbiKNLJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbiKNLH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:07:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7779220372;
        Mon, 14 Nov 2022 03:07:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 572F061011;
        Mon, 14 Nov 2022 11:07:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB3CC4FF14;
        Mon, 14 Nov 2022 11:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668424034;
        bh=dR6PYnup71SrMpjCURyTzhMSRf1CekmotMz5OcKjKU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XjhbIekuRnFg4k4J+B1YRJYVUcNK8cLM/pJ1YrcQHfEix8GlRgRXr/3cWoA5yfpYR
         UWpTFyQVNtzkxTOuI0/8xRIuzcP0nBR2le9F6ruXffW2z6Ezk653lWvqqPqyYJ66me
         WJtrflSpHo7U6YPIgXMlP9srbmJkCk74SmsaVpdZ/2dl3uvbJ3Go88pKEv2IHn7z5e
         +3Fiu6F3SeR1xbNxZ0qPEkTU9HVL5L/ySm9C1/3W6X04AFnwSwGG4cIl6ZWpd2YrMy
         KykTGW8cFQpgZ2W3EKHab+TPLtqO+0BGnz5D3XOxL8LUrG7EzqdLt53lSVZw+2U3ou
         3V9km3hN0/pkw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ouXIZ-0001F9-43; Mon, 14 Nov 2022 12:06:43 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 16/22] phy: qcom-qmp-combo: add DP configuration tables
Date:   Mon, 14 Nov 2022 12:06:15 +0100
Message-Id: <20221114110621.4639-17-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221114110621.4639-1-johan+linaro@kernel.org>
References: <20221114110621.4639-1-johan+linaro@kernel.org>
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

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 45 ++++++++++++-----------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index d3fd6bde4af5..2588cfa5e81e 100644
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

