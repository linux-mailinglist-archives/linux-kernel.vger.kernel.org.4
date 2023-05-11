Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCC66FF356
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237973AbjEKNpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237782AbjEKNp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:45:28 -0400
Received: from pku.edu.cn (mx19.pku.edu.cn [162.105.129.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96D07EC;
        Thu, 11 May 2023 06:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:References:MIME-Version:Content-Type:
        Content-Disposition:In-Reply-To; bh=qXBu95G5bfbSWSftu3sO2tbsazve
        Sm7qRkHUMjdgwts=; b=iMoeqcAW+2fizTQ8Z8d5Pu3fZLdYR12DMnIhta312ALj
        bHqQaiGVJfw6ZJ6pt726rFcvFXqEDmaXKMs9dYlFsYbR+pvJk80GA0HhNsrKB+AY
        I8ei1C5k5NNtMcr4HPlfb61+2qvm1BAryHwE5mNodQ5KG57iDIdwCM1fKHCXxjM=
Received: from localhost (unknown [10.7.101.92])
        by front02 (Coremail) with SMTP id 54FpogAnI7pY8Vxk29+OEw--.15738S2;
        Thu, 11 May 2023 21:44:59 +0800 (CST)
Date:   Thu, 11 May 2023 21:44:55 +0800
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mm@kvack.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ruihan Li <lrh2000@pku.edu.cn>
Subject: Re: [PATCH 0/4] Fix type confusion in page_table_check
Message-ID: <cyym2uqyqdtegfbdpworng4fa7iiuyh3e2wjrf4lp47jksvoxt@wwhvnzy5757c>
References: <20230510085527.57953-1-lrh2000@pku.edu.cn>
 <2023051108-lens-unsocial-8425@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023051108-lens-unsocial-8425@gregkh>
X-CM-TRANSID: 54FpogAnI7pY8Vxk29+OEw--.15738S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1DCFW7CryxWw4kJF1UJrb_yoWrJrWUpa
        nrJr42yFs8tFZ7X34kKa1xua48Zwn5Z3yUGry8Wr98uFnIq34Skr1fCay3ZFy3Zr4kGw1I
        qan0qa43t3WrAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9S1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24V
        AvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
        8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Kr1UJr1l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r
        4UYxBIdaVFxhVjvjDU0xZFpf9x0JUQZ23UUUUU=
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEHBVPy772BUwAMss
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 07:51:58AM +0900, Greg Kroah-Hartman wrote:
> On Wed, May 10, 2023 at 04:55:23PM +0800, Ruihan Li wrote:
> > Recently, syzbot reported [1] ("kernel BUG in page_table_check_clear").
> > The root cause is that usbdev_mmap calls remap_pfn_range on kmalloc'ed
> > memory, which leads to type confusion between struct page and slab in
> > page_table_check. This series of patches fixes the usb side by avoiding
> > mapping slab pages into userspace, and fixes the mm side by enforcing
> > that all user-accessible pages are not slab pages. A more detailed
> > analysis and some discussion of how to fix the problem can also be found
> > in [1].
> > 
> >  [1] https://lore.kernel.org/lkml/20230507135844.1231056-1-lrh2000@pku.edu.cn/T/
> 
> Can you see if you can implement Christoph's proposed change instead:
> 	https://lore.kernel.org/r/ZFuZVDcU81WmqEvJ@infradead.org
> 
> As it might not actually be as bad as you think to require this type of
> churn.
> 
> thanks,
> 
> greg k-h

Sorry, but no.

Christoph's patch perfectly fixes _one_ problem: kmalloc'ed memory
cannot be mapped to user space. However, as I detailed in the commit
message, this series of patches fixes _three_ problems.

I have to say that the original code is quite buggy. In the
gen_pool_dma_alloc path, there is no guarantee of page alignment. 

void *hcd_buffer_alloc(...)
{
	// ...
	if (hcd->localmem_pool)
		return gen_pool_dma_alloc(hcd->localmem_pool, size, dma);
	// ...
}

When localmem_pool gets initialized, the alignment bits are set to 4
(instead of PAGE_SHIFT).

int usb_hcd_setup_local_mem(struct usb_hcd *hcd, phys_addr_t phys_addr,
			    dma_addr_t dma, size_t size)
{
	// ...
	hcd->localmem_pool = devm_gen_pool_create(hcd->self.sysdev, 4,
						  dev_to_node(hcd->self.sysdev),
						  dev_name(hcd->self.sysdev));
	// ...
}

It is introduced by commit ff2437befd8f ("usb: host: Fix excessive
alignment restriction for local memory allocations") [1].

 [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ff2437befd8fe52046e0db949347b5bcfab6b097

If you don't believe me, please see my test results. In the following
qemu setup,

	qemu-system-sh4 -M r2d -kernel arch/sh/boot/zImage \
		-usb -device usb-storage,drive=d0 \
		-drive file=test.img,if=none,id=d0,format=raw \
		-append "console=tty0 console=ttySC1,115200 rootwait root=/dev/sda init=/bin/sh" \
		-serial null -serial stdio

together with the following patch,

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index e501a03d6..d7069c986 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -265,6 +265,10 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
 	INIT_LIST_HEAD(&usbm->memlist);
 
 	if (hcd->localmem_pool || !hcd_uses_dma(hcd)) {
+		printk("usb_alloc_coherent returns %px\n", usbm->mem);
+		printk("so the mapping starts at %lx\n",
+				virt_to_phys(usbm->mem) >> PAGE_SHIFT);
+
 		if (remap_pfn_range(vma, vma->vm_start,
 				    virt_to_phys(usbm->mem) >> PAGE_SHIFT,
 				    size, vma->vm_page_prot) < 0) {

it quickly leads to the following output when I manage to map a page
from /dev/bus/usb/001/002,

	usb_alloc_coherent returns b07c06c0
	so the mapping starts at 307c0

What's more, in this case, remap_pfn_range should _not_ be used, since
we are going to map a DMA page. However, as you can see, usbdev_mmap
actually goes to the wrong path.

If you say I shouldn't fix all these bugs in _this_ patch series, that's
fine. However, I do think that these bugs should be fixed, perhaps in
another patch series.

Thanks,
Ruihan Li

