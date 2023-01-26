Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5310667CA25
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237329AbjAZLix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237305AbjAZLis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:38:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A663BDBF;
        Thu, 26 Jan 2023 03:38:47 -0800 (PST)
Date:   Thu, 26 Jan 2023 11:38:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674733125;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cbK7nIGD/08H7Aeb4a9bD6tyPHJg6ETnqXE4EFES7nQ=;
        b=cJCqHT8VIYqRVRApNHeskZGd/veQQgUxMsKbgESkHFe/pILBhY3E+flaOGF4PEcl4dURke
        oiY0ob3zcFCMX5lIq6f1jMHbupePQ1FoJbGLaASxDu0yhDwBT8anY3+Jd829ewj3SmufuM
        Gb/AZU0wPGPriMUCGx+K05Dkco1NSue2pon5G4yH0zJxAdrsYFsDy9hqpBkejzvqqfH7BS
        9HnD6g/jalQxXyoawP6Wa8SmlOYb4tQ1IlLwd49K3j03lH8AZEg5baIDaKettyDby+OWBX
        jDO2OMhXB/kp1gEx+znZMZDHmTX/YyBd5ZKoH8YitarhnzpA5F9HxyzVwblHAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674733125;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cbK7nIGD/08H7Aeb4a9bD6tyPHJg6ETnqXE4EFES7nQ=;
        b=bXSr65vZ1IyuWmbQfE7Hh+b/4nQwLbCHC6Ik9QJINIFj5eLm7FA4j//ryUu06X+F9VIGa5
        Ouf5q25G12UxfgBQ==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rwsem: Disable preemption in all
 down_read*() and up_read() code paths
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230126003628.365092-3-longman@redhat.com>
References: <20230126003628.365092-3-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <167473312497.4906.10689090616417879897.tip-bot2@tip-bot2>
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

Commit-ID:     3f5245538a1964ae186ab7e1636020a41aa63143
Gitweb:        https://git.kernel.org/tip/3f5245538a1964ae186ab7e1636020a41aa63143
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Wed, 25 Jan 2023 19:36:26 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 26 Jan 2023 11:46:46 +01:00

locking/rwsem: Disable preemption in all down_read*() and up_read() code paths

Commit:

  91d2a812dfb9 ("locking/rwsem: Make handoff writer optimistically spin on owner")

... assumes that when the owner field is changed to NULL, the lock will
become free soon. But commit:

  48dfb5d2560d ("locking/rwsem: Disable preemption while trying for rwsem lock")

... disabled preemption when acquiring rwsem for write.

However, preemption has not yet been disabled when acquiring a read lock
on a rwsem.  So a reader can add a RWSEM_READER_BIAS to count without
setting owner to signal a reader, got preempted out by a RT task which
then spins in the writer slowpath as owner remains NULL leading to live lock.

One easy way to fix this problem is to disable preemption at all the
down_read*() and up_read() code paths as implemented in this patch.

Fixes: 91d2a812dfb9 ("locking/rwsem: Make handoff writer optimistically spin on owner")
Reported-by: Mukesh Ojha <quic_mojha@quicinc.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230126003628.365092-3-longman@redhat.com
---
 kernel/locking/rwsem.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index be2df9e..84d5b64 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1091,7 +1091,7 @@ queue:
 			/* Ordered by sem->wait_lock against rwsem_mark_wake(). */
 			break;
 		}
-		schedule();
+		schedule_preempt_disabled();
 		lockevent_inc(rwsem_sleep_reader);
 	}
 
@@ -1253,14 +1253,20 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
  */
 static inline int __down_read_common(struct rw_semaphore *sem, int state)
 {
+	int ret = 0;
 	long count;
 
+	preempt_disable();
 	if (!rwsem_read_trylock(sem, &count)) {
-		if (IS_ERR(rwsem_down_read_slowpath(sem, count, state)))
-			return -EINTR;
+		if (IS_ERR(rwsem_down_read_slowpath(sem, count, state))) {
+			ret = -EINTR;
+			goto out;
+		}
 		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	}
-	return 0;
+out:
+	preempt_enable();
+	return ret;
 }
 
 static inline void __down_read(struct rw_semaphore *sem)
@@ -1280,19 +1286,23 @@ static inline int __down_read_killable(struct rw_semaphore *sem)
 
 static inline int __down_read_trylock(struct rw_semaphore *sem)
 {
+	int ret = 0;
 	long tmp;
 
 	DEBUG_RWSEMS_WARN_ON(sem->magic != sem, sem);
 
+	preempt_disable();
 	tmp = atomic_long_read(&sem->count);
 	while (!(tmp & RWSEM_READ_FAILED_MASK)) {
 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
 						    tmp + RWSEM_READER_BIAS)) {
 			rwsem_set_reader_owned(sem);
-			return 1;
+			ret = 1;
+			break;
 		}
 	}
-	return 0;
+	preempt_enable();
+	return ret;
 }
 
 /*
@@ -1334,6 +1344,7 @@ static inline void __up_read(struct rw_semaphore *sem)
 	DEBUG_RWSEMS_WARN_ON(sem->magic != sem, sem);
 	DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 
+	preempt_disable();
 	rwsem_clear_reader_owned(sem);
 	tmp = atomic_long_add_return_release(-RWSEM_READER_BIAS, &sem->count);
 	DEBUG_RWSEMS_WARN_ON(tmp < 0, sem);
@@ -1342,6 +1353,7 @@ static inline void __up_read(struct rw_semaphore *sem)
 		clear_nonspinnable(sem);
 		rwsem_wake(sem);
 	}
+	preempt_enable();
 }
 
 /*
@@ -1661,6 +1673,12 @@ void down_read_non_owner(struct rw_semaphore *sem)
 {
 	might_sleep();
 	__down_read(sem);
+	/*
+	 * The owner value for a reader-owned lock is mostly for debugging
+	 * purpose only and is not critical to the correct functioning of
+	 * rwsem. So it is perfectly fine to set it in a preempt-enabled
+	 * context here.
+	 */
 	__rwsem_set_reader_owned(sem, NULL);
 }
 EXPORT_SYMBOL(down_read_non_owner);
