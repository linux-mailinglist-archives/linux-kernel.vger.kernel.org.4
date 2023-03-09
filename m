Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0FF6B2EA2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 21:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjCIUZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 15:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjCIUZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 15:25:07 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF40DBB73;
        Thu,  9 Mar 2023 12:25:06 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329IYkNG028961;
        Thu, 9 Mar 2023 20:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=7thI068FQB8fnYsmyGn3WbsGkchpboF6YiDyxhiR0V8=;
 b=BkZO4/RbVKJigZ9iC5rlJ5vtXWMQapiKWV8o/litedDa3WA6fleD+9RJ2L6PKzrFlK/a
 109xw18yR8PEzzDDwyop5UQ9vRGIJH2sVVH03vlSAJ9r6GP+spEKqNY7010zE1ECSd66
 EI7qo+5KwIm3vZOP3Gs0olNmSqkQ7oFNGHOt5wYJagOfnUv0xjAoRdL9ICO3n3oW41dt
 NK9z6Xji+Nxjp7IlBSWjiTEAY05a3uAeHACWrP59cmT/TF4RxwSxQP75ax+L7ZMbfikf
 oViYJqc1b8VPbmvLqsPIpyTxpTqWVuG78KzsVS7uDcMV1A+Yq4HE17B3AGP+PmieGnZ2 qQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p7bvk20sa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 20:25:02 +0000
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 329KP1W3003624;
        Thu, 9 Mar 2023 20:25:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 3p4fjtdn86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 09 Mar 2023 20:25:01 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 329KP1Q4003596;
        Thu, 9 Mar 2023 20:25:01 GMT
Received: from hu-devc-lv-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.164])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTP id 329KP0j2003592;
        Thu, 09 Mar 2023 20:25:01 +0000
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id AE3DA20E4E; Thu,  9 Mar 2023 12:25:00 -0800 (PST)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        balbi@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v7 3/5] usb: gadget: Add function wakeup support
Date:   Thu,  9 Mar 2023 12:24:57 -0800
Message-Id: <1678393499-7366-4-git-send-email-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1678393499-7366-1-git-send-email-quic_eserrao@quicinc.com>
References: <1678393499-7366-1-git-send-email-quic_eserrao@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HfNOWwR0mUB7uFZ7FzGqy8QUU30HbUA6
X-Proofpoint-ORIG-GUID: HfNOWwR0mUB7uFZ7FzGqy8QUU30HbUA6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_11,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 mlxlogscore=359 lowpriorityscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303090164
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB3.2 spec section 9.2.5.4 quotes that a function may signal that
it wants to exit from Function Suspend by sending a Function
Wake Notification to the host if it is enabled for function
remote wakeup. Add an api in composite layer that can be used
by the function drivers to support this feature. Also expose
a gadget op so that composite layer can trigger a wakeup request
to the UDC driver.

Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
---
 drivers/usb/gadget/composite.c | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/usb/composite.h  |  6 ++++++
 include/linux/usb/gadget.h     |  1 +
 3 files changed, 47 insertions(+)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index c9c983e..2111732 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -492,6 +492,46 @@ int usb_interface_id(struct usb_configuration *config,
 }
 EXPORT_SYMBOL_GPL(usb_interface_id);
 
+/**
+ * usb_func_wakeup - sends function wake notification to the host.
+ * @func: function that sends the remote wakeup notification.
+ *
+ * Applicable to devices operating at enhanced superspeed when usb
+ * functions are put in function suspend state and armed for function
+ * remote wakeup. On completion, function wake notification is sent. If
+ * the device is in low power state it tries to bring the device to active
+ * state before sending the wake notification. Since it is a synchronous
+ * call, caller must take care of not calling it in interrupt context.
+ * For devices operating at lower speeds  returns negative errno.
+ *
+ * Returns zero on success, else negative errno.
+ */
+int usb_func_wakeup(struct usb_function *func)
+{
+	struct usb_gadget	*gadget = func->config->cdev->gadget;
+	int			id;
+
+	if (!gadget->ops->func_wakeup)
+		return -EOPNOTSUPP;
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
+	return gadget->ops->func_wakeup(gadget, id);
+}
+EXPORT_SYMBOL_GPL(usb_func_wakeup);
+
 static u8 encode_bMaxPower(enum usb_device_speed speed,
 		struct usb_configuration *c)
 {
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
index 1d79612..75bda078 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -310,6 +310,7 @@ struct usb_udc;
 struct usb_gadget_ops {
 	int	(*get_frame)(struct usb_gadget *);
 	int	(*wakeup)(struct usb_gadget *);
+	int	(*func_wakeup)(struct usb_gadget *gadget, int intf_id);
 	int	(*set_remote_wakeup)(struct usb_gadget *, int set);
 	int	(*set_selfpowered) (struct usb_gadget *, int is_selfpowered);
 	int	(*vbus_session) (struct usb_gadget *, int is_active);
-- 
2.7.4

