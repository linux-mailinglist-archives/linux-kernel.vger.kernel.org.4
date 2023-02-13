Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799F36950BA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjBMTbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjBMTb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:31:29 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88414C36;
        Mon, 13 Feb 2023 11:31:27 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DId7xh002102;
        Mon, 13 Feb 2023 19:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=O3qh7iht/MTTIaMiK8wxM3Ebt2hpHMktbLNRlWT9iqg=;
 b=VLMCU2l763PkeV4GbacADZGHSVbFzX7AP6VMpknLz5fZDZUH+i1zequHD2EACTOMPwny
 4G7p07IcPBw3UiQMtXLND/jr0zryMqs4yQybEeAaMby0gsME0bTLRVQMjskjtv0OQxbY
 1bynGZ9+RD1F/yBOFeGkRupZ2SorqgZmeC6H/pbL9zDb0Dq1rEe007trKcLl/QKW6dPd
 ntwfuLHNhL0pO+N46YfhgERfVZZNHJruBJovnDwKvsPbcD6DEBx9k4vWdHy96mGs1vv0
 dT1hGcM1MvuFjpxuYN+JGoh+tPh7/Cqj94E775McTv3l9vF68g7Tjja/FqOs0TKbwTjC lg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3np4agcu41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 19:31:22 +0000
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 31DJVLws026817;
        Mon, 13 Feb 2023 19:31:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA02.qualcomm.com (PPS) with ESMTP id 3np43mb474-1;
        Mon, 13 Feb 2023 19:31:21 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31DJVL5i026807;
        Mon, 13 Feb 2023 19:31:21 GMT
Received: from hu-devc-lv-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.164])
        by NALASPPMTA02.qualcomm.com (PPS) with ESMTP id 31DJVLKx026805;
        Mon, 13 Feb 2023 19:31:21 +0000
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id 9348720E50; Mon, 13 Feb 2023 11:31:21 -0800 (PST)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        balbi@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v4 4/5] usb: dwc3: Add function suspend and function wakeup support
Date:   Mon, 13 Feb 2023 11:31:15 -0800
Message-Id: <1676316676-28377-5-git-send-email-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1676316676-28377-1-git-send-email-quic_eserrao@quicinc.com>
References: <1676316676-28377-1-git-send-email-quic_eserrao@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9lcaim4HriS1OuOATgvzv3XbP2VY7r3M
X-Proofpoint-GUID: 9lcaim4HriS1OuOATgvzv3XbP2VY7r3M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 mlxlogscore=829
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130170
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB host sends function suspend and function resume notifications to
the interface through SET_FEATURE/CLEAR_FEATURE setup packets.
Add support to handle these packets by delegating the requests to
composite layer. Also add support to handle function wake notification
requests to exit from function suspend state.

Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
---
 drivers/usb/dwc3/core.h   |  3 +++
 drivers/usb/dwc3/debug.h  |  2 ++
 drivers/usb/dwc3/ep0.c    | 12 ++++--------
 drivers/usb/dwc3/gadget.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index cc78236..1565b21 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -526,6 +526,7 @@
 #define DWC3_DGCMD_SET_ENDPOINT_NRDY	0x0c
 #define DWC3_DGCMD_SET_ENDPOINT_PRIME	0x0d
 #define DWC3_DGCMD_RUN_SOC_BUS_LOOPBACK	0x10
+#define DWC3_DGCMD_DEV_NOTIFICATION	0x07
 
 #define DWC3_DGCMD_STATUS(n)		(((n) >> 12) & 0x0F)
 #define DWC3_DGCMD_CMDACT		BIT(10)
@@ -538,6 +539,8 @@
 #define DWC3_DGCMDPAR_TX_FIFO			BIT(5)
 #define DWC3_DGCMDPAR_LOOPBACK_DIS		(0 << 0)
 #define DWC3_DGCMDPAR_LOOPBACK_ENA		BIT(0)
+#define DWC3_DGCMDPAR_DN_FUNC_WAKE		BIT(0)
+#define DWC3_DGCMDPAR_INTF_SEL(n)		((n) << 4)
 
 /* Device Endpoint Command Register */
 #define DWC3_DEPCMD_PARAM_SHIFT		16
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index 8bb2c9e..09d7038 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -72,6 +72,8 @@ dwc3_gadget_generic_cmd_string(u8 cmd)
 		return "Set Endpoint Prime";
 	case DWC3_DGCMD_RUN_SOC_BUS_LOOPBACK:
 		return "Run SoC Bus Loopback Test";
