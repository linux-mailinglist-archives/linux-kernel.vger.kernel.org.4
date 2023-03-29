Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA0D6CD99E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjC2Mvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 08:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjC2Mvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:51:44 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2D11717
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 05:51:35 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1F5011EC03DB;
        Wed, 29 Mar 2023 14:51:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680094294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hEk4Arbx/UdsR4XZ5bKxBT3WkpYEHrm0dmE+Hs+We1w=;
        b=bEeBV4TC69qEzA9gUd4vyQwl97J/iKf01AV/KZFtjSHOq34LMmE5VQ/CcV3PyEmF11ZSA0
        vCDG8jgFluRBbMsxvNs+xmAIFBqqz3op22WFDsKgF4rWUo04ClhPzovbLQ4Q5UHiEvL6sQ
        KbLDl1wQjpk3cth7s9wuWSqcDFLauB4=
Date:   Wed, 29 Mar 2023 14:51:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 09/12] x86/mtrr: construct a memory map with cache
 modes
Message-ID: <20230329125128.GAZCQ0UJUj48VKdG//@fat_crate.local>
References: <20230306163425.8324-1-jgross@suse.com>
 <20230306163425.8324-10-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230306163425.8324-10-jgross@suse.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 05:34:22PM +0100, Juergen Gross wrote:
> +struct cache_map {
> +	u64 start;
> +	u64 end;
> +	u8 type;
> +	bool fixed;

Can those last two be a single

	u64 flags;

which contains the type and fixed and later perhaps other things so that we can
have those elements aligned and we don't waste space unnecessarily by having
a bool for a single bit of information?

> +};
> +
> +/*
> + * CACHE_MAP_MAX is the maximum number of memory ranges in cache_map, where
> + * no 2 adjacent ranges have the same cache mode (those would be merged).
> + * The number is based on the worst case:
> + * - no two adjacent fixed MTRRs share the same cache mode
> + * - one variable MTRR is spanning a huge area with mode WB
> + * - 255 variable MTRRs with mode UC all overlap with the WB MTRR, creating 2
> + *   additional ranges each (result like "ababababa...aba" with a = WB, b = UC),
> + *   accounting for MTRR_MAX_VAR_RANGES * 2 - 1 range entries
> + * - a TOM2 area (even with overlapping an UC MTRR can't add 2 range entries
> + *   to the possible maximum, as it always starts at 4GB, thus it can't be in
> + *   the middle of that MTRR, unless that MTRR starts at 0, which would remove
> + *   the initial "a" from the "abababa" pattern above)
> + * The map won't contain ranges with no matching MTRR (those fall back to the
> + * default cache mode).
> + */

Nice.

