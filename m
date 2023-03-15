Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCFC6BAC3E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjCOJfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjCOJes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:34:48 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616894C02
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:34:46 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Pc4sb13Rfz17KWQ;
        Wed, 15 Mar 2023 17:31:47 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 17:34:43 +0800
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>, <yangyicong@hisilicon.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, Hillf Danton <hdanton@sina.com>,
        kernel test robot <yujie.liu@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 0/2] sched/fair: Wake short task on current CPU
To:     Chen Yu <yu.c.chen@intel.com>
References: <cover.1677069490.git.yu.c.chen@intel.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <718acf0e-2c98-cff3-98f4-da43d49f776b@huawei.com>
Date:   Wed, 15 Mar 2023 17:34:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <cover.1677069490.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chenyu,

On 2023/2/22 22:09, Chen Yu wrote:
> The main purpose is to avoid too many cross CPU wake up when it is
> unnecessary. The frequent cross CPU wake up brings significant damage
> to some workloads, especially on high core count systems.
> 
> Inhibits the cross CPU wake-up by placing the wakee on waking CPU,
> if both the waker and wakee are short-duration tasks. The short
> duration task could become a trouble maker on high-load system,
> because it could bring frequent context switch. This strategy
> only takes effect when the system is busy. Because it is unreasonable
> to inhibit the idle CPU scan when there are still idle CPUs.
> 
> First, introduce the definition of a short-duration task. Then
> leverages the first patch to choose a local CPU for wakee.
> 
> Overall there is performance improvement on some overloaded case.
> Such as will-it-scale, netperf. And no noticeable impact on
> schbench, hackbench, tbench and a OLTP workload with a commercial
> RDBMS, tested on a Intel Xeon 2 x 56C machine.
> 
> Per the test on Zen3 from Prateek, most benchmarks result saw small
> wins or are comparable to sched:tip. SpecJBB Critical-jOps improved while
> Max-jOPS saw a small hit, but it might be in the expected range.
> ycsb-mongodb saw small uplift in NPS1 mode.
> 
> Throughput improvement of netperf(localhost) was observed on a
> Rome 2 x 64C machine, when the number of clients equals the CPUs.
> 
> Abel reported against a latency regression from Redis on an overloaded
> system. Inspired by his description, v5 added the check of wakee_flips
> to mitigate task stacking.
> 
> Changes since v5:
> 1. Check the wakee_flips of the waker/wakee. If the wakee_flips
>    of waker/wakee are both 0, it indicates that the waker and the wakee
>    are waking up each other. In this case, put them together on the
>    same CPU. This is to avoid that too many wakees are stacked on
>    one CPU, which might cause regression on redis.
> 

The patch looks good to me. And for the v6 version there's no significant
regression on our server. :)

Detailed results below. The setup are the same as what used on v4. There're
some gain for UDP_RR. For mysql no significant regression, there're ~2%
loss for 128 threads case but the proportion is within the fluctuation
range so it should be ok.

Thanks,
Yicong

tbench results (node 0):
Compare
      6.3-rc1-vanilla                sis-short-v6
  1:        322.2940        324.6750 (    0.74%)
  4:       1293.4000       1294.2900 (    0.07%)
  8:       2568.7700       2606.9200 (    1.49%)
 16:       5158.0800       5254.5500 (    1.87%)
 32:      10074.2000      10286.9000 (    2.11%)
 64:       7910.5000       7969.1000 (    0.74%)
128:       6670.3900       6699.7600 (    0.44%)
tbench results (node 0-1):
Compare
      6.3-rc1-vanilla                sis-short-v6
  1:        324.5650        330.9840 (    1.98%)
  4:       1302.9000       1311.3300 (    0.65%)
  8:       2573.7200       2615.5500 (    1.63%)
 16:       5092.7900       5178.4200 (    1.68%)
 32:       8766.8000       9466.6700 (    7.98%)
 64:      16859.5000      16535.2000 (   -1.92%)
