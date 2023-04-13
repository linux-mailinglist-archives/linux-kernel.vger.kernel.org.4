Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573386E10A9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjDMPLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDMPLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:11:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D93E55
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oN2WyCXZ74bahdqn9nb+GnHcWbtR5YsHBVv1xso685M=; b=HCIeR8SNYb+9dDhH0hV4OlGugn
        /eguTNW6K/W0UiLDsjsyhY6WOIPuwT5G1RDgr8YFWb0vW4QZlpAh6E50QcmVpUJjFvPTlfGiE0WjJ
        V0bcPPe0wyaF76jg01Q5zgSmrf9Bcfj+D2fL77jO8WmxJmhqyB0792EFAXwwx1leAJGTroe4bPXuE
        ffvNPOH22a+jordWPsj5aWahdJlNFeeboy06ayYYsMispHCBIPkTAQ0VHidDdX5E1Z0H3TvQjCoM5
        s5lKW8Q/IOh75lnMZfuHuFkt00XqPpJ4E07wl8eZxOrT0n9SdhUj4IT75ve2wIRrobJzO1I4gLHg3
        ARhQPUHQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmybB-00ElfV-1F;
        Thu, 13 Apr 2023 15:10:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CEC2D3002A6;
        Thu, 13 Apr 2023 17:10:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 989C72023D643; Thu, 13 Apr 2023 17:10:55 +0200 (CEST)
Date:   Thu, 13 Apr 2023 17:10:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>,
        Olivier Dion <odion@efficios.com>, michael.christie@oracle.com
Subject: Re: [RFC PATCH v5] sched: Fix performance regression introduced by
 mm_cid
Message-ID: <20230413151055.GN4253@hirez.programming.kicks-ass.net>
References: <20230413140248.230479-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413140248.230479-1-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 10:02:48AM -0400, Mathieu Desnoyers wrote:

