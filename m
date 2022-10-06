Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EFA5F71FA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 01:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbiJFXoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 19:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiJFXoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:44:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4A7B7EF2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 16:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZgYg+TXdShKnQjqWZe7CHnhBk6HcFIPAWWEHqOLdrLg=; b=cewjqgldr3aDQBKlHs46OsWViU
        Jif0KUS407VTQybYKvF9uqj7AIUaldZ9odDeFpKB4bWWhUOWEbcLO1TKJ6QQ4c41vpEKG7mAJ6Cor
        pBKxOwD/WGJZRgBqsV2tIopPs1AjaPPf7RLFS/D3MQglaBClWc6i5FOAQW+bBxcnibooXl3U5gzqM
        oCBzfQSBq+VX9ewBP7O5KKc9mC+HonUrZPoE9hgtsExNjDJkug8sjhT1AIyk8jjXMjy3Reu+P16qx
        UJ0NC3I4Itb3erFn/L+cZ/p4G2wtkt0XQomOI2OHqw3fJtQxMRzo7m9BJxlejf0VTVmjao03nANdw
        xOXrirkA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ogaXI-0062Td-FU; Thu, 06 Oct 2022 23:44:16 +0000
Date:   Thu, 6 Oct 2022 16:44:16 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, x86@kernel.org, peterz@infradead.org,
        hch@lst.de, kernel-team@fb.com, rick.p.edgecombe@intel.com,
        dave.hansen@intel.com
Subject: Re: [RFC 4/5] vmalloc_exec: share a huge page with kernel text
Message-ID: <Yz9oUDY6nj4V9z/O@bombadil.infradead.org>
References: <20220818224218.2399791-1-song@kernel.org>
 <20220818224218.2399791-5-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818224218.2399791-5-song@kernel.org>
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

On Thu, Aug 18, 2022 at 03:42:17PM -0700, Song Liu wrote:
> On x86 kernel, we allocate 2MB pages for kernel text up to
> round_down(_etext, 2MB). Therefore, some of the kernel text is still
> on 4kB pages. With vmalloc_exec, we can allocate 2MB pages up to
> round_up(_etext, 2MB), and use the rest of the page for modules and
> BPF programs.
> 
> Here is an example:
> 
> [root@eth50-1 ~]# grep _etext /proc/kallsyms
> ffffffff82202a08 T _etext
> 
> [root@eth50-1 ~]# grep bpf_prog_ /proc/kallsyms  | tail -n 3
> ffffffff8220f920 t bpf_prog_cc61a5364ac11d93_handle__sched_wakeup       [bpf]
> ffffffff8220fa28 t bpf_prog_cc61a5364ac11d93_handle__sched_wakeup_new   [bpf]
> ffffffff8220fad4 t bpf_prog_3bf73fa16f5e3d92_handle__sched_switch       [bpf]
> 
> [root@eth50-1 ~]#  grep 0xffffffff82200000 /sys/kernel/debug/page_tables/kernel
> 0xffffffff82200000-0xffffffff82400000     2M     ro   PSE         x  pmd
> 
> [root@eth50-1 ~]# grep xfs_flush_inodes /proc/kallsyms
> ffffffff822ba910 t xfs_flush_inodes_worker      [xfs]
> ffffffff822bc580 t xfs_flush_inodes     [xfs]
> 
> ffffffff82200000-ffffffff82400000 is a 2MB page, serving kernel text, xfs
> module, and bpf programs.

This is pretty rad. I'm not sure how you were able to squeeze xfs and
*more* into one 2 MiB huge page though at least on debian 5.17.0-1-amd64
xfs is 3.6847 MiB. How big is your XFS module?

I don't grok mm stuff, but I'd like to understand why we gain the ability
of re-use the same 2 MiB page with this patch, from the code I really
can't tail. Any pointers?

But, I'm still concerned about the free'ing case in terms of
fragmentation for contigous memory, when free huage pages are available.

  Luis

> ---
>  arch/x86/mm/init_64.c |  3 ++-
>  mm/vmalloc.c          | 27 +++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 39c5246964a9..d27d0af5beb5 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1367,12 +1367,13 @@ int __init deferred_page_init_max_threads(const struct cpumask *node_cpumask)
>  
>  int kernel_set_to_readonly;
>  
> +#define PMD_ALIGN(x)	(((unsigned long)(x) + (PMD_SIZE - 1)) & PMD_MASK)
>  void mark_rodata_ro(void)
>  {
>  	unsigned long start = PFN_ALIGN(_text);
>  	unsigned long rodata_start = PFN_ALIGN(__start_rodata);
>  	unsigned long end = (unsigned long)__end_rodata_hpage_align;
> -	unsigned long text_end = PFN_ALIGN(_etext);
> +	unsigned long text_end = PMD_ALIGN(_etext);
>  	unsigned long rodata_end = PFN_ALIGN(__end_rodata);
>  	unsigned long all_end;
>  
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 472287e71bf1..5f3b5df9313f 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -72,6 +72,11 @@ early_param("nohugevmalloc", set_nohugevmalloc);
>  static const bool vmap_allow_huge = false;
>  #endif	/* CONFIG_HAVE_ARCH_HUGE_VMALLOC */
>  
> +#define PMD_ALIGN(x)	(((unsigned long)(x) + (PMD_SIZE - 1)) & PMD_MASK)
> +
> +static struct vm_struct text_tail_vm;
> +static struct vmap_area text_tail_va;
> +
>  bool is_vmalloc_addr(const void *x)
>  {
>  	unsigned long addr = (unsigned long)kasan_reset_tag(x);
> @@ -634,6 +639,8 @@ int is_vmalloc_or_module_addr(const void *x)
>  	unsigned long addr = (unsigned long)kasan_reset_tag(x);
>  	if (addr >= MODULES_VADDR && addr < MODULES_END)
>  		return 1;
> +	if (addr >= text_tail_va.va_start && addr < text_tail_va.va_end)
> +		return 1;
>  #endif
>  	return is_vmalloc_addr(x);
>  }
> @@ -2371,6 +2378,25 @@ static void vmap_init_free_space(void)
>  	}
>  }
>  
> +static void register_text_tail_vm(void)
> +{
> +	unsigned long start = PFN_ALIGN(_etext);
> +	unsigned long end = PMD_ALIGN(_etext);
> +	struct vmap_area *va;
> +
> +	va = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
> +	if (WARN_ON_ONCE(!va))
> +		return;
> +	text_tail_vm.addr = (void *)start;
> +	text_tail_vm.size = end - start;
> +	text_tail_vm.flags = VM_KERNEL_EXEC;
> +	text_tail_va.va_start = start;
> +	text_tail_va.va_end = end;
> +	text_tail_va.vm = &text_tail_vm;
> +	memcpy(va, &text_tail_va, sizeof(*va));
> +	insert_vmap_area(va, &free_text_area_root, &free_text_area_list);
> +}
> +
>  void __init vmalloc_init(void)
>  {
>  	struct vmap_area *va;
> @@ -2381,6 +2407,7 @@ void __init vmalloc_init(void)
>  	 * Create the cache for vmap_area objects.
>  	 */
>  	vmap_area_cachep = KMEM_CACHE(vmap_area, SLAB_PANIC);
> +	register_text_tail_vm();
>  
>  	for_each_possible_cpu(i) {
>  		struct vmap_block_queue *vbq;
> -- 
> 2.30.2
> 
