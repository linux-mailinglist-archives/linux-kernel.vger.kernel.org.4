Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5A95F7191
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 01:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiJFXPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 19:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiJFXPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:15:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F72638A37
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 16:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jim+9/y06LGi+uVmz8kZgwb+BbpBMvLmJoqFNj+ZOO0=; b=XtL+bUTQnaLtcir1Fg3HwmW3ot
        ms0HS3clc+CFME1sUAQ2tJZIEXoHgfjKyVBuYlTk9Fb0UD7ucjvKnP4GyDhV790COa9mh/PuoFN02
        us/cHXpsIalQ7dqVf1dy6wpIe8r40b4ngJ39ZmOIgiob8AvqaxWJhW/PZqqKLx4l1q06RoPpztaRs
        eKFQ0ue0kqU6Fw6axlEY+q2GcYzt09uyESHGhJhP4RXrHZKqlpg9tCElS72S4lXSPAcUFWFL0QhkY
        1QH1dlDetMD9VFITzEfUV2qy15qsLUK+XKU/Yd2AtmNFtD1A4h2xTYsiomjiwMHKsBnzvjsGzU8iB
        tzxoN4Rg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oga5F-005wIg-UC; Thu, 06 Oct 2022 23:15:17 +0000
Date:   Thu, 6 Oct 2022 16:15:17 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, x86@kernel.org, peterz@infradead.org,
        hch@lst.de, kernel-team@fb.com, rick.p.edgecombe@intel.com,
        dave.hansen@intel.com
Subject: Re: [RFC 1/5] vmalloc: introduce vmalloc_exec and vfree_exec
Message-ID: <Yz9hhTRzMr0ZEnA/@bombadil.infradead.org>
References: <20220818224218.2399791-1-song@kernel.org>
 <20220818224218.2399791-2-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818224218.2399791-2-song@kernel.org>
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

On Thu, Aug 18, 2022 at 03:42:14PM -0700, Song Liu wrote:
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -372,6 +372,13 @@ int vm_map_pages_zero(struct vm_area_struct *vma, struct page **pages,
>  }
>  EXPORT_SYMBOL(vm_map_pages_zero);
>  
> +void *vmalloc_exec(unsigned long size, unsigned long align)
> +{
> +	return NULL;
> +}

Well that's not so nice for no-mmu systems. Shouldn't we have a
fallback?

> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index effd1ff6a4b4..472287e71bf1 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1583,9 +1592,17 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	va->va_end = addr + size;
>  	va->vm = NULL;
>  
> -	spin_lock(&vmap_area_lock);
> -	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
> -	spin_unlock(&vmap_area_lock);
> +	if (vm_flags & VM_KERNEL_EXEC) {
> +		spin_lock(&free_text_area_lock);
> +		insert_vmap_area(va, &free_text_area_root, &free_text_area_list);
> +		/* update subtree_max_size now as we need this soon */
> +		augment_tree_propagate_from(va);

Sorry, it is not clear to me why its needed only for exec, can you elaborate a
bit more?

> +		spin_unlock(&free_text_area_lock);
> +	} else {
> +		spin_lock(&vmap_area_lock);
> +		insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
> +		spin_unlock(&vmap_area_lock);
> +	}
>  
>  	BUG_ON(!IS_ALIGNED(va->va_start, align));
>  	BUG_ON(va->va_start < vstart);

<-- snip -->

