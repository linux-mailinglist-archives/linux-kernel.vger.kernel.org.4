Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C0C6006F5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 08:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiJQGv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 02:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiJQGuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 02:50:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1954A137;
        Sun, 16 Oct 2022 23:50:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67EDBB80F93;
        Mon, 17 Oct 2022 06:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645C2C4FEBC;
        Mon, 17 Oct 2022 06:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665989441;
        bh=TcypivBfk2W9WTPaCElq2ehES8rUnpTli45iHdyD1GI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=npDf3EA2kME9CIke9xlNkjp1Ez0kSmsEHigY7UIbCKvoRFnyvAOt6qFLhHAMgDKzz
         QL0vi4KpA6R2XEL5Tzcgtgd5rP7lA/oBx4H3OpRCcYN6FzQKHuSWzvaklqfWsNzidr
         xwvaGZHHXOkGdgtS7lLLBoGbIRr0T9/OXKaLNOQjAklU2f/rUAOtzmg0SK9hleBwe7
         kF5/KrSEQSvQmZIXa+Rk9F1+seAAR2Qs8chvu7yn+Zpp55duLBEdHY2BOpItSOevKq
         mPvvSQdHI0KvQ+he/UipGN0HSjTBlgsd1tersKIhhY5ckjWy/cdVZLWVy1SS5eWc2F
         dqHdSgzKpjZ7Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1okJxH-00057y-4V; Mon, 17 Oct 2022 08:50:31 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 11/11] phy: qcom-qmp-pcie: drop bogus register update
Date:   Mon, 17 Oct 2022 08:50:13 +0200
Message-Id: <20221017065013.19647-12-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221017065013.19647-1-johan+linaro@kernel.org>
References: <20221017065013.19647-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 0d58280cf1e6 ("phy: Update PHY power control sequence") the
PHY is powered on before configuring the registers and only the MSM8996
PCIe PHY, which includes the POWER_DOWN_CONTROL register in its PCS
initialisation table, may possibly require a second update afterwards.

To make things worse, the POWER_DOWN_CONTROL register lies at a
different offset on more recent SoCs so that the second update, which
still used a hard-coded offset, would write to an unrelated register
(e.g. a revision-id register on SC8280XP).

As the MSM8996 PCIe PHY is now handled by a separate driver, simply drop
the bogus register update.

Fixes: e4d8b05ad5f9 ("phy: qcom-qmp: Use proper PWRDOWN offset for sm8150 USB") added support
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> #RB3
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index cb2128e5a78d..30838ae8f027 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -2061,12 +2061,6 @@ static int qmp_pcie_power_on(struct phy *phy)
 	qmp_pcie_pcs_init(qphy, &cfg->tables);
 	qmp_pcie_pcs_init(qphy, mode_tables);
 
-	/*
-	 * Pull out PHY from POWER DOWN state.
-	 * This is active low enable signal to power-down PHY.
-	 */
-	qphy_setbits(pcs, QPHY_V2_PCS_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
-
 	if (cfg->has_pwrdn_delay)
 		usleep_range(cfg->pwrdn_delay_min, cfg->pwrdn_delay_max);
 
-- 
2.37.3

