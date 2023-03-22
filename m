Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D966C4163
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 05:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjCVEA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 00:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjCVEAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 00:00:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C510A4BE96
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 21:00:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55A78B81B04
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E856C433EF;
        Wed, 22 Mar 2023 04:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679457627;
        bh=tb5QGkQcKrmN7Wm/CAvKL0u/Ga2rvVEu68/h2UtgX30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OeAR1xl3qz3lSIgmEmstlXdDKpTgH5daqrwgwb1svDcx/JYf5SC/V3XUSiU5GVltU
         eGu2ycVrh06TwCqMcuoR+nhleIVna0Ryd39Pq1p/6qbg9qUiLUUgdHpgaUnyw6wB2N
         VzxDW22Rud/BBmJtIaphSlpJ59ENJI9M9MYLfnV5sUGddDxkW5YSI9ahCR3Ab0rvyX
         BUVwlTPFtXUZX19JNTvSdf8D7vSsbXRMMgKmML8wRqYAf6NJ9r1cSMvhPVFwpJqb36
         1aacCKxi6b6PngHaenG7vkpWtRBVhu4SCNE3EOTxWIoyiPdvnJIjrnrTw5M9Wtcu9n
         9rtPHuKF5pQiw==
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
Subject: [PATCH v2 07/11] static_call: Reorganize static call headers
Date:   Tue, 21 Mar 2023 21:00:13 -0700
Message-Id: <315c9c6959d53bcdfc05e64a90bfd465137aca95.1679456900.git.jpoimboe@kernel.org>
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

Move all the extra gunk out of static_call_types.h, which is for sharing
types with objtool.

While at it, de-spaghettify static_call.h, with user-visible interfaces
at the top, and implementation differences more clearly separated.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/arm/include/asm/paravirt.h         |   2 +-
 arch/arm64/include/asm/paravirt.h       |   2 +-
 arch/x86/include/asm/paravirt.h         |   2 +-
 arch/x86/include/asm/preempt.h          |   2 +-
 arch/x86/include/asm/static_call.h      |   3 +-
 arch/x86/kernel/paravirt.c              |   1 +
 include/linux/entry-common.h            |   2 +-
 include/linux/entry-kvm.h               |   2 +-
 include/linux/kernel.h                  |   2 +-
 include/linux/module.h                  |   2 +-
 include/linux/static_call.h             | 250 +++++++++++-------------
 include/linux/static_call_types.h       |  70 +------
 kernel/static_call.c                    |   1 +
 kernel/static_call_inline.c             |  13 ++
 tools/include/linux/static_call_types.h |  70 +------
 15 files changed, 148 insertions(+), 276 deletions(-)

diff --git a/arch/arm/include/asm/paravirt.h b/arch/arm/include/asm/paravirt.h
index 95d5b0d625cd..37a723b653f5 100644
--- a/arch/arm/include/asm/paravirt.h
+++ b/arch/arm/include/asm/paravirt.h
@@ -3,7 +3,7 @@
 #define _ASM_ARM_PARAVIRT_H
 
 #ifdef CONFIG_PARAVIRT
-#include <linux/static_call_types.h>
+#include <linux/static_call.h>
 
 struct static_key;
 extern struct static_key paravirt_steal_enabled;
diff --git a/arch/arm64/include/asm/paravirt.h b/arch/arm64/include/asm/paravirt.h
index 9aa193e0e8f2..f59cb310d8ef 100644
--- a/arch/arm64/include/asm/paravirt.h
+++ b/arch/arm64/include/asm/paravirt.h
@@ -3,7 +3,7 @@
 #define _ASM_ARM64_PARAVIRT_H
 
 #ifdef CONFIG_PARAVIRT
-#include <linux/static_call_types.h>
+#include <linux/static_call.h>
 
 struct static_key;
 extern struct static_key paravirt_steal_enabled;
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index cf40e813b3d7..25d7696be801 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -15,7 +15,7 @@
 #include <linux/bug.h>
 #include <linux/types.h>
 #include <linux/cpumask.h>
-#include <linux/static_call_types.h>
+#include <linux/static_call.h>
 #include <asm/frame.h>
 
 u64 dummy_steal_clock(int cpu);
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 65028c346709..0879ec504b31 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -7,7 +7,7 @@
 #include <asm/current.h>
 
 #include <linux/thread_info.h>
