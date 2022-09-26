Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC94C5EB318
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 23:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiIZVaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 17:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiIZVaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 17:30:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDDB3CBEA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 14:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664227803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WoZ9fgngRao8IT+B8E9l7WqjGAnK52AtXGsAOFoOmwE=;
        b=gqPkCoAQEXqORUk3o6im4JzSArv6xL3j/IDtTmL469ivnDe5yMrRCk9Xr53ETfsGaUYo6m
        tQb7OKQjmCMxAOJvxQRYcBq8iHB37974sy+5Cmi0kIMi3KvoZRYOL22cxpdWpY7tOSg7d6
        nHV4I6mtZTWDKCjOkpdVbhKordrh4qs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-149-2QUGcYejNCS3kE5aNmZ49w-1; Mon, 26 Sep 2022 17:30:00 -0400
X-MC-Unique: 2QUGcYejNCS3kE5aNmZ49w-1
Received: by mail-qv1-f72.google.com with SMTP id i10-20020ad45c6a000000b004a25d0fea96so4601990qvh.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 14:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WoZ9fgngRao8IT+B8E9l7WqjGAnK52AtXGsAOFoOmwE=;
        b=v7mmu6xQv0+zX277fRW3wI1sCDeXxCaO5I070/806X5U52NZ6UscAG4Jnhc6K4BNlS
         QbhxvT8Qwq0wxNSYNXQrE5qQdx1rOUf1wX/sP2qgQ0BU7BhLYk++0lwSfZ4UKS4oi1Q4
         XHWeLQyBRpFfxFjdtYRylLFB3vy/d3J061MAlzQTkjut2qojWNhybWObDG64u1VtqakR
         T1FDnmX26NMus2rARrp5EcRQXomxDMqTpDgtFs5wmBXn6bB+Az+IjXuQuT9NlLqU+8jJ
         mFJiSPrMWkLfA9Z+vKDBfdXjPLHyKokQEwjdPbN6ueZ4i2XcPPALmtNNrMH+FQSUR2pc
         JI5Q==
X-Gm-Message-State: ACrzQf2nG1nT8bltbCFKh75/H8rkFOxJM4TxLaDu8ag//qAquHaEbKpv
        Wxn89YLJ59zjBp4EmLodwDMwvobb2achjBj+jIQZ4u2kK7ZBkYVt23HOKgs0Oxm0KDR7cZY0yPj
        EsFH55G5ctfmjA18mAKmSwG/k
X-Received: by 2002:a05:620a:2987:b0:6ce:c029:5f03 with SMTP id r7-20020a05620a298700b006cec0295f03mr15801496qkp.157.1664227799812;
        Mon, 26 Sep 2022 14:29:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5ooMLHPNGYGRP1IOKqLF5TpXz9XfH1OcMI3VMSbPod5U0TpcrkzXrJ+Bq2BgRX5qr4d9CtNA==
X-Received: by 2002:a05:620a:2987:b0:6ce:c029:5f03 with SMTP id r7-20020a05620a298700b006cec0295f03mr15801473qkp.157.1664227799582;
        Mon, 26 Sep 2022 14:29:59 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c48:e00:e786:1aff:4f5c:c549? ([2600:4040:5c48:e00:e786:1aff:4f5c:c549])
        by smtp.gmail.com with ESMTPSA id y14-20020a05620a25ce00b006cfa7b944fdsm1686678qko.16.2022.09.26.14.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 14:29:57 -0700 (PDT)
