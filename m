Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE606C4162
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 05:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjCVEAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 00:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjCVEAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 00:00:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DDB4C6C7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 21:00:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E69C5B81B03
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3049BC433A0;
        Wed, 22 Mar 2023 04:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679457627;
        bh=Ko8dqfsbQjWRnrk2DZgCMLtu7fL816reSjEA59wqAaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hi5QCIv/A5W/qDawWErpT3W2w2gt9tQk4Wa3uUc3oPnTWgZKMZvTwsZpNNw1d83dM
         ybVCWti9DqrlfsI4b5LHfg+zEE+s7sTfpCd8hurzI5tmcXSHdwHFtiVbVDi/hzFaa+
         F2fbY8rX+3sk5LkgRQ97OLqy9GHjeHCx14jb7SI+Z+a0XMbiMeCGYqDtOAm9+U1kdd
         2yfgJbZdi68fLxq+7fP3EhwY5v9p0pEunvM1C1Bs5a2qbMp/WnUiroZtJH/f0hjNWr
         Fa1sWKNspub7EBUBCfMausDojGiuZG8EIV0k31kci9sjEFa/JQ93mAL7JI6Drz8B89
         B7kDoe7ed0y1w==
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
Subject: [PATCH v2 08/11] arm64/static_call: Fix static call CFI violations
Date:   Tue, 21 Mar 2023 21:00:14 -0700
Message-Id: <3d8c9e67a7e29f3bed4e44429d953e1ac9c6d5be.1679456900.git.jpoimboe@kernel.org>
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

