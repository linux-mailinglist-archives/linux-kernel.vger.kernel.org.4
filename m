Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5F75EB338
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 23:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiIZVfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 17:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbiIZVfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 17:35:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6166182D10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 14:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664228117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6AigG2QaFz9fUItmLdlNymo8Bc77uFt/gfHqkCrhpQs=;
        b=ViQMg1Eqzxl/4dSVnTdtLU0jQBFgR1BD3XLdEZJ+Zr/c/jKXFPT8SFhMz0Y1AnQwJWHhVy
        hW29kOoUy5T8sMmor5mgrAE4AU3PTwy7AbNra9sj9h7xE7Fk5KThtW7GvYeLnNDVWlKRky
        orPhJ6ftD0ht9a0tH5uWU4YcETO+Jzg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-635-bVbAo_J8P7On5x0Ng4oatQ-1; Mon, 26 Sep 2022 17:35:16 -0400
X-MC-Unique: bVbAo_J8P7On5x0Ng4oatQ-1
Received: by mail-qt1-f197.google.com with SMTP id u9-20020a05622a14c900b0035cc7e8cbaeso5592752qtx.19
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 14:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=6AigG2QaFz9fUItmLdlNymo8Bc77uFt/gfHqkCrhpQs=;
        b=0zRYx6ZPhLQM0qdIx0KOkZNORDBaaMjhmVLy0qgfpBFrfn2pPfKQf7RKnBf4lUyNVT
         khgG8EQw08Yea3JG6sil6oqmXt99GttPZtDhKIXeGYax8R2lb7R4eTAU+hb3Zmd7fJtM
         T4YaSBh8PmyJF6ujR2qTw0dAU73NZDPYcqZXtGXcBaxqVfgSLl3VhzBW810Eo2e2yFLu
         w9tbMyiLWEcyb0/IPPTpcbMSRwsY6Mm3ku+g669Auql/9nZlw8dYZZkmtVLNgf815wQh
         SxnRuulh6a/KeBSilqF+y1GFjgNpCwKieaT+j25Zt597h/KygJEiVoEcG3+qs8eQXR9q
         ZiBQ==
X-Gm-Message-State: ACrzQf1dE+4U8Q5X5uffqaqlwFSSOnItLlu1sdlThJzL8RE1xbk4kEPJ
        d21rKIO8pd8wg4cBMCfGvN8mSQksy55ftCq40DMa8g5bbkvc+njKm07whQH4ebKWCSQeYr9cdkK
        tCES5CJ9DgL3sL0L9NR3vjGQb
X-Received: by 2002:ad4:596f:0:b0:4ad:79fc:9ae0 with SMTP id eq15-20020ad4596f000000b004ad79fc9ae0mr19024070qvb.53.1664228115767;
        Mon, 26 Sep 2022 14:35:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4xw6uz00XLpP3Skve6uaqwVGBSYr5mSlACMtNy5xy5ttQADFwfKgBu7gO0RX0i2rRcQ9QrXA==
X-Received: by 2002:ad4:596f:0:b0:4ad:79fc:9ae0 with SMTP id eq15-20020ad4596f000000b004ad79fc9ae0mr19024049qvb.53.1664228115534;
        Mon, 26 Sep 2022 14:35:15 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c48:e00:e786:1aff:4f5c:c549? ([2600:4040:5c48:e00:e786:1aff:4f5c:c549])
        by smtp.gmail.com with ESMTPSA id e24-20020ac84918000000b003445d06a622sm11246884qtq.86.2022.09.26.14.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 14:35:13 -0700 (PDT)
Message-ID: <881735bda9b1ba0ecf3648af201840233508f206.camel@redhat.com>
Subject: Re: [PATCH 6/7] nouveau/dmem: Evict device private memory during
 release
From:   Lyude Paul <lyude@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alex Sierra <alex.sierra@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 26 Sep 2022 17:35:11 -0400
In-Reply-To: <072e1ce590fe101a4cdbd5e91b1702efebb6d0fd.1664171943.git-series.apopple@nvidia.com>
References: <cover.f15b25597fc3afd45b144df863eeca3b2c13f9f4.1664171943.git-series.apopple@nvidia.com>
         <072e1ce590fe101a4cdbd5e91b1702efebb6d0fd.1664171943.git-series.apopple@nvidia.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-09-26 at 16:03 +1000, Alistair Popple wrote:
> When the module is unloaded or a GPU is unbound from the module it is
> possible for device private pages to be left mapped in currently running
> processes. This leads to a kernel crash when the pages are either freed
> or accessed from the CPU because the GPU and associated data structures
> and callbacks have all been freed.
> 
> Fix this by migrating any mappings back to normal CPU memory prior to
> freeing the GPU memory chunks and associated device private pages.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> ---
> 
> I assume the AMD driver might have a similar issue. However I can't see
> where device private (or coherent) pages actually get unmapped/freed
> during teardown as I couldn't find any relevant calls to
> devm_memunmap(), memunmap(), devm_release_mem_region() or
> release_mem_region(). So it appears that ZONE_DEVICE pages are not being
> properly freed during module unload, unless I'm missing something?

I've got no idea, will poke Ben to see if they know the answer to this

> ---
>  drivers/gpu/drm/nouveau/nouveau_dmem.c | 48 +++++++++++++++++++++++++++-
>  1 file changed, 48 insertions(+)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> index 66ebbd4..3b247b8 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> @@ -369,6 +369,52 @@ nouveau_dmem_suspend(struct nouveau_drm *drm)
>  	mutex_unlock(&drm->dmem->mutex);
>  }
>  
> +/*
> + * Evict all pages mapping a chunk.
> + */
> +void
> +nouveau_dmem_evict_chunk(struct nouveau_dmem_chunk *chunk)
> +{
> +	unsigned long i, npages = range_len(&chunk->pagemap.range) >> PAGE_SHIFT;
> +	unsigned long *src_pfns, *dst_pfns;
> +	dma_addr_t *dma_addrs;
> +	struct nouveau_fence *fence;
> +
> +	src_pfns = kcalloc(npages, sizeof(*src_pfns), GFP_KERNEL);
> +	dst_pfns = kcalloc(npages, sizeof(*dst_pfns), GFP_KERNEL);
> +	dma_addrs = kcalloc(npages, sizeof(*dma_addrs), GFP_KERNEL);
> +
> +	migrate_device_range(src_pfns, chunk->pagemap.range.start >> PAGE_SHIFT,
> +			npages);
> +
> +	for (i = 0; i < npages; i++) {
> +		if (src_pfns[i] & MIGRATE_PFN_MIGRATE) {
> +			struct page *dpage;
> +
> +			/*
> +			 * _GFP_NOFAIL because the GPU is going away and there
> +			 * is nothing sensible we can do if we can't copy the
> +			 * data back.
> +			 */

You'll have to excuse me for a moment since this area of nouveau isn't one of
my strongpoints, but are we sure about this? IIRC __GFP_NOFAIL means infinite
retry, in the case of a GPU hotplug event I would assume we would rather just
stop trying to migrate things to the GPU and just drop the data instead of
hanging on infinite retries.

> +			dpage = alloc_page(GFP_HIGHUSER | __GFP_NOFAIL);
> +			dst_pfns[i] = migrate_pfn(page_to_pfn(dpage));
> +			nouveau_dmem_copy_one(chunk->drm,
> +					migrate_pfn_to_page(src_pfns[i]), dpage,
> +					&dma_addrs[i]);
> +		}
> +	}
> +
> +	nouveau_fence_new(chunk->drm->dmem->migrate.chan, false, &fence);
> +	migrate_device_pages(src_pfns, dst_pfns, npages);
> +	nouveau_dmem_fence_done(&fence);
> +	migrate_device_finalize(src_pfns, dst_pfns, npages);
> +	kfree(src_pfns);
> +	kfree(dst_pfns);
> +	for (i = 0; i < npages; i++)
> +		dma_unmap_page(chunk->drm->dev->dev, dma_addrs[i], PAGE_SIZE, DMA_BIDIRECTIONAL);
> +	kfree(dma_addrs);
> +}
> +
>  void
>  nouveau_dmem_fini(struct nouveau_drm *drm)
>  {
> @@ -380,8 +426,10 @@ nouveau_dmem_fini(struct nouveau_drm *drm)
>  	mutex_lock(&drm->dmem->mutex);
>  
>  	list_for_each_entry_safe(chunk, tmp, &drm->dmem->chunks, list) {
> +		nouveau_dmem_evict_chunk(chunk);
>  		nouveau_bo_unpin(chunk->bo);
>  		nouveau_bo_ref(NULL, &chunk->bo);
> +		WARN_ON(chunk->callocated);
>  		list_del(&chunk->list);
>  		memunmap_pages(&chunk->pagemap);
>  		release_mem_region(chunk->pagemap.range.start,

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

