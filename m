Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637226B8063
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjCMSZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjCMSZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:25:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E92C22C92;
        Mon, 13 Mar 2023 11:25:08 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DGaJRN024714;
        Mon, 13 Mar 2023 18:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=EAMc2pVxLD4JP1bC2VZAqSNIZJkmle3yQvaqUA+t3GY=;
 b=V0CJabqZ79TFq+msTUw/ZrP7TC954NFhNENaYqDGrtiPGnStAvNo0JYW9VCi+8XfqPdP
 qOy/gg6Ammx26pBG8yofYtY/enQNP72d2l0tSC4DZ7Ilu4brb0Q8ZXGcGhuwBpU4LqNZ
 FxKP08c6ZaxsJ+mQd+ulzbTBMVqnKABl94HIWDZZuaWFCT3nCF402GbK7aajNCSuQuXw
 A+fH2CPKWcswRT9SgvCBHS5ISX8wjH7nRIrcpX3C26vpvKrrmFWYSTvTtsKISS5TzUTw
 mXZbg0cVpMBoJXssO+peMKGQ5lolUmkAAyVIaXNUyur9Sjs31jm0VOXtHPVHMgiCxeO7 Ew== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p8gyswpuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 18:25:02 +0000
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32DIO2Pj016607;
        Mon, 13 Mar 2023 18:25:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA05.qualcomm.com (PPS) with ESMTP id 3p8jqkmdud-1;
        Mon, 13 Mar 2023 18:25:01 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32DIP1kH017499;
        Mon, 13 Mar 2023 18:25:01 GMT
Received: from hu-devc-lv-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.164])
        by NALASPPMTA05.qualcomm.com (PPS) with ESMTP id 32DIP1Vc017494;
        Mon, 13 Mar 2023 18:25:01 +0000
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id 0763720D8E; Mon, 13 Mar 2023 11:25:01 -0700 (PDT)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        balbi@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v8 1/5] usb: gadget: Properly configure the device for remote wakeup
Date:   Mon, 13 Mar 2023 11:24:48 -0700
Message-Id: <1678731892-20503-2-git-send-email-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1678731892-20503-1-git-send-email-quic_eserrao@quicinc.com>
References: <1678731892-20503-1-git-send-email-quic_eserrao@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nNpgt2jsorampAi3UFjFT25Cc_X0_A9e
X-Proofpoint-ORIG-GUID: nNpgt2jsorampAi3UFjFT25Cc_X0_A9e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_09,2023-03-13_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=819 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303130143
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

Reviewed-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
---
 drivers/usb/gadget/composite.c | 18 ++++++++++++++++++
 drivers/usb/gadget/configfs.c  |  3 +++
 drivers/usb/gadget/udc/core.c  | 27 +++++++++++++++++++++++++++
 drivers/usb/gadget/udc/trace.h |  5 +++++
 include/linux/usb/composite.h  |  2 ++
 include/linux/usb/gadget.h     |  8 ++++++++
 6 files changed, 63 insertions(+)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 36add18..c9c983e 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -513,6 +513,19 @@ static u8 encode_bMaxPower(enum usb_device_speed speed,
 		return min(val, 900U) / 8;
 }
 
