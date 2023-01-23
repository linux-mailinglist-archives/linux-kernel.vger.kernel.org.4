Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A34E677CE8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjAWNrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjAWNqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:46:44 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47DC62686B;
        Mon, 23 Jan 2023 05:46:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD9EE1691;
        Mon, 23 Jan 2023 05:47:14 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 18DF13F64C;
        Mon, 23 Jan 2023 05:46:30 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mhiramat@kernel.org, ndesaulniers@google.com,
        ojeda@kernel.org, peterz@infradead.org, rafael.j.wysocki@intel.com,
        revest@chromium.org, robert.moore@intel.com, rostedt@goodmis.org,
        will@kernel.org
Subject: [PATCH v3 8/8] arm64: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
Date:   Mon, 23 Jan 2023 13:46:03 +0000
Message-Id: <20230123134603.1064407-9-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230123134603.1064407-1-mark.rutland@arm.com>
References: <20230123134603.1064407-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables support for DYNAMIC_FTRACE_WITH_CALL_OPS on arm64.
This allows each ftrace callsite to provide an ftrace_ops to the common
ftrace trampoline, allowing each callsite to invoke distinct tracer
functions without the need to fall back to list processing or to
allocate custom trampolines for each callsite. This significantly speeds
up cases where multiple distinct trace functions are used and callsites
are mostly traced by a single tracer.

The main idea is to place a pointer to the ftrace_ops as a literal at a
fixed offset from the function entry point, which can be recovered by
the common ftrace trampoline. Using a 64-bit literal avoids branch range
limitations, and permits the ops to be swapped atomically without
special considerations that apply to code-patching. In future this will
also allow for the implementation of DYNAMIC_FTRACE_WITH_DIRECT_CALLS
without branch range limitations by using additional fields in struct
ftrace_ops.

As noted in the core patch adding support for
DYNAMIC_FTRACE_WITH_CALL_OPS, this approach allows for directly invoking
ftrace_ops::func even for ftrace_ops which are dynamically-allocated (or
part of a module), without going via ftrace_ops_list_func.

Currently, this approach is not compatible with CLANG_CFI, as the
presence/absence of pre-function NOPs changes the offset of the
pre-function type hash, and there's no existing mechanism to ensure a
consistent offset for instrumented and uninstrumented functions. When
CLANG_CFI is enabled, the existing scheme with a global ops->func
pointer is used, and there should be no functional change. I am
currently working with others to allow the two to work together in
future (though this will liekly require updated compiler support).

I've benchamrked this with the ftrace_ops sample module [1], which is
not currently upstream, but available at:

  https://lore.kernel.org/lkml/20230103124912.2948963-1-mark.rutland@arm.com
  git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git ftrace-ops-sample-20230109

Using that module I measured the total time taken for 100,000 calls to a
trivial instrumented function, with a number of tracers enabled with
relevant filters (which would apply to the instrumented function) and a
number of tracers enabled with irrelevant filters (which would not apply
to the instrumented function). I tested on an M1 MacBook Pro, running
under a HVF-accelerated QEMU VM (i.e. on real hardware).

Before this patch:

  Number of tracers     || Total time  | Per-call average time (ns)
  Relevant | Irrelevant || (ns)        | Total        | Overhead
  =========+============++=============+==============+============
         0 |          0 ||      94,583 |         0.95 |           -
         0 |          1 ||      93,709 |         0.94 |           -
         0 |          2 ||      93,666 |         0.94 |           -
         0 |         10 ||      93,709 |         0.94 |           -
         0 |        100 ||      93,792 |         0.94 |           -
  ---------+------------++-------------+--------------+------------
         1 |          1 ||   6,467,833 |        64.68 |       63.73
         1 |          2 ||   7,509,708 |        75.10 |       74.15
         1 |         10 ||  23,786,792 |       237.87 |      236.92
         1 |        100 || 106,432,500 |     1,064.43 |     1063.38
  ---------+------------++-------------+--------------+------------
         1 |          0 ||   1,431,875 |        14.32 |       13.37
         2 |          0 ||   6,456,334 |        64.56 |       63.62
        10 |          0 ||  22,717,000 |       227.17 |      226.22
       100 |          0 || 103,293,667 |      1032.94 |     1031.99
  ---------+------------++-------------+--------------+--------------

  Note: per-call overhead is estimated relative to the baseline case
  with 0 relevant tracers and 0 irrelevant tracers.

