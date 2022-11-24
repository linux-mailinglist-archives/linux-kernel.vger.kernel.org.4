Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3321E6374E5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiKXJNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiKXJNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:13:51 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E199D1122E3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:13:49 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=zelin.deng@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VVaTOzS_1669281187;
Received: from alinux-host.hz.ali.com(mailfrom:zelin.deng@linux.alibaba.com fp:SMTPD_---0VVaTOzS_1669281187)
          by smtp.aliyun-inc.com;
          Thu, 24 Nov 2022 17:13:07 +0800
From:   Zelin Deng <zelin.deng@linux.alibaba.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Zelin Deng <zelin.deng@linux.alibaba.com>
Subject: [PATCH 2/2] x86/setup: Preserve _ENC flag when initrd is being relocated
Date:   Thu, 24 Nov 2022 17:12:46 +0800
Message-Id: <20221124091246.4957-3-zelin.deng@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221124091246.4957-1-zelin.deng@linux.alibaba.com>
References: <20221124091246.4957-1-zelin.deng@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 107cd2532181 ("Encrypt the initrd earlier for BSP microcode update")
when SME is enabled, initrd will be encrypted at earlier stage. If
initrd is located at e820 reserved area the initrd will be copied to
direct mapping area in relocate_initrd().

In this case source address of initrd should be mapped as encrypted
while copy_from_early_mem() will clear encrypted attribute as the source
address is not in kernel usable area, therefore relocated initrd is
encrypted data and is not able to be unpacked later.

Add new function copy_early_initrd() to preserve _ENC flag in setup.c
and remove copy_from_early_mem() as it's only used once here by x86.

Signed-off-by: Zelin Deng <zelin.deng@linux.alibaba.com>
---
 arch/x86/kernel/setup.c             | 30 ++++++++++++++++++++++++++++-
 include/asm-generic/early_ioremap.h |  6 ------
 mm/early_ioremap.c                  | 21 --------------------
 3 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 56deaf37e508..f9996982f026 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -260,6 +260,34 @@ static u64 __init get_ramdisk_size(void)
 	return ramdisk_size;
 }
 
+#define MAX_MAP_CHUNK	(NR_FIX_BTMAPS << PAGE_SHIFT)
+
+static void __init copy_early_initrd(void *dest, phys_addr_t src,
+				     unsigned long size)
+{
+	unsigned long slop, clen;
+	char *p;
+
+	while (size) {
+		slop = offset_in_page(src);
+		clen = size;
+		if (clen > MAX_MAP_CHUNK - slop)
+			clen = MAX_MAP_CHUNK - slop;
+		/*
+		 * _ENC flag should be preserved so that when SME is enabled initrd
+		 * can be mapped as encrypted, as it had been encrypted earlier.
+		 * This flag won't impact on other platforms like TDX/SEV enabled.
+		 */
+		p = early_memremap_prot(src & PAGE_MASK, clen + slop,
+					pgprot_val(FIXMAP_PAGE_NORMAL));
+		memcpy(dest, p + slop, clen);
+		early_memunmap(p, clen + slop);
+		dest += clen;
+		src += clen;
+		size -= clen;
+	}
+}
+
 static void __init relocate_initrd(void)
 {
 	/* Assume only end is not page aligned */
@@ -279,7 +307,7 @@ static void __init relocate_initrd(void)
 	printk(KERN_INFO "Allocated new RAMDISK: [mem %#010llx-%#010llx]\n",
 	       relocated_ramdisk, relocated_ramdisk + ramdisk_size - 1);
 
-	copy_from_early_mem((void *)initrd_start, ramdisk_image, ramdisk_size);
+	copy_early_initrd((void *)initrd_start, ramdisk_image, ramdisk_size);
 
 	printk(KERN_INFO "Move RAMDISK from [mem %#010llx-%#010llx] to"
 		" [mem %#010llx-%#010llx]\n",
diff --git a/include/asm-generic/early_ioremap.h b/include/asm-generic/early_ioremap.h
index 9d0479f50f97..be1ce406f481 100644
--- a/include/asm-generic/early_ioremap.h
+++ b/include/asm-generic/early_ioremap.h
@@ -32,12 +32,6 @@ extern void early_ioremap_setup(void);
  */
 extern void early_ioremap_reset(void);
 
-/*
- * Early copy from unmapped memory to kernel mapped memory.
- */
-extern void copy_from_early_mem(void *dest, phys_addr_t src,
-				unsigned long size);
-
 #else
 static inline void early_ioremap_init(void) { }
 static inline void early_ioremap_setup(void) { }
diff --git a/mm/early_ioremap.c b/mm/early_ioremap.c
index 9bc12e526ed0..86b68d63ad35 100644
--- a/mm/early_ioremap.c
+++ b/mm/early_ioremap.c
@@ -245,27 +245,6 @@ early_memremap_prot(resource_size_t phys_addr, unsigned long size,
 }
 #endif
 
-#define MAX_MAP_CHUNK	(NR_FIX_BTMAPS << PAGE_SHIFT)
-
-void __init copy_from_early_mem(void *dest, phys_addr_t src, unsigned long size)
-{
-	unsigned long slop, clen;
-	char *p;
-
-	while (size) {
-		slop = offset_in_page(src);
-		clen = size;
-		if (clen > MAX_MAP_CHUNK - slop)
-			clen = MAX_MAP_CHUNK - slop;
-		p = early_memremap(src & PAGE_MASK, clen + slop);
-		memcpy(dest, p + slop, clen);
-		early_memunmap(p, clen + slop);
-		dest += clen;
-		src += clen;
-		size -= clen;
-	}
-}
-
 #else /* CONFIG_MMU */
 
 void __init __iomem *
-- 
2.27.0

