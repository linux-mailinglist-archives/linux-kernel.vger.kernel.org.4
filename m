Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F7B70BE96
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbjEVMm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbjEVMmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:42:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87902AC
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 05:42:23 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QPxqg0RdYzsRtx;
        Mon, 22 May 2023 20:40:15 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 20:42:19 +0800
CC:     <yangyicong@hisilicon.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <tim.c.chen@linux.intel.com>,
        <gautham.shenoy@amd.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <jonathan.cameron@huawei.com>,
        <ego@linux.vnet.ibm.com>, <srikar@linux.vnet.ibm.com>,
        <linuxarm@huawei.com>, <21cnbao@gmail.com>,
        <guodong.xu@linaro.org>, <hesham.almatary@huawei.com>,
        <john.garry@huawei.com>, <shenyang39@huawei.com>,
        <kprateek.nayak@amd.com>, <wuyun.abel@bytedance.com>,
        <tim.c.chen@intel.com>
Subject: Re: [RESEND PATCH v7 2/2] sched/fair: Scan cluster before scanning
 LLC in wake-up path
To:     Chen Yu <yu.c.chen@intel.com>
References: <20220915073423.25535-1-yangyicong@huawei.com>
 <20220915073423.25535-3-yangyicong@huawei.com>
 <ZGsLy83wPIpamy6x@chenyu5-mobl1>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <46e8d4fc-993b-e1d6-5e4c-cb33513d7888@huawei.com>
Date:   Mon, 22 May 2023 20:42:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <ZGsLy83wPIpamy6x@chenyu5-mobl1>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen,

On 2023/5/22 14:29, Chen Yu wrote:
> Hi Yicong,
> On 2022-09-15 at 15:34:23 +0800, Yicong Yang wrote:
>> From: Barry Song <song.bao.hua@hisilicon.com>
>>
>> For platforms having clusters like Kunpeng920, CPUs within the same cluster
>> have lower latency when synchronizing and accessing shared resources like
>> cache. Thus, this patch tries to find an idle cpu within the cluster of the
>> target CPU before scanning the whole LLC to gain lower latency.
>>
>> Testing has been done on Kunpeng920 by pinning tasks to one numa and two
>> numa. On Kunpeng920, Each numa has 8 clusters and each cluster has 4 CPUs.
>>
>> With this patch, We noticed enhancement on tbench within one numa or cross
>> two numa.
>>
>> On numa 0:
>>                              6.0-rc1                patched
>> Hmean     1        351.20 (   0.00%)      396.45 *  12.88%*
>> Hmean     2        700.43 (   0.00%)      793.76 *  13.32%*
>> Hmean     4       1404.42 (   0.00%)     1583.62 *  12.76%*
>> Hmean     8       2833.31 (   0.00%)     3147.85 *  11.10%*
>> Hmean     16      5501.90 (   0.00%)     6089.89 *  10.69%*
>> Hmean     32     10428.59 (   0.00%)    10619.63 *   1.83%*
>> Hmean     64      8223.39 (   0.00%)     8306.93 *   1.02%*
>> Hmean     128     7042.88 (   0.00%)     7068.03 *   0.36%*
>>
>> On numa 0-1:
>>                              6.0-rc1                patched
>> Hmean     1        363.06 (   0.00%)      397.13 *   9.38%*
>> Hmean     2        721.68 (   0.00%)      789.84 *   9.44%*
>> Hmean     4       1435.15 (   0.00%)     1566.01 *   9.12%*
>> Hmean     8       2776.17 (   0.00%)     3007.05 *   8.32%*
>> Hmean     16      5471.71 (   0.00%)     6103.91 *  11.55%*
>> Hmean     32     10164.98 (   0.00%)    11531.81 *  13.45%*
>> Hmean     64     17143.28 (   0.00%)    20078.68 *  17.12%*
>> Hmean     128    14552.70 (   0.00%)    15156.41 *   4.15%*
>> Hmean     256    12827.37 (   0.00%)    13326.86 *   3.89%*
>>
>> Note neither Kunpeng920 nor x86 Jacobsville supports SMT, so the SMT branch
>> in the code has not been tested but it supposed to work.
>>
> May I know if this is the latest version to support cluster based wakeup?
> 

Yes it's the latest version.

