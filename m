Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33CD6D7F40
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238084AbjDEOWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238081AbjDEOWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:22:30 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77734DE
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 07:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1680704514;
        bh=j3/CDZKSSeu31sGWKE+raZe1FkwQqT8iyOSOlMavLnM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=M4gWRhe4OdWUx40IWvtGec2SDV4OqDt3eVsq18T+jaT9AfnlhGox1Ku2BfMt6KtFb
         jL3e009WMrtqxRuxTPDlmpMOOKT4Y7f0ODTG6xpal9YRUkFWzwDmGCOp5rKygg8HMy
         8PWRoBUtZw3zxc5DgBBp+eTwEKxpUZ/s/4vxTbMLn4YiUBjV1YSQ32c/tCRQxp9FRJ
         U8SkY+QTjIGcdx17Q7eLLnTnoyKn8fJRwAbYF9lRTrfKhqoVdZ4I0pfbECbfo2rIGr
         WbbmxJRg25x+NVbp/ugRmqNrxAv5OGTThKw7XgWD6poYs8MXBe1rLLsyfRKLALUShX
         R6vAZMlwk0AAw==
Received: from [IPV6:2605:8d80:5a1:347b:3c02:376a:5850:94da] (unknown [IPv6:2605:8d80:5a1:347b:3c02:376a:5850:94da])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Ps6Jf13nbztnm;
        Wed,  5 Apr 2023 10:21:54 -0400 (EDT)
Message-ID: <57d9f3b5-182a-21ed-528c-7a1ec7dad4ca@efficios.com>
Date:   Wed, 5 Apr 2023 10:21:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH] sched: Fix performance regression introduced by
 mm_cid (v2)
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>
References: <20230405121535.3891327-1-mathieu.desnoyers@efficios.com>
 <20230405125755.GB351571@hirez.programming.kicks-ass.net>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230405125755.GB351571@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-05 08:57, Peter Zijlstra wrote:
> On Wed, Apr 05, 2023 at 08:15:35AM -0400, Mathieu Desnoyers wrote:
>> +/*
>> + * Migration from src cpu. Called from set_task_cpu(). There are no guarantees
>> + * that the rq lock is held.
>> + */
>> +void sched_mm_cid_migrate_from(struct task_struct *t)
>> +{
>> +	int src_cid, *src_pcpu_cid, last_mm_cid;
>> +	struct mm_struct *mm = t->mm;
>> +	struct rq *src_rq;
>> +	struct task_struct *src_task;
>> +
>> +	if (!mm)
>> +		return;
>> +
>> +	last_mm_cid = t->last_mm_cid;
>> +	/*
>> +	 * If the migrated task has no last cid, or if the current
>> +	 * task on src rq uses the cid, it means the destination cpu
>> +	 * does not have to reallocate its cid to keep the cid allocation
>> +	 * compact.
>> +	 */
>> +	if (last_mm_cid == -1)
>> +		return;
>> +
>> +	src_rq = task_rq(t);
>> +	src_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu_of(src_rq));
>> +	src_cid = READ_ONCE(*src_pcpu_cid);
>> +
>> +	if (!mm_cid_is_valid(src_cid) || last_mm_cid != src_cid)
>> +		return;
>> +
>> +	/*
>> +	 * If we observe an active task using the mm on this rq, it means we
>> +	 * are not the last task to be migrated from this cpu for this mm, so
>> +	 * there is no need to clear the src_cid.
>> +	 */
>> +	rcu_read_lock();
>> +	src_task = rcu_dereference(src_rq->curr);
> 
> Continuing our discussion from IRC; your concern was if we need a
> barrier near RCU_INIT_POINTER() in __schedule(). Now, typically such a
> site would use rcu_assign_pointer() and be a store-release, which is
> ommitted in this case.
> 
> Specifically as commit 5311a98fef7d argues, there's at least one barrier
> in between most fields being set and this assignment.
> 
> On top of that, the below only has the ->mm dependent load, and task->mm
> is fairly constant. The obvious exception being kthread_use_mm().
> 
>> +	if (src_task->mm_cid_active && src_task->mm == mm) {
>> +		rcu_read_unlock();
>> +		t->last_mm_cid = -1;
>> +		return;
>> +	}
>> +	rcu_read_unlock();
> 
> So if we get here, then rq->curr->mm was observed to not match t->mm.
> However, nothing stops the rq from switching to a task that does match
> right here.
> 
>> +
>> +	/*
>> +	 * If the source cpu cid is set, and matches the last cid of the
>> +	 * migrated task, clear the source cpu cid to keep cid allocation
>> +	 * compact to cover the case where this task is the last task using
>> +	 * this mm on the source cpu. If there happens to be other tasks left
>> +	 * on the source cpu using this mm, the next task using this mm will
>> +	 * reallocate its cid on context switch.
>> +	 *
>> +	 * We cannot keep ownership of concurrency ID without runqueue
>> +	 * lock held when it is not used by a current task, because it
>> +	 * would lead to allocation of more concurrency ids than there
>> +	 * are possible cpus in the system. The last_mm_cid is used as
>> +	 * a hint to conditionally unset the dst cpu cid, keeping
>> +	 * allocated concurrency ids compact.
>> +	 */
>> +	if (cmpxchg(src_pcpu_cid, src_cid, mm_cid_set_lazy_put(src_cid)) != src_cid)
>> +		return;
> 
> So we set LAZY, and because that switch above will not observe this
> flag, we must check again:
> 
> And if there has indeed been a switch; that CPU will have gone through
> at least one smp_mb() (there's one at the start of __schedule()), so
> either way, it will see the LAZY or we will see the update or both.
> 
>> +
>> +	/*
>> +	 * If we observe an active task using the mm on this rq after setting the lazy-put
>> +	 * flag, this task will be responsible for transitioning from lazy-put
>> +	 * flag set to MM_CID_UNSET.
>> +	 */
>> +	rcu_read_lock();
>> +	src_task = rcu_dereference(src_rq->curr);
>> +	if (src_task->mm_cid_active && src_task->mm == mm) {
>> +		rcu_read_unlock();
>> +		/*
>> +		 * We observed an active task for this mm, clearing the destination
>> +		 * cpu mm_cid is not relevant for compactness.
>> +		 */
>> +		t->last_mm_cid = -1;
>> +		return;
>> +	}
>> +	rcu_read_unlock();
> 
> It is still unused, so wipe it.
> 
>> +
>> +	if (cmpxchg(src_pcpu_cid, mm_cid_set_lazy_put(src_cid), MM_CID_UNSET) != mm_cid_set_lazy_put(src_cid))
>> +		return;
>> +	__mm_cid_put(mm, src_cid);
>> +}
> 
> Did I miss any races?

