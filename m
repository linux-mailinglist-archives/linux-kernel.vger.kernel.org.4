Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EF06E03D9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 03:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjDMBuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 21:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDMBuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 21:50:02 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104AC5599;
        Wed, 12 Apr 2023 18:49:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0Vfy7mto_1681350593;
Received: from 30.240.113.14(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vfy7mto_1681350593)
          by smtp.aliyun-inc.com;
          Thu, 13 Apr 2023 09:49:55 +0800
Message-ID: <cdf60454-c026-def4-b582-0ff894f98acf@linux.alibaba.com>
Date:   Thu, 13 Apr 2023 09:49:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v5 2/2] ACPI: APEI: handle synchronous exceptions in task
 work
Content-Language: en-US
To:     Xiaofei Tan <tanxiaofei@huawei.com>, mawupeng1@huawei.com,
        tony.luck@intel.com, naoya.horiguchi@nec.com
Cc:     linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, justin.he@arm.com,
        akpm@linux-foundation.org, ardb@kernel.org, ashish.kalra@amd.com,
        baolin.wang@linux.alibaba.com, bp@alien8.de,
        cuibixuan@linux.alibaba.com, dave.hansen@linux.intel.com,
        james.morse@arm.com, jarkko@kernel.org, lenb@kernel.org,
        linmiaohe@huawei.com, lvying6@huawei.com, rafael@kernel.org,
        xiexiuqi@huawei.com, zhuo.song@linux.alibaba.com
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20230411104842.37079-3-xueshuai@linux.alibaba.com>
 <e52f39f9-3a36-869e-b321-55dfc8a44ad0@huawei.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <e52f39f9-3a36-869e-b321-55dfc8a44ad0@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/12 PM12:05, Xiaofei Tan wrote:
