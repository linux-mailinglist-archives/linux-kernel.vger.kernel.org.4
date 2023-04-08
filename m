Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6646DB7F2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 03:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjDHBOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 21:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDHBOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 21:14:41 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B13CA39
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 18:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1680916477;
        bh=SKER2uGKY5pCWg9GHljQXxLwWcywFOD3A1hiQAR0JM0=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=RoNlSmPcl6aoxGM3I6P1LQz+m8CVxPmEfB83kanFJvdf6H/93nmq3vbG1oKFb6gtz
         IVqytQEXmXTjSZs/XGbaKwvGNHNiiNxK2qx41SCY8LqgnvnYbBpjsjEdq+OFv3sH92
         iXykkBic1/UlHUcTx0H/+Ox/Uh8v4UmqoRxse304DsZ6/eSMJUrjq6BBLn032DBO54
         DLgZFKh4OCeE0BM2oy+tTNI1X/OGPfoQZvIW6DErXqpoEsPXVRxbjNnWNXNOd3/fOK
         WSVC7roFmt1jZxNHe32GOoADdIzUaXLq4mENZVo7uFkXvJ8139PTHL9bRjNGMw5L63
         T/rw6lHaJisQA==
Received: from [192.222.149.5] (192-222-149-5.qc.cable.ebox.net [192.222.149.5])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Ptchs1ZHGzty1;
        Fri,  7 Apr 2023 21:14:37 -0400 (EDT)
Message-ID: <3b4684ea-5c0d-376b-19cf-195684ec4e0e@efficios.com>
Date:   Fri, 7 Apr 2023 21:14:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH v3] sched: Fix performance regression introduced by
 mm_cid
Content-Language: en-US
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>,
        Olivier Dion <odion@efficios.com>, michael.christie@oracle.com
References: <20230405162635.225245-1-mathieu.desnoyers@efficios.com>
 <386a6e32-a746-9eb1-d5ae-e5bedaa8fc75@efficios.com>
 <20230406095122.GF386572@hirez.programming.kicks-ass.net>
 <fdaa7242-4ddd-fbe2-bc0e-6c62054dbde8@efficios.com>
In-Reply-To: <fdaa7242-4ddd-fbe2-bc0e-6c62054dbde8@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-07 19:50, Mathieu Desnoyers wrote:
[...]
> 
> Let's introduce task (Y) which has mm == src_task->mm and task (N) which 
> has
> mm != src_task->mm for the rest of the discussion.
> 
> Let's consider the scheduling state transitions we want to consider here.
> There are two scheduler state transitions on context switch we care about:
> 
> (TSA) Store to rq->curr with transition from (N) to (Y)
> 
> (TSB) Store to rq->curr with transition from (Y) to (N)
> 
> On the migrate-from side, there is one transition we care about:
> 
> (TMA) cmpxchg to *pcpu_cid to set the LAZY flag
> 
> There is also a transition to UNSET state which can be performed from all
> sides (scheduler, migrate-from). It is performed with a cmpxchg everywhere
> which guarantees that only a single thread will succeed:
> 
> (TMB) cmpxchg to *pcpu_cid to mark UNSET
> 
> Just to be clear (at the risk of repeating myself), what we do _not_ want
> to happen is a transition to UNSET when a thread is actively using the cid
> (property (1)). And ideally we do not want to leak a cid after migrating 
> the
> last task from a cpu (property (2)).
> 
> Let's looks at the relevant combinations of TSA/TSB, and TMA transitions.
> 
> Scenario A) (TSA)+(TMA) (from next task perspective)
> 
> CPU0                                                 CPU1
> 
> Context switch CS-1                                  Migrate-from
>    - store to rq->curr: (N)->(Y) (TSA)                - cmpxchg to 
> *pcpu_id to LAZY (TMA)
>       *** missing barrier ?? ***                        (implied barrier 
> after cmpxchg)
>    - prepare_task_switch()
>      - switch_mm_cid()
>        - mm_cid_get (next)
>          - READ_ONCE(*pcpu_cid)                       - 
> rcu_dereference(src_rq->curr)
> 
> This Dekker ensures that either task (Y) is observed by the 
> rcu_dereference() or the LAZY
> flag is observed by READ_ONCE(), or both are observed.
> 
> If task (Y) store is observed by rcu_dereference(), it means that there 
> is still
> an active task on the cpu. Migrate-from will therefore not transition to 
> UNSET, which
> fulfills property (1). That observed task will itself eventually need a 
> migrate-from
> to be migrated away from that cpu, which fulfills property (2).
> 
> If task (Y) is not observed, but the lazy flag is observed by 
> READ_ONCE(), it will
> move its state to UNSET, which clears the percpu cid perhaps uselessly 
> (which is not
> an issue for correctness). Because task (Y) is not observed, CPU1 can 
> move ahead to
> set the state to UNSET. Because moving state to UNSET is done with a 
> cmpxchg expecting
> that the old state has the LAZY flag set, only one thread will 
> successfully UNSET.
> 
> If both states (LAZY flag and task (Y)) are observed, the thread on CPU0 
> will observe
> the LAZY flag and transition to UNSET (perhaps uselessly), and CPU1 will 
> observe task
> (Y) and do nothing more, which is fine.
> 
> What we are effectively preventing with this Dekker is a scenario where 
> neither LAZY
> flag nor store (Y) are observed, which would fail property (1) because 
> this would
> UNSET a cid which is actively used.
> 
> 
> Scenario B) (TSB)+(TMA) (from prev task perspective)
> 
> CPU0                                                 CPU1
> 
> Context switch CS-1                                  Migrate-from
>    - store to rq->curr: (Y)->(N) (TSB)                - cmpxchg to 
> *pcpu_id to LAZY (TMA)
>      *** missing barrier ?? ***                         (implied barrier 
> after cmpxchg)
>    - prepare_task_switch()
>      - switch_mm_cid()
>        - cid_put_lazy() (prev)
>          - READ_ONCE(*pcpu_cid)                       - 
> rcu_dereference(src_rq->curr)
> 
> This Dekker ensures that either task (N) is observed by the 
> rcu_dereference() or the LAZY
> flag is observed by READ_ONCE(), or both are observed.
> 
> If rcu_dereference observes (N) but LAZY is not observed, migrate-from 
> will take care to
> advance the state to UNSET, thus fulfilling property (2). Because (Y) is 
> not running anymore
> property (1) is fulfilled.
> 
> If rcu_dereference does not observe (N), but LAZY is observed, 
> migrate-from does not
> advance to UNSET because it observes (Y), but LAZY flag will make the 
> task on CPU0
> take care of advancing the state to UNSET, thus fulfilling property (2).
> 
> If both (N) and LAZY are observed, both migrate-from and CPU0 will try 
> to advance the
> state to UNSET, but only one will succeed its cmpxchg.
> 
> What we are effectively preventing with this Dekker is a scenario where 
> neither LAZY
> flag nor store (N) are observed, which would fail property (2) because 
> it would leak
> a cid on a cpu that has no task left using the mm.
> 
> So based on my analysis, we are indeed missing a barrier between store 
> to rq->curr and
> load of the per-mm/cpu cid within context_switch().
> 
> Am I missing something ? How can we provide this barrier with minimal 
> overhead ?

