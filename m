Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F37699483
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjBPMh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjBPMhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:37:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD3359B78
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676550965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jOfO7o4eolW0xpC5MhdSSAQCpax0BympL7aMQoqVjro=;
        b=OD3Na08kNzIDg5cR7SyO/rPM9OwE0I5YMpYvGutQZ0OBjpwulvnNitGEQTFNtyZdYhrZiX
        9nXERVWX0C9EBDIY8DCrdbVj92ONSdm+xHrvrgXnK1NRhE9ADEnTuUgkyTzBSMZG36UMWF
        5FgCPMju1RL0Ld+fJ02HyWnxTpkF8Tc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-118-3LacnqMIN4yVN8x9q_9VQQ-1; Thu, 16 Feb 2023 07:36:01 -0500
X-MC-Unique: 3LacnqMIN4yVN8x9q_9VQQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E5F9811E6E;
        Thu, 16 Feb 2023 12:36:00 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-99.pek2.redhat.com [10.72.12.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF29B492B0F;
        Thu, 16 Feb 2023 12:35:54 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        christophe.leroy@csgroup.eu, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@ACULAB.COM, shorne@gmail.com,
        arnd@arndb.de, Baoquan He <bhe@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Subject: [PATCH v4 12/16] parisc: mm: Convert to GENERIC_IOREMAP
Date:   Thu, 16 Feb 2023 20:34:15 +0800
Message-Id: <20230216123419.461016-13-bhe@redhat.com>
In-Reply-To: <20230216123419.461016-1-bhe@redhat.com>
References: <20230216123419.461016-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By taking GENERIC_IOREMAP method, the generic generic_ioremap_prot(),
generic_iounmap(), and their generic wrapper ioremap_prot(), ioremap()
and iounmap() are all visible and available to arch. Arch needs to
provide wrapper functions to override the generic versions if there's
arch specific handling in its ioremap_prot(), ioremap() or iounmap().
This change will simplify implementation by removing duplicated codes
with generic_ioremap_prot() and generic_iounmap(), and has the equivalent
functioality as before.

Here, add wrapper function ioremap_prot() for parisc's special operation
when iounmap().

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
 arch/parisc/Kconfig          |  1 +
 arch/parisc/include/asm/io.h | 17 +++++++---
 arch/parisc/mm/ioremap.c     | 62 +++---------------------------------
 3 files changed, 17 insertions(+), 63 deletions(-)

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
index c05e781be2f5..4c386b0cee08 100644
--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_IO_H
 #define _ASM_IO_H
 
+#define ARCH_HAS_IOREMAP_WC
+
 #include <linux/types.h>
 #include <linux/pgtable.h>
 
@@ -125,12 +127,17 @@ static inline void gsc_writeq(unsigned long long val, unsigned long addr)
 /*
  * The standard PCI ioremap interfaces
  */
-void __iomem *ioremap(unsigned long offset, unsigned long size);
-#define ioremap_wc			ioremap
-#define ioremap_uc			ioremap
-#define pci_iounmap			pci_iounmap
+#define ioremap_prot ioremap_prot
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
index 345ff0b66499..fd996472dfe7 100644
--- a/arch/parisc/mm/ioremap.c
+++ b/arch/parisc/mm/ioremap.c
@@ -13,25 +13,9 @@
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
+void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
+			   unsigned long prot)
 {
-	void __iomem *addr;
-	struct vm_struct *area;
-	unsigned long offset, last_addr;
-	pgprot_t pgprot;
-
 #ifdef CONFIG_EISA
 	unsigned long end = phys_addr + size - 1;
 	/* Support EISA addresses */
@@ -40,11 +24,6 @@ void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
 		phys_addr |= F_EXTEND(0xfc000000);
 #endif
 
-	/* Don't allow wraparound or zero size */
-	last_addr = phys_addr + size - 1;
-	if (!size || last_addr < phys_addr)
-		return NULL;
-
 	/*
 	 * Don't allow anybody to remap normal RAM that we're using..
 	 */
@@ -62,39 +41,6 @@ void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
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
+	return generic_ioremap_prot(phys_addr, size, __pgprot(prot));
 }
-EXPORT_SYMBOL(iounmap);
+EXPORT_SYMBOL(ioremap_prot);
-- 
2.34.1

