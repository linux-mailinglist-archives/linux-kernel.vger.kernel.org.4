Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B416C4166
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 05:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjCVEBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 00:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjCVEAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 00:00:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22ACF4D421
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 21:00:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A960EB81B07
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D893CC433A7;
        Wed, 22 Mar 2023 04:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679457628;
        bh=qjI5SVHqDJvNpjFb1YqUeFS5pXrdEquAw81GDMiBKA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=byGUn35/G40su0Sy/SeTCsEwldfAbig96JeRetvJ+HCHwMOcsgv5h8jshTaZ4D+nB
         eUyBz2SGQ19I0q4oGRIGU220yXOxPEph5PgFiIAh35vncQa6XZg0gLQuqOZQOQwC/w
         YaBiXZoVv+K6qnoJWEbdbqiEmvtr5+TOMMukhmtMHyQFvXmgicgZ6eRVBQh4KXG6fO
         rrNxFVHI4cQn45qC9VXvYIGKGTEJosEWGwfPoQL4VWGMj5DElzSQYPMa63PRdArxIC
         hm3mjFjrHpz4qra27oEXnUcgT4ELjEaQQ7Ug+N+Lypl7MMLVnYuu1sy7mg7IA1u4lP
         eH8CWVqoF2iSA==
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
Subject: [PATCH v2 09/11] static_call: Make NULL static calls consistent
Date:   Tue, 21 Mar 2023 21:00:15 -0700
Message-Id: <7638861ae89606b1277ad4235654bba2b880f313.1679456900.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679456900.git.jpoimboe@kernel.org>
References: <cover.1679456900.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NULL static calls have inconsistent behavior.  With HAVE_STATIC_CALL=y
they're a NOP, but with HAVE_STATIC_CALL=n they go boom.

That's guaranteed to cause subtle bugs.  Make the behavior consistent by
making NULL static calls a NOP with HAVE_STATIC_CALL=n.

This is probably easier than doing the reverse (making NULL static calls
panic with HAVE_STATIC_CALL=y).  And it seems to match the current use
cases better: there are several call sites which rely on the NOP
behavior, whereas no call sites rely on the crashing behavior.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/arm64/include/asm/static_call.h    |  4 ++
 arch/powerpc/include/asm/static_call.h  |  2 +-
 arch/powerpc/kernel/static_call.c       |  5 +-
 arch/x86/include/asm/static_call.h      |  4 +-
 arch/x86/kernel/static_call.c           | 14 +++--
 include/linux/static_call.h             | 78 +++++++++----------------
 include/linux/static_call_types.h       |  4 ++
 kernel/static_call.c                    |  5 ++
 tools/include/linux/static_call_types.h |  4 ++
 9 files changed, 57 insertions(+), 63 deletions(-)

diff --git a/arch/arm64/include/asm/static_call.h b/arch/arm64/include/asm/static_call.h
index b3489cac7742..02693b404afc 100644
--- a/arch/arm64/include/asm/static_call.h
+++ b/arch/arm64/include/asm/static_call.h
@@ -22,6 +22,10 @@
 	    ".type " name ", @function				\n"	\
 	    ".size " name ", . - " name "			\n")
 
+#define __ARCH_DEFINE_STATIC_CALL_NOP_CFI(name)			\
+	GEN_CFI_SYM(STATIC_CALL_NOP_CFI(name));			\
+	__ARCH_DEFINE_STATIC_CALL_CFI(STATIC_CALL_NOP_CFI_STR(name), "")
+
 #define __ARCH_DEFINE_STATIC_CALL_RET0_CFI(name)			\
 	GEN_CFI_SYM(STATIC_CALL_RET0_CFI(name));			\
 	__ARCH_DEFINE_STATIC_CALL_CFI(STATIC_CALL_RET0_CFI_STR(name), "mov x0, xzr")
