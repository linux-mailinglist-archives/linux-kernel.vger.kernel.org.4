Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2B4701F19
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 20:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbjENSyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 14:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjENSyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 14:54:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13151720;
        Sun, 14 May 2023 11:54:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A10A60DB5;
        Sun, 14 May 2023 18:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40684C433D2;
        Sun, 14 May 2023 18:54:30 +0000 (UTC)
Date:   Sun, 14 May 2023 19:54:27 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Petr Tesarik <petrtesarik@huaweicloud.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, petr@tesarici.cz
Subject: Re: [PATCH v2 RESEND 7/7] swiotlb: per-device flag if there are
 dynamically allocated buffers
Message-ID: <ZGEuYxR2PM6wHeDh@arm.com>
References: <cover.1683623618.git.petr.tesarik.ext@huawei.com>
 <69f9e058bb1ad95905a62a4fc8461b064872af97.1683623618.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69f9e058bb1ad95905a62a4fc8461b064872af97.1683623618.git.petr.tesarik.ext@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 11:18:19AM +0200, Petr Tesarik wrote:
> diff --git a/include/linux/device.h b/include/linux/device.h
> index d1d2b8557b30..e340e0f06dce 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -516,6 +516,9 @@ struct device_physical_location {
>   * @dma_io_tlb_dyn_slots:
>   *		Dynamically allocated bounce buffers for this device.
>   *		Not for driver use.
> + * @dma_io_tlb_have_dyn:
> + *		Does this device have any dynamically allocated bounce
> + *		buffers? Not for driver use.
>   * @archdata:	For arch-specific additions.
>   * @of_node:	Associated device tree node.
>   * @fwnode:	Associated device node supplied by platform firmware.
> @@ -623,6 +626,7 @@ struct device {
>  	struct io_tlb_mem *dma_io_tlb_mem;
>  	spinlock_t dma_io_tlb_dyn_lock;
>  	struct list_head dma_io_tlb_dyn_slots;
> +	bool dma_io_tlb_have_dyn;
>  #endif
>  	/* arch specific additions */
>  	struct dev_archdata	archdata;
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index daa2064f2ede..8cbb0bebb0bc 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -152,7 +152,11 @@ static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
>  
>  	return mem &&
>  		(is_swiotlb_fixed(mem, paddr) ||
> -		 (mem->allow_dyn && is_swiotlb_dyn(dev, paddr)));
> +		 /* Pairs with smp_store_release() in swiotlb_dyn_map()
> +		  * and swiotlb_dyn_unmap().
> +		  */
> +		 (smp_load_acquire(&dev->dma_io_tlb_have_dyn) &&
> +		  is_swiotlb_dyn(dev, paddr)));
>  }
>  
>  static inline bool is_swiotlb_force_bounce(struct device *dev)
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 81eab1c72c50..e8be3ee50f18 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -642,6 +642,9 @@ static phys_addr_t swiotlb_dyn_map(struct device *dev, phys_addr_t orig_addr,
>  
>  	spin_lock_irqsave(&dev->dma_io_tlb_dyn_lock, flags);
>  	list_add(&slot->node, &dev->dma_io_tlb_dyn_slots);
> +	if (!dev->dma_io_tlb_have_dyn)
> +		/* Pairs with smp_load_acquire() in is_swiotlb_buffer() */
> +		smp_store_release(&dev->dma_io_tlb_have_dyn, true);
>  	spin_unlock_irqrestore(&dev->dma_io_tlb_dyn_lock, flags);

I'm not sure this works. What this seems to do is that if the caller of
is_swiotlb_buffer() sees the flag set, it's guaranteed that something
was added to the dma_io_tlb_dyn_slots list. But the reverse is not
necessarily true. IOW, if something was added to the list, there is a
brief window where the dma_io_tlb_have_dyn flag is still false. In the
general case, I doubt any ordering between list_add() and the flag
setting changes anything since neither of them may be visible to another
CPU.

What you need is for a 'paddr' added to the dynamic list to be correctly
identified by another CPU as dynamic swiotlb. That other CPU doesn't
check random addresses but only those returned by the DMA API. Such
values would be normally passed through a memory location (e.g. driver
local structures) and that's what you want to order against.

What I mean is that a 'dev->blah = paddr' needs to be ordered _after_
your flag setting. So you need the either the 'blah = paddr' assignment
to have release semantics or the flag setting to be an
smp_store_acquire() (but we don't have such thing). You'd have to use an
explicit smp_wmb() barrier after the flag setting (it can be outside the
lock). The spin_unlock() is not sufficient since it only has release
semantics. I also don't think the ordering between list_add() and flag
setting matters since the smp_wmb() would ensure that both are visible
when the 'paddr' value made it to the other CPU.

Similarly on the is_swiotlb_buffer() side, you want the flag reading to
be ordered after the 'blah = paddr' is observed. Here the
smp_load_acquire() is sufficient.

>  	return page_to_phys(slot->page);
> @@ -668,6 +671,9 @@ static void swiotlb_dyn_unmap(struct device *dev, phys_addr_t tlb_addr,
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&dev->dma_io_tlb_dyn_lock, flags);
> +	if (list_is_singular(&dev->dma_io_tlb_dyn_slots))
> +		/* Pairs with smp_load_acquire() in is_swiotlb_buffer() */
> +		smp_store_release(&dev->dma_io_tlb_have_dyn, false);
>  	slot = lookup_dyn_slot_locked(dev, tlb_addr);
>  	list_del(&slot->node);
>  	spin_unlock_irqrestore(&dev->dma_io_tlb_dyn_lock, flags);

As with the map case, I don't think the ordering between list_del() and
the flag setting matters. If you unmap the last dynamic buffer, the
worst that can happen is that an is_swiotlb_buffer() call attempts a
read of the list but the flag will eventually become visible. There
shouldn't be another caller trying to unmap the same paddr (in well
behaved drivers).

Now, thinking about the list_head access and the flag ordering, since it
doesn't matter, you might as well not bother with the flag at all and
rely on list_add() and list_empty() ordering vs the hypothetical 'blah'
access. Both of these use READ/WRITE_ONCE() for setting
dma_io_tlb_dyn_slots.next. You only need an smp_wmb() after the
list_add() and an smp_rmb() before a list_empty() check in
is_swiotlb_buffer(), no dma_iotlb_have_dyn variable.

That's my reasoning but to be absolutely sure, you can pass that through
some formal modelling.

-- 
Catalin
