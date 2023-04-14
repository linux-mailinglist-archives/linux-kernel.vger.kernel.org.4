Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED44A6E2D7A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 01:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjDNXrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 19:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjDNXqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 19:46:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A4B975E;
        Fri, 14 Apr 2023 16:45:36 -0700 (PDT)
Message-ID: <20230414232311.379210081@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681515911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=30gAYfFq7D/rpiAsDZ0VJ8Kl0fjNcwxtQrZfJqj5x1Q=;
        b=slTd10Pp/4TGmD/zlEb43Gb2WKRTlAppsSoSOu/T/E5JWpZy7hpKytp5/flV3pXvlf98mG
        aFkvnauiXOzF9rU2jFxo9JDlLYJmNHG16yPTZ65k9zIeEDhe+RYXJnZZEJKz1jMvqGBqWY
        BrJbQ+/W6kvjZFEcMJnDOmBoB+wtMm7S1uu0QlhCDKdWnqg0/vW+4HXD1l1CY7ixM7tgU3
        5PYqnW+jK7Z+hTrrlILf1oeW7ukViva1urpMPLhbmq0i0D+n8MofDLQxKVm+wNnRvv0a2W
        OS0dI9HKv3OCVLtAiJE196l54a2e8MLBX7ZcLL6pY36gkjwA0CwNz7FRv3fQXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681515911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=30gAYfFq7D/rpiAsDZ0VJ8Kl0fjNcwxtQrZfJqj5x1Q=;
        b=fpHp/7lpP4jb7NBZQJ1STRnv+01MPSKMiVut7RE9SWvxHshH6nA9x03/g2I1cMS+hCTLAP
        Z5dLyPS0dXp2guCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, David Woodhouse <dwmw@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        "Arjan van de Veen" <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>
Subject: [patch 35/37] x86/smpboot: Support parallel startup of secondary CPUs
References: <20230414225551.858160935@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 15 Apr 2023 01:45:10 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

 2. Avoid needing to use the global smpboot_control variable to pass
    each AP its CPU number.

To achieve the latter, export the cpuid_to_apicid[] array so that each
AP can find its own CPU number by searching therein based on its APIC ID.

Introduce flags in the top bits of smpboot_control which indicate methods
by which an AP should find its CPU number. For a serialized bringup, the
CPU number is explicitly passed in the low bits of smpboot_control as
before. For parallel mode there are flags directing the AP to find its APIC
ID in CPUID leaf 0x0b or 1x1f (for X2APIC mode) or CPUID leaf 0x01 where 8
bits are sufficient, then perform the cpuid_to_apicid[] lookup with that.

Aside from the fact that APs will now look up their CPU number via the
newly-exported cpuid_to_apicid[] table, there is no behavioural change
intended, since the parallel bootup has not yet been enabled.

[ tglx: Initial proof of concept patch with bitlock and APIC ID lookup ]
[ dwmw2: Rework and testing, commit message, CPUID 0x1 and CPU0 support ]
[ seanc: Fix stray override of initial_gs in common_cpu_up() ]
[ Oleksandr Natalenko: reported suspend/resume issue fixed in
  x86_acpi_suspend_lowlevel ]

Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Co-developed-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/apic.h          |    2 
 arch/x86/include/asm/realmode.h      |    3 +
 arch/x86/include/asm/smp.h           |    8 +++
 arch/x86/kernel/acpi/sleep.c         |    9 +++
 arch/x86/kernel/apic/apic.c          |    2 
 arch/x86/kernel/head_64.S            |   79 ++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/smpboot.c            |    5 --
 arch/x86/realmode/init.c             |    3 +
 arch/x86/realmode/rm/trampoline_64.S |   27 +++++++++--
 9 files changed, 125 insertions(+), 13 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -55,6 +55,8 @@ extern int local_apic_timer_c2_ok;
 extern int disable_apic;
 extern unsigned int lapic_timer_period;
 