-#include <linux/static_call_types.h>
+#include <linux/static_call.h>
 
 /* We use the MSB mostly because its available */
 #define PREEMPT_NEED_RESCHED	0x80000000
diff --git a/arch/x86/include/asm/static_call.h b/arch/x86/include/asm/static_call.h
index 52abbdfd6106..14c6b1862e2e 100644
--- a/arch/x86/include/asm/static_call.h
+++ b/arch/x86/include/asm/static_call.h
@@ -2,7 +2,8 @@
 #ifndef _ASM_STATIC_CALL_H
 #define _ASM_STATIC_CALL_H
 
-#include <asm/text-patching.h>
+#include <linux/objtool.h>
+#include <linux/static_call_types.h>
 
 /*
  * For CONFIG_HAVE_STATIC_CALL_INLINE, this is a temporary trampoline which
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 42e182868873..378aaa2925ad 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -33,6 +33,7 @@
 #include <asm/tlb.h>
 #include <asm/io_bitmap.h>
 #include <asm/gsseg.h>
+#include <asm/text-patching.h>
 
 /*
  * nop stub, which must not clobber anything *including the stack* to
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index d95ab85f96ba..c89b08e6a029 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -2,7 +2,7 @@
 #ifndef __LINUX_ENTRYCOMMON_H
 #define __LINUX_ENTRYCOMMON_H
 
-#include <linux/static_call_types.h>
+#include <linux/static_call.h>
 #include <linux/ptrace.h>
 #include <linux/syscalls.h>
 #include <linux/seccomp.h>
diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
index 6813171afccb..2f3e56062e3e 100644
--- a/include/linux/entry-kvm.h
+++ b/include/linux/entry-kvm.h
@@ -2,7 +2,7 @@
 #ifndef __LINUX_ENTRYKVM_H
 #define __LINUX_ENTRYKVM_H
 
-#include <linux/static_call_types.h>
+#include <linux/static_call.h>
 #include <linux/resume_user_mode.h>
 #include <linux/syscalls.h>
 #include <linux/seccomp.h>
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 5c857c3acbc0..90bc8932c4e3 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -28,7 +28,7 @@
 #include <linux/panic.h>
 #include <linux/printk.h>
 #include <linux/build_bug.h>
-#include <linux/static_call_types.h>
+#include <linux/static_call.h>
 #include <linux/instruction_pointer.h>
 #include <asm/byteorder.h>
 
diff --git a/include/linux/module.h b/include/linux/module.h
index 4435ad9439ab..a933ec51817d 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -26,7 +26,7 @@
 #include <linux/error-injection.h>
 #include <linux/tracepoint-defs.h>
 #include <linux/srcu.h>
-#include <linux/static_call_types.h>
+#include <linux/static_call.h>
 
 #include <linux/percpu.h>
 #include <asm/module.h>
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 74f089a5955b..650bda9a3367 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -134,178 +134,141 @@
 #include <linux/types.h>
 #include <linux/static_call_types.h>
 
-#ifdef CONFIG_HAVE_STATIC_CALL
-#include <asm/static_call.h>
-
-/*
- * Either @site or @tramp can be NULL.
- */
-extern void arch_static_call_transform(void *site, void *tramp, void *func, bool tail);
-
-#define STATIC_CALL_TRAMP_ADDR(name) &STATIC_CALL_TRAMP(name)
-
-#else
-#define STATIC_CALL_TRAMP_ADDR(name) NULL
-#endif
-
-#define static_call_update(name, func)					\
-({									\
-	typeof(&STATIC_CALL_TRAMP(name)) __F = (func);			\
-	__static_call_update(&STATIC_CALL_KEY(name),			\
-			     STATIC_CALL_TRAMP_ADDR(name), __F);	\
-})
-
-#define static_call_query(name) (READ_ONCE(STATIC_CALL_KEY(name).func))
-
+struct static_call_mods;
+struct static_call_key {
+	void *func;
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
-
-extern int __init static_call_init(void);
-
-extern void static_call_force_reinit(void);
-
-struct static_call_mod {
-	struct static_call_mod *next;
-	struct module *mod; /* for vmlinux, mod == NULL */
-	struct static_call_site *sites;
+	union {
+		/* bit 0: 0 = sites, 1 = mods */
+		unsigned long type;
+		struct static_call_site *_sites;
+		struct static_call_mod *_mods;
+	};
+#endif
 };
 
-/* For finding the key associated with a trampoline */
-struct static_call_tramp_key {
-	s32 tramp;
-	s32 key;
-};
+#define DECLARE_STATIC_CALL(name, func)					\
+	extern struct static_call_key STATIC_CALL_KEY(name);		\
+	extern typeof(func) STATIC_CALL_TRAMP(name);
 
-extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
-extern int static_call_text_reserved(void *start, void *end);
-
-extern long __static_call_return0(void);
-
-#define DEFINE_STATIC_CALL(name, _func)					\
-	DECLARE_STATIC_CALL(name, _func);				\
+#define __DEFINE_STATIC_CALL(name, type, _func)				\
+	DECLARE_STATIC_CALL(name, type);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
 		.func = _func,						\
-	};								\
-	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
+	}
 
