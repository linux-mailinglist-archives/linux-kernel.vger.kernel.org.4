Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F2469E544
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbjBUQ5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbjBUQ5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:57:46 -0500
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EFE2CFD2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1676998657; x=1708534657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=fhEoY9IU3G7XCWBaSUwtYVs3CkU8ozJyP8tt7abOQGQ=;
  b=CaDT5EdsNxiEPFaXCPD56tDosbuVk6nfpA0OlxNYDHLYQVfLRSwaPx6S
   +zgUKPs3sh2FLpohzmUD2SslvWVuka+GqOteFT5mqXShPcDBCJNKNMHHG
   C5Q8jw0XyGuR3t5criQU5T6ygDCtzFaDVaW2lnHeNrI0whAUpyWiq5xu8
   M=;
X-IronPort-AV: E=Sophos;i="5.97,315,1669075200"; 
   d="scan'208";a="313643089"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 16:57:28 +0000
Received: from EX13D41EUC003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com (Postfix) with ESMTPS id 3A1D2A2878;
        Tue, 21 Feb 2023 16:57:23 +0000 (UTC)
Received: from EX19D033EUC004.ant.amazon.com (10.252.61.133) by
 EX13D41EUC003.ant.amazon.com (10.43.164.188) with Microsoft SMTP Server (TLS)
 id 15.0.1497.46; Tue, 21 Feb 2023 16:57:23 +0000
Received: from u40bc5e070a0153.ant.amazon.com (10.1.212.12) by
 EX19D033EUC004.ant.amazon.com (10.252.61.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.24; Tue, 21 Feb 2023 16:57:18 +0000
Date:   Tue, 21 Feb 2023 17:57:12 +0100
From:   Roman Kagan <rkagan@amazon.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Ben Segall <bsegall@google.com>,
        "Waiman Long" <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v3] sched/fair: sanitize vruntime of entity being placed
Message-ID: <Y/T36NvaCxSfS8Z/@u40bc5e070a0153.ant.amazon.com>
Mail-Followup-To: Roman Kagan <rkagan@amazon.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        Valentin Schneider <vschneid@redhat.com>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Ben Segall <bsegall@google.com>, Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>
References: <20230209193107.1432770-1-rkagan@amazon.de>
 <CAKfTPtB7ZDyCh0MiNQtyimVhYJ6E3C+2bTptj9CX3+mepH8YAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <CAKfTPtB7ZDyCh0MiNQtyimVhYJ6E3C+2bTptj9CX3+mepH8YAQ@mail.gmail.com>
X-Originating-IP: [10.1.212.12]
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D033EUC004.ant.amazon.com (10.252.61.133)
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 10:38:44AM +0100, Vincent Guittot wrote:
> On Thu, 9 Feb 2023 at 20:31, Roman Kagan <rkagan@amazon.de> wrote:
> >
> > From: Zhang Qiao <zhangqiao22@huawei.com>
> >
> > When a scheduling entity is placed onto cfs_rq, its vruntime is pulled
> > to the base level (around cfs_rq->min_vruntime), so that the entity
> > doesn't gain extra boost when placed backwards.
> >
> > However, if the entity being placed wasn't executed for a long time, its
> > vruntime may get too far behind (e.g. while cfs_rq was executing a
> > low-weight hog), which can inverse the vruntime comparison due to s64
> > overflow.  This results in the entity being placed with its original
> > vruntime way forwards, so that it will effectively never get to the cpu.
> >
> > To prevent that, ignore the vruntime of the entity being placed if it
> > didn't execute for longer than the time that can lead to an overflow.
> >
> > Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> > [rkagan: formatted, adjusted commit log, comments, cutoff value]
> > Co-developed-by: Roman Kagan <rkagan@amazon.de>
> > Signed-off-by: Roman Kagan <rkagan@amazon.de>
> =

> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> =

> > ---
> > v2 -> v3:
> > - make cutoff less arbitrary and update comments [Vincent]
> >
> > v1 -> v2:
> > - add Zhang Qiao's s-o-b
> > - fix constant promotion on 32bit
> >
> >  kernel/sched/fair.c | 21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)

Turns out Peter took v2 through his tree, and it has already landed in
Linus' master.

What scares me, though, is that I've got a message from the test robot
that this commit drammatically affected hackbench results, see the quote
below.  I expected the commit not to affect any benchmarks.

Any idea what could have caused this change?

Thanks,
Roman.


On Tue, Feb 21, 2023 at 03:34:16PM +0800, kernel test robot wrote:
> FYI, we noticed a 125.5% improvement of hackbench.throughput due to commi=
t:
> =

