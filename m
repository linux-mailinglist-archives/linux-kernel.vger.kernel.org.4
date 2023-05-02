Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81956F483D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 18:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbjEBQVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 12:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbjEBQVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 12:21:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E17A1FCF;
        Tue,  2 May 2023 09:21:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0E966269A;
        Tue,  2 May 2023 16:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2944BC433D2;
        Tue,  2 May 2023 16:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683044505;
        bh=b9tefdzOc1bWXV5kmOP1p0fNq2clTQHh+ZqUpM8gGtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V9oxEH7Qn0fCfI1+zCTzDe/iIXyCxd64aiBIgCh6iRUrhVaF2rwAeOFcM5nXMx+7/
         mRAz5rgyfKMuve8fFY/FG0k1sNdWHwVm+godXEMbfIZZuUPFoq+D8z8E0Ibx/hFoZT
         TVLG5suliIe/RNSHfsjwuUYjwtj+h3SIkOFAal4ZhqSMXVYDw4OVnOxDxpOB9MSQBg
         FiVK1OpwroNWsRx6+pZqoj3qaRN8ijybOkqPJJlBvWCKeTvkBZC4OJnCf7EvmhslSX
         VIFiN1g7+Z/wYOQcexnbeZlYus3faAeOtQnx1MdRfWN/Tc7Qn24Tr+xXuhXn0LhegF
         HlfBJn0n5u6aQ==
From:   Roger Quadros <rogerq@kernel.org>
To:     Thinh.Nguyen@synopsys.com
Cc:     gregkh@linuxfoundation.org, r-gunasekaran@ti.com, srk@ti.com,
        wcheng@codeaurora.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>,
        stable@vger.kernel.org
Subject: [PATCH v2 2/2] usb: dwc3: gadget: Improve dwc3_gadget_suspend() and dwc3_gadget_resume()
Date:   Tue,  2 May 2023 19:21:33 +0300
Message-Id: <20230502162133.148821-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230502162133.148821-1-rogerq@kernel.org>
References: <20230502162133.148821-1-rogerq@kernel.org>
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
---
 drivers/usb/dwc3/gadget.c | 66 +++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index b5170374cd18..869f1695565d 100644
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
 
@@ -4655,42 +4659,38 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 int dwc3_gadget_suspend(struct dwc3 *dwc)
 {
 	unsigned long flags;
+	int ret;
 
 	if (!dwc->gadget_driver || !dwc->softconnect)
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
+	dwc3_gadget_soft_connect(dwc);
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

