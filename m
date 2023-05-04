Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0846F725B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjEDTC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjEDTCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:02:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC32C83E8;
        Thu,  4 May 2023 12:02:08 -0700 (PDT)
Message-ID: <20230504185936.590281709@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683226927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=IjEqVwuDXy6l11CZOhb2Q9Y7uBHaszP86r8c69YcU4c=;
        b=1TjCsPNIyVe0J97AnMZ9IZuq5klCTmb8uOqmiS6QP7ZxFmpOciabd4+mZXTpZt5PKaBC3+
        tShhthEpUYU1PR0O6G3TAKNFHt5nf1NpPdvBpi/KOT/ebUi2EI8FLEgU6k80VCWhJI6XJu
        rdlacFVoZAD33FbY1MiLPzbfOdt5caRuE6+hd9z2DCXlPIQ+LrOM0u1VlHpb9igmtMFSjX
        biJHT/ieDdtdnU2SskStM2vMbaj83W3ZNAkvtv4DHH1Q8FTO6wyJZvCKM2vsuaZPc/wXqB
        4zIAc45oyX3TzFS3xg5Y4mqLrWDKm1CH9YSWlqdnpwKJWQa8TDMH4rl3Gug5TQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683226927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=IjEqVwuDXy6l11CZOhb2Q9Y7uBHaszP86r8c69YcU4c=;
        b=9diOKqSJbLdnSrqHxlovDTLpCZmCgBMmL7vKik0+pcztGx/FVE2OzspIn02s8YsczZddy6
        W6MOr2qwUqkfM0DA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
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
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: [patch V2 05/38] x86/topology: Remove CPU0 hotplug option
References: <20230504185733.126511787@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu,  4 May 2023 21:02:06 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

