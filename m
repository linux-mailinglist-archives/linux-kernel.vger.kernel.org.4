Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E1773B8F3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbjFWNo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjFWNoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:44:17 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9FB2688;
        Fri, 23 Jun 2023 06:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1687527854; bh=f229IMk1VGwaw6gXKR4ZAc7KUbCMX+zZ6jBZnAgNAOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KmjEtvxfkVSF1PlCvSl4Seu/B50grA2znwPUjFrTHo5M3sdF9FjBxq3OzD8UPDI41
         Iw6z2D2z8ZMoWcgC0DhxoHy19Noq413ynpO4fSWSloGcJu5TOBaIoG9pbL1ZuIqcy0
         S3ErX7s1Ix2kijT0OvJ7e5NRZAI0CfudlqnSzbS8=
Received: from ld50.lan (unknown [101.88.25.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 85392605E8;
        Fri, 23 Jun 2023 21:44:13 +0800 (CST)
From:   WANG Xuerui <kernel@xen0n.name>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Rui <wangrui@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Subject: [PATCH 5/9] LoongArch: Make the CPUCFG and CSR ops simple aliases of compiler built-ins
Date:   Fri, 23 Jun 2023 21:43:47 +0800
Message-Id: <20230623134351.1898379-6-kernel@xen0n.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230623134351.1898379-1-kernel@xen0n.name>
References: <20230623134351.1898379-1-kernel@xen0n.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WANG Xuerui <git@xen0n.name>

In addition to less visual clutter, this also makes Clang happy
regarding the const-ness of arguments. In the original approach, all
Clang gets to see is the incoming arguments whose const-ness cannot be
proven without first being inlined; so Clang errors out here while GCC
is fine.

While at it, tweak several printk format strings because the return type
of csr_read64 becomes effectively unsigned long, instead of unsigned
long long,

Signed-off-by: WANG Xuerui <git@xen0n.name>
---
 arch/loongarch/include/asm/loongarch.h | 63 +++++---------------------
 arch/loongarch/kernel/traps.c          |  2 +-
 arch/loongarch/lib/dump_tlb.c          |  6 +--
 3 files changed, 15 insertions(+), 56 deletions(-)

diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index eedc313b5241..c2a6f698a3af 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -56,10 +56,7 @@ __asm__(".macro	parse_r var r\n\t"
 #undef _IFC_REG
 
 /* CPUCFG */
-static inline u32 read_cpucfg(u32 reg)
-{
-	return __cpucfg(reg);
-}
+#define read_cpucfg(reg) __cpucfg(reg)
 
 #endif /* !__ASSEMBLY__ */
 
@@ -207,56 +204,18 @@ static inline u32 read_cpucfg(u32 reg)
 #ifndef __ASSEMBLY__
 
 /* CSR */
-static __always_inline u32 csr_read32(u32 reg)
-{
-	return __csrrd_w(reg);
-}
-
-static __always_inline u64 csr_read64(u32 reg)
-{
-	return __csrrd_d(reg);
-}
-
-static __always_inline void csr_write32(u32 val, u32 reg)
-{
-	__csrwr_w(val, reg);
-}
-
-static __always_inline void csr_write64(u64 val, u32 reg)
-{
-	__csrwr_d(val, reg);
-}
-
-static __always_inline u32 csr_xchg32(u32 val, u32 mask, u32 reg)
-{
-	return __csrxchg_w(val, mask, reg);
-}
-
-static __always_inline u64 csr_xchg64(u64 val, u64 mask, u32 reg)
-{
-	return __csrxchg_d(val, mask, reg);
-}
+#define csr_read32(reg) __csrrd_w(reg)
+#define csr_read64(reg) __csrrd_d(reg)
+#define csr_write32(val, reg) __csrwr_w(val, reg)
+#define csr_write64(val, reg) __csrwr_d(val, reg)
+#define csr_xchg32(val, mask, reg) __csrxchg_w(val, mask, reg)
+#define csr_xchg64(val, mask, reg) __csrxchg_d(val, mask, reg)
 
 /* IOCSR */
-static __always_inline u32 iocsr_read32(u32 reg)
-{
-	return __iocsrrd_w(reg);
-}
-
-static __always_inline u64 iocsr_read64(u32 reg)
-{
-	return __iocsrrd_d(reg);
-}
-
-static __always_inline void iocsr_write32(u32 val, u32 reg)
-{
-	__iocsrwr_w(val, reg);
-}
-
-static __always_inline void iocsr_write64(u64 val, u32 reg)
-{
-	__iocsrwr_d(val, reg);
-}
+#define iocsr_read32(reg) __iocsrrd_w(reg)
+#define iocsr_read64(reg) __iocsrrd_d(reg)
+#define iocsr_write32(val, reg) __iocsrwr_w(val, reg)
+#define iocsr_write64(val, reg) __iocsrwr_d(val, reg)
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index 22179cf6f33c..8fb5e7a77145 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -999,7 +999,7 @@ asmlinkage void cache_parity_error(void)
 	/* For the moment, report the problem and hang. */
 	pr_err("Cache error exception:\n");
 	pr_err("csr_merrctl == %08x\n", csr_read32(LOONGARCH_CSR_MERRCTL));
-	pr_err("csr_merrera == %016llx\n", csr_read64(LOONGARCH_CSR_MERRERA));
+	pr_err("csr_merrera == %016lx\n", csr_read64(LOONGARCH_CSR_MERRERA));
 	panic("Can't handle the cache error!");
 }
 
diff --git a/arch/loongarch/lib/dump_tlb.c b/arch/loongarch/lib/dump_tlb.c
index c2cc7ce343c9..0b886a6e260f 100644
--- a/arch/loongarch/lib/dump_tlb.c
+++ b/arch/loongarch/lib/dump_tlb.c
@@ -20,9 +20,9 @@ void dump_tlb_regs(void)
 
 	pr_info("Index    : 0x%0x\n", read_csr_tlbidx());
 	pr_info("PageSize : 0x%0x\n", read_csr_pagesize());
-	pr_info("EntryHi  : 0x%0*llx\n", field, read_csr_entryhi());
-	pr_info("EntryLo0 : 0x%0*llx\n", field, read_csr_entrylo0());
-	pr_info("EntryLo1 : 0x%0*llx\n", field, read_csr_entrylo1());
+	pr_info("EntryHi  : 0x%0*lx\n", field, read_csr_entryhi());
+	pr_info("EntryLo0 : 0x%0*lx\n", field, read_csr_entrylo0());
+	pr_info("EntryLo1 : 0x%0*lx\n", field, read_csr_entrylo1());
 }
 
 static void dump_tlb(int first, int last)
-- 
2.40.0

