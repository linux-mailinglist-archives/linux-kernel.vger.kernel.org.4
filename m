Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E577C5F8AA2
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 12:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiJIKdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 06:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiJIKca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 06:32:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C252E9C0
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 03:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665311542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HaQPeJxptHMyV1ztVt0VW5rhVl6/g1wDewqhu9GeM3I=;
        b=fyknXdH//8+4SwJF+8+bwqaLBLLn81o1nQNy1tlUx7Q8zZl1iwxz0LI/Av/L4ftsdjiD27
        k5U9qfwRKP5o2MN7XrxC7lXOmRN1pcMLNgeV3MuALgZa3k4jfk+sSvRGxc99A9aqqcXNyj
        bmvDTZHFAP051W18b53TKEgwggbZJkI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-9rDO8_alNHa97RVOw_ynxw-1; Sun, 09 Oct 2022 06:32:18 -0400
X-MC-Unique: 9rDO8_alNHa97RVOw_ynxw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7BA285A583;
        Sun,  9 Oct 2022 10:32:17 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-36.pek2.redhat.com [10.72.12.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2656D40D298B;
        Sun,  9 Oct 2022 10:32:11 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        christophe.leroy@csgroup.eu, schnelle@linux.ibm.com,
        David.Laight@ACULAB.COM, shorne@gmail.com, bhe@redhat.com,
        Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH v3 05/11] arc: mm: Convert to GENERIC_IOREMAP
Date:   Sun,  9 Oct 2022 18:31:08 +0800
Message-Id: <20221009103114.149036-6-bhe@redhat.com>
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

Here, add hooks arch_ioremap() and arch_iounmap() for arc's special
operation when ioremap_prot() and iounmap(). Meanwhile define and
implement arc's own ioremap() because arc has some special handling
in ioremap() than standard ioremap().

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Vineet Gupta <vgupta@kernel.org>
Cc: linux-snps-arc@lists.infradead.org
---
 arch/arc/Kconfig          |  1 +
 arch/arc/include/asm/io.h | 19 +++++++++----
 arch/arc/mm/ioremap.c     | 60 ++++++---------------------------------
 3 files changed, 23 insertions(+), 57 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 9e3653253ef2..a08d2abfaf61 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -26,6 +26,7 @@ config ARC
 	select GENERIC_PENDING_IRQ if SMP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
+	select GENERIC_IOREMAP
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if ARC_MMU_V4
diff --git a/arch/arc/include/asm/io.h b/arch/arc/include/asm/io.h
index 8f777d6441a5..41a317567920 100644
--- a/arch/arc/include/asm/io.h
+++ b/arch/arc/include/asm/io.h
@@ -20,9 +20,20 @@
 #define __iowmb()		do { } while (0)
 #endif
 
-extern void __iomem *ioremap(phys_addr_t paddr, unsigned long size);
-extern void __iomem *ioremap_prot(phys_addr_t paddr, unsigned long size,
-				  unsigned long flags);
+/*
+ * I/O memory mapping functions.
+ */
+
+void __iomem *
+arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val);
+#define arch_ioremap arch_ioremap
+
+bool arch_iounmap(void __iomem *addr);
+#define arch_iounmap arch_iounmap
+
+void __iomem *ioremap(phys_addr_t paddr, unsigned long size);
+#define ioremap ioremap
+
 static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
 {
 	return (void __iomem *)port;
@@ -32,8 +43,6 @@ static inline void ioport_unmap(void __iomem *addr)
 {
 }
 
-extern void iounmap(const void __iomem *addr);
-
 /*
  * io{read,write}{16,32}be() macros
  */
diff --git a/arch/arc/mm/ioremap.c b/arch/arc/mm/ioremap.c
index 0ee75aca6e10..c2dcacd56aca 100644
--- a/arch/arc/mm/ioremap.c
+++ b/arch/arc/mm/ioremap.c
@@ -25,13 +25,6 @@ static inline bool arc_uncached_addr_space(phys_addr_t paddr)
 
 void __iomem *ioremap(phys_addr_t paddr, unsigned long size)
 {
-	phys_addr_t end;
-
-	/* Don't allow wraparound or zero size */
-	end = paddr + size - 1;
-	if (!size || (end < paddr))
-		return NULL;
-
 	/*
 	 * If the region is h/w uncached, MMU mapping can be elided as optim
 	 * The cast to u32 is fine as this region can only be inside 4GB
@@ -44,62 +37,25 @@ void __iomem *ioremap(phys_addr_t paddr, unsigned long size)
 }
 EXPORT_SYMBOL(ioremap);
 
-/*
- * ioremap with access flags
- * Cache semantics wise it is same as ioremap - "forced" uncached.
- * However unlike vanilla ioremap which bypasses ARC MMU for addresses in
- * ARC hardware uncached region, this one still goes thru the MMU as caller
- * might need finer access control (R/W/X)
- */
-void __iomem *ioremap_prot(phys_addr_t paddr, unsigned long size,
-			   unsigned long flags)
+void __iomem *
+arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
 {
-	unsigned int off;
-	unsigned long vaddr;
-	struct vm_struct *area;
-	phys_addr_t end;
-	pgprot_t prot = __pgprot(flags);
-
-	/* Don't allow wraparound, zero size */
-	end = paddr + size - 1;
-	if ((!size) || (end < paddr))
-		return NULL;
-
 	/* An early platform driver might end up here */
 	if (!slab_is_available())
-		return NULL;
+		return IOMEM_ERR_PTR(-EINVAL);
 
 	/* force uncached */
-	prot = pgprot_noncached(prot);
+	*prot_val = pgprot_val(pgprot_noncached(__pgprot(*prot_val)));
 
-	/* Mappings have to be page-aligned */
-	off = paddr & ~PAGE_MASK;
-	paddr &= PAGE_MASK_PHYS;
-	size = PAGE_ALIGN(end + 1) - paddr;
+	return NULL;
 
-	/*
-	 * Ok, go for it..
-	 */
-	area = get_vm_area(size, VM_IOREMAP);
-	if (!area)
-		return NULL;
-	area->phys_addr = paddr;
-	vaddr = (unsigned long)area->addr;
-	if (ioremap_page_range(vaddr, vaddr + size, paddr, prot)) {
-		vunmap((void __force *)vaddr);
-		return NULL;
-	}
-	return (void __iomem *)(off + (char __iomem *)vaddr);
 }
-EXPORT_SYMBOL(ioremap_prot);
-
 
-void iounmap(const void __iomem *addr)
+bool arch_iounmap(void __iomem *addr)
 {
 	/* weird double cast to handle phys_addr_t > 32 bits */
 	if (arc_uncached_addr_space((phys_addr_t)(u32)addr))
-		return;
+		return false;
 
-	vfree((void *)(PAGE_MASK & (unsigned long __force)addr));
+	return true;
 }
-EXPORT_SYMBOL(iounmap);
-- 
2.34.1

