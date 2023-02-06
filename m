Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0044E68C682
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjBFTNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBFTNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:13:43 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C3220D18;
        Mon,  6 Feb 2023 11:13:42 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316Gg22d031706;
        Mon, 6 Feb 2023 19:13:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=fktbampqwJFPXzZdkvnSuFfkoSZAmrk2w2kwqJ22yGo=;
 b=Z0ct5m+9rDcMub9fm1S4RZdFExILTA0O34afnz9CMjqptidLxAH/BiU4RMzxESUfU5f4
 KKTJIOyJfQmOMVEgRw1MAiS89FoKkMALcUxxX0/VRiWJL3jg7Od9GLj6gq4CaK154W83
 tlB0wV2tUuOInEYnYztpBgpfr2+qTV2tGx5ZrRNrCw9zUPdKj0YSU69Wxexq6CvfrE60
 UlBfLs4oObT20uo//kaqBf0e2/5RomuGc+wgETsCzk/VIyT8EeWjK26iKQ5YfboCZxzN
 SNFPMTSxxtvksbUZKoqeha+yZF919DbCWRPVsPZRN1VoHt9I719iN/9cc/Reepk8Ny6l Dg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nhey74hr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 19:13:35 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 316JDYBM018003;
        Mon, 6 Feb 2023 19:13:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTP id 3nhgem2v2h-1;
        Mon, 06 Feb 2023 19:13:34 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 316JDYqb017992;
        Mon, 6 Feb 2023 19:13:34 GMT
Received: from hu-devc-lv-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.164])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTP id 316JDXPL017987;
        Mon, 06 Feb 2023 19:13:34 +0000
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id E8BA920340; Mon,  6 Feb 2023 11:13:33 -0800 (PST)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        balbi@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v3 1/5] usb: gadget: Properly configure the device for remote wakeup
Date:   Mon,  6 Feb 2023 11:13:22 -0800
Message-Id: <1675710806-9735-2-git-send-email-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1675710806-9735-1-git-send-email-quic_eserrao@quicinc.com>
References: <1675710806-9735-1-git-send-email-quic_eserrao@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uSveIcUz8hnhoZss8nGrhGm3mF7WHZ4S
X-Proofpoint-GUID: uSveIcUz8hnhoZss8nGrhGm3mF7WHZ4S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=714 priorityscore=1501 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060167
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wakeup bit in the bmAttributes field indicates whether the device
is configured for remote wakeup. But this field should be allowed to
set only if the UDC supports such wakeup mechanism. So configure this
field based on UDC capability. Also inform the UDC whether the device
is configured for remote wakeup by implementing a gadget op.

Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
---
 drivers/usb/gadget/composite.c | 24 +++++++++++++++++++++++-
 drivers/usb/gadget/udc/core.c  | 27 +++++++++++++++++++++++++++
 drivers/usb/gadget/udc/trace.h |  5 +++++
 include/linux/usb/gadget.h     |  8 ++++++++
 4 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index fa7dd6c..e459fb0 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -513,6 +513,19 @@ static u8 encode_bMaxPower(enum usb_device_speed speed,
 		return min(val, 900U) / 8;
 }
 
+static void check_remote_wakeup_config(struct usb_gadget *gadget,
+				       struct usb_configuration *c)
+{
+	if (USB_CONFIG_ATT_WAKEUP & c->bmAttributes) {
+		/* Reset the rw bit if gadget is not capable of it */
+		if (!gadget->rw_capable) {
+			INFO(c->cdev, "Clearing rw bit for config c.%d\n",
+			     c->bConfigurationValue);
+			c->bmAttributes &= ~USB_CONFIG_ATT_WAKEUP;
+		}
+	}
+}
+
 static int config_buf(struct usb_configuration *config,
 		enum usb_device_speed speed, void *buf, u8 type)
 {
@@ -620,8 +633,12 @@ static int config_desc(struct usb_composite_dev *cdev, unsigned w_value)
 				continue;
 		}
 
-		if (w_value == 0)
+		if (w_value == 0) {
+			/* Correctly configure the bmAttributes wakeup bit */
+			check_remote_wakeup_config(gadget, c);
+
 			return config_buf(c, speed, cdev->req->buf, type);
+		}
 		w_value--;
 	}
 	return -EINVAL;