On arm64, with CONFIG_CFI_CLANG, it's trivial to trigger CFI violations
by running "perf record -e sched:sched_switch -a":

  CFI failure at perf_misc_flags+0x34/0x70 (target: __static_call_return0+0x0/0xc; expected type: 0x837de525)
  WARNING: CPU: 3 PID: 32 at perf_misc_flags+0x34/0x70
  CPU: 3 PID: 32 Comm: ksoftirqd/3 Kdump: loaded Tainted: P                   6.3.0-rc2 #8
  Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
  pstate: 904000c5 (NzcV daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : perf_misc_flags+0x34/0x70
  lr : perf_event_output_forward+0x74/0xf0
  sp : ffff80000a98b970
  x29: ffff80000a98b970 x28: ffff00077bd34d00 x27: ffff8000097d2d00
  x26: fffffbffeff6a360 x25: ffff800009835a30 x24: ffff0000c2e8dca0
  x23: 0000000000000000 x22: 0000000000000080 x21: ffff00077bd31610
  x20: ffff0000c2e8dca0 x19: ffff00077bd31610 x18: ffff800008cd52f0
  x17: 00000000837de525 x16: 0000000072923c8f x15: 000000000000b67e
  x14: 000000000178797d x13: 0000000000000004 x12: 0000000070b5b3a8
  x11: 0000000000000015 x10: 0000000000000048 x9 : ffff80000829e2b4
  x8 : ffff80000829c6f0 x7 : 0000000000000000 x6 : 0000000000000000
  x5 : fffffbffeff6a340 x4 : ffff00077bd31610 x3 : ffff00077bd31610
  x2 : ffff800009833400 x1 : 0000000000000000 x0 : ffff00077bd31610
  Call trace:
   perf_misc_flags+0x34/0x70
   perf_event_output_forward+0x74/0xf0
   __perf_event_overflow+0x12c/0x1e8
   perf_swevent_event+0x98/0x1a0
   perf_tp_event+0x140/0x558
   perf_trace_run_bpf_submit+0x88/0xc8
   perf_trace_sched_switch+0x160/0x19c
   __schedule+0xabc/0x153c
   dynamic_cond_resched+0x48/0x68
   run_ksoftirqd+0x3c/0x138
   smpboot_thread_fn+0x26c/0x2f8
   kthread+0x108/0x1c4
   ret_from_fork+0x10/0x20

The problem is that the __perf_guest_state() static call does an
indirect branch to __static_call_return0(), which isn't CFI-compliant.

Fix that by generating custom CFI-compliant ret0 functions for each
defined static key.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/Kconfig                            |  4 ++
 arch/arm64/include/asm/static_call.h    | 29 +++++++++++
 include/linux/static_call.h             | 64 +++++++++++++++++++++----
 include/linux/static_call_types.h       |  4 ++
 kernel/Makefile                         |  2 +-
 kernel/static_call.c                    |  2 +-
 tools/include/linux/static_call_types.h |  4 ++
 7 files changed, 97 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm64/include/asm/static_call.h

diff --git a/arch/Kconfig b/arch/Kconfig
index e3511afbb7f2..8800fe80a0f9 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1348,6 +1348,10 @@ config HAVE_STATIC_CALL_INLINE
 	depends on HAVE_STATIC_CALL
 	select OBJTOOL
 
+config CFI_WITHOUT_STATIC_CALL
+	def_bool y
+	depends on CFI_CLANG && !HAVE_STATIC_CALL
+
 config HAVE_PREEMPT_DYNAMIC
 	bool
 
diff --git a/arch/arm64/include/asm/static_call.h b/arch/arm64/include/asm/static_call.h
new file mode 100644
index 000000000000..b3489cac7742
--- /dev/null
+++ b/arch/arm64/include/asm/static_call.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ARM64_STATIC_CALL_H
+#define _ASM_ARM64_STATIC_CALL_H
+
+/*
+ * Make a dummy reference to a function pointer in C to force the compiler to
+ * emit a __kcfi_typeid_ symbol for asm to use.
+ */
+#define GEN_CFI_SYM(func)						\
+	static typeof(func) __used __section(".discard.cfi") *__UNIQUE_ID(cfi) = func
+
+
+/* Generate a CFI-compliant static call NOP function */
+#define __ARCH_DEFINE_STATIC_CALL_CFI(name, insns)			\
+	asm(".align 4						\n"	\
+	    ".word __kcfi_typeid_" name "			\n"	\
+	    ".globl " name "					\n"	\
+	    name ":						\n"	\
+	    "bti c						\n"	\
+	    insns "						\n"	\
+	    "ret						\n"	\
+	    ".type " name ", @function				\n"	\
+	    ".size " name ", . - " name "			\n")
+
+#define __ARCH_DEFINE_STATIC_CALL_RET0_CFI(name)			\
+	GEN_CFI_SYM(STATIC_CALL_RET0_CFI(name));			\
+	__ARCH_DEFINE_STATIC_CALL_CFI(STATIC_CALL_RET0_CFI_STR(name), "mov x0, xzr")
+
+#endif /* _ASM_ARM64_STATIC_CALL_H */
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 650bda9a3367..50ad928afeb8 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -147,15 +147,19 @@ struct static_call_key {
 #endif
 };
 
+extern long __static_call_return0(void);
+
 #define DECLARE_STATIC_CALL(name, func)					\
 	extern struct static_call_key STATIC_CALL_KEY(name);		\
-	extern typeof(func) STATIC_CALL_TRAMP(name);
+	extern typeof(func) STATIC_CALL_TRAMP(name);			\
+	__DECLARE_STATIC_CALL_CFI(name, func)
 
 #define __DEFINE_STATIC_CALL(name, type, _func)				\
 	DECLARE_STATIC_CALL(name, type);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
 		.func = _func,						\
-	}
+	};								\
+	__DEFINE_STATIC_CALL_CFI(name)
 
 #define DEFINE_STATIC_CALL(name, func)					\
 	__DEFINE_STATIC_CALL(name, func, func);				\
