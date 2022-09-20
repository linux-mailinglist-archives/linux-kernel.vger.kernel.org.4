Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4C65BDE6D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiITHjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiITHjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:39:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56E6606B4;
        Tue, 20 Sep 2022 00:39:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60632B82558;
        Tue, 20 Sep 2022 07:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1191CC433C1;
        Tue, 20 Sep 2022 07:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663659539;
        bh=ZMg+DLlcdSNqveTVoiGMNLqinsWBf1qIoufFezsHv90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=deUePSbjI1qt9UmHdaQMj3rR5fi8uXynqnSpclwKlorrntxIwYDNKY2m42uLA8qoq
         cuvOsseLwP5kucB25dI5Wtlsh3NqiyuuUm3ET9Huh1psKdattEn1gRXF/kvPQpfgPj
         9QGqa8ODqWetiq62ww9LQTLEB1UjPqeSeTUx41mmLDXwubw2lDObuCOlgp+ymbHOej
         q0g5KEiEQyQMUqjrLEED6b5ooMoNOKWWKgiLgv+u12FLnZOzCvB7L2omYme5xG2xdp
         wbyWsRZhUdfEdQywd/237/FPzDLz9ooD0aUnXdI4dViZbNtUtmTQwHfdPZafNM9Leb
         qFG1tWHmtDCYg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oaXqP-0005Qr-Pe; Tue, 20 Sep 2022 09:39:01 +0200
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
Subject: [PATCH 06/17] phy: qcom-qmp-usb: drop init and exit wrappers
Date:   Tue, 20 Sep 2022 09:38:15 +0200
Message-Id: <20220920073826.20811-7-johan+linaro@kernel.org>
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

Drop the unnecessary PHY init and exit callback wrappers.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 29 ++++---------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index 03481b6f1c35..a42e13905c15 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -2125,8 +2125,9 @@ static int qmp_usb_serdes_init(struct qmp_phy *qphy)
 	return 0;
 }
 
-static int qmp_usb_com_init(struct qmp_phy *qphy)
+static int qmp_usb_init(struct phy *phy)
 {
+	struct qmp_phy *qphy = phy_get_drvdata(phy);
 	struct qcom_qmp *qmp = qphy->qmp;
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
 	void __iomem *pcs = qphy->pcs;
@@ -2197,8 +2198,9 @@ static int qmp_usb_com_init(struct qmp_phy *qphy)
 	return ret;
 }
 
-static int qmp_usb_com_exit(struct qmp_phy *qphy)
+static int qmp_usb_exit(struct phy *phy)
 {
+	struct qmp_phy *qphy = phy_get_drvdata(phy);
 	struct qcom_qmp *qmp = qphy->qmp;
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
 
@@ -2211,20 +2213,6 @@ static int qmp_usb_com_exit(struct qmp_phy *qphy)
 	return 0;
 }
 
-static int qmp_usb_init(struct phy *phy)
-{
-	struct qmp_phy *qphy = phy_get_drvdata(phy);
-	struct qcom_qmp *qmp = qphy->qmp;
-	int ret;
-	dev_vdbg(qmp->dev, "Initializing QMP phy\n");
-
-	ret = qmp_usb_com_init(qphy);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
 static int qmp_usb_power_on(struct phy *phy)
 {
 	struct qmp_phy *qphy = phy_get_drvdata(phy);
@@ -2316,15 +2304,6 @@ static int qmp_usb_power_off(struct phy *phy)
 	return 0;
 }
 
-static int qmp_usb_exit(struct phy *phy)
-{
-	struct qmp_phy *qphy = phy_get_drvdata(phy);
-
-	qmp_usb_com_exit(qphy);
-
-	return 0;
-}
-
 static int qmp_usb_enable(struct phy *phy)
 {
 	int ret;
-- 
2.35.1

