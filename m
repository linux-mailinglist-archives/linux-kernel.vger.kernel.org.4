Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA77653F22
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbiLVLjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiLVLjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:39:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBF227916
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671709105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D2c/4EKQG1CyLBHCaqgEyAQsuYjRgCOdz9VhRLCzbvE=;
        b=D5U0W3enjRMA/IFyqToQZvgfQ3Mf5tUPgm/vzDsPp9Rm0OMYk9KAXyLiBSOY3W+mtYRkg2
        8rJ+Q2Onhta/UNnVoUTuKLvRjwx0JgVUq6jKvXBpjHGDzIncNCNorDajlzP5tFDgS/0bGH
        GfjxUp5d8MPoMGQcVxBAxXzuizRgUlk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-zksao7wdMiaz9HNIn_nrIQ-1; Thu, 22 Dec 2022 06:38:22 -0500
X-MC-Unique: zksao7wdMiaz9HNIn_nrIQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E186A101A521;
        Thu, 22 Dec 2022 11:38:21 +0000 (UTC)
Received: from localhost (ovpn-12-50.pek2.redhat.com [10.72.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 154C8112132C;
        Thu, 22 Dec 2022 11:38:20 +0000 (UTC)
Date:   Thu, 22 Dec 2022 19:38:14 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH v2 1/3] mm: vmalloc: Avoid of calling __find_vmap_area()
 twise in __vunmap()
Message-ID: <Y6RBpl62gDoJiEu+@MiWiFi-R3L-srv>
References: <20221221174454.1085130-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221174454.1085130-1-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/22 at 06:44pm, Uladzislau Rezki (Sony) wrote:
> Currently __vunmap() path calls __find_vmap_area() two times. One on
> entry to check that area exists, second time inside remove_vm_area()
> function that also performs a new search of VA.
> 
> In order to improvie it from a performance point of view we split
> remove_vm_area() into two new parts:
>   - find_unlink_vmap_area() that does a search and unlink from tree;
>   - __remove_vm_area() that does a removing but without searching.
> 
> In this case there is no any functional change for remove_vm_area()
> whereas vm_remove_mappings(), where a second search happens, switches
> to the __remove_vm_area() variant where already detached VA is passed
> as a parameter, so there is no need to find it again.

I like this patch. This takes off the va->vm clearning too. Finally I
don't need to worry about the va->flags clearing during unmapping
when reading out vmap_block areas.
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
> Reported-by: Roman Gushchin <roman.gushchin@linux.dev>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 66 +++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 42 insertions(+), 24 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 9e30f0b39203..28030d2441f1 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1825,9 +1825,11 @@ static void free_vmap_area_noflush(struct vmap_area *va)
>  	unsigned long va_start = va->va_start;
>  	unsigned long nr_lazy;
>  
> -	spin_lock(&vmap_area_lock);
> -	unlink_va(va, &vmap_area_root);
> -	spin_unlock(&vmap_area_lock);
> +	if (!list_empty(&va->list)) {
> +		spin_lock(&vmap_area_lock);
> +		unlink_va(va, &vmap_area_root);
> +		spin_unlock(&vmap_area_lock);
> +	}
>  
>  	nr_lazy = atomic_long_add_return((va->va_end - va->va_start) >>
>  				PAGE_SHIFT, &vmap_lazy_nr);
> @@ -1871,6 +1873,19 @@ struct vmap_area *find_vmap_area(unsigned long addr)
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
> @@ -2591,6 +2606,20 @@ struct vm_struct *find_vm_area(const void *addr)
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
> @@ -2607,22 +2636,8 @@ struct vm_struct *remove_vm_area(const void *addr)
>  
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
> +	va = find_unlink_vmap_area((unsigned long) addr);
> +	return __remove_vm_area(va);
>  }
>  
>  static inline void set_area_direct_map(const struct vm_struct *area,
> @@ -2637,15 +2652,16 @@ static inline void set_area_direct_map(const struct vm_struct *area,
>  }
>  
>  /* Handle removing and resetting vm mappings related to the vm_struct. */
> -static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
> +static void vm_remove_mappings(struct vmap_area *va, int deallocate_pages)
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
> @@ -2690,6 +2706,7 @@ static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
>  static void __vunmap(const void *addr, int deallocate_pages)
>  {
>  	struct vm_struct *area;
> +	struct vmap_area *va;
>  
>  	if (!addr)
>  		return;
> @@ -2698,19 +2715,20 @@ static void __vunmap(const void *addr, int deallocate_pages)
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
> +	vm_remove_mappings(va, deallocate_pages);
>  
>  	if (deallocate_pages) {
>  		int i;
> -- 
> 2.30.2
> 

