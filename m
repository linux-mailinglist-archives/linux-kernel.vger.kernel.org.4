Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3642B6F98C9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 16:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjEGOF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 10:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjEGOF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 10:05:56 -0400
X-Greylist: delayed 407 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 07 May 2023 07:05:50 PDT
Received: from pku.edu.cn (mx18.pku.edu.cn [162.105.129.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2128B13281;
        Sun,  7 May 2023 07:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:In-Reply-To:References:MIME-Version:
        Content-Transfer-Encoding; bh=UZBUtjpqaHHJyf9pW8GlxR48yvNlVH7+xP
        yCDqkF5M0=; b=VUDT1/Anm58YMTdT/uSU9dQqEjGSVJ01RzrbP5Ozq8g8SNpZfL
        idgaOoDcv1ChUi6PjMC6ISfOh55PbrDXeRiBC4tLHGkV5fv5uDwbBXrsWY4EpTnB
        K483mhHv8KSrsvw5+sQb4cMsc6u3kNMaoQTfH9B/Av3a+4WCl8xyUb0xk=
Received: from localhost.localdomain (unknown [10.7.101.92])
        by front02 (Coremail) with SMTP id 54FpogBHTU2Urldktw0OEw--.9528S2;
        Sun, 07 May 2023 21:58:47 +0800 (CST)
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.com
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, pasha.tatashin@soleen.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, Ruihan Li <lrh2000@pku.edu.cn>
Subject: usbdev_mmap causes type confusion in page_table_check
Date:   Sun,  7 May 2023 21:58:44 +0800
Message-Id: <20230507135844.1231056-1-lrh2000@pku.edu.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <000000000000258e5e05fae79fc1@google.com>
References: <000000000000258e5e05fae79fc1@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 54FpogBHTU2Urldktw0OEw--.9528S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AryUKFy8ZF4DAr45Gr48WFg_yoWxJr18pF
        Wagw1UKrs0g34rXr1qvws5ZFyFyw4rGayUGw4fC34Sv3Z8Jwn29F1rtF9xZF1kKrZ3G3WI
        qF4qg3s0y3WUZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvE1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24V
        AvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm
        -wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26w4UJr1UMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWI
        evJa73UjIFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEEBVPy770DbgAAsc
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Recently, syzbot reported [1] ("kernel BUG in page_table_check_clear"). After
some bisection, I found out that when usbdev_mmap calls remap_pfn_range on
kmalloc'ed memory, it causes type confusion between struct folio and slab in
page_table_check. As I will explain below, it seems that both usb-side and
mm-side need some fixes. So I have cc'd linux-usb and linux-mm here, as well
as their maintainers, to see whether there are any comments on the proposed
way to fix.

 [1] https://lore.kernel.org/all/000000000000258e5e05fae79fc1@google.com/

To handle mmap requests for /dev/bus/usb/XXX/YYY, usbdev_mmap first allocates
memory by calling usb_alloc_coherent and then maps it into the user space
using remap_pfn_range:

static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
{
	// ...
	mem = usb_alloc_coherent(ps->dev, size, GFP_USER | __GFP_NOWARN,
			&dma_handle);
	// ...
	if (hcd->localmem_pool || !hcd_uses_dma(hcd)) {
		if (remap_pfn_range(vma, vma->vm_start,
				    virt_to_phys(usbm->mem) >> PAGE_SHIFT,
				    size, vma->vm_page_prot) < 0) {
			// ...
		}
	}
	// ...
}

Note that in this case, we consider the DMA-unavailable scenario, which, to be
honest, is rare in practice. However, syzbot emulates USB devices using a
module named dummy_hcd, and since these devices are emulated, DMA is not
available at all.

Meanwhile, usb_alloc_coherent calls hcd_buffer_alloc, which uses kmalloc for
memory allocation:

void *hcd_buffer_alloc(
	struct usb_bus		*bus,
	size_t			size,
	gfp_t			mem_flags,
	dma_addr_t		*dma
)
{
	// ...
	if (!hcd_uses_dma(hcd)) {
		*dma = ~(dma_addr_t) 0;
		return kmalloc(size, mem_flags);
	}
	// ...
}

However, during the update of the page table to map the kmalloc'd page into
the user space, page_table_check_set attempts to determine whether the page is
anonymous using PageAnon:

static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
				 unsigned long pfn, unsigned long pgcnt,
				 bool rw)
{
	// ...
	anon = PageAnon(page);
	for (i = 0; i < pgcnt; i++) {
		// ...
		if (anon) {
			BUG_ON(atomic_read(&ptc->file_map_count));
			BUG_ON(atomic_inc_return(&ptc->anon_map_count) > 1 && rw);
		} else {
			BUG_ON(atomic_read(&ptc->anon_map_count));
			BUG_ON(atomic_inc_return(&ptc->file_map_count) < 0);
		}
		// ...
	}
	// ...
}

This call to PageAnon is invalid for slab pages because slab reuses the bits
in struct page/folio to store its internal states, and the anonymity bit only
exists in struct page/folio. As a result, the counters are incorrectly updated
and checked in page_table_check_set and page_table_check_clear, leading to the
bug being raised.

Intuitively, I don't think it's reasonable to call remap_pfn_range to map
kmalloc'd pages into the user space. In the past, kmalloc'd pages might have
had alignment issues when certain memory debugging options were enabled.
Although this has been fixed in commit 59bb47985c1d ("mm, sl[aou]b: guarantee
natural alignment for kmalloc(power-of-two)"), it has been shown that
performing such mapping is still buggy, as demonstrated by the type confusion
in page_table_check. Therefore, I propose adding a new function,
hcd_buffer_alloc_pages, to guarantee the page requirements (i.e., no
intermediate allocators, such as slab/slub). Below is a diff as a quick
example:

diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
index fbb087b72..514bdc949 100644
--- a/drivers/usb/core/buffer.c
+++ b/drivers/usb/core/buffer.c
@@ -112,7 +112,7 @@ void hcd_buffer_destroy(struct usb_hcd *hcd)
  * better sharing and to leverage mm/slab.c intelligence.
  */
 
-void *hcd_buffer_alloc(
+void *hcd_buffer_alloc_pages(
 	struct usb_bus		*bus,
 	size_t			size,
 	gfp_t			mem_flags,
@@ -126,12 +126,13 @@ void *hcd_buffer_alloc(
 		return NULL;
 
 	if (hcd->localmem_pool)
-		return gen_pool_dma_alloc(hcd->localmem_pool, size, dma);
+		return gen_pool_dma_alloc_align(hcd->localmem_pool, size,
+						dma, PAGE_SIZE);
 
 	/* some USB hosts just use PIO */
 	if (!hcd_uses_dma(hcd)) {
 		*dma = ~(dma_addr_t) 0;
-		return kmalloc(size, mem_flags);
+		return (void *)__get_free_pages(mem_flags, get_order(size));
 	}
 
 	for (i = 0; i < HCD_BUFFER_POOLS; i++) {

(There appears to be another issue. In cases where hcd->localmem_pool is
non-null, I suspect that remap_pfn_range should not be used. This is a DMA
scenario, and the DMA handle is properly returned, so dma_mmap_coherent should
be used instead. Am I correct?)

This does not actually fix the type confusion bug in page_table_check_*. It
should be noted that by leveraging /dev/mem, users can map arbitrary physical
memory regions into the user space, which is also achieved through
remap_pfn_range. I'm not 100% certain whether a fix is necessary, as one may
argue that using page table checks (a kernel hardening technique, which means
security is important) and /dev/mem (clearly insecure and potentially
exploitable) together is completely unreasonable.

If a fix is deemed necessary, I think taking the flag VM_PFNMAP into
consideration is a reasonable solution, that said, in page_table_check_*,
 * when the VM_PFNMAP flag is set, all operations and checks on
   file_map_count and anon_map_count counters should be bypassed;
 * when the VM_PFNMAP flag is not set, an additionally check to ensure
   folio_test_slab evaluates to false should be performed.

The implementation should be straightforward. However, I noticed that the
page_table_check_* hooks are called in arch/* instead of mm/*, which not only
limits its supported architectures (currently x86_64, arm64, and risc-v) but
also makes it difficult to get the struct vm_area_struct as a parameter, since
the struct vm_area_struct is not passed from mm/* to arch/* when mapping or
unmapping pages. I have looked at d283d422c6c4 ("x86: mm: add x86_64 support
for page table check"), but I don't see a valid reason. Perhaps Pasha can
provide some explanation about this implementation choice?

Thanks,
Ruihan Li

