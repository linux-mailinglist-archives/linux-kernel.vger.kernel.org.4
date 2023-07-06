Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A729974A165
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjGFPsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbjGFPr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:47:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BDF1FE8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 08:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688658418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MfP/dV90ghXNs4nny37p+AmeMzpGP5gepSHR9mCOjb8=;
        b=Y8/4gZluukpcrVDRosx1sfk8yr2WsZBRiNxQYaG+jvpU+rjFzguAOiquM9iXmSD+XpjCZA
        Lgc1q1dh+yHgeLqpoxirjTGtfCAJOIWJlipZVwcGsLpV12Nxq/lbuT8b7YalhY+F49TiCP
        A7OP0Xz1WvXrxkGtb7htNo3abZL7r4g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-266-Mw8JIk7-MdGKjVVBaMzICg-1; Thu, 06 Jul 2023 11:46:57 -0400
X-MC-Unique: Mw8JIk7-MdGKjVVBaMzICg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 757ED3815EF3;
        Thu,  6 Jul 2023 15:46:56 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C0792F6403;
        Thu,  6 Jul 2023 15:46:47 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org, arnd@arndb.de,
        hch@lst.de, christophe.leroy@csgroup.eu, rppt@kernel.org,
        willy@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        shorne@gmail.com, David.Laight@ACULAB.COM, deller@gmx.de,
        nathan@kernel.org, glaubitz@physik.fu-berlin.de,
        Baoquan He <bhe@redhat.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: [PATCH v8 09/19] openrisc: mm: Convert to GENERIC_IOREMAP
Date:   Thu,  6 Jul 2023 23:45:10 +0800
Message-Id: <20230706154520.11257-10-bhe@redhat.com>
In-Reply-To: <20230706154520.11257-1-bhe@redhat.com>
References: <20230706154520.11257-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
This change will simplify implementation by removing duplicated code
with generic_ioremap_prot() and generic_iounmap(), and has the equivalent
functioality as before.

For openrisc, the current ioremap() and iounmap() are the same as
generic version. After taking GENERIC_IOREMAP way, the old ioremap()
and iounmap() can be completely removed.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: openrisc@lists.librecores.org
---
 arch/openrisc/Kconfig          |  1 +
 arch/openrisc/include/asm/io.h | 11 ++++----
 arch/openrisc/mm/ioremap.c     | 49 ----------------------------------
 3 files changed, 7 insertions(+), 54 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index c7f282f60f64..fd9bb76a610b 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -21,6 +21,7 @@ config OPENRISC
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_PCI_IOMAP
+	select GENERIC_IOREMAP
 	select GENERIC_CPU_DEVICES
 	select HAVE_PCI
 	select HAVE_UID16
diff --git a/arch/openrisc/include/asm/io.h b/arch/openrisc/include/asm/io.h
index ee6043a03173..5a6f0f16a5ce 100644
--- a/arch/openrisc/include/asm/io.h
+++ b/arch/openrisc/include/asm/io.h
@@ -15,6 +15,8 @@
 #define __ASM_OPENRISC_IO_H
 
 #include <linux/types.h>
+#include <asm/pgalloc.h>
+#include <asm/pgtable.h>
 
 /*
  * PCI: We do not use IO ports in OpenRISC
@@ -27,11 +29,10 @@
 #define PIO_OFFSET		0
 #define PIO_MASK		0
 
-#define ioremap ioremap
-void __iomem *ioremap(phys_addr_t offset, unsigned long size);
-
-#define iounmap iounmap
-extern void iounmap(volatile void __iomem *addr);
+/*
+ * I/O memory mapping functions.
+ */
+#define _PAGE_IOREMAP (pgprot_val(PAGE_KERNEL) | _PAGE_CI)
 
 #include <asm-generic/io.h>
 
diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
index cdbcc7e73684..91c8259d4b7e 100644
--- a/arch/openrisc/mm/ioremap.c
+++ b/arch/openrisc/mm/ioremap.c
@@ -22,55 +22,6 @@
 
 extern int mem_init_done;
 
-/*
- * Remap an arbitrary physical address space into the kernel virtual
- * address space. Needed when the kernel wants to access high addresses
- * directly.
- *
- * NOTE! We need to allow non-page-aligned mappings too: we will obviously
- * have to convert them into an offset in a page-aligned mapping, but the
- * caller shouldn't need to know that small detail.
- */
-void __iomem *__ref ioremap(phys_addr_t addr, unsigned long size)
-{
-	phys_addr_t p;
-	unsigned long v;
-	unsigned long offset, last_addr;
-	struct vm_struct *area = NULL;
-
-	/* Don't allow wraparound or zero size */
-	last_addr = addr + size - 1;
-	if (!size || last_addr < addr)
-		return NULL;
-
-	/*
-	 * Mappings have to be page-aligned
-	 */
-	offset = addr & ~PAGE_MASK;
-	p = addr & PAGE_MASK;
-	size = PAGE_ALIGN(last_addr + 1) - p;
-
-	area = get_vm_area(size, VM_IOREMAP);
-	if (!area)
-		return NULL;
-	v = (unsigned long)area->addr;
-
-	if (ioremap_page_range(v, v + size, p,
-			__pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_CI))) {
-		vfree(area->addr);
-		return NULL;
-	}
-
-	return (void __iomem *)(offset + (char *)v);
-}
-EXPORT_SYMBOL(ioremap);
-
-void iounmap(volatile void __iomem *addr)
-{
-	return vfree((void *)(PAGE_MASK & (unsigned long)addr));
-}
-EXPORT_SYMBOL(iounmap);
-
 /**
  * OK, this one's a bit tricky... ioremap can get called before memory is
  * initialized (early serial console does this) and will want to alloc a page
-- 
2.34.1

