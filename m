Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A26C6185C6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiKCRGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbiKCRGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:06:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 799471AF17
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:05:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F323139F;
        Thu,  3 Nov 2022 10:05:45 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 87DCC3F5A1;
        Thu,  3 Nov 2022 10:05:37 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com, mhiramat@kernel.org, revest@chromium.org,
        rostedt@goodmis.org, will@kernel.org
Subject: [PATCH v2 4/4] ftrace: arm64: move from REGS to ARGS
Date:   Thu,  3 Nov 2022 17:05:20 +0000
Message-Id: <20221103170520.931305-5-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221103170520.931305-1-mark.rutland@arm.com>
References: <20221103170520.931305-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit replaces arm64's support for FTRACE_WITH_REGS with support
for FTRACE_WITH_ARGS. This removes some overhead and complexity, and
removes some latent issues with inconsistent presentation of struct
pt_regs (which can only be reliably saved/restored at exception
boundaries).

FTRACE_WITH_REGS has been supported on arm64 since commit:

  3b23e4991fb66f6d ("arm64: implement ftrace with regs")

As noted in the commit message, the major reasons for implementing
FTRACE_WITH_REGS were:

(1) To make it possible to use the ftrace graph tracer with pointer
    authentication, where it's necessary to snapshot/manipulate the LR
    before it is signed by the instrumented function.

(2) To make it possible to implement LIVEPATCH in future, where we need
    to hook function entry before an instrumented function manipulates
    the stack or argument registers. Practically speaking, we need to
    preserve the argument/return registers, PC, LR, and SP.

Neither of these need a struct pt_regs, and only require the set of
registers which are live at function call/return boundaries. Our calling
convention is defined by "Procedure Call Standard for the Arm® 64-bit
Architecture (AArch64)" (AKA "AAPCS64"), which can currently be found
at:

  https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst

Per AAPCS64, all function call argument and return values are held in
the following GPRs:

* X0 - X7 : parameter / result registers
* X8      : indirect result location register
* SP      : stack pointer (AKA SP)

Additionally, ad function call boundaries, the following GPRs hold
context/return information:

* X29 : frame pointer (AKA FP)
* X30 : link register (AKA LR)

... and for ftrace we need to capture the instrumented address:

 * PC  : program counter

No other GPRs are relevant, as none of the other arguments hold
parameters or return values:

* X9  - X17 : temporaries, may be clobbered
* X18       : shadow call stack pointer (or temorary)
* X19 - X28 : callee saved

This patch implements FTRACE_WITH_ARGS for arm64, only saving/restoring
the minimal set of registers necessary. This is always sufficient to
manipulate control flow (e.g. for live-patching) or to manipulate
function arguments and return values.

This reduces the necessary stack usage from 336 bytes for pt_regs down
to 112 bytes for ftrace_regs + 32 bytes for two frame records, freeing
up 188 bytes. This could be reduced further with changes to the
unwinder.

As there is no longer a need to save different sets of registers for
different features, we no longer need distinct `ftrace_caller` and
`ftrace_regs_caller` trampolines. This allows the trampoline assembly to
be simpler, and simplifies code which previously had to handle the two
trampolines.

I've tested this with the ftrace selftests, where there are no
unexpected failures.

Co-developed-by: Florent Revest <revest@chromium.org>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Florent Revest <revest@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/Kconfig               |  18 ++---
 arch/arm64/Makefile              |   2 +-
 arch/arm64/include/asm/ftrace.h  |  72 +++++++++++++++++--
 arch/arm64/kernel/asm-offsets.c  |  13 ++++
 arch/arm64/kernel/entry-ftrace.S | 117 ++++++++++++-------------------
 arch/arm64/kernel/ftrace.c       |  82 +++++++++++++---------
 arch/arm64/kernel/module.c       |   3 -
 7 files changed, 184 insertions(+), 123 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 505c8a1ccbe0c..b6b3305ba7013 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -181,8 +181,10 @@ config ARM64
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
+	select HAVE_DYNAMIC_FTRACE_WITH_ARGS \
+		if $(cc-option,-fpatchable-function-entry=2)
 	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY \
