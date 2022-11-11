Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA526255ED
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbiKKI5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbiKKI5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:57:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41467C8D0;
        Fri, 11 Nov 2022 00:57:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38C1361EFE;
        Fri, 11 Nov 2022 08:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7D9C43166;
        Fri, 11 Nov 2022 08:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668157043;
        bh=zZ3R6y73sAEmGUBnoaMqt7CyCvH2RDT2V8L5CYQqJvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oxhMWewmJZN7bkeAxI7wKBy/HmVmuHaVdhNt+xX5XrOo/S8e/GJNrCChBqSmF3sB0
         XMUQ3Mgq1vk31ygaxjj6glEszZIl8WNcQkDT/hNTMet5dOhHDvHAiqYMx39+ArsdSO
         3k6RFhlC2pyCJc4KinFnTCTIpDVuk/PfrPPxoxEYWfskcgpvM+SOqontdikEkRnfO+
         2Q08sniNOsr7pEw/oqqIPuP4qfYz0AeXNhMtogEe1JbfB2BHqyoQxpbGdCL0zo/P/H
         kxoHPIai4+9s2ZI5Ivcx3kHjObX2kJPGT2VxFLUMVnY7EUJsWhyRuWg3a0irGCgw6f
         47BqEmbI34dcQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1otPqJ-0002U7-FY; Fri, 11 Nov 2022 09:56:55 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 08/22] phy: qcom-qmp-combo: separate USB and DP init ops
Date:   Fri, 11 Nov 2022 09:56:29 +0100
Message-Id: <20221111085643.9478-9-johan+linaro@kernel.org>
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

Separate the USB and DP init and exit operations by calling the common
initialisation code directly from the USB operation and adding a "dp"
infix to the DP callbacks.

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

