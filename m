Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558866EC7F0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 10:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjDXIcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 04:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDXIcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 04:32:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60FF21AD;
        Mon, 24 Apr 2023 01:32:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84820D75;
        Mon, 24 Apr 2023 01:33:02 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.78.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BF913F5A1;
        Mon, 24 Apr 2023 01:32:18 -0700 (PDT)
Date:   Mon, 24 Apr 2023 09:32:16 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     viresh.kumar@linaro.org, rafael@kernel.org, mark.rutland@arm.com,
        sudeep.holla@arm.com, lpieralisi@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com, vsethi@nvidia.com, sdonthineni@nvidia.com,
        sanjayc@nvidia.com, ksitaraman@nvidia.com, bbasu@nvidia.com
Subject: Re: [Patch 6/6] cpufreq: CPPC: use wq to read amu counters on target
 cpu
Message-ID: <ZEY+kENTxCvHlhvK@arm.com>
References: <20230418113459.12860-1-sumitg@nvidia.com>
 <20230418113459.12860-7-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418113459.12860-7-sumitg@nvidia.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,

Thank you for the patches!

On Tuesday 18 Apr 2023 at 17:04:59 (+0530), Sumit Gupta wrote:
> ARM cores which implement the Activity Monitor Unit (AMU)
> use Functional Fixed Hardware (FFH) to map AMU counters to
> Delivered_Counter and Reference_Counter registers. Each
> sysreg is read separately with a smp_call_function_single
> call. So, total four IPI's are used, one per register.
> Due to this, the AMU's core counter and constant counter
> sampling can happen at a non-consistent time interval if
> an IPI is handled late. This results in unstable frequency
> value from "cpuinfo_cur_req" node sometimes. To fix, queue
> work on target CPU to read all counters synchronously in
> sequence. This helps to remove the inter-IPI latency and
> make sure that both the counters are sampled at a close
> time interval.
> Without this change we observed that the re-generated value
> of CPU Frequency from AMU counters sometimes deviates by
> ~25% as the counters are read at non-determenistic time.
> Currently, kept the change specific to Tegra241. It can be
> applied to other SoC's having AMU if same issue is observed.
> 

To be honest I never liked the need for IPIs but it was the most
generic solution I could find for an FFH implementation that does not
assume a dependency between different reads, which is usecase specific.

Also, for any kind of caching of the counters I'd have to introduce some
logic that would assume we'd always have two consecutive reads - one for
the cycle counter and one for the constant counter, and there should be no
update between them. And then there's the problem of potentially returning
the same values if there's no update between two sets of reads.

The only feasible idea based on caching would be to piggy back on the
frequency invariance engine (FIE) which computes a performance scale
factor on the tick which can be translated to frequency. But the
frequency obtained would be an average frequency for the past 4ms, which
can in turn be at up to 4ms old (or more, if the CPU was idle).

Would something like this work for you?

This could also help with a similar issue described at [1] - not an IPI
related issue, but an issue with similar symptoms.

[1] https://lore.kernel.org/lkml/20230328193846.8757-1-yang@os.amperecomputing.com/

Thanks,
Ionela.

> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 53 +++++++++++++++++++++++++++-------
>  1 file changed, 43 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 5e6a132a525e..52b93ac6225e 100644
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
> @@ -851,28 +859,44 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
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
> @@ -953,7 +977,16 @@ static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu)
>  
>  static void cppc_nvidia_workaround(void)
>  {
> +	int cpu;
> +
>  	sampling_delay_us = 25;
> +
> +#ifdef CONFIG_ARM64_AMU_EXTN
> +	cpu = get_cpu_with_amu_feat();
> +
> +	if (cpu < nr_cpu_ids)
> +		get_rate_use_wq = true;
> +#endif
>  }
>  
>  static void cppc_check_hisi_workaround(void)
> -- 
> 2.17.1
> 
