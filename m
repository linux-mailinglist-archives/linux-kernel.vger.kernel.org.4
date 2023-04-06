Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8E26D9358
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 11:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbjDFJxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 05:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236741AbjDFJxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 05:53:31 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1027EEA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 02:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MdchMn80dJa4PocBmnOEt/k8LLJ1nguoqKvH2E+CHyo=; b=gXBtnxaYY2MBTLZxzde4sRQ2Ac
        kYZtmn42wu6jC2Qr2GD2EW/PHEfHQAp1+GjJfC0NPWMXAkxWi8NsUFZkrlAcAd1jAYNvSOF6mDQGY
        aNZWRlED8GJNlAGN/2G0j0WHSPTYIQTQGzxn8HOC3ZSQA/jtAQxM33UKcv75Q+gLsXqBeOJ0S8Rry
        Q6OxTECiN1nY/rdtdX0fGCLPX9QbhcV/Ypln39jJJ7BM5ad03PVZxcE9X1a7slSkXsYcDz/XiPv8H
        fXzMaAWNYzDikcGaoqazTeh4FISLwVRQpbVe013f7oY9+zY7SRj1nej6c2LPXKwc/jB4MHrFtb7EW
        MCrnIW+w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pkMH6-00AUV7-2l;
        Thu, 06 Apr 2023 09:51:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 419E830008D;
        Thu,  6 Apr 2023 11:51:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0DBAF24C025F1; Thu,  6 Apr 2023 11:51:23 +0200 (CEST)
Date:   Thu, 6 Apr 2023 11:51:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>
Subject: Re: [RFC PATCH v3] sched: Fix performance regression introduced by
 mm_cid
Message-ID: <20230406095122.GF386572@hirez.programming.kicks-ass.net>
References: <20230405162635.225245-1-mathieu.desnoyers@efficios.com>
 <386a6e32-a746-9eb1-d5ae-e5bedaa8fc75@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <386a6e32-a746-9eb1-d5ae-e5bedaa8fc75@efficios.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 04:37:42PM -0400, Mathieu Desnoyers wrote:
> On 2023-04-05 12:26, Mathieu Desnoyers wrote:
> [...]
> >   #ifdef CONFIG_SCHED_MM_CID
> > +/*
> > + * Migration from src cpu. Called from set_task_cpu(). There are no guarantees
> > + * that the rq lock is held.
> > + */
> > +void sched_mm_cid_migrate_from(struct task_struct *t)
> > +{
> > +	int src_cid, *src_pcpu_cid, last_mm_cid;
> > +	struct mm_struct *mm = t->mm;
> > +	struct rq *src_rq;
> > +	struct task_struct *src_task;
> > +
> > +	if (!mm)
> > +		return;
> > +
> > +	last_mm_cid = t->last_mm_cid;
> > +	/*
> > +	 * If the migrated task has no last cid, or if the current
> > +	 * task on src rq uses the cid, it means the destination cpu
> > +	 * does not have to reallocate its cid to keep the cid allocation
> > +	 * compact.
> > +	 */
> > +	if (last_mm_cid == -1)
> > +		return;
> > +
> > +	src_rq = task_rq(t);
> > +	src_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu_of(src_rq));
> > +	src_cid = READ_ONCE(*src_pcpu_cid);
> > +
> > +	if (!mm_cid_is_valid(src_cid) || last_mm_cid != src_cid)
> > +		return;
> > +
> > +	/*
> > +	 * If we observe an active task using the mm on this rq, it means we
> > +	 * are not the last task to be migrated from this cpu for this mm, so
> > +	 * there is no need to clear the src_cid.
> > +	 */
> > +	rcu_read_lock();
> > +	src_task = rcu_dereference(src_rq->curr);
> > +	if (src_task->mm_cid_active && src_task->mm == mm) {
> > +		rcu_read_unlock();
> > +		t->last_mm_cid = -1;
> > +		return;
> > +	}
> > +	rcu_read_unlock();
> > +
> > +	/*
> > +	 * If the source cpu cid is set, and matches the last cid of the
> > +	 * migrated task, clear the source cpu cid to keep cid allocation
> > +	 * compact to cover the case where this task is the last task using
> > +	 * this mm on the source cpu. If there happens to be other tasks left
> > +	 * on the source cpu using this mm, the next task using this mm will
> > +	 * reallocate its cid on context switch.
> > +	 *
> > +	 * We cannot keep ownership of concurrency ID without runqueue
> > +	 * lock held when it is not used by a current task, because it
> > +	 * would lead to allocation of more concurrency ids than there
> > +	 * are possible cpus in the system. The last_mm_cid is used as
> > +	 * a hint to conditionally unset the dst cpu cid, keeping
> > +	 * allocated concurrency ids compact.
> > +	 */
> > +	if (cmpxchg(src_pcpu_cid, src_cid, mm_cid_set_lazy_put(src_cid)) != src_cid)
> > +		return;
> > +
> > +	/*
> > +	 * The implicit barrier after cmpxchg per-mm/cpu cid before loading
> > +	 * rq->curr->mm matches the scheduler barrier in context_switch()
> > +	 * between store to rq->curr and load of prev and next task's
> > +	 * per-mm/cpu cid.
> 
> Thinking about it further, I suspect the transition:
> 
>          *   user -> kernel   lazy + mmgrab() active
> 
> in context_switch() lacks a memory barrier we need here (it's only an
> atomic_inc with mmgrab()).
> 
> The scenario is a transition from user to kernel thread happening
> concurrently with migrate-from.
> 
> Because there is no memory barrier between set rq->curr to a value that
> has a NULL mm and loading per-mm/cpu cid value in mm_cid_put_lazy() for the
> prev task, nothing guarantees that the following src_rq->curr rcu
> dereference here will observe the store.
> 
> Or am I missing something ?

OK, so last night I thought it was me needing sleep (which might still
be the case), but now I'm still not quite getting it. Let me draw a
picture, perhaps that'll help...

It reads to me like you're treating a barrier as 'makes visible', which
it never will.


CPU0 will run a user task A and switch to a kernel thread K;
CPU1 will concurrently run sched_mm_cid_migrate_from().


	CPU0				CPU1

	.. runs A ..

					if (src_task->mm_cid_active && src_task->mm == mm)
					  // false, proceed

					cmpxchg(); // set LAZY

	__schedule()
					(A)
	  rq->curr = K;
					(B)
	  context_switch()
	    prepare_task_switch()
	      switch_mm_cid()
	        cid_put_lazy(prev)
		cid_get(next)
            mmgrab(); // user->kernel active_mm
	    switch_to();



	.. runs K ..


And it is this second compare that can either observe A or K, right?
That is the locations A or B above. Later doesn't make sense because
then switch_mm_cid() will have taken care of things.

If A, still false, and we continue to mark UNSET and put.
If B, we see K, which will not have mm_cid_active set so still false and
same as above.

What am I missing?
