Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D963625A84
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 13:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbiKKMeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 07:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiKKMeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 07:34:10 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94154299B;
        Fri, 11 Nov 2022 04:34:08 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N7ymy32m9zRp6P;
        Fri, 11 Nov 2022 20:33:54 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 20:34:06 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 20:34:06 +0800
Subject: Re: [PATCH v2] rcu: Dump memory object info if callback function is
 invalid
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Neeraj Upadhyay" <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221111102822.224-1-thunder.leizhen@huawei.com>
 <PH0PR11MB5880E3A11437CD0402941F4DDA009@PH0PR11MB5880.namprd11.prod.outlook.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <ed264f0e-bc13-5662-1a71-1458952ffd71@huawei.com>
Date:   Fri, 11 Nov 2022 20:34:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <PH0PR11MB5880E3A11437CD0402941F4DDA009@PH0PR11MB5880.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/11 19:54, Zhang, Qiang1 wrote:
>> When a structure containing an RCU callback rhp is (incorrectly) freed
>> and reallocated after rhp is passed to call_rcu(), it is not unusual for
>> rhp->func to be set to NULL. This defeats the debugging prints used by
>> __call_rcu_common() in kernels built with CONFIG_DEBUG_OBJECTS_RCU_HEAD=y,
>> which expect to identify the offending code using the identity of this
>> function.
>>
>> And in kernels build without CONFIG_DEBUG_OBJECTS_RCU_HEAD=y, things
>> are even worse, as can be seen from this splat:
>>
>> Unable to handle kernel NULL pointer dereference at virtual address 0
>> ... ...
>> PC is at 0x0
>> LR is at rcu_do_batch+0x1c0/0x3b8
>> ... ...
>> (rcu_do_batch) from (rcu_core+0x1d4/0x284)
>> (rcu_core) from (__do_softirq+0x24c/0x344)
>> (__do_softirq) from (__irq_exit_rcu+0x64/0x108)
>> (__irq_exit_rcu) from (irq_exit+0x8/0x10)
>> (irq_exit) from (__handle_domain_irq+0x74/0x9c)
>> (__handle_domain_irq) from (gic_handle_irq+0x8c/0x98)
>> (gic_handle_irq) from (__irq_svc+0x5c/0x94)
>> (__irq_svc) from (arch_cpu_idle+0x20/0x3c)
>> (arch_cpu_idle) from (default_idle_call+0x4c/0x78)
>> (default_idle_call) from (do_idle+0xf8/0x150)
>> (do_idle) from (cpu_startup_entry+0x18/0x20)
>> (cpu_startup_entry) from (0xc01530)
>>
>> This commit therefore adds calls to mem_dump_obj(rhp) to output some
>> information, for example:
>>
>>  slab kmalloc-256 start ffff410c45019900 pointer offset 0 size 256
>>
>> This provides the rough size of the memory block and the offset of the
>> rcu_head structure, which as least provides at least a few clues to help
>> locate the problem. If the problem is reproducible, additional slab
>> debugging can be enabled, for example, CONFIG_DEBUG_SLAB=y, which can
>> provide significantly more information.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>> ---
>> kernel/rcu/rcu.h      | 7 +++++++
>> kernel/rcu/srcutiny.c | 1 +
>> kernel/rcu/srcutree.c | 1 +
>> kernel/rcu/tasks.h    | 1 +
>> kernel/rcu/tiny.c     | 1 +
>> kernel/rcu/tree.c     | 1 +
>> 6 files changed, 12 insertions(+)
>>
>> v1 --> v2:
>> 1. Remove condition "(unsigned long)rhp->func & 0x3", it have problems on x86.
>> 2. Paul E. McKenney helped me update the commit message, thanks.
>>
> 
> Hi, Zhen Lei
> 
> Maybe the following scenarios should be considered:
> 
>                 CPU 0
> tasks context
>    spin_lock(&vmap_area_lock)
>           Interrupt 
> 	 RCU softirq
> 	      rcu_do_batch
> 		mem_dump_obj
>                                   vmalloc_dump_obj
>                                        spin_lock(&vmap_area_lock)   <--  deadlock     