+void check_remote_wakeup_config(struct usb_gadget *g,
+				struct usb_configuration *c)
+{
+	if (USB_CONFIG_ATT_WAKEUP & c->bmAttributes) {
+		/* Reset the rw bit if gadget is not capable of it */
+		if (!g->wakeup_capable && g->ops->set_remote_wakeup) {
+			WARN(c->cdev, "Clearing wakeup bit for config c.%d\n",
+			     c->bConfigurationValue);
+			c->bmAttributes &= ~USB_CONFIG_ATT_WAKEUP;
+		}
+	}
+}
+
 static int config_buf(struct usb_configuration *config,
 		enum usb_device_speed speed, void *buf, u8 type)
 {
@@ -994,6 +1007,11 @@ static int set_config(struct usb_composite_dev *cdev,
 		power = min(power, 500U);
 	else
 		power = min(power, 900U);
+
+	if (USB_CONFIG_ATT_WAKEUP & c->bmAttributes)
+		usb_gadget_set_remote_wakeup(gadget, 1);
+	else
+		usb_gadget_set_remote_wakeup(gadget, 0);
 done:
 	if (power <= USB_SELF_POWER_VBUS_MAX_DRAW)
 		usb_gadget_set_selfpowered(gadget);
diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index b9f1136..4c639e9 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -1761,6 +1761,9 @@ static int configfs_composite_bind(struct usb_gadget *gadget,
 		if (gadget_is_otg(gadget))
 			c->descriptors = otg_desc;
 
+		/* Properly configure the bmAttributes wakeup bit */
+		check_remote_wakeup_config(gadget, c);
+
 		cfg = container_of(c, struct config_usb_cfg, c);
 		if (!list_empty(&cfg->string_list)) {
 			i = 0;
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 23b0629..3dcbba7 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -514,6 +514,33 @@ int usb_gadget_wakeup(struct usb_gadget *gadget)
 EXPORT_SYMBOL_GPL(usb_gadget_wakeup);
 
 /**
+ * usb_gadget_set_remote_wakeup - configures the device remote wakeup feature.
+ * @gadget:the device being configured for remote wakeup
+ * @set:value to be configured.
+ *
+ * set to one to enable remote wakeup feature and zero to disable it.
+ *
+ * returns zero on success, else negative errno.
+ */
+int usb_gadget_set_remote_wakeup(struct usb_gadget *gadget, int set)
+{
+	int ret = 0;
+
+	if (!gadget->ops->set_remote_wakeup) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	ret = gadget->ops->set_remote_wakeup(gadget, set);
+
+out:
+	trace_usb_gadget_set_remote_wakeup(gadget, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_set_remote_wakeup);
+
+/**
  * usb_gadget_set_selfpowered - sets the device selfpowered feature.
  * @gadget:the device being declared as self-powered
  *
diff --git a/drivers/usb/gadget/udc/trace.h b/drivers/usb/gadget/udc/trace.h
index abdbcb1..a5ed26f 100644
--- a/drivers/usb/gadget/udc/trace.h
+++ b/drivers/usb/gadget/udc/trace.h
@@ -91,6 +91,11 @@ DEFINE_EVENT(udc_log_gadget, usb_gadget_wakeup,
 	TP_ARGS(g, ret)
 );
 
+DEFINE_EVENT(udc_log_gadget, usb_gadget_set_remote_wakeup,
+	TP_PROTO(struct usb_gadget *g, int ret),
+	TP_ARGS(g, ret)
+);
+
 DEFINE_EVENT(udc_log_gadget, usb_gadget_set_selfpowered,
 	TP_PROTO(struct usb_gadget *g, int ret),
 	TP_ARGS(g, ret)
diff --git a/include/linux/usb/composite.h b/include/linux/usb/composite.h
index 608dc96..d949e91 100644
--- a/include/linux/usb/composite.h
+++ b/include/linux/usb/composite.h
@@ -413,6 +413,8 @@ extern int composite_dev_prepare(struct usb_composite_driver *composite,
 extern int composite_os_desc_req_prepare(struct usb_composite_dev *cdev,
 					 struct usb_ep *ep0);
 void composite_dev_cleanup(struct usb_composite_dev *cdev);
+void check_remote_wakeup_config(struct usb_gadget *g,
+				struct usb_configuration *c);
 
 static inline struct usb_composite_driver *to_cdriver(
 		struct usb_gadget_driver *gdrv)
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 00750f7..1d79612 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -310,6 +310,7 @@ struct usb_udc;
 struct usb_gadget_ops {
 	int	(*get_frame)(struct usb_gadget *);
 	int	(*wakeup)(struct usb_gadget *);
+	int	(*set_remote_wakeup)(struct usb_gadget *, int set);
 	int	(*set_selfpowered) (struct usb_gadget *, int is_selfpowered);
 	int	(*vbus_session) (struct usb_gadget *, int is_active);
 	int	(*vbus_draw) (struct usb_gadget *, unsigned mA);
@@ -384,6 +385,8 @@ struct usb_gadget_ops {
  * @connected: True if gadget is connected.
  * @lpm_capable: If the gadget max_speed is FULL or HIGH, this flag
  *	indicates that it supports LPM as per the LPM ECN & errata.
+ * @wakeup_capable: True if gadget is capable of sending remote wakeup.
+ * @wakeup_armed: True if gadget is armed by the host for remote wakeup.
  * @irq: the interrupt number for device controller.
  * @id_number: a unique ID number for ensuring that gadget names are distinct
  *
@@ -445,6 +448,8 @@ struct usb_gadget {
 	unsigned			deactivated:1;
 	unsigned			connected:1;
 	unsigned			lpm_capable:1;
+	unsigned			wakeup_capable:1;
+	unsigned			wakeup_armed:1;
 	int				irq;
 	int				id_number;
 };
@@ -601,6 +606,7 @@ static inline int gadget_is_otg(struct usb_gadget *g)
 #if IS_ENABLED(CONFIG_USB_GADGET)
 int usb_gadget_frame_number(struct usb_gadget *gadget);
 int usb_gadget_wakeup(struct usb_gadget *gadget);
+int usb_gadget_set_remote_wakeup(struct usb_gadget *gadget, int set);
 int usb_gadget_set_selfpowered(struct usb_gadget *gadget);
 int usb_gadget_clear_selfpowered(struct usb_gadget *gadget);
 int usb_gadget_vbus_connect(struct usb_gadget *gadget);
@@ -616,6 +622,8 @@ static inline int usb_gadget_frame_number(struct usb_gadget *gadget)
 { return 0; }
 static inline int usb_gadget_wakeup(struct usb_gadget *gadget)
 { return 0; }
+static inline int usb_gadget_set_remote_wakeup(struct usb_gadget *gadget, int set)
+{ return 0; }
 static inline int usb_gadget_set_selfpowered(struct usb_gadget *gadget)
 { return 0; }
 static inline int usb_gadget_clear_selfpowered(struct usb_gadget *gadget)
-- 
2.7.4

