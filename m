Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3013873DE9B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjFZMOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjFZMN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:13:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA029E60
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:13:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687781630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=JyxsuPSSC6pJrkwpit78ZzSOEQCMqa+J/oqa/Gyx4OM=;
        b=nxB+TWxGgRRq5Xg0LciM94iTC6fY4u3w8auMGBHuRXl/0yr1dRIOMiN0h5XOH6rg34mjcZ
        H6qEx8yucVtFoGynlCbpSHKZLBL8tWvydZuHUOwMeyswyMbSn3Oryd3Qv0eJjV4Hc4hqeT
        2331RKkdAvTw4TaLqnx9oCSnP/l6Cop9AN4tIlLRVT1tJjXrZNqP41ALorvtgnZT2jg3Fx
        NEN6WKbDJKG4SA27PF+KabqdLiyLASkwPL1Gn05BaCaK3uzqYRnPLFDhLE8XQJEAjf1bXW
        j/1pYdm/iTEsF+7cwJrxRj4o1m3hEfhdeNUpTWVgUiq2t64lWXANaSPAZgO0SQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687781630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=JyxsuPSSC6pJrkwpit78ZzSOEQCMqa+J/oqa/Gyx4OM=;
        b=r2Pb6dnBaWRS6nWwvzESBeqr1661zYUPIPYVSUG6387arNYo6boej+cS9ICtCJj4R4TXgc
        AZMo9/PtQjPnAeBA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] smp/core for v6.5-rc1
References: <168778150975.3634408.5562070824299155127.tglx@vps.praguecc.cz>
Message-ID: <168778151245.3634408.4606396781291833683.tglx@vps.praguecc.cz>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 26 Jun 2023 14:13:50 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest smp/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2023-06=
-26

up to:  bf5a8c26ad7c: trace,smp: Add tracepoints for scheduling remotelly cal=
led functions


A large update for SMP management:

  - Parallel CPU bringup

    The reason why people are interested in parallel bringup is to shorten
    the (kexec) reboot time of cloud servers to reduce the downtime of the
    VM tenants.

    The current fully serialized bringup does the following per AP:

      1) Prepare callbacks (allocate, intialize, create threads)
      2) Kick the AP alive (e.g. INIT/SIPI on x86)
      3) Wait for the AP to report alive state
      4) Let the AP continue through the atomic bringup
      5) Let the AP run the threaded bringup to full online state

    There are two significant delays:

      #3 The time for an AP to report alive state in start_secondary() on
         x86 has been measured in the range between 350us and 3.5ms
         depending on vendor and CPU type, BIOS microcode size etc.

      #4 The atomic bringup does the microcode update. This has been
         measured to take up to ~8ms on the primary threads depending on
         the microcode patch size to apply.

    On a two socket SKL server with 56 cores (112 threads) the boot CPU
    spends on current mainline about 800ms busy waiting for the APs to come
    up and apply microcode. That's more than 80% of the actual onlining
    procedure.

    This can be reduced significantly by splitting the bringup mechanism
    into two parts:

      1) Run the prepare callbacks and kick the AP alive for each AP which
      	 needs to be brought up.

	 The APs wake up, do their firmware initialization and run the low
      	 level kernel startup code including microcode loading in parallel
      	 up to the first synchronization point. (#1 and #2 above)

      2) Run the rest of the bringup code strictly serialized per CPU
      	 (#3 - #5 above) as it's done today.

	 Parallelizing that stage of the CPU bringup might be possible in
	 theory, but it's questionable whether required surgery would be
	 justified for a pretty small gain.

    If the system is large enough the first AP is already waiting at the
    first synchronization point when the boot CPU finished the wake-up of
    the last AP. That reduces the AP bringup time on that SKL from ~800ms
    to ~80ms, i.e. by a factor ~10x.

    The actual gain varies wildly depending on the system, CPU, microcode
    patch size and other factors. There are some opportunities to reduce
    the overhead further, but that needs some deep surgery in the x86 CPU
    bringup code.

    For now this is only enabled on x86, but the core functionality
    obviously works for all SMP capable architectures.


  - Enhancements for SMP function call tracing so it is possible to locate
    the scheduling and the actual execution points. That allows to measure
    IPI delivery time precisely.

Thanks,

	tglx

------------------>
Andrew Cooper (1):
      x86/apic: Fix use of X{,2}APIC_ENABLE in asm with older binutils

David Woodhouse (3):
      x86/smpboot: Split up native_cpu_up() into separate phases and document=
 them
      cpu/hotplug: Reset task stack state in _cpu_up()
      x86/smpboot: Support parallel startup of secondary CPUs

Leonardo Bras (2):
      trace,smp: Add tracepoints around remotelly called functions
      trace,smp: Add tracepoints for scheduling remotelly called functions

Thomas Gleixner (39):
      x86/smpboot: Cleanup topology_phys_to_logical_pkg()/die()
      cpu/hotplug: Mark arch_disable_smp_support() and bringup_nonboot_cpus()=
 __init
      x86/smpboot: Avoid pointless delay calibration if TSC is synchronized
      x86/smpboot: Rename start_cpu0() to soft_restart_cpu()
      x86/topology: Remove CPU0 hotplug option
      x86/smpboot: Remove the CPU0 hotplug kludge
      x86/smpboot: Restrict soft_restart_cpu() to SEV
      x86/smpboot: Remove unnecessary barrier()
      x86/smpboot: Get rid of cpu_init_secondary()
      x86/cpu/cacheinfo: Remove cpu_callout_mask dependency
      x86/smpboot: Move synchronization masks to SMP boot code
      x86/smpboot: Make TSC synchronization function call based
      x86/smpboot: Remove cpu_callin_mask
      cpu/hotplug: Rework sparse_irq locking in bringup_cpu()
      x86/smpboot: Remove wait for cpu_online()
      x86/xen/smp_pv: Remove wait for CPU online
      x86/xen/hvm: Get rid of DEAD_FROZEN handling
      cpu/hotplug: Add CPU state tracking and synchronization
      x86/smpboot: Switch to hotplug core state synchronization
      cpu/hotplug: Remove cpu_report_state() and related unused cruft
      ARM: smp: Switch to hotplug core state synchronization
      arm64: smp: Switch to hotplug core state synchronization
      csky/smp: Switch to hotplug core state synchronization
      MIPS: SMP_CPS: Switch to hotplug core state synchronization
      parisc: Switch to hotplug core state synchronization
      riscv: Switch to hotplug core state synchronization
      cpu/hotplug: Remove unused state functions
      cpu/hotplug: Provide a split up CPUHP_BRINGUP mechanism
      x86/smpboot: Enable split CPU startup
      x86/apic: Provide cpu_primary_thread mask
      cpu/hotplug: Allow "parallel" bringup up to CPUHP_BP_KICK_AP_STATE
      x86/apic: Save the APIC virtual base address
      x86/smpboot: Implement a bit spinlock to protect the realmode stack
      x86/smpboot/64: Implement arch_cpuhp_init_parallel_bringup() and enable=
 it
      cpu/hotplug: Fix off by one in cpuhp_bringup_mask()
      x86/smp: Initialize cpu_primary_thread_mask late
      x86/realmode: Make stack lock work in trampoline_compat()
      x86/smpboot: Fix the parallel bringup decision
      MAINTAINERS: Add CPU HOTPLUG entry


 Documentation/admin-guide/kernel-parameters.txt |  20 +-
 Documentation/core-api/cpu_hotplug.rst          |  13 +-
 MAINTAINERS                                     |  12 +
 arch/Kconfig                                    |  23 ++
 arch/arm/Kconfig                                |   1 +
 arch/arm/include/asm/smp.h                      |   2 +-
 arch/arm/kernel/smp.c                           |  18 +-
 arch/arm64/Kconfig                              |   1 +
 arch/arm64/include/asm/smp.h                    |   2 +-
 arch/arm64/kernel/smp.c                         |  14 +-
 arch/csky/Kconfig                               |   1 +
 arch/csky/include/asm/smp.h                     |   2 +-
 arch/csky/kernel/smp.c                          |   8 +-
 arch/mips/Kconfig                               |   1 +
 arch/mips/cavium-octeon/smp.c                   |   1 +
 arch/mips/include/asm/smp-ops.h                 |   1 +
 arch/mips/kernel/smp-bmips.c                    |   1 +
 arch/mips/kernel/smp-cps.c                      |  14 +-
 arch/mips/kernel/smp.c                          |   8 +
 arch/mips/loongson64/smp.c                      |   1 +
 arch/parisc/Kconfig                             |   1 +
 arch/parisc/kernel/process.c                    |   4 +-
 arch/parisc/kernel/smp.c                        |   7 +-
 arch/riscv/Kconfig                              |   1 +
 arch/riscv/include/asm/smp.h                    |   2 +-
 arch/riscv/kernel/cpu-hotplug.c                 |  14 +-
 arch/x86/Kconfig                                |  45 +-
 arch/x86/coco/tdx/tdx.c                         |  11 +
 arch/x86/include/asm/apic.h                     |   5 +-
 arch/x86/include/asm/apicdef.h                  |  11 +-
 arch/x86/include/asm/cpu.h                      |   5 +-
 arch/x86/include/asm/cpumask.h                  |   5 -
 arch/x86/include/asm/processor.h                |   1 -
 arch/x86/include/asm/realmode.h                 |   3 +
 arch/x86/include/asm/smp.h                      |  24 +-
 arch/x86/include/asm/topology.h                 |  22 +-
 arch/x86/include/asm/tsc.h                      |   2 -
 arch/x86/include/asm/x86_init.h                 |   3 +
 arch/x86/kernel/acpi/sleep.c                    |   9 +-
 arch/x86/kernel/apic/apic.c                     |  40 +-
 arch/x86/kernel/callthunks.c                    |   4 +-
 arch/x86/kernel/cpu/cacheinfo.c                 |  21 +-
 arch/x86/kernel/cpu/common.c                    |  50 +--
 arch/x86/kernel/head_32.S                       |  14 -
 arch/x86/kernel/head_64.S                       |  85 +++-
 arch/x86/kernel/sev.c                           |   2 +-
 arch/x86/kernel/smp.c                           |   3 +-
 arch/x86/kernel/smpboot.c                       | 523 ++++++++--------------=
--
 arch/x86/kernel/topology.c                      |  98 +----
 arch/x86/kernel/tsc.c                           |  20 +-
 arch/x86/kernel/tsc_sync.c                      |  36 +-
 arch/x86/kernel/x86_init.c                      |   1 +
 arch/x86/mm/mem_encrypt_amd.c                   |  15 +
 arch/x86/power/cpu.c                            |  37 --
 arch/x86/realmode/init.c                        |   3 +
 arch/x86/realmode/rm/trampoline_64.S            |  27 +-
 arch/x86/xen/enlighten_hvm.c                    |  11 +-
 arch/x86/xen/smp_hvm.c                          |  16 +-
 arch/x86/xen/smp_pv.c                           |  56 +--
 drivers/acpi/processor_idle.c                   |   4 -
 include/linux/cpu.h                             |   4 -
 include/linux/cpuhotplug.h                      |  17 +
 include/trace/events/csd.h                      |  72 ++++
 kernel/cpu.c                                    | 402 +++++++++++++++++-
 kernel/smp.c                                    |  43 +-
 kernel/smpboot.c                                | 163 --------
 66 files changed, 1076 insertions(+), 1010 deletions(-)
 create mode 100644 include/trace/events/csd.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/=
admin-guide/kernel-parameters.txt
index 9e5bab29685f..79fb1248f0ce 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -818,20 +818,6 @@
 			Format:
 			<first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
=20
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
 	cpuidle.off=3D1	[CPU_IDLE]
 			disable the cpuidle sub-system
=20
@@ -852,6 +838,12 @@
 			on every CPU online, such as boot, and resume from suspend.
 			Default: 10000
=20
+	cpuhp.parallel=3D
+			[SMP] Enable/disable parallel bringup of secondary CPUs
+			Format: <bool>
+			Default is enabled if CONFIG_HOTPLUG_PARALLEL=3Dy. Otherwise
+			the parameter has no effect.
+
 	crash_kexec_post_notifiers
 			Run kdump after running panic-notifiers and dumping
 			kmsg. This only for the users who doubt kdump always
diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/=
cpu_hotplug.rst
index f75778d37488..e6f5bc39cf5c 100644
--- a/Documentation/core-api/cpu_hotplug.rst
+++ b/Documentation/core-api/cpu_hotplug.rst
@@ -127,17 +127,8 @@ bring CPU4 back online::
  $ echo 1 > /sys/devices/system/cpu/cpu4/online
  smpboot: Booting Node 0 Processor 4 APIC 0x1
=20
-The CPU is usable again. This should work on all CPUs. CPU0 is often special
-and excluded from CPU hotplug. On X86 the kernel option
-*CONFIG_BOOTPARAM_HOTPLUG_CPU0* has to be enabled in order to be able to
-shutdown CPU0. Alternatively the kernel command option *cpu0_hotplug* can be
-used. Some known dependencies of CPU0:
-
-* Resume from hibernate/suspend. Hibernate/suspend will fail if CPU0 is offl=
ine.
-* PIC interrupts. CPU0 can't be removed if a PIC interrupt is detected.
-
-Please let Fenghua Yu <fenghua.yu@intel.com> know if you find any dependenci=
es
-on CPU0.
+The CPU is usable again. This should work on all CPUs, but CPU0 is often spe=
cial
+and excluded from CPU hotplug.
=20
 The CPU hotplug coordination
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
diff --git a/MAINTAINERS b/MAINTAINERS
index e0ad886d3163..273f9804d544 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5341,6 +5341,18 @@ F:	include/linux/sched/cpufreq.h
 F:	kernel/sched/cpufreq*.c
 F:	tools/testing/selftests/cpufreq/
=20
+CPU HOTPLUG
+M:	Thomas Gleixner <tglx@linutronix.de>
+M:	Peter Zijlstra <peterz@infradead.org>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/core
+F:	kernel/cpu.c
+F:	kernel/smpboot.*
+F:	include/linux/cpu.h
+F:	include/linux/cpuhotplug.h
+F:	include/linux/smpboot.h
+
 CPU IDLE TIME MANAGEMENT FRAMEWORK
 M:	"Rafael J. Wysocki" <rafael@kernel.org>
 M:	Daniel Lezcano <daniel.lezcano@linaro.org>
diff --git a/arch/Kconfig b/arch/Kconfig
index 205fd23e0cad..64d771855ecd 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -34,6 +34,29 @@ config ARCH_HAS_SUBPAGE_FAULTS
 config HOTPLUG_SMT
 	bool
=20
+# Selected by HOTPLUG_CORE_SYNC_DEAD or HOTPLUG_CORE_SYNC_FULL
+config HOTPLUG_CORE_SYNC
+	bool
+
+# Basic CPU dead synchronization selected by architecture
+config HOTPLUG_CORE_SYNC_DEAD
+	bool
+	select HOTPLUG_CORE_SYNC
+
+# Full CPU synchronization with alive state selected by architecture
+config HOTPLUG_CORE_SYNC_FULL
+	bool
+	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
+	select HOTPLUG_CORE_SYNC
+
+config HOTPLUG_SPLIT_STARTUP
+	bool
+	select HOTPLUG_CORE_SYNC_FULL
+
+config HOTPLUG_PARALLEL
+	bool
+	select HOTPLUG_SPLIT_STARTUP
+
 config GENERIC_ENTRY
 	bool
=20
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0fb4b218f665..775ce86507d7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -124,6 +124,7 @@ config ARM
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UID16
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN
+	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
 	select IRQ_FORCED_THREADING
 	select MODULES_USE_ELF_REL
 	select NEED_DMA_MAP_STATE
diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 7c1c90d9f582..8c05a7f374d8 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -64,7 +64,7 @@ extern void secondary_startup_arm(void);
=20
 extern int __cpu_disable(void);
=20
-extern void __cpu_die(unsigned int cpu);
+static inline void __cpu_die(unsigned int cpu) { }
=20
 extern void arch_send_call_function_single_ipi(int cpu);
 extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 87f8d0e5e314..6756203e45f3 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -288,15 +288,11 @@ int __cpu_disable(void)
 }
=20
 /*
- * called on the thread which is asking for a CPU to be shutdown -
- * waits until shutdown has completed, or it is timed out.
+ * called on the thread which is asking for a CPU to be shutdown after the
+ * shutdown completed.
  */
-void __cpu_die(unsigned int cpu)
+void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu)
 {
-	if (!cpu_wait_death(cpu, 5)) {
-		pr_err("CPU%u: cpu didn't die\n", cpu);
-		return;
-	}
 	pr_debug("CPU%u: shutdown\n", cpu);
=20
 	clear_tasks_mm_cpumask(cpu);
@@ -336,11 +332,11 @@ void __noreturn arch_cpu_idle_dead(void)
 	flush_cache_louis();
=20
 	/*
-	 * Tell __cpu_die() that this CPU is now safe to dispose of.  Once
-	 * this returns, power and/or clocks can be removed at any point
-	 * from this CPU and its cache by platform_cpu_kill().
+	 * Tell cpuhp_bp_sync_dead() that this CPU is now safe to dispose
+	 * of. Once this returns, power and/or clocks can be removed at
+	 * any point from this CPU and its cache by platform_cpu_kill().
 	 */
-	(void)cpu_report_death();
+	cpuhp_ap_report_dead();
=20
 	/*
 	 * Ensure that the cache lines associated with that completion are
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b1201d25a8a4..fcb945bde648 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -222,6 +222,7 @@ config ARM64
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
 	select HAVE_GENERIC_VDSO
+	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
 	select KASAN_VMALLOC if KASAN
diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index f2d26235bfb4..9b31e6d0da17 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -99,7 +99,7 @@ static inline void arch_send_wakeup_ipi_mask(const struct c=
pumask *mask)
=20
 extern int __cpu_disable(void);
=20
-extern void __cpu_die(unsigned int cpu);
+static inline void __cpu_die(unsigned int cpu) { }
 extern void __noreturn cpu_die(void);
 extern void __noreturn cpu_die_early(void);
=20
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index d00d4cbb31b1..edd63894d61e 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -332,17 +332,13 @@ static int op_cpu_kill(unsigned int cpu)
 }
=20
 /*
- * called on the thread which is asking for a CPU to be shutdown -
- * waits until shutdown has completed, or it is timed out.
+ * Called on the thread which is asking for a CPU to be shutdown after the
+ * shutdown completed.
  */
-void __cpu_die(unsigned int cpu)
+void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu)
 {
 	int err;
=20
-	if (!cpu_wait_death(cpu, 5)) {
-		pr_crit("CPU%u: cpu didn't die\n", cpu);
-		return;
-	}
 	pr_debug("CPU%u: shutdown\n", cpu);
=20
 	/*
@@ -369,8 +365,8 @@ void __noreturn cpu_die(void)
=20
 	local_daif_mask();
=20
-	/* Tell __cpu_die() that this CPU is now safe to dispose of */
-	(void)cpu_report_death();
+	/* Tell cpuhp_bp_sync_dead() that this CPU is now safe to dispose of */
+	cpuhp_ap_report_dead();
=20
 	/*
 	 * Actually shutdown the CPU. This must never fail. The specific hotplug
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 4df1f8c9d170..95f1e9bfd1c7 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -96,6 +96,7 @@ config CSKY
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
 	select MAY_HAVE_SPARSE_IRQ
 	select MODULES_USE_ELF_RELA if MODULES
 	select OF
diff --git a/arch/csky/include/asm/smp.h b/arch/csky/include/asm/smp.h
index 668b79ce29ea..d3db334f3196 100644
--- a/arch/csky/include/asm/smp.h
+++ b/arch/csky/include/asm/smp.h
@@ -23,7 +23,7 @@ void __init set_send_ipi(void (*func)(const struct cpumask =
*mask), int irq);
=20
 int __cpu_disable(void);
=20
-void __cpu_die(unsigned int cpu);
+static inline void __cpu_die(unsigned int cpu) { }
=20
 #endif /* CONFIG_SMP */
=20
diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index b12e2c3c387f..8e42352cbf12 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -291,12 +291,8 @@ int __cpu_disable(void)
 	return 0;
 }
