Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1512715304
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 03:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjE3BoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 21:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjE3BoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 21:44:11 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18274D9
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 18:44:08 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QVZrK0p8wzsSYZ;
        Tue, 30 May 2023 09:41:53 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 09:44:05 +0800
Message-ID: <5eea1d90-a903-d211-9dd7-38cd824c1573@huawei.com>
Date:   Tue, 30 May 2023 09:44:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 1/3] genirq: Use hlist for managing resend handlers
To:     Marc Zyngier <maz@kernel.org>
CC:     Shanker Donthineni <sdonthineni@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Walle <michael@walle.cc>,
        <linux-kernel@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>,
        Jason Sequeira <jsequeira@nvidia.com>
References: <20230519134902.1495562-1-sdonthineni@nvidia.com>
 <20230519134902.1495562-2-sdonthineni@nvidia.com>
 <6dc6642a-1e7c-f111-1fa2-be54826ecef6@huawei.com>
 <86cz2jcykv.wl-maz@kernel.org>
From:   "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <86cz2jcykv.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marc

在 2023/5/29 16:48, Marc Zyngier 写道:
> On Mon, 29 May 2023 08:57:07 +0100,
> "Liao, Chang" <liaochang1@huawei.com> wrote:
>>
>> Hi, Shanker
>>
>> 在 2023/5/19 21:49, Shanker Donthineni 写道:
>>> The current implementation utilizes a bitmap for managing IRQ resend
>>> handlers, which is allocated based on the SPARSE_IRQ/NR_IRQS macros.
>>> However, this method may not efficiently utilize memory during runtime,
>>> particularly when IRQ_BITMAP_BITS is large.
>>>
>>> Address this issue by using the hlist to manage IRQ resend handlers
>>> instead of relying on a static bitmap memory allocation. Additionally,
>>> a new function, clear_irq_resend(), is introduced and called from
>>> irq_shutdown to ensure a graceful teardown of the interrupt.
>>>
>>> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
>>> ---
>>>  include/linux/irqdesc.h |  3 +++
>>>  kernel/irq/chip.c       |  1 +
>>>  kernel/irq/internals.h  |  2 ++
>>>  kernel/irq/irqdesc.c    |  2 ++
>>>  kernel/irq/resend.c     | 47 ++++++++++++++++++++++++++---------------
>>>  5 files changed, 38 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
>>> index 844a8e30e6de..d9451d456a73 100644
>>> --- a/include/linux/irqdesc.h
>>> +++ b/include/linux/irqdesc.h
>>> @@ -102,6 +102,9 @@ struct irq_desc {
>>>  	int			parent_irq;
>>>  	struct module		*owner;
>>>  	const char		*name;
>>> +#ifdef CONFIG_HARDIRQS_SW_RESEND
>>> +	struct hlist_node	resend_node;
>>> +#endif
>>>  } ____cacheline_internodealigned_in_smp;
>>
>> Although there is no documented rule that limits the change of the KABI
>> struct irq_desc, it is still better to keep the irq_desc definition stable.
> 
> On what grounds? There is no such thing as a stable in-kernel ABI,
> specially for things as internal as irq_desc.

Okay, helpful.

