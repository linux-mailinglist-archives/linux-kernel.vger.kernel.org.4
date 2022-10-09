Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C50F5F8AA6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 12:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiJIKdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 06:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiJIKcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 06:32:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006002B61F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 03:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665311561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UIibfMEWzx8qbt+G+E/4sdi5Hq+zAkJYVe3xl5xYLl4=;
        b=NJ8IRoCCo0qRy9xplQt2tvVjUbaaU3aUePGRWUAii4SOFESzNy6/p9gz2c9ge1owr2KRzL
        y5gMHNRd6Gz7RIfA06Vj3wzdnhJRV/7lvHTVZn4o37H8jW/x1TUhQVh0KUMbGpvFKNOZ56
        Pqd45mlkKKLmaQ/5vfzQTyRNzf2gPVY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-bIPd6-M9PcePbJcxMLGtEQ-1; Sun, 09 Oct 2022 06:32:24 -0400
X-MC-Unique: bIPd6-M9PcePbJcxMLGtEQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3DCCA380673A;
        Sun,  9 Oct 2022 10:32:24 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-36.pek2.redhat.com [10.72.12.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9DA8F40D298B;
        Sun,  9 Oct 2022 10:32:18 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        christophe.leroy@csgroup.eu, schnelle@linux.ibm.com,
        David.Laight@ACULAB.COM, shorne@gmail.com, bhe@redhat.com,
        linux-ia64@vger.kernel.org
Subject: [PATCH v3 06/11] ia64: mm: Convert to GENERIC_IOREMAP
Date:   Sun,  9 Oct 2022 18:31:09 +0800
Message-Id: <20221009103114.149036-7-bhe@redhat.com>
In-Reply-To: <20221009103114.149036-1-bhe@redhat.com>
References: <20221009103114.149036-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Here add hooks arch_ioremap() and arch_iounmap() for ia64's special
operation when ioremap() and iounmap(), then ioremap_cache() is
converted to use ioremap_prot() from GENERIC_IOREMAP.

The old ioremap_uc() is kept and add its macro definittion.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: linux-ia64@vger.kernel.org
---
 arch/ia64/Kconfig          |  1 +
 arch/ia64/include/asm/io.h | 26 ++++++++++++--------
 arch/ia64/mm/ioremap.c     | 50 +++++++++-----------------------------
 3 files changed, 28 insertions(+), 49 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 26ac8ea15a9e..1ca18be5dc30 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -45,6 +45,7 @@ config IA64
 	select GENERIC_IRQ_LEGACY
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select GENERIC_IOMAP
+	select GENERIC_IOREMAP
 	select GENERIC_SMP_IDLE_THREAD
 	select ARCH_TASK_STRUCT_ON_STACK
 	select ARCH_TASK_STRUCT_ALLOCATOR
diff --git a/arch/ia64/include/asm/io.h b/arch/ia64/include/asm/io.h
index ce66dfc0e719..54378cea4b36 100644
--- a/arch/ia64/include/asm/io.h
+++ b/arch/ia64/include/asm/io.h
@@ -247,17 +247,23 @@ static inline void outsl(unsigned long port, const void *src,
 
 # ifdef __KERNEL__
 
-extern void __iomem * ioremap(unsigned long offset, unsigned long size);
-extern void __iomem * ioremap_uc(unsigned long offset, unsigned long size);
-extern void iounmap (volatile void __iomem *addr);
-static inline void __iomem * ioremap_cache (unsigned long phys_addr, unsigned long size)
-{
-	return ioremap(phys_addr, size);
-}
-#define ioremap ioremap
-#define ioremap_cache ioremap_cache
+/*
+ * I/O memory mapping functions.
+ */
+void __iomem *
+arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val);
+#define arch_ioremap arch_ioremap
+
+bool arch_iounmap(void __iomem *addr);
+#define arch_iounmap arch_iounmap
+
+#define _PAGE_IOREMAP pgprot_val(PAGE_KERNEL)
+
+#define ioremap_cache(addr, size)  \
+	ioremap_prot((addr), (size), pgprot_val(PAGE_KERNEL))
+
+void __iomem *ioremap_uc(unsigned long offset, unsigned long size);
 #define ioremap_uc ioremap_uc
-#define iounmap iounmap
 
 /*
  * String version of IO memory access ops:
diff --git a/arch/ia64/mm/ioremap.c b/arch/ia64/mm/ioremap.c
index 55fd3eb753ff..a290c7dc7f1e 100644
--- a/arch/ia64/mm/ioremap.c
+++ b/arch/ia64/mm/ioremap.c
@@ -30,15 +30,12 @@ early_ioremap (unsigned long phys_addr, unsigned long size)
 }
 
 void __iomem *
-ioremap (unsigned long phys_addr, unsigned long size)
+arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
 {
-	void __iomem *addr;
-	struct vm_struct *area;
-	unsigned long offset;
-	pgprot_t prot;
-	u64 attr;
+	phys_addr_t phys_addr = *paddr;
 	unsigned long gran_base, gran_size;
 	unsigned long page_base;
+	u64 attr;
 
 	/*
 	 * For things in kern_memmap, we must use the same attribute
@@ -69,35 +66,18 @@ ioremap (unsigned long phys_addr, unsigned long size)
 	page_base = phys_addr & PAGE_MASK;
 	size = PAGE_ALIGN(phys_addr + size) - page_base;
 	if (efi_mem_attribute(page_base, size) & EFI_MEMORY_WB) {
-		prot = PAGE_KERNEL;
-
-		/*
-		 * Mappings have to be page-aligned
-		 */
-		offset = phys_addr & ~PAGE_MASK;
-		phys_addr &= PAGE_MASK;
-
-		/*
-		 * Ok, go for it..
-		 */
-		area = get_vm_area(size, VM_IOREMAP);
-		if (!area)
-			return NULL;
-
-		area->phys_addr = phys_addr;
-		addr = (void __iomem *) area->addr;
-		if (ioremap_page_range((unsigned long) addr,
-				(unsigned long) addr + size, phys_addr, prot)) {
-			vunmap((void __force *) addr);
-			return NULL;
-		}
-
-		return (void __iomem *) (offset + (char __iomem *)addr);
+		return NULL;
 	}
 
 	return __ioremap_uc(phys_addr);
 }
-EXPORT_SYMBOL(ioremap);
+
+bool arch_iounmap(void __iomem *addr)
+{
+	if (REGION_NUMBER(addr) != RGN_GATE)
+		return false;
+	return true;
+}
 
 void __iomem *
 ioremap_uc(unsigned long phys_addr, unsigned long size)
@@ -113,11 +93,3 @@ void
 early_iounmap (volatile void __iomem *addr, unsigned long size)
 {
 }
-
-void
-iounmap (volatile void __iomem *addr)
-{
-	if (REGION_NUMBER(addr) == RGN_GATE)
-		vunmap((void *) ((unsigned long) addr & PAGE_MASK));
-}
-EXPORT_SYMBOL(iounmap);
-- 
2.34.1

