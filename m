Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17C273119E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244869AbjFOH7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244129AbjFOH7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:59:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1CD2137
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:59:13 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QhZRf2qbWzTkyD;
        Thu, 15 Jun 2023 15:58:38 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 15:59:10 +0800
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
 <85e29dd8-60f6-1e84-b3e4-061e5a2a0037@huawei.com>
 <ZIMEEnozzC+Uyluv@chenyu5-mobl2.ccr.corp.intel.com>
 <f534ead9-56cc-d834-90a3-67f8532230ff@huawei.com>
 <be1f2bcd-fe03-2b0a-0754-1054a09663a2@huawei.com>
 <ZIhkr5xIijJG6AKF@chenyu5-mobl2.ccr.corp.intel.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <e7a0461d-fc28-b752-605c-bd8e89f5a844@huawei.com>
Date:   Thu, 15 Jun 2023 15:59:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <ZIhkr5xIijJG6AKF@chenyu5-mobl2.ccr.corp.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2023/6/13 20:44, Chen Yu wrote:
> On 2023-06-13 at 16:09:17 +0800, Yicong Yang wrote:
>> On 2023/6/13 15:36, Yicong Yang wrote:
>>> On 2023/6/9 18:50, Chen Yu wrote:
>>>> On 2023-06-08 at 14:45:54 +0800, Yicong Yang wrote:
>>>>> On 2023/6/8 11:26, Chen Yu wrote:
>>>>>> On 2023-05-31 at 16:21:00 +0800, Yicong Yang wrote:
>>>>>>> On 2023/5/30 22:39, Yicong Yang wrote:
>>>>>>>> On 2023/5/30 19:55, Peter Zijlstra wrote:
>>>>>>>>> On Tue, May 30, 2023 at 03:02:53PM +0800, Yicong Yang wrote:
>>>>>>>>>
>>>>>>>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>>>>>>>> index 373ff5f55884..b8c129ed8b47 100644
>>>>>>>>>> --- a/kernel/sched/fair.c
>>>>>>>>>> +++ b/kernel/sched/fair.c
>>>>>>>>>> @@ -6994,6 +6994,30 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>>>>>>>>>>  		}
>>>>>>>>>>  	}
>>>>>>>>>>  
>>>>>>>>>> +	if (static_branch_unlikely(&sched_cluster_active)) {
>>>>>>>>>> +		struct sched_domain *sdc = rcu_dereference(per_cpu(sd_cluster, target));
>>>>>>>>>> +
>>>>>>>>>> +		if (sdc) {
>>>>>>>>>> +			for_each_cpu_wrap(cpu, sched_domain_span(sdc), target + 1) {
>>>>>>>>>> +				if (!cpumask_test_cpu(cpu, cpus))
>>>>>>>>>> +					continue;
>>>>>>>>>> +
>>>>>>>>>> +				if (has_idle_core) {
>>>>>>>>>> +					i = select_idle_core(p, cpu, cpus, &idle_cpu);
>>>>>>>>>> +					if ((unsigned int)i < nr_cpumask_bits)
>>>>>>>>>> +						return i;
>>>>>>>>>> +				} else {
>>>>>>>>>> +					if (--nr <= 0)
>>>>>>>>>> +						return -1;
>>>>>>>>>> +					idle_cpu = __select_idle_cpu(cpu, p);
>>>>>>>>>> +					if ((unsigned int)idle_cpu < nr_cpumask_bits)
>>>>>>>>>> +						return idle_cpu;
>>>>>>>>>> +				}
>>>>>>>>>> +			}
>>>>>>>>>> +			cpumask_andnot(cpus, cpus, sched_domain_span(sdc));
>>>>>>>>>> +		}
>>>>>>>>>> +	}
>>>>>>>>>
>>>>>>>>> Would not this:
>>>>>>>>>
>>>>>>>>> --- a/kernel/sched/fair.c
>>>>>>>>> +++ b/kernel/sched/fair.c
>>>>>>>>> @@ -6994,6 +6994,29 @@ static int select_idle_cpu(struct task_s
>>>>>>>>>  		}
>>>>>>>>>  	}
>>>>>>>>>  
>>>>>>>>> +	if (static_branch_unlikely(&sched_cluster_active)) {
>>>>>>>>> +		struct sched_group *sg = sd->groups;
>>>>>>>>> +		if (sg->flags & SD_CLUSTER) {
>>>>>>>>> +			for_each_cpu_wrap(cpu, sched_group_span(sg), target+1) {
>>>>>>>>> +				if (!cpumask_test_cpu(cpu, cpus))
>>>>>>>>> +					continue;
>>>>>>>>> +
>>>>>>>>> +				if (has_idle_core) {
>>>>>>>>> +					i = select_idle_core(p, cpu, cpus, &idle_cpu);
>>>>>>>>> +					if ((unsigned)i < nr_cpumask_bits)
>>>>>>>>> +						return 1;
>>>>>>>>> +				} else {
>>>>>>>>> +					if (--nr <= 0)
>>>>>>>>> +						return -1;
>>>>>>>>> +					idle_cpu = __select_idle_cpu(cpu, p);
>>>>>>>>> +					if ((unsigned)idle_cpu < nr_cpumask_bits)
>>>>>>>>> +						return idle_cpu;
>>>>>>>>> +				}
>>>>>>>>> +			}
>>>>>>>>> +			cpumask_andnot(cpus, cpus, sched_group_span(sg));
>>>>>>>>> +		}
>>>>>>>>> +	}
>>>>>>>>> +
>>>>>>>>>  	for_each_cpu_wrap(cpu, cpus, target + 1) {
>>>>>>>>>  		if (has_idle_core) {
>>>>>>>>>  			i = select_idle_core(p, cpu, cpus, &idle_cpu);
>>>>>>>>>
>>>>>>>>> also work? Then we can avoid the extra sd_cluster per-cpu variable.
>>>>>>>>>
>>>>>>>>
>>>>>>>> I thought it will be fine since sg->flags is derived from the child domain. But practically it doesn't.
>>>>>>>> Tested on a 2P Skylake server with no clusters, add some debug messages to see how sg->flags appears:
>>>>>>>>
>>>>>>>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>>>>>>>> index 69968ed9ffb9..5c443b74abf5 100644
>>>>>>>> --- a/kernel/sched/topology.c
>>>>>>>> +++ b/kernel/sched/topology.c
>>>>>>>> @@ -90,8 +90,8 @@ static int sched_domain_debug_one(struct sched_domain *sd, int cpu, int level,
>>>>>>>>
>>>>>>>>                 cpumask_or(groupmask, groupmask, sched_group_span(group));
>>>>>>>>
>>>>>>>> -               printk(KERN_CONT " %d:{ span=%*pbl",
>>>>>>>> -                               group->sgc->id,
>>>>>>>> +               printk(KERN_CONT " %d:{ cluster: %s span=%*pbl",
>>>>>>>> +                               group->sgc->id, group->flags & SD_CLUSTER ? "true" : "false",
>>>>>>>>                                 cpumask_pr_args(sched_group_span(group)));
>>>>>>>>
>>>>>>>>                 if ((sd->flags & SD_OVERLAP) &&
>>>>>>>>
>>>>>>>> Unfortunately the result doesn't match what I expected, the MC domain's sg->flags still marked
>>>>>>>> as cluster:
>>>>>>>>
>>>>>>>> [    8.886099] CPU0 attaching sched-domain(s):
>>>>>>>> [    8.889539]  domain-0: span=0,40 level=SMT
>>>>>>>> [    8.893538]   groups: 0:{ cluster: false span=0 }, 40:{ cluster: false span=40 }
>>>>>>>> [    8.897538]   domain-1: span=0-19,40-59 level=MC
>>>>>>>> [    8.901538]    groups: 0:{ cluster: true span=0,40 cap=2048 }, 1:{ cluster: true span=1,41 cap=2048 }, 2:{ cluster: true span=2,42 cap=2048 }, 3:{ cluster: true span=3,43 cap=2048 }, 4:{ cluster: true span=4,44 cap=2048 }, 5:{ cluster: true span=5,45 cap=2048 }, 6:{ cluster: true span=6,46 cap=2048 }, 7:{ cluster: true span=7,47 cap=2048 }, 8:{ cluster: true span=8,48 cap=2048 }, 9:{ cluster: true span=9,49 cap=2048 }, 10:{ cluster: true span=10,50 cap=2048 }, 11:{ cluster: true span=11,51 cap=2048 }, 12:{ cluster: true span=12,52 cap=2048 }, 13:{ cluster: true span=13,53 cap=2048 }, 14:{ cluster: true span=14,54 cap=2048 }, 15:{ cluster: true span=15,55 cap=2048 }, 16:{ cluster: true span=16,56 cap=2048 }, 17:{ cluster: true span=17,57 cap=2048 }, 18:{ cluster: true span=18,58 cap=2048 }, 19:{ cluster: true span=19,59 cap=2048 }
>>>>>>>> [    8.905538]    domain-2: span=0-79 level=NUMA
>>>>>>>> [    8.909538]     groups: 0:{ cluster: false span=0-19,40-59 cap=40960 }, 20:{ cluster: false span=20-39,60-79 cap=40960 }
>>>>>>>>
>>>>>>>> I assume we didn't handle the sg->flags correctly on the domain degeneration. Simply checked the code seems
>>>>>>>> we've already make sg->flags = 0 on degeneration, maybe I need to check where's wrong.
>>>>>>>>
>>>>>>>
>>>>>>> Currently we only update the groups' flags to 0 for the final lowest domain in [1]. The upper
>>>>>>> domains' group won't be updated if degeneration happens. So we cannot use the suggested approach
>>>>>>> for cluster scanning and sd_cluster per-cpu variable is still needed.
>>>>>>>
>>>>>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/sched/topology.c?h=v6.4-rc4#n749
>>>>>>>
>>>>>>> Thanks.
>>>>>>>
>>>>>>>
>>>>>> Is this an issue? Suppose sched domain A's parent domain
>>>>>> is B, B's parent sched domain is C. When B degenerates, C's child domain
>>>>>> pointer is adjusted to A. However, currently the code does not adjust C's
>>>>>> sched groups' flags. Should we adjust C's sched groups flags to be the same
>>>>>> as A to keep consistency?
>>>>>
>>>>> It depends on whether we're going to use it. currently only asym_smt_can_pull_tasks() uses
>>>>> it within the SMT so I think update the lowest domain's group flag works. For correctness
>>>>> all the domain group's flag should derives from its real child. I tried to solve this at group
>>>>> building but seems hard to do, at that time we don't know whether a domain is going to degenerate
>>>>> or not since the groups it not built.
>>>>>
>>>>>>
>>>>>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>>>>>> index 6198fa135176..fe3fd70f2313 100644
>>>>>> --- a/kernel/sched/topology.c
>>>>>> +++ b/kernel/sched/topology.c
>>>>>> @@ -713,14 +713,13 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
>>>>>>  
>>>>>>  	/* Remove the sched domains which do not contribute to scheduling. */
>>>>>>  	for (tmp = sd; tmp; ) {
>>>>>> -		struct sched_domain *parent = tmp->parent;
>>>>>> +		struct sched_domain *parent = tmp->parent, *pparent;
>>>>>>  		if (!parent)
>>>>>>  			break;
>>>>>>  
>>>>>>  		if (sd_parent_degenerate(tmp, parent)) {
>>>>>> -			tmp->parent = parent->parent;
>>>>>> -			if (parent->parent)
>>>>>> -				parent->parent->child = tmp;
>>>>>> +			pparent = parent->parent;
>>>>>> +			tmp->parent = pparent;
>>>>>>  			/*
>>>>>>  			 * Transfer SD_PREFER_SIBLING down in case of a
>>>>>>  			 * degenerate parent; the spans match for this
>>>>>> @@ -728,6 +727,18 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
>>>>>>  			 */
>>>>>>  			if (parent->flags & SD_PREFER_SIBLING)
>>>>>>  				tmp->flags |= SD_PREFER_SIBLING;
>>>>>> +
>>>>>> +			if (pparent) {
>>>>>> +				struct sched_group *sg = pparent->groups;
>>>>>> +
>>>>>> +				do {
>>>>>> +					sg->flags = tmp->flags;
>>>>>
>>>>> May need to test on some heterogeous platforms. Does it always stand that child domain of CPU from
>>>>> remote group have the same flags with @tmp?
>>>>>
>>>> Good question, for heterogenous platforms sched groups within the same domain might not always
>>>> have the same flags, because if group1 and group2 sit in big/small-core child domain, they could
>>>> have different balance flags in theory. Maybe only update the local group's flag is accurate.
>>>>
>>>> I found Tim has proposed a fix for a similar scenario, and it is for SD_SHARE_CPUCAPACITY, and it
>>>> should be in tip:
>>>> https://lore.kernel.org/lkml/168372654916.404.6677242284447941021.tip-bot2@tip-bot2/
>>>> We could adjust it based on his change to remove SD_CLUSTER, or we can
>>>> replace groups->flag with tmp->flag directly, in case we have other flags to be
>>>> adjusted in the future.
>>>>
>>>
>>> Thanks for the reference. I think we can handle the SD_CLUSTER in the same way and only update
>>> local groups flag should satisfy our needs. I tried to use the correct child domains to build the
>>> sched groups then all the groups will have the correct flags, but it'll be a bit more complex.
>>>
>>
>> something like below, detect the sched domain degeneration first and try to rebuild the groups if
>> necessary.
> Not sure if we need to rebuild the groups. With only
> 
> if (parent->flags & SD_CLUSTER)
> 	parent->parent->groups->flags &= ~SD_CLUSTER;
> 
> I see the correct flags.
> 
> My understanding is that, although remote groups's flag might be incorrect,
> later when other sched domain degenerates, these remote groups becomes local
> groups for those sched domains, and the flags will be adjusted accordingly.

Maybe worth a try to build the groups correctly at very beginning rather
correct it later when needed. Considering we've used it in several places[1][2]
and this time we're going to use it for cluster.

[1] 16d364ba6ef2 ("sched/topology: Introduce sched_group::flags")
[2] https://lore.kernel.org/lkml/168372654916.404.6677242284447941021.tip-bot2@tip-bot2/

>> Works on a non-cluster machine emulated with QEMU:
>>
>> qemu-system-aarch64 \
>>         -kernel ${Image} \
>>         -smp cores=16,threads=2 \
>>         -cpu host --enable-kvm \
>>         -m 32G \
>>         -object memory-backend-ram,id=node0,size=8G \
>>         -object memory-backend-ram,id=node1,size=8G \
>>         -object memory-backend-ram,id=node2,size=8G \
>>         -object memory-backend-ram,id=node3,size=8G \
>>         -numa node,memdev=node0,cpus=0-7,nodeid=0 \
>>         -numa node,memdev=node1,cpus=8-15,nodeid=1 \
>>         -numa node,memdev=node2,cpus=16-23,nodeid=2 \
>>         -numa node,memdev=node3,cpus=24-31,nodeid=3 \
>>         -numa dist,src=0,dst=1,val=12 \
>>         -numa dist,src=0,dst=2,val=20 \
>>         -numa dist,src=0,dst=3,val=22 \
>>         -numa dist,src=1,dst=2,val=22 \
>>         -numa dist,src=1,dst=3,val=24 \
>>         -numa dist,src=2,dst=3,val=12 \
>>         -machine virt,iommu=smmuv3 \
>>         -net none -initrd ${Rootfs} \
>>         -nographic -bios $(pwd)/QEMU_EFI.fd \
>>         -append "rdinit=/init console=ttyAMA0 earlycon=pl011,0x9000000 sched_verbose schedstats=enable loglevel=8"
>>
>> The flags looks correct:
>> [    4.379910] CPU0 attaching sched-domain(s):
>> [    4.380540]  domain-0: span=0-1 level=SMT
>> [    4.381130]   groups: 0:{ cluster: false span=0 cap=1023 }, 1:{ cluster: false span=1 }
>> [    4.382353]   domain-1: span=0-7 level=MC
>> [    4.382950]    groups: 0:{ cluster: false span=0-1 cap=2047 }, 2:{ cluster: false span=2-3 cap=2048 }, 4:{ cluster: false span=4-5 cap=2048 }, 6:{ cluster: false span=6-7 cap=2048 }
>> [    4.385378]    domain-2: span=0-15 level=NUMA
>> [    4.386047]     groups: 0:{ cluster: false span=0-7 cap=8191 }, 8:{ cluster: false span=8-15 cap=8192 }
>> [    4.387542]     domain-3: span=0-23 level=NUMA
>> [    4.388197]      groups: 0:{ cluster: false span=0-15 cap=16383 }, 16:{ cluster: false span=16-23 cap=8192 }
>> [    4.389661]      domain-4: span=0-31 level=NUMA
>> [    4.390358]       groups: 0:{ cluster: false span=0-23 mask=0-7 cap=24575 }, 24:{ cluster: false span=16-31 mask=24-31 cap=16384 }
>>
>>
> 
> I did similar test based on your config:
> qemu-system-x86_64 \
>         -m 2G \
>         -smp 16,threads=2,cores=4,sockets=2 \
>         -numa node,mem=1G,cpus=0-7,nodeid=0 \
>         -numa node,mem=1G,cpus=8-15,nodeid=1 \
>         -kernel bzImage \
>         -drive file=./ubuntu.raw,format=raw \
>         -append "console=ttyS0 root=/dev/sda5 earlyprintk=serial ignore_loglevel sched_verbose" \
>         -cpu host \
>         -enable-kvm \
>         -nographic
> 
> and print the group address as well as the SD_CLUSTER flag:
> 
> [    0.208583] CPU0 attaching sched-domain(s):
> [    0.208998]  domain-0: span=0-1 level=SMT
> [    0.209393]   groups: 0:{ cluster: false group 0xffff9ed3c19e6140 span=0 }, 1:{ cluster: false group 0xffff9ed3c19e6440 span=1 }
> [    0.212463]   domain-1: span=0-7 level=MC
> [    0.212856]    groups: 0:{ cluster: false group 0xffff9ed3c1a8f3c0 span=0-1 cap=2048 }, 2:{ cluster: true group 0xffff9ed3c1a8fac0 span=2-3 cap=2048 },
> 
> Yeah, group 0xffff9ed3c1a8fac0 has SD_CLUSTER, but...
> 

Something's wrong here. 0xffff9ed3c1a8fac0 shouldn't have SD_CLUSTER. Code above should works to successfully build
MC's groups from SMT rather than CLS, Tested with qemu version 4.2.1 (from ubuntu 20.04) and mainline v8.0.0-1358-gac84b57b4d
with your x86 topology, it looks like:

[    0.517077] CPU0 attaching sched-domain(s):
[    0.520858]  domain-0: span=0-1 level=SMT
[    0.524858]   groups: 0:{ cluster: false span=0 }, 1:{ cluster: false span=1 }
[    0.528858]   domain-1: span=0-7 level=MC
[    0.532858]    groups: 0:{ cluster: false span=0-1 cap=2048 }, 2:{ cluster: false span=2-3 cap=2048 }, 4:{ cluster: false span=4-5 cap=2048 }, 6:{ cluster: false span=6-7 cap=2048 }
[    0.536858]    domain-2: span=0-15 level=NUMA
[    0.540858]     groups: 0:{ cluster: false span=0-7 cap=8192 }, 8:{ cluster: false span=8-15 cap=8192 }

and for CPU 2:

[    0.572859] CPU2 attaching sched-domain(s):
[    0.576858]  domain-0: span=2-3 level=SMT
[    0.580858]   groups: 2:{ cluster: false span=2 }, 3:{ cluster: false span=3 }
[    0.584858]   domain-1: span=0-7 level=MC
[    0.588858]    groups: 2:{ cluster: false span=2-3 cap=2048 }, 4:{ cluster: false span=4-5 cap=2048 }, 6:{ cluster: false span=6-7 cap=2048 }, 0:{ cluster: false span=0-1 cap=2048 }
[    0.592858]    domain-2: span=0-15 level=NUMA
[    0.596858]     groups: 0:{ cluster: false span=0-7 cap=8192 }, 8:{ cluster: false span=8-15 cap=8192 }

Thanks.
