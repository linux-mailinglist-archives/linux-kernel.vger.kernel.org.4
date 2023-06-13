Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D950272F01D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240573AbjFMXjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239940AbjFMXj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:39:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7027D172A;
        Tue, 13 Jun 2023 16:39:26 -0700 (PDT)
Message-ID: <20230613224545.019583869@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686699565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=83St4CX9k4r3etM5D/zDLxt583bBYUX8Z2E5c0B+/8o=;
        b=3viID6EMmGtwT6pty1299Bp4e/YEbbLDSFkQ5FM1xHbDTnnYM2EPjzfoyNvqU9xZQ6si67
        zDu0E0pfkffv/xVUzayaJiuDWIl2tDbw5bZGTSDfO1w7xkGrr3eAqt4VzVvDNTbMD0+8lQ
        8P0dqipiyPmmZCa+o48JUXdjTAm9xStwOwtUlihlYgBoCO0LUad9gn10J3MiZ7i3ihy24A
        5wMJHC5qOSflVMpxvb55/jOd+ZMT3GkmwRxwnBKQWRxPadaRQAuIBxw435ZWWQcdR1tKC+
        /GW9p44n6J4jU+jta5DEZ7WUcaW8gIjdndf0ueYD7h+qQRtu75mG1qkMpVVVkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686699565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=83St4CX9k4r3etM5D/zDLxt583bBYUX8Z2E5c0B+/8o=;
        b=bbIrH1nI96We/t4rw8JUO249OZXCtRabtAP3RSB1RR6S/JhBpaowhlD8A1iE7l22P9oR7a
        OMsatE9/YbtL6RCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org,
        Richard Henderson <richard.henderson@linaro.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [patch 02/17] x86/cpu: Switch to arch_cpu_finalize_init()
References: <20230613223827.532680283@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 14 Jun 2023 01:39:24 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_bugs() is a dump ground for finalizing the CPU bringup. Only parts of
it has to do with actual CPU bugs.

Split it apart into arch_cpu_finalize_init() and cpu_select_mitigations().

Fixup the bogus 32bit comments while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/Kconfig             |    1 
 arch/x86/include/asm/bugs.h  |    2 -
 arch/x86/kernel/cpu/bugs.c   |   51 -----------------------------------------
 arch/x86/kernel/cpu/common.c |   53 +++++++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/cpu.h    |    1 
 5 files changed, 56 insertions(+), 52 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -71,6 +71,7 @@ config X86
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
+	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE	if !X86_PAE
--- a/arch/x86/include/asm/bugs.h
+++ b/arch/x86/include/asm/bugs.h
@@ -4,8 +4,6 @@
 
 #include <asm/processor.h>
 
-extern void check_bugs(void);
-
 #if defined(CONFIG_CPU_SUP_INTEL) && defined(CONFIG_X86_32)
 int ppro_with_ram_bug(void);
 #else
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -9,7 +9,6 @@
  *	- Andrew D. Balsa (code cleanup).
  */
 #include <linux/init.h>
-#include <linux/utsname.h>
 #include <linux/cpu.h>
 #include <linux/module.h>
 #include <linux/nospec.h>
@@ -27,8 +26,6 @@
 #include <asm/msr.h>
 #include <asm/vmx.h>
 #include <asm/paravirt.h>
-#include <asm/alternative.h>
-#include <asm/set_memory.h>
 #include <asm/intel-family.h>
 #include <asm/e820/api.h>
 #include <asm/hypervisor.h>
