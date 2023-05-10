Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919366FE07F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbjEJOiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237117AbjEJOiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:38:50 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 2EE0A268E
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:38:49 -0700 (PDT)
Received: (qmail 623646 invoked by uid 1000); 10 May 2023 10:38:48 -0400
Date:   Wed, 10 May 2023 10:38:48 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Ruihan Li <lrh2000@pku.edu.cn>
Cc:     linux-mm@kvack.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/4] usb: usbfs: Use consistent mmap functions
Message-ID: <e197f549-0ee7-446e-86af-ac173d047df5@rowland.harvard.edu>
References: <20230510085527.57953-1-lrh2000@pku.edu.cn>
 <20230510085527.57953-3-lrh2000@pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510085527.57953-3-lrh2000@pku.edu.cn>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 04:55:25PM +0800, Ruihan Li wrote:
> When hcd->localmem_pool is non-null, it is used to allocate DMA memory.
> In this case, the dma address will be properly returned (in dma_handle),
> and dma_mmap_coherent should be used to map this memory into the user
> space. However, the current implementation uses pfn_remap_range, which
> is supposed to map normal pages (instead of DMA pages).
> 
> Instead of repeating the logic in the memory allocation function, this
> patch introduces a more robust solution. To address the previous issue,
> this patch checks the type of allocated memory by testing whether
> dma_handle is properly set. If dma_handle is properly returned, it means
> some DMA pages are allocated and dma_mmap_coherent should be used to map
> them. Otherwise, normal pages are allocated and pfn_remap_range should
> be called. This ensures that the correct mmap functions are used
> consistently, independently with logic details that determine which type
> of memory gets allocated.
> 
> Fixes: a0e710a7def4 ("USB: usbfs: fix mmap dma mismatch")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
> ---
>  drivers/usb/core/devio.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> index b4cf9e860..5067030b7 100644
> --- a/drivers/usb/core/devio.c
> +++ b/drivers/usb/core/devio.c
> @@ -235,7 +235,7 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
>  	size_t size = vma->vm_end - vma->vm_start;
>  	void *mem;
>  	unsigned long flags;
> -	dma_addr_t dma_handle;
> +	dma_addr_t dma_handle = DMA_MAPPING_ERROR;
>  	int ret;
>  
>  	ret = usbfs_increase_memory_usage(size + sizeof(struct usb_memory));
> @@ -265,7 +265,13 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
>  	usbm->vma_use_count = 1;
>  	INIT_LIST_HEAD(&usbm->memlist);
>  
> -	if (hcd->localmem_pool || !hcd_uses_dma(hcd)) {
> +	/* In DMA-unavailable cases, hcd_buffer_alloc_pages allocates
> +	 * normal pages and assigns DMA_MAPPING_ERROR to dma_handle. Check
> +	 * whether we are in such cases, and then use remap_pfn_range (or
> +	 * dma_mmap_coherent) to map normal (or DMA) pages into the user
> +	 * space, respectively.
> +	 */

Another stylistic issue.  For multi-line comments, the format we use is:

	/*
	 * Blah, blah, blah
	 * Blah, blah, blah
	 */

Alan Stern
