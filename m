Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDC9653014
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 12:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbiLULPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 06:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiLULPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 06:15:50 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAA6B1E;
        Wed, 21 Dec 2022 03:15:46 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VXpNmI0_1671621341;
Received: from 192.168.31.240(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VXpNmI0_1671621341)
          by smtp.aliyun-inc.com;
          Wed, 21 Dec 2022 19:15:43 +0800
Message-ID: <41403288-3be7-56c3-3df8-974dfeb2c53c@linux.alibaba.com>
Date:   Wed, 21 Dec 2022 19:15:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [RFC PATCH v2 1/1] ACPI: APEI: Make memory_failure() triggered by
 synchronization errors execute in the current context
Content-Language: en-US
To:     Lv Ying <lvying6@huawei.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Xie XiuQi <xiexiuqi@huawei.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "xiezhipeng1@huawei.com" <xiezhipeng1@huawei.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "tanxiaofei@huawei.com" <tanxiaofei@huawei.com>,
        "cuibixuan@linux.alibaba.com" <cuibixuan@linux.alibaba.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20221209095407.383211-1-lvying6@huawei.com>
 <20221209095407.383211-2-lvying6@huawei.com>
 <20221215002520.GA2020717@hori.linux.bs1.fc.nec.co.jp>
 <76038f5b-914c-7ae0-e89f-500bd0c7502f@huawei.com>
 <685065ab-0807-425e-b2d5-c6c272bac70e@linux.alibaba.com>
 <127a6f29-3239-1954-da39-f76357d0caa2@huawei.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <127a6f29-3239-1954-da39-f76357d0caa2@huawei.com>
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



