Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523606B2EAB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 21:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjCIUZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 15:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjCIUZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 15:25:31 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559BBFB27E;
        Thu,  9 Mar 2023 12:25:13 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329JmnTF005575;
        Thu, 9 Mar 2023 20:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=ti9Lszwa75Y+nzreucBhbmd1tWQsi4uD+FTacwhvEzo=;
 b=kjbdHTAHWUqpzUkoDslMRKhbuYKD+KEDCADjz89naY8zyYhydPbm/sEUmKNMBE2Rfs6E
 zlg6b8fAblYRcRsgQrnbAevmYTIRDiZhej7f+dBjtfBYXxTVHo9gbYrxmDjInNgB/As3
 WIA0D44n0dx4Jn61UyhTIQcHIcHDAIiJedgfNVoq+jQXnbIRiCl8EZLlGx3YaGf8eKe4
 YtzlhZHb4dFXJDW4jmBdKDMl7ItzduPPB56ZVHpfXidlb0bcR4E2ZmmhB2CCzoF7UeYC
 tKWMkAoFkvy+jpTC0Gdvl83c6xQ5lJjBMMijHP/BbWxuEE0bKL7m1JII//UU9jKdEUME eg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p75yqaseb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 20:25:02 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 329KP1cS002784;
        Thu, 9 Mar 2023 20:25:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 3p4fewncpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 09 Mar 2023 20:25:01 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 329KP0sQ002725;
        Thu, 9 Mar 2023 20:25:00 GMT
