Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A17B6D0EEC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 21:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjC3TeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 15:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjC3TeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 15:34:21 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8416195
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 12:34:19 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso14057270wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 12:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680204858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4AZMjVxZxEEFlOECKFUO1XIhYF75XUZWy+zJLa0qlV4=;
        b=jhf6eyRH0FcsNmCeDgv4Sr/YJyLxNKVqQxorDHqNllLRVTlmooppA/U2ra6LMN52uF
         xAg1E6nJ6zMGBszdBlC8jRpnA6AFj2W41dK/fNJSeJaxdEU2JNTjm67wByX/VwTSP4SH
         4vN9T26EK7CenNbwoQ1nuozEMZlw9bsunFiEUC2pLv36zsW8yaLBChY+k8javk6r/D98
         jeoU6zFhoUa5v+jEholcK0+BBfNBeYfl08f/5WCCFhZQ5yuASJQH+lgW+qE1NOKMH8mm
         boJujgOPkq+5RKV9cFbDQ8WoQXIgfN1SCnwZBERtFziToQo7OfCohZs0pjylrJCNELYP
         +klw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680204858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AZMjVxZxEEFlOECKFUO1XIhYF75XUZWy+zJLa0qlV4=;
        b=X6FRcYU1BwHFq/3TNAztvr9x/wCxiG+qBggxV+JkQ8UcqTw0nhmwcVgmjqHmodKGqS
         p2oXlGDFUoBaoKrASEOtAk6lYwaBoUxv4COiN7xsGlohnpdbzycxfUYIxg9VMZACwdvd
         m3IEUXbmkK2jfuv6bKRYWt0dxitKEf29XkBrBNfbthS8yWHEYZcCslTC39zJCSdnVUoG
         8n1+iJR/fvrMsC+Jl3IBHNQ/KlFy3D5fyCYiq+5ZvQXPtJ8QaTe+tpPFx+fkUzBqeTEq
         3i/ZClfuzReP+Qts9ufp3M+k8FgA7lOAgnJSjxGvr7YdjfKJWPhlHdJdWJN7RmMnDC1I
         DGgA==
X-Gm-Message-State: AO0yUKWyEmmpySq0VNet+D4WGKgz1fZuLp0FZW0LbGTDtiCjTJ1JZ2Of
        HpcD5DAOO15rQTgd+OYOeBc=
X-Google-Smtp-Source: AK7set+hPBYyIj3UMAuKoulqJmB/Ujmt7vkg0s05VhX/bGCDjK1WKCkv+HgwcLaCJZnrbPjCPHEizw==
X-Received: by 2002:a7b:c7d6:0:b0:3e1:f8af:8772 with SMTP id z22-20020a7bc7d6000000b003e1f8af8772mr18644164wmk.9.1680204857711;
        Thu, 30 Mar 2023 12:34:17 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b003ef5bb63f13sm7482669wms.10.2023.03.30.12.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 12:34:17 -0700 (PDT)
