Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB81F73A375
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjFVOpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjFVOoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:44:39 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982AD2713
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:44:10 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-3fde82c8ca7so57192231cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:44:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687445011; x=1690037011;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7CnhTqHAVyX7UVlzcZHYvI6F7kSNqIP0gMnyF6qXKEY=;
        b=jA8M7u0nSf0+pvtEPfSfsFWLaIzZEqIhwhlh8lcl7wAD74/uwPmZtHcXKiYNagXtZH
         mMSb9FwDMuvlnloHliul+QFpt/DXme7Mca7AyYFJQfd2g0U2PQRB9Aa7gXQ+pDq9jQc8
         J6EQ76YBNzjbqfSbnPaIqvZ2Zv0lpRqxT2qF3i2Z0g19yxb7sofURvqpAD1d2YcMhFSO
         rBMO3aRebAwtXXfI/ssxIszSoILH87f4TP7YS6lvYcCn25xR9HirY1vhR/GRaZPhn3KG
         DLdevvr2tAKaWdPIKX7x5EzWndVVMQRmPDR2pEf+woWASpu6Zye5C4oUCoLkp1i4HRl7
         LuWQ==
X-Gm-Message-State: AC+VfDz4oyUcZ0I7p5mooiCeQfSJx4Ah8MfFho0qb2VMJOW3eunD59gn
        0v0kyOgC+vBbnfEyq82lSn8=
X-Google-Smtp-Source: ACHHUZ6IduvbWpPOXs0xSPi6fexDsrPSr6SpItGDQdFgkwEnAJcV6GaO+w8gMYEczszM7gn3bOZUYA==
X-Received: by 2002:ac8:4e96:0:b0:400:817a:50ff with SMTP id 22-20020ac84e96000000b00400817a50ffmr945067qtp.33.1687445010209;
        Thu, 22 Jun 2023 07:43:30 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:d965])
        by smtp.gmail.com with ESMTPSA id d24-20020ac84e38000000b003ff0d00a71esm716801qtw.13.2023.06.22.07.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 07:43:29 -0700 (PDT)
Date:   Thu, 22 Jun 2023 09:43:27 -0500
From:   David Vernet <void@manifault.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, dietmar.eggemann@arm.com, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        joshdon@google.com, roman.gushchin@linux.dev, tj@kernel.org,
        kernel-team@meta.com
Subject: Re: [RFC PATCH 3/3] sched: Implement shared wakequeue in CFS
Message-ID: <20230622144327.GA113759@maniforge>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-4-void@manifault.com>
 <20230621142020.GG2053369@hirez.programming.kicks-ass.net>
 <20230621203445.GC15990@maniforge>
 <20230622105841.GH4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622105841.GH4253@hirez.programming.kicks-ass.net>
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

On Thu, Jun 22, 2023 at 12:58:41PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 21, 2023 at 03:34:45PM -0500, David Vernet wrote:
> > On Wed, Jun 21, 2023 at 04:20:20PM +0200, Peter Zijlstra wrote:
> > > On Tue, Jun 13, 2023 at 12:20:04AM -0500, David Vernet wrote:
> > > > +struct swqueue {
> > > > +	struct list_head list;
> > > > +	spinlock_t lock;
> > > > +} ____cacheline_aligned;
> > > 
> > > I'm thinking you can shard this just fine, it makes that pop() needs to
> > > iterate all shards, but that shouldn't be a problem, and it would still
> > > only need to take a single lock.
> > 
> > Is the idea here to have multiple sharded queues per LLC, with a single
> > lock protecting them? 
> 
> No, each shard will have it's own lock, each shard it's own cacheline.
> 
> > Or did I misunderstand your suggestion entirely?
> 
> Yup, so each shard is basically the above struct, whole cacheline with a
> lock and list. Then on enqueue we hash to a shard (possibly based on cpu
> -- this gives the least amount of bounces) and stick it on.
> 
> Then on pop we iterate the shards, the first non-empty shard gets the
> lock taken, and pop'ed. If you start iteration based on the cpu->shard
> map used for enqueue you can even get a sense of 'locality' depending on
> the mapping.

