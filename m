Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B09A5E6223
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 14:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiIVMRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 08:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiIVMRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:17:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2F7E511D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:17:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C8E560B4B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 12:17:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E881DC43141;
        Thu, 22 Sep 2022 12:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663849030;
        bh=a6JDj92h4ZSv3d2J6QFlrqQM09V4BjuUQX8oFHndpVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rq62sEsJ/0KaMF/543icgWoLEyrjnehcpCEa9IUzQ+fZwXssz4Nnj6N1vqTQR8rNO
         VwrXIcoy1ZmmUuTF6kK1z+RC7UKdWqg9YZimDetM4mZK9E5m/sOjBLLWnE5yyEb5ng
         tLtmWh429O1zaNZ9atBa5fektJIwQsd4P0ZmkezIcLOgrhmtU6t+Rg0BitltCkND3T
         AidNmvwe7Ir96tnjJvjWpNKCFz/ejAT9NZfT+aXbc8RXiQYOoR5tDg2sbPPddcs1KY
         y9GHugwV8xF3g34gt9r5WT2V55PA7c/St37IrHGCeQ3PmPbUGqXq3sgH+ernZGxjyO
         gSAYp5G29jH3g==
Date:   Thu, 22 Sep 2022 20:07:44 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        guoren@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: vdso: fix NULL deference in vdso_join_timens()
 when vfork
Message-ID: <YyxQEOheUORzBLBX@xhacker>
References: <20220908150421.323-1-jszhang@kernel.org>
 <mhng-25f0a2ef-5eea-4567-95ff-438c2285c7ee@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <mhng-25f0a2ef-5eea-4567-95ff-438c2285c7ee@palmer-ri-x1c9>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 11:02:19AM -0700, Palmer Dabbelt wrote:
