Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75DD66D4C9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbjAQC5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235752AbjAQC4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:56:53 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AA1302BF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:53:40 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NwthG5tvrznVKx;
        Tue, 17 Jan 2023 10:51:42 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 17 Jan 2023 10:53:25 +0800
CC:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        <yangyicong@hisilicon.com>, Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v4 0/2] sched/fair: Choose the CPU where short task is
 running during wake up
To:     Chen Yu <yu.c.chen@intel.com>
References: <cover.1671158588.git.yu.c.chen@intel.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <5910589f-fe3e-5999-5821-7b2b8021e74b@huawei.com>
Date:   Tue, 17 Jan 2023 10:53:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <cover.1671158588.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen Yu,

On 2022/12/16 14:08, Chen Yu wrote:
> The main purpose of this change is to avoid too many cross CPU
> wake up when it is unnecessary. The frequent cross CPU wake up
> brings significant damage to some workloads, especially on high
> core count systems.
> 
> This patch set inhibits the cross CPU wake-up by placing the wakee
> on waking CPU or previous CPU, if both the waker and wakee are
> short-duration tasks.
> 
> The first patch is to introduce the definition of a short-duration
> task. The second patch leverages the first patch to choose a local
> or previous CPU for wakee.
> 

Tested with tbench and netperf locally and MySQL remotely. Unluckily
cannot reproduce the improvement and see some regression. Detailed
information below. The tests are done based on 6.2-rc1 on a 2x64 CPUs
Kunpeng 920 server with 4 nodes and no SMT, CONFIG_SCHED_CLUSTER
enabled.

For tbench and netperf tested on single node and two nodes on one socket.

tbench(node 0)
             vanilla                   sis_short
  1:        326.2950        312.3700 (   -4.27%)
  4:       1299.7700       1241.3400 (   -4.50%)
  8:       2613.2900       2476.4700 (   -5.24%)
 16:       5091.9400       5096.3100 (    0.09%)
 32:      10104.1000       9905.8500 (   -1.96%)
 64:       7558.8500       7826.2000 (    3.54%)
128:       6641.4000       6608.6600 (   -0.49%)

tbench(node 0-1)
             vanilla                   sis_short
  1:        328.0880        313.5830 (   -4.42%)
  4:       1318.4700       1237.2100 (   -6.16%)
  8:       2546.1700       2372.5900 (   -6.82%)
 16:       5147.1700       4651.3400 (   -9.63%)
 32:       9275.1100       8772.0100 (   -5.42%)
 64:      17526.6000      17918.8000 (    2.23%)
128:      13108.1000      13317.0000 (    1.59%)

netperf TCP_RR(node 0)
              vanilla                   sis_short
  1:      76444.3100      72681.4200 (   -4.92%)
  4:      77615.7475      73436.4575 (   -5.38%)
  8:      78066.5887      69473.9312 (  -11.01%)
 16:      77134.8562      76473.4144 (   -0.86%)
 32:      76626.3322      63785.1650 (  -16.76%)
 64:      29072.7872      24552.9916 (  -15.55%)
128:      11875.6830      10532.4508 (  -11.31%)

netperf TCP_RR(node 0-1)
              vanilla                   sis_short
  1:      77645.3700      72879.3300 (   -6.14%)
  4:      78180.0150      72926.2225 (   -6.72%)
  8:      77878.7675      66724.6137 (  -14.32%)
 16:      77427.6944      65682.6012 (  -15.17%)
 32:      71774.5309      71887.1747 (    0.16%)
 64:      75023.3972      62730.7395 (  -16.39%)
128:      28468.2309      25048.1859 (  -12.01%)

netperf UDP_RR(node 0)
              vanilla                   sis_short
  1:      91614.6400      89437.6600 (   -2.38%)
  4:      91926.3425      90511.9750 (   -1.54%)
  8:      92596.4850      87336.7162 (   -5.68%)
 16:      91803.2525      95212.5069 (    3.71%)
 32:      98482.9212      79793.1803 (  -18.98%)
 64:      36373.5367      30577.2208 (  -15.94%)
128:      14440.2914      12727.7759 (  -11.86%)

netperf UDP_RR(node 0-1)
              vanilla                   sis_short
  1:      92609.3400      90915.8600 (   -1.83%)
  4:      93034.8425      91742.4825 (   -1.39%)
  8:      91963.3950      85801.8250 (   -6.70%)
 16:      91589.4900      83339.7944 (   -9.01%)
 32:      83161.0234      90298.3934 (    8.58%)
 64:      88860.0155      74933.8544 (  -15.67%)
128:      24715.9842      28022.6998 (   13.38%)

MySQL tests are done among two servers with same hardware setup and kernel
updated on both kernel. Network device locates on node 0 and network
interrupts is balanced evenly by irqbalance. No NUMA binding applied.

