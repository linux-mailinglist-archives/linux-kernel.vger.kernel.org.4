Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C9C5FC1D4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiJLIR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiJLIQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:16:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515075E57E;
        Wed, 12 Oct 2022 01:15:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FF02B819A1;
        Wed, 12 Oct 2022 08:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D079C4FEB8;
        Wed, 12 Oct 2022 08:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665562555;
        bh=zj2f+fEcuy4BNH83sVnT+5iGBlx2okQalx8OhQNynWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=APeEtNn7vJKC8dYWsgC2KNtXwJlfJsHmg15yh0Z2Bn4rn+so4p8xN007l4D6AuDjL
         OWPrTsDZunxbLSSy7s0NDDljVwKqPWSvcAh+SkT2iRCnwxADSVscawZN7086Q2Jxbr
         AkLGnktALPsgF4v0lZdMRckFvDGsoriYMDNoSjTAn6bTF/krvnFdz7liKtlg2wvAZI
         sin46TCw82RKfnjJjCoYk6M7j9nlpEItUrLZYNtVy7noTpprNs0xNS0lcsnRLsK1S4
         ZOvUHQmFaIbzbfYqAPqhFB0x/Te9SWzRVQyvw+YWNHJYpDwR3WsLU7nfBM5MMDCjR8
         xomabSF5NF8tA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oiWu2-0004oj-Ty; Wed, 12 Oct 2022 10:15:46 +0200
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
Subject: [PATCH v2 09/14] phy: qcom-qmp-pcie: replace power-down delay
Date:   Wed, 12 Oct 2022 10:12:36 +0200
Message-Id: <20221012081241.18273-10-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221012081241.18273-1-johan+linaro@kernel.org>
References: <20221012081241.18273-1-johan+linaro@kernel.org>
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

The power-down delay was included in the first version of the QMP driver
as an optional delay after powering on the PHY (using
POWER_DOWN_CONTROL) and just before starting it. Later changes modified
this sequence by powering on before initialising the PHY, but the
optional delay stayed where it was (i.e. before starting the PHY).

The vendor driver does not use a delay before starting the PHY and this
is likely not needed on any platform unless there is a corresponding
delay in the vendor kernel init sequence tables (i.e. in devicetree).

But as the vendor kernel do have a 1 ms delay *after* starting the PHY
and before starting to poll the status it is possible that later
contributors have simply not noticed that the mainline power-down delay
is not equivalent.

As the current delay before even starting the PHY is pretty much
pointless and likely a mistake, move the delay after starting the PHY
which avoids a few iterations of polling and speeds up startup by 1 ms
(the poll loop otherwise takes about 1.8 ms).

Note that MSM8998 has never used a power-down delay so add a flag to
skip the delay in case starting the PHY is faster on MSM8998. This can
be removed after someone takes a measurement.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 33 +++++-------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 315de484f875..151baa63e8e8 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1360,8 +1360,7 @@ struct qmp_phy_cfg {
 	/* bit offset of PHYSTATUS in QPHY_PCS_STATUS register */
 	unsigned int phy_status;
 
-	/* true, if PHY needs delay after POWER_DOWN */
-	bool has_pwrdn_delay;
+	bool skip_start_delay;
 
 	/* QMP PHY pipe clock interface rate */
 	unsigned long pipe_clock_rate;
@@ -1495,8 +1494,6 @@ static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
 	.start_ctrl		= SERDES_START | PCS_START,
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 	.phy_status		= PHYSTATUS,
-
-	.has_pwrdn_delay	= true,
 };
 
 static const struct qmp_phy_cfg ipq8074_pciephy_gen3_cfg = {
@@ -1523,8 +1520,6 @@ static const struct qmp_phy_cfg ipq8074_pciephy_gen3_cfg = {
 	.start_ctrl		= SERDES_START | PCS_START,
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 
-	.has_pwrdn_delay	= true,
-
 	.pipe_clock_rate	= 250000000,
 };
 
@@ -1553,8 +1548,6 @@ static const struct qmp_phy_cfg ipq6018_pciephy_cfg = {
 
 	.start_ctrl		= SERDES_START | PCS_START,
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
-
-	.has_pwrdn_delay	= true,
 };
 
 static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
@@ -1583,8 +1576,6 @@ static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
 	.start_ctrl		= PCS_START | SERDES_START,
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 	.phy_status		= PHYSTATUS,
-
-	.has_pwrdn_delay	= true,
 };
 
 static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
@@ -1611,8 +1602,6 @@ static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
 	.start_ctrl		= PCS_START | SERDES_START,
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 	.phy_status		= PHYSTATUS,
-
-	.has_pwrdn_delay	= true,
 };
 
 static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
@@ -1651,8 +1640,6 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
 	.start_ctrl		= PCS_START | SERDES_START,
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 	.phy_status		= PHYSTATUS,
-
-	.has_pwrdn_delay	= true,
 };
 
 static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
@@ -1691,8 +1678,6 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
 	.start_ctrl		= PCS_START | SERDES_START,
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 	.phy_status		= PHYSTATUS,
-
-	.has_pwrdn_delay	= true,
 };
 
 static const struct qmp_phy_cfg msm8998_pciephy_cfg = {
@@ -1719,6 +1704,8 @@ static const struct qmp_phy_cfg msm8998_pciephy_cfg = {
 	.start_ctrl             = SERDES_START | PCS_START,
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 	.phy_status		= PHYSTATUS,
+
+	.skip_start_delay	= true,
 };
 
 static const struct qmp_phy_cfg sc8180x_pciephy_cfg = {
@@ -1746,8 +1733,6 @@ static const struct qmp_phy_cfg sc8180x_pciephy_cfg = {
 
 	.start_ctrl		= PCS_START | SERDES_START,
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
-
-	.has_pwrdn_delay	= true,
 };
 
 static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
@@ -1776,8 +1761,6 @@ static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
 	.start_ctrl		= PCS_START | SERDES_START,
 	.pwrdn_ctrl		= SW_PWRDN,
 	.phy_status		= PHYSTATUS_4_20,
-
-	.has_pwrdn_delay	= true,
 };
 
 static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
@@ -1806,8 +1789,6 @@ static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
 	.start_ctrl             = SERDES_START | PCS_START,
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 	.phy_status		= PHYSTATUS,
-
-	.has_pwrdn_delay	= true,
 };
 
 static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
@@ -1851,8 +1832,6 @@ static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
 	.start_ctrl             = SERDES_START | PCS_START,
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 	.phy_status		= PHYSTATUS_4_20,
-
-	.has_pwrdn_delay	= true,
 };
 
 static void qmp_pcie_configure_lane(void __iomem *base,
@@ -2011,15 +1990,15 @@ static int qmp_pcie_power_on(struct phy *phy)
 	qmp_pcie_pcs_init(qphy, &cfg->tables);
 	qmp_pcie_pcs_init(qphy, mode_tables);
 
-	if (cfg->has_pwrdn_delay)
-		usleep_range(1000, 1200);
-
 	/* Pull PHY out of reset state */
 	qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
 
 	/* start SerDes and Phy-Coding-Sublayer */
 	qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
 
+	if (!cfg->skip_start_delay)
+		usleep_range(1000, 1200);
+
 	status = pcs + cfg->regs[QPHY_PCS_STATUS];
 	mask = cfg->phy_status;
 	ready = 0;
-- 
2.35.1

