Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82C46E1121
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjDMP2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjDMP2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:28:11 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33ECFB46B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1681399667;
        bh=vxnscmk2AV7AafQMCxpPQV6/uIZsABW3bteoP3ZX2I0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Nzw2y9TPIQxCjZ6uhttgWGtdGXMa2VUgUOK0mP4xYyrUz/P2A6QML7kmLUbX69y1U
         EO+zoYSCgNOFcNWcfXL7cCZ9gTfuRvq7D00GL+PyLZAbzuq8gCUnaKU0FwzoClQgRt
         pN/q2ERs25suXq2/hW804W2rLwakrx81e6O+VV4nHCOpYFCYY6qa6nRB9UEFtMY8+5
         YhTSKEBEF5Q5393FOBtP0Q0+8twvvh7kyY6c3cDvVQO+kwLUGeRO8L4vTET6/VjSvj
         pzjIq1OH8sAkgfpNt2sVVx0yLi9u2b6OlV6DxCzNGFUjozgaSBnl1YvVlxYJxx9fJj
         EGgZX+uv9jYag==
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Py3Nz1K7Pzvf4;
        Thu, 13 Apr 2023 11:27:47 -0400 (EDT)
Message-ID: <7c8703c3-7e47-c880-6215-00cc830bd913@efficios.com>
Date:   Thu, 13 Apr 2023 11:27:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH v5] sched: Fix performance regression introduced by
 mm_cid
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>,
        Olivier Dion <odion@efficios.com>, michael.christie@oracle.com
References: <20230413140248.230479-1-mathieu.desnoyers@efficios.com>
 <20230413151055.GN4253@hirez.programming.kicks-ass.net>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230413151055.GN4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-13 11:10, Peter Zijlstra wrote:
> On Thu, Apr 13, 2023 at 10:02:48AM -0400, Mathieu Desnoyers wrote:
> 
>> +static inline void __mm_cid_put(struct mm_struct *mm, int cid)
>> +{
>> +	if (cid < 0)
>> +		return;
>> +	cpumask_clear_cpu(cid, mm_cidmask(mm));
>> +}
>> +
>> +/*
>> + * The per-mm/cpu cid can have the MM_CID_LAZY_PUT flag set or transition to the
>> + * MM_CID_UNSET state without holding the rq lock, but the rq lock needs to be
>> + * held to transition to other states.
>> + */
>> +static inline void mm_cid_put_lazy(struct task_struct *t)
>> +{
>> +	struct mm_struct *mm = t->mm;
>> +	int *pcpu_cid, cid;
>> +
>> +	lockdep_assert_rq_held(this_rq());
>> +	pcpu_cid = this_cpu_ptr(mm->pcpu_cid);
>> +	cid = READ_ONCE(*pcpu_cid);
>> +	if (!mm_cid_is_lazy_put(cid))
>> +		return;
>> +	if (!try_cmpxchg(pcpu_cid, &cid, MM_CID_UNSET))
>> +		return;
>> +	__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
>> +}
>> +
>> +static inline void mm_cid_put(struct task_struct *t)
>> +{
>> +	struct mm_struct *mm = t->mm;
>> +	int *pcpu_cid, cid, res;
>> +
>> +	lockdep_assert_rq_held(this_rq());
>> +	WARN_ON_ONCE(t->mm_cid < 0);
>> +	pcpu_cid = this_cpu_ptr(mm->pcpu_cid);
>> +	cid = READ_ONCE(*pcpu_cid);
>> +	for (;;) {
>> +		if (mm_cid_is_unset(cid))
>> +			return;
>> +		WARN_ON_ONCE(mm_cid_clear_lazy_put(cid) != t->mm_cid);
>> +		/*
>> +		 * Attempt transition from valid or lazy-put to unset.
>> +		 */
>> +		res = cmpxchg(pcpu_cid, cid, MM_CID_UNSET);
>> +		if (res == cid)
>> +			break;
>> +		cid = res;
> 
> 		if (try_cmpxchg(pcpu_cid, &cid, MM_CID_UNSET))
> 			break;

I left this as a cmpxchg on purpose: it acts as a read for the next 
loop. Or is it better to move the "cid = READ_ONCE(*pcpu_cid);" at the 
beginning of the loop and use try_cmpxchg ?

> 
>> +	}
> 
> 
> 
>> +	__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
>> +}
>> +
>> +static inline int __mm_cid_try_get(struct mm_struct *mm)
>>   {
>>   	struct cpumask *cpumask;
>>   	int cid;
>>   
>>   	cpumask = mm_cidmask(mm);
>> +	/*
>> +	 * Retry finding first zero bit if the mask is temporarily
>> +	 * filled. This only happens during concurrent migrate-from
>> +	 * which owns a cid without holding a rq lock.
>> +	 */
>> +	do {
>> +		cid = cpumask_first_zero(cpumask);
>> +	} while (cid >= nr_cpu_ids);
> 
> Urgh..
> 	for (;;) {
> 		cid = cpumask_first_zero(cpumask);
> 		if (cid < nr_cpu_ids)
> 			break;
> 		cpu_relax();
> 	}

OK

> 
> 
>> +	if (!cpumask_test_and_set_cpu(cid, cpumask))
>> +		return cid;
>> +	/*
>> +	 * If initial find-then-test-and-set fails due to concurrent updates,
>> +	 * attempt a brute-force test-and-set from 0 to nr_cpu_ids-1 to
>> +	 * eliminate the race between find and test-and-set. This does not
>> +	 * strictly provide forward-progress guarantees, because we could
>> +	 * theoretically be racing against concurrent updates of the mask, but
>> +	 * it does have much better odds to succeed in contended cases than
>> +	 * the find-then-test-and-set approach.
>> +	 */
>> +	for (cid = 0; cid < nr_cpu_ids; cid++) {
>> +		if (!cpumask_test_and_set_cpu(cid, cpumask))
>> +			return cid;
>> +	}
> 
> Yikes, we have IRQs disabled and hold rq->lock, this is a very expensive
> proposition. Also, afaict all *should* just work without this on.

Yes, I'll remove this.

> 
>> +	return -1;
>>   }
>>   
>> +static inline int __mm_cid_get(struct mm_struct *mm)
>>   {
>> +	int cid;
>> +
>> +	if (!READ_ONCE(use_cid_lock)) {
> 
> This all hurts my brain, but shouldn't you be able to replace
> use_cid_lock with raw_spin_is_locked(&cid_lock) ?

No, because we only want the thread which observed the find/test-and-set 
race to set the use_cid_lock bit. We don't want all other threads which 
end up using the lock because they see use_cid_lock set to also 
themselves cause other threads to use the lock. This could cause a 
scenario where we always keep using the lock and never revert back to 
lock-free in a very contended case.

> 
>> +		cid = __mm_cid_try_get(mm);
>> +		if (cid >= 0)
>> +			goto end;
>> +		raw_spin_lock(&cid_lock);
>> +	} else {
>> +		raw_spin_lock(&cid_lock);
>> +		cid = __mm_cid_try_get(mm);
>> +		if (cid >= 0)
>> +			goto unlock;
>> +	}
>> +
>> +	/*
>> +	 * cid concurrently allocated. Retry while forcing following
>> +	 * allocations to use the cid_lock to ensure forward progress.
>> +	 */
>> +	WRITE_ONCE(use_cid_lock, 1);
>> +	/*
>> +	 * Set use_cid_lock before allocation. Only care about program order
>> +	 * because this is for forward progress.
>> +	 */
>> +	barrier();
>> +	/*
>> +	 * Retry until it succeeds. It is guaranteed to eventually
>> +	 * succeed once all newcoming allocations observe the
>> +	 * use_cid_lock flag set.
>> +	 */
>> +	do {
>> +		cid = __mm_cid_try_get(mm);
>> +	} while (cid < 0);
>> +	/*
>> +	 * Allocate before clearing use_cid_lock. Only care about
>> +	 * program order because this is for forward progress.
>> +	 */
>> +	barrier();
>> +	WRITE_ONCE(use_cid_lock, 0);
>> +unlock:
>> +	raw_spin_unlock(&cid_lock);
>> +end:
>> +	return cid;
>>   }
> 
> 
> Anyway, I ran the thing and __schedule()'s dropped from around 11% to 5%

