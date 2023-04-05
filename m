Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AC46D88B3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 22:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjDEUhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 16:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDEUhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 16:37:46 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EA2B7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 13:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1680727062;
        bh=GCrzLfmJ/YJUNa83ehp8ndG+hkTWNE4OACr1TV4rtoY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QmiMEc5b1ZgBoogiU4cD52fR2VejOD73M7FvlJs9/POq5OW2tdZkbujYPS0VJVv+Q
         lfrdQiTGcZ+Bnu6wfjHMtZVdrw3nqZ2DnLJ/IQPKXyOuW6hqS+KmhWWIF64+iSLFLO
         TA2hwZhbIB/+YbwV9818WLS8b0pIEHadRpYxy+5zeL4G+ValGMzG9zOnaFgCRlOYsi
         uqeLqceMin1sh/bDhwmUd26gwgLmVIOVbfHg11T4pV6ZXYirDO8PgixLS8i3MiMht9
         PMvj2WcKOAK5BdkjOyQ8OA94hfAv4tBAgQaA6C5svnYjmtxRuj39qyzciQtfwtrZdh
         PZRytQFYk5A8w==
Received: from [10.1.0.206] (unknown [192.222.195.223])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4PsGfG4h1jzv1M;
        Wed,  5 Apr 2023 16:37:42 -0400 (EDT)
Message-ID: <386a6e32-a746-9eb1-d5ae-e5bedaa8fc75@efficios.com>
Date:   Wed, 5 Apr 2023 16:37:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH v3] sched: Fix performance regression introduced by
 mm_cid
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>
References: <20230405162635.225245-1-mathieu.desnoyers@efficios.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230405162635.225245-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-05 12:26, Mathieu Desnoyers wrote:
[...]
>   #ifdef CONFIG_SCHED_MM_CID
> +/*
> + * Migration from src cpu. Called from set_task_cpu(). There are no guarantees
> + * that the rq lock is held.
> + */
> +void sched_mm_cid_migrate_from(struct task_struct *t)
> +{
> +	int src_cid, *src_pcpu_cid, last_mm_cid;
> +	struct mm_struct *mm = t->mm;
> +	struct rq *src_rq;
> +	struct task_struct *src_task;
> +
> +	if (!mm)
> +		return;
> +
> +	last_mm_cid = t->last_mm_cid;
> +	/*
> +	 * If the migrated task has no last cid, or if the current
> +	 * task on src rq uses the cid, it means the destination cpu
> +	 * does not have to reallocate its cid to keep the cid allocation
> +	 * compact.
> +	 */
> +	if (last_mm_cid == -1)
> +		return;
> +
> +	src_rq = task_rq(t);
> +	src_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu_of(src_rq));
> +	src_cid = READ_ONCE(*src_pcpu_cid);
> +
> +	if (!mm_cid_is_valid(src_cid) || last_mm_cid != src_cid)
> +		return;
> +
> +	/*
> +	 * If we observe an active task using the mm on this rq, it means we
> +	 * are not the last task to be migrated from this cpu for this mm, so
> +	 * there is no need to clear the src_cid.
> +	 */
> +	rcu_read_lock();
> +	src_task = rcu_dereference(src_rq->curr);
> +	if (src_task->mm_cid_active && src_task->mm == mm) {
> +		rcu_read_unlock();
> +		t->last_mm_cid = -1;
> +		return;
> +	}
> +	rcu_read_unlock();
> +
> +	/*
> +	 * If the source cpu cid is set, and matches the last cid of the
> +	 * migrated task, clear the source cpu cid to keep cid allocation
> +	 * compact to cover the case where this task is the last task using
> +	 * this mm on the source cpu. If there happens to be other tasks left
> +	 * on the source cpu using this mm, the next task using this mm will
> +	 * reallocate its cid on context switch.
> +	 *
> +	 * We cannot keep ownership of concurrency ID without runqueue
> +	 * lock held when it is not used by a current task, because it
> +	 * would lead to allocation of more concurrency ids than there
> +	 * are possible cpus in the system. The last_mm_cid is used as
> +	 * a hint to conditionally unset the dst cpu cid, keeping
> +	 * allocated concurrency ids compact.
> +	 */
> +	if (cmpxchg(src_pcpu_cid, src_cid, mm_cid_set_lazy_put(src_cid)) != src_cid)
> +		return;
> +
> +	/*
> +	 * The implicit barrier after cmpxchg per-mm/cpu cid before loading
> +	 * rq->curr->mm matches the scheduler barrier in context_switch()
> +	 * between store to rq->curr and load of prev and next task's
> +	 * per-mm/cpu cid.

Thinking about it further, I suspect the transition:

          *   user -> kernel   lazy + mmgrab() active

in context_switch() lacks a memory barrier we need here (it's only an
atomic_inc with mmgrab()).

The scenario is a transition from user to kernel thread happening 
concurrently with migrate-from.

Because there is no memory barrier between set rq->curr to a value that
has a NULL mm and loading per-mm/cpu cid value in mm_cid_put_lazy() for 
the prev task, nothing guarantees that the following src_rq->curr rcu 
dereference here will observe the store.

Or am I missing something ?

Thanks,

Mathieu


> +	 *
> +	 * The implicit barrier after cmpxchg per-mm/cpu cid before loading
> +	 * rq->curr->mm_cid_active matches the barrier in
> +	 * sched_mm_cid_exit_signals(), sched_mm_cid_before_execve(), and
> +	 * sched_mm_cid_after_execve() between store to t->mm_cid_active and
> +	 * load of per-mm/cpu cid.
> +	 */
> +
> +	/*
> +	 * If we observe an active task using the mm on this rq after setting the lazy-put
> +	 * flag, this task will be responsible for transitioning from lazy-put
> +	 * flag set to MM_CID_UNSET.
> +	 */
> +	rcu_read_lock();
> +	src_task = rcu_dereference(src_rq->curr);
> +	if (src_task->mm_cid_active && src_task->mm == mm) {
> +		rcu_read_unlock();
> +		/*
> +		 * We observed an active task for this mm, clearing the destination
> +		 * cpu mm_cid is not relevant for compactness.
> +		 */
> +		t->last_mm_cid = -1;
> +		return;
> +	}
> +	rcu_read_unlock();
> +
> +	/*
> +	 * The src_cid is unused, so it can be unset.
> +	 */
> +	if (cmpxchg(src_pcpu_cid, mm_cid_set_lazy_put(src_cid), MM_CID_UNSET) != mm_cid_set_lazy_put(src_cid))
> +		return;
> +	__mm_cid_put(mm, src_cid);
> +}


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

