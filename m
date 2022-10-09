Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA065F8AAC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 12:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiJIKeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 06:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiJIKdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 06:33:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655E22E9C6
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 03:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665311590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bqIEJNY7OTuGnBXiHmFCBXJop9TGsVbIeh9U19Nxyck=;
        b=ZOv+stWC4jLYOyE3y8mYFGsRIkgaor4ngjbguT1v0LWJeDXDJsPP7tO57OsEkjeY195KzC
        H3HKEnNuSxHriEaiYf4Izq8xOcAxuUF6mIfrh+zv+A/wvEqsewf08MZf3yHfVkO1elBFzW
        SGiPyVqkkG2ETmHyMZHfF7xN/UAvLKE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-RYSyp31wMciz2Sp9b4WCaQ-1; Sun, 09 Oct 2022 06:33:03 -0400
X-MC-Unique: RYSyp31wMciz2Sp9b4WCaQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D8B3101A5DE;
        Sun,  9 Oct 2022 10:33:02 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-36.pek2.redhat.com [10.72.12.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 17EF540D298B;
        Sun,  9 Oct 2022 10:32:54 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        christophe.leroy@csgroup.eu, schnelle@linux.ibm.com,
        David.Laight@ACULAB.COM, shorne@gmail.com, bhe@redhat.com,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH v3 11/11] xtensa: mm: Convert to GENERIC_IOREMAP
Date:   Sun,  9 Oct 2022 18:31:14 +0800
Message-Id: <20221009103114.149036-12-bhe@redhat.com>
In-Reply-To: <20221009103114.149036-1-bhe@redhat.com>
References: <20221009103114.149036-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By taking GENERIC_IOREMAP method, the generic ioremap_prot() and
iounmap() are visible and available to arch. Arch only needs to
provide implementation of arch_ioremap() or arch_iounmap() if there's
arch specific handling needed in its ioremap() or iounmap(). This
change will simplify implementation by removing duplicated codes with
generic ioremap() and iounmap(), and has the equivalent functioality
as before.

For xtensa, add hooks arch_ioremap() and arch_iounmap() for xtensa's
special operation when ioremap() and iounmap(). Then define and
implement its own ioremap() and ioremap_cache() via ioremap_prot().

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
---
 arch/xtensa/Kconfig          |  1 +
 arch/xtensa/include/asm/io.h | 39 +++++++++++--------------
 arch/xtensa/mm/ioremap.c     | 56 ++++++++----------------------------
 3 files changed, 30 insertions(+), 66 deletions(-)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 12ac277282ba..ee3a638f5458 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -29,6 +29,7 @@ config XTENSA
 	select GENERIC_LIB_UCMPDI2
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK
+	select GENERIC_IOREMAP if MMU
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
 	select HAVE_ARCH_KASAN if MMU && !XIP_KERNEL
diff --git a/arch/xtensa/include/asm/io.h b/arch/xtensa/include/asm/io.h
index a5b707e1c0f4..126af8de5722 100644
--- a/arch/xtensa/include/asm/io.h
+++ b/arch/xtensa/include/asm/io.h
@@ -16,6 +16,7 @@
 #include <asm/vectors.h>
 #include <linux/bug.h>
 #include <linux/kernel.h>
+#include <linux/pgtable.h>
 
 #include <linux/types.h>
 
@@ -23,23 +24,29 @@
 #define IO_SPACE_LIMIT ~0
 #define PCI_IOBASE		((void __iomem *)XCHAL_KIO_BYPASS_VADDR)
 
-#ifdef CONFIG_MMU
-
-void __iomem *xtensa_ioremap_nocache(unsigned long addr, unsigned long size);
-void __iomem *xtensa_ioremap_cache(unsigned long addr, unsigned long size);
-void xtensa_iounmap(volatile void __iomem *addr);
-
 /*
- * Return the virtual address for the specified bus memory.
+ * I/O memory mapping functions.
  */
+void __iomem *
+arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val);
+#define arch_ioremap arch_ioremap
+
+bool arch_iounmap(void __iomem *addr);
+#define arch_iounmap arch_iounmap
+
+void __iomem *ioremap_prot(phys_addr_t paddr, size_t size,
+			   unsigned long prot);
+
 static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
 {
 	if (offset >= XCHAL_KIO_PADDR
 	    && offset - XCHAL_KIO_PADDR < XCHAL_KIO_SIZE)
 		return (void*)(offset-XCHAL_KIO_PADDR+XCHAL_KIO_BYPASS_VADDR);
 	else
-		return xtensa_ioremap_nocache(offset, size);
+		return ioremap_prot(offset, size,
+			pgprot_val(pgprot_noncached(PAGE_KERNEL)));
 }