> I did a double check on Jacobsville(24 CPUs, 1 socket) with this patch applied.
> Overall there are obvious improvements for netperf/tbench in throughput:
> 

Thanks for the further information. The result of netperf/tbench looks good as we
image, the cluster wakeup expects to gain more benefit when the system is under
loaded or well-loaded. May I know how many CPUs sharing cluster on Jacobsvilla?

> netperf
> =======
> case            	load    	baseline(std%)	compare%( std%)
> TCP_RR          	6-threads	 1.00 (  0.59)	 +6.63 (  0.71)
> TCP_RR          	12-threads	 1.00 (  0.25)	 +5.90 (  0.16)
> TCP_RR          	18-threads	 1.00 (  0.39)	 +9.49 (  0.49)
> TCP_RR          	24-threads	 1.00 (  0.95)	 +2.61 (  0.94)
> TCP_RR          	30-threads	 1.00 (  5.01)	 +2.37 (  3.82)
> TCP_RR          	36-threads	 1.00 (  3.73)	 +2.02 (  2.97)
> TCP_RR          	42-threads	 1.00 (  3.88)	 +1.99 (  3.96)
> TCP_RR          	48-threads	 1.00 (  1.39)	 +1.74 (  1.50)
> UDP_RR          	6-threads	 1.00 (  1.31)	 +5.04 (  1.70)
> UDP_RR          	12-threads	 1.00 (  0.30)	 +8.18 (  0.20)
> UDP_RR          	18-threads	 1.00 (  0.37)	+10.94 (  0.59)
> UDP_RR          	24-threads	 1.00 (  0.84)	 +1.12 (  0.99)
> UDP_RR          	30-threads	 1.00 (  4.70)	 +1.61 (  6.54)
> UDP_RR          	36-threads	 1.00 ( 10.53)	 +1.71 (  2.67)
> UDP_RR          	42-threads	 1.00 (  2.52)	 +0.63 (  3.60)
> UDP_RR          	48-threads	 1.00 (  1.61)	 +0.12 (  1.27)
> 
> tbench
> ======
> case            	load    	baseline(std%)	compare%( std%)
> loopback        	6-threads	 1.00 (  0.60)	 +2.94 (  0.23)
> loopback        	12-threads	 1.00 (  0.11)	 +4.27 (  0.23)
> loopback        	18-threads	 1.00 (  0.12)	+13.45 (  0.14)
> loopback        	24-threads	 1.00 (  0.13)	 +0.69 (  0.24)
> loopback        	30-threads	 1.00 (  0.34)	 +0.42 (  0.15)
> loopback        	36-threads	 1.00 (  0.29)	 +0.58 (  0.07)
> loopback        	42-threads	 1.00 (  0.06)	 +0.38 (  0.45)
> loopback        	48-threads	 1.00 (  0.04)	 +0.15 (  0.68)
> 
> schbench
> ========
> case            	load    	baseline(std%)	compare%( std%)
> normal          	1-mthreads	 1.00 (  4.56)	 +3.23 (  0.00)
> normal          	2-mthreads	 1.00 (  0.00)	 +0.00 (  0.00)
> normal          	4-mthreads	 1.00 ( 11.00)	 -8.82 ( 16.66)
> normal          	8-mthreads	 1.00 (  7.10)	 -4.49 (  3.26)
> 
> hackbench
> =========
> case            	load    	baseline(std%)	compare%( std%)
> process-pipe    	1-groups	 1.00 (  0.62)	 +4.71 (  0.96)
> process-pipe    	2-groups	 1.00 (  0.84)	 +3.56 (  2.35)
> process-pipe    	4-groups	 1.00 (  1.56)	 +6.74 (  0.74)
> process-pipe    	8-groups	 1.00 ( 14.27)	 +0.85 (  8.34)
> process-sockets 	1-groups	 1.00 (  0.36)	 -8.05 (  1.54)
> process-sockets 	2-groups	 1.00 (  3.19)	 +1.77 (  2.39)
> process-sockets 	4-groups	 1.00 (  1.86)	-29.10 (  2.63)
> process-sockets 	8-groups	 1.00 (  1.77)	 -2.94 (  1.55)
> threads-pipe    	1-groups	 1.00 (  0.74)	 +6.62 (  0.94)
> threads-pipe    	2-groups	 1.00 (  1.28)	 +7.50 (  0.93)
> threads-pipe    	4-groups	 1.00 (  0.80)	 +8.72 (  4.54)
> threads-pipe    	8-groups	 1.00 (  8.77)	 +6.49 (  7.49)
> threads-sockets 	1-groups	 1.00 (  0.43)	 -4.35 (  0.27)
> threads-sockets 	2-groups	 1.00 (  0.35)	 -5.60 (  1.86)
> threads-sockets 	4-groups	 1.00 (  0.61)	-26.87 (  2.35)
> threads-sockets 	8-groups	 1.00 (  0.81)	 -6.60 (  0.62)
> 
> And there is regression from hackbench in socket mode, especially in
> 4 groups case.
> 
> In 4 groups case, the fd descriptors of each hackbench group is 3, so there
> are 3 x 4 x 2 = 24 tasks in the system, which is the same number
> as the online CPUs.
> 
> I added schedstats trace and found that it was due to target CPU(becauase the
> idle CPU scan in select_idle_sibling() failed) is chosen more offen than
> the previous CPU with this patch applied. And with this patch applied, when
> there are 4 groups of hackbench, some CPUs are around 80% utilization, while
> without the patch applied, every CPU is nearly 100% utilized. This suggested
> that, task migration is unnecessary in this case, just to put the wakee on its
> previous CPU is optimal and could mitigate race condition. I did an experiment
> to keep the cpus_share_cache() as it is when checking prev cpu and recent_used_cpu,
> the regression was gone(comment below).

