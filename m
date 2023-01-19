Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B436C6734BE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 10:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjASJsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 04:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjASJr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 04:47:58 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C87676F2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 01:47:43 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AC7B61EC0674;
        Thu, 19 Jan 2023 10:47:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1674121661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pSUMAYyX4KNcWYfWQgxrz7Ggu0rhqzevib+31onaLJg=;
        b=lLKI+rizLSJFzwhgeOnpq8p+ZNr184PlcqpCVeYOrLa5L0/vZAkSauc5BWN0VV3xzlWPmi
        7IKTrBTP5dFj2UhTeCjpwG6sUtNjaY7LZnivZBae6dZ7kHMJmP37w3IapXWXspac+vfbfB
        4E6kwO2QcbTNw06WdQqmG8/ulQ7vqQk=
Date:   Thu, 19 Jan 2023 10:47:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/cpu: Start documenting what the X86_FEATURE_ flag
 testing macros do
Message-ID: <Y8kRuUwsKxYsk1AX@zn.tnic>
References: <20221107211505.8572-1-bp@alien8.de>
 <50b2113d-d6a8-ab36-028d-b78c41142c18@intel.com>
 <Y2okdzF60XHLCK2v@zn.tnic>
 <Y22IzA9DN/xYWgWN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y22IzA9DN/xYWgWN@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another belated reply... ;-\

On Thu, Nov 10, 2022 at 11:27:08PM +0000, Sean Christopherson wrote:
> What about doing the opposite and folding cpu_feature_enabled()'s build-time
> functionality into static_cpu_has() _and_ boot_cpu_has(), and then dropping
> cpu_feature_enabled()?  That way the tradeoffs of using the static variant are
> still captured in code (cpu_feature_enabled() sounds too innocuous to my ears),
> and as an added bonus even slow paths benefit from build-time disabling of features.
> 
> Hiding the use of alternatives in cpu_feature_enabled() seems like it will lead to
> unnecessary code patching.

Actually, tglx and I have a sekrit plan - a small preview below. I don't have
answers to replacing all functionality we have yet but it is a good start and
the goal is to eventually get rid of all the gunk that has grown over the years.

It is a long-term project and only if the day had more than 24 hours ...

commit d4b89111c8bec1c9fbc9a3d5290b3231e9a61c9f
Author: Borislav Petkov <bp@suse.de>
Date:   Fri Nov 25 20:55:57 2022 +0100

    Leaf 1
    
    TODO:
    - Compare cpu_feature_enabled() resulting code after patching with those
      simpler tests.
    
    - Read on the BSP and compare on the APs. Warn if mismatch. When you do
    that, take into consideration the bits cleared by setup_clear_cpu_cap()
    and mask them out from the AP's CPUID word before comparing.
    
    That should happen in apply_forced_caps(), where the settings for each
    AP are consolidated.
    
    Eventually, we'll remove cpu_caps_cleared and cpu_caps_set arrays.
    
    - make __ro_after_init.
    
    Not-really-signed-off-by: Borislav Petkov <bp@suse.de>

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 1a85e1fb0922..8eaf08025c16 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_CPUFEATURE_H
 
 #include <asm/processor.h>
+#include <asm/cpuid.h>
 
 #if defined(__KERNEL__) && !defined(__ASSEMBLY__)
 
@@ -10,30 +11,6 @@
 #include <linux/bitops.h>
 #include <asm/alternative.h>
 
-enum cpuid_leafs
-{
-	CPUID_1_EDX		= 0,
-	CPUID_8000_0001_EDX,
-	CPUID_8086_0001_EDX,
-	CPUID_LNX_1,
-	CPUID_1_ECX,
-	CPUID_C000_0001_EDX,
-	CPUID_8000_0001_ECX,
-	CPUID_LNX_2,
-	CPUID_LNX_3,
-	CPUID_7_0_EBX,
-	CPUID_D_1_EAX,
-	CPUID_LNX_4,
-	CPUID_7_1_EAX,
-	CPUID_8000_0008_EBX,
-	CPUID_6_EAX,
-	CPUID_8000_000A_EDX,
-	CPUID_7_ECX,
-	CPUID_8000_0007_EBX,
-	CPUID_7_EDX,
-	CPUID_8000_001F_EAX,
-};
-
 #define X86_CAP_FMT_NUM "%d:%d"
 #define x86_cap_flag_num(flag) ((flag) >> 5), ((flag) & 31)
 
@@ -143,7 +120,7 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 
 #define boot_cpu_has(bit)	cpu_has(&boot_cpu_data, bit)
 