-		if DYNAMIC_FTRACE_WITH_REGS
+		if DYNAMIC_FTRACE_WITH_ARGS
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_FAST_GUP
 	select HAVE_FTRACE_MCOUNT_RECORD
@@ -233,16 +235,16 @@ config ARM64
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
-config CLANG_SUPPORTS_DYNAMIC_FTRACE_WITH_REGS
+config CLANG_SUPPORTS_DYNAMIC_FTRACE_WITH_ARGS
 	def_bool CC_IS_CLANG
 	# https://github.com/ClangBuiltLinux/linux/issues/1507
 	depends on AS_IS_GNU || (AS_IS_LLVM && (LD_IS_LLD || LD_VERSION >= 23600))
-	select HAVE_DYNAMIC_FTRACE_WITH_REGS
+	select HAVE_DYNAMIC_FTRACE_WITH_ARGS
 
-config GCC_SUPPORTS_DYNAMIC_FTRACE_WITH_REGS
+config GCC_SUPPORTS_DYNAMIC_FTRACE_WITH_ARGS
 	def_bool CC_IS_GCC
 	depends on $(cc-option,-fpatchable-function-entry=2)
-	select HAVE_DYNAMIC_FTRACE_WITH_REGS
+	select HAVE_DYNAMIC_FTRACE_WITH_ARGS
 
 config 64BIT
 	def_bool y
@@ -1816,7 +1818,7 @@ config ARM64_PTR_AUTH_KERNEL
 	# which is only understood by binutils starting with version 2.33.1.
 	depends on LD_IS_LLD || LD_VERSION >= 23301 || (CC_IS_GCC && GCC_VERSION < 90100)
 	depends on !CC_IS_CLANG || AS_HAS_CFI_NEGATE_RA_STATE
-	depends on (!FUNCTION_GRAPH_TRACER || DYNAMIC_FTRACE_WITH_REGS)
+	depends on (!FUNCTION_GRAPH_TRACER || DYNAMIC_FTRACE_WITH_ARGS)
 	help
 	  If the compiler supports the -mbranch-protection or
 	  -msign-return-address flag (e.g. GCC 7 or later), then this option
@@ -1826,7 +1828,7 @@ config ARM64_PTR_AUTH_KERNEL
 	  disabled with minimal loss of protection.
 
 	  This feature works with FUNCTION_GRAPH_TRACER option only if
-	  DYNAMIC_FTRACE_WITH_REGS is enabled.
+	  DYNAMIC_FTRACE_WITH_ARGS is enabled.
 
 config CC_HAS_BRANCH_PROT_PAC_RET
 	# GCC 9 or later, clang 8 or later
@@ -1924,7 +1926,7 @@ config ARM64_BTI_KERNEL
 	depends on !CC_IS_GCC
 	# https://github.com/llvm/llvm-project/commit/a88c722e687e6780dcd6a58718350dc76fcc4cc9
 	depends on !CC_IS_CLANG || CLANG_VERSION >= 120000
-	depends on (!FUNCTION_GRAPH_TRACER || DYNAMIC_FTRACE_WITH_REGS)
+	depends on (!FUNCTION_GRAPH_TRACER || DYNAMIC_FTRACE_WITH_ARGS)
 	help
 	  Build the kernel with Branch Target Identification annotations
 	  and enable enforcement of this for kernel code. When this option
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 5e56d26a22398..b1202fa84baba 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -128,7 +128,7 @@ endif
 
 CHECKFLAGS	+= -D__aarch64__
 
-ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_REGS),y)
+ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_ARGS),y)
   KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
   CC_FLAGS_FTRACE := -fpatchable-function-entry=2
 endif
diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 329dbbd4d50b6..5664729800ae1 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -23,7 +23,7 @@
  */
 #define HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
 
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
 #define ARCH_SUPPORTS_FTRACE_OPS 1
 #else
 #define MCOUNT_ADDR		((unsigned long)_mcount)
