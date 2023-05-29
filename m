Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5BF715272
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 01:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjE2Xsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 19:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjE2Xs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 19:48:28 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40CECD
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 16:48:25 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5659a7d4c38so72714157b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 16:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685404105; x=1687996105;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=66406mb6JaIKbrkVnco49u9OjoxMGPlKWf10btSS/Wc=;
        b=SVjAONKIc/fc3Uu7ToJjRbOyDAGHB+UN61NBq4f/AVij57RfaCphJz/G6PLBA6+50C
         C3pynANWhe6TuwFbNJsBaUL+vx3Ln7zdMLe1demw1SVmKZ04qiVW6SKMEBWddMV0fxVZ
         n3N1oE+UtbIU39QPHSA9yFusq5xb1V9DhBHH7FNXSC2uAwl8+FzKRztJiZRamNcxo8IB
         /hrunsrbjVUlHTMs71Xoox0y1A161+3ZtMNj/tfzpT0wK0NYXc/Fyy1ZObLjQkJXNrNA
         4lciS++wHRuGlcESbQoGlaAUsA3miT/YfDi4HGSd6Lezx5nWuD0mu2w1U09xsVdyL9gn
         LC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685404105; x=1687996105;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66406mb6JaIKbrkVnco49u9OjoxMGPlKWf10btSS/Wc=;
        b=eUpm0DBmKQVmgxhohs0Fq9my/cASKLqEDMZqtbnq4MXjXuDjphy6Wc7XcvSDw3oPxN
         nOKiFBKiJuSo/DH0ZcwI0L52+8L+ei0OLAMzVs88M8laNjsWEyTXUxMGffHHjSpTo+e+
         HxSUvanLtdpne3bKg01B5EEQVSHP4BL9fNM5mY9SLwWJGcV+rDoHK6YITgJ38RQHEO2H
         2WgIlalzH7raBm/UMQPJpRehtlJjph2C0HLE07MI/OGfVIW5jzcJpBHQV/r1n2M4Cblq
         DK1BSzgcw81e91QoXroGBxls4dko7DwXRmpAA0Pkn9Cc0M3o3OAyhP2g5mycAFDoJeot
         kfmg==
X-Gm-Message-State: AC+VfDw6ZWLBd2gw7AX/Y8Unw59aOtNm7vtVBZ6YbFZFM65gdpbHrqt9
        6DG59S8DjRmnZWcqFxtd6gNRhUxosOg=
X-Google-Smtp-Source: ACHHUZ7AtVKiMallHnDYHbiKi7MYkYu/tiYHVHnJLME6iat+DOHlranN0yT4R+ckNVH55IKGBTEUj5E4SMM=
X-Received: from badhri.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6442])
 (user=badhri job=sendgmr) by 2002:a81:af64:0:b0:54f:a35e:e79a with SMTP id
 x36-20020a81af64000000b0054fa35ee79amr219796ywj.8.1685404105019; Mon, 29 May
 2023 16:48:25 -0700 (PDT)
Date:   Mon, 29 May 2023 23:48:16 +0000
In-Reply-To: <20230529234816.3720623-1-badhri@google.com>
Mime-Version: 1.0
References: <20230529234816.3720623-1-badhri@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230529234816.3720623-3-badhri@google.com>
Subject: [PATCH v4 3/3] usb: gadget: udc: core: Offload usb_udc_vbus_handler processing
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        colin.i.king@gmail.com, xuetao09@huawei.com,
        quic_eserrao@quicinc.com, water.zhangjiantao@huawei.com,
        peter.chen@freescale.com, balbi@ti.com, francesco@dolcini.it,
        alistair@alistair23.me, stephan@gerhold.net, bagasdotme@gmail.com,
        luca@z3ntu.xyz
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Badhri Jagan Sridharan <badhri@google.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

chipidea udc calls usb_udc_vbus_handler from udc_start gadget
ops causing a deadlock. Avoid this by offloading usb_udc_vbus_handler
processing.

============================================
WARNING: possible recursive locking detected
640-rc1-000-devel-00005-gcda3c69ebc14 #1 Not tainted
-------------------------------------------

CPU0
----
lock(&udc->connect_lock);
lock(&udc->connect_lock);

 DEADLOCK

