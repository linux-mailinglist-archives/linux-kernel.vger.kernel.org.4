Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E3C5B4CDC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 11:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiIKJHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 05:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiIKJGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 05:06:51 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88FDB3A171;
        Sun, 11 Sep 2022 02:06:49 -0700 (PDT)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.105])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx_2sbpR1jFrsWAA--.22738S4;
        Sun, 11 Sep 2022 17:06:38 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     lpieralisi@kernel.org, robin.murphy@arm.com, chenhuacai@loongson.cn
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        lenb@kernel.org, robert.moore@intel.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        loongarch@lists.linux.dev
Subject: [PATCH V5 2/2] LoongArch: Use acpi_arch_dma_setup() and remove ARCH_HAS_PHYS_TO_DMA
Date:   Sun, 11 Sep 2022 17:06:35 +0800
Message-Id: <20220911090635.5559-3-lvjianmin@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220911090635.5559-1-lvjianmin@loongson.cn>
References: <20220911090635.5559-1-lvjianmin@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx_2sbpR1jFrsWAA--.22738S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWw47XF4rAF45CryDXF1UZFb_yoW7Gr43pa
        srCrs8Gr4xKrs7XrykCw18Zr15X3s2kay7XFW7K3sakFnFqr1UXr1vyF9rZF1YqrZrKF4I
        qF95CFyYqF4UWw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU921xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
        jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r10
        6r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxE
        wVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26ryrJr1UJwCFx2IqxVCFs4
        IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
        MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
        WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
        6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUZa9-UUUUU=
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use _DMA defined in ACPI spec for translation between
DMA address and CPU address, and implement acpi_arch_dma_setup
for initializing dev->dma_range_map, where acpi_dma_get_range
is called for parsing _DMA.

e.g.
If we have two dma ranges:
cpu address      dma address    size         offset
0x200080000000   0x2080000000   0x400000000  0x1fe000000000
0x400080000000   0x4080000000   0x400000000  0x3fc000000000

_DMA for pci devices should be declared in host bridge as
flowing:

Name (_DMA, ResourceTemplate() {
        QWordMemory (ResourceProducer,
            PosDecode,
            MinFixed,
            MaxFixed,
            NonCacheable,
            ReadWrite,
            0x0,
            0x4080000000,
            0x447fffffff,
            0x3fc000000000,
            0x400000000,
            ,
            ,
            )

        QWordMemory (ResourceProducer,
            PosDecode,
            MinFixed,
            MaxFixed,
            NonCacheable,
            ReadWrite,
            0x0,
            0x2080000000,
            0x247fffffff,
            0x1fe000000000,
            0x400000000,
            ,
            ,
            )
    })

Acked-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
---
 arch/loongarch/Kconfig        |  1 -
 arch/loongarch/kernel/dma.c   | 52 ++++++++++++++---------------------
 arch/loongarch/kernel/setup.c |  2 +-
 include/linux/acpi.h          |  9 ++++--
 4 files changed, 28 insertions(+), 36 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index c7dd6ad779af..551dd99e98b8 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -10,7 +10,6 @@ config LOONGARCH
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
-	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_INLINE_READ_LOCK if !PREEMPTION
diff --git a/arch/loongarch/kernel/dma.c b/arch/loongarch/kernel/dma.c
index 8c9b5314a13e..7a9c6a9dd2d0 100644
--- a/arch/loongarch/kernel/dma.c
+++ b/arch/loongarch/kernel/dma.c
@@ -2,39 +2,29 @@
 /*
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
-#include <linux/init.h>
+#include <linux/acpi.h>
 #include <linux/dma-direct.h>
-#include <linux/dma-mapping.h>
-#include <linux/dma-map-ops.h>
-#include <linux/swiotlb.h>
 
-#include <asm/bootinfo.h>
-#include <asm/dma.h>
-#include <asm/loongson.h>
-
-/*
- * We extract 4bit node id (bit 44~47) from Loongson-3's
- * 48bit physical address space and embed it into 40bit.
- */
-
-static int node_id_offset;
-
-dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
-{
-	long nid = (paddr >> 44) & 0xf;
-
-	return ((nid << 44) ^ paddr) | (nid << node_id_offset);
-}
-
-phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
+void acpi_arch_dma_setup(struct device *dev)
 {
-	long nid = (daddr >> node_id_offset) & 0xf;
+	int ret;
+	u64 mask, end = 0;
+	const struct bus_dma_region *map = NULL;
+
+	ret = acpi_dma_get_range(dev, &map);
+	if (!ret && map) {
+		const struct bus_dma_region *r = map;
+
+		for (end = 0; r->size; r++) {
+			if (r->dma_start + r->size - 1 > end)
+				end = r->dma_start + r->size - 1;
+		}
+
+		mask = DMA_BIT_MASK(ilog2(end) + 1);
+		dev->bus_dma_limit = end;
+		dev->dma_range_map = map;
+		dev->coherent_dma_mask = min(dev->coherent_dma_mask, mask);
+		*dev->dma_mask = min(*dev->dma_mask, mask);
+	}
 
-	return ((nid << node_id_offset) ^ daddr) | (nid << 44);
-}
-
-void __init plat_swiotlb_setup(void)
-{
-	swiotlb_init(true, SWIOTLB_VERBOSE);
-	node_id_offset = ((readl(LS7A_DMA_CFG) & LS7A_DMA_NODE_MASK) >> LS7A_DMA_NODE_SHF) + 36;
 }
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 8f5c2f9a1a83..d97c69dbe553 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -247,7 +247,7 @@ static void __init arch_mem_init(char **cmdline_p)
 	sparse_init();
 	memblock_set_bottom_up(true);
 
-	plat_swiotlb_setup();
+	swiotlb_init(true, SWIOTLB_VERBOSE);
 
 	dma_contiguous_reserve(PFN_PHYS(max_low_pfn));
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index bb41623dab77..a71d73a0d43e 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -279,14 +279,17 @@ acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa) { }
 
 void acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa);
 
+#if defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH)
+void acpi_arch_dma_setup(struct device *dev);
+#else
+static inline void acpi_arch_dma_setup(struct device *dev) { }
+#endif
+
 #ifdef CONFIG_ARM64
 void acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa);
-void acpi_arch_dma_setup(struct device *dev);
 #else
 static inline void
 acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa) { }
-static inline void
-acpi_arch_dma_setup(struct device *dev) { }
 #endif
 
 int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
-- 
2.31.1