@@ -33,8 +33,7 @@
 #define MCOUNT_INSN_SIZE	AARCH64_INSN_SIZE
 
 #define FTRACE_PLT_IDX		0
-#define FTRACE_REGS_PLT_IDX	1
-#define NR_FTRACE_PLTS		2
+#define NR_FTRACE_PLTS		1
 
 /*
  * Currently, gcc tends to save the link register after the local variables
@@ -69,7 +68,7 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 	 * Adjust addr to point at the BL in the callsite.
 	 * See ftrace_init_nop() for the callsite sequence.
 	 */
-	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS))
+	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_ARGS))
 		return addr + AARCH64_INSN_SIZE;
 	/*
 	 * addr is the address of the mcount call instruction.
@@ -78,10 +77,71 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 	return addr;
 }
 
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
 struct dyn_ftrace;
 struct ftrace_ops;
-struct ftrace_regs;
+
+#define arch_ftrace_get_regs(regs) NULL
+
+struct ftrace_regs {
+	/* x0 - x8 */
+	unsigned long regs[9];
+	unsigned long __unused;
+
+	unsigned long fp;
+	unsigned long lr;
+
+	unsigned long sp;
+	unsigned long pc;
+};
+
+static __always_inline unsigned long
+ftrace_regs_get_instruction_pointer(const struct ftrace_regs *fregs)
+{
+	return fregs->pc;
+}
+
+static __always_inline void
+ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
+				    unsigned long pc)
+{
+	fregs->pc = pc;
+}
+
+static __always_inline unsigned long
+ftrace_regs_get_stack_pointer(const struct ftrace_regs *fregs)
+{
+	return fregs->sp;
+}
+
+static __always_inline unsigned long
+ftrace_regs_get_argument(struct ftrace_regs *fregs, unsigned int n)
+{
+	if (n < 8)
+		return fregs->regs[n];
+	return 0;
+}
+
+static __always_inline unsigned long
+ftrace_regs_get_return_value(const struct ftrace_regs *fregs)
+{
+	return fregs->regs[0];
+}
+
+static __always_inline void
+ftrace_regs_set_return_value(struct ftrace_regs *fregs,
+			     unsigned long ret)
+{
+	fregs->regs[0] = ret;
+}
+
+static __always_inline void
+ftrace_override_function_with_return(struct ftrace_regs *fregs)
+{
+	fregs->pc = fregs->lr;
+}
+
+int ftrace_regs_query_register_offset(const char *name);
 
 int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
 #define ftrace_init_nop ftrace_init_nop
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 1197e7679882e..2234624536d95 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -82,6 +82,19 @@ int main(void)
   DEFINE(S_STACKFRAME,		offsetof(struct pt_regs, stackframe));
   DEFINE(PT_REGS_SIZE,		sizeof(struct pt_regs));
   BLANK();
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
+  DEFINE(FREGS_X0,		offsetof(struct ftrace_regs, regs[0]));
+  DEFINE(FREGS_X2,		offsetof(struct ftrace_regs, regs[2]));
+  DEFINE(FREGS_X4,		offsetof(struct ftrace_regs, regs[4]));
+  DEFINE(FREGS_X6,		offsetof(struct ftrace_regs, regs[6]));
+  DEFINE(FREGS_X8,		offsetof(struct ftrace_regs, regs[8]));
+  DEFINE(FREGS_FP,		offsetof(struct ftrace_regs, fp));
+  DEFINE(FREGS_LR,		offsetof(struct ftrace_regs, lr));
+  DEFINE(FREGS_SP,		offsetof(struct ftrace_regs, sp));
+  DEFINE(FREGS_PC,		offsetof(struct ftrace_regs, pc));
+  DEFINE(FREGS_SIZE,		sizeof(struct ftrace_regs));
+  BLANK();
+#endif
 #ifdef CONFIG_COMPAT
   DEFINE(COMPAT_SIGFRAME_REGS_OFFSET,		offsetof(struct compat_sigframe, uc.uc_mcontext.arm_r0));
   DEFINE(COMPAT_RT_SIGFRAME_REGS_OFFSET,	offsetof(struct compat_rt_sigframe, sig.uc.uc_mcontext.arm_r0));
diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index 795344ab4ec45..4d3050549aa6e 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -13,83 +13,58 @@
 #include <asm/ftrace.h>
 #include <asm/insn.h>
 
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
 /*
  * Due to -fpatchable-function-entry=2, the compiler has placed two NOPs before
  * the regular function prologue. For an enabled callsite, ftrace_init_nop() and
  * ftrace_make_call() have patched those NOPs to:
  *
  * 	MOV	X9, LR
- * 	BL	<entry>
- *
- * ... where <entry> is either ftrace_caller or ftrace_regs_caller.
+ * 	BL	ftrace_caller
  *
  * Each instrumented function follows the AAPCS, so here x0-x8 and x18-x30 are
  * live (x18 holds the Shadow Call Stack pointer), and x9-x17 are safe to
  * clobber.
  *
- * We save the callsite's context into a pt_regs before invoking any ftrace
- * callbacks. So that we can get a sensible backtrace, we create a stack record
- * for the callsite and the ftrace entry assembly. This is not sufficient for
- * reliable stacktrace: until we create the callsite stack record, its caller
- * is missing from the LR and existing chain of frame records.
+ * We save the callsite's context into a struct ftrace_regs before invoking any
+ * ftrace callbacks. So that we can get a sensible backtrace, we create frame
+ * records for the callsite and the ftrace entry assembly. This is not
+ * sufficient for reliable stacktrace: until we create the callsite stack
+ * record, its caller is missing from the LR and existing chain of frame
+ * records.
  */