stack backtrace:
  CPU: 1 PID: 566 Comm: echo Not tainted 640-rc1-000-devel-00005-gcda3c69ebc14 #1
  Hardware name: Freescale iMX7 Dual (Device Tree)
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x70/0xb0
  dump_stack_lvl from __lock_acquire+0x924/0x22c4
  __lock_acquire from lock_acquire+0x100/0x370
  lock_acquire from __mutex_lock+0xa8/0xfb4
  __mutex_lock from mutex_lock_nested+0x1c/0x24
  mutex_lock_nested from usb_udc_vbus_handler+0x1c/0x60
  usb_udc_vbus_handler from ci_udc_start+0x74/0x9c
  ci_udc_start from gadget_bind_driver+0x130/0x230
  gadget_bind_driver from really_probe+0xd8/0x3fc
  really_probe from __driver_probe_device+0x94/0x1f0
  __driver_probe_device from driver_probe_device+0x2c/0xc4
  driver_probe_device from __driver_attach+0x114/0x1cc
  __driver_attach from bus_for_each_dev+0x7c/0xcc
  bus_for_each_dev from bus_add_driver+0xd4/0x200
  bus_add_driver from driver_register+0x7c/0x114
  driver_register from usb_gadget_register_driver_owner+0x40/0xe0
  usb_gadget_register_driver_owner from gadget_dev_desc_UDC_store+0xd4/0x110
  gadget_dev_desc_UDC_store from configfs_write_iter+0xac/0x118
  configfs_write_iter from vfs_write+0x1b4/0x40c
  vfs_write from ksys_write+0x70/0xf8
  ksys_write from ret_fast_syscall+0x0/0x1c

Fixes: 0db213ea8eed ("Revert "Revert "usb: gadget: udc: core: Prevent redundant calls to pullup""")
Cc: stable@vger.kernel.org
Reported-by: Stephan Gerhold <stephan@gerhold.net>
Closes: https://lore.kernel.org/all/ZF4bMptC3Lf2Hnee@gerhold.net/
Reported-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Closes: https://lore.kernel.org/all/ZF4BvgsOyoKxdPFF@francesco-nb.int.toradex.com/
Reported-by: Alistair <alistair@alistair23.me>
Closes: https://lore.kernel.org/lkml/0cf8c588b701d7cf25ffe1a9217b81716e6a5c51.camel@alistair23.me/
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
Changes since v1:
- Address Alan Stern's comment on usb_udc_vbus_handler invocation from
  atomic context:
* vbus_events_lock is now a spinlock and allocations in
* usb_udc_vbus_handler are atomic now.

Changes since v2:
- Addressing Alan Stern's comments:
** connect_lock is now held by callers of
* usb_gadget_pullup_update_locked() and gadget_(un)bind_driver() does
* notdirectly hold the lock.

** Both usb_gadget_(dis)connect() and usb_udc_vbus_handler() would
* set/clear udc->vbus and invoke usb_gadget_pullup_update_locked.

** Add "unbinding" to prevent new connections after the gadget is being
* unbound.