> +#define CACHE_MAP_MAX	(MTRR_NUM_FIXED_RANGES + MTRR_MAX_VAR_RANGES * 2)
> +
> +static struct cache_map init_cache_map[CACHE_MAP_MAX] __initdata;
> +static struct cache_map *cache_map __refdata = init_cache_map;
> +static unsigned int cache_map_size = CACHE_MAP_MAX;
> +static unsigned int cache_map_n;
> +static unsigned int cache_map_fixed;
> +
>  static unsigned long smp_changes_mask;
>  static int mtrr_state_set;
>  u64 mtrr_tom2;
> @@ -78,6 +109,20 @@ static u64 get_mtrr_size(u64 mask)
>  	return size;
>  }
>  
> +static u8 get_var_mtrr_state(unsigned int reg, u64 *start, u64 *size)
> +{
> +	struct mtrr_var_range *mtrr = mtrr_state.var_ranges + reg;
> +
> +	if (!(mtrr->mask_lo & (1 << 11)))

I'm guessing that's the

	MTRR Pair Enable

bit?

Use a macro with a proper name pls.

> +		return MTRR_TYPE_INVALID;
> +
> +	*start = (((u64)mtrr->base_hi) << 32) + (mtrr->base_lo & PAGE_MASK);
> +	*size = get_mtrr_size((((u64)mtrr->mask_hi) << 32) +
> +			      (mtrr->mask_lo & PAGE_MASK));
> +
> +	return mtrr->base_lo & 0xff;
> +}
> +
>  static u8 get_effective_type(u8 type1, u8 type2)
>  {
>  	if (type1 == MTRR_TYPE_UNCACHABLE || type2 == MTRR_TYPE_UNCACHABLE)
> @@ -241,6 +286,211 @@ static u8 mtrr_type_lookup_variable(u64 start, u64 end, u64 *partial_end,
>  	return mtrr_state.def_type;
>  }
>  
> +static void rm_map_entry_at(int idx)
> +{
> +	int i;
> +
> +	for (i = idx; i < cache_map_n - 1; i++)
> +		cache_map[i] = cache_map[i + 1];

That can be a memmove, I think. Something like

	memmove((void *)&cache_map[i],
		(void *)&cache_map[i + 1], 
		(cache_map_n - idx) * sizeof(struct cache_map));


> +
> +	cache_map_n--;
> +}
> +
> +/*
> + * Add an entry into cache_map at a specific index.
> + * Merges adjacent entries if appropriate.
> + * Return the number of merges for correcting the scan index.

Make that a block comment:

* Add an entry into cache_map at a specific index.  Merges adjacent entries if
* appropriate.  Return the number of merges for correcting the scan index.

vim, for example, has the cool "gq}" command for that.

> + */
> +static int add_map_entry_at(u64 start, u64 end, u8 type, int idx)
> +{
> +	bool merge_prev, merge_next;
> +	int i;
> +
> +	if (start >= end)
> +		return 0;
> +
> +	merge_prev = (idx > 0 && !cache_map[idx - 1].fixed &&
> +		      start == cache_map[idx - 1].end &&
> +		      type == cache_map[idx - 1].type);
> +	merge_next = (idx < cache_map_n && !cache_map[idx].fixed &&
> +		      end == cache_map[idx].start &&
> +		      type == cache_map[idx].type);

Uuh, head hurts. How about:

	bool merge_prev = false, merge_next = false;

	...

	if (idx > 0) {
		struct cache_map *prev = &cache_map[idx - 1];

		if (!prev->fixed &&
		     prev->end  == start &&
		     prev->type == type)
			merge_prev = true;
	}

Untested ofc, but you get the idea. It is a lot more readable this way. And the
same with merge_next.

> +
> +	if (merge_prev && merge_next) {
> +		cache_map[idx - 1].end = cache_map[idx].end;
> +		rm_map_entry_at(idx);
> +		return 2;
> +	}
> +	if (merge_prev) {
> +		cache_map[idx - 1].end = end;
> +		return 1;
> +	}
> +	if (merge_next) {
> +		cache_map[idx].start = start;
> +		return 1;
> +	}
> +
> +	/* Sanity check: the array should NEVER be too small! */
> +	if (cache_map_n == cache_map_size) {
> +		WARN(1, "MTRR cache mode memory map exhausted!\n");
> +		cache_map_n = cache_map_fixed;
> +		return 0;
> +	}
> +
> +	for (i = cache_map_n; i > idx; i--)
> +		cache_map[i] = cache_map[i - 1];

memmove as above.

> +
> +	cache_map[idx].start = start;
> +	cache_map[idx].end = end;
> +	cache_map[idx].type = type;
> +	cache_map[idx].fixed = false;
> +	cache_map_n++;
> +
> +	return 0;
> +}
> +
> +/* Clear a part of an entry. Return 1 if start of entry is still valid. */
> +static int clr_map_range_at(u64 start, u64 end, int idx)
> +{
> +	int ret = start != cache_map[idx].start;
> +	u64 tmp;
> +
> +	if (start == cache_map[idx].start && end == cache_map[idx].end) {
> +		rm_map_entry_at(idx);
> +	} else if (start == cache_map[idx].start) {
> +		cache_map[idx].start = end;
> +	} else if (end == cache_map[idx].end) {
> +		cache_map[idx].end = start;
> +	} else {
> +		tmp = cache_map[idx].end;
> +		cache_map[idx].end = start;
> +		add_map_entry_at(end, tmp, cache_map[idx].type, idx + 1);
> +	}
> +
> +	return ret;
> +}
> +
> +static void add_map_entry(u64 start, u64 end, u8 type)
> +{
> +	int i;
> +	u8 new_type, old_type;
> +	u64 tmp;

"int i;" goes here.

> +
> +	for (i = 0; i < cache_map_n && start < end; i++) {
> +		if (start >= cache_map[i].end)
> +			continue;
> +
> +		if (start < cache_map[i].start) {
> +			/* Region start has no overlap. */
> +			tmp = min(end, cache_map[i].start);
> +			i -= add_map_entry_at(start, tmp,  type, i);

Uff, what happens if i == 0 and becomes negative here?

Can that even happen?

This feels weird: using function retvals as index var decrements. I have
only a vague idea what you're doing in this function but it feels weird.
Maybe I need to play through an example to grok it better...

> +			start = tmp;
> +			continue;
> +		}
> +
> +		new_type = get_effective_type(type, cache_map[i].type);
> +		old_type = cache_map[i].type;
> +
> +		if (cache_map[i].fixed || new_type == old_type) {
> +			/* Cut off start of new entry. */
> +			start = cache_map[i].end;
> +			continue;
> +		}
> +
> +		tmp = min(end, cache_map[i].end);
> +		i += clr_map_range_at(start, tmp, i);
> +		i -= add_map_entry_at(start, tmp, new_type, i);
> +		start = tmp;
> +	}
> +
> +	add_map_entry_at(start, end, type, i);
> +}
> +
> +/* Add variable MTRRs to cache map. */
> +static void map_add_var(void)
> +{
> +	unsigned int i;
> +	u64 start, size;
> +	u8 type;
> +
> +	/* Add AMD magic MTRR. */

Why magic?

> +	if (mtrr_tom2) {
> +		add_map_entry(1ULL << 32, mtrr_tom2 - 1, MTRR_TYPE_WRBACK);

BIT_ULL(32)

> +		cache_map[cache_map_n - 1].fixed = true;
> +	}
> +
> +	for (i = 0; i < num_var_ranges; i++) {
> +		type = get_var_mtrr_state(i, &start, &size);
> +		if (type != MTRR_TYPE_INVALID)
> +			add_map_entry(start, start + size, type);
> +	}
> +}
> +
> +/* Rebuild map by replacing variable entries. */
> +static void rebuild_map(void)
> +{
> +	cache_map_n = cache_map_fixed;
> +
> +	map_add_var();
> +}
> +
> +/* Build the cache_map containing the cache modes per memory range. */
> +void mtrr_build_map(void)
> +{
> +	unsigned int i;
> +	u64 start, end, size;
> +	u8 type;
> +
> +	if (!mtrr_state.enabled)
> +		return;
> +
> +	/* Add fixed MTRRs, optimize for adjacent entries with same type. */
> +	if (mtrr_state.enabled & MTRR_STATE_MTRR_FIXED_ENABLED) {
> +		start = 0;
> +		end = size = 0x10000;
> +		type = mtrr_state.fixed_ranges[0];
> +
> +		for (i = 1; i < MTRR_NUM_FIXED_RANGES; i++) {
> +			if (i == 8 || i == 24)
> +				size >>= 2;
> +
> +			if (mtrr_state.fixed_ranges[i] != type) {
> +				add_map_entry(start, end, type);
> +				start = end;
> +				type = mtrr_state.fixed_ranges[i];
> +			}
> +			end += size;
> +		}
> +		add_map_entry(start, end, type);
> +	}
> +
> +	/* Mark fixed and magic MTRR as fixed, they take precedence. */
> +	for (i = 0; i < cache_map_n; i++)
> +		cache_map[i].fixed = true;
> +	cache_map_fixed = cache_map_n;
> +
> +	map_add_var();

I think it would be useful to issue some stats here:

	pr_info("MTRR map: ... size: ..., ... entries: ..., memory used: ....");

and so on so that we can get some feedback when that happens. We can always
drop it later but for the initial runs it would be prudent to have that.

> +/* Copy the cache_map from __initdata memory to dynamically allocated one. */
> +void __init mtrr_copy_map(void)
> +{
> +	unsigned int new_size = cache_map_fixed + 2 * num_var_ranges;
> +
> +	if (!mtrr_state.enabled || !new_size) {
> +		cache_map = NULL;
> +		return;
> +	}
> +
> +	mutex_lock(&mtrr_mutex);
> +
> +	cache_map = kcalloc(new_size, sizeof(*cache_map), GFP_KERNEL);
> +	memmove(cache_map, init_cache_map, cache_map_n * sizeof(*cache_map));
> +	cache_map_size = new_size;
> +
> +	mutex_unlock(&mtrr_mutex);
> +}
> +
>  /**
>   * mtrr_overwrite_state - set static MTRR state
>   *
> @@ -815,6 +1065,10 @@ static void generic_set_mtrr(unsigned int reg, unsigned long base,
>  
>  	cache_enable();
>  	local_irq_restore(flags);
> +
> +	/* On the first cpu rebuild the cache mode memory map. */

s/cpu/CPU/

> +	if (smp_processor_id() == cpumask_first(cpu_online_mask))

Why not in mtrr_bp_init()? That is the first CPU.

> +		rebuild_map();
>  }
>  
>  int generic_validate_add_page(unsigned long base, unsigned long size,
> diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
> index 50cd2287b6e1..1dbb9fdfd87b 100644
> --- a/arch/x86/kernel/cpu/mtrr/mtrr.c
> +++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
> @@ -65,7 +65,7 @@ static bool mtrr_enabled(void)
>  }
>  
>  unsigned int mtrr_usage_table[MTRR_MAX_VAR_RANGES];
> -static DEFINE_MUTEX(mtrr_mutex);
> +DEFINE_MUTEX(mtrr_mutex);
>  
>  u64 size_or_mask, size_and_mask;
>  
> @@ -668,6 +668,7 @@ void __init mtrr_bp_init(void)
>  		/* Software overwrite of MTRR state, only for generic case. */
>  		mtrr_calc_physbits(true);
>  		init_table();
> +		mtrr_build_map();
>  		pr_info("MTRRs set to read-only\n");
>  
>  		return;
> @@ -705,6 +706,7 @@ void __init mtrr_bp_init(void)
>  			if (get_mtrr_state()) {
>  				memory_caching_control |= CACHE_MTRR;
>  				changed_by_mtrr_cleanup = mtrr_cleanup(phys_addr);
> +				mtrr_build_map();
>  			} else {
>  				mtrr_if = NULL;
>  				why = "by BIOS";
> @@ -733,6 +735,8 @@ void mtrr_save_state(void)
>  
>  static int __init mtrr_init_finialize(void)
>  {
> +	mtrr_copy_map();

Move that...

> +
>  	if (!mtrr_enabled())
>  		return 0;

... here.

So yeah, I like the general direction but this is a complex patch. Lemme
add some printks to it in order to get a better idea of what happens.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