> 
>>>  
>>>  #ifdef CONFIG_SPARSE_IRQ
>>> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
>>> index 49e7bc871fec..2eac5532c3c8 100644
>>> --- a/kernel/irq/chip.c
>>> +++ b/kernel/irq/chip.c
>>> @@ -306,6 +306,7 @@ static void __irq_disable(struct irq_desc *desc, bool mask);
>>>  void irq_shutdown(struct irq_desc *desc)
>>>  {
>>>  	if (irqd_is_started(&desc->irq_data)) {
>>> +		clear_irq_resend(desc);
>>>  		desc->depth = 1;
>>>  		if (desc->irq_data.chip->irq_shutdown) {
>>>  			desc->irq_data.chip->irq_shutdown(&desc->irq_data);
>>> diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
>>> index 5fdc0b557579..51fc8c497c22 100644
>>> --- a/kernel/irq/internals.h
>>> +++ b/kernel/irq/internals.h
>>> @@ -113,6 +113,8 @@ irqreturn_t handle_irq_event(struct irq_desc *desc);
>>>  
>>>  /* Resending of interrupts :*/
>>>  int check_irq_resend(struct irq_desc *desc, bool inject);
>>> +void clear_irq_resend(struct irq_desc *desc);
>>> +void irq_resend_init(struct irq_desc *desc);
>>>  bool irq_wait_for_poll(struct irq_desc *desc);
>>>  void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action);
>>>  
>>> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
>>> index 240e145e969f..b401b89b226a 100644
>>> --- a/kernel/irq/irqdesc.c
>>> +++ b/kernel/irq/irqdesc.c
>>> @@ -415,6 +415,7 @@ static struct irq_desc *alloc_desc(int irq, int node, unsigned int flags,
>>>  	desc_set_defaults(irq, desc, node, affinity, owner);
>>>  	irqd_set(&desc->irq_data, flags);
>>>  	kobject_init(&desc->kobj, &irq_kobj_type);
>>> +	irq_resend_init(desc);
>>>  
>>>  	return desc;
>>>  
>>> @@ -581,6 +582,7 @@ int __init early_irq_init(void)
>>>  		mutex_init(&desc[i].request_mutex);
>>>  		init_waitqueue_head(&desc[i].wait_for_threads);
>>>  		desc_set_defaults(i, &desc[i], node, NULL, NULL);
>>> +		irq_resend_init(desc);
>>>  	}
>>>  	return arch_early_irq_init();
>>>  }
>>> diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
>>> index 0c46e9fe3a89..edec335c0a7a 100644
>>> --- a/kernel/irq/resend.c
>>> +++ b/kernel/irq/resend.c
>>> @@ -21,8 +21,9 @@
>>>  
>>>  #ifdef CONFIG_HARDIRQS_SW_RESEND
>>>  
>>> -/* Bitmap to handle software resend of interrupts: */
>>> -static DECLARE_BITMAP(irqs_resend, IRQ_BITMAP_BITS);
>>> +/* hlist_head to handle software resend of interrupts: */
>>> +static HLIST_HEAD(irq_resend_list);
>>> +static DEFINE_RAW_SPINLOCK(irq_resend_lock);
>>
>> What is the benefit of using hlist here? If you want to enjoy the
>> low latency of querying elements by key, you must define a hlist table
>> with a reasonable number of buckets. Otherwise, I don't think the time
>> complexity of hlist is better than a regular double-linked list, right?
> 
> You do realise that the list is processed in order, one element after
> the other, without ever querying any arbitrary element? Have you read
> the code?

Yes, so i *wonder* why not use regular a linked-list here if no need to do
arbitrary querying. I have no doubt the idea of these changes are sound,
just curious about the data structure used to maintain resend IRQs.

> 
>>
>>>  
>>>  /*
>>>   * Run software resends of IRQ's
>>> @@ -30,18 +31,17 @@ static DECLARE_BITMAP(irqs_resend, IRQ_BITMAP_BITS);
>>>  static void resend_irqs(struct tasklet_struct *unused)
>>>  {
>>>  	struct irq_desc *desc;
>>> -	int irq;
>>> -
>>> -	while (!bitmap_empty(irqs_resend, nr_irqs)) {
>>> -		irq = find_first_bit(irqs_resend, nr_irqs);
>>> -		clear_bit(irq, irqs_resend);
>>> -		desc = irq_to_desc(irq);
>>> -		if (!desc)
>>> -			continue;
>>> -		local_irq_disable();
>>> +
>>> +	raw_spin_lock_irq(&irq_resend_lock);
>>> +	while (!hlist_empty(&irq_resend_list)) {
>>> +		desc = hlist_entry(irq_resend_list.first, struct irq_desc,
>>> +				   resend_node);
>>> +		hlist_del_init(&desc->resend_node);
>>> +		raw_spin_unlock(&irq_resend_lock);
>>>  		desc->handle_irq(desc);
>>> -		local_irq_enable();
>>> +		raw_spin_lock(&irq_resend_lock);
>>>  	}
>>> +	raw_spin_unlock_irq(&irq_resend_lock);
>>>  }
>>>  
>>>  /* Tasklet to handle resend: */
>>> @@ -49,8 +49,6 @@ static DECLARE_TASKLET(resend_tasklet, resend_irqs);
>>>  
>>>  static int irq_sw_resend(struct irq_desc *desc)
>>>  {
>>> -	unsigned int irq = irq_desc_get_irq(desc);
>>> -
>>>  	/*
>>>  	 * Validate whether this interrupt can be safely injected from
>>>  	 * non interrupt context
>>> @@ -70,16 +68,31 @@ static int irq_sw_resend(struct irq_desc *desc)
>>>  		 */
>>>  		if (!desc->parent_irq)
>>>  			return -EINVAL;
>>> -		irq = desc->parent_irq;
>>
>> Why delete this code?
> 
> OK, now I know you haven't read this code at all :-(.

Sorry for the noise, I overlook some core changes.

> 
>>
>>>  	}
>>>  
>>> -	/* Set it pending and activate the softirq: */
>>> -	set_bit(irq, irqs_resend);
>>> +	/* Add to resend_list and activate the softirq: */
>>> +	raw_spin_lock(&irq_resend_lock);
>>> +	hlist_add_head(&desc->resend_node, &irq_resend_list);
>>> +	raw_spin_unlock(&irq_resend_lock);
>>
>> Do you conside a situation where irq_sw_resend() is running on two CPUs concurrently?
>> If so, the same desc could be added into irq_resend_list twice by mistake.
> 
> Have you looked at the calling site (stress on singular), the locking
> requirements, and the role IRQS_REPLAY plays when it comes to queuing
> an interrupt for resend?

I see, the IRQS_REPLAY and locking of irq_desc ensure that irq_sw_resend() is not called
on the same interrupt concurrently, thanks for pointing that out.

> 
> 	M.
> 

-- 
BR
Liao, Chang
