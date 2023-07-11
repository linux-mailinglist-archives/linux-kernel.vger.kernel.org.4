Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C341F74E607
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 06:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjGKEnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 00:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjGKEnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 00:43:53 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6B1A9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 21:43:50 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-40398ccdaeeso23140851cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 21:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689050629; x=1691642629;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYkim05IY6DDa9DIUE8NqpYmo491OhXKoKM5NkgZ7eQ=;
        b=XeXe2td86jhEbjJLpVbK/Db6LkR+Af5Yx2nJ0F248K0waxaaO741Ouhsc0q/wmRwLD
         N970Tj83zbRgBWAmFsjmBx+mjGMuzaZRVuGnOo0B3g+pGp68qG84hpFoLFzfaJkbmBHG
         y6oh0WKxHe4qc2ncVhnhjXZD1LVoNKmIWr0MGiAgl6Uc4donP+A0whyMp8cmRO9TO7Xx
         dsN0VSYNIN6bmL0bZKzvH2N6vldYtV2ihKwD4nwGeuasgd+y6Xen3gmE1w2Jg5UG6Kix
         pQ7MfydydiBiTQz1uBmzvNFUOGwgLj1KpME9j7TstddI/boe8Gdw8wtq2VB8Q7GDy9wN
         oH4Q==
X-Gm-Message-State: ABy/qLYhZ5XcUvLF9SQDyLy3k8lCyH+Ge3E6reU55SGxm3g5VIy/gQtV
        PBJx2+6Dtdt8urnj3Ssc5HI=
X-Google-Smtp-Source: APBJJlEjH1oN1gdLurztIHIG5pw/vQR45mqgDYV4KTf9//XLf0aHx4nIPI9cGzFT35oXdh1iJ98sZg==
X-Received: by 2002:a05:622a:209:b0:403:abf5:6fec with SMTP id b9-20020a05622a020900b00403abf56fecmr6788943qtx.23.1689050628924;
        Mon, 10 Jul 2023 21:43:48 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:4850])
        by smtp.gmail.com with ESMTPSA id cf17-20020a05622a401100b003fdec95e9c8sm678170qtb.83.2023.07.10.21.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 21:43:48 -0700 (PDT)
Date:   Mon, 10 Jul 2023 23:43:45 -0500
From:   David Vernet <void@manifault.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, joshdon@google.com,
        roman.gushchin@linux.dev, tj@kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH 0/3] sched: Implement shared wakequeue in CFS
Message-ID: <20230711044345.GC376791@maniforge>
References: <20230613052004.2836135-1-void@manifault.com>
 <2b1fba1c-da7a-f7a0-552a-c6dbc7ac2b7e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b1fba1c-da7a-f7a0-552a-c6dbc7ac2b7e@amd.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 05:27:15PM +0530, K Prateek Nayak wrote:
> Hello David,
> 
> Sharing the results from testing SWQUEUE with some of the standard
> benchmarks below.

Hello Prateek,

Thank you for taking the time to run these benchmarks. Very much
appreciated. As I expect you saw given that I cc'd you, I sent v2 of
this series out this morning in [0].

[0]: https://lore.kernel.org/all/20230710200342.358255-1-void@manifault.com/

There were quite a few changes, so if you have the bandwidth it may be
worth running these benchmarks again on v2.

> tl;dr
> 
> - Hackbench, tbench, DeathStarBench and SPECjbb seem to like the
>   SWQUEUE (except for hackbench in NPS4, with 16 groups)

Excellent, glad to hear that. I observed a significant improvement in
hackbench as well on v2, glad to hear that other benchmarks seem to like
this too.

> 
> - Netperf sees regression as system becomes more loaded. I'll go
>   back and check if there is some lock contention issues here which
>   is parallely being discussed on the tread.

Lock contention is indeed the issue, as Aaron pointed out in [1].

[1]: https://lore.kernel.org/lkml/20230614043529.GA1942@ziqianlu-dell/

