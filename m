Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6336C3FBC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 02:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCVB1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 21:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCVB1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 21:27:50 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E80303FD;
        Tue, 21 Mar 2023 18:27:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0VeOjh1N_1679448461;
Received: from 30.240.114.229(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VeOjh1N_1679448461)
          by smtp.aliyun-inc.com;
          Wed, 22 Mar 2023 09:27:43 +0800
Message-ID: <81eb51fa-c2a5-64dc-1c39-a2eddd23f62e@linux.alibaba.com>
Date:   Wed, 22 Mar 2023 09:27:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v3 0/2] ACPI: APEI: handle synchronous exceptions with
 proper si_code
Content-Language: en-US
To:     mawupeng <mawupeng1@huawei.com>, tony.luck@intel.com,
        naoya.horiguchi@nec.com
Cc:     linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, justin.he@arm.com,
        akpm@linux-foundation.org, ardb@kernel.org, ashish.kalra@amd.com,
        baolin.wang@linux.alibaba.com, bp@alien8.de,
        cuibixuan@linux.alibaba.com, dave.hansen@linux.intel.com,
        james.morse@arm.com, jarkko@kernel.org, lenb@kernel.org,
        linmiaohe@huawei.com, lvying6@huawei.com, rafael@kernel.org,
        xiexiuqi@huawei.com, zhuo.song@linux.alibaba.com
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20230317072443.3189-1-xueshuai@linux.alibaba.com>
 <3b7e99a5-de65-67a5-4f74-d0d8d40fa9f2@huawei.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <3b7e99a5-de65-67a5-4f74-d0d8d40fa9f2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/21 PM3:17, mawupeng wrote:
> Test-by: Ma Wupeng <mawupeng1@huawei.com>
> 
> I have test this on arm64 with following steps:
>   1. make memory failure return EBUSY
>   2. force a UCE with einj
> 
> Without this patchset, user task will not be kill since memory_failure can
> not handle this UCE properly and user task is in D state. The stack can
> be found in the end.
> With this patchset, user task can be killed even memory_failure return
> -EBUSY without doing anything.
> 
> Here is the stack of user task with D state:
> 
>   # cat /proc/7001/stack
>   [<0>] __flush_work.isra.0+0x80/0xa8
>   [<0>] __cancel_work_timer+0x144/0x1c8
>   [<0>] cancel_work_sync+0x1c/0x30
>   [<0>] memory_failure_queue_kick+0x3c/0x88
>   [<0>] ghes_kick_task_work+0x28/0x78
>   [<0>] task_work_run+0xb8/0x188
>   [<0>] do_notify_resume+0x1e0/0x280
>   [<0>] el0_da+0x130/0x138
>   [<0>] el0t_64_sync_handler+0x68/0xc0
>   [<0>] el0t_64_sync+0x188/0x190

Thank you :)

Cheers,
Shuai

> 
> On 2023/3/17 15:24, Shuai Xue wrote:
>> changes since v2 by addressing comments from Naoya:
>> - rename mce_task_work to sync_task_work
>> - drop ACPI_HEST_NOTIFY_MCE case in is_hest_sync_notify()
>> - add steps to reproduce this problem in cover letter
>> - Link: https://lore.kernel.org/lkml/1aa0ca90-d44c-aa99-1e2d-bd2ae610b088@linux.alibaba.com/T/#mb3dede6b7a6d189dc8de3cf9310071e38a192f8e
>>
>> changes since v1:
>> - synchronous events by notify type
>> - Link: https://lore.kernel.org/lkml/20221206153354.92394-3-xueshuai@linux.alibaba.com/
>>
>> Currently, both synchronous and asynchronous error are queued and handled
>> by a dedicated kthread in workqueue. And Memory failure for synchronous
>> error is synced by a cancel_work_sync trick which ensures that the
>> corrupted page is unmapped and poisoned. And after returning to user-space,
>> the task starts at current instruction which triggering a page fault in
>> which kernel will send SIGBUS to current process due to VM_FAULT_HWPOISON.
>>
>> However, the memory failure recovery for hwpoison-aware mechanisms does not
>> work as expected. For example, hwpoison-aware user-space processes like
>> QEMU register their customized SIGBUS handler and enable early kill mode by
>> seting PF_MCE_EARLY at initialization. Then the kernel will directy notify
>> the process by sending a SIGBUS signal in memory failure with wrong
>> si_code: BUS_MCEERR_AO si_code to the actual user-space process instead of
>> BUS_MCEERR_AR.
>>
>> To address this problem:
>>
>> - PATCH 1 sets mf_flags as MF_ACTION_REQUIRED on synchronous events which
>>   indicates error happened in current execution context
>> - PATCH 2 separates synchronous error handling into task work so that the
>>   current context in memory failure is exactly belongs to the task
>>   consuming poison data.
>>
>> Then, kernel will send SIGBUS with proper si_code in kill_proc().
>>
>> Lv Ying and XiuQi also proposed to address similar problem and we discussed
>> about new solution to add a new flag(acpi_hest_generic_data::flags bit 8) to
>> distinguish synchronous event. [2][3] The UEFI community still has no response.
>> After a deep dive into the SDEI TRM, the SDEI notification should be used for
>> asynchronous error. As SDEI TRM[1] describes "the dispatcher can simulate an
>> exception-like entry into the client, **with the client providing an additional
>> asynchronous entry point similar to an interrupt entry point**". The client
>> (kernel) lacks complete synchronous context, e.g. systeam register (ELR, ESR,
>> etc). So notify type is enough to distinguish synchronous event.
>>
>> To reproduce this problem:
>>
>> 	# STEP1: enable early kill mode
>> 	#sysctl -w vm.memory_failure_early_kill=1
>> 	vm.memory_failure_early_kill = 1
>>
>> 	# STEP2: inject an UCE error and consume it to trigger a synchronous error
>> 	#einj_mem_uc single
>> 	0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
>> 	injecting ...
>> 	triggering ...
>> 	signal 7 code 5 addr 0xffffb0d75000
>> 	page not present
>> 	Test passed
>>
>> The si_code (code 5) from einj_mem_uc indicates that it is BUS_MCEERR_AO error
>> and it is not fact.
>>
>> After this patch set:
>>
>> 	# STEP1: enable early kill mode
>> 	#sysctl -w vm.memory_failure_early_kill=1
>> 	vm.memory_failure_early_kill = 1
>>
>> 	# STEP2: inject an UCE error and consume it to trigger a synchronous error
>> 	#einj_mem_uc single
>> 	0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
>> 	injecting ...
>> 	triggering ...
>> 	signal 7 code 4 addr 0xffffb0d75000
>> 	page not present
>> 	Test passed
>>
>> The si_code (code 4) from einj_mem_uc indicates that it is BUS_MCEERR_AR error
>> as we expected.
>>
>> [1] https://developer.arm.com/documentation/den0054/latest/
>> [2] https://lore.kernel.org/linux-arm-kernel/20221205160043.57465-4-xiexiuqi@huawei.com/T/
>> [3] https://lore.kernel.org/lkml/20221209095407.383211-1-lvying6@huawei.com/
>>
>> Shuai Xue (2):
>>   ACPI: APEI: set memory failure flags as MF_ACTION_REQUIRED on
>>     synchronous events
>>   ACPI: APEI: handle synchronous exceptions in task work
>>
>>  drivers/acpi/apei/ghes.c | 135 ++++++++++++++++++++++++---------------
>>  include/acpi/ghes.h      |   3 -
>>  mm/memory-failure.c      |  13 ----
>>  3 files changed, 83 insertions(+), 68 deletions(-)
>>