On 2022/12/16 PM8:23, Lv Ying wrote:
> On 2022/12/15 12:45, Shuai Xue wrote:
>>
>>
>> On 2022/12/15 AM10:45, Lv Ying wrote:
>>> On 2022/12/15 8:26, HORIGUCHI NAOYA(堀口 直也) wrote:
>>>> On Fri, Dec 09, 2022 at 05:54:07PM +0800, Lv Ying wrote:
>>>>> The memory uncorrected error which is detected by an external component and
>>>>> notified via an IRQ, can be called asynchronization error. If an error is
>>>>> detected as a result of user-space process accessing a corrupt memory
>>>>> location, the CPU may take an abort. On arm64 this is a
>>>>> 'synchronous external abort', and on a firmware first system it is notified
>>>>> via NOTIFY_SEA, this can be called synchronization error.
>>>>>
>>>>
>>>> "synchronization error" in this context looks weird to me, maybe you mean
>>>> "synchronous error" ?  There're many places using "synchronization", so
>>>> please use consistent wording.
>>>
>>> "synchronization error" in this context means "synchronous error", e.g SEA. Thanks for your suggestion, I will use consistent wording - "synchronous error".
>>>
>>>>
>>>>> Currently, synchronization error and asynchronization error both use
>>>>> memory_failure_queue to schedule memory_failure() exectute in kworker
>>>>> context. Commit 7f17b4a121d0 ("ACPI: APEI: Kick the memory_failure() queue
>>>>> for synchronous errors") make task_work pending to flush out the queue,
>>>>> cancel_work_sync() in memory_failure_queue_kick() will make
>>>>> memory_failure() exectute in kworker context first which will get
>>>>
>>>> s/exectute/execute/
>>>
>>> Thank you for your detailed review, I will check again and fix the typos and syntax errors in the patch.
>>>
>>>>
>>>>> synchronization error info from kfifo, so task_work later will get nothing
>>>>> from kfifo which doesn't work as expected. Even worse, synchronization
>>>>> error notification has NMI like properties, (it can interrupt IRQ-masked
>>>>> code), task_work may get wrong kfifo entry from interrupted
>>>>> asynchronization error which is notified by IRQ.
>>>>>
>>>>> Since the memory_failure() triggered by a synchronous exception is
>>>>> executed in the kworker context, the early_kill mode of memory_failure()
>>>>> will send wrong si_code by SIGBUS signal: current process is kworker
>>>>> thread, the actual user-space process accessing the corrupt memory location
>>>>> will be collected by find_early_kill_thread(), and then send SIGBUS with
>>>>> BUS_MCEERR_AO si_code to the actual user-space process instead of
>>>>> BUS_MCEERR_AR. The machine-manager(kvm) use the si_code: BUS_MCEERR_AO for
>>>>> 'action optional' early notifications, and BUS_MCEERR_AR for
>>>>> 'action required' synchronous/late notifications.
>>>>>
>>>>> Make memory_failure() triggered by synchronization errors execute in the
>>>>> current context, we do not need workqueue for synchronization error
>>>>> anymore, use task_work handle synchronization errors directly. Since,
>>>>> synchronization errors and asynchronization errors share the same kfifo,
>>>>> use MF_ACTION_REQUIRED flag to distinguish them. And the asynchronization
>>>>> error keeps the same as before.
>>>>>
>>>>> Currently, it's hard to distinguish synchronization error in APEI. It
>>>>> can be determined that the SEA report synchronization error, so
>>>>> currently only the synchronization error reported by SEA is distinguished
>>>>> and handled in current context.
>>>>>
>>>>> Signed-off-by: Lv Ying <lvying6@huawei.com>
>>>>> ---
>>>>>    drivers/acpi/apei/ghes.c | 20 +++++++++-------
>>>>>    mm/memory-failure.c      | 50 +++++++++++++++++++++++++++++-----------
>>>>>    2 files changed, 48 insertions(+), 22 deletions(-)
>>>>>
>>>>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>>>>> index 9952f3a792ba..19d62ec2177f 100644
>>>>> --- a/drivers/acpi/apei/ghes.c
>>>>> +++ b/drivers/acpi/apei/ghes.c
>>>>> @@ -423,8 +423,8 @@ static void ghes_clear_estatus(struct ghes *ghes,
>>>>>      /*
>>>>>     * Called as task_work before returning to user-space.
>>>>> - * Ensure any queued work has been done before we return to the context that
>>>>> - * triggered the notification.
>>>>> + * Ensure any queued corrupt page in synchronous errors has been handled before
>>>>> + * we return to the user context that triggered the notification.
>>>>>     */
>>>>>    static void ghes_kick_task_work(struct callback_head *head)
>>>>>    {
>>>>> @@ -461,7 +461,7 @@ static bool ghes_do_memory_failure(u64 physical_addr, int flags)
>>>>>    }
>>>>>      static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
>>>>> -                       int sev)
>>>>> +                       int sev, int notify_type)
>>>>>    {
>>>>>        int flags = -1;
>>>>>        int sec_sev = ghes_severity(gdata->error_severity);
>>>>> @@ -475,7 +475,7 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
>>>>>            (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
>>>>>            flags = MF_SOFT_OFFLINE;
>>>>>        if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
>>>>> -        flags = 0;
>>>>> +        flags = (notify_type == ACPI_HEST_NOTIFY_SEA) ? MF_ACTION_REQUIRED : 0;
>>>>>          if (flags != -1)
>>>>>            return ghes_do_memory_failure(mem_err->physical_addr, flags);
>>>>> @@ -483,7 +483,8 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
>>>>>        return false;
>>>>>    }
>>>>>    -static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int sev)
>>>>> +static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int sev,
>>>>> +        int notify_type)
>>>>>    {
>>>>>        struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
>>>>>        bool queued = false;
>>>>> @@ -510,7 +511,9 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int s
>>>>>             * and don't filter out 'corrected' error here.
>>>>>             */
>>>>>            if (is_cache && has_pa) {
>>>>> -            queued = ghes_do_memory_failure(err_info->physical_fault_addr, 0);
>>>>> +            queued = ghes_do_memory_failure(err_info->physical_fault_addr,
>>>>> +                    (notify_type == ACPI_HEST_NOTIFY_SEA) ?
>>>>> +                    MF_ACTION_REQUIRED : 0);
>>>>>                p += err_info->length;
>>>>>                continue;
>>>>>            }
>>>>> @@ -631,6 +634,7 @@ static bool ghes_do_proc(struct ghes *ghes,
>>>>>        const guid_t *fru_id = &guid_null;
>>>>>        char *fru_text = "";
>>>>>        bool queued = false;
>>>>> +    int notify_type = ghes->generic->notify.type;
>>>>>          sev = ghes_severity(estatus->error_severity);
>>>>>        apei_estatus_for_each_section(estatus, gdata) {
>>>>> @@ -648,13 +652,13 @@ static bool ghes_do_proc(struct ghes *ghes,
>>>>>                ghes_edac_report_mem_error(sev, mem_err);
>>>>>                  arch_apei_report_mem_error(sev, mem_err);
>>>>> -            queued = ghes_handle_memory_failure(gdata, sev);
>>>>> +            queued = ghes_handle_memory_failure(gdata, sev, notify_type);
>>>>>            }
>>>>>            else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
>>>>>                ghes_handle_aer(gdata);
>>>>>            }
>>>>>            else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
>>>>> -            queued = ghes_handle_arm_hw_error(gdata, sev);
>>>>> +            queued = ghes_handle_arm_hw_error(gdata, sev, notify_type);
>>>>>            } else {
>>>>>                void *err = acpi_hest_get_payload(gdata);
>>>>>    diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>>>> index bead6bccc7f2..82238ec86acd 100644
>>>>> --- a/mm/memory-failure.c
>>>>> +++ b/mm/memory-failure.c
>>>>> @@ -2204,7 +2204,11 @@ struct memory_failure_cpu {
>>>>>    static DEFINE_PER_CPU(struct memory_failure_cpu, memory_failure_cpu);
>>>>>      /**
>>>>> - * memory_failure_queue - Schedule handling memory failure of a page.
>>>>> + * memory_failure_queue
>>>>> + * - Schedule handling memory failure of a page for asynchronous error, memory
>>>>> + *   failure page will be executed in kworker thread
>>>>> + * - put corrupt memory info into kfifo for synchronous error, task_work will
>>>>> + *   handle them before returning to the user
>>>>
>>>> I think that the top description of kernel-doc function documentation needs
>>>> to be brief, so could you move the above 2 items downward as details?
>>>> Maybe the first line can be updated like below (scheduling is done conditionally
>>>> with your change):
>>>>
>>>> /**
>>>>    * memory_failure_queue - Queue memory failure event
>>>>    * @pfn: Page Number of the corrupted page
>>>>    * @flags: Flags for memory failure handling
>>>>    *
>>>>    * ... (full details)
>>>>
>>>> And maybe existing comment in "full details" is obsolete since commit
>>>> 7f17b4a121d0 ("ACPI: APEI: Kick the memory_failure() queue for synchronous
>>>> errors"), so could you update the whole description to explain the new
>>>> behavior with some background information as done in patch description?
>>>>
>>>
>>> Thanks, your description is very concise and close to the meaning expressed by the patch. I will fix it in the next patch.
>>> And I will update the whole description to explain the new behavior.
>>>
>>>>>     * @pfn: Page Number of the corrupted page
>>>>>     * @flags: Flags for memory failure handling
>>>>>     *
>>>>> @@ -2217,6 +2221,11 @@ static DEFINE_PER_CPU(struct memory_failure_cpu, memory_failure_cpu);
>>>>>     * happen outside the current execution context (e.g. when
>>>>>     * detected by a background scrubber)
>>>>>     *
>>>>> + * This function can also be used in synchronous errors which was detected as a
>>>>
>>>> "... errors which was ..." seems unmatched in plurality.
>>>>
>>>>> + * result of user-space accessing a corrupt memory location, just put memory
>>>>
>>>> s/corrupt/corrupted/
>>>
>>> The typo and syntax error will be fixed in the next patch.
>>>
>>>>
>>>>> + * error info into kfifo, and then, task_work get and handle it in current
>>>>> + * execution context instead of scheduling kworker to handle it
>>>>
>>>> Please put a period at the end of sentence. kernel-doc comment is
>>>> converted to auto-generated documentation, so it needs to look like
>>>> natural English text.
>>>> See https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation
>>>>
>>>
>>> Thanks, it help me a lot, I will update function comments as per the kernel-doc.
>>>
>>>>> + *
>>>>>     * Can run in IRQ context.
>>>>>     */
>>>>> @@ -2230,9 +2239,10 @@ void memory_failure_queue(unsigned long pfn, int flags)
>>>>>          mf_cpu = &get_cpu_var(memory_failure_cpu);
>>>>>        spin_lock_irqsave(&mf_cpu->lock, proc_flags);
>>>>> -    if (kfifo_put(&mf_cpu->fifo, entry))
>>>>> -        schedule_work_on(smp_processor_id(), &mf_cpu->work);
>>>>> -    else
>>>>> +    if (kfifo_put(&mf_cpu->fifo, entry)) {
>>>>> +        if (!(entry.flags & MF_ACTION_REQUIRED))
>>>>> +            schedule_work_on(smp_processor_id(), &mf_cpu->work);
>>>>> +    } else
>>>>>            pr_err("buffer overflow when queuing memory failure at %#lx\n",
>>>>>                   pfn);
>>>>>        spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
>>>>> @@ -2240,12 +2250,15 @@ void memory_failure_queue(unsigned long pfn, int flags)
>>>>>    }
>>>>>    EXPORT_SYMBOL_GPL(memory_failure_queue);
>>>>>    -static void memory_failure_work_func(struct work_struct *work)
>>>>> +/*
>>>>> + * (a)synchronous error info should be consumed by the corresponding handler
>>>>> + */
>>>>> +static void __memory_failure_work_func(struct work_struct *work, bool sync)
>>>>>    {
>>>>>        struct memory_failure_cpu *mf_cpu;
>>>>>        struct memory_failure_entry entry = { 0, };
>>>>>        unsigned long proc_flags;
>>>>> -    int gotten;
>>>>> +    int gotten, ret;
>>>>>          mf_cpu = container_of(work, struct memory_failure_cpu, work);
>>>>>        for (;;) {
>>>>> @@ -2256,22 +2269,31 @@ static void memory_failure_work_func(struct work_struct *work)
>>>>>                break;
>>>>>            if (entry.flags & MF_SOFT_OFFLINE)
>>>>>                soft_offline_page(entry.pfn, entry.flags);
>>>>> -        else
>>>>> -            memory_failure(entry.pfn, entry.flags);
>>>>> +        else {
>>>>> +            if (sync && (entry.flags & MF_ACTION_REQUIRED)) {
>>>>> +                ret = memory_failure(entry.pfn, entry.flags);
>>>>> +                if (ret == -EHWPOISON || ret == -EOPNOTSUPP)
>>>>> +                    return;
>>>>> +
>>>>> +                pr_err("Memory error not recovered");
>>>>> +                force_sig(SIGBUS);
>>>>> +            } else if (!sync && !(entry.flags & MF_ACTION_REQUIRED))
>>>>> +                memory_failure(entry.pfn, entry.flags);
>>>>
>>>> So if sync is true and MF_ACTION_REQUIRED is not set, memory_failure() is
>>>> not called.  Does that break something?
>>>>
>>>> Thanks,
>>>> Naoya Horiguchi
>>>>
>>>
>>> Only in synchronous error handle process, set sync true.
>>> As expected, MF_ACTION_REQUIRED should be set in synchronous error handle process.
>>>
>>> Kfifo is shared by synchronous error and asynchronous error. Asynchronous error will not set MF_ACTION_REQUIRED. This judgment is to prevent synchronous error calls memory_failure() handle asynchronous errors in kfifo. If __memory_failure_work_func() in synchronous error get an asynchronous error info(sync is true and MF_ACTION_REQUIRED is not set), just ignore it, it will break nothing.
>>
>> Sorry, I am afraid that it does break asynchronous error. NMI handler other
>> than SEA will not MF_ACTION_REQUIRED, and will never schedule a worker in
>> memory_failure_queue(). You intend to use ghes_kick_task_work to handle queued
>> Kfifo work, but the task work is only added to user task. When a asynchronous
> 
> If NMI is asynchronous error, memory_failure_queue() will schedule kworker handle error in kfifo. ghes_kick_task_work() in NMI handler may confuse you.

Yes, you are right, if NMI is asynchronous error, memory_failure_queue()
will schedule kworker handle error in kfifo. But how about NMI for synchronous
error without sync flag? In this case, memory_failure_queue() will still schedule
kworker. The side effects are that:

- 1. The task work added to current will not get memory failure work from kfifo,
becase it has consumed by kworker.
- 2. cancel_work_sync is removed so that memory failure in kworker is not ensured
to handled before current returning to userspace.

The root cause is the lack of synchronous information of other NMI notification.


> 
>> error signaled a IRQ, it will interrupt any kind of task, including user task
>> and kernel task. In kernel task scenario, the task work will not be added to
>> current so that the memory failure work queued in Kfifo will never be handled.
>> A related discussion is here[1].
>>
>>         if (task_work_pending && current->mm) {  // notice here
>>             estatus_node->task_work.func = ghes_kick_task_work;
>>             estatus_node->task_work_cpu = smp_processor_id();
>>             ret = task_work_add(current, &estatus_node->task_work,
>>                         TWA_RESUME);
>>             if (ret)
>>                 estatus_node->task_work.func = NULL;
>>         }
> 
> I am a little confused here, your job in [1] is not to add task_work to kernel thread, it's consistent with the code here.

Sorry, I misunderstood your code. Please ignore this comment.

> 
> 
>> I prefer to add a new path to handle synchronous error through task work and
>> leave the original path as it is. A reference code based on XiuQi's patch is
>> here. [2]
>>
>> By the way, you are working on the same interface with XiuQi in ghes, e.g.
>> ghes_handle_memory_failure to add similar signature, sync flag. Could we
>> discuss based on his patch?
>>
>> Best Regards,
>> Shuai
>>
>> [1]https://lore.kernel.org/lkml/20220916050535.26625-1-xueshuai@linux.alibaba.com/
>> [2]https://lore.kernel.org/linux-arm-kernel/20221205160043.57465-4-xiexiuqi@huawei.com/T/#mdd6cc9526bfd704c42f88f305a89e3fd94ce5882
>>
> 
> Actually, I think your work is great, my current job is just trying to change the current kernel implementation as little as possible.
> 
> Ok, if you have any update, please cc me, let's discuss.

Thank you. As Naoya asked, "Does that break something? " is more important.
Even if the new APEI specification comes and adopted to add a sync flag, we
should be compatible with the old BIOS, right? So, personally speaking,
the cancel_work_sync trick can not been removed.

Of course, if XiuQi doesn't add the reference code into his patch set,
I'll send a new patch and cc you.

Best Regards,
Shuai

> 
>>>
>>> However, currently we can only confirm that SEA is
>>> synchronous error, just set MF_ACTION_REQUIRED in SEA, other indeterminate synchronous error will miss memory_failure().
>>>
>>>
>>
>> .
>>
> 
> 
