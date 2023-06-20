Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AB97376BE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 23:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjFTViQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 17:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjFTViO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 17:38:14 -0400
Received: from out-30.mta1.migadu.com (out-30.mta1.migadu.com [95.215.58.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD5C1739
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:38:12 -0700 (PDT)
Date:   Tue, 20 Jun 2023 14:37:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687297088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=60OO0jtISCjEIpK8se6Yga1g7BdYQxPXZlUI/Wu6eR8=;
        b=maobrQhqDPMa6kqlZYyRmRMiWZQJV1OE5tw0GIUzqjHOZQF5zAMhYG7nscpeu2QRxGQctj
        h91mTb1asvSa3L6CzjGPHR8PgPGR8e42a+gN3MBvgoFuGw+wb0+nMcDlPfyZZejFE8AMf5
        w6PSIEKlPigBJrZaUM/c5K44ZyxaIHI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     David Vernet <void@manifault.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, joshdon@google.com,
        tj@kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH 3/3] sched: Implement shared wakequeue in CFS
Message-ID: <ZJIcLf0489kLMtjQ@P9FQF9L96D.corp.robot.car>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-4-void@manifault.com>
 <CAKfTPtCT==N_r1Vp-e_cFtVmcdo_YN1aD45AfbLMSpGpu1oU=w@mail.gmail.com>
 <20230620195423.GB3027191@maniforge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620195423.GB3027191@maniforge>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 02:54:23PM -0500, David Vernet wrote:
> On Fri, Jun 16, 2023 at 10:08:57AM +0200, Vincent Guittot wrote:
> > On Tue, 13 Jun 2023 at 07:20, David Vernet <void@manifault.com> wrote:
> > >
> > > Overview
> > > ========
> > >
> > > The scheduler must constantly strike a balance between work
> > > conservation, and avoiding costly migrations which harm performance due
> > > to e.g. decreased cache locality. The matter is further complicated by
> > > the topology of the system. Migrating a task between cores on the same
> > > LLC may be more optimal than keeping a task local to the CPU, whereas
> > > migrating a task between LLCs or NUMA nodes may tip the balance in the
> > > other direction.
> > >
> > > With that in mind, while CFS is by and large mostly a work conserving
> > > scheduler, there are certain instances where the scheduler will choose
> > > to keep a task local to a CPU, when it would have been more optimal to
> > > migrate it to an idle core.
> > >
> > > An example of such a workload is the HHVM / web workload at Meta. HHVM
> > > is a VM that JITs Hack and PHP code in service of web requests. Like
> > > other JIT / compilation workloads, it tends to be heavily CPU bound, and
> > > exhibit generally poor cache locality. To try and address this, we set
> > > several debugfs (/sys/kernel/debug/sched) knobs on our HHVM workloads:
> > >
> > > - migration_cost_ns -> 0
> > > - latency_ns -> 20000000
> > > - min_granularity_ns -> 10000000
> > > - wakeup_granularity_ns -> 12000000
> > >
> > > These knobs are intended both to encourage the scheduler to be as work
> > > conserving as possible (migration_cost_ns -> 0), and also to keep tasks
> > > running for relatively long time slices so as to avoid the overhead of
> > > context switching (the other knobs). Collectively, these knobs provide a
> > > substantial performance win; resulting in roughly a 20% improvement in
> > > throughput. Worth noting, however, is that this improvement is _not_ at
> > > full machine saturation.
> > >
> > > That said, even with these knobs, we noticed that CPUs were still going
> > > idle even when the host was overcommitted. In response, we wrote the
> > > "shared wakequeue" (swqueue) feature proposed in this patch set. The
> > > idea behind swqueue is simple: it enables the scheduler to be
> > > aggressively work conserving by placing a waking task into a per-LLC
> > > FIFO queue that can be pulled from by another core in the LLC FIFO queue
> > > which can then be pulled from before it goes idle.
> > 
> > This seems to be just another newly idle load balance outside the current one !
> 
> Hi Vincent,
> 
> I can bring the swqueue logic inside of newidle_balance(). In hindsight
> I think it makes more sense there.
> 
> To answer your point more generally though, yes, this is a new approach
> to load balancing that eschews tracking migration costs, scanning
> runqueues, etc in favor of optimizing for work conservation, and
> tracking runnable tasks in a shared data structure. More on this below
> in response to your other points.
> 
> > 
> > The knobs above are not the only thing preventing a rq to pull a new
> > task. We have rq->avg_idle, curr_cost and sd->max_newidle_lb_cost
> > stuff which might be one main root cause for one of your cpu not
> > pulling a waiting task
> >
> > It's not clear in your explanation why fixing newly_idle_load_balance
> > was not possible instead of adding outside code and what prevents
> > newly_idle_load balance from picking a task in your case ?
> > 
> > For example, have you tried to disable the early break because of avg_idle ?
> 
> The goal of swqueue is to enable work conservation using a shared, per-LLC data
> structure. The shared data structure is really the salient point as to why just
> updating newidle_balance() wouldn't achieve the same result. newidle_balance()
> finds tasks to migrate by (sometimes) iterating over runqueues and scanning for
> tasks. It's an expensive operation, which doesn't scale to large machines or to
> being performed on every idle path. swqueue, on the other hand, is shared
> across all cores in an LLC, so pulling a runnable task is simply a matter of a
> spinlock acquire and a list operation. This doesn't scale to every single
> configuration as Aaron pointed out in [0], but it works well in many other
> configurations.

+1

Additionally, swqueue minimizes the number of races when two tasks pick
the same cpu for being woken up.
It's also serializing the wakeup order, which effectively pessimises tasks
which are woken very often and promotes cpu-bound tasks, which usually
positively affects the throughput.

I agree that swqueue can be seen as an alternative form of the idle load balancing,
I thought this way when I was working on it.
Can it replace it completely? Idk, maybe. But maybe we need some sort of a balancing
between multiple wait queues. E.g. if there are two swqueues on the system, one is empty
and another is long, load idle balancing can borrow some tasks from the "foreign" swqueue.
Just some ideas.

Thanks!
