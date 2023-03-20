Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2436C1D5F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjCTRKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjCTRJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:09:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AC2305F6;
        Mon, 20 Mar 2023 10:04:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6FB611F385;
        Mon, 20 Mar 2023 17:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679331809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0fyr8p7XacBHCbP6ZboYSoI97hM17lvHrWNbAot/zZs=;
        b=oTbKJMuvPJuAH+d9SQzvO7PccfF6om8HrWAWIWbsOwLZhxSOxoA5F+K3aFHNK9gc692afB
        LUqHzR2mfEbsn24pI9sjkKI7DuEjNLDyyUkdGD84nMiKxchqCp0LJZgFTzy955g9IzOI1T
        CvApNAkVT13YN52UV0zbTagA5BDGquU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679331809;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0fyr8p7XacBHCbP6ZboYSoI97hM17lvHrWNbAot/zZs=;
        b=AjOjiul+GlM+f5R63FQxqm0SOQgXGr+c91wJP/vbt6F4ZYUV08+GlcHHW7ktlkhtRN7JmU
        Pazy9Dog/mFv9FCA==
Received: from [10.163.29.78] (unknown [10.163.29.78])
        by relay2.suse.de (Postfix) with ESMTP id 22C022C141;
        Mon, 20 Mar 2023 17:03:28 +0000 (UTC)
Message-ID: <70119ad043502390100e66dbbe658aa069b86e45.camel@suse.cz>
Subject: Re: [PATCH] cpufreq: intel_pstate: Enable HWP IO boost for all
 servers
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org, lenb@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 20 Mar 2023 18:03:26 +0100
In-Reply-To: <20230303041411.3161780-1-srinivas.pandruvada@linux.intel.com>
References: <20230303041411.3161780-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-03-02 at 20:14 -0800, Srinivas Pandruvada wrote:
> The HWP IO boost results in slight improvements for IO performance on
> both Ice Lake and Sapphire Rapid servers.
> 
> Currently there is a CPU model check for Skylake desktop and server along
> with the ACPI PM profile for performance and enterprise servers to enable
> IO boost.
> 
> Remove the CPU model check, so that all current server models enable HWP
> IO boost by default.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index cb4beec27555..8edbc0856892 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2384,12 +2384,6 @@ static const struct x86_cpu_id intel_pstate_cpu_ee_disable_ids[] = {
>  	{}
>  };
>  
> -static const struct x86_cpu_id intel_pstate_hwp_boost_ids[] = {
> -	X86_MATCH(SKYLAKE_X,		core_funcs),
> -	X86_MATCH(SKYLAKE,		core_funcs),
> -	{}
> -};
> -
>  static int intel_pstate_init_cpu(unsigned int cpunum)
>  {
>  	struct cpudata *cpu;
> @@ -2408,12 +2402,9 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
>  		cpu->epp_default = -EINVAL;
>  
>  		if (hwp_active) {
> -			const struct x86_cpu_id *id;
> -
>  			intel_pstate_hwp_enable(cpu);
>  
> -			id = x86_match_cpu(intel_pstate_hwp_boost_ids);
> -			if (id && intel_pstate_acpi_pm_profile_server())
> +			if (intel_pstate_acpi_pm_profile_server())
>  				hwp_boost = true;
>  		}
>  	} else if (hwp_active) {

Hello Srinivas,

Good catch. We've had HWP IO Boost in the kernel for a while now but we
weren't enabling on most of the modern CPUs... This fixes it.

One thing though: I've the impression that HWP IO Boost depends on having
per-core p-states -- otherwise you'll be boosting up and down the entire machine
instead of just the one core waking up from IO.
Enabling the feature on all machines with the ACPI PM server profile would
force it also where per-core p-states aren't available.

Would you agree with this assessment?
Do I correctly understand the reason why per-core p-states are needed here?

I remember you mentioned the the dependency on per-core p-states in the cover
letter from the HWP IO Boost submission in 2018
https://lore.kernel.org/lkml/20180605214242.62156-1-srinivas.pandruvada@linux.intel.com/

I think there's a tradeoff here. Up until this patch, we forgot to enable the
feature on four generations of Intel CPUs. That's a lot of lost performance;
thanks to this patch it won't happen ever again, because nobody will have to
update the model list at every new CPU release.

On the other side, there may be some penalty for machines that:
- have HWP
- don't have per-core p-states
I don't know how large that interesection is, or how big the penalty.


Giovanni

