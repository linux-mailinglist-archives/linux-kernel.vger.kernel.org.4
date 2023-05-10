Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0186FE1AE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 17:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbjEJPj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 11:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjEJPjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 11:39:47 -0400
Received: from pku.edu.cn (mx19.pku.edu.cn [162.105.129.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A62811BE4;
        Wed, 10 May 2023 08:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:References:MIME-Version:Content-Type:
        Content-Disposition:In-Reply-To; bh=E5X1EnY8H+9y2Bd0/LtCE7uJbb9e
        Ek4yWHczmrin+AY=; b=ZHxe2XQz9hSXcE4d88DTlLHtyDTyeiwG9+TTEVy0B1FH
        /GKBjvRkDEncHlC5rfaJ0T2ElgUf0/gMxVf6AHRUNGbvw5m4kkiVXRRZ2WS9mE9V
        +eeMJuqszXAVs3wTUw3IoDlbAPbUHfJ3DUl683KrLs6B9p06ZsR5W82AhSTQQRs=
Received: from localhost (unknown [10.7.101.92])
        by front01 (Coremail) with SMTP id 5oFpogCH7b5lultkKXGDAg--.38057S2;
        Wed, 10 May 2023 23:38:18 +0800 (CST)
Date:   Wed, 10 May 2023 23:38:12 +0800
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
        syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.comm,
        stable@vger.kernel.org, Ruihan Li <lrh2000@pku.edu.cn>
Subject: Re: [PATCH 1/4] usb: usbfs: Enforce page requirements for mmap
Message-ID: <a6ltxooqc5kvgnw5xhinbt2k4g4l3o6osdvlp3mfcxdp6oo6oc@6cpny4hyexqj>
References: <20230510085527.57953-1-lrh2000@pku.edu.cn>
 <20230510085527.57953-2-lrh2000@pku.edu.cn>
 <65ae7b7f-9dea-429f-aca6-2ce4a75b6531@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65ae7b7f-9dea-429f-aca6-2ce4a75b6531@rowland.harvard.edu>
X-CM-TRANSID: 5oFpogCH7b5lultkKXGDAg--.38057S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr4DJr48uw4DGF1kJrW5KFg_yoW5uF1fpF
        WrWr1Yka98tr93CrnIgFn8uFy5Zan5XFy5GryIv34rZr9xZry3Krn0yF45ur1kAr40ga1F
        qFs0yF1Yka45Za7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24V
        AvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
        8cxan2IY04v7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26w
        4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
        r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
        IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEHBVPy772BUwADsj
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

On Wed, May 10, 2023 at 10:37:45AM -0400, Alan Stern wrote:
> On Wed, May 10, 2023 at 04:55:24PM +0800, Ruihan Li wrote:
> > The current implementation of usbdev_mmap uses usb_alloc_coherent to
> > allocate memory pages that will later be mapped into the user space.
> > Meanwhile, usb_alloc_coherent employs three different methods to
> > allocate memory, as outlined below:
> >  * If hcd->localmem_pool is non-null, it uses gen_pool_dma_alloc to
> >    allocate memory.
> >  * If DMA is not available, it uses kmalloc to allocate memory.
> >  * Otherwise, it uses dma_alloc_coherent.
> > 
> > However, it should be noted that gen_pool_dma_alloc does not guarantee
> > that the resulting memory will be page-aligned. Furthermore, trying to
> > map slab pages (i.e., memory allocated by kmalloc) into the user space
> > is not resonable and can lead to problems, such as a type confusion bug
> > when PAGE_TABLE_CHECK=y [1].
> > 
> > To address these issues, this patch introduces hcd_alloc_coherent_pages,
> > which addresses the above two problems. Specifically,
> > hcd_alloc_coherent_pages uses gen_pool_dma_alloc_align instead of
> > gen_pool_dma_alloc to ensure that the memory is page-aligned. To replace
> > kmalloc, hcd_alloc_coherent_pages directly allocates pages by calling
> > __get_free_pages.
> > 
> > Reported-by: syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.comm
> > Closes: https://lore.kernel.org/lkml/000000000000258e5e05fae79fc1@google.com/ [1]
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
> > ---
> 
> I'm never quite sure about when it makes sense to complain about 
> stylistic issues.  Nevertheless, I'm going to do so here...
> 
> >  drivers/usb/core/buffer.c | 41 +++++++++++++++++++++++++++++++++++++++
> >  drivers/usb/core/devio.c  |  9 +++++----
> >  include/linux/usb/hcd.h   |  5 +++++
> >  3 files changed, 51 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
> > index fbb087b72..6010ef9f5 100644
> > --- a/drivers/usb/core/buffer.c
> > +++ b/drivers/usb/core/buffer.c
> > @@ -172,3 +172,44 @@ void hcd_buffer_free(
> >  	}
> >  	dma_free_coherent(hcd->self.sysdev, size, addr, dma);
> >  }
> > +
> > +void *hcd_buffer_alloc_pages(struct usb_hcd *hcd, size_t size,
> > +			     gfp_t mem_flags, dma_addr_t *dma)
> > +{
> > +	if (size == 0)
> > +		return NULL;
> > +
> > +	if (hcd->localmem_pool)
> > +		return gen_pool_dma_alloc_align(hcd->localmem_pool,
> > +						size, dma, PAGE_SIZE);
> 
> C isn't Lisp.  Expressions in C are not based entirely around 
> parentheses, and it's not necessary to align our code based on the 
> parenthesized sub-expressions to avoid hopelessly confusing the reader.
> 
> The style used in this file (and many other places in the USB core) is 
> to indent continuation lines by two tab stops.  The same comment applies 
> to all the other continuation lines you added or changed in this patch 
> and in patch 2/4.
> 
> Alan Stern

I'm just a bit shocked to find out that different subsystems might
prefer different styles of coding. In the net subsystem, checkpatch.pl
will complain that:
	CHECK: Alignment should match open parenthesis

Nevertheless, in the next version, I'll follow the coding style that you
have pointed out.

Thanks,
Ruihan Li

