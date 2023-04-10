Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87776DCDEA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjDJXUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 19:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjDJXUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:20:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A86E4D;
        Mon, 10 Apr 2023 16:20:09 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33ANCdmc032106;
        Mon, 10 Apr 2023 23:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=bI/wZP7ubTjCdHoQXeZS5R4X8U4Eh+xW5LDQQWeAzvw=;
 b=AB6JC7lT307nwfRAxfmYuUEfDHcytjG0e2enSXsuARDS91zFRpMzjQtzHnoKegP5+n9e
 nOvgIIeHO46V6NnZ3VOqN2vRc4Vez5Ea+XEgZtIHZUtuByBHnirKujunr/FwYkkPPZ7m
 GQznEANjyRoNDmY2XkD1LmNL4GXyWQT837AGWHtq8Mv31oTj9URVgkmJEop86U3ivD+s
 +5k5Mq7MP16t2wE85aMXUNu5h6pUyHRJ3hjeNFl5+tBqz5q+HxUkVM/vOgmHAh+rNOYF
 RyleuwjQsfzMufUBd0H/jLlI518d8uElJBU4XmSBjYYdsQhA1tuUzpXQz7I9DgLCkdkb Wg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pvmnagwpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 23:20:07 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33ANK6it029474
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 23:20:06 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 10 Apr 2023 16:20:06 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>, <quic_ugoswami@quicinc.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v3 3/3] usb: dwc3: gadget: Execute gadget stop after halting the controller
Date:   Mon, 10 Apr 2023 16:19:54 -0700
Message-ID: <20230410231954.437-4-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230410231954.437-1-quic_wcheng@quicinc.com>
References: <20230410231954.437-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: g2aW2SwlmXZO6rK8tP5AbcAGQz405Dx6
X-Proofpoint-GUID: g2aW2SwlmXZO6rK8tP5AbcAGQz405Dx6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_16,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=627
 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304100205
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/dwc3/gadget.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 91768f1bdbaf..9715de8e99bc 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2566,7 +2566,6 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	 * bit.
 	 */
 	dwc3_stop_active_transfers(dwc);
-	__dwc3_gadget_stop(dwc);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	/*
@@ -2596,7 +2595,19 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
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