> 
> 在 2023/4/11 18:48, Shuai Xue 写道:
>> Hardware errors could be signaled by synchronous interrupt, e.g.  when an
>> error is detected by a background scrubber, or signaled by synchronous
>> exception, e.g. when an uncorrected error is consumed. Both synchronous and
>> asynchronous error are queued and handled by a dedicated kthread in
>> workqueue.
>>
>> commit 7f17b4a121d0 ("ACPI: APEI: Kick the memory_failure() queue for
>> synchronous errors") keep track of whether memory_failure() work was
>> queued, and make task_work pending to flush out the workqueue so that the
>> work for synchronous error is processed before returning to user-space.
>> The trick ensures that the corrupted page is unmapped and poisoned. And
>> after returning to user-space, the task starts at current instruction which
>> triggering a page fault in which kernel will send SIGBUS to current process
>> due to VM_FAULT_HWPOISON.
>>
>> However, the memory failure recovery for hwpoison-aware mechanisms does not
>> work as expected. For example, hwpoison-aware user-space processes like
>> QEMU register their customized SIGBUS handler and enable early kill mode by
>> seting PF_MCE_EARLY at initialization. Then the kernel will directy notify
>> the process by sending a SIGBUS signal in memory failure with wrong
>> si_code: the actual user-space process accessing the corrupt memory
>> location, but its memory failure work is handled in a kthread context, so
>> it will send SIGBUS with BUS_MCEERR_AO si_code to the actual user-space
>> process instead of BUS_MCEERR_AR in kill_proc().
>>
>> To this end, separate synchronous and asynchronous error handling into
>> different paths like X86 platform does:
>>
>> - valid synchronous errors: queue a task_work to synchronously send SIGBUS
>>    before ret_to_user.
>> - valid asynchronous errors: queue a work into workqueue to asynchronously
>>    handle memory failure.
>> - abnormal branches such as invalid PA, unexpected severity, no memory
>>    failure config support, invalid GUID section, OOM, etc.
>>
>> Then for valid synchronous errors, the current context in memory failure is
>> exactly belongs to the task consuming poison data and it will send SIBBUS
>> with proper si_code.
>>
>> Fixes: 7f17b4a121d0 ("ACPI: APEI: Kick the memory_failure() queue for synchronous errors")
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> Tested-by: Ma Wupeng <mawupeng1@huawei.com>
>> ---
>>   drivers/acpi/apei/ghes.c | 91 +++++++++++++++++++++++++++-------------
>>   include/acpi/ghes.h      |  3 --
>>   mm/memory-failure.c      | 13 ------
>>   3 files changed, 61 insertions(+), 46 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index c479b85899f5..4b70955e25f9 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -452,28 +452,51 @@ static void ghes_clear_estatus(struct ghes *ghes,
>>   }
>>     /*
>> - * Called as task_work before returning to user-space.
>> - * Ensure any queued work has been done before we return to the context that
>> - * triggered the notification.
>> + * struct sync_task_work - for synchronous RAS event
>> + *
>> + * @twork:                callback_head for task work
>> + * @pfn:                  page frame number of corrupted page
>> + * @flags:                fine tune action taken
>> + *
>> + * Structure to pass task work to be handled before
>> + * ret_to_user via task_work_add().
>>    */
>> -static void ghes_kick_task_work(struct callback_head *head)
>> +struct sync_task_work {
>> +    struct callback_head twork;
>> +    u64 pfn;
>> +    int flags;
>> +};
>> +
>> +static void memory_failure_cb(struct callback_head *twork)
>>   {
>> -    struct acpi_hest_generic_status *estatus;
>> -    struct ghes_estatus_node *estatus_node;
>> -    u32 node_len;
>> +    int ret;
>> +    struct sync_task_work *twcb =
>> +        container_of(twork, struct sync_task_work, twork);
>>   -    estatus_node = container_of(head, struct ghes_estatus_node, task_work);
>> -    if (IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
>> -        memory_failure_queue_kick(estatus_node->task_work_cpu);
>> +    ret = memory_failure(twcb->pfn, twcb->flags);
>> +    kfree(twcb);
>>   -    estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
>> -    node_len = GHES_ESTATUS_NODE_LEN(cper_estatus_len(estatus));
>> -    gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node, node_len);
>> +    if (!ret)
>> +        return;
>> +
>> +    /*
>> +     * -EHWPOISON from memory_failure() means that it already sent SIGBUS
>> +     * to the current process with the proper error info,
>> +     * -EOPNOTSUPP means hwpoison_filter() filtered the error event,
>> +     *
>> +     * In both cases, no further processing is required.
>> +     */
>> +    if (ret == -EHWPOISON || ret == -EOPNOTSUPP)
>> +        return;
>> +
>> +    pr_err("Memory error not recovered");
> 
> The print could add the following SIGBUS signal sending.
> Such as "Sending SIGBUS to current task due to memory error not recovered"
> 
>> +    force_sig(SIGBUS);
>>   }
>>     static bool ghes_do_memory_failure(u64 physical_addr, int flags)
>>   {
>>       unsigned long pfn;
>> +    struct sync_task_work *twcb;
>>         if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
>>           return false;
>> @@ -486,6 +509,18 @@ static bool ghes_do_memory_failure(u64 physical_addr, int flags)
>>           return false;
>>       }
>>   +    if (flags == MF_ACTION_REQUIRED && current->mm) {
>> +        twcb = kmalloc(sizeof(*twcb), GFP_ATOMIC);
>> +        if (!twcb)
>> +            return false;
>> +
>> +        twcb->pfn = pfn;
>> +        twcb->flags = flags;
>> +        init_task_work(&twcb->twork, memory_failure_cb);
>> +        task_work_add(current, &twcb->twork, TWA_RESUME);
>> +        return true;
>> +    }
>> +
>>       memory_failure_queue(pfn, flags);
>>       return true;
>>   }
>> @@ -1000,9 +1035,8 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
>>       struct ghes_estatus_node *estatus_node;
>>       struct acpi_hest_generic *generic;
>>       struct acpi_hest_generic_status *estatus;
>> -    bool task_work_pending;
>> +    bool queued, sync;
>>       u32 len, node_len;
>> -    int ret;
>>         llnode = llist_del_all(&ghes_estatus_llist);
>>       /*
>> @@ -1015,27 +1049,25 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
>>           estatus_node = llist_entry(llnode, struct ghes_estatus_node,
>>                          llnode);
>>           estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
>> +        sync = is_hest_sync_notify(estatus_node->ghes);
>>           len = cper_estatus_len(estatus);
>>           node_len = GHES_ESTATUS_NODE_LEN(len);
>> -        task_work_pending = ghes_do_proc(estatus_node->ghes, estatus);
>> +
>> +        queued = ghes_do_proc(estatus_node->ghes, estatus);
>> +        /*
>> +         * If no memory failure work is queued for abnormal synchronous
>> +         * errors, do a force kill.
>> +         */
>> +        if (sync && !queued)
>> +            force_sig(SIGBUS);
> 
> Could also add one similar print here as above
> Apart from this,
> Reviewed-by: Xiaofei Tan <tanxiaofei@huawei.com>

