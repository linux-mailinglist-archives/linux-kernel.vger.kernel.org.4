Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243296A0449
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjBWI6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbjBWI6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:58:06 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35564E5FD;
        Thu, 23 Feb 2023 00:58:05 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31N5A1hP023409;
        Thu, 23 Feb 2023 08:58:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=2K+C8HMS9npx4Hhjm7Ocj7wuGl6LtUkhYA+q3Bkv+oQ=;
 b=HH+d6JmLDWZ67zbCGKMIuiaMcl2DkdkbJjc4qmwqn50cb1Ag9ED8o5XoCJjblwgOskgA
 1+ENU1FdX8e7It3QxBpTdbjFXo+z8Ph3UwkcT2/JvKmybtCeDProqw7EIMK3bS4z9iTm
 4y2fhMlb6GF/bZTuXq39ctRJ5IVBgtGykPq3i7s7iJo5rZxXyNJH/DVsczX3gGoEE/NZ
 zo72UNB0XjAC47dCZy+H+mQAb1JaG7n+v039L/gSLy7vfNIP8pPSUxyiZCh2nGb5ITVx
 wSWkIytRfEzNKFGcQAVHAOl77r4b+ygLJyH5dOw+tckz0mW48RLNbtqvkRrSnDCBBMSi Fw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nwy9a0tku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 08:58:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31N8w1Zn016477
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 08:58:01 GMT
Received: from hu-prashk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 23 Feb 2023 00:57:57 -0800
From:   Prashanth K <quic_prashk@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        =?UTF-8?q?J=C3=B3=20=C3=81gila=20Bitsch?= <jgilab@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Prashanth K <quic_prashk@quicinc.com>
Subject: [PATCH v2 2/2] usb: gadget: composite: Draw 100mA current if not configured
Date:   Thu, 23 Feb 2023 14:27:45 +0530
Message-ID: <1677142665-8686-3-git-send-email-quic_prashk@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1677142665-8686-1-git-send-email-quic_prashk@quicinc.com>
References: <1677142665-8686-1-git-send-email-quic_prashk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 34TsFu1mA0ppEYHxSzBTPPcWCaIFQXn8
X-Proofpoint-ORIG-GUID: 34TsFu1mA0ppEYHxSzBTPPcWCaIFQXn8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_04,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 mlxscore=0 mlxlogscore=621
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302230077
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we don't change the current value if device isn't in
configured state. But the battery charging specification says,
device can draw up to 100mA of current if its in unconfigured
state. Hence add a Vbus_draw work in composite_resume to draw
100mA if the device isn't configured.

Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
---
 drivers/usb/gadget/composite.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 403563c..23b7347a8 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -2449,6 +2449,9 @@ void composite_resume(struct usb_gadget *gadget)
 			usb_gadget_clear_selfpowered(gadget);
 
 		usb_gadget_vbus_draw(gadget, maxpower);
+	} else {
+		maxpower = min(CONFIG_USB_GADGET_VBUS_DRAW, 100U)
+		usb_gadget_vbus_draw(gadget, maxpower);
 	}
 
 	cdev->suspended = 0;
-- 
2.7.4

