Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3C1714847
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjE2LCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjE2LCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:02:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198AE8E
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:02:19 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QVCD13vtgzqTQ9;
        Mon, 29 May 2023 18:57:37 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 29 May 2023 19:02:13 +0800
CC:     <yangyicong@hisilicon.com>, <mingo@redhat.com>,
        <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <dietmar.eggemann@arm.com>, <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <yu.c.chen@intel.com>, <linuxarm@huawei.com>,
        <prime.zeng@huawei.com>, <wangjie125@huawei.com>
Subject: Re: [PATCH] sched/fair: Don't balance task to its current running CPU
To:     Vincent Guittot <vincent.guittot@linaro.org>
References: <20230524072018.62204-1-yangyicong@huawei.com>
 <CAKfTPtDOvMqHW7sgw1Ht7pV27W-Up61uO+AfSNkGpoMuOF_gXQ@mail.gmail.com>
 <0decbc3a-ee1e-e84b-915d-d77b75ec1df6@huawei.com>
 <CAKfTPtB=Ms9Evu-aiBC2hO2ahvxfKZxXsnR+oqCHyU0ituwY4g@mail.gmail.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <785256e9-209f-7d88-e03e-61999d845e81@huawei.com>
Date:   Mon, 29 May 2023 19:02:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtB=Ms9Evu-aiBC2hO2ahvxfKZxXsnR+oqCHyU0ituwY4g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Hi Vincent,

