Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43212697EE1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 15:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjBOOzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 09:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjBOOzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 09:55:08 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAE939CF2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 06:54:34 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id m10so10510808wrn.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 06:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Th2e52Ts8GBThcPpakljZ9Li92MFnHMTVi+rZRm810w=;
        b=QU+oHa7g5LJjD2df5X41sBMZSkYRLCTyrt/PfEtr5DlN3KX0bii+o8MgMXvQ0dzxOC
         lu8ZLMknp7lBArQ8s5MhtwbSzh6lOsvDBVzuNP6lQACTGhZb7vjHlkCYAI4pASTO253u
         UKmFRfQR6AKYV9h/j1kdcBnYk5lIIhAmyNXZtUq4LQiwzcWgpgkF5zJSHN2oLvohfCZv
         MIwCISvgnJ3+0eG3e+6eJ8T2zq1K+CCGem8WtrVn//+Mw+uQuNL/0v/ejQxviOdXv8U1
         hrCNVuDPNx6g/ut1X8LPSaVq3ZVgn6u86zo6fjvLR4Qv852MIdKGAXeM6I8gvBC/Nmjz
         B2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Th2e52Ts8GBThcPpakljZ9Li92MFnHMTVi+rZRm810w=;
        b=EKueO+qiM/OdtvgDkwv1UA3BP4lP5XMTm9SE/AQDHLR2SENFXnOE0J2c/yiX8PrhEc
         6CCl/z4JmHF8x2kszFeKg7vS4BTSafT6eerysByKWmeIw30nsBwkiB/SnqZ6CE+7Br2n
         1h77q+6YYBRQnLKB7VqQP4HJTS/enntuh4DqljUZpGxJhKVnZHfRzis6Fag/XRvJ3bk5
         QV5AjdBz/lHV3CRjGt+HdiZZc7NXN5hEdk2KXpKmQDr+w7NxWjZD0Q3VuqavLeuBpOkw
         DQALwqgcKuNgaDigQvCaxp628/5kgizXFJUitrZE0Blb2e8IFSiKPCEI+ZWlOPNo3K8R
         JQFw==
X-Gm-Message-State: AO0yUKUCbpT+Nw/VjvY+GFi+qNFeGD/uWFNF8jrLqPvBlfkbFh+yqF1t
        hPsmqMd5p86hqBXKPt5HJr4Cag==
X-Google-Smtp-Source: AK7set/fY0xUlnvh1mfQLLs8/gPsHqtxGovqpg57Ta9RzVlYrwzaKK3e8nsM0CLVJ4tlAmPfEy+fiw==
X-Received: by 2002:a05:6000:1182:b0:2c3:f812:1cad with SMTP id g2-20020a056000118200b002c3f8121cadmr1732845wrx.37.1676472874283;
        Wed, 15 Feb 2023 06:54:34 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:8487:6a9a:3a67:11aa])
        by smtp.gmail.com with ESMTPSA id t13-20020adfe44d000000b002c557f82e27sm8495508wrm.99.2023.02.15.06.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 06:54:33 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     dwmw2@infradead.org, tglx@linutronix.de, kim.phillips@amd.com
Cc:     arjan@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        rcu@vger.kernel.org, mimoja@mimoja.de, hewenliang4@huawei.com,
        thomas.lendacky@amd.com, seanjc@google.com, pmenzel@molgen.mpg.de,
        fam.zheng@bytedance.com, punit.agrawal@bytedance.com,
        simon.evans@bytedance.com, liangma@liangbit.com,
        David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH v9 6/8] x86/smpboot: Support parallel startup of secondary CPUs
Date:   Wed, 15 Feb 2023 14:54:23 +0000
Message-Id: <20230215145425.420125-7-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230215145425.420125-1-usama.arif@bytedance.com>
References: <20230215145425.420125-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

Rework the real-mode startup code to allow for APs to be brought up in
parallel. This is in two parts:

1. Introduce a bit-spinlock to prevent them from all using the real
   mode stack at the same time.