-	.macro  ftrace_regs_entry, allregs=0
-	/* Make room for pt_regs, plus a callee frame */
-	sub	sp, sp, #(PT_REGS_SIZE + 16)
-
-	/* Save function arguments (and x9 for simplicity) */
-	stp	x0, x1, [sp, #S_X0]
-	stp	x2, x3, [sp, #S_X2]
-	stp	x4, x5, [sp, #S_X4]
-	stp	x6, x7, [sp, #S_X6]
-	stp	x8, x9, [sp, #S_X8]
-
-	/* Optionally save the callee-saved registers, always save the FP */
-	.if \allregs == 1
-	stp	x10, x11, [sp, #S_X10]
-	stp	x12, x13, [sp, #S_X12]
-	stp	x14, x15, [sp, #S_X14]
-	stp	x16, x17, [sp, #S_X16]
-	stp	x18, x19, [sp, #S_X18]
-	stp	x20, x21, [sp, #S_X20]
-	stp	x22, x23, [sp, #S_X22]
-	stp	x24, x25, [sp, #S_X24]
-	stp	x26, x27, [sp, #S_X26]
-	stp	x28, x29, [sp, #S_X28]
-	.else
-	str	x29, [sp, #S_FP]
-	.endif
-
-	/* Save the callsite's SP and LR */
-	add	x10, sp, #(PT_REGS_SIZE + 16)
-	stp	x9, x10, [sp, #S_LR]
+SYM_CODE_START(ftrace_caller)
+	bti	c
 
-	/* Save the PC after the ftrace callsite */
-	str	x30, [sp, #S_PC]
+	/* Save original SP */
+	mov	x10, sp
 
-	/* Create a frame record for the callsite above pt_regs */
-	stp	x29, x9, [sp, #PT_REGS_SIZE]
-	add	x29, sp, #PT_REGS_SIZE
+	/* Make room for ftrace regs, plus two frame records */
+	sub	sp, sp, #(FREGS_SIZE + 32)
 
-	/* Create our frame record within pt_regs. */
-	stp	x29, x30, [sp, #S_STACKFRAME]
-	add	x29, sp, #S_STACKFRAME
-	.endm
+	/* Save function arguments */
+	stp	x0, x1, [sp, #FREGS_X0]
+	stp	x2, x3, [sp, #FREGS_X2]
+	stp	x4, x5, [sp, #FREGS_X4]
+	stp	x6, x7, [sp, #FREGS_X6]
+	str	x8,     [sp, #FREGS_X8]
 
-SYM_CODE_START(ftrace_regs_caller)
-	bti	c
-	ftrace_regs_entry	1
-	b	ftrace_common
-SYM_CODE_END(ftrace_regs_caller)
+	/* Save the callsite's FP, LR, SP */
+	str	x29, [sp, #FREGS_FP]
+	str	x9,  [sp, #FREGS_LR]
+	str	x10, [sp, #FREGS_SP]
 
-SYM_CODE_START(ftrace_caller)
-	bti	c
-	ftrace_regs_entry	0
-	b	ftrace_common
-SYM_CODE_END(ftrace_caller)
+	/* Save the PC after the ftrace callsite */
+	str	x30, [sp, #FREGS_PC]
+
+	/* Create a frame record for the callsite above the ftrace regs */
+	stp	x29, x9, [sp, #FREGS_SIZE + 16]
+	add	x29, sp, #FREGS_SIZE + 16
+
+	/* Create our frame record above the ftrace regs */
+	stp	x29, x30, [sp, #FREGS_SIZE]
+	add	x29, sp, #FREGS_SIZE
 
-SYM_CODE_START(ftrace_common)
 	sub	x0, x30, #AARCH64_INSN_SIZE	// ip (callsite's BL insn)
 	mov	x1, x9				// parent_ip (callsite's LR)
 	ldr_l	x2, function_trace_op		// op
@@ -104,24 +79,24 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
  * to restore x0-x8, x29, and x30.
  */
 	/* Restore function arguments */
-	ldp	x0, x1, [sp]
-	ldp	x2, x3, [sp, #S_X2]
-	ldp	x4, x5, [sp, #S_X4]
-	ldp	x6, x7, [sp, #S_X6]
-	ldr	x8, [sp, #S_X8]
+	ldp	x0, x1, [sp, #FREGS_X0]
+	ldp	x2, x3, [sp, #FREGS_X2]
+	ldp	x4, x5, [sp, #FREGS_X4]
+	ldp	x6, x7, [sp, #FREGS_X6]
+	ldr	x8,     [sp, #FREGS_X8]
 
 	/* Restore the callsite's FP, LR, PC */
-	ldr	x29, [sp, #S_FP]
-	ldr	x30, [sp, #S_LR]
-	ldr	x9, [sp, #S_PC]
+	ldr	x29, [sp, #FREGS_FP]
+	ldr	x30, [sp, #FREGS_LR]
+	ldr	x9,  [sp, #FREGS_PC]
 
 	/* Restore the callsite's SP */
-	add	sp, sp, #PT_REGS_SIZE + 16
+	add	sp, sp, #FREGS_SIZE + 32
 
 	ret	x9
-SYM_CODE_END(ftrace_common)
+SYM_CODE_END(ftrace_caller)
 
-#else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+#else /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
 
 /*
  * Gcc with -pg will put the following code in the beginning of each function:
@@ -293,7 +268,7 @@ SYM_FUNC_START(ftrace_graph_caller)
 	mcount_exit
 SYM_FUNC_END(ftrace_graph_caller)
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
 
 SYM_TYPED_FUNC_START(ftrace_stub)
 	ret
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 8745175f4a754..5cf990d052ba8 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -17,6 +17,49 @@
 #include <asm/insn.h>
 #include <asm/patching.h>
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
+struct fregs_offset {
+	const char *name;
+	int offset;
+};
+
+#define FREGS_OFFSET(n, field)				\
+{							\
+	.name = n,					\
+	.offset = offsetof(struct ftrace_regs, field),	\
+}
+
+static const struct fregs_offset fregs_offsets[] = {
+	FREGS_OFFSET("x0", regs[0]),
+	FREGS_OFFSET("x1", regs[1]),
+	FREGS_OFFSET("x2", regs[2]),
+	FREGS_OFFSET("x3", regs[3]),
+	FREGS_OFFSET("x4", regs[4]),
+	FREGS_OFFSET("x5", regs[5]),
+	FREGS_OFFSET("x6", regs[6]),
+	FREGS_OFFSET("x7", regs[7]),
+	FREGS_OFFSET("x8", regs[8]),
+
+	FREGS_OFFSET("x29", fp),
+	FREGS_OFFSET("x30", lr),
+	FREGS_OFFSET("lr", lr),
+
+	FREGS_OFFSET("sp", sp),
+	FREGS_OFFSET("pc", pc),
+};
+
+int ftrace_regs_query_register_offset(const char *name)
+{
+	for (int i = 0; i < ARRAY_SIZE(fregs_offsets); i++) {
+		const struct fregs_offset *roff = &fregs_offsets[i];
+		if (!strcmp(roff->name, name))
+			return roff->offset;
+	}
+
+	return -EINVAL;
+}
+#endif
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 /*
  * Replace a single instruction, which may be a branch or NOP.
@@ -70,9 +113,6 @@ static struct plt_entry *get_ftrace_plt(struct module *mod, unsigned long addr)
 
 	if (addr == FTRACE_ADDR)
 		return &plt[FTRACE_PLT_IDX];
-	if (addr == FTRACE_REGS_ADDR &&
-	    IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS))
-		return &plt[FTRACE_REGS_PLT_IDX];
 #endif
 	return NULL;
 }
@@ -154,25 +194,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	return ftrace_modify_code(pc, old, new, true);
 }
 
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
-int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
-			unsigned long addr)
-{
-	unsigned long pc = rec->ip;
-	u32 old, new;
-
-	if (!ftrace_find_callable_addr(rec, NULL, &old_addr))
-		return -EINVAL;
-	if (!ftrace_find_callable_addr(rec, NULL, &addr))
-		return -EINVAL;
-
-	old = aarch64_insn_gen_branch_imm(pc, old_addr,
-					  AARCH64_INSN_BRANCH_LINK);
-	new = aarch64_insn_gen_branch_imm(pc, addr, AARCH64_INSN_BRANCH_LINK);
-
-	return ftrace_modify_code(pc, old, new, true);
-}
-
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
 /*
  * The compiler has inserted two NOPs before the regular function prologue.
  * All instrumented functions follow the AAPCS, so x0-x8 and x19-x30 are live,
@@ -228,7 +250,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 	 *
 	 * Note: 'mod' is only set at module load time.
 	 */
-	if (!IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS) &&
+	if (!IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_ARGS) &&
 	    IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) && mod) {
 		return aarch64_insn_patch_text_nosync((void *)pc, new);
 	}
@@ -279,19 +301,11 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
-	/*
-	 * When DYNAMIC_FTRACE_WITH_REGS is selected, `fregs` can never be NULL
-	 * and arch_ftrace_get_regs(fregs) will always give a non-NULL pt_regs
-	 * in which we can safely modify the LR.
-	 */
-	struct pt_regs *regs = arch_ftrace_get_regs(fregs);
-	unsigned long *parent = (unsigned long *)&procedure_link_pointer(regs);
-
-	prepare_ftrace_return(ip, parent, frame_pointer(regs));
+	prepare_ftrace_return(ip, &fregs->lr, fregs->fp);
 }
 #else
 /*
@@ -323,6 +337,6 @@ int ftrace_disable_ftrace_graph_caller(void)
 {
 	return ftrace_modify_graph_caller(false);
 }
-#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
 #endif /* CONFIG_DYNAMIC_FTRACE */
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 76b41e4ca9fa3..acd0d883e9ca2 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -497,9 +497,6 @@ static int module_init_ftrace_plt(const Elf_Ehdr *hdr,
 
 	__init_plt(&plts[FTRACE_PLT_IDX], FTRACE_ADDR);
 
-	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS))
-		__init_plt(&plts[FTRACE_REGS_PLT_IDX], FTRACE_REGS_ADDR);
-
 	mod->arch.ftrace_trampolines = plts;
 #endif
 	return 0;
-- 
2.30.2