On 2023/5/26 18:34, Vincent Guittot wrote:
> On Fri, 26 May 2023 at 10:18, Yicong Yang <yangyicong@huawei.com> wrote:
>>
>> On 2023/5/25 23:13, Vincent Guittot wrote:
>>> On Wed, 24 May 2023 at 09:21, Yicong Yang <yangyicong@huawei.com> wrote:
>>>>
>>>> From: Yicong Yang <yangyicong@hisilicon.com>
>>>>
>>>> We've run into the case that the balancer tries to balance a migration
>>>> disabled task and trigger the warning in set_task_cpu() like below:
>>>>
>>>>  ------------[ cut here ]------------
>>>>  WARNING: CPU: 7 PID: 0 at kernel/sched/core.c:3115 set_task_cpu+0x188/0x240
>>>>  Modules linked in: hclgevf xt_CHECKSUM ipt_REJECT nf_reject_ipv4 <...snip>
>>>>  CPU: 7 PID: 0 Comm: swapper/7 Kdump: loaded Tainted: G           O       6.1.0-rc4+ #1
>>>>  Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 2280-V2 CS V5.B221.01 12/09/2021
>>>>  pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>>  pc : set_task_cpu+0x188/0x240
>>>>  lr : load_balance+0x5d0/0xc60
>>>>  sp : ffff80000803bc70
>>>>  x29: ffff80000803bc70 x28: ffff004089e190e8 x27: ffff004089e19040
>>>>  x26: ffff007effcabc38 x25: 0000000000000000 x24: 0000000000000001
>>>>  x23: ffff80000803be84 x22: 000000000000000c x21: ffffb093e79e2a78
>>>>  x20: 000000000000000c x19: ffff004089e19040 x18: 0000000000000000
>>>>  x17: 0000000000001fad x16: 0000000000000030 x15: 0000000000000000
>>>>  x14: 0000000000000003 x13: 0000000000000000 x12: 0000000000000000
>>>>  x11: 0000000000000001 x10: 0000000000000400 x9 : ffffb093e4cee530
>>>>  x8 : 00000000fffffffe x7 : 0000000000ce168a x6 : 000000000000013e
>>>>  x5 : 00000000ffffffe1 x4 : 0000000000000001 x3 : 0000000000000b2a
>>>>  x2 : 0000000000000b2a x1 : ffffb093e6d6c510 x0 : 0000000000000001
>>>>  Call trace:
>>>>   set_task_cpu+0x188/0x240
>>>>   load_balance+0x5d0/0xc60
>>>>   rebalance_domains+0x26c/0x380
>>>>   _nohz_idle_balance.isra.0+0x1e0/0x370
>>>>   run_rebalance_domains+0x6c/0x80
>>>>   __do_softirq+0x128/0x3d8
>>>>   ____do_softirq+0x18/0x24
>>>>   call_on_irq_stack+0x2c/0x38
>>>>   do_softirq_own_stack+0x24/0x3c
>>>>   __irq_exit_rcu+0xcc/0xf4
>>>>   irq_exit_rcu+0x18/0x24
>>>>   el1_interrupt+0x4c/0xe4
>>>>   el1h_64_irq_handler+0x18/0x2c
>>>>   el1h_64_irq+0x74/0x78
>>>>   arch_cpu_idle+0x18/0x4c
>>>>   default_idle_call+0x58/0x194
>>>>   do_idle+0x244/0x2b0
>>>>   cpu_startup_entry+0x30/0x3c
>>>>   secondary_start_kernel+0x14c/0x190
>>>>   __secondary_switched+0xb0/0xb4
>>>>  ---[ end trace 0000000000000000 ]---
>>>>
>>>> Further investigation shows that the warning is superfluous, the migration
>>>> disabled task is just going to be migrated to its current running CPU.
>>>> This is because that on load balance if the dst_cpu is not allowed by the
>>>> task, we'll re-select a new_dst_cpu as a candidate. If no task can be
>>>> balanced to dst_cpu we'll try to balance the task to the new_dst_cpu
>>>> instead. In this case when the migration disabled task is not on CPU it
>>>> only allows to run on its current CPU, load balance will select its
>>>> current CPU as new_dst_cpu and later triggers the the warning above.
>>>>
>>>> This patch tries to solve this by not select the task's current running
>>>> CPU as new_dst_cpu in the load balance.
>>>>
>>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>>>> ---
>>>> Thanks Valentin for the knowledge of migration disable. Previous discussion can
>>>> be found at
>>>> https://lore.kernel.org/all/20230313065759.39698-1-yangyicong@huawei.com/
>>>>
>>>>  kernel/sched/fair.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index 7a1b1f855b96..3c4f3a244c1d 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -8456,7 +8456,8 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>>>>
>>>>                 /* Prevent to re-select dst_cpu via env's CPUs: */
>>>>                 for_each_cpu_and(cpu, env->dst_grpmask, env->cpus) {
>>>> -                       if (cpumask_test_cpu(cpu, p->cpus_ptr)) {
>>>> +                       if (cpumask_test_cpu(cpu, p->cpus_ptr) &&
>>>> +                           cpu != env->src_cpu) {
>>>
>>> So I'm a bit surprised that src_cpu can be part of the dst_grpmask and
>>> selected as new_dst_cpu. The only reason would be some numa
>>> overlapping domains. Is it the case for you ?
>>>
>>
>> It's a 2P 4 NUMA machine, the groups in the top NUMA domains are overlapped, for example for CPU64:
>>
>> [    3.147038] CPU64 attaching sched-domain(s):
>> [    3.147040]  domain-0: span=64-67 level=CLS
>> [    3.147043]   groups: 64:{ span=64 cap=1023 }, 65:{ span=65 cap=1023 }, 66:{ span=66 cap=1023 }, 67:{ span=67 }
>> [    3.147056]   domain-1: span=64-95 level=MC
>> [    3.147059]    groups: 64:{ span=64-67 cap=4093 }, 68:{ span=68-71 cap=4096 }, 72:{ span=72-75 cap=4096 }, 76:{ span=76-79 cap=4096 }, 80:{ span=80-83 cap=4096 }, 84:{ span=84-87 cap=4096 }, 88:{ span=88-91 cap=4096 }, 92:{ span=92-95 cap=4096 }
>> [    3.147085]    domain-2: span=64-127 level=NUMA
>> [    3.147087]     groups: 64:{ span=64-95 cap=32765 }, 96:{ span=96-127 cap=32767 }
>> [    3.147095]     domain-3: span=0-31,64-127 level=NUMA
>> [    3.147098]      groups: 64:{ span=64-127 cap=65532 }, 0:{ span=0-31 cap=32767 }
>> [    3.147106]      domain-4: span=0-127 level=NUMA
>> [    3.147109]       groups: 64:{ span=0-31,64-127 mask=64-95 cap=98300 }, 32:{ span=0-63 mask=32-63 cap=65531 }
>>
> 
> Thanks for confirming this.
> 
> So I wonder if a better solution would be to make env->dst_grpmask =
> group_balance_cpu(sd->groups) instead of
> sched_group_span(sd->groups),. The behavior remains the same for non
> overlapping groups because group_balance_cpu(sd->groups) ==
> sched_group_span(sd->groups) in this case and for overlapping group,
> we will try to find a dst_cpu that is not contained in src/busiest
> group and the load balance will effectively pull load from the
> busiest_group
> 

I think this make sense to me. We've already limited the dst_cpu within the
group_balance_mask(sd->groups) in should_we_balance() for periodical balance
(but not for idle balance). The sg->sgc->cpumask is commented as "balance
mask", so only the cpus in sg->sgc->cpumask can pull the task in the load balance.
The newidle CPU maybe an exception, but also need to limit the new_dst_cpu
int the sg->sgc->cpumask.

> 
>>>>                                 env->flags |= LBF_DST_PINNED;
>>>>                                 env->new_dst_cpu = cpu;
>>>>                                 break;
>>>> --
>>>> 2.24.0
>>>>
>>> .
>>>
> .
> 