diff --git a/arch/powerpc/include/asm/static_call.h b/arch/powerpc/include/asm/static_call.h
index de1018cc522b..744435127574 100644
--- a/arch/powerpc/include/asm/static_call.h
+++ b/arch/powerpc/include/asm/static_call.h
@@ -23,7 +23,7 @@
 #define PPC_SCT_DATA		28		/* Offset of label 2 */
 
 #define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)	__PPC_SCT(name, "b " #func)
-#define ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)	__PPC_SCT(name, "blr")
+#define ARCH_DEFINE_STATIC_CALL_NOP_TRAMP(name)		__PPC_SCT(name, "blr")
 #define ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name)	__PPC_SCT(name, "b .+20")
 
 #endif /* _ASM_POWERPC_STATIC_CALL_H */
diff --git a/arch/powerpc/kernel/static_call.c b/arch/powerpc/kernel/static_call.c
index 863a7aa24650..8bfe46654e01 100644
--- a/arch/powerpc/kernel/static_call.c
+++ b/arch/powerpc/kernel/static_call.c
@@ -8,6 +8,7 @@ void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
 {
 	int err;
 	bool is_ret0 = (func == __static_call_return0);
+	bool is_nop = (func == __static_call_nop);
 	unsigned long target = (unsigned long)(is_ret0 ? tramp + PPC_SCT_RET0 : func);
 	bool is_short = is_offset_in_branch_range((long)target - (long)tramp);
 
@@ -16,13 +17,13 @@ void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
 
 	mutex_lock(&text_mutex);
 
-	if (func && !is_short) {
+	if (!is_nop && !is_short) {
 		err = patch_instruction(tramp + PPC_SCT_DATA, ppc_inst(target));
 		if (err)
 			goto out;
 	}
 
-	if (!func)
+	if (is_nop)
 		err = patch_instruction(tramp, ppc_inst(PPC_RAW_BLR()));
 	else if (is_short)
 		err = patch_branch(tramp, target, 0);
diff --git a/arch/x86/include/asm/static_call.h b/arch/x86/include/asm/static_call.h
index 14c6b1862e2e..afea6ceeed23 100644
--- a/arch/x86/include/asm/static_call.h
+++ b/arch/x86/include/asm/static_call.h
@@ -48,10 +48,10 @@
 	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, ".byte 0xe9; .long " #func " - (. + 4)")
 
 #ifdef CONFIG_RETHUNK
-#define ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)			\
+#define ARCH_DEFINE_STATIC_CALL_NOP_TRAMP(name)				\
 	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, "jmp __x86_return_thunk")
 #else
-#define ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)			\
+#define ARCH_DEFINE_STATIC_CALL_NOP_TRAMP(name)				\
 	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, "ret; int3; nop; nop; nop")
 #endif
 
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index b70670a98597..27c095c7fc96 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -89,7 +89,7 @@ static void __ref __static_call_transform(void *insn, enum insn_type type,
 
 	case JCC:
 		if (!func) {
-			func = __static_call_return;
+			func = __static_call_return; //FIXME use __static_call_nop()?
 			if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
 				func = x86_return_thunk;
 		}
@@ -139,33 +139,35 @@ static void __static_call_validate(u8 *insn, bool tail, bool tramp)
 	BUG();
 }
 
-static inline enum insn_type __sc_insn(bool null, bool tail)
+static inline enum insn_type __sc_insn(bool nop, bool tail)
 {
 	/*
 	 * Encode the following table without branches:
 	 *
-	 *	tail	null	insn
+	 *	tail	nop	insn
 	 *	-----+-------+------
 	 *	  0  |   0   |  CALL
 	 *	  0  |   1   |  NOP
 	 *	  1  |   0   |  JMP
 	 *	  1  |   1   |  RET
 	 */
-	return 2*tail + null;
+	return 2*tail + nop;
 }
 
 void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
 {
+	bool nop = (func == __static_call_nop);
+
 	mutex_lock(&text_mutex);
 
 	if (tramp) {
 		__static_call_validate(tramp, true, true);
-		__static_call_transform(tramp, __sc_insn(!func, true), func, false);
+		__static_call_transform(tramp, __sc_insn(nop, true), func, false);
 	}
 
 	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE) && site) {
 		__static_call_validate(site, tail, false);
-		__static_call_transform(site, __sc_insn(!func, tail), func, false);
+		__static_call_transform(site, __sc_insn(nop, tail), func, false);
 	}
 
 	mutex_unlock(&text_mutex);
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 50ad928afeb8..65ac01179993 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -66,24 +66,16 @@
  *
  * Notes on NULL function pointers:
  *