2. Avoid the use of global variables for passing per-CPU information to
   the APs.

To achieve the latter, export the cpuid_to_apicid[] array so that each
AP can find its own per_cpu data (and thus initial_gs, initial_stack and
early_gdt_descr) by searching therein based on its APIC ID.

Introduce a global variable 'smpboot_control' indicating to the AP how
it should find its APIC ID. For a serialized bringup, the APIC ID is
explicitly passed in the low bits of smpboot_control, while for parallel
mode there are flags directing the AP to find its APIC ID in CPUID leaf
0x0b (for X2APIC mode) or CPUID leaf 0x01 where 8 bits are sufficient.

Parallel startup may be disabled by a command line option, and also if:
 • AMD SEV-ES is in use, since the AP may not use CPUID that early.
 • X2APIC is enabled, but CPUID leaf 0xb is not present and correect.
 • X2APIC is not enabled but not even CPUID leaf 0x01 exists.

Aside from the fact that APs will now look up their per-cpu data via the
newly-exported cpuid_to_apicid[] table, there is no behavioural change
intended yet, since new parallel CPUHP states have not — yet — been added.

[ tglx: Initial proof of concept patch with bitlock and APIC ID lookup ]
[ dwmw2: Rework and testing, commit message, CPUID 0x1 and CPU0 support ]
[ seanc: Fix stray override of initial_gs in common_cpu_up() ]
Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 .../admin-guide/kernel-parameters.txt         |  3 +
 arch/x86/include/asm/realmode.h               |  3 +
 arch/x86/include/asm/smp.h                    | 10 +-
 arch/x86/kernel/acpi/sleep.c                  |  1 +
 arch/x86/kernel/apic/apic.c                   |  2 +-
 arch/x86/kernel/head_64.S                     | 99 ++++++++++++++++++-
 arch/x86/kernel/smpboot.c                     | 62 +++++++++++-
 arch/x86/realmode/init.c                      |  3 +
 arch/x86/realmode/rm/trampoline_64.S          | 14 +++
 kernel/smpboot.c                              |  2 +-
 10 files changed, 191 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6cfa6e3996cf..ee099b8aac6d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3819,6 +3819,9 @@
 
 	nomodule	Disable module load
 
+	no_parallel_bringup
+			[X86,SMP] Disable parallel brinugp of secondary cores.
+
 	nopat		[X86] Disable PAT (page attribute table extension of
 			pagetables) support.
 
diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index a336feef0af1..f0357cfe2fb0 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -52,6 +52,7 @@ struct trampoline_header {
 	u64 efer;
 	u32 cr4;
 	u32 flags;
+	u32 lock;
 #endif
 };
 
@@ -65,6 +66,8 @@ extern unsigned long initial_stack;
 extern unsigned long initial_vc_handler;
 #endif
 
+extern u32 *trampoline_lock;
+
 extern unsigned char real_mode_blob[];
 extern unsigned char real_mode_relocs[];
 
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index b4dbb20dab1a..33c0d5fd8af6 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -199,5 +199,13 @@ extern void nmi_selftest(void);
 #define nmi_selftest() do { } while (0)
 #endif
 
-#endif /* __ASSEMBLY__ */
+extern unsigned int smpboot_control;
+
+#endif /* !__ASSEMBLY__ */
+
+/* Control bits for startup_64 */
+#define STARTUP_SECONDARY	0x80000000
+#define STARTUP_APICID_CPUID_0B	0x40000000
+#define STARTUP_APICID_CPUID_01	0x20000000
+
 #endif /* _ASM_X86_SMP_H */
diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index 3b7f4cdbf2e0..06adf340a0f1 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -115,6 +115,7 @@ int x86_acpi_suspend_lowlevel(void)
 	early_gdt_descr.address =
 			(unsigned long)get_cpu_gdt_rw(smp_processor_id());
 	initial_gs = per_cpu_offset(smp_processor_id());
+	smpboot_control = 0;
 #endif
 	initial_code = (unsigned long)wakeup_long64;
        saved_magic = 0x123456789abcdef0L;
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 20d9a604da7c..ac1d7e5da1f2 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2377,7 +2377,7 @@ static int nr_logical_cpuids = 1;
 /*
  * Used to store mapping between logical CPU IDs and APIC IDs.
  */
-static int cpuid_to_apicid[] = {
+int cpuid_to_apicid[] = {
 	[0 ... NR_CPUS - 1] = -1,
 };
 
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 222efd4a09bc..0e4e53d231db 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -25,6 +25,7 @@
 #include <asm/export.h>
 #include <asm/nospec-branch.h>
 #include <asm/fixmap.h>
+#include <asm/smp.h>
 
 /*
  * We are not able to switch in one step to the final KERNEL ADDRESS SPACE
@@ -241,6 +242,83 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	UNWIND_HINT_EMPTY
 	ANNOTATE_NOENDBR // above
 
+#ifdef CONFIG_SMP
+	/*
+	 * Is this the boot CPU coming up? If so everything is available
+	 * in initial_gs, initial_stack and early_gdt_descr.
+	 */
+	movl	smpboot_control(%rip), %edx
+	testl	$STARTUP_SECONDARY, %edx
+	jz	.Lsetup_cpu
+
+	/*
+	 * Secondary CPUs find out the offsets via the APIC ID. For parallel
+	 * boot the APIC ID is retrieved from CPUID, otherwise it's encoded
+	 * in smpboot_control:
+	 * Bit 31	STARTUP_SECONDARY flag (checked above)
+	 * Bit 30	STARTUP_APICID_CPUID_0B flag (use CPUID 0x0b)
+	 * Bit 29	STARTUP_APICID_CPUID_01 flag (use CPUID 0x01)
+	 * Bit 0-24	APIC ID if STARTUP_APICID_CPUID_xx flags are not set
+	 */
+	testl	$STARTUP_APICID_CPUID_0B, %edx
+	jnz	.Luse_cpuid_0b
+	testl	$STARTUP_APICID_CPUID_01, %edx
+	jnz	.Luse_cpuid_01
+	andl	$0x0FFFFFFF, %edx
+	jmp	.Lsetup_AP
+
+.Luse_cpuid_01:
+	mov	$0x01, %eax
+	cpuid
+	mov	%ebx, %edx
+	shr	$24, %edx
+	jmp	.Lsetup_AP
+
+.Luse_cpuid_0b:
+	mov	$0x0B, %eax
+	xorl	%ecx, %ecx
+	cpuid
+
+.Lsetup_AP:
+	/* EDX contains the APIC ID of the current CPU */
+	xorq	%rcx, %rcx
+	leaq	cpuid_to_apicid(%rip), %rbx
+
+.Lfind_cpunr:
+	cmpl	(%rbx,%rcx,4), %edx
+	jz	.Linit_cpu_data
+	inc	%ecx
+	cmpl	nr_cpu_ids(%rip), %ecx
+	jb	.Lfind_cpunr
+
+	/*  APIC ID not found in the table. Drop the trampoline lock and bail. */
+	movq	trampoline_lock(%rip), %rax
+	lock
+	btrl	$0, (%rax)
+
+1:	cli
+	hlt
+	jmp	1b
+
+.Linit_cpu_data:
+	/* Get the per cpu offset for the given CPU# which is in ECX */
+	leaq	__per_cpu_offset(%rip), %rbx
+	movq	(%rbx,%rcx,8), %rbx
+	/* Save it for GS BASE setup */
+	movq	%rbx, initial_gs(%rip)
+
+	/* Calculate the GDT address */
+	movq	$gdt_page, %rcx
+	addq	%rbx, %rcx
+	movq	%rcx, early_gdt_descr_base(%rip)
+
+	/* Find the idle task stack */
+	movq	idle_threads(%rbx), %rcx
+	movq	TASK_threadsp(%rcx), %rcx
+	movq	%rcx, initial_stack(%rip)
+#endif /* CONFIG_SMP */
+
+.Lsetup_cpu:
 	/*
 	 * We must switch to a new descriptor in kernel space for the GDT
 	 * because soon the kernel won't have access anymore to the userspace
@@ -281,6 +359,14 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	 */
 	movq initial_stack(%rip), %rsp
 
+	/* Drop the realmode protection. For the boot CPU the pointer is NULL! */
+	movq	trampoline_lock(%rip), %rax
+	testq	%rax, %rax
+	jz	.Lsetup_idt
+	lock
+	btrl	$0, (%rax)
+
+.Lsetup_idt:
 	/* Setup and Load IDT */
 	pushq	%rsi
 	call	early_setup_idt
@@ -372,7 +458,14 @@ SYM_CODE_END(secondary_startup_64)
 SYM_CODE_START(start_cpu0)
 	ANNOTATE_NOENDBR
 	UNWIND_HINT_EMPTY
-	movq	initial_stack(%rip), %rsp
+	/* Load the per-cpu base for CPU#0 */
+	leaq	__per_cpu_offset(%rip), %rbx
+	movq	(%rbx), %rbx
+
+	/* Find the idle task stack */
+	movq	idle_threads(%rbx), %rcx
+	movq	TASK_threadsp(%rcx), %rsp
+
 	jmp	.Ljump_to_C_code
 SYM_CODE_END(start_cpu0)
 #endif
@@ -426,6 +519,7 @@ SYM_DATA(initial_vc_handler,	.quad handle_vc_boot_ghcb)
  * reliably detect the end of the stack.
  */
 SYM_DATA(initial_stack, .quad init_thread_union + THREAD_SIZE - FRAME_SIZE)
+SYM_DATA(trampoline_lock, .quad 0);
 	__FINITDATA
 
 	__INIT
@@ -660,6 +754,9 @@ SYM_DATA_END(level1_fixmap_pgt)
 SYM_DATA(early_gdt_descr,		.word GDT_ENTRIES*8-1)
 SYM_DATA_LOCAL(early_gdt_descr_base,	.quad INIT_PER_CPU_VAR(gdt_page))
 
+	.align 16
+SYM_DATA(smpboot_control,		.long 0)
+
 	.align 16
 /* This must match the first entry in level2_kernel_pgt */
 SYM_DATA(phys_base, .quad 0x0)
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index b9366f86c433..49d6563e4c23 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -797,6 +797,16 @@ static int __init cpu_init_udelay(char *str)
 }
 early_param("cpu_init_udelay", cpu_init_udelay);
 
