Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556A65F8AA7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 12:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiJIKdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 06:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiJIKcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 06:32:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDA92DA85
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 03:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665311563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VQufd3pNtB/ZLIfwfMxxAYrIBPOZ+D7pL2gacb9OT3o=;
        b=OeMpBnC7G/7y44hBZT17e1rqrNajPHBeMSXyKz9nRhKsQ5a/I2mrehx51wHMfqXuZCIEWc
        KLOW50kX56cXHj/EmSagmTFZAncUNpb00meA/Y9oW1aG7yAnFqGXm6BUuAVzw7UCXn9Eqc
        0iNf6+augjEffOchtgxlvHAtL3bijak=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-16-oye7IdRbOhqO2CIsuNzMQQ-1; Sun, 09 Oct 2022 06:32:39 -0400
X-MC-Unique: oye7IdRbOhqO2CIsuNzMQQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17304380673B;
        Sun,  9 Oct 2022 10:32:39 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-36.pek2.redhat.com [10.72.12.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C6AF40D298B;
        Sun,  9 Oct 2022 10:32:32 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        christophe.leroy@csgroup.eu, schnelle@linux.ibm.com,
        David.Laight@ACULAB.COM, shorne@gmail.com, bhe@redhat.com,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Subject: [PATCH v3 08/11] parisc: mm: Convert to GENERIC_IOREMAP
Date:   Sun,  9 Oct 2022 18:31:11 +0800
Message-Id: <20221009103114.149036-9-bhe@redhat.com>
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

For parisc, add hook arch_ioremap() for parisc's special operation when
ioremap(), then ioremap_[wc|uc]() are converted to use ioremap_prot()
from GENERIC_IOREMAP.

Meanwhile, add macro ARCH_HAS_IOREMAP_WC since the added ioremap_wc()
will conflict with the one in include/asm-generic/iomap.h, then an
compiling error is seen:

./include/asm-generic/iomap.h:97: warning: "ioremap_wc" redefined
   97 | #define ioremap_wc ioremap

And benefit from the commit 437b6b35362b ("parisc: Use the generic
IO helpers"), those macros don't need be added any more.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
---
v2->v3:
- Fix compiling error by adding macro definition, ARCH_HAS_IOREMAP_WC.
- Benefit from commit 437b6b35362b ("parisc: Use the generic IO helpers"),
  those tons of port/mem io operation macro definitions are not needed
  after rebasing to the latest upstream.

 arch/parisc/Kconfig          |  1 +
 arch/parisc/include/asm/io.h | 19 ++++++++---
 arch/parisc/mm/ioremap.c     | 65 ++++--------------------------------
 3 files changed, 21 insertions(+), 64 deletions(-)

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index a98940e64243..0ed18e673aba 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -36,6 +36,7 @@ config PARISC
 	select GENERIC_ATOMIC64 if !64BIT
 	select GENERIC_IRQ_PROBE
 	select GENERIC_PCI_IOMAP
+	select GENERIC_IOREMAP
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_ARCH_TOPOLOGY if SMP
diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
index c05e781be2f5..1c54f83d4f78 100644
--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_IO_H
 #define _ASM_IO_H
 
+#define ARCH_HAS_IOREMAP_WC
+
 #include <linux/types.h>
 #include <linux/pgtable.h>
 
@@ -125,12 +127,19 @@ static inline void gsc_writeq(unsigned long long val, unsigned long addr)
 /*
  * The standard PCI ioremap interfaces
  */
-void __iomem *ioremap(unsigned long offset, unsigned long size);
-#define ioremap_wc			ioremap
-#define ioremap_uc			ioremap
-#define pci_iounmap			pci_iounmap
+void __iomem *
+arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val);
+#define arch_ioremap arch_ioremap
+
+#define _PAGE_IOREMAP (_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | \
+		       _PAGE_ACCESSED | _PAGE_NO_CACHE)
 
-extern void iounmap(const volatile void __iomem *addr);
+#define ioremap_wc(addr, size)  \
+	ioremap_prot((addr), (size), _PAGE_IOREMAP)
+#define ioremap_uc(addr, size)  \
+	ioremap_prot((addr), (size), _PAGE_IOREMAP)
+
+#define pci_iounmap			pci_iounmap
 
 void memset_io(volatile void __iomem *addr, unsigned char val, int count);
 void memcpy_fromio(void *dst, const volatile void __iomem *src, int count);
diff --git a/arch/parisc/mm/ioremap.c b/arch/parisc/mm/ioremap.c
index 345ff0b66499..28884757fad0 100644
--- a/arch/parisc/mm/ioremap.c
+++ b/arch/parisc/mm/ioremap.c
@@ -13,38 +13,19 @@
 #include <linux/io.h>
 #include <linux/mm.h>
 
-/*
- * Generic mapping function (not visible outside):
- */
-
-/*
- * Remap an arbitrary physical address space into the kernel virtual
- * address space.
- *
- * NOTE! We need to allow non-page-aligned mappings too: we will obviously
- * have to convert them into an offset in a page-aligned mapping, but the
- * caller shouldn't need to know that small detail.
- */
-void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
+void __iomem *
+arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
 {
-	void __iomem *addr;
-	struct vm_struct *area;
-	unsigned long offset, last_addr;
-	pgprot_t pgprot;
+	phys_addr_t phys_addr = *paddr;
 
 #ifdef CONFIG_EISA
 	unsigned long end = phys_addr + size - 1;
 	/* Support EISA addresses */
 	if ((phys_addr >= 0x00080000 && end < 0x000fffff) ||
 	    (phys_addr >= 0x00500000 && end < 0x03bfffff))
-		phys_addr |= F_EXTEND(0xfc000000);
+		*paddr = phys_addr |= F_EXTEND(0xfc000000);
 #endif
 
-	/* Don't allow wraparound or zero size */
-	last_addr = phys_addr + size - 1;
-	if (!size || last_addr < phys_addr)
-		return NULL;
-
 	/*
 	 * Don't allow anybody to remap normal RAM that we're using..
 	 */
@@ -58,43 +39,9 @@ void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
 		for (page = virt_to_page(t_addr); 
 		     page <= virt_to_page(t_end); page++) {
 			if(!PageReserved(page))
-				return NULL;
+				return IOMEM_ERR_PTR(-EINVAL);
 		}
 	}
 
-	pgprot = __pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY |
-			  _PAGE_ACCESSED | _PAGE_NO_CACHE);
-
-	/*
-	 * Mappings have to be page-aligned
-	 */
-	offset = phys_addr & ~PAGE_MASK;
-	phys_addr &= PAGE_MASK;
-	size = PAGE_ALIGN(last_addr + 1) - phys_addr;
-
-	/*
-	 * Ok, go for it..
-	 */
-	area = get_vm_area(size, VM_IOREMAP);
-	if (!area)
-		return NULL;
-
-	addr = (void __iomem *) area->addr;
-	if (ioremap_page_range((unsigned long)addr, (unsigned long)addr + size,
-			       phys_addr, pgprot)) {
-		vunmap(addr);
-		return NULL;
-	}
-
-	return (void __iomem *) (offset + (char __iomem *)addr);
-}
-EXPORT_SYMBOL(ioremap);
-
-void iounmap(const volatile void __iomem *io_addr)
-{
-	unsigned long addr = (unsigned long)io_addr & PAGE_MASK;
-
-	if (is_vmalloc_addr((void *)addr))
-		vunmap((void *)addr);
+	return NULL;
 }
-EXPORT_SYMBOL(iounmap);
-- 
2.34.1

