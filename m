Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD2D6D7D10
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 14:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238075AbjDEM6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 08:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjDEM6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 08:58:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C685BA6
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 05:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yaf9qAkwJkgHv7hUdVv61g+f9IFSUH5qO4hBhidv7Ak=; b=oAob+mZHrwdZCh024yf/iOC3/i
        SOX0OLOtPavrkab9txlz7hsbf46x3eW0+soTBxXO3rj/soBY1HiEwi5S/JHyui2dlOtxK/LFoq+IT
        1m01zRlY1ZVtIgLx2Qf/mj+IcwLKmPPv5bhWLB+e3WTLhRHc3fmujZb8jCLPFG+mUYqRC7d+L8mGz
        ZbGrqqdAdZmY4wyGGEHyeE59k2iJK6JxtATCLT7WiFcUrhxdH4m7y/lbDM9xUtdSY2uVx46LtDcBx
        17t7AB2aWpZqrhCQMBIjN6MOufLkKfTgRG3cvw644TWVYByYSrwh6/dEXw0XgvTlT3FkmiFYgdyuj
        p7o72MwQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pk2i5-00GOTs-2V; Wed, 05 Apr 2023 12:57:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CB7E6300338;
        Wed,  5 Apr 2023 14:57:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B2C6626231812; Wed,  5 Apr 2023 14:57:55 +0200 (CEST)
Date:   Wed, 5 Apr 2023 14:57:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>
Subject: Re: [RFC PATCH] sched: Fix performance regression introduced by
 mm_cid (v2)
Message-ID: <20230405125755.GB351571@hirez.programming.kicks-ass.net>
References: <20230405121535.3891327-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405121535.3891327-1-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 08:15:35AM -0400, Mathieu Desnoyers wrote:
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

Continuing our discussion from IRC; your concern was if we need a
barrier near RCU_INIT_POINTER() in __schedule(). Now, typically such a
site would use rcu_assign_pointer() and be a store-release, which is
ommitted in this case.

Specifically as commit 5311a98fef7d argues, there's at least one barrier
in between most fields being set and this assignment.

On top of that, the below only has the ->mm dependent load, and task->mm
is fairly constant. The obvious exception being kthread_use_mm().

> +	if (src_task->mm_cid_active && src_task->mm == mm) {
> +		rcu_read_unlock();
> +		t->last_mm_cid = -1;
> +		return;
> +	}
> +	rcu_read_unlock();

So if we get here, then rq->curr->mm was observed to not match t->mm.
However, nothing stops the rq from switching to a task that does match
right here.

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

So we set LAZY, and because that switch above will not observe this
flag, we must check again:

And if there has indeed been a switch; that CPU will have gone through
at least one smp_mb() (there's one at the start of __schedule()), so
either way, it will see the LAZY or we will see the update or both.

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

It is still unused, so wipe it.

> +
> +	if (cmpxchg(src_pcpu_cid, mm_cid_set_lazy_put(src_cid), MM_CID_UNSET) != mm_cid_set_lazy_put(src_cid))
> +		return;
> +	__mm_cid_put(mm, src_cid);
> +}

Did I miss any races?
