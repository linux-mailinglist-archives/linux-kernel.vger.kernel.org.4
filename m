Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3D06BC1FE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 01:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjCPACL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 20:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbjCPACI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 20:02:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8681241E1;
        Wed, 15 Mar 2023 17:02:00 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FMZ4hV021412;
        Thu, 16 Mar 2023 00:01:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=i0XJRS5q6hBPStYCsWrDNHvg1jTjLpcHlCzKYJqObk4=;
 b=NcMdZLMhhcXkrb0TEDhMDtWzy9XThBVF16T4Y87MWqsBPEkhyYvMIDeYwze5532yCzIz
 K5I4no7Wu1M2G27ERJ0dsfQTU4ETrzzNUyR9J1ALiiMGvc0GMtV/sGALhRuCOam5AmT0
 TXkDdCfehbBOCuG/Qp9+cgzcjH/QuBUTonzqzop7R+45JymxWEYtpIYCXjyGqXhFrGUV
 6nmiTHLfyF35v8cbmdGNR1Pebkyn11Lp6aKEacQOVQtX5I7egcBryVFo3KyrW5T6ZuOL
 m4UCSB3QxCNIziKjWzAsWiZFcFoZjVFtskw7FcrXHoTsgTIqOFdRDNh7WNJHRA15A/dH xg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pbpxjr5a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 00:01:56 +0000
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32FNwCC3027497;
        Thu, 16 Mar 2023 00:01:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA05.qualcomm.com (PPS) with ESMTP id 3pbpyt8a2y-1;
        Thu, 16 Mar 2023 00:01:56 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32FNwiXC028091;
        Thu, 16 Mar 2023 00:01:55 GMT
Received: from hu-devc-lv-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.164])
        by NALASPPMTA05.qualcomm.com (PPS) with ESMTP id 32G01tEi000728;
        Thu, 16 Mar 2023 00:01:55 +0000
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id 9F6F920E56; Wed, 15 Mar 2023 17:01:55 -0700 (PDT)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        balbi@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v11 3/5] usb: gadget: Add function wakeup support
Date:   Wed, 15 Mar 2023 17:01:51 -0700
Message-Id: <1678924913-9364-4-git-send-email-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1678924913-9364-1-git-send-email-quic_eserrao@quicinc.com>
References: <1678924913-9364-1-git-send-email-quic_eserrao@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SkCzLkQLaRYGUH10m5jO7dlCcuOdPp3U
X-Proofpoint-ORIG-GUID: SkCzLkQLaRYGUH10m5jO7dlCcuOdPp3U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_12,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=482 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303150002 definitions=main-2303150196
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

