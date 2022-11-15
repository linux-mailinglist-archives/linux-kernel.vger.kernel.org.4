Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C8862903B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 03:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237790AbiKOC5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 21:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbiKOC45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 21:56:57 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B151E1EC56
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:55:35 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Axz7ek_3Jjex8HAA--.16482S3;
        Tue, 15 Nov 2022 10:55:32 +0800 (CST)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxLuKf_3JjmywTAA--.51398S7;
        Tue, 15 Nov 2022 10:55:31 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jinyang He <hejinyang@loongson.cn>
Subject: [PATCH v6 5/9] LoongArch/ftrace: Add DYNAMIC_FTRACE_WITH_REGS support
Date:   Tue, 15 Nov 2022 10:55:23 +0800
Message-Id: <20221115025527.13382-6-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221115025527.13382-1-zhangqing@loongson.cn>
References: <20221115025527.13382-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxLuKf_3JjmywTAA--.51398S7
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxCF43Gry5Zr1ktr17XFWUJwb_yoWrWw1Dpr
        97Arn5GFWj9FsagrWfK3s5Wrs8JrWvg34ava9rAFyrGr4qqF15Z3y8Cr1DZFyIq3yxG3yx
        XF1fCr4Yya17XwUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b3AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2Iq
        xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
        126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY
        6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
        AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
        vjxU4AhLUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements DYNAMIC_FTRACE_WITH_REGS on LoongArch, which allows
a traced function's arguments (and some other registers) to be captured
into a struct pt_regs, allowing these to be inspected and modified.

Co-developed-by: Jinyang He <hejinyang@loongson.cn>
Signed-off-by: Jinyang He <hejinyang@loongson.cn>
Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 arch/loongarch/Kconfig              |  1 +
 arch/loongarch/include/asm/ftrace.h |  3 +++
 arch/loongarch/kernel/ftrace_dyn.c  | 17 ++++++++++++++
 arch/loongarch/kernel/mcount-dyn.S  | 36 +++++++++++++++++++++++++++--
 4 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 615ce62422b8..12e3e91a68ae 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -90,6 +90,7 @@ config LOONGARCH
 	select HAVE_DEBUG_STACKOVERFLOW
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
+	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EBPF_JIT
 	select HAVE_EXIT_THREAD
 	select HAVE_FAST_GUP
diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
index 76ca58767f4d..a3f974a7a5ce 100644
--- a/arch/loongarch/include/asm/ftrace.h
+++ b/arch/loongarch/include/asm/ftrace.h
@@ -28,6 +28,9 @@ struct dyn_ftrace;
 int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
 #define ftrace_init_nop ftrace_init_nop
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#define ARCH_SUPPORTS_FTRACE_OPS 1
+#endif
 #endif /* CONFIG_DYNAMIC_FTRACE */
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_FUNCTION_TRACER */
diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
index 3fe791b6783e..ec3d951be50c 100644
--- a/arch/loongarch/kernel/ftrace_dyn.c
+++ b/arch/loongarch/kernel/ftrace_dyn.c
@@ -99,6 +99,23 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 	return ftrace_modify_code(pc, old, new, true);
 }
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
+			unsigned long addr)
+{
+	unsigned long pc;
+	long offset;
+	u32 old, new;
+
+	pc = rec->ip + LOONGARCH_INSN_SIZE;
+
+	old = larch_insn_gen_bl(pc, old_addr);
+	new = larch_insn_gen_bl(pc, addr);
+
+	return ftrace_modify_code(pc, old, new, true);
+}
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+
 void arch_ftrace_update_code(int command)
 {
 	command |= FTRACE_MAY_SLEEP;
diff --git a/arch/loongarch/kernel/mcount-dyn.S b/arch/loongarch/kernel/mcount-dyn.S
index 0c12cc108e6f..02835186b463 100644
--- a/arch/loongarch/kernel/mcount-dyn.S
+++ b/arch/loongarch/kernel/mcount-dyn.S
@@ -27,7 +27,7 @@
  * follows the LoongArch psABI well.
  */
 
-	.macro  ftrace_regs_entry
+	.macro  ftrace_regs_entry allregs=0
 	PTR_ADDI sp, sp, -PT_SIZE
 	/* Save trace function ra at PT_ERA */
 	PTR_S	ra, sp, PT_ERA
@@ -43,16 +43,48 @@
 	PTR_S	a7, sp, PT_R11
 	PTR_S	fp, sp, PT_R22
 
+	.if \allregs
+	PTR_S	t0, sp, PT_R12
+	PTR_S	t1, sp, PT_R13
+	PTR_S	t2, sp, PT_R14
+	PTR_S	t3, sp, PT_R15
+	PTR_S	t4, sp, PT_R16
+	PTR_S	t5, sp, PT_R17
+	PTR_S	t6, sp, PT_R18
+	PTR_S	t7, sp, PT_R19
+	PTR_S	t8, sp, PT_R20
+	PTR_S	s0, sp, PT_R23
+	PTR_S	s1, sp, PT_R24
+	PTR_S	s2, sp, PT_R25
+	PTR_S	s3, sp, PT_R26
+	PTR_S	s4, sp, PT_R27
+	PTR_S	s5, sp, PT_R28
+	PTR_S	s6, sp, PT_R29
+	PTR_S	s7, sp, PT_R30
+	PTR_S	s8, sp, PT_R31
+	PTR_S	tp, sp, PT_R2
+	/* Clear it for later use as a flag sometimes. */
+	PTR_S	zero, sp, PT_R0
+	PTR_S	$r21, sp, PT_R21
+	.endif
+
 	PTR_ADDI t8, sp, PT_SIZE
 	PTR_S   t8, sp, PT_R3
 
 	.endm
 
 SYM_CODE_START(ftrace_caller)
-	ftrace_regs_entry
+	ftrace_regs_entry allregs=0
 	b	ftrace_common
 SYM_CODE_END(ftrace_caller)
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+SYM_CODE_START(ftrace_regs_caller)
+	ftrace_regs_entry allregs=1
+	b	ftrace_common
+SYM_CODE_END(ftrace_regs_caller)
+#endif
+
 SYM_CODE_START(ftrace_common)
 	PTR_ADDI	a0, ra, -8	/* arg0: ip */
 	move		a1, t0		/* arg1: parent_ip */
-- 
2.36.0

