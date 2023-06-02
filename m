Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D44A71F871
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 04:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbjFBCeJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Jun 2023 22:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFBCeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 22:34:08 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF30184;
        Thu,  1 Jun 2023 19:34:07 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-ba841216e92so1627562276.1;
        Thu, 01 Jun 2023 19:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685673246; x=1688265246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xk3Rc0h2ObRKAXRYUm/zEVJciQYfZSHvCKxOG+vpYQA=;
        b=keWP2+N0b3X3q5Qhj80pULL73kwBSufJSobZKTcHbGHOW4NzBnGvaEvkYNFn5bN5nJ
         JDm5ovvoplDUklOT/JzJrR7hlrr3kxfvQgUQc8t1soL6qsBnNTtMKKVri8QWoDLaEBPA
         j4IZxyjzmmdhcLlgnsrgeMJ46WduDkFPWFwHZM/7BMA9ZgPCixf96G3t2afqU+oVUETc
         eCpVJch9tsrVPHrPgmWGXYC9H6BquQhqJSdqdt4MvDXROSUz3PFyWoGDB9JTxtJ5zN8x
         Ww5s/50Zfr+JGtvCgYO19cI5EMHC7BvKf6wTxJGglC4xRUEb2bb87GATGrZcykEd4T3Q
         7OXw==
X-Gm-Message-State: AC+VfDyYLjO5KzNZLdENS3Y5TRflo4xJQhSRIv6u+YppQyPrBDXqEdLi
        kMO4tXFyKi4/1XPLPi6c+1mlP0vSk7nASCCzMEamb0Z1
X-Google-Smtp-Source: ACHHUZ4mqXRIstnhLo+CFz0NkOM2wTvTa3qDFEvmnY0+LcmGaJtftFXZR+a19UHj/M3Icbzf3I+9emuCsk5QwWiG4Ic=
X-Received: by 2002:a25:bcc5:0:b0:bb1:684a:c369 with SMTP id
 l5-20020a25bcc5000000b00bb1684ac369mr1700694ybm.54.1685673246299; Thu, 01 Jun
 2023 19:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230531040428.501523-1-anshuman.khandual@arm.com> <20230531040428.501523-6-anshuman.khandual@arm.com>
