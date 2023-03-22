Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBBA6C4167
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 05:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjCVEBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 00:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjCVEAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 00:00:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C54647403
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 21:00:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2699AB81B00
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4539BC4339E;
        Wed, 22 Mar 2023 04:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679457629;
        bh=K9boLq8z7fFVEvsbG6dLv4M6tcuUFGHuZyYPrBfNWt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aJaxlTRD5z6KYT8GOc3YDHsq7AgJRJsje9tYr2v/JDTRGcdZDbVcPPQD06RFU+1ma
         uDY4R5CiQxp/GWYvovLw1L0BxFw3tqvWQoTOf9B97XR3LBfWup1P9NOgbN16NMOtM2
         ABf5kLArMRbm3BnO+ivX/Nyj7c0mDJovtw3zJ9hP0eZfN2F6jleykCAfwa5MjltFLX
         DGSO2ls8GQ2dmkNhWs6WDCtGZGDPqVJJjqofDytIpdE/4tQayH/9VrlUa8Besn/d3y
         REizfEsK6vCLwuoliLULg1Wz1sNyU8tqGPEwoVXfoGKpQR1hyYXlDcJDLwEwvAM/MO
         r171LcKrXxcPw==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 11/11] static_call: Remove DEFINE_STATIC_CALL_RET0()
Date:   Tue, 21 Mar 2023 21:00:17 -0700
Message-Id: <8aab02492c2bf512c7ffe458e41acc1b930ed2dc.1679456900.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679456900.git.jpoimboe@kernel.org>
References: <cover.1679456900.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NULL and RET0 static calls are both slightly different ways of nopping a
static call.  A not-insignificant amount of code and complexity is spent
maintaining them separately.  It's also somewhat tricky for the user who
has to try to remember to use the correct one for the given function
type.

Simplify things all around by just combining them, such that NULL static
calls always return 0.

While it doesn't necessarily make sense for void-return functions to
return 0, it's pretty much harmless.  The return value register is
already callee-clobbered, and an extra "xor %eax, %eax" shouldn't affect
performance (knock on wood).

This "do nothing return 0" default should work for the vast majority of
NULL cases.  Otherwise it can be easily overridden with a user-specified
function which panics or returns 0xdeadbeef or does whatever one wants.

This simplifies the static call code and also tends to help simplify
users' code as well.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/arm64/include/asm/static_call.h    |  4 --
 arch/powerpc/include/asm/static_call.h  |  1 -
 arch/powerpc/kernel/irq.c               |  2 +-
 arch/powerpc/kernel/static_call.c       |  7 +-
 arch/x86/events/amd/core.c              |  2 +-
 arch/x86/events/core.c                  |  5 +-
 arch/x86/include/asm/kvm-x86-ops.h      |  3 +-
 arch/x86/include/asm/static_call.h      | 13 +---
 arch/x86/kernel/alternative.c           |  6 --
 arch/x86/kernel/static_call.c           | 89 ++-----------------------
 arch/x86/kvm/x86.c                      |  4 +-
 include/linux/static_call.h             | 65 +++++-------------
 include/linux/static_call_types.h       |  4 --
 kernel/events/core.c                    | 15 ++---
 kernel/sched/core.c                     | 10 +--
 kernel/static_call.c                    |  5 --
 tools/include/linux/static_call_types.h |  4 --
 17 files changed, 39 insertions(+), 200 deletions(-)

diff --git a/arch/arm64/include/asm/static_call.h b/arch/arm64/include/asm/static_call.h
index 02693b404afc..b3489cac7742 100644
--- a/arch/arm64/include/asm/static_call.h
+++ b/arch/arm64/include/asm/static_call.h
@@ -22,10 +22,6 @@
 	    ".type " name ", @function				\n"	\
 	    ".size " name ", . - " name "			\n")
 
-#define __ARCH_DEFINE_STATIC_CALL_NOP_CFI(name)			\
-	GEN_CFI_SYM(STATIC_CALL_NOP_CFI(name));			\
-	__ARCH_DEFINE_STATIC_CALL_CFI(STATIC_CALL_NOP_CFI_STR(name), "")
-
 #define __ARCH_DEFINE_STATIC_CALL_RET0_CFI(name)			\
 	GEN_CFI_SYM(STATIC_CALL_RET0_CFI(name));			\
 	__ARCH_DEFINE_STATIC_CALL_CFI(STATIC_CALL_RET0_CFI_STR(name), "mov x0, xzr")