@@ -125,21 +122,8 @@ DEFINE_STATIC_KEY_FALSE(switch_mm_cond_l
 DEFINE_STATIC_KEY_FALSE(mmio_stale_data_clear);
 EXPORT_SYMBOL_GPL(mmio_stale_data_clear);
 
-void __init check_bugs(void)
+void __init cpu_select_mitigations(void)
 {
-	identify_boot_cpu();
-
-	/*
-	 * identify_boot_cpu() initialized SMT support information, let the
-	 * core code know.
-	 */
-	cpu_smt_check_topology();
-
-	if (!IS_ENABLED(CONFIG_SMP)) {
-		pr_info("CPU: ");
-		print_cpu_info(&boot_cpu_data);
-	}
-
 	/*
 	 * Read the SPEC_CTRL MSR to account for reserved bits which may
 	 * have unknown values. AMD64_LS_CFG MSR is cached in the early AMD
@@ -176,39 +160,6 @@ void __init check_bugs(void)
 	md_clear_select_mitigation();
 	srbds_select_mitigation();
 	l1d_flush_select_mitigation();
-
-	arch_smt_update();
-
-#ifdef CONFIG_X86_32
-	/*
-	 * Check whether we are able to run this kernel safely on SMP.
-	 *
-	 * - i386 is no longer supported.
-	 * - In order to run on anything without a TSC, we need to be
-	 *   compiled for a i486.
-	 */
-	if (boot_cpu_data.x86 < 4)
-		panic("Kernel requires i486+ for 'invlpg' and other features");
-
-	init_utsname()->machine[1] =
-		'0' + (boot_cpu_data.x86 > 6 ? 6 : boot_cpu_data.x86);
-	alternative_instructions();
-
-	fpu__init_check_bugs();
-#else /* CONFIG_X86_64 */
-	alternative_instructions();
-
-	/*
-	 * Make sure the first 2MB area is not mapped by huge pages
-	 * There are typically fixed size MTRRs in there and overlapping
-	 * MTRRs into large pages causes slow downs.
-	 *
-	 * Right now we don't do that with gbpages because there seems
-	 * very little benefit for that case.
-	 */
-	if (!direct_gbpages)
-		set_memory_4k((unsigned long)__va(0), 1);
-#endif
 }
 
 /*
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -19,11 +19,14 @@
 #include <linux/kprobes.h>
 #include <linux/kgdb.h>
 #include <linux/smp.h>
+#include <linux/cpu.h>
 #include <linux/io.h>
 #include <linux/syscore_ops.h>
 #include <linux/pgtable.h>
 #include <linux/stackprotector.h>
+#include <linux/utsname.h>
 
+#include <asm/alternative.h>
 #include <asm/cmdline.h>
 #include <asm/perf_event.h>
 #include <asm/mmu_context.h>
@@ -59,6 +62,7 @@
 #include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
 #include <asm/uv/uv.h>
+#include <asm/set_memory.h>
 #include <asm/sigframe.h>
 #include <asm/traps.h>
 #include <asm/sev.h>
@@ -2362,3 +2366,52 @@ void arch_smt_update(void)
 	/* Check whether IPI broadcasting can be enabled */
 	apic_smt_update();
 }
+
+void __init arch_cpu_finalize_init(void)
+{
+	identify_boot_cpu();
+
+	/*
+	 * identify_boot_cpu() initialized SMT support information, let the
+	 * core code know.
+	 */
+	cpu_smt_check_topology();
+
+	if (!IS_ENABLED(CONFIG_SMP)) {
+		pr_info("CPU: ");
+		print_cpu_info(&boot_cpu_data);
+	}
+
+	arch_smt_update();
+
+	cpu_select_mitigations();
+
+	if (IS_ENABLED(CONFIG_X86_32)) {
+		/*
+		 * Check whether this is a real i386 which is not longer
+		 * supported and fixup the utsname.
+		 */
+		if (boot_cpu_data.x86 < 4)
+			panic("Kernel requires i486+ for 'invlpg' and other features");
+
+		init_utsname()->machine[1] =
+			'0' + (boot_cpu_data.x86 > 6 ? 6 : boot_cpu_data.x86);
+	}
+
+	alternative_instructions();
+
+	if (IS_ENABLED(CONFIG_X86_64)) {
+		/*
+		 * Make sure the first 2MB area is not mapped by huge pages
+		 * There are typically fixed size MTRRs in there and overlapping
+		 * MTRRs into large pages causes slow downs.
+		 *
+		 * Right now we don't do that with gbpages because there seems
+		 * very little benefit for that case.
+		 */
+		if (!direct_gbpages)
+			set_memory_4k((unsigned long)__va(0), 1);
+	} else {
+		fpu__init_check_bugs();
+	}
+}
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -79,6 +79,7 @@ extern void detect_ht(struct cpuinfo_x86
 extern void check_null_seg_clears_base(struct cpuinfo_x86 *c);
 
 unsigned int aperfmperf_get_khz(int cpu);
+void cpu_select_mitigations(void);
 
 extern void x86_spec_ctrl_setup_ap(void);
 extern void update_srbds_msr(void);

