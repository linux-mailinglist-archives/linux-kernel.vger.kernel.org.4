Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6656FE1B6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 17:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237691AbjEJPld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 11:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237622AbjEJPlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 11:41:25 -0400
Received: from pku.edu.cn (mx19.pku.edu.cn [162.105.129.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF7E63583;
        Wed, 10 May 2023 08:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:References:MIME-Version:Content-Type:
        Content-Disposition:In-Reply-To; bh=f2kwca3p5lvmK1UKkYNiCNtEhFHR
        gCfnV1Hv36vabJE=; b=AUAyj4Rh8ryw5jfWK+eYdxwMtpGmL+2cMOMiHRSIKmRO
        Ux8B+3fGADgsT9+Y57nXL03gP7QhZ/Koli5PlZj447yjYLzMU4pazuL1FRvlYgWL
        D3bj89QLxyVciAJ05H3DVZ5Q+FwurbUdFHFVvztcxIUAjDbvB1hFuVX9ikdiTHc=
Received: from localhost (unknown [10.7.101.92])
        by front02 (Coremail) with SMTP id 54FpogCXbjgRu1tkSAlvEw--.9090S2;
        Wed, 10 May 2023 23:41:10 +0800 (CST)
Date:   Wed, 10 May 2023 23:41:05 +0800
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-mm@kvack.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ruihan Li <lrh2000@pku.edu.cn>
Subject: Re: [PATCH 2/4] usb: usbfs: Use consistent mmap functions
Message-ID: <w6keszmqdkwsuw5k3dsyl67zgndorxsoeenysjyzlzf5v4p6bl@mvztdsgt7qjj>
References: <20230510085527.57953-1-lrh2000@pku.edu.cn>
 <20230510085527.57953-3-lrh2000@pku.edu.cn>
 <e197f549-0ee7-446e-86af-ac173d047df5@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e197f549-0ee7-446e-86af-ac173d047df5@rowland.harvard.edu>
X-CM-TRANSID: 54FpogCXbjgRu1tkSAlvEw--.9090S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr4fXFWUAry5Jr4xtF48Crg_yoW5Xw4xpF
        W8t3yjkF4YqFyI9r12van8WFyfGwn5KFyUGryIv3sxu3W3Xr1SkFySkFy5ZF12yr10qr1I
        vFWqyw13u3W5uFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24V
        AvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
        8cxan2IY04v7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26w
        4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
        r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
        IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1c4S5UUUUU==
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEHBVPy772BUwAGsm
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Wed, May 10, 2023 at 10:38:48AM -0400, Alan Stern wrote:
> On Wed, May 10, 2023 at 04:55:25PM +0800, Ruihan Li wrote:
> > When hcd->localmem_pool is non-null, it is used to allocate DMA memory.
> > In this case, the dma address will be properly returned (in dma_handle),
> > and dma_mmap_coherent should be used to map this memory into the user
> > space. However, the current implementation uses pfn_remap_range, which
> > is supposed to map normal pages (instead of DMA pages).
> > 
> > Instead of repeating the logic in the memory allocation function, this
> > patch introduces a more robust solution. To address the previous issue,
> > this patch checks the type of allocated memory by testing whether
> > dma_handle is properly set. If dma_handle is properly returned, it means
> > some DMA pages are allocated and dma_mmap_coherent should be used to map
> > them. Otherwise, normal pages are allocated and pfn_remap_range should
> > be called. This ensures that the correct mmap functions are used
> > consistently, independently with logic details that determine which type
> > of memory gets allocated.
> > 
> > Fixes: a0e710a7def4 ("USB: usbfs: fix mmap dma mismatch")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
> > ---
> >  drivers/usb/core/devio.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> > index b4cf9e860..5067030b7 100644
> > --- a/drivers/usb/core/devio.c
> > +++ b/drivers/usb/core/devio.c
> > @@ -235,7 +235,7 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
> >  	size_t size = vma->vm_end - vma->vm_start;
> >  	void *mem;
> >  	unsigned long flags;
> > -	dma_addr_t dma_handle;
> > +	dma_addr_t dma_handle = DMA_MAPPING_ERROR;
> >  	int ret;
> >  
> >  	ret = usbfs_increase_memory_usage(size + sizeof(struct usb_memory));
> > @@ -265,7 +265,13 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
> >  	usbm->vma_use_count = 1;
> >  	INIT_LIST_HEAD(&usbm->memlist);
> >  
> > -	if (hcd->localmem_pool || !hcd_uses_dma(hcd)) {
> > +	/* In DMA-unavailable cases, hcd_buffer_alloc_pages allocates
> > +	 * normal pages and assigns DMA_MAPPING_ERROR to dma_handle. Check
> > +	 * whether we are in such cases, and then use remap_pfn_range (or
> > +	 * dma_mmap_coherent) to map normal (or DMA) pages into the user
> > +	 * space, respectively.
> > +	 */
> 
> Another stylistic issue.  For multi-line comments, the format we use is:
> 
> 	/*
> 	 * Blah, blah, blah
> 	 * Blah, blah, blah
> 	 */
> 
> Alan Stern

Yeah, I am pretty sure it is another style difference with the net
subsystem. Again, in the next version, I'll follow the coding style that
you have pointed out.

Thanks,
Ruihan Li

