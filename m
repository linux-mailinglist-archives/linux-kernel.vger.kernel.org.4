Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A142A6804D0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 05:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbjA3EPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 23:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjA3EPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 23:15:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DA3559A;
        Sun, 29 Jan 2023 20:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=JApqLJSlREJfto41HrlaOE5znyfw3ipMqIEA/E2Edb0=; b=G+S7c9c/3tN2UkizZ1Sdw6MiTM
        FmmV8PcPcJujF+Kx31seWO9uUgLdt0aXWrYtMKxm3saYvt9Fl6qyxZeqkuezm8hfITWH9x04TM7B4
        Jwsu7S0JyfRBpEj7gSLKI7J/ylIfBYDhse2HdRaf5h18zkX2xKg2G1fzK+GG5oXjXwJ+HHdyVUKX3
        IajDnctjB09FW1M0HuRdibQ1HbjC1i7raE884dLQ1EFIbG8WklyGEFsDG0IC+cjaBDvF5hBqmEFJJ
        m347XYOkj983QX5XVL1SeCz/aA2EZ7HTcdpQJk5DxDSULYmQCewfhtc57gzcp/Uimeq/Bi5S9sOmu
        RLJ0q1+w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMLZV-00A1lP-Q6; Mon, 30 Jan 2023 04:15:09 +0000
Date:   Mon, 30 Jan 2023 04:15:09 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Shakeel Butt <shakeelb@google.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [mm]  f1a7941243:  unixbench.score -19.2%
 regression
Message-ID: <Y9dETROtv9Bld9TI@casper.infradead.org>
References: <202301301057.e55dad5b-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202301301057.e55dad5b-oliver.sang@intel.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 10:32:56AM +0800, kernel test robot wrote:
> FYI, we noticed a -19.2% regression of unixbench.score due to commit:
> 
> commit: f1a7941243c102a44e8847e3b94ff4ff3ec56f25 ("mm: convert mm's rss stats into percpu_counter")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: unixbench
> on test machine: 128 threads 4 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
> with following parameters:
> 
> 	runtime: 300s
> 	nr_task: 30%
> 	test: spawn
> 	cpufreq_governor: performance

...

> 9cd6ffa60256e931 f1a7941243c102a44e8847e3b94 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>      11110           -19.2%       8974        unixbench.score
>    1090843           -12.2%     957314        unixbench.time.involuntary_context_switches
>    4243909 ±  6%     -32.4%    2867136 ±  5%  unixbench.time.major_page_faults
>      10547           -12.6%       9216        unixbench.time.maximum_resident_set_size
>  9.913e+08           -19.6%  7.969e+08        unixbench.time.minor_page_faults
>       5638           +19.1%       6714        unixbench.time.system_time
>       5502           -20.7%       4363        unixbench.time.user_time

So we're spending a lot more time in the kernel and correspondingly less
time in userspace.

>   67991885           -16.9%   56507507        unixbench.time.voluntary_context_switches
>   46198768           -19.1%   37355723        unixbench.workload
>  1.365e+08           -12.5%  1.195e+08 ±  7%  cpuidle..usage
>    1220612 ±  4%     -38.0%     757009 ± 28%  meminfo.Active
>    1220354 ±  4%     -38.0%     756754 ± 28%  meminfo.Active(anon)
>       0.50 ±  2%      -0.1        0.45 ±  4%  mpstat.cpu.all.soft%
>       1.73            -0.2        1.52 ±  2%  mpstat.cpu.all.usr%
>     532266           -18.4%     434559        vmstat.system.cs
>     495826           -12.2%     435455 ±  8%  vmstat.system.in
>   1.36e+08           -13.2%   1.18e+08 ±  9%  turbostat.C1
>      68.80            +0.8       69.60        turbostat.C1%
>  1.663e+08           -12.1%  1.462e+08 ±  8%  turbostat.IRQ
>      15.54 ± 20%     -49.0%       7.93 ± 24%  sched_debug.cfs_rq:/.runnable_avg.min
>      13.26 ± 19%     -46.6%       7.08 ± 29%  sched_debug.cfs_rq:/.util_avg.min
>      48.96 ±  8%     +51.5%      74.20 ± 13%  sched_debug.cfs_rq:/.util_est_enqueued.avg
>     138.00 ±  5%     +28.9%     177.87 ±  7%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
>     228060 ±  3%     +13.3%     258413 ±  4%  sched_debug.cpu.avg_idle.stddev
>     432533 ±  5%     -16.4%     361517 ±  4%  sched_debug.cpu.nr_switches.min
>  2.665e+08           -18.9%  2.162e+08        numa-numastat.node0.local_node
>  2.666e+08           -18.9%  2.163e+08        numa-numastat.node0.numa_hit
>  2.746e+08           -20.9%  2.172e+08        numa-numastat.node1.local_node
>  2.747e+08           -20.9%  2.172e+08        numa-numastat.node1.numa_hit
>  2.602e+08           -17.4%  2.149e+08        numa-numastat.node2.local_node
>  2.603e+08           -17.4%  2.149e+08        numa-numastat.node2.numa_hit
>  2.423e+08           -15.0%   2.06e+08        numa-numastat.node3.local_node
>  2.424e+08           -15.0%  2.061e+08        numa-numastat.node3.numa_hit

So we're going off-node a lot more for ... something.

>  2.666e+08           -18.9%  2.163e+08        numa-vmstat.node0.numa_hit
>  2.665e+08           -18.9%  2.162e+08        numa-vmstat.node0.numa_local
>  2.747e+08           -20.9%  2.172e+08        numa-vmstat.node1.numa_hit
>  2.746e+08           -20.9%  2.172e+08        numa-vmstat.node1.numa_local
>  2.603e+08           -17.4%  2.149e+08        numa-vmstat.node2.numa_hit
>  2.602e+08           -17.4%  2.149e+08        numa-vmstat.node2.numa_local
>  2.424e+08           -15.0%  2.061e+08        numa-vmstat.node3.numa_hit
>  2.423e+08           -15.0%   2.06e+08        numa-vmstat.node3.numa_local
>     304947 ±  4%     -38.0%     189144 ± 28%  proc-vmstat.nr_active_anon

Umm.  Are we running vmstat a lot during this test?  The commit says:

    At the
    moment the readers are either procfs interface, oom_killer and memory
    reclaim which I think are not performance critical and should be ok with
    slow read.  However I think we can make that change in a separate patch.

This would explain the increased cross-NUMA references (we're going to
the other nodes to collect the stats), and the general slowdown.  But I
don't think it reflects a real workload; it's reflecting that the
monitoring of this workload that we're doing is now more accurate and
more expensive.

