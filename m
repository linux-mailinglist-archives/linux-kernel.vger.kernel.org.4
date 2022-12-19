Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5600650780
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 07:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiLSGS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 01:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLSGSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 01:18:53 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106B324D;
        Sun, 18 Dec 2022 22:18:52 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so11937047pjs.4;
        Sun, 18 Dec 2022 22:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xnpXqtwOk4096xQXoOsXv/+jlvNNs1plcpDQ4+FbXcY=;
        b=f5SsS5D6geDdwx+aToSFbt6cMP51JtPToFXyr5jHxwdLI4WSk6hOf48aT8glAfqCvn
         1Eml0QrvgNw0UJfDVnSWYDF06oS4u1i8+r0e9zFfCydME80/R3Mr3lXAYV6cZgY8CeEY
         Fb/nMcQryf70aU+Wm15zQcGRSqNnbP7XnzyW2hU6PN63VmotEs3KUCcNALaLYS7lPzH/
         k4IiuhV08eDBYcbMdUKvuUwF/DcMi0Nw7YDgsR4QtvDjJIEKpZJtZ+hsDOlDvp2r/pkw
         owrBst7912yrBXNeIj33ssafNCJJDsDsd8Wu+U+sqKATIM3pOkSPNJovf3sVprTJ4Eqd
         lZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xnpXqtwOk4096xQXoOsXv/+jlvNNs1plcpDQ4+FbXcY=;
        b=p+pkXk7AtSMuW75Pvu2GW8/wR1QI/svkRlAcX/gAYDuSob8hWaGJ952cAyLQDQft8+
         utAyx2W9lJF99EIE8VkIMW/2SAnTi2rysd2h2aLrhp+lr6DrzDmCZ+9eeXw/b9T5BmvA
         gUT0OmW0hGhLf/IinPOebUWFg73zEQtEDSyjbLrj4J0k3D0rdirRHqvB+pTUt51p3ME+
         uU6PXSvjwVQokahEa0L7j2Cc5wn0Hsrocyh7juXOt5VeFKNd6Yq2BSQ0CBtFiYdPnHFQ
         N7BZPqVBt1dyDU0QaJJalLM2+B8gRhmPiQ2pWjXmDTjhWAAqxa/oKyb+mAVMNjZf1/NG
         kO8A==
X-Gm-Message-State: ANoB5pl67B/WaFllJsppoQ+Pdd4D6tR/W4YfHr0oJ4yGHQWj8kW0eSyI
        e2ZaKGMy5sN+pCYwczMTDfI=
X-Google-Smtp-Source: AA0mqf7hGnk98vtE8qLeNNbC1u6TGcRYq1xoT+Bc1efX+VUb6hK1CPaw+Oe7bKOtZs9KnrklkOi0SA==
X-Received: by 2002:a05:6a20:4e25:b0:ad:f155:7b47 with SMTP id gk37-20020a056a204e2500b000adf1557b47mr22721668pzb.22.1671430731434;
        Sun, 18 Dec 2022 22:18:51 -0800 (PST)
Received: from localhost ([103.152.220.92])
        by smtp.gmail.com with ESMTPSA id f28-20020a63101c000000b00478f87eaa44sm5461503pgl.35.2022.12.18.22.18.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Dec 2022 22:18:51 -0800 (PST)
From:   Dan Li <ashimida.1990@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dan Li <ashimida.1990@gmail.com>,
        Marco Elver <elver@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Song Liu <song@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Yuntao Wang <ytcoode@gmail.com>,
        Changbin Du <changbin.du@intel.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: [RFC/RFT] CFI: Add support for gcc CFI in aarch64
Date:   Sun, 18 Dec 2022 22:17:58 -0800
Message-Id: <20221219061758.23321-1-ashimida.1990@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on Sami's patch[1], this patch makes the corresponding kernel
configuration of CFI available when compiling the kernel with the gcc[2].

The code after enabling cfi is as follows:

int (*p)(void);
int func (int)
{
	p();
}

__cfi_func:
        .4byte 0x439d3502
func:
        ......
        adrp    x0, p
        add     x0, x0, :lo12:p
        mov     w1, 23592
        movk    w1, 0x4601, lsl 16
        cmp     w0, w1
        beq     .L2
        ......
        bl      cfi_check_failed