- *   Static_call()s support NULL functions, with many of the caveats that
- *   regular function pointers have.
+ *   A static_call() to a NULL function pointer is a NOP.
  *
- *   Clearly calling a NULL function pointer is 'BAD', so too for
- *   static_call()s (although when HAVE_STATIC_CALL it might not be immediately
- *   fatal). A NULL static_call can be the result of:
+ *   A NULL static call can be the result of:
  *
  *     DECLARE_STATIC_CALL_NULL(my_static_call, void (*)(int));
  *
- *   which is equivalent to declaring a NULL function pointer with just a
- *   typename:
- *
- *     void (*my_func_ptr)(int arg1) = NULL;
- *
- *   or using static_call_update() with a NULL function. In both cases the
- *   HAVE_STATIC_CALL implementation will patch the trampoline with a RET
- *   instruction, instead of an immediate tail-call JMP. HAVE_STATIC_CALL_INLINE
- *   architectures can patch the trampoline call to a NOP.
+ *   or using static_call_update() with a NULL function pointer. In both cases
+ *   the HAVE_STATIC_CALL implementation will patch the trampoline with a RET
+*    instruction, instead of an immediate tail-call JMP. HAVE_STATIC_CALL_INLINE
+*    architectures can patch the trampoline call to a NOP.
  *
  *   In all cases, any argument evaluation is unconditional. Unlike a regular
  *   conditional function pointer call:
@@ -91,14 +83,7 @@
  *     if (my_func_ptr)
  *         my_func_ptr(arg1)
  *
- *   where the argument evaludation also depends on the pointer value.
- *
- *   When calling a static_call that can be NULL, use:
- *
- *     static_call_cond(name)(arg1);
- *
- *   which will include the required value tests to avoid NULL-pointer
- *   dereferences.
+ *   where the argument evaluation also depends on the pointer value.
  *
  *   To query which function is currently set to be called, use:
  *
@@ -147,6 +132,7 @@ struct static_call_key {
 #endif
 };
 
+extern void __static_call_nop(void);
 extern long __static_call_return0(void);
 
 #define DECLARE_STATIC_CALL(name, func)					\
@@ -166,8 +152,8 @@ extern long __static_call_return0(void);
 	__DEFINE_STATIC_CALL_TRAMP(name, func)
 
 #define DEFINE_STATIC_CALL_NULL(name, type)				\
-	__DEFINE_STATIC_CALL(name, type, NULL);				\
-	__DEFINE_STATIC_CALL_NULL_TRAMP(name)
+	__DEFINE_STATIC_CALL(name, type, __STATIC_CALL_NOP(name));	\
+	__DEFINE_STATIC_CALL_NOP_TRAMP(name)
 
 #define DEFINE_STATIC_CALL_RET0(name, type)				\
 	__DEFINE_STATIC_CALL(name, type, __STATIC_CALL_RET0(name));	\
@@ -212,7 +198,7 @@ extern long __static_call_return0(void);
 	__static_call(name);						\
 })
 
-#define static_call_cond(name)		(void)__static_call_cond(name)
+#define static_call_cond(name)		(void)static_call(name)
 
 /* Use static_call_ro() to call a read-only-exported static call. */
 #define static_call_ro(name)		__static_call_ro(name)
