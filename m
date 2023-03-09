Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751926B2EA4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 21:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjCIUZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 15:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjCIUZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 15:25:08 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1D9E485C;
        Thu,  9 Mar 2023 12:25:07 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329IXaZD018183;
        Thu, 9 Mar 2023 20:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=fLxPF8eCKppWTaLwryyhSnKF0mhre4/Id5PxFMHvSGE=;
 b=QgBQUXS60aTbVcqm8HhgAwOn8QUDVHm3PBL2brOflGJKk06aSDd8Eg2eilMjp+QUy5te
 VK0Umpyyi+95CuGsJbjz0gKA5o0ZgW8I8cpwDyMpZz4FcCeQ7G8WyeSNeunE0Wrcxqj9
 NyE/S5oNn7+fjkhD0Ef7bxNBR5Pn5lDZhnqvqCsdx92uPoIUbUCpYwoZAC5ZpZzKN0J1
 rRpTRTUgf3hzqltrD0bhOg6UgUuhLseOXJqSoNF2LEoh0VAHrDNRYr3hC+Y1ck9CHCp3
 2iDQPKx7f2V+b+U1uZxpSh2rTj31HJ5Aafd9Eh0md/pZiKT6/RSEMwJzmYCjamXFFJAW uQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p7mgrgcaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 20:25:02 +0000
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 329KP21H008315;
        Thu, 9 Mar 2023 20:25:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 3p4fg0wffp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 09 Mar 2023 20:25:02 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 329KP1Ze008270;
        Thu, 9 Mar 2023 20:25:01 GMT
Received: from hu-devc-lv-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.164])
        by NALASPPMTA02.qualcomm.com (PPS) with ESMTP id 329KP1d7008260;
        Thu, 09 Mar 2023 20:25:01 +0000
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id B2BF220E5C; Thu,  9 Mar 2023 12:25:00 -0800 (PST)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        balbi@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v7 5/5] usb: gadget: f_ecm: Add suspend/resume and remote wakeup support
Date:   Thu,  9 Mar 2023 12:24:59 -0800
Message-Id: <1678393499-7366-6-git-send-email-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1678393499-7366-1-git-send-email-quic_eserrao@quicinc.com>
References: <1678393499-7366-1-git-send-email-quic_eserrao@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ho3RpGHsX7yf299x7e74O3lJMFAq50lv
X-Proofpoint-GUID: Ho3RpGHsX7yf299x7e74O3lJMFAq50lv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_11,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=891 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

