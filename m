Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AAF67C1DD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236390AbjAZAi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbjAZAiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:38:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4184A20A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674693455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xoPc7h2MXQbO5QKH8EbA+GwoYeGdGi4ZmgSUMsdtLlg=;
        b=S/8vIwGOglPbaIcfru79YvCWqX/fjZB+2dBnNeY98PwwUoBLwaQXU1JLmmrmnpOZMV1Ipf
        ED2Jhpk27ICzkx9WLyCbMatBAGHoZ8VIsijeul/iuvH4UFuzTwK4MnWOUwrmTfOEoJ6WmN
        vV3LE8dzGrBvGZOvz/0i4u9tgmOWuRY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-84-E6wcanBpMi270ebRjSI_LQ-1; Wed, 25 Jan 2023 19:37:32 -0500
X-MC-Unique: E6wcanBpMi270ebRjSI_LQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 91CBE85C069;
        Thu, 26 Jan 2023 00:37:31 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 177BB492C14;
        Thu, 26 Jan 2023 00:37:31 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        =?UTF-8?q?Ting11=20Wang=20=E7=8E=8B=E5=A9=B7?= 
        <wangting11@xiaomi.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH v7 3/4] locking/rwsem: Disable preemption at all down_write*() and up_write() code paths
Date:   Wed, 25 Jan 2023 19:36:27 -0500
Message-Id: <20230126003628.365092-4-longman@redhat.com>
In-Reply-To: <20230126003628.365092-1-longman@redhat.com>
References: <20230126003628.365092-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous patch has disabled preemption at all the down_read() and
up_read() code paths. For symmetry, this patch extends commit 48dfb5d2560d
("locking/rwsem: Disable preemption while trying for rwsem lock")
to have preemption disabled at all the down_write() and up_write()
code path including downgrade_write().

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 84d5b649b95f..acb5a50309a1 100644
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
-- 
2.31.1