-#define DEFINE_STATIC_CALL_NULL(name, _func)				\
-	DECLARE_STATIC_CALL(name, _func);				\
-	struct static_call_key STATIC_CALL_KEY(name) = {		\
-		.func = NULL,						\
-	};								\
-	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
+#define DEFINE_STATIC_CALL(name, func)					\
+	__DEFINE_STATIC_CALL(name, func, func);				\
+	__DEFINE_STATIC_CALL_TRAMP(name, func)
 
-#define DEFINE_STATIC_CALL_RET0(name, _func)				\
-	DECLARE_STATIC_CALL(name, _func);				\
-	struct static_call_key STATIC_CALL_KEY(name) = {		\
-		.func = __static_call_return0,				\
-	};								\
-	ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name)
+#define DEFINE_STATIC_CALL_NULL(name, type)				\
+	__DEFINE_STATIC_CALL(name, type, NULL);				\
+	__DEFINE_STATIC_CALL_NULL_TRAMP(name)
 
-#define static_call_cond(name)	(void)__static_call(name)
+#define DEFINE_STATIC_CALL_RET0(name, type)				\
+	__DEFINE_STATIC_CALL(name, type, __static_call_return0);	\
+	__DEFINE_STATIC_CALL_RET0_TRAMP(name)
 
 #define EXPORT_STATIC_CALL(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
-	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
+	__EXPORT_STATIC_CALL_TRAMP(name)
 #define EXPORT_STATIC_CALL_GPL(name)					\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
-	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
+	__EXPORT_STATIC_CALL_TRAMP_GPL(name)
 
 /*
  * Read-only exports: export the trampoline but not the key, so modules can't
  * change call targets.
+ *
+ * These are called via static_call_ro().
  */
 #define EXPORT_STATIC_CALL_RO(name)					\
-	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name));				\
+	__EXPORT_STATIC_CALL_TRAMP(name);				\
 	__STATIC_CALL_ADD_TRAMP_KEY(name)
-#define EXPORT_STATIC_CALL_RO_GPL(name)				\
-	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name));			\
+#define EXPORT_STATIC_CALL_RO_GPL(name)					\
+	__EXPORT_STATIC_CALL_TRAMP_GPL(name);				\
 	__STATIC_CALL_ADD_TRAMP_KEY(name)
 
-/* Unexported key lookup table */
-#define __STATIC_CALL_ADD_TRAMP_KEY(name)				\
-	asm(".pushsection .static_call_tramp_key, \"a\"		\n"	\
-	    ".long " STATIC_CALL_TRAMP_STR(name) " - .		\n"	\
-	    ".long " STATIC_CALL_KEY_STR(name) " - .		\n"	\
-	    ".popsection					\n")
+/*
+ * __ADDRESSABLE() is used to ensure the key symbol doesn't get stripped from
+ * the symbol table so that objtool can reference it when it generates the
+ * .static_call_sites section.
+ */
+#define __STATIC_CALL_ADDRESSABLE(name) __ADDRESSABLE(STATIC_CALL_KEY(name))
 
-#elif defined(CONFIG_HAVE_STATIC_CALL)
+#define static_call(name)						\
+({									\
+	__STATIC_CALL_ADDRESSABLE(name);				\
+	__static_call(name);						\
+})
 
-static inline int static_call_init(void) { return 0; }
+#define static_call_cond(name)		(void)__static_call_cond(name)
 
-#define DEFINE_STATIC_CALL(name, _func)					\
-	DECLARE_STATIC_CALL(name, _func);				\
-	struct static_call_key STATIC_CALL_KEY(name) = {		\
-		.func = _func,						\
-	};								\
-	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
+/* Use static_call_ro() to call a read-only-exported static call. */
+#define static_call_ro(name)		__static_call_ro(name)
 