128:      13673.6000      11960.7000 (  -12.53%)
128:      13673.6000      13066.6000 (   -4.43%) [verification]

netperf results TCP_RR (node 0):
Compare
      6.3-rc1-vanilla                sis-short-v6
  1:      74952.4633      74964.7067 (    0.02%)
  4:      76020.1192      75984.1158 (   -0.05%)
  8:      76698.5804      76846.1312 (    0.19%)
 16:      77713.0350      77858.9752 (    0.19%)
 32:      65947.7090      66124.5758 (    0.27%)
 64:      25195.1539      25374.4948 (    0.71%)
128:      10602.2112      10703.6223 (    0.96%)
netperf results TCP_RR (node 0-1):
Compare
      6.3-rc1-vanilla                sis-short-v6
  1:      76229.5167      76178.0700 (   -0.07%)
  4:      77196.7558      76546.3333 (   -0.84%)
  8:      76340.5733      76612.0829 (    0.36%)
 16:      75808.3848      75132.6454 (   -0.89%)
 32:      75178.5653      71464.7628 (   -4.94%)
 64:      75222.3510      76028.7949 (    1.07%)
128:      28552.5946      28830.6498 (    0.97%)
netperf results UDP_RR (node 0):
Compare
      6.3-rc1-vanilla                sis-short-v6
  1:      90744.2900      94082.3967 (    3.68%)
  4:      92323.3100      95160.6525 (    3.07%)
  8:      92951.3996      96303.9783 (    3.61%)
 16:      93418.8117      97358.5925 (    4.22%)
 32:      78725.5393      84363.7384 (    7.16%)
 64:      30069.7350      30929.4379 (    2.86%)
128:      12501.6386      12695.0588 (    1.55%)
netperf results UDP_RR (node 0-1):
Compare
      6.3-rc1-vanilla                sis-short-v6
  1:      92030.0200      95568.9767 (    3.85%)
  4:      90041.0042      94265.9775 (    4.69%)
  8:      90273.7354      94055.1283 (    4.19%)
 16:      90404.9869      95233.8633 (    5.34%)
 32:      74813.0918      83538.5368 (   11.66%) [*]
 64:      57494.5351      74612.3866 (   29.77%) [*]
128:      24803.3562      16420.1439 (  -33.80%) [*]
[*] untrustworthy due to large fluactuation

               6.3.0-rc1-vanilla     6.3.0-rc1-sis-short-v6
                       Avg                 Avg (%)
     TPS-8       4496.25         4520.99 (0.55%)
     QPS-8      71940.01        72335.93 (0.55%)
 avg_lat-8          1.78            1.77 (0.38%)
95th_lat-8          2.10            2.11 (-0.48%)
     TPS-16      8905.41         8844.63 (-0.68%)
     QPS-16     142486.59       141514.08 (-0.68%)
 avg_lat-16         1.80            1.81 (-0.56%)
95th_lat-16         2.18            2.23 (-2.45%)
     TPS-32     14214.88        14378.30 (1.15%)
     QPS-32     227438.14       230052.76 (1.15%)
 avg_lat-32         2.25            2.22 (1.19%)
95th_lat-32         3.06            2.95 (3.70%)
     TPS-64     14697.57        14801.04 (0.70%)
     QPS-64     235161.20       236816.57 (0.70%)
 avg_lat-64         4.35            4.32 (0.69%)
95th_lat-64         6.51            6.39 (1.79%)
     TPS-128    18417.83        18010.42 (-2.21%)
     QPS-128    294685.24       288166.68 (-2.21%)
 avg_lat-128        6.97            7.13 (-2.30%)
95th_lat-128       10.22           10.46 (-2.35%)
     TPS-256    29940.82        30491.62 (1.84%)
     QPS-256    479053.21       487865.89 (1.84%)
 avg_lat-256        8.54            8.41 (1.60%)
