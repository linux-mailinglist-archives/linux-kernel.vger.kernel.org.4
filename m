Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4C069DA92
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 07:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbjBUGIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 01:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbjBUGI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 01:08:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E1A24130
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 22:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676959663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u1NKntO/QfPCOBzWgJ4dShR6SEblbk9yft7GyEY5yCo=;
        b=MLM3H2o7/8cczAs7GRlrE2aTEyqk1V5ECdLdNUbVC+Y19oqpMpsaqvgNeobkCuxOV4pr7o
        3sZe5qFsUUGke/012mWDdXHO/wCj4PC4znrOFvIwZuOwZSxRRki9e0YLAVXLUGW7xckAgh
        opk4xdznldJ8zQ9Q+dazmTJqQySiD1U=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-394-64ARo8UCM-23MdKA0rH2cg-1; Tue, 21 Feb 2023 01:07:37 -0500
X-MC-Unique: 64ARo8UCM-23MdKA0rH2cg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B5AD3C0F189;
        Tue, 21 Feb 2023 06:07:36 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-7.pek2.redhat.com [10.72.13.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30FFE492B04;
        Tue, 21 Feb 2023 06:07:30 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, arnd@arndb.de, hch@infradead.org,
        mcgrof@kernel.org, Baoquan He <bhe@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org
Subject: [RFC PATCH 1/2] mips: add <asm-generic/io.h> including
Date:   Tue, 21 Feb 2023 14:07:22 +0800
Message-Id: <20230221060723.26291-2-bhe@redhat.com>
In-Reply-To: <20230221060723.26291-1-bhe@redhat.com>
References: <20230221060723.26291-1-bhe@redhat.com>
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

With the adding, some default ioremap_xx methods defined in
asm-generic/io.h can be used. E.g the default ioremap_uc() returning
NULL.

Signed-off-by: Baoquan He <bhe@redhat.com>

Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-mips@vger.kernel.org

---
 arch/mips/include/asm/io.h     | 46 ++++++++++++++++++++++++++++++++++
 arch/mips/include/asm/mmiowb.h |  2 --
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index e6d5ccaa309e..c89804a5802a 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -129,6 +129,7 @@ static inline phys_addr_t virt_to_phys(const volatile void *x)
  *     almost all conceivable cases a device driver should not be using
  *     this function
  */
+#define phys_to_virt phys_to_virt
 static inline void * phys_to_virt(unsigned long address)
 {
 	return __va(address);
@@ -481,14 +482,17 @@ BUILDSTRING(l, u32)
 BUILDSTRING(q, u64)
 #endif
 
+#define memset_io memset_io
 static inline void memset_io(volatile void __iomem *addr, unsigned char val, int count)
 {
 	memset((void __force *) addr, val, count);
 }
+#define memcpy_fromio memcpy_fromio
 static inline void memcpy_fromio(void *dst, const volatile void __iomem *src, int count)
 {
 	memcpy(dst, (void __force *) src, count);
 }
+#define memcpy_toio memcpy_toio
 static inline void memcpy_toio(volatile void __iomem *dst, const void *src, int count)
 {
 	memcpy((void __force *) dst, src, count);
@@ -549,6 +553,46 @@ extern void (*_dma_cache_inv)(unsigned long start, unsigned long size);
 #define csr_out32(v, a) (*(volatile u32 *)((unsigned long)(a) + __CSR_32_ADJUST) = (v))
 #define csr_in32(a)    (*(volatile u32 *)((unsigned long)(a) + __CSR_32_ADJUST))
 
+
+#define inb_p inb_p
+#define inw_p inw_p
+#define inl_p inl_p
+#define insb insb
+#define insw insw
+#define insl insl
+
+#define outb_p outb_p
+#define outw_p outw_p
+#define outl_p outl_p
+#define outsb outsb
+#define outsw outsw
+#define outsl outsl
+
+#define readb readb
+#define readw readw
+#define readl readl
+#define writeb writeb
+#define writew writew
+#define writel writel
+
+#define readsb readsb
+#define readsw readsw
+#define readsl readsl
+#define readsq readsq
+#define writesb writesb
+#define writesw writesw
+#define writesl writesl
+#define writesq writesq
+
+#define __raw_readb __raw_readb
+#define __raw_readw __raw_readw
+#define __raw_readl __raw_readl
+#define __raw_readq __raw_readq
+#define __raw_writeb __raw_writeb
+#define __raw_writew __raw_writew
+#define __raw_writel __raw_writel
+#define __raw_writeq __raw_writeq
+
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
@@ -557,4 +601,6 @@ extern void (*_dma_cache_inv)(unsigned long start, unsigned long size);
 
 void __ioread64_copy(void *to, const void __iomem *from, size_t count);
 
+#include <asm-generic/io.h>
+
 #endif /* _ASM_IO_H */
diff --git a/arch/mips/include/asm/mmiowb.h b/arch/mips/include/asm/mmiowb.h
index a40824e3ef8e..007fe55bc7d1 100644
--- a/arch/mips/include/asm/mmiowb.h
+++ b/arch/mips/include/asm/mmiowb.h
@@ -2,8 +2,6 @@
 #ifndef _ASM_MMIOWB_H
 #define _ASM_MMIOWB_H
 
-#include <asm/io.h>
-
 #define mmiowb()	iobarrier_w()
 
 #include <asm-generic/mmiowb.h>
-- 
2.34.1

