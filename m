Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A90E68C68C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjBFTNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjBFTNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:13:42 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972B420060;
        Mon,  6 Feb 2023 11:13:40 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316IA3gW005726;
        Mon, 6 Feb 2023 19:13:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=6FWkFSeHgUiV9QCXZDwysCnJKsRycgPAOkmixMhwHUE=;
 b=flO/5hO24jXBPnk0YwbA4MR30xkilTLD2gqAeXb2JlgaQ+vZynA7kJ1o57eqxW9yIPOy
 tlUbwbkM/qUdpBHZJiENB1RiWTy9csVtripMPvLXboFtMmo7BG24DZ1VDReBDtDbFSsj
 QANsjtNSQs5l29YW5Pud0aZ3GAIVewVKwNfKEbqIVxg/2hvniBsLkZ1E8s+m8lHwDvkY
 n2QiKpQDCjEjYrZkuS6zBftk4LJBJL5wkmOdzllVyhmbm9Yp2V+HDGl8MD2h1YKLmWJp
 XfpjD79JqSkNWxK5q/Bpr2NbRzxKXqEPgDmVpXS0kokgNr0sIxXMyLHzxCEZYTf8PhGw Mw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nhff2mhfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 19:13:35 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 316JDYYe018004;
        Mon, 6 Feb 2023 19:13:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTP id 3nhgem2v2g-1;
        Mon, 06 Feb 2023 19:13:34 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 316JDYxI017991;
        Mon, 6 Feb 2023 19:13:34 GMT
Received: from hu-devc-lv-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.164])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTP id 316JDXuC017988;
        Mon, 06 Feb 2023 19:13:34 +0000
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id EA56720E45; Mon,  6 Feb 2023 11:13:33 -0800 (PST)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        balbi@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v3 3/5] usb: gadget: Add function wakeup support
Date:   Mon,  6 Feb 2023 11:13:24 -0800
Message-Id: <1675710806-9735-4-git-send-email-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1675710806-9735-1-git-send-email-quic_eserrao@quicinc.com>
References: <1675710806-9735-1-git-send-email-quic_eserrao@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vkqn88_GQFJsg95FfOM9UK911apYl8FQ
X-Proofpoint-GUID: vkqn88_GQFJsg95FfOM9UK911apYl8FQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=277
 suspectscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302060167
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
 drivers/usb/gadget/composite.c | 26 ++++++++++++++++++++++++++
 drivers/usb/gadget/udc/core.c  | 19 +++++++++++++++++++
 include/linux/usb/composite.h  |  6 ++++++
 include/linux/usb/gadget.h     |  4 ++++
 4 files changed, 55 insertions(+)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index e459fb0..aa243d8 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -492,6 +492,32 @@ int usb_interface_id(struct usb_configuration *config,
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
index 5874d4f..63b5944 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -846,6 +846,25 @@ int usb_gadget_activate(struct usb_gadget *gadget)
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
index 91d22c3..c9573ba 100644
--- a/include/linux/usb/composite.h
+++ b/include/linux/usb/composite.h
@@ -150,6 +150,9 @@ struct usb_os_desc_table {
  *	GetStatus() request when the recipient is Interface.
  * @func_suspend: callback to be called when
  *	SetFeature(FUNCTION_SUSPEND) is reseived
+ * @func_suspended: Indicates whether the function is in function suspend state.
+ * @func_rw_armed: Indicates whether the function is armed by the host for
+ *	wakeup signaling.
  *
  * A single USB function uses one or more interfaces, and should in most
  * cases support operation at both full and high speeds.  Each function is
@@ -220,6 +223,8 @@ struct usb_function {
 	int			(*get_status)(struct usb_function *);
 	int			(*func_suspend)(struct usb_function *,
 						u8 suspend_opt);
+	bool			func_suspended;
+	bool			func_rw_armed;
 	/* private: */
 	/* internals */
 	struct list_head		list;
@@ -241,6 +246,7 @@ int config_ep_by_speed_and_alt(struct usb_gadget *g, struct usb_function *f,
 
 int config_ep_by_speed(struct usb_gadget *g, struct usb_function *f,
 			struct usb_ep *_ep);
+int usb_func_wakeup(struct usb_function *func);
 
 #define	MAX_CONFIG_INTERFACES		16	/* arbitrary; max 255 */
 
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 05d1449..1e73943 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -309,6 +309,7 @@ struct usb_udc;
 struct usb_gadget_ops {
 	int	(*get_frame)(struct usb_gadget *);
 	int	(*wakeup)(struct usb_gadget *);
+	int     (*func_wakeup)(struct usb_gadget *gadget, int intf_id);
 	int	(*set_remotewakeup)(struct usb_gadget *, int set);
 	int	(*set_selfpowered) (struct usb_gadget *, int is_selfpowered);
 	int	(*vbus_session) (struct usb_gadget *, int is_active);
@@ -616,6 +617,7 @@ int usb_gadget_disconnect(struct usb_gadget *gadget);
 int usb_gadget_deactivate(struct usb_gadget *gadget);
 int usb_gadget_activate(struct usb_gadget *gadget);
 int usb_gadget_check_config(struct usb_gadget *gadget);
+int usb_gadget_func_wakeup(struct usb_gadget *gadget, int intf_id);
 #else
 static inline int usb_gadget_frame_number(struct usb_gadget *gadget)
 { return 0; }
@@ -643,6 +645,8 @@ static inline int usb_gadget_activate(struct usb_gadget *gadget)
 { return 0; }
 static inline int usb_gadget_check_config(struct usb_gadget *gadget)
 { return 0; }
+static inline int usb_gadget_func_wakeup(struct usb_gadget *gadget, int intf_id)
+{ return 0; }
 #endif /* CONFIG_USB_GADGET */
 
 /*-------------------------------------------------------------------------*/
-- 
2.7.4