-#define DEFINE_STATIC_CALL_NULL(name, _func)				\
-	DECLARE_STATIC_CALL(name, _func);				\
-	struct static_call_key STATIC_CALL_KEY(name) = {		\
-		.func = NULL,						\
-	};								\
-	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
+#if defined(MODULE) || !defined(CONFIG_HAVE_STATIC_CALL_INLINE)
+#define __STATIC_CALL_RO_ADDRESSABLE(name)
+#define __static_call_ro(name)		__static_call(name)
+#else
+#define __STATIC_CALL_RO_ADDRESSABLE(name) __STATIC_CALL_ADDRESSABLE(name)
+#define __static_call_ro(name)		static_call(name)
+#endif
 
-#define DEFINE_STATIC_CALL_RET0(name, _func)				\
-	DECLARE_STATIC_CALL(name, _func);				\
-	struct static_call_key STATIC_CALL_KEY(name) = {		\
-		.func = __static_call_return0,				\
-	};								\
-	ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name)
+#define static_call_update(name, func)					\
+({									\
+	typeof(&STATIC_CALL_TRAMP(name)) __F = (func);			\
+	__static_call_update(&STATIC_CALL_KEY(name),			\
+			     STATIC_CALL_TRAMP_ADDR(name), __F);	\
+})
 
-#define static_call_cond(name)	(void)__static_call(name)
+#define static_call_query(name) (READ_ONCE(STATIC_CALL_KEY(name).func))
 
-extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
 
-static inline int static_call_text_reserved(void *start, void *end)
-{
-	return 0;
-}
+#ifdef CONFIG_HAVE_STATIC_CALL
 
-extern long __static_call_return0(void);
+#include <asm/static_call.h>
 
-#define EXPORT_STATIC_CALL(name)					\
-	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
-	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
-#define EXPORT_STATIC_CALL_GPL(name)					\
-	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
-	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
+#define __DEFINE_STATIC_CALL_TRAMP(name, func)				\
+	ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)
 
-/*
- * Read-only exports: export the trampoline but not the key, so modules can't
- * change call targets.
- */
-#define EXPORT_STATIC_CALL_RO(name)					\
+#define __DEFINE_STATIC_CALL_NULL_TRAMP(name)				\
+	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
+
+#define __DEFINE_STATIC_CALL_RET0_TRAMP(name)				\
+	ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name)
+
+#define __EXPORT_STATIC_CALL_TRAMP(name)				\
 	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
-#define EXPORT_STATIC_CALL_RO_GPL(name)					\
+
+#define __EXPORT_STATIC_CALL_TRAMP_GPL(name)				\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
 
-#else /* Generic implementation */
+#define __static_call(name)		(&STATIC_CALL_TRAMP(name))
+#define __static_call_cond		__static_call
 
-static inline int static_call_init(void) { return 0; }
+#define STATIC_CALL_TRAMP_ADDR(name)	&STATIC_CALL_TRAMP(name)
 
-static inline long __static_call_return0(void)
-{
-	return 0;
-}
+extern long __static_call_return0(void);
+extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
 
-#define __DEFINE_STATIC_CALL(name, _func, _func_init)			\
-	DECLARE_STATIC_CALL(name, _func);				\
-	struct static_call_key STATIC_CALL_KEY(name) = {		\
-		.func = _func_init,					\
-	}
+/*
+ * Either @site or @tramp can be NULL.
+ */
+extern void arch_static_call_transform(void *site, void *tramp, void *func, bool tail);
 
-#define DEFINE_STATIC_CALL(name, _func)					\
-	__DEFINE_STATIC_CALL(name, _func, _func)
+#else /* !CONFIG_HAVE_STATIC_CALL */
 
-#define DEFINE_STATIC_CALL_NULL(name, _func)				\
-	__DEFINE_STATIC_CALL(name, _func, NULL)
+#define __DEFINE_STATIC_CALL_TRAMP(name, func)
+#define __DEFINE_STATIC_CALL_NULL_TRAMP(name)
+#define __DEFINE_STATIC_CALL_RET0_TRAMP(name)
+#define __EXPORT_STATIC_CALL_TRAMP(name)
+#define __EXPORT_STATIC_CALL_TRAMP_GPL(name)
 
