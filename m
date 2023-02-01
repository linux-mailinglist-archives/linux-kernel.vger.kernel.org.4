Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA01568675A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjBANqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjBANq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:46:29 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CE853B21
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 05:46:28 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4524D20854;
        Wed,  1 Feb 2023 13:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675259187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UMIp1XUOGkinGppK4yW7jmxHJrE36Zn5eG/6nPBk5J4=;
        b=YfVwTqpurRoZcEP1kKeiI+TEUdab7Coud7ASnU7knsacH4FnHx50SlDhCKv44XJElOv2/+
        L2kr+/9BLG2JWlVfFuJZy1kaXm0EVoCV2e1wDuDGds+H7IBhGecxci0EETN0d2MLTTTR3Q
        UAI3jIg+bXn9NJmPnKZVp2e1Bes2reQ=
Received: from alley.suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        by relay2.suse.de (Postfix) with ESMTP id F3C702C141;
        Wed,  1 Feb 2023 13:46:26 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Koutny <mkoutny@suse.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [RFC 2/5] workqueue: Warn when a new worker could not be created
Date:   Wed,  1 Feb 2023 14:45:40 +0100
Message-Id: <20230201134543.13687-3-pmladek@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230201134543.13687-1-pmladek@suse.com>
References: <20230201134543.13687-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The workqueue watchdog reports a lockup when there was not any progress
in the worker pool for a long time. The progress means that a pending
work item starts being proceed.

The progress is guaranteed by using idle workers or creating new workers
for pending work items.

There are several reasons why a new worker could not be created:

   + there is not enough memory

   + there is no free pool ID (IDR API)

   + the system reached PID limit

   + the process creating the new worker was interrupted

   + the last idle worker (manager) has not been scheduled for a long
     time. It was not able to even start creating the kthread.

None of these failures is reported at the moment. The only clue is that
show_one_worker_pool() prints that there is a manager. It is the last
idle worker that is responsible for creating a new one. But it is not
clear if create_worker() is repeatedly failing and why.

Make the debugging easier by printing warnings in create_worker().

The error code is important, especially from kthread_create_on_node().
It helps to distinguish the various reasons. For example, reaching
memory limit (-ENOMEM), other system limits (-EAGAIN), or process
interrupted (-EINTR).

Print the warnings only once during the stall. printk() might touch
the watchdog and prevent reaching the watchdog thresh. For example,
see touch_nmi_watchdog() in serial8250_console_write(). Anyway,
many of these failures are quite persistent. And it does not make
sense to report the same problem every second, see CREATE_COOLDOWN.

In addition print a message when create_worker() succeeded again.

Also print how many times it failed in the hung report when it
still keeps failing.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/workqueue.c | 82 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 77 insertions(+), 5 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 5419d12e56ae..ab109ef7a7c0 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1911,7 +1911,68 @@ static void worker_detach_from_pool(struct worker *worker)
 		complete(detach_completion);
 }
 
-/**
+static int create_worker_failed;
+static DEFINE_SPINLOCK(create_worker_failed_lock);
+
+static __printf(2, 3) __cold
+void __print_create_worker_failure(long err, const char *fmt, ...)
+{
+	spin_lock_irq(&create_worker_failed_lock);
+
+	/*
+	 * Report potentially repeated failures only once during a stall.
+	 * Otherwise, it might be noisy. Also slow serial console drivers
+	 * touch watchdogs so that more frequent messages would prevent
+	 * reaching the watchdog thresh.
+	 */
+	if (!create_worker_failed) {
+		va_list args;
+
+		va_start(args, fmt);
+		vprintk(fmt, args);
+		va_end(args);
+	}
+
+	create_worker_failed++;
+
+	spin_unlock_irq(&create_worker_failed_lock);
+}
+
+#define print_create_worker_failure(msg, err)	\
+	do {					\
+		long _err = err;		\
+						\
+		__print_create_worker_failure(_err, KERN_WARNING msg ":%pe\n", (void *)_err); \
+	} while (0)
+
+static void print_create_worker_success(void)
+{
+	spin_lock_irq(&create_worker_failed_lock);
+
+	if (create_worker_failed) {
+		pr_info("workqueue: Successfully created a worker after %d attempts\n",
+			create_worker_failed);
+	}
+	create_worker_failed = 0;
+
+	spin_unlock_irq(&create_worker_failed_lock);
+}
+
+static void print_create_worker_failed_num(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&create_worker_failed_lock, flags);
+
+	if (create_worker_failed) {
+		pr_info("workqueue: %d times failed to create a new worker since the last success\n",
+			create_worker_failed);
+	}
+
+	spin_unlock_irqrestore(&create_worker_failed_lock, flags);
+}
+
+ /**
  * create_worker - create a new workqueue worker
  * @pool: pool the new worker will belong to
  *
@@ -1931,12 +1992,16 @@ static struct worker *create_worker(struct worker_pool *pool)
 
 	/* ID is needed to determine kthread name */
 	id = ida_alloc(&pool->worker_ida, GFP_KERNEL);
-	if (id < 0)
+	if (id < 0) {
+		print_create_worker_failure("workqueue: Failed to allocate a pool ID", id);
 		return NULL;
+	}
 
 	worker = alloc_worker(pool->node);
-	if (!worker)
+	if (!worker) {
+		print_create_worker_failure("workqueue: Failed to allocate a worker", -ENOMEM);
 		goto fail;
+	}
 
 	worker->id = id;
 
@@ -1948,8 +2013,11 @@ static struct worker *create_worker(struct worker_pool *pool)
 
 	worker->task = kthread_create_on_node(worker_thread, worker, pool->node,
 					      "kworker/%s", id_buf);
-	if (IS_ERR(worker->task))
+	if (IS_ERR(worker->task)) {
+		print_create_worker_failure("workqueue: Failed to create a worker thread",
+					    PTR_ERR(worker->task));
 		goto fail;
+	}
 
 	set_user_nice(worker->task, pool->attrs->nice);
 	kthread_bind_mask(worker->task, pool->attrs->cpumask);
@@ -1964,6 +2032,8 @@ static struct worker *create_worker(struct worker_pool *pool)
 	wake_up_process(worker->task);
 	raw_spin_unlock_irq(&pool->lock);
 
+	print_create_worker_success();
+
 	return worker;
 
 fail:
@@ -5880,8 +5950,10 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 
 	rcu_read_unlock();
 
-	if (lockup_detected)
+	if (lockup_detected) {
+		print_create_worker_failed_num();
 		show_all_workqueues();
+	}
 
 	wq_watchdog_reset_touched();
 	mod_timer(&wq_watchdog_timer, jiffies + thresh);
-- 
2.35.3

