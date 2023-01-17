Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6990866E8CB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjAQV4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjAQVzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:55:20 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F387495B;
        Tue, 17 Jan 2023 13:55:16 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HLiOQO018484;
        Tue, 17 Jan 2023 21:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=DTBTVZ3J++TNyfjkCKY/j8e/JcFrazIKJqXXD7rrnKA=;
 b=initot5HVnjFZKu8uQwL7MBiI+W2UBUOe+i5//RfPWAB93nMbHGcED1XQNp1gYslL0nZ
 SvUM6V3TR2GOcCNLMwxbU82+k96nB1J+op3gJFokutj3v5Xs4GJw901WXpAWabz2d1Qr
 kJq/8UsOSWo/zSCARmuMSevn2N7xHB+IzanvOtSRt4O3m21U1N78hJj9/QMR+TbYmAT4
 AP+xQYpOGDGzw0FuXJwFCuRJ4VaQ8AJ56gvXPdIoXbd+BnfvrS9IOaVlGyk0mkCmqALj
 a3CXq452KztnjQHKqJc5K1aaYt1WTaSwMZU1saUsOXPfIB69xZtc2lsXCO0q94BfngHs pg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n3mm9xfcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 21:55:10 +0000
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 30HLt9BA031282;
        Tue, 17 Jan 2023 21:55:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA02.qualcomm.com (PPS) with ESMTP id 3n3nfkd825-1;
        Tue, 17 Jan 2023 21:55:09 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30HLt9iu031275;
        Tue, 17 Jan 2023 21:55:09 GMT
Received: from hu-devc-lv-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.164])
        by NALASPPMTA02.qualcomm.com (PPS) with ESMTP id 30HLt9lq031264;
        Tue, 17 Jan 2023 21:55:09 +0000
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id 0D26320DF8; Tue, 17 Jan 2023 13:55:09 -0800 (PST)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        balbi@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v2 3/5] usb: gadget: Add function wakeup support
Date:   Tue, 17 Jan 2023 13:55:05 -0800
Message-Id: <1673992507-7823-4-git-send-email-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1673992507-7823-1-git-send-email-quic_eserrao@quicinc.com>
References: <1673992507-7823-1-git-send-email-quic_eserrao@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yDXwWPwEsRHya-O3PXqwh7oAnlniwVjT
X-Proofpoint-ORIG-GUID: yDXwWPwEsRHya-O3PXqwh7oAnlniwVjT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_10,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=238 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170175
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A function which is in function suspend state has to send a
function wake notification to the host in case it needs to
exit from this state and resume data transfer. Add support to
handle such requests by exposing a new gadget op.

Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
---
 drivers/usb/gadget/composite.c | 26 ++++++++++++++++++++++++++
 drivers/usb/gadget/udc/core.c  | 19 +++++++++++++++++++
 include/linux/usb/composite.h  |  6 ++++++
 include/linux/usb/gadget.h     |  2 ++
 4 files changed, 53 insertions(+)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index b83963a..1672513 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -490,6 +490,32 @@ int usb_interface_id(struct usb_configuration *config,
 }
 EXPORT_SYMBOL_GPL(usb_interface_id);
 
+int usb_func_wakeup(struct usb_function *func)
+{
+	int ret, id;
+
+	if (!func->func_rw_armed) {
+		ERROR(func->config->cdev, "func remote wakeup not enabled\n");
+		return -EINVAL;
+	}
+
+	DBG(func->config->cdev, "%s function wakeup\n", func->name);
+
+	for (id = 0; id < MAX_CONFIG_INTERFACES; id++)
+		if (func->config->interface[id] == func)
+			break;
+
+	if (id == MAX_CONFIG_INTERFACES) {
+		ERROR(func->config->cdev, "Invalid function id:%d\n", id);
+		return -EINVAL;
+	}
+
+	ret = usb_gadget_func_wakeup(func->config->cdev->gadget, id);
+
+	return ret;
+}
+EXPORT_SYMBOL(usb_func_wakeup);
+
 static u8 encode_bMaxPower(enum usb_device_speed speed,
 		struct usb_configuration *c)
 {
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 23b0629..73c2346 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -819,6 +819,25 @@ int usb_gadget_activate(struct usb_gadget *gadget)
 }
 EXPORT_SYMBOL_GPL(usb_gadget_activate);
 
