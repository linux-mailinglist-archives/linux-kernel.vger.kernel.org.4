Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02365648E15
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 11:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiLJKJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 05:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiLJKJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 05:09:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803D3205F9
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 02:09:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A2FE60A24
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 10:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D610AC433F0;
        Sat, 10 Dec 2022 10:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670666988;
        bh=5ghN9JW2HFtpVtwiWAlI7UySwVA3lyKrsQIFRBo/g8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iJ0pBgLJTq5BcrKXlsghFrcJv0XBGPXuSeLbIAYvi4wXGi06KeGKZqj7UecDjHLSU
         Jaw0wt3GoUQ29OWIobpCjxTM+aXOQwesa0QnvBfqG5gwF9b4W0kIW/HHsW+DEEB9rs
         +phKyCzJVYxUoMYfieAekbg/Lbs9xY5zttYMPrUHQxyrdPq26Dael08jIStJKKE1Sh
         SFwQYQGaJG/y8EHGaA/gZTG4h5j79CCuws7spiqSKNks63EYkzQMXfYezT0LH3dvSc
         NvU2OvGLsGiZvofWJaxvAJJebE9XLJdtz2cEZuqy7okQdKGUvbqn34XikhAZCSaCq7
         ZwB0hmfStFpag==
From:   guoren@kernel.org
To:     palmer@rivosinc.com, conor.Dooley@microchip.com, guoren@kernel.org,
        andy.chiu@sifive.com, greentime.hu@sifive.com,
        paul.walmsley@sifive.com, peterz@infradead.org,
        rostedt@goodmis.org, jrtc27@jrtc27.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH -next V2 2/2] riscv: jump_label: Using c.j for CONFIG_RISCV_ISA_C
Date:   Sat, 10 Dec 2022 05:09:27 -0500
Message-Id: <20221210100927.835145-3-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221210100927.835145-1-guoren@kernel.org>
References: <20221210100927.835145-1-guoren@kernel.org>
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
update problems. It would also reduce the range from 1MB to 4KB.
The range of 4K is enough for static branch.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Jessica Clarke <jrtc27@jrtc27.com>
---
 arch/riscv/include/asm/jump_label.h | 16 +++++++++++----
 arch/riscv/kernel/jump_label.c      | 30 +++++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/jump_label.h b/arch/riscv/include/asm/jump_label.h
index 729991e8f782..e5f772ad5887 100644
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
 
 static __always_inline bool arch_static_branch(struct static_key *key,
 					       bool branch)
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
@@ -40,11 +46,13 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key,
 						    bool branch)
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

