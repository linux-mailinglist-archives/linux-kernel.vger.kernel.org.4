Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62739699474
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjBPMfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjBPMfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:35:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20343B3D1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676550896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wmaPlT6qa/hIBp/Pd8+V5Z2lcUnUfL5T/RFM1vmlHuE=;
        b=Ce51N/oEzQqHA5iGuaCbigH409h7dEx7bqfJEYvoh2drEWiNP356P5MvB/uUwMZtQ8DT7e
        VEMQODGEpKTSD0Mw1hJCJDt1I69c6OYFLBucRAoj+NOfLFyre0lMkb0H0e3wMRYv2n0SOH
        wGlcPtsjbQXL72Ss8vsbarjzHwjTqwY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-373-91IkA2bIOg-NUu3Sb4_AoA-1; Thu, 16 Feb 2023 07:34:53 -0500
X-MC-Unique: 91IkA2bIOg-NUu3Sb4_AoA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 040CD3814952;
        Thu, 16 Feb 2023 12:34:53 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-99.pek2.redhat.com [10.72.12.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7074B492C3C;
        Thu, 16 Feb 2023 12:34:47 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        christophe.leroy@csgroup.eu, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@ACULAB.COM, shorne@gmail.com,
        arnd@arndb.de, Baoquan He <bhe@redhat.com>
Subject: [PATCH v4 03/16] mm/ioremap: Define generic_ioremap_prot() and generic_iounmap()
Date:   Thu, 16 Feb 2023 20:34:06 +0800
Message-Id: <20230216123419.461016-4-bhe@redhat.com>
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

From: Christophe Leroy <christophe.leroy@csgroup.eu>

Define a generic version of ioremap_prot() and iounmap() that
architectures can call after they have performed the necessary
alteration to parameters and/or necessary verifications.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/asm-generic/io.h |  4 ++++
 mm/ioremap.c             | 22 ++++++++++++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 4c44a29b5e8e..5a9cf16ee0c2 100644
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

