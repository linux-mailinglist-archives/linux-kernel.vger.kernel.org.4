Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826B570EBB0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 05:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239215AbjEXDKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 23:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjEXDKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 23:10:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0C8AB3;
        Tue, 23 May 2023 20:10:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F90A1042;
        Tue, 23 May 2023 20:11:34 -0700 (PDT)
Received: from [10.163.72.91] (unknown [10.163.72.91])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B3FF3F6C4;
        Tue, 23 May 2023 20:10:44 -0700 (PDT)
Message-ID: <d02df808-6d2b-c24b-bc8d-8f4859c0c71b@arm.com>
Date:   Wed, 24 May 2023 08:40:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V9 10/10] arm64/perf: Implement branch records save on PMU
 IRQ
Content-Language: en-US
To:     James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230315051444.1683170-1-anshuman.khandual@arm.com>
 <20230315051444.1683170-11-anshuman.khandual@arm.com>
 <83cac0ae-7e82-d67e-c854-941c65dae79e@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <83cac0ae-7e82-d67e-c854-941c65dae79e@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/23 20:09, James Clark wrote:
> 
> 
> On 15/03/2023 05:14, Anshuman Khandual wrote:
>> This modifies armv8pmu_branch_read() to concatenate live entries along with
>> task context stored entries and then process the resultant buffer to create
>> perf branch entry array for perf_sample_data. It follows the same principle
>> like task sched out.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
> 
> [...]
> 
>>  void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)
>>  {
>>  	struct brbe_hw_attr *brbe_attr = (struct brbe_hw_attr *)cpuc->percpu_pmu->private;
>> +	struct arm64_perf_task_context *task_ctx = event->pmu_ctx->task_ctx_data;
>> +	struct brbe_regset live[BRBE_MAX_ENTRIES];
>> +	int nr_live, nr_store;
>>  	u64 brbfcr, brbcr;
>> -	int idx, loop1_idx1, loop1_idx2, loop2_idx1, loop2_idx2, count;
>>  
>>  	brbcr = read_sysreg_s(SYS_BRBCR_EL1);
>>  	brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
>> @@ -739,36 +743,13 @@ void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)
>>  	write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
>>  	isb();
>>  
>> -	/* Determine the indices for each loop */
>> -	loop1_idx1 = BRBE_BANK0_IDX_MIN;
>> -	if (brbe_attr->brbe_nr <= BRBE_BANK_MAX_ENTRIES) {
>> -		loop1_idx2 = brbe_attr->brbe_nr - 1;
>> -		loop2_idx1 = BRBE_BANK1_IDX_MIN;
>> -		loop2_idx2 = BRBE_BANK0_IDX_MAX;
>> -	} else {
>> -		loop1_idx2 = BRBE_BANK0_IDX_MAX;
>> -		loop2_idx1 = BRBE_BANK1_IDX_MIN;
>> -		loop2_idx2 = brbe_attr->brbe_nr - 1;
>> -	}
>> -
>> -	/* Loop through bank 0 */
>> -	select_brbe_bank(BRBE_BANK_IDX_0);
>> -	for (idx = 0, count = loop1_idx1; count <= loop1_idx2; idx++, count++) {
>> -		if (!capture_branch_entry(cpuc, event, idx))
>> -			goto skip_bank_1;
>> -	}
>> -
>> -	/* Loop through bank 1 */
>> -	select_brbe_bank(BRBE_BANK_IDX_1);
>> -	for (count = loop2_idx1; count <= loop2_idx2; idx++, count++) {
>> -		if (!capture_branch_entry(cpuc, event, idx))
>> -			break;
>> -	}
>> -
>> -skip_bank_1:
>> -	cpuc->branches->branch_stack.nr = idx;
>> -	cpuc->branches->branch_stack.hw_idx = -1ULL;
>> +	nr_live = capture_brbe_regset(brbe_attr, live);
>> +	nr_store = task_ctx->nr_brbe_records;
>> +	nr_store = stitch_stored_live_entries(task_ctx->store, live, nr_store,
>> +					      nr_live, brbe_attr->brbe_nr);
>> +	process_branch_entries(cpuc, event, task_ctx->store, nr_store);
> 
> Hi Anshuman,
> 
> With the following command I get a crash:
> 
>   perf record --branch-filter any,save_type -a -- ls
> 
> [  101.171822] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000600
> ...
> [145380.414654] Call trace:
> [145380.414739]  armv8pmu_branch_read+0x7c/0x578
> [145380.414895]  armv8pmu_handle_irq+0x104/0x1c0
> [145380.415043]  armpmu_dispatch_irq+0x38/0x70
> [145380.415209]  __handle_irq_event_percpu+0x124/0x3b8
> [145380.415392]  handle_irq_event+0x54/0xc8
> [145380.415567]  handle_fasteoi_irq+0x100/0x1e0
> [145380.415718]  generic_handle_domain_irq+0x38/0x58
> [145380.415895]  gic_handle_irq+0x5c/0x130
> [145380.416025]  call_on_irq_stack+0x24/0x58
> [145380.416173]  el1_interrupt+0x74/0xc0
> [145380.416321]  el1h_64_irq_handler+0x18/0x28
> [145380.416475]  el1h_64_irq+0x64/0x68
> [145380.416604]  smp_call_function_single+0xe8/0x1f0
> [145380.416745]  event_function_call+0xbc/0x1c8
> [145380.416919]  _perf_event_enable+0x84/0xa0
> [145380.417069]  perf_ioctl+0xe8/0xd68
> [145380.417204]  __arm64_sys_ioctl+0x9c/0xe0
> [145380.417353]  invoke_syscall+0x4c/0x120
> [145380.417523]  el0_svc_common+0xd0/0x120
> [145380.417693]  do_el0_svc+0x3c/0xb8
> [145380.417859]  el0_svc+0x50/0xc0
> [145380.418004]  el0t_64_sync_handler+0x84/0xf0
> [145380.418160]  el0t_64_sync+0x190/0x198
> 
> When using --branch-filter any,u without -a it seems to be fine so could
> be that task_ctx is null in per-cpu mode, or something to do with the
> userspace only flag?

