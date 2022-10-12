Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E355FC267
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiJLIvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJLIun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:50:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21707895EE;
        Wed, 12 Oct 2022 01:50:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3A6DB819F0;
        Wed, 12 Oct 2022 08:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1B3C43152;
        Wed, 12 Oct 2022 08:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665564639;
        bh=xh/48riPxxrksVO8sUXV43vCkvfHT7+7zX2NHhbvI8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Je0iX9yBUJYvYHTEbNPZTk6Y80QUCBqqAn6Zp4phvFg4cWnmqMwCFIxH0YOvv5Ji7
         xJ94esdyqpbbYSxx17ykr5TCDeqtuEm/qOJXOCkFnLQ/De9AjP5bIzfehXsSuKksYq
         wytVN+mganwX4O3fxXJ+G6rr6vvlbf7At9Nhy4JqlniLJqZGhZb0UZWPf2pzil5EPp
         DKjTJy9dHS9PCXuvhF5WkZC+wWciBZFPWoQVf9Ir4yAoQMhIIHVOW0Yb8VfZO9+pKq
         EuqzaqupV8wTwNdwjqd7MWjwFfT1D2UizVsls4y1kFzQP7oHY/gUovGL9IH9LH5PFm
         TpLVF42rQA9rA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oiXRe-0006Hp-O8; Wed, 12 Oct 2022 10:50:30 +0200
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
Subject: [PATCH 08/20] phy: qcom-qmp-combo: clean up status polling
Date:   Wed, 12 Oct 2022 10:49:50 +0200
Message-Id: <20221012085002.24099-8-johan+linaro@kernel.org>
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

Clean up the PHY status polling by dropping the configuration mask which
is no longer needed since the QMP driver split.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 82055d3a3536..e312cad6d9c2 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -853,8 +853,6 @@ struct qmp_phy_cfg {
 
 	unsigned int start_ctrl;
 	unsigned int pwrdn_ctrl;
-	/* bit offset of PHYSTATUS in QPHY_PCS_STATUS register */
-	unsigned int phy_status;
 
 	/* true, if PHY needs delay after POWER_DOWN */
 	bool has_pwrdn_delay;
@@ -1023,7 +1021,6 @@ static const struct qmp_phy_cfg sc7180_usb3phy_cfg = {
 
 	.start_ctrl		= SERDES_START | PCS_START,
 	.pwrdn_ctrl		= SW_PWRDN,
-	.phy_status		= PHYSTATUS,
 
 	.has_pwrdn_delay	= true,
 };
@@ -1092,7 +1089,6 @@ static const struct qmp_phy_cfg sdm845_usb3phy_cfg = {
 
 	.start_ctrl		= SERDES_START | PCS_START,
 	.pwrdn_ctrl		= SW_PWRDN,
-	.phy_status		= PHYSTATUS,
 
 	.has_pwrdn_delay	= true,
 };
@@ -1127,7 +1123,6 @@ static const struct qmp_phy_cfg sm8150_usb3phy_cfg = {
 
 	.start_ctrl		= SERDES_START | PCS_START,
 	.pwrdn_ctrl		= SW_PWRDN,
-	.phy_status		= PHYSTATUS,
 
 	.has_pwrdn_delay	= true,
 };
@@ -1197,7 +1192,6 @@ static const struct qmp_phy_cfg sc8280xp_usb43dp_usb_cfg = {
 
 	.start_ctrl		= SERDES_START | PCS_START,
 	.pwrdn_ctrl		= SW_PWRDN,
-	.phy_status		= PHYSTATUS,
 };
 
 static const struct qmp_phy_cfg sc8280xp_usb43dp_dp_cfg = {
@@ -1267,7 +1261,6 @@ static const struct qmp_phy_cfg sm8250_usb3phy_cfg = {
 
 	.start_ctrl		= SERDES_START | PCS_START,
 	.pwrdn_ctrl		= SW_PWRDN,
-	.phy_status		= PHYSTATUS,
 
 	.has_pwrdn_delay	= true,
 };
@@ -2017,7 +2010,7 @@ static int qmp_combo_power_on(struct phy *phy)
 	void __iomem *rx = qphy->rx;
 	void __iomem *pcs = qphy->pcs;
 	void __iomem *status;
-	unsigned int mask, val, ready;
+	unsigned int val;
 	int ret;
 
 	qmp_combo_serdes_init(qphy);
@@ -2059,10 +2052,7 @@ static int qmp_combo_power_on(struct phy *phy)
 		qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
 
 		status = pcs + cfg->regs[QPHY_PCS_STATUS];
-		mask = cfg->phy_status;
-		ready = 0;
-
-		ret = readl_poll_timeout(status, val, (val & mask) == ready, 10,
+		ret = readl_poll_timeout(status, val, !(val & PHYSTATUS), 10,
 					 PHY_INIT_COMPLETE_TIMEOUT);
 		if (ret) {
 			dev_err(qmp->dev, "phy initialization timed-out\n");
-- 
2.35.1

