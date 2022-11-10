Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0BE624E46
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 00:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiKJXNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 18:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKJXNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 18:13:31 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C63E260D;
        Thu, 10 Nov 2022 15:13:27 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24A071FB;
        Thu, 10 Nov 2022 15:13:33 -0800 (PST)
Received: from [192.168.122.164] (U203867.austin.arm.com [10.118.30.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F08D3F73D;
        Thu, 10 Nov 2022 15:13:25 -0800 (PST)
Message-ID: <4717b687-895e-fec2-e792-3b5281d9ca77@arm.com>
Date:   Thu, 10 Nov 2022 17:13:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 4/5] ACPI: PPTT: Update acpi_find_last_cache_level() to
 acpi_get_cache_info()
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gavin Shan <gshan@redhat.com>, SeongJae Park <sj@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
References: <20221108110424.166896-1-pierre.gondois@arm.com>
 <20221108110424.166896-5-pierre.gondois@arm.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20221108110424.166896-5-pierre.gondois@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for fixing this!


Aside from one somewhat significant comment below this is all looks fine 
to me:

Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>


On 11/8/22 05:04, Pierre Gondois wrote:
> acpi_find_last_cache_level() allows to find the last level of cache
> for a given CPU. The function is only called on arm64 ACPI based
> platforms to check for cache information that would be missing in
> the CLIDR_EL1 register.
> To allow populating (struct cpu_cacheinfo).num_leaves by only parsing
> a PPTT, update acpi_find_last_cache_level() to get the 'split_levels',
> i.e. the number of cache levels being split in data/instruction
> caches.
> 
> It is assumed that there will not be data/instruction caches above a
> unified cache.
> If a split level consist of one data cache and no instruction cache
> (or opposite), then the missing cache will still be populated
> by default with minimal cache information, and maximal cpumask
> (all non-existing caches have the same fw_token).
> 
> Suggested-by: Jeremy Linton <jeremy.linton@arm.com>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>   arch/arm64/kernel/cacheinfo.c |  9 +++--
>   drivers/acpi/pptt.c           | 69 ++++++++++++++++++++++++-----------
>   include/linux/cacheinfo.h     |  8 ++--
>   3 files changed, 58 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
> index 97c42be71338..164255651d64 100644
> --- a/arch/arm64/kernel/cacheinfo.c
> +++ b/arch/arm64/kernel/cacheinfo.c
> @@ -46,7 +46,7 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
>   int init_cache_level(unsigned int cpu)
>   {
>   	unsigned int ctype, level, leaves;
> -	int fw_level;
> +	int fw_level, ret;
>   	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
>   
>   	for (level = 1, leaves = 0; level <= MAX_CACHE_LEVEL; level++) {
> @@ -61,8 +61,11 @@ int init_cache_level(unsigned int cpu)
>   
>   	if (acpi_disabled)
>   		fw_level = of_find_last_cache_level(cpu);
> -	else
> -		fw_level = acpi_find_last_cache_level(cpu);
> +	else {
> +		ret = acpi_get_cache_info(cpu, &fw_level, NULL);
> +		if (ret < 0)
> +			return ret;
> +	}
>   
>   	if (fw_level < 0)
>   		return fw_level;
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 97c1d33822d1..72a6ddc1c555 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -81,6 +81,7 @@ static inline bool acpi_pptt_match_type(int table_type, int type)
>    * acpi_pptt_walk_cache() - Attempt to find the requested acpi_pptt_cache
>    * @table_hdr: Pointer to the head of the PPTT table
>    * @local_level: passed res reflects this cache level
> + * @split_levels: Number of split cache levels (data/instruction).
>    * @res: cache resource in the PPTT we want to walk
>    * @found: returns a pointer to the requested level if found
>    * @level: the requested cache level
> @@ -100,6 +101,7 @@ static inline bool acpi_pptt_match_type(int table_type, int type)
>    */
>   static unsigned int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
>   					 unsigned int local_level,
> +					 unsigned int *split_levels,
>   					 struct acpi_subtable_header *res,
>   					 struct acpi_pptt_cache **found,
>   					 unsigned int level, int type)
> @@ -113,6 +115,12 @@ static unsigned int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
>   	while (cache) {
>   		local_level++;
>   
> +		if (split_levels && (acpi_pptt_match_type(cache->attributes,
> +				ACPI_PPTT_CACHE_TYPE_DATA) ||
> +				acpi_pptt_match_type(cache->attributes,
> +				ACPI_PPTT_CACHE_TYPE_INSTR)))
> +			*split_levels = local_level;
> +

I think for maximum defense/spec compliance you need to validate the 
CACHE_TYPE_VALID flag before checking this. As its done in the next line 
too, it might be cleaner to consolidate the two checks.

>   		if (local_level == level &&
>   		    cache->flags & ACPI_PPTT_CACHE_TYPE_VALID &&
>   		    acpi_pptt_match_type(cache->attributes, type)) {
> @@ -135,8 +143,8 @@ static unsigned int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
>   static struct acpi_pptt_cache *
>   acpi_find_cache_level(struct acpi_table_header *table_hdr,
>   		      struct acpi_pptt_processor *cpu_node,
> -		      unsigned int *starting_level, unsigned int level,
> -		      int type)
> +		      unsigned int *starting_level, unsigned int *split_levels,
> +		      unsigned int level, int type)
>   {
>   	struct acpi_subtable_header *res;
>   	unsigned int number_of_levels = *starting_level;
> @@ -149,7 +157,8 @@ acpi_find_cache_level(struct acpi_table_header *table_hdr,
>   		resource++;
>   
>   		local_level = acpi_pptt_walk_cache(table_hdr, *starting_level,
> -						   res, &ret, level, type);
> +						   split_levels, res, &ret,
> +						   level, type);
>   		/*
>   		 * we are looking for the max depth. Since its potentially
>   		 * possible for a given node to have resources with differing
> @@ -165,29 +174,33 @@ acpi_find_cache_level(struct acpi_table_header *table_hdr,
>   }
>   
>   /**
> - * acpi_count_levels() - Given a PPTT table, and a CPU node, count the caches
> + * acpi_count_levels() - Given a PPTT table, and a CPU node, count the cache
> + * levels and split cache levels (data/instruction).
>    * @table_hdr: Pointer to the head of the PPTT table
>    * @cpu_node: processor node we wish to count caches for
> + * @levels: Number of levels if success.
> + * @split_levels: Number of split cache levels (data/instruction) if success.
> + * Can by NULL.
nitpick: I think usually you want to indent/align multiple line argument 
comments so its clear your talking about the argument.

See: 
https://elixir.bootlin.com/linux/v6.1-rc4/source/Documentation/doc-guide/kernel-doc.rst#L107

>    *
>    * Given a processor node containing a processing unit, walk into it and count
>    * how many levels exist solely for it, and then walk up each level until we hit
>    * the root node (ignore the package level because it may be possible to have
> - * caches that exist across packages). Count the number of cache levels that
> - * exist at each level on the way up.
> + * caches that exist across packages). Count the number of cache levels and
> + * split cache levels (data/instruction) that exist at each level on the way
> + * up.
>    *
> - * Return: Total number of levels found.
> + * Return: 0 on success.
>    */
>   static int acpi_count_levels(struct acpi_table_header *table_hdr,
> -			     struct acpi_pptt_processor *cpu_node)
> +				struct acpi_pptt_processor *cpu_node,
> +				unsigned int *levels, unsigned int *split_levels)
>   {
> -	int total_levels = 0;
> - >   	do {
> -		acpi_find_cache_level(table_hdr, cpu_node, &total_levels, 0, 0);
> +		acpi_find_cache_level(table_hdr, cpu_node, levels, split_levels, 0, 0);
>   		cpu_node = fetch_pptt_node(table_hdr, cpu_node->parent);
>   	} while (cpu_node);
>   
> -	return total_levels;
> +	return 0;
>   }
another nitpick: You might consider just making this "void" if the 
return value is always 0, and not checked later.
>   
>   /**
> @@ -321,7 +334,7 @@ static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *ta
>   
>   	while (cpu_node && !found) {
>   		found = acpi_find_cache_level(table_hdr, cpu_node,
> -					      &total_levels, level, acpi_type);
> +					      &total_levels, NULL, level, acpi_type);
>   		*node = cpu_node;
>   		cpu_node = fetch_pptt_node(table_hdr, cpu_node->parent);
>   	}
> @@ -589,36 +602,48 @@ static int check_acpi_cpu_flag(unsigned int cpu, int rev, u32 flag)
>   }
>   
>   /**
> - * acpi_find_last_cache_level() - Determines the number of cache levels for a PE
> + * acpi_get_cache_info() - Determine the number of cache levels and
> + * split cache levels (data/instruction) and for a PE.
>    * @cpu: Kernel logical CPU number
> + * @levels: Number of levels if success.
> + * @split_levels: Number of levels being split (i.e. data/instruction)
> + * if success. Can by NULL.nitpick: same as above
>    *
>    * Given a logical CPU number, returns the number of levels of cache represented
>    * in the PPTT. Errors caused by lack of a PPTT table, or otherwise, return 0
>    * indicating we didn't find any cache levels.
>    *
> - * Return: Cache levels visible to this core.
> + * Return: -ENOENT if no PPTT table or no PPTT processor struct found.
> + *	   0 on success.
>    */
> -int acpi_find_last_cache_level(unsigned int cpu)
> +int acpi_get_cache_info(unsigned int cpu, unsigned int *levels,
> +				unsigned int *split_levels)
>   {
>   	struct acpi_pptt_processor *cpu_node;
>   	struct acpi_table_header *table;
> -	int number_of_levels = 0;
>   	u32 acpi_cpu_id;
>   
> +	*levels = 0;
> +	if (split_levels)
> +		*split_levels = 0;
> +
>   	table = acpi_get_pptt();
>   	if (!table)
>   		return -ENOENT;
>   
> -	pr_debug("Cache Setup find last level CPU=%d\n", cpu);
> +	pr_debug("Cache Setup: find cache levels for CPU=%d\n", cpu);
>   
>   	acpi_cpu_id = get_acpi_id_for_cpu(cpu);
>   	cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
> -	if (cpu_node)
> -		number_of_levels = acpi_count_levels(table, cpu_node);
> +	if (!cpu_node)
> +		return -ENOENT;
>   
> -	pr_debug("Cache Setup find last level level=%d\n", number_of_levels);
> +	acpi_count_levels(table, cpu_node, levels, split_levels);
>   
> -	return number_of_levels;
> +	pr_debug("Cache Setup: last_level=%d split_levels=%d\n",
> +			*levels, split_levels ? *split_levels : -1);
> +
> +	return 0;
>   }
>   
>   /**
> diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
> index ff0328f3fbb0..f992d81d211f 100644
> --- a/include/linux/cacheinfo.h
> +++ b/include/linux/cacheinfo.h
> @@ -88,19 +88,21 @@ bool last_level_cache_is_shared(unsigned int cpu_x, unsigned int cpu_y);
>   int detect_cache_attributes(unsigned int cpu);
>   #ifndef CONFIG_ACPI_PPTT
>   /*
> - * acpi_find_last_cache_level is only called on ACPI enabled
> + * acpi_get_cache_info() is only called on ACPI enabled
>    * platforms using the PPTT for topology. This means that if
>    * the platform supports other firmware configuration methods
>    * we need to stub out the call when ACPI is disabled.
>    * ACPI enabled platforms not using PPTT won't be making calls
>    * to this function so we need not worry about them.
>    */
> -static inline int acpi_find_last_cache_level(unsigned int cpu)
> +static inline int acpi_get_cache_info(unsigned int cpu,
> +			unsigned int *levels, unsigned int *split_levels)
>   {
>   	return 0;
>   }
>   #else
> -int acpi_find_last_cache_level(unsigned int cpu);
> +int acpi_get_cache_info(unsigned int cpu,
> +			unsigned int *levels, unsigned int *split_levels);

And as a final comment your free to ignore: It might reduce some patch 
churn to just add split_levels and leave the return behavior alone.

>   #endif
>   
>   const struct attribute_group *cache_get_priv_group(struct cacheinfo *this_leaf);

