Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B397182F2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236636AbjEaNqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236711AbjEaNov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:44:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC431705;
        Wed, 31 May 2023 06:42:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6599263B0F;
        Wed, 31 May 2023 13:42:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C296C4339B;
        Wed, 31 May 2023 13:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540567;
        bh=qCUmt/x8RV/lJojRSG7blHQYXDYqXLHH6XaAcs5g/YQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DwM7Pg30hMNLTz+BrFjTpI8S6rrZ2u+nk4gXRyuEBqGdm8J0xG+1rbOwtADiRCG9c
         NuOsCj7WKDrHhjQnH0f2EdTLMAGzGdNS0LvRg0U/hVBk1hdR0CHYi2yFhhM9zjbrHu
         jpcUr43FBTIYhv1isOX7HXodda+7mXUpyEiqX9LH+zgxgjFv9WWmAyqlZ1Y5D+PaAY
         rlD8cFflIZgxwJFgNSXpaD+mgi/dSbnJdvPHZy+378a0+OntABOteEkCeepjIOu6tx
         +DB0RTo8CDopzyBjioQt94uEERhzqkbGDgvpp92xQxR4JjSPoIhLGCzMgHdw/H3l+V
         5Qll1cbzKWIjA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        James.Bottomley@HansenPartnership.com, gaoxin@cdjrlc.com,
        linux-parisc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 22/33] parisc: Improve cache flushing for PCXL in arch_sync_dma_for_cpu()
Date:   Wed, 31 May 2023 09:41:48 -0400
Message-Id: <20230531134159.3383703-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134159.3383703-1-sashal@kernel.org>
References: <20230531134159.3383703-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helge Deller <deller@gmx.de>

[ Upstream commit 59fa12646d9f56c842b4d5b6418ed77af625c588 ]

Add comment in arch_sync_dma_for_device() and handle the direction flag in
arch_sync_dma_for_cpu().

When receiving data from the device (DMA_FROM_DEVICE) unconditionally
purge the data cache in arch_sync_dma_for_cpu().

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/parisc/kernel/pci-dma.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
index ba87f791323be..71ed5391f29d6 100644
--- a/arch/parisc/kernel/pci-dma.c
+++ b/arch/parisc/kernel/pci-dma.c
@@ -446,11 +446,27 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
 {
+	/*
+	 * fdc: The data cache line is written back to memory, if and only if
+	 * it is dirty, and then invalidated from the data cache.
+	 */
 	flush_kernel_dcache_range((unsigned long)phys_to_virt(paddr), size);
 }
 
 void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
 {
-	flush_kernel_dcache_range((unsigned long)phys_to_virt(paddr), size);
+	unsigned long addr = (unsigned long) phys_to_virt(paddr);
+
+	switch (dir) {
+	case DMA_TO_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		flush_kernel_dcache_range(addr, size);
+		return;
+	case DMA_FROM_DEVICE:
+		purge_kernel_dcache_range_asm(addr, addr + size);
+		return;
+	default:
+		BUG();
+	}
 }
-- 
2.39.2