+/**
+ * usb_gadget_func_wakeup - sends function wake notification to the host.
+ * If the link is in low power state, first brings the link to active state.
+ * @gadget: controller used to wake up the host
+ * @interface_id: interface on which function wake notification is sent.
+ *
+ * Returns zero on success, else negative error code if the hardware
+ * doesn't support such attempts. Drivers must return device descriptors that
+ * report their ability to support this, or hosts won't enable it.
+ */
+int usb_gadget_func_wakeup(struct usb_gadget *gadget, int interface_id)
+{
+	if (!gadget->ops->func_wakeup)
+		return -EOPNOTSUPP;
+
+	return gadget->ops->func_wakeup(gadget, interface_id);
+}
+EXPORT_SYMBOL_GPL(usb_gadget_func_wakeup);
+
 /* ------------------------------------------------------------------------- */
 
 #ifdef	CONFIG_HAS_DMA
diff --git a/include/linux/usb/composite.h b/include/linux/usb/composite.h
index 43ac3fa..b2cac0a 100644
--- a/include/linux/usb/composite.h
+++ b/include/linux/usb/composite.h
@@ -149,6 +149,9 @@ struct usb_os_desc_table {
  *	GetStatus() request when the recipient is Interface.
  * @func_suspend: callback to be called when
  *	SetFeature(FUNCTION_SUSPEND) is reseived
+ * @func_suspended: Indicates whether the function is in function suspend state.
+ * @func_rw_armed: Indicates whether the function is armed by the host for
+ *	wakeup signaling.
  *
  * A single USB function uses one or more interfaces, and should in most
  * cases support operation at both full and high speeds.  Each function is
@@ -219,6 +222,8 @@ struct usb_function {
 	int			(*get_status)(struct usb_function *);
 	int			(*func_suspend)(struct usb_function *,
 						u8 suspend_opt);
+	bool			func_suspended;
+	bool			func_rw_armed;
 	/* private: */
 	/* internals */
 	struct list_head		list;
@@ -240,6 +245,7 @@ int config_ep_by_speed_and_alt(struct usb_gadget *g, struct usb_function *f,
 
 int config_ep_by_speed(struct usb_gadget *g, struct usb_function *f,
 			struct usb_ep *_ep);
+int usb_func_wakeup(struct usb_function *func);
 
 #define	MAX_CONFIG_INTERFACES		16	/* arbitrary; max 255 */
 
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 15785f8..47441b0 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -309,6 +309,7 @@ struct usb_udc;
 struct usb_gadget_ops {
 	int	(*get_frame)(struct usb_gadget *);
 	int	(*wakeup)(struct usb_gadget *);
+	int	(*func_wakeup)(struct usb_gadget *gadget, int interface_id);
 	int	(*set_selfpowered) (struct usb_gadget *, int is_selfpowered);
 	int	(*vbus_session) (struct usb_gadget *, int is_active);
 	int	(*vbus_draw) (struct usb_gadget *, unsigned mA);
@@ -612,6 +613,7 @@ int usb_gadget_disconnect(struct usb_gadget *gadget);
 int usb_gadget_deactivate(struct usb_gadget *gadget);
 int usb_gadget_activate(struct usb_gadget *gadget);
 int usb_gadget_check_config(struct usb_gadget *gadget);
+int usb_gadget_func_wakeup(struct usb_gadget *gadget, int interface_id);
 #else
 static inline int usb_gadget_frame_number(struct usb_gadget *gadget)
 { return 0; }
-- 
2.7.4

