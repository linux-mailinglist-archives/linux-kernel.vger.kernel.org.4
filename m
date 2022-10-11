Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A6D5FB2FD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiJKNPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJKNOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:14:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351E1DEAF;
        Tue, 11 Oct 2022 06:14:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEABE61196;
        Tue, 11 Oct 2022 13:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C00FC43141;
        Tue, 11 Oct 2022 13:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665494087;
        bh=1+P6yo0W1ucxyznL6paoX+Shezy9L9z8yKXUSd66CkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UR2+h5pv324uOPTvp2zNT9KScvCDUm8HM7dDVDnEgZ6Pl9NYnDzoFCJYUhqBSCw6Y
         g2SVOieBjVHcDgysQZgEWM/QK/4kPk4R2ZD1mP+vOukl7caTwLbPOaYRfUKuY2NNCt
         Qw7S0MJNO1SbZU+QDL70rl9CXUpVIrpN+6n+8cVNmfK36jmdOtZdqzPKw/5wY0L1Ux
         V+tpm4IUPqenKyYAxKIyEg+QrS3o8U5TyqZlT+gVi/yHsG0A5bKQ6227oKbbSkDPVR
         C3gEg1UEIYPFOMVz+XsI/mRtLF/x/bjGZHcHqZvTfxjaQOlk/zVpxqra5EY+9pWn/E
         TNUW29kdm4cyg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oiF5i-0000eh-Cg; Tue, 11 Oct 2022 15:14:38 +0200
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
Subject: [PATCH 03/13] phy: qcom-qmp-combo: drop unused in-layout configuration
Date:   Tue, 11 Oct 2022 15:14:06 +0200
Message-Id: <20221011131416.2478-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221011131416.2478-1-johan+linaro@kernel.org>
References: <20221011131416.2478-1-johan+linaro@kernel.org>
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

