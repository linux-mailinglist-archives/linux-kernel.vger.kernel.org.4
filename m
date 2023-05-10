Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96EF6FDA5E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 11:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbjEJJEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 05:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236947AbjEJJEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 05:04:12 -0400
Received: from pku.edu.cn (mx18.pku.edu.cn [162.105.129.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A6A230C7;
        Wed, 10 May 2023 02:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:In-Reply-To:References:MIME-Version:
        Content-Transfer-Encoding; bh=FCdoZypKOCF7Yar38FzSX/85JDvNvpncqZ
        ++kam1a4o=; b=jvCCbw1WH+LNsraRFmaFWBu79Plkic4etlcBNT2Q9/Pu+Ozgbj
        5yIQu+HzX+Df+l7RnwSSM/X2QK4J727QlDceCkFh0FJZTq57YTKR1/5mVne2XE0l
        REqck6axoRwbXR0l1nvzX5Hin4BdXaYw97JAI5ZYCwuvCumiC2g04qrys=
Received: from localhost.localdomain (unknown [10.7.101.92])
        by front01 (Coremail) with SMTP id 5oFpogBnb2cIXFtkW9d5Ag--.63159S3;
        Wed, 10 May 2023 16:55:42 +0800 (CST)
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     linux-mm@kvack.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ruihan Li <lrh2000@pku.edu.cn>,
        syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.comm,
        stable@vger.kernel.org
Subject: [PATCH 1/4] usb: usbfs: Enforce page requirements for mmap
Date:   Wed, 10 May 2023 16:55:24 +0800
Message-Id: <20230510085527.57953-2-lrh2000@pku.edu.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510085527.57953-1-lrh2000@pku.edu.cn>
References: <20230510085527.57953-1-lrh2000@pku.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 5oFpogBnb2cIXFtkW9d5Ag--.63159S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXry7Gr1fXw4xWw13tF13urg_yoWrKF4kpF
        sxWr15CrW5tryxXrnxKFs8Za4Yvws5uFyUKrWxu3s3uF13J3sI9Fn5AFy5ZF1rJr4vgr1f
        tFn0krWYk3WUG37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBF1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4
        vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
        628vn2kIc2xKxwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8V
        WkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQZ23UUUUU=
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEEBVPy770DbwAWsL
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
   allocate memory.
 * If DMA is not available, it uses kmalloc to allocate memory.
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
Cc: stable@vger.kernel.org
Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
---
 drivers/usb/core/buffer.c | 41 +++++++++++++++++++++++++++++++++++++++
 drivers/usb/core/devio.c  |  9 +++++----
 include/linux/usb/hcd.h   |  5 +++++
 3 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
index fbb087b72..6010ef9f5 100644
--- a/drivers/usb/core/buffer.c
+++ b/drivers/usb/core/buffer.c
@@ -172,3 +172,44 @@ void hcd_buffer_free(
 	}
 	dma_free_coherent(hcd->self.sysdev, size, addr, dma);
 }
+
+void *hcd_buffer_alloc_pages(struct usb_hcd *hcd, size_t size,
+			     gfp_t mem_flags, dma_addr_t *dma)
+{
+	if (size == 0)
+		return NULL;
+
+	if (hcd->localmem_pool)
+		return gen_pool_dma_alloc_align(hcd->localmem_pool,
+						size, dma, PAGE_SIZE);
+
+	/* some USB hosts just use PIO */
+	if (!hcd_uses_dma(hcd)) {
+		*dma = DMA_MAPPING_ERROR;
+		return (void *)__get_free_pages(mem_flags,
+						get_order(size));
+	}
+
+	return dma_alloc_coherent(hcd->self.sysdev,
+				  size, dma, mem_flags);
+}
+
+void hcd_buffer_free_pages(struct usb_hcd *hcd, size_t size,
+			   void *addr, dma_addr_t dma)
+{
+	if (!addr)
+		return;
+
+	if (hcd->localmem_pool) {
+		gen_pool_free(hcd->localmem_pool,
+			      (unsigned long)addr, size);
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
index e501a03d6..b4cf9e860 100644
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
+		hcd_buffer_free_pages(hcd, usbm->size, usbm->mem,
+				      usbm->dma_handle);
 		usbfs_decrease_memory_usage(
 			usbm->size + sizeof(struct usb_memory));
 		kfree(usbm);
@@ -247,8 +248,8 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
 		goto error_decrease_mem;
 	}
 
-	mem = usb_alloc_coherent(ps->dev, size, GFP_USER | __GFP_NOWARN,
-			&dma_handle);
+	mem = hcd_buffer_alloc_pages(hcd, size, GFP_USER | __GFP_NOWARN,
+				     &dma_handle);
 	if (!mem) {
 		ret = -ENOMEM;
 		goto error_free_usbm;
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 094c77eaf..79f89109e 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -501,6 +501,11 @@ void *hcd_buffer_alloc(struct usb_bus *bus, size_t size,
 void hcd_buffer_free(struct usb_bus *bus, size_t size,
 	void *addr, dma_addr_t dma);
 
+void *hcd_buffer_alloc_pages(struct usb_hcd *hcd, size_t size,
+			     gfp_t mem_flags, dma_addr_t *dma);
+void hcd_buffer_free_pages(struct usb_hcd *hcd, size_t size,
+			   void *addr, dma_addr_t dma);
+
 /* generic bus glue, needed for host controllers that don't use PCI */
 extern irqreturn_t usb_hcd_irq(int irq, void *__hcd);
 
-- 
2.40.1

