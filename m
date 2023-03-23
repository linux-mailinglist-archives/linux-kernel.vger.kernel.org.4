Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038A46C7287
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 22:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjCWVqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 17:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCWVqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 17:46:06 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F5290
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 14:46:03 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id y14so22031778wrq.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 14:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679607962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vm3BmmfuBc1fsQRJFUMOsryahKUhHqNWVOs1SaZyGCs=;
        b=XqngBCcgSzCY+OjkJHXKfbD5QNeGvZrVzpqu3rdUk15gH3tgDdbu0Vfu9FCjZmY+Qf
         gx/FH2BXTroFbgxdgOkJq+6XxojY1MHaM7zRMvMo1T/VyA8cRvk9HFEcTI3RJUyV7LWt
         3v/pqAEVbiwjixuEkq7hqVzQEblkpqd1LyFT/25eFGx8IZR0F5ddD0qhBgm+b/t9iBiV
         cMSx1LAaXfmxsttcCYqaCbL5t289/PiJH9nXP7N29Ioz8wnscOB+BVd/hfH4+e1l/a4G
         bBl+NN9ixFmf1zU/RQXRWARl5uTHzmtZRZz1d4iLBELAZi96YL+CgmLm2QIA3I4PC0L1
         2hwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679607962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vm3BmmfuBc1fsQRJFUMOsryahKUhHqNWVOs1SaZyGCs=;
        b=A/gF/VJ2l2S4Oi1RjCp4xUh1FnkEGu5xauYc7l0BOyefv8D+8HXzRbHL/zFcFE5jlT
         1nZ88LlKKG/V3fwph2sxUYybsfQn8Y7A9QGMmha+E6zuwgWZVmnM5KPOMH8E8f//QnD9
         DKexsxoeHaYchFOFB2ASUuZFDtWkgK/D6nJrGNCzCCKcEYpNo1ERx+YgEYO+a3eKMgZH
         Ku7UTow1ifneovyVmBDaLRaZHbwAqvsXPhA73igpFVB9i47zK69m/669C+PCMYbbGMXt
         Cn2YQAe1m+gaWqhnRI0RrxcADMLI/Yt7lS/K3gUHj6G4FfwQA6ckP0Owt4JfeX66Vo4+
         mtYA==
X-Gm-Message-State: AAQBX9cMEtoysgWzr549Fb8eNJtq2FpS6wY527o6lcsctbDpGfWTCCJn
        8c4AIp79Pwj1l6M4+x4lT8c=
X-Google-Smtp-Source: AKy350ayEU8oKTHJ9o2jNWejT0uNfgUtwA4/qgWRXxYhZYYSSHwQIUjPoB9gB3bg6cX30WPRHV1Hyw==
X-Received: by 2002:adf:fc8e:0:b0:2d9:16f9:aee3 with SMTP id g14-20020adffc8e000000b002d916f9aee3mr467650wrr.14.1679607962034;
        Thu, 23 Mar 2023 14:46:02 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id e11-20020a5d65cb000000b002c55de1c72bsm17003870wrw.62.2023.03.23.14.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 14:46:01 -0700 (PDT)
