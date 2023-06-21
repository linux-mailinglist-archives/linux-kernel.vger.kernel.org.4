Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3F97386B3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjFUOUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjFUOUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:20:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9867C94
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2jA/tM4AlkQTFj+2INBFFGNIdh2rLm+mNnKcsM50PIs=; b=CEIamnuW80b9glwGdAltGZZ7A4
        gdZC9jTxbR8oPaKOCXoFaQiYIUwRttHcbeXqKfWk+vPTJof0xU2xXPTkJmTxbT58z7uoykso+boee
        +5HIDnYkZMU3vGQZOvpRwbtfGdqbc636r1D8ZGc7DReWSO0xrY7aRksr/lc0396Du8AzuyPnMlE57
        8ksIlSwoylVym2525KxvZLDwjseDQBhu+7PdiGp8TuhFm3AgWveQ6F9atOBoh6abHOM3uVPb8muTf
        67m/OZQ0u5KUjIva2/uOZjy2M1SHkOIpMXzJe/vKdUbXR8y3O3V3c4Wfohx9BRJ5kRdZyPA97F44R
        w14iy7Ow==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qByh4-00EPKo-U7; Wed, 21 Jun 2023 14:20:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CF0B8300274;
        Wed, 21 Jun 2023 16:20:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 88E6F2130B3BB; Wed, 21 Jun 2023 16:20:20 +0200 (CEST)
Date:   Wed, 21 Jun 2023 16:20:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Vernet <void@manifault.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, dietmar.eggemann@arm.com, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        joshdon@google.com, roman.gushchin@linux.dev, tj@kernel.org,
        kernel-team@meta.com
Subject: Re: [RFC PATCH 3/3] sched: Implement shared wakequeue in CFS
Message-ID: <20230621142020.GG2053369@hirez.programming.kicks-ass.net>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-4-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613052004.2836135-4-void@manifault.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 12:20:04AM -0500, David Vernet wrote:
> +struct swqueue {
> +	struct list_head list;
> +	spinlock_t lock;
> +} ____cacheline_aligned;

I'm thinking you can shard this just fine, it makes that pop() needs to
iterate all shards, but that shouldn't be a problem, and it would still
only need to take a single lock.

I'm thinking 4 or 8 shards should be plenty, even for Intel LLC.

>  #ifdef CONFIG_SMP

> +static struct task_struct *swqueue_pull_task(struct swqueue *swqueue)
> +{
> +	unsigned long flags;
> +
> +	struct task_struct *p;
> +
> +	spin_lock_irqsave(&swqueue->lock, flags);
> +	p = list_first_entry_or_null(&swqueue->list, struct task_struct,
> +				     swqueue_node);
> +	if (p)
> +		list_del_init(&p->swqueue_node);
> +	spin_unlock_irqrestore(&swqueue->lock, flags);
> +
> +	return p;
> +}

Would this not normally be called pop() or somesuch?

> +static void swqueue_enqueue(struct rq *rq, struct task_struct *p, int enq_flags)
> +{
> +	unsigned long flags;
> +	struct swqueue *swqueue;
> +	bool task_migrated = enq_flags & ENQUEUE_MIGRATED;
> +	bool task_wakeup = enq_flags & ENQUEUE_WAKEUP;
> +
> +	/*
> +	 * Only enqueue the task in the shared wakequeue if:
> +	 *
> +	 * - SWQUEUE is enabled
> +	 * - The task is on the wakeup path
> +	 * - The task wasn't purposefully migrated to the current rq by
> +	 *   select_task_rq()
> +	 * - The task isn't pinned to a specific CPU
> +	 */
> +	if (!task_wakeup || task_migrated || p->nr_cpus_allowed == 1)
> +		return;

Elsewhere you mentioned heuristics, this smells like them. This and the
is_cpus_allowed() thing makes you loose plenty of opportunities.

> +	swqueue = rq_swqueue(rq);
> +	spin_lock_irqsave(&swqueue->lock, flags);
> +	list_add_tail(&p->swqueue_node, &swqueue->list);
> +	spin_unlock_irqrestore(&swqueue->lock, flags);
> +}
> +
>  static int swqueue_pick_next_task(struct rq *rq, struct rq_flags *rf)
>  {
> -	return 0;
> +	struct swqueue *swqueue;
> +	struct task_struct *p = NULL;
> +	struct rq *src_rq;
> +	struct rq_flags src_rf;
> +	int ret;
> +
> +	swqueue = rq_swqueue(rq);
> +	if (!list_empty(&swqueue->list))
> +		p = swqueue_pull_task(swqueue);
> +
> +	if (!p)
> +		return 0;

At this point you can do the whole is_cpu_allowed() and avoid the whole
lock dance if not.

> +
> +	rq_unpin_lock(rq, rf);
> +	raw_spin_rq_unlock(rq);
> +
> +	src_rq = task_rq_lock(p, &src_rf);
> +
> +	if (task_on_rq_queued(p) && !task_on_cpu(rq, p))
> +		src_rq = migrate_task_to(src_rq, &src_rf, p, cpu_of(rq));

And then this becomes move_queued_task().

> +	if (src_rq->cpu != rq->cpu)
> +		ret = 1;
> +	else
> +		ret = -1;
> +
> +	task_rq_unlock(src_rq, p, &src_rf);
> +
> +	raw_spin_rq_lock(rq);
> +	rq_repin_lock(rq, rf);
> +
> +	return ret;
>  }
>  
>  static void swqueue_remove_task(struct task_struct *p)
> +{
> +	unsigned long flags;
> +	struct swqueue *swqueue;
> +
> +	if (!list_empty(&p->swqueue_node)) {
> +		swqueue = rq_swqueue(task_rq(p));
> +		spin_lock_irqsave(&swqueue->lock, flags);
> +		list_del_init(&p->swqueue_node);
> +		spin_unlock_irqrestore(&swqueue->lock, flags);
> +	}
> +}

dequeue()
