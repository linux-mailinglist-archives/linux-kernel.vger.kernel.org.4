Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3316DDB10
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjDKMl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjDKMl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:41:26 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97212F4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 05:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1681216884;
        bh=feQnz7LEtrUjR3knhXb/iWIUFOvW72wj0TBYEI4P9CY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=feLLcyQFTIG82JbvKvpJwlDTtzZMEGbSD0Nf94jBrzsa5GMvY552zq2NucnScCBf7
         5yK8Yd6nQEPjrqX5cjNGFRm6pRVFtoI1/eHT7eDJ3sBjb3fjzFj1RX3tpCsmHAgcrA
         U7997JvirBE9+1S4yLUg9NBSfloDiswiMjjfrEY0MiSxE3Kw1gTo/SLwbM4tiF7QD6
         CbqLe6J1RgtW4JyPbags8SeYlh4aTsMFNcjjZ+slGbou+VTvaICMFfJ1KE6Y76eAZC
         mTjvzhCjBrt7KmA4vq5sRVyeZ+9QaIBbkwyKil4amkwGSB2wQyH646tHFFyQ7ontPe
         Wz6KpOwhW3rOQ==
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Pwlnw67GlzvQy;
        Tue, 11 Apr 2023 08:41:24 -0400 (EDT)
Message-ID: <7b5bf266-1418-1fe2-5d26-f94d3f67d49f@efficios.com>
Date:   Tue, 11 Apr 2023 08:41:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH v3] sched: Fix performance regression introduced by
 mm_cid
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>
References: <20230405162635.225245-1-mathieu.desnoyers@efficios.com>
 <20230411085304.GB576825@hirez.programming.kicks-ass.net>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230411085304.GB576825@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-11 04:53, Peter Zijlstra wrote:
> On Wed, Apr 05, 2023 at 12:26:35PM -0400, Mathieu Desnoyers wrote:
>> +void sched_mm_cid_migrate_from(struct task_struct *t)
>> +{
> 
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
>> +
> 
> FWIW, I'm thinking that if we write this using try_cmpxchg() it'll be a
> little nicer:
> 
> 	lazy_cid = mm_cid_set_lazy_put(src_cid);
> 	if (!try_cmpxchg(src_pcpu_cid, &src_cid, lazy_cid))
> 		return;
> 

Yes, done.

>> +	/*
>> +	 * The implicit barrier after cmpxchg per-mm/cpu cid before loading
>> +	 * rq->curr->mm matches the scheduler barrier in context_switch()
>> +	 * between store to rq->curr and load of prev and next task's
>> +	 * per-mm/cpu cid.
>> +	 *
>> +	 * The implicit barrier after cmpxchg per-mm/cpu cid before loading
>> +	 * rq->curr->mm_cid_active matches the barrier in
>> +	 * sched_mm_cid_exit_signals(), sched_mm_cid_before_execve(), and
>> +	 * sched_mm_cid_after_execve() between store to t->mm_cid_active and
>> +	 * load of per-mm/cpu cid.
>> +	 */
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
>> +
>> +	/*
>> +	 * The src_cid is unused, so it can be unset.
>> +	 */
>> +	if (cmpxchg(src_pcpu_cid, mm_cid_set_lazy_put(src_cid), MM_CID_UNSET) != mm_cid_set_lazy_put(src_cid))
>> +		return;
> 
> 	if (!try_cmpxchg(src_pcpu_cid, &lazy_cid, MM_CID_UNSET))
> 		return;

done,

Thanks!

Mathieu

> 
>> +	__mm_cid_put(mm, src_cid);
>> +}

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

