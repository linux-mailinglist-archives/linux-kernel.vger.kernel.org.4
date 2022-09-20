Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BC65BDE73
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiITHjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiITHjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:39:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9EB60516;
        Tue, 20 Sep 2022 00:39:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CA2F6248D;
        Tue, 20 Sep 2022 07:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FBCC43140;
        Tue, 20 Sep 2022 07:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663659539;
        bh=K+BfnWQLrlylNxKUw3danjgFngQqMpiDXDbH2n7HI14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P83L7sSyk+N0JOLm1dy5fRTWp0p/0WLNFLKfb9s80ND0u963zWz+MqL0BqeM+xPVi
         8tW6FAZnagHNJbwx64nTxkch3UP0NLZOiY7SBMWeGCGNSZ6qQlUHkz/X+yzPCOKbZr
         z1fb5roj+SKerD45Zt3GY4jGjyzPANPod4boJailrgRiyUL4AIjXAPOPIMAWtYdf3a
         05M6QLFkX5vCUQABI8lgAunAktIWAvr2bjYaRmUki7jwICuFvFx+tioJNahrpbJQiQ
         4Ws+NH6HLJGQoG+dY5Sob3yldZMJ3agVbSS/2lUB9FjLYFdKmKKTtpbtfktftb+QLD
         W3Urp2Y/fPIXQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oaXqP-0005Qm-N8; Tue, 20 Sep 2022 09:39:01 +0200
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
Subject: [PATCH 05/17] phy: qcom-qmp-pcie: drop init and exit wrappers
Date:   Tue, 20 Sep 2022 09:38:14 +0200
Message-Id: <20220920073826.20811-6-johan+linaro@kernel.org>
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
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 29 ++++--------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index d25f9215b86f..525097e3b041 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1877,8 +1877,9 @@ static int qmp_pcie_serdes_init(struct qmp_phy *qphy)
 	return 0;
 }
 
-static int qmp_pcie_com_init(struct qmp_phy *qphy)
+static int qmp_pcie_init(struct phy *phy)
 {
+	struct qmp_phy *qphy = phy_get_drvdata(phy);
 	struct qcom_qmp *qmp = qphy->qmp;
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
 	void __iomem *pcs = qphy->pcs;
@@ -1925,8 +1926,9 @@ static int qmp_pcie_com_init(struct qmp_phy *qphy)
 	return ret;
 }
 
-static int qmp_pcie_com_exit(struct qmp_phy *qphy)
+static int qmp_pcie_exit(struct phy *phy)
 {
+	struct qmp_phy *qphy = phy_get_drvdata(phy);
 	struct qcom_qmp *qmp = qphy->qmp;
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
 
@@ -1939,20 +1941,6 @@ static int qmp_pcie_com_exit(struct qmp_phy *qphy)
 	return 0;
 }
 
-static int qmp_pcie_init(struct phy *phy)
-{
-	struct qmp_phy *qphy = phy_get_drvdata(phy);
-	struct qcom_qmp *qmp = qphy->qmp;
-	int ret;
-	dev_vdbg(qmp->dev, "Initializing QMP phy\n");
-
-	ret = qmp_pcie_com_init(qphy);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
 static int qmp_pcie_power_on(struct phy *phy)
 {
 	struct qmp_phy *qphy = phy_get_drvdata(phy);
@@ -2060,15 +2048,6 @@ static int qmp_pcie_power_off(struct phy *phy)
 	return 0;
 }
 
-static int qmp_pcie_exit(struct phy *phy)
-{
-	struct qmp_phy *qphy = phy_get_drvdata(phy);
-
-	qmp_pcie_com_exit(qphy);
-
-	return 0;
-}
-
 static int qmp_pcie_enable(struct phy *phy)
 {
 	int ret;
-- 
2.35.1