@@ -1000,6 +1017,11 @@ static int set_config(struct usb_composite_dev *cdev,
 	else
 		usb_gadget_clear_selfpowered(gadget);
 
+	if (USB_CONFIG_ATT_WAKEUP & c->bmAttributes)
+		usb_gadget_set_remotewakeup(gadget, 1);
+	else
+		usb_gadget_set_remotewakeup(gadget, 0);
+
 	usb_gadget_vbus_draw(gadget, power);
 	if (result >= 0 && cdev->delayed_status)
 		result = USB_GADGET_DELAYED_STATUS;
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 23b0629..5874d4f 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -514,6 +514,33 @@ int usb_gadget_wakeup(struct usb_gadget *gadget)
 EXPORT_SYMBOL_GPL(usb_gadget_wakeup);
 
 /**
+ * usb_gadget_set_remotewakeup - configures the device remote wakeup feature.
+ * @gadget:the device being configured for remote wakeup
+ * @set:value to be configured.
+ *
+ * set to one to enable remote wakeup feature and zero to disable it.
+ *
+ * returns zero on success, else negative errno.
+ */
+int usb_gadget_set_remotewakeup(struct usb_gadget *gadget, int set)
+{
+	int ret = 0;
+
+	if (!gadget->ops->set_remotewakeup) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	ret = gadget->ops->set_remotewakeup(gadget, set);
+
+out:
+	trace_usb_gadget_set_remotewakeup(gadget, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_set_remotewakeup);
+
+/**
  * usb_gadget_set_selfpowered - sets the device selfpowered feature.
  * @gadget:the device being declared as self-powered
  *
diff --git a/drivers/usb/gadget/udc/trace.h b/drivers/usb/gadget/udc/trace.h
index abdbcb1..a3314ce 100644
--- a/drivers/usb/gadget/udc/trace.h
+++ b/drivers/usb/gadget/udc/trace.h
@@ -91,6 +91,11 @@ DEFINE_EVENT(udc_log_gadget, usb_gadget_wakeup,
 	TP_ARGS(g, ret)
 );
 
+DEFINE_EVENT(udc_log_gadget, usb_gadget_set_remotewakeup,
+	TP_PROTO(struct usb_gadget *g, int ret),
+	TP_ARGS(g, ret)
+);
+
 DEFINE_EVENT(udc_log_gadget, usb_gadget_set_selfpowered,
 	TP_PROTO(struct usb_gadget *g, int ret),
 	TP_ARGS(g, ret)
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index dc3092c..05d1449 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -309,6 +309,7 @@ struct usb_udc;
 struct usb_gadget_ops {
 	int	(*get_frame)(struct usb_gadget *);
 	int	(*wakeup)(struct usb_gadget *);
+	int	(*set_remotewakeup)(struct usb_gadget *, int set);
 	int	(*set_selfpowered) (struct usb_gadget *, int is_selfpowered);
 	int	(*vbus_session) (struct usb_gadget *, int is_active);
 	int	(*vbus_draw) (struct usb_gadget *, unsigned mA);
@@ -383,6 +384,8 @@ struct usb_gadget_ops {
  * @connected: True if gadget is connected.
  * @lpm_capable: If the gadget max_speed is FULL or HIGH, this flag
  *	indicates that it supports LPM as per the LPM ECN & errata.
+ * @rw_capable: True if gadget is capable of sending remote wakeup.
+ * @rw_armed: True if gadget is armed by the host for remote wakeup.
  * @irq: the interrupt number for device controller.
  * @id_number: a unique ID number for ensuring that gadget names are distinct
  *
@@ -444,6 +447,8 @@ struct usb_gadget {
 	unsigned			deactivated:1;
 	unsigned			connected:1;
 	unsigned			lpm_capable:1;
+	unsigned			rw_capable:1;
+	unsigned			rw_armed:1;
 	int				irq;
 	int				id_number;
 };
@@ -600,6 +605,7 @@ static inline int gadget_is_otg(struct usb_gadget *g)
 #if IS_ENABLED(CONFIG_USB_GADGET)
 int usb_gadget_frame_number(struct usb_gadget *gadget);
 int usb_gadget_wakeup(struct usb_gadget *gadget);
+int usb_gadget_set_remotewakeup(struct usb_gadget *gadget, int set);
 int usb_gadget_set_selfpowered(struct usb_gadget *gadget);
 int usb_gadget_clear_selfpowered(struct usb_gadget *gadget);
 int usb_gadget_vbus_connect(struct usb_gadget *gadget);
@@ -615,6 +621,8 @@ static inline int usb_gadget_frame_number(struct usb_gadget *gadget)
 { return 0; }
 static inline int usb_gadget_wakeup(struct usb_gadget *gadget)
 { return 0; }
+static inline int usb_gadget_set_remotewakeup(struct usb_gadget *gadget, int set)
+{ return 0; }
 static inline int usb_gadget_set_selfpowered(struct usb_gadget *gadget)
 { return 0; }
 static inline int usb_gadget_clear_selfpowered(struct usb_gadget *gadget)
-- 
2.7.4

