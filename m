Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E03768C8E3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 22:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjBFVpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 16:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjBFVpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 16:45:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D792F9ECD;
        Mon,  6 Feb 2023 13:45:51 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675719949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PrYS8GaXkkLdus6u5BrPz0bpi5mFB5kYn4bxT6s+/fs=;
        b=4FmyqnElg2UCbR1VEsWCTRvNlskhF1nGQBPVW/wHOyK9vjIs06l4AyeprTGQR4QLDkQQFG
        aqC5nkXJJ8y8GfkWkKVa9Cr2+F5QRg4zUcKnmPXqDY5K8uYDRmcfM611KowwUyQPB4SMCh
        snX4f6E2tCJbS3u0dUMIFGsVABO2+hzcOxAO5povLiaD5oZorme37KUgl1+dtNGDCF4b5L
        cyJcV3ky+LtgftRxeDcmvyhKcVfG2YSnUlQJAixrK77tT8fB4tsvt1jT6L3y3tzIZw/xm1
        Y+yJxt4OtRvS6m145sLfTjK3hZjHk5wF0xI3O18OC3cYurCCj2V+va+GUOVDbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675719949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PrYS8GaXkkLdus6u5BrPz0bpi5mFB5kYn4bxT6s+/fs=;
        b=6PrCS8ocwxIompzADSwq3cubZlA/0J+AvOGDF0LHtY2x79m+a9Pn2niFMiScfOhvj6lWo5
        ZlPBNMi7cM8TvQBw==
To:     Song Liu <song@kernel.org>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     hch@lst.de, kernel-team@meta.com, Song Liu <song@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v9] module: replace module_layout with module_memory
In-Reply-To: <20230203214500.745276-1-song@kernel.org>
References: <20230203214500.745276-1-song@kernel.org>
Date:   Mon, 06 Feb 2023 22:45:48 +0100
Message-ID: <87cz6mxyb7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Song!

