Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAF56A0256
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 06:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbjBWFTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 00:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjBWFS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 00:18:57 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADF3474FC;
        Wed, 22 Feb 2023 21:18:56 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31N42FMc030284;
        Thu, 23 Feb 2023 05:18:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=luXeSi3oGE0B76cYBdKMJWZZbG8GVrkQJyPg4MmcMH4=;
 b=LoP5uFPMwV9afpZRmNqeHZrpSewUbdkCSpvcEFzgOcE2tWz4Gg1L90BnmLWe6JPHz94T
 Po+IHtNdRQQ+cI7a52ajf1KebWO6jOXl2pC+d5jYU4o1E4///T3gWiDPCk8OALcBkQIJ
 o/bywRXE6jMcPcZRsIF6A50L1qnVeN68tX2lJyMofh408XUMcRHT7pnaBe9EidL03H+F
 ZD/pc54N1ZNdfhzj4aPmWBTvH+l8Zw7qBmniizNroQI+Z/8uDxBoA7voDecGp/+XxlL8
 xkbyTDeUYKpYevsESmczrvbmWhNd7eylpGhzzhESYuyIvDAZSpuvfL1I3vUOfQN93Sdo 0w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nwybm0bg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 05:18:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31N5Iqth018033
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 05:18:52 GMT
Received: from hu-prashk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 22 Feb 2023 21:18:49 -0800
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
Subject: [PATCH v1 2/2] usb: gadget: composite: Draw 100mA current if not configured
Date:   Thu, 23 Feb 2023 10:48:30 +0530
Message-ID: <1677129510-10283-3-git-send-email-quic_prashk@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1677129510-10283-1-git-send-email-quic_prashk@quicinc.com>
References: <1677129510-10283-1-git-send-email-quic_prashk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hftI9Gdu0Wx7XuC_6tbObtQgQw1bpJJ7
X-Proofpoint-GUID: hftI9Gdu0Wx7XuC_6tbObtQgQw1bpJJ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_02,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=550
 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302230045
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we don't change the current value if device isn't in
configured state. But the battery charging specification says,
the device can draw upto 100mA of current if its in unconfigured
state. Hence add a Vbus_draw work in composite_resume to draw
100mA if the device isn't configured.

Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
---
 drivers/usb/gadget/composite.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index fa7dd6c..147d278 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -2531,6 +2531,8 @@ void composite_resume(struct usb_gadget *gadget)
 			usb_gadget_clear_selfpowered(gadget);
 
 		usb_gadget_vbus_draw(gadget, maxpower);
+	} else {
+		usb_gadget_vbus_draw(gadget, 100);
 	}
 
 	cdev->suspended = 0;
-- 
2.7.4

