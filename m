Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11266DB69B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 00:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjDGWlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 18:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjDGWlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 18:41:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93083D532;
        Fri,  7 Apr 2023 15:40:57 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337MVnGd003703;
        Fri, 7 Apr 2023 22:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=mrzAxL+ALewHXGb7bTnfhweah2z2VemEqbRNLk/lNUA=;
 b=EDhvNrC2vRmKzX2DaLtrSZchJWldBnYY7XmI9tcT5ELJYn+01B1qVp9jOvxATZoZgcNS
 Uw1et7mv4iTZPxE/F47wYwLhqx94On3dUUDTTjJSwk6zNYd75YGTtyFrpcSicSwoSuhY
 o+09MGpDlafjyinmwCZFXfXuz7SI5l1eSgl/LVO7r+ynz2xP87LEdbhwTk6Zz1gIQbIg
 zpbJh2reFk9hjTRVYQnZh62OdZ5QmVzys9LGOLrYBa0W6wW3Axpw0lKt8PeDM7g2q22Q
 enS+BgTARtPx45JlskM51UIZ6DnWrnMM6yiJkSpCrRLULIdYC8TRw+DNP3sw1wTxg3k5 rQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ptd5ct0sq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 22:40:51 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 337Mecor019240
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Apr 2023 22:40:38 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 7 Apr 2023 15:40:38 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>, <quic_ugoswami@quicinc.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v2 2/3] usb: dwc3: gadget: Stall and restart EP0 if host is unresponsive
Date:   Fri, 7 Apr 2023 15:40:24 -0700
Message-ID: <20230407224025.22315-3-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230407224025.22315-1-quic_wcheng@quicinc.com>
References: <20230407224025.22315-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: imnr2LYMG9YbbuBOBvJCQTqzd8KrjN9d
X-Proofpoint-ORIG-GUID: imnr2LYMG9YbbuBOBvJCQTqzd8KrjN9d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_14,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070205
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was observed that there are hosts that may complete pending SETUP
transactions before the stop active transfers and controller halt occurs,
leading to lingering endxfer commands on DEPs on subsequent pullup/gadget
start iterations.

  dwc3_gadget_ep_disable   name=ep8in flags=0x3009  direction=1
  dwc3_gadget_ep_disable   name=ep4in flags=1  direction=1
  dwc3_gadget_ep_disable   name=ep3out flags=1  direction=0
  usb_gadget_disconnect   deactivated=0  connected=0  ret=0

The sequence shows that the USB gadget disconnect (dwc3_gadget_pullup(0))
routine completed successfully, allowing for the USB gadget to proceed with
a USB gadget connect.  However, if this occurs the system runs into an
issue where:

  BUG: spinlock already unlocked on CPU
  spin_bug+0x0
  dwc3_remove_requests+0x278
  dwc3_ep0_out_start+0xb0
  __dwc3_gadget_start+0x25c

This is due to the pending endxfers, leading to gadget start (w/o lock
held) to execute the remove requests, which will unlock the dwc3
spinlock as part of giveback.

To mitigate this, resolve the pending endxfers on the pullup disable
path by re-locating the SETUP phase check after stop active transfers, since
that is where the DWC3_EP_DELAY_STOP is potentially set.  This also allows
for handling of a host that may be unresponsive by using the completion
timeout to trigger the stall and restart for EP0.

Fixes: c96683798e27 ("usb: dwc3: ep0: Don't prepare beyond Setup stage")
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/dwc3/gadget.c | 42 +++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 320e30476c88..91768f1bdbaf 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2546,29 +2546,17 @@ static int __dwc3_gadget_start(struct dwc3 *dwc);
 static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 {
 	unsigned long flags;
+	int ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	dwc->connected = false;
 
 	/*
-	 * Per databook, when we want to stop the gadget, if a control transfer
-	 * is still in process, complete it and get the core into setup phase.
+	 * Attempt to end pending SETUP status phase, and not wait for the
+	 * function to do so.
 	 */
-	if (dwc->ep0state != EP0_SETUP_PHASE) {
-		int ret;
-
-		if (dwc->delayed_status)
-			dwc3_ep0_send_delayed_status(dwc);
-
-		reinit_completion(&dwc->ep0_in_setup);
-
-		spin_unlock_irqrestore(&dwc->lock, flags);
-		ret = wait_for_completion_timeout(&dwc->ep0_in_setup,
-				msecs_to_jiffies(DWC3_PULL_UP_TIMEOUT));
-		spin_lock_irqsave(&dwc->lock, flags);
-		if (ret == 0)
-			dev_warn(dwc->dev, "timed out waiting for SETUP phase\n");
-	}
+	if (dwc->delayed_status)
+		dwc3_ep0_send_delayed_status(dwc);
 
 	/*
 	 * In the Synopsys DesignWare Cores USB3 Databook Rev. 3.30a
@@ -2581,6 +2569,26 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	__dwc3_gadget_stop(dwc);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	/*
+	 * Per databook, when we want to stop the gadget, if a control transfer
+	 * is still in process, complete it and get the core into setup phase.
+	 * In case the host is unresponsive to a SETUP transaction, forcefully
+	 * stall the transfer, and move back to the SETUP phase, so that any
+	 * pending endxfers can be executed.
+	 */
+	if (dwc->ep0state != EP0_SETUP_PHASE) {
+		reinit_completion(&dwc->ep0_in_setup);
+
+		ret = wait_for_completion_timeout(&dwc->ep0_in_setup,
+				msecs_to_jiffies(DWC3_PULL_UP_TIMEOUT));
+		if (ret == 0) {
+			dev_warn(dwc->dev, "wait for SETUP phase timed out\n");
+			spin_lock_irqsave(&dwc->lock, flags);
+			dwc3_ep0_reset_state(dwc);
+			spin_unlock_irqrestore(&dwc->lock, flags);
+		}
+	}
+
 	/*
 	 * Note: if the GEVNTCOUNT indicates events in the event buffer, the
 	 * driver needs to acknowledge them before the controller can halt.