+#define ioremap ioremap
 
 static inline void __iomem *ioremap_cache(unsigned long offset,
 		unsigned long size)
@@ -48,22 +55,10 @@ static inline void __iomem *ioremap_cache(unsigned long offset,
 	    && offset - XCHAL_KIO_PADDR < XCHAL_KIO_SIZE)
 		return (void*)(offset-XCHAL_KIO_PADDR+XCHAL_KIO_CACHED_VADDR);
 	else
-		return xtensa_ioremap_cache(offset, size);
-}
-#define ioremap_cache ioremap_cache
-
-static inline void iounmap(volatile void __iomem *addr)
-{
-	unsigned long va = (unsigned long) addr;
+		return ioremap_prot(offset, size, pgprot_val(PAGE_KERNEL));
 
-	if (!(va >= XCHAL_KIO_CACHED_VADDR &&
-	      va - XCHAL_KIO_CACHED_VADDR < XCHAL_KIO_SIZE) &&
-	    !(va >= XCHAL_KIO_BYPASS_VADDR &&
-	      va - XCHAL_KIO_BYPASS_VADDR < XCHAL_KIO_SIZE))
-		xtensa_iounmap(addr);
 }
-
-#endif /* CONFIG_MMU */
+#define ioremap_cache ioremap_cache
 
 #include <asm-generic/io.h>
 
diff --git a/arch/xtensa/mm/ioremap.c b/arch/xtensa/mm/ioremap.c
index a400188c16b9..b76c3f264f6f 100644
--- a/arch/xtensa/mm/ioremap.c
+++ b/arch/xtensa/mm/ioremap.c
@@ -6,60 +6,28 @@
  */
 
 #include <linux/io.h>
-#include <linux/vmalloc.h>
 #include <linux/pgtable.h>
 #include <asm/cacheflush.h>
 #include <asm/io.h>
 
-static void __iomem *xtensa_ioremap(unsigned long paddr, unsigned long size,
-				    pgprot_t prot)
+void __iomem *
+arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
 {
-	unsigned long offset = paddr & ~PAGE_MASK;
-	unsigned long pfn = __phys_to_pfn(paddr);
-	struct vm_struct *area;
-	unsigned long vaddr;
-	int err;
-
-	paddr &= PAGE_MASK;
-
+	unsigned long pfn = __phys_to_pfn((*paddr));
 	WARN_ON(pfn_valid(pfn));
 
-	size = PAGE_ALIGN(offset + size);
-
-	area = get_vm_area(size, VM_IOREMAP);
-	if (!area)
-		return NULL;
-
-	vaddr = (unsigned long)area->addr;
-	area->phys_addr = paddr;
-
-	err = ioremap_page_range(vaddr, vaddr + size, paddr, prot);
-
-	if (err) {
-		vunmap((void *)vaddr);
-		return NULL;
-	}
-
-	flush_cache_vmap(vaddr, vaddr + size);
-	return (void __iomem *)(offset + vaddr);
-}
-
-void __iomem *xtensa_ioremap_nocache(unsigned long addr, unsigned long size)
-{
-	return xtensa_ioremap(addr, size, pgprot_noncached(PAGE_KERNEL));
+	return NULL;
 }
-EXPORT_SYMBOL(xtensa_ioremap_nocache);
 
-void __iomem *xtensa_ioremap_cache(unsigned long addr, unsigned long size)
+bool arch_iounmap(void __iomem *addr)
 {
-	return xtensa_ioremap(addr, size, PAGE_KERNEL);
-}
-EXPORT_SYMBOL(xtensa_ioremap_cache);
+	unsigned long va = (unsigned long) addr;
 
-void xtensa_iounmap(volatile void __iomem *io_addr)
-{
-	void *addr = (void *)(PAGE_MASK & (unsigned long)io_addr);
+	if ((va >= XCHAL_KIO_CACHED_VADDR &&
+	      va - XCHAL_KIO_CACHED_VADDR < XCHAL_KIO_SIZE) ||
+	    (va >= XCHAL_KIO_BYPASS_VADDR &&
+	      va - XCHAL_KIO_BYPASS_VADDR < XCHAL_KIO_SIZE))
+		return false;
 
-	vunmap(addr);
+	return true;
 }
-EXPORT_SYMBOL(xtensa_iounmap);
-- 
2.34.1