oltp_read_only
8-TPS		4315.11		4236.45		-1.82%
8-QPS		69041.74	67783.19	-1.82%
8-avg-lat	1.85		1.89		-1.98%
8-95th-lat	2.14		2.24		-4.35%
16-TPS		8315.80		7993.78		-3.87%
16-QPS		133052.87	127900.49	-3.87%
16-avg-lat	1.92		2.00		-3.99%
16-95th-lat	2.36		2.60		-10.17%
24-TPS		11601.29	11387.88	-1.84%
24-QPS		185620.63	182206.08	-1.84%
24-avg-lat	2.07		2.11		-1.94%
24-95th-lat	2.61		2.74		-4.97%
32-TPS		13882.59	13277.71	-4.36%
32-QPS		222121.46	212443.37	-4.36%
32-avg-lat	2.31		2.41		-4.48%
32-95th-lat	2.93		3.38		-15.47%
64-TPS		17558.38	16200.13	-7.74%
64-QPS		280934.13	259202.00	-7.74%
64-avg-lat	3.64		3.95		-8.42%
64-95th-lat	5.12		5.40		-5.53%
96-TPS		21858.44	21104.80	-3.45%
96-QPS		349735.03	337676.78	-3.45%
96-avg-lat	4.39		4.55		-3.57%
96-95th-lat	5.92		6.09		-2.93%
128-TPS		24633.09	24278.48	-1.44%
128-QPS		394129.44	388455.76	-1.44%
128-avg-lat	5.19		5.27		-1.54%
128-95th-lat	6.51		6.79		-4.30%
256-TPS		40793.59	41878.29	2.66%
256-QPS		652697.45	670052.64	2.66%
256-avg-lat	6.27		6.11		2.55%
256-95th-lat	9.67		9.79		-1.21%
512-TPS		50461.71	50593.95	0.26%
512-QPS		807387.36	809503.29	0.26%
512-avg-lat	10.13		10.10		0.30%
512-95th-lat	14.64		14.73		-0.61%
700-TPS		50848.04	50899.43	0.10%
700-QPS		813568.68	814390.94	0.10%
700-avg-lat	13.74		13.73		0.10%
700-95th-lat	18.95		19.06		-0.60%

Further looked into 64 threads since it regress most and mainly looked on the
server(mysqld) side. In this case most loads will be on node 0 and partly
on node 1. With SIS_SHORT the utilization on node 0 keeps almost the same
but utilization on node 1 remains nearly half comparing to baseline. That
may partly answers why the performance decreases.

mpstat 60s, non-idle%
	vanilla	sis_short	
node 0	94.25	91.67	-2.73%
node 1	46.41	30.03	-35.29%

Previously there's argument that sync wakeup from interrupts maybe incorrectly
and SIS_SHORT seems to consolidate that and tie more tasks on the interrupt node.

SIS_SHORT will likely to make short tasks wakeup locally but seems to increase the
wait time in this case. schedstat for CPUs on node 0 shows:

                        vanilla               sis_short
time elapsed            60.201085s            60.200395s
[cpu Average, counts/sec]
#0 cpu zeros            0.0                   0.0
#1 sched_yied()         0.03                  0.12
#2 zeros                0.0                   0.0
#3 schedule()           409415.36             340304.86
#4 sched->idle()        125616.92             91078.52
#5 try_to_wake_up()     317404.25             280896.88
#6 try_to_wakeup(local) 115451.87             140567.68
#7 run time             26071494674.87        26164834556.84
#8 wait time            3861592891.75         7361228637.54 (+ 90.63%)
#9 timeslices,          283747.1              249182.34

Since it's a 128 CPU machine the min_granularity is 3000000ns which means a short
task running within 375000ns. Most mysql worker threads' se.dur_avg is around
110000ns and will be regarded as short tasks.

To exclude the influence of Patch 1 (which we'll always record the dur_avg and related
informations), tested 64 threads case with SIS_SHORT enabled or not through debugfs
control and seems Patch 2 mainly dominate the results.

		NO_SIS_SHORT	SIS_SHORT	
TPS		17446.54	16464.83	-5.63%
QPS		279144.61	263437.21	-5.63%
avg lat		3.67		3.89		-5.99%
95th lat	5.09		5.37		-5.50%

Please let me know if you need more information.

Thanks.

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
> This change brings overall improvement on some microbenchmarks, both on
> Intel and AMD platforms.
> 
> v3: https://lore.kernel.org/lkml/cover.1669862147.git.yu.c.chen@intel.com/
> v2: https://lore.kernel.org/all/cover.1666531576.git.yu.c.chen@intel.com/
> v1: https://lore.kernel.org/lkml/20220915165407.1776363-1-yu.c.chen@intel.com/
> 
> Chen Yu (2):
>   sched/fair: Introduce short duration task check
>   sched/fair: Choose the CPU where short task is running during wake up
> 
>  include/linux/sched.h   |  3 +++
>  kernel/sched/core.c     |  2 ++
>  kernel/sched/debug.c    |  1 +
>  kernel/sched/fair.c     | 32 ++++++++++++++++++++++++++++++++
>  kernel/sched/features.h |  1 +
>  5 files changed, 39 insertions(+)
> 
