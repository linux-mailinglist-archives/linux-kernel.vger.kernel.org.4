Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46A15B3F9F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiIIT3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiIIT3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:29:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B632A1238F1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 12:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662751737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=scB/A0eqZPNbc0FcobF2auT2+RpNVwKOnjb7JpfOEKI=;
        b=URueGIP6mpMqET43WqVODqkjyUeSqlj1vf4LFGe3d93lEUPY9GZUaSw2vHUfyUzHxCfUGd
        XVVhPK64sgjhAU8Lmv9SX32GwPfY2ZKj7YOzg5Z0MtkbM22Vu2bmxqI/P67Hm85wCUNQmX
        yfGKMSdJcK5rnWdGMgC1sBFCGqAtM8Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-NcN6HpSwPBGKK6oRUzuLYw-1; Fri, 09 Sep 2022 15:28:56 -0400
X-MC-Unique: NcN6HpSwPBGKK6oRUzuLYw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8BED08032FB;
        Fri,  9 Sep 2022 19:28:55 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 435491415102;
        Fri,  9 Sep 2022 19:28:55 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH v2] locking/semaphore: Use wake_q to wake up processes outside lock critical section
Date:   Fri,  9 Sep 2022 15:28:48 -0400
Message-Id: <20220909192848.963982-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was found that a circular lock dependency can happen with the
following locking sequence:

   +--> (console_sem).lock --> &p->pi_lock --> &rq->__lock --+
   |                                                         |
   +---------------------------------------------------------+

The &p->pi_lock --> &rq->__lock sequence is very common in all the
task_rq_lock() calls.

The &rq->__lock --> (console_sem).lock sequence happens when the
scheduler code calling printk() or more likely the various WARN*()
macros while holding the rq lock. The (console_sem).lock is actually
a raw spinlock guarding the semaphore. In the particular lockdep splat
that I saw, it was caused by SCHED_WARN_ON() call in update_rq_clock().
To work around this locking sequence, we may have to ban all WARN*()
calls when the rq lock is held, which may be too restrictive, or we
may have to add a WARN_DEFERRED() call and modify all the call sites
to use it.

Even then, a deferred printk or WARN function may still call
console_trylock() which may, in turn, calls up_console_sem() leading
to this locking sequence.

The other ((console_sem).lock --> &p->pi_lock) locking sequence
was caused by the fact that the semaphore up() function is calling
wake_up_process() while holding the semaphore raw spinlock. This lockiing
sequence can be easily eliminated by moving the wake_up_processs()
call out of the raw spinlock critical section using wake_q which is
what this patch implements. That is the easiest and the most certain
way to break this circular locking sequence.

v1: https://lore.kernel.org/lkml/20220118153254.358748-1-longman@redhat.com/

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/semaphore.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
index f2654d2fe43a..b4b817451dd7 100644
--- a/kernel/locking/semaphore.c
+++ b/kernel/locking/semaphore.c
@@ -29,6 +29,7 @@
 #include <linux/export.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/wake_q.h>
 #include <linux/semaphore.h>
 #include <linux/spinlock.h>
 #include <linux/ftrace.h>
@@ -38,7 +39,7 @@ static noinline void __down(struct semaphore *sem);
 static noinline int __down_interruptible(struct semaphore *sem);
 static noinline int __down_killable(struct semaphore *sem);
 static noinline int __down_timeout(struct semaphore *sem, long timeout);
-static noinline void __up(struct semaphore *sem);
+static noinline void __up(struct semaphore *sem, struct wake_q_head *wake_q);
 
 /**
  * down - acquire the semaphore
@@ -183,13 +184,16 @@ EXPORT_SYMBOL(down_timeout);
 void up(struct semaphore *sem)
 {
 	unsigned long flags;
+	DEFINE_WAKE_Q(wake_q);
 
 	raw_spin_lock_irqsave(&sem->lock, flags);
 	if (likely(list_empty(&sem->wait_list)))
 		sem->count++;
 	else
-		__up(sem);
+		__up(sem, &wake_q);
 	raw_spin_unlock_irqrestore(&sem->lock, flags);
+	if (!wake_q_empty(&wake_q))
+		wake_up_q(&wake_q);
 }
 EXPORT_SYMBOL(up);
 
@@ -269,11 +273,12 @@ static noinline int __sched __down_timeout(struct semaphore *sem, long timeout)
 	return __down_common(sem, TASK_UNINTERRUPTIBLE, timeout);
 }
 
-static noinline void __sched __up(struct semaphore *sem)
+static noinline void __sched __up(struct semaphore *sem,
+				  struct wake_q_head *wake_q)
 {
 	struct semaphore_waiter *waiter = list_first_entry(&sem->wait_list,
 						struct semaphore_waiter, list);
 	list_del(&waiter->list);
 	waiter->up = true;
-	wake_up_process(waiter->task);
+	wake_q_add(wake_q, waiter->task);
 }
-- 
2.31.1