@@ -228,7 +214,9 @@ extern long __static_call_return0(void);
 #define static_call_update(name, func)					\
 ({									\
 	typeof(&STATIC_CALL_TRAMP(name)) __F = (func);			\
-	if (__F == (void *)__static_call_return0)			\
+	if (!__F)							\
+		__F = __STATIC_CALL_NOP(name);				\
+	else if (__F == (void *)__static_call_return0)			\
 		__F = __STATIC_CALL_RET0(name);				\
 	__static_call_update(&STATIC_CALL_KEY(name),			\
 			     STATIC_CALL_TRAMP_ADDR(name), __F);	\
@@ -237,7 +225,9 @@ extern long __static_call_return0(void);
 #define static_call_query(name)						\
 ({									\
 	void *__F = (READ_ONCE(STATIC_CALL_KEY(name).func));		\
-	if (__F == __STATIC_CALL_RET0(name))			\
+	if (__F == __STATIC_CALL_NOP(name))				\
+		__F = NULL;						\
+	else if (__F == __STATIC_CALL_RET0(name))			\
 		__F = __static_call_return0;				\
 	__F;								\
 })
@@ -249,8 +239,8 @@ extern long __static_call_return0(void);
 #define __DEFINE_STATIC_CALL_TRAMP(name, func)				\
 	ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)
 
-#define __DEFINE_STATIC_CALL_NULL_TRAMP(name)				\
-	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
+#define __DEFINE_STATIC_CALL_NOP_TRAMP(name)				\
+	ARCH_DEFINE_STATIC_CALL_NOP_TRAMP(name)
 
 #define __DEFINE_STATIC_CALL_RET0_TRAMP(name)				\
 	ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name)
@@ -262,7 +252,6 @@ extern long __static_call_return0(void);
 	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
 
 #define __static_call(name)		(&STATIC_CALL_TRAMP(name))
-#define __static_call_cond		__static_call
 
 #define STATIC_CALL_TRAMP_ADDR(name)	&STATIC_CALL_TRAMP(name)
 
@@ -276,7 +265,7 @@ extern void arch_static_call_transform(void *site, void *tramp, void *func, bool
 #else /* !CONFIG_HAVE_STATIC_CALL */
 
 #define __DEFINE_STATIC_CALL_TRAMP(name, func)
-#define __DEFINE_STATIC_CALL_NULL_TRAMP(name)
+#define __DEFINE_STATIC_CALL_NOP_TRAMP(name)
 #define __DEFINE_STATIC_CALL_RET0_TRAMP(name)
 #define __EXPORT_STATIC_CALL_TRAMP(name)
 #define __EXPORT_STATIC_CALL_TRAMP_GPL(name)
@@ -284,27 +273,6 @@ extern void arch_static_call_transform(void *site, void *tramp, void *func, bool
 #define __static_call(name)						\
 	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))
 
-static inline void __static_call_nop(void) { }
-/*
- * This horrific hack takes care of two things:
- *
- *  - it ensures the compiler will only load the function pointer ONCE,
- *    which avoids a reload race.
- *
- *  - it ensures the argument evaluation is unconditional, similar
- *    to the HAVE_STATIC_CALL variant.
- *
- * Sadly current GCC/Clang (10 for both) do not optimize this properly
- * and will emit an indirect call for the NULL case :-(
- */
-#define __static_call_cond(name)					\
-({									\
-	void *func = READ_ONCE(STATIC_CALL_KEY(name).func);		\
-	if (!func)							\
-		func = &__static_call_nop;				\
-	(typeof(STATIC_CALL_TRAMP(name))*)func;				\
-})
-
 #define STATIC_CALL_TRAMP_ADDR(name)	NULL
 
 static inline
@@ -343,22 +311,28 @@ static inline void static_call_force_reinit(void) {}
 
 #include <asm/static_call.h>
 
+#define __STATIC_CALL_NOP(name)		STATIC_CALL_NOP_CFI(name)
 #define __STATIC_CALL_RET0(name)	STATIC_CALL_RET0_CFI(name)
 
 #define __DECLARE_STATIC_CALL_CFI(name, func)				\