That's a good start!

> 
> 4.98%     0.04%  swapper          [kernel.vmlinux]            [k] schedule_idle
>         |
>         --4.95%--schedule_idle
>                  |
>                  --4.94%--__schedule
>                           |
>                           |--2.36%--mm_cid_get
>                           |
>                           |--0.72%--finish_task_switch.isra.0
>                           |          |
>                           |           --0.61%--asm_sysvec_call_function_single
>                           |                     |
>                           |                      --0.51%--sysvec_call_function_single
>                           |
>                           --0.59%--switch_mm_irqs_off
> 
> So improved, but not as good as my glorious hack ;-)

Yeah, we still need to touch the bitmap and suffer from cache line bouncing.

> 
> Also, I see that even migrate_from is visible
> 
> 5.26%     0.74%  sched-messaging  [kernel.vmlinux]            [k] try_to_wake_up
>         |
>         |--4.52%--try_to_wake_up
>         |          |
>         |          |--1.49%--set_task_cpu
>         |          |          |
>         |          |           --1.18%--sched_mm_cid_migrate_from
>         |          |
>         |          |--1.24%--select_task_rq_fair
>         |          |
>         |          |--0.73%--ttwu_do_activate
>         |          |          |
>         |          |           --0.57%--enqueue_task_fair
>         |          |
>         |           --0.50%--ttwu_queue_wakelist
>         |
>         --0.74%--start_thread

One tradeoff we can consider is that we could afford to delay compaction 
of cids to much later. One way to achieve this would be to update a 
timestamp along with each per-mm/cpu cid value keeping track of its last 
use on context switch. Then we could implement a worker thread which 
would periodically iterate over all mm and figure out if it needs to 
compact things because per-mm/cpu cids were unused for too long.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

