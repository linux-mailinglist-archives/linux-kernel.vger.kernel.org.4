Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667416536D5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 20:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbiLUTLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 14:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbiLUTLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 14:11:47 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B72F24BF8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 11:11:45 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 131-20020a1c0289000000b003d35acb0f9fso2285953wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 11:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JbYuuxURZ+HULop4cvQjD1UbE1sTZhJCtl/bY00O3aI=;
        b=A/RS840oCo/HZ9cxbMliBu6RhaOi9m1RWH/Qky05PoNcHhidv4Xd+qg09V7VqgGdt0
         KTD7LAaRdpOu4y9GbtZoHACH6vRLl6d86yWO9PIdm+ZVLTcs01HjNdQwMo4mJX5WVjB2
         TN3fkt2iprul9zqkgT9u0zZ8nhOY+O+/S1sCpFa30nLNCPxZ6Jzm3f9smrf5hTEkRds7
         0TVS/i2GLdYAHXZmycv7uOKlXbm89pzQvMZZ35IU6PmZx3fpKCeQLX0bvB71fIuuDfbh
         5ZK7mskzbu7vAs37ZFVCS7V+9tZd9d8ALRTSSumlgQLyebSfoLf+sIqoidEDhXx3oo9g
         q4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbYuuxURZ+HULop4cvQjD1UbE1sTZhJCtl/bY00O3aI=;
        b=L7a+Gni/Pk7T2O4W0yCTtYFjMEVLB3cVB1kUQFbLq+t0UxWsICUwnTZ2AP/fHWfkMg
         L8OUnq49nVt4cF/KhFDrYZ8g/deXoGcOb6ONByX6LU4ftDEVtf+eqUHbH1aQ2+/C+yP3
         Oz3oi/5CQ9c/GvHl1KH+Oao6mxFS6vsTXK4IVc8ORZvfNSq7+HuRxndytnhxACoYkj7B
         iGqR/r87HiW11LfkVWeEc9XKesMITOMbsttvtz0LHdJP53YVbt7+Wpn5Qrb8ahgqzgXI
         j8kNHXBZUx5v2/w7v/lMjU4wVZyDHtSlm62P1xOvpef7HB35PTBD6ygk5qWQRCNC/9wS
         n+Mg==
X-Gm-Message-State: AFqh2kqvld1tmSMSkWtKIWMad/CvQvvp9EjJHhtVlCf38W8GEY07LngM
        KL0FHYOxZvOqMIbxISHRPgU=
X-Google-Smtp-Source: AMrXdXsIMx+E0i6YC6gy8hrmfbrNNhLohFajh26CEV8oZb/iCssXF/Sg8lXsGo1/itTYGZDk6gb26w==
X-Received: by 2002:a05:600c:1509:b0:3d2:17a5:17fe with SMTP id b9-20020a05600c150900b003d217a517femr2540935wmg.18.1671649904309;
        Wed, 21 Dec 2022 11:11:44 -0800 (PST)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id bu13-20020a056000078d00b002422816aa25sm18648497wrb.108.2022.12.21.11.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 11:11:43 -0800 (PST)
Date:   Wed, 21 Dec 2022 19:11:42 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH v2 1/3] mm: vmalloc: Avoid of calling __find_vmap_area()
 twise in __vunmap()
Message-ID: <Y6Nabg5g5gbD6J6K@lucifer>
References: <20221221174454.1085130-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221174454.1085130-1-urezki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some pedantic grammar/spelling stuff:-

(I know it can be a little annoying to get grammatical suggestions so I do hope
that it isn't too irritating!)

For the Subject line:-
'mm: vmalloc: Avoid of calling __find_vmap_area() twise in __vunmap()' ->
'mm: vmalloc: Avoid calling __find_vmap_area() twice in __vunmap()'

On Wed, Dec 21, 2022 at 06:44:52PM +0100, Uladzislau Rezki (Sony) wrote:
> Currently __vunmap() path calls __find_vmap_area() two times. One on
> entry to check that area exists, second time inside remove_vm_area()
> function that also performs a new search of VA.

Perhaps slightly tweak to:-

"Currently the __vunmap() path calls __find_vmap_area() twice. Once on entry
 to check that the area exists, then inside the remove_vm_area() function
 which also performs a new search for the VA."

>
> In order to improvie it from a performance point of view we split
> remove_vm_area() into two new parts:
>   - find_unlink_vmap_area() that does a search and unlink from tree;
>   - __remove_vm_area() that does a removing but without searching.

'that does a removing but without searching' reads better I think as
'that removes without searching'.

>
> In this case there is no any functional change for remove_vm_area()
> whereas vm_remove_mappings(), where a second search happens, switches
> to the __remove_vm_area() variant where already detached VA is passed
> as a parameter, so there is no need to find it again.
>

'where already detached VA' -> 'where the already detached VA' as a minor nit
here!

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

Very nice, amazing work!

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

Do we want to do the same in free_vmap_area()?

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

Really nice separation of concerns and cleanup.

>
>  static inline void set_area_direct_map(const struct vm_struct *area,
> @@ -2637,15 +2652,16 @@ static inline void set_area_direct_map(const struct vm_struct *area,
>  }
>
>  /* Handle removing and resetting vm mappings related to the vm_struct. */
> -static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
> +static void vm_remove_mappings(struct vmap_area *va, int deallocate_pages)

Perhaps rename this to va_remove_mappings() or vmap_area_remove_mappings() since
it is now explicitly accepting a vmap_area rather than vm_struct?

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

Feels like it's getting a bit confusing with 'va' representing vmap_area and
'area' which represents... vm_struct (this file has a bunch of naming
inconsistencies like this actually), perhaps rename this to 'vm'?

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

Other than some pendatic points about grammar/naming this looks really good!
