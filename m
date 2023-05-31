Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088EC7174A4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 06:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbjEaECX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 00:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbjEaECN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 00:02:13 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EBC118
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 21:02:09 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-556011695d1so95861117b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 21:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685505729; x=1688097729;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v6QTveAwLS+RXrF0pN6prG1FOlU7FfJOhesY8AMEUQ4=;
        b=RTjAikjKXfCzzzzXmMH2ms1csn4xNxC2KDfgandf99uG3RbmGGHNiyy1B9ygvBUpc8
         rpU8PMkmJK3cvKQYUp8XYsFeywHSuSRDpQbXEtp4VE2+jkTacBQhQFnmx4XMl6/MFwNd
         XAmv17rEtEdYs0Bl1B4PySgRiqRxDJ4/y6i5XoZpSYdEICnUK/ZPZV8XPDbfm8PqFqDV
         TDn7hbpX8fEWGcZvvPRbNPMlvi9OrTpi3VMgDqULGbBQ8ySJd6UdS7gqqrKPewDw77x8
         F5d+9TiQyhXdUUMIVbbdR9+9EPhe0uf+nhf79rB9dSPrnYDkX9CG5iaFYZ+d1WskZdxE
         P3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685505729; x=1688097729;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v6QTveAwLS+RXrF0pN6prG1FOlU7FfJOhesY8AMEUQ4=;
        b=XeyqOHHIEEc4ZE10bO0G6e6qx0WT51xtpLdBifuV/cS3vo9CQY7P+oL8LVvsEJpwNm
         6aRWSLH8YZ9c6uo41gGwsdKr6QReBlPlnxY1GGUb258YEIoJ7BrBFDYXYubn1HJhLpak
         Zem9sfwc2je6kvcHznY62Lxnl4HIFnDKc67TQKaJmmxlG9/UikKxHi5jiEgvmWBSUfAB
         b8+YGijBqGs/4M4cXcVVY7ereeWtQmVgDdfPN9T8AyxeNslo0AlQJgXmAY+GAJQX60oE
         9Ont4TxnocikKgT3TH1Tp2u8Jv1ZqN9zHDpz2mqbYO8o833RDMK9c0dG8n1C6MvtA5GX
         kj8Q==
X-Gm-Message-State: AC+VfDzT10V6x6B1WiyogsJRR1pKVpWd66hWAdMGYd9byZIEuIdtfYsm
        qZ29L87p15TP9nZtN62CtN0bnwJn+MQ=
X-Google-Smtp-Source: ACHHUZ5jPpPpVYB4OlWKN/mf41vW77V1YR4lb2MrbmZhSCREbIHJveURgtgOPwxmlsETvhr+LZ7SYiv/DXc=
X-Received: from badhri.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6442])
 (user=badhri job=sendgmr) by 2002:a81:431a:0:b0:54c:2409:c306 with SMTP id
 q26-20020a81431a000000b0054c2409c306mr2486624ywa.6.1685505729173; Tue, 30 May
 2023 21:02:09 -0700 (PDT)
Date:   Wed, 31 May 2023 04:02:02 +0000
In-Reply-To: <20230531040203.19295-1-badhri@google.com>
Mime-Version: 1.0
References: <20230531040203.19295-1-badhri@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230531040203.19295-2-badhri@google.com>
Subject: [PATCH v5 2/3] usb: gadget: udc: core: Invoke usb_gadget_connect only
 when started
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        colin.i.king@gmail.com, xuetao09@huawei.com,
        quic_eserrao@quicinc.com, water.zhangjiantao@huawei.com,
        peter.chen@freescale.com, balbi@ti.com, francesco@dolcini.it,
        alistair@alistair23.me, stephan@gerhold.net, bagasdotme@gmail.com,
        luca@z3ntu.xyz
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb_udc_connect_control() does not check to see if the udc has already
been started. This causes gadget->ops->pullup to be called through
usb_gadget_connect() when invoked from usb_udc_vbus_handler() even
before usb_gadget_udc_start() is called. Guard this by checking for
udc->started in usb_udc_connect_control() before invoking
usb_gadget_connect().

Guarding udc->vbus, udc->started, gadget->connect, gadget->deactivate
related functions with connect_lock. usb_gadget_connect_locked(),
usb_gadget_disconnect_locked(), usb_udc_connect_control_locked(),
usb_gadget_udc_start_locked(), usb_gadget_udc_stop_locked() are called
with this lock held as they can be simulataneously invoked from
different code paths.

