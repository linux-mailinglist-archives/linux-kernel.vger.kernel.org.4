Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540C56950BC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjBMTbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjBMTb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:31:29 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2AA5B9A;
        Mon, 13 Feb 2023 11:31:28 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DIjte6000382;
        Mon, 13 Feb 2023 19:31:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=ND5ZYINpZP81d746ljdOgCnx3y1zWD4csgb7aeBMp3E=;
 b=g3PYOI74WIy4fLtbCtoIMTylpzQwFLjhfOQSpCmnEjpQkEnWSdLs7+qWQdIMSw5h1Kuu
 cwvBdoX6f5jM/LDlw7Xx3UnCSKZn0eE16+dxpD9Z0c1sto2dFMCPhovPa/5XmoozP1+m
 WKyUwchikhkdv70frw6bVH7SlPqZF9Z3O6lTMej1/fibBh+KqT9VIT60emah9y8E3y+i
 6/pN9w/n5uY54+kZJ/LfRFw6lKzAjsyF02TymLjuo0YrJwNhHG3Vv2tsmhdCJs5uTKCo
 ces07GM3oTMV+sI43sk7Ec9i/glMpR8Y24CCpHTY7xCqtAstsYlLlmSjVwMP2piA7d9Y xw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3np0cw5c9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 19:31:23 +0000
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 31DJVMdZ024203;
        Mon, 13 Feb 2023 19:31:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA05.qualcomm.com (PPS) with ESMTP id 3np43kk3wc-1;
        Mon, 13 Feb 2023 19:31:22 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31DJVMrK024183;
        Mon, 13 Feb 2023 19:31:22 GMT
Received: from hu-devc-lv-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.164])
        by NALASPPMTA05.qualcomm.com (PPS) with ESMTP id 31DJVLiD024179;
        Mon, 13 Feb 2023 19:31:22 +0000
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id 95F2F20E54; Mon, 13 Feb 2023 11:31:21 -0800 (PST)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        balbi@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v4 5/5] usb: gadget: f_ecm: Add suspend/resume and remote wakeup support
Date:   Mon, 13 Feb 2023 11:31:16 -0800
Message-Id: <1676316676-28377-6-git-send-email-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1676316676-28377-1-git-send-email-quic_eserrao@quicinc.com>
References: <1676316676-28377-1-git-send-email-quic_eserrao@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bp-2ROc_Ngh2CxFYBaDsQmKhlwThh0XT
X-Proofpoint-ORIG-GUID: bp-2ROc_Ngh2CxFYBaDsQmKhlwThh0XT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 phishscore=0
 mlxlogscore=902 clxscore=1015 suspectscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130170
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When host sends a suspend notification to the device, handle
the suspend callbacks in the function driver. Enhanced super
speed devices can support function suspend feature to put the
function in suspend state. Handle function suspend callback.

Depending on the remote wakeup capability the device can either
trigger a remote wakeup or wait for the host initiated resume to
start data transfer again.

Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
---
 drivers/usb/gadget/function/f_ecm.c   | 68 +++++++++++++++++++++++++++++++++++
 drivers/usb/gadget/function/u_ether.c | 63 ++++++++++++++++++++++++++++++++
 drivers/usb/gadget/function/u_ether.h |  4 +++
 3 files changed, 135 insertions(+)

diff --git a/drivers/usb/gadget/function/f_ecm.c b/drivers/usb/gadget/function/f_ecm.c
index a7ab30e..d50c1a4 100644
--- a/drivers/usb/gadget/function/f_ecm.c
+++ b/drivers/usb/gadget/function/f_ecm.c
@@ -633,6 +633,8 @@ static void ecm_disable(struct usb_function *f)
 
 	usb_ep_disable(ecm->notify);
 	ecm->notify->desc = NULL;
+	f->func_suspended = false;
+	f->func_wakeup_armed = false;
 }
 
 /*-------------------------------------------------------------------------*/
@@ -885,6 +887,68 @@ static struct usb_function_instance *ecm_alloc_inst(void)
 	return &opts->func_inst;
 }
 
+static void ecm_suspend(struct usb_function *f)
+{
+	struct f_ecm *ecm = func_to_ecm(f);
+	struct usb_composite_dev *cdev = ecm->port.func.config->cdev;
+
+	if (f->func_suspended) {
+		DBG(cdev, "Function already suspended\n");
+		return;
+	}
+
+	DBG(cdev, "ECM Suspend\n");
+
+	gether_suspend(&ecm->port);
+}
+
+static void ecm_resume(struct usb_function *f)
+{
+	struct f_ecm *ecm = func_to_ecm(f);
+	struct usb_composite_dev *cdev = ecm->port.func.config->cdev;
+
+	/*
+	 * If the function is in USB3 Function Suspend state, resume is
+	 * canceled. In this case resume is done by a Function Resume request.
+	 */
+	if (f->func_suspended)
+		return;
+
+	DBG(cdev, "ECM Resume\n");
+
+	gether_resume(&ecm->port);
+}
+
+static int ecm_get_status(struct usb_function *f)
+{
+	return (f->func_wakeup_armed ? USB_INTRF_STAT_FUNC_RW : 0) |
+		USB_INTRF_STAT_FUNC_RW_CAP;
+}
+
+static int ecm_func_suspend(struct usb_function *f, u8 options)
+{
+	struct f_ecm *ecm = func_to_ecm(f);
+	struct usb_composite_dev *cdev = ecm->port.func.config->cdev;
+
+	DBG(cdev, "func susp %u cmd\n", options);
+
+	f->func_wakeup_armed = !!(options & (USB_INTRF_FUNC_SUSPEND_RW >> 8));
+
+	if (options & (USB_INTRF_FUNC_SUSPEND_LP >> 8)) {
+		if (!f->func_suspended) {
+			ecm_suspend(f);
+			f->func_suspended = true;
+		}
+	} else {
+		if (f->func_suspended) {
+			f->func_suspended = false;
+			ecm_resume(f);
+		}
+	}
+
+	return 0;
+}
+
 static void ecm_free(struct usb_function *f)
 {
 	struct f_ecm *ecm;
@@ -952,6 +1016,10 @@ static struct usb_function *ecm_alloc(struct usb_function_instance *fi)
 	ecm->port.func.setup = ecm_setup;
 	ecm->port.func.disable = ecm_disable;
 	ecm->port.func.free_func = ecm_free;
+	ecm->port.func.suspend = ecm_suspend;
+	ecm->port.func.get_status = ecm_get_status;
+	ecm->port.func.func_suspend = ecm_func_suspend;
+	ecm->port.func.resume = ecm_resume;
 
 	return &ecm->port.func;
 }
diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 8f12f3f..4e54089 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -471,6 +471,20 @@ static inline int is_promisc(u16 cdc_filter)
 	return cdc_filter & USB_CDC_PACKET_TYPE_PROMISCUOUS;
 }
 
+static int ether_wakeup_host(struct gether *port)
+{
+	int			ret;
+	struct usb_function	*func = &port->func;
+	struct usb_gadget	*gadget = func->config->cdev->gadget;
+
+	if (func->func_suspended)
+		ret = usb_func_wakeup(func);
+	else
+		ret = usb_gadget_wakeup(gadget);
+
+	return ret;
+}
+
 static netdev_tx_t eth_start_xmit(struct sk_buff *skb,
 					struct net_device *net)
 {
@@ -490,6 +504,15 @@ static netdev_tx_t eth_start_xmit(struct sk_buff *skb,
 		in = NULL;
 		cdc_filter = 0;
 	}
+
+	if (dev->port_usb->is_suspend) {
+		DBG(dev, "Port suspended. Triggering wakeup\n");
+		netif_stop_queue(net);
+		spin_unlock_irqrestore(&dev->lock, flags);
+		ether_wakeup_host(dev->port_usb);
+		return NETDEV_TX_BUSY;
+	}
+
 	spin_unlock_irqrestore(&dev->lock, flags);
 
 	if (!in) {
@@ -1046,6 +1069,45 @@ int gether_set_ifname(struct net_device *net, const char *name, int len)
 }
 EXPORT_SYMBOL_GPL(gether_set_ifname);
 
+void gether_suspend(struct gether *link)
+{
+	struct eth_dev *dev = link->ioport;
+	unsigned long flags;
+
+	if (!dev)
+		return;
+
+	if (atomic_read(&dev->tx_qlen)) {
+		/*
+		 * There is a transfer in progress. So we trigger a remote
+		 * wakeup to inform the host.
+		 */
+		ether_wakeup_host(dev->port_usb);
+		return;
+	}
+	spin_lock_irqsave(&dev->lock, flags);
+	link->is_suspend = true;
+	spin_unlock_irqrestore(&dev->lock, flags);
+}
+EXPORT_SYMBOL_GPL(gether_suspend);
+
+void gether_resume(struct gether *link)
+{
+	struct eth_dev *dev = link->ioport;
+	unsigned long flags;
+
+	if (!dev)
+		return;
+
+	if (netif_queue_stopped(dev->net))
+		netif_start_queue(dev->net);
+
+	spin_lock_irqsave(&dev->lock, flags);
+	link->is_suspend = false;
+	spin_unlock_irqrestore(&dev->lock, flags);
+}
+EXPORT_SYMBOL_GPL(gether_resume);
+
 /*
  * gether_cleanup - remove Ethernet-over-USB device
  * Context: may sleep
@@ -1208,6 +1270,7 @@ void gether_disconnect(struct gether *link)
 
 	spin_lock(&dev->lock);
 	dev->port_usb = NULL;
+	link->is_suspend = false;
 	spin_unlock(&dev->lock);
 }
 EXPORT_SYMBOL_GPL(gether_disconnect);
diff --git a/drivers/usb/gadget/function/u_ether.h b/drivers/usb/gadget/function/u_ether.h
index 4014454..851ee10 100644
--- a/drivers/usb/gadget/function/u_ether.h
+++ b/drivers/usb/gadget/function/u_ether.h
@@ -79,6 +79,7 @@ struct gether {
 	/* called on network open/close */
 	void				(*open)(struct gether *);
 	void				(*close)(struct gether *);
+	bool				is_suspend;
 };
 
 #define	DEFAULT_FILTER	(USB_CDC_PACKET_TYPE_BROADCAST \
@@ -258,6 +259,9 @@ int gether_set_ifname(struct net_device *net, const char *name, int len);
 
 void gether_cleanup(struct eth_dev *dev);
 
+void gether_suspend(struct gether *link);
+void gether_resume(struct gether *link);
+
 /* connect/disconnect is handled by individual functions */
 struct net_device *gether_connect(struct gether *);
 void gether_disconnect(struct gether *);
-- 
2.7.4

