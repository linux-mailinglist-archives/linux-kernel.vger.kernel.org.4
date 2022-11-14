Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A56627BA0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbiKNLIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiKNLH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:07:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDCD20F55;
        Mon, 14 Nov 2022 03:07:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA255B80DC1;
        Mon, 14 Nov 2022 11:07:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBEA3C4315E;
        Mon, 14 Nov 2022 11:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668424034;
        bh=qn5RumtVltb51JOcYVlk6Xg93g2ZXcIIgZeoxH4IrpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=umgD14FOPeBWkEcTI2k+nkYTYahyQkRgK9iEa0oIyKTLD/cRM/EvBkt728Nmip6XD
         35dczSp/Z5SDunvyhmd3sI9laXhJm+Q+wZmmPmJ7alc6gPZL2vmUnBKcIpel4GpYAe
         ztfSgNl7Hh5hfKBJJV4Hjabg7mcHceDupgnOFrBBn0Ab6s9UUwgdp8bEyrWt+LGhDl
         ApdI4q34ejVUL9G0ZXW1FYjudwax8KcXUWccJYRsjp+BJLdAP1LjY0Kz420ejT9fnV
         tOB7mUd6YvNzcEwVvlNkW59UOmPsZN4BASJbTWqgdYxc5LRRi2mvSdkh0Xfo2tSJt9
         SGfRfr7l3P9bg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ouXIY-0001Ej-DO; Mon, 14 Nov 2022 12:06:42 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 08/22] phy: qcom-qmp-combo: separate USB and DP init ops
Date:   Mon, 14 Nov 2022 12:06:07 +0100
Message-Id: <20221114110621.4639-9-johan+linaro@kernel.org>
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

Separate the USB and DP init and exit operations by calling the common
initialisation code directly from the USB operation and adding a "dp"
infix to the DP callbacks.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 36 ++++++++++++-----------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index ae04f6219fd2..5d985195df38 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -1964,7 +1964,7 @@ static int qmp_combo_com_exit(struct qmp_phy *qphy)
 	return 0;
 }
 
-static int qmp_combo_init(struct phy *phy)
+static int qmp_combo_dp_init(struct phy *phy)
 {
 	struct qmp_phy *qphy = phy_get_drvdata(phy);
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
@@ -1974,8 +1974,16 @@ static int qmp_combo_init(struct phy *phy)
 	if (ret)
 		return ret;
 
-	if (cfg->type == PHY_TYPE_DP)
-		cfg->dp_aux_init(qphy);
+	cfg->dp_aux_init(qphy);
+
+	return 0;
+}
+
+static int qmp_combo_dp_exit(struct phy *phy)
+{
+	struct qmp_phy *qphy = phy_get_drvdata(phy);
+
+	qmp_combo_com_exit(qphy);
 
 	return 0;
 }
@@ -2073,38 +2081,32 @@ static int qmp_combo_power_off(struct phy *phy)
 	return 0;
 }
 
-static int qmp_combo_exit(struct phy *phy)
-{
-	struct qmp_phy *qphy = phy_get_drvdata(phy);
-
-	qmp_combo_com_exit(qphy);
-
-	return 0;
-}
-
 static int qmp_combo_usb_init(struct phy *phy)
 {
+	struct qmp_phy *qphy = phy_get_drvdata(phy);
 	int ret;
 
-	ret = qmp_combo_init(phy);
+	ret = qmp_combo_com_init(qphy);
 	if (ret)
 		return ret;
 
 	ret = qmp_combo_power_on(phy);
 	if (ret)
-		qmp_combo_exit(phy);
+		qmp_combo_com_exit(qphy);
 
 	return ret;
 }
 
 static int qmp_combo_usb_exit(struct phy *phy)
 {
+	struct qmp_phy *qphy = phy_get_drvdata(phy);
 	int ret;
 
 	ret = qmp_combo_power_off(phy);
 	if (ret)
 		return ret;
-	return qmp_combo_exit(phy);
+
+	return qmp_combo_com_exit(qphy);
 }
 
 static int qmp_combo_usb_set_mode(struct phy *phy, enum phy_mode mode, int submode)
@@ -2124,12 +2126,12 @@ static const struct phy_ops qmp_combo_usb_phy_ops = {
 };
 
 static const struct phy_ops qmp_combo_dp_phy_ops = {
-	.init		= qmp_combo_init,
+	.init		= qmp_combo_dp_init,
 	.configure	= qcom_qmp_dp_phy_configure,
 	.power_on	= qmp_combo_power_on,
 	.calibrate	= qcom_qmp_dp_phy_calibrate,
 	.power_off	= qmp_combo_power_off,
-	.exit		= qmp_combo_exit,
+	.exit		= qmp_combo_dp_exit,
 	.owner		= THIS_MODULE,
 };
 
-- 
2.37.4

