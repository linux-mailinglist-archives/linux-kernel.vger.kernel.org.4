Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979276950B6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjBMTbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjBMTb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:31:29 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10864EC8;
        Mon, 13 Feb 2023 11:31:27 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DImn7w014142;
        Mon, 13 Feb 2023 19:31:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=w7HZY+uTjA/4Nb4d/avnd2PgC9y6LHf8q4x738SM01s=;
 b=GKhL7MfccejEt8Cn2jf0kYkHZY8cLrlUWaoRuClhEcOF/t7azYfM2A7loAkTcCmpjaWW
 Mxw8VFnIMilC4dbWlkSKXqOCGyTyYQoLBK7VbRZ7KtQXyF6BLbeQmp8FMYBP4/AEODUk
 WIS/0G/FDGlRTldr3yIdCcJHUxa/RO+3H+6LP5WanUMmq6Ku+1vZjWYLoq8Ps6f34usb
 lMWJpoL141eylEBhuSbMGoSEeRIbaf5v7iST3mbl/FHDWd9ImL2YB29cdqguU3GxA58b
 1NHKuMpA2/5BXTlq/+gnfcoxgf6rQeywzsDoPAW6gIEmD2/EDmaLvLrnbuyOEvrsVbUP oA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqtsur2qb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 19:31:23 +0000
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 31DJVMXg024186;
        Mon, 13 Feb 2023 19:31:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA05.qualcomm.com (PPS) with ESMTP id 3np43kk3w8-1;
        Mon, 13 Feb 2023 19:31:22 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31DJVLwM024175;
        Mon, 13 Feb 2023 19:31:21 GMT
Received: from hu-devc-lv-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.164])
        by NALASPPMTA05.qualcomm.com (PPS) with ESMTP id 31DJVLUw024173;
        Mon, 13 Feb 2023 19:31:21 +0000
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id 9078520E4E; Mon, 13 Feb 2023 11:31:21 -0800 (PST)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        balbi@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v4 3/5] usb: gadget: Add function wakeup support
Date:   Mon, 13 Feb 2023 11:31:14 -0800
Message-Id: <1676316676-28377-4-git-send-email-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1676316676-28377-1-git-send-email-quic_eserrao@quicinc.com>
References: <1676316676-28377-1-git-send-email-quic_eserrao@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LQ7iHVtIOT2Npig8PdsXsfXQr5ybOAgU
X-Proofpoint-ORIG-GUID: LQ7iHVtIOT2Npig8PdsXsfXQr5ybOAgU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=385 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302130170
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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
 drivers/usb/gadget/composite.c | 24 ++++++++++++++++++++++++
 drivers/usb/gadget/udc/core.c  | 21 +++++++++++++++++++++
 include/linux/usb/composite.h  |  6 ++++++
 include/linux/usb/gadget.h     |  4 ++++
 4 files changed, 55 insertions(+)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index a37a8f4..51d6ee9 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -492,6 +492,30 @@ int usb_interface_id(struct usb_configuration *config,
 }
 EXPORT_SYMBOL_GPL(usb_interface_id);
 
