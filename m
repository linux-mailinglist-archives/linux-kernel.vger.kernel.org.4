Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614EC7282F3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbjFHOpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbjFHOpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:45:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CDDD2136;
        Thu,  8 Jun 2023 07:45:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BE60AB6;
        Thu,  8 Jun 2023 07:46:02 -0700 (PDT)
Received: from e120325.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A07823F6C4;
        Thu,  8 Jun 2023 07:45:13 -0700 (PDT)
Date:   Thu, 8 Jun 2023 15:45:11 +0100
From:   Beata Michalska <beata.michalska@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        mark.rutland@arm.com, will@kernel.org, rafael@kernel.org,
        sudeep.holla@arm.com, ionela.voinescu@arm.com, sumitg@nvidia.com,
        yang@os.amperecomputing.com, Len Brown <len.brown@intel.com>,
        vincent.guittot@linaro.org
Subject: Re: [PATCH] arm64: Provide an AMU-based version of
 arch_freq_get_on_cpu
Message-ID: <ZIHpd6unkOtYVEqP@e120325.cambridge.arm.com>
References: <20230606155754.245998-1-beata.michalska@arm.com>
 <20230608051509.h4a6gn572mjgdusv@vireshk-i7>
 <20230608051816.2ww7ncg65qo7kcuk@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608051816.2ww7ncg65qo7kcuk@vireshk-i7>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 10:48:16AM +0530, Viresh Kumar wrote:
> +Vincent
> 
> On 08-06-23, 10:45, Viresh Kumar wrote:
> > +Len
> > 
> > On 06-06-23, 16:57, Beata Michalska wrote:
> > > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > > +unsigned int arch_freq_get_on_cpu(int cpu)
> > > +{
> > > +	unsigned int freq;
> > > +	u64 scale;
> > > +
> > > +	if (!cpumask_test_cpu(cpu, amu_fie_cpus))
> > > +		return 0;
> > > +
> > > +	if (!housekeeping_cpu(cpu, HK_TYPE_TICK)) {
> > 
> > I am not sure what we are doing in the `if` block here, at least a comment would
> > be useful.
For those CPUs that are in full dynticks mode , the arch_freq_scale_factor will
be basically useless (as there will be no regular sched_tick which eventually
calls topology_scale_freq_tick()), so the code below will look for any other
available CPU within current policy that could server as the source of the
counters. If there is none it will fallback to cpufreq driver to provide
current frequency.
Comment to be added.

> > 
> > > +		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> > > +		int ref_cpu = nr_cpu_ids;
> > > +
> > > +		if (cpumask_intersects(housekeeping_cpumask(HK_TYPE_TICK),
> > > +				       policy->cpus))
> > > +			ref_cpu = cpumask_nth_and(cpu, policy->cpus,
> > > +						  housekeeping_cpumask(HK_TYPE_TICK));
> > > +		cpufreq_cpu_put(policy);
> > > +		if (ref_cpu >= nr_cpu_ids)
> > > +			return 0;
> > > +		cpu = ref_cpu;
> > > +	}
> > 
> > A blank line here please.
Noted.
> > 
> > > +	/*
> > > +	 * Reversed computation to the one used to determine
> > > +	 * the arch_freq_scale value
> > > +	 * (see amu_scale_freq_tick for details)
> > > +	 */
> > > +	scale = per_cpu(arch_freq_scale, cpu);
> > > +	scale *= cpufreq_get_hw_max_freq(cpu);
> > > +	freq = scale >> SCHED_CAPACITY_SHIFT;
> > > +
> > > +	return freq;
> > > +}
> > > +
> > >  #ifdef CONFIG_ACPI_CPPC_LIB
> > >  #include <acpi/cppc_acpi.h>
> > >  
> > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > index 6b52ebe5a890..9f2cf45bf190 100644
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -710,7 +710,8 @@ static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
> > >  	ssize_t ret;
> arch_freq_get_on_cpu> >  	unsigned int freq;
> > >  
> > > -	freq = arch_freq_get_on_cpu(policy->cpu);
> > > +	freq = !cpufreq_driver->get ? arch_freq_get_on_cpu(policy->cpu)
> > > +				    : 0;
> > 
> > You may have changed the logic for X86 parts as well here. For a x86 platform
> > with setpolicy() and get() callbacks, we will not call arch_freq_get_on_cpu()
> > anymore ?
> > 
There is a little bit of ambiguity around both 'cpuinfo_cur_freq' and
'scaling_cur_freq' and how those two are being handled on different platforms.
If I got things right, the first one is supposed to reflect the frequency as
obtained from  the hardware, whereas the latter is more of a sw point of view on
that, with the exception of x86, where that one is actually relying on info
retrieved from the hardware. It would potentially break the 'x86' platforms that
do provide both: setpolicy and get, though apparently I must have missed one (?)
(... so I did miss LongRun although not sure how much of an issue it would be
for that case ...)
> > >  	if (freq)
> > >  		ret = sprintf(buf, "%u\n", freq);
> > >  	else if (cpufreq_driver->setpolicy && cpufreq_driver->get)
> > > @@ -747,7 +748,11 @@ store_one(scaling_max_freq, max);
> > >  static ssize_t show_cpuinfo_cur_freq(struct cpufreq_policy *policy,
> > >  					char *buf)
> > >  {
> > > -	unsigned int cur_freq = __cpufreq_get(policy);
> > > +	unsigned int cur_freq;
> > > +
> > > +	cur_freq = arch_freq_get_on_cpu(policy->cpu);
> > > +	if (!cur_freq)
> > > +		cur_freq = __cpufreq_get(policy);
> > 
> > For this and the above change, I am not sure what is the right thing to do.
> > 
> > >From Len's commit [1]:
> > 
> >     Here we provide an x86 routine to make this calculation
> >     on supported hardware, and use it in preference to any
> >     driver driver-specific cpufreq_driver.get() routine.
> > 
I've seen that one as well though there seems to be no cpufreq driver that does
support both.
(scratch that ... there is LongRun)
> > I am not sure why Len updated `show_scaling_cur_freq()` and not
> > `show_cpuinfo_cur_freq()` ? Maybe we should update both these routines ?
> > 
> > Also, I don't think this is something that should have different logic for ARM
> > and X86, we should be consistent here as a cpufreq decision. Since both these
I agree, it would be good to align the two.
> > routines are reached via a read operation to a sysfs file, we shouldn't be
> > concerned about performance too.
> > 
> > What about doing this for both the routines, for all platforms now:
> > 
> > 	cur_freq = arch_freq_get_on_cpu(policy->cpu);
> > 	if (!cur_freq)
> >                 ... get freq via policy->get() or policy->cur;
> > 
That could work, I guess. But then we would have 'cpuinfo_cur_freq' ==
'scaling_cur_freq' for platforms that do provide arch_freq_get_on_cpu,
which might lead to more confusion as per what is the actual difference between
the two (?)

Thank you for all the comments!

---
BR
B.
> > -- 
> > viresh
> > 
> > [1] commit f8475cef9008 ("x86: use common aperfmperf_khz_on_cpu() to calculate KHz using APERF/MPERF")
> 
> -- 
> viresh
