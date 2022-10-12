Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723F15FC1CD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiJLIQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiJLIP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:15:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA9C89916;
        Wed, 12 Oct 2022 01:15:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 694CD6147A;
        Wed, 12 Oct 2022 08:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08A0C4FF0A;
        Wed, 12 Oct 2022 08:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665562555;
        bh=bYQN0YtO3QDxIDiiIbVNgHd6/O2oSORExytwbqbGh7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tx0WxBJDYVSw5qJcuh6FjqqAYA1g0eHqBKCFm+Q/fgZOuIeJ5HUAhQNXrlJRKMum7
         s3kR0u5Ud4cNw0u76CNXNRiVxlg6Fvn3B0fcVtZSBw9qJypNo50nHVKJloK6d7jHiH
         gngsQiLDYeA6ledF0jXrffNybG2tkQIsd7P1eE0z+/z++myd5ExaqwMfZhhl7jIV2p
         7gnFBEIJ546JG5F23xd/t7QA0XTSdVzlPl/m/v8obauyu5cKtVyKbeZLS5gyM5SvCa
         0WCXxaeuwXg7gjWlA20aXQ41a65cN+Nou6unT3fTeY3ylIys0zBB1m+DNHl7Jw4xhj
         +A4ZdGPKXJmXA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oiWu3-0004or-78; Wed, 12 Oct 2022 10:15:47 +0200
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
Subject: [PATCH v2 12/14] phy: qcom-qmp-combo: drop power-down delay config
Date:   Wed, 12 Oct 2022 10:12:39 +0200
Message-Id: <20221012081241.18273-13-johan+linaro@kernel.org>
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
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index a8e09333072e..82055d3a3536 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -63,8 +63,6 @@
 #define CLAMP_EN				BIT(0) /* enables i/o clamp_n */
 
 #define PHY_INIT_COMPLETE_TIMEOUT		10000
-#define POWER_DOWN_DELAY_US_MIN			10
-#define POWER_DOWN_DELAY_US_MAX			11
 
 struct qmp_phy_init_tbl {
 	unsigned int offset;
@@ -860,9 +858,6 @@ struct qmp_phy_cfg {
 
 	/* true, if PHY needs delay after POWER_DOWN */
 	bool has_pwrdn_delay;
-	/* power_down delay in usec */
-	int pwrdn_delay_min;
-	int pwrdn_delay_max;
 
 	/* Offset from PCS to PCS_USB region */
 	unsigned int pcs_usb_offset;
@@ -1031,8 +1026,6 @@ static const struct qmp_phy_cfg sc7180_usb3phy_cfg = {
 	.phy_status		= PHYSTATUS,
 
 	.has_pwrdn_delay	= true,
-	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
-	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
 };
 
 static const struct qmp_phy_cfg sc7180_dpphy_cfg = {
@@ -1102,8 +1095,6 @@ static const struct qmp_phy_cfg sdm845_usb3phy_cfg = {
 	.phy_status		= PHYSTATUS,
 
 	.has_pwrdn_delay	= true,
-	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
-	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
 };
 
 static const struct qmp_phy_combo_cfg sdm845_usb3dpphy_cfg = {
@@ -1138,10 +1129,7 @@ static const struct qmp_phy_cfg sm8150_usb3phy_cfg = {
 	.pwrdn_ctrl		= SW_PWRDN,
 	.phy_status		= PHYSTATUS,
 
-
 	.has_pwrdn_delay	= true,
-	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
-	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
 };
 
 static const struct qmp_phy_cfg sc8180x_dpphy_cfg = {
@@ -1282,8 +1270,6 @@ static const struct qmp_phy_cfg sm8250_usb3phy_cfg = {
 	.phy_status		= PHYSTATUS,
 
 	.has_pwrdn_delay	= true,
-	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
-	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
 };
 
 static const struct qmp_phy_cfg sm8250_dpphy_cfg = {
@@ -2064,7 +2050,7 @@ static int qmp_combo_power_on(struct phy *phy)
 		qmp_combo_configure(pcs, cfg->pcs_tbl, cfg->pcs_tbl_num);
 
 	if (cfg->has_pwrdn_delay)
-		usleep_range(cfg->pwrdn_delay_min, cfg->pwrdn_delay_max);
+		usleep_range(10, 20);
 
 	if (cfg->type != PHY_TYPE_DP) {
 		/* Pull PHY out of reset state */
-- 
2.35.1