diff --git a/arch/powerpc/include/asm/static_call.h b/arch/powerpc/include/asm/static_call.h
index 744435127574..0b17fc551157 100644
--- a/arch/powerpc/include/asm/static_call.h
+++ b/arch/powerpc/include/asm/static_call.h
@@ -23,7 +23,6 @@
 #define PPC_SCT_DATA		28		/* Offset of label 2 */
 
 #define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)	__PPC_SCT(name, "b " #func)
-#define ARCH_DEFINE_STATIC_CALL_NOP_TRAMP(name)		__PPC_SCT(name, "blr")
 #define ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name)	__PPC_SCT(name, "b .+20")
 
 #endif /* _ASM_POWERPC_STATIC_CALL_H */
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index c9535f2760b5..320e1a41abd6 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -220,7 +220,7 @@ static __always_inline void call_do_softirq(const void *sp)
 }
 #endif
 
-DEFINE_STATIC_CALL_RET0(ppc_get_irq, *ppc_md.get_irq);
+DEFINE_STATIC_CALL_NULL(ppc_get_irq, *ppc_md.get_irq);
 
 static void __do_irq(struct pt_regs *regs, unsigned long oldsp)
 {
diff --git a/arch/powerpc/kernel/static_call.c b/arch/powerpc/kernel/static_call.c
index 8bfe46654e01..db3116b2d8a8 100644
--- a/arch/powerpc/kernel/static_call.c
+++ b/arch/powerpc/kernel/static_call.c
@@ -8,7 +8,6 @@ void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
 {
 	int err;
 	bool is_ret0 = (func == __static_call_return0);
-	bool is_nop = (func == __static_call_nop);
 	unsigned long target = (unsigned long)(is_ret0 ? tramp + PPC_SCT_RET0 : func);
 	bool is_short = is_offset_in_branch_range((long)target - (long)tramp);
 
@@ -17,15 +16,13 @@ void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
 
 	mutex_lock(&text_mutex);
 
-	if (!is_nop && !is_short) {
+	if (!is_short) {
 		err = patch_instruction(tramp + PPC_SCT_DATA, ppc_inst(target));
 		if (err)
 			goto out;
 	}
 
-	if (is_nop)
-		err = patch_instruction(tramp, ppc_inst(PPC_RAW_BLR()));
-	else if (is_short)
+	if (is_short)
 		err = patch_branch(tramp, target, 0);
 	else
 		err = patch_instruction(tramp, ppc_inst(PPC_RAW_NOP()));
diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 8c45b198b62f..3c545595bfeb 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -330,7 +330,7 @@ static inline bool amd_is_pair_event_code(struct hw_perf_event *hwc)
 	}
 }
 
-DEFINE_STATIC_CALL_RET0(amd_pmu_branch_hw_config, *x86_pmu.hw_config);
+DEFINE_STATIC_CALL_NULL(amd_pmu_branch_hw_config, *x86_pmu.hw_config);
 
 static int amd_core_hw_config(struct perf_event *event)
 {
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index c94537501091..dfeaeee34acf 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -96,7 +96,7 @@ DEFINE_STATIC_CALL_NULL(x86_pmu_filter, *x86_pmu.filter);
  * This one is magic, it will get called even when PMU init fails (because
  * there is no PMU), in which case it should simply return NULL.
  */
-DEFINE_STATIC_CALL_RET0(x86_pmu_guest_get_msrs, *x86_pmu.guest_get_msrs);
+DEFINE_STATIC_CALL_NULL(x86_pmu_guest_get_msrs, *x86_pmu.guest_get_msrs);
 
 u64 __read_mostly hw_cache_event_ids
 				[PERF_COUNT_HW_CACHE_MAX]
@@ -2125,9 +2125,6 @@ static int __init init_hw_perf_events(void)
 	if (!x86_pmu.read)
 		x86_pmu.read = _x86_pmu_read;
 
-	if (!x86_pmu.guest_get_msrs)
-		x86_pmu.guest_get_msrs = (void *)&__static_call_return0;
-
 	if (!x86_pmu.set_period)
 		x86_pmu.set_period = x86_perf_event_set_period;
 
diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 2f0bfd910637..6e1259ed1014 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -10,8 +10,7 @@ BUILD_BUG_ON(1)
  *
  * KVM_X86_OP_OPTIONAL() can be used for those functions that can have
  * a NULL definition.  KVM_X86_OP_OPTIONAL_RET0() can be used likewise
- * to make a definition optional, but in this case the default will
- * be __static_call_return0.
+ * to make a definition optional.
  */
 KVM_X86_OP(check_processor_compatibility)
 KVM_X86_OP(hardware_enable)
diff --git a/arch/x86/include/asm/static_call.h b/arch/x86/include/asm/static_call.h
index afea6ceeed23..21ad48988f6e 100644
--- a/arch/x86/include/asm/static_call.h
+++ b/arch/x86/include/asm/static_call.h
@@ -29,8 +29,7 @@
  *   ud1 %esp, %ecx
  *
  * That trailing #UD provides both a speculation stop and serves as a unique
- * 3 byte signature identifying static call trampolines. Also see tramp_ud[]
- * and __static_call_fixup().
+ * 3 byte signature identifying static call trampolines. Also see tramp_ud[].
  */
 #define __ARCH_DEFINE_STATIC_CALL_TRAMP(name, insns)			\
 	asm(".pushsection .static_call.text, \"ax\"		\n"	\
@@ -47,17 +46,7 @@
 #define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)			\
 	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, ".byte 0xe9; .long " #func " - (. + 4)")
 
-#ifdef CONFIG_RETHUNK
-#define ARCH_DEFINE_STATIC_CALL_NOP_TRAMP(name)				\
-	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, "jmp __x86_return_thunk")
-#else
-#define ARCH_DEFINE_STATIC_CALL_NOP_TRAMP(name)				\
-	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, "ret; int3; nop; nop; nop")
-#endif
-
 #define ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name)			\
 	ARCH_DEFINE_STATIC_CALL_TRAMP(name, __static_call_return0)
 
-extern bool __static_call_fixup(void *tramp, u8 op, void *dest);
-
 #endif /* _ASM_STATIC_CALL_H */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index f615e0cb6d93..4388dc9942ca 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -624,12 +624,6 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end)
 		if (op == JMP32_INSN_OPCODE)
 			dest = addr + insn.length + insn.immediate.value;
 
-		if (__static_call_fixup(addr, op, dest) ||
-		    WARN_ONCE(dest != &__x86_return_thunk,
-			      "missing return thunk: %pS-%pS: %*ph",
-			      addr, dest, 5, addr))
-			continue;
-
 		DPRINTK("return thunk at: %pS (%px) len: %d to: %pS",
 			addr, addr, insn.length,
 			addr + insn.length + insn.immediate.value);
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index 27c095c7fc96..d914167fbb4e 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -6,10 +6,8 @@
 
 enum insn_type {
 	CALL = 0, /* site call */
-	NOP = 1,  /* site cond-call */
-	JMP = 2,  /* tramp / site tail-call */
-	RET = 3,  /* tramp / site cond-tail-call */
-	JCC = 4,
+	JMP = 1,  /* tramp / site tail-call */
+	JCC = 2,
 };
 
 /*
@@ -24,8 +22,6 @@ static const u8 tramp_ud[] = { 0x0f, 0xb9, 0xcc };
  */
 static const u8 xor5rax[] = { 0x2e, 0x2e, 0x2e, 0x31, 0xc0 };
 
-static const u8 retinsn[] = { RET_INSN_OPCODE, 0xcc, 0xcc, 0xcc, 0xcc };
-
 static u8 __is_Jcc(u8 *insn) /* Jcc.d32 */
 {
 	u8 ret = 0;
@@ -39,17 +35,6 @@ static u8 __is_Jcc(u8 *insn) /* Jcc.d32 */
 	return ret;
 }
 
-extern void __static_call_return(void);
-
-asm (".global __static_call_return\n\t"
-     ".type __static_call_return, @function\n\t"
-     ASM_FUNC_ALIGN "\n\t"
-     "__static_call_return:\n\t"
-     ANNOTATE_NOENDBR
-     ANNOTATE_RETPOLINE_SAFE
-     "ret; int3\n\t"
-     ".size __static_call_return, . - __static_call_return \n\t");
-
 static void __ref __static_call_transform(void *insn, enum insn_type type,
 					  void *func, bool modinit)
 {
@@ -58,7 +43,7 @@ static void __ref __static_call_transform(void *insn, enum insn_type type,
 	const void *code;
 	u8 op, buf[6];
 
-	if ((type == JMP || type == RET) && (op = __is_Jcc(insn)))
+	if (type == JMP && (op = __is_Jcc(insn)))
 		type = JCC;
 
 	switch (type) {
@@ -72,28 +57,11 @@ static void __ref __static_call_transform(void *insn, enum insn_type type,
 
 		break;
 
-	case NOP:
-		code = x86_nops[5];
-		break;
-
 	case JMP:
 		code = text_gen_insn(JMP32_INSN_OPCODE, insn, func);
 		break;
 
-	case RET:
-		if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
-			code = text_gen_insn(JMP32_INSN_OPCODE, insn, x86_return_thunk);
-		else
-			code = &retinsn;
-		break;
-
 	case JCC:
-		if (!func) {
-			func = __static_call_return; //FIXME use __static_call_nop()?
-			if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
-				func = x86_return_thunk;
-		}
-
 		buf[0] = 0x0f;
 		__text_gen_insn(buf+1, op, insn+1, func, 5);
 		code = buf;
@@ -122,12 +90,10 @@ static void __static_call_validate(u8 *insn, bool tail, bool tramp)
 
 	if (tail) {
 		if (opcode == JMP32_INSN_OPCODE ||
-		    opcode == RET_INSN_OPCODE ||
 		    __is_Jcc(insn))
 			return;
 	} else {
 		if (opcode == CALL_INSN_OPCODE ||
-		    !memcmp(insn, x86_nops[5], 5) ||
 		    !memcmp(insn, xor5rax, 5))
 			return;
 	}
@@ -139,65 +105,22 @@ static void __static_call_validate(u8 *insn, bool tail, bool tramp)
 	BUG();
 }
 
-static inline enum insn_type __sc_insn(bool nop, bool tail)
-{
-	/*
-	 * Encode the following table without branches:
-	 *
-	 *	tail	nop	insn
-	 *	-----+-------+------
-	 *	  0  |   0   |  CALL
-	 *	  0  |   1   |  NOP
-	 *	  1  |   0   |  JMP
-	 *	  1  |   1   |  RET
-	 */
-	return 2*tail + nop;
-}
-
 void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
 {
-	bool nop = (func == __static_call_nop);
+	enum insn_type insn = tail ? JMP : CALL;
 
 	mutex_lock(&text_mutex);
 
 	if (tramp) {
 		__static_call_validate(tramp, true, true);
-		__static_call_transform(tramp, __sc_insn(nop, true), func, false);
+		__static_call_transform(tramp, insn, func, false);
 	}
 
 	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE) && site) {
 		__static_call_validate(site, tail, false);
-		__static_call_transform(site, __sc_insn(nop, tail), func, false);
+		__static_call_transform(site, insn, func, false);
 	}
 
 	mutex_unlock(&text_mutex);
 }
 EXPORT_SYMBOL_GPL(arch_static_call_transform);
-
-#ifdef CONFIG_RETHUNK
-/*
- * This is called by apply_returns() to fix up static call trampolines,
- * specifically ARCH_DEFINE_STATIC_CALL_NULL_TRAMP which is recorded as
- * having a return trampoline.
- *
- * The problem is that static_call() is available before determining
- * X86_FEATURE_RETHUNK and, by implication, running alternatives.
- *
- * This means that __static_call_transform() above can have overwritten the
- * return trampoline and we now need to fix things up to be consistent.
- */
-bool __static_call_fixup(void *tramp, u8 op, void *dest)
-{
-	if (memcmp(tramp+5, tramp_ud, 3)) {
-		/* Not a trampoline site, not our problem. */
-		return false;
-	}
-
-	mutex_lock(&text_mutex);
-	if (op == RET_INSN_OPCODE || dest == &__x86_return_thunk)
-		__static_call_transform(tramp, RET, NULL, true);
-	mutex_unlock(&text_mutex);
-
-	return true;
-}
-#endif
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index fcf845fc5770..324676d738c0 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9321,9 +9321,7 @@ static inline void kvm_ops_update(struct kvm_x86_init_ops *ops)
 #define KVM_X86_OP(func) \
 	WARN_ON(!kvm_x86_ops.func); __KVM_X86_OP(func)
 #define KVM_X86_OP_OPTIONAL __KVM_X86_OP
-#define KVM_X86_OP_OPTIONAL_RET0(func) \
-	static_call_update(kvm_x86_##func, (void *)kvm_x86_ops.func ? : \
-					   (void *)__static_call_return0);
+#define KVM_X86_OP_OPTIONAL_RET0(func) __KVM_X86_OP
 #include <asm/kvm-x86-ops.h>
 #undef __KVM_X86_OP
 
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index d5254107ccf4..625b3217480f 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -17,9 +17,6 @@
  *   DECLARE_STATIC_CALL(name, func);
  *   DEFINE_STATIC_CALL(name, func);
  *   DEFINE_STATIC_CALL_NULL(name, typename);
- *   DEFINE_STATIC_CALL_RET0(name, typename);
- *
- *   __static_call_return0;
  *
  *   static_call(name)(args...);
  *   static_call_ro(name)(args...);
@@ -65,19 +62,26 @@
  *
  * Notes on NULL function pointers:
  *
- *   A static_call() to a NULL function pointer is a NOP.
+ *   A static_call() to a NULL function pointer is equivalent to a call to a
+ *   "do nothing return 0" function.
  *
  *   A NULL static call can be the result of:
  *
  *     DECLARE_STATIC_CALL_NULL(my_static_call, void (*)(int));
  *
- *   or using static_call_update() with a NULL function pointer. In both cases
- *   the HAVE_STATIC_CALL implementation will patch the trampoline with a RET
-*    instruction, instead of an immediate tail-call JMP. HAVE_STATIC_CALL_INLINE
-*    architectures can patch the trampoline call to a NOP.
+ *   or using static_call_update() with a NULL function pointer.
+ *
+ *   The "return 0" feature is strictly UB per the C standard (since it casts a
+ *   function pointer to a different signature) and relies on the architecture
+ *   ABI to make things work. In particular it relies on the return value
+ *   register being callee-clobbered for all function calls.
+ *
+ *   In particular The x86_64 implementation of HAVE_STATIC_CALL_INLINE
+ *   replaces the 5 byte CALL instruction at the callsite with a 5 byte clear
+ *   of the RAX register, completely eliding any function call overhead.
  *
- *   In all cases, any argument evaluation is unconditional. Unlike a regular
- *   conditional function pointer call:
+ *   Any argument evaluation is unconditional. Unlike a regular conditional
+ *   function pointer call:
  *
  *     if (my_func_ptr)
  *         my_func_ptr(arg1)
@@ -88,26 +92,6 @@
  *
  *   func = static_call_query(name);
  *
- *
- * DEFINE_STATIC_CALL_RET0 / __static_call_return0:
- *
- *   Just like how DEFINE_STATIC_CALL_NULL() optimizes the
- *   conditional void function call, DEFINE_STATIC_CALL_RET0 /
- *   __static_call_return0 optimize the do nothing return 0 function.
- *
- *   This feature is strictly UB per the C standard (since it casts a function
- *   pointer to a different signature) and relies on the architecture ABI to
- *   make things work. In particular it relies on Caller Stack-cleanup and the
- *   whole return register being clobbered for short return values. All normal
- *   CDECL style ABIs conform.
- *
- *   In particular the x86_64 implementation replaces the 5 byte CALL
- *   instruction at the callsite with a 5 byte clear of the RAX register,
- *   completely eliding any function call overhead.
- *
- *   Notably argument setup is unconditional.
- *
- *
  * EXPORT_STATIC_CALL() vs EXPORT_STATIC_CALL_RO():
  *
  *   The difference is the read-only variant exports the trampoline but not the
@@ -131,7 +115,6 @@ struct static_call_key {
 #endif
 };
 
-extern void __static_call_nop(void);
 extern long __static_call_return0(void);
 
 #define DECLARE_STATIC_CALL(name, func)					\
@@ -151,10 +134,6 @@ extern long __static_call_return0(void);
 	__DEFINE_STATIC_CALL_TRAMP(name, func)
 
 #define DEFINE_STATIC_CALL_NULL(name, type)				\
-	__DEFINE_STATIC_CALL(name, type, __STATIC_CALL_NOP(name));	\
-	__DEFINE_STATIC_CALL_NOP_TRAMP(name)
-
-#define DEFINE_STATIC_CALL_RET0(name, type)				\
 	__DEFINE_STATIC_CALL(name, type, __STATIC_CALL_RET0(name));	\
 	__DEFINE_STATIC_CALL_RET0_TRAMP(name)
 
@@ -212,8 +191,6 @@ extern long __static_call_return0(void);
 ({									\
 	typeof(&STATIC_CALL_TRAMP(name)) __F = (func);			\
 	if (!__F)							\
-		__F = __STATIC_CALL_NOP(name);				\
-	else if (__F == (void *)__static_call_return0)			\
 		__F = __STATIC_CALL_RET0(name);				\
 	__static_call_update(&STATIC_CALL_KEY(name),			\
 			     STATIC_CALL_TRAMP_ADDR(name), __F);	\
@@ -222,10 +199,8 @@ extern long __static_call_return0(void);
 #define static_call_query(name)						\
 ({									\
 	void *__F = (READ_ONCE(STATIC_CALL_KEY(name).func));		\
-	if (__F == __STATIC_CALL_NOP(name))				\
+	if (__F == __STATIC_CALL_RET0(name))				\
 		__F = NULL;						\
-	else if (__F == __STATIC_CALL_RET0(name))			\
-		__F = __static_call_return0;				\
 	__F;								\
 })
 
@@ -236,9 +211,6 @@ extern long __static_call_return0(void);
 #define __DEFINE_STATIC_CALL_TRAMP(name, func)				\
 	ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)
 
-#define __DEFINE_STATIC_CALL_NOP_TRAMP(name)				\
-	ARCH_DEFINE_STATIC_CALL_NOP_TRAMP(name)
-
 #define __DEFINE_STATIC_CALL_RET0_TRAMP(name)				\
 	ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name)
 
@@ -262,7 +234,6 @@ extern void arch_static_call_transform(void *site, void *tramp, void *func, bool
 #else /* !CONFIG_HAVE_STATIC_CALL */
 
 #define __DEFINE_STATIC_CALL_TRAMP(name, func)
-#define __DEFINE_STATIC_CALL_NOP_TRAMP(name)
 #define __DEFINE_STATIC_CALL_RET0_TRAMP(name)
 #define __EXPORT_STATIC_CALL_TRAMP(name)
 #define __EXPORT_STATIC_CALL_TRAMP_GPL(name)
@@ -308,28 +279,22 @@ static inline void static_call_force_reinit(void) {}
 
 #include <asm/static_call.h>
 
-#define __STATIC_CALL_NOP(name)		STATIC_CALL_NOP_CFI(name)
 #define __STATIC_CALL_RET0(name)	STATIC_CALL_RET0_CFI(name)
 
 #define __DECLARE_STATIC_CALL_CFI(name, func)				\
-	extern typeof(func) STATIC_CALL_NOP_CFI(name);		\
 	extern typeof(func) STATIC_CALL_RET0_CFI(name)
 
 #define __DEFINE_STATIC_CALL_CFI(name)					\
-	__ARCH_DEFINE_STATIC_CALL_NOP_CFI(name);			\
 	__ARCH_DEFINE_STATIC_CALL_RET0_CFI(name)
 
 #define __EXPORT_STATIC_CALL_CFI(name)					\
-	EXPORT_SYMBOL(STATIC_CALL_NOP_CFI(name));			\
 	EXPORT_SYMBOL(STATIC_CALL_RET0_CFI(name))
 
 #define __EXPORT_STATIC_CALL_CFI_GPL(name)				\
-	EXPORT_SYMBOL_GPL(STATIC_CALL_NOP_CFI(name));		\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_RET0_CFI(name))
 
 #else /* ! CONFIG_CFI_WITHOUT_STATIC_CALL */
 
-#define __STATIC_CALL_NOP(name)		(void *)__static_call_nop
 #define __STATIC_CALL_RET0(name)	(void *)__static_call_return0
 
 #define __DECLARE_STATIC_CALL_CFI(name, func)
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
index 2e2481c3f54e..72732af51cba 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -22,10 +22,6 @@
 #define STATIC_CALL_TRAMP(name)		__PASTE(STATIC_CALL_TRAMP_PREFIX, name)
 #define STATIC_CALL_TRAMP_STR(name)	__stringify(STATIC_CALL_TRAMP(name))
 
-#define STATIC_CALL_NOP_CFI_PREFIX	__SCN__
-#define STATIC_CALL_NOP_CFI(name)	__PASTE(STATIC_CALL_NOP_CFI_PREFIX, name)
-#define STATIC_CALL_NOP_CFI_STR(name)	__stringify(STATIC_CALL_NOP_CFI(name))
-
 #define STATIC_CALL_RET0_CFI_PREFIX	__SCR__
 #define STATIC_CALL_RET0_CFI(name)	__PASTE(STATIC_CALL_RET0_CFI_PREFIX, name)
 #define STATIC_CALL_RET0_CFI_STR(name)	__stringify(STATIC_CALL_RET0_CFI(name))
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f79fd8b87f75..52f1edb8128c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6757,9 +6757,9 @@ static void perf_pending_task(struct callback_head *head)
 #ifdef CONFIG_GUEST_PERF_EVENTS
 struct perf_guest_info_callbacks __rcu *perf_guest_cbs;
 
-DEFINE_STATIC_CALL_RET0(__perf_guest_state, *perf_guest_cbs->state);
-DEFINE_STATIC_CALL_RET0(__perf_guest_get_ip, *perf_guest_cbs->get_ip);
-DEFINE_STATIC_CALL_RET0(__perf_guest_handle_intel_pt_intr, *perf_guest_cbs->handle_intel_pt_intr);
+DEFINE_STATIC_CALL_NULL(__perf_guest_state, *perf_guest_cbs->state);
+DEFINE_STATIC_CALL_NULL(__perf_guest_get_ip, *perf_guest_cbs->get_ip);
+DEFINE_STATIC_CALL_NULL(__perf_guest_handle_intel_pt_intr, *perf_guest_cbs->handle_intel_pt_intr);
 
 void perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
 {
@@ -6783,10 +6783,9 @@ void perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
 		return;
 
 	rcu_assign_pointer(perf_guest_cbs, NULL);
-	static_call_update(__perf_guest_state, (void *)&__static_call_return0);
-	static_call_update(__perf_guest_get_ip, (void *)&__static_call_return0);
-	static_call_update(__perf_guest_handle_intel_pt_intr,
-			   (void *)&__static_call_return0);
+	static_call_update(__perf_guest_state, NULL);
+	static_call_update(__perf_guest_get_ip, NULL);
+	static_call_update(__perf_guest_handle_intel_pt_intr, NULL);
 	synchronize_rcu();
 }
 EXPORT_SYMBOL_GPL(perf_unregister_guest_info_callbacks);
@@ -13766,4 +13765,4 @@ struct cgroup_subsys perf_event_cgrp_subsys = {
 };
 #endif /* CONFIG_CGROUP_PERF */
 
-DEFINE_STATIC_CALL_RET0(perf_snapshot_branch_stack, perf_snapshot_branch_stack_t);
+DEFINE_STATIC_CALL_NULL(perf_snapshot_branch_stack, perf_snapshot_branch_stack_t);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a89de2a2d8f8..e69543a8b098 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6821,7 +6821,6 @@ EXPORT_SYMBOL(preempt_schedule);
 #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #ifndef preempt_schedule_dynamic_enabled
 #define preempt_schedule_dynamic_enabled	preempt_schedule
-#define preempt_schedule_dynamic_disabled	NULL
 #endif
 DEFINE_STATIC_CALL(preempt_schedule, preempt_schedule_dynamic_enabled);
 EXPORT_STATIC_CALL_RO(preempt_schedule);
@@ -6894,7 +6893,6 @@ EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
 #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #ifndef preempt_schedule_notrace_dynamic_enabled
 #define preempt_schedule_notrace_dynamic_enabled	preempt_schedule_notrace
-#define preempt_schedule_notrace_dynamic_disabled	NULL
 #endif
 DEFINE_STATIC_CALL(preempt_schedule_notrace, preempt_schedule_notrace_dynamic_enabled);
 EXPORT_STATIC_CALL_RO(preempt_schedule_notrace);
@@ -8491,13 +8489,11 @@ EXPORT_SYMBOL(__cond_resched);
 #ifdef CONFIG_PREEMPT_DYNAMIC
 #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #define cond_resched_dynamic_enabled	__cond_resched
-#define cond_resched_dynamic_disabled	((void *)&__static_call_return0)
-DEFINE_STATIC_CALL_RET0(cond_resched, __cond_resched);
+DEFINE_STATIC_CALL_NULL(cond_resched, __cond_resched);
 EXPORT_STATIC_CALL_RO(cond_resched);
 
 #define might_resched_dynamic_enabled	__cond_resched
-#define might_resched_dynamic_disabled	((void *)&__static_call_return0)
-DEFINE_STATIC_CALL_RET0(might_resched, __cond_resched);
+DEFINE_STATIC_CALL_NULL(might_resched, __cond_resched);
 EXPORT_STATIC_CALL_RO(might_resched);
 #elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
 static DEFINE_STATIC_KEY_FALSE(sk_dynamic_cond_resched);
@@ -8643,7 +8639,7 @@ int sched_dynamic_mode(const char *str)
 
 #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #define preempt_dynamic_enable(f)	static_call_update(f, f##_dynamic_enabled)
-#define preempt_dynamic_disable(f)	static_call_update(f, f##_dynamic_disabled)
+#define preempt_dynamic_disable(f)	static_call_update(f, NULL)
 #elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
 #define preempt_dynamic_enable(f)	static_key_enable(&sk_dynamic_##f.key)
 #define preempt_dynamic_disable(f)	static_key_disable(&sk_dynamic_##f.key)
diff --git a/kernel/static_call.c b/kernel/static_call.c
index 20bf34bc3e2a..090ecf5d34b4 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -9,11 +9,6 @@ long __static_call_return0(void)
 }
 EXPORT_SYMBOL_GPL(__static_call_return0);
 
-void __static_call_nop(void)
-{
-}
-EXPORT_SYMBOL_GPL(__static_call_nop);
-
 #if defined(CONFIG_HAVE_STATIC_CALL) && !defined(CONFIG_HAVE_STATIC_CALL_INLINE)
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 {
diff --git a/tools/include/linux/static_call_types.h b/tools/include/linux/static_call_types.h
index 2e2481c3f54e..72732af51cba 100644
--- a/tools/include/linux/static_call_types.h
+++ b/tools/include/linux/static_call_types.h
@@ -22,10 +22,6 @@
 #define STATIC_CALL_TRAMP(name)		__PASTE(STATIC_CALL_TRAMP_PREFIX, name)
 #define STATIC_CALL_TRAMP_STR(name)	__stringify(STATIC_CALL_TRAMP(name))
 
-#define STATIC_CALL_NOP_CFI_PREFIX	__SCN__
-#define STATIC_CALL_NOP_CFI(name)	__PASTE(STATIC_CALL_NOP_CFI_PREFIX, name)
-#define STATIC_CALL_NOP_CFI_STR(name)	__stringify(STATIC_CALL_NOP_CFI(name))
-
 #define STATIC_CALL_RET0_CFI_PREFIX	__SCR__
 #define STATIC_CALL_RET0_CFI(name)	__PASTE(STATIC_CALL_RET0_CFI_PREFIX, name)
 #define STATIC_CALL_RET0_CFI_STR(name)	__stringify(STATIC_CALL_RET0_CFI(name))
-- 
2.39.2