It's task_ctx is null in per-cpu mode, because armv8pmu_branch_read() used
event->pmu_ctx->task_ctx_data in per-cpu mode where it would not have been
allocated as well. Following change fixes the problem.

diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
index 9e441141a2c3..c8fd581eacf9 100644
--- a/drivers/perf/arm_brbe.c
+++ b/drivers/perf/arm_brbe.c
@@ -744,12 +744,17 @@ void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)
        isb();
 
        nr_live = capture_brbe_regset(brbe_attr, live);
-       nr_store = task_ctx->nr_brbe_records;
-       nr_store = stitch_stored_live_entries(task_ctx->store, live, nr_store,
-                                             nr_live, brbe_attr->brbe_nr);
-       process_branch_entries(cpuc, event, task_ctx->store, nr_store);
+       if (event->ctx->task) {
+               nr_store = task_ctx->nr_brbe_records;
+               nr_store = stitch_stored_live_entries(task_ctx->store, live, nr_store,
+                                                     nr_live, brbe_attr->brbe_nr);
+               process_branch_entries(cpuc, event, task_ctx->store, nr_store);
+               task_ctx->nr_brbe_records = 0;
+       } else {
+               process_branch_entries(cpuc, event, live, nr_live);
+       }
+
        process_branch_aborts(cpuc);
-       task_ctx->nr_brbe_records = 0;
 
        /* Unpause the buffer */
        write_sysreg_s(brbfcr & ~BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);


> 
> I'm also wondering if it's possible to collapse some of the last 5
> commits? They seem to mostly modify things in brbe.c which is a new file
> so the history probably isn't important at this point it just makes it a
> bit harder to review.

[PATCH 6/10] enables base perf branch stack sampling on arm64 platform via
BRBE and then subsequent patches represent logical progression up until
save-stitch mechanism is implemented both during normal PMU IRQ and task
switch callbacks.

> 
>>  	process_branch_aborts(cpuc);
>> +	task_ctx->nr_brbe_records = 0;
>>  
>>  	/* Unpause the buffer */
>>  	write_sysreg_s(brbfcr & ~BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
