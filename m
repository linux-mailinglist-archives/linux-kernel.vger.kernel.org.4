Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C204B6C87AA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 22:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjCXVsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 17:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjCXVsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 17:48:11 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5EB59C5;
        Fri, 24 Mar 2023 14:48:07 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OKTNAS005065;
        Fri, 24 Mar 2023 21:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=4cBkg0BSbAr6hdLFnOhS3cufomDh+qd60IRPygupoNg=;
 b=Uc2WLWf+Mg9iXr5wq18KSi0XhsIYxujX8H7tKKB/stUEzC7xKIl/RrcFZWMZmVyH8B31
 T8PqT2+7NLasYxx3f7ApAcZUBX9W2GDVD8e36SSETdjof9PN4v+vC9kv4ZRKumsN0SJY
 ArwFDWnemC8lue+4dZ5qh+//rzQYwv00xWnWAQ7Ok2etNz6oAirGj+ZhyWh3vwerYAcj
 aZ9FIe37gDft8O2WcE/hW44U6xghdKLLf5p9t8pMLJQYR8GZmI7FK5jRb0i621FqF+s2
 Ci2ItitGXUzxzqSJbxwey6Bw9TMHn8AOR0IeUylm6Yxt2hEIhkCLi2JDjXJHfWER4xPg sQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3phjk5r5td-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 21:48:05 +0000
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32OLm4fQ021463;
        Fri, 24 Mar 2023 21:48:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTP id 3pfgpd357g-1;
        Fri, 24 Mar 2023 21:48:04 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32OLm4Bu021448;
        Fri, 24 Mar 2023 21:48:04 GMT
Received: from hu-devc-lv-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.164])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTP id 32OLm4dG021442;
        Fri, 24 Mar 2023 21:48:04 +0000
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id 24FBB20E6A; Fri, 24 Mar 2023 14:48:04 -0700 (PDT)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v13 5/6] usb: gadget: Handle function suspend feature selector
Date:   Fri, 24 Mar 2023 14:48:01 -0700
Message-Id: <1679694482-16430-6-git-send-email-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1679694482-16430-1-git-send-email-quic_eserrao@quicinc.com>
References: <1679694482-16430-1-git-send-email-quic_eserrao@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -wxy43guAzsY5DRVp5s3zUtpuknNi7In
X-Proofpoint-ORIG-GUID: -wxy43guAzsY5DRVp5s3zUtpuknNi7In
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 mlxlogscore=569 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303240166
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When host sends function suspend feature selector to the device,
inspect the received packet and trigger function suspend or
function resume accordingly. Inspect the remote wakeup bit and
arm the function for remote wakeup if it is wakeup capable. Also
host queries the function wakeup capability  through a get status
request before sending function resume. Handle such requests in
composite layer.

Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
---
 drivers/usb/gadget/composite.c | 65 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 2111732..d1d7f89 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -941,6 +941,9 @@ static void reset_config(struct usb_composite_dev *cdev)
 		if (f->disable)
 			f->disable(f);
 
+		/* Section 9.1.1.6, disable remote wakeup when device is reset */
+		f->func_wakeup_armed = false;
+
 		bitmap_zero(f->endpoints, 32);
 	}
 	cdev->config = NULL;
@@ -2006,9 +2009,20 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
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
@@ -2030,8 +2044,44 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 			if (!f)
 				break;
 			value = 0;
-			if (f->func_suspend)
+			if (f->func_suspend) {
 				value = f->func_suspend(f, w_index >> 8);
+			/* SetFeature(FUNCTION_SUSPEND) */
+			} else if (ctrl->bRequest == USB_REQ_SET_FEATURE) {
+				if (!(f->config->bmAttributes &
+				      USB_CONFIG_ATT_WAKEUP) &&
+				     (w_index & USB_INTRF_FUNC_SUSPEND_RW))
+					break;
+
+				f->func_wakeup_armed = !!(w_index &
+							  USB_INTRF_FUNC_SUSPEND_RW);
+
+				if (w_index & USB_INTRF_FUNC_SUSPEND_LP) {
+					if (f->suspend && !f->func_suspended) {
+						f->suspend(f);
+						f->func_suspended = true;
+					}
+				/*
+				 * Handle cases where host sends function resume
+				 * through SetFeature(FUNCTION_SUSPEND) but low power
+				 * bit reset
+				 */
+				} else {
+					if (f->resume && f->func_suspended) {
+						f->resume(f);
+						f->func_suspended = false;
+					}
+				}
+			/* ClearFeature(FUNCTION_SUSPEND) */
+			} else if (ctrl->bRequest == USB_REQ_CLEAR_FEATURE) {
+				f->func_wakeup_armed = false;
+
+				if (f->resume && f->func_suspended) {
+					f->resume(f);
+					f->func_suspended = false;
+				}
+			}
+
 			if (value < 0) {
 				ERROR(cdev,
 				      "func_suspend() returned error %d\n",
@@ -2574,7 +2624,12 @@ void composite_resume(struct usb_gadget *gadget)
 		cdev->driver->resume(cdev);
 	if (cdev->config) {
 		list_for_each_entry(f, &cdev->config->functions, list) {
-			if (f->resume)
+			/*
+			 * Check for func_suspended flag to see if the function is
+			 * in USB3 FUNCTION_SUSPEND state. In this case resume is
+			 * done via FUNCTION_SUSPEND feature selector.
+			 */
+			if (f->resume && !f->func_suspended)
 				f->resume(f);
 		}
 
-- 
2.7.4

