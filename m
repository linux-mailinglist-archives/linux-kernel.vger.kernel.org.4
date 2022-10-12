Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386BA5FC1CE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiJLIQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiJLIQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:16:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8025E325;
        Wed, 12 Oct 2022 01:15:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 055C5B819B9;
        Wed, 12 Oct 2022 08:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457D6C43155;
        Wed, 12 Oct 2022 08:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665562555;
        bh=e8XpSHjTNJUNEEWSbFBHEVklGknG96PoGVTN8QWLfBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pwe8DNgiMsexlj+WlWiztNuTtYfe9f34+TLqpNWj6pdloKALmXQFU4yraF9YWvzMg
         zGSm4basaJf9bHGvt/q1/IK1pLC5s1Q3RVigYA+14HKzYHnWLgNf5suhfRe6qy3fxv
         zOo/v+JoUAeCDO7ZiENieMONBJ4tB07lkXp6XaVzH37yJmtJEjDk/CqDBijeHlPlGv
         lNvCaxJB2E83sV+ONYy/dc65nyc+6rcJaEUYJL/iSn5NOGhK8kKFjrsgMNLHRMNou3
         NjXmiAQWIKtX5aa5qUk/3egTRFkk8ghfGLUxufgD+KbY3vj8LAjdjRHpD4gaYyDCjY
         7OKcOH6AyqepA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oiWu2-0004of-Qi; Wed, 12 Oct 2022 10:15:46 +0200
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
Subject: [PATCH v2 08/14] phy: qcom-qmp-pcie: drop power-down delay config
Date:   Wed, 12 Oct 2022 10:12:35 +0200
Message-Id: <20221012081241.18273-9-johan+linaro@kernel.org>
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

Let's keep the delay for now, but drop the redundant delay period
configuration while increasing the unnecessarily low timer slack
somewhat.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 27 +-----------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index fa8bc6aeedf1..315de484f875 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1362,9 +1362,6 @@ struct qmp_phy_cfg {
 
 	/* true, if PHY needs delay after POWER_DOWN */
 	bool has_pwrdn_delay;
-	/* power_down delay in usec */
-	int pwrdn_delay_min;
-	int pwrdn_delay_max;
 
 	/* QMP PHY pipe clock interface rate */
 	unsigned long pipe_clock_rate;
@@ -1500,8 +1497,6 @@ static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
 	.phy_status		= PHYSTATUS,
 
 	.has_pwrdn_delay	= true,
-	.pwrdn_delay_min	= 995,		/* us */
-	.pwrdn_delay_max	= 1005,		/* us */
 };
 
 static const struct qmp_phy_cfg ipq8074_pciephy_gen3_cfg = {
@@ -1529,8 +1524,6 @@ static const struct qmp_phy_cfg ipq8074_pciephy_gen3_cfg = {
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 
 	.has_pwrdn_delay	= true,
-	.pwrdn_delay_min	= 995,		/* us */
-	.pwrdn_delay_max	= 1005,		/* us */
 
 	.pipe_clock_rate	= 250000000,
 };
@@ -1562,8 +1555,6 @@ static const struct qmp_phy_cfg ipq6018_pciephy_cfg = {
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 
 	.has_pwrdn_delay	= true,
-	.pwrdn_delay_min	= 995,		/* us */
-	.pwrdn_delay_max	= 1005,		/* us */
 };
 
 static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
@@ -1594,8 +1585,6 @@ static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
 	.phy_status		= PHYSTATUS,
 
 	.has_pwrdn_delay	= true,
-	.pwrdn_delay_min	= 995,		/* us */
-	.pwrdn_delay_max	= 1005,		/* us */
 };
 
 static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
@@ -1624,8 +1613,6 @@ static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
 	.phy_status		= PHYSTATUS,
 
 	.has_pwrdn_delay	= true,
-	.pwrdn_delay_min	= 995,		/* us */
-	.pwrdn_delay_max	= 1005,		/* us */
 };
 
 static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
@@ -1666,8 +1653,6 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
 	.phy_status		= PHYSTATUS,
 
 	.has_pwrdn_delay	= true,
-	.pwrdn_delay_min	= 995,		/* us */
-	.pwrdn_delay_max	= 1005,		/* us */
 };
 
 static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
@@ -1708,8 +1693,6 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
 	.phy_status		= PHYSTATUS,
 
 	.has_pwrdn_delay	= true,
-	.pwrdn_delay_min	= 995,		/* us */
-	.pwrdn_delay_max	= 1005,		/* us */
 };
 
 static const struct qmp_phy_cfg msm8998_pciephy_cfg = {
@@ -1765,8 +1748,6 @@ static const struct qmp_phy_cfg sc8180x_pciephy_cfg = {
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 
 	.has_pwrdn_delay	= true,
-	.pwrdn_delay_min	= 995,		/* us */
-	.pwrdn_delay_max	= 1005,		/* us */
 };
 
 static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
@@ -1797,8 +1778,6 @@ static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
 	.phy_status		= PHYSTATUS_4_20,
 
 	.has_pwrdn_delay	= true,
-	.pwrdn_delay_min	= 995,		/* us */
-	.pwrdn_delay_max	= 1005,		/* us */
 };
 
 static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
@@ -1829,8 +1808,6 @@ static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
 	.phy_status		= PHYSTATUS,
 
 	.has_pwrdn_delay	= true,
-	.pwrdn_delay_min	= 995,		/* us */
-	.pwrdn_delay_max	= 1005,		/* us */
 };
 
 static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
@@ -1876,8 +1853,6 @@ static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
 	.phy_status		= PHYSTATUS_4_20,
 
 	.has_pwrdn_delay	= true,
-	.pwrdn_delay_min	= 995,		/* us */
-	.pwrdn_delay_max	= 1005,		/* us */
 };
 
 static void qmp_pcie_configure_lane(void __iomem *base,
@@ -2037,7 +2012,7 @@ static int qmp_pcie_power_on(struct phy *phy)
 	qmp_pcie_pcs_init(qphy, mode_tables);
 
 	if (cfg->has_pwrdn_delay)
-		usleep_range(cfg->pwrdn_delay_min, cfg->pwrdn_delay_max);
+		usleep_range(1000, 1200);
 
 	/* Pull PHY out of reset state */
 	qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
-- 
2.35.1

