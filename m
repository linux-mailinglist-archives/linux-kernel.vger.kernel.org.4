Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FF46011C2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiJQOyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiJQOx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:53:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429D268CF9;
        Mon, 17 Oct 2022 07:53:46 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:53:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018420;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8nYvTgfwwsWkVvSHe1CjhPKH3cfGxwCeg/eOBd74qts=;
        b=BbKG4RfqcElMfSoQ4wC4d8mqG0cNDnEyDjeu7MvSBRluR4aICG3447n75UAYd7F8pfgsT4
        EHX4Qb+7C0xgxVwTy2lE1OT64UF6z3WtqXFwqxEBhxua3ZLsnavv8k276NfEOKVSAnG5pW
        0XSPrugrzLcvmcBepdN1PfldjzBSbh0Q0a3ghKCimr7XGZp0S42xR21ECsy7Stnu62+Zoy
        jGoT6Nw27AfT0wUMP5hRUhw6wvNvsHjVPWvTCVHC9CIGyr4ZaWjp1adu1Fhopq8eMuKcLl
        2xbkYy7s+MLrSKA+FlNhI0fNa+6GlpPdDoAvvQW3QT6iTFWTxHVVe2sgHtF1GA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018420;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8nYvTgfwwsWkVvSHe1CjhPKH3cfGxwCeg/eOBd74qts=;
        b=o47p/lDLKvFPpklzmAPAtoAVbRTOaKGl+fz/WjUhg67FT3YLM8XA2UTq3ddHG3YK1GSwUS
        0Y0mF5rH66qV/JAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/retpoline: Add SKL retthunk retpolines
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111147.996634749@infradead.org>
References: <20220915111147.996634749@infradead.org>
MIME-Version: 1.0
Message-ID: <166601841951.401.10547986435032366895.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     3b6c1747da48ff40ab746b0e860cffe83619f5c5
Gitweb:        https://git.kernel.org/tip/3b6c1747da48ff40ab746b0e860cffe83619f5c5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 15 Sep 2022 13:11:28 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:15 +02:00

x86/retpoline: Add SKL retthunk retpolines

Ensure that retpolines do the proper call accounting so that the return
accounting works correctly.

Specifically; retpolines are used to replace both 'jmp *%reg' and
'call *%reg', however these two cases do not have the same accounting
requirements. Therefore split things up and provide two different
retpoline arrays for SKL.

The 'jmp *%reg' case needs no accounting, the
__x86_indirect_jump_thunk_array[] covers this. The retpoline is
changed to not use the return thunk; it's a simple call;ret construct.

[ strictly speaking it should do:
	andq $(~0x1f), PER_CPU_VAR(__x86_call_depth)
  but we can argue this can be covered by the fuzz we already have
  in the accounting depth (12) vs the RSB depth (16) ]

The 'call *%reg' case does need accounting, the
__x86_indirect_call_thunk_array[] covers this. Again, this retpoline
avoids the use of the return-thunk, in this case to avoid double
accounting.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111147.996634749@infradead.org
---
 arch/x86/include/asm/nospec-branch.h | 12 +++++-
 arch/x86/kernel/alternative.c        | 59 ++++++++++++++++++++--
 arch/x86/lib/retpoline.S             | 71 +++++++++++++++++++++++----
 arch/x86/net/bpf_jit_comp.c          |  5 +-
 4 files changed, 135 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index d4be826..06ba7ca 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -301,6 +301,8 @@
 
 typedef u8 retpoline_thunk_t[RETPOLINE_THUNK_SIZE];
 extern retpoline_thunk_t __x86_indirect_thunk_array[];
+extern retpoline_thunk_t __x86_indirect_call_thunk_array[];
+extern retpoline_thunk_t __x86_indirect_jump_thunk_array[];
 
 extern void __x86_return_thunk(void);
 extern void zen_untrain_ret(void);
