Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356626428D3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiLEM4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiLEM4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:56:35 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1951A3BF
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 04:56:34 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id z4so13418601ljq.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 04:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MNizMxTAJQcCerVNPojMjVYQUThcKeI/6F+iAZVM61E=;
        b=LoM4ZvQsmSIuu2v5/WOVXLHUPhjPjZKvAvKw7ppYq7FOFTyo8eFQ40euk6uUal8ca/
         f4FcDS2k74EaENuC8SKrdfkO4r4zI94k6AANBExnMb/NGNbUc5Q/g3SmrZBM++rc2fRi
         Mvq/FgyW20b7S/QDS2u9mkIjfZhvwLX+GDHXtW1Dc/fDx/H/gJMe/qWedSoBDajI6OCa
         Iy1zXCVFUpz+u3JlTe5WYx5fjg8jDEg6jL7RBK/aZ8tfso/juT1/lWrf3m3F1uA/XWUD
         iUANfPIFLzASlDjKPtKEr/AwYdzMIBsl3l1xebHJfWzcKYdcxjqU5/8dmSHEGLXG/LI2
         Bckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNizMxTAJQcCerVNPojMjVYQUThcKeI/6F+iAZVM61E=;
        b=n0g9dvWkrEfByXMkhJNqpiTQNWvTeHVZIssTn6NeTFixO3/9iWW70BOGhWEbg6DokT
         yARg1Z2ikIQA3n0hZBMKuh+UHDZQDB5mSsNe6YfpOqWcttFUjJZtaY/xPR3Ydf67y3na
         qJZDaVzh+ljdrgawhEcGQApF9s4Y1U+J9tXESf01q0BK4Dqi9dw52t1kFe0nlzh2QICq
         fWtivoXBej9/kjPLRJ08p/5iprKsT5COAH1oO6GAZg/2ypijPQUQxEhhApuQrQoHtne1
         Exe1CLaiqIzafO5N1OBoVLf18qTXwkdJOlY3fYnXQENQ8phOmsh5WApSfR6FYMMoY3c5
         lkng==
X-Gm-Message-State: ANoB5plOEciXg0YakKQX8PZgK2mIBH+5IOVJoHB+ot4QSOh0KgySbzZm
        WCvSYcZDRpgTODptCKmRPZk=
X-Google-Smtp-Source: AA0mqf6PmvS8jf6HU82mhQ98ZgGkGOidYsoFHSWwPdtJQpFz9zyG591eeD+XLTWGRozdUMVBjYZgdQ==
X-Received: by 2002:a2e:a9a7:0:b0:26e:2de:49ad with SMTP id x39-20020a2ea9a7000000b0026e02de49admr21169013ljq.511.1670244992807;
        Mon, 05 Dec 2022 04:56:32 -0800 (PST)
Received: from pc636 (host-90-235-25-230.mobileonline.telia.com. [90.235.25.230])
        by smtp.gmail.com with ESMTPSA id s9-20020ac24649000000b004b5634f9b9dsm878455lfo.115.2022.12.05.04.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 04:56:32 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 5 Dec 2022 13:56:29 +0100
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stephen.s.brennan@oracle.com, urezki@gmail.com,
        willy@infradead.org, akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v1 2/7] mm/vmalloc.c: add flags to mark vm_map_ram area
Message-ID: <Y43qfdseyq0zizJO@pc636>
References: <20221204013046.154960-1-bhe@redhat.com>
 <20221204013046.154960-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221204013046.154960-3-bhe@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Through vmalloc API, a virtual kernel area is reserved for physical
> address mapping. And vmap_area is used to track them, while vm_struct
> is allocated to associate with the vmap_area to store more information
> and passed out.
> 
> However, area reserved via vm_map_ram() is an exception. It doesn't have
> vm_struct to associate with vmap_area. And we can't recognize the
> vmap_area with '->vm == NULL' as a vm_map_ram() area because the normal
> freeing path will set va->vm = NULL before unmapping, please see
> function remove_vm_area().
> 
> Meanwhile, there are two types of vm_map_ram area. One is the whole
> vmap_area being reserved and mapped at one time; the other is the
> whole vmap_area with VMAP_BLOCK_SIZE size being reserved, while mapped
> into split regions with smaller size several times via vb_alloc().
> 
> To mark the area reserved through vm_map_ram(), add flags field into
> struct vmap_area. Bit 0 indicates whether it's a vm_map_ram area,
> while bit 1 indicates whether it's a vmap_block type of vm_map_ram
> area.
> 
> This is a preparatoin for later use.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  include/linux/vmalloc.h |  1 +
>  mm/vmalloc.c            | 18 +++++++++++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 096d48aa3437..69250efa03d1 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -76,6 +76,7 @@ struct vmap_area {
>  		unsigned long subtree_max_size; /* in "free" tree */
>  		struct vm_struct *vm;           /* in "busy" tree */
>  	};
> +	unsigned long flags; /* mark type of vm_map_ram area */
>  };
>  
>  /* archs that select HAVE_ARCH_HUGE_VMAP should override one or more of these */
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 5d3fd3e6fe09..d6f376060d83 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1815,6 +1815,7 @@ static void free_vmap_area_noflush(struct vmap_area *va)
>  
>  	spin_lock(&vmap_area_lock);
>  	unlink_va(va, &vmap_area_root);
> +	va->flags = 0;
>  	spin_unlock(&vmap_area_lock);
>  
This is not a good place to set flags to zero. It looks to me like
corner and kind of specific.


>  	nr_lazy = atomic_long_add_return((va->va_end - va->va_start) >>
> @@ -1887,6 +1888,10 @@ struct vmap_area *find_vmap_area(unsigned long addr)
>  
>  #define VMAP_BLOCK_SIZE		(VMAP_BBMAP_BITS * PAGE_SIZE)
>  
> +#define VMAP_RAM		0x1
> +#define VMAP_BLOCK		0x2
> +#define VMAP_FLAGS_MASK		0x3
> +
>  struct vmap_block_queue {
>  	spinlock_t lock;
>  	struct list_head free;
> @@ -1967,6 +1972,9 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  		kfree(vb);
>  		return ERR_CAST(va);
>  	}
> +	spin_lock(&vmap_area_lock);
> +	va->flags = VMAP_RAM|VMAP_BLOCK;
> +	spin_unlock(&vmap_area_lock);
>
The per-cpu code was created as a fast per-cpu allocator because of high
vmalloc lock contention. If possible we should avoid of locking of the
vmap_area_lock. Because it has a high contention.

>  
>  	vaddr = vmap_block_vaddr(va->va_start, 0);
>  	spin_lock_init(&vb->lock);
> @@ -2229,8 +2237,12 @@ void vm_unmap_ram(const void *mem, unsigned int count)
>  		return;
>  	}
>  
> -	va = find_vmap_area(addr);
> +	spin_lock(&vmap_area_lock);
> +	va = __find_vmap_area((unsigned long)addr, &vmap_area_root);
>  	BUG_ON(!va);
> +	if (va)
> +		va->flags &= ~VMAP_RAM;
> +	spin_unlock(&vmap_area_lock);
>  	debug_check_no_locks_freed((void *)va->va_start,
>  				    (va->va_end - va->va_start));
>  	free_unmap_vmap_area(va);
> @@ -2269,6 +2281,10 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
>  		if (IS_ERR(va))
>  			return NULL;
>  
> +		spin_lock(&vmap_area_lock);
> +		va->flags = VMAP_RAM;
> +		spin_unlock(&vmap_area_lock);
> +
>
Same here.

--
Uladzislau Rezki
