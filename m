Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7D56FF8B4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbjEKRsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238915AbjEKRso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:48:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE04C1BF8;
        Thu, 11 May 2023 10:48:40 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34BEXkIi015548;
        Thu, 11 May 2023 17:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=KtJFYBLAtSf0ie4VHY+aVj81JEKa7Tce07EEqcYjExI=;
 b=M4ue7RZUnv+xM2SgASyU/kWITPG4Pvr0vjIsUBVlQ7gIY8OWrBs7LiJXRVlSgYnMmGPq
 da9vUguAcolTBdW+YuIXfOGpStzUcce5uBcinfPPy49ozrfgr1lwvG8kWBKr8GOJeMy2
 9QCWTaSdTnAcpySbbB/vPtzxnO+GZnP80Av2KJUooxRcU3NMaeDXhat3Y9nmn+RwILLA
 F6ftiicgWuy+ybXhq75S9n282mC3SAzMm2AycXdEYQzUz9VNZs502ifF9CRmw61rObd6
 B9znvE6piY/aZOrUkoq3xylM77c+R/htoKKlMDw08ewtUXluF9ewFvflZJxeEyxjSnXq tA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qgkxmtar3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 17:48:37 +0000
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34BHmaBp031467;
        Thu, 11 May 2023 17:48:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTP id 3qdfym8vfv-1;
        Thu, 11 May 2023 17:48:36 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34BHmaHX031319;
        Thu, 11 May 2023 17:48:36 GMT
Received: from hu-devc-lv-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.164])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTP id 34BHmapv031219;
        Thu, 11 May 2023 17:48:36 +0000
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id 2333920D77; Thu, 11 May 2023 10:48:36 -0700 (PDT)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH 2/2] usb: dwc3: Modify runtime pm ops to handle bus suspend
Date:   Thu, 11 May 2023 10:48:31 -0700
Message-Id: <1683827311-1462-3-git-send-email-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1683827311-1462-1-git-send-email-quic_eserrao@quicinc.com>
References: <1683827311-1462-1-git-send-email-quic_eserrao@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LTW3oO5VAiCrcMA-fWbm7SVaM3QnTdq3
X-Proofpoint-GUID: LTW3oO5VAiCrcMA-fWbm7SVaM3QnTdq3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-11_14,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=434 priorityscore=1501
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305110153
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For bus suspend scenario we should skip controller halt
as we still have the usb cable connected. So modify the
runtime pm ops to handle bus suspend scenario. Also invoke
autosuspend when device receives U3 notification so that
controller can enter runtime suspended state. Ensure that
the controller is brought out of runtime suspend before
triggering remote wakeup.

Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
---
 drivers/usb/dwc3/core.c   | 19 +++++++++++++++++++
 drivers/usb/dwc3/gadget.c | 40 +++++++++++++++++++++++++++++++++-------
 2 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 0beaab9..b00d1e8 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2108,6 +2108,12 @@ static int dwc3_runtime_suspend(struct device *dev)
 {
 	struct dwc3     *dwc = dev_get_drvdata(dev);
 	int		ret;
+	u32		reg;
+
+	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
+	/* For bus suspend case do not halt the controller */
+	if (DWC3_DSTS_USBLNKST(reg) == DWC3_LINK_STATE_U3 && dwc->connected)
+		return 0;
 
 	if (dwc3_runtime_checks(dwc))
 		return -EBUSY;
@@ -2124,6 +2130,13 @@ static int dwc3_runtime_resume(struct device *dev)
 	struct dwc3     *dwc = dev_get_drvdata(dev);
 	int		ret;
 
+	/* resume from bus suspend */
+	if (dwc->connected) {
+		dwc3_gadget_process_pending_events(dwc);
+		pm_runtime_mark_last_busy(dev);
+		return 0;
+	}
+
 	ret = dwc3_resume_common(dwc, PMSG_AUTO_RESUME);
 	if (ret)
 		return ret;
@@ -2146,9 +2159,14 @@ static int dwc3_runtime_resume(struct device *dev)
 static int dwc3_runtime_idle(struct device *dev)
 {
 	struct dwc3     *dwc = dev_get_drvdata(dev);
+	u32		reg;
 
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
+		reg = dwc3_readl(dwc->regs, DWC3_DSTS);
+		/* for bus suspend case return success */
+		if (DWC3_DSTS_USBLNKST(reg) == DWC3_LINK_STATE_U3 && dwc->connected)
+			goto autosuspend;
 		if (dwc3_runtime_checks(dwc))
 			return -EBUSY;
 		break;
@@ -2158,6 +2176,7 @@ static int dwc3_runtime_idle(struct device *dev)
 		break;
 	}
 
+autosuspend:
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_autosuspend(dev);
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index c0ca4d1..d4da83b 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2400,15 +2400,21 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
 		return -EINVAL;
 	}
 
