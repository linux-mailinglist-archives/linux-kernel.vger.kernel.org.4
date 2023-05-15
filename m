Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43565702DB2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242338AbjEONLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242256AbjEONKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:10:47 -0400
Received: from pku.edu.cn (mx19.pku.edu.cn [162.105.129.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81A541FE1;
        Mon, 15 May 2023 06:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:In-Reply-To:References:MIME-Version:
        Content-Transfer-Encoding; bh=/FgfHoZt8CIbKJeIzVtG6eMW7phMC0X6WN
        ZhYU6z8NA=; b=PVR2JpuBpFykLKuVCgCH22JOoFEc9akgZ4VtiJL+zH0wkNoS7Z
        BOnFWHBWzU6kJoWm1JYRFWumdKZFtE4e5cwT9cLGc7CtOFL1mqdVtMRk3RvapPFh
        NIO2NsECPkFJ8R0iesR/q0q9iMjXiuzCbNY7VCJt/MzZh+2rAwwILyy2o=
Received: from localhost.localdomain (unknown [10.7.98.243])
        by front02 (Coremail) with SMTP id 54FpogAnLDgqL2JkVboyFA--.10053S3;
        Mon, 15 May 2023 21:10:07 +0800 (CST)
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     linux-mm@kvack.org, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ruihan Li <lrh2000@pku.edu.cn>,
        syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.comm,
        stable@vger.kernel.org
Subject: [PATCH v2 1/4] usb: usbfs: Enforce page requirements for mmap
Date:   Mon, 15 May 2023 21:09:55 +0800
Message-Id: <20230515130958.32471-2-lrh2000@pku.edu.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515130958.32471-1-lrh2000@pku.edu.cn>
References: <20230515130958.32471-1-lrh2000@pku.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 54FpogAnLDgqL2JkVboyFA--.10053S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXryrGr4kuFyktw4DGw48WFg_yoW7Gr1UpF
        sxWr4YkrW5tr1xXrn3KFs8ua45Zws5uFyUKrWxu3s3uF13J3sakFn5AFW5ZF1fXr4qgr4r
        tFn0krWYk3WUG37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBI1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24V
        AvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF
        7I0E8cxan2IY04v7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
        x26w4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEMBVPy77495gAAsh
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation of usbdev_mmap uses usb_alloc_coherent to
allocate memory pages that will later be mapped into the user space.
Meanwhile, usb_alloc_coherent employs three different methods to
allocate memory, as outlined below:
 * If hcd->localmem_pool is non-null, it uses gen_pool_dma_alloc to
   allocate memory;
 * If DMA is not available, it uses kmalloc to allocate memory;
 * Otherwise, it uses dma_alloc_coherent.

However, it should be noted that gen_pool_dma_alloc does not guarantee
that the resulting memory will be page-aligned. Furthermore, trying to
map slab pages (i.e., memory allocated by kmalloc) into the user space
is not resonable and can lead to problems, such as a type confusion bug
when PAGE_TABLE_CHECK=y [1].

To address these issues, this patch introduces hcd_alloc_coherent_pages,
which addresses the above two problems. Specifically,
hcd_alloc_coherent_pages uses gen_pool_dma_alloc_align instead of
gen_pool_dma_alloc to ensure that the memory is page-aligned. To replace
kmalloc, hcd_alloc_coherent_pages directly allocates pages by calling
__get_free_pages.

Reported-by: syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.comm
Closes: https://lore.kernel.org/lkml/000000000000258e5e05fae79fc1@google.com/ [1]
Fixes: f7d34b445abc ("USB: Add support for usbfs zerocopy.")
Fixes: ff2437befd8f ("usb: host: Fix excessive alignment restriction for local memory allocations")
Cc: stable@vger.kernel.org
Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
---
 drivers/usb/core/buffer.c | 41 +++++++++++++++++++++++++++++++++++++++
 drivers/usb/core/devio.c  |  9 +++++----
 include/linux/usb/hcd.h   |  5 +++++
 3 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
index fbb087b72..268ccbec8 100644
--- a/drivers/usb/core/buffer.c
+++ b/drivers/usb/core/buffer.c
@@ -172,3 +172,44 @@ void hcd_buffer_free(
 	}
 	dma_free_coherent(hcd->self.sysdev, size, addr, dma);
 }
+
+void *hcd_buffer_alloc_pages(struct usb_hcd *hcd,
+		size_t size, gfp_t mem_flags, dma_addr_t *dma)
+{
+	if (size == 0)
+		return NULL;
+
+	if (hcd->localmem_pool)
+		return gen_pool_dma_alloc_align(hcd->localmem_pool,
+				size, dma, PAGE_SIZE);
+
+	/* some USB hosts just use PIO */
+	if (!hcd_uses_dma(hcd)) {
+		*dma = DMA_MAPPING_ERROR;
+		return (void *)__get_free_pages(mem_flags,
+				get_order(size));
+	}
+
+	return dma_alloc_coherent(hcd->self.sysdev,
+			size, dma, mem_flags);
+}
+
+void hcd_buffer_free_pages(struct usb_hcd *hcd,
+		size_t size, void *addr, dma_addr_t dma)
+{
+	if (!addr)
+		return;
+
+	if (hcd->localmem_pool) {
+		gen_pool_free(hcd->localmem_pool,
+				(unsigned long)addr, size);
+		return;
+	}
+
+	if (!hcd_uses_dma(hcd)) {
+		free_pages((unsigned long)addr, get_order(size));
+		return;
+	}
+
+	dma_free_coherent(hcd->self.sysdev, size, addr, dma);
+}
diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index e501a03d6..3936ca7f7 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -186,6 +186,7 @@ static int connected(struct usb_dev_state *ps)
 static void dec_usb_memory_use_count(struct usb_memory *usbm, int *count)
 {
 	struct usb_dev_state *ps = usbm->ps;
+	struct usb_hcd *hcd = bus_to_hcd(ps->dev->bus);
 	unsigned long flags;
 
 	spin_lock_irqsave(&ps->lock, flags);
@@ -194,8 +195,8 @@ static void dec_usb_memory_use_count(struct usb_memory *usbm, int *count)
 		list_del(&usbm->memlist);
 		spin_unlock_irqrestore(&ps->lock, flags);
 
-		usb_free_coherent(ps->dev, usbm->size, usbm->mem,
-				usbm->dma_handle);
+		hcd_buffer_free_pages(hcd, usbm->size,
+				usbm->mem, usbm->dma_handle);
 		usbfs_decrease_memory_usage(
 			usbm->size + sizeof(struct usb_memory));
 		kfree(usbm);
@@ -247,8 +248,8 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
 		goto error_decrease_mem;
 	}
 
-	mem = usb_alloc_coherent(ps->dev, size, GFP_USER | __GFP_NOWARN,
-			&dma_handle);
+	mem = hcd_buffer_alloc_pages(hcd,
+			size, GFP_USER | __GFP_NOWARN, &dma_handle);
 	if (!mem) {
 		ret = -ENOMEM;
 		goto error_free_usbm;
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 094c77eaf..0c7eff91a 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -501,6 +501,11 @@ void *hcd_buffer_alloc(struct usb_bus *bus, size_t size,
 void hcd_buffer_free(struct usb_bus *bus, size_t size,
 	void *addr, dma_addr_t dma);
 
+void *hcd_buffer_alloc_pages(struct usb_hcd *hcd,
+		size_t size, gfp_t mem_flags, dma_addr_t *dma);
+void hcd_buffer_free_pages(struct usb_hcd *hcd,
+		size_t size, void *addr, dma_addr_t dma);
+
 /* generic bus glue, needed for host controllers that don't use PCI */
 extern irqreturn_t usb_hcd_irq(int irq, void *__hcd);
 
-- 
2.40.1

