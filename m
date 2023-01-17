Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EA8670A7E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjAQWBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjAQV7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:59:19 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389C91AF;
        Tue, 17 Jan 2023 13:55:21 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HLp9ea024031;
        Tue, 17 Jan 2023 21:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=m1O+Z4VAjWPLxfejV4qA2pZd0fq+xCUMN4yJqhQttuM=;
 b=UisKmZ3s6jBDBRdvm5Rm+bAp7IP6y+TpgSQWxFb7jxzMGy/8EEhyv+R9bxk5I4M7E6lQ
 6FoiyQkN9jPPhlfdiZg4AbfcCJ96E5k8TkS4vmKtvIfsFmeUuhkRHAUbRapwM18340z2
 HA7nPrwIfRoBN2w53OpEBor95N8Ldj3H7aB4Ne17HPJq1JnlC7uRJHxuZYjnyaeR9VGR
 wmkvkSPf/kJmoyE2D/prdZuLDSDtnUunzDtwj/bh181J8XBSBEwZqKcQI8PX4YfgpsIl
 IysqXE1kA3GqtGHDSgR8NKZANqoEZIMCTWMX4yzERxOoKWfcQCw9eUufGKBPpaae2w2A Zg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n602k0gvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 21:55:10 +0000
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 30HLt9hg017158;
        Tue, 17 Jan 2023 21:55:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTP id 3n3nfkn84r-1;
        Tue, 17 Jan 2023 21:55:09 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30HLt9II017153;
        Tue, 17 Jan 2023 21:55:09 GMT
Received: from hu-devc-lv-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.164])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTP id 30HLt9df017152;
        Tue, 17 Jan 2023 21:55:09 +0000
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id 0ABA620DF7; Tue, 17 Jan 2023 13:55:09 -0800 (PST)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        balbi@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v2 2/5] usb: dwc3: Add remote wakeup handling
Date:   Tue, 17 Jan 2023 13:55:04 -0800
Message-Id: <1673992507-7823-3-git-send-email-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1673992507-7823-1-git-send-email-quic_eserrao@quicinc.com>
References: <1673992507-7823-1-git-send-email-quic_eserrao@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3342cNKP6kcrqaFTXUiE5XG3ffn04DCa
X-Proofpoint-GUID: 3342cNKP6kcrqaFTXUiE5XG3ffn04DCa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_10,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=949 spamscore=0
 suspectscore=0 clxscore=1011 impostorscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170175
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An usb device can initate a remote wakeup and bring the link out of
suspend as dictated by the DEVICE_REMOTE_WAKEUP feature selector.
Add support to handle this packet and set the remote wakeup capability.