-#define set_cpu_cap(c, bit)	set_bit(bit, (unsigned long *)((c)->x86_capability))
+#define set_cpu_cap(c, bit)	set_bit(bit & 0x1f, (unsigned long *)get_ap_cap_word(c, bit))
 
 extern void setup_clear_cpu_cap(unsigned int bit);
 extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
@@ -174,13 +151,13 @@ static __always_inline bool _static_cpu_has(u16 bit)
 		ALTERNATIVE_TERNARY("jmp 6f", %P[feature], "", "jmp %l[t_no]")
 		".pushsection .altinstr_aux,\"ax\"\n"
 		"6:\n"
-		" testb %[bitnum]," _ASM_RIP(%P[cap_byte]) "\n"
+		" test %[bitnum], %[cap_word]\n"
 		" jnz %l[t_yes]\n"
 		" jmp %l[t_no]\n"
 		".popsection\n"
 		 : : [feature]  "i" (bit),
-		     [bitnum]   "i" (1 << (bit & 7)),
-		     [cap_byte] "i" (&((const char *)boot_cpu_data.x86_capability)[bit >> 3])
+		     [bitnum]   "i" (1 << (bit & 31)),
+		     [cap_word] "g" (get_boot_cpu_cap_word(bit))
 		 : : t_yes, t_no);
 t_yes:
 	return true;
diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
index 9bee3e7bf973..c2a7d5a2d4e1 100644
--- a/arch/x86/include/asm/cpuid.h
+++ b/arch/x86/include/asm/cpuid.h
@@ -8,6 +8,8 @@
 
 #include <asm/string.h>
 
+struct cpuinfo_x86;
+
 struct cpuid_regs {
 	u32 eax, ebx, ecx, edx;
 };
@@ -19,6 +21,61 @@ enum cpuid_regs_idx {
 	CPUID_EDX,
 };
 
+enum cpuid_leafs
+{
+	CPUID_1_EDX		= 0,
+	CPUID_8000_0001_EDX,
+	CPUID_8086_0001_EDX,
+	CPUID_LNX_1,
+	CPUID_1_ECX,
+	CPUID_C000_0001_EDX,
+	CPUID_8000_0001_ECX,
+	CPUID_LNX_2,
+	CPUID_LNX_3,
+	CPUID_7_0_EBX,
+	CPUID_D_1_EAX,
+	CPUID_LNX_4,
+	CPUID_7_1_EAX,
+	CPUID_8000_0008_EBX,
+	CPUID_6_EAX,
+	CPUID_8000_000A_EDX,
+	CPUID_7_ECX,
+	CPUID_8000_0007_EBX,
+	CPUID_7_EDX,
+	CPUID_8000_001F_EAX,
+};
+
+/*
+ * All CPUID functions
+ */
+struct func_1 {
+	/* EDX */
+	union {
+		struct {
+		u32	fpu	  : 1, vme	 : 1, de	  : 1, pse	: 1,
+			tsc	  : 1, msr	 : 1, pae	  : 1, mce	: 1,
+
+			cx8	  : 1, apic	 : 1, __rsv2	  : 1, sep	: 1,
+			mtrr	  : 1, pge	 : 1, mca	  : 1, cmov	: 1,
+
+			pat	  : 1, pse36	 : 1, psn	  : 1, clfsh	: 1,
+			__rsv3	  : 1, ds	 : 1, acpi	  : 1, mmx	: 1,
+
+			fxsr	  : 1, sse	 : 1, sse2	  : 1, ss	: 1,
+			htt	  : 1, tm	 : 1, __rsv4	  : 1, pbe	: 1;
+		};
+		u32 edx;
+	} __packed;
+};
+
+struct cpuid_info {
+	struct func_1 f1;
+};
+
+extern struct cpuid_info cpuid_info;
+u32 *get_boot_cpu_cap_word(u16 bit);
+u32 *get_ap_cap_word(struct cpuinfo_x86 *c, u16 bit);
+
 #ifdef CONFIG_X86_32
 extern int have_cpuid_p(void);
 #else
@@ -168,4 +225,6 @@ static inline uint32_t hypervisor_cpuid_base(const char *sig, uint32_t leaves)
 	return 0;
 }
 
+void cpuid_read_leafs(void);
+
 #endif /* _ASM_X86_CPUID_H */
