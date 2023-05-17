Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E925370629B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjEQIRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjEQIRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:17:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91573139;
        Wed, 17 May 2023 01:17:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBEA81FB;
        Wed, 17 May 2023 01:18:28 -0700 (PDT)
Received: from [10.34.100.110] (e126645.nice.arm.com [10.34.100.110])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15C713F663;
        Wed, 17 May 2023 01:17:41 -0700 (PDT)
Message-ID: <a1075da1-4ff1-4a8b-2902-3954db717ded@arm.com>
Date:   Wed, 17 May 2023 10:17:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] cpufreq: CPPC: keep target core awake when reading
 its cpufreq rate
Content-Language: en-US
To:     Zeng Heng <zengheng4@huawei.com>,
        Ionela Voinescu <Ionela.Voinescu@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        wangxiongfeng2@huawei.com, xiexiuqi@huawei.com,
        liwei391@huawei.com, linux-acpi@vger.kernel.org,
        weiyongjun1@huawei.com, lenb@kernel.org, viresh.kumar@linaro.org,
        rafael@kernel.org, sumitg@nvidia.com,
        Yang Shi <yang@os.amperecomputing.com>
References: <20230516133248.712242-1-zengheng4@huawei.com>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20230516133248.712242-1-zengheng4@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Ionela, Sumit, Yang,

Hello Zeng,

I think solutions around related issues were suggested at:

[1] https://lore.kernel.org/all/20230418113459.12860-7-sumitg@nvidia.com/
[2] https://lore.kernel.org/all/20230328193846.8757-1-yang@os.amperecomputing.com/
[3] https://lore.kernel.org/all/ZEl1Fms%2FJmdEZsVn@arm.com/

About this patch, it seems to mean that CPPC counters of CPUx are always
accessed from CPUx, even when they are not AMUs. For instance CPPC
counters could be memory mapped and accessible from any CPU.
cpu_has_amu_feat() should allow to probe if a CPU uses AMUs or not,
and [2] had an implementation using it.

Another comment about PATCH 2/2 is that if the counters are accessed
through FFH, arm64 version of cpc_read_ffh() is calling
counters_read_on_cpu(), and a comment in counters_read_on_cpu() seems
to specify the function must be called with interrupt enabled.

I think the best solution so far was the one at [3], suggested by Ionela,
but it doesn't seem to solve your issue. Indeed, it is not checked whether
the counters are AMU counters and that they must be remotely read (to
have the CPU awake),

Regards,
Pierre


On 5/16/23 15:32, Zeng Heng wrote:
> As ARM AMU's document says, all counters are subject to any changes
> in clock frequency, including clock stopping caused by the WFI and WFE
> instructions.
> 
> Therefore, using smp_call_on_cpu() to trigger target CPU to
> read self's AMU counters, which ensures the counters are working
> properly during calculation.
> 
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> ---
>   drivers/cpufreq/cppc_cpufreq.c | 30 +++++++++++++++++++-----------
>   1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 022e3555407c..910167f58bb3 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -837,9 +837,24 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
>   	return (reference_perf * delta_delivered) / delta_reference;
>   }
>   
> +static int cppc_get_perf_ctrs_smp(void *val)
> +{
> +	int cpu = smp_processor_id();
> +	struct cppc_perf_fb_ctrs *fb_ctrs = val;
> +	int ret;
> +
> +	ret = cppc_get_perf_ctrs(cpu, fb_ctrs);
> +	if (ret)
> +		return ret;
> +
> +	udelay(2); /* 2usec delay between sampling */
> +
> +	return cppc_get_perf_ctrs(cpu, fb_ctrs + 1);
> +}
> +
>   static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>   {
> -	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
> +	struct cppc_perf_fb_ctrs fb_ctrs[2] = {0};
>   	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>   	struct cppc_cpudata *cpu_data = policy->driver_data;
>   	u64 delivered_perf;
> @@ -847,19 +862,12 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>   
>   	cpufreq_cpu_put(policy);
>   
> -	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
> -	if (ret)
> -		return ret;
> -
> -	udelay(2); /* 2usec delay between sampling */
> -
> -	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
> +	ret = smp_call_on_cpu(cpu, cppc_get_perf_ctrs_smp, fb_ctrs, 1);
>   	if (ret)
>   		return ret;
>   
> -	delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
> -					       &fb_ctrs_t1);
> -
> +	delivered_perf = cppc_perf_from_fbctrs(cpu_data, fb_ctrs,
> +					       fb_ctrs + 1);
>   	return cppc_cpufreq_perf_to_khz(cpu_data, delivered_perf);
>   }
>   