Date:   Thu, 23 Mar 2023 21:46:00 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/1] mm: vmalloc: Remove a global vmap_blocks xarray
Message-ID: <9ef9690d-cd79-4024-b7f1-eae2916cf5a2@lucifer.local>
References: <20230323192111.1501308-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323192111.1501308-1-urezki@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 08:21:11PM +0100, Uladzislau Rezki (Sony) wrote:
> A global vmap_blocks-xarray array can be contented under
> heavy usage of the vm_map_ram()/vm_unmap_ram() APIs. The
> lock_stat shows that a "vmap_blocks.xa_lock" lock is a
> second in a top-list when it comes to contentions:
>
> <snip>
> ----------------------------------------
> class name con-bounces contentions ...
> ----------------------------------------
> vmap_area_lock:         2554079 2554276 ...
>   --------------
>   vmap_area_lock        1297948  [<00000000dd41cbaa>] alloc_vmap_area+0x1c7/0x910
>   vmap_area_lock        1256330  [<000000009d927bf3>] free_vmap_block+0x4a/0xe0
>   vmap_area_lock              1  [<00000000c95c05a7>] find_vm_area+0x16/0x70
>   --------------
>   vmap_area_lock        1738590  [<00000000dd41cbaa>] alloc_vmap_area+0x1c7/0x910
>   vmap_area_lock         815688  [<000000009d927bf3>] free_vmap_block+0x4a/0xe0
>   vmap_area_lock              1  [<00000000c1d619d7>] __get_vm_area_node+0xd2/0x170
>
> vmap_blocks.xa_lock:    862689  862698 ...
>   -------------------
>   vmap_blocks.xa_lock   378418    [<00000000625a5626>] vm_map_ram+0x359/0x4a0
>   vmap_blocks.xa_lock   484280    [<00000000caa2ef03>] xa_erase+0xe/0x30
>   -------------------
>   vmap_blocks.xa_lock   576226    [<00000000caa2ef03>] xa_erase+0xe/0x30
>   vmap_blocks.xa_lock   286472    [<00000000625a5626>] vm_map_ram+0x359/0x4a0
> ...
> <snip>
>
> that is a result of running vm_map_ram()/vm_unmap_ram() in
> a loop. The test creates 64(on 64 CPUs system) threads and
> each one maps/unmaps 1 page.
>
> After this change the "xa_lock" can be considered as a noise
> in the same test condition:
>
> <snip>
> ...
> &xa->xa_lock#1:         10333 10394 ...
>   --------------
>   &xa->xa_lock#1        5349      [<00000000bbbc9751>] xa_erase+0xe/0x30
>   &xa->xa_lock#1        5045      [<0000000018def45d>] vm_map_ram+0x3a4/0x4f0
>   --------------
>   &xa->xa_lock#1        7326      [<0000000018def45d>] vm_map_ram+0x3a4/0x4f0
>   &xa->xa_lock#1        3068      [<00000000bbbc9751>] xa_erase+0xe/0x30
> ...
> <snip>
>

Nice! Really good to see contention reduced, but in addition I'm a huge fan
of us removing the global state in vmalloc and this is a good start.

I've noticed a small perf regression after 3 runs of ./test_vmalloc.sh
performance from an average of 119356136169 cycles to 120404645782 or +0.9%
but this doesn't seem especially egregious.

> This patch does not fix vmap_area_lock/free_vmap_area_lock and
> purge_vmap_area_lock bottle-necks, it is rather a separate rework.
>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 50 ++++++++++++++++++++++++++------------------------
>  1 file changed, 26 insertions(+), 24 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 978194dc2bb8..13b5342bed9a 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1911,6 +1911,7 @@ static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
>  struct vmap_block_queue {
>  	spinlock_t lock;
>  	struct list_head free;
> +	struct xarray vmap_blocks;
>  };
>
>  struct vmap_block {
> @@ -1927,25 +1928,18 @@ struct vmap_block {
>  /* Queue of free and dirty vmap blocks, for allocation and flushing purposes */
>  static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
>
> -/*
> - * XArray of vmap blocks, indexed by address, to quickly find a vmap block
> - * in the free path. Could get rid of this if we change the API to return a
> - * "cookie" from alloc, to be passed to free. But no big deal yet.
> - */

Doesn't this comment still apply? Or is the idea of returning the "cookie"
not really viable?

> -static DEFINE_XARRAY(vmap_blocks);
> -
> -/*
> - * We should probably have a fallback mechanism to allocate virtual memory
> - * out of partially filled vmap blocks. However vmap block sizing should be
> - * fairly reasonable according to the vmalloc size, so it shouldn't be a
> - * big problem.
> - */

Again, is this comment no longer relevant?

> +static struct vmap_block_queue *
> +addr_to_vbq(unsigned long addr)
> +{
> +	int cpu = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> +	return &per_cpu(vmap_block_queue, cpu);
> +}

Andrew's already commented on this, so I won't dwell but it does seem odd
to subdivide by number of possible CPUs rather than just use the actual
CPU. I guess your response to his question will also answer mine :)

>
> -static unsigned long addr_to_vb_idx(unsigned long addr)
> +static unsigned long
> +addr_to_vb_va_start(unsigned long addr)
>  {
> -	addr -= VMALLOC_START & ~(VMAP_BLOCK_SIZE-1);
> -	addr /= VMAP_BLOCK_SIZE;
> -	return addr;
> +	/* A start address of block an address belongs to. */

A nit, but might be worth referring to the assert in vmap_block_vaddr(), as
this comment seems a bit redundant otherwise as it is implied by the code
it comments.

> +	return rounddown(addr, VMAP_BLOCK_SIZE);
>  }
>
>  static void *vmap_block_vaddr(unsigned long va_start, unsigned long pages_off)
> @@ -1953,7 +1947,7 @@ static void *vmap_block_vaddr(unsigned long va_start, unsigned long pages_off)
>  	unsigned long addr;
>
>  	addr = va_start + (pages_off << PAGE_SHIFT);
> -	BUG_ON(addr_to_vb_idx(addr) != addr_to_vb_idx(va_start));
> +	BUG_ON(addr_to_vb_va_start(addr) != addr_to_vb_va_start(va_start));

Maybe nitty, but perhaps better to WARN_ON() here to avoid BUG_ON proliferation?

And can't this be the below?

WARN_ON(addr_to_vb_va_start(addr) != va_start);

>  	return (void *)addr;
>  }
>
> @@ -1970,7 +1964,6 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  	struct vmap_block_queue *vbq;
>  	struct vmap_block *vb;
>  	struct vmap_area *va;
> -	unsigned long vb_idx;
>  	int node, err;
>  	void *vaddr;
>
> @@ -2003,8 +1996,8 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  	bitmap_set(vb->used_map, 0, (1UL << order));
>  	INIT_LIST_HEAD(&vb->free_list);
>
> -	vb_idx = addr_to_vb_idx(va->va_start);
> -	err = xa_insert(&vmap_blocks, vb_idx, vb, gfp_mask);
> +	vbq = addr_to_vbq(va->va_start);
> +	err = xa_insert(&vbq->vmap_blocks, va->va_start, vb, gfp_mask);

