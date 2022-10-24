Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EA0609F6A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiJXKz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiJXKy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:54:58 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400D513EAB;
        Mon, 24 Oct 2022 03:54:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DB1BE61D87;
        Mon, 24 Oct 2022 12:44:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1666608275; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=wKMtxoQSqU1ebaoGnDGb+/Jm2lZqqN7MOioiczni8Q4=;
        b=Gv8xGyN41xfixWyk3MSUHYHC7pQsBIjt/5gQfFsrP+8A+mdStUayYM0dMm4r9Tq3xa3+RG
        XLgriCxoVzZ/UnXb7hvMiJl2uZJiKEYCl5QwMi7DuHVlGZouJ2jkOXFGMMvzURJ9rfwaxF
        QM9M59BVerI6FHPuqCK/nretNaZAtZaPo32eY0uMJsxs6RJhRwClq4IoVgexxFR96mz9L/
        Ud/SeXsu/XDhW9RibK7QU8l/8DiTQxiKUxrhlRiFGSzrDpFf32JxwQLNQeiWwB114jtKs7
        oJm2a1X1GKTlfDqmrwXrkPkLZcbg/InzJPn1FqI5iAWS/oorsTkZckHxJ6jQZA==
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Cc:     Tejun Heo <tj@kernel.org>, Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 8/9] workqueue: Use rcuwait for wq_manager_wait
Date:   Mon, 24 Oct 2022 12:44:24 +0200
Message-Id: <20221024104425.16423-9-wagi@monom.org>
In-Reply-To: <20221024104425.16423-1-wagi@monom.org>
References: <20221024104425.16423-1-wagi@monom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.19.255-rt114-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Upstream commit d8bb65ab70f702531aaaa11d9710f9450078e295

The workqueue code has it's internal spinlock (pool::lock) and also
implicit spinlock usage in the wq_manager waitqueue. These spinlocks
are converted to 'sleeping' spinlocks on a RT-kernel.

Workqueue functions can be invoked from contexts which are truly atomic
even on a PREEMPT_RT enabled kernel. Taking sleeping locks from such
contexts is forbidden.

pool::lock can be converted to a raw spinlock as the lock held times
are short. But the workqueue manager waitqueue is handled inside of
pool::lock held regions which again violates the lock nesting rules
of raw and regular spinlocks.

The manager waitqueue has no special requirements like custom wakeup
callbacks or mass wakeups. While it does not use exclusive wait mode
explicitly there is no strict requirement to queue the waiters in a
particular order as there is only one waiter at a time.

This allows to replace the waitqueue with rcuwait which solves the
locking problem because rcuwait relies on existing locking.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[wagi: Updated context as v4.19-rt was using swait]
Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 kernel/workqueue.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index d97c2ad8dc08..a3777fe1e224 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -50,6 +50,7 @@
 #include <linux/sched/isolation.h>
 #include <linux/nmi.h>
 #include <linux/kvm_para.h>
+#include <linux/rcuwait.h>
 
 #include "workqueue_internal.h"
 
@@ -299,7 +300,8 @@ static struct workqueue_attrs *wq_update_unbound_numa_attrs_buf;
 static DEFINE_MUTEX(wq_pool_mutex);	/* protects pools and workqueues list */
 static DEFINE_MUTEX(wq_pool_attach_mutex); /* protects worker attach/detach */
 static DEFINE_RAW_SPINLOCK(wq_mayday_lock);	/* protects wq->maydays list */
-static DECLARE_SWAIT_QUEUE_HEAD(wq_manager_wait); /* wait for manager to go away */
+/* wait for manager to go away */
+static struct rcuwait manager_wait = __RCUWAIT_INITIALIZER(manager_wait);
 
 static LIST_HEAD(workqueues);		/* PR: list of all workqueues */
 static bool workqueue_freezing;		/* PL: have wqs started freezing? */
@@ -2023,7 +2025,7 @@ static bool manage_workers(struct worker *worker)
 
 	pool->manager = NULL;
 	pool->flags &= ~POOL_MANAGER_ACTIVE;
-	swake_up_one(&wq_manager_wait);
+	rcuwait_wake_up(&manager_wait);
 	return true;
 }
 
@@ -3344,6 +3346,18 @@ static void rcu_free_pool(struct rcu_head *rcu)
 	kfree(pool);
 }
 
+/* This returns with the lock held on success (pool manager is inactive). */
+static bool wq_manager_inactive(struct worker_pool *pool)
+{
+	raw_spin_lock_irq(&pool->lock);
+
+	if (pool->flags & POOL_MANAGER_ACTIVE) {
+		raw_spin_unlock_irq(&pool->lock);
+		return false;
+	}
+	return true;
+}
+
 /**
  * put_unbound_pool - put a worker_pool
  * @pool: worker_pool to put
@@ -3379,10 +3393,12 @@ static void put_unbound_pool(struct worker_pool *pool)
 	 * Become the manager and destroy all workers.  This prevents
 	 * @pool's workers from blocking on attach_mutex.  We're the last
 	 * manager and @pool gets freed with the flag set.
+	 * Because of how wq_manager_inactive() works, we will hold the
+	 * spinlock after a successful wait.
 	 */
 	raw_spin_lock_irq(&pool->lock);
-	swait_event_lock_irq(wq_manager_wait,
-			    !(pool->flags & POOL_MANAGER_ACTIVE), pool->lock);
+	rcuwait_wait_event(&manager_wait, wq_manager_inactive(pool),
+			   TASK_UNINTERRUPTIBLE);
 	pool->flags |= POOL_MANAGER_ACTIVE;
 
 	while ((worker = first_idle_worker(pool)))
-- 
2.38.0