+int usb_func_wakeup(struct usb_function *func)
+{
+	int ret, id;
+
+	if (!func->func_wakeup_armed) {
+		ERROR(func->config->cdev, "not armed for func remote wakeup\n");
+		return -EINVAL;
+	}
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
+EXPORT_SYMBOL_GPL(usb_func_wakeup);
+
 static u8 encode_bMaxPower(enum usb_device_speed speed,
 		struct usb_configuration *c)
 {
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 3dcbba7..59e7a7e 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -846,6 +846,27 @@ int usb_gadget_activate(struct usb_gadget *gadget)
 }
 EXPORT_SYMBOL_GPL(usb_gadget_activate);
 
+/**
+ * usb_gadget_func_wakeup - sends function wake notification to the host.
+ * @gadget: controller used to wake up the host
+ * @interface_id: interface on which function wake notification is sent.
+ *
+ * On completion, function wake notification is sent. If the device is in
+ * low power state it tries to bring the device to active state before sending
+ * the wake notification. Since it is a synchronous call, caller must take care
+ * of not calling it in interrupt context.
+ *
+ * Returns zero on success, else negative errno.
+ */
+int usb_gadget_func_wakeup(struct usb_gadget *gadget, int intf_id)
+{
+	if (!gadget->ops->func_wakeup)
+		return -EOPNOTSUPP;
+
+	return gadget->ops->func_wakeup(gadget, intf_id);
+}
+EXPORT_SYMBOL_GPL(usb_gadget_func_wakeup);
+
 /* ------------------------------------------------------------------------- */
 
 #ifdef	CONFIG_HAS_DMA
diff --git a/include/linux/usb/composite.h b/include/linux/usb/composite.h
index d949e91..a2448e9 100644
--- a/include/linux/usb/composite.h
+++ b/include/linux/usb/composite.h
@@ -150,6 +150,9 @@ struct usb_os_desc_table {
  *	GetStatus() request when the recipient is Interface.
  * @func_suspend: callback to be called when
  *	SetFeature(FUNCTION_SUSPEND) is reseived
+ * @func_suspended: Indicates whether the function is in function suspend state.
+ * @func_wakeup_armed: Indicates whether the function is armed by the host for
+ *	wakeup signaling.
  *
  * A single USB function uses one or more interfaces, and should in most
  * cases support operation at both full and high speeds.  Each function is
@@ -220,6 +223,8 @@ struct usb_function {
 	int			(*get_status)(struct usb_function *);
 	int			(*func_suspend)(struct usb_function *,
 						u8 suspend_opt);
+	bool			func_suspended;
+	bool			func_wakeup_armed;
 	/* private: */
 	/* internals */
 	struct list_head		list;
@@ -241,6 +246,7 @@ int config_ep_by_speed_and_alt(struct usb_gadget *g, struct usb_function *f,
 
 int config_ep_by_speed(struct usb_gadget *g, struct usb_function *f,
 			struct usb_ep *_ep);
+int usb_func_wakeup(struct usb_function *func);
 
 #define	MAX_CONFIG_INTERFACES		16	/* arbitrary; max 255 */
 
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 1d79612..2a512c5 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -310,6 +310,7 @@ struct usb_udc;
 struct usb_gadget_ops {
 	int	(*get_frame)(struct usb_gadget *);
 	int	(*wakeup)(struct usb_gadget *);
+	int     (*func_wakeup)(struct usb_gadget *gadget, int intf_id);
 	int	(*set_remote_wakeup)(struct usb_gadget *, int set);
 	int	(*set_selfpowered) (struct usb_gadget *, int is_selfpowered);
 	int	(*vbus_session) (struct usb_gadget *, int is_active);
@@ -617,6 +618,7 @@ int usb_gadget_disconnect(struct usb_gadget *gadget);
 int usb_gadget_deactivate(struct usb_gadget *gadget);
 int usb_gadget_activate(struct usb_gadget *gadget);
 int usb_gadget_check_config(struct usb_gadget *gadget);
+int usb_gadget_func_wakeup(struct usb_gadget *gadget, int intf_id);
 #else
 static inline int usb_gadget_frame_number(struct usb_gadget *gadget)
 { return 0; }
@@ -644,6 +646,8 @@ static inline int usb_gadget_activate(struct usb_gadget *gadget)
 { return 0; }
 static inline int usb_gadget_check_config(struct usb_gadget *gadget)
 { return 0; }
+static inline int usb_gadget_func_wakeup(struct usb_gadget *gadget, int intf_id)
+{ return 0; }
 #endif /* CONFIG_USB_GADGET */
 
 /*-------------------------------------------------------------------------*/
-- 
2.7.4

