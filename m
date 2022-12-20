Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEBC65266D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbiLTSp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbiLTSpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:45:25 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F522B4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 10:45:24 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id o6so15078753lfi.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 10:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GkTIGn2utZ7uNmGiVZXj3rWNJl0Nf4rSdYfRDQYhHv8=;
        b=kysol0L3DxRu21ppajFTksrX+5/rSipbZx9Uj4dhXR8kYUqfCh7vp1asRkik7HLB+I
         X8KJa2Lxd6RwrO4WegvpfW8SSR2R/9kQkCU8aOzNLApwRW4Mc+Bx0cZlWDdH6PXVrW9X
         Nt8mlV94a49BwUkxIv/yocFJ7NG98H28id+EkDiWTbUxfIfHH8LtDEohw4z7175ZBZc9
         l9FuHbmHNaEG1M2rgS6QqQtfJsh6AsRpT0g3IXEKte5ej2xG/x5OY0Jx4LrRD6sos+n0
         QFCHd67/Rq9AkKOHzPcC5VZRVjl+h1Gi+H4CbwV4gSszQXPdM7T+Y2agPMbxRYuc7+X0
         kYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkTIGn2utZ7uNmGiVZXj3rWNJl0Nf4rSdYfRDQYhHv8=;
        b=LdHXOa1EahE623RU9RnG8CYwhgSVR/pBtH6RU7CoH0ucrJpgOd3JKnAGLOsHrVKsJF
         /QAG+Df0dPz37c60fhrAL5uB/LCOJuXCtewwzD1hkHQSurTTdYtBNpnxXS28qyS6+VIV
         iNLVQEHc2t4ACMzeDQQkFPQujAue/+isLE1hrqVzVnW8jeU7IQbX/B//X+21n2Du3kCf
         i4hwzKaXYRv3m4JB1NDCNlFQ6KhzNINRPbca4tSzqUKp7EKJAleF2L7csXwxpFzKeWSG
         sCWxws5Cli4gNKdYMtKSPqANOl1TTpFjgTfhG3Dr3iFMv8ntdb94sQBJ07eu+plR/DO9
         bh6w==
X-Gm-Message-State: ANoB5plLL9IdfvP/8Ko1ttAPN2vguRxBVLiAhZvMauxjene1SOJMBku/
        l6SjUUfL/PZ588TnP7rxttg=
X-Google-Smtp-Source: AA0mqf46AJ378ecB0DA/Jl0wnVpAMcCaDrio7nPDJXRa+L3FTIUqZN8TF8THNA2DKskl+FBC42oAmg==
X-Received: by 2002:a05:6512:3c84:b0:4b5:8d45:7f32 with SMTP id h4-20020a0565123c8400b004b58d457f32mr18755184lfv.56.1671561922632;
        Tue, 20 Dec 2022 10:45:22 -0800 (PST)
Received: from pc636 (host-90-233-218-120.mobileonline.telia.com. [90.233.218.120])
        by smtp.gmail.com with ESMTPSA id o9-20020a05651205c900b00497aa190523sm1546271lfo.248.2022.12.20.10.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 10:45:22 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 20 Dec 2022 19:45:20 +0100
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/2] mm: vmalloc: Avoid a double lookup of freed VA in a
 tree