In-Reply-To: <20230531040428.501523-6-anshuman.khandual@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 1 Jun 2023 19:33:54 -0700
Message-ID: <CAM9d7cioDUxzNos5b3ANkG-BkJUcROSGCG0gpLzSXnc-v6o9jw@mail.gmail.com>
Subject: Re: [PATCH V11 05/10] arm64/perf: Add branch stack support in ARMV8 PMU
To:     Anshuman Khandual <anshuman.khandual@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 9:27 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> This enables support for branch stack sampling event in ARMV8 PMU, checking
> has_branch_stack() on the event inside 'struct arm_pmu' callbacks. Although
> these branch stack helpers armv8pmu_branch_XXXXX() are just dummy functions
> for now. While here, this also defines arm_pmu's sched_task() callback with
> armv8pmu_sched_task(), which resets the branch record buffer on a sched_in.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Tested-by: James Clark <james.clark@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/include/asm/perf_event.h | 33 +++++++++++++
>  drivers/perf/arm_pmuv3.c            | 76 ++++++++++++++++++++---------
>  2 files changed, 86 insertions(+), 23 deletions(-)
>
> diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
> index eb7071c9eb34..7548813783ba 100644
> --- a/arch/arm64/include/asm/perf_event.h
> +++ b/arch/arm64/include/asm/perf_event.h
> @@ -24,4 +24,37 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
>         (regs)->pstate = PSR_MODE_EL1h; \
>  }
>
> +struct pmu_hw_events;
> +struct arm_pmu;
> +struct perf_event;
> +
> +#ifdef CONFIG_PERF_EVENTS
> +static inline bool has_branch_stack(struct perf_event *event);
> +
> +static inline void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)
> +{
> +       WARN_ON_ONCE(!has_branch_stack(event));
> +}
> +
> +static inline bool armv8pmu_branch_valid(struct perf_event *event)
> +{
> +       WARN_ON_ONCE(!has_branch_stack(event));
> +       return false;
> +}
> +
> +static inline void armv8pmu_branch_enable(struct perf_event *event)
> +{
> +       WARN_ON_ONCE(!has_branch_stack(event));
> +}
> +
> +static inline void armv8pmu_branch_disable(struct perf_event *event)
> +{
> +       WARN_ON_ONCE(!has_branch_stack(event));
> +}
> +
> +static inline void armv8pmu_branch_probe(struct arm_pmu *arm_pmu) { }
> +static inline void armv8pmu_branch_reset(void) { }
> +static inline int armv8pmu_private_alloc(struct arm_pmu *arm_pmu) { return 0; }
> +static inline void armv8pmu_private_free(struct arm_pmu *arm_pmu) { }
> +#endif
>  #endif
> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index c98e4039386d..86d803ff1ae3 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -705,38 +705,21 @@ static void armv8pmu_enable_event(struct perf_event *event)
>          * Enable counter and interrupt, and set the counter to count
>          * the event that we're interested in.
>          */
> -
> -       /*
> -        * Disable counter
> -        */
>         armv8pmu_disable_event_counter(event);
> -
> -       /*
> -        * Set event.
> -        */
>         armv8pmu_write_event_type(event);
> -
> -       /*
> -        * Enable interrupt for this counter
> -        */
>         armv8pmu_enable_event_irq(event);
> -
> -       /*
> -        * Enable counter
> -        */
>         armv8pmu_enable_event_counter(event);
> +
> +       if (has_branch_stack(event))
> +               armv8pmu_branch_enable(event);
>  }
>
>  static void armv8pmu_disable_event(struct perf_event *event)
>  {
> -       /*
> -        * Disable counter
> -        */
> -       armv8pmu_disable_event_counter(event);
> +       if (has_branch_stack(event))
> +               armv8pmu_branch_disable(event);
>
> -       /*
> -        * Disable interrupt for this counter
> -        */
> +       armv8pmu_disable_event_counter(event);
>         armv8pmu_disable_event_irq(event);
>  }
>
> @@ -814,6 +797,11 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
>                 if (!armpmu_event_set_period(event))
>                         continue;
>
> +               if (has_branch_stack(event) && !WARN_ON(!cpuc->branches)) {
> +                       armv8pmu_branch_read(cpuc, event);
> +                       perf_sample_save_brstack(&data, event, &cpuc->branches->branch_stack);
> +               }
> +
>                 /*
>                  * Perf event overflow will queue the processing of the event as
>                  * an irq_work which will be taken care of in the handling of
> @@ -912,6 +900,14 @@ static int armv8pmu_user_event_idx(struct perf_event *event)
>         return event->hw.idx;
>  }
>
> +static void armv8pmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
> +{
> +       struct arm_pmu *armpmu = to_arm_pmu(pmu_ctx->pmu);
> +
> +       if (sched_in && arm_pmu_branch_stack_supported(armpmu))
> +               armv8pmu_branch_reset();
> +}
> +
>  /*
>   * Add an event filter to a given event.
>   */
> @@ -982,6 +978,9 @@ static void armv8pmu_reset(void *info)
>                 pmcr |= ARMV8_PMU_PMCR_LP;
>
>         armv8pmu_pmcr_write(pmcr);
> +
> +       if (arm_pmu_branch_stack_supported(cpu_pmu))
> +               armv8pmu_branch_reset();
>  }
>
>  static int __armv8_pmuv3_map_event_id(struct arm_pmu *armpmu,
> @@ -1019,6 +1018,9 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
>
>         hw_event_id = __armv8_pmuv3_map_event_id(armpmu, event);
>
> +       if (has_branch_stack(event) && !armv8pmu_branch_valid(event))
> +               return -EOPNOTSUPP;
> +
>         /*
>          * CHAIN events only work when paired with an adjacent counter, and it
>          * never makes sense for a user to open one in isolation, as they'll be
> @@ -1135,6 +1137,21 @@ static void __armv8pmu_probe_pmu(void *info)
>                 cpu_pmu->reg_pmmir = read_pmmir();
>         else
>                 cpu_pmu->reg_pmmir = 0;
> +       armv8pmu_branch_probe(cpu_pmu);
> +}
> +
> +static int branch_records_alloc(struct arm_pmu *armpmu)
> +{
> +       struct pmu_hw_events *events;
> +       int cpu;
> +
> +       for_each_possible_cpu(cpu) {
> +               events = per_cpu_ptr(armpmu->hw_events, cpu);
> +               events->branches = kzalloc(sizeof(struct branch_records), GFP_KERNEL);
> +               if (!events->branches)
> +                       return -ENOMEM;
> +       }
> +       return 0;
>  }
>
>  static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
> @@ -1145,12 +1162,24 @@ static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
>         };
>         int ret;
>
> +       ret = armv8pmu_private_alloc(cpu_pmu);
> +       if (ret)
> +               return ret;

Wouldn't it be better to move it under the if statement below
if it's only needed for branch stack?

> +
>         ret = smp_call_function_any(&cpu_pmu->supported_cpus,
>                                     __armv8pmu_probe_pmu,
>                                     &probe, 1);
>         if (ret)
>                 return ret;

Otherwise you might need to free it here.

>
> +       if (arm_pmu_branch_stack_supported(cpu_pmu)) {
> +               ret = branch_records_alloc(cpu_pmu);
> +               if (ret)
> +                       return ret;

And here too.

Thanks,
Namhyung


> +       } else {
> +               armv8pmu_private_free(cpu_pmu);
> +       }
> +
>         return probe.present ? 0 : -ENODEV;
>  }
>
> @@ -1214,6 +1243,7 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
>         cpu_pmu->set_event_filter       = armv8pmu_set_event_filter;
>
>         cpu_pmu->pmu.event_idx          = armv8pmu_user_event_idx;
> +       cpu_pmu->sched_task             = armv8pmu_sched_task;
>
>         cpu_pmu->name                   = name;
>         cpu_pmu->map_event              = map_event;
> --
> 2.25.1
>