Thanks for the information, see the reply below...

>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
>> [https://lore.kernel.org/lkml/Ytfjs+m1kUs0ScSn@worktop.programming.kicks-ass.net]
>> Tested-by: Yicong Yang <yangyicong@hisilicon.com>
>> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
>> Reviewed-by: Chen Yu <yu.c.chen@intel.com>
>> ---
>>  kernel/sched/fair.c     | 30 +++++++++++++++++++++++++++---
>>  kernel/sched/sched.h    |  1 +
>>  kernel/sched/topology.c | 10 ++++++++++
>>  3 files changed, 38 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 4e5b171b1171..e6505b0764c0 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6444,6 +6444,30 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>>  		}
>>  	}
>>  
>> +	if (static_branch_unlikely(&sched_cluster_active)) {
>> +		struct sched_domain *sdc = rcu_dereference(per_cpu(sd_cluster, target));
>> +
>> +		if (sdc) {
>> +			for_each_cpu_wrap(cpu, sched_domain_span(sdc), target + 1) {
>> +				if (!cpumask_test_cpu(cpu, cpus))
>> +					continue;
>> +
>> +				if (has_idle_core) {
>> +					i = select_idle_core(p, cpu, cpus, &idle_cpu);
>> +					if ((unsigned int)i < nr_cpumask_bits)
>> +						return i;
>> +				} else {
>> +					if (--nr <= 0)
>> +						return -1;
>> +					idle_cpu = __select_idle_cpu(cpu, p);
>> +					if ((unsigned int)idle_cpu < nr_cpumask_bits)
>> +						return idle_cpu;
>> +				}
>> +			}
>> +			cpumask_andnot(cpus, cpus, sched_domain_span(sdc));
>> +		}
>> +	}
>> +
>>  	for_each_cpu_wrap(cpu, cpus, target + 1) {
>>  		if (has_idle_core) {
>>  			i = select_idle_core(p, cpu, cpus, &idle_cpu);
>> @@ -6451,7 +6475,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>>  				return i;
>>  
>>  		} else {
>> -			if (!--nr)
>> +			if (--nr <= 0)
> This change seems to not be needed because if the cluster scan has run out of nr budget,
> it will return -1 there, and there's no need to check nr here. But yes, with this
> change the code is more readable.
>>  				return -1;
>>  			idle_cpu = __select_idle_cpu(cpu, p);
>>  			if ((unsigned int)idle_cpu < nr_cpumask_bits)
>> @@ -6550,7 +6574,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>>  	/*
>>  	 * If the previous CPU is cache affine and idle, don't be stupid:
>>  	 */
>> -	if (prev != target && cpus_share_cache(prev, target) &&
>> +	if (prev != target && cpus_share_lowest_cache(prev, target) &&
> This change impacts hackbench in socket mode a bit. It seems that for hackbench even
> putting the wakee on its previous CPU in the same LLC is better than putting it on
> current cluster. But it seems to be hackbench specific.
> 

...without this do you still see the same improvement at under-loaded case (threads less-equal the CPU
numbers) for tbench/netperf? The idea here is to always try to wakeup in the same cluster of the
target to benefit from the cluster cache but the early test for the prev and recent used cpu may break
that. Keep it as is, at low load the prev cpu or recent used cpu get more chance to be idle so we take
less chance to benefit from the cluster and gain less performance improvement.

In the hackbench case as you noticed, the utilization can reach 100% ideally so the SIS_UTIL
will regulate the scanning number to 4 or around. If the prev/recent used CPU is not in the same
cluster with target, we're about to scanning the cluster and when found no idle CPU and has
run out of the scanning number, we'll fallback to wakeup on the target. That maybe the reason
why observed more wakeups on target rather than previous CPU.

In this case I wondering choosing prev cpu or recent used cpu after scanning the cluster can help
the situation here, like the snippet below (kinds of messy though).

Thanks,
Yicong

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ecdc7970566e..5a25cb680350 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6939,7 +6939,8 @@ static inline int select_idle_smt(struct task_struct *p, int target)
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
  * average idle time for this rq (as found in rq->avg_idle).
  */
-static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
+static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target,
+                          int aff_prev_cpu, int aff_recent_cpu)
 {
        struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
        int i, cpu, idle_cpu = -1, nr = INT_MAX;
@@ -7008,12 +7009,22 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
                                                return i;
                                } else {
                                        if (--nr <= 0)
-                                               return -1;
+                                               break;
                                        idle_cpu = __select_idle_cpu(cpu, p);
                                        if ((unsigned int)idle_cpu < nr_cpumask_bits)
                                                return idle_cpu;
                                }
                        }
+
+                       /*
+                        * No idle CPU in the target's cluster found, check task's
+                        * prev_cpu and recent_used_cpu first for better affinity.
+                        */
+                       if ((unsigned int)aff_prev_cpu < nr_cpumask_bits)
+                               return aff_prev_cpu;
+                       else if ((unsigned int)aff_recent_cpu < nr_cpumask_bits)
+                               return aff_recent_cpu;
+
                        cpumask_andnot(cpus, cpus, sched_domain_span(sdc));
                }
        }
