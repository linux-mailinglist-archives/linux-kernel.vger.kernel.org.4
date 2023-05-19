Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34EE709C93
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjESQjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjESQji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:39:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FA0F11F;
        Fri, 19 May 2023 09:39:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03EDE1FB;
        Fri, 19 May 2023 09:40:19 -0700 (PDT)
Received: from e120325.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C01D3F793;
        Fri, 19 May 2023 09:39:31 -0700 (PDT)
Date:   Fri, 19 May 2023 17:39:26 +0100
From:   Beata Michalska <beata.michalska@arm.com>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     Yang Shi <yang@os.amperecomputing.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Zeng Heng <zengheng4@huawei.com>,
        Ionela Voinescu <Ionela.Voinescu@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        wangxiongfeng2@huawei.com, xiexiuqi@huawei.com,
        liwei391@huawei.com, linux-acpi@vger.kernel.org,
        weiyongjun1@huawei.com, lenb@kernel.org, viresh.kumar@linaro.org,
        rafael@kernel.org
Subject: Re: [PATCH v2 1/2] cpufreq: CPPC: keep target core awake when
 reading its cpufreq rate
Message-ID: <ZGemPss01YollQKp@e120325.cambridge.arm.com>
References: <20230516133248.712242-1-zengheng4@huawei.com>
 <a1075da1-4ff1-4a8b-2902-3954db717ded@arm.com>
 <cde1d8a9-3a21-e82b-7895-40603a14d898@nvidia.com>
 <7caa9878-c910-06f2-6eee-64cc55d8a207@os.amperecomputing.com>
 <0dc000e3-9b85-0841-03c0-3589e2e5d34b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dc000e3-9b85-0841-03c0-3589e2e5d34b@nvidia.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 08:10:36PM +0530, Sumit Gupta wrote:
> > > > 
> > > > +Ionela, Sumit, Yang,
> > > > 
> > > > Hello Zeng,
> > > > 
> > > > I think solutions around related issues were suggested at:
> > > > 
> > > > [1]
> > > > https://lore.kernel.org/all/20230418113459.12860-7-sumitg@nvidia.com/
> > > > [2]
> > > > https://lore.kernel.org/all/20230328193846.8757-1-yang@os.amperecomputing.com/
> > > > [3] https://lore.kernel.org/all/ZEl1Fms%2FJmdEZsVn@arm.com/
> > > > 
> > > > About this patch, it seems to mean that CPPC counters of CPUx are always
> > > > accessed from CPUx, even when they are not AMUs. For instance CPPC
> > > > counters could be memory mapped and accessible from any CPU.
> > > > cpu_has_amu_feat() should allow to probe if a CPU uses AMUs or not,
> > > > and [2] had an implementation using it.
> > > > 
> > > > Another comment about PATCH 2/2 is that if the counters are accessed
> > > > through FFH, arm64 version of cpc_read_ffh() is calling
> > > > counters_read_on_cpu(), and a comment in counters_read_on_cpu() seems
> > > > to specify the function must be called with interrupt enabled.
> > > > 
> > > > I think the best solution so far was the one at [3], suggested by
> > > > Ionela,
> > > > but it doesn't seem to solve your issue. Indeed, it is not checked
> > > > whether
> > > > the counters are AMU counters and that they must be remotely read (to
> > > > have the CPU awake),
> > > > 
> > > > Regards,
> > > > Pierre
> > > > 
> > > 
> > > I think the solution in [1] is simple and solves all the three cases.
> > > Also, it provides better accuracy between the set and get frequency as
> > > compared to [3].
> > 
> > I don't think [1] patches work for our case. We use mmio instead of AMU.
> > Increasing delay could help to mitigate it somehow, buyt 25us is not
> > good enough for our case. IIRC the fix proposed by Ionela works for both
> > yours and mine.
> > 
FWIW, we are preparing a change providing an arch specific implementation of
_arch_freq_get_on_cpu_ that will leverage existing support for FIE with AMU
counters. This will give a reliable way of querying current CPU frequency
reflecting the last sched tick period. The only case when we would fall back
to cpufreq_gov's get functionality would be for CPUs with dynamic ticks when
those are the only ones withing given policy or there is no available
housekeeping CPU to query the frequency from. This should solve most of the
experienced issues. To be posted soon.

