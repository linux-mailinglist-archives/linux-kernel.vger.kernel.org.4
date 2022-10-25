Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077A160CB3E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiJYLtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiJYLtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:49:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485FA17F678
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 04:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fT2+bpegZwRyx8Q7ZkOxmG8+LPDfOkewwsIOnA+YqWI=; b=kBhVEJn2IFAbcUnRrNsyhiqPO4
        QI3u/LVm/yieRj4xbC/glA85hPuo3YQJiT0qoM2Gycntrnw0DhdyF016U0VSi79ObNXzjzcp2oyt9
        /xO5plk9+eUEZ3neEiQ8VZvfUPV7ajISJpcz/1BH7MSvk3b4P+Yec9hV3a/MPiWXNee0aouBGmn4I
        FBpye+ueiswVFfF+6oQotrdCf+g5rwfPurymNnkp60l2THsImOT+axAbq6ahn+q87xn8TcCOYNnzm
        zAtvtRbV2lRHx6AyBDBgApt1c1KaWsx/z9WuGZGV+l5V4LvuTs2jkFSeqHK6Oe3a8o0VzQ2zPgBQE
        G4AijHhQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onIQQ-006It7-LO; Tue, 25 Oct 2022 11:48:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4B655300169;
        Tue, 25 Oct 2022 13:48:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3116C2C43B4C2; Tue, 25 Oct 2022 13:48:53 +0200 (CEST)
Date:   Tue, 25 Oct 2022 13:48:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Ting11 Wang =?utf-8?B?546L5am3?= <wangting11@xiaomi.com>
Subject: Re: [PATCH v3 2/5] locking/rwsem: Limit # of null owner retries for
 handoff writer
Message-ID: <Y1fNJZ9SALWlmoon@hirez.programming.kicks-ass.net>
References: <20221017211356.333862-1-longman@redhat.com>
 <20221017211356.333862-3-longman@redhat.com>
 <Y1aTpYba1Wwly48+@hirez.programming.kicks-ass.net>
 <980d882c-01b8-2ce1-663f-41a8a337f350@redhat.com>
 <Y1fG7nQxiLyKIhQ6@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1fG7nQxiLyKIhQ6@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 01:22:22PM +0200, Peter Zijlstra wrote:

> Funny, I find the former approach much saner. Disabling preemption
> around the whole thing fixes the fundamental problem while spin-limiting
> is a band-aid.
> 
> Note how rwsem_write_trylock() already does preempt_disable(), having
> the read-side do something similar only makes sense.

Something like the completely untested below perhaps...


diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 44873594de03..350fb004b0fb 100644
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
@@ -717,7 +714,6 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 		return false;
 	}
 
-	preempt_disable();
 	/*
 	 * Disable preemption is equal to the RCU read-side crital section,
 	 * thus the task_strcut structure won't go away.
@@ -729,7 +725,6 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 	if ((flags & RWSEM_NONSPINNABLE) ||
 	    (owner && !(flags & RWSEM_READER_OWNED) && !owner_on_cpu(owner)))
 		ret = false;
-	preempt_enable();
 
 	lockevent_cond_inc(rwsem_opt_fail, !ret);
 	return ret;
@@ -829,8 +824,6 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 	int loop = 0;
 	u64 rspin_threshold = 0;
 
-	preempt_disable();
-
 	/* sem->wait_lock should not be held when doing optimistic spinning */
 	if (!osq_lock(&sem->osq))
 		goto done;
@@ -938,7 +931,6 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 	}
 	osq_unlock(&sem->osq);
 done:
-	preempt_enable();
 	lockevent_cond_inc(rwsem_opt_fail, !taken);
 	return taken;
 }
@@ -1092,7 +1084,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 			/* Ordered by sem->wait_lock against rwsem_mark_wake(). */
 			break;
 		}
-		schedule();
+		schedule_preempt_disabled();
 		lockevent_inc(rwsem_sleep_reader);
 	}
 
@@ -1179,15 +1171,12 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
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
@@ -1254,14 +1243,20 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
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
@@ -1281,19 +1276,23 @@ static inline int __down_read_killable(struct rw_semaphore *sem)
 
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
@@ -1301,10 +1300,14 @@ static inline int __down_read_trylock(struct rw_semaphore *sem)
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
@@ -1321,8 +1324,14 @@ static inline int __down_write_killable(struct rw_semaphore *sem)
 
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
