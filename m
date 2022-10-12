Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF37E5FC259
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJLIvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiJLIul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:50:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9455E77555;
        Wed, 12 Oct 2022 01:50:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22E3D6148E;
        Wed, 12 Oct 2022 08:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5550DC43160;
        Wed, 12 Oct 2022 08:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665564639;
        bh=6vsQBAgZfI4wDGxDOIVhNZ+2EYF9AhBrT+wedu3kMvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W8jv0gtHzkonAPh41XF/YY/7xyUtsffOm2rrIF69BiufB3IBomHZ52BR4/+7sfbew
         Ks06RTDYVvQGfIqabo0+3zFlJyslWZm3No0LUwPam5/iem0TNPZ6Apzh/yGWIJnvOz
         6r9Y7/BmuPFIrRHzLcGq0XigvbXaRx9dPQEcERUKKIt6Ja7zgylHGPPP4SwJHj/E5W
         9O8Egvh2SVzBMj/E9g74VNhTdb6UVkrI2qpSZ5CGlO0xe9/bYbrtCUpovHhevYN3cB
         7wSB+1z/pqjATzh3WmibNLmss8+KZSBWZm5BbbXJW4I1gU1uWd2VUmj7Ods6NqveEJ
         Gm6CXkIE+zRiQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oiXRf-0006Hy-0X; Wed, 12 Oct 2022 10:50:31 +0200
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
Subject: [PATCH 11/20] phy: qcom-qmp-ufs: clean up ready polling
Date:   Wed, 12 Oct 2022 10:49:53 +0200
Message-Id: <20221012085002.24099-11-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221012085002.24099-1-johan+linaro@kernel.org>
References: <20221012084846.24003-1-johan+linaro@kernel.org>
 <20221012085002.24099-1-johan+linaro@kernel.org>
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

Clean up the PHY ready polling by dropping the mask variables which are
no longer needed since the QMP driver split.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 1c7d8fc9b94a..8380904cf26c 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -908,7 +908,7 @@ static int qmp_ufs_power_on(struct phy *phy)
 	void __iomem *rx = qphy->rx;
 	void __iomem *pcs = qphy->pcs;
 	void __iomem *status;
-	unsigned int mask, val, ready;
+	unsigned int val;
 	int ret;
 
 	qmp_ufs_serdes_init(qphy);
@@ -937,10 +937,7 @@ static int qmp_ufs_power_on(struct phy *phy)
 	qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
 
 	status = pcs + cfg->regs[QPHY_PCS_READY_STATUS];
-	mask = PCS_READY;
-	ready = PCS_READY;
-
-	ret = readl_poll_timeout(status, val, (val & mask) == ready, 10,
+	ret = readl_poll_timeout(status, val, (val & PCS_READY), 10,
 				 PHY_INIT_COMPLETE_TIMEOUT);
 	if (ret) {
 		dev_err(qmp->dev, "phy initialization timed-out\n");
-- 
2.35.1

