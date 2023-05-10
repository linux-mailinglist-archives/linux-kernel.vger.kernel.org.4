Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1226FDA58
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 11:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236964AbjEJJES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 05:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbjEJJEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 05:04:12 -0400
X-Greylist: delayed 477 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 May 2023 02:03:54 PDT
Received: from pku.edu.cn (mx18.pku.edu.cn [162.105.129.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B636CE4A;
        Wed, 10 May 2023 02:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:In-Reply-To:References:MIME-Version:
        Content-Transfer-Encoding; bh=uc/joagnVnWX0pVL8sA/swhhcGx1a7P3dQ
        TDyW7FP10=; b=ZmFL1Miz+iwxUAejxmnXZrzMvhWRO2gTDNymFiYKOFmOJx2Phg
        n86fSt1XcCM1orEYX0LJ8T7Z57qLiHA5O81og7eaOHCblqDcOVLLfy3XPdMK7Mvo
        aKEwhnHrpWzNksDyzH7/HBiexN+Atn1CCGgm+sIUKlxloB2ZQEE2gI3E8=
Received: from localhost.localdomain (unknown [10.7.101.92])
        by front01 (Coremail) with SMTP id 5oFpogBnb2cIXFtkW9d5Ag--.63159S4;
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
        Ruihan Li <lrh2000@pku.edu.cn>, stable@vger.kernel.org
Subject: [PATCH 2/4] usb: usbfs: Use consistent mmap functions
Date:   Wed, 10 May 2023 16:55:25 +0800
Message-Id: <20230510085527.57953-3-lrh2000@pku.edu.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510085527.57953-1-lrh2000@pku.edu.cn>
References: <20230510085527.57953-1-lrh2000@pku.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 5oFpogBnb2cIXFtkW9d5Ag--.63159S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw45ZF1kZrWfCw4UCr17KFg_yoW8KFWDpF
        W8K3yj9F40qFySvr1q9an5WFn5G3s5KFyUWrW2v3sxu3W3Jr1SkFWFya4YqF17tr18Xrna
        qFWqyw13C3W5uFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEEBVPy770DbwAZsE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When hcd->localmem_pool is non-null, it is used to allocate DMA memory.
In this case, the dma address will be properly returned (in dma_handle),
and dma_mmap_coherent should be used to map this memory into the user
space. However, the current implementation uses pfn_remap_range, which
is supposed to map normal pages (instead of DMA pages).

Instead of repeating the logic in the memory allocation function, this
patch introduces a more robust solution. To address the previous issue,
this patch checks the type of allocated memory by testing whether
dma_handle is properly set. If dma_handle is properly returned, it means
some DMA pages are allocated and dma_mmap_coherent should be used to map
them. Otherwise, normal pages are allocated and pfn_remap_range should
be called. This ensures that the correct mmap functions are used
consistently, independently with logic details that determine which type
of memory gets allocated.

Fixes: a0e710a7def4 ("USB: usbfs: fix mmap dma mismatch")
Cc: stable@vger.kernel.org
Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
---
 drivers/usb/core/devio.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index b4cf9e860..5067030b7 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -235,7 +235,7 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
 	size_t size = vma->vm_end - vma->vm_start;
 	void *mem;
 	unsigned long flags;
-	dma_addr_t dma_handle;
+	dma_addr_t dma_handle = DMA_MAPPING_ERROR;
 	int ret;
 
 	ret = usbfs_increase_memory_usage(size + sizeof(struct usb_memory));
@@ -265,7 +265,13 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
 	usbm->vma_use_count = 1;
 	INIT_LIST_HEAD(&usbm->memlist);
 
-	if (hcd->localmem_pool || !hcd_uses_dma(hcd)) {
+	/* In DMA-unavailable cases, hcd_buffer_alloc_pages allocates
+	 * normal pages and assigns DMA_MAPPING_ERROR to dma_handle. Check
+	 * whether we are in such cases, and then use remap_pfn_range (or
+	 * dma_mmap_coherent) to map normal (or DMA) pages into the user
+	 * space, respectively.
+	 */
+	if (dma_handle == DMA_MAPPING_ERROR) {
 		if (remap_pfn_range(vma, vma->vm_start,
 				    virt_to_phys(usbm->mem) >> PAGE_SHIFT,
 				    size, vma->vm_page_prot) < 0) {
-- 
2.40.1

