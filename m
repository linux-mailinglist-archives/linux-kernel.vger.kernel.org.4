Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2B16D5997
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbjDDH0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbjDDHZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:25:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055462D66;
        Tue,  4 Apr 2023 00:25:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13DAF62F7D;
        Tue,  4 Apr 2023 07:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0483BC43444;
        Tue,  4 Apr 2023 07:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680593146;
        bh=zWmuC496pqTix/rZxkywu1zj6uxV5eFhonW4MahNP64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ejedvJFiAWvSB/FG9rLaSNYmMMrN9IkOTwtEADgEwVC/s59DY3W73VwENHxgi1gD8
         dTq5rwdNbth6A9kehBOtCAq/Vfe8IyZU2n1/ZZlgLkQT7KnUpwphhHMMw3vlm1OyDg
         b2XZWRlB2e7sEoEzaFGXU+ljWSNpWbv485/Urx1K6nk+sz51eSAokmfN069MmqOKtc
         0ke3Y71EZ/Ne4jbEIJs9Z1WYqzTXRyqZ+krcxih5RI2AdzE1bysnu70BR9rDkFSnCU
         1GIf2qBHr7+7E3H1fgJO8bkrZaK17PgiSyo1w0u/I0IwmzrZAVLd7jVQaI4WwDIil1
         LM34jRxs4m1QA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pjb3V-0004xn-DF; Tue, 04 Apr 2023 09:26:13 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 09/11] USB: dwc3: refactor phy handling
Date:   Tue,  4 Apr 2023 09:25:22 +0200
Message-Id: <20230404072524.19014-10-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404072524.19014-1-johan+linaro@kernel.org>
References: <20230404072524.19014-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the PHY handling using four new helpers to initialise,
deinitialise, power on and power off all the PHYs.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/dwc3/core.c | 143 ++++++++++++++++++++++++----------------
 1 file changed, 86 insertions(+), 57 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index c499ef026500..52cd5ddfebd5 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -721,6 +721,76 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	return 0;
 }
 
+static int dwc3_phy_init(struct dwc3 *dwc)
+{
+	int ret;
+
+	usb_phy_init(dwc->usb2_phy);
+	usb_phy_init(dwc->usb3_phy);
+
+	ret = phy_init(dwc->usb2_generic_phy);
+	if (ret < 0)
+		goto err_shutdown_usb3_phy;
+
+	ret = phy_init(dwc->usb3_generic_phy);
+	if (ret < 0)
+		goto err_exit_usb2_phy;
+
+	return 0;
+
+err_exit_usb2_phy:
+	phy_exit(dwc->usb2_generic_phy);
+err_shutdown_usb3_phy:
+	usb_phy_shutdown(dwc->usb3_phy);
+	usb_phy_shutdown(dwc->usb2_phy);
+
+	return ret;
+}
+
+static void dwc3_phy_exit(struct dwc3 *dwc)
+{
+	phy_exit(dwc->usb3_generic_phy);
+	phy_exit(dwc->usb2_generic_phy);
+
+	usb_phy_shutdown(dwc->usb3_phy);
+	usb_phy_shutdown(dwc->usb2_phy);
+}
+
+static int dwc3_phy_power_on(struct dwc3 *dwc)
+{
+	int ret;
+
+	usb_phy_set_suspend(dwc->usb2_phy, 0);
+	usb_phy_set_suspend(dwc->usb3_phy, 0);
+
+	ret = phy_power_on(dwc->usb2_generic_phy);
+	if (ret < 0)
+		goto err_suspend_usb3_phy;
+
+	ret = phy_power_on(dwc->usb3_generic_phy);
+	if (ret < 0)
+		goto err_power_off_usb2_phy;
+
+	return 0;
+
+err_power_off_usb2_phy:
+	phy_power_off(dwc->usb2_generic_phy);
+err_suspend_usb3_phy:
+	usb_phy_set_suspend(dwc->usb3_phy, 1);
+	usb_phy_set_suspend(dwc->usb2_phy, 1);
+
+	return ret;
+}
+
+static void dwc3_phy_power_off(struct dwc3 *dwc)
+{
+	phy_power_off(dwc->usb3_generic_phy);
+	phy_power_off(dwc->usb2_generic_phy);
+
+	usb_phy_set_suspend(dwc->usb3_phy, 1);
+	usb_phy_set_suspend(dwc->usb2_phy, 1);
+}
+
 static int dwc3_clk_enable(struct dwc3 *dwc)
 {
 	int ret;
@@ -756,17 +826,8 @@ static void dwc3_clk_disable(struct dwc3 *dwc)
 static void dwc3_core_exit(struct dwc3 *dwc)
 {
 	dwc3_event_buffers_cleanup(dwc);
-
-	usb_phy_set_suspend(dwc->usb2_phy, 1);
-	usb_phy_set_suspend(dwc->usb3_phy, 1);
-	phy_power_off(dwc->usb2_generic_phy);
-	phy_power_off(dwc->usb3_generic_phy);
-
-	usb_phy_shutdown(dwc->usb2_phy);
-	usb_phy_shutdown(dwc->usb3_phy);
-	phy_exit(dwc->usb2_generic_phy);
-	phy_exit(dwc->usb3_generic_phy);
-
+	dwc3_phy_power_off(dwc);
+	dwc3_phy_exit(dwc);
 	dwc3_clk_disable(dwc);
 	reset_control_assert(dwc->reset);
 }
@@ -1029,20 +1090,13 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc->phys_ready = true;
 	}
 
