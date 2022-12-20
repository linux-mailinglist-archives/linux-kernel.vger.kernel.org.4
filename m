Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0063D652508
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 17:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbiLTQ4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 11:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiLTQz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 11:55:59 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832CC1176
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 08:55:57 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id q2so3753687ljp.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 08:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RV2b+N4EY8X7AP+wxiTDOB1h8DJAj0YpeZrRZGqmAGU=;
        b=igIjFRYBlJmWR+sZzIcsLQyE8jdrcsZ97Cj+D0lh8XfZDlJVuOVWRPQt09Trny3eXg
         bg2r5Razpu5YSMx9vnnA7dWArKG/M1TKW/pRjYwznlxc47EnxLyCIvEFR7S+IpfqW6wA
         jh3FMFMBbPDbKyRZSxiiojjYCT66FLvvfoyGbTbpMXeO+Rfg0qMOhpPUrK131Ptn9K3x
         iwULuAoKCHJJM346zXtDA5zd6Yeoe9ZSs5EKzGS/2kNLrW5lFF3UJkeVBK3HPgZRh/gE
         BCeZc1TQ9C2mek0+Pej07us+LIxQ2EvvnoIrH7joXWeS5wi/PwfpGQhrluFFh3q/LL0o
         xvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RV2b+N4EY8X7AP+wxiTDOB1h8DJAj0YpeZrRZGqmAGU=;
        b=Bv/oYSNMIqQ0ITpZiIS6wDgjSiU/xXID419WkBjt/g42wdumfgkqG3616zjXe7vQAg
         fiT9HPblReGGm4ex5r1N5YAv2ZPpvNfb617a3vMPoISdpK3YaY3Nus79Y8VsjSjCH0Xf
         NNinbielJFwvEypwfMwKfkuALwaMcHrzzUpeUVq3h/PTOKQNA1hsF44OwZq1+cl2dgRV
         GPnGHjOBt9WrFx6z+pBK7suDvTlIAyDNRItOSz7VNpcZ1J+TF0dgjuaPTkwMS2F2XflD
         iE3GqFtAakAZTO1qvsfKZzKrB+qimLAPHqYXUYiu3rvKBmFmT3YtuWG4y5J3u1PuZaGJ
         k7jw==
X-Gm-Message-State: ANoB5pnI7O9BGLSYAumSh9kfQiKu1SWFRw92FJ9fPUVCyT/UaZgSeTnQ
        Wyi4zPnDIN5bxKTeFpIr2qY=
X-Google-Smtp-Source: AA0mqf4k8IpjOpJrh6S3u5p9mOLpoXNiRbJdsIh5YoWG5Dxh22i4epGSO1G9gwynRJDnANzyqfU1Kg==
X-Received: by 2002:a05:651c:1145:b0:277:744:1f34 with SMTP id h5-20020a05651c114500b0027707441f34mr18843183ljo.25.1671555355739;
        Tue, 20 Dec 2022 08:55:55 -0800 (PST)
Received: from pc636 (host-90-233-218-120.mobileonline.telia.com. [90.233.218.120])
        by smtp.gmail.com with ESMTPSA id t23-20020a2e8e77000000b00279e618444dsm1061417ljk.122.2022.12.20.08.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 08:55:55 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 20 Dec 2022 17:55:53 +0100
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, urezki@gmail.com,
        stephen.s.brennan@oracle.com, willy@infradead.org,
        akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v2 2/7] mm/vmalloc.c: add flags to mark vm_map_ram area
Message-ID: <Y6HpGayyQZH7U7Fd@pc636>
References: <20221217015435.73889-1-bhe@redhat.com>
 <20221217015435.73889-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221217015435.73889-3-bhe@redhat.com>
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
A normal "free" path sets it to NULL in order to prevent a double-free
of same VA. We can avoid of touching the va->vm if needed and do an unlink
on entry in the remove_vm_area() when a lock is taken to find an area.