@@ -330,6 +332,16 @@ static inline void x86_set_skl_return_thunk(void) {}
 #include <asm/GEN-for-each-reg.h>
 #undef GEN
 
+#define GEN(reg)						\
+	extern retpoline_thunk_t __x86_indirect_call_thunk_ ## reg;
+#include <asm/GEN-for-each-reg.h>
+#undef GEN
+
+#define GEN(reg)						\
+	extern retpoline_thunk_t __x86_indirect_jump_thunk_ ## reg;
+#include <asm/GEN-for-each-reg.h>
+#undef GEN
+
 #ifdef CONFIG_X86_64
 
 /*
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 04d1e3d..19221d7 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -377,6 +377,56 @@ static int emit_indirect(int op, int reg, u8 *bytes)
 	return i;
 }
 
+static inline bool is_jcc32(struct insn *insn)
+{
+	/* Jcc.d32 second opcode byte is in the range: 0x80-0x8f */
+	return insn->opcode.bytes[0] == 0x0f && (insn->opcode.bytes[1] & 0xf0) == 0x80;
+}
+
+static int emit_call_track_retpoline(void *addr, struct insn *insn, int reg, u8 *bytes)
+{
+	u8 op = insn->opcode.bytes[0];
+	int i = 0;
+
+	/*
+	 * Clang does 'weird' Jcc __x86_indirect_thunk_r11 conditional
+	 * tail-calls. Deal with them.
+	 */
+	if (is_jcc32(insn)) {
+		bytes[i++] = op;
+		op = insn->opcode.bytes[1];
+		goto clang_jcc;
+	}
+
+	if (insn->length == 6)
+		bytes[i++] = 0x2e; /* CS-prefix */
+
+	switch (op) {
+	case CALL_INSN_OPCODE:
+		__text_gen_insn(bytes+i, op, addr+i,
+				__x86_indirect_call_thunk_array[reg],
+				CALL_INSN_SIZE);
+		i += CALL_INSN_SIZE;
+		break;
+
+	case JMP32_INSN_OPCODE:
+clang_jcc:
+		__text_gen_insn(bytes+i, op, addr+i,
+				__x86_indirect_jump_thunk_array[reg],
+				JMP32_INSN_SIZE);
+		i += JMP32_INSN_SIZE;
+		break;
+
+	default:
+		WARN("%pS %px %*ph\n", addr, addr, 6, addr);
+		return -1;
+	}
+
+	WARN_ON_ONCE(i != insn->length);
+
+	return i;
+}
+
 /*
  * Rewrite the compiler generated retpoline thunk calls.
  *
@@ -409,8 +459,12 @@ static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
 	BUG_ON(reg == 4);
 
 	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE) &&
-	    !cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE))
+	    !cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {
+		if (cpu_feature_enabled(X86_FEATURE_CALL_DEPTH))
+			return emit_call_track_retpoline(addr, insn, reg, bytes);
+
 		return -1;
+	}
 
 	op = insn->opcode.bytes[0];
 
@@ -427,8 +481,7 @@ static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
 	 *   [ NOP ]
 	 * 1:
 	 */
