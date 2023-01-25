Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C32367AADD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 08:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbjAYH1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 02:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbjAYH1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 02:27:50 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A8BEC64;
        Tue, 24 Jan 2023 23:27:49 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30P7GAnw003812;
        Wed, 25 Jan 2023 07:27:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ULNqnRyw4epclnCKBllJ8Xlo23ISztCl3VRP+Fq8Ygs=;
 b=lLtUgJmQ+4/e8DP5Eroqu4h8rDF2mvE7e8rnQNUFTF39vhGDN9T+CXds+PEfZfSxk8/L
 BGQsGDO419b8WTaof20XdPHzVidEy+XMLJMxuCqKMzCAlWs60hm6PH9hYrCERh6jYwtg
 7hWam/4zwvZPaqxXHBf0l5Fv5TpGbZOIvn6c5Segg21jAkHGZo38/EHvbDOOe1Bx8hss
 T48+uxTYcYLpLDQpnKOfwEmxByhP3eJZvFB2Imn60FXGbxG6RKQNJEprz/95CeHjc06O
 Q0lApgVoLr/4RE7htZiWfrNlxaImJJZBa0FNibKU1BFI1A1+FN3WE1LDjkSfQWg2bXxd Dg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3najqa9a3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 07:27:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30P7RdM7009025
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 07:27:39 GMT
Received: from hu-prashk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 24 Jan 2023 23:27:35 -0800
From:   Prashanth K <quic_prashk@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Hofman <pavel.hofman@ivitera.com>,
        Joe Perches <joe@perches.com>, Julian Scheel <julian@jusst.de>,
        Colin Ian King <colin.i.king@gmail.com>
CC:     Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Prashanth K <quic_prashk@quicinc.com>
Subject: [PATCH v3] usb: gadget: f_uac2: Fix incorrect increment of bNumEndpoints
Date:   Wed, 25 Jan 2023 12:57:25 +0530
Message-ID: <1674631645-28888-1-git-send-email-quic_prashk@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: i3NvaGzwxVVNUW6bkEyuatvxGPoHvzPs
X-Proofpoint-ORIG-GUID: i3NvaGzwxVVNUW6bkEyuatvxGPoHvzPs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_04,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 mlxlogscore=730 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250068
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pratham Pratap <quic_ppratap@quicinc.com>

Currently connect/disconnect of USB cable calls afunc_bind and
eventually increments the bNumEndpoints. Performing multiple
plugin/plugout will increment bNumEndpoints incorrectly, and on
the next plug-in it leads to invalid configuration of descriptor
and hence enumeration fails.

Fix this by resetting the value of bNumEndpoints to 1 on every
afunc_bind call.

Fixes: 40c73b30546e ("usb: gadget: f_uac2: add adaptive sync support for capture")
Signed-off-by: Pratham Pratap <quic_ppratap@quicinc.com>
Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
---
v3: Added Fixes tag.

 drivers/usb/gadget/function/f_uac2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index 08726e4..0219cd7 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -1142,6 +1142,7 @@ afunc_bind(struct usb_configuration *cfg, struct usb_function *fn)
 		}
 		std_as_out_if0_desc.bInterfaceNumber = ret;
 		std_as_out_if1_desc.bInterfaceNumber = ret;
+		std_as_out_if1_desc.bNumEndpoints = 1;
 		uac2->as_out_intf = ret;
 		uac2->as_out_alt = 0;
 
-- 
2.7.4

