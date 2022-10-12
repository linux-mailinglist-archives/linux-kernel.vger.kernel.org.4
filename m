Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB055FC26C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJLIwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiJLIuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:50:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0EA7EFDE;
        Wed, 12 Oct 2022 01:50:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94630B819FC;
        Wed, 12 Oct 2022 08:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F17C43470;
        Wed, 12 Oct 2022 08:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665564640;
        bh=CJiFugk3JutIkty+xFhq8GQC1jyF4iuWYXZTcn07R9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FiuzhvkpiHfa8Lr42xyWiO1n93cgG3nFavCcCImi19FeQ0ts6aSs8OKhk3ZcgOpQA
         Tjf35WjTJVSyMCzBrZaQ5IvvKr9Om2DjTkQ9PXtwxBfXXweJ8CLL3f/0IEYKoGC+FU
         UPWv0y+c/cFRbehz7LWkYRrmGX/jtILLvT1CjDSuBUxhLYwNxwnR9I0Hhph4UduDrE
         munrACS0IASkPDqn91x3dGT/Z7oStFU365EaUzTpvtoskjlxcL4exN5W9YLMq38EOf
         Oz4IwEiPHz/Orb8dENe4UWPruYIJ8ewmRhUh0k0eSV8GqDiPL5JrgkEL9rIeKR3ZzL
         OFNsXAUqwgeIg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oiXRf-0006IQ-PW; Wed, 12 Oct 2022 10:50:31 +0200
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
Subject: [PATCH 20/20] phy: qcom-qmp-usb: drop start and pwrdn-ctrl abstraction
Date:   Wed, 12 Oct 2022 10:50:02 +0200
Message-Id: <20221012085002.24099-20-johan+linaro@kernel.org>
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
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 61 ++-----------------------
 1 file changed, 5 insertions(+), 56 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index 0bd9291e6a7b..d0c433197080 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -1443,9 +1443,6 @@ struct qmp_phy_cfg {
 	/* array of registers with different offsets */
 	const unsigned int *regs;
 
-	unsigned int start_ctrl;
-	unsigned int pwrdn_ctrl;
-
 	/* true, if PHY needs delay after POWER_DOWN */
 	bool has_pwrdn_delay;
 
@@ -1599,9 +1596,6 @@ static const struct qmp_phy_cfg ipq8074_usb3phy_cfg = {
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= usb3phy_regs_layout,
-
-	.start_ctrl		= SERDES_START | PCS_START,
-	.pwrdn_ctrl		= SW_PWRDN,
 };
 
 static const struct qmp_phy_cfg msm8996_usb3phy_cfg = {
@@ -1622,9 +1616,6 @@ static const struct qmp_phy_cfg msm8996_usb3phy_cfg = {
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= usb3phy_regs_layout,
-
-	.start_ctrl		= SERDES_START | PCS_START,
-	.pwrdn_ctrl		= SW_PWRDN,
 };
 
 static const struct qmp_phy_cfg qmp_v3_usb3phy_cfg = {
@@ -1646,9 +1637,6 @@ static const struct qmp_phy_cfg qmp_v3_usb3phy_cfg = {
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= qmp_v3_usb3phy_regs_layout,
 
-	.start_ctrl		= SERDES_START | PCS_START,
-	.pwrdn_ctrl		= SW_PWRDN,
-
 	.has_pwrdn_delay	= true,
 	.has_phy_dp_com_ctrl	= true,
 };
@@ -1672,9 +1660,6 @@ static const struct qmp_phy_cfg sc7180_usb3phy_cfg = {
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= qmp_v3_usb3phy_regs_layout,
 
-	.start_ctrl		= SERDES_START | PCS_START,
-	.pwrdn_ctrl		= SW_PWRDN,
-
 	.has_pwrdn_delay	= true,
 	.has_phy_dp_com_ctrl	= true,
 };
@@ -1697,9 +1682,6 @@ static const struct qmp_phy_cfg sc8280xp_usb3_uniphy_cfg = {
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= qmp_v4_usb3phy_regs_layout,
-
-	.start_ctrl		= SERDES_START | PCS_START,
-	.pwrdn_ctrl		= SW_PWRDN,
 };
 
 static const struct qmp_phy_cfg qmp_v3_usb3_uniphy_cfg = {
@@ -1721,9 +1703,6 @@ static const struct qmp_phy_cfg qmp_v3_usb3_uniphy_cfg = {
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= qmp_v3_usb3phy_regs_layout,
 
-	.start_ctrl		= SERDES_START | PCS_START,
-	.pwrdn_ctrl		= SW_PWRDN,
-
 	.has_pwrdn_delay	= true,
 };
 
@@ -1745,9 +1724,6 @@ static const struct qmp_phy_cfg msm8998_usb3phy_cfg = {
 	.vreg_list              = qmp_phy_vreg_l,
 	.num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs                   = qmp_v3_usb3phy_regs_layout,
-
-	.start_ctrl             = SERDES_START | PCS_START,
-	.pwrdn_ctrl             = SW_PWRDN,
 };
 
 static const struct qmp_phy_cfg sm8150_usb3phy_cfg = {
@@ -1772,9 +1748,6 @@ static const struct qmp_phy_cfg sm8150_usb3phy_cfg = {
 	.regs			= qmp_v4_usb3phy_regs_layout,
 	.pcs_usb_offset		= 0x300,
 
-	.start_ctrl		= SERDES_START | PCS_START,
-	.pwrdn_ctrl		= SW_PWRDN,
-
 	.has_pwrdn_delay	= true,
 	.has_phy_dp_com_ctrl	= true,
 };
@@ -1801,9 +1774,6 @@ static const struct qmp_phy_cfg sm8150_usb3_uniphy_cfg = {
 	.regs			= qmp_v4_usb3phy_regs_layout,
 	.pcs_usb_offset		= 0x600,
 
-	.start_ctrl		= SERDES_START | PCS_START,
-	.pwrdn_ctrl		= SW_PWRDN,
-
 	.has_pwrdn_delay	= true,
 };
 
@@ -1829,9 +1799,6 @@ static const struct qmp_phy_cfg sm8250_usb3phy_cfg = {
 	.regs			= qmp_v4_usb3phy_regs_layout,
 	.pcs_usb_offset		= 0x300,
 
-	.start_ctrl		= SERDES_START | PCS_START,
-	.pwrdn_ctrl		= SW_PWRDN,
-
 	.has_pwrdn_delay	= true,
 	.has_phy_dp_com_ctrl	= true,
 };
@@ -1858,9 +1825,6 @@ static const struct qmp_phy_cfg sm8250_usb3_uniphy_cfg = {
 	.regs			= qmp_v4_usb3phy_regs_layout,
 	.pcs_usb_offset		= 0x600,
 
-	.start_ctrl		= SERDES_START | PCS_START,
-	.pwrdn_ctrl		= SW_PWRDN,
-
 	.has_pwrdn_delay	= true,
 };
 
@@ -1886,9 +1850,6 @@ static const struct qmp_phy_cfg sdx55_usb3_uniphy_cfg = {
 	.regs			= qmp_v4_usb3phy_regs_layout,
 	.pcs_usb_offset		= 0x600,
 
-	.start_ctrl		= SERDES_START | PCS_START,
-	.pwrdn_ctrl		= SW_PWRDN,
-
 	.has_pwrdn_delay	= true,
 };
 
@@ -1914,9 +1875,6 @@ static const struct qmp_phy_cfg sdx65_usb3_uniphy_cfg = {
 	.regs			= qmp_v4_usb3phy_regs_layout,
 	.pcs_usb_offset		= 0x1000,
 
-	.start_ctrl		= SERDES_START | PCS_START,
-	.pwrdn_ctrl		= SW_PWRDN,
-
 	.has_pwrdn_delay	= true,
 };
 
@@ -1942,9 +1900,6 @@ static const struct qmp_phy_cfg sm8350_usb3phy_cfg = {
 	.regs			= qmp_v4_usb3phy_regs_layout,
 	.pcs_usb_offset		= 0x300,
 
-	.start_ctrl		= SERDES_START | PCS_START,
-	.pwrdn_ctrl		= SW_PWRDN,
-
 	.has_pwrdn_delay	= true,
 	.has_phy_dp_com_ctrl	= true,
 };
@@ -1971,9 +1926,6 @@ static const struct qmp_phy_cfg sm8350_usb3_uniphy_cfg = {
 	.regs			= qmp_v4_usb3phy_regs_layout,
 	.pcs_usb_offset		= 0x1000,
 
-	.start_ctrl		= SERDES_START | PCS_START,
-	.pwrdn_ctrl		= SW_PWRDN,
-
 	.has_pwrdn_delay	= true,
 };
 
@@ -1995,9 +1947,6 @@ static const struct qmp_phy_cfg qcm2290_usb3phy_cfg = {
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= qcm2290_usb3phy_regs_layout,
-
-	.start_ctrl		= SERDES_START | PCS_START,
-	.pwrdn_ctrl		= SW_PWRDN,
 };
 
 static void qmp_usb_configure_lane(void __iomem *base,
@@ -2092,8 +2041,7 @@ static int qmp_usb_init(struct phy *phy)
 		qphy_clrbits(dp_com, QPHY_V3_DP_COM_SW_RESET, SW_RESET);
 	}
 
-	qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
-			cfg->pwrdn_ctrl);
+	qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL], SW_PWRDN);
 
 	return 0;
 
@@ -2160,7 +2108,7 @@ static int qmp_usb_power_on(struct phy *phy)
 	qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
 
 	/* start SerDes and Phy-Coding-Sublayer */
-	qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
+	qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], SERDES_START | PCS_START);
 
 	status = pcs + cfg->regs[QPHY_PCS_STATUS];
 	ret = readl_poll_timeout(status, val, !(val & PHYSTATUS), 200,
@@ -2189,11 +2137,12 @@ static int qmp_usb_power_off(struct phy *phy)
 	qphy_setbits(qphy->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
 
 	/* stop SerDes and Phy-Coding-Sublayer */
-	qphy_clrbits(qphy->pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
+	qphy_clrbits(qphy->pcs, cfg->regs[QPHY_START_CTRL],
+			SERDES_START | PCS_START);
 
 	/* Put PHY into POWER DOWN state: active low */
 	qphy_clrbits(qphy->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
-			cfg->pwrdn_ctrl);
+			SW_PWRDN);
 
 	return 0;
 }
-- 
2.35.1