Some hosts may take longer time to initiate the resume signaling after
device triggers a remote wakeup. So add async support to the wakeup API
by enabling link status change events.

Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
---
 drivers/usb/dwc3/core.h   |  3 +++
 drivers/usb/dwc3/ep0.c    |  4 ++++
 drivers/usb/dwc3/gadget.c | 57 ++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 8f9959b..53ded08 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1117,6 +1117,8 @@ struct dwc3_scratchpad_array {
  *		     address.
  * @num_ep_resized: carries the current number endpoints which have had its tx
  *		    fifo resized.
+ * @rw_armed: Indicates whether the host has armed the device for remote
+ *	      wakeup.
  */
 struct dwc3 {
 	struct work_struct	drd_work;
@@ -1332,6 +1334,7 @@ struct dwc3 {
 	int			max_cfg_eps;
 	int			last_fifo_depth;
 	int			num_ep_resized;
+	bool			rw_armed;
 };
 
 #define INCRX_BURST_MODE 0
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 61de693..0c1203d 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -356,6 +356,8 @@ static int dwc3_ep0_handle_status(struct dwc3 *dwc,
 				usb_status |= 1 << USB_DEV_STAT_U1_ENABLED;
 			if (reg & DWC3_DCTL_INITU2ENA)
 				usb_status |= 1 << USB_DEV_STAT_U2_ENABLED;
+		} else {
+			usb_status |= dwc->rw_armed << USB_DEVICE_REMOTE_WAKEUP;
 		}
 
 		break;
@@ -476,6 +478,8 @@ static int dwc3_ep0_handle_device(struct dwc3 *dwc,
 
 	switch (wValue) {
 	case USB_DEVICE_REMOTE_WAKEUP:
+		if (dwc->gadget->rw_capable)
+			dwc->rw_armed = set;
 		break;
 	/*
 	 * 9.4.1 says only for SS, in AddressState only for
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 89dcfac..db4b438 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -258,7 +258,7 @@ int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned int cmd,
 	return ret;
 }
 
-static int __dwc3_gadget_wakeup(struct dwc3 *dwc);
+static int __dwc3_gadget_wakeup(struct dwc3 *dwc, bool async);
 
 /**
  * dwc3_send_gadget_ep_cmd - issue an endpoint command
@@ -325,7 +325,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 
 			fallthrough;
 		case DWC3_LINK_STATE_U3:
-			ret = __dwc3_gadget_wakeup(dwc);
+			ret = __dwc3_gadget_wakeup(dwc, false);
 			dev_WARN_ONCE(dwc->dev, ret, "wakeup failed --> %d\n",
 					ret);
 			break;
@@ -2269,6 +2269,19 @@ static const struct usb_ep_ops dwc3_gadget_ep_ops = {
 
 /* -------------------------------------------------------------------------- */
 
+static void dwc3_gadget_enable_linksts_evts(struct dwc3 *dwc, bool set)
+{
+	u32 reg;
+
+	reg = dwc3_readl(dwc->regs, DWC3_DEVTEN);
+	if (set)
+		reg |= DWC3_DEVTEN_ULSTCNGEN;
+	else
+		reg &= ~DWC3_DEVTEN_ULSTCNGEN;
+
+	dwc3_writel(dwc->regs, DWC3_DEVTEN, reg);
+}
+
 static int dwc3_gadget_get_frame(struct usb_gadget *g)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
@@ -2276,7 +2289,7 @@ static int dwc3_gadget_get_frame(struct usb_gadget *g)
 	return __dwc3_gadget_get_frame(dwc);
 }
 
-static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
+static int __dwc3_gadget_wakeup(struct dwc3 *dwc, bool async)
 {
 	int			retries;
 
@@ -2307,9 +2320,13 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
 		return -EINVAL;
 	}
 
+	if (async)
+		dwc3_gadget_enable_linksts_evts(dwc, true);
+
 	ret = dwc3_gadget_set_link_state(dwc, DWC3_LINK_STATE_RECOV);
 	if (ret < 0) {
 		dev_err(dwc->dev, "failed to put link in Recovery\n");
+		dwc3_gadget_enable_linksts_evts(dwc, false);
 		return ret;
 	}
 
@@ -2321,6 +2338,13 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_DCTL, reg);
 	}
 
+	/*
+	 * Since link status change events are enabled we will receive
+	 * an U0 event when wakeup is successful. So bail out.
+	 */
+	if (async)
+		return 0;
+
 	/* poll until Link State changes to ON */
 	retries = 20000;
 
@@ -2347,7 +2371,13 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
 	int			ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	ret = __dwc3_gadget_wakeup(dwc);
+	if (!dwc->rw_armed) {
+		dev_err(dwc->dev, "%s:remote wakeup not enabled\n", __func__);
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return -EINVAL;
+	}
+	ret = __dwc3_gadget_wakeup(dwc, true);
+
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return ret;
@@ -2813,6 +2843,8 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	dwc->gadget_driver	= driver;
+	dwc3_gadget_enable_linksts_evts(dwc, false);
+	dwc->rw_armed = false;
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return 0;
@@ -2832,6 +2864,8 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	dwc->gadget_driver	= NULL;
+	dwc3_gadget_enable_linksts_evts(dwc, false);
+	dwc->rw_armed = false;
 	dwc->max_cfg_eps = 0;
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
@@ -3821,6 +3855,8 @@ static void dwc3_gadget_disconnect_interrupt(struct dwc3 *dwc)
 
 	dwc->gadget->speed = USB_SPEED_UNKNOWN;
 	dwc->setup_packet_pending = false;
+	dwc3_gadget_enable_linksts_evts(dwc, false);
+	dwc->rw_armed = false;
 	usb_gadget_set_state(dwc->gadget, USB_STATE_NOTATTACHED);
 
 	if (dwc->ep0state != EP0_SETUP_PHASE) {
@@ -3920,6 +3956,9 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 	reg = dwc3_readl(dwc->regs, DWC3_DCFG);
 	reg &= ~(DWC3_DCFG_DEVADDR_MASK);
 	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
+
+	dwc3_gadget_enable_linksts_evts(dwc, false);
+	dwc->rw_armed = false;
 }
 
 static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
@@ -4066,7 +4105,7 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 	 */
 }
 
-static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc)
+static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc, unsigned int evtinfo)
 {
 	/*
 	 * TODO take core out of low power mode when that's
@@ -4078,6 +4117,8 @@ static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc)
 		dwc->gadget_driver->resume(dwc->gadget);
 		spin_lock(&dwc->lock);
 	}
+
+	dwc->link_state = evtinfo & DWC3_LINK_STATE_MASK;
 }
 
 static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
@@ -4159,6 +4200,10 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
 	}
 
 	switch (next) {
+	case DWC3_LINK_STATE_U0:
+		dwc3_gadget_enable_linksts_evts(dwc, false);
+		dwc3_resume_gadget(dwc);
+		break;
 	case DWC3_LINK_STATE_U1:
 		if (dwc->speed == USB_SPEED_SUPER)
 			dwc3_suspend_gadget(dwc);
@@ -4227,7 +4272,7 @@ static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 		dwc3_gadget_conndone_interrupt(dwc);
 		break;
 	case DWC3_DEVICE_EVENT_WAKEUP:
-		dwc3_gadget_wakeup_interrupt(dwc);
+		dwc3_gadget_wakeup_interrupt(dwc, event->event_info);
 		break;
 	case DWC3_DEVICE_EVENT_HIBER_REQ:
 		if (dev_WARN_ONCE(dwc->dev, !dwc->has_hibernation,
-- 
2.7.4