That's nifty. Even if we don't get locality from it, it seems prudent to
do to avoid contention.

> So pop is O(n) in shards, but on average will only take a single lock --

Ah, so it's 1 lock on average -- thanks for clarifying.

I like this idea and will implement it for v2. I'm not keen on the idea
of artificially having multiple independent swqueues (yes, I'll think of
a less evil name) per-LLC to avoid contending, but sharding like this
seems like a simple but effective solution to the scalability issue;
assuming having a sufficiently high N doesn't slow down the pop path by
too much as you pointed out below.

> there is an obvious race where it might see a non-empty queue, but race
> on lock and find the queue empty once acquired, but meh.

Yep, I would be surprised if this race caused a problem in practice.
Especially if we spread the poppers by starting iteration based on the
cpu->shared map as you suggested.

> > > I'm thinking 4 or 8 shards should be plenty, even for Intel LLC.

I'll try out a few combinations and see what works.

> > > 
> > > >  #ifdef CONFIG_SMP
> > > 
> > > > +static struct task_struct *swqueue_pull_task(struct swqueue *swqueue)
> > > > +{
> > > > +	unsigned long flags;
> > > > +
> > > > +	struct task_struct *p;
> > > > +
> > > > +	spin_lock_irqsave(&swqueue->lock, flags);
> > > > +	p = list_first_entry_or_null(&swqueue->list, struct task_struct,
> > > > +				     swqueue_node);
> > > > +	if (p)
> > > > +		list_del_init(&p->swqueue_node);
> > > > +	spin_unlock_irqrestore(&swqueue->lock, flags);
> > > > +
> > > > +	return p;
> > > > +}
> > > 
> > > Would this not normally be called pop() or somesuch?
> > 
> > Yes, I'll improve the name in the next iteration. swqueue_dequeue() and
> > swqueue_enqueue() seem like the most canonical. Let me know if you have another
> > preference.
> 
> Well, there's two layers intermixed here, which is, I think, what gave
> rise to the whole wonky naming.
> 
> If you implement the queue primitives as: push, pop, del
> and then build, using them, the scheduler primitives: enqueue, dequeue,
> pick, things should become saner.

Right, will do

> > > > +	if (!task_wakeup || task_migrated || p->nr_cpus_allowed == 1)
> > > > +		return;
> > > 
> > > Elsewhere you mentioned heuristics, this smells like them. This and the
> > > is_cpus_allowed() thing makes you loose plenty of opportunities.
> > 
> > Yeah fair enough, these certainly are heuristics as well.
> > 
> > I thought it best to try and avoid swqueue getting in the way of
> > select_task_rq_fair() (at least to start out with), but we could always
> > remove that and run other experiments to see how it does.
> 
> So, part of the problem is that you might be hooking at the wrong level
> (see also my earlier email about the queue only containing running tasks
> and none of the ready tasks).
> 
> If you were to hook at the __{en,de}queue_entity() level you'll
> automagically dequeue running tasks and enqueue any ready tasks. OTOH
> you get to deal with the problem that not all entities are tasks, but
> that shouldn't be too hard.
> 
> Also, you end up with more enqueue/dequeue -- so that might hurt.

If this doesn't cause untenable contention then it seems preferable if
the overall goal is work conservation. Using your shard idea would
hopefully mitigate that concern somewhat as well. I'll try this out for
v2 and compare it to keeping the enqueues to only be on the wakeup path.

If there's too much contention we can always just go back to the wakeup
case, but I'm hopeful this works out.

> Also, at this point you're nr_cpus/N away from simply scanning the
> runqueues and pulling things from non-empty runqueues. But for large
> nr_cpus and smallish N it might be a win over-all. Dunno..

Given that we're not seeing any contention on smaller LLCs but still
observing perf wins, I'm optimistic.

Thanks,
David
