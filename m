Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB20E6F1747
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 14:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346052AbjD1MIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 08:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345965AbjD1MIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 08:08:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6F6212D;
        Fri, 28 Apr 2023 05:08:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F8B064358;
        Fri, 28 Apr 2023 12:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAABC433D2;
        Fri, 28 Apr 2023 12:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682683704;
        bh=H7zz9k0fAxO598lk5RscNfG2z6M8eK1928V5K1H0KWg=;
        h=From:To:Cc:Subject:Date:From;
        b=eZ6vdgSRzzAzMSIf4YMhBs1IT/qRUwfzTpJZIPW5Djgr62R2BIt6z7yVpdq2vKeXn
         NRCp5pQcxFkfxVN4LrexR5svwIXbJHjvJMuaHT0/HUQEKBGv6iFHwPezvaA0rX1CRK
         x96vekamRthzLpc6rzoKU8gXH7rtZQABnAbi36BJsYKy0KQOOh7h8bnzrf4gmtKq07
         Jgl9zgKj/Ock5b8pXn2U7Gd3udZpFnPBL8gFFbEJgmfjM/5b7sBQd4Cpv9ymbSOm3J
         +zJf11LZEzM7JsxWDVSKWkkQ9mmzTx9/alqB9gSBrBwDyS006DvxsJgsuG3LhR0tDW
         aq2vSWPgTrvzA==
From:   Roger Quadros <rogerq@kernel.org>
To:     Thinh.Nguyen@synopsys.com
Cc:     gregkh@linuxfoundation.org, r-gunasekaran@ti.com, srk@ti.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH] usb: dwc3: gadget: Fix controller timeout at dwc3_gadget_suspend()
Date:   Fri, 28 Apr 2023 15:08:12 +0300
Message-Id: <20230428120812.107123-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If gadget driver is loaded and we are connected to a USB host,
all transfers must be stopped before stopping the controller else
we will not get a clean stop i.e. dwc3_gadget_run_stop() will take
several seconds to complete and will return -ETIMEDOUT. Fix this.

No need to stop the controller at dwc3_gadget_suspend() if
dwc->softconnect is 0 as controller is already stopped.

Handle error cases properly in dwc3_gadget_suspend().

Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 69 ++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 287ea6ee2463..b63502afb144 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2668,6 +2668,21 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	return dwc3_gadget_run_stop(dwc, false, false);
 }
 
+static int dwc3_gadget_soft_connect(struct dwc3 *dwc)
+{
+	/*
+	 * In the Synopsys DWC_usb31 1.90a programming guide section
+	 * 4.1.9, it specifies that for a reconnect after a
+	 * device-initiated disconnect requires a core soft reset
+	 * (DCTL.CSftRst) before enabling the run/stop bit.
+	 */
+	dwc3_core_soft_reset(dwc);
+
+	dwc3_event_buffers_setup(dwc);
+	__dwc3_gadget_start(dwc);
+	return dwc3_gadget_run_stop(dwc, true, false);
+}
+
 static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
@@ -2706,21 +2721,10 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 
 	synchronize_irq(dwc->irq_gadget);
 
-	if (!is_on) {
+	if (!is_on)
 		ret = dwc3_gadget_soft_disconnect(dwc);
-	} else {
-		/*
-		 * In the Synopsys DWC_usb31 1.90a programming guide section
-		 * 4.1.9, it specifies that for a reconnect after a
-		 * device-initiated disconnect requires a core soft reset
-		 * (DCTL.CSftRst) before enabling the run/stop bit.
-		 */
-		dwc3_core_soft_reset(dwc);
-
-		dwc3_event_buffers_setup(dwc);
-		__dwc3_gadget_start(dwc);
-		ret = dwc3_gadget_run_stop(dwc, true, false);
-	}
+	else
+		ret = dwc3_gadget_soft_connect(dwc);
 
 	pm_runtime_put(dwc->dev);
 
@@ -4674,42 +4678,39 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 int dwc3_gadget_suspend(struct dwc3 *dwc)
 {
 	unsigned long flags;
+	int ret;
 
-	if (!dwc->gadget_driver)
+	if (!dwc->gadget_driver || !dwc->softconnect)
 		return 0;
 
-	dwc3_gadget_run_stop(dwc, false, false);
+	ret = dwc3_gadget_soft_disconnect(dwc);
+	if (ret)
+		goto err;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	dwc3_disconnect_gadget(dwc);
-	__dwc3_gadget_stop(dwc);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return 0;
+
+err:
+	/*
+	 * Attempt to reset the controller's state. Likely no
+	 * communication can be established until the host
+	 * performs a port reset.
+	 */
+	if (dwc->softconnect)
+		dwc3_gadget_soft_connect(dwc);
+
+	return ret;
 }
 
 int dwc3_gadget_resume(struct dwc3 *dwc)
 {
-	int			ret;
-
 	if (!dwc->gadget_driver || !dwc->softconnect)
 		return 0;
 
-	ret = __dwc3_gadget_start(dwc);
-	if (ret < 0)
-		goto err0;
-
-	ret = dwc3_gadget_run_stop(dwc, true, false);
-	if (ret < 0)
-		goto err1;
-
-	return 0;
-
-err1:
-	__dwc3_gadget_stop(dwc);
-
-err0:
-	return ret;
+	return dwc3_gadget_soft_connect(dwc);
 }
 
 void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
-- 
2.34.1

