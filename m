Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E816616976
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiKBQmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiKBQmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:42:03 -0400
Received: from mx1.veeam.com (mx1.veeam.com [216.253.77.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B672ED45;
        Wed,  2 Nov 2022 09:37:04 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.veeam.com (Postfix) with ESMTPS id 7717241D4F;
        Wed,  2 Nov 2022 11:52:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx1-2022; t=1667404332;
        bh=TyNzmYDcfAr7FLJZ9aVsP79ngrCxgm8xxrHZVRSY9WY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=as62dqzWBh1vxcxNsCa3zF14UgbxfjNje9a6h1T18NtR7lPBPoiK9dYEw8opxRVB5
         ZA6n2kr85g0sbyf2FLWVUsDr86lAxpSnKev8KNhJLPoi1td5cBkJ3taGEyUP2HP+5d
         TrddiSS+QHUGCQoo4X6dK9CBHmgVpriV/wJQBOhZoC3skfTHNRc+rej+opKSdmaXUa
         16ImaiDSeRcRcc5BvuyKNiO1CknlvC1SnAxwgQ50/RmBBW2g7i4Z+qplSR6jirOrcO
         pj7v4eJBDnP2aZsbYbhFKnKoO2Ey1EHMKz4nPIEnfnxuWingqkW+XN0Xi0Rl9AxjA2
         Yf3u8skTs20PQ==
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Wed, 2 Nov 2022 16:51:33 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hch@infradead.org>,
        <sergei.shtepa@veeam.com>
Subject: [PATCH v1 12/17] lock, blksnap: event queue from the difference storage
Date:   Wed, 2 Nov 2022 16:50:56 +0100
Message-ID: <20221102155101.4550-13-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221102155101.4550-1-sergei.shtepa@veeam.com>
References: <20221102155101.4550-1-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A292403155666726A
X-Veeam-MMEX: True
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

