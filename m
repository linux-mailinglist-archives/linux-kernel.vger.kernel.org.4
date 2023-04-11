Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C528C6DD8CA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjDKLEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjDKLEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:04:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC604491
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PEEIRFcCY8V94MFUrFLu3tv9SHVUfUNorm0Jdg+YNsM=; b=GAs7AfVokscfCgCy6zW0yVJe/a
        1ubg6uTrcsewDRyG4lvPuQFDiZ28OZHvZwBeMBoF49NE6NEfxEzUF1dxgwTpc6ex4IyylyTJ+ebtR
        7F+YiVfkHev7q77RsmCHripVOp1LNiG2KsDwjOcWANnFsOY8qcm7dOX0s7Re0QHlsx2e7ioVRSeuG
        LWjahAC8aYZMRplyWOTd4YscNI1XwSmKdhCEItQM02MhQluVQdy/VgxQZ2pSpXeA9CCoRC1gc0Str
        qvP9yXkEF+WnyLElGL7ktWcT413b4hh5eQJTmSjCcA0+KecZZ7zvRZrUkQgqXnWrS6M72XiXISr2/
        w4e6kSJA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmBms-00DKS0-20;
        Tue, 11 Apr 2023 11:03:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2B82A300274;
        Tue, 11 Apr 2023 13:03:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE57420593938; Tue, 11 Apr 2023 13:03:44 +0200 (CEST)
Date:   Tue, 11 Apr 2023 13:03:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>,
        Olivier Dion <odion@efficios.com>, michael.christie@oracle.com,
        npiggin@gmail.com
Subject: Re: [RFC PATCH v3] sched: Fix performance regression introduced by
 mm_cid
Message-ID: <20230411110344.GC576825@hirez.programming.kicks-ass.net>
References: <20230405162635.225245-1-mathieu.desnoyers@efficios.com>
 <386a6e32-a746-9eb1-d5ae-e5bedaa8fc75@efficios.com>
 <20230406095122.GF386572@hirez.programming.kicks-ass.net>
 <fdaa7242-4ddd-fbe2-bc0e-6c62054dbde8@efficios.com>
 <3b4684ea-5c0d-376b-19cf-195684ec4e0e@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b4684ea-5c0d-376b-19cf-195684ec4e0e@efficios.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 09:14:36PM -0400, Mathieu Desnoyers wrote:

> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 2a243616f222..f20fc0600fcc 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -37,6 +37,11 @@ static inline void mmgrab(struct mm_struct *mm)
>  	atomic_inc(&mm->mm_count);
>  }
> +static inline void smp_mb__after_mmgrab(void)
> +{
> +	smp_mb__after_atomic();
> +}
> +
>  extern void __mmdrop(struct mm_struct *mm);
>  static inline void mmdrop(struct mm_struct *mm)
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9e0fa4193499..8d410c0dcb39 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5117,7 +5117,6 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
>  	sched_info_switch(rq, prev, next);
>  	perf_event_task_sched_out(prev, next);
>  	rseq_preempt(prev);
> -	switch_mm_cid(prev, next);
>  	fire_sched_out_preempt_notifiers(prev, next);
>  	kmap_local_sched_out();
>  	prepare_task(next);
> @@ -5273,6 +5272,9 @@ context_switch(struct rq *rq, struct task_struct *prev,
>  	 *
>  	 * kernel ->   user   switch + mmdrop() active
>  	 *   user ->   user   switch
> +	 *
> +	 * switch_mm_cid() needs to be updated if the barriers provided
> +	 * by context_switch() are modified.
>  	 */
>  	if (!next->mm) {                                // to kernel
>  		enter_lazy_tlb(prev->active_mm, next);
> @@ -5302,6 +5304,9 @@ context_switch(struct rq *rq, struct task_struct *prev,
>  		}
>  	}
> +	/* switch_mm_cid() requires the memory barriers above. */
> +	switch_mm_cid(prev, next);
> +
>  	rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
>  	prepare_lock_switch(rq, next, rf);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index bc0e1cd0d6ac..f3e7dc2cd1cc 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3354,6 +3354,37 @@ static inline int mm_cid_get(struct mm_struct *mm)
>  static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *next)
>  {
> +	/*
> +	 * Provide a memory barrier between rq->curr store and load of
> +	 * {prev,next}->mm->pcpu_cid[cpu] on rq->curr->mm transition.
> +	 *
> +	 * Should be adapted if context_switch() is modified.
> +	 */
> +	if (!next->mm) {                                // to kernel
> +		/*
> +		 * user -> kernel transition does not guarantee a barrier, but
> +		 * we can use the fact that it performs an atomic operation in
> +		 * mmgrab().
> +		 */
> +		if (prev->mm)                           // from user
> +			smp_mb__after_mmgrab();
> +		/*
> +		 * kernel -> kernel transition does not change rq->curr->mm
> +		 * state. It stays NULL.
> +		 */
> +	} else {                                        // to user
> +		/*
> +		 * kernel -> user transition does not provide a barrier
> +		 * between rq->curr store and load of {prev,next}->mm->pcpu_cid[cpu].
> +		 * Provide it here.
> +		 */
> +		if (!prev->mm)                          // from kernel
> +			smp_mb();
> +		/*
> +		 * user -> user transition guarantees a memory barrier through
> +		 * switch_mm().
> +		 */
> +	}
>  	if (prev->mm_cid_active) {
>  		mm_cid_put_lazy(prev);
>  		prev->mm_cid = -1;
> 

This is going to be pain wrt.:

  https://lkml.kernel.org/r/20230203071837.1136453-3-npiggin@gmail.com

which is already in -next. Also, I recon Nick isn't going to too happy
-- although I recond smp_mb() is better than an atomic op on Power. But
still.

Urgh...

For Nick; the TL;DR is we need an smp_mb() after setting rq->curr and
before calling switch_mm_cid() *IFF* rq->curr->mm changes. Normally this
is provided by switch_mm() itself per actually changing the address
space, except for the whole active_mm/lazy swizzle nonsense, which gives
a few holes still.

The very much longer explanation is upthread here:

  https://lkml.kernel.org/r/fdaa7242-4ddd-fbe2-bc0e-6c62054dbde8@efficios.com

 
