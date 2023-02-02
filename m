Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F516879CC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjBBKJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 05:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjBBKJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:09:31 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865DC8758F;
        Thu,  2 Feb 2023 02:09:30 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 46D1168C7B; Thu,  2 Feb 2023 11:09:27 +0100 (CET)
Date:   Thu, 2 Feb 2023 11:09:26 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Dr. David Alan Gilbert" <dave@treblig.org>
Cc:     iommu@lists.linux.dev, mchehab@kernel.org, hch@lst.de,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Regression: v4l/bttv vbi vs iommu
Message-ID: <20230202100926.GA14931@lst.de>
References: <Y9qSwkLxeMpffZK/@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9qSwkLxeMpffZK/@gallifrey>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 04:26:42PM +0000, Dr. David Alan Gilbert wrote:
> f5ff79fddf0efecca538046b5cc20fb3ded2ec4f is the first bad commit
> commit f5ff79fddf0efecca538046b5cc20fb3ded2ec4f
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Sat Feb 26 16:40:21 2022 +0100
> 
>     dma-mapping: remove CONFIG_DMA_REMAP

Which just enabled some code on common x86 configs that was already
used on many other platforms.  In other words:  the code already
was buggy, but got away with it on x86 so far as no one tested on
e.g. arm or arm64.

The bug is in videobuf_dma_init_kernel:

	for (i = 0; i < nr_pages; i++) {
		void *addr;

		addr = dma_alloc_coherent(dma->dev, PAGE_SIZE,
					  &(dma->dma_addr[i]), GFP_KERNEL);
		if (addr == NULL)
			goto out_free_pages;

		dma->vaddr_pages[i] = virt_to_page(addr);
	}
	dma->vaddr = vmap(dma->vaddr_pages, nr_pages, VM_MAP | VM_IOREMAP,
			  PAGE_KERNEL);

The address by dma_alloc_coherent is just a kernel virtual address,
and virt_to_page must not be used on it as it could be vmalloc (as in
this case) or various other really odd forms of memory.

