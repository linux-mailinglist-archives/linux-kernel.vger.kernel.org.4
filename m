Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E31B63A265
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 08:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiK1H7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 02:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiK1H7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 02:59:50 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE012114E;
        Sun, 27 Nov 2022 23:59:48 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NLHt54sZgzRpZ6;
        Mon, 28 Nov 2022 15:59:09 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 28 Nov 2022 15:59:46 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 28 Nov 2022 15:59:46 +0800
Subject: Re: [PATCH v3] mm: Make vmalloc_dump_obj() call in clean context
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>
CC:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221118003441.3980437-1-qiang1.zhang@intel.com>
 <PH0PR11MB58802C9BF5683925DF983A4FDA0D9@PH0PR11MB5880.namprd11.prod.outlook.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <de550275-b8dd-e958-4f34-5ec545ed4f43@huawei.com>
Date:   Mon, 28 Nov 2022 15:59:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <PH0PR11MB58802C9BF5683925DF983A4FDA0D9@PH0PR11MB5880.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/23 7:05, Zhang, Qiang1 wrote:
> 
> Gently ping  😊
> 
> Thanks
> Zqiang
> 
>> Currently, the mem_dump_obj() is invoked in call_rcu(), the
>> call_rcu() is maybe invoked in non-preemptive code segment,
>> for object allocated from vmalloc(), the following scenarios
>> may occur:
>>
>>        CPU 0
>> tasks context
>>   spin_lock(&vmap_area_lock)
>>       Interrupt context
>>           call_rcu()
>>             mem_dump_obj
>>               vmalloc_dump_obj
>>                 spin_lock(&vmap_area_lock) <--deadlock
>>
>> and for PREEMPT-RT kernel, the spinlock will convert to sleepable
>> lock, so the vmap_area_lock spinlock not allowed to get in non-preemptive
>> code segment. therefore, this commit make the vmalloc_dump_obj() call in
>> a clean context.
>>
>> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>> ---
>> v1->v2:
>> add IS_ENABLED(CONFIG_PREEMPT_RT) check.
>> v2->v3:
>> change commit message and add some comment.
>>
>> mm/util.c    |  4 +++-
>> mm/vmalloc.c | 25 +++++++++++++++++++++++++
>> 2 files changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/util.c b/mm/util.c
>> index 12984e76767e..2b0222a728cc 100644
>> --- a/mm/util.c
>> +++ b/mm/util.c
>> @@ -1128,7 +1128,9 @@ void mem_dump_obj(void *object)
>> 		return;
>>
>> 	if (virt_addr_valid(object))
>> -		type = "non-slab/vmalloc memory";
>> +		type = "non-slab memory";
>> +	else if (is_vmalloc_addr(object))
>> +		type = "vmalloc memory";
>> 	else if (object == NULL)
>> 		type = "NULL pointer";
>> 	else if (object == ZERO_SIZE_PTR)
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index ccaa461998f3..4351eafbe7ab 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -4034,6 +4034,31 @@ bool vmalloc_dump_obj(void *object)
>> 	struct vm_struct *vm;
>> 	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
>>
>> +	/* for non-vmalloc addr, return directly */
>> +	if (!is_vmalloc_addr(objp))
>> +		return false;
>> +
>> +	/**
>> +	 * for non-Preempt-RT kernel, return directly. otherwise not
>> +	 * only needs to determine whether it is in the interrupt context
>> +	 * (in_interrupt())to avoid deadlock, but also to avoid acquire
>> +	 * vmap_area_lock spinlock in disables interrupts or preempts
>> +	 * critical sections, because the vmap_area_lock spinlock convert
>> +	 * to sleepable lock
>> +	 */
>> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
>> +		return false;
>> +
>> +	/**
>> +	 * get here, for Preempt-RT kernel, it means that we are in
>> +	 * preemptible context(preemptible() is true), it also means
>> +	 * that the in_interrupt() will return false.
>> +	 * for non-Preempt-RT kernel, only needs to determine whether
>> +	 * it is in the interrupt context(in_interrupt()) to avoid deadlock
>> +	 */
>> +	if (in_interrupt())
>> +		return false;

We want mem_dump_obj() to work properly in the interrupt context. But with
this if statement, it's impossible to work properly.

Here's my test case:
void *tst_p;

void my_irqwork_handler(struct irq_work *work)
{
        void *p = tst_p;

        printk("enter my_irqwork_handler: CPU=%d, locked=%d\n", smp_processor_id(), tst_is_locked());
        mem_dump_obj(p);
        vfree(p);
}

static void test_mem_dump(void)
{
        struct irq_work work = IRQ_WORK_INIT_HARD(my_irqwork_handler);

        tst_p = vmalloc(PAGE_SIZE);
        if (!tst_p) {
                printk("vmalloc failed\n");
                return;
        }
        printk("enter test_mem_dump: CPU=%d\n", smp_processor_id());

        //tst_lock();
        irq_work_queue(&work);
        //tst_unlock();

        printk("leave test_mem_dump: CPU=%d\n", smp_processor_id());
}

Test result:
[   45.212941] enter test_mem_dump: CPU=0
[   45.213280] enter my_irqwork_handler: CPU=0, locked=0
[   45.213546]  vmalloc memory
[   45.213996] leave test_mem_dump: CPU=0

>> +
>> 	vm = find_vm_area(objp);
>> 	if (!vm)
>> 		return false;
>> -- 
>> 2.25.1
> 

-- 
Regards,
  Zhen Lei
