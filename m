Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C8D721C14
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 04:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjFECnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 22:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFECnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 22:43:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D2B6BC;
        Sun,  4 Jun 2023 19:43:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 746CBD75;
        Sun,  4 Jun 2023 19:44:01 -0700 (PDT)
Received: from [10.162.41.6] (a077893.blr.arm.com [10.162.41.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44CA63F663;
        Sun,  4 Jun 2023 19:43:10 -0700 (PDT)
Message-ID: <58628cba-7ec4-b2b3-b993-14c2af1a67cb@arm.com>
Date:   Mon, 5 Jun 2023 08:13:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V11 05/10] arm64/perf: Add branch stack support in ARMV8
 PMU
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230531040428.501523-1-anshuman.khandual@arm.com>
 <20230531040428.501523-6-anshuman.khandual@arm.com>
 <CAM9d7cioDUxzNos5b3ANkG-BkJUcROSGCG0gpLzSXnc-v6o9jw@mail.gmail.com>
Content-Language: en-US
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <CAM9d7cioDUxzNos5b3ANkG-BkJUcROSGCG0gpLzSXnc-v6o9jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Namhyung,

On 6/2/23 08:03, Namhyung Kim wrote:
> On Tue, May 30, 2023 at 9:27 PM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>> This enables support for branch stack sampling event in ARMV8 PMU, checking
>> has_branch_stack() on the event inside 'struct arm_pmu' callbacks. Although
>> these branch stack helpers armv8pmu_branch_XXXXX() are just dummy functions
>> for now. While here, this also defines arm_pmu's sched_task() callback with
>> armv8pmu_sched_task(), which resets the branch record buffer on a sched_in.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Tested-by: James Clark <james.clark@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/include/asm/perf_event.h | 33 +++++++++++++
>>  drivers/perf/arm_pmuv3.c            | 76 ++++++++++++++++++++---------
>>  2 files changed, 86 insertions(+), 23 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
>> index eb7071c9eb34..7548813783ba 100644
>> --- a/arch/arm64/include/asm/perf_event.h
>> +++ b/arch/arm64/include/asm/perf_event.h
>> @@ -24,4 +24,37 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
>>         (regs)->pstate = PSR_MODE_EL1h; \
>>  }
>>
>> +struct pmu_hw_events;
>> +struct arm_pmu;
>> +struct perf_event;
>> +
>> +#ifdef CONFIG_PERF_EVENTS
>> +static inline bool has_branch_stack(struct perf_event *event);
>> +
>> +static inline void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)
>> +{
>> +       WARN_ON_ONCE(!has_branch_stack(event));
>> +}
>> +
>> +static inline bool armv8pmu_branch_valid(struct perf_event *event)
>> +{
>> +       WARN_ON_ONCE(!has_branch_stack(event));
>> +       return false;
>> +}
>> +
>> +static inline void armv8pmu_branch_enable(struct perf_event *event)
>> +{
>> +       WARN_ON_ONCE(!has_branch_stack(event));
>> +}
>> +
>> +static inline void armv8pmu_branch_disable(struct perf_event *event)
>> +{
>> +       WARN_ON_ONCE(!has_branch_stack(event));
>> +}
>> +
>> +static inline void armv8pmu_branch_probe(struct arm_pmu *arm_pmu) { }
>> +static inline void armv8pmu_branch_reset(void) { }
>> +static inline int armv8pmu_private_alloc(struct arm_pmu *arm_pmu) { return 0; }
>> +static inline void armv8pmu_private_free(struct arm_pmu *arm_pmu) { }
>> +#endif
>>  #endif
>> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
>> index c98e4039386d..86d803ff1ae3 100644
>> --- a/drivers/perf/arm_pmuv3.c
>> +++ b/drivers/perf/arm_pmuv3.c
>> @@ -705,38 +705,21 @@ static void armv8pmu_enable_event(struct perf_event *event)
>>          * Enable counter and interrupt, and set the counter to count
>>          * the event that we're interested in.
>>          */
>> -
>> -       /*
>> -        * Disable counter
>> -        */
>>         armv8pmu_disable_event_counter(event);
>> -
>> -       /*
>> -        * Set event.
>> -        */
>>         armv8pmu_write_event_type(event);
>> -
>> -       /*
>> -        * Enable interrupt for this counter
>> -        */
>>         armv8pmu_enable_event_irq(event);
>> -
>> -       /*
>> -        * Enable counter
>> -        */
>>         armv8pmu_enable_event_counter(event);
>> +
>> +       if (has_branch_stack(event))
>> +               armv8pmu_branch_enable(event);
>>  }
>>
>>  static void armv8pmu_disable_event(struct perf_event *event)
>>  {
>> -       /*
>> -        * Disable counter
>> -        */
>> -       armv8pmu_disable_event_counter(event);
>> +       if (has_branch_stack(event))
>> +               armv8pmu_branch_disable(event);
>>
>> -       /*
>> -        * Disable interrupt for this counter
>> -        */
>> +       armv8pmu_disable_event_counter(event);
>>         armv8pmu_disable_event_irq(event);
>>  }
>>
>> @@ -814,6 +797,11 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
>>                 if (!armpmu_event_set_period(event))
>>                         continue;
>>
>> +               if (has_branch_stack(event) && !WARN_ON(!cpuc->branches)) {
>> +                       armv8pmu_branch_read(cpuc, event);
>> +                       perf_sample_save_brstack(&data, event, &cpuc->branches->branch_stack);
>> +               }
>> +
>>                 /*
>>                  * Perf event overflow will queue the processing of the event as
>>                  * an irq_work which will be taken care of in the handling of
>> @@ -912,6 +900,14 @@ static int armv8pmu_user_event_idx(struct perf_event *event)
>>         return event->hw.idx;
>>  }
>>
>> +static void armv8pmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
>> +{
>> +       struct arm_pmu *armpmu = to_arm_pmu(pmu_ctx->pmu);
>> +
>> +       if (sched_in && arm_pmu_branch_stack_supported(armpmu))
>> +               armv8pmu_branch_reset();
>> +}
>> +
>>  /*
>>   * Add an event filter to a given event.
>>   */
>> @@ -982,6 +978,9 @@ static void armv8pmu_reset(void *info)
>>                 pmcr |= ARMV8_PMU_PMCR_LP;
>>
>>         armv8pmu_pmcr_write(pmcr);
>> +
>> +       if (arm_pmu_branch_stack_supported(cpu_pmu))
>> +               armv8pmu_branch_reset();
>>  }
>>
>>  static int __armv8_pmuv3_map_event_id(struct arm_pmu *armpmu,
>> @@ -1019,6 +1018,9 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
>>
>>         hw_event_id = __armv8_pmuv3_map_event_id(armpmu, event);
>>
>> +       if (has_branch_stack(event) && !armv8pmu_branch_valid(event))
>> +               return -EOPNOTSUPP;
>> +
>>         /*
>>          * CHAIN events only work when paired with an adjacent counter, and it
>>          * never makes sense for a user to open one in isolation, as they'll be
>> @@ -1135,6 +1137,21 @@ static void __armv8pmu_probe_pmu(void *info)
>>                 cpu_pmu->reg_pmmir = read_pmmir();
>>         else
>>                 cpu_pmu->reg_pmmir = 0;
>> +       armv8pmu_branch_probe(cpu_pmu);
>> +}
>> +
>> +static int branch_records_alloc(struct arm_pmu *armpmu)
>> +{
>> +       struct pmu_hw_events *events;
>> +       int cpu;
>> +
>> +       for_each_possible_cpu(cpu) {
>> +               events = per_cpu_ptr(armpmu->hw_events, cpu);
>> +               events->branches = kzalloc(sizeof(struct branch_records), GFP_KERNEL);
>> +               if (!events->branches)
>> +                       return -ENOMEM;
>> +       }
>> +       return 0;
>>  }
>>
>>  static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
>> @@ -1145,12 +1162,24 @@ static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
>>         };
>>         int ret;
>>
>> +       ret = armv8pmu_private_alloc(cpu_pmu);
>> +       if (ret)
>> +               return ret;
> Wouldn't it be better to move it under the if statement below
> if it's only needed for branch stack?

armv8pmu_private_alloc() allocates arm_pmu's private structure which stores
the BRBE HW attributes during armv8pmu_branch_probe(), called from this SMP
callback __armv8pmu_probe_pmu(). Hence without the structure being allocated
and assigned, following smp_call_function_any() cannot execute successfully.

armv8pmu_private_alloc()
	{
		......
		Allocates arm_pmu->private as single 'struct brbe_hw_attr'
		Allocates arm_pmu->pmu.task_ctx_cache
		......
	}

__armv8pmu_probe_pmu()
	armv8pmu_branch_probe()
		brbe_attributes_probe()
		{
			......
			brbe_attr->brbe_version = brbe;
			brbe_attr->brbe_format = brbe_get_format(brbidr);
        		brbe_attr->brbe_cc = brbe_get_cc_bits(brbidr);
        		brbe_attr->brbe_nr = brbe_get_numrec(brbidr);
			......
		}

armv8pmu_private_alloc() cannot be moved inside armv8pmu_branch_probe(),
because there cannot be any allocation while being in a SMP call context.

> 
>> +
>>         ret = smp_call_function_any(&cpu_pmu->supported_cpus,
>>                                     __armv8pmu_probe_pmu,
>>                                     &probe, 1);
>>         if (ret)
>>                 return ret;
> Otherwise you might need to free it here.
> 
>> +       if (arm_pmu_branch_stack_supported(cpu_pmu)) {
>> +               ret = branch_records_alloc(cpu_pmu);
>> +               if (ret)
>> +                       return ret;
> And here too.

Not freeing the arm_pmu's private data, might not be a problem in cases
where either pmu does not support BRBE or pmu probe itself fails. But for
completeness, will change as following.

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 9725a53d6799..fdbe52913cc7 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -1198,13 +1198,17 @@ static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
        ret = smp_call_function_any(&cpu_pmu->supported_cpus,
                                    __armv8pmu_probe_pmu,
                                    &probe, 1);
-       if (ret)
+       if (ret) {
+               armv8pmu_private_free(cpu_pmu);
                return ret;
+       }
 
        if (arm_pmu_branch_stack_supported(cpu_pmu)) {
                ret = branch_records_alloc(cpu_pmu);
-               if (ret)
+               if (ret) {
+                       armv8pmu_private_free(cpu_pmu);
                        return ret;
+               }
        } else {
                armv8pmu_private_free(cpu_pmu);
        }