+	case DWC3_DGCMD_DEV_NOTIFICATION:
+		return "Device Notification";
 	default:
 		return "UNKNOWN";
 	}
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index f90fa55..1e7cc15 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -30,6 +30,8 @@
 static void __dwc3_ep0_do_control_status(struct dwc3 *dwc, struct dwc3_ep *dep);
 static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		struct dwc3_ep *dep, struct dwc3_request *req);
+static int dwc3_ep0_delegate_req(struct dwc3 *dwc,
+				 struct usb_ctrlrequest *ctrl);
 
 static void dwc3_ep0_prepare_one_trb(struct dwc3_ep *dep,
 		dma_addr_t buf_dma, u32 len, u32 type, bool chain)
@@ -368,7 +370,7 @@ static int dwc3_ep0_handle_status(struct dwc3 *dwc,
 		 * Function Remote Wake Capable	D0
 		 * Function Remote Wakeup	D1
 		 */
-		break;
+		return dwc3_ep0_delegate_req(dwc, ctrl);
 
 	case USB_RECIP_ENDPOINT:
 		dep = dwc3_wIndex_to_dep(dwc, ctrl->wIndex);
@@ -514,13 +516,7 @@ static int dwc3_ep0_handle_intf(struct dwc3 *dwc,
 
 	switch (wValue) {
 	case USB_INTRF_FUNC_SUSPEND:
-		/*
-		 * REVISIT: Ideally we would enable some low power mode here,
-		 * however it's unclear what we should be doing here.
-		 *
-		 * For now, we're not doing anything, just making sure we return
-		 * 0 so USB Command Verifier tests pass without any errors.
-		 */
+		ret = dwc3_ep0_delegate_req(dwc, ctrl);
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index b7fef5d..9905875 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2391,6 +2391,47 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
 	return ret;
 }
 
+static void dwc3_resume_gadget(struct dwc3 *dwc);
+
+static int dwc3_gadget_func_wakeup(struct usb_gadget *g, int intf_id)
+{
+	struct  dwc3		*dwc = gadget_to_dwc(g);
+	unsigned long		flags;
+	int			ret;
+	int			link_state;
+
+	if (!dwc->wakeup_configured) {
+		dev_err(dwc->dev, "remote wakeup not configured\n");
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	/*
+	 * If the link is in low power, first bring the link to U0
+	 * before triggering function remote wakeup.
+	 */
+	link_state = dwc3_gadget_get_link_state(dwc);
+	if (link_state == DWC3_LINK_STATE_U3) {
+		ret = __dwc3_gadget_wakeup(dwc, false);
+		if (ret) {
+			spin_unlock_irqrestore(&dwc->lock, flags);
+			return -EINVAL;
+		}
+		dwc3_resume_gadget(dwc);
+		dwc->link_state = DWC3_LINK_STATE_U0;
+	}
+
+	ret = dwc3_send_gadget_generic_command(dwc, DWC3_DGCMD_DEV_NOTIFICATION,
+					       DWC3_DGCMDPAR_DN_FUNC_WAKE |
+					       DWC3_DGCMDPAR_INTF_SEL(intf_id));
+	if (ret)
+		dev_err(dwc->dev, "function remote wakeup failed, ret:%d\n", ret);
+
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	return ret;
+}
+
 static int dwc3_gadget_set_remote_wakeup(struct usb_gadget *g, int set)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
@@ -3028,6 +3069,7 @@ static void dwc3_gadget_async_callbacks(struct usb_gadget *g, bool enable)
 static const struct usb_gadget_ops dwc3_gadget_ops = {
 	.get_frame		= dwc3_gadget_get_frame,
 	.wakeup			= dwc3_gadget_wakeup,
+	.func_wakeup		= dwc3_gadget_func_wakeup,
 	.set_remote_wakeup	= dwc3_gadget_set_remote_wakeup,
 	.set_selfpowered	= dwc3_gadget_set_selfpowered,
 	.pullup			= dwc3_gadget_pullup,
-- 
2.7.4