95th_lat-256       13.22           13.55 (-2.50%)

> Changes since v4:
> 1. Dietmar has commented on the task duration calculation. So refined
>    the commit log to reduce confusion.
> 2. Change [PATCH 1/2] to only record the average duration of a task.
>    So this change could benefit UTIL_EST_FASTER[1].
> 3. As v4 reported regression on Zen3 and Kunpeng Arm64, add back
>    the system average utilization restriction that, if the system
>    is not busy, do not enable the short wake up. Above logic has
>    shown improvment on Zen3[2].
> 4. Restrict the wakeup target to be current CPU, rather than both
>    current CPU and task's previous CPU. This could also benefit
>    wakeup optimization from interrupt in the future, which is
>    suggested by Yicong.
> 
> Changes since v3:
> 1. Honglei and Josh have concern that the threshold of short
>    task duration could be too long. Decreased the threshold from
>    sysctl_sched_min_granularity to (sysctl_sched_min_granularity / 8),
>    and the '8' comes from get_update_sysctl_factor().
> 2. Export p->se.dur_avg to /proc/{pid}/sched per Yicong's suggestion.
> 3. Move the calculation of average duration from put_prev_task_fair()
>    to dequeue_task_fair(). Because there is an issue in v3 that,
>    put_prev_task_fair() will not be invoked by pick_next_task_fair()
>    in fast path, thus the dur_avg could not be updated timely.
> 4. Fix the comment in PATCH 2/2, that "WRITE_ONCE(CPU1->ttwu_pending, 1);"
>    on CPU0 is earlier than CPU1 getting "ttwu_list->p0", per Tianchen.
> 5. Move the scan for CPU with short duration task from select_idle_cpu()
>    to select_idle_siblings(), because there is no CPU scan involved, per
>    Yicong.
> 
> Changes since v2:
> 
> 1. Peter suggested comparing the duration of waker and the cost to
>    scan for an idle CPU: If the cost is higher than the task duration,
>    do not waste time finding an idle CPU, choose the local or previous
>    CPU directly. A prototype was created based on this suggestion.
>    However, according to the test result, this prototype does not inhibit
>    the cross CPU wakeup and did not bring improvement. Because the cost
>    to find an idle CPU is small in the problematic scenario. The root
>    cause of the problem is a race condition between scanning for an idle
>    CPU and task enqueue(please refer to the commit log in PATCH 2/2).
>    So v3 does not change the core logic of v2, with some refinement based
>    on Peter's suggestion.
> 
> 2. Simplify the logic to record the task duration per Peter and Abel's suggestion.
> 
> 
> [1] https://lore.kernel.org/lkml/c56855a7-14fd-4737-fc8b-8ea21487c5f6@arm.com/
> [2] https://lore.kernel.org/all/cover.1666531576.git.yu.c.chen@intel.com/
> 
> v5: https://lore.kernel.org/lkml/cover.1675361144.git.yu.c.chen@intel.com/
> v4: https://lore.kernel.org/lkml/cover.1671158588.git.yu.c.chen@intel.com/
> v3: https://lore.kernel.org/lkml/cover.1669862147.git.yu.c.chen@intel.com/
> v2: https://lore.kernel.org/all/cover.1666531576.git.yu.c.chen@intel.com/
> v1: https://lore.kernel.org/lkml/20220915165407.1776363-1-yu.c.chen@intel.com/
> 
> Chen Yu (2):
>   sched/fair: Record the average duration of a task
>   sched/fair: Introduce SIS_SHORT to wake up short task on current CPU
> 
>  include/linux/sched.h   |  3 +++
>  kernel/sched/core.c     |  2 ++
>  kernel/sched/debug.c    |  1 +
>  kernel/sched/fair.c     | 49 +++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/features.h |  1 +
>  5 files changed, 56 insertions(+)
> 
