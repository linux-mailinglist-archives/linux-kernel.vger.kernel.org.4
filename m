Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D196FD8A9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbjEJHyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236436AbjEJHxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:53:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273CE44AB;
        Wed, 10 May 2023 00:53:42 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34A7RIAU017497;
        Wed, 10 May 2023 07:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=TWfriI1GPViFPiF9QfSprwUBp0trQtulsgwwLsgPKAY=;
 b=n7hg07RMT84PZJYqqr75XTzL6R+Z6hBLafurv+LOMfZEEgf6aqEVSNbbVWhAQRdA3z2z
 HeY9Cg6NEYQIXR8zU0o9ht/rK5Pr3p2ijTSiishDkyvJToeA7FrWNhUQsysuN/6Vk/3i
 ejjBMZVX2yyy8l8iHNOEdHuxgSVnDxWi7OXooDiFkkWmTLWk2irBakhTSKfD2IWOjCww
 r053Alomxh8cpW+HRASXWLHXQQJ3OxrGMJMlIM7uwhPoFckwfH6FY/gEk8GU+ixT3eT3
 uLWlm+hOccRJE7swJ8SUC67hs9kLWwiRwjMjWI91+kksq7Gd3M7MJ2hs6ubpqj2GPbbz 7g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qfrut9mwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 07:53:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34A7rHQd015468
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 07:53:17 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 10 May 2023 00:53:14 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Jiantao Zhang" <water.zhangjiantao@huawei.com>,
        Badhri Jagan Sridharan <badhri@google.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v3 2/2] usb: gadget: udc: Handle gadget_connect failure during bind operation
Date:   Wed, 10 May 2023 13:22:52 +0530
Message-ID: <20230510075252.31023-3-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230510075252.31023-1-quic_kriskura@quicinc.com>
References: <20230510075252.31023-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pwcW3T6yZNhZ2L6Peo3B0s5wVvZ-m0Em
X-Proofpoint-ORIG-GUID: pwcW3T6yZNhZ2L6Peo3B0s5wVvZ-m0Em
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305100061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the event, gadget_connect call (which invokes pullup) fails,
propagate the error to udc bind operation which inturn sends the
error to configfs. The userspace can then retry enumeartion if
it chooses to.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
changes in v3: Rebase on top of usb-next

 drivers/usb/gadget/udc/core.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 4641153e9706..69041cca5d24 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1122,12 +1122,16 @@ EXPORT_SYMBOL_GPL(usb_gadget_set_state);
 /* ------------------------------------------------------------------------- */
 
 /* Acquire connect_lock before calling this function. */
-static void usb_udc_connect_control_locked(struct usb_udc *udc) __must_hold(&udc->connect_lock)
+static int usb_udc_connect_control_locked(struct usb_udc *udc) __must_hold(&udc->connect_lock)
 {
+	int ret;
+
 	if (udc->vbus && udc->started)
-		usb_gadget_connect_locked(udc->gadget);
+		ret = usb_gadget_connect_locked(udc->gadget);
 	else
-		usb_gadget_disconnect_locked(udc->gadget);
+		ret = usb_gadget_disconnect_locked(udc->gadget);
+
+	return ret;
 }
 
 /**
@@ -1583,12 +1587,21 @@ static int gadget_bind_driver(struct device *dev)
 		goto err_start;
 	}
 	usb_gadget_enable_async_callbacks(udc);
-	usb_udc_connect_control_locked(udc);
+	ret = usb_udc_connect_control_locked(udc);
+	if (ret)
+		goto err_connect_control;
+
 	mutex_unlock(&udc->connect_lock);
 
 	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
 	return 0;
 
+ err_connect_control:
+	usb_gadget_disable_async_callbacks(udc);
+	if (gadget->irq)
+		synchronize_irq(gadget->irq);
+	usb_gadget_udc_stop_locked(udc);
+
  err_start:
 	driver->unbind(udc->gadget);
 
-- 
2.40.0