-	usb_phy_init(dwc->usb2_phy);
-	usb_phy_init(dwc->usb3_phy);
-
-	ret = phy_init(dwc->usb2_generic_phy);
-	if (ret < 0)
-		goto err_shutdown_usb3_phy;
-
-	ret = phy_init(dwc->usb3_generic_phy);
-	if (ret < 0)
-		goto err_exit_usb2_phy;
+	ret = dwc3_phy_init(dwc);
+	if (ret)
+		goto err_exit_ulpi;
 
 	ret = dwc3_core_soft_reset(dwc);
 	if (ret)
-		goto err_exit_usb3_phy;
+		goto err_exit_phy;
 
 	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD &&
 	    !DWC3_VER_IS_WITHIN(DWC3, ANY, 194A)) {
@@ -1073,20 +1127,14 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	dwc3_set_incr_burst_type(dwc);
 
-	usb_phy_set_suspend(dwc->usb2_phy, 0);
-	usb_phy_set_suspend(dwc->usb3_phy, 0);
-	ret = phy_power_on(dwc->usb2_generic_phy);
-	if (ret < 0)
-		goto err_suspend_usb3_phy;
-
-	ret = phy_power_on(dwc->usb3_generic_phy);
-	if (ret < 0)
-		goto err_power_off_usb2_phy;
+	dwc3_phy_power_on(dwc);
+	if (ret)
+		goto err_exit_phy;
 
 	ret = dwc3_event_buffers_setup(dwc);
 	if (ret) {
 		dev_err(dwc->dev, "failed to setup event buffers\n");
-		goto err_power_off_usb3_phy;
+		goto err_power_off_phy;
 	}
 
 	/*
@@ -1203,20 +1251,10 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	return 0;
 
-err_power_off_usb3_phy:
-	phy_power_off(dwc->usb3_generic_phy);
-err_power_off_usb2_phy:
-	phy_power_off(dwc->usb2_generic_phy);
-err_suspend_usb3_phy:
-	usb_phy_set_suspend(dwc->usb3_phy, 1);
-	usb_phy_set_suspend(dwc->usb2_phy, 1);
-err_exit_usb3_phy:
-	phy_exit(dwc->usb3_generic_phy);
-err_exit_usb2_phy:
-	phy_exit(dwc->usb2_generic_phy);
-err_shutdown_usb3_phy:
-	usb_phy_shutdown(dwc->usb3_phy);
-	usb_phy_shutdown(dwc->usb2_phy);
+err_power_off_phy:
+	dwc3_phy_power_off(dwc);
+err_exit_phy:
+	dwc3_phy_exit(dwc);
 err_exit_ulpi:
 	dwc3_ulpi_exit(dwc);
 
@@ -1832,17 +1870,8 @@ static int dwc3_probe(struct platform_device *pdev)
 err_exit_debugfs:
 	dwc3_debugfs_exit(dwc);
 	dwc3_event_buffers_cleanup(dwc);
-
-	usb_phy_set_suspend(dwc->usb2_phy, 1);
-	usb_phy_set_suspend(dwc->usb3_phy, 1);
-	phy_power_off(dwc->usb2_generic_phy);
-	phy_power_off(dwc->usb3_generic_phy);
-
-	usb_phy_shutdown(dwc->usb2_phy);
-	usb_phy_shutdown(dwc->usb3_phy);
-	phy_exit(dwc->usb2_generic_phy);
-	phy_exit(dwc->usb3_generic_phy);
-
+	dwc3_phy_power_off(dwc);
+	dwc3_phy_exit(dwc);
 	dwc3_ulpi_exit(dwc);
 err_free_event_buffers:
 	dwc3_free_event_buffers(dwc);
-- 
2.39.2

