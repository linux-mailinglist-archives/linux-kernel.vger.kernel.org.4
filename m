Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD73F5FC26A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiJLIwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiJLIuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:50:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2099176542;
        Wed, 12 Oct 2022 01:50:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DA5EB819EF;
        Wed, 12 Oct 2022 08:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02D2C4FEBF;
        Wed, 12 Oct 2022 08:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665564639;
        bh=SIzGWAVVhVZ8mBCQ1iAHzKC3Y4NjKbPeFHbDfW5jfFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JlqY0FQ3FIuAwBbEtrw3iHg6Mv1MrsQJOhMjTYepvY8P0jEPc3mn71qzRT+4LNCTM
         LS/L9fn6EqoSf2npqfaYND6sO6vfNdN2pCO45Er6qyMqXhPXKXHryUiyE6fe6lYTyT
         FcFm3MYqOJUuzX3rXU3J6QhPfcj7TzT3iv4CpBk3SffJ9LFktVJjYvQqYh2pl7wuy9
         Ouy0XndIqPUfp7+tsiizqS6emir/XsQ80mMh2A1q9ceUyXbEm/AWochMK+X304FbIv
         zol3c3KjIwMEteGsxu5nOyiRicUa8mk4jiYvwD8NIFE0iDr+1CBT/yTeZg12EQMHiI
         J48ZTSYJv/y2w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oiXRf-0006ID-EJ; Wed, 12 Oct 2022 10:50:31 +0200
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
Subject: [PATCH 16/20] phy: qcom-qmp-pcie: drop start-ctrl abstraction
Date:   Wed, 12 Oct 2022 10:49:58 +0200
Message-Id: <20221012085002.24099-16-johan+linaro@kernel.org>
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

All PCIe PHYs need to start and stop the SerDes and PCS so drop the
start-ctrl abstraction which is no longer needed since the QMP driver
split.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index d3e7e673114f..5534a4ad0243 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1355,7 +1355,6 @@ struct qmp_phy_cfg {
 	/* array of registers with different offsets */
 	const unsigned int *regs;
 
-	unsigned int start_ctrl;
 	unsigned int pwrdn_ctrl;
 	/* bit offset of PHYSTATUS in QPHY_PCS_STATUS register */
 	unsigned int phy_status;
@@ -1491,7 +1490,6 @@ static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
 	.num_vregs		= 0,
 	.regs			= pciephy_regs_layout,
 
-	.start_ctrl		= SERDES_START | PCS_START,
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 	.phy_status		= PHYSTATUS,
 };
@@ -1517,7 +1515,6 @@ static const struct qmp_phy_cfg ipq8074_pciephy_gen3_cfg = {
 	.num_vregs		= 0,
 	.regs			= ipq_pciephy_gen3_regs_layout,
 
-	.start_ctrl		= SERDES_START | PCS_START,
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 	.phy_status		= PHYSTATUS,
 
@@ -1547,7 +1544,6 @@ static const struct qmp_phy_cfg ipq6018_pciephy_cfg = {
 	.num_vregs		= 0,
 	.regs			= ipq_pciephy_gen3_regs_layout,
 
-	.start_ctrl		= SERDES_START | PCS_START,
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 	.phy_status		= PHYSTATUS,
 };
@@ -1575,7 +1571,6 @@ static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= sdm845_qmp_pciephy_regs_layout,
 
-	.start_ctrl		= PCS_START | SERDES_START,
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 	.phy_status		= PHYSTATUS,
 };
@@ -1601,7 +1596,6 @@ static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= sdm845_qhp_pciephy_regs_layout,
 
-	.start_ctrl		= PCS_START | SERDES_START,
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 	.phy_status		= PHYSTATUS,
 };
@@ -1639,7 +1633,6 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= sm8250_pcie_regs_layout,
 
-	.start_ctrl		= PCS_START | SERDES_START,
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 	.phy_status		= PHYSTATUS,
 };
@@ -1677,7 +1670,6 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= sm8250_pcie_regs_layout,
 
-	.start_ctrl		= PCS_START | SERDES_START,
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 	.phy_status		= PHYSTATUS,
 };
@@ -1703,7 +1695,6 @@ static const struct qmp_phy_cfg msm8998_pciephy_cfg = {
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= pciephy_regs_layout,
 
-	.start_ctrl             = SERDES_START | PCS_START,
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 	.phy_status		= PHYSTATUS,
 
@@ -1733,7 +1724,6 @@ static const struct qmp_phy_cfg sc8180x_pciephy_cfg = {
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= sm8250_pcie_regs_layout,
 
-	.start_ctrl		= PCS_START | SERDES_START,
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 	.phy_status		= PHYSTATUS,
 };
@@ -1761,7 +1751,6 @@ static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= sm8250_pcie_regs_layout,
 
-	.start_ctrl		= PCS_START | SERDES_START,
 	.pwrdn_ctrl		= SW_PWRDN,
 	.phy_status		= PHYSTATUS_4_20,
 };
@@ -1789,7 +1778,6 @@ static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= sm8250_pcie_regs_layout,
 
-	.start_ctrl             = SERDES_START | PCS_START,
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 	.phy_status		= PHYSTATUS,
 };
@@ -1832,7 +1820,6 @@ static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= sm8250_pcie_regs_layout,
 
-	.start_ctrl             = SERDES_START | PCS_START,
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 	.phy_status		= PHYSTATUS_4_20,
 };
@@ -1997,7 +1984,7 @@ static int qmp_pcie_power_on(struct phy *phy)
 	qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
 
 	/* start SerDes and Phy-Coding-Sublayer */
-	qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
+	qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], SERDES_START | PCS_START);
 
 	if (!cfg->skip_start_delay)
 		usleep_range(1000, 1200);
@@ -2030,7 +2017,8 @@ static int qmp_pcie_power_off(struct phy *phy)
 	qphy_setbits(qphy->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
 
 	/* stop SerDes and Phy-Coding-Sublayer */
-	qphy_clrbits(qphy->pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
+	qphy_clrbits(qphy->pcs, cfg->regs[QPHY_START_CTRL],
+			SERDES_START | PCS_START);
 
 	/* Put PHY into POWER DOWN state: active low */
 	qphy_clrbits(qphy->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
-- 
2.35.1