.L2:
        blr     x19
        ret

In the compiler part[4], there are some differences from Sami's
implementation[3], mainly including:

1. When a typeid mismatch is detected, the cfi_check_failed function
   will be called instead of the brk instruction. This function needs
   to be implemented by the compiler user.
   If there are user mode programs or other systems that want to use
   this feature, it may be more convenient to use a callback (so this
   compilation option is set to -fsanitize=cfi instead of kcfi).

2. A reserved typeid (such as 0x0U on the aarch64 platform) is always
   inserted in front of functions that should not be called indirectly.
   Functions that can be called indirectly will not use this hash value,
   which prevents instructions/data before the function from being used
   as a typeid by an attacker.

3. Some bits are ignored in the typeid to avoid conflicts between the
   typeid and the instruction set of a specific platform, thereby
   preventing an attacker from bypassing the CFI check by using the
   instruction as a typeid, such as on the aarch64 platform:
   * If the following instruction sequence exists:
	  400620:       a9be7bfd        stp     x29, x30, [sp, #-32]!
	  400624:       910003fd        mov     x29, sp
	  400628:       f9000bf3        str     x19, [sp, #16]
   * If the expected typeid of the indirect call is exactly 0x910003fd,
     the attacker can jump to the next instruction position of any
     "mov x29,sp" instruction (such as 0x400628 here).

4. Insert a symbol __cfi_<function> before each function's typeid,
   which may be helpful for fine-grained KASLR implementations (or not?).

5. The current implementation of gcc only supports the aarch64 platform.

This produces the following oops on CFI failure (generated using lkdtm):

/kselftest_install/lkdtm # ./CFI_FORWARD_PROTO.sh
[   74.856516] lkdtm: Performing direct entry CFI_FORWARD_PROTO
[   74.856878] lkdtm: Calling matched prototype ...
[   74.857011] lkdtm: Calling mismatched prototype ...
[   74.857133] CFI failure at lkdtm_indirect_call+0x30/0x50 (target: lkdtm_increment_int+0x0/0x1c; expected type: 0xc59c68f1)
[   74.858185] Kernel panic - not syncing: Oops - CFI
[   74.859240] CPU: 0 PID: 129 Comm: cat Not tainted 6.0.0-rc4-00024-g32bf7f14f497-dirty #150
[   74.859481] Hardware name: linux,dummy-virt (DT)
[   74.859795] Call trace:
[   74.859959]  dump_backtrace.part.0+0xcc/0xe0
[   74.860212]  show_stack+0x18/0x5c
[   74.860327]  dump_stack_lvl+0x64/0x84
[   74.860398]  dump_stack+0x18/0x38
[   74.860443]  panic+0x170/0x36c
[   74.860496]  cfi_check_failed+0x38/0x44
[   74.860564]  lkdtm_indirect_call+0x30/0x50
[   74.860614]  lkdtm_CFI_FORWARD_PROTO+0x3c/0x6c
[   74.860701]  lkdtm_do_action+0x44/0x58
[   74.860764]  direct_entry+0x148/0x160
[   74.860814]  full_proxy_write+0x74/0xe0
[   74.860874]  vfs_write+0xd8/0x2d0
[   74.860942]  ksys_write+0x70/0x110
[   74.861000]  __arm64_sys_write+0x1c/0x30
[   74.861067]  invoke_syscall+0x5c/0x140
[   74.861117]  el0_svc_common.constprop.0+0x44/0xf0
[   74.861190]  do_el0_svc+0x2c/0xc0
[   74.861233]  el0_svc+0x20/0x60
[   74.861287]  el0t_64_sync_handler+0xf4/0x124
[   74.861340]  el0t_64_sync+0x160/0x164
[   74.861782] SMP: stopping secondary CPUs
[   74.862336] Kernel Offset: disabled
[   74.862439] CPU features: 0x0000,00075024,699418af
[   74.862799] Memory Limit: none
[   74.863373] ---[ end Kernel panic - not syncing: Oops - CFI ]---

The gcc-related patches[4] are based on tag: releases/gcc-12.2.0.

Any suggestion please let me know :).

Thanks, Dan.

[1] https://lore.kernel.org/all/20220908215504.3686827-1-samitolvanen@google.com/
[2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=107048
[3] https://reviews.llvm.org/D119296
[4] https://lore.kernel.org/linux-hardening/20221219055431.22596-1-ashimida.1990@gmail.com/

Signed-off-by: Dan Li <ashimida.1990@gmail.com>
---
 Makefile                     |  6 ++++++
 arch/Kconfig                 | 24 +++++++++++++++++++++++-
 arch/arm64/Kconfig           |  1 +
 include/linux/cfi_types.h    | 15 +++++++++++----
 include/linux/compiler-gcc.h |  4 ++++
 kernel/Makefile              |  1 +
 kernel/cfi.c                 | 23 +++++++++++++++++++++++
 scripts/kallsyms.c           |  4 +++-
 8 files changed, 72 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 43e08c9f95e9..7c74dac57aa4 100644
--- a/Makefile
+++ b/Makefile
@@ -926,6 +926,12 @@ KBUILD_CFLAGS	+= $(CC_FLAGS_CFI)
 export CC_FLAGS_CFI
 endif
 
+ifdef CONFIG_CFI_GCC
+CC_FLAGS_CFI	:= -fsanitize=cfi
+KBUILD_CFLAGS	+= $(CC_FLAGS_CFI)
+export CC_FLAGS_CFI
+endif
+
 ifdef CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B
 KBUILD_CFLAGS += -falign-functions=64
 endif
diff --git a/arch/Kconfig b/arch/Kconfig
index 1c1eca0c0019..8b43a9fd3b54 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -756,9 +756,31 @@ config CFI_CLANG
 
 	    https://clang.llvm.org/docs/ControlFlowIntegrity.html
 
+config ARCH_SUPPORTS_CFI_GCC
+	bool
+	help
+	  An architecture should select this option if it can support GCC's
+	  Control-Flow Integrity (CFI) checking.
+
+config CFI_GCC
+	bool "Use GCC's Control Flow Integrity (CFI)"
+	depends on ARCH_SUPPORTS_CFI_GCC
+	depends on $(cc-option,-fsanitize=cfi)
+	help
+	  This option enables GCC’s forward-edge Control Flow Integrity
+	  (CFI) checking, where the compiler injects a runtime check to each
+	  indirect function call to ensure the target is a valid function with
+	  the correct static type. This restricts possible call targets and
+	  makes it more difficult for an attacker to exploit bugs that allow
+	  the modification of stored function pointers. More information can be
+	  found from the compiler's documentation:
+
+	  - Clang: https://clang.llvm.org/docs/ControlFlowIntegrity.html
+	  - GCC: https://gcc.gnu.org/onlinedocs/gcc/Instrumentation-Options.html#Instrumentation-Options
+
 config CFI_PERMISSIVE
 	bool "Use CFI in permissive mode"
-	depends on CFI_CLANG
+	depends on CFI_CLANG || CFI_GCC
 	help
 	  When selected, Control Flow Integrity (CFI) violations result in a
 	  warning instead of a kernel panic. This option should only be used
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9fb9fff08c94..60fdfb01cecb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -89,6 +89,7 @@ config ARM64
 	select ARCH_SUPPORTS_LTO_CLANG if CPU_LITTLE_ENDIAN
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_SUPPORTS_CFI_CLANG
+	select ARCH_SUPPORTS_CFI_GCC
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_SUPPORTS_NUMA_BALANCING
diff --git a/include/linux/cfi_types.h b/include/linux/cfi_types.h
index 6b8713675765..1c3b7ea6a79f 100644
--- a/include/linux/cfi_types.h
+++ b/include/linux/cfi_types.h
@@ -8,18 +8,25 @@
 #ifdef __ASSEMBLY__
 #include <linux/linkage.h>
 
-#ifdef CONFIG_CFI_CLANG
+#if defined(CONFIG_CFI_CLANG) || defined(CONFIG_CFI_GCC)
 /*
- * Use the __kcfi_typeid_<function> type identifier symbol to
+ * Use the __[k]cfi_typeid_<function> type identifier symbol to
  * annotate indirectly called assembly functions. The compiler emits
  * these symbols for all address-taken function declarations in C
  * code.
  */
 #ifndef __CFI_TYPE
+
+#ifdef CONFIG_CFI_GCC
+#define __CFI_TYPE(name)				\
+	.4byte __cfi_typeid_##name
+#else
 #define __CFI_TYPE(name)				\
 	.4byte __kcfi_typeid_##name
 #endif
 
+#endif
+
 #define SYM_TYPED_ENTRY(name, linkage, align...)	\
 	linkage(name) ASM_NL				\
 	align ASM_NL					\
@@ -29,12 +36,12 @@
 #define SYM_TYPED_START(name, linkage, align...)	\
 	SYM_TYPED_ENTRY(name, linkage, align)
 
-#else /* CONFIG_CFI_CLANG */
+#else /* defined(CONFIG_CFI_CLANG) || defined(CONFIG_CFI_GCC) */
 
 #define SYM_TYPED_START(name, linkage, align...)	\
 	SYM_START(name, linkage, align)
 
-#endif /* CONFIG_CFI_CLANG */
+#endif /* defined(CONFIG_CFI_CLANG) || defined(CONFIG_CFI_GCC) */
 
 #ifndef SYM_TYPED_FUNC_START
 #define SYM_TYPED_FUNC_START(name) 			\
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 9b157b71036f..aec1ce327b1a 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -82,6 +82,10 @@
 #define __noscs __attribute__((__no_sanitize__("shadow-call-stack")))
 #endif
 
+#ifdef CONFIG_CFI_GCC
+#define __nocfi __attribute__((no_sanitize("cfi")))
+#endif
+
 #if __has_attribute(__no_sanitize_address__)
 #define __no_sanitize_address __attribute__((no_sanitize_address))
 #else
diff --git a/kernel/Makefile b/kernel/Makefile
index 318789c728d3..923d3e060852 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -114,6 +114,7 @@ obj-$(CONFIG_SHADOW_CALL_STACK) += scs.o
 obj-$(CONFIG_HAVE_STATIC_CALL) += static_call.o
 obj-$(CONFIG_HAVE_STATIC_CALL_INLINE) += static_call_inline.o
 obj-$(CONFIG_CFI_CLANG) += cfi.o
+obj-$(CONFIG_CFI_GCC) += cfi.o
 
 obj-$(CONFIG_PERF_EVENTS) += events/
 
diff --git a/kernel/cfi.c b/kernel/cfi.c
index 08caad776717..9bff35736756 100644
--- a/kernel/cfi.c
+++ b/kernel/cfi.c
@@ -25,6 +25,7 @@ enum bug_trap_type report_cfi_failure(struct pt_regs *regs, unsigned long addr,
 	return BUG_TRAP_TYPE_BUG;
 }
 
+#ifdef CONFIG_CFI_CLANG
 #ifdef CONFIG_ARCH_USES_CFI_TRAPS
 static inline unsigned long trap_address(s32 *p)
 {
@@ -99,3 +100,25 @@ bool is_cfi_trap(unsigned long addr)
 	return is_module_cfi_trap(addr);
 }
 #endif /* CONFIG_ARCH_USES_CFI_TRAPS */
+#endif /* CONFIG_CFI_CLANG */
+
+
+#ifdef CONFIG_CFI_GCC
+void cfi_check_failed(u32 caller_hash, u32 callee_hash, void *callee_addr)
+{
+	unsigned long pc, target;
+
+	pc = (unsigned long)__builtin_return_address(0);
+	target = (unsigned long)callee_addr;
+
+	switch (report_cfi_failure(NULL, pc, &target, caller_hash)) {
+	case BUG_TRAP_TYPE_WARN:
+		break;
+
+	default:
+		panic("Oops - CFI");
+	}
+}
+EXPORT_SYMBOL(cfi_check_failed);
+
+#endif /* CONFIG_CFI_GCC */
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index ccdf0c897f31..ed8db513b918 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -119,7 +119,9 @@ static bool is_ignored_symbol(const char *name, char type)
 		"__ThumbV7PILongThunk_",
 		"__LA25Thunk_",		/* mips lld */
 		"__microLA25Thunk_",
-		"__kcfi_typeid_",	/* CFI type identifiers */
+		"__kcfi_typeid_",	/* CFI type identifiers in Clang */
+		"__cfi_",		/* CFI type identifiers in GCC */
+		"__pi___cfi",		/* CFI type identifiers in GCC */
 		NULL
 	};
 
-- 
2.17.1

