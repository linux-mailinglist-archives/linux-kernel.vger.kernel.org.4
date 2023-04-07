Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367686DABD8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 12:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjDGK5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 06:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbjDGK4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 06:56:47 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAA96A74
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 03:55:38 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id A361B14B53E;
        Fri,  7 Apr 2023 12:55:36 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1680864936; bh=U8kPN4Yj0CIndWrR4OoPEKQkLAq9ITd7QDh5nTQuHtI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wlWRwK7E//70YUYlOiwmvCLQ+JUVE6Fecr684ItS5b31MS7o3Fk8ZHf53PJTKqdcC
         CuG+OubZdMklUrQKPzOGGQj0pkv954uO/GphHHlEwMpYIIsBzLcUWWPisoI16u8WI6
         jesicsj6oI5VzUsprC2gRHMF3ISVM+UzaoPfIfQZeA6P8CvzXZnp2CEDA9N+Ksm0BI
         dOCN8Tc7wTBjvpw94EqBmH13XRq+8TMlmYfmhCPeW+CpCOEJ+mvMdJyJpIJV1Vch0M
         fgSS+T2G0mSrEsi0sESZ37tLnaapUrabxcXQzdMQL5GlO4p6hI+8traPSm7KU/wY3l
         5jpj9hPwuBhOA==
Date:   Fri, 7 Apr 2023 12:55:35 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        decui@microsoft.com, tiala@microsoft.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] swiotlb: Track and report io_tlb_used high water
 mark in debugfs
Message-ID: <20230407125535.476350d4@meshulam.tesarici.cz>
In-Reply-To: <1680324300-124563-1-git-send-email-mikelley@microsoft.com>
References: <1680324300-124563-1-git-send-email-mikelley@microsoft.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2023 21:45:00 -0700
Michael Kelley <mikelley@microsoft.com> wrote:

> swiotlb currently reports the total number of slabs and the instantaneous
> in-use slabs in debugfs. But with increased usage of swiotlb for all I/O
> in Confidential Computing (coco) VMs, it has become difficult to know
> how much memory to allocate for swiotlb bounce buffers, either via the
> automatic algorithm in the kernel or by specifying a value on the
> kernel boot line. The current automatic algorithm generously allocates
> swiotlb bounce buffer memory, and may be wasting significant memory in
> many use cases.
> 
> To support better understanding of swiotlb usage, add tracking of the
> the high water mark usage of the default swiotlb bounce buffer memory
> pool. Report the high water mark in debugfs along with the other swiotlb
> metrics.  Allow the high water mark to be reset to zero at runtime by
> writing to it.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
> Changes in v3:
> * Do high water mark accounting only when CONFIG_DEBUG_FS=y. As
>   as a result, add back the mem_used() function for the "swiotlb
>   buffer is full" error message. [Christoph -- I didn't hear back
>   whether this approach addresses your concern about one additional
>   atomic operation when slots are allocated and again when freed. I've
>   gone ahead with this new version, and we can obviously have further
>   discussion.]
> 
> * Remove unnecessary u64 casts. [Christoph Hellwig]
> 
> * Track slot usage and the high water mark only for io_tlb_default_mem.
>   Previous versions incorrectly included per-device pools. [Petr Tesarik]
> 
> Changes in v2:
> * Only reset the high water mark to zero when the specified new value
>   is zero, to prevent confusion about the ability to reset to some
>   other value [Dexuan Cui]
> 
>  kernel/dma/swiotlb.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index d3d6be0..6587a3d 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -76,6 +76,9 @@ struct io_tlb_slot {
>  static unsigned long default_nslabs = IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
>  static unsigned long default_nareas;
>  
> +static atomic_long_t total_used = ATOMIC_LONG_INIT(0);
> +static atomic_long_t used_hiwater = ATOMIC_LONG_INIT(0);
> +
>  /**
>   * struct io_tlb_area - IO TLB memory area descriptor
>   *
> @@ -594,6 +597,7 @@ static int swiotlb_do_find_slots(struct device *dev, int area_index,
>  	unsigned long flags;
>  	unsigned int slot_base;
>  	unsigned int slot_index;
> +	unsigned long old_hiwater, new_used;
>  
>  	BUG_ON(!nslots);
>  	BUG_ON(area_index >= mem->nareas);
> @@ -663,6 +667,17 @@ static int swiotlb_do_find_slots(struct device *dev, int area_index,
>  		area->index = 0;
>  	area->used += nslots;
>  	spin_unlock_irqrestore(&area->lock, flags);
> +
> +	if (IS_ENABLED(CONFIG_DEBUG_FS) && mem == &io_tlb_default_mem) {

Yes, this works fine now, but why are total_used and used_hiwater
global variables? If you make them fields in struct io_tlb_mem
(possibly guarded with #ifdef CONFIG_DEBUG_FS), you can get rid of the
check. Of course, in instances other than io_tlb_default_mem these
fields would not be exported to userspace through debugfs, but if really
needed, I can at least find them in a crash dump (or read them through
/proc/kcore).

Petr T
