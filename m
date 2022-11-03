Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCCB617D9D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiKCNNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiKCNMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:12:54 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4995914D3B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:12:53 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so1748965pjl.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 06:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=La6137YO6O3TJK/0GFcDignRrRdua80P+6PCRQgIvsM=;
        b=DSclgAj23WinjREjPzdCRDM1MdJhbVwuzU56c+TRZXuKWWkmEci1xkgsiDFwn+eJRC
         2n8y6N+snvNwKCwxvvPe42FZ3i7KJO3npl4+HIJpKit6MQkJ3hH3j1MIg6YJwCzqV5aS
         F8DogQkMVdadB5/zArnJD6RKDiFRoznOXT3Sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=La6137YO6O3TJK/0GFcDignRrRdua80P+6PCRQgIvsM=;
        b=5kyTHFLButTt+WZfNhjcFYkSxs9FUtmA7AURYnsFqO673nUFGg5eBBd2AegMarevxr
         wibMNP40xtqW71krEqQjkYY5RkER2TceeDQjckueuVsFt5bOaD2MqWWrOUlN7FD7/E3d
         9sDzdx7Dxb4WIuy2z4B7A8wun//Qyx3DUUzpGQscbPBb0AqLk0svEa8K1yrvR2zyO3c2
         c2TQpkYPsGJbRF9/K5DuCV8VvfdCB4jHedTJnYnR4FSYxyjVE7NpkN4bBFG7agbkodDo
         /r9worM2JZItbxszhsc3pvMTdHk+2PLk4kO+NkWy9QPfEgTEKnb3hkJHIL40/wMwwyOY
         Q2/A==
X-Gm-Message-State: ACrzQf0v5m6+zPvwOoAQB7V7Bnr+Xrt0d8N0Bz/nT5Q+fIWSeqUmnVDw
        9usgjq0+Ni1hXTz3kfURNDV8sg==
X-Google-Smtp-Source: AMsMyM6ClraYowbRIAKelQ6pTDvpQgmVyIo4USpCdTVNAETdzJHfp7GFC3E43dtoSMFxGytnh9WuJg==
X-Received: by 2002:a17:902:8c92:b0:178:29d4:600f with SMTP id t18-20020a1709028c9200b0017829d4600fmr30344420plo.40.1667481172527;
        Thu, 03 Nov 2022 06:12:52 -0700 (PDT)
Received: from shuah-tx13.. ([103.99.10.63])
        by smtp.gmail.com with ESMTPSA id p8-20020a1709027ec800b0018703bf3ec9sm647871plb.61.2022.11.03.06.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:12:51 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, valentina.manea.m@gmail.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] usb/usbip: fix uninitialized variables errors
Date:   Thu,  3 Nov 2022 07:12:42 -0600
Message-Id: <76654f2f1cc30b27be10ac9b177bb449a7ad7068.1667480280.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1667480280.git.skhan@linuxfoundation.org>
References: <cover.1667480280.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix uninitialized variable errors reported by cppcheck. One example
below.

usbip/stub_main.c:284:10: error: Uninitialized variables: priv.seqnum, priv.sdev, priv.urbs, priv.sgl, priv.num_urbs, priv.completed_urbs, priv.urb_status, priv.unlinking [uninitvar]
  return priv;

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/usb/usbip/stub_main.c     | 2 +-
 drivers/usb/usbip/stub_rx.c       | 4 ++--
 drivers/usb/usbip/stub_tx.c       | 4 ++--
 drivers/usb/usbip/usbip_event.c   | 2 +-
 drivers/usb/usbip/vhci_hcd.c      | 2 +-
 drivers/usb/usbip/vhci_rx.c       | 2 +-
 drivers/usb/usbip/vhci_tx.c       | 4 ++--
 drivers/usb/usbip/vudc_dev.c      | 2 +-
 drivers/usb/usbip/vudc_rx.c       | 2 +-
 drivers/usb/usbip/vudc_transfer.c | 4 ++--
 10 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
