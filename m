Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDA1699FC3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 23:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjBPWaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 17:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjBPWaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 17:30:06 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF80443453;
        Thu, 16 Feb 2023 14:30:04 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31GHNWlJ001170;
        Thu, 16 Feb 2023 22:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=CPcttb5DtsMnCpbdP3LKapVeosUZ8I7QE2F6yyOQ8Dg=;
 b=Ju1jvcMpNawUfAerFbynW5+6AO3eZIAxU2bMvRfqtjGUDdrKim4R56PNtIzVuKGqco6x
 +PPG+cNxqn6GkZwbbGw/7e1iHKWmkV4ZekL12pr7CuANp9Xx+ZoL8FYeTs9R+MCY6WKD
 W4oC1iYjj08KuWMwV3OOU19nKpR81HK/az3J5/5GHfdhksTmL8/0lNxAGYdUQOMc3FSX
 FFob7XIBfExl+HY7o+tBVz2bMVt65b7GcjKXhQPWE/aBJi6l5VNj2soqKhDuag0L8qdw
 QAN3L3LDdS/aLmvc7mngRu+k4O1R64pc7Xmznvb24XaDhpOWxkPMC6A1BtUvdE8GIw9s 7A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nsft5t77w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 22:29:53 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 31GMRBEa001108;
        Thu, 16 Feb 2023 22:29:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTP id 3ns32ng2cv-1;
        Thu, 16 Feb 2023 22:29:52 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31GMSewl002732;
        Thu, 16 Feb 2023 22:29:52 GMT
Received: from hu-devc-lv-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.164])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTP id 31GMTqIB003759;
        Thu, 16 Feb 2023 22:29:52 +0000
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id 308DE20E53; Thu, 16 Feb 2023 14:29:52 -0800 (PST)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        balbi@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v5 3/5] usb: gadget: Add function wakeup support
Date:   Thu, 16 Feb 2023 14:29:46 -0800
Message-Id: <1676586588-25989-4-git-send-email-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1676586588-25989-1-git-send-email-quic_eserrao@quicinc.com>
References: <1676586588-25989-1-git-send-email-quic_eserrao@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: l7su8jVtiiOzdzVGHUeDm1KhvqtRTLy1
X-Proofpoint-GUID: l7su8jVtiiOzdzVGHUeDm1KhvqtRTLy1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_16,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 spamscore=0 phishscore=0 impostorscore=0 mlxlogscore=363
 clxscore=1015 adultscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302160192
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
index a37a8f4..f649f997 100644
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
+		ERROR(func->config->cdev, "Invalid function\n");
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

