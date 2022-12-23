Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74948654E5D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236196AbiLWJ1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236077AbiLWJ1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:27:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A66379C4;
        Fri, 23 Dec 2022 01:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=bsLsQ8oRMe9VK1Dry6x0Z4+LOSid6dNOzo+yQXaFItk=; b=ha7RjNVen/T0MpbA1+zAHQrVM9
        TcOw6Jvc4pcCbgvO1/8lOxnIomOqMaRlR4a8wR+ZcYtehEK3uCFGtxYfcdlY3XLtN9I9qIeifuz+r
        cxSnqPzC+yBXi7Y4C/3o8ZLVvB3ycAfTQftPjP48RIP/tzUI1djqlGf7SJ/sBV5gwJolcvWrOp4yr
        u8xnaYh+LWW+SfSYbyzuDkUB1qgsA97kfsC61X6fJ7/FDOzE2Caov2TwMtdE5tzhj+mhjIviwpuPs
        6/c3j8S/6Eg0C7vf9oUnnQqeNxmWVO88Lfo78K2cInJf+crbu9Uz0CVK1+fS3XPgR7RcVdLCljc3i
        WIyjqJXQ==;
Received: from [2001:4bb8:199:7829:8d88:c8b3:6416:2f03] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8eKb-005hRT-Hi; Fri, 23 Dec 2022 09:27:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux.dev
Subject: [PATCH 1/2] Revert "remoteproc: qcom_q6v5_mss: map/unmap metadata region before/after use"
Date:   Fri, 23 Dec 2022 10:27:02 +0100
Message-Id: <20221223092703.61927-2-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221223092703.61927-1-hch@lst.de>
References: <20221223092703.61927-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit fc156629b23a21181e473e60341e3a78af25a1d4.

This commit manages to do three API violations at once:

 - dereference the return value of dma_alloc_attrs with the
   DMA_ATTR_NO_KERNEL_MAPPING mapping, which is clearly forbidden and
   will do the wrong thing on various dma mapping implementations.  The
   fact that dma-direct uses a struct page as a cookie is an undocumented
   implementation detail
 - include dma-map-ops.h and use pgprot_dmacoherent despite a clear
   comment documenting that this is not acceptable
 - use of the VM_DMA_COHERENT for something that is not the dma-mapping
   code
 - use of VM_FLUSH_RESET_PERMS for vmap, while it is only supported for
   vmalloc

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 38 +++++-------------------------
 1 file changed, 6 insertions(+), 32 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index fddb63cffee078..a8b141db4de63f 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -10,7 +10,6 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/devcoredump.h>
-#include <linux/dma-map-ops.h>
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -933,52 +932,27 @@ static void q6v5proc_halt_axi_port(struct q6v5 *qproc,
 static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
 				const char *fw_name)
 {
-	unsigned long dma_attrs = DMA_ATTR_FORCE_CONTIGUOUS | DMA_ATTR_NO_KERNEL_MAPPING;
-	unsigned long flags = VM_DMA_COHERENT | VM_FLUSH_RESET_PERMS;
-	struct page **pages;
-	struct page *page;
+	unsigned long dma_attrs = DMA_ATTR_FORCE_CONTIGUOUS;
 	dma_addr_t phys;
 	void *metadata;
 	int mdata_perm;
 	int xferop_ret;
 	size_t size;
-	void *vaddr;
-	int count;
+	void *ptr;
 	int ret;
-	int i;
 
 	metadata = qcom_mdt_read_metadata(fw, &size, fw_name, qproc->dev);
 	if (IS_ERR(metadata))
 		return PTR_ERR(metadata);
 
-	page = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
-	if (!page) {
+	ptr = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
+	if (!ptr) {
 		kfree(metadata);
 		dev_err(qproc->dev, "failed to allocate mdt buffer\n");
 		return -ENOMEM;
 	}
 
-	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	pages = kmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
-	if (!pages) {
-		ret = -ENOMEM;
-		goto free_dma_attrs;
-	}
-
-	for (i = 0; i < count; i++)
-		pages[i] = nth_page(page, i);
-
-	vaddr = vmap(pages, count, flags, pgprot_dmacoherent(PAGE_KERNEL));
-	kfree(pages);
-	if (!vaddr) {
-		dev_err(qproc->dev, "unable to map memory region: %pa+%zx\n", &phys, size);
-		ret = -EBUSY;
-		goto free_dma_attrs;
-	}
-
-	memcpy(vaddr, metadata, size);
-
-	vunmap(vaddr);
+	memcpy(ptr, metadata, size);
 
 	/* Hypervisor mapping to access metadata by modem */
 	mdata_perm = BIT(QCOM_SCM_VMID_HLOS);
@@ -1008,7 +982,7 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
 			 "mdt buffer not reclaimed system may become unstable\n");
 
 free_dma_attrs:
-	dma_free_attrs(qproc->dev, size, page, phys, dma_attrs);
+	dma_free_attrs(qproc->dev, size, ptr, phys, dma_attrs);
 	kfree(metadata);
 
 	return ret < 0 ? ret : 0;
-- 
2.35.1