This was introduced together with commit e1c467e69040 ("x86, hotplug: Wake
up CPU0 via NMI instead of INIT, SIPI, SIPI") to eventually support
physical hotplug of CPU0:

 "We'll change this code in the future to wake up hard offlined CPU0 if
  real platform and request are available."

11 years later this has not happened and physical hotplug is not officially
supported. Remove the cruft.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 Documentation/admin-guide/kernel-parameters.txt |   14 ---
 Documentation/core-api/cpu_hotplug.rst          |   13 ---
 arch/x86/Kconfig                                |   43 ----------
 arch/x86/include/asm/cpu.h                      |    3 
 arch/x86/kernel/topology.c                      |   98 ------------------------
 arch/x86/power/cpu.c                            |   37 ---------
 6 files changed, 6 insertions(+), 202 deletions(-)
---
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -818,20 +818,6 @@
 			Format:
 			<first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
 
-	cpu0_hotplug	[X86] Turn on CPU0 hotplug feature when
-			CONFIG_BOOTPARAM_HOTPLUG_CPU0 is off.
-			Some features depend on CPU0. Known dependencies are:
-			1. Resume from suspend/hibernate depends on CPU0.
-			Suspend/hibernate will fail if CPU0 is offline and you
-			need to online CPU0 before suspend/hibernate.
-			2. PIC interrupts also depend on CPU0. CPU0 can't be
-			removed if a PIC interrupt is detected.
-			It's said poweroff/reboot may depend on CPU0 on some
-			machines although I haven't seen such issues so far
-			after CPU0 is offline on a few tested machines.
-			If the dependencies are under your control, you can
-			turn on cpu0_hotplug.
-
 	cpuidle.off=1	[CPU_IDLE]
 			disable the cpuidle sub-system
 
--- a/Documentation/core-api/cpu_hotplug.rst
+++ b/Documentation/core-api/cpu_hotplug.rst
@@ -127,17 +127,8 @@ Once the CPU is shutdown, it will be rem
  $ echo 1 > /sys/devices/system/cpu/cpu4/online
  smpboot: Booting Node 0 Processor 4 APIC 0x1
 
-The CPU is usable again. This should work on all CPUs. CPU0 is often special
-and excluded from CPU hotplug. On X86 the kernel option
-*CONFIG_BOOTPARAM_HOTPLUG_CPU0* has to be enabled in order to be able to
-shutdown CPU0. Alternatively the kernel command option *cpu0_hotplug* can be
-used. Some known dependencies of CPU0:
-
-* Resume from hibernate/suspend. Hibernate/suspend will fail if CPU0 is offline.
-* PIC interrupts. CPU0 can't be removed if a PIC interrupt is detected.
-
-Please let Fenghua Yu <fenghua.yu@intel.com> know if you find any dependencies
-on CPU0.
+The CPU is usable again. This should work on all CPUs, but CPU0 is often special
+and excluded from CPU hotplug.
 
 The CPU hotplug coordination
 ============================
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2305,49 +2305,6 @@ config HOTPLUG_CPU
 	def_bool y
 	depends on SMP
 
-config BOOTPARAM_HOTPLUG_CPU0
-	bool "Set default setting of cpu0_hotpluggable"
-	depends on HOTPLUG_CPU
-	help
-	  Set whether default state of cpu0_hotpluggable is on or off.
-
-	  Say Y here to enable CPU0 hotplug by default. If this switch
-	  is turned on, there is no need to give cpu0_hotplug kernel
-	  parameter and the CPU0 hotplug feature is enabled by default.
-
-	  Please note: there are two known CPU0 dependencies if you want
-	  to enable the CPU0 hotplug feature either by this switch or by
-	  cpu0_hotplug kernel parameter.
-
-	  First, resume from hibernate or suspend always starts from CPU0.
-	  So hibernate and suspend are prevented if CPU0 is offline.
-
-	  Second dependency is PIC interrupts always go to CPU0. CPU0 can not
-	  offline if any interrupt can not migrate out of CPU0. There may
-	  be other CPU0 dependencies.
-
-	  Please make sure the dependencies are under your control before
-	  you enable this feature.
-
-	  Say N if you don't want to enable CPU0 hotplug feature by default.
-	  You still can enable the CPU0 hotplug feature at boot by kernel
-	  parameter cpu0_hotplug.
-
-config DEBUG_HOTPLUG_CPU0
-	def_bool n
-	prompt "Debug CPU0 hotplug"
-	depends on HOTPLUG_CPU
-	help
-	  Enabling this option offlines CPU0 (if CPU0 can be offlined) as
-	  soon as possible and boots up userspace with CPU0 offlined. User
-	  can online CPU0 back after boot time.
-
-	  To debug CPU0 hotplug, you need to enable CPU0 offline/online
-	  feature by either turning on CONFIG_BOOTPARAM_HOTPLUG_CPU0 during
-	  compilation or giving cpu0_hotplug kernel parameter at boot.
-
-	  If unsure, say N.
-
 config COMPAT_VDSO
 	def_bool n
 	prompt "Disable the 32-bit vDSO (needed for glibc 2.3.3)"
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -31,9 +31,6 @@ struct x86_cpu {
 extern int arch_register_cpu(int num);
 extern void arch_unregister_cpu(int);
 extern void soft_restart_cpu(void);
-#ifdef CONFIG_DEBUG_HOTPLUG_CPU0
-extern int _debug_hotplug_cpu(int cpu, int action);
-#endif
 #endif
 
 extern void ap_init_aperfmperf(void);
--- a/arch/x86/kernel/topology.c
+++ b/arch/x86/kernel/topology.c
@@ -38,102 +38,12 @@
 static DEFINE_PER_CPU(struct x86_cpu, cpu_devices);
 
 #ifdef CONFIG_HOTPLUG_CPU
-
-#ifdef CONFIG_BOOTPARAM_HOTPLUG_CPU0
-static int cpu0_hotpluggable = 1;
-#else
-static int cpu0_hotpluggable;
-static int __init enable_cpu0_hotplug(char *str)
-{
-	cpu0_hotpluggable = 1;
-	return 1;
-}
-
-__setup("cpu0_hotplug", enable_cpu0_hotplug);
-#endif
-
-#ifdef CONFIG_DEBUG_HOTPLUG_CPU0
-/*
- * This function offlines a CPU as early as possible and allows userspace to
- * boot up without the CPU. The CPU can be onlined back by user after boot.
- *
- * This is only called for debugging CPU offline/online feature.
- */
-int _debug_hotplug_cpu(int cpu, int action)
-{
-	int ret;
-
-	if (!cpu_is_hotpluggable(cpu))
-		return -EINVAL;
-
-	switch (action) {
-	case 0:
-		ret = remove_cpu(cpu);
-		if (!ret)
-			pr_info("DEBUG_HOTPLUG_CPU0: CPU %u is now offline\n", cpu);
-		else
-			pr_debug("Can't offline CPU%d.\n", cpu);
-		break;
-	case 1:
-		ret = add_cpu(cpu);
-		if (ret)
-			pr_debug("Can't online CPU%d.\n", cpu);
-
-		break;
-	default:
-		ret = -EINVAL;
-	}
-
-	return ret;
-}
-
-static int __init debug_hotplug_cpu(void)
+int arch_register_cpu(int cpu)
 {
-	_debug_hotplug_cpu(0, 0);
-	return 0;
-}
-
-late_initcall_sync(debug_hotplug_cpu);
-#endif /* CONFIG_DEBUG_HOTPLUG_CPU0 */
-
-int arch_register_cpu(int num)
-{
-	struct cpuinfo_x86 *c = &cpu_data(num);
-
-	/*
-	 * Currently CPU0 is only hotpluggable on Intel platforms. Other
-	 * vendors can add hotplug support later.
-	 * Xen PV guests don't support CPU0 hotplug at all.
-	 */
-	if (c->x86_vendor != X86_VENDOR_INTEL ||
-	    cpu_feature_enabled(X86_FEATURE_XENPV))
-		cpu0_hotpluggable = 0;
-
-	/*
-	 * Two known BSP/CPU0 dependencies: Resume from suspend/hibernate
-	 * depends on BSP. PIC interrupts depend on BSP.
-	 *
-	 * If the BSP dependencies are under control, one can tell kernel to
-	 * enable BSP hotplug. This basically adds a control file and
-	 * one can attempt to offline BSP.
-	 */
-	if (num == 0 && cpu0_hotpluggable) {
-		unsigned int irq;
-		/*
-		 * We won't take down the boot processor on i386 if some
-		 * interrupts only are able to be serviced by the BSP in PIC.
-		 */
-		for_each_active_irq(irq) {
-			if (!IO_APIC_IRQ(irq) && irq_has_action(irq)) {
-				cpu0_hotpluggable = 0;
-				break;
-			}
-		}
-	}
-	if (num || cpu0_hotpluggable)
-		per_cpu(cpu_devices, num).cpu.hotpluggable = 1;
+	struct x86_cpu *xc = per_cpu_ptr(&cpu_devices, cpu);
 
-	return register_cpu(&per_cpu(cpu_devices, num).cpu, num);
+	xc->cpu.hotpluggable = cpu > 0;
+	return register_cpu(&xc->cpu, cpu);
 }
 EXPORT_SYMBOL(arch_register_cpu);
 
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -351,43 +351,6 @@ static int bsp_pm_callback(struct notifi
 	case PM_HIBERNATION_PREPARE:
 		ret = bsp_check();
 		break;
-#ifdef CONFIG_DEBUG_HOTPLUG_CPU0
-	case PM_RESTORE_PREPARE:
-		/*
-		 * When system resumes from hibernation, online CPU0 because
-		 * 1. it's required for resume and
-		 * 2. the CPU was online before hibernation
-		 */
-		if (!cpu_online(0))
-			_debug_hotplug_cpu(0, 1);
-		break;
-	case PM_POST_RESTORE:
-		/*
-		 * When a resume really happens, this code won't be called.
-		 *
-		 * This code is called only when user space hibernation software
-		 * prepares for snapshot device during boot time. So we just
-		 * call _debug_hotplug_cpu() to restore to CPU0's state prior to
-		 * preparing the snapshot device.
-		 *
-		 * This works for normal boot case in our CPU0 hotplug debug
-		 * mode, i.e. CPU0 is offline and user mode hibernation
-		 * software initializes during boot time.
-		 *
-		 * If CPU0 is online and user application accesses snapshot
-		 * device after boot time, this will offline CPU0 and user may
-		 * see different CPU0 state before and after accessing
-		 * the snapshot device. But hopefully this is not a case when
-		 * user debugging CPU0 hotplug. Even if users hit this case,
-		 * they can easily online CPU0 back.
-		 *
-		 * To simplify this debug code, we only consider normal boot
-		 * case. Otherwise we need to remember CPU0's state and restore
-		 * to that state and resolve racy conditions etc.
-		 */
-		_debug_hotplug_cpu(0, 0);
-		break;
-#endif
 	default:
 		break;
 	}