-#define DEFINE_STATIC_CALL_RET0(name, _func)				\
-	__DEFINE_STATIC_CALL(name, _func, __static_call_return0)
+#define __static_call(name)						\
+	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))
 
 static inline void __static_call_nop(void) { }
-
 /*
  * This horrific hack takes care of two things:
  *
@@ -326,7 +289,9 @@ static inline void __static_call_nop(void) { }
 	(typeof(STATIC_CALL_TRAMP(name))*)func;				\
 })
 
-#define static_call_cond(name)	(void)__static_call_cond(name)
+#define STATIC_CALL_TRAMP_ADDR(name)	NULL
+
+static inline long __static_call_return0(void) { return 0; }
 
 static inline
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
@@ -334,14 +299,29 @@ void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 	WRITE_ONCE(key->func, func);
 }
 
-static inline int static_call_text_reserved(void *start, void *end)
-{
-	return 0;
-}
+#endif /* CONFIG_HAVE_STATIC_CALL */
 
-#define EXPORT_STATIC_CALL(name)	EXPORT_SYMBOL(STATIC_CALL_KEY(name))
-#define EXPORT_STATIC_CALL_GPL(name)	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name))
 
-#endif /* CONFIG_HAVE_STATIC_CALL */
+#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
+
+/* Unexported key lookup table */
+#define __STATIC_CALL_ADD_TRAMP_KEY(name)				\
+	asm(".pushsection .static_call_tramp_key, \"a\"		\n"	\
+	    ".long " STATIC_CALL_TRAMP_STR(name) " - .		\n"	\
+	    ".long " STATIC_CALL_KEY_STR(name) " - .		\n"	\
+	    ".popsection					\n")
+
+extern int static_call_init(void);
+extern int static_call_text_reserved(void *start, void *end);
+extern void static_call_force_reinit(void);
+
+#else /* !CONFIG_HAVE_STATIC_CALL_INLINE*/
+
+#define __STATIC_CALL_ADD_TRAMP_KEY(name)
+static inline int static_call_init(void) { return 0; }
+static inline int static_call_text_reserved(void *start, void *end) { return 0; }
+static inline void static_call_force_reinit(void) {}
+
+#endif /* CONFIG_HAVE_STATIC_CALL_INLINE */
 
 #endif /* _LINUX_STATIC_CALL_H */
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
index 06293067424f..8b349fe39e45 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -2,6 +2,10 @@
 #ifndef _STATIC_CALL_TYPES_H
 #define _STATIC_CALL_TYPES_H
 
+/*
+ * Static call types for sharing with objtool
+ */
+
 #include <linux/types.h>
 #include <linux/stringify.h>
 #include <linux/compiler.h>
@@ -34,70 +38,4 @@ struct static_call_site {
 	s32 key;
 };
 
-#define DECLARE_STATIC_CALL(name, func)					\
-	extern struct static_call_key STATIC_CALL_KEY(name);		\
-	extern typeof(func) STATIC_CALL_TRAMP(name);
-
-#ifdef CONFIG_HAVE_STATIC_CALL
-
-#define __raw_static_call(name)	(&STATIC_CALL_TRAMP(name))
-
-#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
-
-/*
- * __ADDRESSABLE() is used to ensure the key symbol doesn't get stripped from
- * the symbol table so that objtool can reference it when it generates the
- * .static_call_sites section.
- */
-#define __STATIC_CALL_ADDRESSABLE(name) \
-	__ADDRESSABLE(STATIC_CALL_KEY(name))
-
-#define __static_call(name)						\
-({									\
-	__STATIC_CALL_ADDRESSABLE(name);				\
-	__raw_static_call(name);					\
-})
-
-struct static_call_key {
-	void *func;
-	union {
-		/* bit 0: 0 = sites, 1 = mods */
-		unsigned long type;
-		struct static_call_site *_sites;
-		struct static_call_mod *_mods;
-	};
-};
-
-#else /* !CONFIG_HAVE_STATIC_CALL_INLINE */
-
-#define __STATIC_CALL_ADDRESSABLE(name)
-#define __static_call(name)	__raw_static_call(name)
-
-struct static_call_key {
-	void *func;
-};
-
-#endif /* CONFIG_HAVE_STATIC_CALL_INLINE */
-
-#ifdef MODULE
-#define __STATIC_CALL_RO_ADDRESSABLE(name)
-#define static_call_ro(name)	__raw_static_call(name)
-#else
-#define __STATIC_CALL_RO_ADDRESSABLE(name) __STATIC_CALL_ADDRESSABLE(name)
-#define static_call_ro(name)	__static_call(name)
-#endif
-
-#define static_call(name)	__static_call(name)
-
-#else
-
-struct static_call_key {
-	void *func;
-};
-
-#define static_call(name)						\
-	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))
-
-#endif /* CONFIG_HAVE_STATIC_CALL */
-
 #endif /* _STATIC_CALL_TYPES_H */
