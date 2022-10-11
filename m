Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AAC5FB311
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJKNP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiJKNO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:14:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42B512AA7;
        Tue, 11 Oct 2022 06:14:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E36CE6119D;
        Tue, 11 Oct 2022 13:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE953C4FF0E;
        Tue, 11 Oct 2022 13:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665494088;
        bh=7iqBl5ToGpZIK8VdO6IaG81Yvl6yy+W8gMPBoqqK1fI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MLUcUnv0oLYFP8+tSsvjJwCcWgz4veZION/D6RloSBaPYIWPcYyrOz+ADfxkLg0V/
         O+k6lbogjGBQY55ffrEt+qitO8qU5/jwf3iWlXstlDfGsss7z0iDYWGPzP1A+ZOh6y
         DrrFsE9ucxco5Y210Bt1C1wK1YjLvpdv8XbsPhhfNtox4LL3zdiUJ6RHAeIbO+ARld
         fVFi4iv0oLOFMqJnLCimXuCIKl2ag0HUJrHp2Ma/3pesWZVVpA/Skgb7DaJxwncVd5
         iTvBs8zBdjofhXzIxZpTs+iWFZ+4NRN/S3jV3ZKg/0vTKFDhoXJfnfc2A/ro50ZVHM
         vpRh/5u5kghsA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oiF5j-0000fI-AC; Tue, 11 Oct 2022 15:14:39 +0200
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
Subject: [PATCH 13/13] phy: qcom-qmp-usb: drop power-down delay config
Date:   Tue, 11 Oct 2022 15:14:16 +0200
Message-Id: <20221011131416.2478-14-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221011131416.2478-1-johan+linaro@kernel.org>
References: <20221011131416.2478-1-johan+linaro@kernel.org>
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

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 35 +------------------------
 1 file changed, 1 insertion(+), 34 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index 57dda1ecefe6..751f628710eb 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -63,8 +63,6 @@
 #define CLAMP_EN				BIT(0) /* enables i/o clamp_n */
 
 #define PHY_INIT_COMPLETE_TIMEOUT		10000
-#define POWER_DOWN_DELAY_US_MIN			10
-#define POWER_DOWN_DELAY_US_MAX			11
 
 struct qmp_phy_init_tbl {
 	unsigned int offset;
@@ -1452,9 +1450,6 @@ struct qmp_phy_cfg {
 
 	/* true, if PHY needs delay after POWER_DOWN */
 	bool has_pwrdn_delay;
-	/* power_down delay in usec */
-	int pwrdn_delay_min;
-	int pwrdn_delay_max;
 
 	/* true, if PHY has a separate DP_COM control block */
 	bool has_phy_dp_com_ctrl;
@@ -1660,9 +1655,6 @@ static const struct qmp_phy_cfg qmp_v3_usb3phy_cfg = {
 	.phy_status		= PHYSTATUS,
 
 	.has_pwrdn_delay	= true,
-	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
-	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
-
 	.has_phy_dp_com_ctrl	= true,
 };
 
@@ -1690,9 +1682,6 @@ static const struct qmp_phy_cfg sc7180_usb3phy_cfg = {
 	.phy_status		= PHYSTATUS,
 
 	.has_pwrdn_delay	= true,
-	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
-	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
-
 	.has_phy_dp_com_ctrl	= true,
 };
 
@@ -1744,8 +1733,6 @@ static const struct qmp_phy_cfg qmp_v3_usb3_uniphy_cfg = {
 	.phy_status		= PHYSTATUS,
 
 	.has_pwrdn_delay	= true,
-	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
-	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
 };
 
 static const struct qmp_phy_cfg msm8998_usb3phy_cfg = {
@@ -1798,11 +1785,7 @@ static const struct qmp_phy_cfg sm8150_usb3phy_cfg = {
 	.pwrdn_ctrl		= SW_PWRDN,
 	.phy_status		= PHYSTATUS,
 
-
 	.has_pwrdn_delay	= true,
-	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
-	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
-
 	.has_phy_dp_com_ctrl	= true,
 };
 
@@ -1833,8 +1816,6 @@ static const struct qmp_phy_cfg sm8150_usb3_uniphy_cfg = {
 	.phy_status		= PHYSTATUS,
 
 	.has_pwrdn_delay	= true,
-	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
-	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
 };
 
 static const struct qmp_phy_cfg sm8250_usb3phy_cfg = {
@@ -1864,9 +1845,6 @@ static const struct qmp_phy_cfg sm8250_usb3phy_cfg = {
 	.phy_status		= PHYSTATUS,
 
 	.has_pwrdn_delay	= true,
-	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
-	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
-
 	.has_phy_dp_com_ctrl	= true,
 };
 
@@ -1897,8 +1875,6 @@ static const struct qmp_phy_cfg sm8250_usb3_uniphy_cfg = {
 	.phy_status		= PHYSTATUS,
 
 	.has_pwrdn_delay	= true,
-	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
-	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
 };
 
 static const struct qmp_phy_cfg sdx55_usb3_uniphy_cfg = {
@@ -1928,8 +1904,6 @@ static const struct qmp_phy_cfg sdx55_usb3_uniphy_cfg = {
 	.phy_status		= PHYSTATUS,
 
 	.has_pwrdn_delay	= true,
-	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
-	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
 };
 
 static const struct qmp_phy_cfg sdx65_usb3_uniphy_cfg = {
@@ -1959,8 +1933,6 @@ static const struct qmp_phy_cfg sdx65_usb3_uniphy_cfg = {
 	.phy_status		= PHYSTATUS,
 
 	.has_pwrdn_delay	= true,
-	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
-	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
 };
 
 static const struct qmp_phy_cfg sm8350_usb3phy_cfg = {
@@ -1990,9 +1962,6 @@ static const struct qmp_phy_cfg sm8350_usb3phy_cfg = {
 	.phy_status		= PHYSTATUS,
 
 	.has_pwrdn_delay	= true,
-	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
-	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
-
 	.has_phy_dp_com_ctrl	= true,
 };
 
@@ -2023,8 +1992,6 @@ static const struct qmp_phy_cfg sm8350_usb3_uniphy_cfg = {
 	.phy_status		= PHYSTATUS,
 
 	.has_pwrdn_delay	= true,
-	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
-	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
 };
 
 static const struct qmp_phy_cfg qcm2290_usb3phy_cfg = {
@@ -2205,7 +2172,7 @@ static int qmp_usb_power_on(struct phy *phy)
 	qmp_usb_configure(pcs, cfg->pcs_tbl, cfg->pcs_tbl_num);
 
 	if (cfg->has_pwrdn_delay)
-		usleep_range(cfg->pwrdn_delay_min, cfg->pwrdn_delay_max);
+		usleep_range(10, 20);
 
 	/* Pull PHY out of reset state */
 	qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
-- 
2.35.1