=20
-void __cpu_die(unsigned int cpu)
+void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu)
 {
-	if (!cpu_wait_death(cpu, 5)) {
-		pr_crit("CPU%u: shutdown failed\n", cpu);
-		return;
-	}
 	pr_notice("CPU%u: shutdown\n", cpu);
 }
=20
@@ -304,7 +300,7 @@ void __noreturn arch_cpu_idle_dead(void)
 {
 	idle_task_exit();
=20
-	cpu_report_death();
+	cpuhp_ap_report_dead();
=20
 	while (!secondary_stack)
 		arch_cpu_idle();
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c2f5498d207f..30e90a2d53f4 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2285,6 +2285,7 @@ config MIPS_CPS
 	select MIPS_CM
 	select MIPS_CPS_PM if HOTPLUG_CPU
 	select SMP
+	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
 	select SYNC_R4K if (CEVT_R4K || CSRC_R4K)
 	select SYS_SUPPORTS_HOTPLUG_CPU
 	select SYS_SUPPORTS_SCHED_SMT if CPU_MIPSR6
diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 4212584e6efa..33c09688210f 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -345,6 +345,7 @@ void play_dead(void)
 	int cpu =3D cpu_number_map(cvmx_get_core_num());
=20
 	idle_task_exit();
+	cpuhp_ap_report_dead();
 	octeon_processor_boot =3D 0xff;
 	per_cpu(cpu_state, cpu) =3D CPU_DEAD;
=20
diff --git a/arch/mips/include/asm/smp-ops.h b/arch/mips/include/asm/smp-ops.h
index 0145bbfb5efb..5719ff49eff1 100644
--- a/arch/mips/include/asm/smp-ops.h
+++ b/arch/mips/include/asm/smp-ops.h
@@ -33,6 +33,7 @@ struct plat_smp_ops {
 #ifdef CONFIG_HOTPLUG_CPU
 	int (*cpu_disable)(void);
 	void (*cpu_die)(unsigned int cpu);
+	void (*cleanup_dead_cpu)(unsigned cpu);
 #endif
 #ifdef CONFIG_KEXEC
 	void (*kexec_nonboot_cpu)(void);
diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 15466d4cf4a0..c074ecce3fbf 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -392,6 +392,7 @@ static void bmips_cpu_die(unsigned int cpu)
 void __ref play_dead(void)
 {
 	idle_task_exit();
+	cpuhp_ap_report_dead();
=20
 	/* flush data cache */
 	_dma_cache_wback_inv(0, ~0);
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 62f677b2306f..d7fdbec232da 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -503,8 +503,7 @@ void play_dead(void)
 		}
 	}
=20
-	/* This CPU has chosen its way out */
-	(void)cpu_report_death();
+	cpuhp_ap_report_dead();
=20
 	cps_shutdown_this_cpu(cpu_death);
=20
@@ -527,7 +526,9 @@ static void wait_for_sibling_halt(void *ptr_cpu)
 	} while (!(halted & TCHALT_H));
 }
=20
-static void cps_cpu_die(unsigned int cpu)
+static void cps_cpu_die(unsigned int cpu) { }
+
+static void cps_cleanup_dead_cpu(unsigned cpu)
 {
 	unsigned core =3D cpu_core(&cpu_data[cpu]);
 	unsigned int vpe_id =3D cpu_vpe_id(&cpu_data[cpu]);
@@ -535,12 +536,6 @@ static void cps_cpu_die(unsigned int cpu)
 	unsigned stat;
 	int err;
=20
-	/* Wait for the cpu to choose its way out */
-	if (!cpu_wait_death(cpu, 5)) {
-		pr_err("CPU%u: didn't offline\n", cpu);
-		return;
-	}
-
 	/*
 	 * Now wait for the CPU to actually offline. Without doing this that
 	 * offlining may race with one or more of:
@@ -624,6 +619,7 @@ static const struct plat_smp_ops cps_smp_ops =3D {
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_disable		=3D cps_cpu_disable,
 	.cpu_die		=3D cps_cpu_die,
+	.cleanup_dead_cpu	=3D cps_cleanup_dead_cpu,
 #endif
 #ifdef CONFIG_KEXEC
 	.kexec_nonboot_cpu	=3D cps_kexec_nonboot_cpu,
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 1d93b85271ba..90c71d800b59 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -690,6 +690,14 @@ void flush_tlb_one(unsigned long vaddr)
 EXPORT_SYMBOL(flush_tlb_page);
 EXPORT_SYMBOL(flush_tlb_one);
=20
+#ifdef CONFIG_HOTPLUG_CORE_SYNC_DEAD
+void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu)
+{
+	if (mp_ops->cleanup_dead_cpu)
+		mp_ops->cleanup_dead_cpu(cpu);
+}
+#endif
+
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
=20
 static void tick_broadcast_callee(void *info)
diff --git a/arch/mips/loongson64/smp.c b/arch/mips/loongson64/smp.c
index b0e8bb9fa036..cdecd7af11a6 100644
--- a/arch/mips/loongson64/smp.c
+++ b/arch/mips/loongson64/smp.c
@@ -775,6 +775,7 @@ void play_dead(void)
 	void (*play_dead_at_ckseg1)(int *);
=20
 	idle_task_exit();
+	cpuhp_ap_report_dead();
=20
 	prid_imp =3D read_c0_prid() & PRID_IMP_MASK;
 	prid_rev =3D read_c0_prid() & PRID_REV_MASK;
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 466a25525364..67a3f98a2c5e 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -57,6 +57,7 @@ config PARISC
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_REGS_AND_STACK_ACCESS_API
+	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_IRQ_MIGRATION if SMP
 	select HAVE_UNSTABLE_SCHED_CLOCK if SMP
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index 97c6f875bd0e..66f6543417b7 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -166,8 +166,8 @@ void __noreturn arch_cpu_idle_dead(void)
=20
 	local_irq_disable();
=20
-	/* Tell __cpu_die() that this CPU is now safe to dispose of. */
-	(void)cpu_report_death();
+	/* Tell the core that this CPU is now safe to dispose of. */
+	cpuhp_ap_report_dead();
=20
 	/* Ensure that the cache lines are written out. */
 	flush_cache_all_local();
diff --git a/arch/parisc/kernel/smp.c b/arch/parisc/kernel/smp.c
index b7fc859fa87d..6b6eaa485946 100644
--- a/arch/parisc/kernel/smp.c
+++ b/arch/parisc/kernel/smp.c
@@ -500,11 +500,10 @@ int __cpu_disable(void)
 void __cpu_die(unsigned int cpu)
 {
 	pdc_cpu_rendezvous_lock();
+}
=20
-	if (!cpu_wait_death(cpu, 5)) {
-		pr_crit("CPU%u: cpu didn't die\n", cpu);
-		return;
-	}
+void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu)
+{
 	pr_info("CPU%u: is shutting down\n", cpu);
=20
 	/* set task's state to interruptible sleep */
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 348c0fa1fc8c..13f058490608 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -122,6 +122,7 @@ config RISCV
 	select HAVE_RSEQ
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
 	select KASAN_VMALLOC if KASAN
diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index c4b77017ec58..0d555847cde6 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -70,7 +70,7 @@ asmlinkage void smp_callin(void);
=20
 #if defined CONFIG_HOTPLUG_CPU
 int __cpu_disable(void);
-void __cpu_die(unsigned int cpu);
+static inline void __cpu_die(unsigned int cpu) { }
 #endif /* CONFIG_HOTPLUG_CPU */
=20
 #else
diff --git a/arch/riscv/kernel/cpu-hotplug.c b/arch/riscv/kernel/cpu-hotplug.c
index a941adc7cbf2..457a18efcb11 100644
--- a/arch/riscv/kernel/cpu-hotplug.c
+++ b/arch/riscv/kernel/cpu-hotplug.c
@@ -8,6 +8,7 @@
 #include <linux/sched.h>
 #include <linux/err.h>
 #include <linux/irq.h>
+#include <linux/cpuhotplug.h>
 #include <linux/cpu.h>
 #include <linux/sched/hotplug.h>
 #include <asm/irq.h>
@@ -49,17 +50,15 @@ int __cpu_disable(void)
 	return ret;
 }
=20
+#ifdef CONFIG_HOTPLUG_CPU
 /*
- * Called on the thread which is asking for a CPU to be shutdown.
+ * Called on the thread which is asking for a CPU to be shutdown, if the
+ * CPU reported dead to the hotplug core.
  */
-void __cpu_die(unsigned int cpu)
+void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu)
 {
 	int ret =3D 0;
=20
-	if (!cpu_wait_death(cpu, 5)) {
-		pr_err("CPU %u: didn't die\n", cpu);
-		return;
-	}
 	pr_notice("CPU%u: off\n", cpu);
=20
 	/* Verify from the firmware if the cpu is really stopped*/
@@ -76,9 +75,10 @@ void __noreturn arch_cpu_idle_dead(void)
 {
 	idle_task_exit();
=20
-	(void)cpu_report_death();
+	cpuhp_ap_report_dead();
=20
 	cpu_ops[smp_processor_id()]->cpu_stop();
 	/* It should never reach here */
 	BUG();
 }
+#endif
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 53bab123a8ee..953823fdf57b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -274,7 +274,9 @@ config X86
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
+	select HOTPLUG_PARALLEL			if SMP && X86_64
 	select HOTPLUG_SMT			if SMP
+	select HOTPLUG_SPLIT_STARTUP		if SMP && X86_32
 	select IRQ_FORCED_THREADING
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
 	select NEED_PER_CPU_PAGE_FIRST_CHUNK
@@ -2305,49 +2307,6 @@ config HOTPLUG_CPU
 	def_bool y
 	depends on SMP
=20
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
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index e146b599260f..27ce10c9ff61 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -871,5 +871,16 @@ void __init tdx_early_init(void)
 	x86_platform.guest.enc_tlb_flush_required   =3D tdx_tlb_flush_required;
 	x86_platform.guest.enc_status_change_finish =3D tdx_enc_status_changed;
=20
+	/*
+	 * TDX intercepts the RDMSR to read the X2APIC ID in the parallel
+	 * bringup low level code. That raises #VE which cannot be handled
+	 * there.
+	 *
+	 * Intel-TDX has a secure RDMSR hypercall, but that needs to be
+	 * implemented seperately in the low level startup ASM code.
+	 * Until that is in place, disable parallel bringup for TDX.
+	 */
+	x86_cpuinit.parallel_bringup =3D false;
+
 	pr_info("Guest detected\n");
 }
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 3216da7074ba..98c32aa5963a 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -55,6 +55,8 @@ extern int local_apic_timer_c2_ok;
 extern int disable_apic;
 extern unsigned int lapic_timer_period;