---
BR
B.

> 
> I have added the CPC_IN_SYSTEM_MEMORY check from [2] in [1].
> Could you please test if the below change works for you.
> 
> -----------------------------------------
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 7ff269a78c20..67aa09b5f15c 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1315,6 +1315,7 @@ int cppc_get_perf_ctrs(int cpunum, struct
> cppc_perf_fb_ctrs *perf_fb_ctrs)
>  	struct cppc_pcc_data *pcc_ss_data = NULL;
>  	u64 delivered, reference, ref_perf, ctr_wrap_time;
>  	int ret = 0, regs_in_pcc = 0;
> +	unsigned long flags;
> 
>  	if (!cpc_desc) {
>  		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
> @@ -1350,8 +1351,17 @@ int cppc_get_perf_ctrs(int cpunum, struct
> cppc_perf_fb_ctrs *perf_fb_ctrs)
>  		}
>  	}
> 
> +	if (CPC_IN_SYSTEM_MEMORY(delivered_reg) &&
> +	    CPC_IN_SYSTEM_MEMORY(reference_reg))
> +		local_irq_save(flags);
> +
>  	cpc_read(cpunum, delivered_reg, &delivered);
>  	cpc_read(cpunum, reference_reg, &reference);
> +
> +	if (CPC_IN_SYSTEM_MEMORY(delivered_reg) &&
> +	    CPC_IN_SYSTEM_MEMORY(reference_reg))
> +		local_irq_restore(flags);
> +
>  	cpc_read(cpunum, ref_perf_reg, &ref_perf);
> 
>  	/*
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 5e6a132a525e..23e690854459 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -46,6 +46,8 @@ static bool boost_supported;
>  /* default 2usec delay between sampling */
>  static unsigned int sampling_delay_us = 2;
> 
> +static bool get_rate_use_wq;
> +
>  static void cppc_check_hisi_workaround(void);
>  static void cppc_nvidia_workaround(void);
> 
> @@ -99,6 +101,12 @@ struct cppc_freq_invariance {
>  static DEFINE_PER_CPU(struct cppc_freq_invariance, cppc_freq_inv);
>  static struct kthread_worker *kworker_fie;
> 
> +struct feedback_ctrs {
> +	u32 cpu;
> +	struct cppc_perf_fb_ctrs fb_ctrs_t0;
> +	struct cppc_perf_fb_ctrs fb_ctrs_t1;
> +};
> +
>  static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu);
>  static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
>  				 struct cppc_perf_fb_ctrs *fb_ctrs_t0,
> @@ -851,28 +859,44 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata
> *cpu_data,
>  	return (reference_perf * delta_delivered) / delta_reference;
>  }
> 
> +static int cppc_get_perf_ctrs_sync(void *fb_ctrs)
> +{
> +	struct feedback_ctrs *ctrs = fb_ctrs;
> +	int ret;
> +
> +	ret = cppc_get_perf_ctrs(ctrs->cpu, &(ctrs->fb_ctrs_t0));
> +	if (ret)
> +		return ret;
> +
> +	udelay(sampling_delay_us);
> +
> +	ret = cppc_get_perf_ctrs(ctrs->cpu, &(ctrs->fb_ctrs_t1));
> +	if (ret)
> +		return ret;
> +
> +	return ret;
> +}
> +
>  static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>  {
> -	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
>  	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>  	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	struct feedback_ctrs fb_ctrs = {0};
>  	u64 delivered_perf;
>  	int ret;
> 
>  	cpufreq_cpu_put(policy);
> +	fb_ctrs.cpu = cpu;
> 
> -	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
> -	if (ret)
> -		return ret;
> -
> -	udelay(sampling_delay_us);
> -
> -	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
> +	if (get_rate_use_wq)
> +		ret = smp_call_on_cpu(cpu, cppc_get_perf_ctrs_sync, &fb_ctrs, false);
> +	else
> +		ret = cppc_get_perf_ctrs_sync(&fb_ctrs);
>  	if (ret)
>  		return ret;
> 
> -	delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
> -					       &fb_ctrs_t1);
> +	delivered_perf = cppc_perf_from_fbctrs(cpu_data, &(fb_ctrs.fb_ctrs_t0),
> +					       &(fb_ctrs.fb_ctrs_t1));
> 
>  	return cppc_cpufreq_perf_to_khz(cpu_data, delivered_perf);
>  }
> @@ -1002,10 +1026,18 @@ static void cppc_apply_workarounds(void)
>  static int __init cppc_cpufreq_init(void)
>  {
>  	int ret;
> +	int cpu;
> 
>  	if (!acpi_cpc_valid())
>  		return -ENODEV;
> 
> +#ifdef CONFIG_ARM64_AMU_EXTN
> +	cpu = get_cpu_with_amu_feat();
> +
> +	if (cpu < nr_cpu_ids)
> +		get_rate_use_wq = true;
> +#endif
> 
> --------------------------------------------
> 
> We can add additional check to call smp_call_on_cpu() only when CPC_IN_FFH
> if we want to reduce the scope of calling smp_call_on_cpu.
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 67aa09b5f15c..3d8348911403 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -110,6 +110,11 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
>                                 (cpc)->cpc_entry.reg.space_id ==        \
>                                 ACPI_ADR_SPACE_SYSTEM_IO)
> 
> +/* Check if a CPC register is in FFH */
> +#define CPC_IN_FFH(cpc) ((cpc)->type == ACPI_TYPE_BUFFER &&    \
> +                               (cpc)->cpc_entry.reg.space_id ==        \
> +                               ACPI_ADR_SPACE_FIXED_HARDWARE)
> +
>  /* Evaluates to True if reg is a NULL register descriptor */
>  #define IS_NULL_REG(reg) ((reg)->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY
> && \
>                                 (reg)->address == 0 &&                  \
> @@ -437,6 +442,29 @@ bool acpi_cpc_valid(void)
>  }
>  EXPORT_SYMBOL_GPL(acpi_cpc_valid);
> 
> +bool acpi_cpc_in_ffh(void)
> +{
> +       struct cpc_register_resource *delivered_reg, *reference_reg;
> +       struct cpc_desc *cpc_ptr;
> +       int cpu;
> +
> +       if (acpi_disabled)
> +               return false;
> +
> +       for_each_possible_cpu(cpu) {
> +               cpc_ptr = per_cpu(cpc_desc_ptr, cpu);
> +               delivered_reg = &cpc_ptr->cpc_regs[DELIVERED_CTR];
> +               reference_reg = &cpc_ptr->cpc_regs[REFERENCE_CTR];
> +
> +               if (!CPC_IN_FFH(delivered_reg) ||
> +                   !CPC_IN_FFH(reference_reg))
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +EXPORT_SYMBOL_GPL(acpi_cpc_in_ffh);
> +
>  bool cppc_allow_fast_switch(void)
>  {
>         struct cpc_register_resource *desired_reg;
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 23e690854459..4109e00b957e 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -1034,7 +1034,7 @@ static int __init cppc_cpufreq_init(void)
>  #ifdef CONFIG_ARM64_AMU_EXTN
>         cpu = get_cpu_with_amu_feat();
> 
> -       if (cpu < nr_cpu_ids)
> +       if ((cpu < nr_cpu_ids) && acpi_cpc_in_ffh())
>                 get_rate_use_wq = true;
>  #endif
> 
> > > 
> > > This can be merged and can later still be improved in Upstream.
> > > 
> > > If OK, I can send new version by changing the patch to apply for all
> > > ARM SoC's with AMU and not specific to Tegra.
> > > 
> > > Thank you,
> > > Sumit Gupta
