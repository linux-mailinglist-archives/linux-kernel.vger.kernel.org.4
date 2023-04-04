Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01296D666F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbjDDO6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235528AbjDDO5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:57:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC5E4ED8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 07:56:48 -0700 (PDT)
Date:   Tue, 4 Apr 2023 16:56:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680620205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b8TGuHfJ8bWdeSdfb+xMIX6BS2iHed0QnwUNOtWlhpU=;
        b=QFL4XvzjMaJAUgQ/3C7/d/EwXujZflEulBTR8tf/IrGf56+SzYiXhHAyX+B1jI2BMaaoiM
        Yt70TwYhE/+QDATnxRWnyvvjDOi0f2yhN7WYcEb24vJh0k1JtqOLEjfGExpaTJGVtZtoK0
        7UL5IZt8onM5ZvBiQaTHL5Vx9OrOHCW3c02t3X2VAOPSGWrgIYp/wHSZpl0dZVBmZ50Iup
        aVZtHxp09Sz8IGXBRD8FykcHVsJXyAFhs+j96AkmJ7NqH4ldfU4GMMpmZa/cxoT2OezGZk
        dzYhj37olUYZe/OIdKchIJaUvf7b8IF41B1TAU3G+etQ25ZB9w4yCdunVP17tQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680620205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b8TGuHfJ8bWdeSdfb+xMIX6BS2iHed0QnwUNOtWlhpU=;
        b=zfi5DPedHkr7oR3Q2Gg4eOjnLO5Uec9pdk3L9NvLp/Ki3bQ36QGhpyfacbg1PRNQl6MbF5
        4O8CKFG8B6ej6DCA==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v5 16/18] timer: Implement the hierarchical pull model
In-Reply-To: <20230323142440.GC2512024@hirez.programming.kicks-ass.net>
Message-ID: <a3338e9d-1637-2fd2-52a1-34768f9e92d8@linutronix.de>
References: <20230301141744.16063-1-anna-maria@linutronix.de> <20230301141744.16063-17-anna-maria@linutronix.de> <20230323142440.GC2512024@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023, Peter Zijlstra wrote:

> On Wed, Mar 01, 2023 at 03:17:42PM +0100, Anna-Maria Behnsen wrote:
> 
> > diff --git a/kernel/time/timer_migration.h b/kernel/time/timer_migration.h
> > new file mode 100644
> > index 000000000000..ceb336e705df
> > --- /dev/null
> > +++ b/kernel/time/timer_migration.h
> > @@ -0,0 +1,123 @@
> > +#ifndef _KERNEL_TIME_MIGRATION_H
> > +#define _KERNEL_TIME_MIGRATION_H
> > +
> > +/* Per group capacity. Must be a power of 2! */
> > +#define TMIGR_CHILDS_PER_GROUP 8
> > +
> > +/**
> > + * struct tmigr_event - a timer event associated to a CPU
> > + * @nextevt:	The node to enqueue an event in the parent group queue
> > + * @cpu:	The CPU to which this event belongs
> > + * @ignore:	Hint whether the event could be ignored; it is set when
> > + *		CPU or group is active;
> > + */
> > +struct tmigr_event {
> > +	struct timerqueue_node	nextevt;
> > +	unsigned int		cpu;
> > +	int			ignore;
> > +};
> > +
> > +/**
> > + * struct tmigr_group - timer migration hierarchy group
> > + * @lock:		Lock protecting the event information
> > + * @cpus:		Array with CPUs which are member of group; required for
> > + *			sibling CPUs; used only when level == 0
> 
> That's 32 bytes wasted for every group that isn't 0, maybe stick on the
> end and conditionally allocate? Also, afaict it is only ever used during
> setup, and as such should not be placed in a hot line, unless you've
> done that explicitly as padding, in which case it needs a comment to
> that effect.
> 
> Also, since it's setup only, why can't you match against:
> 
>   per_cpu_ptr(&tmigr_cpu, cpu)->parent
> 
> ?

This cpus array is currently used to make sure siblings will end up in the
same level 0 group. When matching against the per_cpu_ptr(&tmigr_cpu,
cpu)->parent, I would need to rely on the topology mask and have a look if
the sibling already has a parent.

My question here is: Is it required that siblings end up in the same group
in level 0, or is it enough if the numa node is the same?

> > + * @parent:		Pointer to parent group
> > + * @list:		List head that is added to per level tmigr_level_list
> 
> Also setup only?

Jupp.

> > + * @level:		Hierarchy level of group
> > + * @numa_node:		Is set to numa node when level < tmigr_crossnode_level;
> > + *			otherwise it is set to NUMA_NO_NODE; Required for setup
> > + *			only
> > + * @num_childs:		Counter of group childs; Required for setup only
> > + * @num_cores:		Counter of cores per group; Required for setup only when
> > + *			level == 0 and siblings exist
> 
> Also setup only, move the end?

Same. Will move all the setup stuff to the end.

> > + * @migr_state:		State of group (see struct tmigr_state)
> > + * @childmask:		childmask of group in parent group; is set during setup
> > + *			never changed; could be read lockless
> > + * @events:		Timer queue for child events queued in the group
> > + * @groupevt:		Next event of group; it is only reliable when group is
> > + *			!active (ignore bit is set when group is active)
> > + * @next_expiry:	Base monotonic expiry time of next event of group;
> > + *			Used for racy lockless check whether remote expiry is
> > + *			required; it is always reliable
> 
> This is basically leftmost of @events? A racy lockless check sorta
> implies not reliable, comment is confusing.

It's always updated and contains the expiry value of the first event which
is enqueued into timer queue "events" - reliable is the wrong term here.

> Also, isn't this identical to @groupevt.nextevt.expiry ?

No, it is not identical. Because groupevt is only used and reliable, when
the group is idle to enqueue the first group event into the parent
group. But the migrator of the group needs to check whether timers needs to
be handled remote because some children are idle. Therefore I do not have to
update the whole event.

> > + */
> > +struct tmigr_group {
> > +	raw_spinlock_t		lock;
> > +	unsigned int		cpus[TMIGR_CHILDS_PER_GROUP];
> > +	struct tmigr_group	*parent;
> > +	struct list_head	list;
> > +	unsigned int		level;
> > +	unsigned int		numa_node;
> > +	unsigned int		num_childs;
> > +	unsigned int		num_cores;
> > +	atomic_t		*migr_state;
> 
> Per the other email; why isn't this:
> 
> 	union tmigr_state	migr_state;
> 
> ?

I will change this into a direct member. The reason for not being a direct
member is - because it grows like this...

Only for handling the tmigr_group->migr_state, atomic operations are used
the splitted members are never accessed. All other states are not handled
with atomic operations. If it is 'union tmigr_state' inside the
tmigr_group, then I would need an atomic_t inside the union and the union
gets more complex. I hope I was able to explain my point.

> > +	u32			childmask;
> > +	struct timerqueue_head	events;
> > +	struct tmigr_event	groupevt;
> > +	u64			next_expiry;
> > +};
> > +

I come back to your other remarks in a separate mail.

Thanks,

	Anna-Maria

