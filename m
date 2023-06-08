Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B162572899E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 22:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbjFHUpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 16:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjFHUpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 16:45:23 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC37A1FDA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 13:45:21 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-564fb1018bcso14192497b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 13:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686257121; x=1688849121;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vnoG17X4SR0Yr68DnHAZRjmH2ycNdwkX85eHutCEXPA=;
        b=UN/Iuh6A4ZSn2Srw/iO2/QubYI3z1NBUEPCiOwH2gXvKtbxgDMkJwJQ3fcr7lYMaS6
         LRgUsrWvSHO13NXiH9E6FCY713p0mH4UD6phKd3HXqJm2EK1H6v4xP2sMNG0LkiHtk+i
         qdc2rvtqxhBrZt/vAZwTWMBKfQ/RLOzYINvXt795GjADbOfcB3Ly37ZVYeuBZDz4R7qO
         LENlFPhFhtZtw1uGFcNraCjatKtaQ8LVu81LBVrP9XK2PoiMxOQU+D62A1+LG842jH7D
         JCOU50sAWOiqTrv+RhqLhyXFYi2p3ZHBLG+b+Xb9fGNURYbw3afAIrJdf9EOkkyc3b6t
         13yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686257121; x=1688849121;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vnoG17X4SR0Yr68DnHAZRjmH2ycNdwkX85eHutCEXPA=;
        b=FXg4rPJZN5kZNASq2uU99VLDugAS2bn3tCIZWVyrXobieDVK4sxhaLM4DiQenZtv4V
         8ag747dJK6yKYsHvmGJOWhj4ITsP6xHA0e50yaQlXEKIh7xWdvl35CCPdFdheMkTrXfQ
         R4cFCyDq/rYSEM4Wpba5bJwC5Oefgt01iqpwUmQpm6rgfUAYtGgQJOAXFr8gP+HYHxpU
         /2QO/xSrHEoVDO4VF8ZGiwiXFqKPVzqNXyDKkOF8l4Sx30PBcpEUas4xss4i4HCT1AQQ
         3h5kzT73DPNDEmscn7AtISLb7tXVdwRgdeFbc/DThMdI2W1HvuGGaeahsSHrfWW7d5dZ
         RShQ==
X-Gm-Message-State: AC+VfDz+J+43/iBs07KElPbmtPRd0RSDAI1uUr8+W5O5RSo/EbBTGUoK
        jJ2mhJabPQ81R5PsYv8j9JYVOIcyoy4=
X-Google-Smtp-Source: ACHHUZ7uhwjynCVEVzqwdWP8vaJWg7hx84JcFomCDllbBtoGac7XAtCG6fQcADbdP5cT0fgiYf6v3PXmguI=
X-Received: from badhri.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6442])
 (user=badhri job=sendgmr) by 2002:a81:a7c9:0:b0:569:8603:577 with SMTP id
 e192-20020a81a7c9000000b0056986030577mr505740ywh.4.1686257120940; Thu, 08 Jun
 2023 13:45:20 -0700 (PDT)
Date:   Thu,  8 Jun 2023 20:45:15 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230608204517.105396-1-badhri@google.com>
Subject: [PATCH v7 1/2] usb: gadget: udc: core: Offload usb_udc_vbus_handler processing
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb_udc_vbus_handler() can be invoked from interrupt context by irq
handlers of the gadget drivers, however, usb_udc_connect_control() has
to run in non-atomic context due to the following:
a. Some of the gadget driver implementations expect the ->pullup
   callback to be invoked in non-atomic context.
b. usb_gadget_disconnect() acquires udc_lock which is a mutex.

Hence offload invocation of usb_udc_connect_control()
to workqueue.

UDC should not be pulled up unless gadget driver is bound. The new flag
"allow_connect" is now set by gadget_bind_driver() and cleared by
gadget_unbind_driver(). This prevents work item to pull up the gadget
even if queued when the gadget driver is already unbound.

Cc: stable@vger.kernel.org
Fixes: 1016fc0c096c ("USB: gadget: Fix obscure lockdep violation for udc_mutex")
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
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

Changes since v4:
- Addressing Alan Stern's comments:
** usb_udc_vbus_handler() now offloads invocation of usb_udc_connect_control()
* from workqueue.

** Dropped vbus_events list as this was redundant. Updating to the
* latest value is suffice

Changes since v5:
- Addressing Alan Stern's comments:
** Squashed allow_connect logic to this patch.
** Fixed comment length to wrap at 76
** Cancelling vbus_work in del_gadget()

