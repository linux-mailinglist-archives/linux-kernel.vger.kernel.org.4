Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391AA6DD5FB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjDKIxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjDKIxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:53:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675D9E76
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DYZqFeT2TkDql7LNr9KHtQzkAfQ3U+U8rxb08iVVG8k=; b=ANfLtIK31XNIkd7xjVRtNNRwiA
        xBY9XVTDaO7y7O1ptc7tPHUb96LAHbeoDa8j/awII5eLEQp5J65eN8mPbXEIAo7cmhPcjS+j/bSj6
        3PaFxh4lxO1jR/9V5grKWHRIPo4NLIP8hK2y/87PESjrtUI2uVGitKjrL+D+nF86nMUYLks0AFaUD
        C/ekRkWRvYeac3efpN7XXLTLHoOeDTn1U+x+gt7PtZtEGKiXPV+LBAlfdyUFBDADMk0tikP2Eodzp
        e6zMB4oiS9yfLQZspZ+vFAkiw3+lv/ypx2TiWuT2+nlZFgiMgXCZ7Cm2crrUAy3khXBM5ITd5BRkS
        wNyY2YFg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pm9kP-00DIBx-29;
        Tue, 11 Apr 2023 08:53:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 152D830002F;
        Tue, 11 Apr 2023 10:53:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F257E2BC3D07B; Tue, 11 Apr 2023 10:53:04 +0200 (CEST)
Date:   Tue, 11 Apr 2023 10:53:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>
Subject: Re: [RFC PATCH v3] sched: Fix performance regression introduced by
 mm_cid
Message-ID: <20230411085304.GB576825@hirez.programming.kicks-ass.net>
References: <20230405162635.225245-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405162635.225245-1-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 12:26:35PM -0400, Mathieu Desnoyers wrote:
> +void sched_mm_cid_migrate_from(struct task_struct *t)
> +{

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

FWIW, I'm thinking that if we write this using try_cmpxchg() it'll be a
little nicer:

	lazy_cid = mm_cid_set_lazy_put(src_cid);
	if (!try_cmpxchg(src_pcpu_cid, &src_cid, lazy_cid))
		return;

> +	/*
> +	 * The implicit barrier after cmpxchg per-mm/cpu cid before loading
> +	 * rq->curr->mm matches the scheduler barrier in context_switch()
> +	 * between store to rq->curr and load of prev and next task's
> +	 * per-mm/cpu cid.
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

	if (!try_cmpxchg(src_pcpu_cid, &lazy_cid, MM_CID_UNSET))
		return;

> +	__mm_cid_put(mm, src_cid);
> +}
