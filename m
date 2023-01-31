Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAB868285D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjAaJNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjAaJMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:12:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B4B39CED;
        Tue, 31 Jan 2023 01:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=boxYZ+12IlPevIZLaNuVS7R9UduJnfXiG2COFROhDOM=; b=URFG+830GlCYuXxrigWLa5eSRm
        Wfyg+c6RbHZexvL2+63NnnLxUTz/bXpgHAi3L7lvl6hK02QkGjLkE77xL3I4Ph904snVEsTSXFgAD
        VbznkxNdIk45ysmQ+j+w//xSYA8BvZUsxBldrLNWLD94GCYVpVynEfkEHyPU0WgXyyWZkT1vwcKah
        j3sUdefftVpakorR9CxlUQ/3QFhV+7u5RI8wXhsG4qy4o1MAiEI/zU+qTi/u+jDKaZZPXLcqHUEt7
        GKQbnJLofVrslrI2n9ErZGqWdQ5tBvHOwrCmJa+QmzrcYAaRVv0cpp9Oho/BjlnjrTMX7z+n5/nXD
        DLMWyt8A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMmdf-00BAvd-VL; Tue, 31 Jan 2023 09:09:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 91EC83002BF;
        Tue, 31 Jan 2023 10:09:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4FF71208358FD; Tue, 31 Jan 2023 10:09:15 +0100 (CET)
Date:   Tue, 31 Jan 2023 10:09:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <song@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, kernel-team@meta.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v4] module: replace module_layout with module_memory
Message-ID: <Y9jau76YwdCElzZ0@hirez.programming.kicks-ass.net>
References: <20230130182109.3571524-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130182109.3571524-1-song@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I'm seeing a lot of the same code repeated over and over..

