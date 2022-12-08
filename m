Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011636467F9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 04:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiLHDmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 22:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiLHDly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 22:41:54 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F5560368;
        Wed,  7 Dec 2022 19:41:51 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xueshuai@linux.alibaba.com;NM=0;PH=DS;RN=20;SR=0;TI=SMTPD_---0VWoV7KW_1670470906;
Received: from 30.221.146.120(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VWoV7KW_1670470906)
          by smtp.aliyun-inc.com;
          Thu, 08 Dec 2022 11:41:48 +0800
Message-ID: <3c998c0d-fafb-5fab-ee02-0e0839ffe313@linux.alibaba.com>
Date:   Thu, 8 Dec 2022 11:41:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [RFC 1/2] ACPI: APEI: Make memory_failure() triggered by
 synchronization errors execute in the current context
Content-Language: en-US
To:     Xie XiuQi <xiexiuqi@huawei.com>, Lv Ying <lvying6@huawei.com>,
        rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, naoya.horiguchi@nec.com,
        linmiaohe@huawei.com, akpm@linux-foundation.org,
        ashish.kalra@amd.com
Cc:     xiezhipeng1@huawei.com, wangkefeng.wang@huawei.com,
        tanxiaofei@huawei.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Bixuan Cui <cuibixuan@linux.alibaba.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        yingwen.cyw@alibaba-inc.com
References: <20221205115111.131568-1-lvying6@huawei.com>
 <20221205115111.131568-2-lvying6@huawei.com>
 <c779d666-4937-e2dc-2d52-da0e49d5d1ac@linux.alibaba.com>
 <6c9a17ad-fe68-bbb5-bb37-edbcfbbc2fee@huawei.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <6c9a17ad-fe68-bbb5-bb37-edbcfbbc2fee@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/8 AM10:37, Xie XiuQi wrote:
