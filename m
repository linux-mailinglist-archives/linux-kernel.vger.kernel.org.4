Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1345B74A159
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjGFPrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjGFPrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:47:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE7C19B2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 08:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688658375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X3bCqAOghUMsrFt01sdBss+0xjEFSAaHuAsd0sFdmyw=;
        b=IF8fGozyH5BdhjFxzK679BBw/9Vjxcr92sKiIfGmtl0lb1z2ND3p3nw7u8zP60y/6b6t5H
        XF0ZR+nPuKwVR9NCJWzEsB7Am+lui6QbiJ5o9YuxeI5FVi7cAFLi76ZEwbj0kBcv+mYPaE
        v8i8fgkSGS04+aGinf+iFgKFYO2tXuQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-7eAVe7wZPSC4sGD6Lhz-8w-1; Thu, 06 Jul 2023 11:46:10 -0400
X-MC-Unique: 7eAVe7wZPSC4sGD6Lhz-8w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC4E6185A792;
        Thu,  6 Jul 2023 15:46:08 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D76AF5CF0;
        Thu,  6 Jul 2023 15:46:00 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org, arnd@arndb.de,
        hch@lst.de, christophe.leroy@csgroup.eu, rppt@kernel.org,
        willy@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        shorne@gmail.com, David.Laight@ACULAB.COM, deller@gmx.de,
        nathan@kernel.org, glaubitz@physik.fu-berlin.de,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v8 04/19] mm/ioremap: Define generic_ioremap_prot() and generic_iounmap()
Date:   Thu,  6 Jul 2023 23:45:05 +0800
Message-Id: <20230706154520.11257-5-bhe@redhat.com>
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

From: Christophe Leroy <christophe.leroy@csgroup.eu>

Define a generic version of ioremap_prot() and iounmap() that
architectures can call after they have performed the necessary
alteration to parameters and/or necessary verifications.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/asm-generic/io.h |  4 ++++
 mm/ioremap.c             | 22 ++++++++++++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 587e7e9b9a37..a7ca2099ba19 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1073,9 +1073,13 @@ static inline bool iounmap_allowed(void *addr)
 }
 #endif
 
+void __iomem *generic_ioremap_prot(phys_addr_t phys_addr, size_t size,
+				   pgprot_t prot);
+
 void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 			   unsigned long prot);
 void iounmap(volatile void __iomem *addr);
+void generic_iounmap(volatile void __iomem *addr);
 
 static inline void __iomem *ioremap(phys_addr_t addr, size_t size)
 {
diff --git a/mm/ioremap.c b/mm/ioremap.c
index 8652426282cc..db6234b9db59 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -11,8 +11,8 @@
 #include <linux/io.h>
 #include <linux/export.h>
 
-void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
-			   unsigned long prot)
+void __iomem *generic_ioremap_prot(phys_addr_t phys_addr, size_t size,
+				   pgprot_t prot)
 {
 	unsigned long offset, vaddr;
 	phys_addr_t last_addr;
@@ -28,7 +28,7 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 	phys_addr -= offset;
 	size = PAGE_ALIGN(size + offset);
 
-	if (!ioremap_allowed(phys_addr, size, prot))
+	if (!ioremap_allowed(phys_addr, size, pgprot_val(prot)))
 		return NULL;
 
 	area = get_vm_area_caller(size, VM_IOREMAP,
@@ -38,17 +38,22 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 	vaddr = (unsigned long)area->addr;
 	area->phys_addr = phys_addr;
 
-	if (ioremap_page_range(vaddr, vaddr + size, phys_addr,
-			       __pgprot(prot))) {
+	if (ioremap_page_range(vaddr, vaddr + size, phys_addr, prot)) {
 		free_vm_area(area);
 		return NULL;
 	}
 
 	return (void __iomem *)(vaddr + offset);
 }
+
+void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
+			   unsigned long prot)
+{
+	return generic_ioremap_prot(phys_addr, size, __pgprot(prot));
+}
 EXPORT_SYMBOL(ioremap_prot);
 
-void iounmap(volatile void __iomem *addr)
+void generic_iounmap(volatile void __iomem *addr)
 {
 	void *vaddr = (void *)((unsigned long)addr & PAGE_MASK);
 
@@ -58,4 +63,9 @@ void iounmap(volatile void __iomem *addr)
 	if (is_vmalloc_addr(vaddr))
 		vunmap(vaddr);
 }
+
+void iounmap(volatile void __iomem *addr)
+{
+	generic_iounmap(addr);
+}
 EXPORT_SYMBOL(iounmap);
-- 
2.34.1

