Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EA86DA6D5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 03:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbjDGBQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 21:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238212AbjDGBQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 21:16:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F295B9A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 18:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680830140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yTjaXVllxkU/aHGZ94OX1yUAx1aLhOMTauMuyCLZAvA=;
        b=YvdvoYTFgUBCFyxnoVb/x+3RwbMrL04AX51LJSeiBdVtb9jNbCdv5Db3rB0gqHKl8A4Srh
        SWgB/grlZI8Emk6icUECsffxSs04rfXZ1DBvwfJq4kovhvFMi9NDaboChFF8F0uNLYxIRL
        4eDF1ODL49gfs2KMsSYMmFItjpV6FlY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-aB3Vm8o1PqWzLKh0TWuknA-1; Thu, 06 Apr 2023 21:15:37 -0400
X-MC-Unique: aB3Vm8o1PqWzLKh0TWuknA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A994E185A78B;
        Fri,  7 Apr 2023 01:15:36 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-86.pek2.redhat.com [10.72.12.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4190818EC6;
        Fri,  7 Apr 2023 01:15:30 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, rppt@kernel.org,
        thunder.leizhen@huawei.com, will@kernel.org, ardb@kernel.org,
        horms@kernel.org, John.p.donnelly@oracle.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 3/3] arm64: kdump: defer the crashkernel reservation for platforms with no DMA memory zones
Date:   Fri,  7 Apr 2023 09:15:07 +0800
Message-Id: <20230407011507.17572-4-bhe@redhat.com>
In-Reply-To: <20230407011507.17572-1-bhe@redhat.com>
References: <20230407011507.17572-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 031495635b46 ("arm64: Do not defer reserve_crashkernel() for
platforms with no DMA memory zones"), reserve_crashkernel() is called
much earlier in arm64_memblock_init() to avoid causing base apge
mapping on platforms with no DMA meomry zones.

With taking off protection on crashkernel memory region, no need to call
reserve_crashkernel() specially in advance. The deferred invocation of
reserve_crashkernel() in bootmem_init() can cover all cases. So revert
the whole commit now.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/include/asm/memory.h |  5 -----
 arch/arm64/mm/init.c            | 34 +++------------------------------
 2 files changed, 3 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 78e5163836a0..efcd68154a3a 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -374,11 +374,6 @@ static inline void *phys_to_virt(phys_addr_t x)
 })
 
 void dump_mem_limit(void);
-
-static inline bool defer_reserve_crashkernel(void)
-{
-	return IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32);
-}
 #endif /* !ASSEMBLY */
 
 /*
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 58a0bb2c17f1..66e70ca47680 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -61,34 +61,8 @@ EXPORT_SYMBOL(memstart_addr);
  * unless restricted on specific platforms (e.g. 30-bit on Raspberry Pi 4).
  * In such case, ZONE_DMA32 covers the rest of the 32-bit addressable memory,
  * otherwise it is empty.
- *
- * Memory reservation for crash kernel either done early or deferred
- * depending on DMA memory zones configs (ZONE_DMA) --
- *
- * In absence of ZONE_DMA configs arm64_dma_phys_limit initialized
- * here instead of max_zone_phys().  This lets early reservation of
- * crash kernel memory which has a dependency on arm64_dma_phys_limit.
- * Reserving memory early for crash kernel allows linear creation of block
- * mappings (greater than page-granularity) for all the memory bank rangs.
- * In this scheme a comparatively quicker boot is observed.
- *
- * If ZONE_DMA configs are defined, crash kernel memory reservation
- * is delayed until DMA zone memory range size initialization performed in
- * zone_sizes_init().  The defer is necessary to steer clear of DMA zone
- * memory range to avoid overlap allocation.  So crash kernel memory boundaries
- * are not known when mapping all bank memory ranges, which otherwise means
- * not possible to exclude crash kernel range from creating block mappings
- * so page-granularity mappings are created for the entire memory range.
- * Hence a slightly slower boot is observed.
- *
- * Note: Page-granularity mappings are necessary for crash kernel memory
- * range for shrinking its size via /sys/kernel/kexec_crash_size interface.
  */
-#if IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32)
 phys_addr_t __ro_after_init arm64_dma_phys_limit;
-#else
-phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
-#endif
 
 /* Current arm64 boot protocol requires 2MB alignment */
 #define CRASH_ALIGN			SZ_2M
@@ -248,6 +222,8 @@ static void __init zone_sizes_init(void)
 	if (!arm64_dma_phys_limit)
 		arm64_dma_phys_limit = dma32_phys_limit;
 #endif
+	if (!arm64_dma_phys_limit)
+		arm64_dma_phys_limit = PHYS_MASK + 1;
 	max_zone_pfns[ZONE_NORMAL] = max_pfn;
 
 	free_area_init(max_zone_pfns);
@@ -408,9 +384,6 @@ void __init arm64_memblock_init(void)
 
 	early_init_fdt_scan_reserved_mem();
 
-	if (!defer_reserve_crashkernel())
-		reserve_crashkernel();
-
 	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
 }
 
@@ -457,8 +430,7 @@ void __init bootmem_init(void)
 	 * request_standard_resources() depends on crashkernel's memory being
 	 * reserved, so do it here.
 	 */
-	if (defer_reserve_crashkernel())
-		reserve_crashkernel();
+	reserve_crashkernel();
 
 	memblock_dump_all();
 }
-- 
2.34.1

