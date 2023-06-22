Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55E1739F22
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 12:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjFVK7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 06:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjFVK7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 06:59:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6F61BE4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 03:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EsYjXjdA4B39SRBJvDACKAwszebQmf4U8+ommBHhjZE=; b=CVIbvJnxs+Kuh/dCkJbs0XSLOm
        Q+4PbIzpQcjMUZB49jwkL3TA9KADA3GRn4SjyyL8fC8Af1ph2JO8UQ3cTB4MzGlbCJDS6PSi4erzG
        a2KDPkwjBh4B9ryh23IUM0wDGBebxMpr4byhvOtI/NsXddIrR3E7+U2lvRsqaeQ5rO5jwAPzEFE8b
        mjKXjRZ8MiBseWOp9bRgunQof7Kms12zjZL8KLBeJmbjdKv3ZrmtC1lG9mBU0BjTn7Akb1w7EDvvf
        Vu65p5yeD1nuSZzCf0p0wCuRvPQi0JvW8X351Yrj+bwkjCRpf4HwkyT7qjWyT0pN0hzGBN4wX83bq
        JcPsjVwg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qCI1T-00FWw8-3v; Thu, 22 Jun 2023 10:58:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E308A300274;
        Thu, 22 Jun 2023 12:58:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9A79F241BF9B4; Thu, 22 Jun 2023 12:58:41 +0200 (CEST)
Date:   Thu, 22 Jun 2023 12:58:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Vernet <void@manifault.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, dietmar.eggemann@arm.com, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        joshdon@google.com, roman.gushchin@linux.dev, tj@kernel.org,
        kernel-team@meta.com
Subject: Re: [RFC PATCH 3/3] sched: Implement shared wakequeue in CFS
Message-ID: <20230622105841.GH4253@hirez.programming.kicks-ass.net>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-4-void@manifault.com>
 <20230621142020.GG2053369@hirez.programming.kicks-ass.net>
 <20230621203445.GC15990@maniforge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621203445.GC15990@maniforge>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 03:34:45PM -0500, David Vernet wrote:
> On Wed, Jun 21, 2023 at 04:20:20PM +0200, Peter Zijlstra wrote:
> > On Tue, Jun 13, 2023 at 12:20:04AM -0500, David Vernet wrote:
> > > +struct swqueue {
> > > +	struct list_head list;
> > > +	spinlock_t lock;
> > > +} ____cacheline_aligned;
> > 
> > I'm thinking you can shard this just fine, it makes that pop() needs to
> > iterate all shards, but that shouldn't be a problem, and it would still
> > only need to take a single lock.
> 
> Is the idea here to have multiple sharded queues per LLC, with a single
> lock protecting them? 

No, each shard will have it's own lock, each shard it's own cacheline.

> Or did I misunderstand your suggestion entirely?

Yup, so each shard is basically the above struct, whole cacheline with a
lock and list. Then on enqueue we hash to a shard (possibly based on cpu
-- this gives the least amount of bounces) and stick it on.

Then on pop we iterate the shards, the first non-empty shard gets the
lock taken, and pop'ed. If you start iteration based on the cpu->shard
map used for enqueue you can even get a sense of 'locality' depending on
the mapping.

So pop is O(n) in shards, but on average will only take a single lock --
there is an obvious race where it might see a non-empty queue, but race
on lock and find the queue empty once acquired, but meh.

> > I'm thinking 4 or 8 shards should be plenty, even for Intel LLC.
> > 
> > >  #ifdef CONFIG_SMP
> > 
> > > +static struct task_struct *swqueue_pull_task(struct swqueue *swqueue)
> > > +{
> > > +	unsigned long flags;
> > > +
> > > +	struct task_struct *p;
> > > +
> > > +	spin_lock_irqsave(&swqueue->lock, flags);
> > > +	p = list_first_entry_or_null(&swqueue->list, struct task_struct,
> > > +				     swqueue_node);
> > > +	if (p)
> > > +		list_del_init(&p->swqueue_node);
> > > +	spin_unlock_irqrestore(&swqueue->lock, flags);
> > > +
> > > +	return p;
> > > +}
> > 
> > Would this not normally be called pop() or somesuch?
> 
> Yes, I'll improve the name in the next iteration. swqueue_dequeue() and
> swqueue_enqueue() seem like the most canonical. Let me know if you have another
> preference.

Well, there's two layers intermixed here, which is, I think, what gave
rise to the whole wonky naming.

If you implement the queue primitives as: push, pop, del
and then build, using them, the scheduler primitives: enqueue, dequeue,
pick, things should become saner.

> > > +	if (!task_wakeup || task_migrated || p->nr_cpus_allowed == 1)
> > > +		return;
> > 
> > Elsewhere you mentioned heuristics, this smells like them. This and the
> > is_cpus_allowed() thing makes you loose plenty of opportunities.
> 
> Yeah fair enough, these certainly are heuristics as well.
> 
> I thought it best to try and avoid swqueue getting in the way of
> select_task_rq_fair() (at least to start out with), but we could always
> remove that and run other experiments to see how it does.

So, part of the problem is that you might be hooking at the wrong level
(see also my earlier email about the queue only containing running tasks
and none of the ready tasks).

If you were to hook at the __{en,de}queue_entity() level you'll
automagically dequeue running tasks and enqueue any ready tasks. OTOH
you get to deal with the problem that not all entities are tasks, but
that shouldn't be too hard.

Also, you end up with more enqueue/dequeue -- so that might hurt.

Also, at this point you're nr_cpus/N away from simply scanning the
runqueues and pulling things from non-empty runqueues. But for large
nr_cpus and smallish N it might be a win over-all. Dunno..