> @@ -3265,6 +3282,97 @@ void *vmalloc(unsigned long size)
>  }
>  EXPORT_SYMBOL(vmalloc);
>  
> +void *vmalloc_exec(unsigned long size, unsigned long align)
> +{
> +	struct vmap_area *va, *tmp;
> +	unsigned long addr;
> +	enum fit_type type;
> +	int ret;
> +
> +	va = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, NUMA_NO_NODE);
> +	if (unlikely(!va))
> +		return ERR_PTR(-ENOMEM);
> +
> +again:
> +	preload_this_cpu_lock(&free_text_area_lock, GFP_KERNEL, NUMA_NO_NODE);
> +	tmp = find_vmap_lowest_match(free_text_area_root.rb_node,
> +				     size, align, 1, false);
> +
> +	if (!tmp) {
> +		unsigned long alloc_size;
> +		void *ptr;
> +
> +		spin_unlock(&free_text_area_lock);
> +
> +		alloc_size = roundup(size, PMD_SIZE * num_online_nodes());
> +		ptr = __vmalloc_node_range(alloc_size, PMD_SIZE, MODULES_VADDR,
> +					   MODULES_END, GFP_KERNEL, PAGE_KERNEL,
> +					   VM_KERNEL_EXEC | VM_ALLOW_HUGE_VMAP | VM_NO_GUARD,
> +					   NUMA_NO_NODE, __builtin_return_address(0));

We can review the guard stuff on the other thread with Peter.

> +		if (unlikely(!ptr)) {
> +			ret = -ENOMEM;
> +			goto err_out;
> +		}
> +		memset(ptr, 0, alloc_size);
> +		set_memory_ro((unsigned long)ptr, alloc_size >> PAGE_SHIFT);
> +		set_memory_x((unsigned long)ptr, alloc_size >> PAGE_SHIFT);

I *really* like that this is now not something users have to muck with thanks!

> +
> +		goto again;
> +	}
> +
> +	addr = roundup(tmp->va_start, align);
> +	type = classify_va_fit_type(tmp, addr, size);
> +	if (WARN_ON_ONCE(type == NOTHING_FIT)) {
> +		addr = -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	ret = adjust_va_to_fit_type(&free_text_area_root, &free_text_area_list,
> +				    tmp, addr, size, type);
> +	if (ret) {
> +		addr = ret;
> +		goto err_out;
> +	}
> +	spin_unlock(&free_text_area_lock);
> +
> +	va->va_start = addr;
> +	va->va_end = addr + size;
> +	va->vm = tmp->vm;
> +
> +	spin_lock(&vmap_area_lock);
> +	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
> +	spin_unlock(&vmap_area_lock);
> +
> +	return (void *)addr;
> +
> +err_out:
> +	spin_unlock(&free_text_area_lock);
> +	return ERR_PTR(ret);
> +}
> +
> +void vfree_exec(const void *addr)
> +{
> +	struct vmap_area *va;
> +
> +	might_sleep();
> +
> +	spin_lock(&vmap_area_lock);
> +	va = __find_vmap_area((unsigned long)addr, vmap_area_root.rb_node);
> +	if (WARN_ON_ONCE(!va)) {
> +		spin_unlock(&vmap_area_lock);
> +		return;
> +	}
> +
> +	unlink_va(va, &vmap_area_root);

Curious why we don't memset to 0 before merge_or_add_vmap_area_augment()?
I realize other code doesn't seem to do it, though.

> +	spin_unlock(&vmap_area_lock);
> +
> +	spin_lock(&free_text_area_lock);
> +	merge_or_add_vmap_area_augment(va,
> +		&free_text_area_root, &free_text_area_list);

I have concern that we can be using precious physically contigous memory
from huge pages to then end up in a situation where we create our own
pool and allow things to be non-contigous afterwards.

I'm starting to suspect that if the allocation is > PAGE_SIZE we just
give it back generally. Otherwise wouldn't the fragmentation cause us
to eventually just eat up most huge pages available? Probably not for
eBPF but if we use this on a system with tons of module insertions /
deletions this seems like it could happen?

  Luis

> +	spin_unlock(&free_text_area_lock);
> +	/* TODO: when the whole vm_struct is not in use, free it */
> +}
> +
>  /**
>   * vmalloc_huge - allocate virtually contiguous memory, allow huge pages
>   * @size:      allocation size
> @@ -3851,7 +3959,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>  			/* It is a BUG(), but trigger recovery instead. */
>  			goto recovery;
>  
> -		ret = adjust_va_to_fit_type(va, start, size, type);
> +		ret = adjust_va_to_fit_type(&free_vmap_area_root, &free_vmap_area_list,
> +					    va, start, size, type);
>  		if (unlikely(ret))
>  			goto recovery;
>  
> -- 
> 2.30.2
> 