+extern int cpuid_to_apicid[];
+
 extern enum apic_intr_mode_id apic_intr_mode;
 enum apic_intr_mode_id {
 	APIC_PIC,
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -52,6 +52,7 @@ struct trampoline_header {
 	u64 efer;
 	u32 cr4;
 	u32 flags;
+	u32 lock;
 #endif
 };
 
@@ -64,6 +65,8 @@ extern unsigned long initial_stack;
 extern unsigned long initial_vc_handler;
 #endif
 
+extern u32 *trampoline_lock;
+
 extern unsigned char real_mode_blob[];
 extern unsigned char real_mode_relocs[];
 
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -198,4 +198,12 @@ extern unsigned int smpboot_control;
 
 #endif /* !__ASSEMBLY__ */
 
+/* Control bits for startup_64 */
+#define STARTUP_APICID_CPUID_1F 0x80000000
+#define STARTUP_APICID_CPUID_0B 0x40000000
+#define STARTUP_APICID_CPUID_01 0x20000000
+
+/* Top 8 bits are reserved for control */
+#define STARTUP_PARALLEL_MASK	0xFF000000
+
 #endif /* _ASM_X86_SMP_H */
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -16,6 +16,7 @@
 #include <asm/cacheflush.h>
 #include <asm/realmode.h>
 #include <asm/hypervisor.h>
+#include <asm/smp.h>
 
 #include <linux/ftrace.h>
 #include "../../realmode/rm/wakeup.h"
@@ -127,7 +128,13 @@ int x86_acpi_suspend_lowlevel(void)
 	 * value is in the actual %rsp register.
 	 */
 	current->thread.sp = (unsigned long)temp_stack + sizeof(temp_stack);
-	smpboot_control = smp_processor_id();
+	/*
+	 * Ensure the CPU knows which one it is when it comes back, if
+	 * it isn't in parallel mode and expected to work that out for
+	 * itself.
+	 */
+	if (!(smpboot_control & STARTUP_PARALLEL_MASK))
+		smpboot_control = smp_processor_id();
 #endif
 	initial_code = (unsigned long)wakeup_long64;
 	saved_magic = 0x123456789abcdef0L;
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
 
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -25,6 +25,7 @@
 #include <asm/export.h>
 #include <asm/nospec-branch.h>
 #include <asm/fixmap.h>
+#include <asm/smp.h>
 
 /*
  * We are not able to switch in one step to the final KERNEL ADDRESS SPACE
@@ -234,8 +235,70 @@ SYM_INNER_LABEL(secondary_startup_64_no_
 	ANNOTATE_NOENDBR // above
 
 #ifdef CONFIG_SMP
+	/*
+	 * For parallel boot, the APIC ID is retrieved from CPUID, and then
+	 * used to look up the CPU number.  For booting a single CPU, the
+	 * CPU number is encoded in smpboot_control.
+	 *
+	 * Bit 31	STARTUP_APICID_CPUID_1F flag (use CPUID 0x1f)
+	 * Bit 30	STARTUP_APICID_CPUID_0B flag (use CPUID 0x0b)
+	 * Bit 29	STARTUP_APICID_CPUID_01 flag (use CPUID 0x01)
+	 * Bit 0-23	CPU# if STARTUP_APICID_CPUID_xx flags are not set
+	 */
 	movl	smpboot_control(%rip), %ecx
+	testl	$STARTUP_APICID_CPUID_1F, %ecx
+	jnz	.Luse_cpuid_1f
+	testl	$STARTUP_APICID_CPUID_0B, %ecx
+	jnz	.Luse_cpuid_0b
+	testl	$STARTUP_APICID_CPUID_01, %ecx
+	jnz	.Luse_cpuid_01
+	andl	$(~STARTUP_PARALLEL_MASK), %ecx
+	jmp	.Lsetup_cpu
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
+	jmp	.Lsetup_AP
+
+.Luse_cpuid_1f:
+	mov	$0x1f, %eax
+	xorl	%ecx, %ecx
+	cpuid
 
+.Lsetup_AP:
+	/* EDX contains the APIC ID of the current CPU */
+	xorq	%rcx, %rcx
+	leaq	cpuid_to_apicid(%rip), %rbx
+
+.Lfind_cpunr:
+	cmpl	(%rbx,%rcx,4), %edx
+	jz	.Lsetup_cpu
+	inc	%ecx
+#ifdef CONFIG_FORCE_NR_CPUS
+	cmpl	$NR_CPUS, %ecx
+#else
+	cmpl	nr_cpu_ids(%rip), %ecx
+#endif
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
+.Lsetup_cpu:
 	/* Get the per cpu offset for the given CPU# which is in ECX */
 	movq	__per_cpu_offset(,%rcx,8), %rdx
 #else
@@ -248,10 +311,20 @@ SYM_INNER_LABEL(secondary_startup_64_no_
 	 *
 	 * RDX contains the per-cpu offset
 	 */
-	movq	pcpu_hot + X86_current_task(%rdx), %rax
-	movq	TASK_threadsp(%rax), %rsp
+	movq	pcpu_hot + X86_top_of_stack(%rdx), %rsp
 
 	/*
+	 * Now that this CPU is running on its own stack, drop the realmode
+	 * protection. For the boot CPU the pointer is NULL!
+	 */
+	movq	trampoline_lock(%rip), %rax
+	testq	%rax, %rax
+	jz	.Lsetup_gdt
+	lock
+	btrl	$0, (%rax)
+
+.Lsetup_gdt:
+	/*
 	 * We must switch to a new descriptor in kernel space for the GDT
 	 * because soon the kernel won't have access anymore to the userspace
 	 * addresses where we're currently running on. We have to do that here
@@ -435,6 +508,8 @@ SYM_DATA(initial_code,	.quad x86_64_star
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 SYM_DATA(initial_vc_handler,	.quad handle_vc_boot_ghcb)
 #endif
+
+SYM_DATA(trampoline_lock, .quad 0);
 	__FINITDATA
 
 	__INIT
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -985,10 +985,7 @@ int common_cpu_up(unsigned int cpu, stru
 	if (ret)
 		return ret;
 
-#ifdef CONFIG_X86_32
-	/* Stack for startup_32 can be just as for start_secondary onwards */
 	per_cpu(pcpu_hot.top_of_stack, cpu) = task_top_of_stack(idle);
-#endif
 	return 0;
 }
 
@@ -1014,7 +1011,7 @@ static int do_boot_cpu(int apicid, int c
 	if (IS_ENABLED(CONFIG_X86_32)) {
 		early_gdt_descr.address = (unsigned long)get_cpu_gdt_rw(cpu);
 		initial_stack  = idle->thread.sp;
-	} else {
+	} else if (!(smpboot_control & STARTUP_PARALLEL_MASK)) {
 		smpboot_control = cpu;
 	}
 
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -154,6 +154,9 @@ static void __init setup_real_mode(void)
 
 	trampoline_header->flags = 0;
 
+	trampoline_lock = &trampoline_header->lock;
+	*trampoline_lock = 0;
+
 	trampoline_pgd = (u64 *) __va(real_mode_header->trampoline_pgd);
 
 	/* Map the real mode stub as virtual == physical */
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -37,6 +37,24 @@
 	.text
 	.code16
 
+.macro LOAD_REALMODE_ESP
+	/*
+	 * Make sure only one CPU fiddles with the realmode stack
+	 */
+.Llock_rm\@:
+	btl	$0, tr_lock
+	jnc	2f
+	pause
+	jmp	.Llock_rm\@
+2:
+	lock
+	btsl	$0, tr_lock
+	jc	.Llock_rm\@
+
+	# Setup stack
+	movl	$rm_stack_end, %esp
+.endm
+
 	.balign	PAGE_SIZE
 SYM_CODE_START(trampoline_start)
 	cli			# We should be safe anyway
@@ -49,8 +67,7 @@ SYM_CODE_START(trampoline_start)
 	mov	%ax, %es
 	mov	%ax, %ss
 
-	# Setup stack
-	movl	$rm_stack_end, %esp
+	LOAD_REALMODE_ESP
 
 	call	verify_cpu		# Verify the cpu supports long mode
 	testl   %eax, %eax		# Check for return code
@@ -93,8 +110,7 @@ SYM_CODE_START(sev_es_trampoline_start)
 	mov	%ax, %es
 	mov	%ax, %ss
 
-	# Setup stack
-	movl	$rm_stack_end, %esp
+	LOAD_REALMODE_ESP
 
 	jmp	.Lswitch_to_protected
 SYM_CODE_END(sev_es_trampoline_start)
@@ -177,7 +193,7 @@ SYM_CODE_START(pa_trampoline_compat)
 	 * In compatibility mode.  Prep ESP and DX for startup_32, then disable
 	 * paging and complete the switch to legacy 32-bit mode.
 	 */
-	movl	$rm_stack_end, %esp
+	LOAD_REALMODE_ESP
 	movw	$__KERNEL_DS, %dx
 
 	movl	$(CR0_STATE & ~X86_CR0_PG), %eax
@@ -241,6 +257,7 @@ SYM_DATA_START(trampoline_header)
 	SYM_DATA(tr_efer,		.space 8)
 	SYM_DATA(tr_cr4,		.space 4)
 	SYM_DATA(tr_flags,		.space 4)
+	SYM_DATA(tr_lock,		.space 4)
 SYM_DATA_END(trampoline_header)
 
 #include "trampoline_common.S"

