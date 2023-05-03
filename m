Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841216F56C3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 13:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjECLBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 07:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjECLBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 07:01:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7DF59F2;
        Wed,  3 May 2023 04:00:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE948621B6;
        Wed,  3 May 2023 11:00:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC01C433D2;
        Wed,  3 May 2023 11:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683111654;
        bh=aVQhtxN0NqJG5qAwFQGM7qQW6a+VAP6JwXVNlk6TTI4=;
        h=From:To:Cc:Subject:Date:From;
        b=Pew2rThKTE2IVaEDpnKSwdq2+hrdTIOJoGtZu56OmT77m7fLKOssjQ+M9ZANRvl+F
         Y2QyZ23JuiorwffwwZAkfU7XiQ4CCt5svNwaOyod14xrccDZR1nnXdAGLMbzW+thWs
         OyCUMrDZPyC4rm48OZ1/+5iFTQKb4Dh3AR4EuvyRavi//egHyZ2V28Z4xkcKwTCP6F
         gkh5AyYIRKOULoFyaTfy9AnkdU1VfvqMcGCYo0YzHmOcn6HpCUhtI6ddFK77rPUG21
         A9Ax+uOwoyRdbO74GV3qqg04G0skrXu4aXYWpfzAZDp+Va76gC5OSDuvfkT1GfdfUc
         OnSXeRmTt9ZQQ==
From:   Roger Quadros <rogerq@kernel.org>
To:     Thinh.Nguyen@synopsys.com
Cc:     gregkh@linuxfoundation.org, r-gunasekaran@ti.com, srk@ti.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>, stable@vger.kernel.org
Subject: [PATCH v3] usb: dwc3: gadget: Improve dwc3_gadget_suspend() and dwc3_gadget_resume()
Date:   Wed,  3 May 2023 14:00:48 +0300
Message-Id: <20230503110048.30617-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent -ETIMEDOUT error on .suspend().
e.g. If gadget driver is loaded and we are connected to a USB host,
all transfers must be stopped before stopping the controller else
we will not get a clean stop i.e. dwc3_gadget_run_stop() will take
several seconds to complete and will return -ETIMEDOUT.

Handle error cases properly in dwc3_gadget_suspend().
Simplify dwc3_gadget_resume() by using the introduced helper function.

Fixes: 9f8a67b65a49 ("usb: dwc3: gadget: fix gadget suspend/resume")
Cc: stable@vger.kernel.org
Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---

Changelog:

v3:
- dropped patch 1. Now no longer check for softconnect during .suspend
- in suspend error path check for softconnect and enable softconnect accordingly
- added Acked-by tag by Thinh Nguyen

v2:
- rebase on greg/usb-next
- split into 2 patches. Add Fixes tag and cc stable.
- do not check for !softconnect in error condition in dwc3_gadget_suspend()

 drivers/usb/dwc3/gadget.c | 67 ++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 33 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index c0ca4d12f95d..2996bcb4d53d 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2699,6 +2699,21 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	return ret;
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
+	return dwc3_gadget_run_stop(dwc, true);
+}
+
 static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
@@ -2737,21 +2752,10 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 
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
-		ret = dwc3_gadget_run_stop(dwc, true);
-	}
+	else
+		ret = dwc3_gadget_soft_connect(dwc);
 
 	pm_runtime_put(dwc->dev);
 
@@ -4655,42 +4659,39 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 int dwc3_gadget_suspend(struct dwc3 *dwc)
 {
 	unsigned long flags;
+	int ret;
 
 	if (!dwc->gadget_driver)
 		return 0;
 
-	dwc3_gadget_run_stop(dwc, false);
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
-	ret = dwc3_gadget_run_stop(dwc, true);
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

