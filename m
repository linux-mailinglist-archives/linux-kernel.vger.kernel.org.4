Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DA66CB54F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 06:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjC1EHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 00:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjC1EHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 00:07:30 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92667F3;
        Mon, 27 Mar 2023 21:07:29 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9E54F68B05; Tue, 28 Mar 2023 06:07:24 +0200 (CEST)
Date:   Tue, 28 Mar 2023 06:07:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Petr Tesarik <petrtesarik@huaweicloud.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        Roberto Sassu <roberto.sassu@huawei.com>, petr@tesarici.cz,
        Alexander Graf <graf@amazon.com>
Subject: Re: [RFC v1 3/4] swiotlb: Allow dynamic allocation of bounce
 buffers
Message-ID: <20230328040724.GB25506@lst.de>
References: <cover.1679309810.git.petr.tesarik.ext@huawei.com> <0334a54332ab75312c9de825548b616439dcc9f5.1679309810.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0334a54332ab75312c9de825548b616439dcc9f5.1679309810.git.petr.tesarik.ext@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding Alex as he has been interested in this in the past]

On Mon, Mar 20, 2023 at 01:28:15PM +0100, Petr Tesarik wrote:
> Second, on the Raspberry Pi 4, swiotlb is used by dma-buf for pages
> moved from the rendering GPU (v3d driver), which can access all
> memory, to the display output (vc4 driver), which is connected to a
> bus with an address limit of 1 GiB and no IOMMU. These buffers can
> be large (several megabytes) and cannot be handled by SWIOTLB,
> because they exceed maximum segment size of 256 KiB. Such mapping
> failures can be easily reproduced on a Raspberry Pi4: Starting
> GNOME remote desktop results in a flood of kernel messages like
> these:

Shouldn't we make sure dma-buf allocates the buffers for the most
restricted devices, and more importantly does something like a dma
coherent allocation instead of a dynamic mapping of random memory?

While a larger swiotlb works around this I don't think this fixes the root
cause.

> 1. The value is limited to ULONG_MAX, which is too little both for
>    physical addresses (e.g. x86 PAE or 32-bit ARM LPAE) and DMA
>    addresses (e.g. Xen guests on 32-bit ARM).
> 
> 2. Since buffers are currently allocated with page granularity, a
>    PFN can be used instead. However, some values are reserved by
>    the maple tree implementation. Liam suggests to use
>    xa_mk_value() in that case, but that reduces the usable range by
>    half. Luckily, 31 bits are still enough to hold a PFN on all
>    32-bit platforms.
> 
> 3. Software IO TLB is used from interrupt context. The maple tree
>    implementation is not IRQ-safe (MT_FLAGS_LOCK_IRQ does nothing
>    AFAICS). Instead, I use an external lock, spin_lock_irqsave() and
>    spin_unlock_irqrestore().
> 
> Note that bounce buffers are never allocated dynamically if the
> software IO TLB is in fact a DMA restricted pool, which is intended
> to be stay in its designated location in physical memory.

I'm a little worried about all that because it causes quite a bit
of overhead even for callers that don't end up going into the
dynamic range or do not use swiotlb at all.  I don't really have a
good answer here except for the usual avoid bounce buffering whenever
you can that might not always be easy to do.

> +	gfp = (attrs & DMA_ATTR_MAY_SLEEP) ? GFP_KERNEL : GFP_NOWAIT;
> +	slot = kmalloc(sizeof(*slot), gfp | __GFP_NOWARN);
> +	if (!slot)
> +		goto err;
> +
> +	slot->orig_addr = orig_addr;
> +	slot->alloc_size = alloc_size;
> +	slot->page = dma_direct_alloc_pages(dev, PAGE_ALIGN(alloc_size),
> +					    &slot->dma_addr, dir,
> +					    gfp | __GFP_NOWARN);
> +	if (!slot->page)
> +		goto err_free_slot;

Without GFP_NOIO allocations this will deadlock eventually.
