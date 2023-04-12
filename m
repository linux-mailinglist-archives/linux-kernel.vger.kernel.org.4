Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027836DF3E0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjDLLjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjDLLim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:38:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3ADC283DC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:38:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CF9AD75;
        Wed, 12 Apr 2023 04:38:27 -0700 (PDT)
Received: from bogus (unknown [10.57.57.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 878F43F73F;
        Wed, 12 Apr 2023 04:37:41 -0700 (PDT)
Date:   Wed, 12 Apr 2023 12:36:38 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Radu Rendec <rrendec@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] cacheinfo: Add arch specific early level
 initializer
Message-ID: <20230412113638.p3pkmd46luml2nlr@bogus>
References: <20230406233926.1670094-1-rrendec@redhat.com>
 <20230406233926.1670094-2-rrendec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230406233926.1670094-2-rrendec@redhat.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 07:39:25PM -0400, Radu Rendec wrote:
> This patch gives of architecture specific code the ability to initialize
> the cache level and allocate cacheinfo memory early, when cache level
> initialization runs on the primary CPU for all possible CPUs.
> 
> This is part of a patch series that attempts to further the work in
> commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU").
> Previously, in the absence of any DT/ACPI cache info, architecture
> specific cache detection and info allocation for secondary CPUs would
> happen in non-preemptible context during early CPU initialization and
> trigger a "BUG: sleeping function called from invalid context" splat on
> an RT kernel.
> 
> More specifically, this patch adds the early_cache_level() function,
> which is called by fetch_cache_info() as a fallback when the number of
> cache leaves cannot be extracted from DT/ACPI. In the default generic
> (weak) implementation, this new function returns -ENOENT, which
> preserves the original behavior for architectures that do not implement
> the function.
> 
> Since early detection can get the number of cache leaves wrong in some
> cases*, additional logic is added to still call init_cache_level() later
> on the secondary CPU, therefore giving the architecture specific code an
> opportunity to go back and fix the initial guess. Again, the original
> behavior is preserved for architectures that do not implement the new
> function.
> 
> * For example, on arm64, CLIDR_EL1 detection works only when it runs on
>   the current CPU. In other words, a CPU cannot detect the cache depth
>   for any other CPU than itself.
>

Thanks for the detailed description and putting this together.

> Signed-off-by: Radu Rendec <rrendec@redhat.com>
> ---
>  drivers/base/cacheinfo.c  | 75 +++++++++++++++++++++++++++------------
>  include/linux/cacheinfo.h |  2 ++
>  2 files changed, 55 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index f6573c335f4c..30f5553d3ebb 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -398,6 +398,11 @@ static void free_cache_attributes(unsigned int cpu)
>  	cache_shared_cpu_map_remove(cpu);
>  }
>  
> +int __weak early_cache_level(unsigned int cpu)
> +{
> +	return -ENOENT;
> +}
> +
>  int __weak init_cache_level(unsigned int cpu)
>  {
>  	return -ENOENT;
> @@ -423,56 +428,82 @@ int allocate_cache_info(int cpu)
>  
>  int fetch_cache_info(unsigned int cpu)
>  {
> -	struct cpu_cacheinfo *this_cpu_ci;
> +	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
>  	unsigned int levels = 0, split_levels = 0;
>  	int ret;
>  
>  	if (acpi_disabled) {
>  		ret = init_of_cache_level(cpu);
> -		if (ret < 0)
> -			return ret;
>  	} else {
>  		ret = acpi_get_cache_info(cpu, &levels, &split_levels);
> -		if (ret < 0)
> +		if (!ret) {
> +			this_cpu_ci->num_levels = levels;
> +			/*
> +			 * This assumes that:
> +			 * - there cannot be any split caches (data/instruction)
> +			 *   above a unified cache
> +			 * - data/instruction caches come by pair
> +			 */
> +			this_cpu_ci->num_leaves = levels + split_levels;
> +		}
> +	}
> +
> +	if (ret || !cache_leaves(cpu)) {
> +		ret = early_cache_level(cpu);
> +		if (ret)
>  			return ret;
>  
> -		this_cpu_ci = get_cpu_cacheinfo(cpu);
> -		this_cpu_ci->num_levels = levels;
> -		/*
> -		 * This assumes that:
> -		 * - there cannot be any split caches (data/instruction)
> -		 *   above a unified cache
> -		 * - data/instruction caches come by pair
> -		 */
> -		this_cpu_ci->num_leaves = levels + split_levels;
> +		if (!cache_leaves(cpu))
> +			return -ENOENT;
> +
> +		this_cpu_ci->early_arch_info = true;
>  	}
> -	if (!cache_leaves(cpu))
> -		return -ENOENT;
>  
>  	return allocate_cache_info(cpu);
>  }
>  
> -int detect_cache_attributes(unsigned int cpu)
> +static inline int init_level_allocate_ci(unsigned int cpu)
>  {
> -	int ret;
> +	unsigned int early_leaves = cache_leaves(cpu);
>  
>  	/* Since early initialization/allocation of the cacheinfo is allowed
>  	 * via fetch_cache_info() and this also gets called as CPU hotplug
>  	 * callbacks via cacheinfo_cpu_online, the init/alloc can be skipped
>  	 * as it will happen only once (the cacheinfo memory is never freed).
> -	 * Just populate the cacheinfo.
> +	 * Just populate the cacheinfo. However, if the cacheinfo has been
> +	 * allocated early through the arch-specific early_cache_level() call,
> +	 * there is a chance the info is wrong (this can happen on arm64). In
> +	 * that case, call init_cache_level() anyway to give the arch-specific
> +	 * code a chance to make things right.
>  	 */
> -	if (per_cpu_cacheinfo(cpu))
> -		goto populate_leaves;
> +	if (per_cpu_cacheinfo(cpu) && !ci_cacheinfo(cpu)->early_arch_info)
> +		return 0;
>  
>  	if (init_cache_level(cpu) || !cache_leaves(cpu))
>  		return -ENOENT;
>  
> -	ret = allocate_cache_info(cpu);
> +	/*
> +	 * Now that we have properly initialized the cache level info, make
> +	 * sure we don't try to do that again the next time we are called
> +	 * (e.g. as CPU hotplug callbacks).
> +	 */
> +	ci_cacheinfo(cpu)->early_arch_info = false;

I am wondering if it makes sense to rename this as early_ci_levels or
something similar to indicate it is to do with just level information only ?
If not, it needs to be documented if the variable is not more specific.
I am sure I will forget it and will be wondering to understand in few
months time 😄.

Other than that, it looks good. I will try to push this for v6.4 but it
may be bit late as it is good to have it in -next for sometime to get more
testing. Anyways send v4, will put it into -next ASAP and see what is the
best course of action after that.

--
Regards,
Sudeep
