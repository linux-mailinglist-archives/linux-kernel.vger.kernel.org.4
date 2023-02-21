Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6461D69DA93
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 07:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbjBUGIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 01:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjBUGIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 01:08:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B74F241EE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 22:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676959674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hgqR0ygqLDetqpeTHucde422Qa7eKDiutvhSuW8M0Eo=;
        b=DctXNfsASSZeJUQQFckssop1Qdr1FC69c8XuazNgHWi9UW+LPhFR0We6Eou3Er3MvrnDcw
        qzt4V6L148MS8vSC3vWcg6I+oIv5cd4UVZQphzDLw7ULasvuSkP3GqRzydkiw8i/B5M+Bz
        Y/vTgMXLRNhF5qmyHKtMEf3mvN9t+X0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-le87--KeOZebpduoxv08BQ-1; Tue, 21 Feb 2023 01:07:51 -0500
X-MC-Unique: le87--KeOZebpduoxv08BQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B81D18483B3;
        Tue, 21 Feb 2023 06:07:50 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-7.pek2.redhat.com [10.72.13.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CAF5492B04;
        Tue, 21 Feb 2023 06:07:37 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, arnd@arndb.de, hch@infradead.org,
        mcgrof@kernel.org, Baoquan He <bhe@redhat.com>
Subject: [RFC PATCH 2/2] arch/*/io.h: remove ioremap_uc in some architectures
Date:   Tue, 21 Feb 2023 14:07:23 +0800
Message-Id: <20230221060723.26291-3-bhe@redhat.com>
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

ioremap_uc() is only meaningful on old x86-32 systems with the PAT
extension, and on ia64 with its slightly unconventional ioremap()
behavior, everywhere else this is the same as ioremap() anyway.

So here, remove the ioremap_uc() definition in architecutures other
than x86 and ia64. These architectures all have asm-generic/io.h
included and will have the default ioremap_uc() definition which
returns NULL. If any ARCH really needs a specific ioremap_uc() for
its own usage, one ioremap_uc() can be added in the ARH.

Link: https://lore.kernel.org/all/20191112105507.GA7122@lst.de/#t
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/alpha/include/asm/io.h    | 1 -
 arch/hexagon/include/asm/io.h  | 3 ---
 arch/m68k/include/asm/kmap.h   | 1 -
 arch/mips/include/asm/io.h     | 1 -
 arch/parisc/include/asm/io.h   | 2 --
 arch/powerpc/include/asm/io.h  | 1 -
 arch/sh/include/asm/io.h       | 2 --
 arch/sparc/include/asm/io_64.h | 1 -
 8 files changed, 12 deletions(-)

diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
index 1c3605d874e9..0d519f96a20e 100644
--- a/arch/alpha/include/asm/io.h
+++ b/arch/alpha/include/asm/io.h
@@ -312,7 +312,6 @@ static inline void __iomem *ioremap(unsigned long port, unsigned long size)
 }
 
 #define ioremap_wc ioremap
-#define ioremap_uc ioremap
 
 static inline void iounmap(volatile void __iomem *addr)
 {
diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
index dcd9cbbf5934..b9847472f25c 100644
--- a/arch/hexagon/include/asm/io.h
+++ b/arch/hexagon/include/asm/io.h
@@ -176,9 +176,6 @@ static inline void writel(u32 data, volatile void __iomem *addr)
 #define _PAGE_IOREMAP (_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
 		       (__HEXAGON_C_DEV << 6))
 
-#define ioremap_uc(addr, size) ioremap((addr), (size))
-
-
 #define __raw_writel writel
 
 static inline void memcpy_fromio(void *dst, const volatile void __iomem *src,
diff --git a/arch/m68k/include/asm/kmap.h b/arch/m68k/include/asm/kmap.h
index dec05743d426..d3c9934b9475 100644
--- a/arch/m68k/include/asm/kmap.h
+++ b/arch/m68k/include/asm/kmap.h
@@ -27,7 +27,6 @@ static inline void __iomem *ioremap(unsigned long physaddr, unsigned long size)
 	return __ioremap(physaddr, size, IOMAP_NOCACHE_SER);
 }
 
-#define ioremap_uc ioremap
 #define ioremap_wt ioremap_wt
 static inline void __iomem *ioremap_wt(unsigned long physaddr,
 				       unsigned long size)
diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index c89804a5802a..aa6c55d6cb6c 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -170,7 +170,6 @@ void iounmap(const volatile void __iomem *addr);
  */
 #define ioremap(offset, size)						\
 	ioremap_prot((offset), (size), _CACHE_UNCACHED)
-#define ioremap_uc		ioremap
 
 /*
  * ioremap_cache -	map bus memory into CPU space
diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
index 4c386b0cee08..8aaa79017131 100644
--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -134,8 +134,6 @@ static inline void gsc_writeq(unsigned long long val, unsigned long addr)
 
 #define ioremap_wc(addr, size)  \
 	ioremap_prot((addr), (size), _PAGE_IOREMAP)
-#define ioremap_uc(addr, size)  \
-	ioremap_prot((addr), (size), _PAGE_IOREMAP)
 
 #define pci_iounmap			pci_iounmap
 
diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 127d8300b40b..cfbb6df9f55f 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -870,7 +870,6 @@ void __iomem *ioremap_wt(phys_addr_t address, unsigned long size);
 #endif
 
 void __iomem *ioremap_coherent(phys_addr_t address, unsigned long size);
-#define ioremap_uc(addr, size)		ioremap((addr), (size))
 #define ioremap_cache(addr, size) \
 	ioremap_prot((addr), (size), pgprot_val(PAGE_KERNEL))
 
diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index b3a26b405c8d..12a892804082 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -278,8 +278,6 @@ unsigned long long poke_real_address_q(unsigned long long addr,
 	ioremap_prot((addr), (size), pgprot_val(PAGE_KERNEL))
 #endif /* CONFIG_MMU */
 
-#define ioremap_uc	ioremap
-
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
index 9303270b22f3..d8ee1442f303 100644
--- a/arch/sparc/include/asm/io_64.h
+++ b/arch/sparc/include/asm/io_64.h
@@ -423,7 +423,6 @@ static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
 	return (void __iomem *)offset;
 }
 
-#define ioremap_uc(X,Y)			ioremap((X),(Y))
 #define ioremap_wc(X,Y)			ioremap((X),(Y))
 #define ioremap_wt(X,Y)			ioremap((X),(Y))
 static inline void __iomem *ioremap_np(unsigned long offset, unsigned long size)
-- 
2.34.1