+	extern typeof(func) STATIC_CALL_NOP_CFI(name);		\
 	extern typeof(func) STATIC_CALL_RET0_CFI(name)
 
 #define __DEFINE_STATIC_CALL_CFI(name)					\
+	__ARCH_DEFINE_STATIC_CALL_NOP_CFI(name);			\
 	__ARCH_DEFINE_STATIC_CALL_RET0_CFI(name)
 
 #define __EXPORT_STATIC_CALL_CFI(name)					\
+	EXPORT_SYMBOL(STATIC_CALL_NOP_CFI(name));			\
 	EXPORT_SYMBOL(STATIC_CALL_RET0_CFI(name))
 
 #define __EXPORT_STATIC_CALL_CFI_GPL(name)				\
+	EXPORT_SYMBOL_GPL(STATIC_CALL_NOP_CFI(name));		\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_RET0_CFI(name))
 
 #else /* ! CONFIG_CFI_WITHOUT_STATIC_CALL */
 
+#define __STATIC_CALL_NOP(name)		(void *)__static_call_nop
 #define __STATIC_CALL_RET0(name)	(void *)__static_call_return0
 
 #define __DECLARE_STATIC_CALL_CFI(name, func)
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
index 72732af51cba..2e2481c3f54e 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -22,6 +22,10 @@
 #define STATIC_CALL_TRAMP(name)		__PASTE(STATIC_CALL_TRAMP_PREFIX, name)
 #define STATIC_CALL_TRAMP_STR(name)	__stringify(STATIC_CALL_TRAMP(name))
 
+#define STATIC_CALL_NOP_CFI_PREFIX	__SCN__
+#define STATIC_CALL_NOP_CFI(name)	__PASTE(STATIC_CALL_NOP_CFI_PREFIX, name)
+#define STATIC_CALL_NOP_CFI_STR(name)	__stringify(STATIC_CALL_NOP_CFI(name))
+
 #define STATIC_CALL_RET0_CFI_PREFIX	__SCR__
 #define STATIC_CALL_RET0_CFI(name)	__PASTE(STATIC_CALL_RET0_CFI_PREFIX, name)
 #define STATIC_CALL_RET0_CFI_STR(name)	__stringify(STATIC_CALL_RET0_CFI(name))
diff --git a/kernel/static_call.c b/kernel/static_call.c
index 090ecf5d34b4..20bf34bc3e2a 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -9,6 +9,11 @@ long __static_call_return0(void)
 }
 EXPORT_SYMBOL_GPL(__static_call_return0);
 
+void __static_call_nop(void)
+{
+}
+EXPORT_SYMBOL_GPL(__static_call_nop);
+
 #if defined(CONFIG_HAVE_STATIC_CALL) && !defined(CONFIG_HAVE_STATIC_CALL_INLINE)
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 {
diff --git a/tools/include/linux/static_call_types.h b/tools/include/linux/static_call_types.h
index 72732af51cba..2e2481c3f54e 100644
--- a/tools/include/linux/static_call_types.h
+++ b/tools/include/linux/static_call_types.h
@@ -22,6 +22,10 @@
 #define STATIC_CALL_TRAMP(name)		__PASTE(STATIC_CALL_TRAMP_PREFIX, name)
 #define STATIC_CALL_TRAMP_STR(name)	__stringify(STATIC_CALL_TRAMP(name))
 
+#define STATIC_CALL_NOP_CFI_PREFIX	__SCN__
+#define STATIC_CALL_NOP_CFI(name)	__PASTE(STATIC_CALL_NOP_CFI_PREFIX, name)
+#define STATIC_CALL_NOP_CFI_STR(name)	__stringify(STATIC_CALL_NOP_CFI(name))
+
 #define STATIC_CALL_RET0_CFI_PREFIX	__SCR__
 #define STATIC_CALL_RET0_CFI(name)	__PASTE(STATIC_CALL_RET0_CFI_PREFIX, name)
 #define STATIC_CALL_RET0_CFI_STR(name)	__stringify(STATIC_CALL_RET0_CFI(name))
-- 
2.39.2

