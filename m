Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6ECB67C468
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 07:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbjAZGGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 01:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbjAZGGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 01:06:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E0621970;
        Wed, 25 Jan 2023 22:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JQrN3UZl/mHZBH9yHVK69TJgyXOspURdR0VdlwbD4Eg=; b=0XWSI2tdvwlthpgOh9S7JLikrc
        mY9T4izPEya7VzwoSqdo97+1eVsNWjFkfhriLwIAHL/4DYxsruzwBSqSj/QCCzdtpJ+4bbi+pi3wx
        4V1GAKmJM689VLJzZBkU4prksD3Dl3RQTyLZ1g5+wBed2aq/TOw3amGsPAiDYZBE2tIfm6w+/U+YO
        Gmj26micbcDQkInFQfVw/F1PxhXns3G1WDQVsawXqI7TQU7HXdDfeyAcw8EmfUY4rf7TTqBIm/kF8
        Lf8GSEA9Bjfy5+BQmVO7JZuoq2/Dpk3DRR/UJ/IVU33gM6JA13oQEd7+UKyNz/QR2Vdwh1H/q4tMv
        Hao/k7Vg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKvOe-009ieL-BM; Thu, 26 Jan 2023 06:06:04 +0000
Date:   Wed, 25 Jan 2023 22:06:04 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] module: replace module_layout with module_memory
Message-ID: <Y9IYTI3pWuKbJ3bC@bombadil.infradead.org>
References: <20230125185004.254742-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125185004.254742-1-song@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 10:50:04AM -0800, Song Liu wrote:
> module_layout manages different types of memory (text, data, rodata, etc.)
> in one allocation, which is problematic for some reasons:
> 
> 1. It is hard to enable CONFIG_STRICT_MODULE_RWX.
> 2. It is hard to use huge pages in modules (and not break strict rwx).
> 3. Many archs uses module_layout for arch-specific data, but it is not
>    obvious how these data are used (are they RO, RX, or RW?)
> 
> Improve the scenario by replacing 2 (or 3) module_layout per module with
> up to 7 module_memory per module:
> 
>         MOD_MEM_TYPE_TEXT,
>         MOD_MEM_TYPE_DATA,
>         MOD_MEM_TYPE_RODATA,
>         MOD_MEM_TYPE_RO_AFTER_INIT,
>         MOD_MEM_TYPE_INIT_TEXT,
>         MOD_MEM_TYPE_INIT_DATA,
>         MOD_MEM_TYPE_INIT_RODATA,
> 
> and allocating them separately.

First thanks for doing this work!

This seems to not acknolwedge the original goal of the first module_layout and
the latched rb-tree use, and that was was for speeding up __module_address()
since it *can* even be triggered on NMIs. I say this because the first question
that comes to me is the impact to performance on __module_address() I can't
see that changing much here, but mention it as it similar consideration
should be made in case future changes modify this path.

Microbenching something so trivial as __module_address() may not be as useful
for an idle system, at the very least being able to compare before and after
even on idle may be useful *if* you eventually do some more radical changes
here. Modules-related kernel/kallsyms_selftest.c did that for kallsyms_lookup_name()
and friend just recently for a minor performance enhancement.

At a high level it is perhaps my only conern so far while reviewing this patch,
and I am glad it is now clear that addressing modules is a requirement. The rest
seems like a highly welcomed cleanup even though the diffstat does not reflect
that.

> Various archs use module_layout for different data. These data are put
> into different module_memory based on their location in module_layout.
> IOW, data that used to go with text is allocated with MOD_MEM_TYPE_TEXT;
> data that used to go with data is allocated with MOD_MEM_TYPE_DATA, etc.

I think the commit log should document a bit the rationale for why
ARCH_WANTS_MODULES_DATA_IN_VMALLOC gets *can* tidied up so well here.

> Signed-off-by: Song Liu <song@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> 
> ---
> 
> This is the preparation work for the type aware module_alloc() discussed
> in [1]. While this work is not covered much in the discussion, it is a
> critical step of the effort.
> 
> As this part grows pretty big (~1000 lines, + and -), I would like get
> some feedback on it, so that I know it is on the right track.
> 
> Please share your comments. Thanks!
> 
> Test coverage: Tested on x86_64.

I will likely merge this onto modules-next soon, not because I think it is
ready, but just because I think it *is* mostly ready and the next thing
we need is exposure and testing. rc5 is pretty late to consider this
for v6.3 and so hopefully for this cycle we can at least settle on
something which will sit in linux-next since the respective linux-next
after v6.3-rc1 is released.

> Build tested by kernel test bot in [2]. The only regression in [2] was a
> typo in parisc, which is also fixed.
> 
> [1] https://lore.kernel.org/linux-mm/20221107223921.3451913-1-song@kernel.org/T/#u

You still never addressed my performance suggestions so don't be
surprised if I insist later. Yes you can use existing performance
benchmarks, specially now with modules as a hard requirement, to
show gains. So I'd like to clarify that if I'm reviewing late it is
because:

a) my modules patch review queue has been high as of late
b) you seem to not have taken these performance suggestions into consideration
   before and so I tend to put it at my end of my queue for review.

> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d02d39c7174e..c90eb2ba0985 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -925,11 +929,31 @@ static ssize_t store_uevent(struct module_attribute *mattr,
>  struct module_attribute module_uevent =
>  	__ATTR(uevent, 0200, NULL, store_uevent);
>  
> +#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> +
> +static ssize_t show_coresize(struct module_attribute *mattr,
> +			     struct module_kobject *mk, char *buffer)
> +{
> +	enum mod_mem_type type;

This is unused.

> @@ -1389,16 +1466,29 @@ unsigned int __weak arch_mod_section_prepend(struct module *mod,
>  	return 0;
>  }
>  
> -/* Update size with this section: return offset. */
> -long module_get_offset(struct module *mod, unsigned int *size,
> -		       Elf_Shdr *sechdr, unsigned int section)
> +/*
> + * Use highest 4 bits of sh_entsize to store the mod_mem_type of this
> + * section. This leaves 28 bits for offset on 32-bit systems, which is
> + * about 256 MiB (WARN_ON_ONCE if we exceed that).
> + */
> +
> +#define SH_ENTSIZE_TYPE_BITS	4
> +#define SH_ENTSIZE_TYPE_SHIFT	(BITS_PER_LONG - SH_ENTSIZE_TYPE_BITS)
> +#define SH_ENTSIZE_TYPE_MASK	((1UL << SH_ENTSIZE_TYPE_BITS) - 1)
> +#define SH_ENTSIZE_OFFSET_MASK	((1UL << (BITS_PER_LONG - SH_ENTSIZE_TYPE_BITS)) - 1)
> +
> +long module_get_offset_and_type(struct module *mod, enum mod_mem_type type,
> +				Elf_Shdr *sechdr, unsigned int section)
>  {
> -	long ret;
> +	long offset;
> +	long mask = ((unsigned long)(type) & SH_ENTSIZE_TYPE_MASK) << SH_ENTSIZE_TYPE_SHIFT;
>  
> -	*size += arch_mod_section_prepend(mod, section);
> -	ret = ALIGN(*size, sechdr->sh_addralign ?: 1);
> -	*size = ret + sechdr->sh_size;
> -	return ret;
> +	mod->mod_mem[type].size += arch_mod_section_prepend(mod, section);
> +	offset = ALIGN(mod->mod_mem[type].size, sechdr->sh_addralign ?: 1);
> +	mod->mod_mem[type].size = offset + sechdr->sh_size;
> +
> +	WARN_ON_ONCE(offset & mask);
> +	return offset | mask;
>  }

Could you split this somehow with the mask stuff up into its own
non-functional patch first somehow to make this easier to review?

No worries if you can't.

> @@ -2117,74 +2193,45 @@ static int find_module_sections(struct module *mod, struct load_info *info)
>  
>  static int move_module(struct module *mod, struct load_info *info)
>  {
> +	enum mod_mem_type type;
>  	int i;
>  	void *ptr;
>  
> -	/* Do the allocs. */
> -	ptr = module_alloc(mod->core_layout.size);
> -	/*
> -	 * The pointer to this block is stored in the module structure
> -	 * which is inside the block. Just mark it as not being a
> -	 * leak.
> -	 */
> -	kmemleak_not_leak(ptr);
> -	if (!ptr)
> -		return -ENOMEM;
> -
> -	memset(ptr, 0, mod->core_layout.size);
> -	mod->core_layout.base = ptr;
> +	for_each_mod_mem_type(type) {
> +		if (!mod->mod_mem[type].size) {
> +			mod->mod_mem[type].base = NULL;
> +			continue;
> +		}
> +		mod->mod_mem[type].size = PAGE_ALIGN(mod->mod_mem[type].size);
> +		if (mod_mem_use_vmalloc(type))
> +			ptr = vzalloc(mod->mod_mem[type].size);
> +		else
> +			ptr = module_alloc(mod->mod_mem[type].size);

This form to check for mod_mem_use_vmalloc() is used twice, how about
a helper to just do it one line for us?

> @@ -2195,6 +2242,14 @@ static int move_module(struct module *mod, struct load_info *info)
>  	}
>  
>  	return 0;
> +out_enomem:
> +	for (type--; type >= 0; type--) {
> +		if (mod_mem_use_vmalloc(type))
> +			vfree(mod->mod_mem[type].base);
> +		else
> +			module_memfree(mod->mod_mem[type].base);
> +	}
> +	return -ENOMEM;
>  }

Here's the other user.

> diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c

This was the hardest file to review and so I ask the same, if a separate
non-functional change could be done first to make the changes easier
to review.

No worries if not.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

I'll queue this onto modules-testing to see what blows up. After at
least one more review I'll queue this onto modules-next.

  Luis
