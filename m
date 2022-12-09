Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3181564848F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiLIPEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiLIPEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:04:09 -0500
Received: from mx4.veeam.com (mx4.veeam.com [104.41.138.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7CD450B2;
        Fri,  9 Dec 2022 07:04:08 -0800 (PST)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 78B877D487;
        Fri,  9 Dec 2022 17:24:19 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx4-2022; t=1670595859;
        bh=TyNzmYDcfAr7FLJZ9aVsP79ngrCxgm8xxrHZVRSY9WY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=J9WFg399V2Em83U4EeFpibp3pkqwXE5vL0iC+ug2GjrT5hjQwjBOIzJrTI+1ixxfl
         3oVR5hzvzK4oMKD9dFH4w08k8T13GjfechVbPrn5fbqAAu1KZ/Bi20aT+q5hSnTH05
         QD8zKigU0VxhROOgE87ssCLD2cbH5GoEPeVd+Z/z4sp9ZDXURXHw414nZTU0E7M5OR
         bsDllcsJSY1T12klMUlDeFL+TFq/+YuJFP0T99R1168NUu10T9GCur8T48d5i0zWAM
         3wGRddgGfETnLOOPIFC6P6GUV/MyUAljZ1sQgKXHcCBDmHofeAb+ux5dpcEEj1AtoE
         JLnvS/8bsV+fQ==
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Fri, 9 Dec 2022 15:24:16 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <corbet@lwn.net>
CC:     <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH v2 15/21] block, blksnap: event queue from the difference storage
Date:   Fri, 9 Dec 2022 15:23:25 +0100
Message-ID: <20221209142331.26395-16-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221209142331.26395-1-sergei.shtepa@veeam.com>
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A2924031556627C62
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provides transmission of events from the difference storage to the user
process. Only two events are currently defined. The first is that there
are few free regions in the difference storage. The second is that the
request for a free region for storing differences failed with an error,
since there are no more free regions left in the difference storage
(the snapshot overflow state).

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/blksnap/event_queue.c | 86 +++++++++++++++++++++++++++++
 drivers/block/blksnap/event_queue.h | 63 +++++++++++++++++++++
 2 files changed, 149 insertions(+)
 create mode 100644 drivers/block/blksnap/event_queue.c
 create mode 100644 drivers/block/blksnap/event_queue.h

diff --git a/drivers/block/blksnap/event_queue.c b/drivers/block/blksnap/event_queue.c
new file mode 100644
index 000000000000..c91a81b3e3a8
--- /dev/null
+++ b/drivers/block/blksnap/event_queue.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME "-event_queue: " fmt
+
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include "event_queue.h"
+
+void event_queue_init(struct event_queue *event_queue)
+{
+	INIT_LIST_HEAD(&event_queue->list);
+	spin_lock_init(&event_queue->lock);
+	init_waitqueue_head(&event_queue->wq_head);
+}
+
+void event_queue_done(struct event_queue *event_queue)
+{
+	struct event *event;
+
+	spin_lock(&event_queue->lock);
+	while (!list_empty(&event_queue->list)) {
+		event = list_first_entry(&event_queue->list, struct event,
+					 link);
+		list_del(&event->link);
+		event_free(event);
+	}
+	spin_unlock(&event_queue->lock);
+}
+
+int event_gen(struct event_queue *event_queue, gfp_t flags, int code,
+	      const void *data, int data_size)
+{
+	struct event *event;
+
+	event = kzalloc(sizeof(struct event) + data_size, flags);
+	if (!event)
+		return -ENOMEM;
+
+	event->time = ktime_get();
+	event->code = code;
+	event->data_size = data_size;
+	memcpy(event->data, data, data_size);
+
+	pr_debug("Generate event: time=%lld code=%d data_size=%d\n",
+		 event->time, event->code, event->data_size);
+
+	spin_lock(&event_queue->lock);
+	list_add_tail(&event->link, &event_queue->list);
+	spin_unlock(&event_queue->lock);
+
+	wake_up(&event_queue->wq_head);
+	return 0;
+}
+
+struct event *event_wait(struct event_queue *event_queue,
+			 unsigned long timeout_ms)
+{
+	int ret;
+
+	ret = wait_event_interruptible_timeout(event_queue->wq_head,
+					       !list_empty(&event_queue->list),
+					       timeout_ms);
+
+	if (ret > 0) {
+		struct event *event;
+
+		spin_lock(&event_queue->lock);
+		event = list_first_entry(&event_queue->list, struct event,
+					 link);
+		list_del(&event->link);
+		spin_unlock(&event_queue->lock);
+
+		pr_debug("Event received: time=%lld code=%d\n", event->time,
+			 event->code);
+		return event;
+	}
+	if (ret == 0)
+		return ERR_PTR(-ENOENT);
+
+	if (ret == -ERESTARTSYS) {
+		pr_debug("event waiting interrupted\n");
+		return ERR_PTR(-EINTR);
+	}
+
+	pr_err("Failed to wait event. errno=%d\n", abs(ret));
+	return ERR_PTR(ret);
+}
diff --git a/drivers/block/blksnap/event_queue.h b/drivers/block/blksnap/event_queue.h
new file mode 100644
index 000000000000..d9aee081ab51
--- /dev/null
+++ b/drivers/block/blksnap/event_queue.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __BLK_SNAP_EVENT_QUEUE_H
+#define __BLK_SNAP_EVENT_QUEUE_H
+
+#include <linux/types.h>
+#include <linux/ktime.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+
+/**
+ * struct event - An event to be passed to the user space.
+ * @link:
+ *	The list header allows to combine events from the queue.
+ * @time:
+ *	A timestamp indicates when an event occurred.
+ * @code:
+ *	Event code.
+ * @data_size:
+ *	The number of bytes in the event data array.
+ * @data:
+ *	An array of event data.
+ *
+ * Events can be different, so they contain different data. The size of the
+ * data array is not defined exactly, but it has limitations. The size of
+ * the event structure may exceed the PAGE_SIZE.
+ */
+struct event {
+	struct list_head link;
+	ktime_t time;
+	int code;
+	int data_size;
+	char data[1]; /* up to PAGE_SIZE - sizeof(struct blk_snap_snapshot_event) */
+};
+
+/**
+ * struct event_queue - A queue of &struct event.
+ * @list:
+ *	Linked list for storing events.
+ * @lock:
+ *	Spinlock allows to guarantee safety of the linked list.
+ * @wq_head:
+ *	A wait queue allows to put a user thread in a waiting state until
+ *	an event appears in the linked list.
+ */
+struct event_queue {
+	struct list_head list;
+	spinlock_t lock;
+	struct wait_queue_head wq_head;
+};
+
+void event_queue_init(struct event_queue *event_queue);
+void event_queue_done(struct event_queue *event_queue);
+
+int event_gen(struct event_queue *event_queue, gfp_t flags, int code,
+	      const void *data, int data_size);
+struct event *event_wait(struct event_queue *event_queue,
+			 unsigned long timeout_ms);
+static inline void event_free(struct event *event)
+{
+	kfree(event);
+};
+#endif /* __BLK_SNAP_EVENT_QUEUE_H */
-- 
2.20.1