Sharding the per-LLC shared runqueues helps quite a bit here, but it
doesn't fully address the issue. See my write-up on the v2 cover letter
for more info.

> 
> - Other benchmarks seem to be behave similar to tip.
> 
> On 6/13/2023 10:50 AM, David Vernet wrote:
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
> > 
> > With this simple change, we were able to achieve a 1 - 1.6% improvement
> > in throughput, as well as a small, consistent improvement in p95 and p99
> > latencies, in HHVM. These performance improvements were in addition to
> > the wins from the debugfs knobs mentioned above.
> > 
> > Design
> > ======
> > 
> > The design of swqueue is quite simple. An swqueue is simply a struct
> > list_head, and a spinlock:
> > 
> > struct swqueue {
> > 	struct list_head list;
> > 	spinlock_t lock;
> > } ____cacheline_aligned;
> > 
> > We create a struct swqueue per LLC, ensuring they're in their own
> > cachelines to avoid false sharing between CPUs on different LLCs.
> > 
> > When a task first wakes up, it enqueues itself in the swqueue of its
> > current LLC at the end of enqueue_task_fair(). Enqueues only happen if
> > the task was not manually migrated to the current core by
> > select_task_rq(), and is not pinned to a specific CPU.
> > 
> > A core will pull a task from its LLC's swqueue before calling
> > newidle_balance().
> > 
> > Difference between SIS_NODE
> > ===========================
> > 
> > In [0] Peter proposed a patch that addresses Tejun's observations that
> > when workqueues are targeted towards a specific LLC on his Zen2 machine
> > with small CCXs, that there would be significant idle time due to
> > select_idle_sibling() not considering anything outside of the current
> > LLC.
> > 
> > This patch (SIS_NODE) is essentially the complement to the proposal
> > here. SID_NODE causes waking tasks to look for idle cores in neighboring
> > LLCs on the same die, whereas swqueue causes cores about to go idle to
> > look for enqueued tasks. That said, in its current form, the two
> > features at are a different scope as SIS_NODE searches for idle cores
> > between LLCs, while swqueue enqueues tasks within a single LLC.
> > 
> > The patch was since removed in [1], but we elect to compare its
> > performance to swqueue given that as described above, it's conceptually
> > complementary.
> > 
> > [0]: https://lore.kernel.org/all/20230530113249.GA156198@hirez.programming.kicks-ass.net/
> > [1]: https://lore.kernel.org/all/20230605175636.GA4253@hirez.programming.kicks-ass.net/
> > 
> > I observed that while SIS_NODE works quite well for hosts with small
> > CCXs, it can result in degraded performance on machines either with a
> > large number of total cores in a CCD, or for which the cache miss
> > penalty of migrating between CCXs is high, even on the same die.
> > 
> > For example, on Zen 4c hosts (Bergamo), CCXs within a CCD are muxed
> > through a single link to the IO die, and thus have similar cache miss
> > latencies as cores in remote CCDs.
> > 
> > Such subtleties could be taken into account with SIS_NODE, but
> > regardless, both features are conceptually complementary sides of the
> > same coin. SIS_NODE searches for idle cores for waking threads, whereas
> > swqueue searches for available work before a core goes idle.
> > 
> > Results
> > =======
> > 
> > Note that the motivation for the shared wakequeue feature was originally
> > arrived at using experiments in the sched_ext framework that's currently
> > being proposed upstream. The ~1 - 1.6% improvement in HHVM throughput
> > is similarly visible using work-conserving sched_ext schedulers (even
> > very simple ones like global FIFO).
> > 
> > In both single and multi socket / CCX hosts, this can measurably improve
> > performance. In addition to the performance gains observed on our
> > internal web workloads, we also observed an improvement in common
> > workloads such as kernel compile when running shared wakequeue. Here are
> > the results of running make -j$(nproc) built-in.a on several different
> > types of hosts configured with make allyesconfig on commit a27648c74210
> > ("afs: Fix setting of mtime when creating a file/dir/symlink") on Linus'
> > tree (boost was disabled on all of these hosts when the experiments were
> > performed):
> > 
> > Single-socket | 32-core | 2-CCX | AMD 7950X Zen4
> > 
> > CPU max MHz:                     5879.8818
> > CPU min MHz:                     3000.0000
> > 				o____________o_______o
> > 				|    mean    | CPU   |
> > 				o------------o-------o
> > NO_SWQUEUE + NO_SIS_NODE:	| 590.52s    | 3103% |
> > NO_SWQUEUE + SIS_NODE:		| 590.80s    | 3102% |
> > SWQUEUE + NO_SIS_NODE:		| 589.65s    | 3116% |
> > SWQUEUE + SIS_NODE:		| 589.99s    | 3115% |
> > 				o------------o-------o
> > 
> > Takeaway: swqueue doesn't seem to provide a statistically significant
> > improvement for kernel compile on my 7950X. SIS_NODE similarly does not
> > have a noticeable effect on performance.
> > 
> > -------------------------------------------------------------------------------
> > 
> > Single-socket | 72-core | 6-CCX | AMD Milan Zen3
> > 
> > CPU max MHz:                     3245.0190
> > CPU min MHz:                     700.0000
> > 				o_____________o_______o
> > 				|    mean     | CPU   |
> > 				o-------------o-------o
> > NO_SWQUEUE + NO_SIS_NODE:	| 1608.69s    | 6488% |
> > NO_SWQUEUE + SIS_NODE:		| 1610.24s    | 6473% |
> > SWQUEUE + NO_SIS_NODE:		| 1605.80s    | 6504% |
> > SWQUEUE + SIS_NODE:		| 1606.96s    | 6488% |
> > 				o-------------o-------o
> > 
> > Takeaway: swqueue does provide a small statistically significant
> > improvement on Milan, but the compile times in general were quite long
> > relative to the 7950X Zen4, and the Bergamo Zen4c due to the lower clock
> > frequency. Milan also has larger CCXs than Bergamo, so it stands to
> > reason that select_idle_sibling() will have an easier time finding idle
> > cores inside the current CCX.
> 
> o System Details
> 
> Dual Socket 3rd Generation EPYC System (2 x 64C/128T)

