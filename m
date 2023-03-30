Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D3A6D1385
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 01:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjC3XqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 19:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjC3XqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 19:46:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02928AD27
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 16:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680219936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=so5CzF3uSpQ4q5yJ+Vtdcu9v/Ulq+Us6gCTNf3OXbkU=;
        b=gjv6GoRS4DA4xBld0wF9Mboqt4yT8cXudEx48MGN40qJ/D+SRVgaFZCKjOmWH/uDY84OfD
        GzYhFyVur97NXCQbCwqNW3XtfyyrDY6icSxEuQRCn7IU29JGuFiWnEXM80hvEnK2QrEmmC
        ycqgq9kh+JlI3xQ9Vgc6jY2FElfzkIk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-274-TsJt51_XNiSirUIcbSauZA-1; Thu, 30 Mar 2023 19:45:29 -0400
X-MC-Unique: TsJt51_XNiSirUIcbSauZA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4631A884EC3;
        Thu, 30 Mar 2023 23:45:29 +0000 (UTC)
Received: from localhost (ovpn-12-64.pek2.redhat.com [10.72.12.64])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A9A3404DC50;
        Thu, 30 Mar 2023 23:45:27 +0000 (UTC)
Date:   Fri, 31 Mar 2023 07:45:23 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 1/2] mm: vmalloc: Remove a global vmap_blocks xarray
Message-ID: <ZCYfEwfYmff2lc6d@MiWiFi-R3L-srv>
References: <20230330190639.431589-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330190639.431589-1-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/30/23 at 09:06pm, Uladzislau Rezki (Sony) wrote:
......
> -static DEFINE_XARRAY(vmap_blocks);
> +static struct xarray *
> +addr_to_vb_xarray(unsigned long addr)

I would call it addr_to_vb_xa() if other parts have taken abbreviation.

Other than this nit, this looks great to me.

Reviewed-by: Baoquan He <bhe@redhat.com>

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

