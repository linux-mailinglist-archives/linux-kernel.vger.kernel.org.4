Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CED562D0A7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 02:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbiKQBaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 20:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbiKQB3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 20:29:54 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BF245EE8;
        Wed, 16 Nov 2022 17:29:53 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NCMhL1xQ6zJnlS;
        Thu, 17 Nov 2022 09:26:42 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 09:29:51 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 09:29:50 +0800
Subject: Re: [PATCH v2] rcu: Dump memory object info if callback function is
 invalid
To:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, <Zhang@pc638.lan>,
        Qiang1 <qiang1.zhang@intel.com>
CC:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221111102822.224-1-thunder.leizhen@huawei.com>
 <PH0PR11MB5880E3A11437CD0402941F4DDA009@PH0PR11MB5880.namprd11.prod.outlook.com>
 <ed264f0e-bc13-5662-1a71-1458952ffd71@huawei.com>
 <PH0PR11MB5880FEAD72BAE59185256195DA009@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20221111184238.GX725751@paulmck-ThinkPad-P17-Gen-1>
 <Y3KHdBjAIR3FNKpS@pc638.lan>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <4ad22327-96c6-b97a-338c-ee6a09d50d5c@huawei.com>
Date:   Thu, 17 Nov 2022 09:29:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Y3KHdBjAIR3FNKpS@pc638.lan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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



On 2022/11/15 2:22, Uladzislau Rezki wrote:
>> On Fri, Nov 11, 2022 at 01:05:56PM +0000, Zhang, Qiang1 wrote:
>>> On 2022/11/11 19:54, Zhang, Qiang1 wrote:
>>>>> When a structure containing an RCU callback rhp is (incorrectly) 
>>>>> freed and reallocated after rhp is passed to call_rcu(), it is not 
>>>>> unusual for
>>>>> rhp->func to be set to NULL. This defeats the debugging prints used 
>>>>> rhp->by
>>>>> __call_rcu_common() in kernels built with 
>>>>> CONFIG_DEBUG_OBJECTS_RCU_HEAD=y, which expect to identify the 
>>>>> offending code using the identity of this function.
>>>>>
>>>>> And in kernels build without CONFIG_DEBUG_OBJECTS_RCU_HEAD=y, things 
>>>>> are even worse, as can be seen from this splat:
>>>>>
>>>>> Unable to handle kernel NULL pointer dereference at virtual address 0 
>>>>> ... ...
>>>>> PC is at 0x0
>>>>> LR is at rcu_do_batch+0x1c0/0x3b8
>>>>> ... ...
>>>>> (rcu_do_batch) from (rcu_core+0x1d4/0x284)
>>>>> (rcu_core) from (__do_softirq+0x24c/0x344)
>>>>> (__do_softirq) from (__irq_exit_rcu+0x64/0x108)
>>>>> (__irq_exit_rcu) from (irq_exit+0x8/0x10)
>>>>> (irq_exit) from (__handle_domain_irq+0x74/0x9c)
>>>>> (__handle_domain_irq) from (gic_handle_irq+0x8c/0x98)
>>>>> (gic_handle_irq) from (__irq_svc+0x5c/0x94)
>>>>> (__irq_svc) from (arch_cpu_idle+0x20/0x3c)
>>>>> (arch_cpu_idle) from (default_idle_call+0x4c/0x78)
>>>>> (default_idle_call) from (do_idle+0xf8/0x150)
>>>>> (do_idle) from (cpu_startup_entry+0x18/0x20)
>>>>> (cpu_startup_entry) from (0xc01530)
>>>>>
>>>>> This commit therefore adds calls to mem_dump_obj(rhp) to output some 
>>>>> information, for example:
>>>>>
>>>>>  slab kmalloc-256 start ffff410c45019900 pointer offset 0 size 256
>>>>>
>>>>> This provides the rough size of the memory block and the offset of 
>>>>> the rcu_head structure, which as least provides at least a few clues 
>>>>> to help locate the problem. If the problem is reproducible, 
>>>>> additional slab debugging can be enabled, for example, 
>>>>> CONFIG_DEBUG_SLAB=y, which can provide significantly more information.
>>>>>
>>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>>>> ---
>>>>> kernel/rcu/rcu.h      | 7 +++++++
>>>>> kernel/rcu/srcutiny.c | 1 +
>>>>> kernel/rcu/srcutree.c | 1 +
>>>>> kernel/rcu/tasks.h    | 1 +
>>>>> kernel/rcu/tiny.c     | 1 +
>>>>> kernel/rcu/tree.c     | 1 +
>>>>> 6 files changed, 12 insertions(+)
>>>>>
>>>>> v1 --> v2:
>>>>> 1. Remove condition "(unsigned long)rhp->func & 0x3", it have problems on x86.
>>>>> 2. Paul E. McKenney helped me update the commit message, thanks.
>>>>>
>>>>
>>>> Hi, Zhen Lei
>>>>
>>>> Maybe the following scenarios should be considered:
>>>>
>>>>                 CPU 0
>>>> tasks context
>>>>    spin_lock(&vmap_area_lock)
>>>>           Interrupt 
>>>> 	 RCU softirq
>>>> 	      rcu_do_batch
>>>> 		mem_dump_obj
>>>>                                   vmalloc_dump_obj
>>>>                                        spin_lock(&vmap_area_lock)   <--  deadlock     
>>>
>>>> Right, thanks. I just saw the robot's report. So this patch should be dropped.
>>>> I'll try to add an helper in mm, where I can check whether the lock has been held, and dump the content of memory object.
>>>
>>> This is a workaround, or maybe try a modification like the following, 
>>> of course, need to ask Paul's opinion.
>>
>> Another approach is to schedule a workqueue handler to do the
>> mem_dump_obj().  This would allow mem_dump_obj() to run in a clean
>> environment.
>>
>> This would allow vmalloc_dump_obj() to be called unconditionally.
>>
>> Other thoughts?
>>
> <snip>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ca71de7c9d77..956eb28f9c77 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2591,6 +2591,19 @@ struct vm_struct *find_vm_area(const void *addr)
>  	return va->vm;
>  }
>  
> +static struct vm_struct *
> +find_vm_area_trylock(const void *addr)
> +{
> +	struct vmap_area *va = NULL;
> +
> +	if (spin_trylock(&vmap_area_lock)) {
> +		va = __find_vmap_area((unsigned long)addr, &vmap_area_root);
> +		spin_unlock(&vmap_area_lock);
> +	}
> +
> +	return va ? va->vm : NULL;
> +}

This method also has the problems mentioned by Andrew Morton.
https://lkml.org/lkml/2022/11/14/1238

> +
>  /**
>   * remove_vm_area - find and remove a continuous kernel virtual area
>   * @addr:	    base address
> @@ -4048,7 +4061,7 @@ bool vmalloc_dump_obj(void *object)
>  	struct vm_struct *vm;
>  	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
>  
> -	vm = find_vm_area(objp);
> +	vm = find_vm_area_trylock(objp);
>  	if (!vm)
>  		return false;
>  	pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
> <snip>
> 
> There is one issue though, it is not correct to reference vm->members
> after a lock is dropped because of: use after free bugs. It is better
> to embed the search and read out: nr_pages, addr, caller and drop the
> lock.
> 
> --
> Uladzislau Rezki
> .
> 

-- 
Regards,
  Zhen Lei