Oh yeah, this would definitely run into contention on netperf. We were
seeing it on smaller LLCs as well. Very curious to hear about how the
sharded approach works for machines of this size.

> o NPS Modes
> 
> NPS Modes are used to logically divide single socket into
> multiple NUMA region.
> Following is the NUMA configuration for each NPS mode on the system:
> 
> NPS1: Each socket is a NUMA node.
>     Total 2 NUMA nodes in the dual socket machine.
> 
>     Node 0: 0-63,   128-191
>     Node 1: 64-127, 192-255
> 
> NPS2: Each socket is further logically divided into 2 NUMA regions.
>     Total 4 NUMA nodes exist over 2 socket.
>    
>     Node 0: 0-31,   128-159
>     Node 1: 32-63,  160-191
>     Node 2: 64-95,  192-223
>     Node 3: 96-127, 223-255
> 
> NPS4: Each socket is logically divided into 4 NUMA regions.
>     Total 8 NUMA nodes exist over 2 socket.

Do these logical NUMA regions all share the same LLC? If so, I think the
sharded approach is probably preferable to this, though I guess it
depends on how bad the overhead is for newidle_balance() to walk all the
shards to find an idle task.

>    
>     Node 0: 0-15,    128-143
>     Node 1: 16-31,   144-159
>     Node 2: 32-47,   160-175
>     Node 3: 48-63,   176-191
>     Node 4: 64-79,   192-207
>     Node 5: 80-95,   208-223
>     Node 6: 96-111,  223-231
>     Node 7: 112-127, 232-255
> 
> o Kernel Versions
> 
> - tip              - tip:sched/core at commit e2a1f85bf9f5 "sched/psi:
>                      Avoid resetting the min update period when it is
>                      unnecessary")
> 
> - SWQUEUE	   - tip:sched/core + this patch
> 		     (SWQUEUE feature enabled from debugfs)
> 
> ~~~~~~~~~~~~~
> ~ hackbench ~
> ~~~~~~~~~~~~~
> 
> o NPS1
> 
> Test:			tip			SWQUEUE
>  1-groups:	   3.92 (0.00 pct)	   3.41 (13.01 pct)
>  2-groups:	   4.58 (0.00 pct)	   3.80 (17.03 pct)
>  4-groups:	   4.99 (0.00 pct)	   4.48 (10.22 pct)
>  8-groups:	   5.67 (0.00 pct)	   5.11 (9.87 pct)
> 16-groups:	   7.88 (0.00 pct)	   7.29 (7.48 pct)
> 
> o NPS2
> 
> Test:			tip			SWQUEUE
>  1-groups:	   3.82 (0.00 pct)	   3.45 (9.68 pct)
>  2-groups:	   4.40 (0.00 pct)	   3.72 (15.45 pct)
>  4-groups:	   4.84 (0.00 pct)	   4.27 (11.77 pct)
>  8-groups:	   5.45 (0.00 pct)	   4.98 (8.62 pct)
> 16-groups:	   6.94 (0.00 pct)	   6.82 (1.72 pct)
> 
> o NPS4
> 
> Test:			tip			SWQUEUE
>  1-groups:	   3.82 (0.00 pct)	   3.50 (8.37 pct)
>  2-groups:	   4.44 (0.00 pct)	   3.77 (15.09 pct)
>  4-groups:	   4.86 (0.00 pct)	   4.44 (8.64 pct)
>  8-groups:	   5.42 (0.00 pct)	   5.08 (6.27 pct)
> 16-groups:	   6.68 (0.00 pct)	   7.82 (-17.06 pct)
> 
> ~~~~~~~~~~~~
> ~ schbench ~
> ~~~~~~~~~~~~
> 
> o NPS1
> 
> #workers:	tip			SWQUEUE
>   1:	  26.00 (0.00 pct)	  28.00 (-7.69 pct)
>   2:	  27.00 (0.00 pct)	  23.00 (14.81 pct)
>   4:	  31.00 (0.00 pct)	  29.00 (6.45 pct)
>   8:	  36.00 (0.00 pct)	  38.00 (-5.55 pct)
>  16:	  49.00 (0.00 pct)	  48.00 (2.04 pct)
>  32:	  80.00 (0.00 pct)	  78.00 (2.50 pct)
>  64:	 169.00 (0.00 pct)	 168.00 (0.59 pct)
> 128:	 343.00 (0.00 pct)	 383.00 (-11.66 pct)
> 256:	 42048.00 (0.00 pct)	 50368.00 (-19.78 pct)
> 512:	 95104.00 (0.00 pct)	 93312.00 (1.88 pct)
> 
> o NPS2
> 
> #workers:	tip			SWQUEUE
>   1:	  23.00 (0.00 pct)	  21.00 (8.69 pct)
>   2:	  24.00 (0.00 pct)	  25.00 (-4.16 pct)
>   4:	  31.00 (0.00 pct)	  29.00 (6.45 pct)
>   8:	  41.00 (0.00 pct)	  43.00 (-4.87 pct)
>  16:	  48.00 (0.00 pct)	  50.00 (-4.16 pct)
>  32:	  81.00 (0.00 pct)	  80.00 (1.23 pct)
>  64:	 157.00 (0.00 pct)	 161.00 (-2.54 pct)
> 128:	 386.00 (0.00 pct)	 413.00 (-6.99 pct)
> 256:	 48832.00 (0.00 pct)	 49472.00 (-1.31 pct)
> 512:	 92032.00 (0.00 pct)	 93568.00 (-1.66 pct)
> 
> o NPS4
> 
> #workers:	tip			SWQUEUE
>   1:	  21.00 (0.00 pct)	  22.00 (-4.76 pct)
>   2:	  28.00 (0.00 pct)	  27.00 (3.57 pct)
>   4:	  32.00 (0.00 pct)	  29.00 (9.37 pct)
>   8:	  46.00 (0.00 pct)	  44.00 (4.34 pct)
>  16:	  51.00 (0.00 pct)	  59.00 (-15.68 pct)
>  32:	  82.00 (0.00 pct)	  86.00 (-4.87 pct)
>  64:	 173.00 (0.00 pct)	 164.00 (5.20 pct)
> 128:	 396.00 (0.00 pct)	 400.00 (-1.01 pct)
> 256:	 48832.00 (0.00 pct)	 45504.00 (6.81 pct)
> 512:	 95104.00 (0.00 pct)	 96640.00 (-1.61 pct)
> 
> 
> ~~~~~~~~~~
> ~ tbench ~
> ~~~~~~~~~~
> 
> o NPS1
> 
> Clients:	tip			SWQUEUE
>     1	 452.49 (0.00 pct)	 438.60 (-3.06 pct)
>     2	 862.44 (0.00 pct)	 859.99 (-0.28 pct)
>     4	 1604.27 (0.00 pct)	 1593.44 (-0.67 pct)
>     8	 2966.77 (0.00 pct)	 3005.65 (1.31 pct)
>    16	 5176.70 (0.00 pct)	 5263.86 (1.68 pct)
>    32	 8205.24 (0.00 pct)	 8890.77 (8.35 pct)
>    64	 13956.71 (0.00 pct)	 14600.43 (4.61 pct)
>   128	 24005.50 (0.00 pct)	 25695.32 (7.03 pct)
>   256	 32457.61 (0.00 pct)	 35580.53 (9.62 pct)
>   512	 34345.24 (0.00 pct)	 39206.89 (14.15 pct)
>  1024	 33432.92 (0.00 pct)	 38751.11 (15.90 pct)
> 
> o NPS2
> 
> Clients:	tip			SWQUEUE
>     1	 453.73 (0.00 pct)	 447.49 (-1.37 pct)
>     2	 861.71 (0.00 pct)	 849.51 (-1.41 pct)
>     4	 1599.14 (0.00 pct)	 1604.38 (0.32 pct)
>     8	 2951.03 (0.00 pct)	 2992.67 (1.41 pct)
>    16	 5080.32 (0.00 pct)	 5318.28 (4.68 pct)
>    32	 7900.41 (0.00 pct)	 7845.42 (-0.69 pct)
>    64	 14629.65 (0.00 pct)	 14621.95 (-0.05 pct)
>   128	 23155.88 (0.00 pct)	 24286.26 (4.88 pct)
>   256	 33449.57 (0.00 pct)	 33606.58 (0.46 pct)
>   512	 33757.47 (0.00 pct)	 37592.42 (11.36 pct)
>  1024	 34823.14 (0.00 pct)	 38943.21 (11.83 pct)
> 
> o NPS4
> 
> Clients:	tip			SWQUEUE
>     1	 450.14 (0.00 pct)	 444.69 (-1.21 pct)
>     2	 863.26 (0.00 pct)	 859.65 (-0.41 pct)
>     4	 1618.71 (0.00 pct)	 1604.36 (-0.88 pct)
>     8	 2929.35 (0.00 pct)	 2996.47 (2.29 pct)
>    16	 5114.04 (0.00 pct)	 5243.98 (2.54 pct)
>    32	 7912.18 (0.00 pct)	 8200.71 (3.64 pct)
>    64	 14424.72 (0.00 pct)	 14149.10 (-1.91 pct)
>   128	 23614.97 (0.00 pct)	 24149.05 (2.26 pct)
>   256	 34365.13 (0.00 pct)	 34244.24 (-0.35 pct)
>   512	 34215.50 (0.00 pct)	 39799.28 (16.31 pct)
>  1024	 35421.90 (0.00 pct)	 40460.77 (14.22 pct)
> 
> 
> ~~~~~~~~~~
> ~ stream ~
> ~~~~~~~~~~
> 
> o NPS1
> 
> - 10 Runs:
> 
> Test:		tip			SWQUEUE
>  Copy:	 271317.35 (0.00 pct)	 281858.05 (3.88 pct)
> Scale:	 205533.77 (0.00 pct)	 203003.11 (-1.23 pct)
>   Add:	 221624.62 (0.00 pct)	 226854.06 (2.35 pct)
> Triad:	 228500.68 (0.00 pct)	 224038.89 (-1.95 pct)
> 
> - 100 Runs:
> 
> Test:		tip			SWQUEUE
>  Copy:	 317381.65 (0.00 pct)	 319745.64 (0.74 pct)
> Scale:	 214145.00 (0.00 pct)	 210485.52 (-1.70 pct)
>   Add:	 239243.29 (0.00 pct)	 233651.11 (-2.33 pct)
> Triad:	 249477.76 (0.00 pct)	 241242.87 (-3.30 pct)
> 
> o NPS2
> 
> - 10 Runs:
> 
> Test:		tip			SWQUEUE
>  Copy:	 277761.29 (0.00 pct)	 292487.03 (5.30 pct)
> Scale:	 215193.83 (0.00 pct)	 209904.82 (-2.45 pct)
>   Add:	 242725.75 (0.00 pct)	 239361.95 (-1.38 pct)
> Triad:	 237253.44 (0.00 pct)	 249638.69 (5.22 pct)
> 
> - 100 Runs:
> 
> Test:		tip			SWQUEUE
>  Copy:	 318082.10 (0.00 pct)	 318466.54 (0.12 pct)
> Scale:	 219338.56 (0.00 pct)	 221856.65 (1.14 pct)
>   Add:	 248118.20 (0.00 pct)	 252907.96 (1.93 pct)
> Triad:	 247088.55 (0.00 pct)	 248171.73 (0.43 pct)
> 
> o NPS4
> 
> - 10 Runs:
> 
> Test:		tip			SWQUEUE
>  Copy:	 273307.14 (0.00 pct)	 294527.85 (7.76 pct)
> Scale:	 235715.23 (0.00 pct)	 232442.47 (-1.38 pct)
>   Add:	 244500.40 (0.00 pct)	 243812.43 (-0.28 pct)
> Triad:	 250600.04 (0.00 pct)	 249006.70 (-0.63 pct)
> 
> - 100 Runs:
> 
> Test:		tip			SWQUEUE
>  Copy:	 345396.19 (0.00 pct)	 323605.07 (-6.30 pct)
> Scale:	 241521.63 (0.00 pct)	 218688.02 (-9.45 pct)
>   Add:	 261157.86 (0.00 pct)	 234725.46 (-10.12 pct)
> Triad:	 267804.99 (0.00 pct)	 253017.71 (-5.52 pct)
> 
> ~~~~~~~~~~~
> ~ netperf ~
> ~~~~~~~~~~~
> 
> o NPS1
> 
> Test:			tip			SWQUEUE
>  1-clients:	 102839.97 (0.00 pct)	 98690.53 (-4.03 pct)
>  2-clients:	 98428.08 (0.00 pct)	 97027.85 (-1.42 pct)
>  4-clients:	 92298.45 (0.00 pct)	 93217.27 (0.99 pct)
>  8-clients:	 85618.41 (0.00 pct)	 87393.58 (2.07 pct)
> 16-clients:	 78722.18 (0.00 pct)	 78607.48 (-0.14 pct)
> 32-clients:	 73610.75 (0.00 pct)	 70636.67 (-4.04 pct)
> 64-clients:	 55285.07 (0.00 pct)	 52613.62 (-4.83 pct)
> 128-clients:	 31176.92 (0.00 pct)	 35212.35 (12.94 pct)
> 256-clients:	 20011.44 (0.00 pct)	 18817.54 (-5.96 pct)
> 
> o NPS2
> 
> Test:			tip			SWQUEUE
>  1-clients:	 103105.55 (0.00 pct)	 101318.80 (-1.73 pct)
>  2-clients:	 98720.29 (0.00 pct)	 97809.70 (-0.92 pct)
>  4-clients:	 92289.39 (0.00 pct)	 93771.16 (1.60 pct)
>  8-clients:	 84998.63 (0.00 pct)	 85093.68 (0.11 pct)
> 16-clients:	 76395.81 (0.00 pct)	 78181.45 (2.33 pct)
> 32-clients:	 71110.89 (0.00 pct)	 70312.53 (-1.12 pct)
> 64-clients:	 49526.21 (0.00 pct)	 49030.94 (-1.00 pct)
> 128-clients:	 27917.51 (0.00 pct)	 31428.64 (12.57 pct)
> 256-clients:	 20067.17 (0.00 pct)	 18273.28 (-8.93 pct)
> 
> o NPS4
> 
> Test:			tip			SWQUEUE
>  1-clients:	 102139.49 (0.00 pct)	 100629.37 (-1.47 pct)
>  2-clients:	 98259.53 (0.00 pct)	 96639.21 (-1.64 pct)
>  4-clients:	 91576.79 (0.00 pct)	 92032.50 (0.49 pct)
>  8-clients:	 84742.30 (0.00 pct)	 85588.07 (0.99 pct)
> 16-clients:	 79540.75 (0.00 pct)	 78033.63 (-1.89 pct)
> 32-clients:	 71166.14 (0.00 pct)	 69080.28 (-2.93 pct)
> 64-clients:	 51763.24 (0.00 pct)	 44243.04 (-14.52 pct)
> 128-clients:	 27829.29 (0.00 pct)	 32188.25 (15.66 pct)
> 256-clients:	 24185.37 (0.00 pct)	 17669.40 (-26.94 pct)
> 
> ~~~~~~~~~~~~~
> ~ unixbench ~
> ~~~~~~~~~~~~~
> 
> o NPS1
> 
> 						tip			SWQUEUE
> Hmean     unixbench-dhry2reg-1   	  41322625.19 (   0.00%)    40874894.71 *  -1.08%*
> Hmean     unixbench-dhry2reg-512	6252491108.60 (   0.00%)  6253691168.43 (   0.02%)
> Amean     unixbench-syscall-1    	   2501398.27 (   0.00%)     2524108.97 *  -0.91%*
> Amean     unixbench-syscall-512  	   8120524.00 (   0.00%)     7596446.63 *   6.45%*
> Hmean     unixbench-pipe-1    		   2359346.02 (   0.00%)     2429532.75 *   2.97%*
> Hmean     unixbench-pipe-512		 338790322.61 (   0.00%)   343170761.60 *   1.29%*
> Hmean     unixbench-spawn-1      	      4261.52 (   0.00%)        4554.10 *   6.87%*
> Hmean     unixbench-spawn-512    	     64328.93 (   0.00%)       62585.87 *  -2.71%*
> Hmean     unixbench-execl-1      	      3677.73 (   0.00%)        3655.40 *  -0.61%*
> Hmean     unixbench-execl-512    	     11984.83 (   0.00%)       13248.56 (  10.54%)
> 
> o NPS2
> 
> 						tip			SWQUEUE
> Hmean     unixbench-dhry2reg-1   	  41311787.29 (   0.00%)    41100045.17 (  -0.51%)
> Hmean     unixbench-dhry2reg-512	6243873272.76 (   0.00%)  6257834310.98 (   0.22%)
> Amean     unixbench-syscall-1    	   2503190.70 (   0.00%)     2520187.83 *  -0.68%*
> Amean     unixbench-syscall-512  	   8012388.13 (   0.00%)     7545705.57 *   5.82%*
> Hmean     unixbench-pipe-1    		   2340486.25 (   0.00%)     2436643.73 *   4.11%*
> Hmean     unixbench-pipe-512		 338965319.79 (   0.00%)   342560610.22 *   1.06%*
> Hmean     unixbench-spawn-1      	      5241.83 (   0.00%)        5174.11 (  -1.29%)
> Hmean     unixbench-spawn-512    	     65799.86 (   0.00%)       63879.27 *  -2.92%*
> Hmean     unixbench-execl-1      	      3670.65 (   0.00%)        3634.26 *  -0.99%*
> Hmean     unixbench-execl-512    	     13682.00 (   0.00%)       14002.70 (   2.34%)
> 
> o NPS4
> 
> 						tip			SWQUEUE
> Hmean     unixbench-dhry2reg-1   	  41025577.99 (   0.00%)    41588045.76 (   1.37%)
> Hmean     unixbench-dhry2reg-512	6255568261.91 (   0.00%)  6257479983.24 (   0.03%)
> Amean     unixbench-syscall-1    	   2507165.37 (   0.00%)     2519780.17 *  -0.50%*
> Amean     unixbench-syscall-512  	   7458476.50 (   0.00%)     8140849.63 *  -9.15%*
> Hmean     unixbench-pipe-1    		   2369301.21 (   0.00%)     2415933.77 *   1.97%*
> Hmean     unixbench-pipe-512		 340299405.72 (   0.00%)   343206741.58 *   0.85%*
> Hmean     unixbench-spawn-1      	      5571.78 (   0.00%)        5421.31 (  -2.70%)
> Hmean     unixbench-spawn-512    	     63999.96 (   0.00%)       63968.08 (  -0.05%)
> Hmean     unixbench-execl-1      	      3587.15 (   0.00%)        3619.10 *   0.89%*
> Hmean     unixbench-execl-512    	     14184.17 (   0.00%)       13006.80 *  -8.30%*
> 
> ~~~~~~~~~~~~~~~~
> ~ ycsb-mongodb ~
> ~~~~~~~~~~~~~~~~
> 
> 
> o NPS1:
> 
> base:			298681.00 (var: 2.31%)
> SWQUEUE			295218.00 (var: 0.15%) (-1.15%)
> 
> o NPS2:
> 
> base:			296570.00 (var: 1.01%)
> SWQUEUE			293648.67 (var: 0.89%) (-0.98%)
> 
> o NPS4:
> 
> base			297181.67 (var: 0.46%)
> SWQUEUE			290700.67 (var: 2.09%) (-2.18%)
> 
> ~~~~~~~~~~~~~~~~~~
> ~ DeathStarBench ~
> ~~~~~~~~~~~~~~~~~~
> 
> o NPS1:
> 
> - 1 CCD
> 
> base:			1.00 (var: 0.27%)
> SWQUEUE:		0.99 (var: 0.40%) (-0.83%)
> 
> - 2 CCD
> 
> base:			1.00 (var: 0.42%)
> SWQUEUE:		1.02 (var: 0.40%) (2.52%)
> 
> - 4 CCD
> 
> base:			1.00 (var: 0.46%)
> SWQUEUE:		1.04 (var: 1.08%) (4.63%)
> 
> - 8 CCD
> 
> base:			1.00 (var: 0.63%)
> SWQUEUE:		0.99 (var: 7.18%) (-0.83%)
> 
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ~ SPECjbb2015 - multi-JVM ~
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> 		tip		SWQUEUE
> max-jOPS	1.00		1.02  (+2.47%)   
> critical-jOPS	1.00		1.02  (+1.72%)
> 
> --
> 
> I'll go back and check why netperf is unhappy using perf and IBS.
> Meanwhile if there is any specific benchmark you would like me to run
> on the test system, please do let me know.

Thanks very much for the time you're spending on this. I don't have any
other specific benchmarks in mind. My only suggestion would be that your
time is probably better spent experimenting with the v2 version of the
patch set.

The only thing to bear in mind is that the series hard-codes the shard
size at 6. We may want to make that configurable in a separate debugfs
node. In the meantime, you just need to adjust SHARED_RUNQ_SHARD_SZ in
[2].

[2]: https://lore.kernel.org/all/20230710200342.358255-7-void@manifault.com/

Thanks,
David
