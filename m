Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF076FDA80
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 11:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbjEJJQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 05:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjEJJQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 05:16:53 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A545CBF;
        Wed, 10 May 2023 02:16:48 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxW+r_YFtkWk4HAA--.12277S3;
        Wed, 10 May 2023 17:16:47 +0800 (CST)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxKL3+YFtk7N5TAA--.18920S2;
        Wed, 10 May 2023 17:16:47 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        WANG Xuerui <kernel@xen0n.name>,
        Zhangjin Wu <falcon@tinylab.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
Subject: [PATCH v2] LoongArch: Add jump-label implementation
Date:   Wed, 10 May 2023 17:16:46 +0800
Message-Id: <1683710206-23905-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8BxKL3+YFtk7N5TAA--.18920S2
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxGF1rZw4fAFW7Jry7Cr18uFg_yoW7Jry7pr
        17Aws5GF4kGF1fJrZ8tryDur45Xan5Ga12gF13tFy8AF9rX34vvrn2kryDZF1DJ397GrWI
        gF1ruFsIva1UJ3JanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E
        87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxV
        Aaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxY
        O2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4U
        YxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add jump-label implementation based on the ARM64 version.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
Changes in v2:
- Fix build errors.
- fix comment.

 .../core/jump-labels/arch-support.txt         |  2 +-
 arch/loongarch/Kconfig                        |  2 +
 arch/loongarch/configs/loongson3_defconfig    |  1 +
 arch/loongarch/include/asm/jump_label.h       | 51 +++++++++++++++++++
 arch/loongarch/kernel/Makefile                |  2 +
 arch/loongarch/kernel/jump_label.c            | 23 +++++++++
 6 files changed, 80 insertions(+), 1 deletion(-)
 create mode 100644 arch/loongarch/include/asm/jump_label.h
 create mode 100644 arch/loongarch/kernel/jump_label.c

diff --git a/Documentation/features/core/jump-labels/arch-support.txt b/Documentation/features/core/jump-labels/arch-support.txt
index 2328eada3a49..94d9dece580f 100644
--- a/Documentation/features/core/jump-labels/arch-support.txt
+++ b/Documentation/features/core/jump-labels/arch-support.txt
@@ -13,7 +13,7 @@
     |        csky: |  ok  |
     |     hexagon: | TODO |
     |        ia64: | TODO |
-    |   loongarch: | TODO |
+    |   loongarch: |  ok  |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index d38b066fc931..193a959a5611 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -83,6 +83,8 @@ config LOONGARCH
 	select GPIOLIB
 	select HAS_IOPORT
 	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_JUMP_LABEL
+	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index 6cd26dd3c134..33a0f5f742f6 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -63,6 +63,7 @@ CONFIG_EFI_ZBOOT=y
 CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
 CONFIG_EFI_CAPSULE_LOADER=m
 CONFIG_EFI_TEST=m
+CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_FORCE_LOAD=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/loongarch/include/asm/jump_label.h b/arch/loongarch/include/asm/jump_label.h
new file mode 100644
index 000000000000..2f9fdec256c5
--- /dev/null
+++ b/arch/loongarch/include/asm/jump_label.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 Loongson Technology Corporation Limited
+ *
+ * Based on arch/arm64/include/asm/jump_label.h
+ */
+#ifndef __ASM_JUMP_LABEL_H
+#define __ASM_JUMP_LABEL_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+
+#define JUMP_LABEL_NOP_SIZE	4
+
+static __always_inline bool arch_static_branch(struct static_key * const key,
+					       const bool branch)
+{
+	asm_volatile_goto(
+		"1:	nop					\n\t"
+		 "	.pushsection	__jump_table, \"aw\"	\n\t"
+		 "	.align		3			\n\t"
+		 "	.long		1b - ., %l[l_yes] - .	\n\t"
+		 "	.quad		%0 - .			\n\t"
+		 "	.popsection				\n\t"
+		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
+
+	return false;
+l_yes:
+	return true;
+}
+
+static __always_inline bool arch_static_branch_jump(struct static_key * const key,
+						    const bool branch)
+{
+	asm_volatile_goto(
+		"1:	b		%l[l_yes]		\n\t"
+		 "	.pushsection	__jump_table, \"aw\"	\n\t"
+		 "	.align		3			\n\t"
+		 "	.long		1b - ., %l[l_yes] - .	\n\t"
+		 "	.quad		%0 - .			\n\t"
+		 "	.popsection				\n\t"
+		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
+
+	return false;
+l_yes:
+	return true;
+}
+
+#endif  /* __ASSEMBLY__ */
+#endif	/* __ASM_JUMP_LABEL_H */
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index 9a72d91cd104..64ea76f60e2c 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -54,4 +54,6 @@ obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 
 obj-$(CONFIG_KPROBES)		+= kprobes.o kprobes_trampoline.o
 
+obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
+
 CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS)
diff --git a/arch/loongarch/kernel/jump_label.c b/arch/loongarch/kernel/jump_label.c
new file mode 100644
index 000000000000..b06245955f7a
--- /dev/null
+++ b/arch/loongarch/kernel/jump_label.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Loongson Technology Corporation Limited
+ *
+ * Based on arch/arm64/kernel/jump_label.c
+ */
+#include <linux/jump_label.h>
+#include <linux/kernel.h>
+#include <asm/inst.h>
+
+void arch_jump_label_transform(struct jump_entry *entry,
+			       enum jump_label_type type)
+{
+	void *addr = (void *)jump_entry_code(entry);
+	u32 insn;
+
+	if (type == JUMP_LABEL_JMP)
+		insn = larch_insn_gen_b(jump_entry_code(entry), jump_entry_target(entry));
+	else
+		insn = larch_insn_gen_nop();
+
+	larch_insn_patch_text(addr, insn);
+}
-- 
2.37.1

