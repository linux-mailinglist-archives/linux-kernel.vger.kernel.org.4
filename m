Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCC36546F9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 21:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbiLVUGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 15:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiLVUGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:06:15 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B381A816
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 12:06:14 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id i7so2719658wrv.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 12:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RZJWly5kBebpQU0okqF7TXgSEM1mQ0IrTkUDNeGNEww=;
        b=M7mgkYdGCUsFmj3AdjvMMkSpff/r8gGvOLnk6G6r28Hmm6hkUoVbsIj5aUScUp32OQ
         Fs4mGUJMO+kVN3fyvnCDNVb3LxeaapmQp1bfm2vq+6LAHIqDSZ0SGE9URDE5tkenwTjK
         UlkK6pMuQZ7yVKf34aqBuNzne12EUN8pryeYtD50paVRIBI8wL2lxAWtkKAIOYtaXczF
         IwpsmCWY0SyErNUpIL8MWCwAdKwfc3ghCMeV4P9jfwNmkn9nqH94p/yTwu2zpQ5XOWN8
         HjlDNt5K1nov6SHUI425oTpjFNhwcum/630m8uZ6BvpJadRAAqbv7Pa2erDJe5UhEEg4
         MuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZJWly5kBebpQU0okqF7TXgSEM1mQ0IrTkUDNeGNEww=;
        b=1l4s0zakW1Z38lKAzWmwQwYGEHln5Nm0M2CYBsho8PRganpvCkIeWCLakwfroZVV1i
         6s6hSEw98N1N5EWqlzV4IlVLE+CK1/cFH2+Lss60ixAPPsr52ZhAc53+e5oAPg8gXtzI
         rOcosAZ4ILjL2dVIXG8f3n8MLjXvnh9eRNqEKG4J/ycl5FCPyNerwf4GsaJy58w2CW++
         of8JDLgDP7Fl8i/3ojH7yraccQyxy1zfeQP0WZ2qGDCPmEK4oGi48eusWimrDbvK3zwl
         TKQPXXRuBnaZiHdokqxauYJHiB7Vh8LMCVQf/k8E9JwM88HkiYuowd3S51HO8H1rEXMW
         pvOQ==
X-Gm-Message-State: AFqh2kqAEykvrqFrQAUnCitfDJr6aK7mmoDszhBwVCaj+X77yOQl7lNc
        hoGlicsvdDDVT4+EGZQiho0=
X-Google-Smtp-Source: AMrXdXve9X9xpjXpQvMkY7Gu8MBnYGGuP6vof+BTZ571QEMPAzD+ZO5QPAtN3FbO8KvlM4Sa/WF3Zg==
X-Received: by 2002:a05:6000:49:b0:242:6777:c7e2 with SMTP id k9-20020a056000004900b002426777c7e2mr3736136wrx.31.1671739572912;
        Thu, 22 Dec 2022 12:06:12 -0800 (PST)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id o2-20020a5d58c2000000b0026a4bb75477sm1348793wrf.28.2022.12.22.12.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 12:06:12 -0800 (PST)
Date:   Thu, 22 Dec 2022 20:06:11 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH v3 1/3] mm: vmalloc: Avoid calling __find_vmap_area()
 twice in __vunmap()
Message-ID: <Y6S4s2PAg6AjYKbP@lucifer>
References: <20221222190022.134380-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222190022.134380-1-urezki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

