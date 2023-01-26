Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D8067D290
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjAZRGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjAZRGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:06:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B63FA6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:06:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B3AC61900
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 17:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2676C433EF;
        Thu, 26 Jan 2023 17:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674752786;
        bh=TJzRlX8qvgEiSePWc4rQnWbXyiOPKt8ROYEh5q9ZOX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z8vg+Tjd1ExZ+O8g5stUbVMTPL70WkZNIh5WTjGx/wNXUurHpYJxFyvedy0VT6PZU
         KcV4PrvbOaJlt6BlcQzOBXWZsuXOrqguvA4m8l5U2izzrtcVrE8TGpcMEwwclC1yT8
         e2mumldyttgfH48A1u0b+qIjOFpckm4UX9/es822Xv2A2xGVwv9x0LeewO8Wxi6Zn0
         9oMuis5wzFwJdMzmZJTaguSb0m/kGVhILRDnbbVE9fVdl6spkSxY0qT6ofzDdqRVfh
         cn4Yq4X2NFUAOAK4OAXwHcb1JZybzcYzrEvRq1JCgg379+9+kQU9/RGSaOnQI8mEz7
         M2ARWsvJzjJKQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        mhiramat@kernel.org, conor.dooley@microchip.com,
        penberg@kernel.org, mark.rutland@arm.com, jrtc27@jrtc27.com,
        andy.chiu@sifive.com, zong.li@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH -next V3 2/2] riscv: jump_label: Optimize the code size with compressed instruction
Date:   Thu, 26 Jan 2023 12:06:07 -0500
Message-Id: <20230126170607.1489141-3-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230126170607.1489141-1-guoren@kernel.org>
References: <20230126170607.1489141-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Reduce the size of the static branch instruction and prevent atomic
update problems when CONFIG_RISCV_ISA_C=y. It also reduces the jump
range from 1MB to 4KB, but 4KB is enough for the current riscv
requirement.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/jump_label.h | 16 +++++++++++----
 arch/riscv/kernel/jump_label.c      | 30 +++++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/jump_label.h b/arch/riscv/include/asm/jump_label.h
index 14a5ea8d8ef0..afc58c31d02b 100644
--- a/arch/riscv/include/asm/jump_label.h
+++ b/arch/riscv/include/asm/jump_label.h
@@ -12,17 +12,23 @@
 #include <linux/types.h>
 #include <asm/asm.h>
 
+#ifdef CONFIG_RISCV_ISA_C
+#define JUMP_LABEL_NOP_SIZE 2
+#else
 #define JUMP_LABEL_NOP_SIZE 4
+#endif
 
 static __always_inline bool arch_static_branch(struct static_key * const key,
 					       const bool branch)
 {
 	asm_volatile_goto(
-		"	.align		2			\n\t"
 		"	.option push				\n\t"
 		"	.option norelax				\n\t"
-		"	.option norvc				\n\t"
+#ifdef CONFIG_RISCV_ISA_C
+		"1:	c.nop					\n\t"
+#else
 		"1:	nop					\n\t"
+#endif
 		"	.option pop				\n\t"
 		"	.pushsection	__jump_table, \"aw\"	\n\t"
 		"	.align		" RISCV_LGPTR "		\n\t"
@@ -40,11 +46,13 @@ static __always_inline bool arch_static_branch_jump(struct static_key * const ke
 						    const bool branch)
 {
 	asm_volatile_goto(
-		"	.align		2			\n\t"
 		"	.option push				\n\t"
 		"	.option norelax				\n\t"
-		"	.option norvc				\n\t"
+#ifdef CONFIG_RISCV_ISA_C
+		"1:	c.j		%l[label]		\n\t"
+#else
 		"1:	jal		zero, %l[label]		\n\t"
+#endif
 		"	.option pop				\n\t"
 		"	.pushsection	__jump_table, \"aw\"	\n\t"
 		"	.align		" RISCV_LGPTR "		\n\t"
diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_label.c
index e6694759dbd0..08f42c49e3a0 100644
--- a/arch/riscv/kernel/jump_label.c
+++ b/arch/riscv/kernel/jump_label.c
@@ -11,26 +11,52 @@
 #include <asm/bug.h>
 #include <asm/patch.h>
 
+#ifdef CONFIG_RISCV_ISA_C
+#define RISCV_INSN_NOP 0x0001U
+#define RISCV_INSN_C_J 0xa001U
+#else
 #define RISCV_INSN_NOP 0x00000013U
 #define RISCV_INSN_JAL 0x0000006fU
+#endif
 
 void arch_jump_label_transform(struct jump_entry *entry,
 			       enum jump_label_type type)
 {
 	void *addr = (void *)jump_entry_code(entry);
+#ifdef CONFIG_RISCV_ISA_C
+	u16 insn;
+#else
 	u32 insn;
+#endif
 
 	if (type == JUMP_LABEL_JMP) {
 		long offset = jump_entry_target(entry) - jump_entry_code(entry);
-
-		if (WARN_ON(offset & 1 || offset < -524288 || offset >= 524288))
+		if (WARN_ON(offset & 1 || offset < -2048 || offset >= 2048))
 			return;
 
+#ifdef CONFIG_RISCV_ISA_C
+		/*
+		 * 001 | imm[11|4|9:8|10|6|7|3:1|5] 01 - C.J
+		 */
+		insn = RISCV_INSN_C_J |
+			(((u16)offset & GENMASK(5, 5)) >> (5 - 2)) |
+			(((u16)offset & GENMASK(3, 1)) << (3 - 1)) |
+			(((u16)offset & GENMASK(7, 7)) >> (7 - 6)) |
+			(((u16)offset & GENMASK(6, 6)) << (7 - 6)) |
+			(((u16)offset & GENMASK(10, 10)) >> (10 - 8)) |
+			(((u16)offset & GENMASK(9, 8)) << (9 - 8)) |
+			(((u16)offset & GENMASK(4, 4)) << (11 - 4)) |
+			(((u16)offset & GENMASK(11, 11)) << (12 - 11));
+#else
+		/*
+		 * imm[20|10:1|11|19:12] | rd | 1101111 - JAL
+		 */
 		insn = RISCV_INSN_JAL |
 			(((u32)offset & GENMASK(19, 12)) << (12 - 12)) |
 			(((u32)offset & GENMASK(11, 11)) << (20 - 11)) |
 			(((u32)offset & GENMASK(10,  1)) << (21 -  1)) |
 			(((u32)offset & GENMASK(20, 20)) << (31 - 20));
+#endif
 	} else {
 		insn = RISCV_INSN_NOP;
 	}
-- 
2.36.1

