Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853D770F185
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240409AbjEXIyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240169AbjEXIyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:54:20 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8A0FC;
        Wed, 24 May 2023 01:54:18 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34O7ZRhU003297;
        Wed, 24 May 2023 08:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=YnHB7FpBtR8Tse8rs4GaIWlXq+QS5MQbGYPk6a0WV9s=;
 b=TdYIAymkxInBAXWDz6DVR6tFm7ZvmRUKPPOtDGfFeVG5U32TYrK+DLL/Mfo804VbQknv
 NLkuNHfBjcHfAXux1krvjAyeMHVBkdkjWytJ3D2NUubbKAB1ANnMOcDoF9Km4CZ06+Hf
 bQ/85XR54g/a9+n2tcGVgvrVAEWIos9zbVcLwVuwZMdwVGPh4cZhzqNKUTlNXwVu7d0P
 Vjmgr/n8dBafvgpDwgX6vY0lE9+nSsMQhpQdssjwOLS8jStMhKXeeECUsmQgGN9qFCeG
 VGWznxRiArAYHMw10ByPV8PvN933+/Z/ONMcW1ZO0Wd86PVlH6tVJxESvvRYRWdT3QHY 5Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qs05sa128-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 08:54:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34O8sEYN032504
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 08:54:14 GMT
Received: from hu-prashk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 24 May 2023 01:54:12 -0700
From:   Prashanth K <quic_prashk@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Prashanth K <quic_prashk@quicinc.com>
Subject: [PATCH] usb: common: usb-conn-gpio: Set last role to unknown before initial detection
Date:   Wed, 24 May 2023 14:24:01 +0530
Message-ID: <1684918441-14794-1-git-send-email-quic_prashk@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ACchDRO1baxKxziO4wrZEyL8aP8O0g8W
X-Proofpoint-ORIG-GUID: ACchDRO1baxKxziO4wrZEyL8aP8O0g8W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_05,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 clxscore=1015
 bulkscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305240075
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if we bootup a device without cable connected, then
usb-conn-gpio won't call set_role() since last_role is same as
current role. This happens because during probe last_role gets
initialised to zero.

To avoid this, last_role is set to USB_ROLE_UNKNOWN before
performing the initial detection.

Fixes: 4602f3bff266 ("usb: common: add USB GPIO based connection detection driver")
Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
---
 drivers/usb/common/usb-conn-gpio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
index e20874c..00af735 100644
--- a/drivers/usb/common/usb-conn-gpio.c
+++ b/drivers/usb/common/usb-conn-gpio.c
@@ -27,6 +27,8 @@
 #define USB_CONN_IRQF	\
 	(IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT)
 
+#define USB_ROLE_UNKNOWN	-1
+
 struct usb_conn_info {
 	struct device *dev;
 	struct usb_role_switch *role_sw;
@@ -257,6 +259,9 @@ static int usb_conn_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, info);
 	device_set_wakeup_capable(&pdev->dev, true);
 
+	/* Set last role to unknown before performing the initial detection */
+	info->last_role = USB_ROLE_UNKNOWN;
+
 	/* Perform initial detection */
 	usb_conn_queue_dwork(info, 0);
 
-- 
2.7.4

