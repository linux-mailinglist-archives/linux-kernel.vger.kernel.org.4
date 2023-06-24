Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F3D73CC71
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 20:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbjFXSmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 14:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbjFXSmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 14:42:46 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB922736;
        Sat, 24 Jun 2023 11:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1687632117; bh=cx5Lu/G2tw/bbfykj8m6/Hs/WOmB+fLUfJpSp6qrCjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nLHaBtIPDZ8YeXtguxGys+9gJj+vFo/X2qM6lCoKw4/Tb9d56uBxlJOczJ+kgXyFL
         SQJw86wQ890A3xRmMKOgaa6XMfp4zssdBDLTDlTVL/ErToe9N467kG6W7UH7VRttsy
         8eAWG//3w3Gjy+LnrZjFrVL4CdmdkQLPSC0Rkc/o=
Received: from ld50.lan (unknown [101.88.25.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id DB27E6015B;
        Sun, 25 Jun 2023 02:41:56 +0800 (CST)
From:   WANG Xuerui <kernel@xen0n.name>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Rui <wangrui@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Subject: [PATCH v2 5/9] LoongArch: Simplify the invtlb wrappers
Date:   Sun, 25 Jun 2023 02:40:51 +0800
Message-Id: <20230624184055.3000636-6-kernel@xen0n.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230624184055.3000636-1-kernel@xen0n.name>
References: <20230624184055.3000636-1-kernel@xen0n.name>
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

The invtlb instruction has been supported by upstream LoongArch
toolchains from day one, so ditch the raw opcode trickery and just use
plain inline asm for it.

While at it, also make the invtlb asm statements barriers, for proper
modeling of the side effects.

The signature of the other more specific invtlb wrappers contain unused
arguments right now, but these are not removed right away in order for
the patch to be focused. In the meantime, assertions are added to ensure
no accidental misuse happens before the refactor. (The more specific
wrappers cannot re-use the generic invtlb wrapper, because the ISA
manual says $zero shall be used in case a particular op does not take
the respective argument: re-using the generic wrapper would mean losing
control over the register usage.)

Signed-off-by: WANG Xuerui <git@xen0n.name>
---
 arch/loongarch/include/asm/tlb.h | 39 ++++++++++++++++----------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/loongarch/include/asm/tlb.h b/arch/loongarch/include/asm/tlb.h
index 0dc9ee2b05d2..15750900540c 100644
--- a/arch/loongarch/include/asm/tlb.h
+++ b/arch/loongarch/include/asm/tlb.h
@@ -88,52 +88,51 @@ enum invtlb_ops {
 	INVTLB_GID_ADDR = 0x16,
 };
 
-/*
- * invtlb op info addr
- * (0x1 << 26) | (0x24 << 20) | (0x13 << 15) |
- * (addr << 10) | (info << 5) | op
- */
 static inline void invtlb(u32 op, u32 info, u64 addr)
 {
+	BUILD_BUG_ON(!__builtin_constant_p(op));
 	__asm__ __volatile__(
-		"parse_r addr,%0\n\t"
-		"parse_r info,%1\n\t"
-		".word ((0x6498000) | (addr << 10) | (info << 5) | %2)\n\t"
-		:
-		: "r"(addr), "r"(info), "i"(op)
+		"invtlb %0, %1, %2\n\t"
 		:
+		: "i"(op), "r"(info), "r"(addr)
+		: "memory"
 		);
 }
 
 static inline void invtlb_addr(u32 op, u32 info, u64 addr)
 {
+	BUILD_BUG_ON(!__builtin_constant_p(op));
+	BUILD_BUG_ON(!__builtin_constant_p(info) || info != 0);
 	__asm__ __volatile__(
-		"parse_r addr,%0\n\t"
-		".word ((0x6498000) | (addr << 10) | (0 << 5) | %1)\n\t"
-		:
-		: "r"(addr), "i"(op)
+		"invtlb %0, $zero, %1\n\t"
 		:
+		: "i"(op), "r"(addr)
+		: "memory"
 		);
 }
 
 static inline void invtlb_info(u32 op, u32 info, u64 addr)
 {
+	BUILD_BUG_ON(!__builtin_constant_p(op));
+	BUILD_BUG_ON(!__builtin_constant_p(addr) || addr != 0);
 	__asm__ __volatile__(
-		"parse_r info,%0\n\t"
-		".word ((0x6498000) | (0 << 10) | (info << 5) | %1)\n\t"
-		:
-		: "r"(info), "i"(op)
+		"invtlb %0, %1, $zero\n\t"
 		:
+		: "i"(op), "r"(info)
+		: "memory"
 		);
 }
 
 static inline void invtlb_all(u32 op, u32 info, u64 addr)
 {
+	BUILD_BUG_ON(!__builtin_constant_p(op));
+	BUILD_BUG_ON(!__builtin_constant_p(info) || info != 0);
+	BUILD_BUG_ON(!__builtin_constant_p(addr) || addr != 0);
 	__asm__ __volatile__(
-		".word ((0x6498000) | (0 << 10) | (0 << 5) | %0)\n\t"
+		"invtlb %0, $zero, $zero\n\t"
 		:
 		: "i"(op)
-		:
+		: "memory"
 		);
 }
 
-- 
2.40.0

