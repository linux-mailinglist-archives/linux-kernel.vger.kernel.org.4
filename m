Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090AE6F149A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 11:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjD1JyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 05:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345828AbjD1Jx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 05:53:56 -0400
Received: from out0-216.mail.aliyun.com (out0-216.mail.aliyun.com [140.205.0.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B584696;
        Fri, 28 Apr 2023 02:53:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047194;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=35;SR=0;TI=SMTPD_---.STFQGKD_1682675559;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.STFQGKD_1682675559)
          by smtp.aliyun-inc.com;
          Fri, 28 Apr 2023 17:52:41 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Thomas Garnier" <thgarnie@chromium.org>,
        "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
        "Brian Gerst" <brgerst@gmail.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Juergen Gross" <jgross@suse.com>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Darren Hart" <dvhart@infradead.org>,
        "Andy Shevchenko" <andy@infradead.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Tom Rix" <trix@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "=?UTF-8?B?TWlrZSBSYXBvcG9ydCAoSUJNKQ==?=" <rppt@kernel.org>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Rick Edgecombe" <rick.p.edgecombe@intel.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Guo Ren" <guoren@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>,
        "Kim Phillips" <kim.phillips@amd.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        <xen-devel@lists.xenproject.org>,
        <platform-driver-x86@vger.kernel.org>, <llvm@lists.linux.dev>
Subject: [PATCH RFC 16/43] x86-64: Use per-cpu stack canary if supported by compiler
Date:   Fri, 28 Apr 2023 17:50:56 +0800
Message-Id: <7cee0c83225ffd8cf8fd0065bea9348f6db3b12a.1682673543.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Gerst <brgerst@gmail.com>

From: Brian Gerst <brgerst@gmail.com>

If the compiler supports it, use a standard per-cpu variable for the
stack protector instead of the old fixed location.  Keep the fixed
location code for compatibility with older compilers.

[Hou Wenlong: Disable it on Clang, adapt new code change and adapt
missing GS set up path in pvh_start_xen()]

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Co-developed-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: Thomas Garnier <thgarnie@chromium.org>
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/x86/Kconfig                      | 12 ++++++++++++
 arch/x86/Makefile                     | 21 ++++++++++++++-------
 arch/x86/entry/entry_64.S             |  6 +++++-
 arch/x86/include/asm/processor.h      | 17 ++++++++++++-----
 arch/x86/include/asm/stackprotector.h | 16 +++++++---------
 arch/x86/kernel/asm-offsets_64.c      |  2 +-
 arch/x86/kernel/cpu/common.c          | 15 +++++++--------
 arch/x86/kernel/head_64.S             | 16 ++++++++++------
 arch/x86/kernel/vmlinux.lds.S         |  4 +++-
 arch/x86/platform/pvh/head.S          |  8 ++++++++
 arch/x86/xen/xen-head.S               | 14 +++++++++-----
 11 files changed, 88 insertions(+), 43 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 68e5da464b96..55cce8cdf9bd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -410,6 +410,18 @@ config CC_HAS_SANE_STACKPROTECTOR
 	  the compiler produces broken code or if it does not let us control
 	  the segment on 32-bit kernels.
 
+config CC_HAS_CUSTOMIZED_STACKPROTECTOR
+	bool
+	# Although clang supports -mstack-protector-guard-reg option, it
+	# would generate GOT reference for __stack_chk_guard even with
+	# -fno-PIE flag.
+	default y if (!CC_IS_CLANG && $(cc-option,-mstack-protector-guard-reg=gs))
+
+config STACKPROTECTOR_FIXED
+	bool
+	depends on X86_64 && STACKPROTECTOR
+	default !CC_HAS_CUSTOMIZED_STACKPROTECTOR
+
 menu "Processor type and features"
 
 config SMP
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index b39975977c03..57e4dbbf501d 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -111,13 +111,7 @@ ifeq ($(CONFIG_X86_32),y)
         # temporary until string.h is fixed
         KBUILD_CFLAGS += -ffreestanding
 
-	ifeq ($(CONFIG_STACKPROTECTOR),y)
-		ifeq ($(CONFIG_SMP),y)
-			KBUILD_CFLAGS += -mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard
-		else
-			KBUILD_CFLAGS += -mstack-protector-guard=global
-		endif
-	endif
+	percpu_seg := fs
 else
         BITS := 64
         UTS_MACHINE := x86_64
@@ -167,6 +161,19 @@ else
         KBUILD_CFLAGS += -mcmodel=kernel
         KBUILD_RUSTFLAGS += -Cno-redzone=y
         KBUILD_RUSTFLAGS += -Ccode-model=kernel
+
+	percpu_seg := gs
+endif
+
+ifeq ($(CONFIG_STACKPROTECTOR),y)
+	ifneq ($(CONFIG_STACKPROTECTOR_FIXED),y)
+		ifeq ($(CONFIG_SMP),y)
+			KBUILD_CFLAGS += -mstack-protector-guard-reg=$(percpu_seg) \
+					 -mstack-protector-guard-symbol=__stack_chk_guard
+		else
+			KBUILD_CFLAGS += -mstack-protector-guard=global
+		endif
+	endif
 endif
 
 #
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 6f2297ebb15f..df79b7aa65bb 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -229,6 +229,10 @@ SYM_INNER_LABEL(entry_SYSRETQ_end, SYM_L_GLOBAL)
 	int3
 SYM_CODE_END(entry_SYSCALL_64)
 
+#ifdef CONFIG_STACKPROTECTOR_FIXED
+#define __stack_chk_guard fixed_percpu_data + FIXED_stack_canary
+#endif
+
 /*
  * %rdi: prev task
  * %rsi: next task
@@ -252,7 +256,7 @@ SYM_FUNC_START(__switch_to_asm)
 
 #ifdef CONFIG_STACKPROTECTOR
 	movq	TASK_stack_canary(%rsi), %rbx
-	movq	%rbx, PER_CPU_VAR(fixed_percpu_data) + FIXED_stack_canary
+	movq	%rbx, PER_CPU_VAR(__stack_chk_guard)
 #endif
 
 	/*
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 2a5ec5750ba7..3890f609569d 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -379,6 +379,8 @@ struct irq_stack {
 } __aligned(IRQ_STACK_SIZE);
 
 #ifdef CONFIG_X86_64
+
+#ifdef CONFIG_STACKPROTECTOR_FIXED
 struct fixed_percpu_data {
 	/*
 	 * GCC hardcodes the stack canary as %gs:40.  Since the
@@ -394,21 +396,26 @@ struct fixed_percpu_data {
 
 DECLARE_PER_CPU_FIRST(struct fixed_percpu_data, fixed_percpu_data) __visible;
 DECLARE_INIT_PER_CPU(fixed_percpu_data);
+#endif /* CONFIG_STACKPROTECTOR_FIXED */
 
 static inline unsigned long cpu_kernelmode_gs_base(int cpu)
 {
+#ifdef CONFIG_STACKPROTECTOR_FIXED
 	return (unsigned long)per_cpu(fixed_percpu_data.gs_base, cpu);
+#else
+#ifdef CONFIG_SMP
+	return per_cpu_offset(cpu);
+#else
+	return 0;
+#endif
+#endif
 }
 
 extern asmlinkage void ignore_sysret(void);
 
 /* Save actual FS/GS selectors and bases to current->thread */
 void current_save_fsgs(void);
-#else	/* X86_64 */
-#ifdef CONFIG_STACKPROTECTOR
-DECLARE_PER_CPU(unsigned long, __stack_chk_guard);
-#endif
-#endif	/* !X86_64 */
+#endif	/* X86_64 */
 
 struct perf_event;
 
diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
index 00473a650f51..24aa0e2ad0dd 100644
--- a/arch/x86/include/asm/stackprotector.h
+++ b/arch/x86/include/asm/stackprotector.h
@@ -36,6 +36,12 @@
 
 #include <linux/sched.h>
 
+#ifdef CONFIG_STACKPROTECTOR_FIXED
+#define __stack_chk_guard fixed_percpu_data.stack_canary
+#else
+DECLARE_PER_CPU(unsigned long, __stack_chk_guard);
+#endif
+
 /*
  * Initialize the stackprotector canary value.
  *
@@ -51,25 +57,17 @@ static __always_inline void boot_init_stack_canary(void)
 {
 	unsigned long canary = get_random_canary();
 
-#ifdef CONFIG_X86_64
+#ifdef CONFIG_STACKPROTECTOR_FIXED
 	BUILD_BUG_ON(offsetof(struct fixed_percpu_data, stack_canary) != 40);
 #endif
 
 	current->stack_canary = canary;
-#ifdef CONFIG_X86_64
-	this_cpu_write(fixed_percpu_data.stack_canary, canary);
-#else
 	this_cpu_write(__stack_chk_guard, canary);
-#endif
 }
 
 static inline void cpu_init_stack_canary(int cpu, struct task_struct *idle)
 {
-#ifdef CONFIG_X86_64
-	per_cpu(fixed_percpu_data.stack_canary, cpu) = idle->stack_canary;
-#else
 	per_cpu(__stack_chk_guard, cpu) = idle->stack_canary;
-#endif
 }
 
 #else	/* STACKPROTECTOR */
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index bb65371ea9df..f39baf90126c 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -56,7 +56,7 @@ int main(void)
 
 	BLANK();
 
-#ifdef CONFIG_STACKPROTECTOR
+#ifdef CONFIG_STACKPROTECTOR_FIXED
 	OFFSET(FIXED_stack_canary, fixed_percpu_data, stack_canary);
 	BLANK();
 #endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3ea06b0b4570..972b1babf731 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2051,10 +2051,6 @@ DEFINE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot) = {
 EXPORT_PER_CPU_SYMBOL(pcpu_hot);
 
 #ifdef CONFIG_X86_64
-DEFINE_PER_CPU_FIRST(struct fixed_percpu_data,
-		     fixed_percpu_data) __aligned(PAGE_SIZE) __visible;
-EXPORT_PER_CPU_SYMBOL_GPL(fixed_percpu_data);
-
 static void wrmsrl_cstar(unsigned long val)
 {
 	/*
@@ -2102,15 +2098,18 @@ void syscall_init(void)
 	       X86_EFLAGS_IOPL|X86_EFLAGS_NT|X86_EFLAGS_RF|
 	       X86_EFLAGS_AC|X86_EFLAGS_ID);
 }
-
-#else	/* CONFIG_X86_64 */
+#endif	/* CONFIG_X86_64 */
 
 #ifdef CONFIG_STACKPROTECTOR
+#ifdef CONFIG_STACKPROTECTOR_FIXED
+DEFINE_PER_CPU_FIRST(struct fixed_percpu_data,
+		     fixed_percpu_data) __aligned(PAGE_SIZE) __visible;
+EXPORT_PER_CPU_SYMBOL_GPL(fixed_percpu_data);
+#else
 DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
 EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
 #endif
-
-#endif	/* CONFIG_X86_64 */
+#endif
 
 /*
  * Clear all 6 debug registers:
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 21f0556d3ac0..61f1873d0ff7 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -68,7 +68,13 @@ SYM_CODE_START_NOALIGN(startup_64)
 
 	/* Setup GSBASE to allow stack canary access for C code */
 	movl	$MSR_GS_BASE, %ecx
+#if defined(CONFIG_STACKPROTECTOR_FIXED)
 	leaq	INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
+#elif defined(CONFIG_SMP)
+	movabs	$__per_cpu_load, %rdx
+#else
+	xorl	%edx, %edx
+#endif
 	movl	%edx, %eax
 	shrq	$32,  %rdx
 	wrmsr
@@ -283,16 +289,14 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	movl %eax,%fs
 	movl %eax,%gs
 
-	/* Set up %gs.
-	 *
-	 * The base of %gs always points to fixed_percpu_data. If the
-	 * stack protector canary is enabled, it is located at %gs:40.
+	/*
+	 * Set up GS base.
 	 * Note that, on SMP, the boot cpu uses init data section until
 	 * the per cpu areas are set up.
 	 */
 	movl	$MSR_GS_BASE,%ecx
-#ifndef CONFIG_SMP
-	leaq	INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
+#if !defined(CONFIG_SMP) && defined(CONFIG_STACKPROTECTOR_FIXED)
+	leaq	__per_cpu_load(%rip), %rdx
 #endif
 	movl	%edx, %eax
 	shrq	$32, %rdx
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 25f155205770..f02dcde9f8a8 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -500,12 +500,14 @@ SECTIONS
  */
 #define INIT_PER_CPU(x) init_per_cpu__##x = ABSOLUTE(x) + __per_cpu_load
 INIT_PER_CPU(gdt_page);
-INIT_PER_CPU(fixed_percpu_data);
 INIT_PER_CPU(irq_stack_backing_store);
 
+#ifdef CONFIG_STACKPROTECTOR_FIXED
+INIT_PER_CPU(fixed_percpu_data);
 #ifdef CONFIG_SMP
 . = ASSERT((fixed_percpu_data == 0),
            "fixed_percpu_data is not at start of per-cpu area");
 #endif
+#endif
 
 #endif /* CONFIG_X86_64 */
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index b093996b7e19..5842fe0e4f96 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -96,8 +96,16 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 1:
 	/* Set base address in stack canary descriptor. */
 	mov $MSR_GS_BASE,%ecx
+#if defined(CONFIG_STACKPROTECTOR_FIXED)
 	mov $_pa(INIT_PER_CPU_VAR(fixed_percpu_data)), %eax
 	xor %edx, %edx
+#elif defined(CONFIG_SMP)
+	mov $__per_cpu_load, %rax
+	cdq
+#else
+	xor %eax, %eax
+	xor %edx, %edx
+#endif
 	wrmsr
 
 	call xen_prepare_pvh
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 643d02900fbb..09eaf59e8066 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -51,15 +51,19 @@ SYM_CODE_START(startup_xen)
 
 	leaq	(__end_init_task - PTREGS_SIZE)(%rip), %rsp
 
-	/* Set up %gs.
-	 *
-	 * The base of %gs always points to fixed_percpu_data.  If the
-	 * stack protector canary is enabled, it is located at %gs:40.
+	/*
+	 * Set up GS base.
 	 * Note that, on SMP, the boot cpu uses init data section until
 	 * the per cpu areas are set up.
 	 */
 	movl	$MSR_GS_BASE,%ecx
-	movq	$INIT_PER_CPU_VAR(fixed_percpu_data),%rax
+#if defined(CONFIG_STACKPROTECTOR_FIXED)
+	leaq	INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
+#elif defined(CONFIG_SMP)
+	movabs	$__per_cpu_load, %rdx
+#else
+	xorl	%eax, %eax
+#endif
 	cdq
 	wrmsr
 
-- 
2.31.1