=20
+extern int cpuid_to_apicid[];
+
 extern enum apic_intr_mode_id apic_intr_mode;
 enum apic_intr_mode_id {
 	APIC_PIC,
@@ -377,7 +379,6 @@ extern struct apic *__apicdrivers[], *__apicdrivers_end[];
  * APIC functionality to boot other CPUs - only used on SMP:
  */
 #ifdef CONFIG_SMP
-extern int wakeup_secondary_cpu_via_nmi(int apicid, unsigned long start_eip);
 extern int lapic_can_unplug_cpu(void);
 #endif
=20
@@ -507,10 +508,8 @@ extern int default_check_phys_apicid_present(int phys_ap=
icid);
 #endif /* CONFIG_X86_LOCAL_APIC */
=20
 #ifdef CONFIG_SMP
-bool apic_id_is_primary_thread(unsigned int id);
 void apic_smt_update(void);
 #else
-static inline bool apic_id_is_primary_thread(unsigned int id) { return false=
; }
 static inline void apic_smt_update(void) { }
 #endif
=20
diff --git a/arch/x86/include/asm/apicdef.h b/arch/x86/include/asm/apicdef.h
index 68d213e83fcc..4b125e5b3187 100644
--- a/arch/x86/include/asm/apicdef.h
+++ b/arch/x86/include/asm/apicdef.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_APICDEF_H
 #define _ASM_X86_APICDEF_H
=20
+#include <linux/bits.h>
+
 /*
  * Constants for various Intel APICs. (local APIC, IOAPIC, etc.)
  *
@@ -138,9 +140,10 @@
 #define		APIC_EILVT_MASKED	(1 << 16)
=20
 #define APIC_BASE (fix_to_virt(FIX_APIC_BASE))
-#define APIC_BASE_MSR	0x800
-#define XAPIC_ENABLE	(1UL << 11)
-#define X2APIC_ENABLE	(1UL << 10)
+#define APIC_BASE_MSR		0x800
+#define APIC_X2APIC_ID_MSR	0x802
+#define XAPIC_ENABLE		BIT(11)
+#define X2APIC_ENABLE		BIT(10)
=20
 #ifdef CONFIG_X86_32
 # define MAX_IO_APICS 64
@@ -162,6 +165,7 @@
 #define APIC_CPUID(apicid)	((apicid) & XAPIC_DEST_CPUS_MASK)
 #define NUM_APIC_CLUSTERS	((BAD_APICID + 1) >> XAPIC_DEST_CPUS_SHIFT)
=20
+#ifndef __ASSEMBLY__
 /*
  * the local APIC register structure, memory mapped. Not terribly well
  * tested, but we might eventually use this one in the future - the
@@ -435,4 +439,5 @@ enum apic_delivery_modes {
 	APIC_DELIVERY_MODE_EXTINT	=3D 7,
 };
=20
+#endif /* !__ASSEMBLY__ */
 #endif /* _ASM_X86_APICDEF_H */
diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 78796b98a544..c854376e1cb9 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -30,10 +30,7 @@ struct x86_cpu {
 #ifdef CONFIG_HOTPLUG_CPU
 extern int arch_register_cpu(int num);
 extern void arch_unregister_cpu(int);
-extern void start_cpu0(void);
-#ifdef CONFIG_DEBUG_HOTPLUG_CPU0
-extern int _debug_hotplug_cpu(int cpu, int action);
-#endif
+extern void soft_restart_cpu(void);
 #endif
=20
 extern void ap_init_aperfmperf(void);
diff --git a/arch/x86/include/asm/cpumask.h b/arch/x86/include/asm/cpumask.h
index c5aed9e9226c..4acfd57de8f1 100644
--- a/arch/x86/include/asm/cpumask.h
+++ b/arch/x86/include/asm/cpumask.h
@@ -4,11 +4,6 @@
 #ifndef __ASSEMBLY__
 #include <linux/cpumask.h>
=20
-extern cpumask_var_t cpu_callin_mask;
-extern cpumask_var_t cpu_callout_mask;
-extern cpumask_var_t cpu_initialized_mask;
-extern cpumask_var_t cpu_sibling_setup_mask;
-
 extern void setup_cpu_local_masks(void);
=20
 /*
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processo=
r.h
index a1e4fa58b357..d46300e94f85 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -551,7 +551,6 @@ extern void switch_gdt_and_percpu_base(int);
 extern void load_direct_gdt(int);
 extern void load_fixmap_gdt(int);
 extern void cpu_init(void);
-extern void cpu_init_secondary(void);
 extern void cpu_init_exception_handling(void);
 extern void cr4_init(void);
=20
diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index f6a1737c77be..87e5482acd0d 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -52,6 +52,7 @@ struct trampoline_header {
 	u64 efer;
 	u32 cr4;
 	u32 flags;
+	u32 lock;
 #endif
 };
=20
@@ -64,6 +65,8 @@ extern unsigned long initial_stack;
 extern unsigned long initial_vc_handler;
 #endif
=20
+extern u32 *trampoline_lock;
+
 extern unsigned char real_mode_blob[];
 extern unsigned char real_mode_relocs[];
=20
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 4e91054c84be..42060775a3d0 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -38,7 +38,9 @@ struct smp_ops {
 	void (*crash_stop_other_cpus)(void);
 	void (*smp_send_reschedule)(int cpu);
=20
-	int (*cpu_up)(unsigned cpu, struct task_struct *tidle);
+	void (*cleanup_dead_cpu)(unsigned cpu);
+	void (*poll_sync_state)(void);
+	int (*kick_ap_alive)(unsigned cpu, struct task_struct *tidle);
 	int (*cpu_disable)(void);
 	void (*cpu_die)(unsigned int cpu);
 	void (*play_dead)(void);
@@ -78,11 +80,6 @@ static inline void smp_cpus_done(unsigned int max_cpus)
 	smp_ops.smp_cpus_done(max_cpus);
 }
=20
-static inline int __cpu_up(unsigned int cpu, struct task_struct *tidle)
-{
-	return smp_ops.cpu_up(cpu, tidle);
-}
-
 static inline int __cpu_disable(void)
 {
 	return smp_ops.cpu_disable();
@@ -90,7 +87,8 @@ static inline int __cpu_disable(void)
=20
 static inline void __cpu_die(unsigned int cpu)
 {
-	smp_ops.cpu_die(cpu);
+	if (smp_ops.cpu_die)
+		smp_ops.cpu_die(cpu);
 }
=20
 static inline void __noreturn play_dead(void)
@@ -121,16 +119,13 @@ void native_smp_prepare_cpus(unsigned int max_cpus);
 void calculate_max_logical_packages(void);
 void native_smp_cpus_done(unsigned int max_cpus);
 int common_cpu_up(unsigned int cpunum, struct task_struct *tidle);
-int native_cpu_up(unsigned int cpunum, struct task_struct *tidle);
+int native_kick_ap(unsigned int cpu, struct task_struct *tidle);
 int native_cpu_disable(void);
-int common_cpu_die(unsigned int cpu);
-void native_cpu_die(unsigned int cpu);
 void __noreturn hlt_play_dead(void);
 void native_play_dead(void);
 void play_dead_common(void);
 void wbinvd_on_cpu(int cpu);
 int wbinvd_on_all_cpus(void);
-void cond_wakeup_cpu0(void);
=20
 void native_smp_send_reschedule(int cpu);
 void native_send_call_func_ipi(const struct cpumask *mask);
@@ -201,7 +196,14 @@ extern void nmi_selftest(void);
 #endif
=20
 extern unsigned int smpboot_control;
+extern unsigned long apic_mmio_base;
=20
 #endif /* !__ASSEMBLY__ */
=20
+/* Control bits for startup_64 */
+#define STARTUP_READ_APICID	0x80000000
+
+/* Top 8 bits are reserved for control */
+#define STARTUP_PARALLEL_MASK	0xFF000000
+
 #endif /* _ASM_X86_SMP_H */
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 458c891a8273..caf41c4869a0 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -31,9 +31,9 @@
  * CONFIG_NUMA.
  */
 #include <linux/numa.h>
+#include <linux/cpumask.h>
=20
 #ifdef CONFIG_NUMA
-#include <linux/cpumask.h>
=20
 #include <asm/mpspec.h>
 #include <asm/percpu.h>
@@ -139,23 +139,31 @@ static inline int topology_max_smt_threads(void)
 int topology_update_package_map(unsigned int apicid, unsigned int cpu);
 int topology_update_die_map(unsigned int dieid, unsigned int cpu);
 int topology_phys_to_logical_pkg(unsigned int pkg);
-int topology_phys_to_logical_die(unsigned int die, unsigned int cpu);
-bool topology_is_primary_thread(unsigned int cpu);
 bool topology_smt_supported(void);
-#else
+
+extern struct cpumask __cpu_primary_thread_mask;
+#define cpu_primary_thread_mask ((const struct cpumask *)&__cpu_primary_thre=
ad_mask)
+
+/**
+ * topology_is_primary_thread - Check whether CPU is the primary SMT thread
+ * @cpu:	CPU to check
+ */
+static inline bool topology_is_primary_thread(unsigned int cpu)
+{
+	return cpumask_test_cpu(cpu, cpu_primary_thread_mask);
+}
+#else /* CONFIG_SMP */
 #define topology_max_packages()			(1)
 static inline int
 topology_update_package_map(unsigned int apicid, unsigned int cpu) { return =
0; }
 static inline int
 topology_update_die_map(unsigned int dieid, unsigned int cpu) { return 0; }
 static inline int topology_phys_to_logical_pkg(unsigned int pkg) { return 0;=
 }
-static inline int topology_phys_to_logical_die(unsigned int die,
-		unsigned int cpu) { return 0; }
 static inline int topology_max_die_per_package(void) { return 1; }
 static inline int topology_max_smt_threads(void) { return 1; }
 static inline bool topology_is_primary_thread(unsigned int cpu) { return tru=
e; }
 static inline bool topology_smt_supported(void) { return false; }
-#endif
+#endif /* !CONFIG_SMP */
=20
 static inline void arch_fix_phys_package_id(int num, u32 slot)
 {
diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index fbdc3d951494..dc1b03be43eb 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -55,12 +55,10 @@ extern bool tsc_async_resets;
 #ifdef CONFIG_X86_TSC
 extern bool tsc_store_and_check_tsc_adjust(bool bootcpu);
 extern void tsc_verify_tsc_adjust(bool resume);
-extern void check_tsc_sync_source(int cpu);
 extern void check_tsc_sync_target(void);
 #else
 static inline bool tsc_store_and_check_tsc_adjust(bool bootcpu) { return fal=
se; }
 static inline void tsc_verify_tsc_adjust(bool resume) { }
-static inline void check_tsc_sync_source(int cpu) { }
 static inline void check_tsc_sync_target(void) { }
 #endif
=20
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 88085f369ff6..0bf4d735ff00 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -177,11 +177,14 @@ struct x86_init_ops {
  * struct x86_cpuinit_ops - platform specific cpu hotplug setups
  * @setup_percpu_clockev:	set up the per cpu clock event device
  * @early_percpu_clock_init:	early init of the per cpu clock event device
+ * @fixup_cpu_id:		fixup function for cpuinfo_x86::phys_proc_id
+ * @parallel_bringup:		Parallel bringup control
  */
 struct x86_cpuinit_ops {
 	void (*setup_percpu_clockev)(void);
 	void (*early_percpu_clock_init)(void);
 	void (*fixup_cpu_id)(struct cpuinfo_x86 *c, int node);
+	bool parallel_bringup;
 };
=20
 struct timespec64;
diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index 1328c221af30..6dfecb27b846 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -16,6 +16,7 @@
 #include <asm/cacheflush.h>
 #include <asm/realmode.h>
 #include <asm/hypervisor.h>
+#include <asm/smp.h>
=20
 #include <linux/ftrace.h>
 #include "../../realmode/rm/wakeup.h"
@@ -127,7 +128,13 @@ int x86_acpi_suspend_lowlevel(void)
 	 * value is in the actual %rsp register.
 	 */
 	current->thread.sp =3D (unsigned long)temp_stack + sizeof(temp_stack);
-	smpboot_control =3D smp_processor_id();
+	/*
+	 * Ensure the CPU knows which one it is when it comes back, if
+	 * it isn't in parallel mode and expected to work that out for
+	 * itself.
+	 */
+	if (!(smpboot_control & STARTUP_PARALLEL_MASK))
+		smpboot_control =3D smp_processor_id();
 #endif
 	initial_code =3D (unsigned long)wakeup_long64;
 	saved_magic =3D 0x123456789abcdef0L;
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 770557110051..af49e24b46a4 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -101,6 +101,9 @@ static int apic_extnmi __ro_after_init =3D APIC_EXTNMI_BS=
P;
  */
 static bool virt_ext_dest_id __ro_after_init;
=20
+/* For parallel bootup. */
+unsigned long apic_mmio_base __ro_after_init;
+
 /*
  * Map cpu index to physical APIC ID
  */
@@ -2163,6 +2166,7 @@ void __init register_lapic_address(unsigned long addres=
s)
=20
 	if (!x2apic_mode) {
 		set_fixmap_nocache(FIX_APIC_BASE, address);
+		apic_mmio_base =3D APIC_BASE;
 		apic_printk(APIC_VERBOSE, "mapped APIC to %16lx (%16lx)\n",
 			    APIC_BASE, address);
 	}
@@ -2376,7 +2380,7 @@ static int nr_logical_cpuids =3D 1;
 /*
  * Used to store mapping between logical CPU IDs and APIC IDs.
  */
-static int cpuid_to_apicid[] =3D {
+int cpuid_to_apicid[] =3D {
 	[0 ... NR_CPUS - 1] =3D -1,
 };
=20
@@ -2386,20 +2390,31 @@ bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
 }
=20
 #ifdef CONFIG_SMP
-/**
- * apic_id_is_primary_thread - Check whether APIC ID belongs to a primary th=
read
- * @apicid: APIC ID to check
+static void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid)
+{
+	/* Isolate the SMT bit(s) in the APICID and check for 0 */
+	u32 mask =3D (1U << (fls(smp_num_siblings) - 1)) - 1;
+
+	if (smp_num_siblings =3D=3D 1 || !(apicid & mask))
+		cpumask_set_cpu(cpu, &__cpu_primary_thread_mask);
+}
+
+/*
+ * Due to the utter mess of CPUID evaluation smp_num_siblings is not valid
+ * during early boot. Initialize the primary thread mask before SMP
+ * bringup.
  */
-bool apic_id_is_primary_thread(unsigned int apicid)
+static int __init smp_init_primary_thread_mask(void)
 {
-	u32 mask;
+	unsigned int cpu;
=20
-	if (smp_num_siblings =3D=3D 1)
-		return true;
-	/* Isolate the SMT bit(s) in the APICID and check for 0 */
-	mask =3D (1U << (fls(smp_num_siblings) - 1)) - 1;
-	return !(apicid & mask);
+	for (cpu =3D 0; cpu < nr_logical_cpuids; cpu++)
+		cpu_mark_primary_thread(cpu, cpuid_to_apicid[cpu]);
+	return 0;
 }
+early_initcall(smp_init_primary_thread_mask);
+#else
+static inline void cpu_mark_primary_thread(unsigned int cpu, unsigned int ap=
icid) { }
 #endif
=20
 /*
@@ -2544,6 +2559,9 @@ int generic_processor_info(int apicid, int version)
 	set_cpu_present(cpu, true);
 	num_processors++;
=20
+	if (system_state !=3D SYSTEM_BOOTING)
+		cpu_mark_primary_thread(cpu, apicid);
+
 	return cpu;
 }
=20
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index 22ab13966427..8bb937331acb 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -133,8 +133,8 @@ static bool skip_addr(void *dest)
 	/* Accounts directly */
 	if (dest =3D=3D ret_from_fork)
 		return true;
-#ifdef CONFIG_HOTPLUG_CPU
-	if (dest =3D=3D start_cpu0)
+#if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_AMD_MEM_ENCRYPT)
+	if (dest =3D=3D soft_restart_cpu)
 		return true;
 #endif
 #ifdef CONFIG_FUNCTION_TRACER
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 4063e8991211..8f86eacf69f7 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -39,6 +39,8 @@ DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_ma=
p);
 /* Shared L2 cache maps */
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_l2c_shared_map);
=20
+static cpumask_var_t cpu_cacheinfo_mask;
+
 /* Kernel controls MTRR and/or PAT MSRs. */
 unsigned int memory_caching_control __ro_after_init;
=20
@@ -1172,8 +1174,10 @@ void cache_bp_restore(void)
 		cache_cpu_init();
 }
=20
-static int cache_ap_init(unsigned int cpu)
+static int cache_ap_online(unsigned int cpu)
 {
+	cpumask_set_cpu(cpu, cpu_cacheinfo_mask);
+
 	if (!memory_caching_control || get_cache_aps_delayed_init())
 		return 0;
=20
@@ -1191,11 +1195,17 @@ static int cache_ap_init(unsigned int cpu)
 	 *      lock to prevent MTRR entry changes
 	 */
 	stop_machine_from_inactive_cpu(cache_rendezvous_handler, NULL,
-				       cpu_callout_mask);
+				       cpu_cacheinfo_mask);
=20
 	return 0;
 }
=20
+static int cache_ap_offline(unsigned int cpu)
+{
+	cpumask_clear_cpu(cpu, cpu_cacheinfo_mask);
+	return 0;
+}
+
 /*
  * Delayed cache initialization for all AP's
  */
@@ -1210,9 +1220,12 @@ void cache_aps_init(void)
=20
 static int __init cache_ap_register(void)
 {
+	zalloc_cpumask_var(&cpu_cacheinfo_mask, GFP_KERNEL);
+	cpumask_set_cpu(smp_processor_id(), cpu_cacheinfo_mask);
+
 	cpuhp_setup_state_nocalls(CPUHP_AP_CACHECTRL_STARTING,
 				  "x86/cachectrl:starting",
-				  cache_ap_init, NULL);
+				  cache_ap_online, cache_ap_offline);
 	return 0;
 }
-core_initcall(cache_ap_register);
+early_initcall(cache_ap_register);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 80710a68ef7d..7cc44ebead5a 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -67,14 +67,6 @@
=20
 u32 elf_hwcap2 __read_mostly;
=20
-/* all of these masks are initialized in setup_cpu_local_masks() */
-cpumask_var_t cpu_initialized_mask;
-cpumask_var_t cpu_callout_mask;
-cpumask_var_t cpu_callin_mask;
-
-/* representing cpus for which sibling maps can be computed */
-cpumask_var_t cpu_sibling_setup_mask;
-
 /* Number of siblings per CPU package */
 int smp_num_siblings =3D 1;
 EXPORT_SYMBOL(smp_num_siblings);
@@ -169,15 +161,6 @@ static void ppin_init(struct cpuinfo_x86 *c)
 	clear_cpu_cap(c, info->feature);
 }
=20
-/* correctly size the local cpu masks */
-void __init setup_cpu_local_masks(void)
-{
-	alloc_bootmem_cpumask_var(&cpu_initialized_mask);
-	alloc_bootmem_cpumask_var(&cpu_callin_mask);
-	alloc_bootmem_cpumask_var(&cpu_callout_mask);
-	alloc_bootmem_cpumask_var(&cpu_sibling_setup_mask);
-}
-
 static void default_init(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_X86_64
@@ -2123,19 +2106,6 @@ static void dbg_restore_debug_regs(void)
 #define dbg_restore_debug_regs()
 #endif /* ! CONFIG_KGDB */
=20
-static void wait_for_master_cpu(int cpu)
-{
-#ifdef CONFIG_SMP
-	/*
-	 * wait for ACK from master CPU before continuing
-	 * with AP initialization
-	 */
-	WARN_ON(cpumask_test_and_set_cpu(cpu, cpu_initialized_mask));
-	while (!cpumask_test_cpu(cpu, cpu_callout_mask))
-		cpu_relax();
-#endif
-}
-
 static inline void setup_getcpu(int cpu)
 {
 	unsigned long cpudata =3D vdso_encode_cpunode(cpu, early_cpu_to_node(cpu));
@@ -2158,11 +2128,7 @@ static inline void setup_getcpu(int cpu)
 }
=20
 #ifdef CONFIG_X86_64
-static inline void ucode_cpu_init(int cpu)
-{
-	if (cpu)
-		load_ucode_ap();
-}
+static inline void ucode_cpu_init(int cpu) { }
=20
 static inline void tss_setup_ist(struct tss_struct *tss)
 {
@@ -2239,8 +2205,6 @@ void cpu_init(void)
 	struct task_struct *cur =3D current;
 	int cpu =3D raw_smp_processor_id();
=20
-	wait_for_master_cpu(cpu);
-
 	ucode_cpu_init(cpu);
=20
 #ifdef CONFIG_NUMA
@@ -2293,18 +2257,6 @@ void cpu_init(void)
 	load_fixmap_gdt(cpu);
 }
=20
-#ifdef CONFIG_SMP
-void cpu_init_secondary(void)
-{
-	/*
-	 * Relies on the BP having set-up the IDT tables, which are loaded
-	 * on this CPU in cpu_init_exception_handling().
-	 */
-	cpu_init_exception_handling();
-	cpu_init();
-}
-#endif
-
 #ifdef CONFIG_MICROCODE_LATE_LOADING
 /**
  * store_cpu_caps() - Store a snapshot of CPU capabilities
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 67c8ed99144b..c9318993f959 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -138,20 +138,6 @@ SYM_CODE_START(startup_32)
 	jmp .Ldefault_entry
 SYM_CODE_END(startup_32)
=20
-#ifdef CONFIG_HOTPLUG_CPU
-/*
- * Boot CPU0 entry point. It's called from play_dead(). Everything has been =
set
- * up already except stack. We just set up stack here. Then call
- * start_secondary().
- */
-SYM_FUNC_START(start_cpu0)
-	movl initial_stack, %ecx
-	movl %ecx, %esp
-	call *(initial_code)
-1:	jmp 1b
-SYM_FUNC_END(start_cpu0)
-#endif
-
 /*
  * Non-boot CPU entry point; entered from trampoline.S
  * We can't lgdt here, because lgdt itself uses a data segment, but
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index a5df3e994f04..9cd77d319555 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -24,7 +24,9 @@
 #include "../entry/calling.h"
 #include <asm/export.h>
 #include <asm/nospec-branch.h>
+#include <asm/apicdef.h>
 #include <asm/fixmap.h>
+#include <asm/smp.h>
=20
 /*
  * We are not able to switch in one step to the final KERNEL ADDRESS SPACE
@@ -234,8 +236,67 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GL=
OBAL)
 	ANNOTATE_NOENDBR // above
=20
 #ifdef CONFIG_SMP
+	/*
+	 * For parallel boot, the APIC ID is read from the APIC, and then
+	 * used to look up the CPU number.  For booting a single CPU, the
+	 * CPU number is encoded in smpboot_control.
+	 *
+	 * Bit 31	STARTUP_READ_APICID (Read APICID from APIC)
+	 * Bit 0-23	CPU# if STARTUP_xx flags are not set
+	 */
 	movl	smpboot_control(%rip), %ecx
+	testl	$STARTUP_READ_APICID, %ecx
+	jnz	.Lread_apicid
+	/*
+	 * No control bit set, single CPU bringup. CPU number is provided
+	 * in bit 0-23. This is also the boot CPU case (CPU number 0).
+	 */
+	andl	$(~STARTUP_PARALLEL_MASK), %ecx
+	jmp	.Lsetup_cpu
=20
+.Lread_apicid:
+	/* Check whether X2APIC mode is already enabled */
+	mov	$MSR_IA32_APICBASE, %ecx
+	rdmsr
+	testl	$X2APIC_ENABLE, %eax
+	jnz	.Lread_apicid_msr
+
+	/* Read the APIC ID from the fix-mapped MMIO space. */
+	movq	apic_mmio_base(%rip), %rcx
+	addq	$APIC_ID, %rcx
+	movl	(%rcx), %eax
+	shr	$24, %eax
+	jmp	.Llookup_AP
+
+.Lread_apicid_msr:
+	mov	$APIC_X2APIC_ID_MSR, %ecx
+	rdmsr
+
+.Llookup_AP:
+	/* EAX contains the APIC ID of the current CPU */
+	xorq	%rcx, %rcx
+	leaq	cpuid_to_apicid(%rip), %rbx
+
+.Lfind_cpunr:
+	cmpl	(%rbx,%rcx,4), %eax
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
+	movl	$0, (%rax)
+
+1:	cli
+	hlt
+	jmp	1b
+
+.Lsetup_cpu:
 	/* Get the per cpu offset for the given CPU# which is in ECX */
 	movq	__per_cpu_offset(,%rcx,8), %rdx
 #else
@@ -251,6 +312,16 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GL=
OBAL)
 	movq	pcpu_hot + X86_current_task(%rdx), %rax
 	movq	TASK_threadsp(%rax), %rsp