Adding an additional check to make sure udc is started(udc->started)
before pullup callback is invoked.

This commit was reverted due to the crash reported in
https://lore.kernel.org/all/ZF4BvgsOyoKxdPFF@francesco-nb.int.toradex.com/.
commit 16737e78d190 ("usb: gadget: udc: core: Offload usb_udc_vbus_handler processing")
addresses the crash reported.

Cc: stable@vger.kernel.org
Fixes: 628ef0d273a6 ("usb: udc: add usb_udc_vbus_handler")
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
v5 is the first version in this series.
---
 drivers/usb/gadget/udc/core.c | 148 ++++++++++++++++++++++++----------
 1 file changed, 104 insertions(+), 44 deletions(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 44a9f32679b5..6ffe5fda8bb7 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -37,6 +37,10 @@ static const struct bus_type gadget_bus_type;
  * @vbus: for udcs who care about vbus status, this value is real vbus status;
  * for udcs who do not care about vbus status, this value is always true
  * @started: the UDC's started state. True if the UDC had started.
+ * @connect_lock: protects udc->vbus, udc->started, gadget->connect, gadget->deactivate related
+ * functions. usb_gadget_connect_locked, usb_gadget_disconnect_locked,
+ * usb_udc_connect_control_locked, usb_gadget_udc_start_locked, usb_gadget_udc_stop_locked are
+ * called with this lock held.
  *
  * This represents the internal data structure which is used by the UDC-class
  * to hold information about udc driver and gadget together.
@@ -49,6 +53,7 @@ struct usb_udc {
 	bool				vbus;
 	bool				started;
 	struct work_struct		vbus_work;
+	struct mutex			connect_lock;
 };
 
 static struct class *udc_class;
@@ -688,17 +693,9 @@ int usb_gadget_vbus_disconnect(struct usb_gadget *gadget)
 }
 EXPORT_SYMBOL_GPL(usb_gadget_vbus_disconnect);
 
-/**
- * usb_gadget_connect - software-controlled connect to USB host
- * @gadget:the peripheral being connected
- *
- * Enables the D+ (or potentially D-) pullup.  The host will start
- * enumerating this gadget when the pullup is active and a VBUS session
- * is active (the link is powered).
- *
- * Returns zero on success, else negative errno.
- */
-int usb_gadget_connect(struct usb_gadget *gadget)
+/* Internal version of usb_gadget_connect needs to be called with connect_lock held. */
+static int usb_gadget_connect_locked(struct usb_gadget *gadget)
+	__must_hold(&gadget->udc->connect_lock)
 {
 	int ret = 0;
 
@@ -707,10 +704,12 @@ int usb_gadget_connect(struct usb_gadget *gadget)
 		goto out;
 	}
 