On Mon, Jan 30, 2023 at 10:21:09AM -0800, Song Liu wrote:
> diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
> index af7c322ebed6..17fd0978aee8 100644
> --- a/arch/arm/kernel/module-plts.c
> +++ b/arch/arm/kernel/module-plts.c
> @@ -30,7 +30,10 @@ static const u32 fixed_plts[] = {
>  
>  static bool in_init(const struct module *mod, unsigned long loc)
>  {
> -	return loc - (u32)mod->init_layout.base < mod->init_layout.size;
> +	const struct module_memory *mod_mem;
> +
> +	mod_mem = &mod->mem[MOD_INIT_TEXT];
> +	return loc - (u32)mod_mem->base < mod_mem->size;
>  }

within_module_mem_type(loc, mod, MOD_INIT_TEXT)

>  
>  static void prealloc_fixed(struct mod_plt_sec *pltsec, struct plt_entries *plt)
> diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> index 5a0a8f552a61..2f9f672a7cbb 100644
> --- a/arch/arm64/kernel/module-plts.c
> +++ b/arch/arm64/kernel/module-plts.c
> @@ -67,7 +67,10 @@ static bool plt_entries_equal(const struct plt_entry *a,
>  
>  static bool in_init(const struct module *mod, void *loc)
>  {
> -	return (u64)loc - (u64)mod->init_layout.base < mod->init_layout.size;
> +	const struct module_memory *mod_mem;
> +
> +	mod_mem = &mod->mem[MOD_INIT_TEXT];
> +	return (u64)loc - (u64)mod_mem->base < mod_mem->size;
>  }
>  

within_module_mem_type((unsigned long)loc, mod, MOD_INIT_TEXT)

>  u64 module_emit_plt_entry(struct module *mod, Elf64_Shdr *sechdrs,
> diff --git a/arch/ia64/kernel/module.c b/arch/ia64/kernel/module.c
> index 8f62cf97f691..4268ddb54a33 100644
> --- a/arch/ia64/kernel/module.c
> +++ b/arch/ia64/kernel/module.c
> @@ -485,19 +485,25 @@ module_frob_arch_sections (Elf_Ehdr *ehdr, Elf_Shdr *sechdrs, char *secstrings,
>  	return 0;
>  }
>  
> -static inline int
> +static inline bool
>  in_init (const struct module *mod, uint64_t addr)
>  {
> -	return addr - (uint64_t) mod->init_layout.base < mod->init_layout.size;
> +	const struct module_memory *mod_mem;
> +
> +	mod_mem = &mod->mem[MOD_INIT_TEXT];
> +	return addr - (uint64_t)mod_mem->base < mod_mem->size;
>  }

within_module_mem_type(loc, mod, MOD_INIT_TEXT)

> -static inline int
> +static inline bool
>  in_core (const struct module *mod, uint64_t addr)
>  {
> -	return addr - (uint64_t) mod->core_layout.base < mod->core_layout.size;
> +	const struct module_memory *mod_mem;
> +
> +	mod_mem = &mod->mem[MOD_TEXT];
> +	return addr - (uint64_t)mod_mem->base < mod_mem->size;
>  }
>  

within_module_mem_type(loc, mod, MOD_TEXT)

> diff --git a/arch/parisc/kernel/module.c b/arch/parisc/kernel/module.c
> index 7df140545b22..e052a5fdd51b 100644
> --- a/arch/parisc/kernel/module.c
> +++ b/arch/parisc/kernel/module.c
> @@ -76,23 +76,18 @@
>   * allows us to allocate up to 4095 GOT entries. */
>  #define MAX_GOTS	4095
>  
> +static inline bool in_local(struct module *me, void *loc)
>  {
> +	enum mod_mem_type type;
>  
> +	for (type = MOD_TEXT; type < MOD_MEM_NUM_TYPES; type++) {
> +		struct module_memory *mod_mem = &me->mem[type];
>  
> +		if (loc >= mod_mem->base &&
> +		    loc <= (mod_mem->base + mod_mem->size))
> +			return true;
> +	}
> +	return false;
>  }

(see below)

within_module_mem_types((unsigned long)loc, me, MOD_TEXT, MOD_INIT_RODATA);

>  
>  #ifndef CONFIG_64BIT

> diff --git a/include/linux/module.h b/include/linux/module.h
> index 8c5909c0076c..61b7cff632f9 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -320,17 +320,22 @@ struct mod_tree_node {
>  	struct latch_tree_node node;
>  };
>  
> -struct module_layout {
> -	/* The actual code + data. */
> +enum mod_mem_type {
> +	MOD_TEXT,
> +	MOD_DATA,
> +	MOD_RODATA,
> +	MOD_RO_AFTER_INIT,
> +	MOD_INIT_TEXT,
> +	MOD_INIT_DATA,
> +	MOD_INIT_RODATA,
> +
> +	MOD_MEM_NUM_TYPES,
> +	MOD_INVALID = -1,
> +};

> @@ -573,23 +574,33 @@ bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr);
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
> +
> +	return base <= addr && addr < base + size;

Possible (as inspired by all the above is_{init,core}() etc..

	return addr - base < size;

> +}


static inline bool within_module_mem_types(unsigned long addr,
					   const struct module *mod,
					   enum mod_mem_type first,
					   enum mod_mem_type last)
{
	for (enum mod_mem_type type = first; type <= last; type++) {
		if (within_module_mem_type(addr, mod, type))
			return true;
	}
	return false;
}

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
> +	return within_module_mem_type(addr, mod, MOD_TEXT) ||
> +		within_module_mem_type(addr, mod, MOD_DATA) ||
> +		within_module_mem_type(addr, mod, MOD_RODATA) ||
> +		within_module_mem_type(addr, mod, MOD_RO_AFTER_INIT);
>  }

within_module_mem_types(addr, mod, MOD_TEXT, MOD_RO_AFTER_INIT);

>  static inline bool within_module_init(unsigned long addr,
>  				      const struct module *mod)
>  {
> -	return (unsigned long)mod->init_layout.base <= addr &&
> -	       addr < (unsigned long)mod->init_layout.base + mod->init_layout.size;
> +	return within_module_mem_type(addr, mod, MOD_INIT_TEXT) ||
> +		within_module_mem_type(addr, mod, MOD_INIT_DATA) ||
> +		within_module_mem_type(addr, mod, MOD_INIT_RODATA);
>  }

within_module_mem_types(addr, mod, MOD_INIT_TEXT, MOD_INIT_RODATA);