=20
+	/*
+	 * Now that this CPU is running on its own stack, drop the realmode
+	 * protection. For the boot CPU the pointer is NULL!
+	 */
+	movq	trampoline_lock(%rip), %rax
+	testq	%rax, %rax
+	jz	.Lsetup_gdt
+	movl	$0, (%rax)
+
+.Lsetup_gdt:
 	/*
 	 * We must switch to a new descriptor in kernel space for the GDT
 	 * because soon the kernel won't have access anymore to the userspace
@@ -375,13 +446,13 @@ SYM_CODE_END(secondary_startup_64)
 #include "verify_cpu.S"
 #include "sev_verify_cbit.S"
=20
-#ifdef CONFIG_HOTPLUG_CPU
+#if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_AMD_MEM_ENCRYPT)
 /*
- * Boot CPU0 entry point. It's called from play_dead(). Everything has been =
set
- * up already except stack. We just set up stack here. Then call
- * start_secondary() via .Ljump_to_C_code.
+ * Entry point for soft restart of a CPU. Invoked from xxx_play_dead() for
+ * restarting the boot CPU or for restarting SEV guest CPUs after CPU hot
+ * unplug. Everything is set up already except the stack.
  */
-SYM_CODE_START(start_cpu0)
+SYM_CODE_START(soft_restart_cpu)
 	ANNOTATE_NOENDBR
 	UNWIND_HINT_END_OF_STACK
=20
@@ -390,7 +461,7 @@ SYM_CODE_START(start_cpu0)
 	movq	TASK_threadsp(%rcx), %rsp
=20
 	jmp	.Ljump_to_C_code
-SYM_CODE_END(start_cpu0)
+SYM_CODE_END(soft_restart_cpu)
 #endif
=20
 #ifdef CONFIG_AMD_MEM_ENCRYPT
@@ -433,6 +504,8 @@ SYM_DATA(initial_code,	.quad x86_64_start_kernel)
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 SYM_DATA(initial_vc_handler,	.quad handle_vc_boot_ghcb)
 #endif
+
+SYM_DATA(trampoline_lock, .quad 0);
 	__FINITDATA
=20
 	__INIT
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index b031244d6d2d..d095a5d3c14a 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1328,7 +1328,7 @@ static void sev_es_play_dead(void)
 	 * If we get here, the VCPU was woken up again. Jump to CPU
 	 * startup code to get it back online.
 	 */
-	start_cpu0();
+	soft_restart_cpu();
 }
 #else  /* CONFIG_HOTPLUG_CPU */
 #define sev_es_play_dead	native_play_dead
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 375b33ecafa2..0d54115c3859 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -268,8 +268,7 @@ struct smp_ops smp_ops =3D {
 #endif
 	.smp_send_reschedule	=3D native_smp_send_reschedule,
=20
-	.cpu_up			=3D native_cpu_up,
-	.cpu_die		=3D native_cpu_die,
+	.kick_ap_alive		=3D native_kick_ap,
 	.cpu_disable		=3D native_cpu_disable,
 	.play_dead		=3D native_play_dead,
=20
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 352f0ce1ece4..aaa876cfd9d9 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -57,6 +57,8 @@
 #include <linux/pgtable.h>
 #include <linux/overflow.h>
 #include <linux/stackprotector.h>
+#include <linux/cpuhotplug.h>
+#include <linux/mc146818rtc.h>
=20
 #include <asm/acpi.h>
 #include <asm/cacheinfo.h>
@@ -74,7 +76,7 @@
 #include <asm/fpu/api.h>
 #include <asm/setup.h>
 #include <asm/uv/uv.h>
-#include <linux/mc146818rtc.h>
+#include <asm/microcode.h>
 #include <asm/i8259.h>
 #include <asm/misc.h>
 #include <asm/qspinlock.h>
@@ -101,6 +103,12 @@ EXPORT_PER_CPU_SYMBOL(cpu_die_map);
 DEFINE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
 EXPORT_PER_CPU_SYMBOL(cpu_info);
=20
+/* CPUs which are the primary SMT threads */
+struct cpumask __cpu_primary_thread_mask __read_mostly;
+
+/* Representing CPUs for which sibling maps can be computed */
+static cpumask_var_t cpu_sibling_setup_mask;
+
 /* Logical package management. We might want to allocate that dynamically */
 unsigned int __max_logical_packages __read_mostly;
 EXPORT_SYMBOL(__max_logical_packages);
@@ -121,7 +129,6 @@ int arch_update_cpu_topology(void)
 	return retval;
 }
=20
-
 static unsigned int smpboot_warm_reset_vector_count;
=20
 static inline void smpboot_setup_warm_reset_vector(unsigned long start_eip)
@@ -154,66 +161,59 @@ static inline void smpboot_restore_warm_reset_vector(vo=
id)
=20
 }
=20
-/*
- * Report back to the Boot Processor during boot time or to the caller proce=
ssor
- * during CPU online.
- */
-static void smp_callin(void)
+/* Run the next set of setup steps for the upcoming CPU */
+static void ap_starting(void)
 {
-	int cpuid;
+	int cpuid =3D smp_processor_id();
=20
 	/*
-	 * If waken up by an INIT in an 82489DX configuration
-	 * cpu_callout_mask guarantees we don't get here before
-	 * an INIT_deassert IPI reaches our local APIC, so it is
-	 * now safe to touch our local APIC.
-	 */
-	cpuid =3D smp_processor_id();
-
-	/*
-	 * the boot CPU has finished the init stage and is spinning
-	 * on callin_map until we finish. We are free to set up this
-	 * CPU, first the APIC. (this is probably redundant on most
-	 * boards)
+	 * If woken up by an INIT in an 82489DX configuration the alive
+	 * synchronization guarantees that the CPU does not reach this
+	 * point before an INIT_deassert IPI reaches the local APIC, so it
+	 * is now safe to touch the local APIC.
+	 *
+	 * Set up this CPU, first the APIC, which is probably redundant on
+	 * most boards.
 	 */
 	apic_ap_setup();
=20
-	/*
-	 * Save our processor parameters. Note: this information
-	 * is needed for clock calibration.
-	 */
+	/* Save the processor parameters. */
 	smp_store_cpu_info(cpuid);
=20
 	/*
 	 * The topology information must be up to date before
-	 * calibrate_delay() and notify_cpu_starting().
+	 * notify_cpu_starting().
 	 */
-	set_cpu_sibling_map(raw_smp_processor_id());
+	set_cpu_sibling_map(cpuid);
=20
 	ap_init_aperfmperf();
=20
-	/*
-	 * Get our bogomips.
-	 * Update loops_per_jiffy in cpu_data. Previous call to
-	 * smp_store_cpu_info() stored a value that is close but not as
-	 * accurate as the value just calculated.
-	 */
-	calibrate_delay();
-	cpu_data(cpuid).loops_per_jiffy =3D loops_per_jiffy;
 	pr_debug("Stack at about %p\n", &cpuid);
=20
 	wmb();
=20
+	/*
+	 * This runs the AP through all the cpuhp states to its target
+	 * state CPUHP_ONLINE.
+	 */
 	notify_cpu_starting(cpuid);
+}
=20
+static void ap_calibrate_delay(void)
+{
 	/*
-	 * Allow the master to continue.
+	 * Calibrate the delay loop and update loops_per_jiffy in cpu_data.
+	 * smp_store_cpu_info() stored a value that is close but not as
+	 * accurate as the value just calculated.
+	 *
+	 * As this is invoked after the TSC synchronization check,
+	 * calibrate_delay_is_known() will skip the calibration routine
+	 * when TSC is synchronized across sockets.
 	 */
-	cpumask_set_cpu(cpuid, cpu_callin_mask);
+	calibrate_delay();
+	cpu_data(smp_processor_id()).loops_per_jiffy =3D loops_per_jiffy;
 }
=20
-static int cpu0_logical_apicid;
-static int enable_start_cpu0;
 /*
  * Activate a secondary processor.
  */
@@ -226,24 +226,62 @@ static void notrace start_secondary(void *unused)
 	 */
 	cr4_init();
=20
-#ifdef CONFIG_X86_32
-	/* switch away from the initial page table */
-	load_cr3(swapper_pg_dir);
-	__flush_tlb_all();
-#endif
-	cpu_init_secondary();
+	/*
+	 * 32-bit specific. 64-bit reaches this code with the correct page
+	 * table established. Yet another historical divergence.
+	 */
+	if (IS_ENABLED(CONFIG_X86_32)) {
+		/* switch away from the initial page table */
+		load_cr3(swapper_pg_dir);
+		__flush_tlb_all();
+	}
+
+	cpu_init_exception_handling();
+
+	/*
+	 * 32-bit systems load the microcode from the ASM startup code for
+	 * historical reasons.
+	 *
+	 * On 64-bit systems load it before reaching the AP alive
+	 * synchronization point below so it is not part of the full per
+	 * CPU serialized bringup part when "parallel" bringup is enabled.
+	 *
+	 * That's even safe when hyperthreading is enabled in the CPU as
+	 * the core code starts the primary threads first and leaves the
+	 * secondary threads waiting for SIPI. Loading microcode on
+	 * physical cores concurrently is a safe operation.
+	 *
+	 * This covers both the Intel specific issue that concurrent
+	 * microcode loading on SMT siblings must be prohibited and the
+	 * vendor independent issue`that microcode loading which changes
+	 * CPUID, MSRs etc. must be strictly serialized to maintain
+	 * software state correctness.
+	 */
+	if (IS_ENABLED(CONFIG_X86_64))
+		load_ucode_ap();
+
+	/*
+	 * Synchronization point with the hotplug core. Sets this CPUs
+	 * synchronization state to ALIVE and spin-waits for the control CPU to
+	 * release this CPU for further bringup.
+	 */
+	cpuhp_ap_sync_alive();
+
+	cpu_init();
 	rcu_cpu_starting(raw_smp_processor_id());
 	x86_cpuinit.early_percpu_clock_init();
-	smp_callin();
=20
-	enable_start_cpu0 =3D 0;
+	ap_starting();
+
+	/* Check TSC synchronization with the control CPU. */
+	check_tsc_sync_target();
=20
-	/* otherwise gcc will move up smp_processor_id before the cpu_init */
-	barrier();
 	/*
-	 * Check TSC synchronization with the boot CPU:
+	 * Calibrate the delay loop after the TSC synchronization check.
+	 * This allows to skip the calibration when TSC is synchronized
+	 * across sockets.
 	 */
-	check_tsc_sync_target();
+	ap_calibrate_delay();
=20
 	speculative_store_bypass_ht_init();
=20
@@ -257,7 +295,6 @@ static void notrace start_secondary(void *unused)
 	set_cpu_online(smp_processor_id(), true);
 	lapic_online();
 	unlock_vector_lock();
-	cpu_set_state_online(smp_processor_id());
 	x86_platform.nmi_init();
=20
 	/* enable local interrupts */
@@ -269,15 +306,6 @@ static void notrace start_secondary(void *unused)
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
=20
-/**
- * topology_is_primary_thread - Check whether CPU is the primary SMT thread
- * @cpu:	CPU to check
- */
-bool topology_is_primary_thread(unsigned int cpu)
-{
-	return apic_id_is_primary_thread(per_cpu(x86_cpu_to_apicid, cpu));
-}
-
 /**
  * topology_smt_supported - Check whether SMT is supported by the CPUs
  */
@@ -288,6 +316,7 @@ bool topology_smt_supported(void)
=20
 /**
  * topology_phys_to_logical_pkg - Map a physical package id to a logical
+ * @phys_pkg:	The physical package id to map
  *
  * Returns logical package id or -1 if not found
  */
@@ -304,15 +333,17 @@ int topology_phys_to_logical_pkg(unsigned int phys_pkg)
 	return -1;
 }
 EXPORT_SYMBOL(topology_phys_to_logical_pkg);
+
 /**
  * topology_phys_to_logical_die - Map a physical die id to logical
+ * @die_id:	The physical die id to map
+ * @cur_cpu:	The CPU for which the mapping is done
  *
  * Returns logical die id or -1 if not found
  */
-int topology_phys_to_logical_die(unsigned int die_id, unsigned int cur_cpu)
+static int topology_phys_to_logical_die(unsigned int die_id, unsigned int cu=
r_cpu)
 {
-	int cpu;
-	int proc_id =3D cpu_data(cur_cpu).phys_proc_id;
+	int cpu, proc_id =3D cpu_data(cur_cpu).phys_proc_id;
=20
 	for_each_possible_cpu(cpu) {
 		struct cpuinfo_x86 *c =3D &cpu_data(cpu);
@@ -323,7 +354,6 @@ int topology_phys_to_logical_die(unsigned int die_id, uns=
igned int cur_cpu)
 	}
 	return -1;
 }
-EXPORT_SYMBOL(topology_phys_to_logical_die);
=20
 /**
  * topology_update_package_map - Update the physical to logical package map
@@ -398,7 +428,7 @@ void smp_store_cpu_info(int id)
 	c->cpu_index =3D id;
 	/*
 	 * During boot time, CPU0 has this setup already. Save the info when
-	 * bringing up AP or offlined CPU0.
+	 * bringing up an AP.
 	 */
 	identify_secondary_cpu(c);
 	c->initialized =3D true;
@@ -706,9 +736,9 @@ static void impress_friends(void)
 	 * Allow the user to impress friends.
 	 */
 	pr_debug("Before bogomips\n");
-	for_each_possible_cpu(cpu)
-		if (cpumask_test_cpu(cpu, cpu_callout_mask))
-			bogosum +=3D cpu_data(cpu).loops_per_jiffy;
+	for_each_online_cpu(cpu)
+		bogosum +=3D cpu_data(cpu).loops_per_jiffy;
+
 	pr_info("Total of %d processors activated (%lu.%02lu BogoMIPS)\n",
 		num_online_cpus(),
 		bogosum/(500000/HZ),
@@ -795,51 +825,14 @@ static void __init smp_quirk_init_udelay(void)
 }
=20
 /*
- * Poke the other CPU in the eye via NMI to wake it up. Remember that the no=
rmal
- * INIT, INIT, STARTUP sequence will reset the chip hard for us, and this
- * won't ... remember to clear down the APIC, etc later.
+ * Wake up AP by INIT, INIT, STARTUP sequence.
  */
