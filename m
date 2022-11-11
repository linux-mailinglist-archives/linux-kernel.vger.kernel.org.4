Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63892625606
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbiKKI67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbiKKI53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:57:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BB27E9A6;
        Fri, 11 Nov 2022 00:57:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B29AB82476;
        Fri, 11 Nov 2022 08:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E2EC4FEBE;
        Fri, 11 Nov 2022 08:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668157043;
        bh=nWXsAtVF3OLE/Q7SzT/JJOzcMNVMOqmBow0B6bqTAQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lw+V+7JFWvL6CAtkw01384p9gGqy9PJamLZQ+LdL35klKe8wxEXphsXiKQI37QjxF
         3O1AbVavdV3DXEIXVy5+ZD7ygvutZ9EmAarpvbL3/Qhz28IqdormsDeDm/wMhC3z9k
         QMF6uLn7nXoaXhdyLAL/WXwq3lqDh5uOHLPJR1r1IiZj3nY5vo1J1dh1oaa7uN+Vi3
         i0r8Nh1EIUWFupuiwozqQL4ZemK1ZNeDzJB9NAXm0a8eRgX+U37+5xnH7qk11NDVX9
         qjdDnbCz92nl18BWidMJXWtBwAOFIeNbG8WjHmHD+YO23rHsTQgElnHcjmN5H0eEX4
         B8kcAtVred9kQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1otPqJ-0002UH-OC; Fri, 11 Nov 2022 09:56:55 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 11/22] phy: qcom-qmp-combo: clean up serdes initialisation
Date:   Fri, 11 Nov 2022 09:56:32 +0100
Message-Id: <20221111085643.9478-12-johan+linaro@kernel.org>
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

Clean up serdes initialisation somewhat by making the current helper a
dedicated helper for the DP part of the PHY.

Note that no error is currently returned for non-supported link rates.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 49 +++++++++++------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 748fd32a6f72..c059e4aeecdb 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -1313,7 +1313,7 @@ static void qmp_combo_configure(void __iomem *base,
 	qmp_combo_configure_lane(base, tbl, num, 0xff);
 }
 
-static int qmp_combo_serdes_init(struct qmp_phy *qphy)
+static int qmp_combo_dp_serdes_init(struct qmp_phy *qphy)
 {
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
 	void __iomem *serdes = qphy->serdes;
@@ -1323,28 +1323,26 @@ static int qmp_combo_serdes_init(struct qmp_phy *qphy)
 
 	qmp_combo_configure(serdes, serdes_tbl, serdes_tbl_num);
 
-	if (cfg->type == PHY_TYPE_DP) {
-		switch (dp_opts->link_rate) {
-		case 1620:
-			qmp_combo_configure(serdes, cfg->serdes_tbl_rbr,
-					       cfg->serdes_tbl_rbr_num);
-			break;
-		case 2700:
-			qmp_combo_configure(serdes, cfg->serdes_tbl_hbr,
-					       cfg->serdes_tbl_hbr_num);
-			break;
-		case 5400:
-			qmp_combo_configure(serdes, cfg->serdes_tbl_hbr2,
-					       cfg->serdes_tbl_hbr2_num);
-			break;
-		case 8100:
-			qmp_combo_configure(serdes, cfg->serdes_tbl_hbr3,
-					       cfg->serdes_tbl_hbr3_num);
-			break;
-		default:
-			/* Other link rates aren't supported */
-			return -EINVAL;
-		}
+	switch (dp_opts->link_rate) {
+	case 1620:
+		qmp_combo_configure(serdes, cfg->serdes_tbl_rbr,
+				cfg->serdes_tbl_rbr_num);
+		break;
+	case 2700:
+		qmp_combo_configure(serdes, cfg->serdes_tbl_hbr,
+				cfg->serdes_tbl_hbr_num);
+		break;
+	case 5400:
+		qmp_combo_configure(serdes, cfg->serdes_tbl_hbr2,
+				cfg->serdes_tbl_hbr2_num);
+		break;
+	case 8100:
+		qmp_combo_configure(serdes, cfg->serdes_tbl_hbr3,
+				cfg->serdes_tbl_hbr3_num);
+		break;
+	default:
+		/* Other link rates aren't supported */
+		return -EINVAL;
 	}
 
 	return 0;
@@ -1994,7 +1992,7 @@ static int qmp_combo_dp_power_on(struct phy *phy)
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
 	void __iomem *tx = qphy->tx;
 
-	qmp_combo_serdes_init(qphy);
+	qmp_combo_dp_serdes_init(qphy);
 
 	qmp_combo_configure_lane(tx, cfg->tx_tbl, cfg->tx_tbl_num, 1);
 
@@ -2025,6 +2023,7 @@ static int qmp_combo_usb_power_on(struct phy *phy)
 	struct qmp_phy *qphy = phy_get_drvdata(phy);
 	struct qcom_qmp *qmp = qphy->qmp;
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
+	void __iomem *serdes = qphy->serdes;
 	void __iomem *tx = qphy->tx;
 	void __iomem *rx = qphy->rx;
 	void __iomem *pcs = qphy->pcs;
@@ -2032,7 +2031,7 @@ static int qmp_combo_usb_power_on(struct phy *phy)
 	unsigned int val;
 	int ret;
 
-	qmp_combo_serdes_init(qphy);
+	qmp_combo_configure(serdes, cfg->serdes_tbl, cfg->serdes_tbl_num);
 
 	ret = clk_prepare_enable(qphy->pipe_clk);
 	if (ret) {
-- 
2.37.4

