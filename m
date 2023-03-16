Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C6C6BDD08
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 00:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCPXjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 19:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjCPXip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 19:38:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384E9B6D30;
        Thu, 16 Mar 2023 16:38:32 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32GMSG1p013873;
        Thu, 16 Mar 2023 23:38:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=jgq6H8II6Z0ilzNUlyVFzHKRunZzG3RZ4KR7S/XvShg=;
 b=hYTIdHD/unFMtQZizXII0S+UOCSfbCt50mC3tiJrwE+VMmXL8V6dq9kbvjJKYwEWEZ+v
 hzYsvNWdpTQ/ppLkaniI8q3lzyb0ehXwtHwQ0kUf2tZWj159SAgap087bVRMQEkjjPGh
 EJjv2n8IAtVHzSaAEBDFgjhSqyoZCQE8Nn+AjxAKejE7a6Pkm1cgYFc+M0Ui+/3km320
 OlTosKof80nBThHMjGpsivOnmYMQmedEkMyN9ViXGKiY6UXeUEJClmgghBXw31iT5gkJ
 7Lnno7+/iQ9Va+VimpSIR+oOcpQWd2NMnyY/iL0pZoaDXV02lUFgFooIB3F1QVe2Zr2W 9g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pc4vv9b5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 23:38:14 +0000
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32GNcDmM007517;
        Thu, 16 Mar 2023 23:38:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA01.qualcomm.com (PPS) with ESMTP id 3pbpy2782q-1;
        Thu, 16 Mar 2023 23:38:13 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32GNcDNV007509;
        Thu, 16 Mar 2023 23:38:13 GMT
Received: from hu-devc-lv-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.164])
        by NALASPPMTA01.qualcomm.com (PPS) with ESMTP id 32GNcD3S007507;
        Thu, 16 Mar 2023 23:38:13 +0000
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id AB32420E5A; Thu, 16 Mar 2023 16:38:12 -0700 (PDT)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v12 5/6] usb: gadget: arm the function for triggering remote wakeup
Date:   Thu, 16 Mar 2023 16:38:07 -0700
Message-Id: <1679009888-8239-6-git-send-email-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1679009888-8239-1-git-send-email-quic_eserrao@quicinc.com>
References: <1679009888-8239-1-git-send-email-quic_eserrao@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _NTDcmGVGvDMdIKHFoER9NgbLWdXO7z4
X-Proofpoint-GUID: _NTDcmGVGvDMdIKHFoER9NgbLWdXO7z4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_14,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxlogscore=417 mlxscore=0 spamscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303160176
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When host sends function suspend feature selector to the device,
arm the function for remote wakeup based on the received packet.
Also host queries the function wakeup capability  through a get
status request. Handle such requests in composite layer for cases
where function driver has not exposed a get_status callback.

Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
---
 drivers/usb/gadget/composite.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 2111732..2c1100e 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -2006,9 +2006,20 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 		f = cdev->config->interface[intf];
 		if (!f)
 			break;
-		status = f->get_status ? f->get_status(f) : 0;
-		if (status < 0)
-			break;
+
+		if (f->get_status) {
+			status = f->get_status(f);
+			if (status < 0)
+				break;
+		} else {
+			/* Set D0 and D1 bits based on func wakeup capability */
+			if (f->config->bmAttributes & USB_CONFIG_ATT_WAKEUP) {
+				status |= USB_INTRF_STAT_FUNC_RW_CAP;
+				if (f->func_wakeup_armed)
+					status |= USB_INTRF_STAT_FUNC_RW;
+			}
+		}
+
 		put_unaligned_le16(status & 0x0000ffff, req->buf);
 		break;
 	/*
@@ -2029,6 +2040,15 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 			f = cdev->config->interface[intf];
 			if (!f)
 				break;
+
+			if (w_index & USB_INTRF_FUNC_SUSPEND_RW) {
+				if (!(f->config->bmAttributes &
+				      USB_CONFIG_ATT_WAKEUP))
+					break;
+				f->func_wakeup_armed = (ctrl->bRequest ==
+							USB_REQ_SET_FEATURE);
+			}
+
 			value = 0;
 			if (f->func_suspend)
 				value = f->func_suspend(f, w_index >> 8);
-- 
2.7.4