The QMP combo PHY driver does not use the "in-layout" configuration
macro to configure registers that are typically accessed using
"regs_layout" arrays (e.g. QPHY_START_CTRL) so drop this unused
feature.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 54 ++++++-----------------
 1 file changed, 14 insertions(+), 40 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 3889dcf73c59..84380852ba5b 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -69,11 +69,6 @@
 struct qmp_phy_init_tbl {
 	unsigned int offset;
 	unsigned int val;
-	/*
-	 * register part of layout ?
-	 * if yes, then offset gives index in the reg-layout
-	 */
-	bool in_layout;
 	/*
 	 * mask of lanes for which this register is written
 	 * for cases when second lane needs different values
@@ -88,14 +83,6 @@ struct qmp_phy_init_tbl {
 		.lane_mask = 0xff,	\
 	}
 
-#define QMP_PHY_INIT_CFG_L(o, v)	\
-	{				\
-		.offset = o,		\
-		.val = v,		\
-		.in_layout = true,	\
-		.lane_mask = 0xff,	\
-	}
-
 #define QMP_PHY_INIT_CFG_LANE(o, v, l)	\
 	{				\
 		.offset = o,		\
@@ -1346,7 +1333,6 @@ static const struct qmp_phy_combo_cfg sm8250_usb3dpphy_cfg = {
 };
 
 static void qmp_combo_configure_lane(void __iomem *base,
-					const unsigned int *regs,
 					const struct qmp_phy_init_tbl tbl[],
 					int num,
 					u8 lane_mask)
@@ -1361,19 +1347,15 @@ static void qmp_combo_configure_lane(void __iomem *base,
 		if (!(t->lane_mask & lane_mask))
 			continue;
 
-		if (t->in_layout)
-			writel(t->val, base + regs[t->offset]);
-		else
-			writel(t->val, base + t->offset);
+		writel(t->val, base + t->offset);
 	}
 }
 
 static void qmp_combo_configure(void __iomem *base,
-				   const unsigned int *regs,
 				   const struct qmp_phy_init_tbl tbl[],
 				   int num)
 {
-	qmp_combo_configure_lane(base, regs, tbl, num, 0xff);
+	qmp_combo_configure_lane(base, tbl, num, 0xff);
 }
 
 static int qmp_combo_serdes_init(struct qmp_phy *qphy)
@@ -1384,28 +1366,24 @@ static int qmp_combo_serdes_init(struct qmp_phy *qphy)
 	const struct qmp_phy_init_tbl *serdes_tbl = cfg->serdes_tbl;
 	int serdes_tbl_num = cfg->serdes_tbl_num;
 
-	qmp_combo_configure(serdes, cfg->regs, serdes_tbl, serdes_tbl_num);
+	qmp_combo_configure(serdes, serdes_tbl, serdes_tbl_num);
 
 	if (cfg->type == PHY_TYPE_DP) {
 		switch (dp_opts->link_rate) {
 		case 1620:
-			qmp_combo_configure(serdes, cfg->regs,
-					       cfg->serdes_tbl_rbr,
+			qmp_combo_configure(serdes, cfg->serdes_tbl_rbr,
 					       cfg->serdes_tbl_rbr_num);
 			break;
 		case 2700:
-			qmp_combo_configure(serdes, cfg->regs,
-					       cfg->serdes_tbl_hbr,
+			qmp_combo_configure(serdes, cfg->serdes_tbl_hbr,
 					       cfg->serdes_tbl_hbr_num);
 			break;
 		case 5400:
-			qmp_combo_configure(serdes, cfg->regs,
-					       cfg->serdes_tbl_hbr2,
+			qmp_combo_configure(serdes, cfg->serdes_tbl_hbr2,
 					       cfg->serdes_tbl_hbr2_num);
 			break;
 		case 8100:
-			qmp_combo_configure(serdes, cfg->regs,
-					       cfg->serdes_tbl_hbr3,
+			qmp_combo_configure(serdes, cfg->serdes_tbl_hbr3,
 					       cfg->serdes_tbl_hbr3_num);
 			break;
 		default:
@@ -2069,29 +2047,25 @@ static int qmp_combo_power_on(struct phy *phy)
 	}
 
 	/* Tx, Rx, and PCS configurations */
-	qmp_combo_configure_lane(tx, cfg->regs, cfg->tx_tbl, cfg->tx_tbl_num, 1);
+	qmp_combo_configure_lane(tx, cfg->tx_tbl, cfg->tx_tbl_num, 1);
 
-	if (cfg->lanes >= 2) {
-		qmp_combo_configure_lane(qphy->tx2, cfg->regs, cfg->tx_tbl,
-					 cfg->tx_tbl_num, 2);
-	}
+	if (cfg->lanes >= 2)
+		qmp_combo_configure_lane(qphy->tx2, cfg->tx_tbl, cfg->tx_tbl_num, 2);
 
 	/* Configure special DP tx tunings */
 	if (cfg->type == PHY_TYPE_DP)
 		cfg->configure_dp_tx(qphy);
 
-	qmp_combo_configure_lane(rx, cfg->regs, cfg->rx_tbl, cfg->rx_tbl_num, 1);
+	qmp_combo_configure_lane(rx, cfg->rx_tbl, cfg->rx_tbl_num, 1);
 
-	if (cfg->lanes >= 2) {
-		qmp_combo_configure_lane(qphy->rx2, cfg->regs, cfg->rx_tbl,
-					 cfg->rx_tbl_num, 2);
-	}
+	if (cfg->lanes >= 2)
+		qmp_combo_configure_lane(qphy->rx2, cfg->rx_tbl, cfg->rx_tbl_num, 2);
 
 	/* Configure link rate, swing, etc. */
 	if (cfg->type == PHY_TYPE_DP)
 		cfg->configure_dp_phy(qphy);
 	else
-		qmp_combo_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
+		qmp_combo_configure(pcs, cfg->pcs_tbl, cfg->pcs_tbl_num);
 
 	if (cfg->has_pwrdn_delay)
 		usleep_range(cfg->pwrdn_delay_min, cfg->pwrdn_delay_max);
-- 
2.35.1

