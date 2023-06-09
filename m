Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9113D728CCE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237015AbjFIBCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237031AbjFIBCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:02:38 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC2A30EC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:02:32 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-568fa455b8fso16118437b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 18:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686272552; x=1688864552;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1f5GzB40Nnck/SbxerHyt9uxjJKMRlabQvqAToawx7E=;
        b=3FYYWCtG2kS1UktUFM6mj7GIYlBU+gK/llSekuedvBVkK/lwHh1cx7mQb9Lv3VVq7w
         3DrHwYfdNcr/l7OXjqR6yHAZQsREfdVt9KG9eS3xPaCyCgUIMVP/Y9lZfFrhTJ1gRw1I
         1Gg6byGnIctnsOt0JUYCTOZIqfIqLPsBzEOVwqBufin/57/AYeNsPXE5PHVjT7ahQZHP
         1asbzSyOyG+P/YnAQkEGjumPWC6hHYsYJNRPfNEQNkNEi+x385ixKgUwUsy8u5dgNrtw
         zScOVVQnPrJ2P3rjpIX1uD0pqOVrL2kAxpzANbMBS+Lcj7eenk5RZU8d55oiUC8P4hOU
         U7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686272552; x=1688864552;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1f5GzB40Nnck/SbxerHyt9uxjJKMRlabQvqAToawx7E=;
        b=hQKe4DXX9wE4GJpllztAA3ACguick3ew9OxNbNDznFTVKuBc4WGF+4tM5aYRMz4Gu7
         /4BdSfXFQPEj5eeyrozE6000MiC98evoITl5+QLwsTKZp1lqAYFB9ZROatvb/VKkh2np
         buqMzbFIgojJQ/kZDJh4V5UXYHZjqTsLG6sEjMCx6S9VuNCMvMXDNZMqLEhx3NFSCxT/
         aYpL1hOPTSIWhwWI+uRROazgsqtr8+p31QRHHocCuMGaTbdYrjM4pL1qynj1mqkfMzIH
         rwprYhLyGWuu18m28T8TB5jO1KdaXAOBUEUuYjvUgkdtc5Gzn3M0HhjdbQzttXA0F4b3
         m47A==
X-Gm-Message-State: AC+VfDxFud8rQylHV/5vAQ6L66Xvr6Sxt8Dv8pwVfrglkk2M/8xipQIT
        nKu5SRq5UmkJDCkXjzyXCmy4EPeapb0=
X-Google-Smtp-Source: ACHHUZ5gK44/b3yxRtBkmeSyylUDPqEDFCgloH+0XWnbA+uXK7tNeZ+RdBfP8g2+Ro7hYCxReFLsJ517d28=
X-Received: from badhri.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6442])
 (user=badhri job=sendgmr) by 2002:a81:e346:0:b0:559:e97a:cb21 with SMTP id
 w6-20020a81e346000000b00559e97acb21mr693037ywl.9.1686272552209; Thu, 08 Jun
 2023 18:02:32 -0700 (PDT)
Date:   Fri,  9 Jun 2023 01:02:27 +0000
In-Reply-To: <20230609010227.978661-1-badhri@google.com>
Mime-Version: 1.0
References: <20230609010227.978661-1-badhri@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230609010227.978661-2-badhri@google.com>
Subject: [PATCH v8 2/2] usb: gadget: udc: core: Prevent soft_connect_store() race
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

usb_udc_connect_control(), soft_connect_store() and
usb_gadget_deactivate() can potentially race against each other to invoke
usb_gadget_connect()/usb_gadget_disconnect(). To prevent this, guard
udc->started, gadget->allow_connect, gadget->deactivate and
gadget->connect with connect_lock so that ->pullup() is only invoked when
the gadget is bound, started and not deactivated. The routines
usb_gadget_connect_locked(), usb_gadget_disconnect_locked(),
usb_udc_connect_control_locked(), usb_gadget_udc_start_locked(),
usb_gadget_udc_stop_locked() are called with this lock held.

