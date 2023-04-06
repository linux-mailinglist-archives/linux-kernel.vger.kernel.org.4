Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4256D9155
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 10:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbjDFIR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 04:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbjDFIRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:17:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 267FB119
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 01:17:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CD7C16F8;
        Thu,  6 Apr 2023 01:18:27 -0700 (PDT)
Received: from [192.168.1.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD3D33F762;
        Thu,  6 Apr 2023 01:17:40 -0700 (PDT)
Message-ID: <10dd6c41-b09b-624c-ba1b-183f4e879ff6@arm.com>
Date:   Thu, 6 Apr 2023 10:17:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/2] cacheinfo: Add arch specific early level
 initializer
Content-Language: en-US
To:     Radu Rendec <rrendec@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20230403231551.1090704-1-rrendec@redhat.com>
 <20230403231551.1090704-2-rrendec@redhat.com>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20230403231551.1090704-2-rrendec@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Radu,

On 4/4/23 01:15, Radu Rendec wrote:
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
>    the current CPU. In other words, a CPU cannot detect the cache depth
>    for any other CPU than itself.
> 
> Signed-off-by: Radu Rendec <rrendec@redhat.com>
> ---
>   drivers/base/cacheinfo.c  | 57 ++++++++++++++++++++++++++-------------
>   include/linux/cacheinfo.h |  2 ++
>   2 files changed, 40 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index f6573c335f4c..7f8ac0cb549f 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -398,6 +398,11 @@ static void free_cache_attributes(unsigned int cpu)
>   	cache_shared_cpu_map_remove(cpu);
>   }
>   
> +int __weak early_cache_level(unsigned int cpu)
> +{
> +	return -ENOENT;
> +}
> +
>   int __weak init_cache_level(unsigned int cpu)
>   {
>   	return -ENOENT;
> @@ -423,51 +428,65 @@ int allocate_cache_info(int cpu)
>   
>   int fetch_cache_info(unsigned int cpu)
>   {
> -	struct cpu_cacheinfo *this_cpu_ci;
> +	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
>   	unsigned int levels = 0, split_levels = 0;
>   	int ret;
>   
> -	if (acpi_disabled) {
> +	if (acpi_disabled)
>   		ret = init_of_cache_level(cpu);
> -		if (ret < 0)
> -			return ret;
> -	} else {
> +	else {

NIT: I think braces should be used in the first branch if they
are used in the second branch, cf. './scripts/checkpatch.pl --strict'

>   		ret = acpi_get_cache_info(cpu, &levels, &split_levels);
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
>   			return ret;
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
>   	}
> -	if (!cache_leaves(cpu))
> -		return -ENOENT;
>   
>   	return allocate_cache_info(cpu);
>   }
>   
>   int detect_cache_attributes(unsigned int cpu)
>   {
[start]
> +	unsigned int early_leaves = cache_leaves(cpu);
>   	int ret;
>   
>   	/* Since early initialization/allocation of the cacheinfo is allowed
>   	 * via fetch_cache_info() and this also gets called as CPU hotplug
>   	 * callbacks via cacheinfo_cpu_online, the init/alloc can be skipped
>   	 * as it will happen only once (the cacheinfo memory is never freed).
> -	 * Just populate the cacheinfo.
> +	 * Just populate the cacheinfo. However, if the cacheinfo has been
> +	 * allocated early through the arch-specific early_cache_level() call,
> +	 * there is a chance the info is wrong (this can happen on arm64). In
> +	 * that case, call init_cache_level() anyway to give the arch-specific
> +	 * code a chance to make things right.
>   	 */
> -	if (per_cpu_cacheinfo(cpu))
> +	if (per_cpu_cacheinfo(cpu) && !ci_cacheinfo(cpu)->early_arch_info)
>   		goto populate_leaves;
>   
>   	if (init_cache_level(cpu) || !cache_leaves(cpu))
>   		return -ENOENT;
>   
> +	if (cache_leaves(cpu) <= early_leaves)
> +		goto populate_leaves;
> +
> +	kfree(per_cpu_cacheinfo(cpu))>   	ret = allocate_cache_info(cpu);
>   	if (ret)
>   		return ret;
[stop]

Maybe this would be the occasion to put the code between the start/stop in a separate
function and remove the 'populate_leaves' label. The code seems correct, but it was
already a bit complex to read before the patch.


> diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
> index 908e19d17f49..c9d44308fc42 100644
> --- a/include/linux/cacheinfo.h
> +++ b/include/linux/cacheinfo.h
> @@ -76,9 +76,11 @@ struct cpu_cacheinfo {
>   	unsigned int num_levels;
>   	unsigned int num_leaves;
>   	bool cpu_map_populated;
> +	bool early_arch_info;
>   };
>   
>   struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu);
> +int early_cache_level(unsigned int cpu);
>   int init_cache_level(unsigned int cpu);
>   int init_of_cache_level(unsigned int cpu);
>   int populate_cache_leaves(unsigned int cpu);
