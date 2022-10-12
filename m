Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1859A5FC263
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiJLIvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiJLIun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:50:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607C57EFFC;
        Wed, 12 Oct 2022 01:50:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA62161490;
        Wed, 12 Oct 2022 08:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA287C4FEE3;
        Wed, 12 Oct 2022 08:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665564639;
        bh=6HHb0hSTLogTFhDfHIVKWWgqRK1WkBCFkQZashQnNVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ifJ1auGHFOfwfUr//ULX8EVgVIA/4DuQzgawzPuXFP9tOcKqhgrmpbuTLErtscJjY
         YEJCB+N80vnOeyrB76lYjyRvm+UGfLn8Rfk6YkSO1tL55RclyUiETcG5eBvyB6l7aV
         gx9O8xjw8G4m8iXnEjSIwk8R/qO2Aynv/GKJwGQL8JTJ6Motbl5AjSM36IT8Lc9exd
         llmToBY+9zHlVp9mU4QCnAQxF6xdqnUDXpgat47INv2LgmxLzrAWkRs094lx3BoEjb
         iTV2FsEAOxexhDMxoOD9gMPugQ5EvTSvyPMlPMt4QuStLJWLbBDC7LDiphKq1vcThX
         WkUMkVx/eTpCQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oiXRf-0006IA-Bj; Wed, 12 Oct 2022 10:50:31 +0200
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
Subject: [PATCH 15/20] phy: qcom-qmp-combo: drop start and pwrdn-ctrl abstraction
Date:   Wed, 12 Oct 2022 10:49:57 +0200
Message-Id: <20221012085002.24099-15-johan+linaro@kernel.org>
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

All USB PHYs need to start and stop the SerDes and PCS so drop the
start-ctrl abstraction which is no longer needed since the QMP driver
split.

Similarly, drop the pwrdn-ctrl abstraction which also is not needed
since the split.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 29 +++++------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 0071c73ac1c8..2fab8d5ec0f1 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -851,9 +851,6 @@ struct qmp_phy_cfg {
 	/* array of registers with different offsets */
 	const unsigned int *regs;
 
-	unsigned int start_ctrl;
-	unsigned int pwrdn_ctrl;
-
 	/* true, if PHY needs delay after POWER_DOWN */
 	bool has_pwrdn_delay;
 
@@ -1019,9 +1016,6 @@ static const struct qmp_phy_cfg sc7180_usb3phy_cfg = {
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= qmp_v3_usb3phy_regs_layout,
 
-	.start_ctrl		= SERDES_START | PCS_START,
-	.pwrdn_ctrl		= SW_PWRDN,
-
 	.has_pwrdn_delay	= true,
 };
 
@@ -1087,9 +1081,6 @@ static const struct qmp_phy_cfg sdm845_usb3phy_cfg = {
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= qmp_v3_usb3phy_regs_layout,
 
-	.start_ctrl		= SERDES_START | PCS_START,
-	.pwrdn_ctrl		= SW_PWRDN,
-
 	.has_pwrdn_delay	= true,
 };
 
@@ -1121,9 +1112,6 @@ static const struct qmp_phy_cfg sm8150_usb3phy_cfg = {
 	.regs			= qmp_v4_usb3phy_regs_layout,
 	.pcs_usb_offset		= 0x300,
 
-	.start_ctrl		= SERDES_START | PCS_START,
-	.pwrdn_ctrl		= SW_PWRDN,
-
 	.has_pwrdn_delay	= true,
 };
 
@@ -1189,9 +1177,6 @@ static const struct qmp_phy_cfg sc8280xp_usb43dp_usb_cfg = {
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= qmp_v4_usb3phy_regs_layout,
 	.pcs_usb_offset		= 0x300,
-
-	.start_ctrl		= SERDES_START | PCS_START,
-	.pwrdn_ctrl		= SW_PWRDN,
 };
 
 static const struct qmp_phy_cfg sc8280xp_usb43dp_dp_cfg = {
@@ -1259,9 +1244,6 @@ static const struct qmp_phy_cfg sm8250_usb3phy_cfg = {
 	.regs			= qmp_v4_usb3phy_regs_layout,
 	.pcs_usb_offset		= 0x300,
 
-	.start_ctrl		= SERDES_START | PCS_START,
-	.pwrdn_ctrl		= SW_PWRDN,
-
 	.has_pwrdn_delay	= true,
 };
 
@@ -1944,8 +1926,7 @@ static int qmp_combo_com_init(struct qmp_phy *qphy)
 	qphy_clrbits(dp_com, QPHY_V3_DP_COM_SWI_CTRL, 0x03);
 	qphy_clrbits(dp_com, QPHY_V3_DP_COM_SW_RESET, SW_RESET);
 
-	qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
-			cfg->pwrdn_ctrl);
+	qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL], SW_PWRDN);
 
 	mutex_unlock(&qmp->phy_mutex);
 
@@ -2049,7 +2030,8 @@ static int qmp_combo_power_on(struct phy *phy)
 		/* Pull PHY out of reset state */
 		qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
 		/* start SerDes and Phy-Coding-Sublayer */
-		qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
+		qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL],
+				SERDES_START | PCS_START);
 
 		status = pcs + cfg->regs[QPHY_PCS_STATUS];
 		ret = readl_poll_timeout(status, val, !(val & PHYSTATUS), 200,
@@ -2082,11 +2064,12 @@ static int qmp_combo_power_off(struct phy *phy)
 		qphy_setbits(qphy->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
 
 		/* stop SerDes and Phy-Coding-Sublayer */
-		qphy_clrbits(qphy->pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
+		qphy_clrbits(qphy->pcs, cfg->regs[QPHY_START_CTRL],
+				SERDES_START | PCS_START);
 
 		/* Put PHY into POWER DOWN state: active low */
 		qphy_clrbits(qphy->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
-				cfg->pwrdn_ctrl);
+				SW_PWRDN);
 	}
 
 	return 0;
-- 
2.35.1