-	spin_lock_irqsave(&dwc->lock, flags);
 	if (!dwc->gadget->wakeup_armed) {
 		dev_err(dwc->dev, "not armed for remote wakeup\n");
-		spin_unlock_irqrestore(&dwc->lock, flags);
 		return -EINVAL;
 	}
-	ret = __dwc3_gadget_wakeup(dwc, true);
 
+	ret = pm_runtime_get_sync(dwc->dev);
+	if (ret) {
+		pm_runtime_put(dwc->dev);
+		return ret;
+	}
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	ret = __dwc3_gadget_wakeup(dwc, true);
 	spin_unlock_irqrestore(&dwc->lock, flags);
+	pm_runtime_put_noidle(dwc->dev);
 
 	return ret;
 }
@@ -2427,6 +2433,12 @@ static int dwc3_gadget_func_wakeup(struct usb_gadget *g, int intf_id)
 		return -EINVAL;
 	}
 
+	ret = pm_runtime_get_sync(dwc->dev);
+	if (ret) {
+		pm_runtime_put(dwc->dev);
+		return ret;
+	}
+
 	spin_lock_irqsave(&dwc->lock, flags);
 	/*
 	 * If the link is in U3, signal for remote wakeup and wait for the
@@ -2437,6 +2449,7 @@ static int dwc3_gadget_func_wakeup(struct usb_gadget *g, int intf_id)
 		ret = __dwc3_gadget_wakeup(dwc, false);
 		if (ret) {
 			spin_unlock_irqrestore(&dwc->lock, flags);
+			pm_runtime_put_noidle(dwc->dev);
 			return -EINVAL;
 		}
 		dwc3_resume_gadget(dwc);
@@ -2450,6 +2463,7 @@ static int dwc3_gadget_func_wakeup(struct usb_gadget *g, int intf_id)
 		dev_err(dwc->dev, "function remote wakeup failed, ret:%d\n", ret);
 
 	spin_unlock_irqrestore(&dwc->lock, flags);
+	pm_runtime_put_noidle(dwc->dev);
 
 	return ret;
 }
@@ -2711,21 +2725,23 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 	/*
 	 * Avoid issuing a runtime resume if the device is already in the
 	 * suspended state during gadget disconnect.  DWC3 gadget was already
-	 * halted/stopped during runtime suspend.
+	 * halted/stopped during runtime suspend except for bus suspend case
+	 * where we would have skipped the controller halt.
 	 */
 	if (!is_on) {
 		pm_runtime_barrier(dwc->dev);
-		if (pm_runtime_suspended(dwc->dev))
+		if (pm_runtime_suspended(dwc->dev) && !dwc->connected)
 			return 0;
 	}
 
 	/*
 	 * Check the return value for successful resume, or error.  For a
 	 * successful resume, the DWC3 runtime PM resume routine will handle
-	 * the run stop sequence, so avoid duplicate operations here.
+	 * the run stop sequence except for bus resume case, so avoid
+	 * duplicate operations here.
 	 */
 	ret = pm_runtime_get_sync(dwc->dev);
-	if (!ret || ret < 0) {
+	if ((!ret && !dwc->connected) || ret < 0) {
 		pm_runtime_put(dwc->dev);
 		return 0;
 	}
@@ -4307,6 +4323,8 @@ static void dwc3_gadget_suspend_interrupt(struct dwc3 *dwc,
 		dwc3_suspend_gadget(dwc);
 
 	dwc->link_state = next;
+	pm_runtime_mark_last_busy(dwc->dev);
+	pm_request_autosuspend(dwc->dev);
 }
 
 static void dwc3_gadget_interrupt(struct dwc3 *dwc,
@@ -4697,7 +4715,15 @@ void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
 {
 	if (dwc->pending_events) {
 		dwc3_interrupt(dwc->irq_gadget, dwc->ev_buf);
+		pm_runtime_put(dwc->dev);
 		dwc->pending_events = false;
 		enable_irq(dwc->irq_gadget);
+		/*
+		 * We have only stored the pending events as part
+		 * of dwc3_interrupt() above, but those events are
+		 * not yet handled. So explicitly invoke the
+		 * interrupt handler for handling those events.
+		 */
+		dwc3_thread_interrupt(dwc->irq_gadget, dwc->ev_buf);
 	}
 }
-- 
2.7.4

