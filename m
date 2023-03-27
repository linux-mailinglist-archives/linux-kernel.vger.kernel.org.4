Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456FF6CA39E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjC0MRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjC0MQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:16:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BD53C0F;
        Mon, 27 Mar 2023 05:16:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2427611F0;
        Mon, 27 Mar 2023 12:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68CCC433A8;
        Mon, 27 Mar 2023 12:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679919359;
        bh=dXkVBSHFZo75+7tpVyAnh5gU/93Of01AyIY3GkfM5Xo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LxcGBomvsroLU/soGwnnpht+OmpwZ+CQiYPJxIKYSMNj00PvVbGR5doPLu7Ta51zU
         A4AjXgBFUoaToan99cxpW2tpzSfzmbx7CfucJpx/cZmN4J82wZvf5lGWjPr1irkWI4
         eZp949vYHz5uXoUdFNeW62DfrFW7AYO5kKpo+/0YEhvvJIUHP4VPFskv3Eqs77XyrF
         Xs9EDnGZ3aZvKZmOae+ULTgqTWW5PJS6Wpz4iR9tqX40bYNm1DPxfkANwAHMeIL88M
         53CkbdMXPh+FND6MhgUZQGkY9ycD9t2Azpib43BAHfEe1LeuLFcS8ozxudjpxtNHkD
         yYFa2ciLpv92A==
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
Subject: [PATCH 14/21] parisc: dma-mapping: use regular flush/invalidate ops
Date:   Mon, 27 Mar 2023 14:13:10 +0200
Message-Id: <20230327121317.4081816-15-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327121317.4081816-1-arnd@kernel.org>
References: <20230327121317.4081816-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

non-coherent devices on parisc traditionally use a full flush+invalidate
before and after each DMA, which is more expensive that what we do on
other architectures.

Before transfers to a device, the cache only has to be written back,
but apparently there is no operation for this on parisc. There is no
need to flush it again after the transfer though.

After transfers from a device, the second writeback can be skipped because
the CPU was not allowed to write to the buffer anyway, instead a purge
(invalidate without flush) can be used.

The DMA_FROM_DEVICE is handled differently across architectures,
most use only an invalidate (purge) operation, but some have moved
to flush in order to preserve dirty data when the device does not
write to the buffer, see the link below. As parisc already did the
full flush here, keep that behavior.

Link: https://lore.kernel.org/all/20220606152150.GA31568@willie-the-truck/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I'm not really sure I understand the semantics of the 'flush'
and 'purge' operations on parisc correctly, please double-check that
this makes sense in the context of this architecture.
---
 arch/parisc/include/asm/cacheflush.h |  6 +++++-
 arch/parisc/kernel/pci-dma.c         | 25 +++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/parisc/include/asm/cacheflush.h b/arch/parisc/include/asm/cacheflush.h
index 0bdee6724132..a4c5042f1821 100644
--- a/arch/parisc/include/asm/cacheflush.h
+++ b/arch/parisc/include/asm/cacheflush.h
@@ -33,8 +33,12 @@ void flush_cache_mm(struct mm_struct *mm);
 
 void flush_kernel_dcache_page_addr(const void *addr);
 
+#define clean_kernel_dcache_range(start,size) \
+	flush_kernel_dcache_range((start), (size))
 #define flush_kernel_dcache_range(start,size) \
-	flush_kernel_dcache_range_asm((start), (start)+(size));
+	flush_kernel_dcache_range_asm((start), (start)+(size))
+#define purge_kernel_dcache_range(start,size) \
+	purge_kernel_dcache_range_asm((start), (start)+(size))
 
 #define ARCH_IMPLEMENTS_FLUSH_KERNEL_VMAP_RANGE 1
 void flush_kernel_vmap_range(void *vaddr, int size);
diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
index ba87f791323b..6d3d3cffb316 100644
--- a/arch/parisc/kernel/pci-dma.c
+++ b/arch/parisc/kernel/pci-dma.c
@@ -446,11 +446,32 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
 {
-	flush_kernel_dcache_range((unsigned long)phys_to_virt(paddr), size);
+	unsigned long virt = (unsigned long)phys_to_virt(paddr);
+
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		clean_kernel_dcache_range(virt, size);
+		break;
+	case DMA_FROM_DEVICE:
+		clean_kernel_dcache_range(virt, size);
+		break;
+	case DMA_BIDIRECTIONAL:
+		flush_kernel_dcache_range(virt, size);
+		break;
+	}
 }
 
 void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
 {
-	flush_kernel_dcache_range((unsigned long)phys_to_virt(paddr), size);
+	unsigned long virt = (unsigned long)phys_to_virt(paddr);
+
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		break;
+	case DMA_FROM_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		purge_kernel_dcache_range(virt, size);
+		break;
+	}
 }
-- 
2.39.2