Changes since v6:
- Added reviewed by tag
---
 drivers/usb/gadget/udc/core.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 52e6d2e84e35..d2e4f78c53e3 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -37,6 +37,9 @@ static const struct bus_type gadget_bus_type;
  * @vbus: for udcs who care about vbus status, this value is real vbus status;
  * for udcs who do not care about vbus status, this value is always true
  * @started: the UDC's started state. True if the UDC had started.
+ * @allow_connect: Indicates whether UDC is allowed to be pulled up.
+ * Set/cleared by gadget_(un)bind_driver() after gadget driver is bound or
+ * unbound.
  *
  * This represents the internal data structure which is used by the UDC-class
  * to hold information about udc driver and gadget together.
@@ -48,6 +51,8 @@ struct usb_udc {
 	struct list_head		list;
 	bool				vbus;
 	bool				started;
+	bool				allow_connect;
+	struct work_struct		vbus_work;
 };
 
 static struct class *udc_class;
@@ -706,7 +711,7 @@ int usb_gadget_connect(struct usb_gadget *gadget)
 		goto out;
 	}
 
-	if (gadget->deactivated) {
+	if (gadget->deactivated || !gadget->udc->allow_connect) {
 		/*
 		 * If gadget is deactivated we only save new state.
 		 * Gadget will be connected automatically after activation.
@@ -1086,6 +1091,13 @@ static void usb_udc_connect_control(struct usb_udc *udc)
 		usb_gadget_disconnect(udc->gadget);
 }
 
+static void vbus_event_work(struct work_struct *work)
+{
+	struct usb_udc *udc = container_of(work, struct usb_udc, vbus_work);
+
+	usb_udc_connect_control(udc);
+}
+
 /**
  * usb_udc_vbus_handler - updates the udc core vbus status, and try to
  * connect or disconnect gadget
@@ -1094,6 +1106,14 @@ static void usb_udc_connect_control(struct usb_udc *udc)
  *
  * The udc driver calls it when it wants to connect or disconnect gadget
  * according to vbus status.
+ *
+ * This function can be invoked from interrupt context by irq handlers of
+ * the gadget drivers, however, usb_udc_connect_control() has to run in
+ * non-atomic context due to the following:
+ * a. Some of the gadget driver implementations expect the ->pullup
+ * callback to be invoked in non-atomic context.
+ * b. usb_gadget_disconnect() acquires udc_lock which is a mutex.
+ * Hence offload invocation of usb_udc_connect_control() to workqueue.
  */
 void usb_udc_vbus_handler(struct usb_gadget *gadget, bool status)
 {
@@ -1101,7 +1121,7 @@ void usb_udc_vbus_handler(struct usb_gadget *gadget, bool status)
 
 	if (udc) {
 		udc->vbus = status;
-		usb_udc_connect_control(udc);
+		schedule_work(&udc->vbus_work);
 	}
 }
 EXPORT_SYMBOL_GPL(usb_udc_vbus_handler);
@@ -1328,6 +1348,7 @@ int usb_add_gadget(struct usb_gadget *gadget)
 	mutex_lock(&udc_lock);
 	list_add_tail(&udc->list, &udc_list);
 	mutex_unlock(&udc_lock);
+	INIT_WORK(&udc->vbus_work, vbus_event_work);
 
 	ret = device_add(&udc->dev);
 	if (ret)
@@ -1459,6 +1480,7 @@ void usb_del_gadget(struct usb_gadget *gadget)
 	flush_work(&gadget->work);
 	device_del(&gadget->dev);
 	ida_free(&gadget_id_numbers, gadget->id_number);
+	cancel_work_sync(&udc->vbus_work);
 	device_unregister(&udc->dev);
 }
 EXPORT_SYMBOL_GPL(usb_del_gadget);
@@ -1527,6 +1549,7 @@ static int gadget_bind_driver(struct device *dev)
 	if (ret)
 		goto err_start;
 	usb_gadget_enable_async_callbacks(udc);
+	udc->allow_connect = true;
 	usb_udc_connect_control(udc);
 
 	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
@@ -1558,6 +1581,8 @@ static void gadget_unbind_driver(struct device *dev)
 
 	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
 
+	udc->allow_connect = false;
+	cancel_work_sync(&udc->vbus_work);
 	usb_gadget_disconnect(gadget);
 	usb_gadget_disable_async_callbacks(udc);
 	if (gadget->irq)

base-commit: d37537a1f7cf09e304fe7993cb5e732534a0fb22
-- 
2.41.0.162.gfafddb0af9-goog