Date:   Thu, 30 Mar 2023 20:34:16 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 1/2] mm: vmalloc: Remove a global vmap_blocks xarray
Message-ID: <836e007c-f73e-4a2f-b069-d71a167fd2b9@lucifer.local>
References: <20230330190639.431589-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330190639.431589-1-urezki@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 09:06:38PM +0200, Uladzislau Rezki (Sony) wrote:
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
> Running the test_vmalloc.sh run_test_mask=1024 nr_threads=64 nr_pages=5
> shows around ~8 percent of throughput improvement of vm_map_ram() and
> vm_unmap_ram() APIs.
>
> This patch does not fix vmap_area_lock/free_vmap_area_lock and
> purge_vmap_area_lock bottle-necks, it is rather a separate rework.
>
> v1 - v2:
>    - Add more comments(Andrew Morton req.)
>    - Switch to WARN_ON_ONCE(Lorenzo Stoakes req.)
>
> v2 -> v3:
>    - Fix a kernel-doc complain(Matthew Wilcox)
>
> v3 -> v4:
>    - Improve comments about hashing logic(Lorenzo Stoakes)
>    - Improve code design(Lorenzo Stoakes)
>    - Keep the addr_to_vb_idx() func. to cut index length(Baoquan He)
>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 63 insertions(+), 8 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 978194dc2bb8..671d6d5d5b78 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1911,6 +1911,13 @@ static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
>  struct vmap_block_queue {
>  	spinlock_t lock;
>  	struct list_head free;
> +
> +	/*
> +	 * An xarray requires an extra memory dynamically to
> +	 * be allocated. If it is an issue, we can use rb-tree
> +	 * instead.
> +	 */
> +	struct xarray vmap_blocks;
>  };
>
>  struct vmap_block {
> @@ -1928,11 +1935,48 @@ struct vmap_block {
>  static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
>
>  /*
> - * XArray of vmap blocks, indexed by address, to quickly find a vmap block
> - * in the free path. Could get rid of this if we change the API to return a
> - * "cookie" from alloc, to be passed to free. But no big deal yet.
> + * In order to fast access to any "vmap_block" associated with a
> + * specific address, we use a hash.
> + *
> + * A per-cpu vmap_block_queue is used in both ways, to serialize
> + * an access to free block chains among CPUs(alloc path) and it
> + * also acts as a vmap_block hash(alloc/free paths). It means we
> + * overload it, since we already have the per-cpu array which is
> + * used as a hash table. When used as a hash a 'cpu' passed to
> + * per_cpu() is not actually a CPU but rather a hash index.
> + *
> + * A hash function is addr_to_vb_xarray() which hashes any address
> + * to a specific index(in a hash) it belongs to. This then uses a
> + * per_cpu() macro to access an array with generated index.
> + *
> + * An example:
> + *
> + *  CPU_1  CPU_2  CPU_0
> + *    |      |      |
> + *    V      V      V
> + * 0     10     20     30     40     50     60
> + * |------|------|------|------|------|------|...<vmap address space>
> + *   CPU0   CPU1   CPU2   CPU0   CPU1   CPU2
> + *
> + * - CPU_1 invokes vm_unmap_ram(6), 6 belongs to CPU0 zone, thus
> + *   it access: CPU0/INDEX0 -> vmap_blocks -> xa_lock;
> + *
> + * - CPU_2 invokes vm_unmap_ram(11), 11 belongs to CPU1 zone, thus
> + *   it access: CPU1/INDEX1 -> vmap_blocks -> xa_lock;
> + *
> + * - CPU_0 invokes vm_unmap_ram(20), 20 belongs to CPU2 zone, thus
> + *   it access: CPU2/INDEX2 -> vmap_blocks -> xa_lock.
> + *
> + * This technique almost always avoids lock contention on insert/remove,
> + * however xarray spinlocks protect against any contention that remains.
>   */
> -static DEFINE_XARRAY(vmap_blocks);
> +static struct xarray *
> +addr_to_vb_xarray(unsigned long addr)
> +{
> +	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> +
> +	return &per_cpu(vmap_block_queue, index).vmap_blocks;
> +}
>
>  /*
>   * We should probably have a fallback mechanism to allocate virtual memory
> @@ -1970,6 +2014,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  	struct vmap_block_queue *vbq;
>  	struct vmap_block *vb;
>  	struct vmap_area *va;
> +	struct xarray *xa;
>  	unsigned long vb_idx;
>  	int node, err;
>  	void *vaddr;
> @@ -2003,8 +2048,9 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  	bitmap_set(vb->used_map, 0, (1UL << order));
>  	INIT_LIST_HEAD(&vb->free_list);
>
> +	xa = addr_to_vb_xarray(va->va_start);
>  	vb_idx = addr_to_vb_idx(va->va_start);
> -	err = xa_insert(&vmap_blocks, vb_idx, vb, gfp_mask);
> +	err = xa_insert(xa, vb_idx, vb, gfp_mask);
>  	if (err) {
>  		kfree(vb);
>  		free_vmap_area(va);
> @@ -2022,8 +2068,10 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  static void free_vmap_block(struct vmap_block *vb)
>  {
>  	struct vmap_block *tmp;
> +	struct xarray *xa;
>
> -	tmp = xa_erase(&vmap_blocks, addr_to_vb_idx(vb->va->va_start));
> +	xa = addr_to_vb_xarray(vb->va->va_start);
> +	tmp = xa_erase(xa, addr_to_vb_idx(vb->va->va_start));
>  	BUG_ON(tmp != vb);
>
>  	spin_lock(&vmap_area_lock);
> @@ -2135,6 +2183,7 @@ static void vb_free(unsigned long addr, unsigned long size)
>  	unsigned long offset;
>  	unsigned int order;
>  	struct vmap_block *vb;
> +	struct xarray *xa;
>
>  	BUG_ON(offset_in_page(size));
>  	BUG_ON(size > PAGE_SIZE*VMAP_MAX_ALLOC);
> @@ -2143,7 +2192,10 @@ static void vb_free(unsigned long addr, unsigned long size)
>
>  	order = get_order(size);
>  	offset = (addr & (VMAP_BLOCK_SIZE - 1)) >> PAGE_SHIFT;
> -	vb = xa_load(&vmap_blocks, addr_to_vb_idx(addr));
> +
> +	xa = addr_to_vb_xarray(addr);
> +	vb = xa_load(xa, addr_to_vb_idx(addr));
> +
>  	spin_lock(&vb->lock);
>  	bitmap_clear(vb->used_map, offset, (1UL << order));
>  	spin_unlock(&vb->lock);
> @@ -3486,6 +3538,7 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
>  {
>  	char *start;
>  	struct vmap_block *vb;
> +	struct xarray *xa;
>  	unsigned long offset;
>  	unsigned int rs, re, n;
>
> @@ -3503,7 +3556,8 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
>  	 * Area is split into regions and tracked with vmap_block, read out
>  	 * each region and zero fill the hole between regions.
>  	 */
> -	vb = xa_load(&vmap_blocks, addr_to_vb_idx((unsigned long)addr));
> +	xa = addr_to_vb_xarray((unsigned long) addr);
> +	vb = xa_load(xa, addr_to_vb_idx((unsigned long)addr));
>  	if (!vb)
>  		goto finished;
>
> @@ -4272,6 +4326,7 @@ void __init vmalloc_init(void)
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

Very nice!

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