This seems actually like a nice subtle improvement in that we are now
indexing always on va_start explicitly and will always load using
addr_to_vb_va_start().

>  	if (err) {
>  		kfree(vb);
>  		free_vmap_area(va);
> @@ -2021,9 +2014,11 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>
>  static void free_vmap_block(struct vmap_block *vb)
>  {
> +	struct vmap_block_queue *vbq;
>  	struct vmap_block *tmp;
>
> -	tmp = xa_erase(&vmap_blocks, addr_to_vb_idx(vb->va->va_start));
> +	vbq = addr_to_vbq(vb->va->va_start);
> +	tmp = xa_erase(&vbq->vmap_blocks, vb->va->va_start);
>  	BUG_ON(tmp != vb);
>
>  	spin_lock(&vmap_area_lock);
> @@ -2135,6 +2130,7 @@ static void vb_free(unsigned long addr, unsigned long size)
>  	unsigned long offset;
>  	unsigned int order;
>  	struct vmap_block *vb;
> +	struct vmap_block_queue *vbq;
>
>  	BUG_ON(offset_in_page(size));
>  	BUG_ON(size > PAGE_SIZE*VMAP_MAX_ALLOC);
> @@ -2143,7 +2139,10 @@ static void vb_free(unsigned long addr, unsigned long size)
>
>  	order = get_order(size);
>  	offset = (addr & (VMAP_BLOCK_SIZE - 1)) >> PAGE_SHIFT;
> -	vb = xa_load(&vmap_blocks, addr_to_vb_idx(addr));
> +
> +	vbq = addr_to_vbq(addr);
> +	vb = xa_load(&vbq->vmap_blocks, addr_to_vb_va_start(addr));
> +
>  	spin_lock(&vb->lock);
>  	bitmap_clear(vb->used_map, offset, (1UL << order));
>  	spin_unlock(&vb->lock);
> @@ -3486,6 +3485,7 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
>  {
>  	char *start;
>  	struct vmap_block *vb;
> +	struct vmap_block_queue *vbq;
>  	unsigned long offset;
>  	unsigned int rs, re, n;
>
> @@ -3503,7 +3503,8 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
>  	 * Area is split into regions and tracked with vmap_block, read out
>  	 * each region and zero fill the hole between regions.
>  	 */
> -	vb = xa_load(&vmap_blocks, addr_to_vb_idx((unsigned long)addr));
> +	vbq = addr_to_vbq((unsigned long) addr);
> +	vb = xa_load(&vbq->vmap_blocks, addr_to_vb_va_start((unsigned long) addr));
>  	if (!vb)
>  		goto finished;
>
> @@ -4272,6 +4273,7 @@ void __init vmalloc_init(void)
>  		p = &per_cpu(vfree_deferred, i);
>  		init_llist_head(&p->list);
>  		INIT_WORK(&p->wq, delayed_vfree_work);
> +		xa_init(&vbq->vmap_blocks);
>  	}
>
>  	/* Import existing vmlist entries. */
> --
> 2.30.2
>
