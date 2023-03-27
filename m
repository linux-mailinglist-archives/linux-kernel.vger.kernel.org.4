Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DD26CA3CA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjC0MSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjC0MRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:17:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FB361B4;
        Mon, 27 Mar 2023 05:16:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1900EB8118F;
        Mon, 27 Mar 2023 12:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A199BC433A4;
        Mon, 27 Mar 2023 12:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679919402;
        bh=5fk8QyC/KB/jrsvrHp6V4LA83bUbandj0Wfn0eu1ajs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j2km9ZzYuNDulQLsscEoaytNZ1gOapGTux+/qnSpRR7kgHRFAwDWDmiH52U7YUwS2
         l25ig62lChXkRW9dVZHw0u6u831HBjAVfoB4gwIhsDu9Oly0WFytQgzyZsIKEt4ZjO
         ebigDsT9ROl6sWYKYTUDMLRjvwmuklMuOt84flr18xR/2kTbMG38tS/UXspKPu2ixh
         EuScV8pm+I4HHjlAfxf0LfOpZq853V+LM4kxrKbWNcmBeEWw/4N5QI2a8DvVG5mYHv
         K6lh//J1Yh7TkacN4sV4vOvpMMmOkrqnjch6bIyUT4KqwtxFWozh9BZ59rFdrnUb0v
         pxs4A/jmHxEIw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH 19/21] ARM: dma-mapping: use generic form of arch_sync_dma_* helpers
Date:   Mon, 27 Mar 2023 14:13:15 +0200
Message-Id: <20230327121317.4081816-20-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327121317.4081816-1-arnd@kernel.org>
References: <20230327121317.4081816-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

As the final step of the conversion to generic arch_sync_dma_*
helpers, change the Arm implementation to look the same as the
new generic version, by calling the dmac_{clean,inv,flush}_area
low-level functions instead of the abstracted dmac_{map,unmap}_area
version.

On ARMv6/v7, this invalidates the caches after a DMA transfer from
a device because of speculative prefetching, while on earlier versions
it only needs to do this before the transfer.

This should not change any of the current behavior.

FIXME: address CONFIG_DMA_CACHE_RWFO properly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mm/dma-mapping-nommu.c | 11 +++----
 arch/arm/mm/dma-mapping.c       | 53 +++++++++++++++++++++++----------
 2 files changed, 43 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
index cfd9c933d2f0..12b5c6ae93fc 100644
--- a/arch/arm/mm/dma-mapping-nommu.c
+++ b/arch/arm/mm/dma-mapping-nommu.c
@@ -16,12 +16,13 @@
 void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
 {
-	dmac_map_area(__va(paddr), size, dir);
-
-	if (dir == DMA_FROM_DEVICE)
+	if (dir == DMA_FROM_DEVICE) {
+		dmac_inv_range(__va(paddr), __va(paddr + size));
 		outer_inv_range(paddr, paddr + size);
-	else
+	} else {
+		dmac_clean_range(__va(paddr), __va(paddr + size));
 		outer_clean_range(paddr, paddr + size);
+	}
 }
 
 void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
@@ -29,7 +30,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 {
 	if (dir != DMA_TO_DEVICE) {
 		outer_inv_range(paddr, paddr + size);
-		dmac_unmap_area(__va(paddr), size, dir);
+		dmac_inv_range(__va(paddr), __va(paddr));
 	}
 }
 
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index ce4b74f34a58..cc702cb27ae7 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -623,8 +623,7 @@ static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
 }
 
 static void dma_cache_maint(phys_addr_t paddr,
-	size_t size, enum dma_data_direction dir,
-	void (*op)(const void *, size_t, int))
+	size_t size, void (*op)(const void *, const void *))
 {
 	unsigned long pfn = PFN_DOWN(paddr);
 	unsigned long offset = paddr % PAGE_SIZE;
@@ -647,18 +646,18 @@ static void dma_cache_maint(phys_addr_t paddr,
 
 			if (cache_is_vipt_nonaliasing()) {
 				vaddr = kmap_atomic(page);
-				op(vaddr + offset, len, dir);
+				op(vaddr + offset, vaddr + offset + len);
 				kunmap_atomic(vaddr);
 			} else {
 				vaddr = kmap_high_get(page);
 				if (vaddr) {
-					op(vaddr + offset, len, dir);
+					op(vaddr + offset, vaddr + offset + len);
 					kunmap_high(page);
 				}
 			}
 		} else {
 			vaddr = page_address(page) + offset;
-			op(vaddr, len, dir);
+			op(vaddr, vaddr + len);
 		}
 		offset = 0;
 		pfn++;
@@ -666,6 +665,18 @@ static void dma_cache_maint(phys_addr_t paddr,
 	} while (left);
 }
 
+static bool arch_sync_dma_cpu_needs_post_dma_flush(void)
+{
+	if (IS_ENABLED(CONFIG_CPU_V6) ||
+	    IS_ENABLED(CONFIG_CPU_V6K) ||
+	    IS_ENABLED(CONFIG_CPU_V7) ||
+	    IS_ENABLED(CONFIG_CPU_V7M))
+		return true;
+
+	/* FIXME: runtime detection */
+	return false;
+}
+
 /*
  * Make an area consistent for devices.
  * Note: Drivers should NOT use this function directly.
@@ -674,25 +685,35 @@ static void dma_cache_maint(phys_addr_t paddr,
 void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
 {
-	dma_cache_maint(paddr, size, dir, dmac_map_area);
-
-	if (dir == DMA_FROM_DEVICE) {
-		outer_inv_range(paddr, paddr + size);
-	} else {
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		dma_cache_maint(paddr, size, dmac_clean_range);
 		outer_clean_range(paddr, paddr + size);
+		break;
+	case DMA_FROM_DEVICE:
+		dma_cache_maint(paddr, size, dmac_inv_range);
+		outer_inv_range(paddr, paddr + size);
+		break;
+	case DMA_BIDIRECTIONAL:
+		if (arch_sync_dma_cpu_needs_post_dma_flush()) {
+			dma_cache_maint(paddr, size, dmac_clean_range);
+			outer_clean_range(paddr, paddr + size);
+		} else {
+			dma_cache_maint(paddr, size, dmac_flush_range);
+			outer_flush_range(paddr, paddr + size);
+		}
+		break;
+	default:
+		break;
 	}
-	/* FIXME: non-speculating: flush on bidirectional mappings? */
 }
 
 void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
 {
-	/* FIXME: non-speculating: not required */
-	/* in any case, don't bother invalidating if DMA to device */
-	if (dir != DMA_TO_DEVICE) {
+	if (dir != DMA_TO_DEVICE && arch_sync_dma_cpu_needs_post_dma_flush()) {
 		outer_inv_range(paddr, paddr + size);
-
-		dma_cache_maint(paddr, size, dir, dmac_unmap_area);
+		dma_cache_maint(paddr, size, dmac_inv_range);
 	}
 
 	/*
-- 
2.39.2

