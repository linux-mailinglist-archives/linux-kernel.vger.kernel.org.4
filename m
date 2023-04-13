Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D72F6E1579
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 21:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjDMTxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 15:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjDMTxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 15:53:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9803F6182;
        Thu, 13 Apr 2023 12:53:45 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33DJpDm3003282;
        Thu, 13 Apr 2023 19:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=6kXjPv3JSqmlJQBfZMf+Jgzn2FTqzODxouHwtO4Ijek=;
 b=ZfkHRVS1wEeX8cCY2Di8oPhlUYO4j/GmWwWdFUmRgM/BDXj7gMAqzTXQIcRG606oKSf7
 vug5+A7Uh5SKfECEz/HhVXa5GuMrmCgIB9gx82dqDpqwm3OcfEUSRRGhDt4Gd/u4oeOH
 AhIgn0SR9tOToeGJ0jGhznf7qvnb6OKIuWaDL/o+C7g0xwPHjsiK5sN/ZRL7Hi+/ljz3
 z3iOmoiwYAweTxwrWW/ErZ/07XOiXYH/hyW3/AVK/pp8MeP2uOcZr/2fUASLxhzYgLSd
 xFXKBfhNP6aUGLdzExD1hueMxQZln2RfFFtrgPiyD6uEgtUX9dzAAJVKMbvOtIaSeGCD CA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pxdrk9g3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 19:53:41 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33DJreQd008813
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
Subject: [PATCH v4 2/3] usb: dwc3: gadget: Execute gadget stop after halting the controller
Date:   Thu, 13 Apr 2023 12:53:16 -0700
Message-ID: <20230413195317.7468-3-quic_wcheng@quicinc.com>
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
X-Proofpoint-ORIG-GUID: fSik2OxNBC7VIQ9t2qduW9sPuNhBc0r6
X-Proofpoint-GUID: fSik2OxNBC7VIQ9t2qduW9sPuNhBc0r6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_14,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 suspectscore=0 spamscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 phishscore=0 mlxlogscore=672 clxscore=1011 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130176
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not call gadget stop until the poll for controller halt is
completed.  DEVTEN is cleared as part of gadget stop, so the intention to
allow ep0 events to continue while waiting for controller halt is not
happening.

Fixes: c96683798e27 ("usb: dwc3: ep0: Don't prepare beyond Setup stage")
Cc: stable <stable@kernel.org>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/dwc3/gadget.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index be84c133f0d7..0bb4926933b6 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2548,7 +2548,6 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	 * bit.
 	 */
 	dwc3_stop_active_transfers(dwc);
-	__dwc3_gadget_stop(dwc);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	/*
@@ -2585,7 +2584,19 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	 * remaining event generated by the controller while polling for
 	 * DSTS.DEVCTLHLT.
 	 */
-	return dwc3_gadget_run_stop(dwc, false, false);
+	ret = dwc3_gadget_run_stop(dwc, false, false);
+
+	/*
+	 * Stop the gadget after controller is halted, so that if needed, the
+	 * events to update EP0 state can still occur while the run/stop
+	 * routine polls for the halted state.  DEVTEN is cleared as part of
+	 * gadget stop.
+	 */
+	spin_lock_irqsave(&dwc->lock, flags);
+	__dwc3_gadget_stop(dwc);
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	return ret;
 }
 
 static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
