Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EFA5E6F5C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 00:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiIVWHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 18:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiIVWHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 18:07:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46D9C11264F;
        Thu, 22 Sep 2022 15:07:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1180B1595;
        Thu, 22 Sep 2022 15:07:19 -0700 (PDT)
Received: from [192.168.122.164] (U203867.austin.arm.com [10.118.30.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 520143F73B;
        Thu, 22 Sep 2022 15:07:12 -0700 (PDT)
Message-ID: <6936c836-03e7-ea15-e7ed-2a213458f872@arm.com>
Date:   Thu, 22 Sep 2022 17:07:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5 1/1] ACPI: CPPC: Disable FIE if registers in PCC
 regions
Content-Language: en-US
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, viresh.kumar@linaro.org,
        robert.moore@intel.com, punit.agrawal@bytedance.com,
        lukasz.luba@arm.com, ionela.voinescu@arm.com,
        pierre.gondois@arm.com, linux-kernel@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org
References: <20220912203722.205185-1-jeremy.linton@arm.com>
 <20220912203722.205185-2-jeremy.linton@arm.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20220912203722.205185-2-jeremy.linton@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raphael,

Ping, are we good here?

Thanks,


On 9/12/22 15:37, Jeremy Linton wrote:
> PCC regions utilize a mailbox to set/retrieve register values used by
> the CPPC code. This is fine as long as the operations are
> infrequent. With the FIE code enabled though the overhead can range
> from 2-11% of system CPU overhead (ex: as measured by top) on Arm
> based machines.
> 
> So, before enabling FIE assure none of the registers used by
> cppc_get_perf_ctrs() are in the PCC region. Finally, add a module
> parameter which can override the PCC region detection at boot or
> module reload.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/acpi/cppc_acpi.c       | 42 ++++++++++++++++++++++++++++++++++
>   drivers/cpufreq/cppc_cpufreq.c | 25 ++++++++++++++++----
>   include/acpi/cppc_acpi.h       |  5 ++++
>   3 files changed, 68 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 1e15a9f25ae9..55693e6f7153 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1240,6 +1240,48 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>   }
>   EXPORT_SYMBOL_GPL(cppc_get_perf_caps);
>   
> +/**
> + * cppc_perf_ctrs_in_pcc - Check if any perf counters are in a PCC region.
> + *
> + * CPPC has flexibility about how CPU performance counters are accessed.
> + * One of the choices is PCC regions, which can have a high access latency. This
> + * routine allows callers of cppc_get_perf_ctrs() to know this ahead of time.
> + *
> + * Return: true if any of the counters are in PCC regions, false otherwise
> + */
> +bool cppc_perf_ctrs_in_pcc(void)
> +{
> +	int cpu;
> +
> +	for_each_present_cpu(cpu) {
> +		struct cpc_register_resource *ref_perf_reg;
> +		struct cpc_desc *cpc_desc;
> +
> +		cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> +
> +		if (CPC_IN_PCC(&cpc_desc->cpc_regs[DELIVERED_CTR]) ||
> +		    CPC_IN_PCC(&cpc_desc->cpc_regs[REFERENCE_CTR]) ||
> +		    CPC_IN_PCC(&cpc_desc->cpc_regs[CTR_WRAP_TIME]))
> +			return true;
> +
> +
> +		ref_perf_reg = &cpc_desc->cpc_regs[REFERENCE_PERF];
> +
> +		/*
> +		 * If reference perf register is not supported then we should
> +		 * use the nominal perf value
> +		 */
> +		if (!CPC_SUPPORTED(ref_perf_reg))
> +			ref_perf_reg = &cpc_desc->cpc_regs[NOMINAL_PERF];
> +
> +		if (CPC_IN_PCC(ref_perf_reg))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc);
> +
>   /**
>    * cppc_get_perf_ctrs - Read a CPU's performance feedback counters.
>    * @cpunum: CPU from which to read counters.
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 24eaf0ec344d..9e2a48ac5830 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -63,7 +63,15 @@ static struct cppc_workaround_oem_info wa_info[] = {
>   
>   static struct cpufreq_driver cppc_cpufreq_driver;
>   
> +static enum {
> +	FIE_UNSET = -1,
> +	FIE_ENABLED,
> +	FIE_DISABLED
> +} fie_disabled = FIE_UNSET;
> +
>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
> +module_param(fie_disabled, int, 0444);
> +MODULE_PARM_DESC(fie_disabled, "Disable Frequency Invariance Engine (FIE)");
>   
>   /* Frequency invariance support */
>   struct cppc_freq_invariance {
> @@ -158,7 +166,7 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
>   	struct cppc_freq_invariance *cppc_fi;
>   	int cpu, ret;
>   
> -	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> +	if (fie_disabled)
>   		return;
>   
>   	for_each_cpu(cpu, policy->cpus) {
> @@ -199,7 +207,7 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
>   	struct cppc_freq_invariance *cppc_fi;
>   	int cpu;
>   
> -	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> +	if (fie_disabled)
>   		return;
>   
>   	/* policy->cpus will be empty here, use related_cpus instead */
> @@ -229,7 +237,15 @@ static void __init cppc_freq_invariance_init(void)
>   	};
>   	int ret;
>   
> -	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> +	if (fie_disabled != FIE_ENABLED && fie_disabled != FIE_DISABLED) {
> +		fie_disabled = FIE_ENABLED;
> +		if (cppc_perf_ctrs_in_pcc()) {
> +			pr_info("FIE not enabled on systems with registers in PCC\n");
> +			fie_disabled = FIE_DISABLED;
> +		}
> +	}
> +
> +	if (fie_disabled)
>   		return;
>   
>   	kworker_fie = kthread_create_worker(0, "cppc_fie");
> @@ -247,7 +263,7 @@ static void __init cppc_freq_invariance_init(void)
>   
>   static void cppc_freq_invariance_exit(void)
>   {
> -	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> +	if (fie_disabled)
>   		return;
>   
>   	kthread_destroy_worker(kworker_fie);
> @@ -936,6 +952,7 @@ static void cppc_check_hisi_workaround(void)
>   		    wa_info[i].oem_revision == tbl->oem_revision) {
>   			/* Overwrite the get() callback */
>   			cppc_cpufreq_driver.get = hisi_cppc_cpufreq_get_rate;
> +			fie_disabled = FIE_DISABLED;
>   			break;
>   		}
>   	}
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index f73d357ecdf5..c5614444031f 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -140,6 +140,7 @@ extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
>   extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
>   extern int cppc_set_enable(int cpu, bool enable);
>   extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
> +extern bool cppc_perf_ctrs_in_pcc(void);
>   extern bool acpi_cpc_valid(void);
>   extern bool cppc_allow_fast_switch(void);
>   extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data);
> @@ -173,6 +174,10 @@ static inline int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps)
>   {
>   	return -ENOTSUPP;
>   }
> +static inline bool cppc_perf_ctrs_in_pcc(void)
> +{
> +	return false;
> +}
>   static inline bool acpi_cpc_valid(void)
>   {
>   	return false;