Thanks :)

Sorry, I missed your replies, because Thunderbird marks an email as Junk,
just move it to the Junk folder.

I'd like to add above warning message and pick up your reviewed-by tag.

Cheers,
Shuai



> 
>> +
>>           if (!ghes_estatus_cached(estatus)) {
>>               generic = estatus_node->generic;
>>               if (ghes_print_estatus(NULL, generic, estatus))
>>                   ghes_estatus_cache_add(generic, estatus);
>>           }
>> -
>> -        if (task_work_pending && current->mm) {
>> -            estatus_node->task_work.func = ghes_kick_task_work;
>> -            estatus_node->task_work_cpu = smp_processor_id();
>> -            ret = task_work_add(current, &estatus_node->task_work,
>> -                        TWA_RESUME);
>> -            if (ret)
>> -                estatus_node->task_work.func = NULL;
>> -        }
>> -
>> -        if (!estatus_node->task_work.func)
>> -            gen_pool_free(ghes_estatus_pool,
>> -                      (unsigned long)estatus_node, node_len);
>> +        gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node,
>> +                  node_len);
>>             llnode = next;
>>       }
>> @@ -1096,7 +1128,6 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
>>         estatus_node->ghes = ghes;
>>       estatus_node->generic = ghes->generic;
>> -    estatus_node->task_work.func = NULL;
>>       estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
>>         if (__ghes_read_estatus(estatus, buf_paddr, fixmap_idx, len)) {
>> diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
>> index 3c8bba9f1114..e5e0c308d27f 100644
>> --- a/include/acpi/ghes.h
>> +++ b/include/acpi/ghes.h
>> @@ -35,9 +35,6 @@ struct ghes_estatus_node {
>>       struct llist_node llnode;
>>       struct acpi_hest_generic *generic;
>>       struct ghes *ghes;
>> -
>> -    int task_work_cpu;
>> -    struct callback_head task_work;
>>   };
>>     struct ghes_estatus_cache {
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index fae9baf3be16..6ea8c325acb3 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -2355,19 +2355,6 @@ static void memory_failure_work_func(struct work_struct *work)
>>       }
>>   }
>>   -/*
>> - * Process memory_failure work queued on the specified CPU.
>> - * Used to avoid return-to-userspace racing with the memory_failure workqueue.
>> - */
>> -void memory_failure_queue_kick(int cpu)
>> -{
>> -    struct memory_failure_cpu *mf_cpu;
>> -
>> -    mf_cpu = &per_cpu(memory_failure_cpu, cpu);
>> -    cancel_work_sync(&mf_cpu->work);
>> -    memory_failure_work_func(&mf_cpu->work);
>> -}
>> -
>>   static int __init memory_failure_init(void)
>>   {
>>       struct memory_failure_cpu *mf_cpu;
