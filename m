Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5665A6FE07C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbjEJOhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjEJOhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:37:48 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 8C6E13593
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:37:46 -0700 (PDT)
Received: (qmail 623576 invoked by uid 1000); 10 May 2023 10:37:45 -0400
Date:   Wed, 10 May 2023 10:37:45 -0400
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
        syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.comm,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/4] usb: usbfs: Enforce page requirements for mmap
Message-ID: <65ae7b7f-9dea-429f-aca6-2ce4a75b6531@rowland.harvard.edu>
References: <20230510085527.57953-1-lrh2000@pku.edu.cn>
 <20230510085527.57953-2-lrh2000@pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510085527.57953-2-lrh2000@pku.edu.cn>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 04:55:24PM +0800, Ruihan Li wrote:
> The current implementation of usbdev_mmap uses usb_alloc_coherent to
> allocate memory pages that will later be mapped into the user space.
> Meanwhile, usb_alloc_coherent employs three different methods to
> allocate memory, as outlined below:
>  * If hcd->localmem_pool is non-null, it uses gen_pool_dma_alloc to
>    allocate memory.
>  * If DMA is not available, it uses kmalloc to allocate memory.
>  * Otherwise, it uses dma_alloc_coherent.
> 
> However, it should be noted that gen_pool_dma_alloc does not guarantee
> that the resulting memory will be page-aligned. Furthermore, trying to
> map slab pages (i.e., memory allocated by kmalloc) into the user space
> is not resonable and can lead to problems, such as a type confusion bug
> when PAGE_TABLE_CHECK=y [1].
> 
> To address these issues, this patch introduces hcd_alloc_coherent_pages,
> which addresses the above two problems. Specifically,
> hcd_alloc_coherent_pages uses gen_pool_dma_alloc_align instead of
> gen_pool_dma_alloc to ensure that the memory is page-aligned. To replace
> kmalloc, hcd_alloc_coherent_pages directly allocates pages by calling
> __get_free_pages.
> 
> Reported-by: syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.comm
> Closes: https://lore.kernel.org/lkml/000000000000258e5e05fae79fc1@google.com/ [1]
> Cc: stable@vger.kernel.org
> Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
> ---

I'm never quite sure about when it makes sense to complain about 
stylistic issues.  Nevertheless, I'm going to do so here...

>  drivers/usb/core/buffer.c | 41 +++++++++++++++++++++++++++++++++++++++
>  drivers/usb/core/devio.c  |  9 +++++----
>  include/linux/usb/hcd.h   |  5 +++++
>  3 files changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
> index fbb087b72..6010ef9f5 100644
> --- a/drivers/usb/core/buffer.c
> +++ b/drivers/usb/core/buffer.c
> @@ -172,3 +172,44 @@ void hcd_buffer_free(
>  	}
>  	dma_free_coherent(hcd->self.sysdev, size, addr, dma);
>  }
> +
> +void *hcd_buffer_alloc_pages(struct usb_hcd *hcd, size_t size,
> +			     gfp_t mem_flags, dma_addr_t *dma)
> +{
> +	if (size == 0)
> +		return NULL;
> +
> +	if (hcd->localmem_pool)
> +		return gen_pool_dma_alloc_align(hcd->localmem_pool,
> +						size, dma, PAGE_SIZE);

C isn't Lisp.  Expressions in C are not based entirely around 
parentheses, and it's not necessary to align our code based on the 
parenthesized sub-expressions to avoid hopelessly confusing the reader.

The style used in this file (and many other places in the USB core) is 
to indent continuation lines by two tab stops.  The same comment applies 
to all the other continuation lines you added or changed in this patch 
and in patch 2/4.

Alan Stern
