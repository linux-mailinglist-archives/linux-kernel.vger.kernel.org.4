Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1635FC25F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiJLIv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiJLIun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:50:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FECD7EFDE;
        Wed, 12 Oct 2022 01:50:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 710826144A;
        Wed, 12 Oct 2022 08:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40BAC4FF1E;
        Wed, 12 Oct 2022 08:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665564640;
        bh=8Ptmo3nJGbpkV2ey9zNWxmr3Wo6Tci6upld/D0S8ty8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=efth8sD+gWs77bAV1gFgYnNs/bXrCuPb2fkmOpQpOIGHiWyT9V2Z6o9pJSyq/Xak4
         8V6Ozi6QYjh5KCBHE1vcbF//4q2aN+41Sj1z1HmGjuwzeuSXS67XlX+cBUbl08k4Zc
         A2MXIRO1Ns3CJhWGNTrLtgeRPICrurtIsy1OVo/OgyDRanOgwoX2WIspYLokCR/8uL
         m9BaljfsaIo4SB/bvzmbejcKgUj475shrVqu8T2ZSir0LWtQ+FNGclNsOWhxZ2V54x
         c/9AM73gAtQ7CtP5VxN9mIuX+XOEa5IsR2hwCPksBHQ99P60gzrwHJuArOoRsP193H
         aAKjz3WxhbL3Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oiXRf-0006IJ-JM; Wed, 12 Oct 2022 10:50:31 +0200
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
Subject: [PATCH 18/20] phy: qcom-qmp-pcie-msm8996: drop start and pwrdn-ctrl abstraction
Date:   Wed, 12 Oct 2022 10:50:00 +0200
Message-Id: <20221012085002.24099-18-johan+linaro@kernel.org>
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

Drop the start and pwrdn-ctrl abstractions which are no longer needed
since the QMP driver split.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c    | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
index cd8fafe4c295..ff198d846fd2 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
@@ -196,9 +196,6 @@ struct qmp_phy_cfg {
 
 	/* array of registers with different offsets */
 	const unsigned int *regs;
-
-	unsigned int start_ctrl;
-	unsigned int pwrdn_ctrl;
 };
 
 /**
@@ -311,9 +308,6 @@ static const struct qmp_phy_cfg msm8996_pciephy_cfg = {
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= pciephy_regs_layout,
-
-	.start_ctrl		= PCS_START | PLL_READY_GATE_EN,
-	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 };
 
 static void qmp_pcie_msm8996_configure_lane(void __iomem *base,
@@ -503,7 +497,8 @@ static int qmp_pcie_msm8996_power_on(struct phy *phy)
 	 * Pull out PHY from POWER DOWN state.
 	 * This is active low enable signal to power-down PHY.
 	 */
-	qphy_setbits(pcs, QPHY_V2_PCS_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
+	qphy_setbits(pcs, QPHY_V2_PCS_POWER_DOWN_CONTROL,
+			SW_PWRDN | REFCLK_DRV_DSBL);
 
 	usleep_range(POWER_DOWN_DELAY_US_MIN, POWER_DOWN_DELAY_US_MAX);
 
@@ -511,7 +506,8 @@ static int qmp_pcie_msm8996_power_on(struct phy *phy)
 	qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
 
 	/* start SerDes and Phy-Coding-Sublayer */
-	qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
+	qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL],
+			PCS_START | PLL_READY_GATE_EN);
 
 	status = pcs + cfg->regs[QPHY_PCS_STATUS];
 	ret = readl_poll_timeout(status, val, !(val & PHYSTATUS), 200,
@@ -542,11 +538,12 @@ static int qmp_pcie_msm8996_power_off(struct phy *phy)
 	qphy_setbits(qphy->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
 
 	/* stop SerDes and Phy-Coding-Sublayer */
-	qphy_clrbits(qphy->pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
+	qphy_clrbits(qphy->pcs, cfg->regs[QPHY_START_CTRL],
+			SERDES_START | PCS_START);
 
 	/* Put PHY into POWER DOWN state: active low */
 	qphy_clrbits(qphy->pcs, QPHY_V2_PCS_POWER_DOWN_CONTROL,
-			cfg->pwrdn_ctrl);
+			SW_PWRDN | REFCLK_DRV_DSBL);
 
 	return 0;
 }
-- 
2.35.1

