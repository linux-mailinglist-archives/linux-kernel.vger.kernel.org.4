Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB757390D4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 22:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjFUUfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 16:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjFUUew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 16:34:52 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47733EA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 13:34:50 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-3f9cf20da51so54360771cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 13:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687379689; x=1689971689;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4lH/14XGem5/80z00o/w4e7/bJA0MK+2aNuXcfZsvY=;
        b=hTV0Y6CRlk6YBbYVWRyK/oFuNGkoXUFQbGi6xw3MgzASp9IWPJPXNQ49qnzfELAsdx
         nApTE2JUgFVkQoBEWnYrp+s+wmIQainobCz6aGQpW89O9K/OVTVNASfmf/hO3YzWfHXd
         8z6wf6XJ0q+fDFJAlDW0oHDw2jn/xRGqG/4W7nC8BBhSsojek9CHnt0Ygb8/zOx/5uFV
         XX9jjHo6tWE+JHtrqbzzLgb7BwWxNEuSbPGxr5BP5DS7wHtvsdp4//RTJlHtQb8WD40t
         fugTqiFIRShAutkZV7sNsbVnNGs81osoWkr3EcApNzOHHWH/Jl29RulgeVWfRZGq0ATB
         B8cw==
X-Gm-Message-State: AC+VfDzSgW8/7NNDdrqfI4/6m2eRzmLuSzR8WfUnQcgns/8YaMaBKrI7
        1Yy9a5yzYTxFCi9o5WOmROk=
X-Google-Smtp-Source: ACHHUZ4XCq70Y4vxQOgNcRrJIuble1L+2xzY+ZI1CgCIlH/ALr2QyIK5UT1+sDphZEoMH2hVGr19/Q==
X-Received: by 2002:ac8:7f8c:0:b0:3ed:a2f5:f27c with SMTP id z12-20020ac87f8c000000b003eda2f5f27cmr24770264qtj.12.1687379689058;
        Wed, 21 Jun 2023 13:34:49 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:d965])
        by smtp.gmail.com with ESMTPSA id h15-20020ac8714f000000b003e39106bdb2sm2770144qtp.31.2023.06.21.13.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 13:34:48 -0700 (PDT)
Date:   Wed, 21 Jun 2023 15:34:45 -0500
From:   David Vernet <void@manifault.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, dietmar.eggemann@arm.com, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        joshdon@google.com, roman.gushchin@linux.dev, tj@kernel.org,
        kernel-team@meta.com
Subject: Re: [RFC PATCH 3/3] sched: Implement shared wakequeue in CFS
Message-ID: <20230621203445.GC15990@maniforge>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-4-void@manifault.com>
 <20230621142020.GG2053369@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621142020.GG2053369@hirez.programming.kicks-ass.net>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 04:20:20PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 13, 2023 at 12:20:04AM -0500, David Vernet wrote:
> > +struct swqueue {
> > +	struct list_head list;
> > +	spinlock_t lock;
> > +} ____cacheline_aligned;
> 
> I'm thinking you can shard this just fine, it makes that pop() needs to
> iterate all shards, but that shouldn't be a problem, and it would still
> only need to take a single lock.

Is the idea here to have multiple sharded queues per LLC, with a single
lock protecting them? Assuming so, is the idea that it would avoid
bouncing the list heads amongst all of the cores' cachelines? I could
see that being useful in some scenarios, but it also feels a bit
complicated for what it gives you. If you have tasks being pulled
quickly I don't think that will help much because the list heads will
just bounce to the pullers. Also, if the lock is already heavily
contended, it seems possible that the cores inside a single shard could
still bounce the head back and forth amongst them, or the cache line
bouncing will be a small-order overhead compared to the lock itself.

Or did I misunderstand your suggestion entirely?

> I'm thinking 4 or 8 shards should be plenty, even for Intel LLC.
> 
> >  #ifdef CONFIG_SMP
> 
> > +static struct task_struct *swqueue_pull_task(struct swqueue *swqueue)
> > +{
> > +	unsigned long flags;
> > +
> > +	struct task_struct *p;
> > +
> > +	spin_lock_irqsave(&swqueue->lock, flags);
> > +	p = list_first_entry_or_null(&swqueue->list, struct task_struct,
> > +				     swqueue_node);
> > +	if (p)
> > +		list_del_init(&p->swqueue_node);
> > +	spin_unlock_irqrestore(&swqueue->lock, flags);
> > +
> > +	return p;
> > +}
> 
> Would this not normally be called pop() or somesuch?

