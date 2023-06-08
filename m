Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C61727689
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 07:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbjFHFPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 01:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbjFHFPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 01:15:13 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4A726B6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 22:15:12 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-650352b89f6so56932b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 22:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686201312; x=1688793312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e1h47p5k3wrJ7c5w/RTD0mfm9qHsnO8sn/U2DkDFEcg=;
        b=HYyzlTcTjauhdzH08Q5BlynHkKJCoDfZuVxAQmOw3srPsvr4NJSq94ZRQMH01aMobz
         NcUChIK2csjFpgeTRcKecZoOhQVO3cS/bC7HZgfOAvYvZ4a0an3yVthgjgXbnwNWp1OG
         e31150NqcoVCTvLqmD2PMesrEj03y1AQzxgpXNoRrVV2kcGUB2zRt3FJV1sOEQndfuRx
         yCeEky+XLbiaL1U1QipGhHw5hZofOMmpSqL6j5M3Ko0tnUrYBUO7SLZDVJ6iUU8prbuX
         SIRZTqbxpapvxAqXsF7jcxPyEp0E4s1R5vSrJ413Ym6OFvJEP8Et1DUASSKmqqdOQqAa
         SbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686201312; x=1688793312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1h47p5k3wrJ7c5w/RTD0mfm9qHsnO8sn/U2DkDFEcg=;
        b=hm98aX3gkzrTnUxRCP75vC363knW7TU7Xz1fnbyAKmE0xadPeFV8HY8SExti1faWQt
         RWMY/r/jUTfFmUnGN0EegEQJC5zQEr5rV4dWdYcc1D1wL7L4lljPN+fmPa9RH6GuRpIy
         rXEDMuZz0guXlzpw0+YKdasz7ECmSIBigIWStxPqhmAji3wUxdve+vLPnJchaIh+NXKF
         01xVPLuwgwcQgSOjx0UaA4BHsWb69hshWkoFsDyjFQ6JmM340oiammIhBmsWSWLWkchc
         im/b8Kjdsv9dZLNP5/3u6iPrtnNmXizJXhZvhim4Nb51mFv/rT3VpceynrTxrVMzrEUS
         ZTGg==
X-Gm-Message-State: AC+VfDzRTvCZVqvQPq2jSBUp66RSGyZMTN1eel3DNn/meLyTON/7V8gL
        LCLPwZ3HQP5gcJQ5SH9vJy1bp8SEbsMgG/mEDZA=
X-Google-Smtp-Source: ACHHUZ6s7BW5De80sTBc8chNfiqXhIg7+vFEyGhdaMKYTvqLP7RjJA6fiUVNFNpCPfPFKOpA88kN9A==
X-Received: by 2002:a05:6a00:2e01:b0:653:a9ac:44c with SMTP id fc1-20020a056a002e0100b00653a9ac044cmr4611459pfb.11.1686201312105;
        Wed, 07 Jun 2023 22:15:12 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id h16-20020aa786d0000000b006413e6e7578sm251124pfo.5.2023.06.07.22.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 22:15:11 -0700 (PDT)
Date:   Thu, 8 Jun 2023 10:45:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Beata Michalska <beata.michalska@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        mark.rutland@arm.com, will@kernel.org, rafael@kernel.org,
        sudeep.holla@arm.com, ionela.voinescu@arm.com, sumitg@nvidia.com,
        yang@os.amperecomputing.com, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] arm64: Provide an AMU-based version of
 arch_freq_get_on_cpu
Message-ID: <20230608051509.h4a6gn572mjgdusv@vireshk-i7>
References: <20230606155754.245998-1-beata.michalska@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606155754.245998-1-beata.michalska@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Len

On 06-06-23, 16:57, Beata Michalska wrote:
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> +unsigned int arch_freq_get_on_cpu(int cpu)
> +{
> +	unsigned int freq;
> +	u64 scale;
> +
> +	if (!cpumask_test_cpu(cpu, amu_fie_cpus))
> +		return 0;
> +
> +	if (!housekeeping_cpu(cpu, HK_TYPE_TICK)) {

I am not sure what we are doing in the `if` block here, at least a comment would
be useful.

> +		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +		int ref_cpu = nr_cpu_ids;
> +
> +		if (cpumask_intersects(housekeeping_cpumask(HK_TYPE_TICK),
> +				       policy->cpus))
> +			ref_cpu = cpumask_nth_and(cpu, policy->cpus,
> +						  housekeeping_cpumask(HK_TYPE_TICK));
> +		cpufreq_cpu_put(policy);
> +		if (ref_cpu >= nr_cpu_ids)
> +			return 0;
> +		cpu = ref_cpu;
> +	}

A blank line here please.

> +	/*
> +	 * Reversed computation to the one used to determine
> +	 * the arch_freq_scale value
> +	 * (see amu_scale_freq_tick for details)
> +	 */
> +	scale = per_cpu(arch_freq_scale, cpu);
> +	scale *= cpufreq_get_hw_max_freq(cpu);
> +	freq = scale >> SCHED_CAPACITY_SHIFT;
> +
> +	return freq;
> +}
> +
>  #ifdef CONFIG_ACPI_CPPC_LIB
>  #include <acpi/cppc_acpi.h>
>  
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 6b52ebe5a890..9f2cf45bf190 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -710,7 +710,8 @@ static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
>  	ssize_t ret;
>  	unsigned int freq;
>  
> -	freq = arch_freq_get_on_cpu(policy->cpu);
> +	freq = !cpufreq_driver->get ? arch_freq_get_on_cpu(policy->cpu)
> +				    : 0;

You may have changed the logic for X86 parts as well here. For a x86 platform
with setpolicy() and get() callbacks, we will not call arch_freq_get_on_cpu()
anymore ?

>  	if (freq)
>  		ret = sprintf(buf, "%u\n", freq);
>  	else if (cpufreq_driver->setpolicy && cpufreq_driver->get)
> @@ -747,7 +748,11 @@ store_one(scaling_max_freq, max);
>  static ssize_t show_cpuinfo_cur_freq(struct cpufreq_policy *policy,
>  					char *buf)
>  {
> -	unsigned int cur_freq = __cpufreq_get(policy);
> +	unsigned int cur_freq;
> +
> +	cur_freq = arch_freq_get_on_cpu(policy->cpu);
> +	if (!cur_freq)
> +		cur_freq = __cpufreq_get(policy);

For this and the above change, I am not sure what is the right thing to do.

From Len's commit [1]:

    Here we provide an x86 routine to make this calculation
    on supported hardware, and use it in preference to any
    driver driver-specific cpufreq_driver.get() routine.

I am not sure why Len updated `show_scaling_cur_freq()` and not
`show_cpuinfo_cur_freq()` ? Maybe we should update both these routines ?

Also, I don't think this is something that should have different logic for ARM
and X86, we should be consistent here as a cpufreq decision. Since both these
routines are reached via a read operation to a sysfs file, we shouldn't be
concerned about performance too.

What about doing this for both the routines, for all platforms now:

	cur_freq = arch_freq_get_on_cpu(policy->cpu);
	if (!cur_freq)
                ... get freq via policy->get() or policy->cur;

-- 
viresh

[1] commit f8475cef9008 ("x86: use common aperfmperf_khz_on_cpu() to calculate KHz using APERF/MPERF")