@@ -166,15 +170,18 @@ struct static_call_key {
 	__DEFINE_STATIC_CALL_NULL_TRAMP(name)
 
 #define DEFINE_STATIC_CALL_RET0(name, type)				\
-	__DEFINE_STATIC_CALL(name, type, __static_call_return0);	\
+	__DEFINE_STATIC_CALL(name, type, __STATIC_CALL_RET0(name));	\
 	__DEFINE_STATIC_CALL_RET0_TRAMP(name)
 
 #define EXPORT_STATIC_CALL(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
-	__EXPORT_STATIC_CALL_TRAMP(name)
+	__EXPORT_STATIC_CALL_TRAMP(name);				\
+	__EXPORT_STATIC_CALL_CFI(name)
+
 #define EXPORT_STATIC_CALL_GPL(name)					\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
-	__EXPORT_STATIC_CALL_TRAMP_GPL(name)
+	__EXPORT_STATIC_CALL_TRAMP_GPL(name);				\
+	__EXPORT_STATIC_CALL_CFI_GPL(name)
 
 /*
  * Read-only exports: export the trampoline but not the key, so modules can't
@@ -184,9 +191,12 @@ struct static_call_key {
  */
 #define EXPORT_STATIC_CALL_RO(name)					\
 	__EXPORT_STATIC_CALL_TRAMP(name);				\
+	__EXPORT_STATIC_CALL_CFI(name)					\
 	__STATIC_CALL_ADD_TRAMP_KEY(name)
+
 #define EXPORT_STATIC_CALL_RO_GPL(name)					\
 	__EXPORT_STATIC_CALL_TRAMP_GPL(name);				\
+	__EXPORT_STATIC_CALL_CFI_GPL(name)				\
 	__STATIC_CALL_ADD_TRAMP_KEY(name)
 
 /*
@@ -218,12 +228,19 @@ struct static_call_key {
 #define static_call_update(name, func)					\
 ({									\
 	typeof(&STATIC_CALL_TRAMP(name)) __F = (func);			\
+	if (__F == (void *)__static_call_return0)			\
+		__F = __STATIC_CALL_RET0(name);				\
 	__static_call_update(&STATIC_CALL_KEY(name),			\
 			     STATIC_CALL_TRAMP_ADDR(name), __F);	\
 })
 
-#define static_call_query(name) (READ_ONCE(STATIC_CALL_KEY(name).func))
-
+#define static_call_query(name)						\
+({									\
+	void *__F = (READ_ONCE(STATIC_CALL_KEY(name).func));		\
+	if (__F == __STATIC_CALL_RET0(name))			\
+		__F = __static_call_return0;				\
+	__F;								\
+})
 
 #ifdef CONFIG_HAVE_STATIC_CALL
 
@@ -249,7 +266,6 @@ struct static_call_key {
 
 #define STATIC_CALL_TRAMP_ADDR(name)	&STATIC_CALL_TRAMP(name)
 
-extern long __static_call_return0(void);
 extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
 
 /*
@@ -291,8 +307,6 @@ static inline void __static_call_nop(void) { }
 
 #define STATIC_CALL_TRAMP_ADDR(name)	NULL
 
-static inline long __static_call_return0(void) { return 0; }
-
 static inline
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 {
@@ -324,4 +338,34 @@ static inline void static_call_force_reinit(void) {}
 
 #endif /* CONFIG_HAVE_STATIC_CALL_INLINE */
 
+
+#ifdef CONFIG_CFI_WITHOUT_STATIC_CALL
+
+#include <asm/static_call.h>
+
+#define __STATIC_CALL_RET0(name)	STATIC_CALL_RET0_CFI(name)
+
+#define __DECLARE_STATIC_CALL_CFI(name, func)				\
+	extern typeof(func) STATIC_CALL_RET0_CFI(name)
+
+#define __DEFINE_STATIC_CALL_CFI(name)					\
+	__ARCH_DEFINE_STATIC_CALL_RET0_CFI(name)
+
+#define __EXPORT_STATIC_CALL_CFI(name)					\
+	EXPORT_SYMBOL(STATIC_CALL_RET0_CFI(name))
+
+#define __EXPORT_STATIC_CALL_CFI_GPL(name)				\
+	EXPORT_SYMBOL_GPL(STATIC_CALL_RET0_CFI(name))
+
+#else /* ! CONFIG_CFI_WITHOUT_STATIC_CALL */
+
+#define __STATIC_CALL_RET0(name)	(void *)__static_call_return0
+
+#define __DECLARE_STATIC_CALL_CFI(name, func)
+#define __DEFINE_STATIC_CALL_CFI(name)
+#define __EXPORT_STATIC_CALL_CFI(name)
+#define __EXPORT_STATIC_CALL_CFI_GPL(name)
+
+#endif /* CONFIG_CFI_WITHOUT_STATIC_CALL */
+
 #endif /* _LINUX_STATIC_CALL_H */
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
index 8b349fe39e45..72732af51cba 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -22,6 +22,10 @@
 #define STATIC_CALL_TRAMP(name)		__PASTE(STATIC_CALL_TRAMP_PREFIX, name)
 #define STATIC_CALL_TRAMP_STR(name)	__stringify(STATIC_CALL_TRAMP(name))
 
+#define STATIC_CALL_RET0_CFI_PREFIX	__SCR__
+#define STATIC_CALL_RET0_CFI(name)	__PASTE(STATIC_CALL_RET0_CFI_PREFIX, name)
+#define STATIC_CALL_RET0_CFI_STR(name)	__stringify(STATIC_CALL_RET0_CFI(name))
+
 /*
  * Flags in the low bits of static_call_site::key.
  */
diff --git a/kernel/Makefile b/kernel/Makefile
index 10ef068f598d..59b062b1c8f7 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -110,7 +110,7 @@ obj-$(CONFIG_CPU_PM) += cpu_pm.o
 obj-$(CONFIG_BPF) += bpf/
 obj-$(CONFIG_KCSAN) += kcsan/
 obj-$(CONFIG_SHADOW_CALL_STACK) += scs.o
-obj-$(CONFIG_HAVE_STATIC_CALL) += static_call.o
+obj-y += static_call.o
 obj-$(CONFIG_HAVE_STATIC_CALL_INLINE) += static_call_inline.o
 obj-$(CONFIG_CFI_CLANG) += cfi.o
 
diff --git a/kernel/static_call.c b/kernel/static_call.c
index e5fc33d05015..090ecf5d34b4 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -9,7 +9,7 @@ long __static_call_return0(void)
 }
 EXPORT_SYMBOL_GPL(__static_call_return0);
 
-#ifndef CONFIG_HAVE_STATIC_CALL_INLINE
+#if defined(CONFIG_HAVE_STATIC_CALL) && !defined(CONFIG_HAVE_STATIC_CALL_INLINE)
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 {
 	cpus_read_lock();
diff --git a/tools/include/linux/static_call_types.h b/tools/include/linux/static_call_types.h
index 8b349fe39e45..72732af51cba 100644
--- a/tools/include/linux/static_call_types.h
+++ b/tools/include/linux/static_call_types.h
@@ -22,6 +22,10 @@
 #define STATIC_CALL_TRAMP(name)		__PASTE(STATIC_CALL_TRAMP_PREFIX, name)
 #define STATIC_CALL_TRAMP_STR(name)	__stringify(STATIC_CALL_TRAMP(name))
 
+#define STATIC_CALL_RET0_CFI_PREFIX	__SCR__
+#define STATIC_CALL_RET0_CFI(name)	__PASTE(STATIC_CALL_RET0_CFI_PREFIX, name)
+#define STATIC_CALL_RET0_CFI_STR(name)	__stringify(STATIC_CALL_RET0_CFI(name))
+
 /*
  * Flags in the low bits of static_call_site::key.
  */
-- 
2.39.2