diff --git a/kernel/static_call.c b/kernel/static_call.c
index 63486995fd82..e5fc33d05015 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/export.h>
 #include <linux/static_call.h>
 #include <linux/cpu.h>
 
diff --git a/kernel/static_call_inline.c b/kernel/static_call_inline.c
index 41f6bda6773a..b4f4a9eaa6d8 100644
--- a/kernel/static_call_inline.c
+++ b/kernel/static_call_inline.c
@@ -9,6 +9,19 @@
 #include <linux/cpu.h>
 #include <linux/processor.h>
 #include <asm/sections.h>
+#include <asm/text-patching.h>
+
+/* For finding the key associated with a trampoline */
+struct static_call_tramp_key {
+	s32 tramp;
+	s32 key;
+};
+
+struct static_call_mod {
+	struct static_call_mod *next;
+	struct module *mod; /* for vmlinux, mod == NULL */
+	struct static_call_site *sites;
+};
 
 extern struct static_call_site __start_static_call_sites[],
 			       __stop_static_call_sites[];
diff --git a/tools/include/linux/static_call_types.h b/tools/include/linux/static_call_types.h
index 06293067424f..8b349fe39e45 100644
--- a/tools/include/linux/static_call_types.h
+++ b/tools/include/linux/static_call_types.h
@@ -2,6 +2,10 @@
 #ifndef _STATIC_CALL_TYPES_H
 #define _STATIC_CALL_TYPES_H
 
+/*
+ * Static call types for sharing with objtool
+ */
+
 #include <linux/types.h>
 #include <linux/stringify.h>
 #include <linux/compiler.h>
@@ -34,70 +38,4 @@ struct static_call_site {
 	s32 key;
 };
 
-#define DECLARE_STATIC_CALL(name, func)					\
-	extern struct static_call_key STATIC_CALL_KEY(name);		\
-	extern typeof(func) STATIC_CALL_TRAMP(name);
-
-#ifdef CONFIG_HAVE_STATIC_CALL
-
-#define __raw_static_call(name)	(&STATIC_CALL_TRAMP(name))
-
-#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
-
-/*
- * __ADDRESSABLE() is used to ensure the key symbol doesn't get stripped from
- * the symbol table so that objtool can reference it when it generates the
- * .static_call_sites section.
- */
-#define __STATIC_CALL_ADDRESSABLE(name) \
-	__ADDRESSABLE(STATIC_CALL_KEY(name))
-
-#define __static_call(name)						\
-({									\
-	__STATIC_CALL_ADDRESSABLE(name);				\
-	__raw_static_call(name);					\
-})
-
-struct static_call_key {
-	void *func;
-	union {
-		/* bit 0: 0 = sites, 1 = mods */
-		unsigned long type;
-		struct static_call_site *_sites;
-		struct static_call_mod *_mods;
-	};
-};
-
-#else /* !CONFIG_HAVE_STATIC_CALL_INLINE */
-
-#define __STATIC_CALL_ADDRESSABLE(name)
-#define __static_call(name)	__raw_static_call(name)
-
-struct static_call_key {
-	void *func;
-};
-
-#endif /* CONFIG_HAVE_STATIC_CALL_INLINE */
-
-#ifdef MODULE
-#define __STATIC_CALL_RO_ADDRESSABLE(name)
-#define static_call_ro(name)	__raw_static_call(name)
-#else
-#define __STATIC_CALL_RO_ADDRESSABLE(name) __STATIC_CALL_ADDRESSABLE(name)
-#define static_call_ro(name)	__static_call(name)
-#endif
-
-#define static_call(name)	__static_call(name)
-
-#else
-
-struct static_call_key {
-	void *func;
-};
-
-#define static_call(name)						\
-	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))
-
-#endif /* CONFIG_HAVE_STATIC_CALL */
-
 #endif /* _STATIC_CALL_TYPES_H */
-- 
2.39.2