-	if (gadget->deactivated) {
+	if (gadget->deactivated || !gadget->udc->started) {
 		/*
 		 * If gadget is deactivated we only save new state.
 		 * Gadget will be connected automatically after activation.
+		 *
+		 * udc first needs to be started before gadget can be pulled up.
 		 */
 		gadget->connected = true;
 		goto out;
@@ -725,22 +724,32 @@ int usb_gadget_connect(struct usb_gadget *gadget)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(usb_gadget_connect);
 
 /**
- * usb_gadget_disconnect - software-controlled disconnect from USB host
- * @gadget:the peripheral being disconnected
- *
- * Disables the D+ (or potentially D-) pullup, which the host may see
- * as a disconnect (when a VBUS session is active).  Not all systems
- * support software pullup controls.
+ * usb_gadget_connect - software-controlled connect to USB host
+ * @gadget:the peripheral being connected
  *
- * Following a successful disconnect, invoke the ->disconnect() callback
- * for the current gadget driver so that UDC drivers don't need to.
+ * Enables the D+ (or potentially D-) pullup.  The host will start
+ * enumerating this gadget when the pullup is active and a VBUS session
+ * is active (the link is powered).
  *
  * Returns zero on success, else negative errno.
  */
-int usb_gadget_disconnect(struct usb_gadget *gadget)
+int usb_gadget_connect(struct usb_gadget *gadget)
+{
+	int ret;
+
+	mutex_lock(&gadget->udc->connect_lock);
+	ret = usb_gadget_connect_locked(gadget);
+	mutex_unlock(&gadget->udc->connect_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_connect);
+
+/* Internal version of usb_gadget_disconnect needs to be called with connect_lock held. */
+static int usb_gadget_disconnect_locked(struct usb_gadget *gadget)
+	__must_hold(&gadget->udc->connect_lock)
 {
 	int ret = 0;
 
@@ -752,10 +761,12 @@ int usb_gadget_disconnect(struct usb_gadget *gadget)
 	if (!gadget->connected)
 		goto out;
 
-	if (gadget->deactivated) {
+	if (gadget->deactivated || !gadget->udc->started) {
 		/*
 		 * If gadget is deactivated we only save new state.
 		 * Gadget will stay disconnected after activation.
+		 *
+		 * udc should have been started before gadget being pulled down.
 		 */
 		gadget->connected = false;
 		goto out;
@@ -775,6 +786,30 @@ int usb_gadget_disconnect(struct usb_gadget *gadget)
 
 	return ret;
 }
+
+/**
+ * usb_gadget_disconnect - software-controlled disconnect from USB host
+ * @gadget:the peripheral being disconnected
+ *
+ * Disables the D+ (or potentially D-) pullup, which the host may see
+ * as a disconnect (when a VBUS session is active).  Not all systems
+ * support software pullup controls.
+ *
+ * Following a successful disconnect, invoke the ->disconnect() callback
+ * for the current gadget driver so that UDC drivers don't need to.
+ *
+ * Returns zero on success, else negative errno.
+ */
+int usb_gadget_disconnect(struct usb_gadget *gadget)
+{
+	int ret;
+
+	mutex_lock(&gadget->udc->connect_lock);
+	ret = usb_gadget_disconnect_locked(gadget);
+	mutex_unlock(&gadget->udc->connect_lock);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(usb_gadget_disconnect);
 
 /**
@@ -795,10 +830,11 @@ int usb_gadget_deactivate(struct usb_gadget *gadget)
 	if (gadget->deactivated)
 		goto out;
 
+	mutex_lock(&gadget->udc->connect_lock);
 	if (gadget->connected) {
-		ret = usb_gadget_disconnect(gadget);
+		ret = usb_gadget_disconnect_locked(gadget);
 		if (ret)
-			goto out;
+			goto unlock;
 
 		/*
 		 * If gadget was being connected before deactivation, we want
@@ -808,6 +844,8 @@ int usb_gadget_deactivate(struct usb_gadget *gadget)
 	}
 	gadget->deactivated = true;
 
+unlock:
+	mutex_unlock(&gadget->udc->connect_lock);
 out:
 	trace_usb_gadget_deactivate(gadget, ret);
 
@@ -831,6 +869,7 @@ int usb_gadget_activate(struct usb_gadget *gadget)
 	if (!gadget->deactivated)
 		goto out;
 
+	mutex_lock(&gadget->udc->connect_lock);
 	gadget->deactivated = false;
 
 	/*
@@ -838,7 +877,8 @@ int usb_gadget_activate(struct usb_gadget *gadget)
 	 * while it was being deactivated, we call usb_gadget_connect().
 	 */
 	if (gadget->connected)
-		ret = usb_gadget_connect(gadget);
+		ret = usb_gadget_connect_locked(gadget);
+	mutex_unlock(&gadget->udc->connect_lock);
 
 out:
 	trace_usb_gadget_activate(gadget, ret);
@@ -1079,19 +1119,22 @@ EXPORT_SYMBOL_GPL(usb_gadget_set_state);
 
 /* ------------------------------------------------------------------------- */
 
-static void usb_udc_connect_control(struct usb_udc *udc)
+/* Acquire connect_lock before calling this function. */
+static void usb_udc_connect_control_locked(struct usb_udc *udc) __must_hold(&udc->connect_lock)
 {
-	if (udc->vbus)
-		usb_gadget_connect(udc->gadget);
+	if (udc->vbus && udc->started)
+		usb_gadget_connect_locked(udc->gadget);
 	else
-		usb_gadget_disconnect(udc->gadget);
+		usb_gadget_disconnect_locked(udc->gadget);
 }
 
 static void vbus_event_work(struct work_struct *work)
 {
 	struct usb_udc *udc = container_of(work, struct usb_udc, vbus_work);
 
-	usb_udc_connect_control(udc);
+	mutex_lock(&udc->connect_lock);
+	usb_udc_connect_control_locked(udc);
+	mutex_unlock(&udc->connect_lock);
 }
 
 /**
@@ -1139,7 +1182,7 @@ void usb_gadget_udc_reset(struct usb_gadget *gadget,
 EXPORT_SYMBOL_GPL(usb_gadget_udc_reset);
 
 /**
- * usb_gadget_udc_start - tells usb device controller to start up
+ * usb_gadget_udc_start_locked - tells usb device controller to start up
  * @udc: The UDC to be started
  *
  * This call is issued by the UDC Class driver when it's about
@@ -1150,8 +1193,11 @@ EXPORT_SYMBOL_GPL(usb_gadget_udc_reset);
  * necessary to have it powered on.
  *
  * Returns zero on success, else negative errno.
+ *
+ * Caller should acquire connect_lock before invoking this function.
  */
-static inline int usb_gadget_udc_start(struct usb_udc *udc)
+static inline int usb_gadget_udc_start_locked(struct usb_udc *udc)
+	__must_hold(&udc->connect_lock)
 {
 	int ret;
 
@@ -1168,7 +1214,7 @@ static inline int usb_gadget_udc_start(struct usb_udc *udc)
 }
 
 /**
- * usb_gadget_udc_stop - tells usb device controller we don't need it anymore
+ * usb_gadget_udc_stop_locked - tells usb device controller we don't need it anymore
  * @udc: The UDC to be stopped
  *
  * This call is issued by the UDC Class driver after calling
@@ -1177,8 +1223,11 @@ static inline int usb_gadget_udc_start(struct usb_udc *udc)
  * The details are implementation specific, but it can go as
  * far as powering off UDC completely and disable its data
  * line pullups.
+ *
+ * Caller should acquire connect lock before invoking this function.
  */
-static inline void usb_gadget_udc_stop(struct usb_udc *udc)
+static inline void usb_gadget_udc_stop_locked(struct usb_udc *udc)
+	__must_hold(&udc->connect_lock)
 {
 	if (!udc->started) {
 		dev_err(&udc->dev, "UDC had already stopped\n");
@@ -1337,6 +1386,7 @@ int usb_add_gadget(struct usb_gadget *gadget)
 
 	udc->gadget = gadget;
 	gadget->udc = udc;
+	mutex_init(&udc->connect_lock);
 
 	udc->started = false;
 
@@ -1539,11 +1589,15 @@ static int gadget_bind_driver(struct device *dev)
 	if (ret)
 		goto err_bind;
 
-	ret = usb_gadget_udc_start(udc);
-	if (ret)
+	mutex_lock(&udc->connect_lock);
+	ret = usb_gadget_udc_start_locked(udc);
+	if (ret) {
+		mutex_unlock(&udc->connect_lock);
 		goto err_start;
+	}
 	usb_gadget_enable_async_callbacks(udc);
-	usb_udc_connect_control(udc);
+	usb_udc_connect_control_locked(udc);
+	mutex_unlock(&udc->connect_lock);
 
 	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
 	return 0;
@@ -1575,12 +1629,14 @@ static void gadget_unbind_driver(struct device *dev)
 	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
 
 	cancel_work_sync(&udc->vbus_work);
-	usb_gadget_disconnect(gadget);
+	mutex_lock(&udc->connect_lock);
+	usb_gadget_disconnect_locked(gadget);
 	usb_gadget_disable_async_callbacks(udc);
 	if (gadget->irq)
 		synchronize_irq(gadget->irq);
 	udc->driver->unbind(gadget);
-	usb_gadget_udc_stop(udc);
+	usb_gadget_udc_stop_locked(udc);
+	mutex_unlock(&udc->connect_lock);
 
 	mutex_lock(&udc_lock);
 	driver->is_bound = false;
@@ -1666,11 +1722,15 @@ static ssize_t soft_connect_store(struct device *dev,
 	}
 
 	if (sysfs_streq(buf, "connect")) {
-		usb_gadget_udc_start(udc);
-		usb_gadget_connect(udc->gadget);
+		mutex_lock(&udc->connect_lock);
+		usb_gadget_udc_start_locked(udc);
+		usb_gadget_connect_locked(udc->gadget);
+		mutex_unlock(&udc->connect_lock);
 	} else if (sysfs_streq(buf, "disconnect")) {
-		usb_gadget_disconnect(udc->gadget);
-		usb_gadget_udc_stop(udc);
+		mutex_lock(&udc->connect_lock);
+		usb_gadget_disconnect_locked(udc->gadget);
+		usb_gadget_udc_stop_locked(udc);
+		mutex_unlock(&udc->connect_lock);
 	} else {
 		dev_err(dev, "unsupported command '%s'\n", buf);
 		ret = -EINVAL;
-- 
2.41.0.rc0.172.g3f132b7071-goog

