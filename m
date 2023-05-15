Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58414702F39
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240096AbjEOOHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239978AbjEOOHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:07:22 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D1F551982
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 07:07:16 -0700 (PDT)
Received: (qmail 791507 invoked by uid 1000); 15 May 2023 10:07:15 -0400
Date:   Mon, 15 May 2023 10:07:15 -0400
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
Subject: Re: [PATCH v2 1/4] usb: usbfs: Enforce page requirements for mmap
Message-ID: <761a2bf5-fdd3-4b4d-a14c-87add51db13a@rowland.harvard.edu>
References: <20230515130958.32471-1-lrh2000@pku.edu.cn>
 <20230515130958.32471-2-lrh2000@pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515130958.32471-2-lrh2000@pku.edu.cn>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 09:09:55PM +0800, Ruihan Li wrote:
> The current implementation of usbdev_mmap uses usb_alloc_coherent to
> allocate memory pages that will later be mapped into the user space.
> Meanwhile, usb_alloc_coherent employs three different methods to
> allocate memory, as outlined below:
>  * If hcd->localmem_pool is non-null, it uses gen_pool_dma_alloc to
>    allocate memory;
>  * If DMA is not available, it uses kmalloc to allocate memory;
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
> Fixes: f7d34b445abc ("USB: Add support for usbfs zerocopy.")
> Fixes: ff2437befd8f ("usb: host: Fix excessive alignment restriction for local memory allocations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
> ---

For parts 1/4 and 2/4:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern
