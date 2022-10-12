Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26725FC261
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiJLIvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiJLIum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:50:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F647F264;
        Wed, 12 Oct 2022 01:50:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7188A61496;
        Wed, 12 Oct 2022 08:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C9FC4FF1B;
        Wed, 12 Oct 2022 08:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665564640;
        bh=OPKgUOopDhG/a9gweoH3JA1eoXHuUz63XssdJdVt9XU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ouXIGMGjw+x9qcybhbzq2bF4L8ImU/NFbhi9JKfyXOFCgT4tyKwO7hO2NPlK6aHh+
         Zq880Op8pkdMSJMlDowSqa2OxkQo3Q8pa3+Dvz9uGNYbKZ2ngPaT1FSr8lWhQWpIVe
         R3s+eawBlz5YeX+RJp61mIPlD2PcAl50xAXlKefTXMxY6faBb/2hJDkmHRi700u15J
         5ytZj+kECsDVgvhkuEXXof97ajxClkTIGYDlnst6aM7LWhF+mAoORAF4SEuxCms6xm
         gT980mc+ioOOHdBA3HRwZymnaocZNdiw+IPwnqaO6ei+gRWsVO2EsvSxAxpLrTDKKI
         cFqGshUG2lNFA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oiXRf-0006IN-MW; Wed, 12 Oct 2022 10:50:31 +0200
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
Subject: [PATCH 19/20] phy: qcom-qmp-ufs: drop start and pwrdn-ctrl abstraction
Date:   Wed, 12 Oct 2022 10:50:01 +0200
Message-Id: <20221012085002.24099-19-johan+linaro@kernel.org>
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
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 35 +++++--------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 1a51f803928b..9b58d742af3b 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -544,9 +544,6 @@ struct qmp_phy_cfg {
 	/* array of registers with different offsets */
 	const unsigned int *regs;
 
-	unsigned int start_ctrl;
-	unsigned int pwrdn_ctrl;
-
 	/* true, if PCS block has no separate SW_RESET register */
 	bool no_pcs_sw_reset;
 };
@@ -662,9 +659,6 @@ static const struct qmp_phy_cfg msm8996_ufs_cfg = {
 
 	.regs			= msm8996_ufsphy_regs_layout,
 
-	.start_ctrl		= SERDES_START,
-	.pwrdn_ctrl		= SW_PWRDN,
-
 	.no_pcs_sw_reset	= true,
 };
 
@@ -685,9 +679,6 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= sdm845_ufsphy_regs_layout,
 
-	.start_ctrl		= SERDES_START,
-	.pwrdn_ctrl		= SW_PWRDN,
-
 	.no_pcs_sw_reset	= true,
 };
 
@@ -708,9 +699,6 @@ static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= sm6115_ufsphy_regs_layout,
 
-	.start_ctrl		= SERDES_START,
-	.pwrdn_ctrl		= SW_PWRDN,
-
 	.no_pcs_sw_reset	= true,
 };
 
@@ -730,9 +718,6 @@ static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= sm8150_ufsphy_regs_layout,
-
-	.start_ctrl		= SERDES_START,
-	.pwrdn_ctrl		= SW_PWRDN,
 };
 
 static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
@@ -751,9 +736,6 @@ static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= sm8150_ufsphy_regs_layout,
-
-	.start_ctrl		= SERDES_START,
-	.pwrdn_ctrl		= SW_PWRDN,
 };
 
 static const struct qmp_phy_cfg sm8450_ufsphy_cfg = {
@@ -772,9 +754,6 @@ static const struct qmp_phy_cfg sm8450_ufsphy_cfg = {
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= sm8150_ufsphy_regs_layout,
-
-	.start_ctrl		= SERDES_START,
-	.pwrdn_ctrl		= SW_PWRDN,
 };
 
 static void qmp_ufs_configure_lane(void __iomem *base,
@@ -832,8 +811,7 @@ static int qmp_ufs_com_init(struct qmp_phy *qphy)
 	if (ret)
 		goto err_disable_regulators;
 
-	qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
-			cfg->pwrdn_ctrl);
+	qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL], SW_PWRDN);
 
 	return 0;
 
@@ -933,8 +911,9 @@ static int qmp_ufs_power_on(struct phy *phy)
 	/* Pull PHY out of reset state */
 	if (!cfg->no_pcs_sw_reset)
 		qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
-	/* start SerDes and Phy-Coding-Sublayer */
-	qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
+
+	/* start SerDes */
+	qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], SERDES_START);
 
 	status = pcs + cfg->regs[QPHY_PCS_READY_STATUS];
 	ret = readl_poll_timeout(status, val, (val & PCS_READY), 200,
@@ -956,12 +935,12 @@ static int qmp_ufs_power_off(struct phy *phy)
 	if (!cfg->no_pcs_sw_reset)
 		qphy_setbits(qphy->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
 
-	/* stop SerDes and Phy-Coding-Sublayer */
-	qphy_clrbits(qphy->pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
+	/* stop SerDes */
+	qphy_clrbits(qphy->pcs, cfg->regs[QPHY_START_CTRL], SERDES_START);
 
 	/* Put PHY into POWER DOWN state: active low */
 	qphy_clrbits(qphy->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
-			cfg->pwrdn_ctrl);
+			SW_PWRDN);
 
 	return 0;
 }
-- 
2.35.1

