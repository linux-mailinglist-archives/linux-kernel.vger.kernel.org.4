Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C1872778F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 08:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbjFHGqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 02:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbjFHGqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 02:46:00 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E738A2132
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 23:45:58 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QcF6D3lYvztQVD;
        Thu,  8 Jun 2023 14:43:32 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 14:45:55 +0800
CC:     <yangyicong@hisilicon.com>, Peter Zijlstra <peterz@infradead.org>,
        <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <tim.c.chen@linux.intel.com>, <gautham.shenoy@amd.com>,
        <mgorman@suse.de>, <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <jonathan.cameron@huawei.com>,
        <ego@linux.vnet.ibm.com>, <srikar@linux.vnet.ibm.com>,
        <linuxarm@huawei.com>, <21cnbao@gmail.com>,
        <kprateek.nayak@amd.com>, <wuyun.abel@bytedance.com>,
        Barry Song <baohua@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Len Brown <len.brown@intel.com>
Subject: Re: [PATCH v8 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
To:     Chen Yu <yu.c.chen@intel.com>
References: <20230530070253.33306-1-yangyicong@huawei.com>
 <20230530070253.33306-3-yangyicong@huawei.com>
 <20230530115527.GC156198@hirez.programming.kicks-ass.net>
 <8fcba5d4-eea5-d7c4-2bf7-482321b333b7@huawei.com>
 <ce714341-af58-2522-69a8-321f02c82893@huawei.com>
 <ZIFKf2PkIkiRmUaK@chenyu5-mobl2.ccr.corp.intel.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <85e29dd8-60f6-1e84-b3e4-061e5a2a0037@huawei.com>
Date:   Thu, 8 Jun 2023 14:45:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <ZIFKf2PkIkiRmUaK@chenyu5-mobl2.ccr.corp.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/8 11:26, Chen Yu wrote:
> On 2023-05-31 at 16:21:00 +0800, Yicong Yang wrote:
>> On 2023/5/30 22:39, Yicong Yang wrote:
>>> On 2023/5/30 19:55, Peter Zijlstra wrote:
>>>> On Tue, May 30, 2023 at 03:02:53PM +0800, Yicong Yang wrote:
>>>>
>>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>>> index 373ff5f55884..b8c129ed8b47 100644
>>>>> --- a/kernel/sched/fair.c
>>>>> +++ b/kernel/sched/fair.c
>>>>> @@ -6994,6 +6994,30 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>>>>>  		}
>>>>>  	}
>>>>>  
>>>>> +	if (static_branch_unlikely(&sched_cluster_active)) {
>>>>> +		struct sched_domain *sdc = rcu_dereference(per_cpu(sd_cluster, target));
>>>>> +
>>>>> +		if (sdc) {
>>>>> +			for_each_cpu_wrap(cpu, sched_domain_span(sdc), target + 1) {
>>>>> +				if (!cpumask_test_cpu(cpu, cpus))
>>>>> +					continue;
>>>>> +
>>>>> +				if (has_idle_core) {
>>>>> +					i = select_idle_core(p, cpu, cpus, &idle_cpu);
>>>>> +					if ((unsigned int)i < nr_cpumask_bits)
>>>>> +						return i;
>>>>> +				} else {
>>>>> +					if (--nr <= 0)
>>>>> +						return -1;
>>>>> +					idle_cpu = __select_idle_cpu(cpu, p);
>>>>> +					if ((unsigned int)idle_cpu < nr_cpumask_bits)
>>>>> +						return idle_cpu;
>>>>> +				}
>>>>> +			}
>>>>> +			cpumask_andnot(cpus, cpus, sched_domain_span(sdc));
>>>>> +		}
>>>>> +	}
>>>>
>>>> Would not this:
>>>>
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -6994,6 +6994,29 @@ static int select_idle_cpu(struct task_s
>>>>  		}
>>>>  	}
>>>>  
>>>> +	if (static_branch_unlikely(&sched_cluster_active)) {
>>>> +		struct sched_group *sg = sd->groups;
>>>> +		if (sg->flags & SD_CLUSTER) {
>>>> +			for_each_cpu_wrap(cpu, sched_group_span(sg), target+1) {
>>>> +				if (!cpumask_test_cpu(cpu, cpus))
>>>> +					continue;
>>>> +
>>>> +				if (has_idle_core) {
>>>> +					i = select_idle_core(p, cpu, cpus, &idle_cpu);
>>>> +					if ((unsigned)i < nr_cpumask_bits)
>>>> +						return 1;
>>>> +				} else {
>>>> +					if (--nr <= 0)
>>>> +						return -1;
>>>> +					idle_cpu = __select_idle_cpu(cpu, p);
>>>> +					if ((unsigned)idle_cpu < nr_cpumask_bits)
>>>> +						return idle_cpu;
>>>> +				}
>>>> +			}
>>>> +			cpumask_andnot(cpus, cpus, sched_group_span(sg));
>>>> +		}
>>>> +	}
>>>> +
>>>>  	for_each_cpu_wrap(cpu, cpus, target + 1) {
>>>>  		if (has_idle_core) {
>>>>  			i = select_idle_core(p, cpu, cpus, &idle_cpu);
>>>>
>>>> also work? Then we can avoid the extra sd_cluster per-cpu variable.
>>>>
>>>
>>> I thought it will be fine since sg->flags is derived from the child domain. But practically it doesn't.
>>> Tested on a 2P Skylake server with no clusters, add some debug messages to see how sg->flags appears:
>>>
>>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>>> index 69968ed9ffb9..5c443b74abf5 100644
>>> --- a/kernel/sched/topology.c
>>> +++ b/kernel/sched/topology.c
>>> @@ -90,8 +90,8 @@ static int sched_domain_debug_one(struct sched_domain *sd, int cpu, int level,
>>>
>>>                 cpumask_or(groupmask, groupmask, sched_group_span(group));
>>>
>>> -               printk(KERN_CONT " %d:{ span=%*pbl",
>>> -                               group->sgc->id,
>>> +               printk(KERN_CONT " %d:{ cluster: %s span=%*pbl",
>>> +                               group->sgc->id, group->flags & SD_CLUSTER ? "true" : "false",
>>>                                 cpumask_pr_args(sched_group_span(group)));
>>>
>>>                 if ((sd->flags & SD_OVERLAP) &&
>>>
>>> Unfortunately the result doesn't match what I expected, the MC domain's sg->flags still marked
>>> as cluster:
>>>
>>> [    8.886099] CPU0 attaching sched-domain(s):
>>> [    8.889539]  domain-0: span=0,40 level=SMT
>>> [    8.893538]   groups: 0:{ cluster: false span=0 }, 40:{ cluster: false span=40 }
>>> [    8.897538]   domain-1: span=0-19,40-59 level=MC
>>> [    8.901538]    groups: 0:{ cluster: true span=0,40 cap=2048 }, 1:{ cluster: true span=1,41 cap=2048 }, 2:{ cluster: true span=2,42 cap=2048 }, 3:{ cluster: true span=3,43 cap=2048 }, 4:{ cluster: true span=4,44 cap=2048 }, 5:{ cluster: true span=5,45 cap=2048 }, 6:{ cluster: true span=6,46 cap=2048 }, 7:{ cluster: true span=7,47 cap=2048 }, 8:{ cluster: true span=8,48 cap=2048 }, 9:{ cluster: true span=9,49 cap=2048 }, 10:{ cluster: true span=10,50 cap=2048 }, 11:{ cluster: true span=11,51 cap=2048 }, 12:{ cluster: true span=12,52 cap=2048 }, 13:{ cluster: true span=13,53 cap=2048 }, 14:{ cluster: true span=14,54 cap=2048 }, 15:{ cluster: true span=15,55 cap=2048 }, 16:{ cluster: true span=16,56 cap=2048 }, 17:{ cluster: true span=17,57 cap=2048 }, 18:{ cluster: true span=18,58 cap=2048 }, 19:{ cluster: true span=19,59 cap=2048 }
>>> [    8.905538]    domain-2: span=0-79 level=NUMA
>>> [    8.909538]     groups: 0:{ cluster: false span=0-19,40-59 cap=40960 }, 20:{ cluster: false span=20-39,60-79 cap=40960 }
>>>
>>> I assume we didn't handle the sg->flags correctly on the domain degeneration. Simply checked the code seems
>>> we've already make sg->flags = 0 on degeneration, maybe I need to check where's wrong.
>>>
>>
>> Currently we only update the groups' flags to 0 for the final lowest domain in [1]. The upper
>> domains' group won't be updated if degeneration happens. So we cannot use the suggested approach
>> for cluster scanning and sd_cluster per-cpu variable is still needed.
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/sched/topology.c?h=v6.4-rc4#n749
>>
>> Thanks.
>>
>>
> Is this an issue? Suppose sched domain A's parent domain
> is B, B's parent sched domain is C. When B degenerates, C's child domain
> pointer is adjusted to A. However, currently the code does not adjust C's
> sched groups' flags. Should we adjust C's sched groups flags to be the same
> as A to keep consistency?

It depends on whether we're going to use it. currently only asym_smt_can_pull_tasks() uses
it within the SMT so I think update the lowest domain's group flag works. For correctness
all the domain group's flag should derives from its real child. I tried to solve this at group
building but seems hard to do, at that time we don't know whether a domain is going to degenerate
or not since the groups it not built.

> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 6198fa135176..fe3fd70f2313 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -713,14 +713,13 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
>  
>  	/* Remove the sched domains which do not contribute to scheduling. */
>  	for (tmp = sd; tmp; ) {
> -		struct sched_domain *parent = tmp->parent;
> +		struct sched_domain *parent = tmp->parent, *pparent;
>  		if (!parent)
>  			break;
>  
>  		if (sd_parent_degenerate(tmp, parent)) {
> -			tmp->parent = parent->parent;
> -			if (parent->parent)
> -				parent->parent->child = tmp;
> +			pparent = parent->parent;
> +			tmp->parent = pparent;
>  			/*
>  			 * Transfer SD_PREFER_SIBLING down in case of a
>  			 * degenerate parent; the spans match for this
> @@ -728,6 +727,18 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
>  			 */
>  			if (parent->flags & SD_PREFER_SIBLING)
>  				tmp->flags |= SD_PREFER_SIBLING;
> +
> +			if (pparent) {
> +				struct sched_group *sg = pparent->groups;
> +
> +				do {
> +					sg->flags = tmp->flags;

May need to test on some heterogeous platforms. Does it always stand that child domain of CPU from
remote group have the same flags with @tmp?

> +					sg = sg->next;
> +				} while (sg != pparent->groups);
> +
> +				pparent->child = tmp;
> +			}
> +
>  			destroy_sched_domain(parent);
>  		} else
>  			tmp = tmp->parent;
> 

The code you pasted at last of your mail is correct I think, not sure it doesn't appear here when reply...

Thanks.