After this patch

  Number of tracers     || Total time  | Per-call average time (ns)
  Relevant | Irrelevant || (ns)        | Total        | Overhead
  =========+============++=============+==============+============
         0 |          0 ||      94,541 |         0.95 |           -
         0 |          1 ||      93,666 |         0.94 |           -
         0 |          2 ||      93,709 |         0.94 |           -
         0 |         10 ||      93,667 |         0.94 |           -
         0 |        100 ||      93,792 |         0.94 |           -
  ---------+------------++-------------+--------------+------------
         1 |          1 ||     281,000 |         2.81 |        1.86
         1 |          2 ||     281,042 |         2.81 |        1.87
         1 |         10 ||     280,958 |         2.81 |        1.86
         1 |        100 ||     281,250 |         2.81 |        1.87
  ---------+------------++-------------+--------------+------------
         1 |          0 ||     280,959 |         2.81 |        1.86
         2 |          0 ||   6,502,708 |        65.03 |       64.08
        10 |          0 ||  18,681,209 |       186.81 |      185.87
       100 |          0 || 103,550,458 |     1,035.50 |     1034.56
  ---------+------------++-------------+--------------+------------

  Note: per-call overhead is estimated relative to the baseline case
  with 0 relevant tracers and 0 irrelevant tracers.

As can be seen from the above:

a) Whenever there is a single relevant tracer function associated with a
   tracee, the overhead of invoking the tracer is constant, and does not
   scale with the number of tracers which are *not* associated with that
   tracee.

b) The overhead for a single relevant tracer has dropped to ~1/7 of the
   overhead prior to this series (from 13.37ns to 1.86ns). This is
   largely due to permitting calls to dynamically-allocated ftrace_ops
   without going through ftrace_ops_list_func.

I've run the ftrace selftests from v6.2-rc3, which reports:

| # of passed:  110
| # of failed:  0
| # of unresolved:  3
| # of untested:  0
| # of unsupported:  0
| # of xfailed:  1
| # of undefined(test bug):  0

... where the unresolved entries were the tests for DIRECT functions
(which are not supported), and the checkbashisms selftest (which is
irrelevant here):

| [8] Test ftrace direct functions against tracers        [UNRESOLVED]
| [9] Test ftrace direct functions against kprobes        [UNRESOLVED]
| [62] Meta-selftest: Checkbashisms       [UNRESOLVED]

... with all other tests passing (or failing as expected).

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Florent Revest <revest@chromium.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/Kconfig               |   3 +
 arch/arm64/Makefile              |   5 +-
 arch/arm64/include/asm/ftrace.h  |  15 +--
 arch/arm64/kernel/asm-offsets.c  |   4 +
 arch/arm64/kernel/entry-ftrace.S |  32 ++++++-
 arch/arm64/kernel/ftrace.c       | 156 +++++++++++++++++++++++++++++++
 6 files changed, 195 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6914f6bf41e2..6f6f37161cf6 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -124,6 +124,7 @@ config ARM64
 	select EDAC_SUPPORT
 	select FRAME_POINTER
 	select FUNCTION_ALIGNMENT_4B
+	select FUNCTION_ALIGNMENT_8B if DYNAMIC_FTRACE_WITH_CALL_OPS
 	select GENERIC_ALLOCATOR
 	select GENERIC_ARCH_TOPOLOGY
 	select GENERIC_CLOCKEVENTS_BROADCAST
@@ -187,6 +188,8 @@ config ARM64
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS \
 		if $(cc-option,-fpatchable-function-entry=2)
+	select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS \
+		if (DYNAMIC_FTRACE_WITH_ARGS && !CFI_CLANG)
 	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY \
 		if DYNAMIC_FTRACE_WITH_ARGS
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index d62bd221828f..4c3be442fbb3 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -139,7 +139,10 @@ endif
 
 CHECKFLAGS	+= -D__aarch64__
 
-ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_ARGS),y)
+ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS),y)
+  KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
+  CC_FLAGS_FTRACE := -fpatchable-function-entry=4,2
+else ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_ARGS),y)
   KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
   CC_FLAGS_FTRACE := -fpatchable-function-entry=2
 endif
diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 5664729800ae..1c2672bbbf37 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -62,20 +62,7 @@ extern unsigned long ftrace_graph_call;
 
 extern void return_to_handler(void);
 
-static inline unsigned long ftrace_call_adjust(unsigned long addr)
-{
-	/*
-	 * Adjust addr to point at the BL in the callsite.
-	 * See ftrace_init_nop() for the callsite sequence.
-	 */
-	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_ARGS))
-		return addr + AARCH64_INSN_SIZE;
-	/*
-	 * addr is the address of the mcount call instruction.
-	 * recordmcount does the necessary offset calculation.
-	 */
-	return addr;
-}
+unsigned long ftrace_call_adjust(unsigned long addr);
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
 struct dyn_ftrace;
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 2234624536d9..ae345b06e9f7 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -9,6 +9,7 @@
 
 #include <linux/arm_sdei.h>
 #include <linux/sched.h>
