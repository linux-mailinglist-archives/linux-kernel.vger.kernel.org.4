Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B797183D6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237232AbjEaNwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237229AbjEaNuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:50:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6682D4B;
        Wed, 31 May 2023 06:45:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B498863B88;
        Wed, 31 May 2023 13:45:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C165C433EF;
        Wed, 31 May 2023 13:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540720;
        bh=tmfu4rqs8B0jAXCGsPRU3/ZTp9QbsXePOjb3YSjC15M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WD4e9P0sG1YKXbepS4zOZciT2aOnmwX2LoBK/cbTNqj8BGn+zdzeuuj5CsMpIEv7Q
         7ZueQ+HT6FqS62WtIAJgOatPYs18YBP7vTgUMB8uVjoZnA9rEmxfP+Lbd5YDlKwrjf
         T9oiu3pwJYpF6ztY0SyrEwog8OZa/9IbLp3nLPmOjC4UxvWsvl4CXc67oJTzeRrWVw
         S9POtI4KsLWioKs5Z5nVJauyB+RuC+vtYYyO73YqPUbYx/cXUS6Ii95KEgzepMhqlW
         pDlR0HCOeR6tCM+va8vrBfQJ9AcxQkJyh5a7LrbTvPgDG5AF52vgz8+/ZaVcdv8xiY
         83fsbieybqxuQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        James.Bottomley@HansenPartnership.com, gaoxin@cdjrlc.com,
        linux-parisc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 11/17] parisc: Improve cache flushing for PCXL in arch_sync_dma_for_cpu()
Date:   Wed, 31 May 2023 09:44:55 -0400
Message-Id: <20230531134502.3384828-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134502.3384828-1-sashal@kernel.org>
References: <20230531134502.3384828-1-sashal@kernel.org>
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
index a60d47fd4d55f..1621f678aa05b 100644
--- a/arch/parisc/kernel/pci-dma.c
+++ b/arch/parisc/kernel/pci-dma.c
@@ -442,13 +442,29 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
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
 
 void arch_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-- 
2.39.2

