Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCE27174A0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 06:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbjEaECQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 00:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjEaECJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 00:02:09 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A84107
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 21:02:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bad1c8dce48so8911805276.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 21:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685505727; x=1688097727;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FRShDzU+m20ot9o4O+80g75qyx0AzeQfhVYqf4ZY7r8=;
        b=Ql0coGq15Pj7nTlxZq2f/RivqyjWmPolPYZ2HZFcuekbbm33jfO2dDe82WO2v1/qbk
         /0rAWbwAhOEAeLqo+DBjfOUetbwAHYSr6SCT7UNmRnoKrZhODAzGy6rozWxzB0GFfoeK
         LDoujjTAbvrWNyIgH5c/Pg613GMixADgkWZf5GXNLKoofc9DJ5AkH5wzAL4ppeN/yd+t
         jXSLlKA9RdamVar9TI4EUuLsUSNbXVZbkRRlZQXHZ5/1cF7c2TQfTlUVFQWn+Knn4T5T
         b93NBITM+3BHDI02S2hws83FjuuCzNBdhptgbJvPXHSzwhPWaFmO42Jl5l5KXThnr0Xz
         FRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685505727; x=1688097727;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FRShDzU+m20ot9o4O+80g75qyx0AzeQfhVYqf4ZY7r8=;
        b=aq7SxycBvHJ8IV0kKj7scAeddtrGUUZyEbx3cCcAeqS3rldyCKHA+/R8tXQB9MM5TO
         bqzwtT7kw4sL3GWFGw4bua+0SmOlkEM1tBOAZtf1jPraS3vDw4fsYLuns3i80P1sZLi1
         qVLg69KDd89tVz92o83Z40mCvGuWXrPoZOT4YCy+kvMn7d1/8Hk8eB7AvzNyxwWhGQDp
         dndpOUl8akjc9ZKjS9evAZmBQB73HKzm/iRvWnm87aAUh2vxiHUYN1TSi+yuq7ery6nv
         H89E2lfLgQOBIODRVZZraQO/hroQT/CyVpna7iY21zxsnOzY4BeYJ5aVzFfzH0MGFwE7
         7Ezw==
X-Gm-Message-State: AC+VfDyEVHdQfmU7kBy5SDynjRFxgfOnUY+TRb8xVTRZUnDLwWai1Mly
        I2KP1PAy0N1XqXWgCP5SgpsFaSdiLqM=
X-Google-Smtp-Source: ACHHUZ4ub/AbluMPbZht6ZvhJeeDHG3ymN5X09VDEgsrBNofrc3dYiieroVxZdqj+lnI/TXtJaCBv3cEWgk=
X-Received: from badhri.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6442])
 (user=badhri job=sendgmr) by 2002:a5b:14f:0:b0:bac:faf4:78fd with SMTP id
 c15-20020a5b014f000000b00bacfaf478fdmr1794911ybp.7.1685505727275; Tue, 30 May
 2023 21:02:07 -0700 (PDT)
Date:   Wed, 31 May 2023 04:02:01 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230531040203.19295-1-badhri@google.com>
Subject: [PATCH v5 1/3] usb: gadget: udc: core: Offload usb_udc_vbus_handler processing
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

usb_udc_vbus_handler() can be invoked from interrupt context by irq
handlers of the gadget drivers, however, usb_udc_connect_control() has
to run in non-atomic context due to the following:
a. Some of the gadget driver implementations expect the ->pullup
   callback to be invoked in non-atomic context.
b. usb_gadget_disconnect() acquires udc_lock which is a mutex.

Hence offload invocation of usb_udc_connect_control()
to workqueue.

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
---
 drivers/usb/gadget/udc/core.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 52e6d2e84e35..44a9f32679b5 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -48,6 +48,7 @@ struct usb_udc {
 	struct list_head		list;
 	bool				vbus;
 	bool				started;
+	struct work_struct		vbus_work;
 };
 
 static struct class *udc_class;
@@ -1086,6 +1087,13 @@ static void usb_udc_connect_control(struct usb_udc *udc)
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
@@ -1094,6 +1102,13 @@ static void usb_udc_connect_control(struct usb_udc *udc)
  *
  * The udc driver calls it when it wants to connect or disconnect gadget
  * according to vbus status.
+ *
+ * This function can be invoked from interrupt context by irq handlers of the gadget drivers,
+ * however, usb_udc_connect_control() has to run in non-atomic context due to the following:
+ * a. Some of the gadget driver implementations expect the ->pullup callback to be invoked in
+ * non-atomic context.
+ * b. usb_gadget_disconnect() acquires udc_lock which is a mutex.
+ * Hence offload invocation of usb_udc_connect_control() to workqueue.
  */
 void usb_udc_vbus_handler(struct usb_gadget *gadget, bool status)
 {
@@ -1101,7 +1116,7 @@ void usb_udc_vbus_handler(struct usb_gadget *gadget, bool status)
 
 	if (udc) {
 		udc->vbus = status;
-		usb_udc_connect_control(udc);
+		schedule_work(&udc->vbus_work);
 	}
 }
 EXPORT_SYMBOL_GPL(usb_udc_vbus_handler);
@@ -1328,6 +1343,7 @@ int usb_add_gadget(struct usb_gadget *gadget)
 	mutex_lock(&udc_lock);
 	list_add_tail(&udc->list, &udc_list);
 	mutex_unlock(&udc_lock);
+	INIT_WORK(&udc->vbus_work, vbus_event_work);
 
 	ret = device_add(&udc->dev);
 	if (ret)
@@ -1558,6 +1574,7 @@ static void gadget_unbind_driver(struct device *dev)
 
 	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
 
+	cancel_work_sync(&udc->vbus_work);
 	usb_gadget_disconnect(gadget);
 	usb_gadget_disable_async_callbacks(udc);
 	if (gadget->irq)

base-commit: 046895105d9666ab56e86ce8dd9786f8003125c6
-- 
2.41.0.rc0.172.g3f132b7071-goog