+static bool do_parallel_bringup __ro_after_init = true;
+
+static int __init no_parallel_bringup(char *str)
+{
+	do_parallel_bringup = false;
+
+	return 0;
+}
+early_param("no_parallel_bringup", no_parallel_bringup);
+
 static void __init smp_quirk_init_udelay(void)
 {
 	/* if cmdline changed it from default, leave it alone */
@@ -1084,8 +1094,6 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 #ifdef CONFIG_X86_32
 	/* Stack for startup_32 can be just as for start_secondary onwards */
 	per_cpu(pcpu_hot.top_of_stack, cpu) = task_top_of_stack(idle);
-#else
-	initial_gs = per_cpu_offset(cpu);
 #endif
 	return 0;
 }
@@ -1110,9 +1118,14 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 		start_ip = real_mode_header->trampoline_start64;
 #endif
 	idle->thread.sp = (unsigned long)task_pt_regs(idle);
-	early_gdt_descr.address = (unsigned long)get_cpu_gdt_rw(cpu);
 	initial_code = (unsigned long)start_secondary;
-	initial_stack  = idle->thread.sp;
+
+	if (IS_ENABLED(CONFIG_X86_32)) {
+		early_gdt_descr.address = (unsigned long)get_cpu_gdt_rw(cpu);
+		initial_stack  = idle->thread.sp;
+	} else if (!do_parallel_bringup) {
+		smpboot_control = STARTUP_SECONDARY | apicid;
+	}
 
 	/* Enable the espfix hack for this CPU */
 	init_espfix_ap(cpu);