-	/* Jcc.d32 second opcode byte is in the range: 0x80-0x8f */
-	if (op == 0x0f && (insn->opcode.bytes[1] & 0xf0) == 0x80) {
+	if (is_jcc32(insn)) {
 		cc = insn->opcode.bytes[1] & 0xf;
 		cc ^= 1; /* invert condition */
 
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 1e79ecc..e002060 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -14,17 +14,18 @@
 
 	.section .text.__x86.indirect_thunk
 
-.macro RETPOLINE reg
+
+.macro POLINE reg
 	ANNOTATE_INTRA_FUNCTION_CALL
 	call    .Ldo_rop_\@
-.Lspec_trap_\@:
-	UNWIND_HINT_EMPTY
-	pause
-	lfence
-	jmp .Lspec_trap_\@
+	int3
 .Ldo_rop_\@:
 	mov     %\reg, (%_ASM_SP)
 	UNWIND_HINT_FUNC
+.endm
+
+.macro RETPOLINE reg
+	POLINE \reg
 	RET
 .endm
 
@@ -54,7 +55,6 @@ SYM_INNER_LABEL(__x86_indirect_thunk_\reg, SYM_L_GLOBAL)
  */
 
 #define __EXPORT_THUNK(sym)	_ASM_NOKPROBE(sym); EXPORT_SYMBOL(sym)
-#define EXPORT_THUNK(reg)	__EXPORT_THUNK(__x86_indirect_thunk_ ## reg)
 
 	.align RETPOLINE_THUNK_SIZE
 SYM_CODE_START(__x86_indirect_thunk_array)
@@ -66,10 +66,65 @@ SYM_CODE_START(__x86_indirect_thunk_array)
 	.align RETPOLINE_THUNK_SIZE
 SYM_CODE_END(__x86_indirect_thunk_array)
 
-#define GEN(reg) EXPORT_THUNK(reg)
+#define GEN(reg) __EXPORT_THUNK(__x86_indirect_thunk_ ## reg)
+#include <asm/GEN-for-each-reg.h>
+#undef GEN
+
+#ifdef CONFIG_CALL_DEPTH_TRACKING
+.macro CALL_THUNK reg
+	.align RETPOLINE_THUNK_SIZE
+
+SYM_INNER_LABEL(__x86_indirect_call_thunk_\reg, SYM_L_GLOBAL)
+	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
+
+	CALL_DEPTH_ACCOUNT
+	POLINE \reg
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+.endm
+
+	.align RETPOLINE_THUNK_SIZE
+SYM_CODE_START(__x86_indirect_call_thunk_array)
+
+#define GEN(reg) CALL_THUNK reg
 #include <asm/GEN-for-each-reg.h>
 #undef GEN
 
+	.align RETPOLINE_THUNK_SIZE
+SYM_CODE_END(__x86_indirect_call_thunk_array)
+
+#define GEN(reg) __EXPORT_THUNK(__x86_indirect_call_thunk_ ## reg)
+#include <asm/GEN-for-each-reg.h>
+#undef GEN
+
+.macro JUMP_THUNK reg
+	.align RETPOLINE_THUNK_SIZE
+
+SYM_INNER_LABEL(__x86_indirect_jump_thunk_\reg, SYM_L_GLOBAL)
+	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
+	POLINE \reg
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+.endm
+
+	.align RETPOLINE_THUNK_SIZE
+SYM_CODE_START(__x86_indirect_jump_thunk_array)
+
+#define GEN(reg) JUMP_THUNK reg
+#include <asm/GEN-for-each-reg.h>
+#undef GEN
+
+	.align RETPOLINE_THUNK_SIZE
+SYM_CODE_END(__x86_indirect_jump_thunk_array)
+
+#define GEN(reg) __EXPORT_THUNK(__x86_indirect_jump_thunk_ ## reg)
+#include <asm/GEN-for-each-reg.h>
+#undef GEN
+#endif
 /*
  * This function name is magical and is used by -mfunction-return=thunk-extern
  * for the compiler to generate JMPs to it.
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 0df391e..ad8cb7f 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -417,7 +417,10 @@ static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
 		EMIT2(0xFF, 0xE0 + reg);
 	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
 		OPTIMIZER_HIDE_VAR(reg);
-		emit_jump(&prog, &__x86_indirect_thunk_array[reg], ip);
+		if (cpu_feature_enabled(X86_FEATURE_CALL_DEPTH))
+			emit_jump(&prog, &__x86_indirect_jump_thunk_array[reg], ip);
+		else
+			emit_jump(&prog, &__x86_indirect_thunk_array[reg], ip);
 	} else {
 		EMIT2(0xFF, 0xE0 + reg);	/* jmp *%\reg */
 		if (IS_ENABLED(CONFIG_RETPOLINE) || IS_ENABLED(CONFIG_SLS))
