Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F5D6C6ADE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjCWOZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjCWOZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:25:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371A115164
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 07:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=esQYDR8RvRVxr4tfb08WOmArP4yRodEb4gH8l2VFF9k=; b=R17l5mZSlfy9RDyfxYENuuc0Eg
        BRd8jzmzmTb45svJc6FP5if/vIptc8BnXhnyqtFg0Ja5Nh2aK0ScLStt9m5l8808fDkm7+k8bW3Tz
        bYxMhiK2XRBD70jev1souCggOQStYx34/gQI6H1joQXC4Ix7ti+I0Kb7XnYAvOeFmyDTnELaxAcW/
        Xjhfq7V2NePdlKLosYeovlh/X9XQiHGYkrbH7kIgNO27SRtf4WgiFR4AIvanUccXPxMl6xifLxaHj
        HQtQN463Izdabi8nEwr1ckkAWyQ2UUzIJ0+rgx+HmpLRiFYVSOUu05dJxC0bjYrvF9auNJgkbYjnt
        hDeBjkpw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfLrx-0040Xi-H9; Thu, 23 Mar 2023 14:24:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E04A30030F;
        Thu, 23 Mar 2023 15:24:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 44F002420A88A; Thu, 23 Mar 2023 15:24:40 +0100 (CET)
Date:   Thu, 23 Mar 2023 15:24:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v5 16/18] timer: Implement the hierarchical pull model
Message-ID: <20230323142440.GC2512024@hirez.programming.kicks-ass.net>
References: <20230301141744.16063-1-anna-maria@linutronix.de>
 <20230301141744.16063-17-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301141744.16063-17-anna-maria@linutronix.de>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 03:17:42PM +0100, Anna-Maria Behnsen wrote:

> diff --git a/kernel/time/timer_migration.h b/kernel/time/timer_migration.h
> new file mode 100644
> index 000000000000..ceb336e705df
> --- /dev/null
> +++ b/kernel/time/timer_migration.h
> @@ -0,0 +1,123 @@
> +#ifndef _KERNEL_TIME_MIGRATION_H
> +#define _KERNEL_TIME_MIGRATION_H
> +
> +/* Per group capacity. Must be a power of 2! */
> +#define TMIGR_CHILDS_PER_GROUP 8
> +
> +/**
> + * struct tmigr_event - a timer event associated to a CPU
> + * @nextevt:	The node to enqueue an event in the parent group queue
> + * @cpu:	The CPU to which this event belongs
> + * @ignore:	Hint whether the event could be ignored; it is set when
> + *		CPU or group is active;
> + */
> +struct tmigr_event {
> +	struct timerqueue_node	nextevt;
> +	unsigned int		cpu;
> +	int			ignore;
> +};
> +
> +/**
> + * struct tmigr_group - timer migration hierarchy group
> + * @lock:		Lock protecting the event information
> + * @cpus:		Array with CPUs which are member of group; required for
> + *			sibling CPUs; used only when level == 0

That's 32 bytes wasted for every group that isn't 0, maybe stick on the
end and conditionally allocate? Also, afaict it is only ever used during
setup, and as such should not be placed in a hot line, unless you've
done that explicitly as padding, in which case it needs a comment to
that effect.

Also, since it's setup only, why can't you match against:

  per_cpu_ptr(&tmigr_cpu, cpu)->parent

?

> + * @parent:		Pointer to parent group
> + * @list:		List head that is added to per level tmigr_level_list

Also setup only?

> + * @level:		Hierarchy level of group
> + * @numa_node:		Is set to numa node when level < tmigr_crossnode_level;
> + *			otherwise it is set to NUMA_NO_NODE; Required for setup
> + *			only
> + * @num_childs:		Counter of group childs; Required for setup only
> + * @num_cores:		Counter of cores per group; Required for setup only when
> + *			level == 0 and siblings exist

Also setup only, move the end?

> + * @migr_state:		State of group (see struct tmigr_state)
> + * @childmask:		childmask of group in parent group; is set during setup
> + *			never changed; could be read lockless
> + * @events:		Timer queue for child events queued in the group
> + * @groupevt:		Next event of group; it is only reliable when group is
> + *			!active (ignore bit is set when group is active)
> + * @next_expiry:	Base monotonic expiry time of next event of group;
> + *			Used for racy lockless check whether remote expiry is
> + *			required; it is always reliable

This is basically leftmost of @events? A racy lockless check sorta
implies not reliable, comment is confusing.

Also, isn't this identical to @groupevt.nextevt.expiry ?

> + */
> +struct tmigr_group {
> +	raw_spinlock_t		lock;
> +	unsigned int		cpus[TMIGR_CHILDS_PER_GROUP];
> +	struct tmigr_group	*parent;
> +	struct list_head	list;
> +	unsigned int		level;
> +	unsigned int		numa_node;
> +	unsigned int		num_childs;
> +	unsigned int		num_cores;
> +	atomic_t		*migr_state;

Per the other email; why isn't this:

	union tmigr_state	migr_state;

?

> +	u32			childmask;
> +	struct timerqueue_head	events;
> +	struct tmigr_event	groupevt;
> +	u64			next_expiry;
> +};
> +
> +/**
> + * struct tmigr_cpu - timer migration per CPU group
> + * @lock:	Lock protecting tmigr_cpu group information
> + * @online:	Indicates wheter CPU is online

What I'm missing is *why* we're keeping this state. I suspect you need
serialization on tmigr_cpu->lock between hotplug and something.

> + * @idle:	Indicates wheter CPU is idle in timer migration hierarchy
> + * @remote:	Is set when timers of CPU are expired remote

How are these not the same? When idle timers are expired remote, no?

> + * @tmgroup:	Pointer to parent group
> + * @childmask:	childmask of tmigr_cpu in parent group
> + * @cpuevt:	CPU event which could be queued into parent group
> + * @wakeup:	Stores the first timer when the timer migration hierarchy is
> + *		completely idle and remote expiry was done; is returned to
> + *		timer code when tmigr_cpu_deactive() is called and group is
> + *		idle; afterwards a reset to KTIME_MAX is required;
> + */
> +struct tmigr_cpu {
> +	raw_spinlock_t		lock;
> +	int			online;
> +	int			idle;
> +	int			remote;
> +	struct tmigr_group	*tmgroup;
> +	u32			childmask;
> +	struct tmigr_event	cpuevt;
> +	u64			wakeup;
> +};
> +
> +/**
> + * union tmigr_state - state of tmigr_group
> + * @state:	Combined version of the state - only used for atomic
> + * 		read/cmpxchg function
> + * @struct:	Splitted version of the state - only use the struct members to
> + *		update information to stay independant of endianess
> + */
> +union tmigr_state {
> +	u32 state;
> +	/**
> +	 * struct - splitted state of tmigr_group
> +	 * @active:	Contains each childmask bit of active childs
> +	 * @migrator:	Contains childmask of child which is migrator
> +	 * @seq:	Seqence number to prevent race when update in child
> +	 *		group are propagated in wrong order (especially when
> +	 *		migrator changes are involved)
> +	 */
> +	struct {
> +		u8	active;
> +		u8	migrator;

So childmask is the bit set in either of these masks, but it is u32
elsewhere and u8 here. Surely if the target type is u8, then it is best
to keep it consistently u8 elsewhere too, no?

> +		u16	seq;
> +	} __packed;
> +};
