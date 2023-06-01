Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79DF719105
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 05:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjFADLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 23:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjFADKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 23:10:43 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA65012F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 20:10:32 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-64fa459504aso183779b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 20:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685589032; x=1688181032;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KsoozzYRQMf4DTV7Un2XyzrXR0h8VX0m8PvEcef8Os8=;
        b=s2eFhbqh/2IvjRDc8KIQSPuyQ6J5ZwW6l9E9NLOIq2GqpuBSxF5zR3tJ4DUtDZbq87
         i8NjCRnLuA8HhVvGyEAuljqvZKl4QLR534im67oIaxyvyaRhfgKtzhD6mp/cmaKBPgD7
         BdE0KyGvHhzFzcXLlSiqY87LHCK+nw/5V/UkyMXDdszMA6QYmViodVoywZoKKv4FaSHK
         8P4Az9kMhMT+Cef6upLNNnBbkrum5bUTS96nXAJRIj32XiQfr7l/8BZIVFSgV26D0CM1
         9ZwyY2EqJCwJGu7q0n9oppIUAg2u/LpEYEphkJY0HknoNYy14lgZMq+cjlwxQ3WbOqSy
         mB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685589032; x=1688181032;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KsoozzYRQMf4DTV7Un2XyzrXR0h8VX0m8PvEcef8Os8=;
        b=Jcx+GaVORWiM5Fy3a5iSM9u9MlAWq4My3qopteCXKQaafwoUk46G/ofdckKE7oWhvH
         qNznH8vRupdszDzEu6cUtye/LKEvuTE5XQAcaYqOqL/GvNvue0FhEEOh3brpC66FNlJ9
         h3y5MUlL/gOUSYWR9uRskfcev5Y5JQHah7A2IxSlUXM7/hUCaJu+5PaYTkfrGd2iBcCk
         N63IDeYt27h8yaY4OGuhbHSqiN75G+LxPcxEW4UH57PoyYLnlGQ/01LhodnWf19JzWwK
         8ozeMZwqixLM6etEwaa9O0wDesLKpWT5Gb7zT4Wi5v0xsqPj7fkoZ93CMT5LZWFsCw1m
         RX2A==
X-Gm-Message-State: AC+VfDyaOzseQn0CeflhMw/yY9XjlYrXgMF0kRbcElkKpQDskJtcl8aC
        iBUZmqm9qkgIgTIPIcPD5kYKtwvA03o=
X-Google-Smtp-Source: ACHHUZ7gv15vVvyt6AVxuBSl9wTIMQpxfH74C6zdoIq2tFxEAibMRAr0HV3DTIHnYZbc04YsHoQptbR6ok8=
X-Received: from badhri.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6442])
 (user=badhri job=sendgmr) by 2002:a63:5946:0:b0:52c:b362:1895 with SMTP id
 j6-20020a635946000000b0052cb3621895mr1439104pgm.3.1685589032185; Wed, 31 May
 2023 20:10:32 -0700 (PDT)
Date:   Thu,  1 Jun 2023 03:10:27 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230601031028.544244-1-badhri@google.com>
Subject: [PATCH v6 1/2] usb: gadget: udc: core: Offload usb_udc_vbus_handler processing
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

base-commit: 922c0cb578ac9104a22c11a093cc1e0575c35a39
-- 
2.41.0.rc0.172.g3f132b7071-goog