Right, thanks. I just saw the robot's report. So this patch should be dropped.
I'll try to add an helper in mm, where I can check whether the lock has been
held, and dump the content of memory object.

> 
> Thanks
> Zqiang
> 
> 
>> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
>> index 65704cbc9df7b3d..32ab45fabf8eebf 100644
>> --- a/kernel/rcu/rcu.h
>> +++ b/kernel/rcu/rcu.h
>> @@ -10,6 +10,7 @@
>> #ifndef __LINUX_RCU_H
>> #define __LINUX_RCU_H
>>
>> +#include <linux/mm.h>
>> #include <trace/events/rcu.h>
>>
>> /*
>> @@ -211,6 +212,12 @@ static inline void debug_rcu_head_unqueue(struct rcu_head *head)
>> }
>> #endif	/* #else !CONFIG_DEBUG_OBJECTS_RCU_HEAD */
>>
>> +static inline void debug_rcu_head_callback(struct rcu_head *rhp)
>> +{
>> +	if (unlikely(!rhp->func))
>> +		mem_dump_obj(rhp);
>> +}
>> +
>> extern int rcu_cpu_stall_suppress_at_boot;
>>
>> static inline bool rcu_stall_is_suppressed_at_boot(void)
>> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
>> index 33adafdad261389..5e7f336baa06ae0 100644
>> --- a/kernel/rcu/srcutiny.c
>> +++ b/kernel/rcu/srcutiny.c
>> @@ -138,6 +138,7 @@ void srcu_drive_gp(struct work_struct *wp)
>> 	while (lh) {
>> 		rhp = lh;
>> 		lh = lh->next;
>> +		debug_rcu_head_callback(rhp);
>> 		local_bh_disable();
>> 		rhp->func(rhp);
>> 		local_bh_enable();
>> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>> index ca4b5dcec675bac..294972e66b31863 100644
>> --- a/kernel/rcu/srcutree.c
>> +++ b/kernel/rcu/srcutree.c
>> @@ -1631,6 +1631,7 @@ static void srcu_invoke_callbacks(struct work_struct *work)
>> 	rhp = rcu_cblist_dequeue(&ready_cbs);
>> 	for (; rhp != NULL; rhp = rcu_cblist_dequeue(&ready_cbs)) {
>> 		debug_rcu_head_unqueue(rhp);
>> +		debug_rcu_head_callback(rhp);
>> 		local_bh_disable();
>> 		rhp->func(rhp);
>> 		local_bh_enable();
>> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
>> index b0b885e071fa8dc..b7f8c67c586cdc4 100644
>> --- a/kernel/rcu/tasks.h
>> +++ b/kernel/rcu/tasks.h
>> @@ -478,6 +478,7 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
>> 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
>> 	len = rcl.len;
>> 	for (rhp = rcu_cblist_dequeue(&rcl); rhp; rhp = rcu_cblist_dequeue(&rcl)) {
>> +		debug_rcu_head_callback(rhp);
>> 		local_bh_disable();
>> 		rhp->func(rhp);
>> 		local_bh_enable();
>> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
>> index bb8f7d270f01747..56e9a5d91d97ec5 100644
>> --- a/kernel/rcu/tiny.c
>> +++ b/kernel/rcu/tiny.c
>> @@ -97,6 +97,7 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
>>
>> 	trace_rcu_invoke_callback("", head);
>> 	f = head->func;
>> +	debug_rcu_head_callback(head);
>> 	WRITE_ONCE(head->func, (rcu_callback_t)0L);
>> 	f(head);
>> 	rcu_lock_release(&rcu_callback_map);
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index 15aaff3203bf2d0..ed93ddb8203d42c 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -2088,6 +2088,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
>> 		trace_rcu_invoke_callback(rcu_state.name, rhp);
>>
>> 		f = rhp->func;
>> +		debug_rcu_head_callback(rhp);
>> 		WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
>> 		f(rhp);
>>
>> -- 
>> 2.25.1
> 
> .
> 

-- 
Regards,
  Zhen Lei
