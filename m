Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C7370F804
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbjEXNuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235146AbjEXNuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:50:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E359AAA;
        Wed, 24 May 2023 06:50:18 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OCibAj013324;
        Wed, 24 May 2023 13:50:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=LQQrfZVPT5E9wHqNJdtcY7zkZ8sWfdNxcom8AZHCpRk=;
 b=gVeY6Dnk9GfY5pyAAdkqPXpwDChIEkAuZ4XdzPbQmoXS47LXXYdJHDGj8KBejhkbWkvA
 APIp2t3hPPv5kiewmbOYDVUk8RV6djBk3bGTJRwXjBHNleeh4U9Vntma8c3jYu612HsN
 h/X2COHlbnVjzD2u1gGA35VpSQNWwsg3wKkF1JH2hZhzF3U73w2NRLFIoB14pClZJxLQ
 ttTeKi0JuK9NmcaDQIjl5gYYZN+h5afO1I4WOEVvMvppViSdHr/1H3HUjj+qw0d+1sB2
 Jzn+rDlECIDVn72BkZRdhAMa3bUPsZY1bjfYjwmHDTUlIyGraZ76KrFFBOx8hAoVZkz9 1Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qs4df9uxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 13:50:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34ODoDvg000739
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 13:50:13 GMT
Received: from hu-prashk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 24 May 2023 06:50:11 -0700
From:   Prashanth K <quic_prashk@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Prashanth K <quic_prashk@quicinc.com>
Subject: [PATCH v2] usb: common: usb-conn-gpio: Set last role to unknown before initial detection
Date:   Wed, 24 May 2023 19:20:07 +0530
Message-ID: <1684936207-23529-1-git-send-email-quic_prashk@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hNRLGsQXfAB3vaHGlEc6Kj-YRVtz-eMI
X-Proofpoint-ORIG-GUID: hNRLGsQXfAB3vaHGlEc6Kj-YRVtz-eMI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_09,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=930
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305240113
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
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
initialized to zero.

To avoid this, added a new constant in enum usb_role, last_role
is set to USB_ROLE_UNKNOWN before performing initial detection.

Fixes: 4602f3bff266 ("usb: common: add USB GPIO based connection detection driver")
Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
---
v2: Added USB_ROLE_UNKNWON to enum usb_role

 drivers/usb/common/usb-conn-gpio.c | 3 +++
 include/linux/usb/role.h           | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
index e20874c..30bdb81 100644
--- a/drivers/usb/common/usb-conn-gpio.c
+++ b/drivers/usb/common/usb-conn-gpio.c
@@ -257,6 +257,9 @@ static int usb_conn_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, info);
 	device_set_wakeup_capable(&pdev->dev, true);
 
+	/* Set last role to unknown before performing the initial detection */
+	info->last_role = USB_ROLE_UNKNOWN;
+
 	/* Perform initial detection */
 	usb_conn_queue_dwork(info, 0);
 
diff --git a/include/linux/usb/role.h b/include/linux/usb/role.h
index b5deafd..221d462 100644
--- a/include/linux/usb/role.h
+++ b/include/linux/usb/role.h
@@ -8,6 +8,7 @@
 struct usb_role_switch;
 
 enum usb_role {
+	USB_ROLE_UNKNOWN = -1,
 	USB_ROLE_NONE,
 	USB_ROLE_HOST,
 	USB_ROLE_DEVICE,
-- 
2.7.4

