Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707F062F544
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbiKRMri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbiKRMrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:47:36 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4792B8CF31
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=llH1p4sBg1mDYUseKjl3P8WGG4XLmd5EErI5VrSLg8U=; b=O+2moYxTm9dyTfsSZAYqYla1tz
        HsMC/HLmcNg3XRKPLS8vdamv1ZDarvvWTQQ5FJU369046ahtuH7BG6EEMOqCB3TDugQoTUQpeN5Dl
        mWo78+5sY0mWJP+yIajR8LqqhVwa7wp6GopgejswxkOWLZbnB007BJgZFplbYowGrgRAi4LGVpVFR
        XV8U/kaiF1aD2XID+imIYljKN49is9Qb//btzlE+8VIfLoswizqRa1aI03wHBE6OV7ZwUkxYsZ2NV
        CZT43qka6JI+PAHyxjWG/9Nh8e+GO4IJSgMCWYmBTivuK17/VfWUofohucd8p7IFG9fskYzBuAux/
        vGcez2kQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ow0m7-001zMe-7v; Fri, 18 Nov 2022 12:47:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 846B0300209;
        Fri, 18 Nov 2022 13:47:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5AC8020D94A0E; Fri, 18 Nov 2022 13:47:17 +0100 (CET)
Date:   Fri, 18 Nov 2022 13:47:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Christian Brauner <brauner@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH v3] sched: async unthrottling for cfs bandwidth
Message-ID: <Y3d+1a9AEnWaxFwq@hirez.programming.kicks-ass.net>
References: <20221117005418.3499691-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117005418.3499691-1-joshdon@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 04:54:18PM -0800, Josh Don wrote:

> +#ifdef CONFIG_SMP
> +static void __cfsb_csd_unthrottle(void *arg)
> +{
> +	struct rq *rq = arg;
> +	struct rq_flags rf;
> +	struct cfs_rq *cursor, *tmp;
> +
> +	rq_lock(rq, &rf);
> +
> +	/*
> +	 * Since we hold rq lock we're safe from concurrent manipulation of
> +	 * the CSD list. However, this RCU critical section annotates the
> +	 * fact that we pair with sched_free_group_rcu(), so that we cannot
> +	 * race with group being freed in the window between removing it
> +	 * from the list and advancing to the next entry in the list.
> +	 */
> +	rcu_read_lock();

preempt_disable() -- through rq->lock -- also holds off rcu. Strictly
speaking this here is superfluous. But if you want it as an annotation,
that's fine I suppose.

> +
> +	list_for_each_entry_safe(cursor, tmp, &rq->cfsb_csd_list,
> +				 throttled_csd_list) {
> +		list_del_init(&cursor->throttled_csd_list);
> +
> +		if (cfs_rq_throttled(cursor))
> +			unthrottle_cfs_rq(cursor);
> +	}
> +
> +	rcu_read_unlock();
> +
> +	rq_unlock(rq, &rf);
> +}
> +
> +static inline void __unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
> +{
> +	struct rq *rq = rq_of(cfs_rq);
> +
> +	if (rq == this_rq()) {
> +		unthrottle_cfs_rq(cfs_rq);
> +		return;
> +	}

Ideally we'd first queue all the remotes and then process local, but
given how all this is organized that doesn't seem trivial to arrange.

Maybe have this function return false when local and save that cfs_rq in
a local var to process again later, dunno, that might turn messy.

> +
> +	/* Already enqueued */
> +	if (SCHED_WARN_ON(!list_empty(&cfs_rq->throttled_csd_list)))
> +		return;
> +
> +	list_add_tail(&cfs_rq->throttled_csd_list, &rq->cfsb_csd_list);
> +
> +	smp_call_function_single_async(cpu_of(rq), &rq->cfsb_csd);

Hurmph.. so I was expecting something like:

	first = list_empty(&rq->cfsb_csd_list);
	list_add_tail(&cfs_rq->throttled_csd_list, &rq->cfsb_csd_list);
	if (first)
		smp_call_function_single_async(cpu_of(rq), &rq->cfsb_csd);

But I suppose I'm remembering the 'old' version. I don't think it is
broken as written. There's a very narrow window where you'll end up
sending a second IPI for naught, but meh.

> +}

Let me go queue this thing, we can always improve upon matters later.
