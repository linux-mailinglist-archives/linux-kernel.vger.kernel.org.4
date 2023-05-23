Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666F770D22E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 05:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjEWDGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 23:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjEWDGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 23:06:12 -0400
Received: from out-52.mta1.migadu.com (out-52.mta1.migadu.com [95.215.58.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE3FA7
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 20:06:05 -0700 (PDT)
Message-ID: <eba38fce-2454-d7a4-10ef-240b4686f23d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684811163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u2f/l+JL3oRSlF7RaEwHtVgTsOFdyOgLiYH8AKbd+Cs=;
        b=xPtTcV0s4FNOHl8UBfrZkqPw9yipa8m+eBmRkBzf65fH1zfkHDevmlg4afO6fP5dzxoHsg
        tbYpvJr36YJQQKMyhYvuy6Jiy2Zd7t7R7wCLuYGVBoLSsa+luPBNddmbDABNZtMd6TbFoF
        p3u+qE5RqeGJsZnffBkKv0gG+60i3xM=
Date:   Tue, 23 May 2023 11:05:51 +0800
MIME-Version: 1.0
Subject: Re: [linus:master] [mm] f95bdb700b: stress-ng.ramfs.ops_per_sec
 -88.8% regression
Content-Language: en-US
To:     kernel test robot <yujie.liu@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Kirill Tkhai <tkhai@ya.ru>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>, linux-mm@kvack.org,
        ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
References: <202305230837.db2c233f-yujie.liu@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <202305230837.db2c233f-yujie.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 2023/5/23 09:35, kernel test robot wrote:
> Hello,
> 
> kernel test robot noticed a -88.8% regression of stress-ng.ramfs.ops_per_sec on:
> 
> commit: f95bdb700bc6bb74e1199b1f5f90c613e152cfa7 ("mm: vmscan: make global slab shrink lockless")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Hi,

I see that the reproduction program you pasted is the following:

```
dmsetup remove_all
wipefs -a --force /dev/sda1
mkfs -t ext4 -q -F /dev/sda1
mkdir -p /fs/sda1
mount -t ext4 /dev/sda1 /fs/sda1

for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

  "mkdir" "-p" "/mnt/stress-ng"
  "mount" "/dev/sda1" "/mnt/stress-ng"
  "stress-ng" "--timeout" "60" "--times" "--verify" "--metrics-brief" 
"--ramfs" "9"
```

Looks like it will do mount and umount stress tests.
The commit 475733dda5ae ("mm: vmscan: add shrinker_srcu_generation")
has optimized the umount, can you test it again with this commit?

Thanks,
Qi

> 
> testcase: stress-ng
> test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory
> parameters:
> 
> 	nr_threads: 10%
> 	disk: 1HDD
> 	testtime: 60s
> 	fs: ext4
> 	class: os
> 	test: ramfs
> 	cpufreq_governor: performance
> 
> 
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <yujie.liu@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202305230837.db2c233f-yujie.liu@intel.com
> 
> 
> Details are as below:
> 
> =========================================================================================
> class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
>    os/gcc-11/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-csl-2sp7/ramfs/stress-ng/60s
> 
> commit:
>    42c9db3970 ("mm: vmscan: add a map_nr_max field to shrinker_info")
>    f95bdb700b ("mm: vmscan: make global slab shrink lockless")
> 
> 42c9db39704839ee f95bdb700bc6bb74e1199b1f5f9
> ---------------- ---------------------------
>           %stddev     %change         %stddev
>               \          |                \
>     1408764           -88.8%     157151 ±  8%  stress-ng.ramfs.ops
>       23479           -88.8%       2619 ±  8%  stress-ng.ramfs.ops_per_sec
>     1310766           -88.3%     153888 ±  9%  stress-ng.time.involuntary_context_switches
>      425.00           -82.7%      73.67 ± 16%  stress-ng.time.percent_of_cpu_this_job_got
>      251.56           -82.7%      43.61 ± 15%  stress-ng.time.system_time
>       12.68 ± 20%     -80.1%       2.52 ± 34%  stress-ng.time.user_time
>     4306933           -88.1%     513985 ±  7%  stress-ng.time.voluntary_context_switches
>        1.09 ±  9%      +3.7%       1.13 ± 10%  boot-time.smp_boot
>     9358706           -27.4%    6793950        cpuidle..usage
>       93.32            +4.7%      97.73        iostat.cpu.idle
>        5.78           -70.0%       1.74 ±  4%  iostat.cpu.system
>        4.33 ± 10%     -73.1%       1.17 ± 31%  vmstat.procs.r
>      250072           -84.7%      38245 ±  5%  vmstat.system.cs
>      229190           -54.6%     104141        vmstat.system.in
>        9218 ± 15%     -31.3%       6336 ±  5%  meminfo.Active
>        5681 ±  2%     -39.8%       3421 ± 10%  meminfo.Active(anon)
>       53760 ±  4%     -15.0%      45717        meminfo.Percpu
>       12396           -19.4%       9993 ±  3%  meminfo.Shmem
>        0.75            +0.5        1.27 ±  9%  mpstat.cpu.all.irq%
>        0.13 ±  3%      -0.0        0.10 ±  4%  mpstat.cpu.all.soft%
>        5.00            -4.7        0.34 ± 16%  mpstat.cpu.all.sys%
>        0.88 ±  4%      -0.4        0.51 ±  4%  mpstat.cpu.all.usr%
>      494448 ± 13%     -55.9%     217823 ±  9%  numa-numastat.node0.local_node
>      553385 ± 12%     -52.2%     264460 ±  9%  numa-numastat.node0.numa_hit
>      598515 ± 11%     -68.7%     187452 ± 12%  numa-numastat.node1.local_node
>      632713 ± 11%     -63.9%     228349 ± 11%  numa-numastat.node1.numa_hit
>        6462 ± 14%     -39.9%       3884 ± 15%  numa-meminfo.node1.Active
>        4789 ±  5%     -52.6%       2272 ± 14%  numa-meminfo.node1.Active(anon)
>     1451867 ± 84%     -91.1%     128582 ± 72%  numa-meminfo.node1.FilePages
>     2362122 ± 53%     -55.5%    1050305 ± 16%  numa-meminfo.node1.MemUsed
>        6655 ± 20%     -40.3%       3974 ± 17%  numa-meminfo.node1.Shmem
>      159872 ± 13%     -23.2%     122702 ± 15%  numa-meminfo.node1.Slab
>     1441661 ± 85%     -91.5%     122024 ± 77%  numa-meminfo.node1.Unevictable
>      553499 ± 12%     -52.2%     264583 ±  9%  numa-vmstat.node0.numa_hit
>      494562 ± 13%     -55.9%     217947 ±  9%  numa-vmstat.node0.numa_local
>        1196 ±  5%     -52.6%     567.83 ± 14%  numa-vmstat.node1.nr_active_anon
>      362966 ± 84%     -91.1%      32145 ± 72%  numa-vmstat.node1.nr_file_pages
>        1663 ± 20%     -40.3%     993.33 ± 17%  numa-vmstat.node1.nr_shmem
>      360414 ± 85%     -91.5%      30505 ± 77%  numa-vmstat.node1.nr_unevictable
>        1196 ±  5%     -52.6%     567.83 ± 14%  numa-vmstat.node1.nr_zone_active_anon
>      360414 ± 85%     -91.5%      30505 ± 77%  numa-vmstat.node1.nr_zone_unevictable
>      632698 ± 11%     -63.9%     228516 ± 11%  numa-vmstat.node1.numa_hit
>      598500 ± 11%     -68.7%     187619 ± 12%  numa-vmstat.node1.numa_local
>        1420 ±  2%     -39.8%     855.00 ± 10%  proc-vmstat.nr_active_anon
>        3098           -19.4%       2498 ±  3%  proc-vmstat.nr_shmem
>       30843            -7.7%      28469        proc-vmstat.nr_slab_reclaimable
>       54154            -7.7%      49970        proc-vmstat.nr_slab_unreclaimable
>        1420 ±  2%     -39.8%     855.00 ± 10%  proc-vmstat.nr_zone_active_anon
>     1187707           -58.4%     494370 ±  2%  proc-vmstat.numa_hit
>     1096738           -62.9%     406835 ±  3%  proc-vmstat.numa_local
>       93101            -6.0%      87525        proc-vmstat.numa_other
>        3089 ± 11%     -69.4%     945.17 ±  5%  proc-vmstat.pgactivate
>     1431073           -62.4%     538512 ±  3%  proc-vmstat.pgalloc_normal
>     1272095           -69.3%     390780 ±  4%  proc-vmstat.pgfree
>      221.33           -72.0%      62.00 ±  3%  turbostat.Avg_MHz
>        8.02            -4.2        3.80 ±  3%  turbostat.Busy%
>        2761           -40.6%       1641        turbostat.Bzy_MHz
>     2052119 ±  9%     -96.5%      72643 ± 20%  turbostat.C1
>        2.78 ±  4%      -2.5        0.30 ± 18%  turbostat.C1%
>     1984776 ±  2%     -58.3%     827902 ±  7%  turbostat.C1E
>     5247470           +11.4%    5843977        turbostat.C6
>        1.89 ±  7%    +350.5%       8.50 ± 54%  turbostat.CPU%c6
>       52.00 ±  2%     -11.2%      46.17 ±  3%  turbostat.CoreTmp
>        0.20 ±  2%     +21.2%       0.24 ±  3%  turbostat.IPC
>    14915294           -54.2%    6833094 ±  2%  turbostat.IRQ
>       52057           -47.7%      27209 ±  8%  turbostat.POLL
>        0.01            -0.0        0.00        turbostat.POLL%
>        0.77 ±  8%    +516.9%       4.75 ± 94%  turbostat.Pkg%pc2
>       52.00 ±  2%     -11.2%      46.17 ±  3%  turbostat.PkgTmp
>      168.06           -21.8%     131.38        turbostat.PkgWatt
>       37.48            -3.0%      36.38        turbostat.RAMWatt
>   2.822e+09 ±  2%     -68.8%  8.811e+08 ±  5%  perf-stat.i.branch-instructions
>        1.19            +0.8        1.96 ±  8%  perf-stat.i.branch-miss-rate%
>    32471421 ±  2%     -48.5%   16730947 ±  7%  perf-stat.i.branch-misses
>       21.01 ±  5%     -14.8        6.21 ± 18%  perf-stat.i.cache-miss-rate%
>    35115410           -91.4%    3022306 ± 16%  perf-stat.i.cache-misses
>   1.658e+08 ±  6%     -69.7%   50263818 ± 13%  perf-stat.i.cache-references
>      261530           -84.8%      39659 ±  6%  perf-stat.i.context-switches
>    2.07e+10           -74.6%  5.248e+09 ±  2%  perf-stat.i.cpu-cycles
>        1143 ±  6%     -55.0%     514.25 ± 18%  perf-stat.i.cpu-migrations
>      613.99 ±  2%    +206.8%       1883 ± 18%  perf-stat.i.cycles-between-cache-misses
>        0.04 ±  8%      +0.0        0.09 ± 23%  perf-stat.i.dTLB-load-miss-rate%
>     1337737 ±  6%     -38.9%     817401 ± 21%  perf-stat.i.dTLB-load-misses
>   3.312e+09 ±  3%     -69.4%  1.014e+09 ±  5%  perf-stat.i.dTLB-loads
>      245827 ±  3%     -66.3%      82725 ± 16%  perf-stat.i.dTLB-store-misses
>   1.604e+09 ±  2%     -68.3%  5.086e+08 ±  5%  perf-stat.i.dTLB-stores
>       54.44            -9.1       45.36 ±  5%  perf-stat.i.iTLB-load-miss-rate%
>     3408503           -64.7%    1204595 ±  6%  perf-stat.i.iTLB-load-misses
>     2867132           -48.3%    1481327 ±  7%  perf-stat.i.iTLB-loads
>   1.421e+10 ±  2%     -70.2%  4.231e+09 ±  5%  perf-stat.i.instructions
>        4234 ±  3%     -16.3%       3542 ±  6%  perf-stat.i.instructions-per-iTLB-miss
>        0.69           +16.4%       0.80 ±  4%  perf-stat.i.ipc
>        0.22           -74.7%       0.05 ±  2%  perf-stat.i.metric.GHz
>      372.98           +51.6%     565.34 ± 12%  perf-stat.i.metric.K/sec
>       82.31 ±  2%     -69.6%      25.02 ±  5%  perf-stat.i.metric.M/sec
>    10453834 ±  3%     -92.0%     832079 ± 20%  perf-stat.i.node-load-misses
>      879828           -91.8%      71803 ± 17%  perf-stat.i.node-loads
>       96.34           -10.8       85.52 ±  6%  perf-stat.i.node-store-miss-rate%
>    19057141 ±  2%     -96.0%     771338 ± 33%  perf-stat.i.node-store-misses
>      379581 ±  4%     -80.4%      74536 ± 16%  perf-stat.i.node-stores
>        1.15            +0.8        1.90 ±  6%  perf-stat.overall.branch-miss-rate%
>       21.25 ±  6%     -15.2        6.08 ± 17%  perf-stat.overall.cache-miss-rate%
>        1.46 ±  2%     -14.7%       1.24 ±  4%  perf-stat.overall.cpi
>      589.71 ±  2%    +203.1%       1787 ± 17%  perf-stat.overall.cycles-between-cache-misses
>        0.04 ±  9%      +0.0        0.08 ± 21%  perf-stat.overall.dTLB-load-miss-rate%
>       54.31            -9.4       44.87 ±  5%  perf-stat.overall.iTLB-load-miss-rate%
>        4169 ±  3%     -15.5%       3521 ±  6%  perf-stat.overall.instructions-per-iTLB-miss
>        0.69 ±  2%     +17.5%       0.81 ±  4%  perf-stat.overall.ipc
>       98.05            -8.1       89.98 ±  4%  perf-stat.overall.node-store-miss-rate%
>   2.777e+09 ±  2%     -68.8%   8.67e+08 ±  5%  perf-stat.ps.branch-instructions
>    31948261 ±  2%     -48.5%   16462168 ±  7%  perf-stat.ps.branch-misses
>    34551107           -91.4%    2973956 ± 15%  perf-stat.ps.cache-misses
>   1.632e+08 ±  6%     -69.7%   49465945 ± 13%  perf-stat.ps.cache-references
>      257331           -84.8%      39027 ±  6%  perf-stat.ps.context-switches
>   2.037e+10           -74.6%  5.165e+09 ±  2%  perf-stat.ps.cpu-cycles
>        1124 ±  6%     -55.0%     506.01 ± 18%  perf-stat.ps.cpu-migrations
>     1316371 ±  6%     -38.9%     804455 ± 21%  perf-stat.ps.dTLB-load-misses
>   3.258e+09 ±  3%     -69.4%  9.975e+08 ±  5%  perf-stat.ps.dTLB-loads
>      241892 ±  3%     -66.3%      81415 ± 16%  perf-stat.ps.dTLB-store-misses
>   1.578e+09 ±  2%     -68.3%  5.004e+08 ±  5%  perf-stat.ps.dTLB-stores
>     3353793           -64.7%    1185377 ±  6%  perf-stat.ps.iTLB-load-misses
>     2821090           -48.3%    1457697 ±  7%  perf-stat.ps.iTLB-loads
>   1.398e+10 ±  2%     -70.2%  4.163e+09 ±  5%  perf-stat.ps.instructions
>    10285826 ±  3%     -92.0%     818754 ± 20%  perf-stat.ps.node-load-misses
>      865684           -91.8%      70644 ± 17%  perf-stat.ps.node-loads
>    18750865 ±  2%     -96.0%     758931 ± 33%  perf-stat.ps.node-store-misses
>      373508 ±  4%     -80.4%      73345 ± 16%  perf-stat.ps.node-stores
>    8.75e+11 ±  2%     -69.9%  2.637e+11 ±  6%  perf-stat.total.instructions
>       18.61           -10.1        8.48 ± 19%  perf-profile.calltrace.cycles-pp.mount
>       18.56           -10.1        8.46 ± 19%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.mount
>       18.56           -10.1        8.46 ± 19%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.mount
>       18.52           -10.1        8.44 ± 19%  perf-profile.calltrace.cycles-pp.__x64_sys_mount.do_syscall_64.entry_SYSCALL_64_after_hwframe.mount
>       17.64            -9.4        8.22 ± 19%  perf-profile.calltrace.cycles-pp.do_new_mount.__x64_sys_mount.do_syscall_64.entry_SYSCALL_64_after_hwframe.mount
>       15.74            -7.5        8.29 ± 22%  perf-profile.calltrace.cycles-pp.umount2
>       15.58            -7.4        8.14 ± 21%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.umount2
>       15.56            -7.4        8.13 ± 21%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.umount2
>       13.19 ±  2%      -6.9        6.33 ± 20%  perf-profile.calltrace.cycles-pp.__x64_sys_umount.do_syscall_64.entry_SYSCALL_64_after_hwframe.umount2
>       11.28 ±  3%      -5.6        5.64 ± 22%  perf-profile.calltrace.cycles-pp.path_umount.__x64_sys_umount.do_syscall_64.entry_SYSCALL_64_after_hwframe.umount2
>        9.21 ±  2%      -5.5        3.71 ± 12%  perf-profile.calltrace.cycles-pp.ret_from_fork
>        9.21 ±  2%      -5.5        3.71 ± 12%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
>       10.68 ±  3%      -5.3        5.34 ± 22%  perf-profile.calltrace.cycles-pp.do_umount.path_umount.__x64_sys_umount.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        5.36            -3.7        1.61 ± 15%  perf-profile.calltrace.cycles-pp.attach_recursive_mnt.do_new_mount.__x64_sys_mount.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        4.80            -3.4        1.40 ± 14%  perf-profile.calltrace.cycles-pp.propagate_mnt.attach_recursive_mnt.do_new_mount.__x64_sys_mount.do_syscall_64
>        4.68            -3.3        1.37 ± 14%  perf-profile.calltrace.cycles-pp.propagate_one.propagate_mnt.attach_recursive_mnt.do_new_mount.__x64_sys_mount
>        3.70 ±  4%      -3.2        0.53 ± 46%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd.smpboot_thread_fn
>        4.49            -3.2        1.33 ± 14%  perf-profile.calltrace.cycles-pp.copy_tree.propagate_one.propagate_mnt.attach_recursive_mnt.do_new_mount
>        4.48            -3.2        1.33 ± 14%  perf-profile.calltrace.cycles-pp.clone_mnt.copy_tree.propagate_one.propagate_mnt.attach_recursive_mnt
>        3.75 ±  4%      -3.1        0.64 ± 15%  perf-profile.calltrace.cycles-pp.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
>        3.75 ±  4%      -3.1        0.65 ± 15%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
>        3.72 ±  4%      -3.1        0.63 ± 14%  perf-profile.calltrace.cycles-pp.rcu_core.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread
>        3.82 ±  4%      -3.0        0.87 ± 10%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork
>        4.95 ±  2%      -2.8        2.11 ± 11%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
>        4.05            -2.8        1.22 ± 14%  perf-profile.calltrace.cycles-pp.alloc_vfsmnt.clone_mnt.copy_tree.propagate_one.propagate_mnt
>        5.00            -2.8        2.24 ± 29%  perf-profile.calltrace.cycles-pp.vfs_get_super.vfs_get_tree.do_new_mount.__x64_sys_mount.do_syscall_64
>        5.00            -2.8        2.25 ± 29%  perf-profile.calltrace.cycles-pp.vfs_get_tree.do_new_mount.__x64_sys_mount.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        5.34 ±  2%      -2.6        2.73 ± 13%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
>        3.49 ±  2%      -2.4        1.05 ± 13%  perf-profile.calltrace.cycles-pp.pcpu_alloc.alloc_vfsmnt.clone_mnt.copy_tree.propagate_one
>        4.63 ±  2%      -2.3        2.30 ± 24%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.do_umount.path_umount.__x64_sys_umount
>        4.66 ±  3%      -2.3        2.36 ± 22%  perf-profile.calltrace.cycles-pp.down_write.do_umount.path_umount.__x64_sys_umount.do_syscall_64
>        4.05            -2.3        1.78 ± 29%  perf-profile.calltrace.cycles-pp.sget_fc.vfs_get_super.vfs_get_tree.do_new_mount.__x64_sys_mount
>        3.92            -2.2        1.72 ± 30%  perf-profile.calltrace.cycles-pp.alloc_super.sget_fc.vfs_get_super.vfs_get_tree.do_new_mount
>        3.63 ±  2%      -2.1        1.58 ± 31%  perf-profile.calltrace.cycles-pp.__percpu_init_rwsem.alloc_super.sget_fc.vfs_get_super.vfs_get_tree
>        3.57 ±  2%      -2.0        1.56 ± 31%  perf-profile.calltrace.cycles-pp.pcpu_alloc.__percpu_init_rwsem.alloc_super.sget_fc.vfs_get_super
>        4.10 ±  5%      -1.9        2.20 ± 22%  perf-profile.calltrace.cycles-pp.namespace_unlock.do_umount.path_umount.__x64_sys_umount.do_syscall_64
>        3.62            -1.6        2.00 ± 25%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.do_umount.path_umount
>        2.80            -1.5        1.26 ± 10%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>        2.81            -1.5        1.26 ± 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
>        2.72            -1.5        1.18 ±  7%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>        2.72            -1.5        1.17 ±  7%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>        2.84            -1.5        1.30 ± 10%  perf-profile.calltrace.cycles-pp.open64
>        2.02            -1.5        0.52 ± 49%  perf-profile.calltrace.cycles-pp.memset_erms.pcpu_alloc.__percpu_init_rwsem.alloc_super.sget_fc
>        2.02 ±  2%      -1.5        0.56 ± 45%  perf-profile.calltrace.cycles-pp.memset_erms.pcpu_alloc.alloc_vfsmnt.clone_mnt.copy_tree
>        1.71 ±  2%      -1.4        0.32 ±101%  perf-profile.calltrace.cycles-pp.vfs_create_mount.do_new_mount.__x64_sys_mount.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        1.90 ±  3%      -1.3        0.61 ± 46%  perf-profile.calltrace.cycles-pp.user_path_at_empty.__x64_sys_umount.do_syscall_64.entry_SYSCALL_64_after_hwframe.umount2
>        4.78 ±  2%      -1.3        3.51 ± 17%  perf-profile.calltrace.cycles-pp.lock_mount.do_new_mount.__x64_sys_mount.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        2.62            -1.2        1.44 ± 17%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
>        2.63            -1.2        1.45 ± 18%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        4.57 ±  2%      -1.1        3.46 ± 17%  perf-profile.calltrace.cycles-pp.down_write.lock_mount.do_new_mount.__x64_sys_mount.do_syscall_64
>        4.50 ±  2%      -1.1        3.44 ± 17%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.lock_mount.do_new_mount.__x64_sys_mount
>        1.37 ±  3%      -1.0        0.32 ±103%  perf-profile.calltrace.cycles-pp.propagate_mount_busy.do_umount.path_umount.__x64_sys_umount.do_syscall_64
>        2.28 ±  3%      -1.0        1.25 ± 19%  perf-profile.calltrace.cycles-pp.mntput_no_expire.namespace_unlock.do_umount.path_umount.__x64_sys_umount
>        1.26 ±  3%      -0.9        0.38 ±100%  perf-profile.calltrace.cycles-pp.__sync_rcu_exp_select_node_cpus.process_one_work.worker_thread.kthread.ret_from_fork
>        1.13 ±  7%      -0.8        0.36 ±100%  perf-profile.calltrace.cycles-pp.unlink
>        1.10 ±  7%      -0.8        0.35 ±100%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlink
>        1.06 ±  4%      -0.8        0.31 ±100%  perf-profile.calltrace.cycles-pp.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
>        1.10 ±  7%      -0.8        0.35 ±100%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
>        1.01 ±  5%      -0.7        0.30 ±100%  perf-profile.calltrace.cycles-pp.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
>        1.55 ±  9%      -0.7        0.85 ± 25%  perf-profile.calltrace.cycles-pp.synchronize_rcu_expedited.namespace_unlock.do_umount.path_umount.__x64_sys_umount
>        1.56 ±  3%      -0.7        0.86 ± 25%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.lock_mount
>        0.97 ±  7%      -0.6        0.37 ± 70%  perf-profile.calltrace.cycles-pp.__lxstat64
>        2.26 ±  2%      -0.6        1.68 ± 23%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        0.94 ±  7%      -0.6        0.36 ± 70%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__lxstat64
>        0.93 ±  7%      -0.6        0.36 ± 70%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__lxstat64
>        2.27 ±  2%      -0.6        1.70 ± 22%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.umount2
>        2.24 ±  2%      -0.6        1.67 ± 23%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>        0.82 ±  3%      -0.5        0.29 ±100%  perf-profile.calltrace.cycles-pp.smp_call_function_single.__sync_rcu_exp_select_node_cpus.process_one_work.worker_thread.kthread
>        1.18 ±  5%      -0.4        0.78 ± 19%  perf-profile.calltrace.cycles-pp._raw_spin_lock.mntput_no_expire.namespace_unlock.do_umount.path_umount
>        1.02 ±  6%      -0.3        0.72 ± 20%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.mntput_no_expire.namespace_unlock.do_umount
>        0.00            +0.5        0.55 ±  7%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
>        0.00            +0.6        0.65 ± 19%  perf-profile.calltrace.cycles-pp.__close
>        1.68 ±  6%      +0.7        2.37 ± 17%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.lock_mount
>        0.00            +0.7        0.69 ± 15%  perf-profile.calltrace.cycles-pp.rebalance_domains.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
>        0.00            +0.7        0.70 ± 15%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.openat64
>        0.00            +0.7        0.70 ± 14%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.openat64.device_set_syspath
>        0.00            +0.8        0.79 ± 15%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
>        0.00            +0.8        0.80 ± 13%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.openat64.device_set_syspath.sd_device_new_from_syspath
>        0.00            +0.8        0.81 ± 13%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.openat64.device_set_syspath.sd_device_new_from_syspath
>        0.00            +0.9        0.86 ± 26%  perf-profile.calltrace.cycles-pp.siphash24_compress
>        0.00            +0.9        0.87 ± 13%  perf-profile.calltrace.cycles-pp.openat64.device_set_syspath.sd_device_new_from_syspath
>        0.00            +1.2        1.15 ±  9%  perf-profile.calltrace.cycles-pp.show_mountinfo.seq_read_iter.vfs_read.ksys_read.do_syscall_64
>        0.18 ±141%      +1.2        1.39 ± 11%  perf-profile.calltrace.cycles-pp.sd_device_new_from_syspath
>        0.00            +1.2        1.24 ± 13%  perf-profile.calltrace.cycles-pp.device_set_syspath.sd_device_new_from_syspath
>        0.00            +1.4        1.43 ±  9%  perf-profile.calltrace.cycles-pp.seq_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        0.18 ±141%      +1.5        1.68 ±  7%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
>        0.00            +1.6        1.55 ± 10%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>        0.00            +1.6        1.56 ± 10%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>        0.00            +1.6        1.61 ± 10%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>        0.00            +1.6        1.62 ± 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
>        0.00            +1.6        1.64 ± 10%  perf-profile.calltrace.cycles-pp.read
>        0.00            +1.7        1.66 ± 12%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
>        0.00            +1.8        1.83 ±  9%  perf-profile.calltrace.cycles-pp.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
>        0.85 ±  4%      +2.1        2.92 ±  4%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
>        0.00            +2.1        2.08 ±  8%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
>        0.86 ±  4%      +2.2        3.05 ±  4%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
>        0.99 ±  5%      +2.6        3.57 ±  3%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
>        1.22 ±  5%      +3.8        5.03 ±  4%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
>        1.41 ±  5%      +4.8        6.24 ±  3%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
>        1.42 ±  5%      +4.9        6.35 ±  3%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
>        2.01 ±  4%      +7.2        9.24 ±  5%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
>        2.14 ±  3%      +8.6       10.71 ±  5%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>       36.36            +9.8       46.14 ±  5%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>       40.38           +17.3       57.69 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
>       40.51           +17.8       58.31 ±  5%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
>       42.41           +19.3       61.74 ±  5%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       42.42           +19.4       61.78 ±  5%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       42.42           +19.4       61.78 ±  5%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
>       41.01           +19.4       60.43 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       42.74           +19.6       62.33 ±  5%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
>       43.68           -18.1       25.61 ± 15%  perf-profile.children.cycles-pp.do_syscall_64
>       43.73           -18.0       25.70 ± 15%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>       18.62           -10.1        8.49 ± 19%  perf-profile.children.cycles-pp.mount
>       18.52           -10.1        8.44 ± 19%  perf-profile.children.cycles-pp.__x64_sys_mount
>       17.64            -9.4        8.22 ± 19%  perf-profile.children.cycles-pp.do_new_mount
>       15.76            -7.5        8.30 ± 22%  perf-profile.children.cycles-pp.umount2
>       13.19 ±  2%      -6.9        6.34 ± 20%  perf-profile.children.cycles-pp.__x64_sys_umount
>       11.28 ±  3%      -5.6        5.64 ± 22%  perf-profile.children.cycles-pp.path_umount
>        7.26 ±  2%      -5.6        1.67 ± 19%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>        9.21 ±  2%      -5.5        3.71 ± 12%  perf-profile.children.cycles-pp.kthread
>        9.21 ±  2%      -5.5        3.72 ± 12%  perf-profile.children.cycles-pp.ret_from_fork
>        8.72            -5.4        3.32 ± 23%  perf-profile.children.cycles-pp.pcpu_alloc
>        6.56 ±  3%      -5.4        1.21 ± 16%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>       10.69 ±  3%      -5.3        5.34 ± 22%  perf-profile.children.cycles-pp.do_umount
>        5.24 ±  5%      -4.6        0.67 ± 24%  perf-profile.children.cycles-pp.free_percpu
>        5.36            -3.7        1.61 ± 15%  perf-profile.children.cycles-pp.attach_recursive_mnt
>        5.32 ±  2%      -3.6        1.70 ± 16%  perf-profile.children.cycles-pp.alloc_vfsmnt
>        5.12            -3.5        1.58 ± 19%  perf-profile.children.cycles-pp.memset_erms
>        9.34 ±  2%      -3.5        5.87 ± 19%  perf-profile.children.cycles-pp.down_write
>        4.80            -3.4        1.40 ± 14%  perf-profile.children.cycles-pp.propagate_mnt
>        9.13 ±  2%      -3.4        5.74 ± 20%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
>        4.69            -3.3        1.37 ± 14%  perf-profile.children.cycles-pp.propagate_one
>        4.49            -3.2        1.33 ± 14%  perf-profile.children.cycles-pp.copy_tree
>        4.48            -3.2        1.33 ± 14%  perf-profile.children.cycles-pp.clone_mnt
>        3.75 ±  4%      -3.1        0.65 ± 15%  perf-profile.children.cycles-pp.run_ksoftirqd
>        4.02 ±  4%      -3.1        0.94 ± 11%  perf-profile.children.cycles-pp.rcu_do_batch
>        3.82 ±  4%      -3.0        0.87 ± 10%  perf-profile.children.cycles-pp.smpboot_thread_fn
>        3.41 ±  4%      -2.9        0.47 ± 21%  perf-profile.children.cycles-pp.delayed_free_vfsmnt
>        4.08 ±  4%      -2.9        1.18 ± 10%  perf-profile.children.cycles-pp.rcu_core
>        3.96 ±  3%      -2.9        1.10 ± 15%  perf-profile.children.cycles-pp.path_init
>        4.95 ±  2%      -2.8        2.11 ± 11%  perf-profile.children.cycles-pp.process_one_work
>        5.00            -2.8        2.24 ± 29%  perf-profile.children.cycles-pp.vfs_get_super
>        5.00            -2.8        2.25 ± 29%  perf-profile.children.cycles-pp.vfs_get_tree
>        3.86            -2.7        1.21 ± 21%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
>        5.35 ±  2%      -2.6        2.73 ± 13%  perf-profile.children.cycles-pp.worker_thread
>        4.05            -2.3        1.78 ± 29%  perf-profile.children.cycles-pp.sget_fc
>        3.93            -2.2        1.72 ± 30%  perf-profile.children.cycles-pp.alloc_super
>        4.35 ±  4%      -2.1        2.27 ± 22%  perf-profile.children.cycles-pp.namespace_unlock
>        3.63 ±  2%      -2.1        1.58 ± 31%  perf-profile.children.cycles-pp.__percpu_init_rwsem
>        5.42 ± 12%      -2.0        3.45 ± 13%  perf-profile.children.cycles-pp.__schedule
>        4.44 ±  3%      -1.8        2.61 ±  7%  perf-profile.children.cycles-pp.__do_softirq
>        4.15 ±  2%      -1.8        2.34 ± 12%  perf-profile.children.cycles-pp._raw_spin_lock
>        3.17 ±  3%      -1.8        1.38 ± 13%  perf-profile.children.cycles-pp.filename_lookup
>        2.46 ± 17%      -1.8        0.67 ± 19%  perf-profile.children.cycles-pp.schedule_preempt_disabled
>        3.41 ±  3%      -1.7        1.68 ± 10%  perf-profile.children.cycles-pp.path_lookupat
>        1.87 ±  6%      -1.6        0.26 ± 27%  perf-profile.children.cycles-pp.destroy_super_work
>        1.87 ±  6%      -1.6        0.26 ± 27%  perf-profile.children.cycles-pp.percpu_free_rwsem
>        2.68 ±  2%      -1.6        1.10 ± 15%  perf-profile.children.cycles-pp.user_path_at_empty
>        2.84            -1.5        1.31 ± 10%  perf-profile.children.cycles-pp.open64
>        4.09 ± 13%      -1.5        2.63 ± 17%  perf-profile.children.cycles-pp.schedule
>        2.97            -1.3        1.65 ±  6%  perf-profile.children.cycles-pp.path_openat
>        2.98            -1.3        1.67 ±  6%  perf-profile.children.cycles-pp.do_filp_open
>        2.19 ±  2%      -1.3        0.91 ± 24%  perf-profile.children.cycles-pp.mnt_get_count
>        4.78 ±  2%      -1.3        3.51 ± 17%  perf-profile.children.cycles-pp.lock_mount
>        2.72 ±  3%      -1.2        1.49 ± 19%  perf-profile.children.cycles-pp.mntput_no_expire
>        1.43 ±  8%      -1.2        0.23 ± 41%  perf-profile.children.cycles-pp.intel_idle_irq
>        1.71 ±  2%      -1.2        0.53 ± 23%  perf-profile.children.cycles-pp.vfs_create_mount
>        3.11            -1.2        1.95 ±  5%  perf-profile.children.cycles-pp.do_sys_openat2
>        3.11            -1.1        1.97 ±  5%  perf-profile.children.cycles-pp.__x64_sys_openat
>        1.74 ±  2%      -1.1        0.65 ±  7%  perf-profile.children.cycles-pp.step_into
>        2.43 ±  3%      -1.0        1.39 ±  8%  perf-profile.children.cycles-pp.link_path_walk
>        1.68 ±  6%      -1.0        0.69 ± 18%  perf-profile.children.cycles-pp.filename_parentat
>        1.66 ±  6%      -1.0        0.68 ± 18%  perf-profile.children.cycles-pp.path_parentat
>        1.26 ±  4%      -0.9        0.38 ± 16%  perf-profile.children.cycles-pp.__traverse_mounts
>        1.50 ±  4%      -0.9        0.63 ± 24%  perf-profile.children.cycles-pp.__sync_rcu_exp_select_node_cpus
>        1.17 ±  3%      -0.9        0.30 ± 12%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
>        1.37 ±  3%      -0.9        0.51 ± 31%  perf-profile.children.cycles-pp.propagate_mount_busy
>        1.21 ±  3%      -0.8        0.37 ± 18%  perf-profile.children.cycles-pp.lookup_mnt
>        1.55 ±  9%      -0.7        0.85 ± 25%  perf-profile.children.cycles-pp.synchronize_rcu_expedited
>        1.05 ±  2%      -0.7        0.38 ± 23%  perf-profile.children.cycles-pp.filename_create
>        2.74 ±  2%      -0.6        2.13 ± 17%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
>        2.78 ±  2%      -0.6        2.17 ± 16%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
>        1.04 ±  4%      -0.6        0.47 ± 24%  perf-profile.children.cycles-pp.symlink
>        1.14 ±  7%      -0.6        0.58 ± 24%  perf-profile.children.cycles-pp.unlink
>        0.99 ±  3%      -0.6        0.43 ± 21%  perf-profile.children.cycles-pp.__x64_sys_symlink
>        1.16            -0.6        0.61 ± 24%  perf-profile.children.cycles-pp._find_next_bit
>        0.79 ±  8%      -0.5        0.25 ± 19%  perf-profile.children.cycles-pp.wait_rcu_exp_gp
>        0.79 ±  8%      -0.5        0.25 ± 18%  perf-profile.children.cycles-pp.sync_rcu_exp_select_cpus
>        0.94 ±  3%      -0.5        0.40 ± 22%  perf-profile.children.cycles-pp.do_symlinkat
>        0.71 ±  5%      -0.5        0.18 ± 17%  perf-profile.children.cycles-pp.sysvec_call_function_single
>        1.06 ±  4%      -0.5        0.54 ± 18%  perf-profile.children.cycles-pp.__x64_sys_unlink
>        0.91 ±  3%      -0.5        0.40 ±  9%  perf-profile.children.cycles-pp.__cond_resched
>        1.01 ±  5%      -0.5        0.51 ± 19%  perf-profile.children.cycles-pp.do_unlinkat
>        1.01 ±  2%      -0.5        0.52 ± 25%  perf-profile.children.cycles-pp.stress_rndstr
>        0.98 ±  5%      -0.5        0.49 ± 25%  perf-profile.children.cycles-pp.smp_call_function_single
>        1.01 ±  7%      -0.5        0.55 ± 11%  perf-profile.children.cycles-pp.__lxstat64
>        0.92 ±  4%      -0.4        0.47 ± 10%  perf-profile.children.cycles-pp.__do_sys_newlstat
>        1.13 ±  5%      -0.4        0.68 ± 10%  perf-profile.children.cycles-pp.vfs_statx
>        0.78 ±  2%      -0.4        0.34 ± 18%  perf-profile.children.cycles-pp.generic_shutdown_super
>        0.78 ±  2%      -0.4        0.35 ± 18%  perf-profile.children.cycles-pp.kill_litter_super
>        0.57 ±  6%      -0.4        0.14 ± 19%  perf-profile.children.cycles-pp.__sysvec_call_function_single
>        0.55 ±  3%      -0.4        0.13 ± 36%  perf-profile.children.cycles-pp.rcu_report_exp_cpu_mult
>        0.58 ±  4%      -0.4        0.16 ± 16%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
>        1.20 ±  5%      -0.4        0.78 ± 11%  perf-profile.children.cycles-pp.vfs_fstatat
>        0.78 ±  5%      -0.4        0.37 ± 36%  perf-profile.children.cycles-pp.shmem_fill_super
>        0.61 ±  6%      -0.4        0.20 ± 25%  perf-profile.children.cycles-pp.pcpu_alloc_area
>        0.88 ±  3%      -0.4        0.48 ±  4%  perf-profile.children.cycles-pp.dput
>        0.58 ±  4%      -0.4        0.19 ± 35%  perf-profile.children.cycles-pp.up_write
>        0.50 ±  3%      -0.4        0.12 ± 27%  perf-profile.children.cycles-pp.rcu_note_context_switch
>        0.60 ±  5%      -0.4        0.23 ± 11%  perf-profile.children.cycles-pp.__legitimize_mnt
>        0.71 ±  3%      -0.4        0.35 ± 27%  perf-profile.children.cycles-pp.mnt_get_writers
>        0.56 ±  2%      -0.4        0.20 ± 21%  perf-profile.children.cycles-pp.rcu_exp_wait_wake
>        0.66 ±  6%      -0.4        0.31 ± 29%  perf-profile.children.cycles-pp.mkdir
>        0.62 ±  4%      -0.3        0.28 ± 32%  perf-profile.children.cycles-pp.__x64_sys_mkdir
>        0.59 ±  4%      -0.3        0.26 ± 35%  perf-profile.children.cycles-pp.do_mkdirat
>        0.89 ±  3%      -0.3        0.59 ± 14%  perf-profile.children.cycles-pp.try_to_wake_up
>        0.52 ±  2%      -0.3        0.23 ± 23%  perf-profile.children.cycles-pp.open_last_lookups
>        0.44 ±  5%      -0.3        0.15 ± 34%  perf-profile.children.cycles-pp.rwsem_wake
>        0.45 ±  3%      -0.3        0.18 ± 23%  perf-profile.children.cycles-pp.new_inode
>        0.39 ±  8%      -0.3        0.13 ± 55%  perf-profile.children.cycles-pp.ida_alloc_range
>        0.52 ±  8%      -0.3        0.26 ± 25%  perf-profile.children.cycles-pp.rmdir
>        0.54 ±  4%      -0.3        0.28 ± 37%  perf-profile.children.cycles-pp.__percpu_counter_init
>        0.34 ±  3%      -0.3        0.08 ± 59%  perf-profile.children.cycles-pp.unlock_mount
>        0.48 ±  4%      -0.2        0.24 ± 20%  perf-profile.children.cycles-pp.__x64_sys_rmdir
>        0.40 ±  4%      -0.2        0.16 ± 15%  perf-profile.children.cycles-pp.sync_filesystem
>        0.46 ±  4%      -0.2        0.22 ± 20%  perf-profile.children.cycles-pp.do_rmdir
>        0.39 ±  4%      -0.2        0.15 ± 34%  perf-profile.children.cycles-pp.lookup_open
>        0.39 ±  5%      -0.2        0.15 ± 14%  perf-profile.children.cycles-pp.writeback_inodes_sb
>        0.33 ± 10%      -0.2        0.10 ± 35%  perf-profile.children.cycles-pp.pcpu_free_area
>        0.38 ±  6%      -0.2        0.15 ± 11%  perf-profile.children.cycles-pp.get_nr_dirty_inodes
>        0.45            -0.2        0.22 ± 26%  perf-profile.children.cycles-pp.umount_tree
>        0.46 ±  3%      -0.2        0.24 ± 26%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
>        0.34 ±  5%      -0.2        0.13 ± 32%  perf-profile.children.cycles-pp.wake_up_q
>        0.36 ±  2%      -0.2        0.16 ± 21%  perf-profile.children.cycles-pp.alloc_inode
>        0.25 ±  8%      -0.2        0.05 ± 53%  perf-profile.children.cycles-pp.get_mountpoint
>        0.32 ±  6%      -0.2        0.13 ± 22%  perf-profile.children.cycles-pp.commit_tree
>        0.28 ±  4%      -0.2        0.10 ± 38%  perf-profile.children.cycles-pp.__list_del_entry_valid
>        0.80 ±  2%      -0.2        0.63 ±  9%  perf-profile.children.cycles-pp.getname_flags
>        0.22 ±  6%      -0.2        0.04 ± 78%  perf-profile.children.cycles-pp.mutex_lock_killable
>        0.28 ±  2%      -0.2        0.11 ± 27%  perf-profile.children.cycles-pp.ida_free
>        0.27 ±  4%      -0.2        0.10 ± 25%  perf-profile.children.cycles-pp.synchronize_rcu_expedited_wait
>        0.27 ±  9%      -0.2        0.10 ±  9%  perf-profile.children.cycles-pp.__slab_free
>        0.19 ±  7%      -0.2        0.03 ±101%  perf-profile.children.cycles-pp.rcu_exp_handler
>        0.32 ±  4%      -0.2        0.16 ± 27%  perf-profile.children.cycles-pp.slab_pre_alloc_hook
>        0.25 ±  3%      -0.2        0.10 ± 24%  perf-profile.children.cycles-pp.synchronize_rcu_expedited_wait_once
>        0.34 ±  5%      -0.2        0.18 ± 16%  perf-profile.children.cycles-pp.dentry_kill
>        0.29 ±  4%      -0.2        0.13 ± 26%  perf-profile.children.cycles-pp.shmem_get_inode
>        0.23 ±  8%      -0.2        0.08 ± 25%  perf-profile.children.cycles-pp.generic_exec_single
>        0.48 ±  5%      -0.2        0.33 ± 16%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
>        0.25 ±  8%      -0.1        0.10 ± 25%  perf-profile.children.cycles-pp.llist_add_batch
>        0.50 ±  2%      -0.1        0.35 ± 14%  perf-profile.children.cycles-pp.__wake_up_common_lock
>        0.31 ±  4%      -0.1        0.16 ± 19%  perf-profile.children.cycles-pp.__dentry_kill
>        0.62 ±  3%      -0.1        0.48 ± 12%  perf-profile.children.cycles-pp.strncpy_from_user
>        0.31 ±  6%      -0.1        0.17 ± 11%  perf-profile.children.cycles-pp.stress_mwc32
>        0.24 ±  7%      -0.1        0.10 ± 31%  perf-profile.children.cycles-pp._find_next_zero_bit
>        0.23 ±  6%      -0.1        0.09 ± 20%  perf-profile.children.cycles-pp.ramfs_get_inode
>        0.29 ±  8%      -0.1        0.16 ± 18%  perf-profile.children.cycles-pp.mutex_spin_on_owner
>        0.30 ±  5%      -0.1        0.17 ± 24%  perf-profile.children.cycles-pp.evict
>        0.27 ±  6%      -0.1        0.14 ± 13%  perf-profile.children.cycles-pp.__d_alloc
>        0.30 ±  6%      -0.1        0.18 ± 16%  perf-profile.children.cycles-pp.queue_work_on
>        0.15 ±  6%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.llist_reverse_order
>        0.19 ±  7%      -0.1        0.07 ± 16%  perf-profile.children.cycles-pp.lockref_get
>        0.39 ±  8%      -0.1        0.28 ± 21%  perf-profile.children.cycles-pp.sched_ttwu_pending
>        0.26 ±  7%      -0.1        0.15 ± 10%  perf-profile.children.cycles-pp.__call_rcu_common
>        0.20 ±  7%      -0.1        0.08 ± 16%  perf-profile.children.cycles-pp.get_nr_inodes
>        0.22 ± 11%      -0.1        0.10 ± 15%  perf-profile.children.cycles-pp.d_alloc
>        0.27 ±  8%      -0.1        0.16 ± 14%  perf-profile.children.cycles-pp.__legitimize_path
>        0.22 ±  6%      -0.1        0.11 ±  9%  perf-profile.children.cycles-pp.__flush_work
>        0.21 ±  3%      -0.1        0.10 ± 36%  perf-profile.children.cycles-pp.memcg_list_lru_alloc
>        0.48 ±  8%      -0.1        0.37 ± 18%  perf-profile.children.cycles-pp.ttwu_do_activate
>        0.16 ±  5%      -0.1        0.06 ± 47%  perf-profile.children.cycles-pp.__list_add_valid
>        0.15 ±  6%      -0.1        0.04 ± 75%  perf-profile.children.cycles-pp.pcpu_next_fit_region
>        0.16 ±  4%      -0.1        0.06 ± 49%  perf-profile.children.cycles-pp.pcpu_find_block_fit
>        0.14 ± 15%      -0.1        0.04 ± 73%  perf-profile.children.cycles-pp.swake_up_one
>        0.17 ±  4%      -0.1        0.07 ± 57%  perf-profile.children.cycles-pp.shmem_mknod
>        0.21 ± 11%      -0.1        0.11 ± 19%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
>        0.28 ±  8%      -0.1        0.18 ±  9%  perf-profile.children.cycles-pp.try_to_unlazy
>        0.23 ± 14%      -0.1        0.13 ± 29%  perf-profile.children.cycles-pp.schedule_hrtimeout_range_clock
>        0.14 ±  7%      -0.1        0.04 ± 75%  perf-profile.children.cycles-pp.pcpu_block_update_hint_alloc
>        0.19 ±  8%      -0.1        0.10 ± 27%  perf-profile.children.cycles-pp.complete_walk
>        0.12 ± 12%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.__lookup_mnt
>        0.28 ±  3%      -0.1        0.19 ± 23%  perf-profile.children.cycles-pp.vfs_symlink
>        0.14 ± 14%      -0.1        0.05 ± 74%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
>        0.48 ±  4%      -0.1        0.38 ± 12%  perf-profile.children.cycles-pp.kmem_cache_alloc
>        0.12 ±  6%      -0.1        0.03 ±108%  perf-profile.children.cycles-pp.__bitmap_clear
>        0.42 ± 10%      -0.1        0.34 ± 17%  perf-profile.children.cycles-pp.enqueue_task_fair
>        0.21 ± 18%      -0.1        0.12 ± 25%  perf-profile.children.cycles-pp.__d_lookup
>        0.18 ±  5%      -0.1        0.10 ± 19%  perf-profile.children.cycles-pp.__d_lookup_rcu
>        0.19 ±  8%      -0.1        0.11 ±  9%  perf-profile.children.cycles-pp.update_curr
>        0.11 ± 12%      -0.1        0.03 ±105%  perf-profile.children.cycles-pp.shmem_put_super
>        0.14 ± 11%      -0.1        0.06 ± 55%  perf-profile.children.cycles-pp.shmem_alloc_inode
>        0.20 ±  7%      -0.1        0.11 ± 34%  perf-profile.children.cycles-pp.list_lru_destroy
>        0.17 ± 10%      -0.1        0.09 ± 24%  perf-profile.children.cycles-pp.truncate_inode_pages_range
>        0.12 ±  9%      -0.1        0.04 ± 72%  perf-profile.children.cycles-pp.ns_capable
>        0.11 ± 10%      -0.1        0.03 ±103%  perf-profile.children.cycles-pp.apparmor_capable
>        0.11 ±  9%      -0.1        0.03 ±103%  perf-profile.children.cycles-pp.kstrdup
>        0.14 ± 10%      -0.1        0.06 ± 52%  perf-profile.children.cycles-pp.d_make_root
>        0.16 ±  7%      -0.1        0.08 ± 51%  perf-profile.children.cycles-pp.ramfs_fill_super
>        0.12 ±  9%      -0.1        0.04 ± 77%  perf-profile.children.cycles-pp.security_capable
>        0.10 ± 13%      -0.1        0.03 ±102%  perf-profile.children.cycles-pp.percpu_counter_destroy
>        0.13 ±  7%      -0.1        0.05 ± 71%  perf-profile.children.cycles-pp.vfs_mkdir
>        0.19 ±  3%      -0.1        0.12 ± 22%  perf-profile.children.cycles-pp.lockref_put_return
>        0.16 ±  7%      -0.1        0.09 ± 17%  perf-profile.children.cycles-pp.mutex_unlock
>        0.10 ± 10%      -0.1        0.03 ±101%  perf-profile.children.cycles-pp.propagate_umount
>        0.14 ± 10%      -0.1        0.06 ± 45%  perf-profile.children.cycles-pp.nd_jump_root
>        0.31 ±  7%      -0.1        0.24 ± 16%  perf-profile.children.cycles-pp.__kmem_cache_alloc_node
>        0.13 ±  5%      -0.1        0.06 ± 57%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
>        0.14 ± 11%      -0.1        0.08 ± 33%  perf-profile.children.cycles-pp.__lookup_hash
>        0.15 ±  8%      -0.1        0.08 ± 14%  perf-profile.children.cycles-pp.task_work_add
>        0.11 ±  6%      -0.1        0.04 ±101%  perf-profile.children.cycles-pp.autoremove_wake_function
>        0.12 ± 12%      -0.1        0.06 ± 78%  perf-profile.children.cycles-pp.vfs_rmdir
>        0.14 ± 12%      -0.1        0.08 ± 24%  perf-profile.children.cycles-pp.d_alloc_parallel
>        0.16 ±  4%      -0.1        0.10 ± 21%  perf-profile.children.cycles-pp.shrink_dcache_for_umount
>        0.10 ± 17%      -0.1        0.04 ± 72%  perf-profile.children.cycles-pp.vfs_unlink
>        0.20 ±  5%      -0.1        0.13 ± 22%  perf-profile.children.cycles-pp.ramfs_symlink
>        0.10 ± 11%      -0.1        0.04 ±101%  perf-profile.children.cycles-pp.__pagevec_release
>        0.13 ± 10%      -0.1        0.07 ± 46%  perf-profile.children.cycles-pp.xas_store
>        0.11 ±  8%      -0.1        0.05 ± 47%  perf-profile.children.cycles-pp.set_root
>        0.16 ±  8%      -0.1        0.11 ± 27%  perf-profile.children.cycles-pp.__kmalloc_node_track_caller
>        0.12 ±  8%      -0.1        0.06 ± 21%  perf-profile.children.cycles-pp.__smp_call_single_queue
>        0.16 ±  6%      -0.0        0.11 ± 25%  perf-profile.children.cycles-pp.page_symlink
>        0.13 ±  5%      -0.0        0.08 ± 26%  perf-profile.children.cycles-pp.prepare_task_switch
>        0.12 ± 10%      -0.0        0.07 ± 30%  perf-profile.children.cycles-pp._raw_read_lock_irqsave
>        0.12 ±  9%      -0.0        0.08 ± 23%  perf-profile.children.cycles-pp.kmalloc_trace
>        0.12 ±  5%      -0.0        0.08 ± 17%  perf-profile.children.cycles-pp.rcu_all_qs
>        0.11 ±  8%      -0.0        0.08 ± 24%  perf-profile.children.cycles-pp.simple_write_begin
>        0.12 ± 10%      -0.0        0.08 ± 20%  perf-profile.children.cycles-pp.__switch_to
>        0.11 ±  8%      -0.0        0.08 ± 11%  perf-profile.children.cycles-pp.set_next_entity
>        0.10 ± 13%      +0.0        0.14 ± 16%  perf-profile.children.cycles-pp.do_open
>        0.04 ± 45%      +0.0        0.09 ± 22%  perf-profile.children.cycles-pp.cp_new_stat
>        0.08 ± 16%      +0.0        0.12 ± 17%  perf-profile.children.cycles-pp.do_dentry_open
>        0.09 ± 19%      +0.0        0.13 ± 12%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
>        0.01 ±223%      +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.syscall_return_via_sysret
>        0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.fput
>        0.11 ±  8%      +0.1        0.17 ± 22%  perf-profile.children.cycles-pp.down_read
>        0.04 ± 44%      +0.1        0.11 ± 16%  perf-profile.children.cycles-pp.unit_file_find_dropin_paths
>        0.00            +0.1        0.06 ± 32%  perf-profile.children.cycles-pp.filp_close
>        0.00            +0.1        0.06 ± 24%  perf-profile.children.cycles-pp._copy_to_user
>        0.00            +0.1        0.07 ± 13%  perf-profile.children.cycles-pp.hrtimer_get_next_event
>        0.00            +0.1        0.07 ± 15%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
>        0.11 ± 17%      +0.1        0.18 ± 27%  perf-profile.children.cycles-pp.____sys_recvmsg
>        0.00            +0.1        0.07 ± 32%  perf-profile.children.cycles-pp.kernfs_iop_get_link
>        0.00            +0.1        0.08 ± 20%  perf-profile.children.cycles-pp.wait_for_xmitr
>        0.00            +0.1        0.08 ± 23%  perf-profile.children.cycles-pp.call_cpuidle
>        0.16 ±  6%      +0.1        0.24 ± 15%  perf-profile.children.cycles-pp.ct_kernel_exit_state
>        0.00            +0.1        0.08 ± 22%  perf-profile.children.cycles-pp.strlen@plt
>        0.00            +0.1        0.08 ± 35%  perf-profile.children.cycles-pp.rb_insert_color
>        0.00            +0.1        0.08 ± 24%  perf-profile.children.cycles-pp.__close_nocancel
>        0.00            +0.1        0.08 ± 17%  perf-profile.children.cycles-pp._hashmap_iterate
>        0.00            +0.1        0.08 ± 21%  perf-profile.children.cycles-pp.seq_puts
>        0.11 ± 10%      +0.1        0.19 ± 21%  perf-profile.children.cycles-pp.__entry_text_start
>        0.00            +0.1        0.08 ± 35%  perf-profile.children.cycles-pp.perf_event_task_tick
>        0.02 ±141%      +0.1        0.10 ± 18%  perf-profile.children.cycles-pp.sock_def_readable
>        0.00            +0.1        0.08 ± 32%  perf-profile.children.cycles-pp.tick_nohz_tick_stopped
>        0.00            +0.1        0.08 ± 26%  perf-profile.children.cycles-pp.device_add_property_aux
>        0.00            +0.1        0.08 ± 30%  perf-profile.children.cycles-pp.siphash24_init
>        0.12 ± 15%      +0.1        0.21 ± 26%  perf-profile.children.cycles-pp.__sys_recvmsg
>        0.07 ± 48%      +0.1        0.16 ± 33%  perf-profile.children.cycles-pp.__libc_sendmsg
>        0.01 ±223%      +0.1        0.10 ± 27%  perf-profile.children.cycles-pp.string_table_lookup
>        0.00            +0.1        0.09 ± 25%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
>        0.20 ±  9%      +0.1        0.29 ±  7%  perf-profile.children.cycles-pp.inode_permission
>        0.00            +0.1        0.09 ± 27%  perf-profile.children.cycles-pp.__handle_mm_fault
>        0.06 ± 14%      +0.1        0.16 ± 14%  perf-profile.children.cycles-pp.vfs_fstat
>        0.00            +0.1        0.09 ± 33%  perf-profile.children.cycles-pp.vfs_readlink
>        0.00            +0.1        0.10 ± 19%  perf-profile.children.cycles-pp.uevent_show
>        0.00            +0.1        0.10 ± 10%  perf-profile.children.cycles-pp.up_read
>        0.00            +0.1        0.10 ± 25%  perf-profile.children.cycles-pp.handle_mm_fault
>        0.00            +0.1        0.10 ± 30%  perf-profile.children.cycles-pp.read_counters
>        0.00            +0.1        0.10 ± 20%  perf-profile.children.cycles-pp.strchr
>        0.00            +0.1        0.10 ± 33%  perf-profile.children.cycles-pp.path_hash_func
>        0.00            +0.1        0.10 ± 29%  perf-profile.children.cycles-pp.cmd_stat
>        0.00            +0.1        0.10 ± 29%  perf-profile.children.cycles-pp.dispatch_events
>        0.00            +0.1        0.10 ± 29%  perf-profile.children.cycles-pp.process_interval
>        0.07 ± 11%      +0.1        0.18 ± 19%  perf-profile.children.cycles-pp.memcpy_erms
>        0.00            +0.1        0.11 ±  6%  perf-profile.children.cycles-pp.show_type
>        0.00            +0.1        0.11 ± 19%  perf-profile.children.cycles-pp.exc_page_fault
>        0.00            +0.1        0.11 ± 19%  perf-profile.children.cycles-pp.do_user_addr_fault
>        0.01 ±223%      +0.1        0.12 ± 16%  perf-profile.children.cycles-pp.execve
>        0.01 ±223%      +0.1        0.12 ± 16%  perf-profile.children.cycles-pp.__x64_sys_execve
>        0.01 ±223%      +0.1        0.12 ± 16%  perf-profile.children.cycles-pp.do_execveat_common
>        0.03 ±100%      +0.1        0.14 ± 18%  perf-profile.children.cycles-pp.do_faccessat
>        0.00            +0.1        0.11 ± 14%  perf-profile.children.cycles-pp.dev_attr_show
>        0.00            +0.1        0.11 ± 28%  perf-profile.children.cycles-pp.__libc_start_main
>        0.00            +0.1        0.11 ± 28%  perf-profile.children.cycles-pp.main
>        0.00            +0.1        0.11 ± 28%  perf-profile.children.cycles-pp.run_builtin
>        0.10 ± 28%      +0.1        0.22 ± 15%  perf-profile.children.cycles-pp.sendmsg
>        0.00            +0.1        0.11 ± 13%  perf-profile.children.cycles-pp.sysfs_kf_seq_show
>        0.11 ± 11%      +0.1        0.22 ±  8%  perf-profile.children.cycles-pp._raw_spin_trylock
>        0.10 ±  3%      +0.1        0.22 ± 13%  perf-profile.children.cycles-pp.__do_sys_newfstat
>        0.11 ± 15%      +0.1        0.23 ± 17%  perf-profile.children.cycles-pp.__update_blocked_fair
>        0.00            +0.1        0.12 ± 27%  perf-profile.children.cycles-pp.strlen
>        0.00            +0.1        0.12 ± 22%  perf-profile.children.cycles-pp.rdrand
>        0.06 ± 18%      +0.1        0.18 ±  8%  perf-profile.children.cycles-pp.cfree
>        0.00            +0.1        0.12 ± 13%  perf-profile.children.cycles-pp.number
>        0.00            +0.1        0.12 ± 17%  perf-profile.children.cycles-pp.hrtimer_update_next_event
>        0.03 ±100%      +0.1        0.15 ± 14%  perf-profile.children.cycles-pp.access
>        0.01 ±223%      +0.1        0.13 ± 14%  perf-profile.children.cycles-pp.kernfs_iop_permission
>        0.00            +0.1        0.13 ± 22%  perf-profile.children.cycles-pp.string_escape_mem
>        0.00            +0.1        0.13 ± 30%  perf-profile.children.cycles-pp.try_check_zero
>        0.00            +0.1        0.13 ± 30%  perf-profile.children.cycles-pp.srcu_advance_state
>        0.00            +0.1        0.13 ± 12%  perf-profile.children.cycles-pp.asm_exc_page_fault
>        0.01 ±223%      +0.1        0.14 ± 25%  perf-profile.children.cycles-pp.local_clock
>        0.06 ± 15%      +0.1        0.19 ± 15%  perf-profile.children.cycles-pp.prepend_path
>        0.00            +0.1        0.14 ± 26%  perf-profile.children.cycles-pp.irqtime_account_process_tick
>        0.03 ± 70%      +0.1        0.17 ± 25%  perf-profile.children.cycles-pp.note_gp_changes
>        0.03 ±102%      +0.1        0.17 ± 31%  perf-profile.children.cycles-pp.strchr@plt
>        0.05 ±  7%      +0.1        0.19 ± 20%  perf-profile.children.cycles-pp.siphash24_finalize
>        0.00            +0.1        0.14 ± 20%  perf-profile.children.cycles-pp.seq_escape_mem
>        0.15 ± 10%      +0.1        0.30 ± 31%  perf-profile.children.cycles-pp.trigger_load_balance
>        0.00            +0.1        0.15 ± 17%  perf-profile.children.cycles-pp.format_decode
>        0.19 ±  5%      +0.2        0.34 ± 21%  perf-profile.children.cycles-pp.ct_kernel_enter
>        0.13 ± 14%      +0.2        0.28 ± 19%  perf-profile.children.cycles-pp.unix_stream_sendmsg
>        0.14 ± 18%      +0.2        0.29 ± 17%  perf-profile.children.cycles-pp.sock_sendmsg
>        0.00            +0.2        0.15 ± 28%  perf-profile.children.cycles-pp.process_srcu
>        0.14 ± 17%      +0.2        0.30 ± 19%  perf-profile.children.cycles-pp.____sys_sendmsg
>        0.00            +0.2        0.16 ± 52%  perf-profile.children.cycles-pp.timerqueue_del
>        0.00            +0.2        0.16 ± 21%  perf-profile.children.cycles-pp.get_next_timer_interrupt
>        0.03 ±100%      +0.2        0.19 ± 17%  perf-profile.children.cycles-pp.__d_path
>        0.01 ±223%      +0.2        0.18 ± 15%  perf-profile.children.cycles-pp.delay_tsc
>        0.02 ±141%      +0.2        0.18 ± 28%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
>        0.00            +0.2        0.17 ± 28%  perf-profile.children.cycles-pp.hrtimer_next_event_without
>        0.16 ± 18%      +0.2        0.32 ± 21%  perf-profile.children.cycles-pp.___sys_sendmsg
>        0.00            +0.2        0.17 ± 47%  perf-profile.children.cycles-pp.kernfs_dop_revalidate
>        0.16 ± 15%      +0.2        0.33 ± 22%  perf-profile.children.cycles-pp.__sys_sendmsg
>        0.03 ±100%      +0.2        0.20 ± 16%  perf-profile.children.cycles-pp.check_cpu_stall
>        0.00            +0.2        0.18 ± 20%  perf-profile.children.cycles-pp.timerqueue_add
>        0.00            +0.2        0.18 ± 26%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
>        0.09 ± 13%      +0.2        0.28 ± 37%  perf-profile.children.cycles-pp.__x64_sys_readlinkat
>        0.07 ± 17%      +0.2        0.26 ± 13%  perf-profile.children.cycles-pp.seq_path_root
>        0.30 ±  3%      +0.2        0.49 ± 12%  perf-profile.children.cycles-pp.update_rq_clock
>        0.19 ±  6%      +0.2        0.38 ± 18%  perf-profile.children.cycles-pp.ct_idle_exit
>        0.21 ± 11%      +0.2        0.40 ±  4%  perf-profile.children.cycles-pp.sched_clock_cpu
>        0.07 ± 17%      +0.2        0.26 ± 22%  perf-profile.children.cycles-pp.update_irq_load_avg
>        0.10 ± 14%      +0.2        0.29 ± 34%  perf-profile.children.cycles-pp.do_readlinkat
>        0.11 ± 34%      +0.2        0.31 ± 29%  perf-profile.children.cycles-pp.tick_sched_do_timer
>        0.10 ± 15%      +0.2        0.30 ± 31%  perf-profile.children.cycles-pp.readlinkat
>        0.02 ±141%      +0.2        0.22 ± 19%  perf-profile.children.cycles-pp.device_read_db_internal_filename
>        0.01 ±223%      +0.2        0.22 ± 18%  perf-profile.children.cycles-pp.enqueue_hrtimer
>        0.22 ± 12%      +0.2        0.43 ±  5%  perf-profile.children.cycles-pp.native_sched_clock
>        0.11 ± 14%      +0.2        0.33 ± 19%  perf-profile.children.cycles-pp.path_compare
>        0.05 ± 46%      +0.2        0.29 ± 10%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
>        0.12 ± 11%      +0.2        0.36 ±  7%  perf-profile.children.cycles-pp.irqtime_account_irq
>        0.04 ± 72%      +0.2        0.28 ± 31%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
>        0.16 ±  6%      +0.2        0.40 ±  8%  perf-profile.children.cycles-pp.rcu_pending
>        0.22 ±  4%      +0.2        0.46 ±  6%  perf-profile.children.cycles-pp.native_irq_return_iret
>        0.18 ± 12%      +0.3        0.44 ± 24%  perf-profile.children.cycles-pp.strcmp@plt
>        0.08 ±  8%      +0.3        0.36 ± 15%  perf-profile.children.cycles-pp.seq_printf
>        0.39 ± 10%      +0.3        0.67 ± 19%  perf-profile.children.cycles-pp.__close
>        0.09 ± 21%      +0.3        0.37 ± 24%  perf-profile.children.cycles-pp.tick_nohz_next_event
>        0.18 ±  9%      +0.3        0.47 ± 34%  perf-profile.children.cycles-pp.unit_name_is_valid
>        0.18 ± 22%      +0.3        0.47 ± 33%  perf-profile.children.cycles-pp.__fxstat64
>        0.00            +0.3        0.30 ± 19%  perf-profile.children.cycles-pp.memcpy_toio
>        0.00            +0.3        0.30 ± 19%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_tail_rpm
>        0.00            +0.3        0.30 ± 19%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_planes
>        0.00            +0.3        0.30 ± 19%  perf-profile.children.cycles-pp.ast_primary_plane_helper_atomic_update
>        0.00            +0.3        0.30 ± 19%  perf-profile.children.cycles-pp.drm_fb_memcpy
>        0.22 ±  7%      +0.3        0.52 ± 20%  perf-profile.children.cycles-pp.update_blocked_averages
>        0.00            +0.3        0.31 ± 23%  perf-profile.children.cycles-pp.commit_tail
>        0.00            +0.3        0.31 ± 23%  perf-profile.children.cycles-pp.ast_mode_config_helper_atomic_commit_tail
>        0.07 ±  6%      +0.3        0.39 ± 10%  perf-profile.children.cycles-pp.read_tsc
>        0.32 ±  5%      +0.3        0.65 ± 15%  perf-profile.children.cycles-pp.schedule_timeout
>        0.05 ± 46%      +0.3        0.38 ± 32%  perf-profile.children.cycles-pp.tick_irq_enter
>        0.00            +0.3        0.33 ± 24%  perf-profile.children.cycles-pp.drm_atomic_commit
>        0.00            +0.3        0.33 ± 24%  perf-profile.children.cycles-pp.drm_atomic_helper_commit
>        0.00            +0.3        0.33 ± 24%  perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
>        0.06 ± 45%      +0.3        0.40 ± 27%  perf-profile.children.cycles-pp.irq_enter_rcu
>        0.10 ±  8%      +0.3        0.45 ± 12%  perf-profile.children.cycles-pp.vsnprintf
>        0.08 ± 11%      +0.4        0.44 ± 11%  perf-profile.children.cycles-pp.lapic_next_deadline
>        0.09 ± 15%      +0.4        0.45 ± 25%  perf-profile.children.cycles-pp.run_rebalance_domains
>        0.02 ±141%      +0.4        0.39 ± 27%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
>        0.02 ±141%      +0.4        0.39 ± 27%  perf-profile.children.cycles-pp.drm_fbdev_fb_dirty
>        0.18 ±  7%      +0.4        0.55 ±  6%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
>        0.21 ± 13%      +0.4        0.58 ± 11%  perf-profile.children.cycles-pp.arch_scale_freq_tick
>        0.18 ±  8%      +0.4        0.60 ± 14%  perf-profile.children.cycles-pp.__wait_for_common
>        0.10 ± 10%      +0.4        0.52 ± 17%  perf-profile.children.cycles-pp.perf_rotate_context
>        0.14 ± 12%      +0.4        0.57 ± 21%  perf-profile.children.cycles-pp.malloc
>        0.11 ± 14%      +0.5        0.58 ±  9%  perf-profile.children.cycles-pp.clockevents_program_event
>        0.13 ± 20%      +0.5        0.61 ± 19%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
>        0.37 ±  9%      +0.5        0.89 ± 13%  perf-profile.children.cycles-pp.openat64
>        0.18 ±  8%      +0.5        0.72 ± 14%  perf-profile.children.cycles-pp.rebalance_domains
>        0.07 ± 11%      +0.6        0.63 ± 21%  perf-profile.children.cycles-pp.unregister_shrinker
>        0.16 ±  7%      +0.6        0.74 ±  8%  perf-profile.children.cycles-pp.ktime_get
>        0.00            +0.6        0.59 ± 18%  perf-profile.children.cycles-pp.__synchronize_srcu
>        0.09 ± 13%      +0.6        0.70 ± 18%  perf-profile.children.cycles-pp.io_serial_in
>        0.25 ±  3%      +0.6        0.88 ± 26%  perf-profile.children.cycles-pp.siphash24_compress
>        0.16 ± 10%      +0.7        0.82 ± 12%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
>        0.11 ±  6%      +0.8        0.88 ± 15%  perf-profile.children.cycles-pp.wait_for_lsr
>        0.12 ±  6%      +0.8        0.90 ± 15%  perf-profile.children.cycles-pp.serial8250_console_write
>        0.12 ±  7%      +0.8        0.92 ± 14%  perf-profile.children.cycles-pp.irq_work_run
>        0.12 ±  7%      +0.8        0.92 ± 14%  perf-profile.children.cycles-pp._printk
>        0.12 ±  7%      +0.8        0.92 ± 14%  perf-profile.children.cycles-pp.vprintk_emit
>        0.12 ±  7%      +0.8        0.92 ± 14%  perf-profile.children.cycles-pp.console_unlock
>        0.12 ±  7%      +0.8        0.92 ± 14%  perf-profile.children.cycles-pp.console_flush_all
>        0.12 ±  7%      +0.8        0.92 ± 15%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
>        0.12 ±  7%      +0.8        0.92 ± 15%  perf-profile.children.cycles-pp.sysvec_irq_work
>        0.12 ±  7%      +0.8        0.92 ± 15%  perf-profile.children.cycles-pp.__sysvec_irq_work
>        0.12 ±  7%      +0.8        0.92 ± 15%  perf-profile.children.cycles-pp.irq_work_single
>        0.44 ±  9%      +0.8        1.24 ± 13%  perf-profile.children.cycles-pp.device_set_syspath
>        0.12 ±  5%      +0.8        0.94 ± 15%  perf-profile.children.cycles-pp.irq_work_run_list
>        0.29 ± 10%      +0.9        1.16 ± 10%  perf-profile.children.cycles-pp.show_mountinfo
>        0.48 ±  9%      +0.9        1.39 ± 11%  perf-profile.children.cycles-pp.sd_device_new_from_syspath
>        0.40 ±  9%      +1.0        1.45 ±  9%  perf-profile.children.cycles-pp.seq_read_iter
>        0.61 ±  4%      +1.1        1.76 ±  7%  perf-profile.children.cycles-pp.scheduler_tick
>        0.42 ±  9%      +1.2        1.58 ± 10%  perf-profile.children.cycles-pp.vfs_read
>        0.42 ±  8%      +1.2        1.59 ± 10%  perf-profile.children.cycles-pp.ksys_read
>        0.44 ± 10%      +1.2        1.64 ± 10%  perf-profile.children.cycles-pp.read
>        0.40 ±  8%      +1.3        1.70 ± 12%  perf-profile.children.cycles-pp.menu_select
>        3.06 ±  5%      +1.4        4.44 ± 22%  perf-profile.children.cycles-pp.osq_lock
>        0.84 ±  4%      +1.4        2.24 ±  8%  perf-profile.children.cycles-pp.__irq_exit_rcu
>        1.02 ±  3%      +2.0        3.06 ±  5%  perf-profile.children.cycles-pp.update_process_times
>        1.04 ±  3%      +2.1        3.17 ±  4%  perf-profile.children.cycles-pp.tick_sched_handle
>        1.18 ±  4%      +2.5        3.71 ±  4%  perf-profile.children.cycles-pp.tick_sched_timer
>        1.46 ±  3%      +3.8        5.24 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
>        1.70 ±  4%      +4.8        6.46 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
>        1.71 ±  4%      +4.9        6.57 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
>        2.61 ±  3%      +7.0        9.63 ±  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
>        3.30 ±  2%      +7.3       10.55 ±  5%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
>       36.61            +9.7       46.29 ±  5%  perf-profile.children.cycles-pp.intel_idle
>       40.81           +17.9       58.69 ±  5%  perf-profile.children.cycles-pp.cpuidle_enter_state
>       40.82           +17.9       58.74 ±  5%  perf-profile.children.cycles-pp.cpuidle_enter
>       42.42           +19.4       61.78 ±  5%  perf-profile.children.cycles-pp.start_secondary
>       42.74           +19.6       62.33 ±  5%  perf-profile.children.cycles-pp.do_idle
>       42.74           +19.6       62.33 ±  5%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
>       42.74           +19.6       62.33 ±  5%  perf-profile.children.cycles-pp.cpu_startup_entry
>       41.33           +19.6       60.93 ±  6%  perf-profile.children.cycles-pp.cpuidle_idle_call
>        7.20 ±  2%      -5.5        1.65 ± 19%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
>        4.96            -3.5        1.45 ± 20%  perf-profile.self.cycles-pp.memset_erms
>        3.74 ±  3%      -2.7        1.01 ± 17%  perf-profile.self.cycles-pp.path_init
>        3.76            -2.6        1.12 ± 22%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
>        1.83 ±  3%      -1.1        0.72 ± 20%  perf-profile.self.cycles-pp.mnt_get_count
>        1.82            -1.1        0.72 ± 13%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>        1.22 ±  9%      -1.1        0.16 ± 57%  perf-profile.self.cycles-pp.intel_idle_irq
>        1.15 ±  2%      -0.7        0.48 ± 24%  perf-profile.self.cycles-pp.pcpu_alloc
>        0.81 ±  3%      -0.6        0.24 ± 23%  perf-profile.self.cycles-pp.lookup_mnt
>        1.02            -0.5        0.52 ± 23%  perf-profile.self.cycles-pp._find_next_bit
>        0.94 ±  2%      -0.5        0.47 ± 13%  perf-profile.self.cycles-pp.stress_rndstr
>        1.57 ±  2%      -0.4        1.14 ± 13%  perf-profile.self.cycles-pp._raw_spin_lock
>        0.49 ±  4%      -0.4        0.14 ± 31%  perf-profile.self.cycles-pp.__sync_rcu_exp_select_node_cpus
>        0.74 ±  5%      -0.3        0.41 ± 28%  perf-profile.self.cycles-pp.smp_call_function_single
>        0.55 ±  5%      -0.3        0.27 ± 25%  perf-profile.self.cycles-pp.mnt_get_writers
>        0.30 ±  8%      -0.2        0.06 ± 54%  perf-profile.self.cycles-pp.free_percpu
>        0.25 ±  7%      -0.2        0.07 ± 48%  perf-profile.self.cycles-pp.pcpu_alloc_area
>        0.27 ±  4%      -0.2        0.09 ± 38%  perf-profile.self.cycles-pp.__list_del_entry_valid
>        0.23 ±  4%      -0.2        0.05 ± 76%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
>        0.27 ±  9%      -0.2        0.10 ±  9%  perf-profile.self.cycles-pp.__slab_free
>        0.19 ±  7%      -0.2        0.03 ±101%  perf-profile.self.cycles-pp.rcu_exp_handler
>        0.30 ± 11%      -0.2        0.14 ± 23%  perf-profile.self.cycles-pp.__schedule
>        0.25 ±  9%      -0.1        0.10 ± 25%  perf-profile.self.cycles-pp.llist_add_batch
>        0.23 ±  7%      -0.1        0.10 ± 31%  perf-profile.self.cycles-pp._find_next_zero_bit
>        0.19 ± 10%      -0.1        0.06 ± 83%  perf-profile.self.cycles-pp.rcu_report_exp_cpu_mult
>        0.28 ±  7%      -0.1        0.16 ± 18%  perf-profile.self.cycles-pp.mutex_spin_on_owner
>        0.22 ±  6%      -0.1        0.09 ± 29%  perf-profile.self.cycles-pp.mntput_no_expire
>        0.26 ±  7%      -0.1        0.13 ± 21%  perf-profile.self.cycles-pp.__legitimize_mnt
>        0.44            -0.1        0.32 ± 11%  perf-profile.self.cycles-pp.strncpy_from_user
>        0.15 ±  6%      -0.1        0.03 ±106%  perf-profile.self.cycles-pp.mutex_lock_killable
>        0.21 ± 11%      -0.1        0.09 ± 15%  perf-profile.self.cycles-pp.step_into
>        0.15 ±  7%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.llist_reverse_order
>        0.18 ±  5%      -0.1        0.07 ± 16%  perf-profile.self.cycles-pp.lockref_get
>        0.16 ±  5%      -0.1        0.04 ± 73%  perf-profile.self.cycles-pp.down_write
>        0.16 ±  7%      -0.1        0.04 ± 73%  perf-profile.self.cycles-pp.__list_add_valid
>        0.15 ±  8%      -0.1        0.04 ± 73%  perf-profile.self.cycles-pp.get_nr_dirty_inodes
>        0.15 ±  6%      -0.1        0.04 ± 75%  perf-profile.self.cycles-pp.pcpu_next_fit_region
>        0.23 ±  6%      -0.1        0.13 ± 10%  perf-profile.self.cycles-pp.stress_mwc32
>        0.14 ±  6%      -0.1        0.05 ± 76%  perf-profile.self.cycles-pp.up_write
>        0.16 ±  7%      -0.1        0.06 ± 11%  perf-profile.self.cycles-pp.get_nr_inodes
>        0.12 ± 13%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.__lookup_mnt
>        0.12 ±  6%      -0.1        0.03 ±108%  perf-profile.self.cycles-pp.__bitmap_clear
>        0.18 ±  5%      -0.1        0.10 ± 18%  perf-profile.self.cycles-pp.__d_lookup_rcu
>        0.18 ±  4%      -0.1        0.11 ± 27%  perf-profile.self.cycles-pp.lockref_put_return
>        0.11 ± 11%      -0.1        0.03 ±101%  perf-profile.self.cycles-pp.apparmor_capable
>        0.16 ±  6%      -0.1        0.08 ± 17%  perf-profile.self.cycles-pp.mutex_unlock
>        0.15 ±  8%      -0.1        0.08 ± 17%  perf-profile.self.cycles-pp.task_work_add
>        0.16 ±  8%      -0.1        0.09 ± 14%  perf-profile.self.cycles-pp.__call_rcu_common
>        0.12 ± 23%      -0.1        0.06 ± 52%  perf-profile.self.cycles-pp.enqueue_task_fair
>        0.12 ± 10%      -0.0        0.07 ± 30%  perf-profile.self.cycles-pp._raw_read_lock_irqsave
>        0.11 ±  9%      -0.0        0.08 ± 21%  perf-profile.self.cycles-pp.__switch_to
>        0.09 ±  9%      -0.0        0.06 ± 14%  perf-profile.self.cycles-pp.rcu_all_qs
>        0.08 ± 10%      +0.0        0.12 ± 15%  perf-profile.self.cycles-pp.load_balance
>        0.00            +0.1        0.07 ± 21%  perf-profile.self.cycles-pp.show_mountinfo
>        0.00            +0.1        0.07 ± 27%  perf-profile.self.cycles-pp.tick_nohz_tick_stopped
>        0.00            +0.1        0.07 ± 29%  perf-profile.self.cycles-pp.siphash24_init
>        0.00            +0.1        0.07 ± 18%  perf-profile.self.cycles-pp._hashmap_iterate
>        0.00            +0.1        0.08 ± 21%  perf-profile.self.cycles-pp.string_escape_mem
>        0.00            +0.1        0.08 ± 16%  perf-profile.self.cycles-pp.up_read
>        0.00            +0.1        0.08 ± 32%  perf-profile.self.cycles-pp.sysvec_apic_timer_interrupt
>        0.11 ±  6%      +0.1        0.18 ± 14%  perf-profile.self.cycles-pp.rcu_pending
>        0.16 ±  6%      +0.1        0.24 ± 16%  perf-profile.self.cycles-pp.ct_kernel_exit_state
>        0.00            +0.1        0.08 ± 27%  perf-profile.self.cycles-pp.down_read
>        0.04 ± 71%      +0.1        0.12 ± 27%  perf-profile.self.cycles-pp.__update_blocked_fair
>        0.04 ± 44%      +0.1        0.13 ± 17%  perf-profile.self.cycles-pp.do_idle
>        0.00            +0.1        0.09 ± 32%  perf-profile.self.cycles-pp.__irq_exit_rcu
>        0.00            +0.1        0.09 ± 24%  perf-profile.self.cycles-pp.__do_softirq
>        0.00            +0.1        0.09 ± 44%  perf-profile.self.cycles-pp.rebalance_domains
>        0.00            +0.1        0.09 ± 13%  perf-profile.self.cycles-pp.strchr
>        0.01 ±223%      +0.1        0.10 ± 22%  perf-profile.self.cycles-pp.prepend_path
>        0.00            +0.1        0.10 ± 23%  perf-profile.self.cycles-pp.number
>        0.06 ± 11%      +0.1        0.17 ± 17%  perf-profile.self.cycles-pp.memcpy_erms
>        0.04 ± 71%      +0.1        0.14 ± 14%  perf-profile.self.cycles-pp.cfree
>        0.00            +0.1        0.11 ± 12%  perf-profile.self.cycles-pp.vsnprintf
>        0.00            +0.1        0.11 ± 26%  perf-profile.self.cycles-pp.strlen
>        0.04 ± 71%      +0.1        0.15 ± 34%  perf-profile.self.cycles-pp.ct_kernel_enter
>        0.00            +0.1        0.11 ± 15%  perf-profile.self.cycles-pp.hrtimer_interrupt
>        0.00            +0.1        0.11 ± 22%  perf-profile.self.cycles-pp.timerqueue_add
>        0.11 ± 12%      +0.1        0.22 ±  8%  perf-profile.self.cycles-pp._raw_spin_trylock
>        0.00            +0.1        0.12 ± 29%  perf-profile.self.cycles-pp.scheduler_tick
>        0.00            +0.1        0.12 ± 24%  perf-profile.self.cycles-pp.rdrand
>        0.01 ±223%      +0.1        0.13 ± 23%  perf-profile.self.cycles-pp.tick_nohz_next_event
>        0.04 ± 71%      +0.1        0.16 ± 14%  perf-profile.self.cycles-pp.irqtime_account_irq
>        0.00            +0.1        0.13 ± 17%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
>        0.00            +0.1        0.14 ± 26%  perf-profile.self.cycles-pp.irqtime_account_process_tick
>        0.00            +0.1        0.14 ± 17%  perf-profile.self.cycles-pp.format_decode
>        0.15 ± 10%      +0.1        0.29 ± 33%  perf-profile.self.cycles-pp.trigger_load_balance
>        0.03 ± 70%      +0.1        0.18 ± 21%  perf-profile.self.cycles-pp.siphash24_finalize
>        0.00            +0.1        0.14 ± 34%  perf-profile.self.cycles-pp.perf_rotate_context
>        0.01 ±223%      +0.1        0.16 ± 28%  perf-profile.self.cycles-pp.strchr@plt
>        0.00            +0.2        0.15 ± 24%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
>        0.06 ± 13%      +0.2        0.21 ± 21%  perf-profile.self.cycles-pp.path_compare
>        0.10 ± 37%      +0.2        0.26 ± 28%  perf-profile.self.cycles-pp.tick_sched_do_timer
>        0.01 ±223%      +0.2        0.17 ± 24%  perf-profile.self.cycles-pp.update_process_times
>        0.02 ± 99%      +0.2        0.18 ± 21%  perf-profile.self.cycles-pp.cpuidle_idle_call
>        0.01 ±223%      +0.2        0.18 ± 15%  perf-profile.self.cycles-pp.delay_tsc
>        0.00            +0.2        0.17 ± 21%  perf-profile.self.cycles-pp.device_read_db_internal_filename
>        0.03 ±100%      +0.2        0.20 ± 16%  perf-profile.self.cycles-pp.check_cpu_stall
>        0.07 ± 17%      +0.2        0.25 ± 24%  perf-profile.self.cycles-pp.update_irq_load_avg
>        0.00            +0.2        0.19 ± 20%  perf-profile.self.cycles-pp.__hrtimer_run_queues
>        0.02 ±141%      +0.2        0.22 ± 31%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
>        0.21 ± 13%      +0.2        0.42 ±  5%  perf-profile.self.cycles-pp.native_sched_clock
>        0.05 ± 46%      +0.2        0.29 ± 10%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
>        0.22 ±  4%      +0.2        0.46 ±  6%  perf-profile.self.cycles-pp.native_irq_return_iret
>        0.17 ±  9%      +0.3        0.46 ± 35%  perf-profile.self.cycles-pp.unit_name_is_valid
>        0.00            +0.3        0.30 ± 19%  perf-profile.self.cycles-pp.memcpy_toio
>        0.10 ± 10%      +0.3        0.41 ± 17%  perf-profile.self.cycles-pp.ktime_get
>        0.07 ±  9%      +0.3        0.38 ± 10%  perf-profile.self.cycles-pp.read_tsc
>        0.08 ± 11%      +0.4        0.44 ± 11%  perf-profile.self.cycles-pp.lapic_next_deadline
>        0.21 ± 13%      +0.4        0.58 ± 11%  perf-profile.self.cycles-pp.arch_scale_freq_tick
>        0.12 ± 10%      +0.4        0.55 ± 21%  perf-profile.self.cycles-pp.malloc
>        0.09 ± 13%      +0.6        0.70 ± 18%  perf-profile.self.cycles-pp.io_serial_in
>        0.24 ±  6%      +0.6        0.84 ± 26%  perf-profile.self.cycles-pp.siphash24_compress
>        0.21 ± 10%      +0.6        0.86 ±  6%  perf-profile.self.cycles-pp.menu_select
>        0.20 ±  2%      +0.9        1.13 ± 12%  perf-profile.self.cycles-pp.cpuidle_enter_state
>        3.02 ±  5%      +1.4        4.40 ± 22%  perf-profile.self.cycles-pp.osq_lock
>       36.61            +9.7       46.29 ±  5%  perf-profile.self.cycles-pp.intel_idle
> 
> 
> To reproduce:
> 
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          sudo bin/lkp install job.yaml           # job file is attached in this email
>          bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>          sudo bin/lkp run generated-yaml-file
> 
>          # if come across any failure that blocks the test,
>          # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 

-- 
Thanks,
Qi
