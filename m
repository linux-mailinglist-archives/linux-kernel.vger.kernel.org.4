Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AB5708EDB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 06:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjESEaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 00:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjESEaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 00:30:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CD510EF
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 21:30:47 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba81b238ee8so5538370276.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 21:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684470647; x=1687062647;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9wMw9NBCOXQpnYozNF03rhtPLakaQFpY8x0F4Xseqzs=;
        b=zfww3erdcLVXy5ofhRbVKFnFTvDb2mvGTTxN3Ou9GG7SRPn5Q5CEqmuw7PCWSBmmGk
         NHjx1vLyeDeVLDephf71Pz8+0eJhSmFPd/zIOCdJh1KEin7rm4rp1knFYJEMQ/TEcoso
         S1YcJFr4dyZtcZkqa2zYYyMiFl6dMKvbV9e1URxY0QUBQLnLbl92IpLr0jNWYB9U/c6B
         bhhpMgQKGovmrTJp5cwWO7EyRXaMtrzr0FTmA2BN6UeKHGkpSTWhnaZDqG1WwBgoXqrw
         SiY+whUyLL0pC7l5991Z2xCVLD0gVLZ299yhO8gyaqLrHz5wMEn2YkRWOU8MDnII5xcR
         uTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684470647; x=1687062647;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9wMw9NBCOXQpnYozNF03rhtPLakaQFpY8x0F4Xseqzs=;
        b=hqw/IwyTf8Z9LfMRmRydBavMfK5w6tfpHKlKgigWQDO+koE032ersUVUPovnthmBUh
         U1nrE9El4uNp7Q9p6GfeTdXa8yLaYxHI9o8LFSYgPISOhIM1CAKj5fFDabn9ZSg4Y+6h
         Ona0JeNx+2oFfZ1qg24umwGDbq6OEPdfRUi/xMtgFT1TN1MdBcx6TSSUFsZhHPMAFJY5
         03SPdIKpvIBn+GTFNPmgB3EyyHbIhIeiabjde2xw/ZDtQYv1vA5Arvxvd+y/gVLcPivo
         lB8jJF/v11tTopEBdwVN1LO1qlt4uoHVSBtC7eC6m0H5nqbzTRFY/epzrFOn2c1JYF40
         Np3g==
X-Gm-Message-State: AC+VfDzhijFopVZY09XpfdWqUHgYkmgu1AhgX9t4WzvYnewIgPnonI8N
        V3u2lWcQKLLzHGznF1abRyLgMcJ0+H0=
X-Google-Smtp-Source: ACHHUZ5kodqA+SVrPcbIFneynXHtSA3cICDNUc7JxqSnfWaEKY9+M3qIB7A62WnmJAWDIYoCkogwyGskcfY=
X-Received: from badhri.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6442])
 (user=badhri job=sendgmr) by 2002:a25:c74e:0:b0:ba8:8d92:caea with SMTP id
 w75-20020a25c74e000000b00ba88d92caeamr254357ybe.1.1684470646832; Thu, 18 May
 2023 21:30:46 -0700 (PDT)
Date:   Fri, 19 May 2023 04:30:41 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230519043041.1593578-1-badhri@google.com>
Subject: [PATCH v2] usb: gadget: udc: core: Offload usb_udc_vbus_handler processing
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Fixes: 0db213ea8eed ("usb: gadget: udc: core: Invoke usb_gadget_connect only when started")
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
---
 drivers/usb/gadget/udc/core.c | 63 +++++++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 69041cca5d24..ee612387b39c 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -41,6 +41,9 @@ static const struct bus_type gadget_bus_type;
  * functions. usb_gadget_connect_locked, usb_gadget_disconnect_locked,
  * usb_udc_connect_control_locked, usb_gadget_udc_start_locked, usb_gadget_udc_stop_locked are
  * called with this lock held.
+ * @vbus_events: list head for processing vbus updates on usb_udc_vbus_handler.
+ * @vbus_events_lock: protects vbus_events list
+ * @vbus_work: work item that invokes usb_udc_connect_control_locked.
  *
  * This represents the internal data structure which is used by the UDC-class
  * to hold information about udc driver and gadget together.
@@ -53,6 +56,19 @@ struct usb_udc {
 	bool				vbus;
 	bool				started;
 	struct mutex			connect_lock;
+	struct list_head		vbus_events;
+	spinlock_t			vbus_events_lock;
+	struct work_struct		vbus_work;
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
@@ -1134,6 +1150,30 @@ static int usb_udc_connect_control_locked(struct usb_udc *udc) __must_hold(&udc-
 	return ret;
 }
 
+static void vbus_event_work(struct work_struct *work)
+{
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
+		usb_udc_connect_control_locked(udc);
+		kfree(event);
+		mutex_unlock(&udc->connect_lock);
+		spin_lock_irqsave(&udc->vbus_events_lock, flags);
+	}
+	spin_unlock_irqrestore(&udc->vbus_events_lock, flags);
+}
+
 /**
  * usb_udc_vbus_handler - updates the udc core vbus status, and try to
  * connect or disconnect gadget
@@ -1146,13 +1186,21 @@ static int usb_udc_connect_control_locked(struct usb_udc *udc) __must_hold(&udc-
 void usb_udc_vbus_handler(struct usb_gadget *gadget, bool status)
 {
 	struct usb_udc *udc = gadget->udc;
+	struct vbus_event *vbus_event;
+	unsigned long flags;
 
-	mutex_lock(&udc->connect_lock);
-	if (udc) {
-		udc->vbus = status;
-		usb_udc_connect_control_locked(udc);
-	}
-	mutex_unlock(&udc->connect_lock);
+	if (!udc)
+		return;
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
 
@@ -1379,6 +1427,9 @@ int usb_add_gadget(struct usb_gadget *gadget)
 	udc->gadget = gadget;
 	gadget->udc = udc;
 	mutex_init(&udc->connect_lock);
+	INIT_LIST_HEAD(&udc->vbus_events);
+	spin_lock_init(&udc->vbus_events_lock);
+	INIT_WORK(&udc->vbus_work, vbus_event_work);
 
 	udc->started = false;
 

base-commit: a4422ff221429c600c3dc5d0394fb3738b89d040
-- 
2.40.1.698.g37aff9b760-goog