Will it help you?

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
>  mm/vmalloc.c            | 22 +++++++++++++++++-----
>  2 files changed, 18 insertions(+), 5 deletions(-)
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
> index 5d3fd3e6fe09..190f29bbaaa7 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1586,7 +1586,8 @@ preload_this_cpu_lock(spinlock_t *lock, gfp_t gfp_mask, int node)
>  static struct vmap_area *alloc_vmap_area(unsigned long size,
>  				unsigned long align,
>  				unsigned long vstart, unsigned long vend,
> -				int node, gfp_t gfp_mask)
> +				int node, gfp_t gfp_mask,
> +				unsigned long va_flags)
>  {
>  	struct vmap_area *va;
>  	unsigned long freed;
> @@ -1630,6 +1631,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	va->va_start = addr;
>  	va->va_end = addr + size;
>  	va->vm = NULL;
> +	va->flags = va_flags;
>  
>  	spin_lock(&vmap_area_lock);
>  	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
> @@ -1887,6 +1889,10 @@ struct vmap_area *find_vmap_area(unsigned long addr)
>  
>  #define VMAP_BLOCK_SIZE		(VMAP_BBMAP_BITS * PAGE_SIZE)
>  
> +#define VMAP_RAM		0x1
> +#define VMAP_BLOCK		0x2
> +#define VMAP_FLAGS_MASK		0x3
> 
Maybe to rename a VMAP_BLOCK to something like VMAP_BLOCK_RESERVED or
VMAP_PER_CPU_BLOCK?

>  struct vmap_block_queue {
>  	spinlock_t lock;
>  	struct list_head free;
> @@ -1962,7 +1968,8 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  
>  	va = alloc_vmap_area(VMAP_BLOCK_SIZE, VMAP_BLOCK_SIZE,
>  					VMALLOC_START, VMALLOC_END,
> -					node, gfp_mask);
> +					node, gfp_mask,
> +					VMAP_RAM|VMAP_BLOCK);
>
A new_vmap_block() is for a per-cpu path. As far as i see the VMAP_BLOCK
flag is used to mark a VA that corresponds to a reserved per-cpu free area.

Whereas a VMAP_RAM is for VA that was obtained over per-cpu path but
over alloc_vmap_area() thus a VA should be read out over "busy" tree
directly.

Why do you need to set here both VMAP_RAM and VMAP_BLOCK?

>  	if (IS_ERR(va)) {
>  		kfree(vb);
>  		return ERR_CAST(va);
> @@ -2229,8 +2236,12 @@ void vm_unmap_ram(const void *mem, unsigned int count)
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
>
Agree with Lorenzo. BUG_ON() should be out of spinlock(). Furthermore
i think it makes sense to go with WARN_ON_ONCE() and do not kill a system.
Instead emit a warning and bailout.

What do you think? Maybe separate patch for it?

>  				    (va->va_end - va->va_start));
>  	free_unmap_vmap_area(va);
> @@ -2265,7 +2276,8 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
>  	} else {
>  		struct vmap_area *va;
>  		va = alloc_vmap_area(size, PAGE_SIZE,
> -				VMALLOC_START, VMALLOC_END, node, GFP_KERNEL);
> +				VMALLOC_START, VMALLOC_END,
> +				node, GFP_KERNEL, VMAP_RAM);
>  		if (IS_ERR(va))
>  			return NULL;
>  
> @@ -2505,7 +2517,7 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
>  	if (!(flags & VM_NO_GUARD))
>  		size += PAGE_SIZE;
>  
> -	va = alloc_vmap_area(size, align, start, end, node, gfp_mask);
> +	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0);
>  	if (IS_ERR(va)) {
>  		kfree(area);
>  		return NULL;
>
I know we have already discussed the new parameter. But what if we just
use atomic_set operation to mark VA as either vmap-ram or vmap-block?

As for alloc_vmap_area() we set it just as zero.

--
Uladzislau Rezki
