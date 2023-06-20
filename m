Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EC573756C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjFTTya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjFTTy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:54:28 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122A6D7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:54:27 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6237faa8677so34369436d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687290866; x=1689882866;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YuFavfnhiMmbwTAYkIV6m5x4hZaZCCkA7kIrJB889Sc=;
        b=D7e1KFWoqGgQMf+p4x5t+xGiVp4l2Ewv7okPshm+GKy9slgXiDJAJfiu/yEf708oRV
         ueoBx3j6weCk5qN+AS39GbHqV6CEA9ULpqI5ZzgdaBj8x6xsI89XS8vwrLOCoPHPE0jq
         jAqyMTepfwDVulJbE9ZPM+HCyjJ5ZfF/zXCWvk9oy7kaC/9M5RV2KqaJR8g/oGelKqby
         /i8QcwhU7hN1tJVlQ1uJ6Pb1dYuvjMLbwrqh7ALjwexmluEsei0odYXfGz+fBuT6IycA
         DdSVqS10wr7Ya1OGpJfyXOYEOO6PBs2G27tRJ2fxRIoOYB2uG+2ga9dNtwD0Nn6VHFNa
         xojw==
X-Gm-Message-State: AC+VfDzrKOCXzhXnh1R/hOgO3biOxxpgYU3TfPMeEmrI01JB9IvYy7+8
        OL53LNXrxuIMPz1U472AvU4=
X-Google-Smtp-Source: ACHHUZ6myNE/Xmx+rE8XqVBQmLG4Y8k85rHAA8/UNDy97P/hmmYOrx10fgISHS09IrhSwc9KGY2Hrg==
X-Received: by 2002:a05:6214:c8a:b0:632:c2e:57ae with SMTP id r10-20020a0562140c8a00b006320c2e57aemr561274qvr.54.1687290865909;
        Tue, 20 Jun 2023 12:54:25 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:2cf0])
        by smtp.gmail.com with ESMTPSA id e17-20020a0cf351000000b005e37909a7fcsm1622025qvm.13.2023.06.20.12.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 12:54:25 -0700 (PDT)
Date:   Tue, 20 Jun 2023 14:54:23 -0500
From:   David Vernet <void@manifault.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, joshdon@google.com,
        roman.gushchin@linux.dev, tj@kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH 3/3] sched: Implement shared wakequeue in CFS
Message-ID: <20230620195423.GB3027191@maniforge>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-4-void@manifault.com>
 <CAKfTPtCT==N_r1Vp-e_cFtVmcdo_YN1aD45AfbLMSpGpu1oU=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCT==N_r1Vp-e_cFtVmcdo_YN1aD45AfbLMSpGpu1oU=w@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 10:08:57AM +0200, Vincent Guittot wrote:
> On Tue, 13 Jun 2023 at 07:20, David Vernet <void@manifault.com> wrote:
> >
> > Overview
> > ========
> >
> > The scheduler must constantly strike a balance between work
> > conservation, and avoiding costly migrations which harm performance due
> > to e.g. decreased cache locality. The matter is further complicated by
> > the topology of the system. Migrating a task between cores on the same
> > LLC may be more optimal than keeping a task local to the CPU, whereas
> > migrating a task between LLCs or NUMA nodes may tip the balance in the
> > other direction.
> >
> > With that in mind, while CFS is by and large mostly a work conserving
> > scheduler, there are certain instances where the scheduler will choose
> > to keep a task local to a CPU, when it would have been more optimal to
> > migrate it to an idle core.
> >
> > An example of such a workload is the HHVM / web workload at Meta. HHVM
> > is a VM that JITs Hack and PHP code in service of web requests. Like
> > other JIT / compilation workloads, it tends to be heavily CPU bound, and
> > exhibit generally poor cache locality. To try and address this, we set
> > several debugfs (/sys/kernel/debug/sched) knobs on our HHVM workloads:
> >
> > - migration_cost_ns -> 0
> > - latency_ns -> 20000000
> > - min_granularity_ns -> 10000000
> > - wakeup_granularity_ns -> 12000000
> >
> > These knobs are intended both to encourage the scheduler to be as work
> > conserving as possible (migration_cost_ns -> 0), and also to keep tasks
> > running for relatively long time slices so as to avoid the overhead of
> > context switching (the other knobs). Collectively, these knobs provide a
> > substantial performance win; resulting in roughly a 20% improvement in
> > throughput. Worth noting, however, is that this improvement is _not_ at
> > full machine saturation.
> >
> > That said, even with these knobs, we noticed that CPUs were still going
> > idle even when the host was overcommitted. In response, we wrote the
> > "shared wakequeue" (swqueue) feature proposed in this patch set. The
> > idea behind swqueue is simple: it enables the scheduler to be
> > aggressively work conserving by placing a waking task into a per-LLC
> > FIFO queue that can be pulled from by another core in the LLC FIFO queue
> > which can then be pulled from before it goes idle.
> 
> This seems to be just another newly idle load balance outside the current one !

Hi Vincent,

I can bring the swqueue logic inside of newidle_balance(). In hindsight
I think it makes more sense there.

To answer your point more generally though, yes, this is a new approach
to load balancing that eschews tracking migration costs, scanning
runqueues, etc in favor of optimizing for work conservation, and
tracking runnable tasks in a shared data structure. More on this below
in response to your other points.

> 
> The knobs above are not the only thing preventing a rq to pull a new
> task. We have rq->avg_idle, curr_cost and sd->max_newidle_lb_cost
> stuff which might be one main root cause for one of your cpu not
> pulling a waiting task
>
> It's not clear in your explanation why fixing newly_idle_load_balance
> was not possible instead of adding outside code and what prevents
> newly_idle_load balance from picking a task in your case ?
> 
> For example, have you tried to disable the early break because of avg_idle ?

The goal of swqueue is to enable work conservation using a shared, per-LLC data
structure. The shared data structure is really the salient point as to why just
updating newidle_balance() wouldn't achieve the same result. newidle_balance()
finds tasks to migrate by (sometimes) iterating over runqueues and scanning for
tasks. It's an expensive operation, which doesn't scale to large machines or to
being performed on every idle path. swqueue, on the other hand, is shared
across all cores in an LLC, so pulling a runnable task is simply a matter of a
spinlock acquire and a list operation. This doesn't scale to every single
configuration as Aaron pointed out in [0], but it works well in many other
configurations.

[0]: https://lore.kernel.org/all/20230614043529.GA1942@ziqianlu-dell/

Another consideration is that even if we could adjust newidle_balance()
to load balance well enough for our specific purpose, we're still
relying on heuristics to determine when it's appropriate to load
balance; and that will 

a) Inevitably be suboptimal for certain workloads and configurations. For
example, if we got rid of the following check:

12021         for_each_domain(this_cpu, sd) {
12022                 int continue_balancing = 1;
12023                 u64 domain_cost;
12024
12025                 update_next_balance(sd, &next_balance);
12026
12027                 if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost)
12028                         break;

we may end up load balancing too frequently, which could be a regression in and
of itself per the scalability concerns mentioned above. Or, for certain
workloads, we'll load balance too aggressively and miss out on L1/L2 locality.

b) Be harder for users to effectively tune or use. At OSPM, Peter made it quite
clear that users should not be tuning any of the debugfs knobs. Relying on
heuristics and knobs like this feels antithetical to that policy. swqueue feels
like a reasonable, self-contained alternative to that.

Thanks,
David