@@ -1512,6 +1525,47 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 
 	speculative_store_bypass_ht_init();
 
+	/*
+	 * We can do 64-bit AP bringup in parallel if the CPU reports
+	 * its APIC ID in CPUID (either leaf 0x0B if we need the full
+	 * APIC ID in X2APIC mode, or leaf 0x01 if 8 bits are
+	 * sufficient). Otherwise it's too hard. And not for SEV-ES
+	 * guests because they can't use CPUID that early.
+	 */
+	if (IS_ENABLED(CONFIG_X86_32) || boot_cpu_data.cpuid_level < 1 ||
+	    (x2apic_mode && boot_cpu_data.cpuid_level < 0xb) ||
+	    cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+		do_parallel_bringup = false;
+
+	if (do_parallel_bringup && x2apic_mode) {
+		unsigned int eax, ebx, ecx, edx;
+
+		/*
+		 * To support parallel bringup in x2apic mode, the AP will need
+		 * to obtain its APIC ID from CPUID 0x0B, since CPUID 0x01 has
+		 * only 8 bits. Check that it is present and seems correct.
+		 */
+		cpuid_count(0xb, 0, &eax, &ebx, &ecx, &edx);
+
+		/*
+		 * AMD says that if executed with an umimplemented level in
+		 * ECX, then it will return all zeroes in EAX. Intel says it
+		 * will return zeroes in both EAX and EBX. Checking only EAX
+		 * should be sufficient.
+		 */
+		if (eax) {
+			pr_debug("Using CPUID 0xb for parallel CPU startup\n");
+			smpboot_control = STARTUP_SECONDARY | STARTUP_APICID_CPUID_0B;
+		} else {
+			pr_info("Disabling parallel bringup because CPUID 0xb looks untrustworthy\n");
+			do_parallel_bringup = false;
+		}
+	} else if (do_parallel_bringup) {
+		/* Without X2APIC, what's in CPUID 0x01 should suffice. */
+		pr_debug("Using CPUID 0x1 for parallel CPU startup\n");
+		smpboot_control = STARTUP_SECONDARY | STARTUP_APICID_CPUID_01;
+	}
+
 	snp_set_wakeup_secondary_cpu();
 }
 
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index af565816d2ba..788e5559549f 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -154,6 +154,9 @@ static void __init setup_real_mode(void)
 
 	trampoline_header->flags = 0;
 
+	trampoline_lock = &trampoline_header->lock;
+	*trampoline_lock = 0;
+
 	trampoline_pgd = (u64 *) __va(real_mode_header->trampoline_pgd);
 
 	/* Map the real mode stub as virtual == physical */
diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index e38d61d6562e..49ebc1636ffd 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -49,6 +49,19 @@ SYM_CODE_START(trampoline_start)
 	mov	%ax, %es
 	mov	%ax, %ss
 
+	/*
+	 * Make sure only one CPU fiddles with the realmode stack
+	 */
+.Llock_rm:
+	btl	$0, tr_lock
+	jnc	2f
+	pause
+	jmp	.Llock_rm
+2:
+	lock
+	btsl	$0, tr_lock
+	jc	.Llock_rm
+
 	# Setup stack
 	movl	$rm_stack_end, %esp
 
@@ -241,6 +254,7 @@ SYM_DATA_START(trampoline_header)
 	SYM_DATA(tr_efer,		.space 8)
 	SYM_DATA(tr_cr4,		.space 4)
 	SYM_DATA(tr_flags,		.space 4)
+	SYM_DATA(tr_lock,		.space 4)
 SYM_DATA_END(trampoline_header)
 
 #include "trampoline_common.S"
diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index 2c7396da470c..a18a21dff9bc 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -25,7 +25,7 @@
  * For the hotplug case we keep the task structs around and reuse
  * them.
  */
-static DEFINE_PER_CPU(struct task_struct *, idle_threads);
+DEFINE_PER_CPU(struct task_struct *, idle_threads);
 
 struct task_struct *idle_thread_get(unsigned int cpu)
 {
-- 
2.25.1