> commit: 829c1651e9c4a6f78398d3e67651cef9bb6b42cc ("sched/fair: sanitize v=
runtime of entity being placed")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> =

> in testcase: hackbench
> on test machine: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2=
.10GHz (Cascade Lake) with 128G memory
> with following parameters:
> =

>         nr_threads: 50%
>         iterations: 8
>         mode: process
>         ipc: pipe
>         cpufreq_governor: performance
> =

> test-description: Hackbench is both a benchmark and a stress test for the=
 Linux kernel scheduler.
> test-url: https://github.com/linux-test-project/ltp/blob/master/testcases=
/kernel/sched/cfs-scheduler/hackbench.c
> =

> In addition to that, the commit also has significant impact on the follow=
ing tests:
> =

> +------------------+--------------------------------------------------+
> | testcase: change | hackbench: hackbench.throughput -8.1% regression |
> | test machine     | 104 threads 2 sockets (Skylake) with 192G memory |
> | test parameters  | cpufreq_governor=3Dperformance                     |
> |                  | ipc=3Dsocket                                       |
> |                  | iterations=3D4                                     |
> |                  | mode=3Dprocess                                     |
> |                  | nr_threads=3D100%                                  |
> +------------------+--------------------------------------------------+
> =

> Details are as below:
> =

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/t=
box_group/testcase:
>   gcc-11/performance/pipe/8/x86_64-rhel-8.3/process/50%/debian-11.1-x86_6=
4-20220510.cgz/lkp-csl-2sp9/hackbench
> =

> commit:
>   a2e90611b9 ("sched/fair: Remove capacity inversion detection")
>   829c1651e9 ("sched/fair: sanitize vruntime of entity being placed")
> =

> a2e90611b9f425ad 829c1651e9c4a6f78398d3e6765
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>     308887 =B1  5%    +125.5%     696539        hackbench.throughput
>     259291 =B1  2%    +127.3%     589293        hackbench.throughput_avg
>     308887 =B1  5%    +125.5%     696539        hackbench.throughput_best
>     198770 =B1  2%    +105.5%     408552 =B1  4%  hackbench.throughput_wo=
rst
>     319.60 =B1  2%     -55.8%     141.24        hackbench.time.elapsed_ti=
me
>     319.60 =B1  2%     -55.8%     141.24        hackbench.time.elapsed_ti=
me.max
>  1.298e+09 =B1  8%     -87.6%  1.613e+08 =B1  7%  hackbench.time.involunt=
ary_context_switches
>     477107           -12.5%     417660        hackbench.time.minor_page_f=
aults
>      24683 =B1  2%     -57.2%      10562        hackbench.time.system_time
>       2136 =B1  3%     -45.0%       1174        hackbench.time.user_time
>   3.21e+09 =B1  4%     -83.0%  5.442e+08 =B1  3%  hackbench.time.voluntar=
y_context_switches
>   5.28e+08 =B1  4%      +8.4%  5.723e+08 =B1  3%  cpuidle..time
>     365.97 =B1  2%     -48.9%     187.12        uptime.boot
>    3322559 =B1  3%     +34.3%    4463206 =B1 15%  vmstat.memory.cache
>   14194257 =B1  2%     -62.8%    5279904 =B1  3%  vmstat.system.cs
>    2120781 =B1  3%     -72.8%     576421 =B1  4%  vmstat.system.in
>       1.84 =B1 12%      +2.6        4.48 =B1  5%  mpstat.cpu.all.idle%
>       2.49 =B1  3%      -1.1        1.39 =B1  4%  mpstat.cpu.all.irq%
>       0.04 =B1 12%      +0.0        0.05        mpstat.cpu.all.soft%
>       7.36            +2.2        9.56        mpstat.cpu.all.usr%
>      61555 =B1  6%     -72.8%      16751 =B1 16%  numa-meminfo.node1.Acti=
ve
>      61515 =B1  6%     -72.8%      16717 =B1 16%  numa-meminfo.node1.Acti=
ve(anon)
>     960182 =B1102%    +225.6%    3125990 =B1 42%  numa-meminfo.node1.File=
Pages
>    1754002 =B1 53%    +137.9%    4173379 =B1 34%  numa-meminfo.node1.MemU=
sed
>   35296824 =B1  6%    +157.8%   91005048        numa-numastat.node0.local=
_node
>   35310119 =B1  6%    +157.9%   91058472        numa-numastat.node0.numa_=
hit
>   35512423 =B1  5%    +159.7%   92232951        numa-numastat.node1.local=
_node
>   35577275 =B1  4%    +159.4%   92273266        numa-numastat.node1.numa_=
hit
>   35310253 =B1  6%    +157.9%   91058211        numa-vmstat.node0.numa_hit
>   35296958 =B1  6%    +157.8%   91004787        numa-vmstat.node0.numa_lo=
cal
>      15337 =B1  6%     -72.5%       4216 =B1 17%  numa-vmstat.node1.nr_ac=
tive_anon
>     239988 =B1102%    +225.7%     781607 =B1 42%  numa-vmstat.node1.nr_fi=
le_pages
>      15337 =B1  6%     -72.5%       4216 =B1 17%  numa-vmstat.node1.nr_zo=
ne_active_anon
>   35577325 =B1  4%    +159.4%   92273215        numa-vmstat.node1.numa_hit
>   35512473 =B1  5%    +159.7%   92232900        numa-vmstat.node1.numa_lo=
cal
>      64500 =B1  8%     -61.8%      24643 =B1 32%  meminfo.Active
>      64422 =B1  8%     -61.9%      24568 =B1 32%  meminfo.Active(anon)
>     140271 =B1 14%     -38.0%      86979 =B1 24%  meminfo.AnonHugePages
>     372672 =B1  2%     +13.3%     422069        meminfo.AnonPages
>    3205235 =B1  3%     +35.1%    4329061 =B1 15%  meminfo.Cached
>    1548601 =B1  7%     +77.4%    2747319 =B1 24%  meminfo.Committed_AS
>     783193 =B1 14%    +154.9%    1996137 =B1 33%  meminfo.Inactive
>     783010 =B1 14%    +154.9%    1995951 =B1 33%  meminfo.Inactive(anon)
>    4986534 =B1  2%     +28.2%    6394741 =B1 10%  meminfo.Memused
>     475092 =B1 22%    +236.5%    1598918 =B1 41%  meminfo.Shmem
>       2777            -2.1%       2719        turbostat.Bzy_MHz
>   11143123 =B1  6%     +72.0%   19162667        turbostat.C1
>       0.24 =B1  7%      +0.7        0.94 =B1  3%  turbostat.C1%
>     100440 =B1 18%    +203.8%     305136 =B1 15%  turbostat.C1E
>       0.06 =B1  9%      +0.1        0.18 =B1 11%  turbostat.C1E%
>       1.24 =B1  3%      +1.6        2.81 =B1  4%  turbostat.C6%
>       1.38 =B1  3%    +156.1%       3.55 =B1  3%  turbostat.CPU%c1
>       0.33 =B1  5%     +76.5%       0.58 =B1  7%  turbostat.CPU%c6
>       0.16           +31.2%       0.21        turbostat.IPC
>  6.866e+08 =B1  5%     -87.8%   83575393 =B1  5%  turbostat.IRQ
>       0.33 =B1 27%      +0.2        0.57        turbostat.POLL%
>       0.12 =B1 10%    +176.4%       0.33 =B1 12%  turbostat.Pkg%pc2
>       0.09 =B1  7%    -100.0%       0.00        turbostat.Pkg%pc6
>      61.33            +5.2%      64.50 =B1  2%  turbostat.PkgTmp
>      14.81            +2.0%      15.11        turbostat.RAMWatt
>      16242 =B1  8%     -62.0%       6179 =B1 32%  proc-vmstat.nr_active_a=
non
>      93150 =B1  2%     +13.2%     105429        proc-vmstat.nr_anon_pages
>     801219 =B1  3%     +35.1%    1082320 =B1 15%  proc-vmstat.nr_file_pag=
es
>     195506 =B1 14%    +155.2%     498919 =B1 33%  proc-vmstat.nr_inactive=
_anon
>     118682 =B1 22%    +236.9%     399783 =B1 41%  proc-vmstat.nr_shmem
>      16242 =B1  8%     -62.0%       6179 =B1 32%  proc-vmstat.nr_zone_act=
ive_anon
>     195506 =B1 14%    +155.2%     498919 =B1 33%  proc-vmstat.nr_zone_ina=
ctive_anon
>   70889233 =B1  5%    +158.6%  1.833e+08        proc-vmstat.numa_hit
>   70811086 =B1  5%    +158.8%  1.832e+08        proc-vmstat.numa_local
>      55885 =B1 22%     -67.2%      18327 =B1 38%  proc-vmstat.numa_pages_=
migrated
>     422312 =B1 10%     -95.4%      19371 =B1  7%  proc-vmstat.pgactivate
>   71068460 =B1  5%    +158.1%  1.834e+08        proc-vmstat.pgalloc_normal
>    1554994           -19.6%    1250346 =B1  4%  proc-vmstat.pgfault
>   71011267 =B1  5%    +155.9%  1.817e+08        proc-vmstat.pgfree
>      55885 =B1 22%     -67.2%      18327 =B1 38%  proc-vmstat.pgmigrate_s=
uccess
>     111247 =B1  2%     -35.0%      72355 =B1  2%  proc-vmstat.pgreuse
>    2506368 =B1  2%     -53.1%    1176320        proc-vmstat.unevictable_p=
gs_scanned
>      20.06 =B1 10%     -22.4%      15.56 =B1  8%  sched_debug.cfs_rq:/.h_=
nr_running.max
>       0.81 =B1 32%     -93.1%       0.06 =B1223%  sched_debug.cfs_rq:/.h_=
nr_running.min
>       1917 =B1 34%    -100.0%       0.00        sched_debug.cfs_rq:/.load=
.min
>      24.18 =B1 10%     +39.0%      33.62 =B1 11%  sched_debug.cfs_rq:/.lo=
ad_avg.avg
>     245.61 =B1 25%     +66.3%     408.33 =B1 22%  sched_debug.cfs_rq:/.lo=
ad_avg.max
>      47.52 =B1 13%     +72.6%      82.03 =B1  8%  sched_debug.cfs_rq:/.lo=
ad_avg.stddev
>   13431147           -64.9%    4717147        sched_debug.cfs_rq:/.min_vr=
untime.avg
>   18161799 =B1  7%     -67.4%    5925316 =B1  6%  sched_debug.cfs_rq:/.mi=
n_vruntime.max
>   12413026           -65.0%    4340952        sched_debug.cfs_rq:/.min_vr=
untime.min
>     739748 =B1 16%     -66.6%     247410 =B1 17%  sched_debug.cfs_rq:/.mi=
n_vruntime.stddev
>       0.85           -16.4%       0.71        sched_debug.cfs_rq:/.nr_run=
ning.avg
>       0.61 =B1 25%     -90.9%       0.06 =B1223%  sched_debug.cfs_rq:/.nr=
_running.min
>       0.10 =B1 25%    +109.3%       0.22 =B1  7%  sched_debug.cfs_rq:/.nr=
_running.stddev
>     169.22          +101.7%     341.33        sched_debug.cfs_rq:/.remove=
d.load_avg.max
>      32.41 =B1 24%    +100.2%      64.90 =B1 16%  sched_debug.cfs_rq:/.re=
moved.load_avg.stddev
>      82.92 =B1 10%    +108.1%     172.56        sched_debug.cfs_rq:/.remo=
ved.runnable_avg.max
>      13.60 =B1 28%    +114.0%      29.10 =B1 20%  sched_debug.cfs_rq:/.re=
moved.runnable_avg.stddev
>      82.92 =B1 10%    +108.1%     172.56        sched_debug.cfs_rq:/.remo=
ved.util_avg.max
>      13.60 =B1 28%    +114.0%      29.10 =B1 20%  sched_debug.cfs_rq:/.re=
moved.util_avg.stddev
>       2156 =B1 12%     -36.6%       1368 =B1 27%  sched_debug.cfs_rq:/.ru=
nnable_avg.min
>       2285 =B1  7%     -19.8%       1833 =B1  6%  sched_debug.cfs_rq:/.ru=
nnable_avg.stddev
>   -2389921           -64.8%    -840940        sched_debug.cfs_rq:/.spread=
0.min
>     739781 =B1 16%     -66.5%     247837 =B1 17%  sched_debug.cfs_rq:/.sp=
read0.stddev
>     843.88 =B1  2%     -20.5%     670.53        sched_debug.cfs_rq:/.util=
_avg.avg
>     433.64 =B1  7%     -43.5%     244.83 =B1 17%  sched_debug.cfs_rq:/.ut=
il_avg.min
>     187.00 =B1  6%     +40.6%     263.02 =B1  4%  sched_debug.cfs_rq:/.ut=
il_avg.stddev
>     394.15 =B1 14%     -29.5%     278.06 =B1  3%  sched_debug.cfs_rq:/.ut=
il_est_enqueued.avg
>       1128 =B1 12%     -17.6%     930.39 =B1  5%  sched_debug.cfs_rq:/.ut=
il_est_enqueued.max
>      38.36 =B1 29%    -100.0%       0.00        sched_debug.cfs_rq:/.util=
_est_enqueued.min
>       3596 =B1 15%     -39.5%       2175 =B1  7%  sched_debug.cpu.avg_idl=
e.min
>     160647 =B1  9%     -25.9%     118978 =B1  9%  sched_debug.cpu.avg_idl=
e.stddev
>     197365           -46.2%     106170        sched_debug.cpu.clock.avg
>     197450           -46.2%     106208        sched_debug.cpu.clock.max
>     197281           -46.2%     106128        sched_debug.cpu.clock.min
>      49.96 =B1 22%     -53.1%      23.44 =B1 19%  sched_debug.cpu.clock.s=
tddev
>     193146           -45.7%     104898        sched_debug.cpu.clock_task.=
avg
>     194592           -45.8%     105455        sched_debug.cpu.clock_task.=
max
>     177878           -49.3%      90211        sched_debug.cpu.clock_task.=
min
>       1794 =B1  5%     -10.7%       1602 =B1  2%  sched_debug.cpu.clock_t=
ask.stddev
>      13154 =B1  2%     -20.3%      10479        sched_debug.cpu.curr->pid=
.avg
>      15059           -17.2%      12468        sched_debug.cpu.curr->pid.m=
ax
>       7263 =B1 33%    -100.0%       0.00        sched_debug.cpu.curr->pid=
.min
>       9321 =B1 36%     +98.2%      18478 =B1 44%  sched_debug.cpu.max_idl=
e_balance_cost.stddev
>       0.00 =B1 17%     -41.6%       0.00 =B1 13%  sched_debug.cpu.next_ba=
lance.stddev
>      20.00 =B1 11%     -21.4%      15.72 =B1  7%  sched_debug.cpu.nr_runn=
ing.max
>       0.86 =B1 17%     -87.1%       0.11 =B1141%  sched_debug.cpu.nr_runn=
ing.min
>   25069883           -83.7%    4084117 =B1  4%  sched_debug.cpu.nr_switch=
es.avg
>   26486718           -82.8%    4544009 =B1  4%  sched_debug.cpu.nr_switch=
es.max
>   23680077           -84.5%    3663816 =B1  4%  sched_debug.cpu.nr_switch=
es.min
>     589836 =B1  3%     -68.7%     184621 =B1 16%  sched_debug.cpu.nr_swit=
ches.stddev
>     197278           -46.2%     106128        sched_debug.cpu_clk
>     194327           -46.9%     103176        sched_debug.ktime
>     197967           -46.0%     106821        sched_debug.sched_clk
>      14.91           -37.6%       9.31        perf-stat.i.MPKI
>  2.657e+10           +25.0%   3.32e+10        perf-stat.i.branch-instruct=
ions
>       1.17            -0.4        0.78        perf-stat.i.branch-miss-rat=
e%
>  3.069e+08           -20.1%  2.454e+08        perf-stat.i.branch-misses
>       6.43 =B1  8%      +2.2        8.59 =B1  4%  perf-stat.i.cache-miss-=
rate%
>  1.952e+09           -24.3%  1.478e+09        perf-stat.i.cache-references
>   14344055 =B1  2%     -58.6%    5932018 =B1  3%  perf-stat.i.context-swi=
tches
>       1.83           -21.8%       1.43        perf-stat.i.cpi
>  2.403e+11            -3.4%  2.322e+11        perf-stat.i.cpu-cycles
>    1420139 =B1  2%     -38.8%     869692 =B1  5%  perf-stat.i.cpu-migrati=
ons
>       2619 =B1  7%     -15.5%       2212 =B1  8%  perf-stat.i.cycles-betw=
een-cache-misses
>       0.24 =B1 19%      -0.1        0.10 =B1 17%  perf-stat.i.dTLB-load-m=
iss-rate%
>   90403286 =B1 19%     -55.8%   39926283 =B1 16%  perf-stat.i.dTLB-load-m=
isses
>  3.823e+10           +28.6%  4.918e+10        perf-stat.i.dTLB-loads
>       0.01 =B1 34%      -0.0        0.01 =B1 33%  perf-stat.i.dTLB-store-=
miss-rate%
>    2779663 =B1 34%     -52.7%    1315899 =B1 31%  perf-stat.i.dTLB-store-=
misses
>   2.19e+10           +24.2%   2.72e+10        perf-stat.i.dTLB-stores
>      47.99 =B1  2%     +28.0       75.94        perf-stat.i.iTLB-load-mis=
s-rate%
>   89417955 =B1  2%     +38.7%   1.24e+08 =B1  4%  perf-stat.i.iTLB-load-m=
isses
>   97721514 =B1  2%     -58.2%   40865783 =B1  3%  perf-stat.i.iTLB-loads
>  1.329e+11           +26.3%  1.678e+11        perf-stat.i.instructions
>       1503            -7.7%       1388 =B1  3%  perf-stat.i.instructions-=
per-iTLB-miss
>       0.55           +30.2%       0.72        perf-stat.i.ipc
>       1.64 =B1 18%    +217.4%       5.20 =B1 11%  perf-stat.i.major-faults
>       2.73            -3.7%       2.63        perf-stat.i.metric.GHz
>       1098 =B1  2%      -7.1%       1020 =B1  3%  perf-stat.i.metric.K/sec
>       1008           +24.4%       1254        perf-stat.i.metric.M/sec
>       4334 =B1  2%     +90.5%       8257 =B1  7%  perf-stat.i.minor-faults
>      90.94           -14.9       75.99        perf-stat.i.node-load-miss-=
rate%
>   41932510 =B1  8%     -43.0%   23899176 =B1 10%  perf-stat.i.node-load-m=
isses
>    3366677 =B1  5%     +86.2%    6267816        perf-stat.i.node-loads
>      81.77 =B1  3%     -36.3       45.52 =B1  3%  perf-stat.i.node-store-=
miss-rate%
>   18498318 =B1  7%     -31.8%   12613933 =B1  7%  perf-stat.i.node-store-=
misses
>    3023556 =B1 10%    +508.7%   18405880 =B1  2%  perf-stat.i.node-stores
>       4336 =B1  2%     +90.5%       8262 =B1  7%  perf-stat.i.page-faults
>      14.70           -41.2%       8.65        perf-stat.overall.MPKI
>       1.16            -0.4        0.72        perf-stat.overall.branch-mi=
ss-rate%
>       6.22 =B1  7%      +2.4        8.59 =B1  4%  perf-stat.overall.cache=
-miss-rate%
>       1.81           -24.3%       1.37        perf-stat.overall.cpi
>       0.24 =B1 19%      -0.2        0.07 =B1 15%  perf-stat.overall.dTLB-=
load-miss-rate%
>       0.01 =B1 34%      -0.0        0.00 =B1 29%  perf-stat.overall.dTLB-=
store-miss-rate%
>      47.78 =B1  2%     +29.3       77.12        perf-stat.overall.iTLB-lo=
ad-miss-rate%
>       1486            -9.1%       1351 =B1  4%  perf-stat.overall.instruc=
tions-per-iTLB-miss
>       0.55           +32.0%       0.73        perf-stat.overall.ipc
>      92.54           -15.4       77.16 =B1  2%  perf-stat.overall.node-lo=
ad-miss-rate%
>      85.82 =B1  2%     -48.1       37.76 =B1  5%  perf-stat.overall.node-=
store-miss-rate%
>  2.648e+10           +25.2%  3.314e+10        perf-stat.ps.branch-instruc=
tions
>   3.06e+08           -22.1%  2.383e+08        perf-stat.ps.branch-misses
>  1.947e+09           -25.5%  1.451e+09        perf-stat.ps.cache-referenc=
es
>   14298713 =B1  2%     -62.5%    5359285 =B1  3%  perf-stat.ps.context-sw=
itches
>  2.396e+11            -4.0%  2.299e+11        perf-stat.ps.cpu-cycles
>    1415512 =B1  2%     -42.2%     817981 =B1  4%  perf-stat.ps.cpu-migrat=
ions
>   90073948 =B1 19%     -60.4%   35711862 =B1 15%  perf-stat.ps.dTLB-load-=
misses
>  3.811e+10           +29.7%  4.944e+10        perf-stat.ps.dTLB-loads
>    2767291 =B1 34%     -56.3%    1210210 =B1 29%  perf-stat.ps.dTLB-store=
-misses
>  2.183e+10           +25.0%  2.729e+10        perf-stat.ps.dTLB-stores
>   89118809 =B1  2%     +39.6%  1.244e+08 =B1  4%  perf-stat.ps.iTLB-load-=
misses
>   97404381 =B1  2%     -62.2%   36860047 =B1  3%  perf-stat.ps.iTLB-loads
>  1.324e+11           +26.7%  1.678e+11        perf-stat.ps.instructions
>       1.62 =B1 18%    +164.7%       4.29 =B1  8%  perf-stat.ps.major-faul=
ts
>       4310 =B1  2%     +75.1%       7549 =B1  5%  perf-stat.ps.minor-faul=
ts
>   41743097 =B1  8%     -47.3%   21984450 =B1  9%  perf-stat.ps.node-load-=
misses
>    3356259 =B1  5%     +92.6%    6462631        perf-stat.ps.node-loads
>   18414647 =B1  7%     -35.7%   11833799 =B1  6%  perf-stat.ps.node-store=
-misses
>    3019790 =B1 10%    +545.0%   19478071        perf-stat.ps.node-stores
>       4312 =B1  2%     +75.2%       7553 =B1  5%  perf-stat.ps.page-faults
>  4.252e+13           -43.7%  2.395e+13        perf-stat.total.instructions
>      29.92 =B1  4%     -22.8        7.09 =B1 29%  perf-profile.calltrace.=
cycles-pp.__wake_up_common_lock.pipe_write.vfs_write.ksys_write.do_syscall_=
64
>      28.53 =B1  5%     -21.6        6.92 =B1 29%  perf-profile.calltrace.=
cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write.ksys_=
write
>      27.86 =B1  5%     -21.1        6.77 =B1 29%  perf-profile.calltrace.=
cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.p=
ipe_write.vfs_write
>      27.55 =B1  5%     -20.9        6.68 =B1 29%  perf-profile.calltrace.=
cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_u=
p_common_lock.pipe_write
>      22.28 =B1  4%     -17.0        5.31 =B1 30%  perf-profile.calltrace.=
cycles-pp.schedule.pipe_read.vfs_read.ksys_read.do_syscall_64
>      21.98 =B1  4%     -16.7        5.24 =B1 30%  perf-profile.calltrace.=
cycles-pp.__schedule.schedule.pipe_read.vfs_read.ksys_read
>      12.62 =B1  4%      -9.6        3.00 =B1 33%  perf-profile.calltrace.=
cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_u=
p_common.__wake_up_common_lock
>      34.09            -9.2       24.92 =B1  3%  perf-profile.calltrace.cy=
cles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_h=
wframe
>      11.48 =B1  5%      -8.8        2.69 =B1 38%  perf-profile.calltrace.=
cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake=
_function.__wake_up_common
>       9.60 =B1  7%      -7.2        2.40 =B1 35%  perf-profile.calltrace.=
cycles-pp.dequeue_task_fair.__schedule.schedule.pipe_read.vfs_read
>      36.39            -6.2       30.20        perf-profile.calltrace.cycl=
es-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__lib=
c_read
>      40.40            -6.1       34.28        perf-profile.calltrace.cycl=
es-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
>      40.95            -5.7       35.26        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64_after_hwframe.__libc_read
>      37.43            -5.4       32.07        perf-profile.calltrace.cycl=
es-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
>       6.30 =B1 11%      -5.2        1.09 =B1 36%  perf-profile.calltrace.=
cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64=
.entry_SYSCALL_64_after_hwframe.__libc_write
>       5.66 =B1 12%      -5.1        0.58 =B1 75%  perf-profile.calltrace.=
cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_=
user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       6.46 =B1 10%      -5.1        1.40 =B1 28%  perf-profile.calltrace.=
cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hw=
frame.__libc_write
>       5.53 =B1 13%      -5.0        0.56 =B1 75%  perf-profile.calltrace.=
cycles-pp.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall=
_exit_to_user_mode.do_syscall_64
>       5.42 =B1 13%      -4.9        0.56 =B1 75%  perf-profile.calltrace.=
cycles-pp.__schedule.schedule.exit_to_user_mode_loop.exit_to_user_mode_prep=
are.syscall_exit_to_user_mode
>       5.82 =B1  9%      -4.7        1.10 =B1 37%  perf-profile.calltrace.=
cycles-pp._raw_spin_lock.try_to_wake_up.autoremove_wake_function.__wake_up_=
common.__wake_up_common_lock
>       5.86 =B1 16%      -4.6        1.31 =B1 37%  perf-profile.calltrace.=
cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.=
autoremove_wake_function
>       5.26 =B1  9%      -4.4        0.89 =B1 57%  perf-profile.calltrace.=
cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.try_to_wake_up.au=
toremove_wake_function.__wake_up_common
>      45.18            -3.5       41.68        perf-profile.calltrace.cycl=
es-pp.__libc_read
>      50.31            -3.2       47.12        perf-profile.calltrace.cycl=
es-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
>       4.00 =B1 27%      -2.9        1.09 =B1 40%  perf-profile.calltrace.=
cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.pipe_read
>      50.75            -2.7       48.06        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64_after_hwframe.__libc_write
>      40.80            -2.6       38.20        perf-profile.calltrace.cycl=
es-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_=
hwframe
>       3.10 =B1 15%      -2.5        0.62 =B1103%  perf-profile.calltrace.=
cycles-pp.update_cfs_group.dequeue_task_fair.__schedule.schedule.pipe_read
>       2.94 =B1 12%      -2.3        0.62 =B1102%  perf-profile.calltrace.=
cycles-pp.update_cfs_group.enqueue_task_fair.ttwu_do_activate.try_to_wake_u=
p.autoremove_wake_function
>       2.38 =B1  9%      -2.0        0.38 =B1102%  perf-profile.calltrace.=
cycles-pp._raw_spin_lock.__schedule.schedule.pipe_read.vfs_read
>       2.24 =B1  7%      -1.8        0.40 =B1 71%  perf-profile.calltrace.=
cycles-pp.prepare_to_wait_event.pipe_read.vfs_read.ksys_read.do_syscall_64
>       2.08 =B1  6%      -1.8        0.29 =B1100%  perf-profile.calltrace.=
cycles-pp.pick_next_task_fair.__schedule.schedule.pipe_read.vfs_read
>       2.10 =B1 10%      -1.8        0.32 =B1104%  perf-profile.calltrace.=
cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__schedule.schedu=
le.pipe_read
>       2.76 =B1  7%      -1.5        1.24 =B1 17%  perf-profile.calltrace.=
cycles-pp.select_task_rq.try_to_wake_up.autoremove_wake_function.__wake_up_=
common.__wake_up_common_lock
>       2.27 =B1  5%      -1.4        0.88 =B1 11%  perf-profile.calltrace.=
cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64=
.entry_SYSCALL_64_after_hwframe.__libc_read
>       2.43 =B1  7%      -1.3        1.16 =B1 17%  perf-profile.calltrace.=
cycles-pp.select_task_rq_fair.select_task_rq.try_to_wake_up.autoremove_wake=
_function.__wake_up_common
>       2.46 =B1  5%      -1.3        1.20 =B1  7%  perf-profile.calltrace.=
cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hw=
frame.__libc_read
>       1.54 =B1  5%      -1.2        0.32 =B1101%  perf-profile.calltrace.=
cycles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.ttwu_do_activate=
.try_to_wake_up
>       0.97 =B1  9%      -0.3        0.66 =B1 19%  perf-profile.calltrace.=
cycles-pp.select_idle_sibling.select_task_rq_fair.select_task_rq.try_to_wak=
e_up.autoremove_wake_function
>       0.86 =B1  6%      +0.2        1.02        perf-profile.calltrace.cy=
cles-pp.__might_fault._copy_from_iter.copy_page_from_iter.pipe_write.vfs_wr=
ite
>       0.64 =B1  9%      +0.5        1.16 =B1  5%  perf-profile.calltrace.=
cycles-pp.mutex_unlock.pipe_read.vfs_read.ksys_read.do_syscall_64
>       0.47 =B1 45%      +0.5        0.99 =B1  5%  perf-profile.calltrace.=
cycles-pp.__fget_light.__fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64=
_after_hwframe
>       0.60 =B1  8%      +0.5        1.13 =B1  5%  perf-profile.calltrace.=
cycles-pp.__fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwfram=
e.__libc_read
>       0.00            +0.5        0.54 =B1  5%  perf-profile.calltrace.cy=
cles-pp.current_time.file_update_time.pipe_write.vfs_write.ksys_write
>       0.00            +0.6        0.56 =B1  4%  perf-profile.calltrace.cy=
cles-pp.__might_resched.__might_fault._copy_from_iter.copy_page_from_iter.p=
ipe_write
>       0.00            +0.6        0.56 =B1  7%  perf-profile.calltrace.cy=
cles-pp.__might_resched.__might_fault._copy_to_iter.copy_page_to_iter.pipe_=
read
>       0.00            +0.6        0.58 =B1  5%  perf-profile.calltrace.cy=
cles-pp.__might_resched.mutex_lock.pipe_write.vfs_write.ksys_write
>       0.00            +0.6        0.62 =B1  3%  perf-profile.calltrace.cy=
cles-pp.__might_resched.mutex_lock.pipe_read.vfs_read.ksys_read
>       0.00            +0.7        0.65 =B1  6%  perf-profile.calltrace.cy=
cles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_=
wait_event.pipe_write.vfs_write
>       0.00            +0.7        0.65 =B1  7%  perf-profile.calltrace.cy=
cles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_id=
le
>       0.57 =B1  5%      +0.7        1.24 =B1  6%  perf-profile.calltrace.=
cycles-pp.__fget_light.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_6=
4_after_hwframe
>       0.00            +0.7        0.72 =B1  6%  perf-profile.calltrace.cy=
cles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.pipe_write.vfs_write.k=
sys_write
>       0.00            +0.8        0.75 =B1  6%  perf-profile.calltrace.cy=
cles-pp.mutex_spin_on_owner.__mutex_lock.pipe_write.vfs_write.ksys_write
>       0.74 =B1  9%      +0.8        1.48 =B1  5%  perf-profile.calltrace.=
cycles-pp.file_update_time.pipe_write.vfs_write.ksys_write.do_syscall_64
>       0.63 =B1  5%      +0.8        1.40 =B1  5%  perf-profile.calltrace.=
cycles-pp.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwfra=
me.__libc_write
>       0.00            +0.8        0.78 =B1 19%  perf-profile.calltrace.cy=
cles-pp.reader__read_event.perf_session__process_events.record__finish_outp=
ut.__cmd_record
>       0.00            +0.8        0.78 =B1 19%  perf-profile.calltrace.cy=
cles-pp.record__finish_output.__cmd_record
>       0.00            +0.8        0.78 =B1 19%  perf-profile.calltrace.cy=
cles-pp.perf_session__process_events.record__finish_output.__cmd_record
>       0.00            +0.8        0.80 =B1 15%  perf-profile.calltrace.cy=
cles-pp.__cmd_record
>       0.00            +0.8        0.82 =B1 11%  perf-profile.calltrace.cy=
cles-pp.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.=
do_idle
>       0.00            +0.9        0.85 =B1  6%  perf-profile.calltrace.cy=
cles-pp.prepare_to_wait_event.pipe_write.vfs_write.ksys_write.do_syscall_64
>       0.00            +0.9        0.86 =B1  4%  perf-profile.calltrace.cy=
cles-pp.current_time.atime_needs_update.touch_atime.pipe_read.vfs_read
>       0.00            +0.9        0.87 =B1  5%  perf-profile.calltrace.cy=
cles-pp.syscall_return_via_sysret.__libc_write
>       0.00            +0.9        0.88 =B1  5%  perf-profile.calltrace.cy=
cles-pp.syscall_return_via_sysret.__libc_read
>       0.26 =B1100%      +1.0        1.22 =B1 10%  perf-profile.calltrace.=
cycles-pp.__schedule.schedule.pipe_write.vfs_write.ksys_write
>       0.00            +1.0        0.96 =B1  6%  perf-profile.calltrace.cy=
cles-pp.__might_fault._copy_to_iter.copy_page_to_iter.pipe_read.vfs_read
>       0.27 =B1100%      +1.0        1.23 =B1 10%  perf-profile.calltrace.=
cycles-pp.schedule.pipe_write.vfs_write.ksys_write.do_syscall_64
>       0.00            +1.0        0.97 =B1  7%  perf-profile.calltrace.cy=
cles-pp.page_counter_uncharge.uncharge_batch.__mem_cgroup_uncharge.__folio_=
put.pipe_read
>       0.87 =B1  8%      +1.1        1.98 =B1  5%  perf-profile.calltrace.=
cycles-pp.apparmor_file_permission.security_file_permission.vfs_read.ksys_r=
ead.do_syscall_64
>       0.73 =B1  6%      +1.1        1.85 =B1  5%  perf-profile.calltrace.=
cycles-pp.apparmor_file_permission.security_file_permission.vfs_write.ksys_=
write.do_syscall_64
>       0.00            +1.2        1.15 =B1  7%  perf-profile.calltrace.cy=
cles-pp.uncharge_batch.__mem_cgroup_uncharge.__folio_put.pipe_read.vfs_read
>       0.00            +1.2        1.23 =B1  6%  perf-profile.calltrace.cy=
cles-pp.__mem_cgroup_uncharge.__folio_put.pipe_read.vfs_read.ksys_read
>       0.00            +1.2        1.24 =B1  7%  perf-profile.calltrace.cy=
cles-pp.__folio_put.pipe_read.vfs_read.ksys_read.do_syscall_64
>       0.48 =B1 45%      +1.3        1.74 =B1  6%  perf-profile.calltrace.=
cycles-pp.atime_needs_update.touch_atime.pipe_read.vfs_read.ksys_read
>       0.60 =B1  7%      +1.3        1.87 =B1  8%  perf-profile.calltrace.=
cycles-pp.__wake_up_common_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
>       1.23 =B1  7%      +1.3        2.51 =B1  4%  perf-profile.calltrace.=
cycles-pp.mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
>      43.42            +1.3       44.75        perf-profile.calltrace.cycl=
es-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
>       0.83 =B1  7%      +1.3        2.17 =B1  5%  perf-profile.calltrace.=
cycles-pp.security_file_permission.vfs_write.ksys_write.do_syscall_64.entry=
_SYSCALL_64_after_hwframe
>       0.98 =B1  7%      +1.4        2.36 =B1  6%  perf-profile.calltrace.=
cycles-pp.security_file_permission.vfs_read.ksys_read.do_syscall_64.entry_S=
YSCALL_64_after_hwframe
>       0.27 =B1100%      +1.4        1.70 =B1  9%  perf-profile.calltrace.=
cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_read.vfs_read.ksys_re=
ad
>       0.79 =B1  8%      +1.4        2.23 =B1  6%  perf-profile.calltrace.=
cycles-pp.touch_atime.pipe_read.vfs_read.ksys_read.do_syscall_64
>       0.18 =B1141%      +1.5        1.63 =B1  9%  perf-profile.calltrace.=
cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_u=
p_common_lock.pipe_read
>       0.18 =B1141%      +1.5        1.67 =B1  9%  perf-profile.calltrace.=
cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.p=
ipe_read.vfs_read
>       0.00            +1.6        1.57 =B1 10%  perf-profile.calltrace.cy=
cles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_sta=
rtup_entry
>       0.00            +1.6        1.57 =B1 10%  perf-profile.calltrace.cy=
cles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_sec=
ondary
>       1.05 =B1  8%      +1.7        2.73 =B1  6%  perf-profile.calltrace.=
cycles-pp.copy_user_enhanced_fast_string.copyin._copy_from_iter.copy_page_f=
rom_iter.pipe_write
>       1.84 =B1  9%      +1.7        3.56 =B1  5%  perf-profile.calltrace.=
cycles-pp.copy_user_enhanced_fast_string.copyout._copy_to_iter.copy_page_to=
_iter.pipe_read
>       1.41 =B1  9%      +1.8        3.17 =B1  6%  perf-profile.calltrace.=
cycles-pp.copyin._copy_from_iter.copy_page_from_iter.pipe_write.vfs_write
>       0.00            +1.8        1.79 =B1  9%  perf-profile.calltrace.cy=
cles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.seconda=
ry_startup_64_no_verify
>       1.99 =B1  9%      +2.0        3.95 =B1  5%  perf-profile.calltrace.=
cycles-pp.copyout._copy_to_iter.copy_page_to_iter.pipe_read.vfs_read
>       2.40 =B1  7%      +2.4        4.82 =B1  5%  perf-profile.calltrace.=
cycles-pp._copy_from_iter.copy_page_from_iter.pipe_write.vfs_write.ksys_wri=
te
>       0.00            +2.5        2.50 =B1  7%  perf-profile.calltrace.cy=
cles-pp.__mutex_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
>       2.89 =B1  8%      +2.6        5.47 =B1  5%  perf-profile.calltrace.=
cycles-pp.copy_page_from_iter.pipe_write.vfs_write.ksys_write.do_syscall_64
>       1.04 =B1 30%      +2.8        3.86 =B1  5%  perf-profile.calltrace.=
cycles-pp.__entry_text_start.__libc_write
>       0.00            +2.9        2.90 =B1 11%  perf-profile.calltrace.cy=
cles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_v=
erify
>       0.00            +2.9        2.91 =B1 11%  perf-profile.calltrace.cy=
cles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       0.00            +2.9        2.91 =B1 11%  perf-profile.calltrace.cy=
cles-pp.start_secondary.secondary_startup_64_no_verify
>       0.85 =B1 27%      +2.9        3.80 =B1  5%  perf-profile.calltrace.=
cycles-pp.__entry_text_start.__libc_read
>       0.00            +3.0        2.96 =B1 11%  perf-profile.calltrace.cy=
cles-pp.secondary_startup_64_no_verify
>       2.60 =B1  9%      +3.1        5.74 =B1  6%  perf-profile.calltrace.=
cycles-pp._copy_to_iter.copy_page_to_iter.pipe_read.vfs_read.ksys_read
>       2.93 =B1  9%      +3.7        6.66 =B1  5%  perf-profile.calltrace.=
cycles-pp.copy_page_to_iter.pipe_read.vfs_read.ksys_read.do_syscall_64
>       1.60 =B1 12%      +4.6        6.18 =B1  7%  perf-profile.calltrace.=
cycles-pp.mutex_unlock.pipe_write.vfs_write.ksys_write.do_syscall_64
>       2.60 =B1 10%      +4.6        7.24 =B1  5%  perf-profile.calltrace.=
cycles-pp.mutex_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
>      28.75 =B1  5%     -21.6        7.19 =B1 28%  perf-profile.children.c=
ycles-pp.schedule
>      30.52 =B1  4%     -21.6        8.97 =B1 22%  perf-profile.children.c=
ycles-pp.__wake_up_common_lock
>      28.53 =B1  6%     -21.0        7.56 =B1 26%  perf-profile.children.c=
ycles-pp.__schedule
>      29.04 =B1  5%     -20.4        8.63 =B1 23%  perf-profile.children.c=
ycles-pp.__wake_up_common
>      28.37 =B1  5%     -19.9        8.44 =B1 23%  perf-profile.children.c=
ycles-pp.autoremove_wake_function
>      28.08 =B1  5%     -19.7        8.33 =B1 23%  perf-profile.children.c=
ycles-pp.try_to_wake_up
>      13.90 =B1  2%     -10.2        3.75 =B1 28%  perf-profile.children.c=
ycles-pp.ttwu_do_activate
>      12.66 =B1  3%      -9.2        3.47 =B1 29%  perf-profile.children.c=
ycles-pp.enqueue_task_fair
>      34.20            -9.2       25.05 =B1  3%  perf-profile.children.cyc=
les-pp.pipe_read
>      90.86            -9.1       81.73        perf-profile.children.cycle=
s-pp.do_syscall_64
>      91.80            -8.3       83.49        perf-profile.children.cycle=
s-pp.entry_SYSCALL_64_after_hwframe
>      10.28 =B1  7%      -7.8        2.53 =B1 27%  perf-profile.children.c=
ycles-pp._raw_spin_lock
>       9.85 =B1  7%      -6.9        2.92 =B1 29%  perf-profile.children.c=
ycles-pp.dequeue_task_fair
>       8.69 =B1  7%      -6.6        2.05 =B1 24%  perf-profile.children.c=
ycles-pp.exit_to_user_mode_prepare
>       8.99 =B1  6%      -6.2        2.81 =B1 16%  perf-profile.children.c=
ycles-pp.syscall_exit_to_user_mode
>      36.46            -6.1       30.34        perf-profile.children.cycle=
s-pp.vfs_read
>       8.38 =B1  8%      -5.8        2.60 =B1 23%  perf-profile.children.c=
ycles-pp.native_queued_spin_lock_slowpath
>       6.10 =B1 11%      -5.4        0.66 =B1 61%  perf-profile.children.c=
ycles-pp.exit_to_user_mode_loop
>      37.45            -5.3       32.13        perf-profile.children.cycle=
s-pp.ksys_read
>       6.50 =B1 35%      -4.9        1.62 =B1 61%  perf-profile.children.c=
ycles-pp.update_curr
>       6.56 =B1 15%      -4.6        1.95 =B1 57%  perf-profile.children.c=
ycles-pp.update_cfs_group
>       6.38 =B1 14%      -4.5        1.91 =B1 28%  perf-profile.children.c=
ycles-pp.enqueue_entity
>       5.74 =B1  5%      -3.8        1.92 =B1 25%  perf-profile.children.c=
ycles-pp.update_load_avg
>      45.56            -3.8       41.75        perf-profile.children.cycle=
s-pp.__libc_read
>       3.99 =B1  4%      -3.1        0.92 =B1 24%  perf-profile.children.c=
ycles-pp.pick_next_task_fair
>       4.12 =B1 27%      -2.7        1.39 =B1 34%  perf-profile.children.c=
ycles-pp.dequeue_entity
>      40.88            -2.5       38.37        perf-profile.children.cycle=
s-pp.pipe_write
>       3.11 =B1  4%      -2.4        0.75 =B1 22%  perf-profile.children.c=
ycles-pp.switch_mm_irqs_off
>       2.06 =B1 33%      -1.8        0.27 =B1 27%  perf-profile.children.c=
ycles-pp.asm_sysvec_call_function_single
>       2.38 =B1 41%      -1.8        0.60 =B1 72%  perf-profile.children.c=
ycles-pp.perf_trace_sched_wakeup_template
>       2.29 =B1  5%      -1.7        0.60 =B1 25%  perf-profile.children.c=
ycles-pp.switch_fpu_return
>       2.30 =B1  6%      -1.6        0.68 =B1 18%  perf-profile.children.c=
ycles-pp.prepare_task_switch
>       1.82 =B1 33%      -1.6        0.22 =B1 31%  perf-profile.children.c=
ycles-pp.sysvec_call_function_single
>       1.77 =B1 33%      -1.6        0.20 =B1 32%  perf-profile.children.c=
ycles-pp.__sysvec_call_function_single
>       1.96 =B1  5%      -1.5        0.50 =B1 20%  perf-profile.children.c=
ycles-pp.reweight_entity
>       2.80 =B1  7%      -1.2        1.60 =B1 12%  perf-profile.children.c=
ycles-pp.select_task_rq
>       1.61 =B1  6%      -1.2        0.42 =B1 25%  perf-profile.children.c=
ycles-pp.restore_fpregs_from_fpstate
>       1.34 =B1  9%      -1.2        0.16 =B1 28%  perf-profile.children.c=
ycles-pp._raw_spin_unlock_irqrestore
>       1.62 =B1  4%      -1.2        0.45 =B1 22%  perf-profile.children.c=
ycles-pp.set_next_entity
>       1.55 =B1  8%      -1.1        0.43 =B1 12%  perf-profile.children.c=
ycles-pp.update_rq_clock
>       1.49 =B1  8%      -1.1        0.41 =B1 14%  perf-profile.children.c=
ycles-pp.__update_load_avg_cfs_rq
>       1.30 =B1 20%      -1.0        0.26 =B1 18%  perf-profile.children.c=
ycles-pp.finish_task_switch
>       1.44 =B1  5%      -1.0        0.42 =B1 19%  perf-profile.children.c=
ycles-pp.__switch_to_asm
>       2.47 =B1  7%      -1.0        1.50 =B1 12%  perf-profile.children.c=
ycles-pp.select_task_rq_fair
>       2.33 =B1  7%      -0.9        1.40 =B1  3%  perf-profile.children.c=
ycles-pp.prepare_to_wait_event
>       1.24 =B1  7%      -0.9        0.35 =B1 14%  perf-profile.children.c=
ycles-pp.__update_load_avg_se
>       1.41 =B1 32%      -0.9        0.56 =B1 24%  perf-profile.children.c=
ycles-pp.sched_ttwu_pending
>       2.29 =B1  8%      -0.8        1.45 =B1  3%  perf-profile.children.c=
ycles-pp._raw_spin_lock_irqsave
>       1.04 =B1  7%      -0.8        0.24 =B1 22%  perf-profile.children.c=
ycles-pp.check_preempt_curr
>       1.01 =B1  3%      -0.7        0.30 =B1 20%  perf-profile.children.c=
ycles-pp.__switch_to
>       0.92 =B1  7%      -0.7        0.26 =B1 12%  perf-profile.children.c=
ycles-pp.update_min_vruntime
>       0.71 =B1  2%      -0.6        0.08 =B1 75%  perf-profile.children.c=
ycles-pp.put_prev_entity
>       0.76 =B1  6%      -0.6        0.14 =B1 32%  perf-profile.children.c=
ycles-pp.check_preempt_wakeup
>       0.81 =B1 66%      -0.6        0.22 =B1 34%  perf-profile.children.c=
ycles-pp.set_task_cpu
>       0.82 =B1 17%      -0.6        0.23 =B1 10%  perf-profile.children.c=
ycles-pp.cpuacct_charge
>       1.08 =B1 15%      -0.6        0.51 =B1 10%  perf-profile.children.c=
ycles-pp.wake_affine
>       0.56 =B1 15%      -0.5        0.03 =B1100%  perf-profile.children.c=
ycles-pp.asm_sysvec_reschedule_ipi
>       0.66 =B1  3%      -0.5        0.15 =B1 28%  perf-profile.children.c=
ycles-pp.os_xsave
>       0.52 =B1 44%      -0.5        0.06 =B1151%  perf-profile.children.c=
ycles-pp.native_irq_return_iret
>       0.55 =B1  5%      -0.4        0.15 =B1 21%  perf-profile.children.c=
ycles-pp.__calc_delta
>       0.56 =B1 10%      -0.4        0.17 =B1 26%  perf-profile.children.c=
ycles-pp.___perf_sw_event
>       0.70 =B1 15%      -0.4        0.32 =B1 11%  perf-profile.children.c=
ycles-pp.task_h_load
>       0.40 =B1  4%      -0.3        0.06 =B1 49%  perf-profile.children.c=
ycles-pp.pick_next_entity
>       0.57 =B1  6%      -0.3        0.26 =B1  7%  perf-profile.children.c=
ycles-pp.__list_del_entry_valid
>       0.39 =B1  8%      -0.3        0.08 =B1 24%  perf-profile.children.c=
ycles-pp.set_next_buddy
>       0.64 =B1  6%      -0.3        0.36 =B1  6%  perf-profile.children.c=
ycles-pp._raw_spin_lock_irq
>       0.53 =B1 20%      -0.3        0.25 =B1  8%  perf-profile.children.c=
ycles-pp.ttwu_queue_wakelist
>       0.36 =B1  8%      -0.3        0.08 =B1 11%  perf-profile.children.c=
ycles-pp.rb_insert_color
>       0.41 =B1  6%      -0.3        0.14 =B1 17%  perf-profile.children.c=
ycles-pp.sched_clock_cpu
>       0.36 =B1 33%      -0.3        0.10 =B1 17%  perf-profile.children.c=
ycles-pp.__flush_smp_call_function_queue
>       0.37 =B1  4%      -0.2        0.13 =B1 16%  perf-profile.children.c=
ycles-pp.native_sched_clock
>       0.28 =B1  5%      -0.2        0.07 =B1 18%  perf-profile.children.c=
ycles-pp.rb_erase
>       0.32 =B1  7%      -0.2        0.12 =B1 10%  perf-profile.children.c=
ycles-pp.__list_add_valid
>       0.23 =B1  6%      -0.2        0.03 =B1103%  perf-profile.children.c=
ycles-pp.resched_curr
>       0.27 =B1  5%      -0.2        0.08 =B1 20%  perf-profile.children.c=
ycles-pp.__wrgsbase_inactive
>       0.26 =B1  6%      -0.2        0.08 =B1 17%  perf-profile.children.c=
ycles-pp.finish_wait
>       0.26 =B1  4%      -0.2        0.08 =B1 11%  perf-profile.children.c=
ycles-pp.rcu_note_context_switch
>       0.33 =B1 21%      -0.2        0.15 =B1 32%  perf-profile.children.c=
ycles-pp.migrate_task_rq_fair
>       0.22 =B1  9%      -0.2        0.07 =B1 22%  perf-profile.children.c=
ycles-pp.perf_trace_buf_update
>       0.17 =B1  8%      -0.1        0.03 =B1100%  perf-profile.children.c=
ycles-pp.rb_next
>       0.15 =B1 32%      -0.1        0.03 =B1100%  perf-profile.children.c=
ycles-pp.llist_reverse_order
>       0.34 =B1  7%      -0.1        0.26 =B1  3%  perf-profile.children.c=
ycles-pp.anon_pipe_buf_release
>       0.14 =B1  6%      -0.1        0.07 =B1 17%  perf-profile.children.c=
ycles-pp.read@plt
>       0.10 =B1 17%      -0.1        0.04 =B1 75%  perf-profile.children.c=
ycles-pp.remove_entity_load_avg
>       0.07 =B1 10%      -0.0        0.02 =B1 99%  perf-profile.children.c=
ycles-pp.generic_update_time
>       0.11 =B1  6%      -0.0        0.07 =B1  8%  perf-profile.children.c=
ycles-pp.__mark_inode_dirty
>       0.00            +0.1        0.06 =B1  9%  perf-profile.children.cyc=
les-pp.load_balance
>       0.00            +0.1        0.06 =B1 11%  perf-profile.children.cyc=
les-pp._raw_spin_trylock
>       0.00            +0.1        0.06 =B1  7%  perf-profile.children.cyc=
les-pp.uncharge_folio
>       0.00            +0.1        0.06 =B1  7%  perf-profile.children.cyc=
les-pp.__do_softirq
>       0.00            +0.1        0.07 =B1 10%  perf-profile.children.cyc=
les-pp.tick_nohz_get_sleep_length
>       0.00            +0.1        0.08 =B1 14%  perf-profile.children.cyc=
les-pp.__get_obj_cgroup_from_memcg
>       0.15 =B1 23%      +0.1        0.23 =B1  7%  perf-profile.children.c=
ycles-pp.task_tick_fair
>       0.19 =B1 17%      +0.1        0.28 =B1  7%  perf-profile.children.c=
ycles-pp.scheduler_tick
>       0.00            +0.1        0.10 =B1 21%  perf-profile.children.cyc=
les-pp.select_idle_core
>       0.00            +0.1        0.10 =B1  9%  perf-profile.children.cyc=
les-pp.osq_unlock
>       0.23 =B1 12%      +0.1        0.34 =B1  6%  perf-profile.children.c=
ycles-pp.update_process_times
>       0.37 =B1 13%      +0.1        0.48 =B1  5%  perf-profile.children.c=
ycles-pp.hrtimer_interrupt
>       0.24 =B1 12%      +0.1        0.35 =B1  6%  perf-profile.children.c=
ycles-pp.tick_sched_handle
>       0.31 =B1 14%      +0.1        0.43 =B1  4%  perf-profile.children.c=
ycles-pp.__hrtimer_run_queues
>       0.37 =B1 12%      +0.1        0.49 =B1  5%  perf-profile.children.c=
ycles-pp.__sysvec_apic_timer_interrupt
>       0.00            +0.1        0.12 =B1 10%  perf-profile.children.cyc=
les-pp.__mod_memcg_state
>       0.26 =B1 10%      +0.1        0.38 =B1  6%  perf-profile.children.c=
ycles-pp.tick_sched_timer
>       0.00            +0.1        0.13 =B1  7%  perf-profile.children.cyc=
les-pp.free_unref_page
>       0.00            +0.1        0.14 =B1  8%  perf-profile.children.cyc=
les-pp.rmqueue
>       0.15 =B1  8%      +0.2        0.30 =B1  5%  perf-profile.children.c=
ycles-pp.rcu_all_qs
>       0.16 =B1  6%      +0.2        0.31 =B1  5%  perf-profile.children.c=
ycles-pp.__x64_sys_write
>       0.00            +0.2        0.16 =B1 10%  perf-profile.children.cyc=
les-pp.propagate_protected_usage
>       0.00            +0.2        0.16 =B1 10%  perf-profile.children.cyc=
les-pp.menu_select
>       0.00            +0.2        0.16 =B1  9%  perf-profile.children.cyc=
les-pp.memcg_account_kmem
>       0.42 =B1 12%      +0.2        0.57 =B1  4%  perf-profile.children.c=
ycles-pp.sysvec_apic_timer_interrupt
>       0.15 =B1 11%      +0.2        0.31 =B1  8%  perf-profile.children.c=
ycles-pp.__x64_sys_read
>       0.00            +0.2        0.17 =B1  8%  perf-profile.children.cyc=
les-pp.get_page_from_freelist
>       0.44 =B1 11%      +0.2        0.62 =B1  4%  perf-profile.children.c=
ycles-pp.asm_sysvec_apic_timer_interrupt
>       0.10 =B1 31%      +0.2        0.28 =B1 24%  perf-profile.children.c=
ycles-pp.mnt_user_ns
>       0.16 =B1  4%      +0.2        0.35 =B1  5%  perf-profile.children.c=
ycles-pp.kill_fasync
>       0.20 =B1 10%      +0.2        0.40 =B1  3%  perf-profile.children.c=
ycles-pp.syscall_exit_to_user_mode_prepare
>       0.09 =B1  7%      +0.2        0.29 =B1  4%  perf-profile.children.c=
ycles-pp.page_copy_sane
>       0.08 =B1  8%      +0.2        0.31 =B1  6%  perf-profile.children.c=
ycles-pp.rw_verify_area
>       0.12 =B1 11%      +0.2        0.36 =B1  8%  perf-profile.children.c=
ycles-pp.ktime_get_coarse_real_ts64
>       0.28 =B1 12%      +0.2        0.52 =B1  5%  perf-profile.children.c=
ycles-pp.inode_needs_update_time
>       0.00            +0.3        0.27 =B1  7%  perf-profile.children.cyc=
les-pp.__memcg_kmem_charge_page
>       0.43 =B1  6%      +0.3        0.73 =B1  5%  perf-profile.children.c=
ycles-pp.__cond_resched
>       0.21 =B1 29%      +0.3        0.54 =B1 15%  perf-profile.children.c=
ycles-pp.select_idle_cpu
>       0.10 =B1 10%      +0.3        0.43 =B1 17%  perf-profile.children.c=
ycles-pp.fsnotify_perm
>       0.23 =B1 11%      +0.3        0.56 =B1  6%  perf-profile.children.c=
ycles-pp.syscall_enter_from_user_mode
>       0.06 =B1 75%      +0.4        0.47 =B1 27%  perf-profile.children.c=
ycles-pp.queue_event
>       0.21 =B1  9%      +0.4        0.62 =B1  5%  perf-profile.children.c=
ycles-pp.entry_SYSCALL_64_safe_stack
>       0.06 =B1 75%      +0.4        0.48 =B1 26%  perf-profile.children.c=
ycles-pp.ordered_events__queue
>       0.06 =B1 73%      +0.4        0.50 =B1 24%  perf-profile.children.c=
ycles-pp.process_simple
>       0.01 =B1223%      +0.4        0.44 =B1  9%  perf-profile.children.c=
ycles-pp.schedule_idle
>       0.05 =B1  8%      +0.5        0.52 =B1  7%  perf-profile.children.c=
ycles-pp.__alloc_pages
>       0.45 =B1  7%      +0.5        0.94 =B1  5%  perf-profile.children.c=
ycles-pp.__get_task_ioprio
>       0.89 =B1  8%      +0.5        1.41 =B1  4%  perf-profile.children.c=
ycles-pp.__might_sleep
>       0.01 =B1223%      +0.5        0.54 =B1 21%  perf-profile.children.c=
ycles-pp.flush_smp_call_function_queue
>       0.05 =B1 46%      +0.5        0.60 =B1  7%  perf-profile.children.c=
ycles-pp.osq_lock
>       0.34 =B1  8%      +0.6        0.90 =B1  5%  perf-profile.children.c=
ycles-pp.aa_file_perm
>       0.01 =B1223%      +0.7        0.67 =B1  7%  perf-profile.children.c=
ycles-pp.poll_idle
>       0.14 =B1 17%      +0.7        0.82 =B1  6%  perf-profile.children.c=
ycles-pp.mutex_spin_on_owner
>       0.12 =B1 12%      +0.7        0.82 =B1 15%  perf-profile.children.c=
ycles-pp.__cmd_record
>       0.07 =B1 72%      +0.7        0.78 =B1 19%  perf-profile.children.c=
ycles-pp.reader__read_event
>       0.07 =B1 72%      +0.7        0.78 =B1 19%  perf-profile.children.c=
ycles-pp.record__finish_output
>       0.07 =B1 72%      +0.7        0.78 =B1 19%  perf-profile.children.c=
ycles-pp.perf_session__process_events
>       0.76 =B1  8%      +0.8        1.52 =B1  5%  perf-profile.children.c=
ycles-pp.file_update_time
>       0.08 =B1 61%      +0.8        0.85 =B1 11%  perf-profile.children.c=
ycles-pp.intel_idle_irq
>       1.23 =B1  8%      +0.9        2.11 =B1  4%  perf-profile.children.c=
ycles-pp.__might_fault
>       0.02 =B1141%      +1.0        0.97 =B1  7%  perf-profile.children.c=
ycles-pp.page_counter_uncharge
>       0.51 =B1  9%      +1.0        1.48 =B1  4%  perf-profile.children.c=
ycles-pp.current_time
>       0.05 =B1 46%      +1.1        1.15 =B1  7%  perf-profile.children.c=
ycles-pp.uncharge_batch
>       1.12 =B1  6%      +1.1        2.23 =B1  5%  perf-profile.children.c=
ycles-pp.__fget_light
>       0.06 =B1 14%      +1.2        1.23 =B1  6%  perf-profile.children.c=
ycles-pp.__mem_cgroup_uncharge
>       0.06 =B1 14%      +1.2        1.24 =B1  7%  perf-profile.children.c=
ycles-pp.__folio_put
>       0.64 =B1  7%      +1.2        1.83 =B1  5%  perf-profile.children.c=
ycles-pp.syscall_return_via_sysret
>       1.19 =B1  8%      +1.2        2.42 =B1  4%  perf-profile.children.c=
ycles-pp.__might_resched
>       0.59 =B1  9%      +1.3        1.84 =B1  6%  perf-profile.children.c=
ycles-pp.atime_needs_update
>      43.47            +1.4       44.83        perf-profile.children.cycle=
s-pp.ksys_write
>       1.28 =B1  6%      +1.4        2.68 =B1  5%  perf-profile.children.c=
ycles-pp.__fdget_pos
>       0.80 =B1  8%      +1.5        2.28 =B1  6%  perf-profile.children.c=
ycles-pp.touch_atime
>       0.11 =B1 49%      +1.5        1.59 =B1  9%  perf-profile.children.c=
ycles-pp.cpuidle_enter_state
>       0.11 =B1 49%      +1.5        1.60 =B1  9%  perf-profile.children.c=
ycles-pp.cpuidle_enter
>       0.12 =B1 51%      +1.7        1.81 =B1  9%  perf-profile.children.c=
ycles-pp.cpuidle_idle_call
>       1.44 =B1  8%      +1.8        3.22 =B1  6%  perf-profile.children.c=
ycles-pp.copyin
>       2.00 =B1  9%      +2.0        4.03 =B1  5%  perf-profile.children.c=
ycles-pp.copyout
>       1.02 =B1  8%      +2.0        3.07 =B1  5%  perf-profile.children.c=
ycles-pp.entry_SYSRETQ_unsafe_stack
>       1.63 =B1  7%      +2.3        3.90 =B1  5%  perf-profile.children.c=
ycles-pp.apparmor_file_permission
>       2.64 =B1  8%      +2.3        4.98 =B1  5%  perf-profile.children.c=
ycles-pp._copy_from_iter
>       0.40 =B1 14%      +2.5        2.92 =B1  7%  perf-profile.children.c=
ycles-pp.__mutex_lock
>       2.91 =B1  8%      +2.6        5.54 =B1  5%  perf-profile.children.c=
ycles-pp.copy_page_from_iter
>       0.17 =B1 62%      +2.7        2.91 =B1 11%  perf-profile.children.c=
ycles-pp.start_secondary
>       1.83 =B1  7%      +2.8        4.59 =B1  5%  perf-profile.children.c=
ycles-pp.security_file_permission
>       0.17 =B1 60%      +2.8        2.94 =B1 11%  perf-profile.children.c=
ycles-pp.do_idle
>       0.17 =B1 60%      +2.8        2.96 =B1 11%  perf-profile.children.c=
ycles-pp.secondary_startup_64_no_verify
>       0.17 =B1 60%      +2.8        2.96 =B1 11%  perf-profile.children.c=
ycles-pp.cpu_startup_entry
>       2.62 =B1  9%      +3.2        5.84 =B1  6%  perf-profile.children.c=
ycles-pp._copy_to_iter
>       1.55 =B1  8%      +3.2        4.79 =B1  5%  perf-profile.children.c=
ycles-pp.__entry_text_start
>       3.09 =B1  8%      +3.7        6.77 =B1  5%  perf-profile.children.c=
ycles-pp.copy_user_enhanced_fast_string
>       2.95 =B1  9%      +3.8        6.73 =B1  5%  perf-profile.children.c=
ycles-pp.copy_page_to_iter
>       2.28 =B1 11%      +5.1        7.40 =B1  6%  perf-profile.children.c=
ycles-pp.mutex_unlock
>       3.92 =B1  9%      +6.0        9.94 =B1  5%  perf-profile.children.c=
ycles-pp.mutex_lock
>       8.37 =B1  9%      -5.8        2.60 =B1 23%  perf-profile.self.cycle=
s-pp.native_queued_spin_lock_slowpath
>       6.54 =B1 15%      -4.6        1.95 =B1 57%  perf-profile.self.cycle=
s-pp.update_cfs_group
>       3.08 =B1  4%      -2.3        0.74 =B1 22%  perf-profile.self.cycle=
s-pp.switch_mm_irqs_off
>       2.96 =B1  4%      -1.8        1.13 =B1 33%  perf-profile.self.cycle=
s-pp.update_load_avg
>       2.22 =B1  8%      -1.5        0.74 =B1 12%  perf-profile.self.cycle=
s-pp._raw_spin_lock_irqsave
>       1.96 =B1  9%      -1.5        0.48 =B1 15%  perf-profile.self.cycle=
s-pp.update_curr
>       1.94 =B1  5%      -1.3        0.64 =B1 16%  perf-profile.self.cycle=
s-pp._raw_spin_lock
>       1.78 =B1  5%      -1.3        0.50 =B1 18%  perf-profile.self.cycle=
s-pp.__schedule
>       1.59 =B1  7%      -1.2        0.40 =B1 12%  perf-profile.self.cycle=
s-pp.enqueue_entity
>       1.61 =B1  6%      -1.2        0.42 =B1 25%  perf-profile.self.cycle=
s-pp.restore_fpregs_from_fpstate
>       1.44 =B1  8%      -1.0        0.39 =B1 14%  perf-profile.self.cycle=
s-pp.__update_load_avg_cfs_rq
>       1.42 =B1  5%      -1.0        0.41 =B1 19%  perf-profile.self.cycle=
s-pp.__switch_to_asm
>       1.18 =B1  7%      -0.9        0.33 =B1 14%  perf-profile.self.cycle=
s-pp.__update_load_avg_se
>       1.14 =B1 10%      -0.8        0.31 =B1  9%  perf-profile.self.cycle=
s-pp.update_rq_clock
>       0.90 =B1  7%      -0.7        0.19 =B1 21%  perf-profile.self.cycle=
s-pp.pick_next_task_fair
>       1.04 =B1  7%      -0.7        0.33 =B1 13%  perf-profile.self.cycle=
s-pp.prepare_task_switch
>       0.98 =B1  4%      -0.7        0.29 =B1 20%  perf-profile.self.cycle=
s-pp.__switch_to
>       0.88 =B1  6%      -0.7        0.20 =B1 17%  perf-profile.self.cycle=
s-pp.enqueue_task_fair
>       1.01 =B1  6%      -0.7        0.35 =B1 10%  perf-profile.self.cycle=
s-pp.prepare_to_wait_event
>       0.90 =B1  8%      -0.6        0.25 =B1 12%  perf-profile.self.cycle=
s-pp.update_min_vruntime
>       0.79 =B1 17%      -0.6        0.22 =B1  9%  perf-profile.self.cycle=
s-pp.cpuacct_charge
>       1.10 =B1  5%      -0.6        0.54 =B1  9%  perf-profile.self.cycle=
s-pp.try_to_wake_up
>       0.66 =B1  3%      -0.5        0.15 =B1 27%  perf-profile.self.cycle=
s-pp.os_xsave
>       0.71 =B1  6%      -0.5        0.22 =B1 18%  perf-profile.self.cycle=
s-pp.reweight_entity
>       0.68 =B1  9%      -0.5        0.19 =B1 10%  perf-profile.self.cycle=
s-pp.perf_trace_sched_wakeup_template
>       0.67 =B1  9%      -0.5        0.18 =B1 11%  perf-profile.self.cycle=
s-pp.__wake_up_common
>       0.65 =B1  6%      -0.5        0.17 =B1 23%  perf-profile.self.cycle=
s-pp.switch_fpu_return
>       0.60 =B1 11%      -0.5        0.14 =B1 28%  perf-profile.self.cycle=
s-pp.perf_tp_event
>       0.52 =B1 44%      -0.5        0.06 =B1151%  perf-profile.self.cycle=
s-pp.native_irq_return_iret
>       0.52 =B1  7%      -0.4        0.08 =B1 25%  perf-profile.self.cycle=
s-pp._raw_spin_unlock_irqrestore
>       0.55 =B1  4%      -0.4        0.15 =B1 22%  perf-profile.self.cycle=
s-pp.__calc_delta
>       0.61 =B1  5%      -0.4        0.21 =B1 12%  perf-profile.self.cycle=
s-pp.dequeue_task_fair
>       0.69 =B1 14%      -0.4        0.32 =B1 11%  perf-profile.self.cycle=
s-pp.task_h_load
>       0.49 =B1 11%      -0.3        0.15 =B1 29%  perf-profile.self.cycle=
s-pp.___perf_sw_event
>       0.37 =B1  4%      -0.3        0.05 =B1 73%  perf-profile.self.cycle=
s-pp.pick_next_entity
>       0.50 =B1  3%      -0.3        0.19 =B1 15%  perf-profile.self.cycle=
s-pp.select_idle_sibling
>       0.38 =B1  9%      -0.3        0.08 =B1 24%  perf-profile.self.cycle=
s-pp.set_next_buddy
>       0.32 =B1  4%      -0.3        0.03 =B1100%  perf-profile.self.cycle=
s-pp.put_prev_entity
>       0.64 =B1  6%      -0.3        0.35 =B1  7%  perf-profile.self.cycle=
s-pp._raw_spin_lock_irq
>       0.52 =B1  5%      -0.3        0.25 =B1  6%  perf-profile.self.cycle=
s-pp.__list_del_entry_valid
>       0.34 =B1  5%      -0.3        0.07 =B1 29%  perf-profile.self.cycle=
s-pp.schedule
>       0.35 =B1  9%      -0.3        0.08 =B1 10%  perf-profile.self.cycle=
s-pp.rb_insert_color
>       0.40 =B1  5%      -0.3        0.14 =B1 16%  perf-profile.self.cycle=
s-pp.select_task_rq_fair
>       0.33 =B1  6%      -0.3        0.08 =B1 16%  perf-profile.self.cycle=
s-pp.check_preempt_wakeup
>       0.33 =B1  8%      -0.2        0.10 =B1 16%  perf-profile.self.cycle=
s-pp.select_task_rq
>       0.36 =B1  3%      -0.2        0.13 =B1 16%  perf-profile.self.cycle=
s-pp.native_sched_clock
>       0.32 =B1  7%      -0.2        0.10 =B1 14%  perf-profile.self.cycle=
s-pp.finish_task_switch
>       0.32 =B1  4%      -0.2        0.11 =B1 13%  perf-profile.self.cycle=
s-pp.dequeue_entity
>       0.32 =B1  8%      -0.2        0.12 =B1 10%  perf-profile.self.cycle=
s-pp.__list_add_valid
>       0.23 =B1  5%      -0.2        0.03 =B1103%  perf-profile.self.cycle=
s-pp.resched_curr
>       0.27 =B1  6%      -0.2        0.07 =B1 21%  perf-profile.self.cycle=
s-pp.rb_erase
>       0.27 =B1  5%      -0.2        0.08 =B1 20%  perf-profile.self.cycle=
s-pp.__wrgsbase_inactive
>       0.28 =B1 13%      -0.2        0.09 =B1 12%  perf-profile.self.cycle=
s-pp.check_preempt_curr
>       0.30 =B1 13%      -0.2        0.12 =B1  7%  perf-profile.self.cycle=
s-pp.ttwu_queue_wakelist
>       0.24 =B1  5%      -0.2        0.06 =B1 19%  perf-profile.self.cycle=
s-pp.set_next_entity
>       0.21 =B1 34%      -0.2        0.04 =B1 71%  perf-profile.self.cycle=
s-pp.__flush_smp_call_function_queue
>       0.25 =B1  5%      -0.2        0.08 =B1 16%  perf-profile.self.cycle=
s-pp.rcu_note_context_switch
>       0.19 =B1 26%      -0.1        0.04 =B1 73%  perf-profile.self.cycle=
s-pp.perf_trace_sched_stat_runtime
>       0.20 =B1  8%      -0.1        0.06 =B1 13%  perf-profile.self.cycle=
s-pp.ttwu_do_activate
>       0.17 =B1  8%      -0.1        0.03 =B1100%  perf-profile.self.cycle=
s-pp.rb_next
>       0.22 =B1 23%      -0.1        0.09 =B1 31%  perf-profile.self.cycle=
s-pp.migrate_task_rq_fair
>       0.15 =B1 32%      -0.1        0.03 =B1100%  perf-profile.self.cycle=
s-pp.llist_reverse_order
>       0.16 =B1  8%      -0.1        0.06 =B1 14%  perf-profile.self.cycle=
s-pp.wake_affine
>       0.10 =B1 31%      -0.1        0.03 =B1100%  perf-profile.self.cycle=
s-pp.sched_ttwu_pending
>       0.14 =B1  5%      -0.1        0.07 =B1 20%  perf-profile.self.cycle=
s-pp.read@plt
>       0.32 =B1  8%      -0.1        0.26 =B1  3%  perf-profile.self.cycle=
s-pp.anon_pipe_buf_release
>       0.10 =B1  6%      -0.1        0.04 =B1 45%  perf-profile.self.cycle=
s-pp.__wake_up_common_lock
>       0.10 =B1  9%      -0.0        0.07 =B1  8%  perf-profile.self.cycle=
s-pp.__mark_inode_dirty
>       0.00            +0.1        0.06 =B1 11%  perf-profile.self.cycles-=
pp.free_unref_page
>       0.00            +0.1        0.06 =B1  6%  perf-profile.self.cycles-=
pp.__alloc_pages
>       0.00            +0.1        0.06 =B1 11%  perf-profile.self.cycles-=
pp._raw_spin_trylock
>       0.00            +0.1        0.06 =B1  7%  perf-profile.self.cycles-=
pp.uncharge_folio
>       0.00            +0.1        0.06 =B1 11%  perf-profile.self.cycles-=
pp.uncharge_batch
>       0.00            +0.1        0.07 =B1 10%  perf-profile.self.cycles-=
pp.menu_select
>       0.00            +0.1        0.08 =B1 14%  perf-profile.self.cycles-=
pp.__get_obj_cgroup_from_memcg
>       0.00            +0.1        0.08 =B1  7%  perf-profile.self.cycles-=
pp.__memcg_kmem_charge_page
>       0.00            +0.1        0.10 =B1 10%  perf-profile.self.cycles-=
pp.osq_unlock
>       0.07 =B1  5%      +0.1        0.17 =B1  8%  perf-profile.self.cycle=
s-pp.copyin
>       0.00            +0.1        0.11 =B1 11%  perf-profile.self.cycles-=
pp.__mod_memcg_state
>       0.13 =B1  8%      +0.1        0.24 =B1  6%  perf-profile.self.cycle=
s-pp.rcu_all_qs
>       0.14 =B1  5%      +0.1        0.28 =B1  5%  perf-profile.self.cycle=
s-pp.__x64_sys_write
>       0.07 =B1 10%      +0.1        0.21 =B1  5%  perf-profile.self.cycle=
s-pp.page_copy_sane
>       0.13 =B1 12%      +0.1        0.28 =B1  9%  perf-profile.self.cycle=
s-pp.__x64_sys_read
>       0.00            +0.2        0.15 =B1 10%  perf-profile.self.cycles-=
pp.propagate_protected_usage
>       0.18 =B1  9%      +0.2        0.33 =B1  4%  perf-profile.self.cycle=
s-pp.syscall_exit_to_user_mode_prepare
>       0.07 =B1  8%      +0.2        0.23 =B1  5%  perf-profile.self.cycle=
s-pp.rw_verify_area
>       0.08 =B1 34%      +0.2        0.24 =B1 27%  perf-profile.self.cycle=
s-pp.mnt_user_ns
>       0.13 =B1  5%      +0.2        0.31 =B1  7%  perf-profile.self.cycle=
s-pp.kill_fasync
>       0.21 =B1  8%      +0.2        0.39 =B1  5%  perf-profile.self.cycle=
s-pp.__might_fault
>       0.06 =B1 13%      +0.2        0.26 =B1  9%  perf-profile.self.cycle=
s-pp.copyout
>       0.10 =B1 11%      +0.2        0.31 =B1  8%  perf-profile.self.cycle=
s-pp.ktime_get_coarse_real_ts64
>       0.26 =B1 13%      +0.2        0.49 =B1  6%  perf-profile.self.cycle=
s-pp.inode_needs_update_time
>       0.23 =B1  8%      +0.2        0.47 =B1  5%  perf-profile.self.cycle=
s-pp.copy_page_from_iter
>       0.14 =B1  7%      +0.2        0.38 =B1  6%  perf-profile.self.cycle=
s-pp.file_update_time
>       0.36 =B1  7%      +0.3        0.62 =B1  4%  perf-profile.self.cycle=
s-pp.ksys_read
>       0.54 =B1 13%      +0.3        0.80 =B1  4%  perf-profile.self.cycle=
s-pp._copy_from_iter
>       0.15 =B1  5%      +0.3        0.41 =B1  8%  perf-profile.self.cycle=
s-pp.touch_atime
>       0.14 =B1  5%      +0.3        0.40 =B1  6%  perf-profile.self.cycle=
s-pp.__cond_resched
>       0.18 =B1  5%      +0.3        0.47 =B1  4%  perf-profile.self.cycle=
s-pp.syscall_exit_to_user_mode
>       0.16 =B1  8%      +0.3        0.46 =B1  6%  perf-profile.self.cycle=
s-pp.syscall_enter_from_user_mode
>       0.16 =B1  9%      +0.3        0.47 =B1  6%  perf-profile.self.cycle=
s-pp.__fdget_pos
>       1.79 =B1  8%      +0.3        2.12 =B1  3%  perf-profile.self.cycle=
s-pp.pipe_read
>       0.10 =B1  8%      +0.3        0.43 =B1 17%  perf-profile.self.cycle=
s-pp.fsnotify_perm
>       0.20 =B1  4%      +0.4        0.55 =B1  5%  perf-profile.self.cycle=
s-pp.ksys_write
>       0.05 =B1 76%      +0.4        0.46 =B1 27%  perf-profile.self.cycle=
s-pp.queue_event
>       0.32 =B1  6%      +0.4        0.73 =B1  6%  perf-profile.self.cycle=
s-pp.exit_to_user_mode_prepare
>       0.21 =B1  9%      +0.4        0.62 =B1  6%  perf-profile.self.cycle=
s-pp.entry_SYSCALL_64_safe_stack
>       0.79 =B1  8%      +0.4        1.22 =B1  4%  perf-profile.self.cycle=
s-pp.__might_sleep
>       0.44 =B1  5%      +0.4        0.88 =B1  7%  perf-profile.self.cycle=
s-pp.do_syscall_64
>       0.26 =B1  8%      +0.4        0.70 =B1  4%  perf-profile.self.cycle=
s-pp.atime_needs_update
>       0.42 =B1  7%      +0.5        0.88 =B1  5%  perf-profile.self.cycle=
s-pp.__get_task_ioprio
>       0.28 =B1 12%      +0.5        0.75 =B1  5%  perf-profile.self.cycle=
s-pp.copy_page_to_iter
>       0.19 =B1  6%      +0.5        0.68 =B1 10%  perf-profile.self.cycle=
s-pp.security_file_permission
>       0.31 =B1  8%      +0.5        0.83 =B1  5%  perf-profile.self.cycle=
s-pp.aa_file_perm
>       0.05 =B1 46%      +0.5        0.59 =B1  8%  perf-profile.self.cycle=
s-pp.osq_lock
>       0.30 =B1  7%      +0.5        0.85 =B1  6%  perf-profile.self.cycle=
s-pp._copy_to_iter
>       0.00            +0.6        0.59 =B1  6%  perf-profile.self.cycles-=
pp.poll_idle
>       0.13 =B1 20%      +0.7        0.81 =B1  6%  perf-profile.self.cycle=
s-pp.mutex_spin_on_owner
>       0.38 =B1  9%      +0.7        1.12 =B1  5%  perf-profile.self.cycle=
s-pp.current_time
>       0.08 =B1 59%      +0.8        0.82 =B1 11%  perf-profile.self.cycle=
s-pp.intel_idle_irq
>       0.92 =B1  6%      +0.8        1.72 =B1  4%  perf-profile.self.cycle=
s-pp.entry_SYSCALL_64_after_hwframe
>       0.01 =B1223%      +0.8        0.82 =B1  6%  perf-profile.self.cycle=
s-pp.page_counter_uncharge
>       0.86 =B1  7%      +1.1        1.91 =B1  4%  perf-profile.self.cycle=
s-pp.vfs_read
>       1.07 =B1  6%      +1.1        2.14 =B1  5%  perf-profile.self.cycle=
s-pp.__fget_light
>       0.67 =B1  7%      +1.1        1.74 =B1  6%  perf-profile.self.cycle=
s-pp.vfs_write
>       0.15 =B1 12%      +1.1        1.28 =B1  7%  perf-profile.self.cycle=
s-pp.__mutex_lock
>       1.09 =B1  6%      +1.1        2.22 =B1  5%  perf-profile.self.cycle=
s-pp.__libc_read
>       0.62 =B1  6%      +1.2        1.79 =B1  5%  perf-profile.self.cycle=
s-pp.syscall_return_via_sysret
>       1.16 =B1  8%      +1.2        2.38 =B1  4%  perf-profile.self.cycle=
s-pp.__might_resched
>       0.91 =B1  7%      +1.3        2.20 =B1  5%  perf-profile.self.cycle=
s-pp.__libc_write
>       0.59 =B1  8%      +1.3        1.93 =B1  6%  perf-profile.self.cycle=
s-pp.__entry_text_start
>       1.27 =B1  7%      +1.7        3.00 =B1  6%  perf-profile.self.cycle=
s-pp.apparmor_file_permission
>       0.99 =B1  8%      +2.0        2.98 =B1  5%  perf-profile.self.cycle=
s-pp.entry_SYSRETQ_unsafe_stack
>       1.74 =B1  8%      +3.4        5.15 =B1  6%  perf-profile.self.cycle=
s-pp.pipe_write
>       2.98 =B1  8%      +3.7        6.64 =B1  5%  perf-profile.self.cycle=
s-pp.copy_user_enhanced_fast_string
>       2.62 =B1 10%      +4.8        7.38 =B1  5%  perf-profile.self.cycle=
s-pp.mutex_lock
>       2.20 =B1 10%      +5.1        7.30 =B1  6%  perf-profile.self.cycle=
s-pp.mutex_unlock
> =

> =

> *************************************************************************=
**************************
> lkp-skl-fpga01: 104 threads 2 sockets (Skylake) with 192G memory
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/t=
box_group/testcase:
>   gcc-11/performance/socket/4/x86_64-rhel-8.3/process/100%/debian-11.1-x8=
6_64-20220510.cgz/lkp-skl-fpga01/hackbench
> =

> commit:
>   a2e90611b9 ("sched/fair: Remove capacity inversion detection")
>   829c1651e9 ("sched/fair: sanitize vruntime of entity being placed")
> =

> a2e90611b9f425ad 829c1651e9c4a6f78398d3e6765
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>     177139            -8.1%     162815        hackbench.throughput
>     174484           -18.8%     141618 =B1  2%  hackbench.throughput_avg
>     177139            -8.1%     162815        hackbench.throughput_best
>     168530           -37.3%     105615 =B1  3%  hackbench.throughput_worst
>     281.38           +23.1%     346.39 =B1  2%  hackbench.time.elapsed_ti=
me
>     281.38           +23.1%     346.39 =B1  2%  hackbench.time.elapsed_ti=
me.max
>  1.053e+08 =B1  2%    +688.4%  8.302e+08 =B1  9%  hackbench.time.involunt=
ary_context_switches
>      21992           +27.8%      28116 =B1  2%  hackbench.time.system_time
>       6652            +8.2%       7196        hackbench.time.user_time
>  3.482e+08          +289.2%  1.355e+09 =B1  9%  hackbench.time.voluntary_=
context_switches
>    2110813 =B1  5%     +21.6%    2565791 =B1  3%  cpuidle..usage
>     333.95           +19.5%     399.05        uptime.boot
>       0.03            -0.0        0.03        mpstat.cpu.all.soft%
>      22.68            -2.9       19.77        mpstat.cpu.all.usr%
>     561083 =B1 10%     +45.5%     816171 =B1 12%  numa-numastat.node0.loc=
al_node
>     614314 =B1  9%     +36.9%     841173 =B1 12%  numa-numastat.node0.num=
a_hit
>    1393279 =B1  7%     -16.8%    1158997 =B1  2%  numa-numastat.node1.loc=
al_node
>    1443679 =B1  5%     -14.9%    1229074 =B1  3%  numa-numastat.node1.num=
a_hit
>    4129900 =B1  8%     -23.0%    3181115        vmstat.memory.cache
>       1731           +30.8%       2265        vmstat.procs.r
>    1598044          +290.3%    6237840 =B1  7%  vmstat.system.cs
>     320762           +60.5%     514672 =B1  8%  vmstat.system.in
>     962111 =B1  6%     +46.0%    1404646 =B1  7%  turbostat.C1
>     233987 =B1  5%     +51.2%     353892        turbostat.C1E
>   91515563           +97.3%  1.806e+08 =B1 10%  turbostat.IRQ
>     448466 =B1 14%     -34.2%     294934 =B1  5%  turbostat.POLL
>      34.60            -7.3%      32.07        turbostat.RAMWatt
>     514028 =B1  2%     -14.0%     442125 =B1  2%  meminfo.AnonPages
>    4006312 =B1  8%     -23.9%    3047078        meminfo.Cached
>    3321064 =B1 10%     -32.7%    2236362 =B1  2%  meminfo.Committed_AS
>    1714752 =B1 21%     -60.3%     680479 =B1  8%  meminfo.Inactive
>    1714585 =B1 21%     -60.3%     680305 =B1  8%  meminfo.Inactive(anon)
>     757124 =B1 18%     -67.2%     248485 =B1 27%  meminfo.Mapped
>    6476123 =B1  6%     -19.4%    5220738        meminfo.Memused
>    1275724 =B1 26%     -75.2%     316896 =B1 15%  meminfo.Shmem
>    6806047 =B1  3%     -13.3%    5901974        meminfo.max_used_kB
>     161311 =B1 23%     +31.7%     212494 =B1  5%  numa-meminfo.node0.Anon=
Pages
>     165693 =B1 22%     +30.5%     216264 =B1  5%  numa-meminfo.node0.Inac=
tive
>     165563 =B1 22%     +30.6%     216232 =B1  5%  numa-meminfo.node0.Inac=
tive(anon)
>     140638 =B1 19%     -36.7%      89034 =B1 11%  numa-meminfo.node0.Mapp=
ed
>     352173 =B1 14%     -35.3%     227805 =B1  8%  numa-meminfo.node1.Anon=
Pages
>     501396 =B1 11%     -22.6%     388042 =B1  5%  numa-meminfo.node1.Anon=
Pages.max
>    1702242 =B1 43%     -77.8%     378325 =B1 22%  numa-meminfo.node1.File=
Pages
>    1540803 =B1 25%     -70.4%     455592 =B1 13%  numa-meminfo.node1.Inac=
tive
>    1540767 =B1 25%     -70.4%     455451 =B1 13%  numa-meminfo.node1.Inac=
tive(anon)
>     612123 =B1 18%     -74.9%     153752 =B1 37%  numa-meminfo.node1.Mapp=
ed
>    3085231 =B1 24%     -53.9%    1420940 =B1 14%  numa-meminfo.node1.MemU=
sed
>     254052 =B1  4%     -19.1%     205632 =B1 21%  numa-meminfo.node1.SUnr=
eclaim
>    1259640 =B1 27%     -75.9%     303123 =B1 15%  numa-meminfo.node1.Shmem
>     304597 =B1  7%     -20.2%     242920 =B1 17%  numa-meminfo.node1.Slab
>      40345 =B1 23%     +31.5%      53054 =B1  5%  numa-vmstat.node0.nr_an=
on_pages
>      41412 =B1 22%     +30.4%      53988 =B1  5%  numa-vmstat.node0.nr_in=
active_anon
>      35261 =B1 19%     -36.9%      22256 =B1 12%  numa-vmstat.node0.nr_ma=
pped
>      41412 =B1 22%     +30.4%      53988 =B1  5%  numa-vmstat.node0.nr_zo=
ne_inactive_anon
>     614185 =B1  9%     +36.9%     841065 =B1 12%  numa-vmstat.node0.numa_=
hit
>     560955 =B1 11%     +45.5%     816063 =B1 12%  numa-vmstat.node0.numa_=
local
>      88129 =B1 14%     -35.2%      57097 =B1  8%  numa-vmstat.node1.nr_an=
on_pages
>     426425 =B1 43%     -77.9%      94199 =B1 22%  numa-vmstat.node1.nr_fi=
le_pages
>     386166 =B1 25%     -70.5%     113880 =B1 13%  numa-vmstat.node1.nr_in=
active_anon
>     153658 =B1 18%     -75.3%      38021 =B1 37%  numa-vmstat.node1.nr_ma=
pped
>     315775 =B1 27%     -76.1%      75399 =B1 16%  numa-vmstat.node1.nr_sh=
mem
>      63411 =B1  4%     -18.6%      51593 =B1 21%  numa-vmstat.node1.nr_sl=
ab_unreclaimable
>     386166 =B1 25%     -70.5%     113880 =B1 13%  numa-vmstat.node1.nr_zo=
ne_inactive_anon
>    1443470 =B1  5%     -14.9%    1228740 =B1  3%  numa-vmstat.node1.numa_=
hit
>    1393069 =B1  7%     -16.8%    1158664 =B1  2%  numa-vmstat.node1.numa_=
local
>     128457 =B1  2%     -14.0%     110530 =B1  3%  proc-vmstat.nr_anon_pag=
es
>     999461 =B1  8%     -23.8%     761774        proc-vmstat.nr_file_pages
>     426485 =B1 21%     -60.1%     170237 =B1  9%  proc-vmstat.nr_inactive=
_anon
>      82464            -2.6%      80281        proc-vmstat.nr_kernel_stack
>     187777 =B1 18%     -66.9%      62076 =B1 28%  proc-vmstat.nr_mapped
>     316813 =B1 27%     -75.0%      79228 =B1 16%  proc-vmstat.nr_shmem
>      31469            -2.0%      30840        proc-vmstat.nr_slab_reclaim=
able
>     117889            -8.4%     108036        proc-vmstat.nr_slab_unrecla=
imable
>     426485 =B1 21%     -60.1%     170237 =B1  9%  proc-vmstat.nr_zone_ina=
ctive_anon
>     187187 =B1 12%     -43.5%     105680 =B1  9%  proc-vmstat.numa_hint_f=
aults
>     128363 =B1 15%     -61.5%      49371 =B1 19%  proc-vmstat.numa_hint_f=
aults_local
>      47314 =B1 22%     +39.2%      65863 =B1 13%  proc-vmstat.numa_pages_=
migrated
>     457026 =B1  9%     -18.1%     374188 =B1 13%  proc-vmstat.numa_pte_up=
dates
>    2586600 =B1  3%     +27.7%    3302787 =B1  8%  proc-vmstat.pgalloc_nor=
mal
>    1589970            -6.2%    1491838        proc-vmstat.pgfault
>    2347186 =B1 10%     +37.7%    3232369 =B1  8%  proc-vmstat.pgfree
>      47314 =B1 22%     +39.2%      65863 =B1 13%  proc-vmstat.pgmigrate_s=
uccess
>     112713            +7.0%     120630 =B1  3%  proc-vmstat.pgreuse
>    2189056           +22.2%    2674944 =B1  2%  proc-vmstat.unevictable_p=
gs_scanned
>      14.08 =B1  2%     +29.3%      18.20 =B1  5%  sched_debug.cfs_rq:/.h_=
nr_running.avg
>       0.80 =B1 14%    +179.2%       2.23 =B1 24%  sched_debug.cfs_rq:/.h_=
nr_running.min
>     245.23 =B1 12%     -19.7%     196.97 =B1  6%  sched_debug.cfs_rq:/.lo=
ad_avg.max
>       2.27 =B1 16%     +75.0%       3.97 =B1  4%  sched_debug.cfs_rq:/.lo=
ad_avg.min
>      45.77 =B1 16%     -17.8%      37.60 =B1  6%  sched_debug.cfs_rq:/.lo=
ad_avg.stddev
>   11842707           +39.9%   16567992        sched_debug.cfs_rq:/.min_vr=
untime.avg
>   13773080 =B1  3%    +113.9%   29460281 =B1  7%  sched_debug.cfs_rq:/.mi=
n_vruntime.max
>   11423218           +30.3%   14885830        sched_debug.cfs_rq:/.min_vr=
untime.min
>     301190 =B1 12%    +439.9%    1626088 =B1 10%  sched_debug.cfs_rq:/.mi=
n_vruntime.stddev
>     203.83           -16.3%     170.67        sched_debug.cfs_rq:/.remove=
d.load_avg.max
>      14330 =B1  3%     +30.9%      18756 =B1  5%  sched_debug.cfs_rq:/.ru=
nnable_avg.avg
>      25115 =B1  4%     +15.5%      28999 =B1  6%  sched_debug.cfs_rq:/.ru=
nnable_avg.max
>       3811 =B1 11%     +68.0%       6404 =B1 21%  sched_debug.cfs_rq:/.ru=
nnable_avg.min
>       3818 =B1  6%     +15.3%       4404 =B1  7%  sched_debug.cfs_rq:/.ru=
nnable_avg.stddev
>    -849635          +410.6%   -4338612        sched_debug.cfs_rq:/.spread=
0.avg
>    1092373 =B1 54%    +691.1%    8641673 =B1 21%  sched_debug.cfs_rq:/.sp=
read0.max
>   -1263082          +378.1%   -6038905        sched_debug.cfs_rq:/.spread=
0.min
>     300764 =B1 12%    +441.8%    1629507 =B1  9%  sched_debug.cfs_rq:/.sp=
read0.stddev
>       1591 =B1  4%     -11.1%       1413 =B1  3%  sched_debug.cfs_rq:/.ut=
il_avg.max
>     288.90 =B1 11%     +64.5%     475.23 =B1 13%  sched_debug.cfs_rq:/.ut=
il_avg.min
>     240.33 =B1  2%     -32.1%     163.09 =B1  3%  sched_debug.cfs_rq:/.ut=
il_avg.stddev
>     494.27 =B1  3%     +41.6%     699.85 =B1  3%  sched_debug.cfs_rq:/.ut=
il_est_enqueued.avg
>      11.23 =B1 54%    +634.1%      82.47 =B1 22%  sched_debug.cfs_rq:/.ut=
il_est_enqueued.min
>     174576           +20.7%     210681        sched_debug.cpu.clock.avg
>     174926           +21.2%     211944        sched_debug.cpu.clock.max
>     174164           +20.3%     209436        sched_debug.cpu.clock.min
>     230.84 =B1 33%    +226.1%     752.67 =B1 20%  sched_debug.cpu.clock.s=
tddev
>     172836           +20.6%     208504        sched_debug.cpu.clock_task.=
avg
>     173552           +21.0%     210079        sched_debug.cpu.clock_task.=
max
>     156807           +22.3%     191789        sched_debug.cpu.clock_task.=
min
>       1634           +17.1%       1914 =B1  5%  sched_debug.cpu.clock_tas=
k.stddev
>       0.00 =B1 32%    +220.1%       0.00 =B1 20%  sched_debug.cpu.next_ba=
lance.stddev
>      14.12 =B1  2%     +28.7%      18.18 =B1  5%  sched_debug.cpu.nr_runn=
ing.avg
>       0.73 =B1 25%    +213.6%       2.30 =B1 24%  sched_debug.cpu.nr_runn=
ing.min
>    1810086          +461.3%   10159215 =B1 10%  sched_debug.cpu.nr_switch=
es.avg
>    2315994 =B1  3%    +515.6%   14258195 =B1  9%  sched_debug.cpu.nr_swit=
ches.max
>    1529863          +380.3%    7348324 =B1  9%  sched_debug.cpu.nr_switch=
es.min
>     167487 =B1 18%    +770.8%    1458519 =B1 21%  sched_debug.cpu.nr_swit=
ches.stddev
>     174149           +20.2%     209410        sched_debug.cpu_clk
>     170980           +20.6%     206240        sched_debug.ktime
>     174896           +20.2%     210153        sched_debug.sched_clk
>       7.35           +24.9%       9.18 =B1  4%  perf-stat.i.MPKI
>  1.918e+10           +14.4%  2.194e+10        perf-stat.i.branch-instruct=
ions
>       2.16            -0.1        2.09        perf-stat.i.branch-miss-rat=
e%
>  4.133e+08            +6.6%  4.405e+08        perf-stat.i.branch-misses
>      23.08            -9.2       13.86 =B1  7%  perf-stat.i.cache-miss-ra=
te%
>  1.714e+08           -37.2%  1.076e+08 =B1  3%  perf-stat.i.cache-misses
>  7.497e+08           +33.7%  1.002e+09 =B1  5%  perf-stat.i.cache-referen=
ces
>    1636365          +382.4%    7893858 =B1  5%  perf-stat.i.context-switc=
hes
>       2.74            -6.8%       2.56        perf-stat.i.cpi
>     131725          +288.0%     511159 =B1 10%  perf-stat.i.cpu-migrations
>       1672          +160.8%       4361 =B1  4%  perf-stat.i.cycles-betwee=
n-cache-misses
>       0.49            +0.6        1.11 =B1  5%  perf-stat.i.dTLB-load-mis=
s-rate%
>  1.417e+08          +158.7%  3.665e+08 =B1  5%  perf-stat.i.dTLB-load-mis=
ses
>  2.908e+10            +9.1%  3.172e+10        perf-stat.i.dTLB-loads
>       0.12 =B1  4%      +0.1        0.20 =B1  4%  perf-stat.i.dTLB-store-=
miss-rate%
>   20805655 =B1  4%     +90.9%   39716345 =B1  4%  perf-stat.i.dTLB-store-=
misses
>  1.755e+10            +8.6%  1.907e+10        perf-stat.i.dTLB-stores
>      29.04            +3.6       32.62 =B1  2%  perf-stat.i.iTLB-load-mis=
s-rate%
>   56676082           +60.4%   90917582 =B1  3%  perf-stat.i.iTLB-load-mis=
ses
>  1.381e+08           +30.6%  1.804e+08        perf-stat.i.iTLB-loads
>   1.03e+11           +10.5%  1.139e+11        perf-stat.i.instructions
>       1840           -21.1%       1451 =B1  4%  perf-stat.i.instructions-=
per-iTLB-miss
>       0.37           +10.9%       0.41        perf-stat.i.ipc
>       1084            -4.5%       1035 =B1  2%  perf-stat.i.metric.K/sec
>     640.69           +10.3%     706.44        perf-stat.i.metric.M/sec
>       5249            -9.3%       4762 =B1  3%  perf-stat.i.minor-faults
>      23.57           +18.7       42.30 =B1  8%  perf-stat.i.node-load-mis=
s-rate%
>   40174555           -45.0%   22109431 =B1 10%  perf-stat.i.node-loads
>       8.84 =B1  2%     +24.5       33.30 =B1 10%  perf-stat.i.node-store-=
miss-rate%
>    2912322           +60.3%    4667137 =B1 16%  perf-stat.i.node-store-mi=
sses
>   34046752           -50.6%   16826621 =B1  9%  perf-stat.i.node-stores
>       5278            -9.2%       4791 =B1  3%  perf-stat.i.page-faults
>       7.24           +12.1%       8.12 =B1  4%  perf-stat.overall.MPKI
>       2.15            -0.1        2.05        perf-stat.overall.branch-mi=
ss-rate%
>      22.92            -9.5       13.41 =B1  7%  perf-stat.overall.cache-m=
iss-rate%
>       2.73            -6.3%       2.56        perf-stat.overall.cpi
>       1644           +43.4%       2358 =B1  3%  perf-stat.overall.cycles-=
between-cache-misses
>       0.48            +0.5        0.99 =B1  4%  perf-stat.overall.dTLB-lo=
ad-miss-rate%
>       0.12 =B1  4%      +0.1        0.19 =B1  4%  perf-stat.overall.dTLB-=
store-miss-rate%
>      29.06            +2.9       32.01 =B1  2%  perf-stat.overall.iTLB-lo=
ad-miss-rate%
>       1826           -26.6%       1340 =B1  4%  perf-stat.overall.instruc=
tions-per-iTLB-miss
>       0.37            +6.8%       0.39        perf-stat.overall.ipc
>      22.74            +6.8       29.53 =B1 13%  perf-stat.overall.node-lo=
ad-miss-rate%
>       7.63            +8.4       16.02 =B1 20%  perf-stat.overall.node-st=
ore-miss-rate%
>  1.915e+10            +9.0%  2.088e+10        perf-stat.ps.branch-instruc=
tions
>  4.119e+08            +3.9%  4.282e+08        perf-stat.ps.branch-misses
>  1.707e+08           -30.5%  1.186e+08 =B1  3%  perf-stat.ps.cache-misses
>  7.446e+08           +19.2%  8.874e+08 =B1  4%  perf-stat.ps.cache-refere=
nces
>    1611874          +289.1%    6271376 =B1  7%  perf-stat.ps.context-swit=
ches
>     127362          +189.0%     368041 =B1 11%  perf-stat.ps.cpu-migratio=
ns
>  1.407e+08          +116.2%  3.042e+08 =B1  5%  perf-stat.ps.dTLB-load-mi=
sses
>  2.901e+10            +5.4%  3.057e+10        perf-stat.ps.dTLB-loads
>   20667480 =B1  4%     +66.8%   34473793 =B1  4%  perf-stat.ps.dTLB-store=
-misses
>  1.751e+10            +5.1%   1.84e+10        perf-stat.ps.dTLB-stores
>   56310692           +45.0%   81644183 =B1  4%  perf-stat.ps.iTLB-load-mi=
sses
>  1.375e+08           +26.1%  1.733e+08        perf-stat.ps.iTLB-loads
>  1.028e+11            +6.3%  1.093e+11        perf-stat.ps.instructions
>       4929           -24.5%       3723 =B1  2%  perf-stat.ps.minor-faults
>   40134633           -32.9%   26946247 =B1  9%  perf-stat.ps.node-loads
>    2805073           +39.5%    3914304 =B1 16%  perf-stat.ps.node-store-m=
isses
>   33938259           -38.9%   20726382 =B1  8%  perf-stat.ps.node-stores
>       4952           -24.5%       3741 =B1  2%  perf-stat.ps.page-faults
>  2.911e+13           +30.9%  3.809e+13 =B1  2%  perf-stat.total.instructi=
ons
>      15.30 =B1  4%      -8.6        6.66 =B1  5%  perf-profile.calltrace.=
cycles-pp.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg.sock_write_=
iter.vfs_write
>      13.84 =B1  6%      -7.9        5.98 =B1  6%  perf-profile.calltrace.=
cycles-pp.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.soc=
k_sendmsg.sock_write_iter
>      13.61 =B1  6%      -7.8        5.84 =B1  6%  perf-profile.calltrace.=
cycles-pp.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream=
_sendmsg.sock_sendmsg
>       9.00 =B1  2%      -5.5        3.48 =B1  4%  perf-profile.calltrace.=
cycles-pp.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_rea=
d_iter.vfs_read
>       6.44 =B1  4%      -4.3        2.14 =B1  6%  perf-profile.calltrace.=
cycles-pp.skb_release_data.consume_skb.unix_stream_read_generic.unix_stream=
_recvmsg.sock_read_iter
>       5.83 =B1  8%      -3.4        2.44 =B1  5%  perf-profile.calltrace.=
cycles-pp.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc=
_send_pskb.unix_stream_sendmsg
>       5.81 =B1  6%      -3.3        2.48 =B1  6%  perf-profile.calltrace.=
cycles-pp.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_=
pskb.unix_stream_sendmsg
>       5.50 =B1  7%      -3.2        2.32 =B1  6%  perf-profile.calltrace.=
cycles-pp.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb.alloc_skb=
_with_frags.sock_alloc_send_pskb
>       5.07 =B1  8%      -3.0        2.04 =B1  6%  perf-profile.calltrace.=
cycles-pp.__kmem_cache_alloc_node.__kmalloc_node_track_caller.kmalloc_reser=
ve.__alloc_skb.alloc_skb_with_frags
>       6.22 =B1  2%      -2.9        3.33 =B1  3%  perf-profile.calltrace.=
cycles-pp.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvm=
sg.sock_read_iter.vfs_read
>       6.17 =B1  2%      -2.9        3.30 =B1  3%  perf-profile.calltrace.=
cycles-pp.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_ge=
neric.unix_stream_recvmsg.sock_read_iter
>       6.11 =B1  2%      -2.9        3.24 =B1  3%  perf-profile.calltrace.=
cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor=
.unix_stream_read_generic.unix_stream_recvmsg
>      50.99            -2.6       48.39        perf-profile.calltrace.cycl=
es-pp.__libc_read
>       5.66 =B1  3%      -2.3        3.35 =B1  3%  perf-profile.calltrace.=
cycles-pp.syscall_return_via_sysret.__libc_read
>       5.52 =B1  3%      -2.3        3.27 =B1  3%  perf-profile.calltrace.=
cycles-pp.syscall_return_via_sysret.__libc_write
>       3.14 =B1  2%      -1.7        1.42 =B1  4%  perf-profile.calltrace.=
cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_str=
eam_read_actor.unix_stream_read_generic
>       2.73 =B1  2%      -1.6        1.15 =B1  4%  perf-profile.calltrace.=
cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.=
unix_stream_read_actor
>       2.59 =B1  2%      -1.5        1.07 =B1  4%  perf-profile.calltrace.=
cycles-pp.copy_user_enhanced_fast_string.copyout._copy_to_iter.__skb_datagr=
am_iter.skb_copy_datagram_iter
>       2.72 =B1  3%      -1.4        1.34 =B1  6%  perf-profile.calltrace.=
cycles-pp.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock=
_read_iter.vfs_read
>      41.50            -1.2       40.27        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64_after_hwframe.__libc_read
>       2.26 =B1  4%      -1.1        1.12        perf-profile.calltrace.cy=
cles-pp.skb_release_head_state.consume_skb.unix_stream_read_generic.unix_st=
ream_recvmsg.sock_read_iter
>       2.76 =B1  3%      -1.1        1.63 =B1  3%  perf-profile.calltrace.=
cycles-pp.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_c=
opy_datagram_iter.unix_stream_read_actor
>       2.84 =B1  3%      -1.1        1.71 =B1  2%  perf-profile.calltrace.=
cycles-pp.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.un=
ix_stream_read_actor.unix_stream_read_generic
>       2.20 =B1  4%      -1.1        1.08        perf-profile.calltrace.cy=
cles-pp.unix_destruct_scm.skb_release_head_state.consume_skb.unix_stream_re=
ad_generic.unix_stream_recvmsg
>       2.98 =B1  2%      -1.1        1.90 =B1  6%  perf-profile.calltrace.=
cycles-pp.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_sendmsg.sock=
_write_iter.vfs_write
>       1.99 =B1  4%      -1.1        0.92 =B1  2%  perf-profile.calltrace.=
cycles-pp.sock_wfree.unix_destruct_scm.skb_release_head_state.consume_skb.u=
nix_stream_read_generic
>       2.10 =B1  3%      -1.0        1.08 =B1  4%  perf-profile.calltrace.=
cycles-pp.check_heap_object.__check_object_size.simple_copy_to_iter.__skb_d=
atagram_iter.skb_copy_datagram_iter
>       2.08 =B1  4%      -0.8        1.24 =B1  3%  perf-profile.calltrace.=
cycles-pp.__entry_text_start.__libc_write
>       2.16 =B1  3%      -0.7        1.47        perf-profile.calltrace.cy=
cles-pp.__entry_text_start.__libc_read
>       2.20 =B1  2%      -0.7        1.52 =B1  3%  perf-profile.calltrace.=
cycles-pp.__kmem_cache_free.skb_release_data.consume_skb.unix_stream_read_g=
eneric.unix_stream_recvmsg
>       1.46 =B1  3%      -0.6        0.87 =B1  8%  perf-profile.calltrace.=
cycles-pp._copy_from_iter.skb_copy_datagram_from_iter.unix_stream_sendmsg.s=
ock_sendmsg.sock_write_iter
>       4.82 =B1  2%      -0.6        4.24        perf-profile.calltrace.cy=
cles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwfr=
ame.__libc_read
>       1.31 =B1  2%      -0.4        0.90 =B1  4%  perf-profile.calltrace.=
cycles-pp.__check_object_size.skb_copy_datagram_from_iter.unix_stream_sendm=
sg.sock_sendmsg.sock_write_iter
>       0.96 =B1  3%      -0.4        0.57 =B1 10%  perf-profile.calltrace.=
cycles-pp.copyin._copy_from_iter.skb_copy_datagram_from_iter.unix_stream_se=
ndmsg.sock_sendmsg
>       1.14 =B1  3%      -0.4        0.76 =B1  5%  perf-profile.calltrace.=
cycles-pp.memcg_slab_post_alloc_hook.kmem_cache_alloc_node.__alloc_skb.allo=
c_skb_with_frags.sock_alloc_send_pskb
>       0.99 =B1  3%      -0.3        0.65 =B1  8%  perf-profile.calltrace.=
cycles-pp.memcg_slab_post_alloc_hook.__kmem_cache_alloc_node.__kmalloc_node=
_track_caller.kmalloc_reserve.__alloc_skb
>       1.30 =B1  4%      -0.3        0.99 =B1  3%  perf-profile.calltrace.=
cycles-pp.sock_recvmsg.sock_read_iter.vfs_read.ksys_read.do_syscall_64
>       0.98 =B1  2%      -0.3        0.69 =B1  3%  perf-profile.calltrace.=
cycles-pp.security_file_permission.vfs_write.ksys_write.do_syscall_64.entry=
_SYSCALL_64_after_hwframe
>       0.67            -0.2        0.42 =B1 50%  perf-profile.calltrace.cy=
cles-pp.check_heap_object.__check_object_size.skb_copy_datagram_from_iter.u=
nix_stream_sendmsg.sock_sendmsg
>       0.56 =B1  4%      -0.2        0.32 =B1 81%  perf-profile.calltrace.=
cycles-pp.__fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwfram=
e.__libc_read
>       0.86 =B1  2%      -0.2        0.63 =B1  3%  perf-profile.calltrace.=
cycles-pp.apparmor_file_permission.security_file_permission.vfs_write.ksys_=
write.do_syscall_64
>       1.15 =B1  4%      -0.2        0.93 =B1  4%  perf-profile.calltrace.=
cycles-pp.security_socket_recvmsg.sock_recvmsg.sock_read_iter.vfs_read.ksys=
_read
>       0.90            -0.2        0.69 =B1  3%  perf-profile.calltrace.cy=
cles-pp.get_obj_cgroup_from_current.kmem_cache_alloc_node.__alloc_skb.alloc=
_skb_with_frags.sock_alloc_send_pskb
>       1.23 =B1  3%      -0.2        1.07 =B1  3%  perf-profile.calltrace.=
cycles-pp.security_socket_sendmsg.sock_sendmsg.sock_write_iter.vfs_write.ks=
ys_write
>       1.05 =B1  2%      -0.2        0.88 =B1  2%  perf-profile.calltrace.=
cycles-pp.security_file_permission.vfs_read.ksys_read.do_syscall_64.entry_S=
YSCALL_64_after_hwframe
>       0.84 =B1  4%      -0.2        0.68 =B1  4%  perf-profile.calltrace.=
cycles-pp.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.sock_read_iter.vf=
s_read
>       0.88            -0.1        0.78 =B1  5%  perf-profile.calltrace.cy=
cles-pp.apparmor_file_permission.security_file_permission.vfs_read.ksys_rea=
d.do_syscall_64
>       0.94 =B1  3%      -0.1        0.88 =B1  4%  perf-profile.calltrace.=
cycles-pp.aa_sk_perm.security_socket_sendmsg.sock_sendmsg.sock_write_iter.v=
fs_write
>       0.62 =B1  2%      +0.3        0.90 =B1  2%  perf-profile.calltrace.=
cycles-pp.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg.sock_read=
_iter.vfs_read
>       0.00            +0.6        0.58 =B1  3%  perf-profile.calltrace.cy=
cles-pp._raw_spin_lock_irqsave.prepare_to_wait.unix_stream_data_wait.unix_s=
tream_read_generic.unix_stream_recvmsg
>       0.00            +0.6        0.61 =B1  6%  perf-profile.calltrace.cy=
cles-pp.update_load_avg.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.a=
utoremove_wake_function
>       0.00            +0.6        0.62 =B1  4%  perf-profile.calltrace.cy=
cles-pp.set_next_entity.pick_next_task_fair.__schedule.schedule.exit_to_use=
r_mode_loop
>       0.00            +0.7        0.67 =B1 11%  perf-profile.calltrace.cy=
cles-pp.update_load_avg.dequeue_entity.dequeue_task_fair.__schedule.schedule
>       0.00            +0.7        0.67 =B1  7%  perf-profile.calltrace.cy=
cles-pp.__switch_to_asm.__libc_write
>       0.00            +0.8        0.76 =B1  4%  perf-profile.calltrace.cy=
cles-pp.reweight_entity.dequeue_task_fair.__schedule.schedule.schedule_time=
out
>       0.00            +0.8        0.77 =B1  4%  perf-profile.calltrace.cy=
cles-pp.___perf_sw_event.prepare_task_switch.__schedule.schedule.schedule_t=
imeout
>       0.00            +0.8        0.77 =B1  8%  perf-profile.calltrace.cy=
cles-pp.put_prev_entity.pick_next_task_fair.__schedule.schedule.exit_to_use=
r_mode_loop
>       0.00            +0.8        0.81 =B1  5%  perf-profile.calltrace.cy=
cles-pp.prepare_task_switch.__schedule.schedule.exit_to_user_mode_loop.exit=
_to_user_mode_prepare
>       0.00            +0.8        0.81 =B1  5%  perf-profile.calltrace.cy=
cles-pp.check_preempt_wakeup.check_preempt_curr.ttwu_do_activate.try_to_wak=
e_up.autoremove_wake_function
>       0.00            +0.8        0.82 =B1  2%  perf-profile.calltrace.cy=
cles-pp.__switch_to_asm.__libc_read
>       0.00            +0.8        0.82 =B1  3%  perf-profile.calltrace.cy=
cles-pp.reweight_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.a=
utoremove_wake_function
>       0.00            +0.9        0.86 =B1  5%  perf-profile.calltrace.cy=
cles-pp.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_fun=
ction.__wake_up_common.__wake_up_common_lock
>       0.00            +0.9        0.87 =B1  8%  perf-profile.calltrace.cy=
cles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.ttwu_do_activate.t=
ry_to_wake_up
>      29.66            +0.9       30.58        perf-profile.calltrace.cycl=
es-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__l=
ibc_write
>       0.00            +1.0        0.95 =B1  3%  perf-profile.calltrace.cy=
cles-pp.set_next_entity.pick_next_task_fair.__schedule.schedule.schedule_ti=
meout
>       0.00            +1.0        0.98 =B1  4%  perf-profile.calltrace.cy=
cles-pp.check_preempt_curr.ttwu_do_activate.try_to_wake_up.autoremove_wake_=
function.__wake_up_common
>       0.00            +1.0        0.99 =B1  3%  perf-profile.calltrace.cy=
cles-pp.update_curr.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_t=
o_wake_up
>       0.00            +1.0        1.05 =B1  4%  perf-profile.calltrace.cy=
cles-pp.prepare_to_wait.unix_stream_data_wait.unix_stream_read_generic.unix=
_stream_recvmsg.sock_read_iter
>       0.00            +1.1        1.07 =B1 12%  perf-profile.calltrace.cy=
cles-pp.select_idle_sibling.select_task_rq_fair.select_task_rq.try_to_wake_=
up.autoremove_wake_function
>      27.81 =B1  2%      +1.2       28.98        perf-profile.calltrace.cy=
cles-pp.unix_stream_recvmsg.sock_read_iter.vfs_read.ksys_read.do_syscall_64
>      27.36 =B1  2%      +1.2       28.59        perf-profile.calltrace.cy=
cles-pp.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.vfs_rea=
d.ksys_read
>       0.00            +1.5        1.46 =B1  2%  perf-profile.calltrace.cy=
cles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.try_to_wake_up.auto=
remove_wake_function.__wake_up_common
>       0.00            +1.6        1.55 =B1  4%  perf-profile.calltrace.cy=
cles-pp.prepare_task_switch.__schedule.schedule.schedule_timeout.unix_strea=
m_data_wait
>       0.00            +1.6        1.60 =B1  4%  perf-profile.calltrace.cy=
cles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.e=
ntry_SYSCALL_64_after_hwframe.__libc_read
>      27.58            +1.6       29.19        perf-profile.calltrace.cycl=
es-pp.sock_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_a=
fter_hwframe
>       0.00            +1.6        1.63 =B1  5%  perf-profile.calltrace.cy=
cles-pp.update_curr.dequeue_entity.dequeue_task_fair.__schedule.schedule
>       0.00            +1.6        1.65 =B1  5%  perf-profile.calltrace.cy=
cles-pp.restore_fpregs_from_fpstate.switch_fpu_return.exit_to_user_mode_pre=
pare.syscall_exit_to_user_mode.do_syscall_64
>       0.00            +1.7        1.66 =B1  6%  perf-profile.calltrace.cy=
cles-pp.switch_mm_irqs_off.__schedule.schedule.exit_to_user_mode_loop.exit_=
to_user_mode_prepare
>       0.00            +1.8        1.80        perf-profile.calltrace.cycl=
es-pp._raw_spin_lock.try_to_wake_up.autoremove_wake_function.__wake_up_comm=
on.__wake_up_common_lock
>       0.00            +1.8        1.84 =B1  2%  perf-profile.calltrace.cy=
cles-pp.pick_next_task_fair.__schedule.schedule.schedule_timeout.unix_strea=
m_data_wait
>       0.00            +2.0        1.97 =B1  2%  perf-profile.calltrace.cy=
cles-pp.switch_mm_irqs_off.__schedule.schedule.schedule_timeout.unix_stream=
_data_wait
>      26.63 =B1  2%      +2.0       28.61        perf-profile.calltrace.cy=
cles-pp.sock_sendmsg.sock_write_iter.vfs_write.ksys_write.do_syscall_64
>       0.00            +2.0        2.01 =B1  6%  perf-profile.calltrace.cy=
cles-pp.pick_next_task_fair.__schedule.schedule.exit_to_user_mode_loop.exit=
_to_user_mode_prepare
>       0.00            +2.1        2.09 =B1  6%  perf-profile.calltrace.cy=
cles-pp.select_task_rq_fair.select_task_rq.try_to_wake_up.autoremove_wake_f=
unction.__wake_up_common
>       0.00            +2.1        2.11 =B1  5%  perf-profile.calltrace.cy=
cles-pp.switch_fpu_return.exit_to_user_mode_prepare.syscall_exit_to_user_mo=
de.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      25.21 =B1  2%      +2.2       27.43        perf-profile.calltrace.cy=
cles-pp.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.vfs_write.ksys_wri=
te
>       0.00            +2.4        2.43 =B1  5%  perf-profile.calltrace.cy=
cles-pp.select_task_rq.try_to_wake_up.autoremove_wake_function.__wake_up_co=
mmon.__wake_up_common_lock
>      48.00            +2.7       50.69        perf-profile.calltrace.cycl=
es-pp.__libc_write
>       0.00            +2.9        2.87 =B1  5%  perf-profile.calltrace.cy=
cles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.schedule_timeo=
ut
>       0.09 =B1223%      +3.4        3.47 =B1  3%  perf-profile.calltrace.=
cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.=
autoremove_wake_function
>      39.07            +4.8       43.84        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64_after_hwframe.__libc_write
>       0.66 =B1 18%      +5.0        5.62 =B1  4%  perf-profile.calltrace.=
cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_timeout.unix_strea=
m_data_wait
>       4.73            +5.1        9.88 =B1  3%  perf-profile.calltrace.cy=
cles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwfr=
ame.__libc_write
>       0.66 =B1 20%      +5.3        5.98 =B1  3%  perf-profile.calltrace.=
cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake=
_function.__wake_up_common
>      35.96            +5.7       41.68        perf-profile.calltrace.cycl=
es-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
>       0.00            +6.0        6.02 =B1  6%  perf-profile.calltrace.cy=
cles-pp.__schedule.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepar=
e.syscall_exit_to_user_mode
>       0.00            +6.2        6.18 =B1  6%  perf-profile.calltrace.cy=
cles-pp.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_e=
xit_to_user_mode.do_syscall_64
>       0.00            +6.4        6.36 =B1  6%  perf-profile.calltrace.cy=
cles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_us=
er_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.78 =B1 19%      +6.4        7.15 =B1  3%  perf-profile.calltrace.=
cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_u=
p_common.__wake_up_common_lock
>       0.18 =B1141%      +7.0        7.18 =B1  6%  perf-profile.calltrace.=
cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64=
.entry_SYSCALL_64_after_hwframe.__libc_write
>       1.89 =B1 15%     +12.1       13.96 =B1  3%  perf-profile.calltrace.=
cycles-pp.__schedule.schedule.schedule_timeout.unix_stream_data_wait.unix_s=
tream_read_generic
>       1.92 =B1 15%     +12.3       14.23 =B1  3%  perf-profile.calltrace.=
cycles-pp.schedule.schedule_timeout.unix_stream_data_wait.unix_stream_read_=
generic.unix_stream_recvmsg
>       1.66 =B1 19%     +12.4       14.06 =B1  2%  perf-profile.calltrace.=
cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_u=
p_common_lock.sock_def_readable
>       1.96 =B1 15%     +12.5       14.48 =B1  3%  perf-profile.calltrace.=
cycles-pp.schedule_timeout.unix_stream_data_wait.unix_stream_read_generic.u=
nix_stream_recvmsg.sock_read_iter
>       1.69 =B1 19%     +12.7       14.38 =B1  2%  perf-profile.calltrace.=
cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.s=
ock_def_readable.unix_stream_sendmsg
>       1.75 =B1 19%     +13.0       14.75 =B1  2%  perf-profile.calltrace.=
cycles-pp.__wake_up_common.__wake_up_common_lock.sock_def_readable.unix_str=
eam_sendmsg.sock_sendmsg
>       2.53 =B1 10%     +13.4       15.90 =B1  2%  perf-profile.calltrace.=
cycles-pp.sock_def_readable.unix_stream_sendmsg.sock_sendmsg.sock_write_ite=
r.vfs_write
>       1.96 =B1 16%     +13.5       15.42 =B1  2%  perf-profile.calltrace.=
cycles-pp.__wake_up_common_lock.sock_def_readable.unix_stream_sendmsg.sock_=
sendmsg.sock_write_iter
>       2.28 =B1 15%     +14.6       16.86 =B1  3%  perf-profile.calltrace.=
cycles-pp.unix_stream_data_wait.unix_stream_read_generic.unix_stream_recvms=
g.sock_read_iter.vfs_read
>      15.31 =B1  4%      -8.6        6.67 =B1  5%  perf-profile.children.c=
ycles-pp.sock_alloc_send_pskb
>      13.85 =B1  6%      -7.9        5.98 =B1  5%  perf-profile.children.c=
ycles-pp.alloc_skb_with_frags
>      13.70 =B1  6%      -7.8        5.89 =B1  6%  perf-profile.children.c=
ycles-pp.__alloc_skb
>       9.01 =B1  2%      -5.5        3.48 =B1  4%  perf-profile.children.c=
ycles-pp.consume_skb
>       6.86 =B1 26%      -4.7        2.15 =B1  2%  perf-profile.children.c=
ycles-pp._raw_spin_lock_irqsave
>      11.27 =B1  3%      -4.6        6.67 =B1  3%  perf-profile.children.c=
ycles-pp.syscall_return_via_sysret
>       6.46 =B1  4%      -4.3        2.15 =B1  6%  perf-profile.children.c=
ycles-pp.skb_release_data
>       4.18 =B1 25%      -4.0        0.15 =B1 69%  perf-profile.children.c=
ycles-pp.___slab_alloc
>       5.76 =B1 32%      -3.9        1.91 =B1  3%  perf-profile.children.c=
ycles-pp.native_queued_spin_lock_slowpath
>       5.98 =B1  8%      -3.5        2.52 =B1  5%  perf-profile.children.c=
ycles-pp.kmem_cache_alloc_node
>       5.84 =B1  6%      -3.3        2.50 =B1  6%  perf-profile.children.c=
ycles-pp.kmalloc_reserve
>       3.33 =B1 30%      -3.3        0.05 =B1 88%  perf-profile.children.c=
ycles-pp.get_partial_node
>       5.63 =B1  7%      -3.3        2.37 =B1  6%  perf-profile.children.c=
ycles-pp.__kmalloc_node_track_caller
>       5.20 =B1  7%      -3.1        2.12 =B1  6%  perf-profile.children.c=
ycles-pp.__kmem_cache_alloc_node
>       6.23 =B1  2%      -2.9        3.33 =B1  3%  perf-profile.children.c=
ycles-pp.unix_stream_read_actor
>       6.18 =B1  2%      -2.9        3.31 =B1  3%  perf-profile.children.c=
ycles-pp.skb_copy_datagram_iter
>       6.11 =B1  2%      -2.9        3.25 =B1  3%  perf-profile.children.c=
ycles-pp.__skb_datagram_iter
>      51.39            -2.5       48.85        perf-profile.children.cycle=
s-pp.__libc_read
>       3.14 =B1  3%      -2.5        0.61 =B1 13%  perf-profile.children.c=
ycles-pp.__slab_free
>       5.34 =B1  3%      -2.1        3.23 =B1  3%  perf-profile.children.c=
ycles-pp.__entry_text_start
>       3.57 =B1  2%      -1.9        1.66 =B1  6%  perf-profile.children.c=
ycles-pp.copy_user_enhanced_fast_string
>       3.16 =B1  2%      -1.7        1.43 =B1  4%  perf-profile.children.c=
ycles-pp._copy_to_iter
>       2.74 =B1  2%      -1.6        1.16 =B1  4%  perf-profile.children.c=
ycles-pp.copyout
>       4.16 =B1  2%      -1.5        2.62 =B1  3%  perf-profile.children.c=
ycles-pp.__check_object_size
>       2.73 =B1  3%      -1.4        1.35 =B1  6%  perf-profile.children.c=
ycles-pp.kmem_cache_free
>       2.82 =B1  2%      -1.2        1.63 =B1  3%  perf-profile.children.c=
ycles-pp.check_heap_object
>       2.27 =B1  4%      -1.1        1.13 =B1  2%  perf-profile.children.c=
ycles-pp.skb_release_head_state
>       2.85 =B1  3%      -1.1        1.72 =B1  2%  perf-profile.children.c=
ycles-pp.simple_copy_to_iter
>       2.22 =B1  4%      -1.1        1.10        perf-profile.children.cyc=
les-pp.unix_destruct_scm
>       3.00 =B1  2%      -1.1        1.91 =B1  5%  perf-profile.children.c=
ycles-pp.skb_copy_datagram_from_iter
>       2.00 =B1  4%      -1.1        0.92 =B1  2%  perf-profile.children.c=
ycles-pp.sock_wfree
>       2.16 =B1  3%      -0.7        1.43 =B1  7%  perf-profile.children.c=
ycles-pp.memcg_slab_post_alloc_hook
>       1.45 =B1  3%      -0.7        0.73 =B1  7%  perf-profile.children.c=
ycles-pp.entry_SYSCALL_64_safe_stack
>       2.21 =B1  2%      -0.7        1.52 =B1  3%  perf-profile.children.c=
ycles-pp.__kmem_cache_free
>       1.49 =B1  3%      -0.6        0.89 =B1  8%  perf-profile.children.c=
ycles-pp._copy_from_iter
>       1.40 =B1  3%      -0.6        0.85 =B1 13%  perf-profile.children.c=
ycles-pp.mod_objcg_state
>       0.74            -0.5        0.24 =B1 16%  perf-profile.children.cyc=
les-pp.__build_skb_around
>       1.48            -0.5        1.01 =B1  2%  perf-profile.children.cyc=
les-pp.get_obj_cgroup_from_current
>       2.05 =B1  2%      -0.5        1.59 =B1  2%  perf-profile.children.c=
ycles-pp.security_file_permission
>       0.98 =B1  2%      -0.4        0.59 =B1 10%  perf-profile.children.c=
ycles-pp.copyin
>       1.08 =B1  3%      -0.4        0.72 =B1  3%  perf-profile.children.c=
ycles-pp.__might_resched
>       1.75            -0.3        1.42 =B1  4%  perf-profile.children.cyc=
les-pp.apparmor_file_permission
>       1.32 =B1  4%      -0.3        1.00 =B1  3%  perf-profile.children.c=
ycles-pp.sock_recvmsg
>       0.54 =B1  4%      -0.3        0.25 =B1  6%  perf-profile.children.c=
ycles-pp.skb_unlink
>       0.54 =B1  6%      -0.3        0.26 =B1  3%  perf-profile.children.c=
ycles-pp.unix_write_space
>       0.66 =B1  3%      -0.3        0.39 =B1  4%  perf-profile.children.c=
ycles-pp.obj_cgroup_charge
>       0.68 =B1  2%      -0.3        0.41 =B1  4%  perf-profile.children.c=
ycles-pp.entry_SYSRETQ_unsafe_stack
>       0.86 =B1  4%      -0.3        0.59 =B1  3%  perf-profile.children.c=
ycles-pp.__check_heap_object
>       0.75 =B1  9%      -0.3        0.48 =B1  2%  perf-profile.children.c=
ycles-pp.skb_set_owner_w
>       1.84 =B1  3%      -0.3        1.58 =B1  4%  perf-profile.children.c=
ycles-pp.aa_sk_perm
>       0.68 =B1 11%      -0.2        0.44 =B1  3%  perf-profile.children.c=
ycles-pp.skb_queue_tail
>       1.22 =B1  4%      -0.2        0.99 =B1  5%  perf-profile.children.c=
ycles-pp.__fdget_pos
>       0.70 =B1  2%      -0.2        0.48 =B1  5%  perf-profile.children.c=
ycles-pp.__get_obj_cgroup_from_memcg
>       1.16 =B1  4%      -0.2        0.93 =B1  3%  perf-profile.children.c=
ycles-pp.security_socket_recvmsg
>       0.48 =B1  3%      -0.2        0.29 =B1  4%  perf-profile.children.c=
ycles-pp.__might_fault
>       0.24 =B1  7%      -0.2        0.05 =B1 56%  perf-profile.children.c=
ycles-pp.fsnotify_perm
>       1.12 =B1  4%      -0.2        0.93 =B1  6%  perf-profile.children.c=
ycles-pp.__fget_light
>       1.24 =B1  3%      -0.2        1.07 =B1  3%  perf-profile.children.c=
ycles-pp.security_socket_sendmsg
>       0.61 =B1  3%      -0.2        0.45 =B1  2%  perf-profile.children.c=
ycles-pp.__might_sleep
>       0.33 =B1  5%      -0.2        0.17 =B1  6%  perf-profile.children.c=
ycles-pp.refill_obj_stock
>       0.40 =B1  2%      -0.1        0.25 =B1  4%  perf-profile.children.c=
ycles-pp.kmalloc_slab
>       0.57 =B1  2%      -0.1        0.45        perf-profile.children.cyc=
les-pp.asm_sysvec_apic_timer_interrupt
>       0.54 =B1  3%      -0.1        0.42 =B1  2%  perf-profile.children.c=
ycles-pp.wait_for_unix_gc
>       0.42 =B1  2%      -0.1        0.30 =B1  3%  perf-profile.children.c=
ycles-pp.is_vmalloc_addr
>       1.00 =B1  2%      -0.1        0.87 =B1  5%  perf-profile.children.c=
ycles-pp.__virt_addr_valid
>       0.52 =B1  2%      -0.1        0.41        perf-profile.children.cyc=
les-pp.sysvec_apic_timer_interrupt
>       0.33 =B1  3%      -0.1        0.21 =B1  3%  perf-profile.children.c=
ycles-pp.tick_sched_handle
>       0.36 =B1  2%      -0.1        0.25 =B1  4%  perf-profile.children.c=
ycles-pp.tick_sched_timer
>       0.47 =B1  2%      -0.1        0.36 =B1  2%  perf-profile.children.c=
ycles-pp.hrtimer_interrupt
>       0.48 =B1  2%      -0.1        0.36 =B1  2%  perf-profile.children.c=
ycles-pp.__sysvec_apic_timer_interrupt
>       0.32 =B1  3%      -0.1        0.21 =B1  5%  perf-profile.children.c=
ycles-pp.update_process_times
>       0.42 =B1  3%      -0.1        0.31 =B1  2%  perf-profile.children.c=
ycles-pp.__hrtimer_run_queues
>       0.26 =B1  6%      -0.1        0.16 =B1  4%  perf-profile.children.c=
ycles-pp.kmalloc_size_roundup
>       0.20 =B1  4%      -0.1        0.10 =B1  9%  perf-profile.children.c=
ycles-pp.task_tick_fair
>       0.24 =B1  3%      -0.1        0.15 =B1  4%  perf-profile.children.c=
ycles-pp.scheduler_tick
>       0.30 =B1  5%      -0.1        0.21 =B1  8%  perf-profile.children.c=
ycles-pp.obj_cgroup_uncharge_pages
>       0.20 =B1  2%      -0.1        0.11 =B1  6%  perf-profile.children.c=
ycles-pp.should_failslab
>       0.51 =B1  2%      -0.1        0.43 =B1  6%  perf-profile.children.c=
ycles-pp.syscall_enter_from_user_mode
>       0.15 =B1  8%      -0.1        0.07 =B1 13%  perf-profile.children.c=
ycles-pp.syscall_exit_to_user_mode_prepare
>       0.19 =B1  4%      -0.1        0.12 =B1  5%  perf-profile.children.c=
ycles-pp.apparmor_socket_sendmsg
>       0.20 =B1  4%      -0.1        0.13 =B1  5%  perf-profile.children.c=
ycles-pp.aa_file_perm
>       0.18 =B1  5%      -0.1        0.12 =B1  5%  perf-profile.children.c=
ycles-pp.apparmor_socket_recvmsg
>       0.14 =B1 13%      -0.1        0.08 =B1 55%  perf-profile.children.c=
ycles-pp.__mod_memcg_lruvec_state
>       0.24 =B1  4%      -0.1        0.18 =B1  2%  perf-profile.children.c=
ycles-pp.rcu_all_qs
>       0.18 =B1 10%      -0.1        0.12 =B1 11%  perf-profile.children.c=
ycles-pp.memcg_account_kmem
>       0.37 =B1  3%      -0.1        0.31 =B1  3%  perf-profile.children.c=
ycles-pp.security_socket_getpeersec_dgram
>       0.08            -0.0        0.06 =B1  8%  perf-profile.children.cyc=
les-pp.put_pid
>       0.18 =B1  3%      -0.0        0.16 =B1  4%  perf-profile.children.c=
ycles-pp.apparmor_socket_getpeersec_dgram
>       0.21 =B1  3%      +0.0        0.23 =B1  2%  perf-profile.children.c=
ycles-pp.__get_task_ioprio
>       0.00            +0.1        0.05        perf-profile.children.cycle=
s-pp.perf_exclude_event
>       0.00            +0.1        0.06 =B1  7%  perf-profile.children.cyc=
les-pp.invalidate_user_asid
>       0.00            +0.1        0.07 =B1  6%  perf-profile.children.cyc=
les-pp.__bitmap_and
>       0.05            +0.1        0.13 =B1  8%  perf-profile.children.cyc=
les-pp.irqentry_exit_to_user_mode
>       0.00            +0.1        0.08 =B1  7%  perf-profile.children.cyc=
les-pp.schedule_debug
>       0.00            +0.1        0.08 =B1 13%  perf-profile.children.cyc=
les-pp.read@plt
>       0.00            +0.1        0.08 =B1  5%  perf-profile.children.cyc=
les-pp.sysvec_reschedule_ipi
>       0.00            +0.1        0.10 =B1  4%  perf-profile.children.cyc=
les-pp.tracing_gen_ctx_irq_test
>       0.00            +0.1        0.10 =B1  4%  perf-profile.children.cyc=
les-pp.place_entity
>       0.00            +0.1        0.12 =B1 10%  perf-profile.children.cyc=
les-pp.native_irq_return_iret
>       0.07 =B1 14%      +0.1        0.19 =B1  3%  perf-profile.children.c=
ycles-pp.__list_add_valid
>       0.00            +0.1        0.13 =B1  6%  perf-profile.children.cyc=
les-pp.perf_trace_buf_alloc
>       0.00            +0.1        0.13 =B1 34%  perf-profile.children.cyc=
les-pp._find_next_and_bit
>       0.00            +0.1        0.14 =B1  5%  perf-profile.children.cyc=
les-pp.switch_ldt
>       0.00            +0.1        0.15 =B1  5%  perf-profile.children.cyc=
les-pp.check_cfs_rq_runtime
>       0.00            +0.1        0.15 =B1 30%  perf-profile.children.cyc=
les-pp.migrate_task_rq_fair
>       0.00            +0.2        0.15 =B1  5%  perf-profile.children.cyc=
les-pp.__rdgsbase_inactive
>       0.00            +0.2        0.16 =B1  3%  perf-profile.children.cyc=
les-pp.save_fpregs_to_fpstate
>       0.00            +0.2        0.16 =B1  6%  perf-profile.children.cyc=
les-pp.ttwu_queue_wakelist
>       0.00            +0.2        0.17        perf-profile.children.cycle=
s-pp.perf_trace_buf_update
>       0.00            +0.2        0.18 =B1  2%  perf-profile.children.cyc=
les-pp.rb_insert_color
>       0.00            +0.2        0.18 =B1  4%  perf-profile.children.cyc=
les-pp.rb_next
>       0.00            +0.2        0.18 =B1 21%  perf-profile.children.cyc=
les-pp.__cgroup_account_cputime
>       0.01 =B1223%      +0.2        0.21 =B1 28%  perf-profile.children.c=
ycles-pp.perf_trace_sched_switch
>       0.00            +0.2        0.20 =B1  3%  perf-profile.children.cyc=
les-pp.select_idle_cpu
>       0.00            +0.2        0.20 =B1  3%  perf-profile.children.cyc=
les-pp.rcu_note_context_switch
>       0.00            +0.2        0.21 =B1 26%  perf-profile.children.cyc=
les-pp.set_task_cpu
>       0.00            +0.2        0.22 =B1  8%  perf-profile.children.cyc=
les-pp.resched_curr
>       0.08 =B1  5%      +0.2        0.31 =B1 11%  perf-profile.children.c=
ycles-pp.task_h_load
>       0.00            +0.2        0.24 =B1  3%  perf-profile.children.cyc=
les-pp.finish_wait
>       0.04 =B1 44%      +0.3        0.29 =B1  5%  perf-profile.children.c=
ycles-pp.rb_erase
>       0.19 =B1  6%      +0.3        0.46        perf-profile.children.cyc=
les-pp._raw_spin_unlock_irqrestore
>       0.20 =B1  6%      +0.3        0.47 =B1  3%  perf-profile.children.c=
ycles-pp.__list_del_entry_valid
>       0.00            +0.3        0.28 =B1  3%  perf-profile.children.cyc=
les-pp.__wrgsbase_inactive
>       0.02 =B1141%      +0.3        0.30 =B1  2%  perf-profile.children.c=
ycles-pp.native_sched_clock
>       0.06 =B1 13%      +0.3        0.34 =B1  2%  perf-profile.children.c=
ycles-pp.sched_clock_cpu
>       0.64 =B1  2%      +0.3        0.93        perf-profile.children.cyc=
les-pp.mutex_lock
>       0.00            +0.3        0.30 =B1  5%  perf-profile.children.cyc=
les-pp.cr4_update_irqsoff
>       0.00            +0.3        0.30 =B1  4%  perf-profile.children.cyc=
les-pp.clear_buddies
>       0.07 =B1 55%      +0.3        0.37 =B1  5%  perf-profile.children.c=
ycles-pp.perf_trace_sched_stat_runtime
>       0.10 =B1 66%      +0.3        0.42 =B1  5%  perf-profile.children.c=
ycles-pp.perf_tp_event
>       0.02 =B1142%      +0.3        0.36 =B1  6%  perf-profile.children.c=
ycles-pp.cpuacct_charge
>       0.12 =B1  9%      +0.4        0.47 =B1 11%  perf-profile.children.c=
ycles-pp.wake_affine
>       0.00            +0.4        0.36 =B1 13%  perf-profile.children.cyc=
les-pp.available_idle_cpu
>       0.05 =B1 48%      +0.4        0.42 =B1  6%  perf-profile.children.c=
ycles-pp.finish_task_switch
>       0.12 =B1  4%      +0.4        0.49 =B1  4%  perf-profile.children.c=
ycles-pp.asm_sysvec_reschedule_ipi
>       0.07 =B1 17%      +0.4        0.48        perf-profile.children.cyc=
les-pp.__calc_delta
>       0.03 =B1100%      +0.5        0.49 =B1  4%  perf-profile.children.c=
ycles-pp.pick_next_entity
>       0.00            +0.5        0.48 =B1  8%  perf-profile.children.cyc=
les-pp.set_next_buddy
>       0.08 =B1 14%      +0.6        0.66 =B1  4%  perf-profile.children.c=
ycles-pp.update_min_vruntime
>       0.07 =B1 17%      +0.6        0.68 =B1  2%  perf-profile.children.c=
ycles-pp.os_xsave
>       0.29 =B1  7%      +0.7        0.99 =B1  3%  perf-profile.children.c=
ycles-pp.update_cfs_group
>       0.17 =B1 17%      +0.7        0.87 =B1  4%  perf-profile.children.c=
ycles-pp.perf_trace_sched_wakeup_template
>       0.14 =B1  7%      +0.7        0.87 =B1  3%  perf-profile.children.c=
ycles-pp.__update_load_avg_se
>       0.14 =B1 16%      +0.8        0.90 =B1  2%  perf-profile.children.c=
ycles-pp.update_rq_clock
>       0.08 =B1 17%      +0.8        0.84 =B1  5%  perf-profile.children.c=
ycles-pp.check_preempt_wakeup
>       0.12 =B1 14%      +0.8        0.95 =B1  3%  perf-profile.children.c=
ycles-pp.__update_load_avg_cfs_rq
>       0.22 =B1  5%      +0.8        1.07 =B1  3%  perf-profile.children.c=
ycles-pp.prepare_to_wait
>       0.10 =B1 18%      +0.9        0.98 =B1  3%  perf-profile.children.c=
ycles-pp.check_preempt_curr
>      29.72            +0.9       30.61        perf-profile.children.cycle=
s-pp.vfs_write
>       0.14 =B1 11%      +0.9        1.03 =B1  4%  perf-profile.children.c=
ycles-pp.__switch_to
>       0.07 =B1 20%      +0.9        0.99 =B1  6%  perf-profile.children.c=
ycles-pp.put_prev_entity
>       0.12 =B1 16%      +1.0        1.13 =B1  5%  perf-profile.children.c=
ycles-pp.___perf_sw_event
>       0.07 =B1 17%      +1.0        1.10 =B1 13%  perf-profile.children.c=
ycles-pp.select_idle_sibling
>      27.82 =B1  2%      +1.2       28.99        perf-profile.children.cyc=
les-pp.unix_stream_recvmsg
>      27.41 =B1  2%      +1.2       28.63        perf-profile.children.cyc=
les-pp.unix_stream_read_generic
>       0.20 =B1 15%      +1.4        1.59 =B1  3%  perf-profile.children.c=
ycles-pp.reweight_entity
>       0.21 =B1 13%      +1.4        1.60 =B1  4%  perf-profile.children.c=
ycles-pp.__switch_to_asm
>       0.23 =B1 10%      +1.4        1.65 =B1  5%  perf-profile.children.c=
ycles-pp.restore_fpregs_from_fpstate
>       0.20 =B1 13%      +1.5        1.69 =B1  3%  perf-profile.children.c=
ycles-pp.set_next_entity
>      27.59            +1.6       29.19        perf-profile.children.cycle=
s-pp.sock_write_iter
>       0.28 =B1 10%      +1.8        2.12 =B1  5%  perf-profile.children.c=
ycles-pp.switch_fpu_return
>       0.26 =B1 11%      +1.8        2.10 =B1  6%  perf-profile.children.c=
ycles-pp.select_task_rq_fair
>      26.66 =B1  2%      +2.0       28.63        perf-profile.children.cyc=
les-pp.sock_sendmsg
>       0.31 =B1 12%      +2.1        2.44 =B1  5%  perf-profile.children.c=
ycles-pp.select_task_rq
>       0.30 =B1 14%      +2.2        2.46 =B1  4%  perf-profile.children.c=
ycles-pp.prepare_task_switch
>      25.27 =B1  2%      +2.2       27.47        perf-profile.children.cyc=
les-pp.unix_stream_sendmsg
>       2.10            +2.3        4.38 =B1  2%  perf-profile.children.cyc=
les-pp._raw_spin_lock
>       0.40 =B1 14%      +2.5        2.92 =B1  5%  perf-profile.children.c=
ycles-pp.dequeue_entity
>      48.40            +2.6       51.02        perf-profile.children.cycle=
s-pp.__libc_write
>       0.46 =B1 15%      +3.1        3.51 =B1  3%  perf-profile.children.c=
ycles-pp.enqueue_entity
>       0.49 =B1 10%      +3.2        3.64 =B1  7%  perf-profile.children.c=
ycles-pp.update_load_avg
>       0.53 =B1 20%      +3.4        3.91 =B1  3%  perf-profile.children.c=
ycles-pp.update_curr
>      80.81            +3.4       84.24        perf-profile.children.cycle=
s-pp.entry_SYSCALL_64_after_hwframe
>       0.50 =B1 12%      +3.5        4.00 =B1  4%  perf-profile.children.c=
ycles-pp.switch_mm_irqs_off
>       0.55 =B1  9%      +3.8        4.38 =B1  4%  perf-profile.children.c=
ycles-pp.pick_next_task_fair
>       9.60            +4.6       14.15 =B1  2%  perf-profile.children.cyc=
les-pp.syscall_exit_to_user_mode
>       0.78 =B1 13%      +4.9        5.65 =B1  4%  perf-profile.children.c=
ycles-pp.dequeue_task_fair
>       0.78 =B1 15%      +5.2        5.99 =B1  3%  perf-profile.children.c=
ycles-pp.enqueue_task_fair
>      74.30            +5.6       79.86        perf-profile.children.cycle=
s-pp.do_syscall_64
>       0.90 =B1 15%      +6.3        7.16 =B1  3%  perf-profile.children.c=
ycles-pp.ttwu_do_activate
>       0.33 =B1 31%      +6.3        6.61 =B1  6%  perf-profile.children.c=
ycles-pp.exit_to_user_mode_loop
>       0.82 =B1 15%      +8.1        8.92 =B1  5%  perf-profile.children.c=
ycles-pp.exit_to_user_mode_prepare
>       1.90 =B1 16%     +12.2       14.10 =B1  2%  perf-profile.children.c=
ycles-pp.try_to_wake_up
>       2.36 =B1 11%     +12.2       14.60 =B1  3%  perf-profile.children.c=
ycles-pp.schedule_timeout
>       1.95 =B1 15%     +12.5       14.41 =B1  2%  perf-profile.children.c=
ycles-pp.autoremove_wake_function
>       2.01 =B1 15%     +12.8       14.76 =B1  2%  perf-profile.children.c=
ycles-pp.__wake_up_common
>       2.23 =B1 13%     +13.2       15.45 =B1  2%  perf-profile.children.c=
ycles-pp.__wake_up_common_lock
>       2.53 =B1 10%     +13.4       15.90 =B1  2%  perf-profile.children.c=
ycles-pp.sock_def_readable
>       2.29 =B1 15%     +14.6       16.93 =B1  3%  perf-profile.children.c=
ycles-pp.unix_stream_data_wait
>       2.61 =B1 13%     +18.0       20.65 =B1  4%  perf-profile.children.c=
ycles-pp.schedule
>       2.66 =B1 13%     +18.1       20.77 =B1  4%  perf-profile.children.c=
ycles-pp.__schedule
>      11.25 =B1  3%      -4.6        6.67 =B1  3%  perf-profile.self.cycle=
s-pp.syscall_return_via_sysret
>       5.76 =B1 32%      -3.9        1.90 =B1  3%  perf-profile.self.cycle=
s-pp.native_queued_spin_lock_slowpath
>       8.69 =B1  3%      -3.4        5.27 =B1  3%  perf-profile.self.cycle=
s-pp.syscall_exit_to_user_mode
>       3.11 =B1  3%      -2.5        0.60 =B1 13%  perf-profile.self.cycle=
s-pp.__slab_free
>       6.65 =B1  2%      -2.2        4.47 =B1  2%  perf-profile.self.cycle=
s-pp.entry_SYSCALL_64_after_hwframe
>       4.78 =B1  3%      -1.9        2.88 =B1  3%  perf-profile.self.cycle=
s-pp.__entry_text_start
>       3.52 =B1  2%      -1.9        1.64 =B1  6%  perf-profile.self.cycle=
s-pp.copy_user_enhanced_fast_string
>       2.06 =B1  3%      -1.1        0.96 =B1  5%  perf-profile.self.cycle=
s-pp.kmem_cache_free
>       1.42 =B1  3%      -1.0        0.46 =B1 10%  perf-profile.self.cycle=
s-pp.check_heap_object
>       1.43 =B1  4%      -0.8        0.64        perf-profile.self.cycles-=
pp.sock_wfree
>       0.99 =B1  3%      -0.8        0.21 =B1 12%  perf-profile.self.cycle=
s-pp.skb_release_data
>       0.84 =B1  8%      -0.7        0.10 =B1 64%  perf-profile.self.cycle=
s-pp.___slab_alloc
>       1.97 =B1  2%      -0.6        1.32        perf-profile.self.cycles-=
pp.unix_stream_read_generic
>       1.60 =B1  3%      -0.5        1.11 =B1  4%  perf-profile.self.cycle=
s-pp.memcg_slab_post_alloc_hook
>       1.24 =B1  2%      -0.5        0.75 =B1 11%  perf-profile.self.cycle=
s-pp.mod_objcg_state
>       0.71            -0.5        0.23 =B1 15%  perf-profile.self.cycles-=
pp.__build_skb_around
>       0.95 =B1  3%      -0.5        0.50 =B1  6%  perf-profile.self.cycle=
s-pp.__alloc_skb
>       0.97 =B1  4%      -0.4        0.55 =B1  5%  perf-profile.self.cycle=
s-pp.kmem_cache_alloc_node
>       0.99 =B1  3%      -0.4        0.59 =B1  4%  perf-profile.self.cycle=
s-pp.vfs_write
>       1.38 =B1  2%      -0.4        0.99        perf-profile.self.cycles-=
pp.__kmem_cache_free
>       0.86 =B1  2%      -0.4        0.50 =B1  3%  perf-profile.self.cycle=
s-pp.__kmem_cache_alloc_node
>       0.92 =B1  4%      -0.4        0.56 =B1  4%  perf-profile.self.cycle=
s-pp.sock_write_iter
>       1.06 =B1  3%      -0.4        0.70 =B1  3%  perf-profile.self.cycle=
s-pp.__might_resched
>       0.73 =B1  4%      -0.3        0.44 =B1  4%  perf-profile.self.cycle=
s-pp.__cond_resched
>       0.85 =B1  3%      -0.3        0.59 =B1  4%  perf-profile.self.cycle=
s-pp.__check_heap_object
>       1.46 =B1  7%      -0.3        1.20 =B1  2%  perf-profile.self.cycle=
s-pp.unix_stream_sendmsg
>       0.73 =B1  9%      -0.3        0.47 =B1  2%  perf-profile.self.cycle=
s-pp.skb_set_owner_w
>       1.54            -0.3        1.28 =B1  4%  perf-profile.self.cycles-=
pp.apparmor_file_permission
>       0.74 =B1  3%      -0.2        0.50 =B1  2%  perf-profile.self.cycle=
s-pp.get_obj_cgroup_from_current
>       1.15 =B1  3%      -0.2        0.91 =B1  8%  perf-profile.self.cycle=
s-pp.aa_sk_perm
>       0.60            -0.2        0.36 =B1  4%  perf-profile.self.cycles-=
pp.entry_SYSRETQ_unsafe_stack
>       0.65 =B1  4%      -0.2        0.45 =B1  6%  perf-profile.self.cycle=
s-pp.__get_obj_cgroup_from_memcg
>       0.24 =B1  6%      -0.2        0.05 =B1 56%  perf-profile.self.cycle=
s-pp.fsnotify_perm
>       0.76 =B1  3%      -0.2        0.58 =B1  2%  perf-profile.self.cycle=
s-pp.sock_read_iter
>       1.10 =B1  4%      -0.2        0.92 =B1  6%  perf-profile.self.cycle=
s-pp.__fget_light
>       0.42 =B1  3%      -0.2        0.25 =B1  4%  perf-profile.self.cycle=
s-pp.obj_cgroup_charge
>       0.32 =B1  4%      -0.2        0.17 =B1  6%  perf-profile.self.cycle=
s-pp.refill_obj_stock
>       0.29            -0.2        0.14 =B1  8%  perf-profile.self.cycles-=
pp.__kmalloc_node_track_caller
>       0.54 =B1  3%      -0.1        0.40 =B1  2%  perf-profile.self.cycle=
s-pp.__might_sleep
>       0.30 =B1  7%      -0.1        0.16 =B1 22%  perf-profile.self.cycle=
s-pp.security_file_permission
>       0.34 =B1  3%      -0.1        0.21 =B1  6%  perf-profile.self.cycle=
s-pp.entry_SYSCALL_64_safe_stack
>       0.41 =B1  3%      -0.1        0.29 =B1  3%  perf-profile.self.cycle=
s-pp.is_vmalloc_addr
>       0.27 =B1  3%      -0.1        0.16 =B1  6%  perf-profile.self.cycle=
s-pp._copy_from_iter
>       0.24 =B1  3%      -0.1        0.12 =B1  3%  perf-profile.self.cycle=
s-pp.ksys_write
>       0.95 =B1  2%      -0.1        0.84 =B1  5%  perf-profile.self.cycle=
s-pp.__virt_addr_valid
>       0.56 =B1 11%      -0.1        0.46 =B1  4%  perf-profile.self.cycle=
s-pp.sock_def_readable
>       0.16 =B1  7%      -0.1        0.06 =B1 18%  perf-profile.self.cycle=
s-pp.sock_recvmsg
>       0.22 =B1  5%      -0.1        0.14 =B1  2%  perf-profile.self.cycle=
s-pp.ksys_read
>       0.27 =B1  4%      -0.1        0.19 =B1  5%  perf-profile.self.cycle=
s-pp.kmalloc_slab
>       0.28 =B1  2%      -0.1        0.20 =B1  2%  perf-profile.self.cycle=
s-pp.consume_skb
>       0.35 =B1  2%      -0.1        0.28 =B1  3%  perf-profile.self.cycle=
s-pp.__check_object_size
>       0.13 =B1  8%      -0.1        0.06 =B1 18%  perf-profile.self.cycle=
s-pp.syscall_exit_to_user_mode_prepare
>       0.20 =B1  5%      -0.1        0.12 =B1  6%  perf-profile.self.cycle=
s-pp.kmalloc_reserve
>       0.26 =B1  5%      -0.1        0.19 =B1  4%  perf-profile.self.cycle=
s-pp.sock_alloc_send_pskb
>       0.42 =B1  2%      -0.1        0.35 =B1  7%  perf-profile.self.cycle=
s-pp.syscall_enter_from_user_mode
>       0.19 =B1  5%      -0.1        0.12 =B1  6%  perf-profile.self.cycle=
s-pp.aa_file_perm
>       0.16 =B1  4%      -0.1        0.10 =B1  4%  perf-profile.self.cycle=
s-pp.skb_copy_datagram_from_iter
>       0.18 =B1  4%      -0.1        0.12 =B1  6%  perf-profile.self.cycle=
s-pp.apparmor_socket_sendmsg
>       0.18 =B1  5%      -0.1        0.12 =B1  4%  perf-profile.self.cycle=
s-pp.apparmor_socket_recvmsg
>       0.15 =B1  5%      -0.1        0.10 =B1  5%  perf-profile.self.cycle=
s-pp.alloc_skb_with_frags
>       0.64 =B1  3%      -0.1        0.59        perf-profile.self.cycles-=
pp.__libc_write
>       0.20 =B1  4%      -0.1        0.15 =B1  3%  perf-profile.self.cycle=
s-pp._copy_to_iter
>       0.15 =B1  5%      -0.1        0.10 =B1 11%  perf-profile.self.cycle=
s-pp.sock_sendmsg
>       0.08 =B1  4%      -0.1        0.03 =B1 81%  perf-profile.self.cycle=
s-pp.copyout
>       0.11 =B1  6%      -0.0        0.06 =B1  7%  perf-profile.self.cycle=
s-pp.__fdget_pos
>       0.12 =B1  5%      -0.0        0.07 =B1 10%  perf-profile.self.cycle=
s-pp.kmalloc_size_roundup
>       0.34 =B1  3%      -0.0        0.29        perf-profile.self.cycles-=
pp.do_syscall_64
>       0.20 =B1  4%      -0.0        0.15 =B1  4%  perf-profile.self.cycle=
s-pp.rcu_all_qs
>       0.41 =B1  3%      -0.0        0.37 =B1  8%  perf-profile.self.cycle=
s-pp.unix_stream_recvmsg
>       0.22 =B1  2%      -0.0        0.17 =B1  4%  perf-profile.self.cycle=
s-pp.unix_destruct_scm
>       0.09 =B1  4%      -0.0        0.05        perf-profile.self.cycles-=
pp.should_failslab
>       0.10 =B1 15%      -0.0        0.06 =B1 50%  perf-profile.self.cycle=
s-pp.__mod_memcg_lruvec_state
>       0.11 =B1  4%      -0.0        0.07        perf-profile.self.cycles-=
pp.__might_fault
>       0.16 =B1  2%      -0.0        0.13 =B1  6%  perf-profile.self.cycle=
s-pp.obj_cgroup_uncharge_pages
>       0.18 =B1  4%      -0.0        0.16 =B1  3%  perf-profile.self.cycle=
s-pp.security_socket_getpeersec_dgram
>       0.28 =B1  2%      -0.0        0.25 =B1  2%  perf-profile.self.cycle=
s-pp.unix_write_space
>       0.17 =B1  2%      -0.0        0.15 =B1  5%  perf-profile.self.cycle=
s-pp.apparmor_socket_getpeersec_dgram
>       0.08 =B1  6%      -0.0        0.05 =B1  7%  perf-profile.self.cycle=
s-pp.security_socket_sendmsg
>       0.12 =B1  4%      -0.0        0.10 =B1  3%  perf-profile.self.cycle=
s-pp.__skb_datagram_iter
>       0.24 =B1  2%      -0.0        0.22        perf-profile.self.cycles-=
pp.mutex_unlock
>       0.08 =B1  5%      +0.0        0.10 =B1  6%  perf-profile.self.cycle=
s-pp.scm_recv
>       0.17 =B1  2%      +0.0        0.19 =B1  3%  perf-profile.self.cycle=
s-pp.__x64_sys_read
>       0.19 =B1  3%      +0.0        0.22 =B1  2%  perf-profile.self.cycle=
s-pp.__get_task_ioprio
>       0.00            +0.1        0.06        perf-profile.self.cycles-pp=
.finish_wait
>       0.00            +0.1        0.06 =B1  7%  perf-profile.self.cycles-=
pp.cr4_update_irqsoff
>       0.00            +0.1        0.06 =B1  7%  perf-profile.self.cycles-=
pp.invalidate_user_asid
>       0.00            +0.1        0.07 =B1 12%  perf-profile.self.cycles-=
pp.wake_affine
>       0.00            +0.1        0.07 =B1  7%  perf-profile.self.cycles-=
pp.check_cfs_rq_runtime
>       0.00            +0.1        0.07 =B1  5%  perf-profile.self.cycles-=
pp.perf_trace_buf_update
>       0.00            +0.1        0.07 =B1  9%  perf-profile.self.cycles-=
pp.asm_sysvec_reschedule_ipi
>       0.00            +0.1        0.07 =B1 10%  perf-profile.self.cycles-=
pp.__bitmap_and
>       0.00            +0.1        0.08 =B1 10%  perf-profile.self.cycles-=
pp.schedule_debug
>       0.00            +0.1        0.08 =B1 13%  perf-profile.self.cycles-=
pp.read@plt
>       0.00            +0.1        0.08 =B1 12%  perf-profile.self.cycles-=
pp.perf_trace_buf_alloc
>       0.00            +0.1        0.09 =B1 35%  perf-profile.self.cycles-=
pp.migrate_task_rq_fair
>       0.00            +0.1        0.09 =B1  5%  perf-profile.self.cycles-=
pp.place_entity
>       0.00            +0.1        0.10 =B1  4%  perf-profile.self.cycles-=
pp.tracing_gen_ctx_irq_test
>       0.00            +0.1        0.10        perf-profile.self.cycles-pp=
.__wake_up_common_lock
>       0.07 =B1 17%      +0.1        0.18 =B1  3%  perf-profile.self.cycle=
s-pp.__list_add_valid
>       0.00            +0.1        0.11 =B1  8%  perf-profile.self.cycles-=
pp.native_irq_return_iret
>       0.00            +0.1        0.12 =B1  6%  perf-profile.self.cycles-=
pp.select_idle_cpu
>       0.00            +0.1        0.12 =B1 34%  perf-profile.self.cycles-=
pp._find_next_and_bit
>       0.00            +0.1        0.13 =B1 25%  perf-profile.self.cycles-=
pp.__cgroup_account_cputime
>       0.00            +0.1        0.13 =B1  7%  perf-profile.self.cycles-=
pp.switch_ldt
>       0.00            +0.1        0.14 =B1  5%  perf-profile.self.cycles-=
pp.check_preempt_curr
>       0.00            +0.1        0.15 =B1  2%  perf-profile.self.cycles-=
pp.save_fpregs_to_fpstate
>       0.00            +0.1        0.15 =B1  5%  perf-profile.self.cycles-=
pp.__rdgsbase_inactive
>       0.14 =B1  3%      +0.2        0.29        perf-profile.self.cycles-=
pp._raw_spin_unlock_irqrestore
>       0.00            +0.2        0.15 =B1  7%  perf-profile.self.cycles-=
pp.ttwu_queue_wakelist
>       0.00            +0.2        0.17 =B1  4%  perf-profile.self.cycles-=
pp.rb_insert_color
>       0.00            +0.2        0.17 =B1  5%  perf-profile.self.cycles-=
pp.rb_next
>       0.00            +0.2        0.18 =B1  2%  perf-profile.self.cycles-=
pp.autoremove_wake_function
>       0.01 =B1223%      +0.2        0.19 =B1  6%  perf-profile.self.cycle=
s-pp.ttwu_do_activate
>       0.00            +0.2        0.20 =B1  2%  perf-profile.self.cycles-=
pp.rcu_note_context_switch
>       0.00            +0.2        0.20 =B1  7%  perf-profile.self.cycles-=
pp.exit_to_user_mode_loop
>       0.27            +0.2        0.47 =B1  3%  perf-profile.self.cycles-=
pp.mutex_lock
>       0.00            +0.2        0.20 =B1 28%  perf-profile.self.cycles-=
pp.perf_trace_sched_switch
>       0.00            +0.2        0.21 =B1  9%  perf-profile.self.cycles-=
pp.resched_curr
>       0.04 =B1 45%      +0.2        0.26 =B1  7%  perf-profile.self.cycle=
s-pp.perf_tp_event
>       0.06 =B1  7%      +0.2        0.28 =B1  8%  perf-profile.self.cycle=
s-pp.perf_trace_sched_wakeup_template
>       0.19 =B1  7%      +0.2        0.41 =B1  5%  perf-profile.self.cycle=
s-pp.__list_del_entry_valid
>       0.08 =B1  5%      +0.2        0.31 =B1 11%  perf-profile.self.cycle=
s-pp.task_h_load
>       0.00            +0.2        0.23 =B1  5%  perf-profile.self.cycles-=
pp.finish_task_switch
>       0.03 =B1 70%      +0.2        0.27 =B1  5%  perf-profile.self.cycle=
s-pp.rb_erase
>       0.02 =B1142%      +0.3        0.29 =B1  2%  perf-profile.self.cycle=
s-pp.native_sched_clock
>       0.00            +0.3        0.28 =B1  3%  perf-profile.self.cycles-=
pp.__wrgsbase_inactive
>       0.00            +0.3        0.28 =B1  6%  perf-profile.self.cycles-=
pp.clear_buddies
>       0.07 =B1 10%      +0.3        0.35 =B1  3%  perf-profile.self.cycle=
s-pp.schedule_timeout
>       0.03 =B1 70%      +0.3        0.33 =B1  3%  perf-profile.self.cycle=
s-pp.select_task_rq
>       0.06 =B1 13%      +0.3        0.36 =B1  4%  perf-profile.self.cycle=
s-pp.__wake_up_common
>       0.06 =B1 13%      +0.3        0.36 =B1  3%  perf-profile.self.cycle=
s-pp.dequeue_entity
>       0.06 =B1 18%      +0.3        0.37 =B1  7%  perf-profile.self.cycle=
s-pp.perf_trace_sched_stat_runtime
>       0.01 =B1223%      +0.3        0.33 =B1  4%  perf-profile.self.cycle=
s-pp.schedule
>       0.02 =B1142%      +0.3        0.35 =B1  7%  perf-profile.self.cycle=
s-pp.cpuacct_charge
>       0.01 =B1223%      +0.3        0.35        perf-profile.self.cycles-=
pp.set_next_entity
>       0.00            +0.4        0.35 =B1 13%  perf-profile.self.cycles-=
pp.available_idle_cpu
>       0.08 =B1 10%      +0.4        0.44 =B1  5%  perf-profile.self.cycle=
s-pp.prepare_to_wait
>       0.63 =B1  3%      +0.4        1.00 =B1  4%  perf-profile.self.cycle=
s-pp.vfs_read
>       0.02 =B1142%      +0.4        0.40 =B1  4%  perf-profile.self.cycle=
s-pp.check_preempt_wakeup
>       0.02 =B1141%      +0.4        0.42 =B1  4%  perf-profile.self.cycle=
s-pp.pick_next_entity
>       0.07 =B1 17%      +0.4        0.48        perf-profile.self.cycles-=
pp.__calc_delta
>       0.06 =B1 14%      +0.4        0.47 =B1  3%  perf-profile.self.cycle=
s-pp.unix_stream_data_wait
>       0.04 =B1 45%      +0.4        0.45 =B1  4%  perf-profile.self.cycle=
s-pp.switch_fpu_return
>       0.00            +0.5        0.46 =B1  7%  perf-profile.self.cycles-=
pp.set_next_buddy
>       0.07 =B1 17%      +0.5        0.53 =B1  3%  perf-profile.self.cycle=
s-pp.select_task_rq_fair
>       0.08 =B1 16%      +0.5        0.55 =B1  4%  perf-profile.self.cycle=
s-pp.try_to_wake_up
>       0.08 =B1 19%      +0.5        0.56 =B1  3%  perf-profile.self.cycle=
s-pp.update_rq_clock
>       0.02 =B1141%      +0.5        0.50 =B1 10%  perf-profile.self.cycle=
s-pp.select_idle_sibling
>       0.77 =B1  2%      +0.5        1.25 =B1  2%  perf-profile.self.cycle=
s-pp.__libc_read
>       0.09 =B1 19%      +0.5        0.59 =B1  3%  perf-profile.self.cycle=
s-pp.reweight_entity
>       0.08 =B1 14%      +0.5        0.59 =B1  2%  perf-profile.self.cycle=
s-pp.dequeue_task_fair
>       0.08 =B1 13%      +0.6        0.64 =B1  5%  perf-profile.self.cycle=
s-pp.update_min_vruntime
>       0.02 =B1141%      +0.6        0.58 =B1  7%  perf-profile.self.cycle=
s-pp.put_prev_entity
>       0.06 =B1 11%      +0.6        0.64 =B1  4%  perf-profile.self.cycle=
s-pp.enqueue_task_fair
>       0.07 =B1 18%      +0.6        0.68 =B1  3%  perf-profile.self.cycle=
s-pp.os_xsave
>       1.39 =B1  2%      +0.7        2.06 =B1  3%  perf-profile.self.cycle=
s-pp._raw_spin_lock_irqsave
>       0.28 =B1  8%      +0.7        0.97 =B1  4%  perf-profile.self.cycle=
s-pp.update_cfs_group
>       0.14 =B1  8%      +0.7        0.83 =B1  3%  perf-profile.self.cycle=
s-pp.__update_load_avg_se
>       1.76 =B1  3%      +0.7        2.47 =B1  3%  perf-profile.self.cycle=
s-pp._raw_spin_lock
>       0.12 =B1 12%      +0.7        0.85 =B1  5%  perf-profile.self.cycle=
s-pp.prepare_task_switch
>       0.12 =B1 12%      +0.8        0.91 =B1  3%  perf-profile.self.cycle=
s-pp.__update_load_avg_cfs_rq
>       0.13 =B1 12%      +0.8        0.93 =B1  5%  perf-profile.self.cycle=
s-pp.pick_next_task_fair
>       0.13 =B1 12%      +0.9        0.98 =B1  4%  perf-profile.self.cycle=
s-pp.__switch_to
>       0.11 =B1 18%      +0.9        1.06 =B1  5%  perf-profile.self.cycle=
s-pp.___perf_sw_event
>       0.16 =B1 11%      +1.2        1.34 =B1  4%  perf-profile.self.cycle=
s-pp.enqueue_entity
>       0.20 =B1 12%      +1.4        1.58 =B1  4%  perf-profile.self.cycle=
s-pp.__switch_to_asm
>       0.23 =B1 10%      +1.4        1.65 =B1  5%  perf-profile.self.cycle=
s-pp.restore_fpregs_from_fpstate
>       0.25 =B1 12%      +1.5        1.77 =B1  4%  perf-profile.self.cycle=
s-pp.__schedule
>       0.22 =B1 10%      +1.6        1.78 =B1 10%  perf-profile.self.cycle=
s-pp.update_load_avg
>       0.23 =B1 16%      +1.7        1.91 =B1  7%  perf-profile.self.cycle=
s-pp.update_curr
>       0.48 =B1 11%      +3.4        3.86 =B1  4%  perf-profile.self.cycle=
s-pp.switch_mm_irqs_off
> =

> =

> To reproduce:
> =

>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in=
 this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file =
for lkp run
>         sudo bin/lkp run generated-yaml-file
> =

>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