index e8c3131a8543..e1248b971218 100644
--- a/drivers/usb/usbip/stub_main.c
+++ b/drivers/usb/usbip/stub_main.c
@@ -277,7 +277,7 @@ static DRIVER_ATTR_WO(rebind);
 
 static struct stub_priv *stub_priv_pop_from_listhead(struct list_head *listhead)
 {
-	struct stub_priv *priv, *tmp;
+	struct stub_priv *priv = NULL, *tmp;
 
 	list_for_each_entry_safe(priv, tmp, listhead, list) {
 		list_del_init(&priv->list);
diff --git a/drivers/usb/usbip/stub_rx.c b/drivers/usb/usbip/stub_rx.c
index fc01b31bbb87..08e11948834b 100644
--- a/drivers/usb/usbip/stub_rx.c
+++ b/drivers/usb/usbip/stub_rx.c
@@ -206,7 +206,7 @@ static int stub_recv_cmd_unlink(struct stub_device *sdev,
 {
 	int ret, i;
 	unsigned long flags;
-	struct stub_priv *priv;
+	struct stub_priv *priv = NULL;
 
 	spin_lock_irqsave(&sdev->priv_lock, flags);
 
@@ -440,7 +440,7 @@ static void masking_bogus_flags(struct urb *urb)
 
 static int stub_recv_xbuff(struct usbip_device *ud, struct stub_priv *priv)
 {
-	int ret;
+	int ret = 0;
 	int i;
 
 	for (i = 0; i < priv->num_urbs; i++) {
diff --git a/drivers/usb/usbip/stub_tx.c b/drivers/usb/usbip/stub_tx.c
index b1c2f6781cb3..3d3d2b5a680d 100644
--- a/drivers/usb/usbip/stub_tx.c
+++ b/drivers/usb/usbip/stub_tx.c
@@ -132,7 +132,7 @@ static void setup_ret_unlink_pdu(struct usbip_header *rpdu,
 static struct stub_priv *dequeue_from_priv_tx(struct stub_device *sdev)
 {
 	unsigned long flags;
-	struct stub_priv *priv, *tmp;
+	struct stub_priv *priv = NULL, *tmp;
 
 	spin_lock_irqsave(&sdev->priv_lock, flags);
 
@@ -343,7 +343,7 @@ static int stub_send_ret_submit(struct stub_device *sdev)
 static struct stub_unlink *dequeue_from_unlink_tx(struct stub_device *sdev)
 {
 	unsigned long flags;
-	struct stub_unlink *unlink, *tmp;
+	struct stub_unlink *unlink = NULL, *tmp;
 
 	spin_lock_irqsave(&sdev->priv_lock, flags);
 
diff --git a/drivers/usb/usbip/usbip_event.c b/drivers/usb/usbip/usbip_event.c
index 26513540bcdb..8d782c8d8893 100644
--- a/drivers/usb/usbip/usbip_event.c
+++ b/drivers/usb/usbip/usbip_event.c
@@ -143,7 +143,7 @@ void usbip_finish_eh(void)
 
 void usbip_event_add(struct usbip_device *ud, unsigned long event)
 {
-	struct usbip_event *ue;
+	struct usbip_event *ue = NULL;
 	unsigned long flags;
 
 	if (ud->event & USBIP_EH_BYE)
diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 233265550fc6..79503ffc3db8 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -957,7 +957,7 @@ static void vhci_cleanup_unlink_list(struct vhci_device *vdev,
 	struct vhci_hcd *vhci_hcd = vdev_to_vhci_hcd(vdev);
 	struct usb_hcd *hcd = vhci_hcd_to_hcd(vhci_hcd);
 	struct vhci *vhci = vhci_hcd->vhci;
-	struct vhci_unlink *unlink, *tmp;
+	struct vhci_unlink *unlink = NULL, *tmp;
 	unsigned long flags;
 
 	spin_lock_irqsave(&vhci->lock, flags);
diff --git a/drivers/usb/usbip/vhci_rx.c b/drivers/usb/usbip/vhci_rx.c
index 7f2d1c241559..8edb699aed23 100644
--- a/drivers/usb/usbip/vhci_rx.c
+++ b/drivers/usb/usbip/vhci_rx.c
@@ -12,7 +12,7 @@
 /* get URB from transmitted urb queue. caller must hold vdev->priv_lock */
 struct urb *pickup_urb_and_free_priv(struct vhci_device *vdev, __u32 seqnum)
 {
-	struct vhci_priv *priv, *tmp;
+	struct vhci_priv *priv = NULL, *tmp;
 	struct urb *urb = NULL;
 	int status;
 
diff --git a/drivers/usb/usbip/vhci_tx.c b/drivers/usb/usbip/vhci_tx.c
index 0ae40a13a9fe..78b96c915724 100644
--- a/drivers/usb/usbip/vhci_tx.c
+++ b/drivers/usb/usbip/vhci_tx.c
@@ -33,7 +33,7 @@ static void setup_cmd_submit_pdu(struct usbip_header *pdup,  struct urb *urb)
 
 static struct vhci_priv *dequeue_from_priv_tx(struct vhci_device *vdev)
 {
-	struct vhci_priv *priv, *tmp;
+	struct vhci_priv *priv = NULL, *tmp;
 	unsigned long flags;
 
 	spin_lock_irqsave(&vdev->priv_lock, flags);
@@ -168,7 +168,7 @@ static int vhci_send_cmd_submit(struct vhci_device *vdev)
 
 static struct vhci_unlink *dequeue_from_unlink_tx(struct vhci_device *vdev)
 {
-	struct vhci_unlink *unlink, *tmp;
+	struct vhci_unlink *unlink = NULL, *tmp;
 	unsigned long flags;
 
 	spin_lock_irqsave(&vdev->priv_lock, flags);
diff --git a/drivers/usb/usbip/vudc_dev.c b/drivers/usb/usbip/vudc_dev.c
index 2bc428f2e261..ddf7e6f18439 100644
--- a/drivers/usb/usbip/vudc_dev.c
+++ b/drivers/usb/usbip/vudc_dev.c
@@ -90,7 +90,7 @@ static void nuke(struct vudc *udc, struct vep *ep)
 static void stop_activity(struct vudc *udc)
 {
 	int i;
-	struct urbp *urb_p, *tmp;
+	struct urbp *urb_p = NULL, *tmp;
 
 	udc->address = 0;
 
diff --git a/drivers/usb/usbip/vudc_rx.c b/drivers/usb/usbip/vudc_rx.c
index d4a2f30a7580..a6ca27f10b68 100644
--- a/drivers/usb/usbip/vudc_rx.c
+++ b/drivers/usb/usbip/vudc_rx.c
@@ -63,7 +63,7 @@ static int v_recv_cmd_unlink(struct vudc *udc,
 				struct usbip_header *pdu)
 {
 	unsigned long flags;
-	struct urbp *urb_p;
+	struct urbp *urb_p = NULL;
 
 	spin_lock_irqsave(&udc->lock, flags);
 	list_for_each_entry(urb_p, &udc->urb_queue, urb_entry) {
diff --git a/drivers/usb/usbip/vudc_transfer.c b/drivers/usb/usbip/vudc_transfer.c
index 7e801fee33bf..fd5547f85de9 100644
--- a/drivers/usb/usbip/vudc_transfer.c
+++ b/drivers/usb/usbip/vudc_transfer.c
@@ -183,7 +183,7 @@ static int handle_control_request(struct vudc *udc, struct urb *urb,
 static int transfer(struct vudc *udc,
 		struct urb *urb, struct vep *ep, int limit)
 {
-	struct vrequest	*req;
+	struct vrequest	*req = NULL;
 	int sent = 0;
 top:
 	/* if there's no request queued, the device is NAKing; return */
@@ -303,7 +303,7 @@ static void v_timer(struct timer_list *t)
 {
 	struct vudc *udc = from_timer(udc, t, tr_timer.timer);
 	struct transfer_timer *timer = &udc->tr_timer;
-	struct urbp *urb_p, *tmp;
+	struct urbp *urb_p = NULL, *tmp;
 	unsigned long flags;
 	struct usb_ep *_ep;
 	struct vep *ep;
-- 
2.34.1