+#include <linux/ftrace.h>
 #include <linux/kexec.h>
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
@@ -193,6 +194,9 @@ int main(void)
   DEFINE(KIMAGE_HEAD,			offsetof(struct kimage, head));
   DEFINE(KIMAGE_START,			offsetof(struct kimage, start));
   BLANK();
+#endif
+#ifdef CONFIG_FUNCTION_TRACER
+  DEFINE(FTRACE_OPS_FUNC,		offsetof(struct ftrace_ops, func));
 #endif
   return 0;
 }
diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index 3b625f76ffba..350ed81324ac 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -65,13 +65,35 @@ SYM_CODE_START(ftrace_caller)
 	stp	x29, x30, [sp, #FREGS_SIZE]
 	add	x29, sp, #FREGS_SIZE
 
-	sub	x0, x30, #AARCH64_INSN_SIZE	// ip (callsite's BL insn)
-	mov	x1, x9				// parent_ip (callsite's LR)
-	ldr_l	x2, function_trace_op		// op
-	mov	x3, sp				// regs
+	/* Prepare arguments for the the tracer func */
+	sub	x0, x30, #AARCH64_INSN_SIZE		// ip (callsite's BL insn)
+	mov	x1, x9					// parent_ip (callsite's LR)
+	mov	x3, sp					// regs
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
+	/*
+	 * The literal pointer to the ops is at an 8-byte aligned boundary
+	 * which is either 12 or 16 bytes before the BL instruction in the call
+	 * site. See ftrace_call_adjust() for details.
+	 *
+	 * Therefore here the LR points at `literal + 16` or `literal + 20`,
+	 * and we can find the address of the literal in either case by
+	 * aligning to an 8-byte boundary and subtracting 16. We do the
+	 * alignment first as this allows us to fold the subtraction into the
+	 * LDR.
+	 */
+	bic	x2, x30, 0x7
+	ldr	x2, [x2, #-16]				// op
+
+	ldr	x4, [x2, #FTRACE_OPS_FUNC]		// op->func
+	blr	x4					// op->func(ip, parent_ip, op, regs)
+
+#else
+	ldr_l   x2, function_trace_op			// op
 
 SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
-	bl	ftrace_stub
+	bl      ftrace_stub				// func(ip, parent_ip, op, regs)
+#endif
 
 /*
  * At the callsite x0-x8 and x19-x30 were live. Any C code will have preserved
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 38ebdf063255..5545fe1a9012 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -60,6 +60,89 @@ int ftrace_regs_query_register_offset(const char *name)
 }
 #endif
 
+unsigned long ftrace_call_adjust(unsigned long addr)
+{
+	/*
+	 * When using mcount, addr is the address of the mcount call
+	 * instruction, and no adjustment is necessary.
+	 */
+	if (!IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_ARGS))
+		return addr;
+
+	/*
+	 * When using patchable-function-entry without pre-function NOPS, addr
+	 * is the address of the first NOP after the function entry point.
+	 *
+	 * The compiler has either generated:
+	 *
+	 * addr+00:	func:	NOP		// To be patched to MOV X9, LR
+	 * addr+04:		NOP		// To be patched to BL <caller>
+	 *
+	 * Or:
+	 *
+	 * addr-04:		BTI	C
+	 * addr+00:	func:	NOP		// To be patched to MOV X9, LR
+	 * addr+04:		NOP		// To be patched to BL <caller>
+	 *
+	 * We must adjust addr to the address of the NOP which will be patched
+	 * to `BL <caller>`, which is at `addr + 4` bytes in either case.
+	 *
+	 */
+	if (!IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
+		return addr + AARCH64_INSN_SIZE;
+
+	/*
+	 * When using patchable-function-entry with pre-function NOPs, addr is
+	 * the address of the first pre-function NOP.
+	 *
+	 * Starting from an 8-byte aligned base, the compiler has either
+	 * generated:
+	 *
+	 * addr+00:		NOP		// Literal (first 32 bits)
+	 * addr+04:		NOP		// Literal (last 32 bits)
+	 * addr+08:	func:	NOP		// To be patched to MOV X9, LR
+	 * addr+12:		NOP		// To be patched to BL <caller>
+	 *
+	 * Or:
+	 *
+	 * addr+00:		NOP		// Literal (first 32 bits)
+	 * addr+04:		NOP		// Literal (last 32 bits)
+	 * addr+08:	func:	BTI	C
+	 * addr+12:		NOP		// To be patched to MOV X9, LR
+	 * addr+16:		NOP		// To be patched to BL <caller>
+	 *
+	 * We must adjust addr to the address of the NOP which will be patched
+	 * to `BL <caller>`, which is at either addr+12 or addr+16 depending on
+	 * whether there is a BTI.
+	 */
+
+	if (!IS_ALIGNED(addr, sizeof(unsigned long))) {
+		WARN_RATELIMIT(1, "Misaligned patch-site %pS\n",
+			       (void *)(addr + 8));
+		return 0;
+	}
+
+	/* Skip the NOPs placed before the function entry point */
+	addr += 2 * AARCH64_INSN_SIZE;
+
+	/* Skip any BTI */
+	if (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL)) {
+		u32 insn = le32_to_cpu(*(__le32 *)addr);
+
+		if (aarch64_insn_is_bti(insn)) {
+			addr += AARCH64_INSN_SIZE;
+		} else if (insn != aarch64_insn_gen_nop()) {
+			WARN_RATELIMIT(1, "unexpected insn in patch-site %pS: 0x%08x\n",
+				       (void *)addr, insn);
+		}
+	}
+
+	/* Skip the first NOP after function entry */
+	addr += AARCH64_INSN_SIZE;
+
+	return addr;
+}
+
 /*
  * Replace a single instruction, which may be a branch or NOP.
  * If @validate == true, a replaced instruction is checked against 'old'.
@@ -98,6 +181,13 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	unsigned long pc;
 	u32 new;
 
+	/*
+	 * When using CALL_OPS, the function to call is associated with the
+	 * call site, and we don't have a global function pointer to update.
+	 */
+	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
+		return 0;
+
 	pc = (unsigned long)ftrace_call;
 	new = aarch64_insn_gen_branch_imm(pc, (unsigned long)func,
 					  AARCH64_INSN_BRANCH_LINK);
@@ -176,6 +266,44 @@ static bool ftrace_find_callable_addr(struct dyn_ftrace *rec,
 	return true;
 }
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
+static const struct ftrace_ops *arm64_rec_get_ops(struct dyn_ftrace *rec)
+{
+	const struct ftrace_ops *ops = NULL;
+
+	if (rec->flags & FTRACE_FL_CALL_OPS_EN) {
+		ops = ftrace_find_unique_ops(rec);
+		WARN_ON_ONCE(!ops);
+	}
+
+	if (!ops)
+		ops = &ftrace_list_ops;
+
+	return ops;
+}
+
+static int ftrace_rec_set_ops(const struct dyn_ftrace *rec,
+			      const struct ftrace_ops *ops)
+{
+	unsigned long literal = ALIGN_DOWN(rec->ip - 12, 8);
+	return aarch64_insn_write_literal_u64((void *)literal,
+					      (unsigned long)ops);
+}
+
+static int ftrace_rec_set_nop_ops(struct dyn_ftrace *rec)
+{
+	return ftrace_rec_set_ops(rec, &ftrace_nop_ops);
+}
+
+static int ftrace_rec_update_ops(struct dyn_ftrace *rec)
+{
+	return ftrace_rec_set_ops(rec, arm64_rec_get_ops(rec));
+}
+#else
+static int ftrace_rec_set_nop_ops(struct dyn_ftrace *rec) { return 0; }
+static int ftrace_rec_update_ops(struct dyn_ftrace *rec) { return 0; }
+#endif
+
 /*
  * Turn on the call to ftrace_caller() in instrumented function
  */
@@ -183,6 +311,11 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
 	unsigned long pc = rec->ip;
 	u32 old, new;
+	int ret;
+
+	ret = ftrace_rec_update_ops(rec);
+	if (ret)
+		return ret;
 
 	if (!ftrace_find_callable_addr(rec, NULL, &addr))
 		return -EINVAL;
@@ -193,6 +326,19 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	return ftrace_modify_code(pc, old, new, true);
 }
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
+int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
+		       unsigned long addr)
+{
+	if (WARN_ON_ONCE(old_addr != (unsigned long)ftrace_caller))
+		return -EINVAL;
+	if (WARN_ON_ONCE(addr != (unsigned long)ftrace_caller))
+		return -EINVAL;
+
+	return ftrace_rec_update_ops(rec);
+}
+#endif
+
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
 /*
  * The compiler has inserted two NOPs before the regular function prologue.
@@ -220,6 +366,11 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 {
 	unsigned long pc = rec->ip - AARCH64_INSN_SIZE;
 	u32 old, new;
+	int ret;
+
+	ret = ftrace_rec_set_nop_ops(rec);
+	if (ret)
+		return ret;
 
 	old = aarch64_insn_gen_nop();
 	new = aarch64_insn_gen_move_reg(AARCH64_INSN_REG_9,
@@ -237,9 +388,14 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 {
 	unsigned long pc = rec->ip;
 	u32 old = 0, new;
+	int ret;
 
 	new = aarch64_insn_gen_nop();
 
+	ret = ftrace_rec_set_nop_ops(rec);
+	if (ret)
+		return ret;
+
 	/*
 	 * When using mcount, callsites in modules may have been initalized to
 	 * call an arbitrary module PLT (which redirects to the _mcount stub)
-- 
2.30.2