-int
-wakeup_secondary_cpu_via_nmi(int apicid, unsigned long start_eip)
-{
-	u32 dm =3D apic->dest_mode_logical ? APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
-	unsigned long send_status, accept_status =3D 0;
-	int maxlvt;
-
-	/* Target chip */
-	/* Boot on the stack */
-	/* Kick the second */
-	apic_icr_write(APIC_DM_NMI | dm, apicid);
-
-	pr_debug("Waiting for send to finish...\n");
-	send_status =3D safe_apic_wait_icr_idle();
-
-	/*
-	 * Give the other CPU some time to accept the IPI.
-	 */
-	udelay(200);
-	if (APIC_INTEGRATED(boot_cpu_apic_version)) {
-		maxlvt =3D lapic_get_maxlvt();
-		if (maxlvt > 3)			/* Due to the Pentium erratum 3AP.  */
-			apic_write(APIC_ESR, 0);
-		accept_status =3D (apic_read(APIC_ESR) & 0xEF);
-	}
-	pr_debug("NMI sent\n");
-
-	if (send_status)
-		pr_err("APIC never delivered???\n");
-	if (accept_status)
-		pr_err("APIC delivery error (%lx)\n", accept_status);
-
-	return (send_status | accept_status);
-}
-
-static int
-wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long start_eip)
+static int wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long star=
t_eip)
 {
 	unsigned long send_status =3D 0, accept_status =3D 0;
 	int maxlvt, num_starts, j;
=20
+	preempt_disable();
 	maxlvt =3D lapic_get_maxlvt();
=20
 	/*
@@ -945,15 +938,16 @@ wakeup_secondary_cpu_via_init(int phys_apicid, unsigned=
 long start_eip)
 	if (accept_status)
 		pr_err("APIC delivery error (%lx)\n", accept_status);
=20
+	preempt_enable();
 	return (send_status | accept_status);
 }
=20
 /* reduce the number of lines printed when booting a large cpu count system =
*/
 static void announce_cpu(int cpu, int apicid)
 {
+	static int width, node_width, first =3D 1;
 	static int current_node =3D NUMA_NO_NODE;
 	int node =3D early_cpu_to_node(cpu);
-	static int width, node_width;
=20
 	if (!width)
 		width =3D num_digits(num_possible_cpus()) + 1; /* + '#' sign */
@@ -961,10 +955,10 @@ static void announce_cpu(int cpu, int apicid)
 	if (!node_width)
 		node_width =3D num_digits(num_possible_nodes()) + 1; /* + '#' */
=20
-	if (cpu =3D=3D 1)
-		printk(KERN_INFO "x86: Booting SMP configuration:\n");
-
 	if (system_state < SYSTEM_RUNNING) {
+		if (first)
+			pr_info("x86: Booting SMP configuration:\n");
+
 		if (node !=3D current_node) {
 			if (current_node > (-1))
 				pr_cont("\n");
@@ -975,77 +969,16 @@ static void announce_cpu(int cpu, int apicid)
 		}
=20
 		/* Add padding for the BSP */
-		if (cpu =3D=3D 1)
+		if (first)
 			pr_cont("%*s", width + 1, " ");
+		first =3D 0;
=20
 		pr_cont("%*s#%d", width - num_digits(cpu), " ", cpu);
-
 	} else
 		pr_info("Booting Node %d Processor %d APIC 0x%x\n",
 			node, cpu, apicid);
 }
=20
-static int wakeup_cpu0_nmi(unsigned int cmd, struct pt_regs *regs)
-{
-	int cpu;
-
-	cpu =3D smp_processor_id();
-	if (cpu =3D=3D 0 && !cpu_online(cpu) && enable_start_cpu0)
-		return NMI_HANDLED;
-
-	return NMI_DONE;
-}
-
-/*
- * Wake up AP by INIT, INIT, STARTUP sequence.
- *
- * Instead of waiting for STARTUP after INITs, BSP will execute the BIOS
- * boot-strap code which is not a desired behavior for waking up BSP. To
- * void the boot-strap code, wake up CPU0 by NMI instead.
- *
- * This works to wake up soft offlined CPU0 only. If CPU0 is hard offlined
- * (i.e. physically hot removed and then hot added), NMI won't wake it up.
- * We'll change this code in the future to wake up hard offlined CPU0 if
- * real platform and request are available.
- */
-static int
-wakeup_cpu_via_init_nmi(int cpu, unsigned long start_ip, int apicid,
-	       int *cpu0_nmi_registered)
-{
-	int id;
-	int boot_error;
-
-	preempt_disable();
-
-	/*
-	 * Wake up AP by INIT, INIT, STARTUP sequence.
-	 */
-	if (cpu) {
-		boot_error =3D wakeup_secondary_cpu_via_init(apicid, start_ip);
-		goto out;
-	}
-
-	/*
-	 * Wake up BSP by nmi.
-	 *
-	 * Register a NMI handler to help wake up CPU0.
-	 */
-	boot_error =3D register_nmi_handler(NMI_LOCAL,
-					  wakeup_cpu0_nmi, 0, "wake_cpu0");
-
-	if (!boot_error) {
-		enable_start_cpu0 =3D 1;
-		*cpu0_nmi_registered =3D 1;
-		id =3D apic->dest_mode_logical ? cpu0_logical_apicid : apicid;
-		boot_error =3D wakeup_secondary_cpu_via_nmi(id, start_ip);
-	}
-
-out:
-	preempt_enable();
-
-	return boot_error;
-}
-
 int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 {
 	int ret;
@@ -1071,17 +1004,13 @@ int common_cpu_up(unsigned int cpu, struct task_struc=
t *idle)
 /*
  * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
  * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
- * Returns zero if CPU booted OK, else error code from
+ * Returns zero if startup was successfully sent, else error code from
  * ->wakeup_secondary_cpu.
  */
-static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
-		       int *cpu0_nmi_registered)
+static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle)
 {
-	/* start_ip had better be page-aligned! */
 	unsigned long start_ip =3D real_mode_header->trampoline_start;
-
-	unsigned long boot_error =3D 0;
-	unsigned long timeout;
+	int ret;
=20
 #ifdef CONFIG_X86_64
 	/* If 64-bit wakeup method exists, use the 64-bit mode trampoline IP */
@@ -1094,7 +1023,7 @@ static int do_boot_cpu(int apicid, int cpu, struct task=
_struct *idle,
 	if (IS_ENABLED(CONFIG_X86_32)) {
 		early_gdt_descr.address =3D (unsigned long)get_cpu_gdt_rw(cpu);
 		initial_stack  =3D idle->thread.sp;
-	} else {
+	} else if (!(smpboot_control & STARTUP_PARALLEL_MASK)) {
 		smpboot_control =3D cpu;
 	}
=20
@@ -1108,7 +1037,6 @@ static int do_boot_cpu(int apicid, int cpu, struct task=
_struct *idle,
 	 * This grunge runs the startup process for
 	 * the targeted processor.
 	 */
-
 	if (x86_platform.legacy.warm_reset) {
=20
 		pr_debug("Setting warm reset code and vector.\n");
@@ -1123,13 +1051,6 @@ static int do_boot_cpu(int apicid, int cpu, struct tas=
k_struct *idle,
 		}
 	}
=20
-	/*
-	 * AP might wait on cpu_callout_mask in cpu_init() with
-	 * cpu_initialized_mask set if previous attempt to online
-	 * it timed-out. Clear cpu_initialized_mask so that after
-	 * INIT/SIPI it could start with a clean state.
-	 */
-	cpumask_clear_cpu(cpu, cpu_initialized_mask);
 	smp_mb();
=20
 	/*
@@ -1137,66 +1058,25 @@ static int do_boot_cpu(int apicid, int cpu, struct ta=
sk_struct *idle,
 	 * - Use a method from the APIC driver if one defined, with wakeup
 	 *   straight to 64-bit mode preferred over wakeup to RM.
 	 * Otherwise,
-	 * - Use an INIT boot APIC message for APs or NMI for BSP.
+	 * - Use an INIT boot APIC message
 	 */
 	if (apic->wakeup_secondary_cpu_64)
-		boot_error =3D apic->wakeup_secondary_cpu_64(apicid, start_ip);
+		ret =3D apic->wakeup_secondary_cpu_64(apicid, start_ip);
 	else if (apic->wakeup_secondary_cpu)
-		boot_error =3D apic->wakeup_secondary_cpu(apicid, start_ip);
+		ret =3D apic->wakeup_secondary_cpu(apicid, start_ip);
 	else
-		boot_error =3D wakeup_cpu_via_init_nmi(cpu, start_ip, apicid,
-						     cpu0_nmi_registered);
-
-	if (!boot_error) {
-		/*
-		 * Wait 10s total for first sign of life from AP
-		 */
-		boot_error =3D -1;
-		timeout =3D jiffies + 10*HZ;
-		while (time_before(jiffies, timeout)) {
-			if (cpumask_test_cpu(cpu, cpu_initialized_mask)) {
-				/*
-				 * Tell AP to proceed with initialization
-				 */
-				cpumask_set_cpu(cpu, cpu_callout_mask);
-				boot_error =3D 0;
-				break;
-			}
-			schedule();
-		}
-	}
-
-	if (!boot_error) {
-		/*
-		 * Wait till AP completes initial initialization
-		 */
-		while (!cpumask_test_cpu(cpu, cpu_callin_mask)) {
-			/*
-			 * Allow other tasks to run while we wait for the
-			 * AP to come online. This also gives a chance
-			 * for the MTRR work(triggered by the AP coming online)
-			 * to be completed in the stop machine context.
-			 */
-			schedule();
-		}
-	}
-
-	if (x86_platform.legacy.warm_reset) {
-		/*
-		 * Cleanup possible dangling ends...
-		 */
-		smpboot_restore_warm_reset_vector();
-	}
+		ret =3D wakeup_secondary_cpu_via_init(apicid, start_ip);
=20
-	return boot_error;
+	/* If the wakeup mechanism failed, cleanup the warm reset vector */
+	if (ret)
+		arch_cpuhp_cleanup_kick_cpu(cpu);
+	return ret;
 }
=20
-int native_cpu_up(unsigned int cpu, struct task_struct *tidle)
+int native_kick_ap(unsigned int cpu, struct task_struct *tidle)
 {
 	int apicid =3D apic->cpu_present_to_apicid(cpu);
-	int cpu0_nmi_registered =3D 0;
-	unsigned long flags;
-	int err, ret =3D 0;
+	int err;
=20
 	lockdep_assert_irqs_enabled();
=20
@@ -1209,25 +1089,12 @@ int native_cpu_up(unsigned int cpu, struct task_struc=
t *tidle)
 		return -EINVAL;
 	}
=20
-	/*
-	 * Already booted CPU?
-	 */
-	if (cpumask_test_cpu(cpu, cpu_callin_mask)) {
-		pr_debug("do_boot_cpu %d Already started\n", cpu);
-		return -ENOSYS;
-	}
-
 	/*
 	 * Save current MTRR state in case it was changed since early boot
 	 * (e.g. by the ACPI SMI) to initialize new CPUs with MTRRs in sync:
 	 */
 	mtrr_save_state();
=20
-	/* x86 CPUs take themselves offline, so delayed offline is OK. */
-	err =3D cpu_check_up_prepare(cpu);
-	if (err && err !=3D -EBUSY)
-		return err;
-
 	/* the FPU context is blank, nobody can own it */
 	per_cpu(fpu_fpregs_owner_ctx, cpu) =3D NULL;
=20
@@ -1235,41 +1102,44 @@ int native_cpu_up(unsigned int cpu, struct task_struc=
t *tidle)
 	if (err)
 		return err;
=20
-	err =3D do_boot_cpu(apicid, cpu, tidle, &cpu0_nmi_registered);
-	if (err) {
+	err =3D do_boot_cpu(apicid, cpu, tidle);
+	if (err)
 		pr_err("do_boot_cpu failed(%d) to wakeup CPU#%u\n", err, cpu);
-		ret =3D -EIO;
-		goto unreg_nmi;
-	}
=20
-	/*
-	 * Check TSC synchronization with the AP (keep irqs disabled
-	 * while doing so):
-	 */
-	local_irq_save(flags);
-	check_tsc_sync_source(cpu);
-	local_irq_restore(flags);
+	return err;
+}
=20
-	while (!cpu_online(cpu)) {
-		cpu_relax();
-		touch_nmi_watchdog();
-	}
+int arch_cpuhp_kick_ap_alive(unsigned int cpu, struct task_struct *tidle)
+{
+	return smp_ops.kick_ap_alive(cpu, tidle);
+}
=20
-unreg_nmi:
-	/*
-	 * Clean up the nmi handler. Do this after the callin and callout sync
-	 * to avoid impact of possible long unregister time.
-	 */
-	if (cpu0_nmi_registered)
-		unregister_nmi_handler(NMI_LOCAL, "wake_cpu0");
+void arch_cpuhp_cleanup_kick_cpu(unsigned int cpu)
+{
+	/* Cleanup possible dangling ends... */
+	if (smp_ops.kick_ap_alive =3D=3D native_kick_ap && x86_platform.legacy.warm=
_reset)
+		smpboot_restore_warm_reset_vector();
+}
=20
-	return ret;
+void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu)
+{
+	if (smp_ops.cleanup_dead_cpu)
+		smp_ops.cleanup_dead_cpu(cpu);
+
+	if (system_state =3D=3D SYSTEM_RUNNING)
+		pr_info("CPU %u is now offline\n", cpu);
+}
+
+void arch_cpuhp_sync_state_poll(void)
+{
+	if (smp_ops.poll_sync_state)
+		smp_ops.poll_sync_state();
 }
=20
 /**
- * arch_disable_smp_support() - disables SMP support for x86 at runtime
+ * arch_disable_smp_support() - Disables SMP support for x86 at boottime
  */
-void arch_disable_smp_support(void)
+void __init arch_disable_smp_support(void)
 {
 	disable_ioapic_support();
 }
@@ -1361,14 +1231,6 @@ static void __init smp_cpu_index_default(void)
 	}
 }
=20
-static void __init smp_get_logical_apicid(void)
-{
-	if (x2apic_mode)
-		cpu0_logical_apicid =3D apic_read(APIC_LDR);
-	else
-		cpu0_logical_apicid =3D GET_APIC_LOGICAL_ID(apic_read(APIC_LDR));
-}
-
 void __init smp_prepare_cpus_common(void)
 {
 	unsigned int i;
@@ -1379,7 +1241,6 @@ void __init smp_prepare_cpus_common(void)
 	 * Setup boot CPU information
 	 */
 	smp_store_boot_cpu_info(); /* Final full version of the data */
-	cpumask_copy(cpu_callin_mask, cpumask_of(0));
 	mb();
=20
 	for_each_possible_cpu(i) {
@@ -1402,6 +1263,21 @@ void __init smp_prepare_cpus_common(void)
 	set_cpu_sibling_map(0);
 }
=20
+#ifdef CONFIG_X86_64
+/* Establish whether parallel bringup can be supported. */
+bool __init arch_cpuhp_init_parallel_bringup(void)
+{
+	if (!x86_cpuinit.parallel_bringup) {
+		pr_info("Parallel CPU startup disabled by the platform\n");
+		return false;
+	}
+
+	smpboot_control =3D STARTUP_READ_APICID;
+	pr_debug("Parallel CPU startup enabled: 0x%08x\n", smpboot_control);
+	return true;
+}
+#endif
+
 /*
  * Prepare for SMP bootup.
  * @max_cpus: configured maximum number of CPUs, It is a legacy parameter
@@ -1431,8 +1307,6 @@ void __init native_smp_prepare_cpus(unsigned int max_cp=
us)
 	/* Setup local timer */
 	x86_init.timers.setup_percpu_clockev();
=20
-	smp_get_logical_apicid();
-
 	pr_info("CPU0: ");
 	print_cpu_info(&cpu_data(0));
=20
@@ -1466,9 +1340,6 @@ void __init native_smp_prepare_boot_cpu(void)
 	if (!IS_ENABLED(CONFIG_SMP))
 		switch_gdt_and_percpu_base(me);
=20
-	/* already set me in cpu_online_mask in boot_cpu_init() */
-	cpumask_set_cpu(me, cpu_callout_mask);
-	cpu_set_state_online(me);
 	native_pv_lock_init();
 }
=20
@@ -1592,6 +1463,12 @@ __init void prefill_possible_map(void)
 		set_cpu_possible(i, true);
 }
=20
+/* correctly size the local cpu masks */
+void __init setup_cpu_local_masks(void)
+{
+	alloc_bootmem_cpumask_var(&cpu_sibling_setup_mask);
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
=20
 /* Recompute SMT state for all CPUs on offline */
@@ -1650,10 +1527,6 @@ static void remove_siblinginfo(int cpu)
 static void remove_cpu_from_maps(int cpu)
 {
 	set_cpu_online(cpu, false);
-	cpumask_clear_cpu(cpu, cpu_callout_mask);
-	cpumask_clear_cpu(cpu, cpu_callin_mask);
-	/* was set by cpu_init() */
-	cpumask_clear_cpu(cpu, cpu_initialized_mask);
 	numa_remove_cpu(cpu);
 }
=20
@@ -1704,54 +1577,17 @@ int native_cpu_disable(void)
 	return 0;
 }
=20
-int common_cpu_die(unsigned int cpu)
-{
-	int ret =3D 0;
-
-	/* We don't do anything here: idle task is faking death itself. */
-
-	/* They ack this in play_dead() by setting CPU_DEAD */
-	if (cpu_wait_death(cpu, 5)) {
-		if (system_state =3D=3D SYSTEM_RUNNING)
-			pr_info("CPU %u is now offline\n", cpu);
-	} else {
-		pr_err("CPU %u didn't die...\n", cpu);
-		ret =3D -1;
-	}
-
-	return ret;
-}
-
-void native_cpu_die(unsigned int cpu)
-{
-	common_cpu_die(cpu);
-}
-
 void play_dead_common(void)
 {
 	idle_task_exit();
=20
-	/* Ack it */
-	(void)cpu_report_death();
-
+	cpuhp_ap_report_dead();
 	/*
 	 * With physical CPU hotplug, we should halt the cpu
 	 */
 	local_irq_disable();
 }
