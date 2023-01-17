Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9DA670B1B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjAQWDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjAQWAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:00:21 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B1B3AAA;
        Tue, 17 Jan 2023 13:55:21 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HLtAet001928;
        Tue, 17 Jan 2023 21:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=cmDw+TOZEQslfaLKwSi2E46gLsh4MOjc+Sy+sEou9GM=;
 b=A8LxjlVqgH32t5Cj3pU5CF7GwBimBFvEXaWp5p/4B4XjImkDE9GU9grUemF1mmz8dhrK
 46ltTwqq9jgJcUO7/gF6D0VYSxEMBO10rVXdUlh3911gpKUyXiDRvDI1nRHAyV5yypg9
 dN9vM01JVN7lZViQlfZk/zN9SZ9Dt2mzfmIdn9SflsMz7stilrXuc33C92/nTxxcVxaM
 VIJUCNrXZf8K7ipJ1oBktGgCN0Nvr/7E20LnMAiVEvQIomLHn7lnQMg9ULMPzlihpwzL
 IInMr/w05ySQMR3QKSz4I9XYd4udMhWm5M50g1Be5RHSoC6KasmaHv9KhzXdiGPnKILx Vw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n5nkq9vjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 21:55:10 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 30HLt9DP013187;
        Tue, 17 Jan 2023 21:55:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTP id 3n3nfkw8a2-1;
        Tue, 17 Jan 2023 21:55:09 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30HLt9rJ013181;
        Tue, 17 Jan 2023 21:55:09 GMT
Received: from hu-devc-lv-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.164])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTP id 30HLt94U013178;
        Tue, 17 Jan 2023 21:55:09 +0000
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id 084831F481; Tue, 17 Jan 2023 13:55:09 -0800 (PST)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        balbi@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v2 1/5] usb: gadget: Add remote wakeup capable flag
Date:   Tue, 17 Jan 2023 13:55:03 -0800
Message-Id: <1673992507-7823-2-git-send-email-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1673992507-7823-1-git-send-email-quic_eserrao@quicinc.com>
References: <1673992507-7823-1-git-send-email-quic_eserrao@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qlJ75no6pcub6sSBIxnyxyJIEHga3Uy2
X-Proofpoint-ORIG-GUID: qlJ75no6pcub6sSBIxnyxyJIEHga3Uy2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_10,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 adultscore=0 mlxlogscore=411 bulkscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170174
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a flag to indicate whether the gadget is capable
of sending remote wakeup to the host.

Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
---
 drivers/usb/gadget/composite.c | 3 +++
 include/linux/usb/gadget.h     | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 403563c..b83963a 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -965,6 +965,9 @@ static int set_config(struct usb_composite_dev *cdev,
 	else
 		usb_gadget_clear_selfpowered(gadget);
 
+	if (USB_CONFIG_ATT_WAKEUP & c->bmAttributes)
+		gadget->rw_capable = 1;
+
 	usb_gadget_vbus_draw(gadget, power);
 	if (result >= 0 && cdev->delayed_status)
 		result = USB_GADGET_DELAYED_STATUS;
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index dc3092c..15785f8 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -385,6 +385,7 @@ struct usb_gadget_ops {
  *	indicates that it supports LPM as per the LPM ECN & errata.
  * @irq: the interrupt number for device controller.
  * @id_number: a unique ID number for ensuring that gadget names are distinct
+ * @rw_capable: True if the gadget is capable of sending remote wakeup.
  *
  * Gadgets have a mostly-portable "gadget driver" implementing device
  * functions, handling all usb configurations and interfaces.  Gadget
@@ -446,6 +447,7 @@ struct usb_gadget {
 	unsigned			lpm_capable:1;
 	int				irq;
 	int				id_number;
+	unsigned			rw_capable:1;
 };
 #define work_to_gadget(w)	(container_of((w), struct usb_gadget, work))
 
-- 
2.7.4

