Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD1C5BDE7E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiITHjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiITHjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:39:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CAF61103;
        Tue, 20 Sep 2022 00:39:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F28D624F7;
        Tue, 20 Sep 2022 07:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8DFC4FEE4;
        Tue, 20 Sep 2022 07:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663659540;
        bh=3mWP8IJ6A2mLlaC+zaZQsvzQRfJ1SsQlxyXRCQSRzJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hh1N+odv1v6NiJSkvmmG4ZlhM4WaMQCJXqaeyNrjLGHQZT/dTvgBvUfzoOUW/K5Qk
         GvzgQWKd6AqpuAjw02KUXCclwbzb16Az6ViQ7rViSepCKPamjsoYXolyFyRlUm9+fz
         AcgMiyp06eA2DUMjRs0MH5e4g7XwZJPo/osM8qQk2tKRJqRg0O2mz1lrVz3aJgLuCS
         DPQVz7ocd+snbvmjKKvcXdJpR9Q3FHbDWYepMIF2KMfL9LCgDUwJYd8/Q14wcaTpzt
         m3L26iv9O6JERce+soWw6FBoSToEjS319PYkjiEl2V+Tzgo6z2QZdwq9ottGOQczA1
         HxDOsE4/0ocYg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oaXqQ-0005RM-ML; Tue, 20 Sep 2022 09:39:02 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 16/17] phy: qcom-qmp-usb: consolidate lane config
Date:   Tue, 20 Sep 2022 09:38:25 +0200
Message-Id: <20220920073826.20811-17-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220920073826.20811-1-johan+linaro@kernel.org>
References: <20220920073826.20811-1-johan+linaro@kernel.org>
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

For legacy reasons, there are two configuration parameters that appear
to describe the number of lanes a PHY has, even if "nlanes" was actually
used for a different purpose.

