Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1E46E1DAB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 09:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjDNH6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 03:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjDNH55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 03:57:57 -0400
X-Greylist: delayed 363 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 14 Apr 2023 00:57:56 PDT
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996A37280
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 00:57:56 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1DDA21A114E;
        Fri, 14 Apr 2023 09:51:52 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DA38D1A1152;
        Fri, 14 Apr 2023 09:51:51 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9B7B4183486C;
        Fri, 14 Apr 2023 15:51:50 +0800 (+08)
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [RFC PATCH] dma: coherent: respect to device 'dma-coherent' property
Date:   Fri, 14 Apr 2023 16:03:07 +0800
Message-Id: <20230414080307.35114-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Currently, the coherent DMA memory is always mapped as writecombine
and uncached, ignored the 'dma-coherent' property in device node,
this patch is to map the memory as writeback and cached when the
device has 'dma-coherent' property.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 kernel/dma/coherent.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index c21abc77c53e..f15ba6c6358e 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -36,7 +36,8 @@ static inline dma_addr_t dma_get_device_base(struct device *dev,
 }
 
 static struct dma_coherent_mem *dma_init_coherent_memory(phys_addr_t phys_addr,
-		dma_addr_t device_addr, size_t size, bool use_dma_pfn_offset)
+		dma_addr_t device_addr, size_t size, bool use_dma_pfn_offset,
+		bool cacheable)
 {
 	struct dma_coherent_mem *dma_mem;
 	int pages = size >> PAGE_SHIFT;
@@ -45,7 +46,8 @@ static struct dma_coherent_mem *dma_init_coherent_memory(phys_addr_t phys_addr,
 	if (!size)
 		return ERR_PTR(-EINVAL);
 
-	mem_base = memremap(phys_addr, size, MEMREMAP_WC);
+	mem_base = memremap(phys_addr, size, cacheable ? MEMREMAP_WB :
+			    MEMREMAP_WC);
 	if (!mem_base)
 		return ERR_PTR(-EINVAL);
 
@@ -119,8 +121,10 @@ int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
 {
 	struct dma_coherent_mem *mem;
 	int ret;
+	bool cacheable = dev_is_dma_coherent(dev);
 
-	mem = dma_init_coherent_memory(phys_addr, device_addr, size, false);
+	mem = dma_init_coherent_memory(phys_addr, device_addr, size, false,
+				       cacheable);
 	if (IS_ERR(mem))
 		return PTR_ERR(mem);
 
@@ -310,7 +314,7 @@ int dma_init_global_coherent(phys_addr_t phys_addr, size_t size)
 {
 	struct dma_coherent_mem *mem;
 
-	mem = dma_init_coherent_memory(phys_addr, phys_addr, size, true);
+	mem = dma_init_coherent_memory(phys_addr, phys_addr, size, true, false);
 	if (IS_ERR(mem))
 		return PTR_ERR(mem);
 	dma_coherent_default_memory = mem;
@@ -335,9 +339,10 @@ static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
 {
 	if (!rmem->priv) {
 		struct dma_coherent_mem *mem;
+		bool cacheable = dev_is_dma_coherent(dev);
 
 		mem = dma_init_coherent_memory(rmem->base, rmem->base,
-					       rmem->size, true);
+					       rmem->size, true, cacheable);
 		if (IS_ERR(mem))
 			return PTR_ERR(mem);
 		rmem->priv = mem;
-- 
2.17.1