Received: from hu-devc-lv-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.164])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTP id 329KP0ih002724;
        Thu, 09 Mar 2023 20:25:00 +0000
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id ABE6220E4A; Thu,  9 Mar 2023 12:25:00 -0800 (PST)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        balbi@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v7 2/5] usb: dwc3: Add remote wakeup handling
Date:   Thu,  9 Mar 2023 12:24:56 -0800
Message-Id: <1678393499-7366-3-git-send-email-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1678393499-7366-1-git-send-email-quic_eserrao@quicinc.com>
References: <1678393499-7366-1-git-send-email-quic_eserrao@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mZCUYou52PqJE7lr9xLUZg34avz7-hoz
X-Proofpoint-ORIG-GUID: mZCUYou52PqJE7lr9xLUZg34avz7-hoz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_11,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=922
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303090164
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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
 drivers/usb/dwc3/core.h   |  2 ++
 drivers/usb/dwc3/ep0.c    |  5 ++++
 drivers/usb/dwc3/gadget.c | 76 +++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 77 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index b1bd631..416e0ef 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1113,6 +1113,7 @@ struct dwc3_scratchpad_array {
  *	3	- Reserved
  * @dis_metastability_quirk: set to disable metastability quirk.
  * @dis_split_quirk: set to disable split boundary.
+ * @wakeup_configured: set if the device is configured for remote wakeup.
  * @imod_interval: set the interrupt moderation interval in 250ns
  *			increments or 0 to disable.
  * @max_cfg_eps: current max number of IN eps used across all USB configs.
@@ -1331,6 +1332,7 @@ struct dwc3 {
 
 	unsigned		dis_split_quirk:1;
 	unsigned		async_callbacks:1;
+	unsigned		wakeup_configured:1;
 
 	u16			imod_interval;
 
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 61de693..442d8fe 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -356,6 +356,9 @@ static int dwc3_ep0_handle_status(struct dwc3 *dwc,
 				usb_status |= 1 << USB_DEV_STAT_U1_ENABLED;
 			if (reg & DWC3_DCTL_INITU2ENA)
 				usb_status |= 1 << USB_DEV_STAT_U2_ENABLED;
+		} else {
+			usb_status |= dwc->gadget->wakeup_armed <<
+					USB_DEVICE_REMOTE_WAKEUP;
 		}
 
 		break;
@@ -476,6 +479,8 @@ static int dwc3_ep0_handle_device(struct dwc3 *dwc,
 
 	switch (wValue) {
 	case USB_DEVICE_REMOTE_WAKEUP:
+		if (dwc->wakeup_configured)
+			dwc->gadget->wakeup_armed = set;
 		break;
 	/*
 	 * 9.4.1 says only for SS, in AddressState only for
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 07989c6..f37f949 100644
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
@@ -2269,6 +2269,22 @@ static const struct usb_ep_ops dwc3_gadget_ep_ops = {
 
 /* -------------------------------------------------------------------------- */
 
+static void dwc3_gadget_enable_linksts_evts(struct dwc3 *dwc, bool set)
+{
+	u32 reg;
+
+	if (DWC3_VER_IS_PRIOR(DWC3, 250A))
+		return;
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
@@ -2276,7 +2292,7 @@ static int dwc3_gadget_get_frame(struct usb_gadget *g)
 	return __dwc3_gadget_get_frame(dwc);
 }
 
-static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
+static int __dwc3_gadget_wakeup(struct dwc3 *dwc, bool async)
 {
 	int			retries;
 
@@ -2307,9 +2323,13 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
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
 
@@ -2321,6 +2341,13 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
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
 
@@ -2346,13 +2373,36 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
 	unsigned long		flags;
 	int			ret;
 
+	if (!dwc->wakeup_configured) {
+		dev_err(dwc->dev, "remote wakeup not configured\n");
+		return -EINVAL;
+	}
+
 	spin_lock_irqsave(&dwc->lock, flags);
-	ret = __dwc3_gadget_wakeup(dwc);
+	if (!dwc->gadget->wakeup_armed) {
+		dev_err(dwc->dev, "not armed for remote wakeup\n");
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return -EINVAL;
+	}
+	ret = __dwc3_gadget_wakeup(dwc, true);
+
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return ret;
 }
 
+static int dwc3_gadget_set_remote_wakeup(struct usb_gadget *g, int set)
+{
+	struct dwc3		*dwc = gadget_to_dwc(g);
+	unsigned long		flags;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	dwc->wakeup_configured = !!set;
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	return 0;
+}
+
 static int dwc3_gadget_set_selfpowered(struct usb_gadget *g,
 		int is_selfpowered)
 {
@@ -2978,6 +3028,7 @@ static void dwc3_gadget_async_callbacks(struct usb_gadget *g, bool enable)
 static const struct usb_gadget_ops dwc3_gadget_ops = {
 	.get_frame		= dwc3_gadget_get_frame,
 	.wakeup			= dwc3_gadget_wakeup,
+	.set_remote_wakeup	= dwc3_gadget_set_remote_wakeup,
 	.set_selfpowered	= dwc3_gadget_set_selfpowered,
 	.pullup			= dwc3_gadget_pullup,
 	.udc_start		= dwc3_gadget_start,
@@ -3819,6 +3870,8 @@ static void dwc3_gadget_disconnect_interrupt(struct dwc3 *dwc)
 
 	dwc->gadget->speed = USB_SPEED_UNKNOWN;
 	dwc->setup_packet_pending = false;
+	dwc->gadget->wakeup_armed = false;
+	dwc3_gadget_enable_linksts_evts(dwc, false);
 	usb_gadget_set_state(dwc->gadget, USB_STATE_NOTATTACHED);
 
 	if (dwc->ep0state != EP0_SETUP_PHASE) {
@@ -3912,6 +3965,8 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 	reg &= ~DWC3_DCTL_TSTCTRL_MASK;
 	dwc3_gadget_dctl_write_safe(dwc, reg);
 	dwc->test_mode = false;
+	dwc->gadget->wakeup_armed = false;
+	dwc3_gadget_enable_linksts_evts(dwc, false);
 	dwc3_clear_stall_all_ep(dwc);
 
 	/* Reset device address to zero */
@@ -4064,7 +4119,7 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 	 */
 }
 
-static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc)
+static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc, unsigned int evtinfo)
 {
 	/*
 	 * TODO take core out of low power mode when that's
@@ -4076,6 +4131,8 @@ static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc)
 		dwc->gadget_driver->resume(dwc->gadget);
 		spin_lock(&dwc->lock);
 	}
+
+	dwc->link_state = evtinfo & DWC3_LINK_STATE_MASK;
 }
 
 static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
@@ -4157,6 +4214,12 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
 	}
 
 	switch (next) {
+	case DWC3_LINK_STATE_U0:
+		if (dwc->gadget->wakeup_armed) {
+			dwc3_gadget_enable_linksts_evts(dwc, false);
+			dwc3_resume_gadget(dwc);
+		}
+		break;
 	case DWC3_LINK_STATE_U1:
 		if (dwc->speed == USB_SPEED_SUPER)
 			dwc3_suspend_gadget(dwc);
@@ -4225,7 +4288,7 @@ static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 		dwc3_gadget_conndone_interrupt(dwc);
 		break;
 	case DWC3_DEVICE_EVENT_WAKEUP:
-		dwc3_gadget_wakeup_interrupt(dwc);
+		dwc3_gadget_wakeup_interrupt(dwc, event->event_info);
 		break;
 	case DWC3_DEVICE_EVENT_HIBER_REQ:
 		if (dev_WARN_ONCE(dwc->dev, !dwc->has_hibernation,
@@ -4478,6 +4541,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	dwc->gadget->sg_supported	= true;
 	dwc->gadget->name		= "dwc3-gadget";
 	dwc->gadget->lpm_capable	= !dwc->usb2_gadget_lpm_disable;
+	dwc->gadget->wakeup_capable	= true;
 
 	/*
 	 * FIXME We might be setting max_speed to <SUPER, however versions
-- 
2.7.4

