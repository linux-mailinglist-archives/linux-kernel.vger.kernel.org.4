Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EC8704C94
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjEPLn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjEPLn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:43:26 -0400
Received: from pku.edu.cn (mx18.pku.edu.cn [162.105.129.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0BED26B5;
        Tue, 16 May 2023 04:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:References:MIME-Version:Content-Type:
        Content-Disposition:In-Reply-To; bh=H9he+rg+FJu/lva+YkA+P4NB891u
        ftZsubcF7D6o6y8=; b=PkcE7eCJcZ7WB4DdVMs1pe86EZ4dwiixFnqMY9R5THaR
        vzettkVHlC4UqhiNEwIN2aBFoD4KHmhtE26Q91BsWv1PvmUMVxUmZehwG0RnVWBJ
        +tYzM017P5RwWFsf/f+TEBI8JktBn8sr+atwffRwrgC+4hXnisUaveIn9EGrIp4=
Received: from localhost (unknown [10.7.98.243])
        by front01 (Coremail) with SMTP id 5oFpogD3_JQ8bGNk3+hsAw--.2746S2;
        Tue, 16 May 2023 19:42:56 +0800 (CST)
Date:   Tue, 16 May 2023 19:42:51 +0800
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Ruihan Li <lrh2000@pku.edu.cn>
Subject: Re: [PATCH v2 2/4] usb: usbfs: Use consistent mmap functions
Message-ID: <uk5djnbfunnjn2lrtpsvdv3qh6acaunlp7l76ztrucwdmzvo5e@hmwqjrb2s2i5>
References: <20230515130958.32471-1-lrh2000@pku.edu.cn>
 <20230515130958.32471-3-lrh2000@pku.edu.cn>
 <2b6cb73d2cd14a46b7e4553566030b22@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b6cb73d2cd14a46b7e4553566030b22@AcuMS.aculab.com>
X-CM-TRANSID: 5oFpogD3_JQ8bGNk3+hsAw--.2746S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF4UArW5Cw4UWrW5Jw43Jrb_yoW5Jw17pr
        W7G34Ikw4jq34rWrnruan3XFZ8Kwn5KFsxGr1YvwnxZ39xXrn7CrySkFy2kFy7tr1DGa1j
        qFWvvry8G3WDAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEMBVPy7743xAAUsd
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 04:07:01PM +0000, David Laight wrote:
> 
> From: Ruihan Li
> > Sent: 15 May 2023 14:10
> > 
> > When hcd->localmem_pool is non-null, localmem_pool is used to allocate
> > DMA memory. In this case, the dma address will be properly returned (in
> > dma_handle), and dma_mmap_coherent should be used to map this memory
> > into the user space. However, the current implementation uses
> > pfn_remap_range, which is supposed to map normal pages.
> 
> I've an (out of tree) driver that does the same.
> Am I right in thinking that this does still work?

Generally, it still works most of the time, but it can break sometimes.
I am going to quote commit 2bef9aed6f0e ("usb: usbfs: correct
kernel->user page attribute mismatch"), which introduces
dma_mmap_coherent in usbdev_mmap, and says [1]:

	On some architectures (e.g. arm64) requests for
	IO coherent memory may use non-cachable attributes if
	the relevant device isn't cache coherent. If these
	pages are then remapped into userspace as cacheable,
	they may not be coherent with the non-cacheable mappings.

 [1] https://lore.kernel.org/all/20200504201348.1183246-1-jeremy.linton@arm.com/

I think it means that if your driver deals with devices that aren't
cache-coherent on arm64, using pfn_remap_range directly may cause
problems. Otherwise, you may need to check the arch-specific dma mmap
operation and see if it performs additional things that pfn_remap_range
does not (for the arm example, arm_iommu_mmap_attrs updates the
vm_page_prot field to make the pages non-cacheable if the device is not
cache-coherent [2]).

 [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/mm/dma-mapping.c?id=f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6#n1129

> 
> I can't change the driver to use dma_map_coherent() because it
> doesn't let me mmap from a page offset within a 16k allocation.
> 
> In this case the memory area is an 8MB shared transfer area to an
> FPGA PCIe target sparsely filled with 16kB allocation (max 512 allocs).
> The discontinuous physical memory blocks appear as logically
> contiguous to both the FPGA logic and when mapped to userspace.
> (But not to driver code.)
> 
> I don't really want to expose the 16k allocation size to userspace.
> If we need more than 8MB then the allocation size would need
> changing.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

Thanks,
Ruihan Li

