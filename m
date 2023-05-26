Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4D3713023
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 00:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjEZWqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 18:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjEZWqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 18:46:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45E61B0;
        Fri, 26 May 2023 15:46:23 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QLwNMo016962;
        Fri, 26 May 2023 22:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=LhzcFmQ/tZWuAKNPSZOmXL7CX0n1MLK21h/aX4lbNn4=;
 b=mC622wvrC8XvpzpNkqTcl5jsOSyKL7u/zD2VOi5WMwnP+opnJqfETGjxgAiBpbv7HgSK
 l1ase3DafaRt/fDv3836VaGMnfSgQEtF8olNmzmWAV8Ot001Zh1e5CSJdK6nbadEA+Bl
 n/YNUOYMbO05rzZTz2lfMZL30D6To1RlAEQdr+MUJ21CR/roNEcvZTV0IPdwUHjuo7C/
 sCYwU8roZQvd/H2DcNyvXiJ4UTehUOEoknyK8CzlVBhfXmpfj2fK2tPCwVMrzfFJ1+a5
 Blf1JvBUAa6GNmqGWWeBRhmAjtJMcsHT3lhR+G1rOLYZeKJKrmEVATldS6SL0324jLAw bw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qtkxwjff5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 22:46:21 +0000
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34QMjoJI001431;
        Fri, 26 May 2023 22:45:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA01.qualcomm.com (PPS) with ESMTP id 3qtvwvaejw-1;
        Fri, 26 May 2023 22:45:50 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34QMjoJU001418;
        Fri, 26 May 2023 22:45:50 GMT
Received: from hu-devc-lv-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.164])
        by NALASPPMTA01.qualcomm.com (PPS) with ESMTP id 34QMjoNj001323;
        Fri, 26 May 2023 22:45:50 +0000
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id 6C81C20D9B; Fri, 26 May 2023 15:45:50 -0700 (PDT)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v2 1/2] usb: function: u_ether: Handle rx requests during suspend/resume
Date:   Fri, 26 May 2023 15:45:39 -0700
Message-Id: <1685141140-26228-2-git-send-email-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1685141140-26228-1-git-send-email-quic_eserrao@quicinc.com>
References: <1685141140-26228-1-git-send-email-quic_eserrao@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JT2DWwKo6oub9FFnnzqsbLSaPf2uKcP_
X-Proofpoint-ORIG-GUID: JT2DWwKo6oub9FFnnzqsbLSaPf2uKcP_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_12,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305260195
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some UDCs might have a vote against runtime suspend if there is any
request queued by the function driver. This would block the UDC driver
to enter runtime suspend state when the host sends bus suspend
notification. While tx requests get dequeued after completion, rx
requests always remain queued for the next OUT data to be handled. Since
during bus suspend scenario there are no active OUT transfers we can
dequeue these requests when the function driver suspend callback gets
called and queue them back during resume callback. Implement this
mechanism by adding a new list for queued requests.

Also move the gether_wakeup_host API to work queue context to better
align with the remote wakeup op's synchronous operation.

Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
---
 drivers/usb/gadget/function/u_ether.c | 47 ++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 6956ad8..2b85bd4 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -61,7 +61,7 @@ struct eth_dev {
 	struct usb_gadget	*gadget;
 
 	spinlock_t		req_lock;	/* guard {rx,tx}_reqs */
-	struct list_head	tx_reqs, rx_reqs;
+	struct list_head	tx_reqs, rx_reqs, rx_queued_reqs;
 	atomic_t		tx_qlen;
 
 	struct sk_buff_head	rx_frames;
@@ -74,7 +74,7 @@ struct eth_dev {
 						struct sk_buff *skb,
 						struct sk_buff_head *list);
 
-	struct work_struct	work;
+	struct work_struct	work, wakeup_work;
 
 	unsigned long		todo;
 #define	WORK_RX_MEMORY		0
@@ -212,7 +212,7 @@ rx_submit(struct eth_dev *dev, struct usb_request *req, gfp_t gfp_flags)
 		if (skb)
 			dev_kfree_skb_any(skb);
 		spin_lock_irqsave(&dev->req_lock, flags);
-		list_add(&req->list, &dev->rx_reqs);
+		list_move_tail(&req->list, &dev->rx_reqs);
 		spin_unlock_irqrestore(&dev->req_lock, flags);
 	}
 	return retval;
@@ -302,7 +302,7 @@ static void rx_complete(struct usb_ep *ep, struct usb_request *req)
 	if (!netif_running(dev->net)) {
 clean:
 		spin_lock(&dev->req_lock);
-		list_add(&req->list, &dev->rx_reqs);
+		list_move_tail(&req->list, &dev->rx_reqs);
 		spin_unlock(&dev->req_lock);
 		req = NULL;
 	}