I think your analysis is correct. The full barrier I thought was missing between
store to rq->curr and load of per-mm/cpu cid is indeed in context_switch() in the
next->mm != NULL case:

                 membarrier_switch_mm(rq, prev->active_mm, next->mm);
                 /*
                  * sys_membarrier() requires an smp_mb() between setting
                  * rq->curr / membarrier_switch_mm() and returning to userspace.
                  *
                  * The below provides this either through switch_mm(), or in
                  * case 'prev->active_mm == next->mm' through
                  * finish_task_switch()'s mmdrop().
                  */
                 switch_mm_irqs_off(prev->active_mm, next->mm, next);
                 lru_gen_use_mm(next->mm);

                 if (!prev->mm) {                        // from kernel
                         /* will mmdrop() in finish_task_switch(). */
                         rq->prev_mm = prev->active_mm;
                         prev->active_mm = NULL;
                 }

And in case you would happen to wonder how wrote that big comment about
the barrier, it happens to be me from 2018. :-)

So that barrier takes care of ordering store to rq->curr before load
of per-mm/cpu cid.

And as you said, the barrier at the beginning of __schedule() takes care
of ordering the load of per-mm/cpu cid of the previous context switch with
respect to the next context switch store to rq->curr.

The only other thing I am concerned about is a concurrent update to
t->mm_cid_active of the src rq current task happening concurrently with
sched_mm_cid_migrate_from() migrating a task from that src rq. It is set
to 0 on the current task by sched_mm_cid_exit_signals() and
sched_mm_cid_before_execve(), and set to 1 by sched_mm_cid_after_execve().

In both cases where it is set to 0, there is also a mm_cid_put() which
releases the cid (same effect as what we aim to do in migrate-from). But
I think we need additional barriers here, e.g. clearing t->mm_cid_active
should be done before calling mm_cid_put(t), so a concurrent migrate-from
does not set a lazy-flag that will never be handled. We should also add
a barrier between mm_cid_get() and setting t->mm_cid_active to 1 in
sched_mm_cid_after_execve.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

