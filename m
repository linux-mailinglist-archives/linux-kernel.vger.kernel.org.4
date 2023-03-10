Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902076B51FE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjCJUd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjCJUdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:33:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CAFF940
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 12:33:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB56C61D59
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 20:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D254AC433A7;
        Fri, 10 Mar 2023 20:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678480309;
        bh=162YSDvtqoPYSHnjcw/c0l8hT/AvchzI0YwbmH5+IkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wwn2eQNuQgyFLG550dYlwK31xJpW+ZTqeIqSUYQpRVFdxbxNejleeBKzHXq6qTpHj
         R4b+4CI6IsEkm92Y6zGLqig0vQvB8VEekExr3KcUxgd6lJbI4IijQz78yDTCMUHbJS
         jnFGOlZuiRobBqZqlGHDEGuT3wvHsGvY1aw9nz5B56J3z30NaiLSVAFXIQCdCgeCNT
         VEBJUUrJvDkUZuIy6zizshMt9PgxfH6k2lVFCG47aITFyCqmR6yPQrFoKTHoXXti2R
         6+FJLq30IYbid8zOgIHU2WPaTrIcnHjwZcf/ADlX0bbp+0yIcyLxAWQ9E2PuOcpcNy
         PCWn41SR0hLYw==
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
        Sean Christopherson <seanjc@google.com>
Subject: [RFC][PATCH 2/5] static_call: Make NULL static calls return 0
Date:   Fri, 10 Mar 2023 12:31:14 -0800
Message-Id: <999f0b7f8056dcb51476a6515a8601c9d6374aa2.1678474914.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678474914.git.jpoimboe@kernel.org>
References: <cover.1678474914.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all NULL static calls are just NOPs, the only existing use of
static_call_cond() is to cast static_call() to void.  That prevents
calling code from checking the return value of a NULL static call.

The following results in a compiler error:

  static_call_update(bar, NULL);
  ...
  foo = static_call_cond(bar)();

But the compiler error only happens if somebody remembers to use
static_call_cond().  If they instead use static_call(), 'foo' is
undefined.  So the "protection" of static_call_cond() is a half-hearted,
misleading protection.

If NULL static calls are going to be NOPs, the next logical step is to
have their return values be 0.  In other words, combine NULL and RET0
static calls into a single concept.

While it doesn't necessarily make sense to return 0 for void-return
functions, it's still pretty much harmless.  The return value register
is already callee-clobbered, and an extra "xor %eax, %eax" shouldn't
move the needle on performance.

This "do nothing return 0" default should work for the vast majority of
cases.  Otherwise it can be easily overridden with a user-specified
function which panics or returns 0xdeadbeef or does whatever you want.

This simplifies the static call code and also tends to help simplify
users' code as well.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/powerpc/include/asm/static_call.h |   1 -
 arch/x86/include/asm/static_call.h     |   8 --
 include/linux/static_call.h            | 100 +++++++++----------------
 3 files changed, 34 insertions(+), 75 deletions(-)

diff --git a/arch/powerpc/include/asm/static_call.h b/arch/powerpc/include/asm/static_call.h
index de1018cc522b..0b17fc551157 100644
--- a/arch/powerpc/include/asm/static_call.h
+++ b/arch/powerpc/include/asm/static_call.h
@@ -23,7 +23,6 @@
 #define PPC_SCT_DATA		28		/* Offset of label 2 */
 
 #define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)	__PPC_SCT(name, "b " #func)
-#define ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)	__PPC_SCT(name, "blr")
 #define ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name)	__PPC_SCT(name, "b .+20")
 
 #endif /* _ASM_POWERPC_STATIC_CALL_H */
diff --git a/arch/x86/include/asm/static_call.h b/arch/x86/include/asm/static_call.h
index 343b722ccaf2..118d3d2b837f 100644
--- a/arch/x86/include/asm/static_call.h
+++ b/arch/x86/include/asm/static_call.h
@@ -46,14 +46,6 @@
 #define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)			\
 	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, ".byte 0xe9; .long " #func " - (. + 4)")
 
-#ifdef CONFIG_RETHUNK
-#define ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)			\
-	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, "jmp __x86_return_thunk")
-#else
-#define ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)			\
-	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, "ret; int3; nop; nop; nop")
-#endif
-
 #define ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name)			\
 	ARCH_DEFINE_STATIC_CALL_TRAMP(name, __static_call_return0)
 
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 8b12216da0da..58783d112df5 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -65,47 +65,31 @@
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
- *   or using static_call_update() with a NULL function. In both cases the
- *   HAVE_STATIC_CALL implementation will patch the trampoline with a RET
- *   instruction, instead of an immediate tail-call JMP. HAVE_STATIC_CALL_INLINE
- *   architectures can patch the trampoline call to a NOP.
+ *   or using static_call_update() with a NULL function.
  *
- *   In all cases, any argument evaluation is unconditional. Unlike a regular
- *   conditional function pointer call:
+ *   The "return 0" feature is strictly UB per the C standard (since it casts a
+ *   function pointer to a different signature) and relies on the architecture
+ *   ABI to make things work. In particular it relies on the return value
+ *   register being callee-clobbered for all function calls.
  *
