Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1016E158A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 21:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjDMT70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 15:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjDMT7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 15:59:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDD68A4F;
        Thu, 13 Apr 2023 12:59:14 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33DJj21P025798;
        Thu, 13 Apr 2023 19:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=785MwKS2iQyp2XbJLbbqFpGyH2DA45lwssNOf53Znf0=;
 b=VXT6SndFh71l7yiQD5Yu/Jb6T+Wqkey8/R0JyfBP/nSAxGaAbDL2qNjjwojq373j7KIc
 jHBNBfU1Eh3D9n2IpaZh+1z+BVeQ8ZLfOYSQx+3xIel/1yovw9CSAQwn5vHkrB2jiZhy
 cKOgtPpdIfHuujEZhU2tRhS0KDdEhLeaSXyvo3+LU8yOl2TWawct9HnK9KYhHl5HZBGg
 9F6I3xKewVTJfDm03Q9/luJZ8LYXMfu1Xq6R1YuHNN//5ybg5mDZi1q7ha06ZdHI2VW6
 ReoIPJtouP8Hsk6GC2tI6+QHv2cGHE1BnkggAbQKeT1Yb6vzb5SoyQePJkugLqNCcrF6 /g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pxbx5sq3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 19:59:12 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33DJxB85019483
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 19:59:11 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 13 Apr 2023 12:59:10 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v5 3/3] usb: dwc3: gadget: Refactor EP0 forced stall/restart into a separate API
Date:   Thu, 13 Apr 2023 12:57:42 -0700
Message-ID: <20230413195742.11821-4-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230413195742.11821-1-quic_wcheng@quicinc.com>
References: <20230413195742.11821-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EmMrF_RoMokbghDknyny9OmzVL5ysGCw
X-Proofpoint-GUID: EmMrF_RoMokbghDknyny9OmzVL5ysGCw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_14,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=918 malwarescore=0 bulkscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130177
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several sequences utilize the same routine for forcing the control endpoint
back into the SETUP phase.  This is required, because those operations need
to ensure that EP0 is back in the default state.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/dwc3/gadget.c | 53 ++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 32 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 0bb4926933b6..9715de8e99bc 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -139,6 +139,24 @@ int dwc3_gadget_set_link_state(struct dwc3 *dwc, enum dwc3_link_state state)
 	return -ETIMEDOUT;
 }
 
+static void dwc3_ep0_reset_state(struct dwc3 *dwc)
+{
+	unsigned int	dir;
+
+	if (dwc->ep0state != EP0_SETUP_PHASE) {
+		dir = !!dwc->ep0_expect_in;
+		if (dwc->ep0state == EP0_DATA_PHASE)
+			dwc3_ep0_end_control_data(dwc, dwc->eps[dir]);
+		else
+			dwc3_ep0_end_control_data(dwc, dwc->eps[!dir]);
+
+		dwc->eps[0]->trb_enqueue = 0;
+		dwc->eps[1]->trb_enqueue = 0;
+
+		dwc3_ep0_stall_and_restart(dwc);
+	}
+}
+
 /**
  * dwc3_ep_inc_trb - increment a trb index.
  * @index: Pointer to the TRB index to increment.
@@ -2563,16 +2581,9 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 		ret = wait_for_completion_timeout(&dwc->ep0_in_setup,
 				msecs_to_jiffies(DWC3_PULL_UP_TIMEOUT));
 		if (ret == 0) {
-			unsigned int    dir;
-
 			dev_warn(dwc->dev, "wait for SETUP phase timed out\n");
 			spin_lock_irqsave(&dwc->lock, flags);
-			dir = !!dwc->ep0_expect_in;
-			if (dwc->ep0state == EP0_DATA_PHASE)
-				dwc3_ep0_end_control_data(dwc, dwc->eps[dir]);
-			else
-				dwc3_ep0_end_control_data(dwc, dwc->eps[!dir]);
-			dwc3_ep0_stall_and_restart(dwc);
+			dwc3_ep0_reset_state(dwc);
 			spin_unlock_irqrestore(&dwc->lock, flags);
 		}
 	}
@@ -3847,16 +3858,7 @@ static void dwc3_gadget_disconnect_interrupt(struct dwc3 *dwc)
 	dwc->setup_packet_pending = false;
 	usb_gadget_set_state(dwc->gadget, USB_STATE_NOTATTACHED);
 
-	if (dwc->ep0state != EP0_SETUP_PHASE) {
-		unsigned int    dir;
-
-		dir = !!dwc->ep0_expect_in;
-		if (dwc->ep0state == EP0_DATA_PHASE)
-			dwc3_ep0_end_control_data(dwc, dwc->eps[dir]);
-		else
-			dwc3_ep0_end_control_data(dwc, dwc->eps[!dir]);
-		dwc3_ep0_stall_and_restart(dwc);
-	}
+	dwc3_ep0_reset_state(dwc);
 }
 
 static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
@@ -3910,20 +3912,7 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 	 * phase. So ensure that EP0 is in setup phase by issuing a stall
 	 * and restart if EP0 is not in setup phase.
 	 */
-	if (dwc->ep0state != EP0_SETUP_PHASE) {
-		unsigned int	dir;
-
-		dir = !!dwc->ep0_expect_in;
-		if (dwc->ep0state == EP0_DATA_PHASE)
-			dwc3_ep0_end_control_data(dwc, dwc->eps[dir]);
-		else
-			dwc3_ep0_end_control_data(dwc, dwc->eps[!dir]);
-
-		dwc->eps[0]->trb_enqueue = 0;
-		dwc->eps[1]->trb_enqueue = 0;
-
-		dwc3_ep0_stall_and_restart(dwc);
-	}
+	dwc3_ep0_reset_state(dwc);
 
 	/*
 	 * In the Synopsis DesignWare Cores USB3 Databook Rev. 3.30a