An earlier version of this commit was reverted due to the crash reported in
https://lore.kernel.org/all/ZF4BvgsOyoKxdPFF@francesco-nb.int.toradex.com/.
commit 16737e78d190 ("usb: gadget: udc: core: Offload usb_udc_vbus_handler processing")
addresses the crash reported.

Cc: stable@vger.kernel.org
Fixes: 628ef0d273a6 ("usb: udc: add usb_udc_vbus_handler")
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
v5 is the first version in this series.
Changes since v5:
** Fixed up commit message
** Wrapped comments at 76.

Changes since v6:
** Address Alan comments around style/presentation.
** Fixed code to acquire ->connect_lock before testing gadget->deactivated.

Changes since v7:
** Remove unused out labels reported by ktest robot
---
 drivers/usb/gadget/udc/core.c | 155 +++++++++++++++++++++++-----------
 1 file changed, 106 insertions(+), 49 deletions(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index d2e4f78c53e3..83fd1de14784 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -40,6 +40,11 @@ static const struct bus_type gadget_bus_type;
  * @allow_connect: Indicates whether UDC is allowed to be pulled up.
  * Set/cleared by gadget_(un)bind_driver() after gadget driver is bound or
  * unbound.
+ * @connect_lock: protects udc->started, gadget->connect,
+ * gadget->allow_connect and gadget->deactivate. The routines
+ * usb_gadget_connect_locked(), usb_gadget_disconnect_locked(),
+ * usb_udc_connect_control_locked(), usb_gadget_udc_start_locked() and
+ * usb_gadget_udc_stop_locked() are called with this lock held.
  *
  * This represents the internal data structure which is used by the UDC-class
  * to hold information about udc driver and gadget together.
@@ -53,6 +58,7 @@ struct usb_udc {
 	bool				started;
 	bool				allow_connect;
 	struct work_struct		vbus_work;
+	struct mutex			connect_lock;
 };
 
 static struct class *udc_class;
@@ -692,17 +698,8 @@ int usb_gadget_vbus_disconnect(struct usb_gadget *gadget)
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
+static int usb_gadget_connect_locked(struct usb_gadget *gadget)
+	__must_hold(&gadget->udc->connect_lock)
 {
 	int ret = 0;
 
@@ -711,10 +708,12 @@ int usb_gadget_connect(struct usb_gadget *gadget)
 		goto out;
 	}
 
-	if (gadget->deactivated || !gadget->udc->allow_connect) {
+	if (gadget->deactivated || !gadget->udc->allow_connect || !gadget->udc->started) {
 		/*
-		 * If gadget is deactivated we only save new state.
-		 * Gadget will be connected automatically after activation.
+		 * If the gadget isn't usable (because it is deactivated,
+		 * unbound, or not yet started), we only save the new state.
+		 * The gadget will be connected automatically when it is
+		 * activated/bound/started.
 		 */
 		gadget->connected = true;
 		goto out;
@@ -729,22 +728,31 @@ int usb_gadget_connect(struct usb_gadget *gadget)
 
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
+static int usb_gadget_disconnect_locked(struct usb_gadget *gadget)
+	__must_hold(&gadget->udc->connect_lock)
 {
 	int ret = 0;
 
@@ -756,7 +764,7 @@ int usb_gadget_disconnect(struct usb_gadget *gadget)
 	if (!gadget->connected)
 		goto out;
 
-	if (gadget->deactivated) {
+	if (gadget->deactivated || !gadget->udc->started) {
 		/*
 		 * If gadget is deactivated we only save new state.
 		 * Gadget will stay disconnected after activation.
@@ -779,6 +787,30 @@ int usb_gadget_disconnect(struct usb_gadget *gadget)
 
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
@@ -796,13 +828,14 @@ int usb_gadget_deactivate(struct usb_gadget *gadget)
 {
 	int ret = 0;
 
+	mutex_lock(&gadget->udc->connect_lock);
 	if (gadget->deactivated)
-		goto out;
+		goto unlock;
 
 	if (gadget->connected) {
-		ret = usb_gadget_disconnect(gadget);
+		ret = usb_gadget_disconnect_locked(gadget);
 		if (ret)
-			goto out;
+			goto unlock;
 
 		/*
 		 * If gadget was being connected before deactivation, we want
@@ -812,7 +845,8 @@ int usb_gadget_deactivate(struct usb_gadget *gadget)
 	}
 	gadget->deactivated = true;
 
-out:
+unlock:
+	mutex_unlock(&gadget->udc->connect_lock);
 	trace_usb_gadget_deactivate(gadget, ret);
 
 	return ret;
@@ -832,8 +866,9 @@ int usb_gadget_activate(struct usb_gadget *gadget)
 {
 	int ret = 0;
 
+	mutex_lock(&gadget->udc->connect_lock);
 	if (!gadget->deactivated)
-		goto out;
+		goto unlock;
 
 	gadget->deactivated = false;
 
@@ -842,9 +877,11 @@ int usb_gadget_activate(struct usb_gadget *gadget)
 	 * while it was being deactivated, we call usb_gadget_connect().
 	 */
 	if (gadget->connected)
-		ret = usb_gadget_connect(gadget);
+		ret = usb_gadget_connect_locked(gadget);
+	mutex_unlock(&gadget->udc->connect_lock);
 
-out:
+unlock:
+	mutex_unlock(&gadget->udc->connect_lock);
 	trace_usb_gadget_activate(gadget, ret);
 
 	return ret;
@@ -1083,19 +1120,22 @@ EXPORT_SYMBOL_GPL(usb_gadget_set_state);
 
 /* ------------------------------------------------------------------------- */
 
-static void usb_udc_connect_control(struct usb_udc *udc)
+/* Acquire connect_lock before calling this function. */
+static void usb_udc_connect_control_locked(struct usb_udc *udc) __must_hold(&udc->connect_lock)
 {
 	if (udc->vbus)
-		usb_gadget_connect(udc->gadget);
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
@@ -1144,7 +1184,7 @@ void usb_gadget_udc_reset(struct usb_gadget *gadget,
 EXPORT_SYMBOL_GPL(usb_gadget_udc_reset);
 
 /**
- * usb_gadget_udc_start - tells usb device controller to start up
+ * usb_gadget_udc_start_locked - tells usb device controller to start up
  * @udc: The UDC to be started
  *
  * This call is issued by the UDC Class driver when it's about
@@ -1155,8 +1195,11 @@ EXPORT_SYMBOL_GPL(usb_gadget_udc_reset);
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
 
@@ -1173,7 +1216,7 @@ static inline int usb_gadget_udc_start(struct usb_udc *udc)
 }
 
 /**
- * usb_gadget_udc_stop - tells usb device controller we don't need it anymore
+ * usb_gadget_udc_stop_locked - tells usb device controller we don't need it anymore
  * @udc: The UDC to be stopped
  *
  * This call is issued by the UDC Class driver after calling
@@ -1182,8 +1225,11 @@ static inline int usb_gadget_udc_start(struct usb_udc *udc)
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
@@ -1342,6 +1388,7 @@ int usb_add_gadget(struct usb_gadget *gadget)
 
 	udc->gadget = gadget;
 	gadget->udc = udc;
+	mutex_init(&udc->connect_lock);
 
 	udc->started = false;
 
@@ -1545,12 +1592,16 @@ static int gadget_bind_driver(struct device *dev)
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
 	udc->allow_connect = true;
-	usb_udc_connect_control(udc);
+	usb_udc_connect_control_locked(udc);
+	mutex_unlock(&udc->connect_lock);
 
 	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
 	return 0;
@@ -1583,12 +1634,14 @@ static void gadget_unbind_driver(struct device *dev)
 
 	udc->allow_connect = false;
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
@@ -1674,11 +1727,15 @@ static ssize_t soft_connect_store(struct device *dev,
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
2.41.0.162.gfafddb0af9-goog

