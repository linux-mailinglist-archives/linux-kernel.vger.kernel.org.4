Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B16467CA26
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237333AbjAZLi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237304AbjAZLis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:38:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9573401E;
        Thu, 26 Jan 2023 03:38:46 -0800 (PST)
Date:   Thu, 26 Jan 2023 11:38:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674733125;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gJLQqfA5vkDSUS4jl9BluXFKJ9xqyAl7hld0tHalXCg=;
        b=Dg5hXLl2ZmnEkpFUz/yAatMb+gRxJ3OgMX57DXUh1/Yk+FbWQg9VEbgzwyMc0grMUjwall
        SFoIuHwEsz1pFZVXOIC7EPBD4z7sKeE6RocabmXkw8n6PF5/THw/eVb0YyFYuXc65wIPwH
        l8c+bx/I6bJZwwzGtI150Ge4Q9TxijquSdfx3orTVLvhoH/LS+0KGUVAPN3dHbhxV/FqyP
        ajIaifHbRKdPRVvpY0xNc4LNhP558yOVMe4SVNVCbo3oxZbMgJwZTYoUtThed1nN+VC7pB
        +13zij2CBR0F/Q/wM+J8Cbp/qPC3z9n7GjfUCaUQwuM9ISgF94UzgqN5B+ovxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674733125;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gJLQqfA5vkDSUS4jl9BluXFKJ9xqyAl7hld0tHalXCg=;
        b=k+FeOJJFtoEjvNEJs6X7UfYlBgAlJbZfRfMFq/B87KISAj/CfVWd9SqO4/ru0kjvUxMHEH
        4r4OmDyqU7yM4NDQ==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rwsem: Disable preemption in all
 down_write*() and up_write() code paths
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230126003628.365092-4-longman@redhat.com>
References: <20230126003628.365092-4-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <167473312444.4906.10267318646906255601.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     1d61659ced6bd8881cf2fb5cbcb28f9541fc7430
Gitweb:        https://git.kernel.org/tip/1d61659ced6bd8881cf2fb5cbcb28f9541fc7430
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Wed, 25 Jan 2023 19:36:27 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 26 Jan 2023 11:46:46 +01:00

locking/rwsem: Disable preemption in all down_write*() and up_write() code paths

The previous patch has disabled preemption in all the down_read() and
up_read() code paths. For symmetry, this patch extends commit:

  48dfb5d2560d ("locking/rwsem: Disable preemption while trying for rwsem lock")

... to have preemption disabled in all the down_write() and up_write()
code paths, including downgrade_write().

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230126003628.365092-4-longman@redhat.com
---
 kernel/locking/rwsem.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 84d5b64..acb5a50 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -256,16 +256,13 @@ static inline bool rwsem_read_trylock(struct rw_semaphore *sem, long *cntp)
 static inline bool rwsem_write_trylock(struct rw_semaphore *sem)
 {
 	long tmp = RWSEM_UNLOCKED_VALUE;
-	bool ret = false;
 
-	preempt_disable();
 	if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp, RWSEM_WRITER_LOCKED)) {
 		rwsem_set_owner(sem);
-		ret = true;
+		return true;
 	}
 
-	preempt_enable();
-	return ret;
+	return false;
 }
 
 /*
@@ -716,7 +713,6 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 		return false;
 	}
 
-	preempt_disable();
 	/*
 	 * Disable preemption is equal to the RCU read-side crital section,
 	 * thus the task_strcut structure won't go away.
@@ -728,7 +724,6 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 	if ((flags & RWSEM_NONSPINNABLE) ||
 	    (owner && !(flags & RWSEM_READER_OWNED) && !owner_on_cpu(owner)))
 		ret = false;
-	preempt_enable();
 
 	lockevent_cond_inc(rwsem_opt_fail, !ret);
 	return ret;
@@ -828,8 +823,6 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 	int loop = 0;
 	u64 rspin_threshold = 0;
 
-	preempt_disable();
-
 	/* sem->wait_lock should not be held when doing optimistic spinning */
 	if (!osq_lock(&sem->osq))
 		goto done;
@@ -937,7 +930,6 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 	}
 	osq_unlock(&sem->osq);
 done:
-	preempt_enable();
 	lockevent_cond_inc(rwsem_opt_fail, !taken);
 	return taken;
 }
@@ -1178,15 +1170,12 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 		if (waiter.handoff_set) {
 			enum owner_state owner_state;
 
-			preempt_disable();
 			owner_state = rwsem_spin_on_owner(sem);
-			preempt_enable();
-
 			if (owner_state == OWNER_NULL)
 				goto trylock_again;
 		}
 
-		schedule();
+		schedule_preempt_disabled();
 		lockevent_inc(rwsem_sleep_writer);
 		set_current_state(state);
 trylock_again:
@@ -1310,12 +1299,15 @@ static inline int __down_read_trylock(struct rw_semaphore *sem)
  */
 static inline int __down_write_common(struct rw_semaphore *sem, int state)
 {
+	int ret = 0;
+
+	preempt_disable();
 	if (unlikely(!rwsem_write_trylock(sem))) {
 		if (IS_ERR(rwsem_down_write_slowpath(sem, state)))
-			return -EINTR;
+			ret = -EINTR;
 	}
-
-	return 0;
+	preempt_enable();
+	return ret;
 }
 
 static inline void __down_write(struct rw_semaphore *sem)
@@ -1330,8 +1322,14 @@ static inline int __down_write_killable(struct rw_semaphore *sem)
 
 static inline int __down_write_trylock(struct rw_semaphore *sem)
 {
+	int ret;
+
+	preempt_disable();
 	DEBUG_RWSEMS_WARN_ON(sem->magic != sem, sem);
-	return rwsem_write_trylock(sem);
+	ret = rwsem_write_trylock(sem);
+	preempt_enable();
+
+	return ret;
 }
 
 /*
@@ -1374,9 +1372,9 @@ static inline void __up_write(struct rw_semaphore *sem)
 	preempt_disable();
 	rwsem_clear_owner(sem);
 	tmp = atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED, &sem->count);
-	preempt_enable();
 	if (unlikely(tmp & RWSEM_FLAG_WAITERS))
 		rwsem_wake(sem);
+	preempt_enable();
 }
 
 /*
@@ -1394,11 +1392,13 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
 	 * write side. As such, rely on RELEASE semantics.
 	 */
 	DEBUG_RWSEMS_WARN_ON(rwsem_owner(sem) != current, sem);
+	preempt_disable();
 	tmp = atomic_long_fetch_add_release(
 		-RWSEM_WRITER_LOCKED+RWSEM_READER_BIAS, &sem->count);
 	rwsem_set_reader_owned(sem);
 	if (tmp & RWSEM_FLAG_WAITERS)
 		rwsem_downgrade_wake(sem);
+	preempt_enable();
 }
 
 #else /* !CONFIG_PREEMPT_RT */
