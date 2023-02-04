Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3477A68AABB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 15:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjBDO6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 09:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbjBDO6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 09:58:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08389305C1;
        Sat,  4 Feb 2023 06:58:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3175B80B1C;
        Sat,  4 Feb 2023 14:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005BBC433EF;
        Sat,  4 Feb 2023 14:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675522722;
        bh=obz7uiuDh/DOauLK8CVXZabOXHGwjUrwwwSUO1B6MDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RFjR1B66nj3HovHeeYFiJBHDZRuSTdbHxTYOHSI46bssLs7cNWC3/zi7amhz+eLMT
         hTF/a/luloul3jV6qc5350JotSn3tjb4zorwj70LgCECK8HQjp0TGQLvWCGTsHxPVL
         JiUMMgVmEINax67BU6KFLOJlIqwy5kzOEVrv9oFFZMxmNqoXvZSvIwUAOJBQOD+npS
         v4nil5KmMqYWMstCd+gWpgxhwgEfZp9ahtBGhBYdL8dz201eoRQ2zllIXWuO8m1S4o
         Gk0tqa4hT18kA/YXWUeKSIeIp1HL6x05Kanb5/8IqEC+E38GrGUVRvd/3M+Mrc9nfH
         VICSpBwWtgqqA==
Date:   Sat, 4 Feb 2023 20:28:34 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, swboyd@chromium.org,
        mka@chromium.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-hw: Fix cpufreq_driver->get() for non-LMH
 systems
Message-ID: <20230204145834.GA45501@thinkpad>
References: <20230202140005.1.I4b30aaa027c73372ec4068cc0f0dc665af8b938d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230202140005.1.I4b30aaa027c73372ec4068cc0f0dc665af8b938d@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 02:00:23PM -0800, Douglas Anderson wrote:
> On a sc7180-based Chromebook, when I go to
> /sys/devices/system/cpu/cpu0/cpufreq I can see:
> 
>   cpuinfo_cur_freq:2995200
>   cpuinfo_max_freq:1804800
>   scaling_available_frequencies:300000 576000 ... 1708800 1804800
>   scaling_cur_freq:1804800
>   scaling_max_freq:1804800
> 
> As you can see the `cpuinfo_cur_freq` is bogus. It turns out that this
> bogus info started showing up as of commit 205f5e984d30 ("cpufreq:
> qcom-hw: Fix the frequency returned by cpufreq_driver->get()"). That
> commit seems to assume that everyone is on the LMH bandwagon, but
> sc7180 isn't.
> 

Ah, missed that part.

> Let's go back to the old code in the case where LMH isn't used.
> 

Thanks for fixing!

> Fixes: 205f5e984d30 ("cpufreq: qcom-hw: Fix the frequency returned by cpufreq_driver->get()")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
> 
>  drivers/cpufreq/qcom-cpufreq-hw.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 9505a812d6a1..957cf6bb8c05 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -143,40 +143,42 @@ static unsigned long qcom_lmh_get_throttle_freq(struct qcom_cpufreq_data *data)
>  	return lval * xo_rate;
>  }
>  
> -/* Get the current frequency of the CPU (after throttling) */
> -static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
> +/* Get the frequency requested by the cpufreq core for the CPU */
> +static unsigned int qcom_cpufreq_get_freq(unsigned int cpu)
>  {
>  	struct qcom_cpufreq_data *data;
> +	const struct qcom_cpufreq_soc_data *soc_data;
>  	struct cpufreq_policy *policy;
> +	unsigned int index;
>  
>  	policy = cpufreq_cpu_get_raw(cpu);
>  	if (!policy)
>  		return 0;
>  
>  	data = policy->driver_data;
> +	soc_data = qcom_cpufreq.soc_data;
>  
> -	return qcom_lmh_get_throttle_freq(data) / HZ_PER_KHZ;
> +	index = readl_relaxed(data->base + soc_data->reg_perf_state);
> +	index = min(index, LUT_MAX_ENTRIES - 1);
> +
> +	return policy->freq_table[index].frequency;
>  }
>  
> -/* Get the frequency requested by the cpufreq core for the CPU */
> -static unsigned int qcom_cpufreq_get_freq(unsigned int cpu)
> +static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
>  {
>  	struct qcom_cpufreq_data *data;
> -	const struct qcom_cpufreq_soc_data *soc_data;
>  	struct cpufreq_policy *policy;
> -	unsigned int index;
>  
>  	policy = cpufreq_cpu_get_raw(cpu);
>  	if (!policy)
>  		return 0;
>  
>  	data = policy->driver_data;
> -	soc_data = qcom_cpufreq.soc_data;
>  
> -	index = readl_relaxed(data->base + soc_data->reg_perf_state);
> -	index = min(index, LUT_MAX_ENTRIES - 1);
> +	if (data->throttle_irq >= 0)
> +		return qcom_lmh_get_throttle_freq(data) / HZ_PER_KHZ;
>  
> -	return policy->freq_table[index].frequency;
> +	return qcom_cpufreq_get_freq(cpu);
>  }
>  
>  static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
> -- 
> 2.39.1.519.gcb327c4b5f-goog
> 

-- 
மணிவண்ணன் சதாசிவம்
