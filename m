Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326DB721B4B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 02:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjFEAog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 20:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFEAoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 20:44:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DFCDA
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 17:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685925828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p5PcVi1O+mt/Dqx54l2QxJ5MaS+ZM6zQx9FV0Ue0QeY=;
        b=VwtA1HylatFoI/zcu5tDbwhqJtzpQs8GeIPzZKsF3nM8ZI82E9+RyjGUadxGTHZFwVE6Jl
        U9V+7K3pBIrD5HsdT79INlccd4ZoWRBXSIJ/ZiCbndVaQ/6UyAg6JenJ7v61/P3mt1MV0d
        dTFpYOAcUdbjySQR0+C4CN4BGuKaw8E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-70-ucdAXdoJNP-MeEkZQctfZw-1; Sun, 04 Jun 2023 20:43:45 -0400
X-MC-Unique: ucdAXdoJNP-MeEkZQctfZw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62F4C85A5BB;
        Mon,  5 Jun 2023 00:43:44 +0000 (UTC)
Received: from localhost (ovpn-12-83.pek2.redhat.com [10.72.12.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C18040CFD16;
        Mon,  5 Jun 2023 00:43:43 +0000 (UTC)
Date:   Mon, 5 Jun 2023 08:43:39 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 8/9] mm: vmalloc: Offload free_vmap_area_lock global lock
Message-ID: <ZH0vuwaSddREy9dz@MiWiFi-R3L-srv>
References: <20230522110849.2921-1-urezki@gmail.com>
 <20230522110849.2921-9-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522110849.2921-9-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/22/23 at 01:08pm, Uladzislau Rezki (Sony) wrote:
......  
> +static unsigned long
> +this_cpu_zone_alloc_fill(struct cpu_vmap_zone *z,
> +	unsigned long size, unsigned long align,
> +	gfp_t gfp_mask, int node)
> +{
> +	unsigned long addr = VMALLOC_END;
> +	struct vmap_area *va;
> +
> +	/*
> +	 * It still can race. One task sets a progress to
> +	 * 1 a second one gets preempted on entry, the first
> +	 * zeroed the progress flag and second proceed with
> +	 * an extra prefetch.
> +	 */
> +	if (atomic_xchg(&z->fill_in_progress, 1))
> +		return addr;
> +
> +	va = kmem_cache_alloc_node(vmap_area_cachep, gfp_mask, node);
> +	if (unlikely(!va))
> +		goto out;
> +
> +	spin_lock(&free_vmap_area_lock);
> +	addr = __alloc_vmap_area(&free_vmap_area_root, &free_vmap_area_list,
> +		cvz_size, 1, VMALLOC_START, VMALLOC_END);
> +	spin_unlock(&free_vmap_area_lock);

The 'z' is passed in from this_cpu_zone_alloc(), and it's got with
raw_cpu_ptr(&cpu_vmap_zone). Here when we try to get chunk of cvz_size
from free_vmap_area_root/free_vmap_area_list, how can we guarantee it
must belong to the 'z' zone? With my understanding, __alloc_vmap_area()
will get efficient address range sequentially bottom up from
free_vmap_area_root. Please correct me if I am wrong.

static unsigned long
this_cpu_zone_alloc(unsigned long size, unsigned long align, gfp_t gfp_mask, int node)
{
        struct cpu_vmap_zone *z = raw_cpu_ptr(&cpu_vmap_zone);
	......
	if (addr == VMALLOC_END && left < 4 * PAGE_SIZE)
                addr = this_cpu_zone_alloc_fill(z, size, align, gfp_mask, node);
}

> +
> +	if (addr == VMALLOC_END) {
> +		kmem_cache_free(vmap_area_cachep, va);
> +		goto out;
> +	}
> +
> +	va->va_start = addr;
> +	va->va_end = addr + cvz_size;
> +
> +	fbl_lock(z, FREE);
> +	va = merge_or_add_vmap_area_augment(va,
> +		&fbl_root(z, FREE), &fbl_head(z, FREE));
> +	addr = va_alloc(va, &fbl_root(z, FREE), &fbl_head(z, FREE),
> +		size, align, VMALLOC_START, VMALLOC_END);
> +	fbl_unlock(z, FREE);
> +
> +out:
> +	atomic_set(&z->fill_in_progress, 0);
> +	return addr;
> +}
> +
> +static unsigned long
> +this_cpu_zone_alloc(unsigned long size, unsigned long align, gfp_t gfp_mask, int node)
> +{
> +	struct cpu_vmap_zone *z = raw_cpu_ptr(&cpu_vmap_zone);
> +	unsigned long extra = align > PAGE_SIZE ? align : 0;
> +	unsigned long addr = VMALLOC_END, left = 0;
> +
> +	/*
> +	 * It is disabled, fallback to a global heap.
> +	 */
> +	if (cvz_size == ULONG_MAX)
> +		return addr;
> +
> +	/*
> +	 * Any allocation bigger/equal than one half of
                          ~~~~~~typo~~~~~~  bigger than/equal to
> +	 * a zone-size will fallback to a global heap.
> +	 */
> +	if (cvz_size / (size + extra) < 3)
> +		return addr;
> +
> +	if (RB_EMPTY_ROOT(&fbl_root(z, FREE)))
> +		goto fill;
> +
> +	fbl_lock(z, FREE);
> +	addr = __alloc_vmap_area(&fbl_root(z, FREE), &fbl_head(z, FREE),
> +		size, align, VMALLOC_START, VMALLOC_END);
> +
> +	if (addr == VMALLOC_END)
> +		left = get_subtree_max_size(fbl_root(z, FREE).rb_node);
> +	fbl_unlock(z, FREE);
> +
> +fill:
> +	/*
> +	 * A low watermark is 3 pages.
> +	 */
> +	if (addr == VMALLOC_END && left < 4 * PAGE_SIZE)
> +		addr = this_cpu_zone_alloc_fill(z, size, align, gfp_mask, node);
> +
> +	return addr;
> +}
> +
>  /*
>   * Allocate a region of KVA of the specified size and alignment, within the
>   * vstart and vend.
> @@ -1678,11 +1765,21 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	 */
>  	kmemleak_scan_area(&va->rb_node, SIZE_MAX, gfp_mask);
>  
> +	/*
> +	 * Fast path allocation, start with it.
> +	 */
> +	if (vstart == VMALLOC_START && vend == VMALLOC_END)
> +		addr = this_cpu_zone_alloc(size, align, gfp_mask, node);
> +	else
> +		addr = vend;
> +
>  retry:
> -	preload_this_cpu_lock(&free_vmap_area_lock, gfp_mask, node);
> -	addr = __alloc_vmap_area(&free_vmap_area_root, &free_vmap_area_list,
> -		size, align, vstart, vend);
> -	spin_unlock(&free_vmap_area_lock);
> +	if (addr == vend) {
> +		preload_this_cpu_lock(&free_vmap_area_lock, gfp_mask, node);
> +		addr = __alloc_vmap_area(&free_vmap_area_root, &free_vmap_area_list,
> +			size, align, vstart, vend);
> +		spin_unlock(&free_vmap_area_lock);
> +	}
>  
>  	trace_alloc_vmap_area(addr, size, align, vstart, vend, addr == vend);
>  
> @@ -1827,6 +1924,27 @@ purge_cpu_vmap_zone(struct cpu_vmap_zone *z)
>  	return num_purged_areas;
>  }
>  
> +static void
> +drop_cpu_vmap_cache(struct cpu_vmap_zone *z)
> +{
> +	struct vmap_area *va, *n_va;
> +	LIST_HEAD(free_head);
> +
> +	if (RB_EMPTY_ROOT(&fbl_root(z, FREE)))
> +		return;
> +
> +	fbl_lock(z, FREE);
> +	WRITE_ONCE(fbl(z, FREE, root.rb_node), NULL);
> +	list_replace_init(&fbl_head(z, FREE), &free_head);
> +	fbl_unlock(z, FREE);
> +
> +	spin_lock(&free_vmap_area_lock);
> +	list_for_each_entry_safe(va, n_va, &free_head, list)
> +		merge_or_add_vmap_area_augment(va,
> +			&free_vmap_area_root, &free_vmap_area_list);
> +	spin_unlock(&free_vmap_area_lock);
> +}
> +
>  /*
>   * Purges all lazily-freed vmap areas.
>   */
> @@ -1868,6 +1986,7 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
>  		for_each_possible_cpu(i) {
>  			z = per_cpu_ptr(&cpu_vmap_zone, i);
>  			num_purged_areas += purge_cpu_vmap_zone(z);
> +			drop_cpu_vmap_cache(z);
>  		}
>  	}
>  
> -- 
> 2.30.2
> 

