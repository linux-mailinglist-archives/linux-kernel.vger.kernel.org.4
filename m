Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86996CC784
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 18:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbjC1QIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 12:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjC1QIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:08:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E665E05A;
        Tue, 28 Mar 2023 09:08:34 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SE32N6022919;
        Tue, 28 Mar 2023 16:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=L8rw2Her4iceF3lBbGr1llneXswMjuHwG5KiVK2xQwQ=;
 b=fdWmeCxIlztEFATRJBmUvL29MT22FxDZzuBox0bmoHZKvtQHoLGdY4FgIcVDJ9QGFeSJ
 CTTdC54VkCvjOEPIMGE50aIzD42Q/sT9JhTD16HAH3S22GkvDZrvZJQHQlxTalpGERZi
 FmPS1Uixo9y1gJbdW/XHtYA7b3BR5Qmigmycq5Ai8FQM2yCwhO9m6obCbxWfYpVQKK7R
 bACLXHgqfVHuQH2s8x6NZowo90eMMAVwW0fsYdlRg8RKQcUsc6XYyJgW3YMSiqDIFWkX
 NlDITY0U7T2vWbJU3+GhUR59lz1vu4LAdnF/61nJOYvpGaCBR8qcWhbBDeeSVOoC4zUK zQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pky700vud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 16:08:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32SG8JdO028236
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 16:08:19 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 28 Mar 2023 09:08:15 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Colin Ian King <colin.i.king@gmail.com>,
        Jiantao Zhang <water.zhangjiantao@huawei.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_ugoswami@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v2 2/2] usb: gadget: udc: Handle gadget_connect failure during bind operation
Date:   Tue, 28 Mar 2023 21:37:56 +0530
Message-ID: <20230328160756.30520-3-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230328160756.30520-1-quic_kriskura@quicinc.com>
References: <20230328160756.30520-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3_5wJH3HUWn8oAmejhv48f51nUn3TQPP
X-Proofpoint-GUID: 3_5wJH3HUWn8oAmejhv48f51nUn3TQPP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303280126
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
---
 drivers/usb/gadget/udc/core.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 23b0629a8774..975205a1853f 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1051,12 +1051,16 @@ EXPORT_SYMBOL_GPL(usb_gadget_set_state);
 
 /* ------------------------------------------------------------------------- */
 
-static void usb_udc_connect_control(struct usb_udc *udc)
+static int usb_udc_connect_control(struct usb_udc *udc)
 {
+	int ret;
+
 	if (udc->vbus)
-		usb_gadget_connect(udc->gadget);
+		ret = usb_gadget_connect(udc->gadget);
 	else
-		usb_gadget_disconnect(udc->gadget);
+		ret = usb_gadget_disconnect(udc->gadget);
+
+	return ret;
 }
 
 /**
@@ -1500,11 +1504,19 @@ static int gadget_bind_driver(struct device *dev)
 	if (ret)
 		goto err_start;
 	usb_gadget_enable_async_callbacks(udc);
-	usb_udc_connect_control(udc);
+	ret = usb_udc_connect_control(udc);
+	if (ret)
+		goto err_connect_control;
 
 	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
 	return 0;
 
+ err_connect_control:
+	usb_gadget_disable_async_callbacks(udc);
+	if (gadget->irq)
+		synchronize_irq(gadget->irq);
+	usb_gadget_udc_stop(udc);
+
  err_start:
 	driver->unbind(udc->gadget);
 
-- 
2.40.0