> +static inline void __mm_cid_put(struct mm_struct *mm, int cid)
> +{
> +	if (cid < 0)
> +		return;
> +	cpumask_clear_cpu(cid, mm_cidmask(mm));
> +}
> +
> +/*
> + * The per-mm/cpu cid can have the MM_CID_LAZY_PUT flag set or transition to the
> + * MM_CID_UNSET state without holding the rq lock, but the rq lock needs to be
> + * held to transition to other states.
> + */
> +static inline void mm_cid_put_lazy(struct task_struct *t)
> +{
> +	struct mm_struct *mm = t->mm;
> +	int *pcpu_cid, cid;
> +
> +	lockdep_assert_rq_held(this_rq());
> +	pcpu_cid = this_cpu_ptr(mm->pcpu_cid);
> +	cid = READ_ONCE(*pcpu_cid);
> +	if (!mm_cid_is_lazy_put(cid))
> +		return;
> +	if (!try_cmpxchg(pcpu_cid, &cid, MM_CID_UNSET))
> +		return;
> +	__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
> +}
> +
> +static inline void mm_cid_put(struct task_struct *t)
> +{
> +	struct mm_struct *mm = t->mm;
> +	int *pcpu_cid, cid, res;
> +
> +	lockdep_assert_rq_held(this_rq());
> +	WARN_ON_ONCE(t->mm_cid < 0);
> +	pcpu_cid = this_cpu_ptr(mm->pcpu_cid);
> +	cid = READ_ONCE(*pcpu_cid);
> +	for (;;) {
> +		if (mm_cid_is_unset(cid))
> +			return;
> +		WARN_ON_ONCE(mm_cid_clear_lazy_put(cid) != t->mm_cid);
> +		/*
> +		 * Attempt transition from valid or lazy-put to unset.
> +		 */
> +		res = cmpxchg(pcpu_cid, cid, MM_CID_UNSET);
> +		if (res == cid)
> +			break;
> +		cid = res;

		if (try_cmpxchg(pcpu_cid, &cid, MM_CID_UNSET))
			break;

> +	}



> +	__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
> +}
> +
> +static inline int __mm_cid_try_get(struct mm_struct *mm)
>  {
>  	struct cpumask *cpumask;
>  	int cid;
>  
>  	cpumask = mm_cidmask(mm);
> +	/*
> +	 * Retry finding first zero bit if the mask is temporarily
> +	 * filled. This only happens during concurrent migrate-from
> +	 * which owns a cid without holding a rq lock.
> +	 */
> +	do {
> +		cid = cpumask_first_zero(cpumask);
> +	} while (cid >= nr_cpu_ids);

Urgh..
	for (;;) {
		cid = cpumask_first_zero(cpumask);
		if (cid < nr_cpu_ids)
			break;
		cpu_relax();
	}


> +	if (!cpumask_test_and_set_cpu(cid, cpumask))
> +		return cid;
> +	/*
> +	 * If initial find-then-test-and-set fails due to concurrent updates,
> +	 * attempt a brute-force test-and-set from 0 to nr_cpu_ids-1 to
> +	 * eliminate the race between find and test-and-set. This does not
> +	 * strictly provide forward-progress guarantees, because we could
> +	 * theoretically be racing against concurrent updates of the mask, but
> +	 * it does have much better odds to succeed in contended cases than
> +	 * the find-then-test-and-set approach.
> +	 */
> +	for (cid = 0; cid < nr_cpu_ids; cid++) {
> +		if (!cpumask_test_and_set_cpu(cid, cpumask))
> +			return cid;
> +	}

Yikes, we have IRQs disabled and hold rq->lock, this is a very expensive
proposition. Also, afaict all *should* just work without this on.

> +	return -1;
>  }
>  
> +static inline int __mm_cid_get(struct mm_struct *mm)
>  {
> +	int cid;
> +
> +	if (!READ_ONCE(use_cid_lock)) {

This all hurts my brain, but shouldn't you be able to replace
use_cid_lock with raw_spin_is_locked(&cid_lock) ?

> +		cid = __mm_cid_try_get(mm);
> +		if (cid >= 0)
> +			goto end;
> +		raw_spin_lock(&cid_lock);
> +	} else {
> +		raw_spin_lock(&cid_lock);
> +		cid = __mm_cid_try_get(mm);
> +		if (cid >= 0)
> +			goto unlock;
> +	}
> +
> +	/*
> +	 * cid concurrently allocated. Retry while forcing following
> +	 * allocations to use the cid_lock to ensure forward progress.
> +	 */
> +	WRITE_ONCE(use_cid_lock, 1);
> +	/*
> +	 * Set use_cid_lock before allocation. Only care about program order
> +	 * because this is for forward progress.
> +	 */
> +	barrier();
> +	/*
> +	 * Retry until it succeeds. It is guaranteed to eventually
> +	 * succeed once all newcoming allocations observe the
> +	 * use_cid_lock flag set.
> +	 */
> +	do {
> +		cid = __mm_cid_try_get(mm);
> +	} while (cid < 0);
> +	/*
> +	 * Allocate before clearing use_cid_lock. Only care about
> +	 * program order because this is for forward progress.
> +	 */
> +	barrier();
> +	WRITE_ONCE(use_cid_lock, 0);
> +unlock:
> +	raw_spin_unlock(&cid_lock);
> +end:
> +	return cid;
>  }


Anyway, I ran the thing and __schedule()'s dropped from around 11% to 5%

4.98%     0.04%  swapper          [kernel.vmlinux]            [k] schedule_idle
       |
       --4.95%--schedule_idle
                |
                --4.94%--__schedule
                         |
                         |--2.36%--mm_cid_get
                         |
                         |--0.72%--finish_task_switch.isra.0
                         |          |
                         |           --0.61%--asm_sysvec_call_function_single
                         |                     |
                         |                      --0.51%--sysvec_call_function_single
                         |
                         --0.59%--switch_mm_irqs_off

So improved, but not as good as my glorious hack ;-)

Also, I see that even migrate_from is visible

5.26%     0.74%  sched-messaging  [kernel.vmlinux]            [k] try_to_wake_up
       |
       |--4.52%--try_to_wake_up
       |          |
       |          |--1.49%--set_task_cpu
       |          |          |
       |          |           --1.18%--sched_mm_cid_migrate_from
       |          |
       |          |--1.24%--select_task_rq_fair
       |          |
       |          |--0.73%--ttwu_do_activate
       |          |          |
       |          |           --0.57%--enqueue_task_fair
       |          |
       |           --0.50%--ttwu_queue_wakelist
       |
       --0.74%--start_thread