=20
-/**
- * cond_wakeup_cpu0 - Wake up CPU0 if needed.
- *
- * If NMI wants to wake up CPU0, start CPU0.
- */
-void cond_wakeup_cpu0(void)
-{
-	if (smp_processor_id() =3D=3D 0 && enable_start_cpu0)
-		start_cpu0();
-}
-EXPORT_SYMBOL_GPL(cond_wakeup_cpu0);
-
 /*
  * We need to flush the caches before going to sleep, lest we have
  * dirty data in our caches when we come back up.
@@ -1819,8 +1655,6 @@ static inline void mwait_play_dead(void)
 		__monitor(mwait_ptr, 0, 0);
 		mb();
 		__mwait(eax, 0);
-
-		cond_wakeup_cpu0();
 	}
 }
=20
@@ -1829,11 +1663,8 @@ void __noreturn hlt_play_dead(void)
 	if (__this_cpu_read(cpu_info.x86) >=3D 4)
 		wbinvd();
=20
-	while (1) {
+	while (1)
 		native_halt();
-
-		cond_wakeup_cpu0();
-	}
 }
=20
 void native_play_dead(void)
@@ -1852,12 +1683,6 @@ int native_cpu_disable(void)
 	return -ENOSYS;
 }
=20
-void native_cpu_die(unsigned int cpu)
-{
-	/* We said "no" in __cpu_disable */
-	BUG();
-}
-
 void native_play_dead(void)
 {
 	BUG();
diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
index 1b83377274b8..ca004e2e4469 100644
--- a/arch/x86/kernel/topology.c
+++ b/arch/x86/kernel/topology.c
@@ -38,102 +38,12 @@
 static DEFINE_PER_CPU(struct x86_cpu, cpu_devices);
=20
 #ifdef CONFIG_HOTPLUG_CPU
-
-#ifdef CONFIG_BOOTPARAM_HOTPLUG_CPU0
-static int cpu0_hotpluggable =3D 1;
-#else
-static int cpu0_hotpluggable;
-static int __init enable_cpu0_hotplug(char *str)
-{
-	cpu0_hotpluggable =3D 1;
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
+int arch_register_cpu(int cpu)
 {
-	int ret;
-
-	if (!cpu_is_hotpluggable(cpu))
-		return -EINVAL;
+	struct x86_cpu *xc =3D per_cpu_ptr(&cpu_devices, cpu);
=20
-	switch (action) {
-	case 0:
-		ret =3D remove_cpu(cpu);
-		if (!ret)
-			pr_info("DEBUG_HOTPLUG_CPU0: CPU %u is now offline\n", cpu);
-		else
-			pr_debug("Can't offline CPU%d.\n", cpu);
-		break;
-	case 1:
-		ret =3D add_cpu(cpu);
-		if (ret)
-			pr_debug("Can't online CPU%d.\n", cpu);
-
-		break;
-	default:
-		ret =3D -EINVAL;
-	}
-
-	return ret;
-}
-
-static int __init debug_hotplug_cpu(void)
-{
-	_debug_hotplug_cpu(0, 0);
-	return 0;
-}
-
-late_initcall_sync(debug_hotplug_cpu);
-#endif /* CONFIG_DEBUG_HOTPLUG_CPU0 */
-
-int arch_register_cpu(int num)
-{
-	struct cpuinfo_x86 *c =3D &cpu_data(num);
-
-	/*
-	 * Currently CPU0 is only hotpluggable on Intel platforms. Other
-	 * vendors can add hotplug support later.
-	 * Xen PV guests don't support CPU0 hotplug at all.
-	 */
-	if (c->x86_vendor !=3D X86_VENDOR_INTEL ||
-	    cpu_feature_enabled(X86_FEATURE_XENPV))
-		cpu0_hotpluggable =3D 0;
-
-	/*
-	 * Two known BSP/CPU0 dependencies: Resume from suspend/hibernate
-	 * depends on BSP. PIC interrupts depend on BSP.
-	 *
-	 * If the BSP dependencies are under control, one can tell kernel to
-	 * enable BSP hotplug. This basically adds a control file and
-	 * one can attempt to offline BSP.
-	 */
-	if (num =3D=3D 0 && cpu0_hotpluggable) {
-		unsigned int irq;
-		/*
-		 * We won't take down the boot processor on i386 if some
-		 * interrupts only are able to be serviced by the BSP in PIC.
-		 */
-		for_each_active_irq(irq) {
-			if (!IO_APIC_IRQ(irq) && irq_has_action(irq)) {
-				cpu0_hotpluggable =3D 0;
-				break;
-			}
-		}
-	}
-	if (num || cpu0_hotpluggable)
-		per_cpu(cpu_devices, num).cpu.hotpluggable =3D 1;
-
-	return register_cpu(&per_cpu(cpu_devices, num).cpu, num);
+	xc->cpu.hotpluggable =3D cpu > 0;
+	return register_cpu(&xc->cpu, cpu);
 }
 EXPORT_SYMBOL(arch_register_cpu);
=20
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 344698852146..1412b771651e 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1598,10 +1598,7 @@ void __init tsc_init(void)
=20
 #ifdef CONFIG_SMP
 /*
- * If we have a constant TSC and are using the TSC for the delay loop,
- * we can skip clock calibration if another cpu in the same socket has alrea=
dy
- * been calibrated. This assumes that CONSTANT_TSC applies to all
- * cpus in the socket - this should be a safe assumption.
+ * Check whether existing calibration data can be reused.
  */
 unsigned long calibrate_delay_is_known(void)
 {
@@ -1609,6 +1606,21 @@ unsigned long calibrate_delay_is_known(void)
 	int constant_tsc =3D cpu_has(&cpu_data(cpu), X86_FEATURE_CONSTANT_TSC);
 	const struct cpumask *mask =3D topology_core_cpumask(cpu);
=20
+	/*
+	 * If TSC has constant frequency and TSC is synchronized across
+	 * sockets then reuse CPU0 calibration.
+	 */
+	if (constant_tsc && !tsc_unstable)
+		return cpu_data(0).loops_per_jiffy;
+
+	/*
+	 * If TSC has constant frequency and TSC is not synchronized across
+	 * sockets and this is not the first CPU in the socket, then reuse
+	 * the calibration value of an already online CPU on that socket.
+	 *
+	 * This assumes that CONSTANT_TSC is consistent for all CPUs in a
+	 * socket.
+	 */
 	if (!constant_tsc || !mask)
 		return 0;
=20
diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index 9452dc9664b5..bbc440c93e08 100644
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -245,7 +245,6 @@ bool tsc_store_and_check_tsc_adjust(bool bootcpu)
  */
 static atomic_t start_count;
 static atomic_t stop_count;
-static atomic_t skip_test;
 static atomic_t test_runs;
=20
 /*
@@ -344,20 +343,13 @@ static inline unsigned int loop_timeout(int cpu)
 }
=20
 /*
- * Source CPU calls into this - it waits for the freshly booted
- * target CPU to arrive and then starts the measurement:
+ * The freshly booted CPU initiates this via an async SMP function call.
  */
-void check_tsc_sync_source(int cpu)
+static void check_tsc_sync_source(void *__cpu)
 {
+	unsigned int cpu =3D (unsigned long)__cpu;
 	int cpus =3D 2;
=20
-	/*
-	 * No need to check if we already know that the TSC is not
-	 * synchronized or if we have no TSC.
-	 */
-	if (unsynchronized_tsc())
-		return;
-
 	/*
 	 * Set the maximum number of test runs to
 	 *  1 if the CPU does not provide the TSC_ADJUST MSR
@@ -368,16 +360,9 @@ void check_tsc_sync_source(int cpu)
 	else
 		atomic_set(&test_runs, 3);
 retry:
-	/*
-	 * Wait for the target to start or to skip the test:
-	 */
-	while (atomic_read(&start_count) !=3D cpus - 1) {
-		if (atomic_read(&skip_test) > 0) {
-			atomic_set(&skip_test, 0);
-			return;
-		}
+	/* Wait for the target to start. */
+	while (atomic_read(&start_count) !=3D cpus - 1)
 		cpu_relax();
-	}
=20
 	/*
 	 * Trigger the target to continue into the measurement too:
@@ -397,14 +382,14 @@ void check_tsc_sync_source(int cpu)
 	if (!nr_warps) {
 		atomic_set(&test_runs, 0);
=20
-		pr_debug("TSC synchronization [CPU#%d -> CPU#%d]: passed\n",
+		pr_debug("TSC synchronization [CPU#%d -> CPU#%u]: passed\n",
 			smp_processor_id(), cpu);
=20
 	} else if (atomic_dec_and_test(&test_runs) || random_warps) {
 		/* Force it to 0 if random warps brought us here */
 		atomic_set(&test_runs, 0);
=20
-		pr_warn("TSC synchronization [CPU#%d -> CPU#%d]:\n",
+		pr_warn("TSC synchronization [CPU#%d -> CPU#%u]:\n",
 			smp_processor_id(), cpu);
 		pr_warn("Measured %Ld cycles TSC warp between CPUs, "
 			"turning off TSC clock.\n", max_warp);
@@ -457,11 +442,12 @@ void check_tsc_sync_target(void)
 	 * SoCs the TSC is frequency synchronized, but still the TSC ADJUST
 	 * register might have been wreckaged by the BIOS..
 	 */
-	if (tsc_store_and_check_tsc_adjust(false) || tsc_clocksource_reliable) {
-		atomic_inc(&skip_test);
+	if (tsc_store_and_check_tsc_adjust(false) || tsc_clocksource_reliable)
 		return;
-	}
=20
+	/* Kick the control CPU into the TSC synchronization function */
+	smp_call_function_single(cpumask_first(cpu_online_mask), check_tsc_sync_sou=
rce,
+				 (unsigned long *)(unsigned long)cpu, 0);
 retry:
 	/*
 	 * Register this CPU's participation and wait for the
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index d82f4fa2f1bf..1da4baa34d1b 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -126,6 +126,7 @@ struct x86_init_ops x86_init __initdata =3D {
 struct x86_cpuinit_ops x86_cpuinit =3D {
 	.early_percpu_clock_init	=3D x86_init_noop,
 	.setup_percpu_clockev		=3D setup_secondary_APIC_clock,
+	.parallel_bringup		=3D true,
 };
=20
 static void default_nmi_init(void) { };
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index e0b51c09109f..4855e5f92970 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -501,6 +501,21 @@ void __init sme_early_init(void)
 	x86_platform.guest.enc_status_change_finish  =3D amd_enc_status_change_fini=
sh;
 	x86_platform.guest.enc_tlb_flush_required    =3D amd_enc_tlb_flush_required;
 	x86_platform.guest.enc_cache_flush_required  =3D amd_enc_cache_flush_requir=
ed;
+
+	/*
+	 * AMD-SEV-ES intercepts the RDMSR to read the X2APIC ID in the
+	 * parallel bringup low level code. That raises #VC which cannot be
+	 * handled there.
+	 * It does not provide a RDMSR GHCB protocol so the early startup
+	 * code cannot directly communicate with the secure firmware. The
+	 * alternative solution to retrieve the APIC ID via CPUID(0xb),
+	 * which is covered by the GHCB protocol, is not viable either
+	 * because there is no enforcement of the CPUID(0xb) provided
+	 * "initial" APIC ID to be the same as the real APIC ID.
+	 * Disable parallel bootup.
+	 */
+	if (sev_status & MSR_AMD64_SEV_ES_ENABLED)
+		x86_cpuinit.parallel_bringup =3D false;
 }
=20
 void __init mem_encrypt_free_decrypted_mem(void)
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 7a4d5e911415..63230ff8cf4f 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -351,43 +351,6 @@ static int bsp_pm_callback(struct notifier_block *nb, un=
signed long action,
 	case PM_HIBERNATION_PREPARE:
 		ret =3D bsp_check();
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
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index af565816d2ba..788e5559549f 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -154,6 +154,9 @@ static void __init setup_real_mode(void)
=20
 	trampoline_header->flags =3D 0;
=20
+	trampoline_lock =3D &trampoline_header->lock;
+	*trampoline_lock =3D 0;
+
 	trampoline_pgd =3D (u64 *) __va(real_mode_header->trampoline_pgd);
=20
 	/* Map the real mode stub as virtual =3D=3D physical */
diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/tram=
poline_64.S
index e38d61d6562e..c9f76fae902e 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -37,6 +37,24 @@
 	.text
 	.code16
=20
+.macro LOCK_AND_LOAD_REALMODE_ESP lock_pa=3D0
+	/*
+	 * Make sure only one CPU fiddles with the realmode stack
+	 */
+.Llock_rm\@:
+	.if \lock_pa
+        lock btsl       $0, pa_tr_lock
+	.else
+        lock btsl       $0, tr_lock
+	.endif
+        jnc             2f
+        pause
+        jmp             .Llock_rm\@
+2:
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
=20
-	# Setup stack
-	movl	$rm_stack_end, %esp
+	LOCK_AND_LOAD_REALMODE_ESP
=20
 	call	verify_cpu		# Verify the cpu supports long mode
 	testl   %eax, %eax		# Check for return code
@@ -93,8 +110,7 @@ SYM_CODE_START(sev_es_trampoline_start)
 	mov	%ax, %es
 	mov	%ax, %ss
=20
-	# Setup stack
-	movl	$rm_stack_end, %esp
+	LOCK_AND_LOAD_REALMODE_ESP
=20
 	jmp	.Lswitch_to_protected
 SYM_CODE_END(sev_es_trampoline_start)
@@ -177,7 +193,7 @@ SYM_CODE_START(pa_trampoline_compat)
 	 * In compatibility mode.  Prep ESP and DX for startup_32, then disable
 	 * paging and complete the switch to legacy 32-bit mode.
 	 */
-	movl	$rm_stack_end, %esp
+	LOCK_AND_LOAD_REALMODE_ESP lock_pa=3D1
 	movw	$__KERNEL_DS, %dx
=20
 	movl	$(CR0_STATE & ~X86_CR0_PG), %eax
@@ -241,6 +257,7 @@ SYM_DATA_START(trampoline_header)
 	SYM_DATA(tr_efer,		.space 8)
 	SYM_DATA(tr_cr4,		.space 4)
 	SYM_DATA(tr_flags,		.space 4)
+	SYM_DATA(tr_lock,		.space 4)
 SYM_DATA_END(trampoline_header)
=20
 #include "trampoline_common.S"
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index c1cd28e915a3..a6820ca940bf 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -161,13 +161,12 @@ static int xen_cpu_up_prepare_hvm(unsigned int cpu)
 	int rc =3D 0;
=20
 	/*
-	 * This can happen if CPU was offlined earlier and
-	 * offlining timed out in common_cpu_die().
+	 * If a CPU was offlined earlier and offlining timed out then the
+	 * lock mechanism is still initialized. Uninit it unconditionally
+	 * as it's safe to call even if already uninited. Interrupts and
+	 * timer have already been handled in xen_cpu_dead_hvm().
 	 */
-	if (cpu_report_state(cpu) =3D=3D CPU_DEAD_FROZEN) {
-		xen_smp_intr_free(cpu);
-		xen_uninit_lock_cpu(cpu);
-	}
+	xen_uninit_lock_cpu(cpu);
=20
 	if (cpu_acpi_id(cpu) !=3D U32_MAX)
 		per_cpu(xen_vcpu_id, cpu) =3D cpu_acpi_id(cpu);
diff --git a/arch/x86/xen/smp_hvm.c b/arch/x86/xen/smp_hvm.c
index b70afdff419c..ac95d1981cc0 100644
--- a/arch/x86/xen/smp_hvm.c
+++ b/arch/x86/xen/smp_hvm.c
@@ -55,18 +55,16 @@ static void __init xen_hvm_smp_prepare_cpus(unsigned int =
max_cpus)
 }
=20
 #ifdef CONFIG_HOTPLUG_CPU
-static void xen_hvm_cpu_die(unsigned int cpu)
+static void xen_hvm_cleanup_dead_cpu(unsigned int cpu)
 {
-	if (common_cpu_die(cpu) =3D=3D 0) {
-		if (xen_have_vector_callback) {
-			xen_smp_intr_free(cpu);
-			xen_uninit_lock_cpu(cpu);
-			xen_teardown_timer(cpu);
-		}
+	if (xen_have_vector_callback) {
+		xen_smp_intr_free(cpu);
+		xen_uninit_lock_cpu(cpu);
+		xen_teardown_timer(cpu);
 	}
 }
 #else
-static void xen_hvm_cpu_die(unsigned int cpu)
+static void xen_hvm_cleanup_dead_cpu(unsigned int cpu)
 {
 	BUG();
 }
@@ -77,7 +75,7 @@ void __init xen_hvm_smp_init(void)
 	smp_ops.smp_prepare_boot_cpu =3D xen_hvm_smp_prepare_boot_cpu;
 	smp_ops.smp_prepare_cpus =3D xen_hvm_smp_prepare_cpus;
 	smp_ops.smp_cpus_done =3D xen_smp_cpus_done;
-	smp_ops.cpu_die =3D xen_hvm_cpu_die;
+	smp_ops.cleanup_dead_cpu =3D xen_hvm_cleanup_dead_cpu;
=20
 	if (!xen_have_vector_callback) {
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index a9cf8c8fa074..a92e8002b5cf 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -62,6 +62,7 @@ static void cpu_bringup(void)
 	int cpu;
=20
 	cr4_init();
+	cpuhp_ap_sync_alive();
 	cpu_init();
 	touch_softlockup_watchdog();
=20
@@ -83,7 +84,7 @@ static void cpu_bringup(void)
=20
 	set_cpu_online(cpu, true);
=20
-	cpu_set_state_online(cpu);  /* Implies full memory barrier. */
+	smp_mb();
=20
 	/* We can take interrupts now: we're officially "up". */
 	local_irq_enable();
@@ -254,15 +255,12 @@ cpu_initialize_context(unsigned int cpu, struct task_st=
ruct *idle)
 	struct desc_struct *gdt;
 	unsigned long gdt_mfn;
=20
-	/* used to tell cpu_init() that it can proceed with initialization */
-	cpumask_set_cpu(cpu, cpu_callout_mask);
 	if (cpumask_test_and_set_cpu(cpu, xen_cpu_initialized_map))
 		return 0;
=20
 	ctxt =3D kzalloc(sizeof(*ctxt), GFP_KERNEL);
 	if (ctxt =3D=3D NULL) {
 		cpumask_clear_cpu(cpu, xen_cpu_initialized_map);
-		cpumask_clear_cpu(cpu, cpu_callout_mask);
 		return -ENOMEM;
 	}
=20
@@ -316,7 +314,7 @@ cpu_initialize_context(unsigned int cpu, struct task_stru=
ct *idle)
 	return 0;
 }
=20
-static int xen_pv_cpu_up(unsigned int cpu, struct task_struct *idle)
+static int xen_pv_kick_ap(unsigned int cpu, struct task_struct *idle)
 {
 	int rc;
=20
@@ -326,14 +324,6 @@ static int xen_pv_cpu_up(unsigned int cpu, struct task_s=
truct *idle)
=20
 	xen_setup_runstate_info(cpu);
=20
-	/*
-	 * PV VCPUs are always successfully taken down (see 'while' loop
-	 * in xen_cpu_die()), so -EBUSY is an error.
-	 */
-	rc =3D cpu_check_up_prepare(cpu);
-	if (rc)
-		return rc;
-
 	/* make sure interrupts start blocked */
 	per_cpu(xen_vcpu, cpu)->evtchn_upcall_mask =3D 1;
=20
@@ -343,15 +333,20 @@ static int xen_pv_cpu_up(unsigned int cpu, struct task_=
struct *idle)
=20
 	xen_pmu_init(cpu);
=20
-	rc =3D HYPERVISOR_vcpu_op(VCPUOP_up, xen_vcpu_nr(cpu), NULL);
-	BUG_ON(rc);
-
-	while (cpu_report_state(cpu) !=3D CPU_ONLINE)
-		HYPERVISOR_sched_op(SCHEDOP_yield, NULL);
+	/*
+	 * Why is this a BUG? If the hypercall fails then everything can be
+	 * rolled back, no?
+	 */
+	BUG_ON(HYPERVISOR_vcpu_op(VCPUOP_up, xen_vcpu_nr(cpu), NULL));
=20
 	return 0;
 }
=20
+static void xen_pv_poll_sync_state(void)
+{
+	HYPERVISOR_sched_op(SCHEDOP_yield, NULL);
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 static int xen_pv_cpu_disable(void)
 {
@@ -367,18 +362,18 @@ static int xen_pv_cpu_disable(void)
=20
 static void xen_pv_cpu_die(unsigned int cpu)
 {
-	while (HYPERVISOR_vcpu_op(VCPUOP_is_up,
-				  xen_vcpu_nr(cpu), NULL)) {
+	while (HYPERVISOR_vcpu_op(VCPUOP_is_up, xen_vcpu_nr(cpu), NULL)) {
 		__set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(HZ/10);
 	}
+}
=20
-	if (common_cpu_die(cpu) =3D=3D 0) {
-		xen_smp_intr_free(cpu);
-		xen_uninit_lock_cpu(cpu);
-		xen_teardown_timer(cpu);
-		xen_pmu_finish(cpu);
-	}
+static void xen_pv_cleanup_dead_cpu(unsigned int cpu)
+{
+	xen_smp_intr_free(cpu);
+	xen_uninit_lock_cpu(cpu);
+	xen_teardown_timer(cpu);
+	xen_pmu_finish(cpu);
 }
=20
 static void __noreturn xen_pv_play_dead(void) /* used only with HOTPLUG_CPU =
*/
@@ -400,6 +395,11 @@ static void xen_pv_cpu_die(unsigned int cpu)
 	BUG();
 }
=20
+static void xen_pv_cleanup_dead_cpu(unsigned int cpu)
+{
+	BUG();
+}
+
 static void __noreturn xen_pv_play_dead(void)
 {
 	BUG();
@@ -438,8 +438,10 @@ static const struct smp_ops xen_smp_ops __initconst =3D {
 	.smp_prepare_cpus =3D xen_pv_smp_prepare_cpus,
 	.smp_cpus_done =3D xen_smp_cpus_done,
=20
-	.cpu_up =3D xen_pv_cpu_up,
+	.kick_ap_alive =3D xen_pv_kick_ap,
 	.cpu_die =3D xen_pv_cpu_die,
+	.cleanup_dead_cpu =3D xen_pv_cleanup_dead_cpu,
+	.poll_sync_state =3D xen_pv_poll_sync_state,
 	.cpu_disable =3D xen_pv_cpu_disable,
 	.play_dead =3D xen_pv_play_dead,
=20
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 9718d07cc2a2..dc615ef6550a 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -597,10 +597,6 @@ static int acpi_idle_play_dead(struct cpuidle_device *de=
v, int index)
 			io_idle(cx->address);
 		} else
 			return -ENODEV;
-
-#if defined(CONFIG_X86) && defined(CONFIG_HOTPLUG_CPU)
-		cond_wakeup_cpu0();
-#endif
 	}
=20
 	/* Never reached */
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 8582a7142623..d321dbd53405 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -184,8 +184,6 @@ void arch_cpu_idle_enter(void);
 void arch_cpu_idle_exit(void);
 void __noreturn arch_cpu_idle_dead(void);
=20
-int cpu_report_state(int cpu);
-int cpu_check_up_prepare(int cpu);
 void cpu_set_state_online(int cpu);
 void play_idle_precise(u64 duration_ns, u64 latency_ns);
=20
@@ -195,8 +193,6 @@ static inline void play_idle(unsigned long duration_us)
 }
=20
 #ifdef CONFIG_HOTPLUG_CPU
-bool cpu_wait_death(unsigned int cpu, int seconds);
-bool cpu_report_death(void);
 void cpuhp_report_idle_dead(void);
 #else
 static inline void cpuhp_report_idle_dead(void) { }
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 0f1001dca0e0..a5e414cd82be 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -133,6 +133,7 @@ enum cpuhp_state {
 	CPUHP_MIPS_SOC_PREPARE,
 	CPUHP_BP_PREPARE_DYN,
 	CPUHP_BP_PREPARE_DYN_END		=3D CPUHP_BP_PREPARE_DYN + 20,
+	CPUHP_BP_KICK_AP,
 	CPUHP_BRINGUP_CPU,
=20
 	/*
@@ -517,4 +518,20 @@ void cpuhp_online_idle(enum cpuhp_state state);
 static inline void cpuhp_online_idle(enum cpuhp_state state) { }
 #endif
=20
+struct task_struct;
+
+void cpuhp_ap_sync_alive(void);
+void arch_cpuhp_sync_state_poll(void);
+void arch_cpuhp_cleanup_kick_cpu(unsigned int cpu);
+int arch_cpuhp_kick_ap_alive(unsigned int cpu, struct task_struct *tidle);
+bool arch_cpuhp_init_parallel_bringup(void);
+
+#ifdef CONFIG_HOTPLUG_CORE_SYNC_DEAD
+void cpuhp_ap_report_dead(void);
+void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu);
+#else
+static inline void cpuhp_ap_report_dead(void) { }
+static inline void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu) { }
+#endif
+
 #endif
diff --git a/include/trace/events/csd.h b/include/trace/events/csd.h
new file mode 100644
index 000000000000..67e9d01f80c2
--- /dev/null
+++ b/include/trace/events/csd.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM csd
+
+#if !defined(_TRACE_CSD_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_CSD_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(csd_queue_cpu,
+
+	TP_PROTO(const unsigned int cpu,
+		unsigned long callsite,
+		smp_call_func_t func,
+		struct __call_single_data *csd),
+
+	TP_ARGS(cpu, callsite, func, csd),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, cpu)
+		__field(void *, callsite)
+		__field(void *, func)
+		__field(void *, csd)
+		),
+
+	    TP_fast_assign(
+		__entry->cpu =3D cpu;
+		__entry->callsite =3D (void *)callsite;
+		__entry->func =3D func;
+		__entry->csd  =3D csd;
+		),
+
+	TP_printk("cpu=3D%u callsite=3D%pS func=3D%ps csd=3D%p",
+		__entry->cpu, __entry->callsite, __entry->func, __entry->csd)
+	);
+
+/*
+ * Tracepoints for a function which is called as an effect of smp_call_funct=
ion.*
+ */
+DECLARE_EVENT_CLASS(csd_function,
+
+	TP_PROTO(smp_call_func_t func, struct __call_single_data *csd),
+
+	TP_ARGS(func, csd),
+
+	TP_STRUCT__entry(
+		__field(void *,	func)
+		__field(void *,	csd)
+	),
+
+	TP_fast_assign(
+		__entry->func	=3D func;
+		__entry->csd	=3D csd;
+	),
+
+	TP_printk("func=3D%ps, csd=3D%p", __entry->func, __entry->csd)
+);
+
+DEFINE_EVENT(csd_function, csd_function_entry,
+	TP_PROTO(smp_call_func_t func, struct __call_single_data *csd),
+	TP_ARGS(func, csd)
+);
+
+DEFINE_EVENT(csd_function, csd_function_exit,
+	TP_PROTO(smp_call_func_t func, struct __call_single_data *csd),
+	TP_ARGS(func, csd)
+);
+
+#endif /* _TRACE_CSD_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/cpu.c b/kernel/cpu.c
index f4a2c5845bcb..88a7ede322bd 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -17,6 +17,7 @@
 #include <linux/cpu.h>
 #include <linux/oom.h>
 #include <linux/rcupdate.h>
+#include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/bug.h>
 #include <linux/kthread.h>
@@ -59,6 +60,7 @@
  * @last:	For multi-instance rollback, remember how far we got
  * @cb_state:	The state for a single callback (install/uninstall)
  * @result:	Result of the operation
+ * @ap_sync_state:	State for AP synchronization
  * @done_up:	Signal completion to the issuer of the task for cpu-up
  * @done_down:	Signal completion to the issuer of the task for cpu-down
  */
@@ -76,6 +78,7 @@ struct cpuhp_cpu_state {
 	struct hlist_node	*last;
 	enum cpuhp_state	cb_state;
 	int			result;
+	atomic_t		ap_sync_state;
 	struct completion	done_up;
 	struct completion	done_down;
 #endif
@@ -276,6 +279,182 @@ static bool cpuhp_is_atomic_state(enum cpuhp_state stat=
e)
 	return CPUHP_AP_IDLE_DEAD <=3D state && state < CPUHP_AP_ONLINE;
 }
=20
+/* Synchronization state management */
+enum cpuhp_sync_state {
+	SYNC_STATE_DEAD,
+	SYNC_STATE_KICKED,
+	SYNC_STATE_SHOULD_DIE,
+	SYNC_STATE_ALIVE,
+	SYNC_STATE_SHOULD_ONLINE,
+	SYNC_STATE_ONLINE,
+};
+
+#ifdef CONFIG_HOTPLUG_CORE_SYNC
+/**
+ * cpuhp_ap_update_sync_state - Update synchronization state during bringup/=
teardown
+ * @state:	The synchronization state to set
+ *
+ * No synchronization point. Just update of the synchronization state, but i=
mplies
+ * a full barrier so that the AP changes are visible before the control CPU =
proceeds.
+ */
+static inline void cpuhp_ap_update_sync_state(enum cpuhp_sync_state state)
+{
+	atomic_t *st =3D this_cpu_ptr(&cpuhp_state.ap_sync_state);
+
+	(void)atomic_xchg(st, state);
+}
+
+void __weak arch_cpuhp_sync_state_poll(void) { cpu_relax(); }
+
+static bool cpuhp_wait_for_sync_state(unsigned int cpu, enum cpuhp_sync_stat=
e state,
+				      enum cpuhp_sync_state next_state)
+{
+	atomic_t *st =3D per_cpu_ptr(&cpuhp_state.ap_sync_state, cpu);
+	ktime_t now, end, start =3D ktime_get();
+	int sync;
+
+	end =3D start + 10ULL * NSEC_PER_SEC;
+
+	sync =3D atomic_read(st);
+	while (1) {
+		if (sync =3D=3D state) {
+			if (!atomic_try_cmpxchg(st, &sync, next_state))
+				continue;
+			return true;
+		}
+
+		now =3D ktime_get();
+		if (now > end) {
+			/* Timeout. Leave the state unchanged */
+			return false;
+		} else if (now - start < NSEC_PER_MSEC) {
+			/* Poll for one millisecond */
+			arch_cpuhp_sync_state_poll();
+		} else {
+			usleep_range_state(USEC_PER_MSEC, 2 * USEC_PER_MSEC, TASK_UNINTERRUPTIBLE=
);
+		}
+		sync =3D atomic_read(st);
+	}
+	return true;
+}
+#else  /* CONFIG_HOTPLUG_CORE_SYNC */
+static inline void cpuhp_ap_update_sync_state(enum cpuhp_sync_state state) {=
 }
+#endif /* !CONFIG_HOTPLUG_CORE_SYNC */
+
+#ifdef CONFIG_HOTPLUG_CORE_SYNC_DEAD
+/**
+ * cpuhp_ap_report_dead - Update synchronization state to DEAD
+ *
+ * No synchronization point. Just update of the synchronization state.
+ */
+void cpuhp_ap_report_dead(void)
+{
+	cpuhp_ap_update_sync_state(SYNC_STATE_DEAD);
+}
+
+void __weak arch_cpuhp_cleanup_dead_cpu(unsigned int cpu) { }
+
+/*
+ * Late CPU shutdown synchronization point. Cannot use cpuhp_state::done_down
+ * because the AP cannot issue complete() at this stage.
+ */
+static void cpuhp_bp_sync_dead(unsigned int cpu)
+{
+	atomic_t *st =3D per_cpu_ptr(&cpuhp_state.ap_sync_state, cpu);
+	int sync =3D atomic_read(st);
+
+	do {
+		/* CPU can have reported dead already. Don't overwrite that! */
+		if (sync =3D=3D SYNC_STATE_DEAD)
+			break;
+	} while (!atomic_try_cmpxchg(st, &sync, SYNC_STATE_SHOULD_DIE));
+
+	if (cpuhp_wait_for_sync_state(cpu, SYNC_STATE_DEAD, SYNC_STATE_DEAD)) {
+		/* CPU reached dead state. Invoke the cleanup function */
+		arch_cpuhp_cleanup_dead_cpu(cpu);
+		return;
+	}
+
+	/* No further action possible. Emit message and give up. */
+	pr_err("CPU%u failed to report dead state\n", cpu);
+}
+#else /* CONFIG_HOTPLUG_CORE_SYNC_DEAD */
+static inline void cpuhp_bp_sync_dead(unsigned int cpu) { }
+#endif /* !CONFIG_HOTPLUG_CORE_SYNC_DEAD */
+
+#ifdef CONFIG_HOTPLUG_CORE_SYNC_FULL
+/**
+ * cpuhp_ap_sync_alive - Synchronize AP with the control CPU once it is alive
+ *
+ * Updates the AP synchronization state to SYNC_STATE_ALIVE and waits
+ * for the BP to release it.
+ */
+void cpuhp_ap_sync_alive(void)
+{
+	atomic_t *st =3D this_cpu_ptr(&cpuhp_state.ap_sync_state);
+
+	cpuhp_ap_update_sync_state(SYNC_STATE_ALIVE);
+
+	/* Wait for the control CPU to release it. */
+	while (atomic_read(st) !=3D SYNC_STATE_SHOULD_ONLINE)
+		cpu_relax();
+}
+
+static bool cpuhp_can_boot_ap(unsigned int cpu)
+{
+	atomic_t *st =3D per_cpu_ptr(&cpuhp_state.ap_sync_state, cpu);
+	int sync =3D atomic_read(st);
+
+again:
+	switch (sync) {
+	case SYNC_STATE_DEAD:
+		/* CPU is properly dead */
+		break;
+	case SYNC_STATE_KICKED:
+		/* CPU did not come up in previous attempt */
+		break;
+	case SYNC_STATE_ALIVE:
+		/* CPU is stuck cpuhp_ap_sync_alive(). */
+		break;
+	default:
+		/* CPU failed to report online or dead and is in limbo state. */
+		return false;
+	}
+
+	/* Prepare for booting */
+	if (!atomic_try_cmpxchg(st, &sync, SYNC_STATE_KICKED))
+		goto again;
+
+	return true;
+}
+
+void __weak arch_cpuhp_cleanup_kick_cpu(unsigned int cpu) { }
+
+/*
+ * Early CPU bringup synchronization point. Cannot use cpuhp_state::done_up
+ * because the AP cannot issue complete() so early in the bringup.
+ */
+static int cpuhp_bp_sync_alive(unsigned int cpu)
+{
+	int ret =3D 0;
+
+	if (!IS_ENABLED(CONFIG_HOTPLUG_CORE_SYNC_FULL))
+		return 0;
+
+	if (!cpuhp_wait_for_sync_state(cpu, SYNC_STATE_ALIVE, SYNC_STATE_SHOULD_ONL=
INE)) {
+		pr_err("CPU%u failed to report alive state\n", cpu);
+		ret =3D -EIO;
+	}
+
+	/* Let the architecture cleanup the kick alive mechanics. */
+	arch_cpuhp_cleanup_kick_cpu(cpu);
+	return ret;
+}
+#else /* CONFIG_HOTPLUG_CORE_SYNC_FULL */
+static inline int cpuhp_bp_sync_alive(unsigned int cpu) { return 0; }
+static inline bool cpuhp_can_boot_ap(unsigned int cpu) { return true; }
+#endif /* !CONFIG_HOTPLUG_CORE_SYNC_FULL */
+
 /* Serializes the updates to cpu_online_mask, cpu_present_mask */
 static DEFINE_MUTEX(cpu_add_remove_lock);
 bool cpuhp_tasks_frozen;
@@ -470,8 +649,23 @@ bool cpu_smt_possible(void)
 		cpu_smt_control !=3D CPU_SMT_NOT_SUPPORTED;
 }
 EXPORT_SYMBOL_GPL(cpu_smt_possible);
+
+static inline bool cpuhp_smt_aware(void)
+{
+	return topology_smt_supported();
+}
+
+static inline const struct cpumask *cpuhp_get_primary_thread_mask(void)
+{
+	return cpu_primary_thread_mask;
+}
 #else
 static inline bool cpu_smt_allowed(unsigned int cpu) { return true; }
+static inline bool cpuhp_smt_aware(void) { return false; }
+static inline const struct cpumask *cpuhp_get_primary_thread_mask(void)
+{
+	return cpu_present_mask;
+}
 #endif
=20
 static inline enum cpuhp_state
@@ -558,7 +752,7 @@ static int cpuhp_kick_ap(int cpu, struct cpuhp_cpu_state =
*st,
 	return ret;
 }
=20
-static int bringup_wait_for_ap(unsigned int cpu)
+static int bringup_wait_for_ap_online(unsigned int cpu)
 {
 	struct cpuhp_cpu_state *st =3D per_cpu_ptr(&cpuhp_state, cpu);
=20
@@ -579,38 +773,94 @@ static int bringup_wait_for_ap(unsigned int cpu)
 	 */
 	if (!cpu_smt_allowed(cpu))
 		return -ECANCELED;
+	return 0;
+}
+
+#ifdef CONFIG_HOTPLUG_SPLIT_STARTUP
+static int cpuhp_kick_ap_alive(unsigned int cpu)
+{
+	if (!cpuhp_can_boot_ap(cpu))
+		return -EAGAIN;
+
+	return arch_cpuhp_kick_ap_alive(cpu, idle_thread_get(cpu));
+}
+
+static int cpuhp_bringup_ap(unsigned int cpu)
+{
+	struct cpuhp_cpu_state *st =3D per_cpu_ptr(&cpuhp_state, cpu);
+	int ret;
+
+	/*
+	 * Some architectures have to walk the irq descriptors to
+	 * setup the vector space for the cpu which comes online.
+	 * Prevent irq alloc/free across the bringup.
+	 */
+	irq_lock_sparse();
+
+	ret =3D cpuhp_bp_sync_alive(cpu);
+	if (ret)
+		goto out_unlock;
+
+	ret =3D bringup_wait_for_ap_online(cpu);
+	if (ret)
+		goto out_unlock;
+
+	irq_unlock_sparse();
=20
 	if (st->target <=3D CPUHP_AP_ONLINE_IDLE)
 		return 0;
=20
 	return cpuhp_kick_ap(cpu, st, st->target);
-}
=20
+out_unlock:
+	irq_unlock_sparse();
+	return ret;
+}
+#else
 static int bringup_cpu(unsigned int cpu)
 {
+	struct cpuhp_cpu_state *st =3D per_cpu_ptr(&cpuhp_state, cpu);
 	struct task_struct *idle =3D idle_thread_get(cpu);
 	int ret;
=20
-	/*
-	 * Reset stale stack state from the last time this CPU was online.
-	 */
-	scs_task_reset(idle);
-	kasan_unpoison_task_stack(idle);
+	if (!cpuhp_can_boot_ap(cpu))
+		return -EAGAIN;
=20
 	/*
 	 * Some architectures have to walk the irq descriptors to
 	 * setup the vector space for the cpu which comes online.
-	 * Prevent irq alloc/free across the bringup.
+	 *
+	 * Prevent irq alloc/free across the bringup by acquiring the
+	 * sparse irq lock. Hold it until the upcoming CPU completes the
+	 * startup in cpuhp_online_idle() which allows to avoid
+	 * intermediate synchronization points in the architecture code.
 	 */
 	irq_lock_sparse();
=20
-	/* Arch-specific enabling code. */
 	ret =3D __cpu_up(cpu, idle);
-	irq_unlock_sparse();
 	if (ret)
-		return ret;
-	return bringup_wait_for_ap(cpu);
+		goto out_unlock;
+
+	ret =3D cpuhp_bp_sync_alive(cpu);
+	if (ret)
+		goto out_unlock;
+
+	ret =3D bringup_wait_for_ap_online(cpu);
+	if (ret)
+		goto out_unlock;
+
+	irq_unlock_sparse();
+
+	if (st->target <=3D CPUHP_AP_ONLINE_IDLE)
+		return 0;
+
+	return cpuhp_kick_ap(cpu, st, st->target);
+
+out_unlock:
+	irq_unlock_sparse();
+	return ret;
 }
+#endif
=20
 static int finish_cpu(unsigned int cpu)
 {
@@ -1099,6 +1349,8 @@ static int takedown_cpu(unsigned int cpu)
 	/* This actually kills the CPU. */
 	__cpu_die(cpu);
=20
+	cpuhp_bp_sync_dead(cpu);
+
 	tick_cleanup_dead_cpu(cpu);
 	rcutree_migrate_callbacks(cpu);
 	return 0;
@@ -1345,8 +1597,10 @@ void cpuhp_online_idle(enum cpuhp_state state)
 	if (state !=3D CPUHP_AP_ONLINE_IDLE)
 		return;
=20
+	cpuhp_ap_update_sync_state(SYNC_STATE_ONLINE);
+
 	/*
-	 * Unpart the stopper thread before we start the idle loop (and start
+	 * Unpark the stopper thread before we start the idle loop (and start
 	 * scheduling); this ensures the stopper task is always available.
 	 */
 	stop_machine_unpark(smp_processor_id());
@@ -1383,6 +1637,12 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen,=
 enum cpuhp_state target)
 			ret =3D PTR_ERR(idle);
 			goto out;
 		}
+
+		/*
+		 * Reset stale stack state from the last time this CPU was online.
+		 */
+		scs_task_reset(idle);
+		kasan_unpoison_task_stack(idle);
 	}
=20
 	cpuhp_tasks_frozen =3D tasks_frozen;
@@ -1502,18 +1762,96 @@ int bringup_hibernate_cpu(unsigned int sleep_cpu)
 	return 0;
 }
=20
-void bringup_nonboot_cpus(unsigned int setup_max_cpus)
+static void __init cpuhp_bringup_mask(const struct cpumask *mask, unsigned i=
nt ncpus,
+				      enum cpuhp_state target)
 {
 	unsigned int cpu;
=20
-	for_each_present_cpu(cpu) {
-		if (num_online_cpus() >=3D setup_max_cpus)
+	for_each_cpu(cpu, mask) {
+		struct cpuhp_cpu_state *st =3D per_cpu_ptr(&cpuhp_state, cpu);
+
+		if (cpu_up(cpu, target) && can_rollback_cpu(st)) {
+			/*
+			 * If this failed then cpu_up() might have only
+			 * rolled back to CPUHP_BP_KICK_AP for the final
+			 * online. Clean it up. NOOP if already rolled back.
+			 */
+			WARN_ON(cpuhp_invoke_callback_range(false, cpu, st, CPUHP_OFFLINE));
+		}
+
+		if (!--ncpus)
 			break;
-		if (!cpu_online(cpu))
-			cpu_up(cpu, CPUHP_ONLINE);
 	}
 }
=20
+#ifdef CONFIG_HOTPLUG_PARALLEL
+static bool __cpuhp_parallel_bringup __ro_after_init =3D true;
+
+static int __init parallel_bringup_parse_param(char *arg)
+{
+	return kstrtobool(arg, &__cpuhp_parallel_bringup);
+}
+early_param("cpuhp.parallel", parallel_bringup_parse_param);
+
+/*
+ * On architectures which have enabled parallel bringup this invokes all BP
+ * prepare states for each of the to be onlined APs first. The last state
+ * sends the startup IPI to the APs. The APs proceed through the low level
+ * bringup code in parallel and then wait for the control CPU to release
+ * them one by one for the final onlining procedure.
+ *
+ * This avoids waiting for each AP to respond to the startup IPI in
+ * CPUHP_BRINGUP_CPU.
+ */
+static bool __init cpuhp_bringup_cpus_parallel(unsigned int ncpus)
+{
+	const struct cpumask *mask =3D cpu_present_mask;
+
+	if (__cpuhp_parallel_bringup)
+		__cpuhp_parallel_bringup =3D arch_cpuhp_init_parallel_bringup();
+	if (!__cpuhp_parallel_bringup)
+		return false;
+
+	if (cpuhp_smt_aware()) {
+		const struct cpumask *pmask =3D cpuhp_get_primary_thread_mask();
+		static struct cpumask tmp_mask __initdata;
+
+		/*
+		 * X86 requires to prevent that SMT siblings stopped while
+		 * the primary thread does a microcode update for various
+		 * reasons. Bring the primary threads up first.
+		 */
+		cpumask_and(&tmp_mask, mask, pmask);
+		cpuhp_bringup_mask(&tmp_mask, ncpus, CPUHP_BP_KICK_AP);
+		cpuhp_bringup_mask(&tmp_mask, ncpus, CPUHP_ONLINE);
+		/* Account for the online CPUs */
+		ncpus -=3D num_online_cpus();
+		if (!ncpus)
+			return true;
+		/* Create the mask for secondary CPUs */
+		cpumask_andnot(&tmp_mask, mask, pmask);
+		mask =3D &tmp_mask;
+	}
+
+	/* Bring the not-yet started CPUs up */
+	cpuhp_bringup_mask(mask, ncpus, CPUHP_BP_KICK_AP);
+	cpuhp_bringup_mask(mask, ncpus, CPUHP_ONLINE);
+	return true;
+}
+#else
+static inline bool cpuhp_bringup_cpus_parallel(unsigned int ncpus) { return =
false; }
+#endif /* CONFIG_HOTPLUG_PARALLEL */
+
+void __init bringup_nonboot_cpus(unsigned int setup_max_cpus)
+{
+	/* Try parallel bringup optimization if enabled */
+	if (cpuhp_bringup_cpus_parallel(setup_max_cpus))
+		return;
+
+	/* Full per CPU serialized bringup */
+	cpuhp_bringup_mask(cpu_present_mask, setup_max_cpus, CPUHP_ONLINE);
+}
+
 #ifdef CONFIG_PM_SLEEP_SMP
 static cpumask_var_t frozen_cpus;
=20
@@ -1740,13 +2078,38 @@ static struct cpuhp_step cpuhp_hp_states[] =3D {
 		.startup.single		=3D timers_prepare_cpu,
 		.teardown.single	=3D timers_dead_cpu,
 	},
-	/* Kicks the plugged cpu into life */
+
+#ifdef CONFIG_HOTPLUG_SPLIT_STARTUP
+	/*
+	 * Kicks the AP alive. AP will wait in cpuhp_ap_sync_alive() until
+	 * the next step will release it.
+	 */
+	[CPUHP_BP_KICK_AP] =3D {
+		.name			=3D "cpu:kick_ap",
+		.startup.single		=3D cpuhp_kick_ap_alive,
+	},
+
+	/*
+	 * Waits for the AP to reach cpuhp_ap_sync_alive() and then
+	 * releases it for the complete bringup.
+	 */
+	[CPUHP_BRINGUP_CPU] =3D {
+		.name			=3D "cpu:bringup",
+		.startup.single		=3D cpuhp_bringup_ap,
+		.teardown.single	=3D finish_cpu,
+		.cant_stop		=3D true,
+	},
+#else
+	/*
+	 * All-in-one CPU bringup state which includes the kick alive.
+	 */
 	[CPUHP_BRINGUP_CPU] =3D {
 		.name			=3D "cpu:bringup",
 		.startup.single		=3D bringup_cpu,
 		.teardown.single	=3D finish_cpu,
 		.cant_stop		=3D true,
 	},
+#endif
 	/* Final state before CPU kills itself */
 	[CPUHP_AP_IDLE_DEAD] =3D {
 		.name			=3D "idle:dead",
@@ -2723,6 +3086,7 @@ void __init boot_cpu_hotplug_init(void)
 {
 #ifdef CONFIG_SMP
 	cpumask_set_cpu(smp_processor_id(), &cpus_booted_once_mask);
+	atomic_set(this_cpu_ptr(&cpuhp_state.ap_sync_state), SYNC_STATE_ONLINE);
 #endif
 	this_cpu_write(cpuhp_state.state, CPUHP_ONLINE);
 	this_cpu_write(cpuhp_state.target, CPUHP_ONLINE);
diff --git a/kernel/smp.c b/kernel/smp.c
index ab3e5dad6cfe..385179dae360 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -27,6 +27,9 @@
 #include <linux/jump_label.h>
=20
 #include <trace/events/ipi.h>
+#define CREATE_TRACE_POINTS
+#include <trace/events/csd.h>
+#undef CREATE_TRACE_POINTS
=20
 #include "smpboot.h"
 #include "sched/smp.h"
@@ -121,6 +124,14 @@ send_call_function_ipi_mask(struct cpumask *mask)
 	arch_send_call_function_ipi_mask(mask);
 }
=20
+static __always_inline void
+csd_do_func(smp_call_func_t func, void *info, struct __call_single_data *csd)
+{
+	trace_csd_function_entry(func, csd);
+	func(info);
+	trace_csd_function_exit(func, csd);
+}
+
 #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
=20
 static DEFINE_STATIC_KEY_MAYBE(CONFIG_CSD_LOCK_WAIT_DEBUG_DEFAULT, csdlock_d=
ebug_enabled);
@@ -329,7 +340,7 @@ void __smp_call_single_queue(int cpu, struct llist_node *=
node)
 	 * even if we haven't sent the smp_call IPI yet (e.g. the stopper
 	 * executes migration_cpu_stop() on the remote CPU).
 	 */
-	if (trace_ipi_send_cpu_enabled()) {
+	if (trace_csd_queue_cpu_enabled()) {
 		call_single_data_t *csd;
 		smp_call_func_t func;
=20
@@ -337,7 +348,7 @@ void __smp_call_single_queue(int cpu, struct llist_node *=
node)
 		func =3D CSD_TYPE(csd) =3D=3D CSD_TYPE_TTWU ?
 			sched_ttwu_pending : csd->func;
=20
-		trace_ipi_send_cpu(cpu, _RET_IP_, func);
+		trace_csd_queue_cpu(cpu, _RET_IP_, func, csd);
 	}
=20
 	/*
@@ -375,7 +386,7 @@ static int generic_exec_single(int cpu, struct __call_sin=
gle_data *csd)
 		csd_lock_record(csd);
 		csd_unlock(csd);
 		local_irq_save(flags);
-		func(info);
+		csd_do_func(func, info, NULL);
 		csd_lock_record(NULL);
 		local_irq_restore(flags);
 		return 0;
@@ -477,7 +488,7 @@ static void __flush_smp_call_function_queue(bool warn_cpu=
_offline)
 			}
=20
 			csd_lock_record(csd);
-			func(info);
+			csd_do_func(func, info, csd);
 			csd_unlock(csd);
 			csd_lock_record(NULL);
 		} else {
@@ -508,7 +519,7 @@ static void __flush_smp_call_function_queue(bool warn_cpu=
_offline)
=20
 				csd_lock_record(csd);
 				csd_unlock(csd);
-				func(info);
+				csd_do_func(func, info, csd);
 				csd_lock_record(NULL);
 			} else if (type =3D=3D CSD_TYPE_IRQ_WORK) {
 				irq_work_single(csd);
@@ -522,8 +533,10 @@ static void __flush_smp_call_function_queue(bool warn_cp=
u_offline)
 	/*
 	 * Third; only CSD_TYPE_TTWU is left, issue those.
 	 */
-	if (entry)
-		sched_ttwu_pending(entry);
+	if (entry) {
+		csd =3D llist_entry(entry, typeof(*csd), node.llist);
+		csd_do_func(sched_ttwu_pending, entry, csd);
+	}
 }
=20
=20
@@ -728,7 +741,7 @@ static void smp_call_function_many_cond(const struct cpum=
ask *mask,
 	int cpu, last_cpu, this_cpu =3D smp_processor_id();
 	struct call_function_data *cfd;
 	bool wait =3D scf_flags & SCF_WAIT;
-	int nr_cpus =3D 0, nr_queued =3D 0;
+	int nr_cpus =3D 0;
 	bool run_remote =3D false;
 	bool run_local =3D false;
=20
@@ -786,21 +799,15 @@ static void smp_call_function_many_cond(const struct cp=
umask *mask,
 			csd->node.src =3D smp_processor_id();
 			csd->node.dst =3D cpu;
 #endif
+			trace_csd_queue_cpu(cpu, _RET_IP_, func, csd);
+
 			if (llist_add(&csd->node.llist, &per_cpu(call_single_queue, cpu))) {
 				__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
 				nr_cpus++;
 				last_cpu =3D cpu;
 			}
-			nr_queued++;
 		}
=20
-		/*
-		 * Trace each smp_function_call_*() as an IPI, actual IPIs
-		 * will be traced with func=3D=3Dgeneric_smp_call_function_single_ipi().
-		 */
-		if (nr_queued)
-			trace_ipi_send_cpumask(cfd->cpumask, _RET_IP_, func);
-
 		/*
 		 * Choose the most efficient way to send an IPI. Note that the
 		 * number of CPUs might be zero due to concurrent changes to the
@@ -816,7 +823,7 @@ static void smp_call_function_many_cond(const struct cpum=
ask *mask,
 		unsigned long flags;
=20
 		local_irq_save(flags);
-		func(info);
+		csd_do_func(func, info, NULL);
 		local_irq_restore(flags);
 	}
=20
@@ -892,7 +899,7 @@ EXPORT_SYMBOL(setup_max_cpus);
  * SMP mode to <NUM>.
  */
=20
-void __weak arch_disable_smp_support(void) { }
+void __weak __init arch_disable_smp_support(void) { }
=20
 static int __init nosmp(char *str)
 {
diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index 2c7396da470c..f47d8f375946 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -325,166 +325,3 @@ void smpboot_unregister_percpu_thread(struct smp_hotplu=
g_thread *plug_thread)
 	cpus_read_unlock();
 }
 EXPORT_SYMBOL_GPL(smpboot_unregister_percpu_thread);
-
-static DEFINE_PER_CPU(atomic_t, cpu_hotplug_state) =3D ATOMIC_INIT(CPU_POST_=
DEAD);
-
-/*
- * Called to poll specified CPU's state, for example, when waiting for
- * a CPU to come online.
- */
-int cpu_report_state(int cpu)
-{
-	return atomic_read(&per_cpu(cpu_hotplug_state, cpu));
-}
-
-/*
- * If CPU has died properly, set its state to CPU_UP_PREPARE and
- * return success.  Otherwise, return -EBUSY if the CPU died after
- * cpu_wait_death() timed out.  And yet otherwise again, return -EAGAIN
- * if cpu_wait_death() timed out and the CPU still hasn't gotten around
- * to dying.  In the latter two cases, the CPU might not be set up
- * properly, but it is up to the arch-specific code to decide.
- * Finally, -EIO indicates an unanticipated problem.
- *
- * Note that it is permissible to omit this call entirely, as is
- * done in architectures that do no CPU-hotplug error checking.
- */
-int cpu_check_up_prepare(int cpu)
-{
-	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
-		atomic_set(&per_cpu(cpu_hotplug_state, cpu), CPU_UP_PREPARE);
-		return 0;
-	}
-
-	switch (atomic_read(&per_cpu(cpu_hotplug_state, cpu))) {
-
-	case CPU_POST_DEAD:
-
-		/* The CPU died properly, so just start it up again. */
-		atomic_set(&per_cpu(cpu_hotplug_state, cpu), CPU_UP_PREPARE);
-		return 0;
-
-	case CPU_DEAD_FROZEN:
-
-		/*
-		 * Timeout during CPU death, so let caller know.
-		 * The outgoing CPU completed its processing, but after
-		 * cpu_wait_death() timed out and reported the error. The
-		 * caller is free to proceed, in which case the state
-		 * will be reset properly by cpu_set_state_online().
-		 * Proceeding despite this -EBUSY return makes sense
-		 * for systems where the outgoing CPUs take themselves
-		 * offline, with no post-death manipulation required from
-		 * a surviving CPU.
-		 */
-		return -EBUSY;
-
-	case CPU_BROKEN:
-
-		/*
-		 * The most likely reason we got here is that there was
-		 * a timeout during CPU death, and the outgoing CPU never
-		 * did complete its processing.  This could happen on
-		 * a virtualized system if the outgoing VCPU gets preempted
-		 * for more than five seconds, and the user attempts to
-		 * immediately online that same CPU.  Trying again later
-		 * might return -EBUSY above, hence -EAGAIN.
-		 */
-		return -EAGAIN;
-
-	case CPU_UP_PREPARE:
-		/*
-		 * Timeout while waiting for the CPU to show up. Allow to try
-		 * again later.
-		 */
-		return 0;
-
-	default:
-
-		/* Should not happen.  Famous last words. */
-		return -EIO;
-	}
-}
-
-/*
- * Mark the specified CPU online.
- *
- * Note that it is permissible to omit this call entirely, as is
- * done in architectures that do no CPU-hotplug error checking.
- */
-void cpu_set_state_online(int cpu)
-{
-	(void)atomic_xchg(&per_cpu(cpu_hotplug_state, cpu), CPU_ONLINE);
-}
-
-#ifdef CONFIG_HOTPLUG_CPU
-
-/*
- * Wait for the specified CPU to exit the idle loop and die.
- */
-bool cpu_wait_death(unsigned int cpu, int seconds)
-{
-	int jf_left =3D seconds * HZ;
-	int oldstate;
-	bool ret =3D true;
-	int sleep_jf =3D 1;
-
-	might_sleep();
-
-	/* The outgoing CPU will normally get done quite quickly. */
-	if (atomic_read(&per_cpu(cpu_hotplug_state, cpu)) =3D=3D CPU_DEAD)
-		goto update_state_early;
-	udelay(5);
-
-	/* But if the outgoing CPU dawdles, wait increasingly long times. */
-	while (atomic_read(&per_cpu(cpu_hotplug_state, cpu)) !=3D CPU_DEAD) {
-		schedule_timeout_uninterruptible(sleep_jf);
-		jf_left -=3D sleep_jf;
-		if (jf_left <=3D 0)
-			break;
-		sleep_jf =3D DIV_ROUND_UP(sleep_jf * 11, 10);
-	}
-update_state_early:
-	oldstate =3D atomic_read(&per_cpu(cpu_hotplug_state, cpu));
-update_state:
-	if (oldstate =3D=3D CPU_DEAD) {
-		/* Outgoing CPU died normally, update state. */
-		smp_mb(); /* atomic_read() before update. */
-		atomic_set(&per_cpu(cpu_hotplug_state, cpu), CPU_POST_DEAD);
-	} else {
-		/* Outgoing CPU still hasn't died, set state accordingly. */
-		if (!atomic_try_cmpxchg(&per_cpu(cpu_hotplug_state, cpu),
-					&oldstate, CPU_BROKEN))
-			goto update_state;
-		ret =3D false;
-	}
-	return ret;
-}
-
-/*
- * Called by the outgoing CPU to report its successful death.  Return
- * false if this report follows the surviving CPU's timing out.
- *
- * A separate "CPU_DEAD_FROZEN" is used when the surviving CPU
- * timed out.  This approach allows architectures to omit calls to
- * cpu_check_up_prepare() and cpu_set_state_online() without defeating
- * the next cpu_wait_death()'s polling loop.
- */
-bool cpu_report_death(void)
-{
-	int oldstate;
-	int newstate;
-	int cpu =3D smp_processor_id();
-
-	oldstate =3D atomic_read(&per_cpu(cpu_hotplug_state, cpu));
-	do {
-		if (oldstate !=3D CPU_BROKEN)
-			newstate =3D CPU_DEAD;
-		else
-			newstate =3D CPU_DEAD_FROZEN;
-	} while (!atomic_try_cmpxchg(&per_cpu(cpu_hotplug_state, cpu),
-				     &oldstate, newstate));
-	return newstate =3D=3D CPU_DEAD;
-}
-
-#endif /* #ifdef CONFIG_HOTPLUG_CPU */