On Fri, Feb 03 2023 at 13:45, Song Liu wrote:
> diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
> index af7c322ebed6..9d4ecb6b1412 100644
> --- a/arch/arm/kernel/module-plts.c
> +++ b/arch/arm/kernel/module-plts.c
> @@ -30,7 +30,7 @@ static const u32 fixed_plts[] = {
>  
>  static bool in_init(const struct module *mod, unsigned long loc)
>  {
> -	return loc - (u32)mod->init_layout.base < mod->init_layout.size;
> +	return within_module_init(loc, mod);
>  }
>  
>  static void prealloc_fixed(struct mod_plt_sec *pltsec, struct plt_entries *plt)
> diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> index 5a0a8f552a61..4bf94de272cb 100644
> --- a/arch/arm64/kernel/module-plts.c
> +++ b/arch/arm64/kernel/module-plts.c
> @@ -67,7 +67,7 @@ static bool plt_entries_equal(const struct plt_entry *a,
>  
>  static bool in_init(const struct module *mod, void *loc)
>  {
> -	return (u64)loc - (u64)mod->init_layout.base < mod->init_layout.size;
> +	return within_module_init((unsigned long)loc, mod);
>  }

Wouldn't it make sense to get rid of these indirections in arm[64]
completely ?
  
>  struct mod_kallsyms {
> @@ -418,12 +448,8 @@ struct module {
>  	/* Startup function. */
>  	int (*init)(void);
>  
> -	/* Core layout: rbtree is accessed frequently, so keep together. */
> -	struct module_layout core_layout __module_layout_align;
> -	struct module_layout init_layout;
> -#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> -	struct module_layout data_layout;
> -#endif
> +	/* rbtree is accessed frequently, so keep together. */

I'm confused about the rbtree comment here.

> +	struct module_memory mem[MOD_MEM_NUM_TYPES] __module_memory_align;
>  
>  	/* Arch-specific module values */
>  	struct mod_arch_specific arch;
> @@ -573,23 +599,33 @@ bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr);
>  bool is_module_percpu_address(unsigned long addr);
>  bool is_module_text_address(unsigned long addr);
>  
> +static inline bool within_module_mem_type(unsigned long addr,
> +					  const struct module *mod,
> +					  enum mod_mem_type type)
> +{
> +	unsigned long base, size;
> +
> +	base = (unsigned long)mod->mem[type].base;
> +	size = mod->mem[type].size;
> +	return addr - base < size;
> +}
> +
>  static inline bool within_module_core(unsigned long addr,
>  				      const struct module *mod)
>  {
> -#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> -	if ((unsigned long)mod->data_layout.base <= addr &&
> -	    addr < (unsigned long)mod->data_layout.base + mod->data_layout.size)
> -		return true;
> -#endif
> -	return (unsigned long)mod->core_layout.base <= addr &&
> -	       addr < (unsigned long)mod->core_layout.base + mod->core_layout.size;
> +	for_class_mod_mem_type(type, core)
> +		if (within_module_mem_type(addr, mod, type))
> +			return true;

	for_class_mod_mem_type(type, core) {
		if (within_module_mem_type(addr, mod, type))
			return true;
	}

Please. It's not required by the language, but it makes the code simpler
to read. We omit the brackets when there is a true one-line statement
after the iterator() or condition().

> +static void free_mod_mem(struct module *mod)
> +{
> +	/* free the memory in the right order to avoid use-after-free */

How do we end up with a UAF when the ordering is different?

> +	static enum mod_mem_type mod_mem_free_order[MOD_MEM_NUM_TYPES] = {
> +		/* first free init sections */
> +		MOD_INIT_TEXT,
> +		MOD_INIT_DATA,
> +		MOD_INIT_RODATA,
> +
> +		/* then core sections, except rw data */
> +		MOD_TEXT,
> +		MOD_RODATA,
> +		MOD_RO_AFTER_INIT,
> +
> +		/* last, rw data */
> +		MOD_DATA,
> +	};

That's fragile when we ever add a new section type.

	static const enum mod_mem_type mod_mem_free_order[] = {
               ....
        };

        BUILD_BUG_ON(ARRAY_SIZE(mod_mem_free_order) != MOD_MEM_NUM_TYPES);

Hmm?

>  
>  static bool module_init_layout_section(const char *sname)
> @@ -1428,6 +1506,20 @@ static void layout_sections(struct module *mod, struct load_info *info)
>  		{ SHF_WRITE | SHF_ALLOC, ARCH_SHF_SMALL },
>  		{ ARCH_SHF_SMALL | SHF_ALLOC, 0 }
>  	};
> +	static int core_m_to_mem_type[] = {

const?

> +		MOD_TEXT,
> +		MOD_RODATA,
> +		MOD_RO_AFTER_INIT,
> +		MOD_DATA,
> +		MOD_INVALID,

What's the point of this MOD_INVALID here?

> +	};
> +	static int init_m_to_mem_type[] = {
> +		MOD_INIT_TEXT,
> +		MOD_INIT_RODATA,
> +		MOD_INVALID,
> +		MOD_INIT_DATA,
> +		MOD_INVALID,
> +	};
>  	unsigned int m, i;
>  
>  	for (i = 0; i < info->hdr->e_shnum; i++)
> @@ -1435,41 +1527,30 @@ static void layout_sections(struct module *mod, struct load_info *info)
>  
>  	pr_debug("Core section allocation order:\n");
>  	for (m = 0; m < ARRAY_SIZE(masks); ++m) {
> +		enum mod_mem_type type = core_m_to_mem_type[m];

Oh. This deals with ARRAY_SIZE(masks) being larger than the
*_to_mem_type[] ones. A comment on the *to_mem_type arrays would be
appreciated.

>  
>  	pr_debug("Init section allocation order:\n");
>  	for (m = 0; m < ARRAY_SIZE(masks); ++m) {
> +		enum mod_mem_type type = init_m_to_mem_type[m];
> +
>  		for (i = 0; i < info->hdr->e_shnum; ++i) {
>  			Elf_Shdr *s = &info->sechdrs[i];
>  			const char *sname = info->secstrings + s->sh_name;
> @@ -1479,30 +1560,13 @@ static void layout_sections(struct module *mod, struct load_info *info)
>  			    || s->sh_entsize != ~0UL
>  			    || !module_init_layout_section(sname))
>  				continue;
> -			s->sh_entsize = (module_get_offset(mod, &mod->init_layout.size, s, i)
> -					 | INIT_OFFSET_MASK);
> +
> +			if (WARN_ON_ONCE(type == MOD_INVALID))
> +				continue;
> +
> +			s->sh_entsize = module_get_offset_and_type(mod, type, s, i);
>  			pr_debug("\t%s\n", sname);

Now that the explicit layout members are gone the only difference
between the core and the init part aside of the seperate _to_mem_type[]
array is:

-  			    || module_init_layout_section(sname))
+  			    || !module_init_layout_section(sname))
                               continue;

Which means the loop can be moved into a separate function which takes
an @is_init argument which then selects the right _to_mem_type[] array
and tweaks the condition accordingly. Can be a follow up patch.

> +	for_each_mod_mem_type(type) {
> +		const struct module_memory *mod_mem = &mod->mem[type];
> +
> +		if (mod_mem->size)
> +			flush_icache_range((unsigned long)mod_mem->base,
> +					   (unsigned long)mod_mem->base + mod_mem->size);

Brackets here too, please                                   

> diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
> index 14fbea66f12f..2e79a77f40eb 100644
> --- a/kernel/module/strict_rwx.c
> +++ b/kernel/module/strict_rwx.c
> @@ -11,82 +11,26 @@
>  #include <linux/set_memory.h>
>  #include "internal.h"
>  
> -/*
> - * LKM RO/NX protection: protect module's text/ro-data
> - * from modification and any data from execution.
> - *
> - * General layout of module is:
> - *          [text] [read-only-data] [ro-after-init] [writable data]
> - * text_size -----^                ^               ^               ^
> - * ro_size ------------------------|               |               |
> - * ro_after_init_size -----------------------------|               |
> - * size -----------------------------------------------------------|
> - *
> - * These values are always page-aligned (as is base) when
> - * CONFIG_STRICT_MODULE_RWX is set.
> - */
> +static void module_set_memory(
> +	const struct module *mod, enum mod_mem_type type,
> +	int (*set_memory)(unsigned long start, int num_pages))

Please don't use this horrible formatting.

static void module_set_memory(const struct module *mod, enum mod_mem_type type,
                              int (*set_memory)(unsigned long start, int num_pages))

We lifted the 80 character limit long ago.

> +{
> +	const struct module_memory *mod_mem = &mod->mem[type];

Other than those nits, this looks great!

Thanks,

        tglx