> On Thu, 08 Sep 2022 08:04:21 PDT (-0700), jszhang@kernel.org wrote:
> > Testing tools/testing/selftests/timens/vfork_exec.c got below
> > kernel log:
> > 
> > [    6.838454] Unable to handle kernel access to user memory without uaccess routines at virtual address 0000000000000020
> > [    6.842255] Oops [#1]
> > [    6.842871] Modules linked in:
> > [    6.844249] CPU: 1 PID: 64 Comm: vfork_exec Not tainted 6.0.0-rc3-rt15+ #8
> > [    6.845861] Hardware name: riscv-virtio,qemu (DT)
> > [    6.848009] epc : vdso_join_timens+0xd2/0x110
> > [    6.850097]  ra : vdso_join_timens+0xd2/0x110
> > [    6.851164] epc : ffffffff8000635c ra : ffffffff8000635c sp : ff6000000181fbf0
> > [    6.852562]  gp : ffffffff80cff648 tp : ff60000000fdb700 t0 : 3030303030303030
> > [    6.853852]  t1 : 0000000000000030 t2 : 3030303030303030 s0 : ff6000000181fc40
> > [    6.854984]  s1 : ff60000001e6c000 a0 : 0000000000000010 a1 : ffffffff8005654c
> > [    6.856221]  a2 : 00000000ffffefff a3 : 0000000000000000 a4 : 0000000000000000
> > [    6.858114]  a5 : 0000000000000000 a6 : 0000000000000008 a7 : 0000000000000038
> > [    6.859484]  s2 : ff60000001e6c068 s3 : ff6000000108abb0 s4 : 0000000000000000
> > [    6.860751]  s5 : 0000000000001000 s6 : ffffffff8089dc40 s7 : ffffffff8089dc38
> > [    6.862029]  s8 : ffffffff8089dc30 s9 : ff60000000fdbe38 s10: 000000000000005e
> > [    6.863304]  s11: ffffffff80cc3510 t3 : ffffffff80d1112f t4 : ffffffff80d1112f
> > [    6.864565]  t5 : ffffffff80d11130 t6 : ff6000000181fa00
> > [    6.865561] status: 0000000000000120 badaddr: 0000000000000020 cause: 000000000000000d
> > [    6.868046] [<ffffffff8008dc94>] timens_commit+0x38/0x11a
> > [    6.869089] [<ffffffff8008dde8>] timens_on_fork+0x72/0xb4
> > [    6.870055] [<ffffffff80190096>] begin_new_exec+0x3c6/0x9f0
> > [    6.871231] [<ffffffff801d826c>] load_elf_binary+0x628/0x1214
> > [    6.872304] [<ffffffff8018ee7a>] bprm_execve+0x1f2/0x4e4
> > [    6.873243] [<ffffffff8018f90c>] do_execveat_common+0x16e/0x1ee
> > [    6.874258] [<ffffffff8018f9c8>] sys_execve+0x3c/0x48
> > [    6.875162] [<ffffffff80003556>] ret_from_syscall+0x0/0x2
> > [    6.877484] ---[ end trace 0000000000000000 ]---
> > 
> > This is because the mm->context.vdso_info is NULL in vfork case. From
> > another side, mm->context.vdso_info either points to vdso info
> > for RV64 or vdso info for compat, there's no need to bloat riscv's
> > mm_context_t, we can handle the difference when setup the additional
> > page for vdso.
> 
> Makes sense, but I think there's a lot more diff here than we need in order

The reason of "a lot more diff" is moving the code to avoid forward declaration.
If you prefer smaller fix, I can provide a simpler one w/ forware
declaration. And provide a new clean up patch for next window, what do you
think?

Thanks
> to just fix the bug.  Does something like the following still fix it?  Also
> at kernel.org/palmer/vdso-fix-v3 .  Maybe it's a bit pedantic , but this
> late in the cycle with everyone traveling I'd prefer to keep the fixes
> smaller when possible.
> 
> diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
> index cedcf8ea3c76..0099dc116168 100644
> --- a/arch/riscv/include/asm/mmu.h
> +++ b/arch/riscv/include/asm/mmu.h
> @@ -16,7 +16,6 @@ typedef struct {
> 	atomic_long_t id;
> #endif
> 	void *vdso;
> -	void *vdso_info;
> #ifdef CONFIG_SMP
> 	/* A local icache flush is needed before user execution can resume. */
> 	cpumask_t icache_stale_mask;
> diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
> index 69b05b6c181b..58b8d73a4b1f 100644
> --- a/arch/riscv/kernel/vdso.c
> +++ b/arch/riscv/kernel/vdso.c
> @@ -23,8 +23,10 @@ struct vdso_data {
> #endif
> 
> extern char vdso_start[], vdso_end[];
> +static struct __vdso_info vdso_info;
> #ifdef CONFIG_COMPAT
> extern char compat_vdso_start[], compat_vdso_end[];
> +static struct __vdso_info compat_vdso_info;
> #endif
> 
> enum vvar_pages {
> @@ -114,15 +116,18 @@ int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
> {
> 	struct mm_struct *mm = task->mm;
> 	struct vm_area_struct *vma;
> -	struct __vdso_info *vdso_info = mm->context.vdso_info;
> 
> 	mmap_read_lock(mm);
> 
> 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
> 		unsigned long size = vma->vm_end - vma->vm_start;
> 
> -		if (vma_is_special_mapping(vma, vdso_info->dm))
> +		if (vma_is_special_mapping(vma, vdso_info.dm))
> 			zap_page_range(vma, vma->vm_start, size);
> +#ifdef CONFIG_COMPAT
> +		if (vma_is_special_mapping(vma, compat_vdso_info.dm))
> +			zap_page_range(vma, vma->vm_start, size);
> +#endif
> 	}
> 
> 	mmap_read_unlock(mm);
> @@ -264,7 +269,6 @@ static int __setup_additional_pages(struct mm_struct *mm,
> 
> 	vdso_base += VVAR_SIZE;
> 	mm->context.vdso = (void *)vdso_base;
> -	mm->context.vdso_info = (void *)vdso_info;
> 
> 	ret =
> 	   _install_special_mapping(mm, vdso_base, vdso_text_len,
> 
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > Fixes: 3092eb456375 ("riscv: compat: vdso: Add setup additional pages implementation")
> > ---
> > 
> > since v1:
> >  - add "Fixes" tag
> >  - fix build error when CONFIG_COMPAT is enabled.
> > 
> >  arch/riscv/include/asm/mmu.h |   1 -
> >  arch/riscv/kernel/vdso.c     | 178 +++++++++++++++++++----------------
> >  2 files changed, 95 insertions(+), 84 deletions(-)
> > 
> > diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
> > index cedcf8ea3c76..0099dc116168 100644
> > --- a/arch/riscv/include/asm/mmu.h
> > +++ b/arch/riscv/include/asm/mmu.h
> > @@ -16,7 +16,6 @@ typedef struct {
> >  	atomic_long_t id;
> >  #endif
> >  	void *vdso;
> > -	void *vdso_info;
> >  #ifdef CONFIG_SMP
> >  	/* A local icache flush is needed before user execution can resume. */
> >  	cpumask_t icache_stale_mask;
> > diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
> > index 69b05b6c181b..8ca3b821e1b5 100644
> > --- a/arch/riscv/kernel/vdso.c
> > +++ b/arch/riscv/kernel/vdso.c
> > @@ -27,6 +27,11 @@ extern char vdso_start[], vdso_end[];
> >  extern char compat_vdso_start[], compat_vdso_end[];
> >  #endif
> > 
> > +enum vdso_abi {
> > +	VDSO_ABI_RV64,
> > +	VDSO_ABI_RV32,
> > +};
> > +
> >  enum vvar_pages {
> >  	VVAR_DATA_PAGE_OFFSET,
> >  	VVAR_TIMENS_PAGE_OFFSET,
> > @@ -68,67 +73,7 @@ static int vdso_mremap(const struct vm_special_mapping *sm,
> >  	return 0;
> >  }
> > 
> > -static void __init __vdso_init(struct __vdso_info *vdso_info)
> > -{
> > -	unsigned int i;
> > -	struct page **vdso_pagelist;
> > -	unsigned long pfn;
> > -
> > -	if (memcmp(vdso_info->vdso_code_start, "\177ELF", 4))
> > -		panic("vDSO is not a valid ELF object!\n");
> > -
> > -	vdso_info->vdso_pages = (
> > -		vdso_info->vdso_code_end -
> > -		vdso_info->vdso_code_start) >>
> > -		PAGE_SHIFT;
> > -
> > -	vdso_pagelist = kcalloc(vdso_info->vdso_pages,
> > -				sizeof(struct page *),
> > -				GFP_KERNEL);
> > -	if (vdso_pagelist == NULL)
> > -		panic("vDSO kcalloc failed!\n");
> > -
> > -	/* Grab the vDSO code pages. */
> > -	pfn = sym_to_pfn(vdso_info->vdso_code_start);
> > -
> > -	for (i = 0; i < vdso_info->vdso_pages; i++)
> > -		vdso_pagelist[i] = pfn_to_page(pfn + i);
> > -
> > -	vdso_info->cm->pages = vdso_pagelist;
> > -}
> > -
> >  #ifdef CONFIG_TIME_NS
> > -struct vdso_data *arch_get_vdso_data(void *vvar_page)
> > -{
> > -	return (struct vdso_data *)(vvar_page);
> > -}
> > -
> > -/*
> > - * The vvar mapping contains data for a specific time namespace, so when a task
> > - * changes namespace we must unmap its vvar data for the old namespace.
> > - * Subsequent faults will map in data for the new namespace.
> > - *
> > - * For more details see timens_setup_vdso_data().
> > - */
> > -int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
> > -{
> > -	struct mm_struct *mm = task->mm;
> > -	struct vm_area_struct *vma;
> > -	struct __vdso_info *vdso_info = mm->context.vdso_info;
> > -
> > -	mmap_read_lock(mm);
> > -
> > -	for (vma = mm->mmap; vma; vma = vma->vm_next) {
> > -		unsigned long size = vma->vm_end - vma->vm_start;
> > -
> > -		if (vma_is_special_mapping(vma, vdso_info->dm))
> > -			zap_page_range(vma, vma->vm_start, size);
> > -	}
> > -
> > -	mmap_read_unlock(mm);
> > -	return 0;
> > -}
> > -
> >  static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
> >  {
> >  	if (likely(vma->vm_mm == current->mm))
> > @@ -197,13 +142,6 @@ static struct vm_special_mapping rv_vdso_maps[] __ro_after_init = {
> >  	},
> >  };
> > 
> > -static struct __vdso_info vdso_info __ro_after_init = {
> > -	.name = "vdso",
> > -	.vdso_code_start = vdso_start,
> > -	.vdso_code_end = vdso_end,
> > -	.dm = &rv_vdso_maps[RV_VDSO_MAP_VVAR],
> > -	.cm = &rv_vdso_maps[RV_VDSO_MAP_VDSO],
> > -};
> > 
> >  #ifdef CONFIG_COMPAT
> >  static struct vm_special_mapping rv_compat_vdso_maps[] __ro_after_init = {
> > @@ -216,21 +154,97 @@ static struct vm_special_mapping rv_compat_vdso_maps[] __ro_after_init = {
> >  		.mremap = vdso_mremap,
> >  	},
> >  };
> > +#endif
> > 
> > -static struct __vdso_info compat_vdso_info __ro_after_init = {
> > -	.name = "compat_vdso",
> > -	.vdso_code_start = compat_vdso_start,
> > -	.vdso_code_end = compat_vdso_end,
> > -	.dm = &rv_compat_vdso_maps[RV_VDSO_MAP_VVAR],
> > -	.cm = &rv_compat_vdso_maps[RV_VDSO_MAP_VDSO],
> > +static struct __vdso_info vdso_info[] __ro_after_init = {
> > +	[VDSO_ABI_RV64] = {
> > +		.name = "vdso",
> > +		.vdso_code_start = vdso_start,
> > +		.vdso_code_end = vdso_end,
> > +		.dm = &rv_vdso_maps[RV_VDSO_MAP_VVAR],
> > +		.cm = &rv_vdso_maps[RV_VDSO_MAP_VDSO],
> > +	},
> > +#ifdef CONFIG_COMPAT
> > +	[VDSO_ABI_RV32] = {
> > +		.name = "compat_vdso",
> > +		.vdso_code_start = compat_vdso_start,
> > +		.vdso_code_end = compat_vdso_end,
> > +		.dm = &rv_compat_vdso_maps[RV_VDSO_MAP_VVAR],
> > +		.cm = &rv_compat_vdso_maps[RV_VDSO_MAP_VDSO],
> > +	},
> > +#endif
> >  };
> > +
> > +static void __init __vdso_init(enum vdso_abi abi)
> > +{
> > +	unsigned int i;
> > +	struct page **vdso_pagelist;
> > +	unsigned long pfn;
> > +
> > +	if (memcmp(vdso_info[abi].vdso_code_start, "\177ELF", 4))
> > +		panic("vDSO is not a valid ELF object!\n");
> > +
> > +	vdso_info[abi].vdso_pages = (
> > +		vdso_info[abi].vdso_code_end -
> > +		vdso_info[abi].vdso_code_start) >>
> > +		PAGE_SHIFT;
> > +
> > +	vdso_pagelist = kcalloc(vdso_info[abi].vdso_pages,
> > +				sizeof(struct page *),
> > +				GFP_KERNEL);
> > +	if (vdso_pagelist == NULL)
> > +		panic("vDSO kcalloc failed!\n");
> > +
> > +	/* Grab the vDSO code pages. */
> > +	pfn = sym_to_pfn(vdso_info[abi].vdso_code_start);
> > +
> > +	for (i = 0; i < vdso_info[abi].vdso_pages; i++)
> > +		vdso_pagelist[i] = pfn_to_page(pfn + i);
> > +
> > +	vdso_info[abi].cm->pages = vdso_pagelist;
> > +}
> > +
> > +#ifdef CONFIG_TIME_NS
> > +struct vdso_data *arch_get_vdso_data(void *vvar_page)
> > +{
> > +	return (struct vdso_data *)(vvar_page);
> > +}
> > +
> > +/*
> > + * The vvar mapping contains data for a specific time namespace, so when a task
> > + * changes namespace we must unmap its vvar data for the old namespace.
> > + * Subsequent faults will map in data for the new namespace.
> > + *
> > + * For more details see timens_setup_vdso_data().
> > + */
> > +int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
> > +{
> > +	struct mm_struct *mm = task->mm;
> > +	struct vm_area_struct *vma;
> > +
> > +	mmap_read_lock(mm);
> > +
> > +	for (vma = mm->mmap; vma; vma = vma->vm_next) {
> > +		unsigned long size = vma->vm_end - vma->vm_start;
> > +
> > +		if (vma_is_special_mapping(vma, vdso_info[VDSO_ABI_RV64].dm))
> > +			zap_page_range(vma, vma->vm_start, size);
> > +#ifdef CONFIG_COMPAT
> > +		if (vma_is_special_mapping(vma, vdso_info[VDSO_ABI_RV32].dm))
> > +			zap_page_range(vma, vma->vm_start, size);
> > +#endif
> > +	}
> > +
> > +	mmap_read_unlock(mm);
> > +	return 0;
> > +}
> >  #endif
> > 
> >  static int __init vdso_init(void)
> >  {
> > -	__vdso_init(&vdso_info);
> > +	__vdso_init(VDSO_ABI_RV64);
> >  #ifdef CONFIG_COMPAT
> > -	__vdso_init(&compat_vdso_info);
> > +	__vdso_init(VDSO_ABI_RV32);
> >  #endif
> > 
> >  	return 0;
> > @@ -240,14 +254,14 @@ arch_initcall(vdso_init);
> >  static int __setup_additional_pages(struct mm_struct *mm,
> >  				    struct linux_binprm *bprm,
> >  				    int uses_interp,
> > -				    struct __vdso_info *vdso_info)
> > +				    enum vdso_abi abi)
> >  {
> >  	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
> >  	void *ret;
> > 
> >  	BUILD_BUG_ON(VVAR_NR_PAGES != __VVAR_PAGES);
> > 
> > -	vdso_text_len = vdso_info->vdso_pages << PAGE_SHIFT;
> > +	vdso_text_len = vdso_info[abi].vdso_pages << PAGE_SHIFT;
> >  	/* Be sure to map the data page */
> >  	vdso_mapping_len = vdso_text_len + VVAR_SIZE;
> > 
> > @@ -258,18 +272,17 @@ static int __setup_additional_pages(struct mm_struct *mm,
> >  	}
> > 
> >  	ret = _install_special_mapping(mm, vdso_base, VVAR_SIZE,
> > -		(VM_READ | VM_MAYREAD | VM_PFNMAP), vdso_info->dm);
> > +		(VM_READ | VM_MAYREAD | VM_PFNMAP), vdso_info[abi].dm);
> >  	if (IS_ERR(ret))
> >  		goto up_fail;
> > 
> >  	vdso_base += VVAR_SIZE;
> >  	mm->context.vdso = (void *)vdso_base;
> > -	mm->context.vdso_info = (void *)vdso_info;
> > 
> >  	ret =
> >  	   _install_special_mapping(mm, vdso_base, vdso_text_len,
> >  		(VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC),
> > -		vdso_info->cm);
> > +		vdso_info[abi].cm);
> > 
> >  	if (IS_ERR(ret))
> >  		goto up_fail;
> > @@ -291,8 +304,7 @@ int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
> >  	if (mmap_write_lock_killable(mm))
> >  		return -EINTR;
> > 
> > -	ret = __setup_additional_pages(mm, bprm, uses_interp,
> > -							&compat_vdso_info);
> > +	ret = __setup_additional_pages(mm, bprm, uses_interp, VDSO_ABI_RV32);
> >  	mmap_write_unlock(mm);
> > 
> >  	return ret;
> > @@ -307,7 +319,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
> >  	if (mmap_write_lock_killable(mm))
> >  		return -EINTR;
> > 
> > -	ret = __setup_additional_pages(mm, bprm, uses_interp, &vdso_info);
> > +	ret = __setup_additional_pages(mm, bprm, uses_interp, VDSO_ABI_RV64);
> >  	mmap_write_unlock(mm);
> > 
> >  	return ret;