Here is the barrier placement I have in mind to minimize the impact:

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 2a243616f222..f20fc0600fcc 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -37,6 +37,11 @@ static inline void mmgrab(struct mm_struct *mm)
  	atomic_inc(&mm->mm_count);
  }
  
+static inline void smp_mb__after_mmgrab(void)
+{
+	smp_mb__after_atomic();
+}
+
  extern void __mmdrop(struct mm_struct *mm);
  
  static inline void mmdrop(struct mm_struct *mm)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9e0fa4193499..8d410c0dcb39 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5117,7 +5117,6 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
  	sched_info_switch(rq, prev, next);
  	perf_event_task_sched_out(prev, next);
  	rseq_preempt(prev);
-	switch_mm_cid(prev, next);
  	fire_sched_out_preempt_notifiers(prev, next);
  	kmap_local_sched_out();
  	prepare_task(next);
@@ -5273,6 +5272,9 @@ context_switch(struct rq *rq, struct task_struct *prev,
  	 *
  	 * kernel ->   user   switch + mmdrop() active
  	 *   user ->   user   switch
+	 *
+	 * switch_mm_cid() needs to be updated if the barriers provided
+	 * by context_switch() are modified.
  	 */
  	if (!next->mm) {                                // to kernel
  		enter_lazy_tlb(prev->active_mm, next);
@@ -5302,6 +5304,9 @@ context_switch(struct rq *rq, struct task_struct *prev,
  		}
  	}
  
+	/* switch_mm_cid() requires the memory barriers above. */
+	switch_mm_cid(prev, next);
+
  	rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
  
  	prepare_lock_switch(rq, next, rf);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index bc0e1cd0d6ac..f3e7dc2cd1cc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3354,6 +3354,37 @@ static inline int mm_cid_get(struct mm_struct *mm)
  
  static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *next)
  {
+	/*
+	 * Provide a memory barrier between rq->curr store and load of
+	 * {prev,next}->mm->pcpu_cid[cpu] on rq->curr->mm transition.
+	 *
+	 * Should be adapted if context_switch() is modified.
+	 */
+	if (!next->mm) {                                // to kernel
+		/*
+		 * user -> kernel transition does not guarantee a barrier, but
+		 * we can use the fact that it performs an atomic operation in
+		 * mmgrab().
+		 */
+		if (prev->mm)                           // from user
+			smp_mb__after_mmgrab();
+		/*
+		 * kernel -> kernel transition does not change rq->curr->mm
+		 * state. It stays NULL.
+		 */
+	} else {                                        // to user
+		/*
+		 * kernel -> user transition does not provide a barrier
+		 * between rq->curr store and load of {prev,next}->mm->pcpu_cid[cpu].
+		 * Provide it here.
+		 */
+		if (!prev->mm)                          // from kernel
+			smp_mb();
+		/*
+		 * user -> user transition guarantees a memory barrier through
+		 * switch_mm().
+		 */
+	}
  	if (prev->mm_cid_active) {
  		mm_cid_put_lazy(prev);
  		prev->mm_cid = -1;

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