n Thu, Dec 22, 2022 at 08:00:20PM +0100, Uladzislau Rezki (Sony) wrote:
> Currently the __vunmap() path calls __find_vmap_area() twice. Once on
> entry to check that the area exists, then inside the remove_vm_area()
> function which also performs a new search for the VA.
>
> In order to improvie it from a performance point of view we split
> remove_vm_area() into two new parts:
>   - find_unlink_vmap_area() that does a search and unlink from tree;
>   - __remove_vm_area() that removes without searching.
>
> In this case there is no any functional change for remove_vm_area()
> whereas vm_remove_mappings(), where a second search happens, switches
> to the __remove_vm_area() variant where the already detached VA is
> passed as a parameter, so there is no need to find it again.
>
> Performance wise, i use test_vmalloc.sh with 32 threads doing alloc
> free on a 64-CPUs-x86_64-box:
>
> perf without this patch:
> -   31.41%     0.50%  vmalloc_test/10  [kernel.vmlinux]    [k] __vunmap
>    - 30.92% __vunmap
>       - 17.67% _raw_spin_lock
>            native_queued_spin_lock_slowpath
>       - 12.33% remove_vm_area
>          - 11.79% free_vmap_area_noflush
>             - 11.18% _raw_spin_lock
>                  native_queued_spin_lock_slowpath
>         0.76% free_unref_page
>
> perf with this patch:
> -   11.35%     0.13%  vmalloc_test/14  [kernel.vmlinux]    [k] __vunmap
>    - 11.23% __vunmap
>       - 8.28% find_unlink_vmap_area
>          - 7.95% _raw_spin_lock
>               7.44% native_queued_spin_lock_slowpath
>       - 1.93% free_vmap_area_noflush
>          - 0.56% _raw_spin_lock
>               0.53% native_queued_spin_lock_slowpath
>         0.60% __vunmap_range_noflush
>
> __vunmap() consumes around ~20% less CPU cycles on this test.
>
> v2 -> v3:
> - update commit message;
> - rename the vm_remove_mappings() to the va_remove_mappings();
> - move va-unlinking to the callers so the free_vmap_area_noflush()
>   now expects a VA that has been disconnected;
> - eliminate a local variable in the remove_vm_area().
>
> Reported-by: Roman Gushchin <roman.gushchin@linux.dev>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 77 ++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 47 insertions(+), 30 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 9e30f0b39203..eb91ecaa7277 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1815,9 +1815,9 @@ static void drain_vmap_area_work(struct work_struct *work)
>  }
>
>  /*
> - * Free a vmap area, caller ensuring that the area has been unmapped
> - * and flush_cache_vunmap had been called for the correct range
> - * previously.
> + * Free a vmap area, caller ensuring that the area has been unmapped,
> + * unlinked and flush_cache_vunmap had been called for the correct
> + * range previously.
>   */
>  static void free_vmap_area_noflush(struct vmap_area *va)
>  {
> @@ -1825,9 +1825,8 @@ static void free_vmap_area_noflush(struct vmap_area *va)
>  	unsigned long va_start = va->va_start;
>  	unsigned long nr_lazy;
>
> -	spin_lock(&vmap_area_lock);
> -	unlink_va(va, &vmap_area_root);
> -	spin_unlock(&vmap_area_lock);
> +	if (WARN_ON_ONCE(!list_empty(&va->list)))
> +		return;
>
>  	nr_lazy = atomic_long_add_return((va->va_end - va->va_start) >>
>  				PAGE_SHIFT, &vmap_lazy_nr);
> @@ -1871,6 +1870,19 @@ struct vmap_area *find_vmap_area(unsigned long addr)
>  	return va;
>  }
>
> +static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
> +{
> +	struct vmap_area *va;
> +
> +	spin_lock(&vmap_area_lock);
> +	va = __find_vmap_area(addr, &vmap_area_root);
> +	if (va)
> +		unlink_va(va, &vmap_area_root);
> +	spin_unlock(&vmap_area_lock);
> +
> +	return va;
> +}
> +
>  /*** Per cpu kva allocator ***/
>
>  /*
> @@ -2015,6 +2027,10 @@ static void free_vmap_block(struct vmap_block *vb)
>  	tmp = xa_erase(&vmap_blocks, addr_to_vb_idx(vb->va->va_start));
>  	BUG_ON(tmp != vb);
>
> +	spin_lock(&vmap_area_lock);
> +	unlink_va(vb->va, &vmap_area_root);
> +	spin_unlock(&vmap_area_lock);
> +
>  	free_vmap_area_noflush(vb->va);
>  	kfree_rcu(vb, rcu_head);
>  }
> @@ -2591,6 +2607,20 @@ struct vm_struct *find_vm_area(const void *addr)
>  	return va->vm;
>  }
>
> +static struct vm_struct *__remove_vm_area(struct vmap_area *va)
> +{
> +	struct vm_struct *vm;
> +
> +	if (!va || !va->vm)
> +		return NULL;
> +
> +	vm = va->vm;
> +	kasan_free_module_shadow(vm);
> +	free_unmap_vmap_area(va);
> +
> +	return vm;
> +}
> +
>  /**
>   * remove_vm_area - find and remove a continuous kernel virtual area
>   * @addr:	    base address
> @@ -2603,26 +2633,10 @@ struct vm_struct *find_vm_area(const void *addr)
>   */
>  struct vm_struct *remove_vm_area(const void *addr)
>  {
> -	struct vmap_area *va;
> -
>  	might_sleep();
>
> -	spin_lock(&vmap_area_lock);
> -	va = __find_vmap_area((unsigned long)addr, &vmap_area_root);
> -	if (va && va->vm) {
> -		struct vm_struct *vm = va->vm;
> -
> -		va->vm = NULL;
> -		spin_unlock(&vmap_area_lock);
> -
> -		kasan_free_module_shadow(vm);
> -		free_unmap_vmap_area(va);
> -
> -		return vm;
> -	}
> -
> -	spin_unlock(&vmap_area_lock);
> -	return NULL;
> +	return __remove_vm_area(
> +		find_unlink_vmap_area((unsigned long) addr));
>  }
>
>  static inline void set_area_direct_map(const struct vm_struct *area,
> @@ -2636,16 +2650,17 @@ static inline void set_area_direct_map(const struct vm_struct *area,
>  			set_direct_map(area->pages[i]);
>  }
>
> -/* Handle removing and resetting vm mappings related to the vm_struct. */
> -static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
> +/* Handle removing and resetting vm mappings related to the VA's vm_struct. */
> +static void va_remove_mappings(struct vmap_area *va, int deallocate_pages)
>  {
> +	struct vm_struct *area = va->vm;
>  	unsigned long start = ULONG_MAX, end = 0;
>  	unsigned int page_order = vm_area_page_order(area);
>  	int flush_reset = area->flags & VM_FLUSH_RESET_PERMS;
>  	int flush_dmap = 0;
>  	int i;
>
> -	remove_vm_area(area->addr);
> +	__remove_vm_area(va);
>
>  	/* If this is not VM_FLUSH_RESET_PERMS memory, no need for the below. */
>  	if (!flush_reset)
> @@ -2690,6 +2705,7 @@ static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
>  static void __vunmap(const void *addr, int deallocate_pages)
>  {
>  	struct vm_struct *area;
> +	struct vmap_area *va;
>
>  	if (!addr)
>  		return;
> @@ -2698,19 +2714,20 @@ static void __vunmap(const void *addr, int deallocate_pages)
>  			addr))
>  		return;
>
> -	area = find_vm_area(addr);
> -	if (unlikely(!area)) {
> +	va = find_unlink_vmap_area((unsigned long)addr);
> +	if (unlikely(!va)) {
>  		WARN(1, KERN_ERR "Trying to vfree() nonexistent vm area (%p)\n",
>  				addr);
>  		return;
>  	}
>
> +	area = va->vm;
>  	debug_check_no_locks_freed(area->addr, get_vm_area_size(area));
>  	debug_check_no_obj_freed(area->addr, get_vm_area_size(area));
>
>  	kasan_poison_vmalloc(area->addr, get_vm_area_size(area));
>
> -	vm_remove_mappings(area, deallocate_pages);
> +	va_remove_mappings(va, deallocate_pages);
>
>  	if (deallocate_pages) {
>  		int i;
> --
> 2.30.2
>

All looks good to me! Great work! Feel free to add the below to all patches in series:-

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