@@ -7128,6 +7139,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
        struct sched_domain *sd;
        unsigned long task_util, util_min, util_max;
        int i, recent_used_cpu;
+       int aff_prev_cpu = -1, aff_recent_cpu = -1;

        /*
         * On asymmetric system, update task utilization because we will check
@@ -7152,10 +7164,14 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
        /*
         * If the previous CPU is cache affine and idle, don't be stupid:
         */
-       if (prev != target && cpus_share_lowest_cache(prev, target) &&
+       if (prev != target &&
            (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
-           asym_fits_cpu(task_util, util_min, util_max, prev))
-               return prev;
+           asym_fits_cpu(task_util, util_min, util_max, prev)) {
+               if (cpus_share_lowest_cache(prev, target))
+                       return prev;
+               else if (cpus_share_cache(prev, target))
+                       aff_prev_cpu = prev;
+       }

        /*
         * Allow a per-cpu kthread to stack with the wakee if the
@@ -7178,11 +7194,13 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
        p->recent_used_cpu = prev;
        if (recent_used_cpu != prev &&
            recent_used_cpu != target &&
-           cpus_share_lowest_cache(recent_used_cpu, target) &&
            (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
            cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
            asym_fits_cpu(task_util, util_min, util_max, recent_used_cpu)) {
-               return recent_used_cpu;
+               if (cpus_share_lowest_cache(recent_used_cpu, target))
+                       return recent_used_cpu;
+               else if (cpus_share_cache(recent_used_cpu, target))
+                       aff_recent_cpu = recent_used_cpu;
        }

        /*
@@ -7219,7 +7237,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
                }
        }

-       i = select_idle_cpu(p, sd, has_idle_core, target);
+       i = select_idle_cpu(p, sd, has_idle_core, target, aff_prev_cpu, aff_recent_cpu);
        if ((unsigned)i < nr_cpumask_bits)
                return i;


> thanks,
> Chenyu
> .
> 
