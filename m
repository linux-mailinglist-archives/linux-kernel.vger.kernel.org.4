Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3585FC251
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJLIu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiJLIul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:50:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C29D760E0;
        Wed, 12 Oct 2022 01:50:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6CC861483;
        Wed, 12 Oct 2022 08:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F90C43149;
        Wed, 12 Oct 2022 08:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665564639;
        bh=j091Sqs8HEJc78tMWY2dRxB2XsEU9gn3lUCPU2crSpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pAQAch98ha1mfbhWU0PmeZjGflOKzssPKmONxObEBSynh5ct2ZjuMihRdkN5n0E4p
         Fen9t8CGGt4N4sY4/Flea3cISuigtTn3mO7ee37Td4ayovFXuk910Vxe2FvkUSZgMC
         IYar2URtLXDMyNcIUQMtE/9C13IkQ2r4PCGM8ISNPcDuPKW1RT97kyPFzC1LG/zCMa
         0of9Lx9es6tAJC7CnM2OyY8pnnYPFYI9qJ8VMOItoOWv+HBrVbtyVuWDSwG5+aITvE
         gSfSgzpT3Oqh+CJU9vL4QKa8msVUDCb6LNgl/qOAkinMyj49VWu7Its8lleJtovnkM
         b7nosqbw67kpQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oiXRe-0006Hm-Lc; Wed, 12 Oct 2022 10:50:30 +0200
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
Subject: [PATCH 07/20] phy: qcom-qmp-pcie-msm8996: increase status polling period
Date:   Wed, 12 Oct 2022 10:49:49 +0200
Message-Id: <20221012085002.24099-7-johan+linaro@kernel.org>
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

It typically takes between one and two milliseconds for the PHY to
become ready after starting it. Increase the tight 3--10 us polling
period to the more reasonable 51--200 us.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
index b9260c8746bf..cd8fafe4c295 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
@@ -360,7 +360,7 @@ static int qmp_pcie_msm8996_serdes_init(struct qmp_phy *qphy)
 		     SERDES_START | PCS_START);
 
 	status = serdes + cfg->regs[QPHY_COM_PCS_READY_STATUS];
-	ret = readl_poll_timeout(status, val, (val & PCS_READY), 10,
+	ret = readl_poll_timeout(status, val, (val & PCS_READY), 200,
 				 PHY_INIT_COMPLETE_TIMEOUT);
 	if (ret) {
 		dev_err(qmp->dev,
@@ -514,7 +514,7 @@ static int qmp_pcie_msm8996_power_on(struct phy *phy)
 	qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
 
 	status = pcs + cfg->regs[QPHY_PCS_STATUS];
-	ret = readl_poll_timeout(status, val, !(val & PHYSTATUS), 10,
+	ret = readl_poll_timeout(status, val, !(val & PHYSTATUS), 200,
 				 PHY_INIT_COMPLETE_TIMEOUT);
 	if (ret) {
 		dev_err(qmp->dev, "phy initialization timed-out\n");
-- 
2.35.1