Message-ID: <d839ead12d782a184ca104d6b5f62184c0f178dd.camel@redhat.com>
Subject: Re: [PATCH 5/7] nouveau/dmem: Refactor nouveau_dmem_fault_copy_one()
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
Date:   Mon, 26 Sep 2022 17:29:55 -0400
In-Reply-To: <ea208905d853a0fdc277c2b5e74742593e53f767.1664171943.git-series.apopple@nvidia.com>
References: <cover.f15b25597fc3afd45b144df863eeca3b2c13f9f4.1664171943.git-series.apopple@nvidia.com>
         <ea208905d853a0fdc277c2b5e74742593e53f767.1664171943.git-series.apopple@nvidia.com>
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
> nouveau_dmem_fault_copy_one() is used during handling of CPU faults via
> the migrate_to_ram() callback and is used to copy data from GPU to CPU
> memory. It is currently specific to fault handling, however a future
> patch implementing eviction of data during teardown needs similar
> functionality.
> 
> Refactor out the core functionality so that it is not specific to fault
> handling.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_dmem.c | 59 +++++++++++++--------------
>  1 file changed, 29 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> index f9234ed..66ebbd4 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> @@ -139,44 +139,25 @@ static void nouveau_dmem_fence_done(struct nouveau_fence **fence)
>  	}
>  }
>  
> -static vm_fault_t nouveau_dmem_fault_copy_one(struct nouveau_drm *drm,
> -		struct vm_fault *vmf, struct migrate_vma *args,
> -		dma_addr_t *dma_addr)
> +static int nouveau_dmem_copy_one(struct nouveau_drm *drm, struct page *spage,
> +				struct page *dpage, dma_addr_t *dma_addr)
>  {
>  	struct device *dev = drm->dev->dev;
> -	struct page *dpage, *spage;
> -	struct nouveau_svmm *svmm;
> -
> -	spage = migrate_pfn_to_page(args->src[0]);
> -	if (!spage || !(args->src[0] & MIGRATE_PFN_MIGRATE))
> -		return 0;
>  
> -	dpage = alloc_page_vma(GFP_HIGHUSER, vmf->vma, vmf->address);
> -	if (!dpage)
> -		return VM_FAULT_SIGBUS;
>  	lock_page(dpage);
>  
>  	*dma_addr = dma_map_page(dev, dpage, 0, PAGE_SIZE, DMA_BIDIRECTIONAL);
>  	if (dma_mapping_error(dev, *dma_addr))
> -		goto error_free_page;
> +		return -EIO;
>  
> -	svmm = spage->zone_device_data;
> -	mutex_lock(&svmm->mutex);
> -	nouveau_svmm_invalidate(svmm, args->start, args->end);
>  	if (drm->dmem->migrate.copy_func(drm, 1, NOUVEAU_APER_HOST, *dma_addr,
> -			NOUVEAU_APER_VRAM, nouveau_dmem_page_addr(spage)))
> -		goto error_dma_unmap;
> -	mutex_unlock(&svmm->mutex);
> +					 NOUVEAU_APER_VRAM,
> +					 nouveau_dmem_page_addr(spage))) {
> +		dma_unmap_page(dev, *dma_addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
> +		return -EIO;
> +	}

Feel free to just align this with the starting (, as long as it doesn't go
above 100 characters it doesn't really matter imho and would look nicer that
way.

Otherwise:

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will look at the other patch in a moment

>  
> -	args->dst[0] = migrate_pfn(page_to_pfn(dpage));
>  	return 0;
> -
> -error_dma_unmap:
> -	mutex_unlock(&svmm->mutex);
> -	dma_unmap_page(dev, *dma_addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
> -error_free_page:
> -	__free_page(dpage);
> -	return VM_FAULT_SIGBUS;
>  }
>  
>  static vm_fault_t nouveau_dmem_migrate_to_ram(struct vm_fault *vmf)
> @@ -184,9 +165,11 @@ static vm_fault_t nouveau_dmem_migrate_to_ram(struct vm_fault *vmf)
>  	struct nouveau_drm *drm = page_to_drm(vmf->page);
>  	struct nouveau_dmem *dmem = drm->dmem;
>  	struct nouveau_fence *fence;
> +	struct nouveau_svmm *svmm;
> +	struct page *spage, *dpage;
>  	unsigned long src = 0, dst = 0;
>  	dma_addr_t dma_addr = 0;
> -	vm_fault_t ret;
> +	vm_fault_t ret = 0;
>  	struct migrate_vma args = {
>  		.vma		= vmf->vma,
>  		.start		= vmf->address,
> @@ -207,9 +190,25 @@ static vm_fault_t nouveau_dmem_migrate_to_ram(struct vm_fault *vmf)
>  	if (!args.cpages)
>  		return 0;
>  
> -	ret = nouveau_dmem_fault_copy_one(drm, vmf, &args, &dma_addr);
> -	if (ret || dst == 0)
> +	spage = migrate_pfn_to_page(src);
> +	if (!spage || !(src & MIGRATE_PFN_MIGRATE))
> +		goto done;
> +
> +	dpage = alloc_page_vma(GFP_HIGHUSER, vmf->vma, vmf->address);
> +	if (!dpage)
> +		goto done;
> +
> +	dst = migrate_pfn(page_to_pfn(dpage));
> +
> +	svmm = spage->zone_device_data;
> +	mutex_lock(&svmm->mutex);
> +	nouveau_svmm_invalidate(svmm, args.start, args.end);
> +	ret = nouveau_dmem_copy_one(drm, spage, dpage, &dma_addr);
> +	mutex_unlock(&svmm->mutex);
> +	if (ret) {
> +		ret = VM_FAULT_SIGBUS;
>  		goto done;
> +	}
>  
>  	nouveau_fence_new(dmem->migrate.chan, false, &fence);
>  	migrate_vma_pages(&args);

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