Replace them both with a new field simply named "lanes".

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 52 ++++++++++---------------
 1 file changed, 20 insertions(+), 32 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index a34320738f60..f01b3022a10d 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -1429,8 +1429,7 @@ static const struct qmp_phy_init_tbl sc8280xp_usb3_uniphy_pcs_tbl[] = {
 
 /* struct qmp_phy_cfg - per-PHY initialization config */
 struct qmp_phy_cfg {
-	/* number of lanes provided by phy */
-	int nlanes;
+	int lanes;
 
 	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
 	const struct qmp_phy_init_tbl *serdes_tbl;
@@ -1470,8 +1469,6 @@ struct qmp_phy_cfg {
 
 	/* true, if PHY has a separate DP_COM control block */
 	bool has_phy_dp_com_ctrl;
-	/* true, if PHY has secondary tx/rx lanes to be configured */
-	bool is_dual_lane_phy;
 
 	/* Offset from PCS to PCS_USB region */
 	unsigned int pcs_usb_offset;
@@ -1603,7 +1600,7 @@ static const char * const qmp_phy_vreg_l[] = {
 };
 
 static const struct qmp_phy_cfg ipq8074_usb3phy_cfg = {
-	.nlanes			= 1,
+	.lanes			= 1,
 
 	.serdes_tbl		= ipq8074_usb3_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(ipq8074_usb3_serdes_tbl),
@@ -1627,7 +1624,7 @@ static const struct qmp_phy_cfg ipq8074_usb3phy_cfg = {
 };
 
 static const struct qmp_phy_cfg msm8996_usb3phy_cfg = {
-	.nlanes			= 1,
+	.lanes			= 1,
 
 	.serdes_tbl		= msm8996_usb3_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(msm8996_usb3_serdes_tbl),
@@ -1651,7 +1648,7 @@ static const struct qmp_phy_cfg msm8996_usb3phy_cfg = {
 };
 
 static const struct qmp_phy_cfg qmp_v3_usb3phy_cfg = {
-	.nlanes			= 1,
+	.lanes			= 2,
 
 	.serdes_tbl		= qmp_v3_usb3_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_serdes_tbl),
@@ -1678,11 +1675,10 @@ static const struct qmp_phy_cfg qmp_v3_usb3phy_cfg = {
 	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
 
 	.has_phy_dp_com_ctrl	= true,
-	.is_dual_lane_phy	= true,
 };
 
 static const struct qmp_phy_cfg sc7180_usb3phy_cfg = {
-	.nlanes			= 1,
+	.lanes			= 2,
 
 	.serdes_tbl		= qmp_v3_usb3_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_serdes_tbl),
@@ -1709,11 +1705,10 @@ static const struct qmp_phy_cfg sc7180_usb3phy_cfg = {
 	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
 
 	.has_phy_dp_com_ctrl	= true,
-	.is_dual_lane_phy	= true,
 };
 
 static const struct qmp_phy_cfg sc8280xp_usb3_uniphy_cfg = {
-	.nlanes			= 1,
+	.lanes			= 1,
 
 	.serdes_tbl		= sc8280xp_usb3_uniphy_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sc8280xp_usb3_uniphy_serdes_tbl),
@@ -1741,7 +1736,7 @@ static const struct qmp_phy_cfg sc8280xp_usb3_uniphy_cfg = {
 };
 
 static const struct qmp_phy_cfg qmp_v3_usb3_uniphy_cfg = {
-	.nlanes			= 1,
+	.lanes			= 1,
 
 	.serdes_tbl		= qmp_v3_usb3_uniphy_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_uniphy_serdes_tbl),
@@ -1769,7 +1764,7 @@ static const struct qmp_phy_cfg qmp_v3_usb3_uniphy_cfg = {
 };
 
 static const struct qmp_phy_cfg msm8998_usb3phy_cfg = {
-	.nlanes                 = 1,
+	.lanes			= 2,
 
 	.serdes_tbl             = msm8998_usb3_serdes_tbl,
 	.serdes_tbl_num         = ARRAY_SIZE(msm8998_usb3_serdes_tbl),
@@ -1790,12 +1785,10 @@ static const struct qmp_phy_cfg msm8998_usb3phy_cfg = {
 	.start_ctrl             = SERDES_START | PCS_START,
 	.pwrdn_ctrl             = SW_PWRDN,
 	.phy_status		= PHYSTATUS,
-
-	.is_dual_lane_phy       = true,
 };
 
 static const struct qmp_phy_cfg sm8150_usb3phy_cfg = {
-	.nlanes			= 1,
+	.lanes			= 2,
 
 	.serdes_tbl		= sm8150_usb3_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_serdes_tbl),
@@ -1826,11 +1819,10 @@ static const struct qmp_phy_cfg sm8150_usb3phy_cfg = {
 	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
 
 	.has_phy_dp_com_ctrl	= true,
-	.is_dual_lane_phy	= true,
 };
 
 static const struct qmp_phy_cfg sm8150_usb3_uniphy_cfg = {
-	.nlanes			= 1,
+	.lanes			= 1,
 
 	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_uniphy_serdes_tbl),
@@ -1861,7 +1853,7 @@ static const struct qmp_phy_cfg sm8150_usb3_uniphy_cfg = {
 };
 
 static const struct qmp_phy_cfg sm8250_usb3phy_cfg = {
-	.nlanes			= 1,
+	.lanes			= 2,
 
 	.serdes_tbl		= sm8150_usb3_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_serdes_tbl),
@@ -1891,11 +1883,10 @@ static const struct qmp_phy_cfg sm8250_usb3phy_cfg = {
 	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
 
 	.has_phy_dp_com_ctrl	= true,
-	.is_dual_lane_phy	= true,
 };
 
 static const struct qmp_phy_cfg sm8250_usb3_uniphy_cfg = {
-	.nlanes			= 1,
+	.lanes			= 1,
 
 	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_uniphy_serdes_tbl),
@@ -1926,7 +1917,7 @@ static const struct qmp_phy_cfg sm8250_usb3_uniphy_cfg = {
 };
 
 static const struct qmp_phy_cfg sdx55_usb3_uniphy_cfg = {
-	.nlanes			= 1,
+	.lanes			= 1,
 
 	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_uniphy_serdes_tbl),
@@ -1957,7 +1948,7 @@ static const struct qmp_phy_cfg sdx55_usb3_uniphy_cfg = {
 };
 
 static const struct qmp_phy_cfg sdx65_usb3_uniphy_cfg = {
-	.nlanes			= 1,
+	.lanes			= 1,
 
 	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_uniphy_serdes_tbl),
@@ -1988,7 +1979,7 @@ static const struct qmp_phy_cfg sdx65_usb3_uniphy_cfg = {
 };
 
 static const struct qmp_phy_cfg sm8350_usb3phy_cfg = {
-	.nlanes			= 1,
+	.lanes			= 2,
 
 	.serdes_tbl		= sm8150_usb3_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_serdes_tbl),
@@ -2018,11 +2009,10 @@ static const struct qmp_phy_cfg sm8350_usb3phy_cfg = {
 	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
 
 	.has_phy_dp_com_ctrl	= true,
-	.is_dual_lane_phy	= true,
 };
 
 static const struct qmp_phy_cfg sm8350_usb3_uniphy_cfg = {
-	.nlanes			= 1,
+	.lanes			= 1,
 
 	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_uniphy_serdes_tbl),
@@ -2053,7 +2043,7 @@ static const struct qmp_phy_cfg sm8350_usb3_uniphy_cfg = {
 };
 
 static const struct qmp_phy_cfg qcm2290_usb3phy_cfg = {
-	.nlanes			= 1,
+	.lanes			= 2,
 
 	.serdes_tbl		= qcm2290_usb3_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(qcm2290_usb3_serdes_tbl),
@@ -2074,8 +2064,6 @@ static const struct qmp_phy_cfg qcm2290_usb3phy_cfg = {
 	.start_ctrl		= SERDES_START | PCS_START,
 	.pwrdn_ctrl		= SW_PWRDN,
 	.phy_status		= PHYSTATUS,
-
-	.is_dual_lane_phy	= true,
 };
 
 static void qmp_usb_configure_lane(void __iomem *base,
@@ -2232,14 +2220,14 @@ static int qmp_usb_power_on(struct phy *phy)
 	/* Tx, Rx, and PCS configurations */
 	qmp_usb_configure_lane(tx, cfg->regs, cfg->tx_tbl, cfg->tx_tbl_num, 1);
 
-	if (cfg->is_dual_lane_phy) {
+	if (cfg->lanes >= 2) {
 		qmp_usb_configure_lane(qphy->tx2, cfg->regs,
 					cfg->tx_tbl, cfg->tx_tbl_num, 2);
 	}
 
 	qmp_usb_configure_lane(rx, cfg->regs, cfg->rx_tbl, cfg->rx_tbl_num, 1);
 
-	if (cfg->is_dual_lane_phy) {
+	if (cfg->lanes >= 2) {
 		qmp_usb_configure_lane(qphy->rx2, cfg->regs,
 					cfg->rx_tbl, cfg->rx_tbl_num, 2);
 	}
@@ -2613,7 +2601,7 @@ int qmp_usb_create(struct device *dev, struct device_node *np, int id,
 	if (cfg->pcs_usb_offset)
 		qphy->pcs_usb = qphy->pcs + cfg->pcs_usb_offset;
 
-	if (cfg->is_dual_lane_phy) {
+	if (cfg->lanes >= 2) {
 		qphy->tx2 = devm_of_iomap(dev, np, 3, NULL);
 		if (IS_ERR(qphy->tx2))
 			return PTR_ERR(qphy->tx2);
-- 
2.35.1