diff --git a/arch/x86/include/asm/fpu/sched.h b/arch/x86/include/asm/fpu/sched.h
index b2486b2cbc6e..c903e46f28c9 100644
--- a/arch/x86/include/asm/fpu/sched.h
+++ b/arch/x86/include/asm/fpu/sched.h
@@ -38,8 +38,7 @@ extern void fpu_flush_thread(void);
  */
 static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
 {
-	if (cpu_feature_enabled(X86_FEATURE_FPU) &&
-	    !(current->flags & PF_KTHREAD)) {
+	if (cpuid_info.f1.fpu && !(current->flags & PF_KTHREAD)) {
 		save_fpregs_to_fpstate(old_fpu);
 		/*
 		 * The save operation preserved register state, so the
@@ -61,7 +60,7 @@ static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
  */
 static inline void switch_fpu_finish(void)
 {
-	if (cpu_feature_enabled(X86_FEATURE_FPU))
+	if (cpuid_info.f1.fpu)
 		set_thread_flag(TIF_NEED_FPU_LOAD);
 }
 
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 6836c64b9819..d9502c9e3de4 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -16,7 +16,6 @@ struct vm86;
 #include <uapi/asm/sigcontext.h>
 #include <asm/current.h>
 #include <asm/cpufeatures.h>
-#include <asm/cpuid.h>
 #include <asm/page.h>
 #include <asm/pgtable_types.h>
 #include <asm/percpu.h>
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index f10a921ee756..2a68cec3a240 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -26,7 +26,7 @@ obj-y			+= rdrand.o
 obj-y			+= match.o
 obj-y			+= bugs.o
 obj-y			+= aperfmperf.o
-obj-y			+= cpuid-deps.o
+obj-y			+= cpuid-deps.o cpuid.o
 obj-y			+= umwait.o
 
 obj-$(CONFIG_PROC_FS)	+= proc.o
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3e508f239098..7d816d1e7333 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1541,6 +1541,9 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 
 	/* cyrix could have cpuid enabled via c_identify()*/
 	if (have_cpuid_p()) {
+
+		cpuid_read_leafs();
+
 		cpu_detect(c);
 		get_cpu_vendor(c);
 		get_cpu_cap(c);
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index c881bcafba7d..6b3c81bea902 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -92,7 +92,9 @@ static inline void clear_feature(struct cpuinfo_x86 *c, unsigned int feature)
 		clear_cpu_cap(&boot_cpu_data, feature);
 		set_bit(feature, (unsigned long *)cpu_caps_cleared);
 	} else {
-		clear_bit(feature, (unsigned long *)c->x86_capability);
+		u32 *cap_word = get_ap_cap_word(c, feature);
+
+		clear_bit(feature & 0x1f, (unsigned long *)cap_word);
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/cpuid.c b/arch/x86/kernel/cpu/cpuid.c
new file mode 100644
index 000000000000..b1ad8f0c7430
--- /dev/null
+++ b/arch/x86/kernel/cpu/cpuid.c
@@ -0,0 +1,43 @@
+#include <asm/cpuid.h>
+#include <asm/percpu.h>
+#include <asm/processor.h>
+
+struct cpuid_info cpuid_info;
+EXPORT_SYMBOL_GPL(cpuid_info);
+
+/* Return a pointer to the capability word containing the feature bit. */
+static u32 * __get_cap_word(struct cpuinfo_x86 *c, u16 bit)
+{
+	int cap_word = bit >> 5;
+
+	if (WARN_ON_ONCE(cap_word > NCAPINTS))
+		return 0;
+
+	switch (cap_word) {
+	case CPUID_1_EDX:
+		return &cpuid_info.f1.edx;
+		break;
+	default:
+		return &c->x86_capability[cap_word];
+		break;
+	}
+
+	return 0;
+}
+
+u32 * noinstr get_boot_cpu_cap_word(u16 bit)
+{
+	return __get_cap_word(&boot_cpu_data, bit);
+}
+EXPORT_SYMBOL_GPL(get_boot_cpu_cap_word);
+
+u32 * noinstr get_ap_cap_word(struct cpuinfo_x86 *c, u16 bit)
+{
+	return __get_cap_word(c, bit);
+}
+EXPORT_SYMBOL_GPL(get_ap_cap_word);
+
+void cpuid_read_leafs(void)
+{
+	cpuid_info.f1.edx = cpuid_edx(1);
+}
diff --git a/arch/x86/kernel/cpu/cyrix.c b/arch/x86/kernel/cpu/cyrix.c
index 9651275aecd1..b9782b6290bd 100644
--- a/arch/x86/kernel/cpu/cyrix.c
+++ b/arch/x86/kernel/cpu/cyrix.c
@@ -338,7 +338,7 @@ static void init_cyrix(struct cpuinfo_x86 *c)
 		switch (dir0_lsn) {
 		case 0xd:  /* either a 486SLC or DLC w/o DEVID */
 			dir0_msn = 0;
-			p = Cx486_name[!!boot_cpu_has(X86_FEATURE_FPU)];
+			p = Cx486_name[cpuid_info.f1.fpu];
 			break;
 
 		case 0xe:  /* a 486S A step */
diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index 099b6f0d96bd..cebe8931aec4 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -42,8 +42,8 @@ static void show_cpuinfo_misc(struct seq_file *m, struct cpuinfo_x86 *c)
 		   boot_cpu_has_bug(X86_BUG_FDIV) ? "yes" : "no",
 		   boot_cpu_has_bug(X86_BUG_F00F) ? "yes" : "no",
 		   boot_cpu_has_bug(X86_BUG_COMA) ? "yes" : "no",
-		   boot_cpu_has(X86_FEATURE_FPU) ? "yes" : "no",
-		   boot_cpu_has(X86_FEATURE_FPU) ? "yes" : "no",
+		   cpuid_info.f1.fpu ? "yes" : "no",
+		   cpuid_info.f1.fpu ? "yes" : "no",
 		   c->cpuid_level);
 }
 #else
diff --git a/arch/x86/kernel/fpu/bugs.c b/arch/x86/kernel/fpu/bugs.c
index 794e70151203..647a7c214703 100644
--- a/arch/x86/kernel/fpu/bugs.c
+++ b/arch/x86/kernel/fpu/bugs.c
@@ -27,7 +27,7 @@ void __init fpu__init_check_bugs(void)
 	s32 fdiv_bug;
 
 	/* kernel_fpu_begin/end() relies on patched alternative instructions. */
-	if (!boot_cpu_has(X86_FEATURE_FPU))
+	if (!cpuid_info.f1.fpu)
 		return;
 
 	kernel_fpu_begin();
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index d00db56a8868..90a3f3a74f7b 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -440,7 +440,7 @@ void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 	if (likely(kfpu_mask & KFPU_MXCSR) && boot_cpu_has(X86_FEATURE_XMM))
 		ldmxcsr(MXCSR_DEFAULT);
 
-	if (unlikely(kfpu_mask & KFPU_387) && boot_cpu_has(X86_FEATURE_FPU))
+	if (unlikely(kfpu_mask & KFPU_387) && cpuid_info.f1.fpu)
 		asm volatile ("fninit");
 }
 EXPORT_SYMBOL_GPL(kernel_fpu_begin_mask);
@@ -505,7 +505,7 @@ static inline void fpstate_init_fstate(struct fpstate *fpstate)
  */
 void fpstate_init_user(struct fpstate *fpstate)
 {
-	if (!cpu_feature_enabled(X86_FEATURE_FPU)) {
+	if (!cpuid_info.f1.fpu) {
 		fpstate_init_soft(&fpstate->regs.soft);
 		return;
 	}
@@ -566,7 +566,7 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal)
 
 	fpstate_reset(dst_fpu);
 
-	if (!cpu_feature_enabled(X86_FEATURE_FPU))
+	if (!cpuid_info.f1.fpu)
 		return 0;
 
 	/*
@@ -711,7 +711,7 @@ void fpu__clear_user_states(struct fpu *fpu)
 	WARN_ON_FPU(fpu != &current->thread.fpu);
 
 	fpregs_lock();
-	if (!cpu_feature_enabled(X86_FEATURE_FPU)) {
+	if (!cpuid_info.f1.fpu) {
 		fpu_reset_fpregs();
 		fpregs_unlock();
 		return;
@@ -749,7 +749,7 @@ void fpu_flush_thread(void)
  */
 void switch_fpu_return(void)
 {
-	if (!static_cpu_has(X86_FEATURE_FPU))
+	if (!cpuid_info.f1.fpu)
 		return;
 
 	fpregs_restore_userregs();
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 8946f89761cc..3f4dbb5ef9ee 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -31,13 +31,13 @@ static void fpu__init_cpu_generic(void)
 
 	cr0 = read_cr0();
 	cr0 &= ~(X86_CR0_TS|X86_CR0_EM); /* clear TS and EM */
-	if (!boot_cpu_has(X86_FEATURE_FPU))
+	if (!cpuid_info.f1.fpu)
 		cr0 |= X86_CR0_EM;
 	write_cr0(cr0);
 
 	/* Flush out any pending x87 state: */
 #ifdef CONFIG_MATH_EMULATION
-	if (!boot_cpu_has(X86_FEATURE_FPU))
+	if (!cpuid_info.f1.fpu)
 		fpstate_init_soft(&current->thread.fpu.fpstate->regs.soft);
 	else
 #endif
@@ -82,7 +82,7 @@ static void fpu__init_system_early_generic(struct cpuinfo_x86 *c)
 	}
 
 #ifndef CONFIG_MATH_EMULATION
-	if (!test_cpu_cap(&boot_cpu_data, X86_FEATURE_FPU)) {
+	if (!cpuid_info.f1.fpu) {
 		pr_emerg("x86/fpu: Giving up, no FPU found and no math emulation present\n");
 		for (;;)
 			asm volatile("hlt");
@@ -193,7 +193,7 @@ static void __init fpu__init_system_xstate_size_legacy(void)
 	 * Note that the size configuration might be overwritten later
 	 * during fpu__init_system_xstate().
 	 */
-	if (!cpu_feature_enabled(X86_FEATURE_FPU)) {
+	if (!cpuid_info.f1.fpu) {
 		size = sizeof(struct swregs_state);
 	} else if (cpu_feature_enabled(X86_FEATURE_FXSR)) {
 		size = sizeof(struct fxregs_state);
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 75ffaef8c299..e07e837bfbe6 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -325,7 +325,7 @@ int fpregs_get(struct task_struct *target, const struct user_regset *regset,
 
 	sync_fpstate(fpu);
 
-	if (!cpu_feature_enabled(X86_FEATURE_FPU))
+	if (!cpuid_info.f1.fpu)
 		return fpregs_soft_get(target, regset, to);
 
 	if (!cpu_feature_enabled(X86_FEATURE_FXSR)) {
@@ -359,7 +359,7 @@ int fpregs_set(struct task_struct *target, const struct user_regset *regset,
 	if (pos != 0 || count != sizeof(struct user_i387_ia32_struct))
 		return -EINVAL;
 
-	if (!cpu_feature_enabled(X86_FEATURE_FPU))
+	if (!cpuid_info.f1.fpu)
 		return fpregs_soft_set(target, regset, pos, count, kbuf, ubuf);
 
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &env, 0, -1);
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 91d4b6de58ab..3c6feb69a62a 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -195,7 +195,7 @@ bool copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 	ia32_fxstate &= (IS_ENABLED(CONFIG_X86_32) ||
 			 IS_ENABLED(CONFIG_IA32_EMULATION));
 
-	if (!static_cpu_has(X86_FEATURE_FPU)) {
+	if (!cpuid_info.f1.fpu) {
 		struct user_i387_ia32_struct fp;
 
 		fpregs_soft_get(current, NULL, (struct membuf){.p = &fp,
@@ -488,7 +488,7 @@ bool fpu__restore_sig(void __user *buf, int ia32_frame)
 	if (!access_ok(buf, size))
 		goto out;
 
-	if (!IS_ENABLED(CONFIG_X86_64) && !cpu_feature_enabled(X86_FEATURE_FPU)) {
+	if (!IS_ENABLED(CONFIG_X86_64) && !cpuid_info.f1.fpu) {
 		success = !fpregs_soft_set(current, NULL, 0,
 					   sizeof(struct user_i387_ia32_struct),
 					   NULL, buf);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 59e543b95a3c..76eef683e9c1 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -752,7 +752,7 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 	int err;
 	int i;
 
-	if (!boot_cpu_has(X86_FEATURE_FPU)) {
+	if (!cpuid_info.f1.fpu) {
 		pr_info("x86/fpu: No FPU detected\n");
 		return;
 	}
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index d3fdec706f1d..faa90a0d8dc6 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1326,7 +1326,7 @@ DEFINE_IDTENTRY(exc_device_not_available)
 		return;
 
 #ifdef CONFIG_MATH_EMULATION
-	if (!boot_cpu_has(X86_FEATURE_FPU) && (cr0 & X86_CR0_EM)) {
+	if (!cpuid_info.f1.fpu && (cr0 & X86_CR0_EM)) {
 		struct math_emu_info info = { };
 
 		cond_local_irq_enable(regs);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 490ec23c8450..5dc382c3fc20 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9349,7 +9349,7 @@ int kvm_arch_init(void *opaque)
 	 * FXSAVE/FXRSTOR. For example, the KVM_GET_FPU explicitly casts the
 	 * vCPU's FPU state as a fxregs_state struct.
 	 */
-	if (!boot_cpu_has(X86_FEATURE_FPU) || !boot_cpu_has(X86_FEATURE_FXSR)) {
+	if (!cpuid_info.f1.fpu || !boot_cpu_has(X86_FEATURE_FXSR)) {
 		printk(KERN_ERR "kvm: inadequate fpu\n");
 		return -EOPNOTSUPP;
 	}


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
