Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B006BA41F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 01:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjCOAj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 20:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjCOAjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 20:39:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C363D559F7;
        Tue, 14 Mar 2023 17:39:51 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32F0VtXb012102;
        Wed, 15 Mar 2023 00:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=i0XJRS5q6hBPStYCsWrDNHvg1jTjLpcHlCzKYJqObk4=;
 b=eG8CVfgxJ+1xG7AE5LTbFW+WY9RswveIBS1AQxB5pr4Y4XvNyVixB5qCbc/YlHzsW9EC
 R/2E8fqiOMCRxjaW/ey7fDp2xsnpbBkNviqC8FxAdwfbRih8zpgG7eDp1M96uyJ6NT/7
 GDpJ/4MwRBMqjhD37CLV+sHgP30PP+PJsa5TR4ENm0EmZtCngeokpJOb5zOOxNiw0faT
 ICeR5apqTThOl0iX5nxRZuoR0RxTrTyoTKtrilpODSy30b+IBe0UrELEmkhxlyHS4AiU
 jM8/KvF0gjLyO2w+e5PKZM+3KwI2f5QNLVrRtciclcObZTfcBdP68xDV7U4Z/mSjEHoC Ng== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pb2by843e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 00:39:46 +0000
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32F0dj3d022423;
        Wed, 15 Mar 2023 00:39:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA02.qualcomm.com (PPS) with ESMTP id 3p8jqkvmt2-1;
        Wed, 15 Mar 2023 00:39:45 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32F0djBq022412;
        Wed, 15 Mar 2023 00:39:45 GMT
Received: from hu-devc-lv-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.164])
        by NALASPPMTA02.qualcomm.com (PPS) with ESMTP id 32F0diYp022410;
        Wed, 15 Mar 2023 00:39:45 +0000
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id E040F20E5D; Tue, 14 Mar 2023 17:39:44 -0700 (PDT)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        balbi@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v9 3/5] usb: gadget: Add function wakeup support
Date:   Tue, 14 Mar 2023 17:39:41 -0700
Message-Id: <1678840783-15472-4-git-send-email-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1678840783-15472-1-git-send-email-quic_eserrao@quicinc.com>
References: <1678840783-15472-1-git-send-email-quic_eserrao@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dqd4QXJX_SHLiP9peXh5ft6DMxZq4hvF
X-Proofpoint-GUID: dqd4QXJX_SHLiP9peXh5ft6DMxZq4hvF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_16,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 adultscore=0 mlxlogscore=476 bulkscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150004
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
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

Reviewed-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
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