Yes, I'll improve the name in the next iteration. swqueue_dequeue() and
swqueue_enqueue() seem like the most canonical. Let me know if you have another
preference.

> 
> > +static void swqueue_enqueue(struct rq *rq, struct task_struct *p, int enq_flags)
> > +{
> > +	unsigned long flags;
> > +	struct swqueue *swqueue;
> > +	bool task_migrated = enq_flags & ENQUEUE_MIGRATED;
> > +	bool task_wakeup = enq_flags & ENQUEUE_WAKEUP;
> > +
> > +	/*
> > +	 * Only enqueue the task in the shared wakequeue if:
> > +	 *
> > +	 * - SWQUEUE is enabled
> > +	 * - The task is on the wakeup path
> > +	 * - The task wasn't purposefully migrated to the current rq by
> > +	 *   select_task_rq()
> > +	 * - The task isn't pinned to a specific CPU
> > +	 */
> > +	if (!task_wakeup || task_migrated || p->nr_cpus_allowed == 1)
> > +		return;
> 
> Elsewhere you mentioned heuristics, this smells like them. This and the
> is_cpus_allowed() thing makes you loose plenty of opportunities.

Yeah fair enough, these certainly are heuristics as well.

I thought it best to try and avoid swqueue getting in the way of
select_task_rq_fair() (at least to start out with), but we could always
remove that and run other experiments to see how it does.

> > +	swqueue = rq_swqueue(rq);
> > +	spin_lock_irqsave(&swqueue->lock, flags);
> > +	list_add_tail(&p->swqueue_node, &swqueue->list);
> > +	spin_unlock_irqrestore(&swqueue->lock, flags);
> > +}
> > +
> >  static int swqueue_pick_next_task(struct rq *rq, struct rq_flags *rf)
> >  {
> > -	return 0;
> > +	struct swqueue *swqueue;
> > +	struct task_struct *p = NULL;
> > +	struct rq *src_rq;
> > +	struct rq_flags src_rf;
> > +	int ret;
> > +
> > +	swqueue = rq_swqueue(rq);
> > +	if (!list_empty(&swqueue->list))
> > +		p = swqueue_pull_task(swqueue);
> > +
> > +	if (!p)
> > +		return 0;
> 
> At this point you can do the whole is_cpu_allowed() and avoid the whole
> lock dance if not.

Good idea, will incorporate into the next iteration.

> > +
> > +	rq_unpin_lock(rq, rf);
> > +	raw_spin_rq_unlock(rq);
> > +
> > +	src_rq = task_rq_lock(p, &src_rf);
> > +
> > +	if (task_on_rq_queued(p) && !task_on_cpu(rq, p))
> > +		src_rq = migrate_task_to(src_rq, &src_rf, p, cpu_of(rq));
> 
> And then this becomes move_queued_task().

Yep, will make this change per your suggestion in [0].

[0]: https://lore.kernel.org/all/20230621130439.GF2053369@hirez.programming.kicks-ass.net/

> > +	if (src_rq->cpu != rq->cpu)
> > +		ret = 1;
> > +	else
> > +		ret = -1;
> > +
> > +	task_rq_unlock(src_rq, p, &src_rf);
> > +
> > +	raw_spin_rq_lock(rq);
> > +	rq_repin_lock(rq, rf);
> > +
> > +	return ret;
> >  }
> >  
> >  static void swqueue_remove_task(struct task_struct *p)
> > +{
> > +	unsigned long flags;
> > +	struct swqueue *swqueue;
> > +
> > +	if (!list_empty(&p->swqueue_node)) {
> > +		swqueue = rq_swqueue(task_rq(p));
> > +		spin_lock_irqsave(&swqueue->lock, flags);
> > +		list_del_init(&p->swqueue_node);
> > +		spin_unlock_irqrestore(&swqueue->lock, flags);
> > +	}
> > +}
> 
> dequeue()

Ack