Changes since v3:
** Made a minor cleanup which I missed to do in v3 in
* usb_udc_vbus_handler().
---
 drivers/usb/gadget/udc/core.c | 269 ++++++++++++++++------------------
 1 file changed, 123 insertions(+), 146 deletions(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 4641153e9706..26380e621e9f 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -38,9 +38,10 @@ static const struct bus_type gadget_bus_type;
  * for udcs who do not care about vbus status, this value is always true
  * @started: the UDC's started state. True if the UDC had started.
  * @connect_lock: protects udc->vbus, udc->started, gadget->connect, gadget->deactivate related
- * functions. usb_gadget_connect_locked, usb_gadget_disconnect_locked,
- * usb_udc_connect_control_locked, usb_gadget_udc_start_locked, usb_gadget_udc_stop_locked are
- * called with this lock held.
+ * functions. usb_gadget_pullup_update_locked called with this lock held.
+ * @vbus_events: list head for processing vbus updates on usb_udc_vbus_handler.
+ * @vbus_events_lock: protects vbus_events list
+ * @vbus_work: work item that invokes usb_gadget_pullup_update_locked.
  *
  * This represents the internal data structure which is used by the UDC-class
  * to hold information about udc driver and gadget together.
@@ -53,6 +54,20 @@ struct usb_udc {
 	bool				vbus;
 	bool				started;
 	struct mutex			connect_lock;
+	struct list_head		vbus_events;
+	spinlock_t			vbus_events_lock;
+	struct work_struct		vbus_work;
+	bool				unbinding;
+};
+
+/**
+ * struct vbus_event - used to notify vbus updates posted through usb_udc_vbus_handler.
+ * @vbus_on: true when vbus is on. false other wise.
+ * @node: list node for maintaining a list of pending updates to be processed.
+ */
+struct vbus_event {
+	bool vbus_on;
+	struct list_head node;
 };
 
 static struct class *udc_class;
@@ -693,40 +708,46 @@ int usb_gadget_vbus_disconnect(struct usb_gadget *gadget)
 EXPORT_SYMBOL_GPL(usb_gadget_vbus_disconnect);
 
 /* Internal version of usb_gadget_connect needs to be called with connect_lock held. */
-static int usb_gadget_connect_locked(struct usb_gadget *gadget)
+static int usb_gadget_pullup_update_locked(struct usb_gadget *gadget)
 	__must_hold(&gadget->udc->connect_lock)
 {
 	int ret = 0;
+	bool connect = !gadget->deactivated && gadget->udc->started && gadget->udc->vbus &&
+		       !gadget->udc->unbinding;
 
 	if (!gadget->ops->pullup) {
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
 
-	if (gadget->connected)
-		goto out;
-
-	if (gadget->deactivated || !gadget->udc->started) {
-		/*
-		 * If gadget is deactivated we only save new state.
-		 * Gadget will be connected automatically after activation.
-		 *
-		 * udc first needs to be started before gadget can be pulled up.
-		 */
-		gadget->connected = true;
-		goto out;
+	if (connect != gadget->connected) {
+		ret = gadget->ops->pullup(gadget, connect);
+		if (!ret)
+			gadget->connected = connect;
+		mutex_lock(&udc_lock);
+		if (!connect)
+			gadget->udc->driver->disconnect(gadget);
+		mutex_unlock(&udc_lock);
 	}
 
-	ret = gadget->ops->pullup(gadget, 1);
-	if (!ret)
-		gadget->connected = 1;
-
 out:
 	trace_usb_gadget_connect(gadget, ret);
 
 	return ret;
 }
 
+static int usb_gadget_set_vbus(struct usb_gadget *gadget, bool vbus)
+{
+	int ret;
+
+	mutex_lock(&gadget->udc->connect_lock);
+	gadget->udc->vbus = vbus;
+	ret = usb_gadget_pullup_update_locked(gadget);
+	mutex_unlock(&gadget->udc->connect_lock);
+
+	return ret;
+}
+
 /**
  * usb_gadget_connect - software-controlled connect to USB host
  * @gadget:the peripheral being connected
@@ -739,56 +760,10 @@ static int usb_gadget_connect_locked(struct usb_gadget *gadget)
  */
 int usb_gadget_connect(struct usb_gadget *gadget)
 {
-	int ret;
-
-	mutex_lock(&gadget->udc->connect_lock);
-	ret = usb_gadget_connect_locked(gadget);
-	mutex_unlock(&gadget->udc->connect_lock);
-
-	return ret;
+	return usb_gadget_set_vbus(gadget, true);
 }
 EXPORT_SYMBOL_GPL(usb_gadget_connect);
 
-/* Internal version of usb_gadget_disconnect needs to be called with connect_lock held. */
-static int usb_gadget_disconnect_locked(struct usb_gadget *gadget)
-	__must_hold(&gadget->udc->connect_lock)
-{
-	int ret = 0;
-
-	if (!gadget->ops->pullup) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
-
-	if (!gadget->connected)
-		goto out;
-
-	if (gadget->deactivated || !gadget->udc->started) {
-		/*
-		 * If gadget is deactivated we only save new state.
-		 * Gadget will stay disconnected after activation.
-		 *
-		 * udc should have been started before gadget being pulled down.
-		 */
-		gadget->connected = false;
-		goto out;
-	}
-
-	ret = gadget->ops->pullup(gadget, 0);
-	if (!ret)
-		gadget->connected = 0;
-
-	mutex_lock(&udc_lock);
-	if (gadget->udc->driver)
-		gadget->udc->driver->disconnect(gadget);
-	mutex_unlock(&udc_lock);
-
-out:
-	trace_usb_gadget_disconnect(gadget, ret);
-
-	return ret;
-}
-
 /**
  * usb_gadget_disconnect - software-controlled disconnect from USB host
  * @gadget:the peripheral being disconnected
@@ -803,16 +778,22 @@ static int usb_gadget_disconnect_locked(struct usb_gadget *gadget)
  * Returns zero on success, else negative errno.
  */
 int usb_gadget_disconnect(struct usb_gadget *gadget)
+{
+	return usb_gadget_set_vbus(gadget, false);
+}
+EXPORT_SYMBOL_GPL(usb_gadget_disconnect);
+
+static int usb_gadget_set_deactivate(struct usb_gadget *gadget, bool deactivate)
 {
 	int ret;
 
 	mutex_lock(&gadget->udc->connect_lock);
-	ret = usb_gadget_disconnect_locked(gadget);
+	gadget->deactivated = deactivate;
+	ret = usb_gadget_pullup_update_locked(gadget);
 	mutex_unlock(&gadget->udc->connect_lock);
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(usb_gadget_disconnect);
 
 /**
  * usb_gadget_deactivate - deactivate function which is not ready to work
@@ -829,26 +810,7 @@ int usb_gadget_deactivate(struct usb_gadget *gadget)
 {
 	int ret = 0;
 
-	if (gadget->deactivated)
-		goto out;
-
-	mutex_lock(&gadget->udc->connect_lock);
-	if (gadget->connected) {
-		ret = usb_gadget_disconnect_locked(gadget);
-		if (ret)
-			goto unlock;
-
-		/*
-		 * If gadget was being connected before deactivation, we want
-		 * to reconnect it in usb_gadget_activate().
-		 */
-		gadget->connected = true;
-	}
-	gadget->deactivated = true;
-
-unlock:
-	mutex_unlock(&gadget->udc->connect_lock);
-out:
+	ret = usb_gadget_set_deactivate(gadget, true);
 	trace_usb_gadget_deactivate(gadget, ret);
 
 	return ret;
@@ -868,21 +830,7 @@ int usb_gadget_activate(struct usb_gadget *gadget)
 {
 	int ret = 0;
 
-	if (!gadget->deactivated)
-		goto out;
-
-	mutex_lock(&gadget->udc->connect_lock);
-	gadget->deactivated = false;
-
-	/*
-	 * If gadget has been connected before deactivation, or became connected
-	 * while it was being deactivated, we call usb_gadget_connect().
-	 */
-	if (gadget->connected)
-		ret = usb_gadget_connect_locked(gadget);
-	mutex_unlock(&gadget->udc->connect_lock);
-
-out:
+	ret = usb_gadget_set_deactivate(gadget, false);
 	trace_usb_gadget_activate(gadget, ret);
 
 	return ret;
@@ -1121,13 +1069,28 @@ EXPORT_SYMBOL_GPL(usb_gadget_set_state);
 
 /* ------------------------------------------------------------------------- */
 
-/* Acquire connect_lock before calling this function. */
-static void usb_udc_connect_control_locked(struct usb_udc *udc) __must_hold(&udc->connect_lock)
+static void vbus_event_work(struct work_struct *work)
 {
-	if (udc->vbus && udc->started)
-		usb_gadget_connect_locked(udc->gadget);
-	else
-		usb_gadget_disconnect_locked(udc->gadget);
+	struct vbus_event *event, *n;
+	struct usb_udc *udc = container_of(work, struct usb_udc, vbus_work);
+	unsigned long flags;
+
+	spin_lock_irqsave(&udc->vbus_events_lock, flags);
+	list_for_each_entry_safe(event, n, &udc->vbus_events, node) {
+		list_del(&event->node);
+		/* OK to drop the lock here as it suffice to syncrhronize udc->vbus_events node
+		 * retrieval and deletion against usb_udc_vbus_handler. usb_udc_vbus_handler does
+		 * list_add_tail so n would be the same even if the lock is dropped.
+		 */
+		spin_unlock_irqrestore(&udc->vbus_events_lock, flags);
+		mutex_lock(&udc->connect_lock);
+		udc->vbus = event->vbus_on;
+		usb_gadget_pullup_update_locked(udc->gadget);
+		kfree(event);
+		mutex_unlock(&udc->connect_lock);
+		spin_lock_irqsave(&udc->vbus_events_lock, flags);
+	}
+	spin_unlock_irqrestore(&udc->vbus_events_lock, flags);
 }
 
 /**
@@ -1141,14 +1104,24 @@ static void usb_udc_connect_control_locked(struct usb_udc *udc) __must_hold(&udc
  */
 void usb_udc_vbus_handler(struct usb_gadget *gadget, bool status)
 {
-	struct usb_udc *udc = gadget->udc;
+	struct usb_udc *udc;
+	struct vbus_event *vbus_event;
+	unsigned long flags;
 
-	mutex_lock(&udc->connect_lock);
-	if (udc) {
-		udc->vbus = status;
-		usb_udc_connect_control_locked(udc);
-	}
-	mutex_unlock(&udc->connect_lock);
+	if (!gadget || !gadget->udc)
+		return;
+
+	udc = gadget->udc;
+
+	vbus_event = kzalloc(sizeof(*vbus_event), GFP_ATOMIC);
+	if (!vbus_event)
+		return;
+
+	spin_lock_irqsave(&udc->vbus_events_lock, flags);
+	vbus_event->vbus_on = status;
+	list_add_tail(&vbus_event->node, &udc->vbus_events);
+	spin_unlock_irqrestore(&udc->vbus_events_lock, flags);
+	schedule_work(&udc->vbus_work);
 }
 EXPORT_SYMBOL_GPL(usb_udc_vbus_handler);
 
@@ -1170,7 +1143,7 @@ void usb_gadget_udc_reset(struct usb_gadget *gadget,
 EXPORT_SYMBOL_GPL(usb_gadget_udc_reset);
 
 /**
- * usb_gadget_udc_start_locked - tells usb device controller to start up
+ * usb_gadget_udc_start - tells usb device controller to start up
  * @udc: The UDC to be started
  *
  * This call is issued by the UDC Class driver when it's about
@@ -1181,11 +1154,8 @@ EXPORT_SYMBOL_GPL(usb_gadget_udc_reset);
  * necessary to have it powered on.
  *
  * Returns zero on success, else negative errno.
- *
- * Caller should acquire connect_lock before invoking this function.
  */
-static inline int usb_gadget_udc_start_locked(struct usb_udc *udc)
-	__must_hold(&udc->connect_lock)
+static inline int usb_gadget_udc_start(struct usb_udc *udc)
 {
 	int ret;
 
@@ -1194,15 +1164,17 @@ static inline int usb_gadget_udc_start_locked(struct usb_udc *udc)
 		return -EBUSY;
 	}
 
+	mutex_lock(&udc->connect_lock);
 	ret = udc->gadget->ops->udc_start(udc->gadget, udc->driver);
 	if (!ret)
 		udc->started = true;
+	mutex_unlock(&udc->connect_lock);
 
 	return ret;
 }
 
 /**
- * usb_gadget_udc_stop_locked - tells usb device controller we don't need it anymore
+ * usb_gadget_udc_stop - tells usb device controller we don't need it anymore
  * @udc: The UDC to be stopped
  *
  * This call is issued by the UDC Class driver after calling
@@ -1211,19 +1183,18 @@ static inline int usb_gadget_udc_start_locked(struct usb_udc *udc)
  * The details are implementation specific, but it can go as
  * far as powering off UDC completely and disable its data
  * line pullups.
- *
- * Caller should acquire connect lock before invoking this function.
  */
-static inline void usb_gadget_udc_stop_locked(struct usb_udc *udc)
-	__must_hold(&udc->connect_lock)
+static inline void usb_gadget_udc_stop(struct usb_udc *udc)
 {
 	if (!udc->started) {
 		dev_err(&udc->dev, "UDC had already stopped\n");
 		return;
 	}
 
+	mutex_lock(&udc->connect_lock);
 	udc->gadget->ops->udc_stop(udc->gadget);
 	udc->started = false;
+	mutex_unlock(&udc->connect_lock);
 }
 
 /**
@@ -1362,6 +1333,7 @@ int usb_add_gadget(struct usb_gadget *gadget)
 	if (!udc)
 		goto error;
 
+	udc->unbinding = true;
 	device_initialize(&udc->dev);
 	udc->dev.release = usb_udc_release;
 	udc->dev.class = udc_class;
@@ -1375,6 +1347,9 @@ int usb_add_gadget(struct usb_gadget *gadget)
 	udc->gadget = gadget;
 	gadget->udc = udc;
 	mutex_init(&udc->connect_lock);
+	INIT_LIST_HEAD(&udc->vbus_events);
+	spin_lock_init(&udc->vbus_events_lock);
+	INIT_WORK(&udc->vbus_work, vbus_event_work);
 
 	udc->started = false;
 
@@ -1474,6 +1449,17 @@ char *usb_get_gadget_udc_name(void)
 }
 EXPORT_SYMBOL_GPL(usb_get_gadget_udc_name);
 
+static int usb_gadget_set_unbinding(struct usb_udc *udc, bool status)
+{
+	int ret;
+
+	mutex_lock(&udc->connect_lock);
+	udc->unbinding = status;
+	ret = usb_gadget_pullup_update_locked(udc->gadget);
+	mutex_unlock(&udc->connect_lock);
+
+	return ret;
+}
 /**
  * usb_add_gadget_udc - adds a new gadget to the udc class driver list
  * @parent: the parent device to this udc. Usually the controller
@@ -1576,15 +1562,11 @@ static int gadget_bind_driver(struct device *dev)
 	if (ret)
 		goto err_bind;
 
-	mutex_lock(&udc->connect_lock);
-	ret = usb_gadget_udc_start_locked(udc);
-	if (ret) {
-		mutex_unlock(&udc->connect_lock);
+	ret = usb_gadget_udc_start(udc);
+	if (ret)
 		goto err_start;
-	}
 	usb_gadget_enable_async_callbacks(udc);
-	usb_udc_connect_control_locked(udc);
-	mutex_unlock(&udc->connect_lock);
+	usb_gadget_set_unbinding(udc, false);
 
 	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
 	return 0;
@@ -1615,14 +1597,13 @@ static void gadget_unbind_driver(struct device *dev)
 
 	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
 
-	mutex_lock(&udc->connect_lock);
-	usb_gadget_disconnect_locked(gadget);
+	usb_gadget_set_unbinding(udc, true);
+	cancel_work_sync(&udc->vbus_work);
 	usb_gadget_disable_async_callbacks(udc);
 	if (gadget->irq)
 		synchronize_irq(gadget->irq);
 	udc->driver->unbind(gadget);
-	usb_gadget_udc_stop_locked(udc);
-	mutex_unlock(&udc->connect_lock);
+	usb_gadget_udc_stop(udc);
 
 	mutex_lock(&udc_lock);
 	driver->is_bound = false;
@@ -1708,15 +1689,11 @@ static ssize_t soft_connect_store(struct device *dev,
 	}
 
 	if (sysfs_streq(buf, "connect")) {
-		mutex_lock(&udc->connect_lock);
-		usb_gadget_udc_start_locked(udc);
-		usb_gadget_connect_locked(udc->gadget);
-		mutex_unlock(&udc->connect_lock);
+		usb_gadget_udc_start(udc);
+		usb_udc_vbus_handler(udc->gadget, true);
 	} else if (sysfs_streq(buf, "disconnect")) {
-		mutex_lock(&udc->connect_lock);
-		usb_gadget_disconnect_locked(udc->gadget);
-		usb_gadget_udc_stop_locked(udc);
-		mutex_unlock(&udc->connect_lock);
+		usb_udc_vbus_handler(udc->gadget, false);
+		usb_gadget_udc_stop(udc);
 	} else {
 		dev_err(dev, "unsupported command '%s'\n", buf);
 		ret = -EINVAL;
-- 
2.41.0.rc0.172.g3f132b7071-goog