Message-ID: <Y6ICwLwk3tPdZIqS@pc636>
References: <20221220182704.181657-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220182704.181657-1-urezki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 07:27:03PM +0100, Uladzislau Rezki (Sony) wrote:
> When a VA is freed over a main path, for example by invoking
> the vfree() function, a tree is accessed two times what is odd:
> 
> vfree():
>   __vunmap()
>     __find_vmap_area()
>   vm_remove_mappings()
>     remove_vm_area()
>       __find_vmap_area()
> 
> __find_vmap_area() are called two times. Fix it by introducing
> a find_unlink_vmap_area() helper that finds and un-links a VA
> from a tree.
> 
> Performance test results on a single CPU:
> 
> - fix_size_alloc_test       loops: 1000000 avg: 476847   usec
> - full_fit_alloc_test       loops: 1000000 avg: 806746   usec
> - long_busy_list_alloc_test loops: 1000000 avg: 13552093 usec
> - random_size_alloc_test    loops: 1000000 avg: 7441322  usec
> - fix_align_alloc_test      loops: 1000000 avg: 1411132  usec
> All test took worker0=87650866284 cycles
> 
> - fix_size_alloc_test       loops: 1000000 avg: 490713   usec
> - full_fit_alloc_test       loops: 1000000 avg: 579162   usec
> - long_busy_list_alloc_test loops: 1000000 avg: 10485448 usec
> - random_size_alloc_test    loops: 1000000 avg: 5824449  usec
> - fix_align_alloc_test      loops: 1000000 avg: 984735   usec
> All test took worker0=67952362802 cycles
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 40 ++++++++++++++++++++++++++++------------
>  1 file changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 9e30f0b39203..0fc38c36e0df 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1825,9 +1825,14 @@ static void free_vmap_area_noflush(struct vmap_area *va)
>  	unsigned long va_start = va->va_start;
>  	unsigned long nr_lazy;
>  
> -	spin_lock(&vmap_area_lock);
> -	unlink_va(va, &vmap_area_root);
> -	spin_unlock(&vmap_area_lock);
> +	/*
> +	 * A free_vmap_block() is left. It is NOT a main free path.
> +	 */
> +	if (!list_empty(&va->list)) {
> +		spin_lock(&vmap_area_lock);
> +		unlink_va(va, &vmap_area_root);
> +		spin_unlock(&vmap_area_lock);
> +	}
>  
>  	nr_lazy = atomic_long_add_return((va->va_end - va->va_start) >>
>  				PAGE_SHIFT, &vmap_lazy_nr);
> @@ -1871,6 +1876,19 @@ struct vmap_area *find_vmap_area(unsigned long addr)
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
> @@ -2236,7 +2254,7 @@ void vm_unmap_ram(const void *mem, unsigned int count)
>  		return;
>  	}
>  
> -	va = find_vmap_area(addr);
> +	va = find_unlink_vmap_area(addr);
>  	BUG_ON(!va);
>  	debug_check_no_locks_freed((void *)va->va_start,
>  				    (va->va_end - va->va_start));
> @@ -2607,21 +2625,16 @@ struct vm_struct *remove_vm_area(const void *addr)
>  
>  	might_sleep();
>  
> -	spin_lock(&vmap_area_lock);
> -	va = __find_vmap_area((unsigned long)addr, &vmap_area_root);
> -	if (va && va->vm) {
> +	va = find_unlink_vmap_area((unsigned long) addr);
> +	if (va) {
>  		struct vm_struct *vm = va->vm;
>  
> -		va->vm = NULL;
> -		spin_unlock(&vmap_area_lock);
> -
>  		kasan_free_module_shadow(vm);
>  		free_unmap_vmap_area(va);
>  
>  		return vm;
>  	}
>  
> -	spin_unlock(&vmap_area_lock);
>  	return NULL;
>  }
>  
> @@ -2690,6 +2703,7 @@ static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
>  static void __vunmap(const void *addr, int deallocate_pages)
>  {
>  	struct vm_struct *area;
> +	struct vmap_area *va;
>  
>  	if (!addr)
>  		return;
> @@ -2698,7 +2712,9 @@ static void __vunmap(const void *addr, int deallocate_pages)
>  			addr))
>  		return;
>  
> -	area = find_vm_area(addr);
> +	va = find_unlink_vmap_area((unsigned long)addr);
> +	area = va->vm;
> +
>  	if (unlikely(!area)) {
>  		WARN(1, KERN_ERR "Trying to vfree() nonexistent vm area (%p)\n",
>  				addr);
> -- 
> 2.30.2
> 
Will send a v2.

--
Uladzislau Rezki