- *     if (my_func_ptr)
- *         my_func_ptr(arg1)
- *
- *   where the argument evaludation also depends on the pointer value.
- *
- *   To query which function is currently set to be called, use:
- *
- *   func = static_call_query(name);
+ *   In particular The x86_64 implementation of HAVE_STATIC_CALL_INLINE
+ *   replaces the 5 byte CALL instruction at the callsite with a 5 byte clear
+ *   of the RAX register, completely eliding any function call overhead.
  *
+ *   Any argument evaluation is unconditional. Unlike a regular conditional
+ *   function pointer call:
  *
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
+ *     if (my_func_ptr)
+ *         my_func_ptr(arg1)
  *
- *   Notably argument setup is unconditional.
+ *   where the argument evaluation also depends on the pointer value.
  *
  *
  * EXPORT_STATIC_CALL() vs EXPORT_STATIC_CALL_TRAMP():
@@ -134,14 +118,21 @@ extern void arch_static_call_transform(void *site, void *tramp, void *func, bool
 #define STATIC_CALL_TRAMP_ADDR(name) NULL
 #endif
 
+extern long __static_call_return0(void);
+
 #define static_call_update(name, func)					\
 ({									\
 	typeof(&STATIC_CALL_TRAMP(name)) __F = (func);			\
+	void *__f = (void *)__F ? : (void *)__static_call_return0;	\
 	__static_call_update(&STATIC_CALL_KEY(name),			\
-			     STATIC_CALL_TRAMP_ADDR(name), __F);	\
+			     STATIC_CALL_TRAMP_ADDR(name), __f);	\
 })
 
-#define static_call_query(name) (READ_ONCE(STATIC_CALL_KEY(name).func))
+#define static_call_query(name)						\
+({									\
+	void *__func = (READ_ONCE(STATIC_CALL_KEY(name).func));		\
+	__func == __static_call_return0 ? NULL : __func;		\
+})
 
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
 
@@ -165,8 +156,6 @@ extern void __static_call_update(struct static_call_key *key, void *tramp, void
 extern int static_call_mod_init(struct module *mod);
 extern int static_call_text_reserved(void *start, void *end);
 
-extern long __static_call_return0(void);
-
 #define DEFINE_STATIC_CALL(name, _func)					\
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
@@ -176,14 +165,6 @@ extern long __static_call_return0(void);
 	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
 
 #define DEFINE_STATIC_CALL_NULL(name, _func)				\
-	DECLARE_STATIC_CALL(name, _func);				\
-	struct static_call_key STATIC_CALL_KEY(name) = {		\
-		.func = NULL,						\
-		.type = 1,						\
-	};								\
-	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
-
-#define DEFINE_STATIC_CALL_RET0(name, _func)				\
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
 		.func = __static_call_return0,				\
@@ -191,7 +172,9 @@ extern long __static_call_return0(void);
 	};								\
 	ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name)
 
-#define static_call_cond(name)	(void)__static_call(name)
+#define DEFINE_STATIC_CALL_RET0 DEFINE_STATIC_CALL_NULL
+
+#define static_call_cond(name)	__static_call(name)
 
 #define EXPORT_STATIC_CALL(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
@@ -222,18 +205,13 @@ static inline int static_call_init(void) { return 0; }
 #define DEFINE_STATIC_CALL_NULL(name, _func)				\
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
-		.func = NULL,						\
+		.func = __static_call_return0,				\
 	};								\
 	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
 
-#define DEFINE_STATIC_CALL_RET0(name, _func)				\
-	DECLARE_STATIC_CALL(name, _func);				\
-	struct static_call_key STATIC_CALL_KEY(name) = {		\
-		.func = __static_call_return0,				\
-	};								\
-	ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name)
+#define DEFINE_STATIC_CALL_RET0 DEFINE_STATIC_CALL_NULL
 
-#define static_call_cond(name)	(void)__static_call(name)
+#define static_call_cond(name)	__static_call(name)
 
 static inline
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
@@ -249,8 +227,6 @@ static inline int static_call_text_reserved(void *start, void *end)
 	return 0;
 }
 
-extern long __static_call_return0(void);
-
 #define EXPORT_STATIC_CALL(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
 	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
@@ -268,13 +244,6 @@ extern long __static_call_return0(void);
 
 static inline int static_call_init(void) { return 0; }
 
-static inline void __static_call_nop(void) { }
-
-static inline long __static_call_return0(void)
-{
-	return 0;
-}
-
 #define __DEFINE_STATIC_CALL(name, _func, _func_init)			\
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
@@ -285,17 +254,16 @@ static inline long __static_call_return0(void)
 	__DEFINE_STATIC_CALL(name, _func, _func)
 
 #define DEFINE_STATIC_CALL_NULL(name, _func)				\
-	__DEFINE_STATIC_CALL(name, _func, __static_call_nop)
-
-#define DEFINE_STATIC_CALL_RET0(name, _func)				\
 	__DEFINE_STATIC_CALL(name, _func, __static_call_return0)
 
-#define static_call_cond(name) (void)static_call(name)
+#define DEFINE_STATIC_CALL_RET0 DEFINE_STATIC_CALL_NULL
+
+#define static_call_cond(name) static_call(name)
 
 static inline
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 {
-	WRITE_ONCE(key->func, func ? : (void *)__static_call_nop);
+	WRITE_ONCE(key->func, func);
 }
 
 static inline int static_call_text_reserved(void *start, void *end)
-- 
2.39.2

