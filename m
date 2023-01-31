Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F91668241C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 06:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjAaFpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 00:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjAaFph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 00:45:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674512BF28;
        Mon, 30 Jan 2023 21:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Rds1P43eBYqMP5vCzgXgc6MYwJ1yDxtXp2wIaLfpKq0=; b=bfybH23yWbFVRPGfBmSINLK7iX
        Qmmz3kWQyJ3f57INp2n6UmgIdCrieXhfT7icpcz8zBnb35NBvG1LupRdAounHSetN2ILHsW9PPleL
        1pFTApmxYDY6chnXKDYC3k5sVYyObA3aGd8gJc/N9Fynp4eW8kgjB6yS6saxZi/Ylounopoe9EdOm
        nhJ8q0j2Cq/K2RoqcDfUkoBt2N7nU8GqsbCA1TV81orgq9/GIH+GHpMJLWdVWASkWails0Uvdxx63
        5Bnmp1S9ht8eMJqxOVpkln+fVrhuEinmXa4MOKWWFIDOIb3DaYntOIjXbBsF8z3oIIICmBEXoqZJN
        sT6EoKOw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMjSL-00B3QN-86; Tue, 31 Jan 2023 05:45:21 +0000
Date:   Tue, 31 Jan 2023 05:45:21 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [mm]  f1a7941243:  unixbench.score -19.2%
 regression
Message-ID: <Y9iq8fRT4sDgIwQN@casper.infradead.org>
References: <202301301057.e55dad5b-oliver.sang@intel.com>
 <Y9dETROtv9Bld9TI@casper.infradead.org>
 <20230131052352.5qnqegzwmt7akk7t@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230131052352.5qnqegzwmt7akk7t@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 05:23:52AM +0000, Shakeel Butt wrote:
> On Mon, Jan 30, 2023 at 04:15:09AM +0000, Matthew Wilcox wrote:
> > On Mon, Jan 30, 2023 at 10:32:56AM +0800, kernel test robot wrote:
> > > FYI, we noticed a -19.2% regression of unixbench.score due to commit:
> > >
> > > commit: f1a7941243c102a44e8847e3b94ff4ff3ec56f25 ("mm: convert mm's rss stats into percpu_counter")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > >
> > > in testcase: unixbench
> > > on test machine: 128 threads 4 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
> > > with following parameters:
> > >
> > > 	runtime: 300s
> > > 	nr_task: 30%
> > > 	test: spawn
> > > 	cpufreq_governor: performance
> >
> > ...
> >
> > > 9cd6ffa60256e931 f1a7941243c102a44e8847e3b94
> > > ---------------- ---------------------------
> > >          %stddev     %change         %stddev
> > >              \          |                \
> > >      11110           -19.2%       8974        unixbench.score
> > >    1090843           -12.2%     957314        unixbench.time.involuntary_context_switches
> > >    4243909 ±  6%     -32.4%    2867136 ±  5%  unixbench.time.major_page_faults
> > >      10547           -12.6%       9216        unixbench.time.maximum_resident_set_size
> > >  9.913e+08           -19.6%  7.969e+08        unixbench.time.minor_page_faults
> > >       5638           +19.1%       6714        unixbench.time.system_time
> > >       5502           -20.7%       4363        unixbench.time.user_time
> >
> > So we're spending a lot more time in the kernel and correspondingly less
> > time in userspace.
> >
> > >   67991885           -16.9%   56507507        unixbench.time.voluntary_context_switches
> > >   46198768           -19.1%   37355723        unixbench.workload
> > >  1.365e+08           -12.5%  1.195e+08 ±  7%  cpuidle..usage
> > >    1220612 ±  4%     -38.0%     757009 ± 28%  meminfo.Active
> > >    1220354 ±  4%     -38.0%     756754 ± 28%  meminfo.Active(anon)
> > >       0.50 ±  2%      -0.1        0.45 ±  4%  mpstat.cpu.all.soft%
> > >       1.73            -0.2        1.52 ±  2%  mpstat.cpu.all.usr%
> > >     532266           -18.4%     434559        vmstat.system.cs
> > >     495826           -12.2%     435455 ±  8%  vmstat.system.in
> > >   1.36e+08           -13.2%   1.18e+08 ±  9%  turbostat.C1
> > >      68.80            +0.8       69.60        turbostat.C1%
> > >  1.663e+08           -12.1%  1.462e+08 ±  8%  turbostat.IRQ
> > >      15.54 ± 20%     -49.0%       7.93 ± 24%  sched_debug.cfs_rq:/.runnable_avg.min
> > >      13.26 ± 19%     -46.6%       7.08 ± 29%  sched_debug.cfs_rq:/.util_avg.min
> > >      48.96 ±  8%     +51.5%      74.20 ± 13%  sched_debug.cfs_rq:/.util_est_enqueued.avg
> > >     138.00 ±  5%     +28.9%     177.87 ±  7%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
> > >     228060 ±  3%     +13.3%     258413 ±  4%  sched_debug.cpu.avg_idle.stddev
> > >     432533 ±  5%     -16.4%     361517 ±  4%  sched_debug.cpu.nr_switches.min
> > >  2.665e+08           -18.9%  2.162e+08        numa-numastat.node0.local_node
> > >  2.666e+08           -18.9%  2.163e+08        numa-numastat.node0.numa_hit
> > >  2.746e+08           -20.9%  2.172e+08        numa-numastat.node1.local_node
> > >  2.747e+08           -20.9%  2.172e+08        numa-numastat.node1.numa_hit
> > >  2.602e+08           -17.4%  2.149e+08        numa-numastat.node2.local_node
> > >  2.603e+08           -17.4%  2.149e+08        numa-numastat.node2.numa_hit
> > >  2.423e+08           -15.0%   2.06e+08        numa-numastat.node3.local_node
> > >  2.424e+08           -15.0%  2.061e+08        numa-numastat.node3.numa_hit
> >
> > So we're going off-node a lot more for ... something.
> >
> > >  2.666e+08           -18.9%  2.163e+08        numa-vmstat.node0.numa_hit
> > >  2.665e+08           -18.9%  2.162e+08        numa-vmstat.node0.numa_local
> > >  2.747e+08           -20.9%  2.172e+08        numa-vmstat.node1.numa_hit
> > >  2.746e+08           -20.9%  2.172e+08        numa-vmstat.node1.numa_local
> > >  2.603e+08           -17.4%  2.149e+08        numa-vmstat.node2.numa_hit
> > >  2.602e+08           -17.4%  2.149e+08        numa-vmstat.node2.numa_local
> > >  2.424e+08           -15.0%  2.061e+08        numa-vmstat.node3.numa_hit
> > >  2.423e+08           -15.0%   2.06e+08        numa-vmstat.node3.numa_local
> > >     304947 ±  4%     -38.0%     189144 ± 28%  proc-vmstat.nr_active_anon
> >
> > Umm.  Are we running vmstat a lot during this test?  The commit says:
> >
> >     At the
> >     moment the readers are either procfs interface, oom_killer and memory
> >     reclaim which I think are not performance critical and should be ok with
> >     slow read.  However I think we can make that change in a separate patch.
> >
> > This would explain the increased cross-NUMA references (we're going to
> > the other nodes to collect the stats), and the general slowdown.  But I
> > don't think it reflects a real workload; it's reflecting that the
> > monitoring of this workload that we're doing is now more accurate and
> > more expensive.
> >
> 
> Thanks Willy for taking a stab at this issue. The numa_hit stat is
> updated on allocations, so I don't think stat collection would increase
> these stats. I looked at workload "spawn" in UnixBench and it is a
> simple fork ping pong i.e. process does fork and then waits for the
> child while the child simply exits.

Perhaps I was unclear.  What I meant was the monitoring done by the 01.org
team might be the thing which is causing the slowdown they're seeing,
since your commit says that reading the stats becomes more expensive,
and the stats they report are consistent with that.

> I ran perf and it seems like percpu counter allocation is the additional
> cost with this patch. See the report below. However I made spawn a bit
> more sophisticated by adding a mmap() of a GiB then the page table
> copy became the significant cost and no difference without or with the
> given patch.
> 
> I am now wondering if this fork ping pong really an important workload
> that we should revert the patch or ignore for now but work on improving
> the performance of __alloc_percpu_gfp code.
> 
> 
> -   90.97%     0.06%  spawn    [kernel.kallsyms]  [k] entry_SYSCALL_64_after_hwframe
>    - 90.91% entry_SYSCALL_64_after_hwframe
>       - 90.86% do_syscall_64
>          - 80.03% __x64_sys_clone
>             - 79.98% kernel_clone
>                - 75.97% copy_process
>                   + 46.04% perf_event_init_task
>                   - 21.50% copy_mm
>                      - 10.05% mm_init
> ----------------------> - 8.92% __percpu_counter_init
>                            - 8.67% __alloc_percpu_gfp
>                               - 5.70% pcpu_alloc

5.7% of our time spent in pcpu_alloc seems excessive.  Are we contending
on pcpu_alloc_mutex perhaps?  Also, are you doing this on a 4-socket
machine like the kernel test robot ran on?

We could cut down the number of calls to pcpu_alloc() by a factor of 4
by having a pcpu_alloc_bulk() that would allocate all four RSS counters
at once.

Just throwing out ideas ...
