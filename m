Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203216C2B3C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjCUHRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjCUHRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:17:38 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9097F3E085;
        Tue, 21 Mar 2023 00:17:07 -0700 (PDT)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PgjWq3xFsz17Lb0;
        Tue, 21 Mar 2023 15:13:59 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Mar 2023 15:17:03 +0800
Message-ID: <3b7e99a5-de65-67a5-4f74-d0d8d40fa9f2@huawei.com>
Date:   Tue, 21 Mar 2023 15:17:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   mawupeng <mawupeng1@huawei.com>
Subject: Re: [PATCH v3 0/2] ACPI: APEI: handle synchronous exceptions with
 proper si_code
To:     <xueshuai@linux.alibaba.com>, <tony.luck@intel.com>,
        <naoya.horiguchi@nec.com>
CC:     <mawupeng1@huawei.com>, <linux-acpi@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <justin.he@arm.com>, <akpm@linux-foundation.org>,
        <ardb@kernel.org>, <ashish.kalra@amd.com>,
        <baolin.wang@linux.alibaba.com>, <bp@alien8.de>,
        <cuibixuan@linux.alibaba.com>, <dave.hansen@linux.intel.com>,
        <james.morse@arm.com>, <jarkko@kernel.org>, <lenb@kernel.org>,
        <linmiaohe@huawei.com>, <lvying6@huawei.com>, <rafael@kernel.org>,
        <xiexiuqi@huawei.com>, <zhuo.song@linux.alibaba.com>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20230317072443.3189-1-xueshuai@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20230317072443.3189-1-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test-by: Ma Wupeng <mawupeng1@huawei.com>

I have test this on arm64 with following steps:
  1. make memory failure return EBUSY
  2. force a UCE with einj

Without this patchset, user task will not be kill since memory_failure can
not handle this UCE properly and user task is in D state. The stack can
be found in the end.
With this patchset, user task can be killed even memory_failure return
-EBUSY without doing anything.

Here is the stack of user task with D state:

  # cat /proc/7001/stack
  [<0>] __flush_work.isra.0+0x80/0xa8
  [<0>] __cancel_work_timer+0x144/0x1c8
  [<0>] cancel_work_sync+0x1c/0x30
  [<0>] memory_failure_queue_kick+0x3c/0x88
  [<0>] ghes_kick_task_work+0x28/0x78
  [<0>] task_work_run+0xb8/0x188
  [<0>] do_notify_resume+0x1e0/0x280
  [<0>] el0_da+0x130/0x138
  [<0>] el0t_64_sync_handler+0x68/0xc0
  [<0>] el0t_64_sync+0x188/0x190

On 2023/3/17 15:24, Shuai Xue wrote:
> changes since v2 by addressing comments from Naoya:
> - rename mce_task_work to sync_task_work
> - drop ACPI_HEST_NOTIFY_MCE case in is_hest_sync_notify()
> - add steps to reproduce this problem in cover letter
> - Link: https://lore.kernel.org/lkml/1aa0ca90-d44c-aa99-1e2d-bd2ae610b088@linux.alibaba.com/T/#mb3dede6b7a6d189dc8de3cf9310071e38a192f8e
> 
> changes since v1:
> - synchronous events by notify type
> - Link: https://lore.kernel.org/lkml/20221206153354.92394-3-xueshuai@linux.alibaba.com/
> 
> Currently, both synchronous and asynchronous error are queued and handled
> by a dedicated kthread in workqueue. And Memory failure for synchronous
> error is synced by a cancel_work_sync trick which ensures that the
> corrupted page is unmapped and poisoned. And after returning to user-space,
> the task starts at current instruction which triggering a page fault in
> which kernel will send SIGBUS to current process due to VM_FAULT_HWPOISON.
> 
> However, the memory failure recovery for hwpoison-aware mechanisms does not
> work as expected. For example, hwpoison-aware user-space processes like
> QEMU register their customized SIGBUS handler and enable early kill mode by
> seting PF_MCE_EARLY at initialization. Then the kernel will directy notify
> the process by sending a SIGBUS signal in memory failure with wrong
> si_code: BUS_MCEERR_AO si_code to the actual user-space process instead of
> BUS_MCEERR_AR.
> 
> To address this problem:
> 
> - PATCH 1 sets mf_flags as MF_ACTION_REQUIRED on synchronous events which
>   indicates error happened in current execution context
> - PATCH 2 separates synchronous error handling into task work so that the
>   current context in memory failure is exactly belongs to the task
>   consuming poison data.
> 
> Then, kernel will send SIGBUS with proper si_code in kill_proc().
> 
> Lv Ying and XiuQi also proposed to address similar problem and we discussed
> about new solution to add a new flag(acpi_hest_generic_data::flags bit 8) to
> distinguish synchronous event. [2][3] The UEFI community still has no response.
> After a deep dive into the SDEI TRM, the SDEI notification should be used for
> asynchronous error. As SDEI TRM[1] describes "the dispatcher can simulate an
> exception-like entry into the client, **with the client providing an additional
> asynchronous entry point similar to an interrupt entry point**". The client
> (kernel) lacks complete synchronous context, e.g. systeam register (ELR, ESR,
> etc). So notify type is enough to distinguish synchronous event.
> 
> To reproduce this problem:
> 
> 	# STEP1: enable early kill mode
> 	#sysctl -w vm.memory_failure_early_kill=1
> 	vm.memory_failure_early_kill = 1
> 
> 	# STEP2: inject an UCE error and consume it to trigger a synchronous error
> 	#einj_mem_uc single
> 	0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
> 	injecting ...
> 	triggering ...
> 	signal 7 code 5 addr 0xffffb0d75000
> 	page not present
> 	Test passed
> 
> The si_code (code 5) from einj_mem_uc indicates that it is BUS_MCEERR_AO error
> and it is not fact.
> 
> After this patch set:
> 
> 	# STEP1: enable early kill mode
> 	#sysctl -w vm.memory_failure_early_kill=1
> 	vm.memory_failure_early_kill = 1
> 
> 	# STEP2: inject an UCE error and consume it to trigger a synchronous error
> 	#einj_mem_uc single
> 	0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
> 	injecting ...
> 	triggering ...
> 	signal 7 code 4 addr 0xffffb0d75000
> 	page not present
> 	Test passed
> 
> The si_code (code 4) from einj_mem_uc indicates that it is BUS_MCEERR_AR error
> as we expected.
> 
> [1] https://developer.arm.com/documentation/den0054/latest/
> [2] https://lore.kernel.org/linux-arm-kernel/20221205160043.57465-4-xiexiuqi@huawei.com/T/
> [3] https://lore.kernel.org/lkml/20221209095407.383211-1-lvying6@huawei.com/
> 
> Shuai Xue (2):
>   ACPI: APEI: set memory failure flags as MF_ACTION_REQUIRED on
>     synchronous events
>   ACPI: APEI: handle synchronous exceptions in task work
> 
>  drivers/acpi/apei/ghes.c | 135 ++++++++++++++++++++++++---------------
>  include/acpi/ghes.h      |   3 -
>  mm/memory-failure.c      |  13 ----
>  3 files changed, 83 insertions(+), 68 deletions(-)
> 
