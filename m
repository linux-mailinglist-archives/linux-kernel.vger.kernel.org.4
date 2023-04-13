Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202BD6E157A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 21:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjDMTxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 15:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjDMTxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 15:53:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CBE65BD;
        Thu, 13 Apr 2023 12:53:45 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33DJgZY6003281;
        Thu, 13 Apr 2023 19:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=G+OlpJM+zenbHOMNZmnRI9W00zcei4fB6OwOqJVtDVk=;
 b=aKJ6a1uvalmaCFqV3VCTEwm3CrlBM9VMbV6M8aBhn+pmdtSbWg7bcWuHsHjO/lMbTcCb
 jQjlC2wsQOKNU1Oi6pzOwazvBaVFf1DgIqVsKlZJ4sL5WztqhbLMmezibDtSthnbhTT3
 LrSTwzBYLbiyPTwPg+H9Thq9KWe7+is2K8d4Ak87dIMCCbzlAuTaYJ9xs1xK9fECtqK5
 mjzSQz3DtkkDJ088VB3vNwotXkQ01FpfEaX0ksvuIYeOmstVi38HN+k0gyCZp5ZWp2o3
 xnsT7ZQPokb1E/qxOhKZ6ZkdStMzTelRHgd/U9fHPpPAz4MmCYm6fkbiIDiLG5FLdtHL TQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3px3reten5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 19:53:41 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33DJreuK014243
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 19:53:40 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 13 Apr 2023 12:53:40 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        stable <stable@kernel.org>
Subject: [PATCH v4 1/3] usb: dwc3: gadget: Stall and restart EP0 if host is unresponsive
Date:   Thu, 13 Apr 2023 12:53:15 -0700
Message-ID: <20230413195317.7468-2-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230413195317.7468-1-quic_wcheng@quicinc.com>
References: <20230413195317.7468-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xltX7HgFQBaChghGfKE4jRLAGyNBf2oT
X-Proofpoint-GUID: xltX7HgFQBaChghGfKE4jRLAGyNBf2oT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_14,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 impostorscore=0 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxlogscore=925
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130176
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Cc: stable <stable@kernel.org>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/dwc3/gadget.c | 49 +++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 3c63fa97a680..be84c133f0d7 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2528,29 +2528,17 @@ static int __dwc3_gadget_start(struct dwc3 *dwc);
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
@@ -2563,6 +2551,33 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
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
+			unsigned int    dir;
+
+			dev_warn(dwc->dev, "wait for SETUP phase timed out\n");
+			spin_lock_irqsave(&dwc->lock, flags);
+			dir = !!dwc->ep0_expect_in;
+			if (dwc->ep0state == EP0_DATA_PHASE)
+				dwc3_ep0_end_control_data(dwc, dwc->eps[dir]);
+			else
+				dwc3_ep0_end_control_data(dwc, dwc->eps[!dir]);
+			dwc3_ep0_stall_and_restart(dwc);
+			spin_unlock_irqrestore(&dwc->lock, flags);
+		}
+	}
+
 	/*
 	 * Note: if the GEVNTCOUNT indicates events in the event buffer, the
 	 * driver needs to acknowledge them before the controller can halt.
