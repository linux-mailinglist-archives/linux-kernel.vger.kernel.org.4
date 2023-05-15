Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED58702A7A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241006AbjEOKbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjEOKbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:31:36 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D69BE75;
        Mon, 15 May 2023 03:31:35 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QKbBv6gt1zTkMW;
        Mon, 15 May 2023 18:26:47 +0800 (CST)
Received: from [10.174.179.211] (10.174.179.211) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 15 May 2023 18:31:32 +0800
Message-ID: <fb86128f-2134-61d2-f34b-1b610e3f406d@huawei.com>
Date:   Mon, 15 May 2023 18:31:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] cpufreq: CPPC: keep target core awake when reading
 its cpufreq rate
To:     Zeng Heng <zengheng4@huawei.com>
CC:     <weiyongjun1@huawei.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xiexiuqi@huawei.com>,
        <linux-acpi@vger.kernel.org>, <wangxiongfeng2@huawei.com>,
        <lenb@kernel.org>, <viresh.kumar@linaro.org>, <rafael@kernel.org>
References: <20230515100005.3540793-1-zengheng4@huawei.com>
From:   "liwei (GF)" <liwei391@huawei.com>
In-Reply-To: <20230515100005.3540793-1-zengheng4@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.211]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/15 18:00, Zeng Heng wrote:
> As ARM AMU's document says, all counters are subject to any changes
> in clock frequency, including clock stopping caused by the WFI and WFE
> instructions.
> 
> Therefore, using smp_call_function_single() to trigger target CPU to
> read self's AMU counters, which ensures the counters are working
> properly during calculation.
> 
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 022e3555407c..169af7ff9a2a 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -837,29 +837,31 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
>  	return (reference_perf * delta_delivered) / delta_reference;
>  }
>  
> +static void cppc_get_perf_ctrs_smp(void *val)
> +{
> +	int cpu = smp_processor_id();
> +	struct cppc_perf_fb_ctrs *fb_ctrs = val;
> +
> +	cppc_get_perf_ctrs(cpu, fb_ctrs);
> +
> +	udelay(2); /* 2usec delay between sampling */
> +
> +	cppc_get_perf_ctrs(cpu, fb_ctrs + 1);
> +}
> +
>  static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>  {
> -	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
> +	struct cppc_perf_fb_ctrs fb_ctrs[2] = {0};
>  	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>  	struct cppc_cpudata *cpu_data = policy->driver_data;
>  	u64 delivered_perf;
> -	int ret;
>  
>  	cpufreq_cpu_put(policy);
>  
> -	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
> -	if (ret)
> -		return ret;
> -
> -	udelay(2); /* 2usec delay between sampling */
> -
> -	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
> -	if (ret)
> -		return ret;
> -
> -	delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
> -					       &fb_ctrs_t1);
> +	smp_call_function_single(cpu, cppc_get_perf_ctrs_smp, fb_ctrs, 1);

cppc_get_perf_ctrs() may call down_write(), while the callback for smp_call_function_single()
should be non-blocking, you can use smp_call_on_cpu() instead.

>  
> +	delivered_perf = cppc_perf_from_fbctrs(cpu_data, fb_ctrs,
> +					       fb_ctrs + 1);
>  	return cppc_cpufreq_perf_to_khz(cpu_data, delivered_perf);
>  }
>  
