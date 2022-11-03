Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22A8618781
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbiKCSbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiKCSap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:30:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB3C63EB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 11:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667500187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QeVhMTv4WeHhoSDG61naFzwv8taUrm36WiOql1W/sjc=;
        b=fl31Wi8oTyMQLYOqpecDj9gd0+Ij6+WHCirIoia0rhYMhpBbA2TriYN06gi9ANbSA7BQKm
        kL1UiR2mi1QivJb6R6khXIi+U7hkSZHVXgOBt7Dk6DIihjb/rSt4M1mMEfOJyh8G/7i83Y
        bWz/7VJ5ZFyBCrJqAmSZCbyh/1tgUu0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-413-hDkW7RqPMfy-zfxVt6GxHQ-1; Thu, 03 Nov 2022 14:29:46 -0400
X-MC-Unique: hDkW7RqPMfy-zfxVt6GxHQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4BDF800B23;
        Thu,  3 Nov 2022 18:29:44 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 647FE1121325;
        Thu,  3 Nov 2022 18:29:44 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        =?UTF-8?q?Ting11=20Wang=20=E7=8E=8B=E5=A9=B7?= 
        <wangting11@xiaomi.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH v5 3/6] locking/rwsem: Disable preemption at all down_write*() and up_write() code paths
Date:   Thu,  3 Nov 2022 14:29:33 -0400
Message-Id: <20221103182936.217120-4-longman@redhat.com>
In-Reply-To: <20221103182936.217120-1-longman@redhat.com>
References: <20221103182936.217120-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous patch has disabled preemption at all the down_read()
and up_read() code paths. For symmetry, this patch extends commit
48dfb5d2560d ("locking/rwsem: Disable preemption while trying for rwsem
lock") to have preemption disabled at all the down_write() and up_write()
code path including downgrade_write().

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index ebaff8a87e1d..2953fa4dd790 100644
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
@@ -1310,10 +1299,14 @@ static inline int __down_read_trylock(struct rw_semaphore *sem)
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
+	preempt_enable();
 
 	return 0;
 }
@@ -1330,8 +1323,14 @@ static inline int __down_write_killable(struct rw_semaphore *sem)
 
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
@@ -1374,9 +1373,9 @@ static inline void __up_write(struct rw_semaphore *sem)
 	preempt_disable();
 	rwsem_clear_owner(sem);
 	tmp = atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED, &sem->count);
-	preempt_enable();
 	if (unlikely(tmp & RWSEM_FLAG_WAITERS))
 		rwsem_wake(sem);
+	preempt_enable();
 }
 
 /*
@@ -1394,11 +1393,13 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
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
-- 
2.31.1

