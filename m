Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E796DB761
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 01:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjDGXuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 19:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjDGXus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 19:50:48 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30719E196
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 16:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1680911444;
        bh=M3Bnv7Ooo8j1VJ23L7rZd+WvyTkKfs9JCdR7DZ9MFXY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZW0NZFNyJ7BfSj9IPrXjgowqDjWEnWupwa3YnYgFrAeKwDyJ4WOGNCff4IVTv+RSL
         She9cpimNzOHk201u3W1e944oLWgCfAK3v+ZEimFKMO8MPT0i3sZZ+OVxp68GTYOeP
         LPIaCIQTHolwIXXLXIfa+i9qIfpX8l+oRPj3NUPxkJa/er5WYkTbmlgmZyO4SHSNhy
         8brV9DjIZCce/wodTOWB+FD3TnZMLtBwiqRYQWEjUl/c573fnBdYm9QXjF87R0P2Qf
         jMUfXYz7pM/T03JnrjNvkSxeJJQ2+PslIMP0kP1IPGt6tIdwo5EjfnjVIgOu6DQaRu
         GFshj2eK8EBUg==
Received: from [192.222.149.5] (192-222-149-5.qc.cable.ebox.net [192.222.149.5])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4PtZr36cTpztxy;
        Fri,  7 Apr 2023 19:50:43 -0400 (EDT)
Message-ID: <fdaa7242-4ddd-fbe2-bc0e-6c62054dbde8@efficios.com>
Date:   Fri, 7 Apr 2023 19:50:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH v3] sched: Fix performance regression introduced by
 mm_cid
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>,
        Olivier Dion <odion@efficios.com>
References: <20230405162635.225245-1-mathieu.desnoyers@efficios.com>
 <386a6e32-a746-9eb1-d5ae-e5bedaa8fc75@efficios.com>
 <20230406095122.GF386572@hirez.programming.kicks-ass.net>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230406095122.GF386572@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-06 05:51, Peter Zijlstra wrote:
> On Wed, Apr 05, 2023 at 04:37:42PM -0400, Mathieu Desnoyers wrote:
>> On 2023-04-05 12:26, Mathieu Desnoyers wrote:
>> [...]
>>>    #ifdef CONFIG_SCHED_MM_CID
>>> +/*
>>> + * Migration from src cpu. Called from set_task_cpu(). There are no guarantees
>>> + * that the rq lock is held.
>>> + */
>>> +void sched_mm_cid_migrate_from(struct task_struct *t)
>>> +{
>>> +	int src_cid, *src_pcpu_cid, last_mm_cid;
>>> +	struct mm_struct *mm = t->mm;
>>> +	struct rq *src_rq;
>>> +	struct task_struct *src_task;
>>> +
>>> +	if (!mm)
>>> +		return;
>>> +
>>> +	last_mm_cid = t->last_mm_cid;
>>> +	/*
>>> +	 * If the migrated task has no last cid, or if the current
>>> +	 * task on src rq uses the cid, it means the destination cpu
>>> +	 * does not have to reallocate its cid to keep the cid allocation
>>> +	 * compact.
>>> +	 */
>>> +	if (last_mm_cid == -1)
>>> +		return;
>>> +
>>> +	src_rq = task_rq(t);
>>> +	src_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu_of(src_rq));
>>> +	src_cid = READ_ONCE(*src_pcpu_cid);
>>> +
>>> +	if (!mm_cid_is_valid(src_cid) || last_mm_cid != src_cid)
>>> +		return;
>>> +
>>> +	/*
>>> +	 * If we observe an active task using the mm on this rq, it means we
>>> +	 * are not the last task to be migrated from this cpu for this mm, so
>>> +	 * there is no need to clear the src_cid.
>>> +	 */
>>> +	rcu_read_lock();
>>> +	src_task = rcu_dereference(src_rq->curr);
>>> +	if (src_task->mm_cid_active && src_task->mm == mm) {
>>> +		rcu_read_unlock();
>>> +		t->last_mm_cid = -1;
>>> +		return;
>>> +	}
>>> +	rcu_read_unlock();
>>> +
>>> +	/*
>>> +	 * If the source cpu cid is set, and matches the last cid of the
>>> +	 * migrated task, clear the source cpu cid to keep cid allocation
>>> +	 * compact to cover the case where this task is the last task using
>>> +	 * this mm on the source cpu. If there happens to be other tasks left
>>> +	 * on the source cpu using this mm, the next task using this mm will
>>> +	 * reallocate its cid on context switch.
>>> +	 *
>>> +	 * We cannot keep ownership of concurrency ID without runqueue
>>> +	 * lock held when it is not used by a current task, because it
>>> +	 * would lead to allocation of more concurrency ids than there
>>> +	 * are possible cpus in the system. The last_mm_cid is used as
>>> +	 * a hint to conditionally unset the dst cpu cid, keeping
>>> +	 * allocated concurrency ids compact.
>>> +	 */
>>> +	if (cmpxchg(src_pcpu_cid, src_cid, mm_cid_set_lazy_put(src_cid)) != src_cid)
>>> +		return;
>>> +
>>> +	/*
>>> +	 * The implicit barrier after cmpxchg per-mm/cpu cid before loading
>>> +	 * rq->curr->mm matches the scheduler barrier in context_switch()
>>> +	 * between store to rq->curr and load of prev and next task's
>>> +	 * per-mm/cpu cid.
>>
>> Thinking about it further, I suspect the transition:
>>
>>           *   user -> kernel   lazy + mmgrab() active
>>
>> in context_switch() lacks a memory barrier we need here (it's only an
>> atomic_inc with mmgrab()).
>>
>> The scenario is a transition from user to kernel thread happening
>> concurrently with migrate-from.
>>
>> Because there is no memory barrier between set rq->curr to a value that
>> has a NULL mm and loading per-mm/cpu cid value in mm_cid_put_lazy() for the
>> prev task, nothing guarantees that the following src_rq->curr rcu
>> dereference here will observe the store.
>>
>> Or am I missing something ?
> 
> OK, so last night I thought it was me needing sleep (which might still
> be the case), but now I'm still not quite getting it. Let me draw a
> picture, perhaps that'll help...

Let me try to start from your explanation to expose the case I have in mind.

> 
> It reads to me like you're treating a barrier as 'makes visible', which
> it never will.

No. What I am trying to figure out here is how we can introduce a Dekker
memory ordering (ref. row 10 from table at https://lwn.net/Articles/573436/)
to guarantee that the loads observe at least one of the stores:

Taken from kernel/futex/waitwake.c:

  *      X = Y = 0
  *
  *      w[X]=1          w[Y]=1
  *      MB              MB
  *      r[Y]=y          r[X]=x
  *
  * Which guarantees that x==0 && y==0 is impossible [...]

But let's first go back to the basic properties we want to guarantee before we
discuss how to actually guarantee them without holding the runqueue lock, and
ideally without additional atomic operations or barriers on the scheduler
fast-path.

There are two basic properties we want is to guarantee here:

(1) Migrate-from should _never_ mark a per-cpu cid UNSET when it is actively used
     by a task. That would lead to concurrent allocation of the cid and userspace
     corruption.

(2) Migrate-from should ideally not leak a cid value when there are no more tasks
     using it on the cpu. This ensures we keep cid allocations as compact as possible
     (closest to 0). Getting this wrong will not cause userspace corruption, just a
     less compact id allocation.

> 
> 
> CPU0 will run a user task A and switch to a kernel thread K;
> CPU1 will concurrently run sched_mm_cid_migrate_from().
> 
> 
> 	CPU0				CPU1
> 
> 	.. runs A ..
> 
> 					if (src_task->mm_cid_active && src_task->mm == mm)
> 					  // false, proceed
> 
> 					cmpxchg(); // set LAZY
> 
> 	__schedule()
> 					(A)
> 	  rq->curr = K;
> 					(B)
> 	  context_switch()
> 	    prepare_task_switch()

Please excuse my earlier emails, I did get the order between store to rq->curr,
the barriers in context_switch(), and prepare_task_switch() wrong. The documented
barriers in context_switch() are _after_ prepare_task_switch(), not before. So a
part of my earlier explanations do not make sense because of this.

We are in a situation where there are no barriers between store to rq->curr and the
call to prepare_task_switch() that follows just after.

> 	      switch_mm_cid()
> 	        cid_put_lazy(prev)
> 		cid_get(next)
>              mmgrab(); // user->kernel active_mm
> 	    switch_to();
> 
> 
> 
> 	.. runs K ..
> 
> 
> And it is this second compare that can either observe A or K, right?
> That is the locations A or B above. Later doesn't make sense because
> then switch_mm_cid() will have taken care of things.
> 
> If A, still false, and we continue to mark UNSET and put.
> If B, we see K, which will not have mm_cid_active set so still false and
> same as above.
> 
> What am I missing?

Let's introduce task (Y) which has mm == src_task->mm and task (N) which has
mm != src_task->mm for the rest of the discussion.

Let's consider the scheduling state transitions we want to consider here.
There are two scheduler state transitions on context switch we care about:

(TSA) Store to rq->curr with transition from (N) to (Y)

(TSB) Store to rq->curr with transition from (Y) to (N)

On the migrate-from side, there is one transition we care about:

(TMA) cmpxchg to *pcpu_cid to set the LAZY flag

There is also a transition to UNSET state which can be performed from all
sides (scheduler, migrate-from). It is performed with a cmpxchg everywhere
which guarantees that only a single thread will succeed:

(TMB) cmpxchg to *pcpu_cid to mark UNSET

Just to be clear (at the risk of repeating myself), what we do _not_ want
to happen is a transition to UNSET when a thread is actively using the cid
(property (1)). And ideally we do not want to leak a cid after migrating the
last task from a cpu (property (2)).

Let's looks at the relevant combinations of TSA/TSB, and TMA transitions.

Scenario A) (TSA)+(TMA) (from next task perspective)

CPU0                                                 CPU1

Context switch CS-1                                  Migrate-from
   - store to rq->curr: (N)->(Y) (TSA)                - cmpxchg to *pcpu_id to LAZY (TMA)
      *** missing barrier ?? ***                        (implied barrier after cmpxchg)
   - prepare_task_switch()
     - switch_mm_cid()
       - mm_cid_get (next)
         - READ_ONCE(*pcpu_cid)                       - rcu_dereference(src_rq->curr)

This Dekker ensures that either task (Y) is observed by the rcu_dereference() or the LAZY
flag is observed by READ_ONCE(), or both are observed.

If task (Y) store is observed by rcu_dereference(), it means that there is still
an active task on the cpu. Migrate-from will therefore not transition to UNSET, which
fulfills property (1). That observed task will itself eventually need a migrate-from
to be migrated away from that cpu, which fulfills property (2).

If task (Y) is not observed, but the lazy flag is observed by READ_ONCE(), it will
move its state to UNSET, which clears the percpu cid perhaps uselessly (which is not
an issue for correctness). Because task (Y) is not observed, CPU1 can move ahead to
set the state to UNSET. Because moving state to UNSET is done with a cmpxchg expecting
that the old state has the LAZY flag set, only one thread will successfully UNSET.

If both states (LAZY flag and task (Y)) are observed, the thread on CPU0 will observe
the LAZY flag and transition to UNSET (perhaps uselessly), and CPU1 will observe task
(Y) and do nothing more, which is fine.

What we are effectively preventing with this Dekker is a scenario where neither LAZY
flag nor store (Y) are observed, which would fail property (1) because this would
UNSET a cid which is actively used.


Scenario B) (TSB)+(TMA) (from prev task perspective)

CPU0                                                 CPU1

Context switch CS-1                                  Migrate-from
   - store to rq->curr: (Y)->(N) (TSB)                - cmpxchg to *pcpu_id to LAZY (TMA)
     *** missing barrier ?? ***                         (implied barrier after cmpxchg)
   - prepare_task_switch()
     - switch_mm_cid()
       - cid_put_lazy() (prev)
         - READ_ONCE(*pcpu_cid)                       - rcu_dereference(src_rq->curr)

This Dekker ensures that either task (N) is observed by the rcu_dereference() or the LAZY
flag is observed by READ_ONCE(), or both are observed.

If rcu_dereference observes (N) but LAZY is not observed, migrate-from will take care to
advance the state to UNSET, thus fulfilling property (2). Because (Y) is not running anymore
property (1) is fulfilled.

If rcu_dereference does not observe (N), but LAZY is observed, migrate-from does not
advance to UNSET because it observes (Y), but LAZY flag will make the task on CPU0
take care of advancing the state to UNSET, thus fulfilling property (2).

If both (N) and LAZY are observed, both migrate-from and CPU0 will try to advance the
state to UNSET, but only one will succeed its cmpxchg.

What we are effectively preventing with this Dekker is a scenario where neither LAZY
flag nor store (N) are observed, which would fail property (2) because it would leak
a cid on a cpu that has no task left using the mm.

So based on my analysis, we are indeed missing a barrier between store to rq->curr and
load of the per-mm/cpu cid within context_switch().

Am I missing something ? How can we provide this barrier with minimal overhead ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

