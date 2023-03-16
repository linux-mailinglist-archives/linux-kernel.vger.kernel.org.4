Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2966BC204
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 01:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjCPACS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 20:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbjCPACJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 20:02:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D66E25BA5;
        Wed, 15 Mar 2023 17:02:01 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FMZYQc024954;
        Thu, 16 Mar 2023 00:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=/7RwWkL74gNXqelqf9geipBiQ3ydvV35sx37F8aBTts=;
 b=l0MgokeRoedikZR4JVdjw2vrTFUvtTVC+qZIEIyPjgThW0Jdp8UDBO7FL/iHBeQwy+Zs
 0FgXTxUkSKGsrU5wdJBjQVp0Z6tgIsN3vycw3PpzZlJ4jD+hU+Zp6/CBS0JRgbhEq+1X
 Rjg5Hq90Aa+t8lYjrF8kjw+Vh+pJ3ZfZes1aqVXS2Vly63plIhQadpuSIjlrVwLK6onZ
 QRhaETzQZbR+3aj0xTvYrDqqw0XrV66P0sYgBsnpYqjTXp+9eYLYb3cUfu5aiX1MLpAS
 2ZbdFXpHOVoAZ/5k2AaONXZTwqqQNy9U0FZ3yuYV4yEAV0dS5wxZA8kbt8hv3iZdMRNR VQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pbpxsg5eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 00:01:56 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32G003mO025372;
        Thu, 16 Mar 2023 00:01:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTP id 3p8jqm35p2-1;
        Thu, 16 Mar 2023 00:01:56 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32G00BFW025690;
        Thu, 16 Mar 2023 00:01:56 GMT
Received: from hu-devc-lv-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.164])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTP id 32G01tpf029413;
        Thu, 16 Mar 2023 00:01:56 +0000
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id A3E5320E5A; Wed, 15 Mar 2023 17:01:55 -0700 (PDT)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        balbi@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v11 5/5] usb: gadget: f_ecm: Add suspend/resume and remote wakeup support
Date:   Wed, 15 Mar 2023 17:01:53 -0700
Message-Id: <1678924913-9364-6-git-send-email-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1678924913-9364-1-git-send-email-quic_eserrao@quicinc.com>
References: <1678924913-9364-1-git-send-email-quic_eserrao@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _Y2wBxjD7kR0Knoff8O7t75Ia9rhDDe7
X-Proofpoint-ORIG-GUID: _Y2wBxjD7kR0Knoff8O7t75Ia9rhDDe7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_12,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 mlxscore=0 mlxlogscore=979 suspectscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303150196
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/usb/gadget/function/f_ecm.c   | 80 +++++++++++++++++++++++++++++++++++
 drivers/usb/gadget/function/u_ether.c | 63 +++++++++++++++++++++++++++
 drivers/usb/gadget/function/u_ether.h |  4 ++
 3 files changed, 147 insertions(+)

diff --git a/drivers/usb/gadget/function/f_ecm.c b/drivers/usb/gadget/function/f_ecm.c
index a7ab30e..d0e30e8 100644
--- a/drivers/usb/gadget/function/f_ecm.c
+++ b/drivers/usb/gadget/function/f_ecm.c
@@ -633,6 +633,8 @@ static void ecm_disable(struct usb_function *f)
 
 	usb_ep_disable(ecm->notify);
 	ecm->notify->desc = NULL;
+	f->func_suspended = false;
+	f->func_wakeup_armed = false;
 }
 
 /*-------------------------------------------------------------------------*/
@@ -885,6 +887,80 @@ static struct usb_function_instance *ecm_alloc_inst(void)
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
+	struct usb_configuration *c = f->config;
+
+	/* D0 and D1 bit set to 0 if device is not wakeup capable */
+	if (!(USB_CONFIG_ATT_WAKEUP & c->bmAttributes))
+		return 0;
+
+	return (f->func_wakeup_armed ? USB_INTRF_STAT_FUNC_RW : 0) |
+		USB_INTRF_STAT_FUNC_RW_CAP;
+}
+
+static int ecm_func_suspend(struct usb_function *f, u8 options)
+{
+	struct usb_configuration *c = f->config;
+	bool wakeup_sel;
+
+	DBG(c->cdev, "func susp %u cmd\n", options);
+
+	wakeup_sel = !!(options & (USB_INTRF_FUNC_SUSPEND_RW >> 8));
+
+	/* Respond with negative errno if request is not supported */
+	if (wakeup_sel && !(USB_CONFIG_ATT_WAKEUP & c->bmAttributes))
+		return -EINVAL;
+
+	f->func_wakeup_armed = wakeup_sel;
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
@@ -952,6 +1028,10 @@ static struct usb_function *ecm_alloc(struct usb_function_instance *fi)
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
index f259975..8eba018 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -437,6 +437,20 @@ static inline int is_promisc(u16 cdc_filter)
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
@@ -456,6 +470,15 @@ static netdev_tx_t eth_start_xmit(struct sk_buff *skb,
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
@@ -1014,6 +1037,45 @@ int gether_set_ifname(struct net_device *net, const char *name, int len)
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
@@ -1176,6 +1238,7 @@ void gether_disconnect(struct gether *link)
 
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

