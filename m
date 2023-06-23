Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4635573B8F8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjFWNoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjFWNoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:44:19 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC882697;
        Fri, 23 Jun 2023 06:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1687527855; bh=IRnQjd+50zNSbl5gfok3N2S0Jg+9Z4fkKrrLulCYgAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jBYwNFvAZtvh5weJO87WvoPnD0vpgGxNBYxenSAK4gnQ9KmrG3BnzhhnkWqMKoKgb
         vb0Yqr0llRUyT+De4OoHeaQTyWD4tdaWBYRB+S3XVp7H/rgy17Rt2BnBhce+lGAiJv
         ksfdcKBmIXr/whec8cjaLK0fSsArdAEyhi0wdRzw=
Received: from ld50.lan (unknown [101.88.25.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id BEC90605EB;
        Fri, 23 Jun 2023 21:44:14 +0800 (CST)
From:   WANG Xuerui <kernel@xen0n.name>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Rui <wangrui@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Subject: [PATCH 6/9] LoongArch: Simplify the invtlb wrappers
Date:   Fri, 23 Jun 2023 21:43:48 +0800
Message-Id: <20230623134351.1898379-7-kernel@xen0n.name>
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

Of the 3 existing invtlb wrappers, invtlb_info is not used at all,
so it is removed; invtlb_all and invtlb_addr have their unused
argument(s) removed from their signatures.

Also, the invtlb instruction has been supported by upstream LoongArch
toolchains from day one, so ditch the raw opcode trickery and just use
plain inline asm for it.

Signed-off-by: WANG Xuerui <git@xen0n.name>
---
 arch/loongarch/include/asm/tlb.h | 45 ++++++++++++--------------------
 arch/loongarch/mm/tlb.c          | 10 +++----
 2 files changed, 21 insertions(+), 34 deletions(-)

diff --git a/arch/loongarch/include/asm/tlb.h b/arch/loongarch/include/asm/tlb.h
index 0dc9ee2b05d2..5e6ee9a15f0f 100644
--- a/arch/loongarch/include/asm/tlb.h
+++ b/arch/loongarch/include/asm/tlb.h
@@ -88,52 +88,39 @@ enum invtlb_ops {
 	INVTLB_GID_ADDR = 0x16,
 };
 
-/*
- * invtlb op info addr
- * (0x1 << 26) | (0x24 << 20) | (0x13 << 15) |
- * (addr << 10) | (info << 5) | op
- */
 static inline void invtlb(u32 op, u32 info, u64 addr)
 {
 	__asm__ __volatile__(
-		"parse_r addr,%0\n\t"
-		"parse_r info,%1\n\t"
-		".word ((0x6498000) | (addr << 10) | (info << 5) | %2)\n\t"
-		:
-		: "r"(addr), "r"(info), "i"(op)
-		:
-		);
-}
-
-static inline void invtlb_addr(u32 op, u32 info, u64 addr)
-{
-	__asm__ __volatile__(
-		"parse_r addr,%0\n\t"
-		".word ((0x6498000) | (addr << 10) | (0 << 5) | %1)\n\t"
-		:
-		: "r"(addr), "i"(op)
+		"invtlb %0, %1, %2\n\t"
 		:
+		: "i"(op), "r"(info), "r"(addr)
+		: "memory"
 		);
 }
 
-static inline void invtlb_info(u32 op, u32 info, u64 addr)
+static inline void invtlb_addr(u32 op, u64 addr)
 {
+	/*
+	 * The ISA manual says $zero shall be used in case a particular op
+	 * does not take the respective argument, hence the invtlb helper is
+	 * not re-used to make sure this is the case.
+	 */
 	__asm__ __volatile__(
-		"parse_r info,%0\n\t"
-		".word ((0x6498000) | (0 << 10) | (info << 5) | %1)\n\t"
-		:
-		: "r"(info), "i"(op)
+		"invtlb %0, $zero, %1\n\t"
 		:
+		: "i"(op), "r"(addr)
+		: "memory"
 		);
 }
 
-static inline void invtlb_all(u32 op, u32 info, u64 addr)
+static inline void invtlb_all(u32 op)
 {
+	/* Similar to invtlb_addr, ensure the operands are actually $zero. */
 	__asm__ __volatile__(
-		".word ((0x6498000) | (0 << 10) | (0 << 5) | %0)\n\t"
+		"invtlb %0, $zero, $zero\n\t"
 		:
 		: "i"(op)
-		:
+		: "memory"
 		);
 }
 
diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
index 00bb563e3c89..de04d2624ef4 100644
--- a/arch/loongarch/mm/tlb.c
+++ b/arch/loongarch/mm/tlb.c
@@ -17,19 +17,19 @@
 
 void local_flush_tlb_all(void)
 {
-	invtlb_all(INVTLB_CURRENT_ALL, 0, 0);
+	invtlb_all(INVTLB_CURRENT_ALL);
 }
 EXPORT_SYMBOL(local_flush_tlb_all);
 
 void local_flush_tlb_user(void)
 {
-	invtlb_all(INVTLB_CURRENT_GFALSE, 0, 0);
+	invtlb_all(INVTLB_CURRENT_GFALSE);
 }
 EXPORT_SYMBOL(local_flush_tlb_user);
 
 void local_flush_tlb_kernel(void)
 {
-	invtlb_all(INVTLB_CURRENT_GTRUE, 0, 0);
+	invtlb_all(INVTLB_CURRENT_GTRUE);
 }
 EXPORT_SYMBOL(local_flush_tlb_kernel);
 
@@ -100,7 +100,7 @@ void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
 		end &= (PAGE_MASK << 1);
 
 		while (start < end) {
-			invtlb_addr(INVTLB_ADDR_GTRUE_OR_ASID, 0, start);
+			invtlb_addr(INVTLB_ADDR_GTRUE_OR_ASID, start);
 			start += (PAGE_SIZE << 1);
 		}
 	} else {
@@ -131,7 +131,7 @@ void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
 void local_flush_tlb_one(unsigned long page)
 {
 	page &= (PAGE_MASK << 1);
-	invtlb_addr(INVTLB_ADDR_GTRUE_OR_ASID, 0, page);
+	invtlb_addr(INVTLB_ADDR_GTRUE_OR_ASID, page);
 }
 
 static void __update_hugetlb(struct vm_area_struct *vma, unsigned long address, pte_t *ptep)
-- 
2.40.0