> 
> On 2022/12/7 18:57, Shuai Xue wrote:
>>
>>
>> 在 2022/12/5 PM7:51, Lv Ying 写道:
>>> The memory uncorrected error which is detected by an external component and
>>> notified via an IRQ, can be called asynchronization error. If an error is
>>> detected as a result of user-space process accessing a corrupt memory
>>> location, the CPU may take an abort. On arm64 this is a
>>> 'synchronous external abort', and on a firmware first system it is notified
>>> via NOTIFY_SEA, this can be called synchronization error.
>>>
>>> Currently, synchronization error and asynchronization error both use
>>> memory_failure_queue to schedule memory_failure() exectute in kworker
>>> context. Commit 7f17b4a121d0 ("ACPI: APEI: Kick the memory_failure() queue
>>> for synchronous errors") make task_work pending to flush out the queue,
>>> cancel_work_sync() in memory_failure_queue_kick() will make
>>> memory_failure() exectute in kworker context first which will get
>>> synchronization error info from kfifo, so task_work later will get nothing
>>> from kfifo which doesn't work as expected. Even worse, synchronization
>>> error notification has NMI like properties, (it can interrupt IRQ-masked
>>> code), task_work may get wrong kfifo entry from interrupted
>>> asynchronization error which is notified by IRQ.
>>>
>>> Since the memory_failure() triggered by a synchronous exception is
>>> executed in the kworker context, the early_kill mode of memory_failure()
>>> will send wrong si_code by SIGBUS signal: current process is kworker
>>> thread, the actual user-space process accessing the corrupt memory location
>>> will be collected by find_early_kill_thread(), and then send SIGBUS with
>>> BUS_MCEERR_AO si_code to the actual user-space process instead of
>>> BUS_MCEERR_AR. The machine-manager(kvm) use the si_code: BUS_MCEERR_AO for
>>> 'action optional' early notifications, and BUS_MCEERR_AR for
>>> 'action required' synchronous/late notifications.
>>>
>>> Make memory_failure() triggered by synchronization errors execute in the
>>> current context, we do not need workqueue for synchronization error
>>> anymore, use task_work handle synchronization errors directly. Since,
>>> synchronization errors and asynchronization errors share the same kfifo,
>>> use MF_ACTION_REQUIRED flag to distinguish them. And the asynchronization
>>> error keeps the same as before.
>>
>>
>> Hi, Lv Ying,
>>
>> Thank you for your great work.
>>
>> We also encountered this problem in production environment, and tried to
>> solve it by dividing synchronous and asynchronous error handling into different
>> paths: task work for synchronous error and workqueue for asynchronous error.
>>
>> The main challenge is how to distinguish synchronous errors in kernel first
>> mode through APEI, a related discussion is here.[1]
>>
>>> @@ -978,14 +979,14 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
>>>  		estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
>>>  		len = cper_estatus_len(estatus);
>>>  		node_len = GHES_ESTATUS_NODE_LEN(len);
>>> -		task_work_pending = ghes_do_proc(estatus_node->ghes, estatus);
>>> +		corruption_page_pending = ghes_do_proc(estatus_node->ghes, estatus, true);
>>>  		if (!ghes_estatus_cached(estatus)) {
>>>  			generic = estatus_node->generic;
>>>  			if (ghes_print_estatus(NULL, generic, estatus))
>>>  				ghes_estatus_cache_add(generic, estatus);
>>>  		}
>>
>> In the case of your patch, it is inappropriate to assume that ghes_proc_in_irq() is only
>> called to handle synchronous error. Firmware could notify all synchronous and asynchronous
>> error signals to kernel through NMI notification, e.g. SDEI. In this case, asynchronous
>> error will be treated as synchronous error.
>>
>> Our colleague Yingwen has submitted a proposal to extend acpi_hest_generic_data::flag (bit 8)
>> to indicate that the error is a synchronous[2]. Personally speaking, it is a more general
>> solution and completely solves the problem.
>>
>>
>>> Background:
>>>
>>> In ARM world, two type events (Sync/Async) from hardware IP need OS/VMM take different actions.
>>> Current CPER memory error record is not able to distinguish sync/async type event right now.
>>> Current OS/VMM need to take extra actions beyond CPER which is heavy burden to identify the
>>> two type events
>>>
>>> Sync event (e.g. CPU consume poisoned data) --> Firmware  -> CPER error log  --> OS/VMM take recovery action.
>>> Async event (e.g. Memory controller detect UE event)  --> Firmware  --> CPER error log  --> OS take page action.
>>>
>>>
>>> Proposal:
>>>
>>> - In section description Flags field(UEFI spec section N.2, add sync flag as below. OS/VMM
>>>  could depend on this flag to distinguish sync/async events.
>>> - Bit8 – sync flag; if set this flag indicates that this event record is synchronous(e.g.
>>>  cpu core consumes poison data, then cause instruction/data abort); if not set, this event record is asynchronous.
>>>
>>> Best regards,
>>> Yingwen Chen
>>
>> A RFC patch set based on above proposal is here[3].
> 
> Hi Shuai & Lv Ying,
> 
> Thanks for your great works, I'm also trying to improve the handling for ARM SEA.
> But I missed the issue about cancel_work_sync().

May part of my RFC[1] can address this issue :)

[1][RFC PATCH 1/2] ACPI: APEI: set memory failure flags as MF_ACTION_REQUIRED on synchronous events
https://lore.kernel.org/lkml/1aa0ca90-d44c-aa99-1e2d-bd2ae610b088@linux.alibaba.com/T/#m2bd61100552ea3aeb1b0aae3ab71df85a580de4c

> 
> I also agree that adding SYNC flag in CPER is a better way.
> Otherwise, the notification type is used to distinguish them.
> Let's try to fix this problem before the new UEFI version comes out.
> 
> After all, we have to wait for a new UEFI version and a new BIOS version,
> which may take a long time.

Agree. At least we could address the problem for SEA notification before a new UEFI version
is ready.

> 
> This is the patchset perious.
> https://lore.kernel.org/linux-arm-kernel/20221205160043.57465-4-xiexiuqi@huawei.com/T/

Great work, thank you.

Best regards,
Shuai
> 
>>
>> Thank you.
>>
>> Best Regards,
>> Shuai
>>
>>
>> [1] https://lore.kernel.org/lkml/1aa0ca90-d44c-aa99-1e2d-bd2ae610b088@linux.alibaba.com/T/
>> [2] https://members.uefi.org/wg/uswg/mail/thread/9453
>> [3] https://lore.kernel.org/lkml/20221206153354.92394-2-xueshuai@linux.alibaba.com/
>>
>>
>>>
>>> Signed-off-by: Lv Ying <lvying6@huawei.com>
>>> ---
>>>  drivers/acpi/apei/ghes.c | 27 ++++++++++++++-------------
>>>  mm/memory-failure.c      | 34 ++++++++++++++++++++++------------
>>>  2 files changed, 36 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>>> index 9952f3a792ba..2ec71fc8a8dd 100644
>>> --- a/drivers/acpi/apei/ghes.c
>>> +++ b/drivers/acpi/apei/ghes.c
>>> @@ -423,8 +423,8 @@ static void ghes_clear_estatus(struct ghes *ghes,
>>>  
>>>  /*
>>>   * Called as task_work before returning to user-space.
>>> - * Ensure any queued work has been done before we return to the context that
>>> - * triggered the notification.
>>> + * Ensure any queued corrupt page in synchronous errors has been handled before
>>> + * we return to the user context that triggered the notification.
>>>   */
>>>  static void ghes_kick_task_work(struct callback_head *head)
>>>  {
>>> @@ -461,7 +461,7 @@ static bool ghes_do_memory_failure(u64 physical_addr, int flags)
>>>  }
>>>  
>>>  static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
>>> -				       int sev)
>>> +				       int sev, bool sync)
>>>  {
>>>  	int flags = -1;
>>>  	int sec_sev = ghes_severity(gdata->error_severity);
>>> @@ -475,7 +475,7 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
>>>  	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
>>>  		flags = MF_SOFT_OFFLINE;
>>>  	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
>>> -		flags = 0;
>>> +		flags = sync ? MF_ACTION_REQUIRED : 0;
>>>  
>>>  	if (flags != -1)
>>>  		return ghes_do_memory_failure(mem_err->physical_addr, flags);
>>> @@ -483,7 +483,7 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
>>>  	return false;
>>>  }
>>>  
>>> -static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int sev)
>>> +static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int sev, bool sync)
>>>  {
>>>  	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
>>>  	bool queued = false;
>>> @@ -510,7 +510,8 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int s
>>>  		 * and don't filter out 'corrected' error here.
>>>  		 */
>>>  		if (is_cache && has_pa) {
>>> -			queued = ghes_do_memory_failure(err_info->physical_fault_addr, 0);
>>> +			queued = ghes_do_memory_failure(err_info->physical_fault_addr,
>>> +					sync ? MF_ACTION_REQUIRED : 0);
>>>  			p += err_info->length;
>>>  			continue;
>>>  		}
>>> @@ -623,7 +624,7 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
>>>  }
>>>  
>>>  static bool ghes_do_proc(struct ghes *ghes,
>>> -			 const struct acpi_hest_generic_status *estatus)
>>> +			 const struct acpi_hest_generic_status *estatus, bool sync)
>>>  {
>>>  	int sev, sec_sev;
>>>  	struct acpi_hest_generic_data *gdata;
>>> @@ -648,13 +649,13 @@ static bool ghes_do_proc(struct ghes *ghes,
>>>  			ghes_edac_report_mem_error(sev, mem_err);
>>>  
>>>  			arch_apei_report_mem_error(sev, mem_err);
>>> -			queued = ghes_handle_memory_failure(gdata, sev);
>>> +			queued = ghes_handle_memory_failure(gdata, sev, sync);
>>>  		}
>>>  		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
>>>  			ghes_handle_aer(gdata);
>>>  		}
>>>  		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
>>> -			queued = ghes_handle_arm_hw_error(gdata, sev);
>>> +			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
>>>  		} else {
>>>  			void *err = acpi_hest_get_payload(gdata);
>>>  
>>> @@ -868,7 +869,7 @@ static int ghes_proc(struct ghes *ghes)
>>>  		if (ghes_print_estatus(NULL, ghes->generic, estatus))
>>>  			ghes_estatus_cache_add(ghes->generic, estatus);
>>>  	}
>>> -	ghes_do_proc(ghes, estatus);
>>> +	ghes_do_proc(ghes, estatus, false);
>>>  
>>>  out:
>>>  	ghes_clear_estatus(ghes, estatus, buf_paddr, FIX_APEI_GHES_IRQ);
>>> @@ -961,7 +962,7 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
>>>  	struct ghes_estatus_node *estatus_node;
>>>  	struct acpi_hest_generic *generic;
>>>  	struct acpi_hest_generic_status *estatus;
>>> -	bool task_work_pending;
>>> +	bool corruption_page_pending;
>>>  	u32 len, node_len;
>>>  	int ret;
>>>  
>>> @@ -978,14 +979,14 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
>>>  		estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
>>>  		len = cper_estatus_len(estatus);
>>>  		node_len = GHES_ESTATUS_NODE_LEN(len);
>>> -		task_work_pending = ghes_do_proc(estatus_node->ghes, estatus);
>>> +		corruption_page_pending = ghes_do_proc(estatus_node->ghes, estatus, true);
>>>  		if (!ghes_estatus_cached(estatus)) {
>>>  			generic = estatus_node->generic;
>>>  			if (ghes_print_estatus(NULL, generic, estatus))
>>>  				ghes_estatus_cache_add(generic, estatus);
>>>  		}
>>>  
>>> -		if (task_work_pending && current->mm) {
>>> +		if (corruption_page_pending && current->mm) {
>>>  			estatus_node->task_work.func = ghes_kick_task_work;
>>>  			estatus_node->task_work_cpu = smp_processor_id();
>>>  			ret = task_work_add(current, &estatus_node->task_work,
>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>> index bead6bccc7f2..3b6ac3694b8d 100644
>>> --- a/mm/memory-failure.c
>>> +++ b/mm/memory-failure.c
>>> @@ -2204,7 +2204,11 @@ struct memory_failure_cpu {
>>>  static DEFINE_PER_CPU(struct memory_failure_cpu, memory_failure_cpu);
>>>  
>>>  /**
>>> - * memory_failure_queue - Schedule handling memory failure of a page.
>>> + * memory_failure_queue
>>> + * - Schedule handling memory failure of a page for asynchronous error, memory
>>> + *   failure page will be executed in kworker thread
>>> + * - put corrupt memory info into kfifo for synchronous error, task_work will
>>> + *   handle them before returning to the user
>>>   * @pfn: Page Number of the corrupted page
>>>   * @flags: Flags for memory failure handling
>>>   *
>>> @@ -2217,6 +2221,11 @@ static DEFINE_PER_CPU(struct memory_failure_cpu, memory_failure_cpu);
>>>   * happen outside the current execution context (e.g. when
>>>   * detected by a background scrubber)
>>>   *
>>> + * This function can also be used in synchronous errors which was detected as a
>>> + * result of user-space accessing a corrupt memory location, just put memory
>>> + * error info into kfifo, and then, task_work get and handle it in current
>>> + * execution context instead of scheduling kworker to handle it
>>> + *
>>>   * Can run in IRQ context.
>>>   */
>>>  void memory_failure_queue(unsigned long pfn, int flags)
>>> @@ -2230,9 +2239,10 @@ void memory_failure_queue(unsigned long pfn, int flags)
>>>  
>>>  	mf_cpu = &get_cpu_var(memory_failure_cpu);
>>>  	spin_lock_irqsave(&mf_cpu->lock, proc_flags);
>>> -	if (kfifo_put(&mf_cpu->fifo, entry))
>>> -		schedule_work_on(smp_processor_id(), &mf_cpu->work);
>>> -	else
>>> +	if (kfifo_put(&mf_cpu->fifo, entry)) {
>>> +		if (!(entry.flags & MF_ACTION_REQUIRED))
>>> +			schedule_work_on(smp_processor_id(), &mf_cpu->work);
>>> +	} else
>>>  		pr_err("buffer overflow when queuing memory failure at %#lx\n",
>>>  		       pfn);
>>>  	spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
>>> @@ -2240,7 +2250,7 @@ void memory_failure_queue(unsigned long pfn, int flags)
>>>  }
>>>  EXPORT_SYMBOL_GPL(memory_failure_queue);
>>>  
>>> -static void memory_failure_work_func(struct work_struct *work)
>>> +static void __memory_failure_work_func(struct work_struct *work, bool sync)
>>>  {
>>>  	struct memory_failure_cpu *mf_cpu;
>>>  	struct memory_failure_entry entry = { 0, };
>>> @@ -2256,22 +2266,22 @@ static void memory_failure_work_func(struct work_struct *work)
>>>  			break;
>>>  		if (entry.flags & MF_SOFT_OFFLINE)
>>>  			soft_offline_page(entry.pfn, entry.flags);
>>> -		else
>>> +		else if (!sync || (entry.flags & MF_ACTION_REQUIRED))
>>>  			memory_failure(entry.pfn, entry.flags);
>>>  	}
>>>  }
>>>  
>>> -/*
>>> - * Process memory_failure work queued on the specified CPU.
>>> - * Used to avoid return-to-userspace racing with the memory_failure workqueue.
>>> - */
>>> +static void memory_failure_work_func(struct work_struct *work)
>>> +{
>>> +	__memory_failure_work_func(work, false);
>>> +}
>>> +
>>>  void memory_failure_queue_kick(int cpu)
>>>  {
>>>  	struct memory_failure_cpu *mf_cpu;
>>>  
>>>  	mf_cpu = &per_cpu(memory_failure_cpu, cpu);
>>> -	cancel_work_sync(&mf_cpu->work);
>>> -	memory_failure_work_func(&mf_cpu->work);
>>> +	__memory_failure_work_func(&mf_cpu->work, true);
>>>  }
>>>  
>>>  static int __init memory_failure_init(void)
>>
>> .
>>
