Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A226FE464
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 21:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbjEJTJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 15:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbjEJTJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 15:09:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930D24203
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 12:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683745749; x=1715281749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OX6gA3T2IWk0qU+f+3B+ygKjVIhA9IRmzlWxPyfDCVM=;
  b=I0C2cNQI0UewZorR20L7P3z3ryF1c1Q4mjxkMXPZac308k5+ynGnu3iq
   HZvRyWvZ4bIdApJPx7KsD4KMEFukanVzol5UBvNrAVXyaaRBWCy5X+0Si
   cN0iJ6ClZGjda5puMxT3mDoUYYzVezjVmI+k8HKzu4u9M4qeAAFw308Y5
   OgD7uzgMG2VYBcdGHXHtctDcp+oCcVGoDB7FdyW/+7OUEIZ4eZ3DFXSuo
   6eImNuZ7+Nh00Qiid7sCJNPa2tyEysKIAVQi6YuljfnJORgay5NGPU0f6
   3SELEDtX+TmWWvTTANHboCf+QQtnBkKW9ljVPC9j+pttDNiq6mPcvdbs8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="339551384"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="339551384"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 12:09:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="730046070"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="730046070"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga008.jf.intel.com with ESMTP; 10 May 2023 12:09:08 -0700
Date:   Wed, 10 May 2023 12:12:07 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Radu Rendec <rrendec@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/3] cacheinfo: Add arch specific early level
 initializer
Message-ID: <20230510191207.GA18514@ranerica-svr.sc.intel.com>
References: <20230412185759.755408-1-rrendec@redhat.com>
 <20230412185759.755408-2-rrendec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412185759.755408-2-rrendec@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 02:57:57PM -0400, Radu Rendec wrote:
> This patch gives architecture specific code the ability to initialize
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
> Signed-off-by: Radu Rendec <rrendec@redhat.com>
> Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/base/cacheinfo.c  | 75 +++++++++++++++++++++++++++------------
>  include/linux/cacheinfo.h |  2 ++
>  2 files changed, 55 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index f3903d002819..d783896c8a1f 100644
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
> +		this_cpu_ci->early_ci_levels = true;
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
> +	if (per_cpu_cacheinfo(cpu) && !ci_cacheinfo(cpu)->early_ci_levels)
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
> +	ci_cacheinfo(cpu)->early_ci_levels = false;
> +
> +	if (cache_leaves(cpu) <= early_leaves)
> +		return 0;
> +

Hi,

I had posted a patchset[1] for x86 that initializes
ci_cacheinfo(cpu)->num_leaves during SMP boot.

This means that early_leaves and a late cache_leaves() are equal but
per_cpu_cacheinfo(cpu) is never allocated. Currently, x86 does not use
fetch_cache_info().

I think that we should check here that per_cpu_cacheinfo() has been allocated to
take care of the case in which early and late cache leaves remain the same:

-       if (cache_leaves(cpu) <= early_leaves)
+       if (cache_leaves(cpu) <= early_leaves && per_cpu_cacheinfo(cpu))

Otherwise, in v6.4-rc1 + [1] I observe a NULL pointer dereference from
last_level_cache_is_valid().

I can post a patch with this fix if it makes sense.

[1]. https://lore.kernel.org/all/20230424001956.21434-3-ricardo.neri-calderon@linux.intel.com/
