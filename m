Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CACD627BA8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbiKNLIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236650AbiKNLH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:07:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF4520F63;
        Mon, 14 Nov 2022 03:07:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D0D96101F;
        Mon, 14 Nov 2022 11:07:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464A3C4FEBA;
        Mon, 14 Nov 2022 11:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668424034;
        bh=7Z6mQ4Faw+KA0p9ntmd5ekJgCbfnfoWcFNq+lpBc2pk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hdfw/dGG2gIqSVetYJvkrfYCj7RmCg6Q+vefjxVIqaS5Cdjc+/P9DOq4l57WNT1t6
         VElkoLzS3joikywejkVIZ+4zZOIunltKLkWKeur/ktugY28bk2eNcoZadXQuDzs9sH
         jtIlfyyAQp7AE9ZayuhPm3jZpBd/0ffymV8CUgbwdLla4ieYsEpKm1lQQ/vPzR11zE
         IzofLRI8zZ9UJn8EXg43cZoXotSMTokQ0efkaXrWoYkfiUmmv7r//6cOSAmsHbirJI
         D6QFj07Bewg7yW7K8GUupkM/+h4s0ai5aWh+ZcTV5n5qND12h32paVvlO7hBggz5lR
         aOjEtTzm1F/eA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ouXIY-0001Eu-MI; Mon, 14 Nov 2022 12:06:42 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 11/22] phy: qcom-qmp-combo: clean up serdes initialisation
Date:   Mon, 14 Nov 2022 12:06:10 +0100
Message-Id: <20221114110621.4639-12-johan+linaro@kernel.org>
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

Clean up serdes initialisation somewhat by making the current helper a
dedicated helper for the DP part of the PHY.

Note that no error is currently returned for non-supported link rates.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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

