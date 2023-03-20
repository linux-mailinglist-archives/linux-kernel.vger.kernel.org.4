Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822D36C0D6C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjCTJfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjCTJfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:35:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A231B572;
        Mon, 20 Mar 2023 02:35:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E781CB80D7D;
        Mon, 20 Mar 2023 09:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75014C4339C;
        Mon, 20 Mar 2023 09:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679304899;
        bh=XAeKuwAyy3BpuGbVe2bkXu++daEbNc72qyzyGZsAOMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uMHzvJJSi/yTk8lRtxH05x1dx3ke8t6MxNW0cyJNywTCnCMdZt9UWvBVPDz02Enhx
         yS8Z9KhUN1bo6gO3p45UqibeRvqik0gILQgUvcv9ScudqdoIlZ/X6sEbpWFU65fbny
         MOCDlxjtvWt5fF3xmagkzUPJmz3Zn55jBX3ST3oLkYu6INdAillvEunV1Hya0pPDJM
         P2Tx7dpxzpor6rKmDjAOUZui4hRNMCFDGe6CBXqiDRXnYpdwYHL7zGtUbu3KduMaJ7
         MBGdn0kzhCoYzITq0ZGSurYBQQTlsEafcbKg6XrsLhLHd2rn+VOWjZXZFbCPYcyrTM
         lVcaVlDzjnm8g==
From:   Roger Quadros <rogerq@kernel.org>
To:     Thinh.Nguyen@synopsys.com, stern@rowland.harvard.edu
Cc:     gregkh@linuxfoundation.org, vigneshr@ti.com, srk@ti.com,
        r-gunasekaran@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [RFC PATCH 2/2] usb: dwc3: Support 'snps,gadget-keep-connect-sys-sleep' feature
Date:   Mon, 20 Mar 2023 11:34:47 +0200
Message-Id: <20230320093447.32105-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320093447.32105-1-rogerq@kernel.org>
References: <20230320093447.32105-1-rogerq@kernel.org>
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

Implement 'snps,gadget-keep-connect-sys-sleep' property.

Do not stop the gadget controller and disconnect if this
property is present and we are connected to a USB Host.

Prevent System sleep if Gadget is not in USB suspend.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/usb/dwc3/core.c   | 25 +++++++++++++++++++------
 drivers/usb/dwc3/core.h   |  2 ++
 drivers/usb/dwc3/gadget.c | 25 +++++++++++++++++++++++--
 3 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 476b63618511..a47bbaa27302 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1575,6 +1575,9 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->dis_split_quirk = device_property_read_bool(dev,
 				"snps,dis-split-quirk");
 
+	dwc->gadget_keep_connect_sys_sleep = device_property_read_bool(dev,
+				"snps,gadget-keep-connect-sys-sleep");
+
 	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
 	dwc->tx_de_emphasis = tx_de_emphasis;
 
@@ -2027,14 +2030,20 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 {
 	unsigned long	flags;
 	u32 reg;
+	int ret;
 
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
 		if (pm_runtime_suspended(dwc->dev))
 			break;
-		dwc3_gadget_suspend(dwc);
+		ret = dwc3_gadget_suspend(dwc);
+		if (ret) {
+			dev_err(dwc->dev, "gadget not suspended: %d\n", ret);
+			return ret;
+		}
 		synchronize_irq(dwc->irq_gadget);
-		dwc3_core_exit(dwc);
+		if(!dwc->gadget_keep_connect_sys_sleep)
+			dwc3_core_exit(dwc);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
 		if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(dwc->dev)) {
@@ -2088,11 +2097,15 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
-		ret = dwc3_core_init_for_resume(dwc);
-		if (ret)
-			return ret;
+		if (!dwc->gadget_keep_connect_sys_sleep)
+		{
+			ret = dwc3_core_init_for_resume(dwc);
+			if (ret)
+				return ret;
+
+			dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+		}
 
-		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
 		dwc3_gadget_resume(dwc);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 582ebd9cf9c2..f84bac815bed 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1328,6 +1328,8 @@ struct dwc3 {
 	unsigned		dis_split_quirk:1;
 	unsigned		async_callbacks:1;
 
+	unsigned		gadget_keep_connect_sys_sleep:1;
+
 	u16			imod_interval;
 
 	int			max_cfg_eps;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 3c63fa97a680..8062e44f63f6 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4572,12 +4572,23 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 int dwc3_gadget_suspend(struct dwc3 *dwc)
 {
 	unsigned long flags;
+	int link_state;
 
 	if (!dwc->gadget_driver)
 		return 0;
 
-	dwc3_gadget_run_stop(dwc, false, false);
+	if (dwc->gadget_keep_connect_sys_sleep && dwc->connected) {
+		link_state = dwc3_gadget_get_link_state(dwc);
+		/* Prevent PM Sleep if not in U3/L2 */
+		if (link_state != DWC3_LINK_STATE_U3)
+			return -EBUSY;
+
+		/* don't stop/disconnect */
+		dwc3_gadget_disable_irq(dwc);
+		return 0;
+	}
 
+	dwc3_gadget_run_stop(dwc, false, false);
 	spin_lock_irqsave(&dwc->lock, flags);
 	dwc3_disconnect_gadget(dwc);
 	__dwc3_gadget_stop(dwc);
@@ -4588,11 +4599,21 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
 
 int dwc3_gadget_resume(struct dwc3 *dwc)
 {
-	int			ret;
+	int ret;
+	irqreturn_t irq_t;
 
 	if (!dwc->gadget_driver || !dwc->softconnect)
 		return 0;
 
+	if (dwc->gadget_keep_connect_sys_sleep && dwc->connected) {
+		dwc3_gadget_enable_irq(dwc);
+		/* check pending events */
+		irq_t = dwc3_check_event_buf(dwc->ev_buf);
+		if (irq_t == IRQ_WAKE_THREAD)
+			dwc3_process_event_buf(dwc->ev_buf);
+		return 0;
+	}
+
 	ret = __dwc3_gadget_start(dwc);
 	if (ret < 0)
 		goto err0;
-- 
2.34.1