@@ -377,7 +377,7 @@ static void rx_fill(struct eth_dev *dev, gfp_t gfp_flags)
 	spin_lock_irqsave(&dev->req_lock, flags);
 	while (!list_empty(&dev->rx_reqs)) {
 		req = list_first_entry(&dev->rx_reqs, struct usb_request, list);
-		list_del_init(&req->list);
+		list_move_tail(&req->list, &dev->rx_queued_reqs);
 		spin_unlock_irqrestore(&dev->req_lock, flags);
 
 		if (rx_submit(dev, req, gfp_flags) < 0) {
@@ -437,9 +437,11 @@ static inline int is_promisc(u16 cdc_filter)
 	return cdc_filter & USB_CDC_PACKET_TYPE_PROMISCUOUS;
 }
 
-static int ether_wakeup_host(struct gether *port)
+static void ether_wakeup_work(struct work_struct *w)
 {
 	int			ret;
+	struct eth_dev		*dev = container_of(w, struct eth_dev, wakeup_work);
+	struct gether		*port = dev->port_usb;
 	struct usb_function	*func = &port->func;
 	struct usb_gadget	*gadget = func->config->cdev->gadget;
 
@@ -448,7 +450,8 @@ static int ether_wakeup_host(struct gether *port)
 	else
 		ret = usb_gadget_wakeup(gadget);
 
-	return ret;
+	if (ret)
+		DBG(dev, "failed to trigger wakeup:%d\n", ret);
 }
 
 static netdev_tx_t eth_start_xmit(struct sk_buff *skb,
@@ -475,7 +478,7 @@ static netdev_tx_t eth_start_xmit(struct sk_buff *skb,
 		DBG(dev, "Port suspended. Triggering wakeup\n");
 		netif_stop_queue(net);
 		spin_unlock_irqrestore(&dev->lock, flags);
-		ether_wakeup_host(dev->port_usb);
+		schedule_work(&dev->wakeup_work);
 		return NETDEV_TX_BUSY;
 	}
 
@@ -753,8 +756,10 @@ struct eth_dev *gether_setup_name(struct usb_gadget *g,
 	spin_lock_init(&dev->lock);
 	spin_lock_init(&dev->req_lock);
 	INIT_WORK(&dev->work, eth_work);
+	INIT_WORK(&dev->wakeup_work, ether_wakeup_work);
 	INIT_LIST_HEAD(&dev->tx_reqs);
 	INIT_LIST_HEAD(&dev->rx_reqs);
+	INIT_LIST_HEAD(&dev->rx_queued_reqs);
 
 	skb_queue_head_init(&dev->rx_frames);
 
@@ -824,8 +829,10 @@ struct net_device *gether_setup_name_default(const char *netname)
 	spin_lock_init(&dev->lock);
 	spin_lock_init(&dev->req_lock);
 	INIT_WORK(&dev->work, eth_work);
+	INIT_WORK(&dev->wakeup_work, ether_wakeup_work);
 	INIT_LIST_HEAD(&dev->tx_reqs);
 	INIT_LIST_HEAD(&dev->rx_reqs);
+	INIT_LIST_HEAD(&dev->rx_queued_reqs);
 
 	skb_queue_head_init(&dev->rx_frames);
 
@@ -1040,6 +1047,7 @@ EXPORT_SYMBOL_GPL(gether_set_ifname);
 void gether_suspend(struct gether *link)
 {
 	struct eth_dev *dev = link->ioport;
+	struct usb_request *req;
 	unsigned long flags;
 
 	if (!dev)
@@ -1050,9 +1058,20 @@ void gether_suspend(struct gether *link)
 		 * There is a transfer in progress. So we trigger a remote
 		 * wakeup to inform the host.
 		 */
-		ether_wakeup_host(dev->port_usb);
+		schedule_work(&dev->wakeup_work);
 		return;
 	}
+	/* Dequeue the submitted requests. */
+	spin_lock(&dev->req_lock);
+	while (!list_empty(&dev->rx_queued_reqs)) {
+		req = list_last_entry(&dev->rx_queued_reqs, struct usb_request, list);
+		list_move_tail(&req->list, &dev->rx_reqs);
+		spin_unlock(&dev->req_lock);
+		usb_ep_dequeue(dev->port_usb->out_ep, req);
+		spin_lock(&dev->req_lock);
+	}
+	spin_unlock(&dev->req_lock);
+
 	spin_lock_irqsave(&dev->lock, flags);
 	link->is_suspend = true;
 	spin_unlock_irqrestore(&dev->lock, flags);
@@ -1067,6 +1086,7 @@ void gether_resume(struct gether *link)
 	if (!dev)
 		return;
 
+	defer_kevent(dev, WORK_RX_MEMORY);
 	if (netif_queue_stopped(dev->net))
 		netif_start_queue(dev->net);
 
@@ -1228,6 +1248,15 @@ void gether_disconnect(struct gether *link)
 		usb_ep_free_request(link->out_ep, req);
 		spin_lock(&dev->req_lock);
 	}
+
+	while (!list_empty(&dev->rx_queued_reqs)) {
+		req = list_first_entry(&dev->rx_queued_reqs, struct usb_request, list);
+		list_del(&req->list);
+
+		spin_unlock(&dev->req_lock);
+		usb_ep_free_request(link->out_ep, req);
+		spin_lock(&dev->req_lock);
+	}
 	spin_unlock(&dev->req_lock);
 	link->out_ep->desc = NULL;
 
-- 
2.7.4

