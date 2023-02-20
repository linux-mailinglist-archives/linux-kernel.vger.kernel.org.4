Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF92369C9EE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjBTLd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjBTLdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:33:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B083340C3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 03:32:56 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676892774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=hjX+ICb3MoSTu18j69UyZYgFJslfi6vGK/VKWHBIzI8=;
        b=HaLGZjfaW+Gz/mNKPLgNtqT+P0lachORxRwLqPEWjtUl1nrLvXuFSxPWwGc1w9SoT5qMtN
        5zoTQpN73tcLp6xdctIjJD+mAfF2s7nIKpIGZ7srERtGsGM7+hZgU8Pm8w6fn1hNBBmrPN
        t6S/wQ5OmUR3iEyAQRFTPTlVsLO11qcl2xbUrCHoRA8j1+NZMrlFb59N+49zy+jR6CvbtE
        bXB/pm20Th3z4naxAaP6pXd9DaYtajqyhk99cyViLYLayBLwtezsUs441wZespdaNSV03e
        1xI/BIdd5/xOlfzSZ9t8nbIz2zc9uRZXnljqLU9jJEeCDsSuFArOGq99gSefog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676892774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=hjX+ICb3MoSTu18j69UyZYgFJslfi6vGK/VKWHBIzI8=;
        b=3xaC74ZsMf5/ZqEkwKMAZFvtfC9T5ywIB5hYdvXP5argNxJ90u1/myvfr12eq2FZZiwD3O
        z8KaI4JeL9SPBjDQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/core for v6.3-rc1
References: <167689254797.295764.1600565060995031919.tglx@xen13>
Message-ID: <167689254948.295764.12646261972310217217.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 20 Feb 2023 12:32:53 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2023=
-02-20

up to:  ab407a1919d2: Merge tag 'clocksource.2023.02.06b' of git://git.kernel=
.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into timers/core


Updates for timekeeping, timers and clockevent/source drivers:

  Core:

    - Yet another round of improvements to make the clocksource watchdog
      more robust:

      	 - Relax the clocksource-watchdog skew criteria to match the NTP
           criteria.

	 - Temporarily skip the watchdog when high memory latencies are
	   detected which can lead to false-positives.

	 - Provide an option to enable TSC skew detection even on systems
           where TSC is marked as reliable.

      Sigh!

    - Initialize the restart block in the nanosleep syscalls to be directed
      to the no restart function instead of doing a partial setup on entry.

      This prevents an erroneous restart_syscall() invocation from
      corrupting user space data. While such a situation is clearly a user
      space bug, preventing this is a correctness issue and caters to the
      least suprise principle.

    - Ignore the hrtimer slack for realtime tasks in schedule_hrtimeout()
      to align it with the nanosleep semantics.

  Drivers:

    - The obligatory new driver bindings for Mediatek, Rockchip and RISC-V
      variants.

    - Add support for the C3STOP misfeature to the RISC-V timer to handle
      the case where the timer stops in deeper idle state.

    - Set up a static key in the RISC-V timer correctly before first use.

    - The usual small improvements and fixes all over the place

Thanks,

	tglx

------------------>
Andy Shevchenko (1):
      vdso/bits.h: Add BIT_ULL() for the sake of consistency

Anup Patel (2):
      dt-bindings: timer: Add bindings for the RISC-V timer device
      clocksource/drivers/timer-riscv: Set CLOCK_EVT_FEAT_C3STOP based on DT

Bernhard Rosenkr=C3=A4nzer (1):
      dt-bindings: timer: mediatek,mtk-timer: add MT8365

Claudiu Beznea (2):
      clocksource/drivers/timer-microchip-pit64b: Select driver only on ARM
      clocksource/drivers/timer-microchip-pit64b: Add delay timer

Conor Dooley (1):
      RISC-V: time: initialize hrtimer based broadcast clock event device

Davidlohr Bueso (2):
      hrtimer: Rely on rt_task() for DL tasks too
      hrtimer: Ignore slack time for RT tasks in schedule_hrtimeout_range()

Feng Tang (2):
      clocksource: Suspend the watchdog temporarily when high read latency de=
tected
      x86/tsc: Add option to force frequency recalibration with HW timer

Greg Kroah-Hartman (1):
      time/debug: Fix memory leak with using debugfs_lookup()

Icenowy Zheng (1):
      dt-bindings: timer: sifive,clint: add comaptibles for T-Head's C9xx

Jagan Teki (1):
      dt-bindings: timer: rk-timer: Add rktimer for rv1126

Jann Horn (1):
      timers: Prevent union confusion from unexpected restart_syscall()

Jean Delvare (1):
      clocksource/drivers/timer-microchip-pit64b: Drop obsolete dependency on=
 COMPILE_TEST

Lad Prabhakar (1):
      clocksource/drivers/riscv: Get rid of clocksource_arch_init() callback

Matt Evans (1):
      clocksource/drivers/riscv: Patch riscv_clock_next_event() jump before f=
irst use

Paul E. McKenney (5):
      clocksource: Loosen clocksource watchdog constraints
      clocksource: Improve read-back-delay message
      clocksource: Improve "skew is too large" messages
      clocksource: Verify HPET and PMTMR when TSC unverified
      clocksource: Enable TSC watchdog checking of HPET and PMTMR only when r=
equested

Samuel Holland (1):
      clocksource/drivers/riscv: Increase the clock source rating

Uros Bizjak (1):
      posix-timers: Use atomic64_try_cmpxchg() in __update_gt_cputime()

Uwe Kleine-K=C3=B6nig (3):
      clocksource/drivers/sh_cmt: Mark driver as non-removable
      clocksource/drivers/sh_tmu: Mark driver as non-removable
      clocksource/drivers/em_sti: Mark driver as non-removable

Yangtao Li (1):
      clocksource/drivers/timer-sun4i: Add CLOCK_EVT_FEAT_DYNIRQ

Yunying Sun (1):
      clocksource: Print clocksource name when clocksource is tested unstable


 Documentation/admin-guide/kernel-parameters.txt    | 10 +++
 .../bindings/timer/mediatek,mtk-timer.txt          |  1 +
 .../devicetree/bindings/timer/riscv,timer.yaml     | 52 ++++++++++++++++
 .../bindings/timer/rockchip,rk-timer.yaml          |  1 +
 .../devicetree/bindings/timer/sifive,clint.yaml    |  8 +++
 arch/riscv/Kconfig                                 |  1 -
 arch/riscv/kernel/time.c                           | 10 +--
 arch/x86/include/asm/time.h                        |  1 +
 arch/x86/kernel/hpet.c                             |  2 +
 arch/x86/kernel/tsc.c                              | 55 +++++++++++++++--
 drivers/clocksource/Kconfig                        |  2 +-
 drivers/clocksource/acpi_pm.c                      |  6 +-
 drivers/clocksource/em_sti.c                       |  7 +--
 drivers/clocksource/sh_cmt.c                       |  7 +--
 drivers/clocksource/sh_tmu.c                       |  7 +--
 drivers/clocksource/timer-microchip-pit64b.c       | 12 ++++
 drivers/clocksource/timer-riscv.c                  | 27 ++++++--
 drivers/clocksource/timer-sun4i.c                  |  3 +-
 include/linux/bits.h                               |  1 -
 include/vdso/bits.h                                |  1 +
 kernel/time/Kconfig                                |  6 +-
 kernel/time/clocksource.c                          | 72 +++++++++++++++-----=
--
 kernel/time/hrtimer.c                              | 18 ++++--
 kernel/time/posix-cpu-timers.c                     | 13 ++--
 kernel/time/posix-stubs.c                          |  2 +
 kernel/time/posix-timers.c                         |  2 +
 kernel/time/test_udelay.c                          |  2 +-
 27 files changed, 252 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/riscv,timer.yaml

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/=
admin-guide/kernel-parameters.txt
index 6cfa6e3996cf..7b4df6d89d3c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6369,6 +6369,16 @@
 			in situations with strict latency requirements (where
 			interruptions from clocksource watchdog are not
 			acceptable).
+			[x86] recalibrate: force recalibration against a HW timer
+			(HPET or PM timer) on systems whose TSC frequency was
+			obtained from HW or FW using either an MSR or CPUID(0x15).
+			Warn if the difference is more than 500 ppm.
+			[x86] watchdog: Use TSC as the watchdog clocksource with
+			which to check other HW timers (HPET or PM timer), but
+			only on systems where TSC has been deemed trustworthy.
+			This will be suppressed by an earlier tsc=3Dnowatchdog and
+			can be overridden by a later tsc=3Dnowatchdog.  A console
+			message will flag any such suppression or overriding.
=20
 	tsc_early_khz=3D  [X86] Skip early TSC calibration and use the given
 			value instead. Useful when the early TSC frequency discovery
diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b=
/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
index 8bbb6e94508b..b3e797e8aa31 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
+++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
@@ -33,6 +33,7 @@ Required properties:
=20
 	For those SoCs that use CPUX
 	* "mediatek,mt6795-systimer" for MT6795 compatible timers (CPUX)
+	* "mediatek,mt8365-systimer" for MT8365 compatible timers (CPUX)
=20
 - reg: Should contain location and length for timer register.
 - clocks: Should contain system clock.
diff --git a/Documentation/devicetree/bindings/timer/riscv,timer.yaml b/Docum=
entation/devicetree/bindings/timer/riscv,timer.yaml
new file mode 100644
index 000000000000..38d67e1a5a79
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/riscv,timer.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/riscv,timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V timer
+
+maintainers:
+  - Anup Patel <anup@brainfault.org>
+
+description: |+
+  RISC-V platforms always have a RISC-V timer device for the supervisor-mode
+  based on the time CSR defined by the RISC-V privileged specification. The
+  timer interrupts of this device are configured using the RISC-V SBI Time
+  extension or the RISC-V Sstc extension.
+
+  The clock frequency of RISC-V timer device is specified via the
+  "timebase-frequency" DT property of "/cpus" DT node which is described
+  in Documentation/devicetree/bindings/riscv/cpus.yaml
+
+properties:
+  compatible:
+    enum:
+      - riscv,timer
+
+  interrupts-extended:
+    minItems: 1
+    maxItems: 4096   # Should be enough?
+
+  riscv,timer-cannot-wake-cpu:
+    type: boolean
+    description:
+      If present, the timer interrupt cannot wake up the CPU from one or
+      more suspend/idle states.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - interrupts-extended
+
+examples:
+  - |
+    timer {
+      compatible =3D "riscv,timer";
+      interrupts-extended =3D <&cpu1intc 5>,
+                            <&cpu2intc 5>,
+                            <&cpu3intc 5>,
+                            <&cpu4intc 5>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml b=
/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
index b61ed1a431bb..65e59836a660 100644
--- a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
@@ -17,6 +17,7 @@ properties:
       - items:
           - enum:
               - rockchip,rv1108-timer
+              - rockchip,rv1126-timer
               - rockchip,rk3036-timer
               - rockchip,rk3128-timer
               - rockchip,rk3188-timer
diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Docu=
mentation/devicetree/bindings/timer/sifive,clint.yaml
index bbad24165837..aada6957216c 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -20,6 +20,10 @@ description:
   property of "/cpus" DT node. The "timebase-frequency" DT property is
   described in Documentation/devicetree/bindings/riscv/cpus.yaml
=20
+  T-Head C906/C910 CPU cores include an implementation of CLINT too, however
+  their implementation lacks a memory-mapped MTIME register, thus not
+  compatible with SiFive ones.
+
 properties:
   compatible:
     oneOf:
@@ -29,6 +33,10 @@ properties:
               - starfive,jh7100-clint
               - canaan,k210-clint
           - const: sifive,clint0
+      - items:
+          - enum:
+              - allwinner,sun20i-d1-clint
+          - const: thead,c900-clint
       - items:
           - const: sifive,clint0
           - const: riscv,clint0
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e2b656043abf..9c687da7756d 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -12,7 +12,6 @@ config 32BIT
=20
 config RISCV
 	def_bool y
-	select ARCH_CLOCKSOURCE_INIT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_HAS_BINFMT_FLAT
diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
index 8217b0f67c6c..babaf3b48ba8 100644
--- a/arch/riscv/kernel/time.c
+++ b/arch/riscv/kernel/time.c
@@ -5,6 +5,7 @@
  */
=20
 #include <linux/of_clk.h>
+#include <linux/clockchips.h>
 #include <linux/clocksource.h>
 #include <linux/delay.h>
 #include <asm/sbi.h>
@@ -29,13 +30,6 @@ void __init time_init(void)
=20
 	of_clk_init(NULL);
 	timer_probe();
-}
=20
-void clocksource_arch_init(struct clocksource *cs)
-{
-#ifdef CONFIG_GENERIC_GETTIMEOFDAY
-	cs->vdso_clock_mode =3D VDSO_CLOCKMODE_ARCHTIMER;
-#else
-	cs->vdso_clock_mode =3D VDSO_CLOCKMODE_NONE;
-#endif
+	tick_setup_hrtimer_broadcast();
 }
diff --git a/arch/x86/include/asm/time.h b/arch/x86/include/asm/time.h
index 8ac563abb567..a53961c64a56 100644
--- a/arch/x86/include/asm/time.h
+++ b/arch/x86/include/asm/time.h
@@ -8,6 +8,7 @@
 extern void hpet_time_init(void);
 extern void time_init(void);
 extern bool pit_timer_init(void);
+extern bool tsc_clocksource_watchdog_disabled(void);
=20
 extern struct clock_event_device *global_clock_event;
=20
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 71f336425e58..c8eb1ac5125a 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -1091,6 +1091,8 @@ int __init hpet_enable(void)
 	if (!hpet_counting())
 		goto out_nohpet;
=20
+	if (tsc_clocksource_watchdog_disabled())
+		clocksource_hpet.flags |=3D CLOCK_SOURCE_MUST_VERIFY;
 	clocksource_register_hz(&clocksource_hpet, (u32)hpet_freq);
=20
 	if (id & HPET_ID_LEGSUP) {
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index a78e73da4a74..306c233c98d8 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -48,6 +48,8 @@ static DEFINE_STATIC_KEY_FALSE(__use_tsc);
=20
 int tsc_clocksource_reliable;
=20
+static int __read_mostly tsc_force_recalibrate;
+
 static u32 art_to_tsc_numerator;
 static u32 art_to_tsc_denominator;
 static u64 art_to_tsc_offset;
@@ -292,6 +294,7 @@ __setup("notsc", notsc_setup);
=20
 static int no_sched_irq_time;
 static int no_tsc_watchdog;
+static int tsc_as_watchdog;
=20
 static int __init tsc_setup(char *str)
 {
@@ -301,8 +304,22 @@ static int __init tsc_setup(char *str)
 		no_sched_irq_time =3D 1;
 	if (!strcmp(str, "unstable"))
 		mark_tsc_unstable("boot parameter");
-	if (!strcmp(str, "nowatchdog"))
+	if (!strcmp(str, "nowatchdog")) {
 		no_tsc_watchdog =3D 1;
+		if (tsc_as_watchdog)
+			pr_alert("%s: Overriding earlier tsc=3Dwatchdog with tsc=3Dnowatchdog\n",
+				 __func__);
+		tsc_as_watchdog =3D 0;
+	}
+	if (!strcmp(str, "recalibrate"))
+		tsc_force_recalibrate =3D 1;
+	if (!strcmp(str, "watchdog")) {
+		if (no_tsc_watchdog)
+			pr_alert("%s: tsc=3Dwatchdog overridden by earlier tsc=3Dnowatchdog\n",
+				 __func__);
+		else
+			tsc_as_watchdog =3D 1;
+	}
 	return 1;
 }
=20
@@ -1186,6 +1203,12 @@ static void __init tsc_disable_clocksource_watchdog(vo=
id)
 	clocksource_tsc.flags &=3D ~CLOCK_SOURCE_MUST_VERIFY;
 }
=20
+bool tsc_clocksource_watchdog_disabled(void)
+{
+	return !(clocksource_tsc.flags & CLOCK_SOURCE_MUST_VERIFY) &&
+	       tsc_as_watchdog && !no_tsc_watchdog;
+}
+
 static void __init check_system_tsc_reliable(void)
 {
 #if defined(CONFIG_MGEODEGX1) || defined(CONFIG_MGEODE_LX) || defined(CONFIG=
_X86_GENERIC)
@@ -1374,6 +1397,25 @@ static void tsc_refine_calibration_work(struct work_st=
ruct *work)
 	else
 		freq =3D calc_pmtimer_ref(delta, ref_start, ref_stop);
=20
+	/* Will hit this only if tsc_force_recalibrate has been set */
+	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
+
+		/* Warn if the deviation exceeds 500 ppm */
+		if (abs(tsc_khz - freq) > (tsc_khz >> 11)) {
+			pr_warn("Warning: TSC freq calibrated by CPUID/MSR differs from what is c=
alibrated by HW timer, please check with vendor!!\n");
+			pr_info("Previous calibrated TSC freq:\t %lu.%03lu MHz\n",
+				(unsigned long)tsc_khz / 1000,
+				(unsigned long)tsc_khz % 1000);
+		}
+
+		pr_info("TSC freq recalibrated by [%s]:\t %lu.%03lu MHz\n",
+			hpet ? "HPET" : "PM_TIMER",
+			(unsigned long)freq / 1000,
+			(unsigned long)freq % 1000);
+
+		return;
+	}
+
 	/* Make sure we're within 1% */
 	if (abs(tsc_khz - freq) > tsc_khz/100)
 		goto out;
@@ -1407,8 +1449,10 @@ static int __init init_tsc_clocksource(void)
 	if (!boot_cpu_has(X86_FEATURE_TSC) || !tsc_khz)
 		return 0;
=20
-	if (tsc_unstable)
-		goto unreg;
+	if (tsc_unstable) {
+		clocksource_unregister(&clocksource_tsc_early);
+		return 0;
+	}
=20
 	if (boot_cpu_has(X86_FEATURE_NONSTOP_TSC_S3))
 		clocksource_tsc.flags |=3D CLOCK_SOURCE_SUSPEND_NONSTOP;
@@ -1421,9 +1465,10 @@ static int __init init_tsc_clocksource(void)
 		if (boot_cpu_has(X86_FEATURE_ART))
 			art_related_clocksource =3D &clocksource_tsc;
 		clocksource_register_khz(&clocksource_tsc, tsc_khz);
-unreg:
 		clocksource_unregister(&clocksource_tsc_early);
-		return 0;
+
+		if (!tsc_force_recalibrate)
+			return 0;
 	}
=20
 	schedule_delayed_work(&tsc_irqwork, 0);
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 4469e7f555e9..ac22c1af056b 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -706,7 +706,7 @@ config INGENIC_OST
=20
 config MICROCHIP_PIT64B
 	bool "Microchip PIT64B support"
-	depends on OF || COMPILE_TEST
+	depends on OF && ARM
 	select TIMER_OF
 	help
 	  This option enables Microchip PIT64B timer for Atmel
diff --git a/drivers/clocksource/acpi_pm.c b/drivers/clocksource/acpi_pm.c
index 279ddff81ab4..82338773602c 100644
--- a/drivers/clocksource/acpi_pm.c
+++ b/drivers/clocksource/acpi_pm.c
@@ -23,6 +23,7 @@
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <asm/io.h>
+#include <asm/time.h>
=20
 /*
  * The I/O port the PMTMR resides at.
@@ -210,8 +211,9 @@ static int __init init_acpi_pm_clocksource(void)
 		return -ENODEV;
 	}
=20
-	return clocksource_register_hz(&clocksource_acpi_pm,
-						PMTMR_TICKS_PER_SEC);
+	if (tsc_clocksource_watchdog_disabled())
+		clocksource_acpi_pm.flags |=3D CLOCK_SOURCE_MUST_VERIFY;
+	return clocksource_register_hz(&clocksource_acpi_pm, PMTMR_TICKS_PER_SEC);
 }
=20
 /* We use fs_initcall because we want the PCI fixups to have run
diff --git a/drivers/clocksource/em_sti.c b/drivers/clocksource/em_sti.c
index ab190dffb1ed..c04b47bd4868 100644
--- a/drivers/clocksource/em_sti.c
+++ b/drivers/clocksource/em_sti.c
@@ -333,11 +333,6 @@ static int em_sti_probe(struct platform_device *pdev)
 	return 0;
 }
=20
-static int em_sti_remove(struct platform_device *pdev)
-{
-	return -EBUSY; /* cannot unregister clockevent and clocksource */
-}
-
 static const struct of_device_id em_sti_dt_ids[] =3D {
 	{ .compatible =3D "renesas,em-sti", },
 	{},
@@ -346,10 +341,10 @@ MODULE_DEVICE_TABLE(of, em_sti_dt_ids);
=20
 static struct platform_driver em_sti_device_driver =3D {
 	.probe		=3D em_sti_probe,
-	.remove		=3D em_sti_remove,
 	.driver		=3D {
 		.name	=3D "em_sti",
 		.of_match_table =3D em_sti_dt_ids,
+		.suppress_bind_attrs =3D true,
 	}
 };
=20
diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 7b952aa52c0b..8b2e079d9df2 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -1145,17 +1145,12 @@ static int sh_cmt_probe(struct platform_device *pdev)
 	return 0;
 }
=20
-static int sh_cmt_remove(struct platform_device *pdev)
-{
-	return -EBUSY; /* cannot unregister clockevent and clocksource */
-}
-
 static struct platform_driver sh_cmt_device_driver =3D {
 	.probe		=3D sh_cmt_probe,
-	.remove		=3D sh_cmt_remove,
 	.driver		=3D {
 		.name	=3D "sh_cmt",
 		.of_match_table =3D of_match_ptr(sh_cmt_of_table),
+		.suppress_bind_attrs =3D true,
 	},
 	.id_table	=3D sh_cmt_id_table,
 };
diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index b00dec0655cb..932f31a7c5be 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -632,11 +632,6 @@ static int sh_tmu_probe(struct platform_device *pdev)
 	return 0;
 }
=20
-static int sh_tmu_remove(struct platform_device *pdev)
-{
-	return -EBUSY; /* cannot unregister clockevent and clocksource */
-}
-
 static const struct platform_device_id sh_tmu_id_table[] =3D {
 	{ "sh-tmu", SH_TMU },
 	{ "sh-tmu-sh3", SH_TMU_SH3 },
@@ -652,10 +647,10 @@ MODULE_DEVICE_TABLE(of, sh_tmu_of_table);
=20
 static struct platform_driver sh_tmu_device_driver =3D {
 	.probe		=3D sh_tmu_probe,
-	.remove		=3D sh_tmu_remove,
 	.driver		=3D {
 		.name	=3D "sh_tmu",
 		.of_match_table =3D of_match_ptr(sh_tmu_of_table),
+		.suppress_bind_attrs =3D true,
 	},
 	.id_table	=3D sh_tmu_id_table,
 };
diff --git a/drivers/clocksource/timer-microchip-pit64b.c b/drivers/clocksour=
ce/timer-microchip-pit64b.c
index d5f1436f33d9..57209bb38c70 100644
--- a/drivers/clocksource/timer-microchip-pit64b.c
+++ b/drivers/clocksource/timer-microchip-pit64b.c
@@ -9,6 +9,7 @@
=20
 #include <linux/clk.h>
 #include <linux/clockchips.h>
+#include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -92,6 +93,8 @@ struct mchp_pit64b_clksrc {
 static void __iomem *mchp_pit64b_cs_base;
 /* Default cycles for clockevent timer. */
 static u64 mchp_pit64b_ce_cycles;
+/* Delay timer. */
+static struct delay_timer mchp_pit64b_dt;
=20
 static inline u64 mchp_pit64b_cnt_read(void __iomem *base)
 {
@@ -169,6 +172,11 @@ static u64 notrace mchp_pit64b_sched_read_clk(void)
 	return mchp_pit64b_cnt_read(mchp_pit64b_cs_base);
 }
=20
+static unsigned long notrace mchp_pit64b_dt_read(void)
+{
+	return mchp_pit64b_cnt_read(mchp_pit64b_cs_base);
+}
+
 static int mchp_pit64b_clkevt_shutdown(struct clock_event_device *cedev)
 {
 	struct mchp_pit64b_timer *timer =3D clkevt_to_mchp_pit64b_timer(cedev);
@@ -376,6 +384,10 @@ static int __init mchp_pit64b_init_clksrc(struct mchp_pi=
t64b_timer *timer,
=20
 	sched_clock_register(mchp_pit64b_sched_read_clk, 64, clk_rate);
=20
+	mchp_pit64b_dt.read_current_timer =3D mchp_pit64b_dt_read;
+	mchp_pit64b_dt.freq =3D clk_rate;
+	register_current_timer_delay(&mchp_pit64b_dt);
+
 	return 0;
 }
=20
diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-ri=
scv.c
index a0d66fabf073..5f0f10c7e222 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -28,6 +28,7 @@
 #include <asm/timex.h>
=20
 static DEFINE_STATIC_KEY_FALSE(riscv_sstc_available);
+static bool riscv_timer_cannot_wake_cpu;
=20
 static int riscv_clock_next_event(unsigned long delta,
 		struct clock_event_device *ce)
@@ -73,10 +74,15 @@ static u64 notrace riscv_sched_clock(void)
=20
 static struct clocksource riscv_clocksource =3D {
 	.name		=3D "riscv_clocksource",
-	.rating		=3D 300,
+	.rating		=3D 400,
 	.mask		=3D CLOCKSOURCE_MASK(64),
 	.flags		=3D CLOCK_SOURCE_IS_CONTINUOUS,
 	.read		=3D riscv_clocksource_rdtime,
+#if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
+	.vdso_clock_mode =3D VDSO_CLOCKMODE_ARCHTIMER,
+#else
+	.vdso_clock_mode =3D VDSO_CLOCKMODE_NONE,
+#endif
 };
=20
 static int riscv_timer_starting_cpu(unsigned int cpu)
@@ -85,6 +91,8 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
=20
 	ce->cpumask =3D cpumask_of(cpu);
 	ce->irq =3D riscv_clock_event_irq;
+	if (riscv_timer_cannot_wake_cpu)
+		ce->features |=3D CLOCK_EVT_FEAT_C3STOP;
 	clockevents_config_and_register(ce, riscv_timebase, 100, 0x7fffffff);
=20
 	enable_percpu_irq(riscv_clock_event_irq,
@@ -139,6 +147,13 @@ static int __init riscv_timer_init_dt(struct device_node=
 *n)
 	if (cpuid !=3D smp_processor_id())
 		return 0;
=20
+	child =3D of_find_compatible_node(NULL, NULL, "riscv,timer");
+	if (child) {
+		riscv_timer_cannot_wake_cpu =3D of_property_read_bool(child,
+					"riscv,timer-cannot-wake-cpu");
+		of_node_put(child);
+	}
+
 	domain =3D NULL;
 	child =3D of_get_compatible_child(n, "riscv,cpu-intc");
 	if (!child) {
@@ -177,6 +192,11 @@ static int __init riscv_timer_init_dt(struct device_node=
 *n)
 		return error;
 	}
=20
+	if (riscv_isa_extension_available(NULL, SSTC)) {
+		pr_info("Timer interrupt in S-mode is available via sstc extension\n");
+		static_branch_enable(&riscv_sstc_available);
+	}
+
 	error =3D cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
 			 "clockevents/riscv/timer:starting",
 			 riscv_timer_starting_cpu, riscv_timer_dying_cpu);
@@ -184,11 +204,6 @@ static int __init riscv_timer_init_dt(struct device_node=
 *n)
 		pr_err("cpu hp setup state failed for RISCV timer [%d]\n",
 		       error);
=20
-	if (riscv_isa_extension_available(NULL, SSTC)) {
-		pr_info("Timer interrupt in S-mode is available via sstc extension\n");
-		static_branch_enable(&riscv_sstc_available);
-	}
-
 	return error;
 }
=20
diff --git a/drivers/clocksource/timer-sun4i.c b/drivers/clocksource/timer-su=
n4i.c
index e5a70aa1deb4..7bdcc60ad43c 100644
--- a/drivers/clocksource/timer-sun4i.c
+++ b/drivers/clocksource/timer-sun4i.c
@@ -144,7 +144,8 @@ static struct timer_of to =3D {
 	.clkevt =3D {
 		.name =3D "sun4i_tick",
 		.rating =3D 350,
-		.features =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+		.features =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
+				CLOCK_EVT_FEAT_DYNIRQ,
 		.set_state_shutdown =3D sun4i_clkevt_shutdown,
 		.set_state_periodic =3D sun4i_clkevt_set_periodic,
 		.set_state_oneshot =3D sun4i_clkevt_set_oneshot,
diff --git a/include/linux/bits.h b/include/linux/bits.h
index 87d112650dfb..7c0cf5031abe 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -6,7 +6,6 @@
 #include <vdso/bits.h>
 #include <asm/bitsperlong.h>
=20
-#define BIT_ULL(nr)		(ULL(1) << (nr))
 #define BIT_MASK(nr)		(UL(1) << ((nr) % BITS_PER_LONG))
 #define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
 #define BIT_ULL_MASK(nr)	(ULL(1) << ((nr) % BITS_PER_LONG_LONG))
diff --git a/include/vdso/bits.h b/include/vdso/bits.h
index 6d005a1f5d94..388b212088ea 100644
--- a/include/vdso/bits.h
+++ b/include/vdso/bits.h
@@ -5,5 +5,6 @@
 #include <vdso/const.h>
=20
 #define BIT(nr)			(UL(1) << (nr))
+#define BIT_ULL(nr)		(ULL(1) << (nr))
=20
 #endif	/* __VDSO_BITS_H */
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index a41753be1a2b..bae8f11070be 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -200,10 +200,14 @@ config CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
 	int "Clocksource watchdog maximum allowable skew (in =CE=BCs)"
 	depends on CLOCKSOURCE_WATCHDOG
 	range 50 1000
-	default 100
+	default 125
 	help
 	  Specify the maximum amount of allowable watchdog skew in
 	  microseconds before reporting the clocksource to be unstable.
+	  The default is based on a half-second clocksource watchdog
+	  interval and NTP's maximum frequency drift of 500 parts
+	  per million.	If the clocksource is good enough for NTP,
+	  it is good enough for the clocksource watchdog!
=20
 endmenu
 endif
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 9cf32ccda715..91836b727cef 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -95,6 +95,11 @@ static char override_name[CS_NAME_LEN];
 static int finished_booting;
 static u64 suspend_start;
=20
+/*
+ * Interval: 0.5sec.
+ */
+#define WATCHDOG_INTERVAL (HZ >> 1)
+
 /*
  * Threshold: 0.0312s, when doubled: 0.0625s.
  * Also a default for cs->uncertainty_margin when registering clocks.
@@ -106,11 +111,14 @@ static u64 suspend_start;
  * clocksource surrounding a read of the clocksource being validated.
  * This delay could be due to SMIs, NMIs, or to VCPU preemptions.  Used as
  * a lower bound for cs->uncertainty_margin values when registering clocks.
+ *
+ * The default of 500 parts per million is based on NTP's limits.
+ * If a clocksource is good enough for NTP, it is good enough for us!
  */
 #ifdef CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
 #define MAX_SKEW_USEC	CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
 #else
-#define MAX_SKEW_USEC	100
+#define MAX_SKEW_USEC	(125 * WATCHDOG_INTERVAL / HZ)
 #endif
=20
 #define WATCHDOG_MAX_SKEW (MAX_SKEW_USEC * NSEC_PER_USEC)
@@ -140,11 +148,6 @@ static inline void clocksource_watchdog_unlock(unsigned =
long *flags)
 static int clocksource_watchdog_kthread(void *data);
 static void __clocksource_change_rating(struct clocksource *cs, int rating);
=20
-/*
- * Interval: 0.5sec.
- */
-#define WATCHDOG_INTERVAL (HZ >> 1)
-
 static void clocksource_watchdog_work(struct work_struct *work)
 {
 	/*
@@ -257,8 +260,8 @@ static enum wd_read_status cs_watchdog_read(struct clocks=
ource *cs, u64 *csnow,
 			goto skip_test;
 	}
=20
-	pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attem=
pt %d, marking unstable\n",
-		smp_processor_id(), watchdog->name, wd_delay, nretries);
+	pr_warn("timekeeping watchdog on CPU%d: wd-%s-wd excessive read-back delay =
of %lldns vs. limit of %ldns, wd-wd read-back delay only %lldns, attempt %d, =
marking %s unstable\n",
+		smp_processor_id(), cs->name, wd_delay, WATCHDOG_MAX_SKEW, wd_seq_delay, n=
retries, cs->name);
 	return WD_READ_UNSTABLE;
=20
 skip_test:
@@ -384,6 +387,15 @@ void clocksource_verify_percpu(struct clocksource *cs)
 }
 EXPORT_SYMBOL_GPL(clocksource_verify_percpu);
=20
+static inline void clocksource_reset_watchdog(void)
+{
+	struct clocksource *cs;
+
+	list_for_each_entry(cs, &watchdog_list, wd_list)
+		cs->flags &=3D ~CLOCK_SOURCE_WATCHDOG;
+}
+
+
 static void clocksource_watchdog(struct timer_list *unused)
 {
 	u64 csnow, wdnow, cslast, wdlast, delta;
@@ -391,6 +403,7 @@ static void clocksource_watchdog(struct timer_list *unuse=
d)
 	int64_t wd_nsec, cs_nsec;
 	struct clocksource *cs;
 	enum wd_read_status read_ret;
+	unsigned long extra_wait =3D 0;
 	u32 md;
=20
 	spin_lock(&watchdog_lock);
@@ -410,13 +423,30 @@ static void clocksource_watchdog(struct timer_list *unu=
sed)
=20
 		read_ret =3D cs_watchdog_read(cs, &csnow, &wdnow);
=20
-		if (read_ret !=3D WD_READ_SUCCESS) {
-			if (read_ret =3D=3D WD_READ_UNSTABLE)
-				/* Clock readout unreliable, so give it up. */
-				__clocksource_unstable(cs);
+		if (read_ret =3D=3D WD_READ_UNSTABLE) {
+			/* Clock readout unreliable, so give it up. */
+			__clocksource_unstable(cs);
 			continue;
 		}
=20
+		/*
+		 * When WD_READ_SKIP is returned, it means the system is likely
+		 * under very heavy load, where the latency of reading
+		 * watchdog/clocksource is very big, and affect the accuracy of
+		 * watchdog check. So give system some space and suspend the
+		 * watchdog check for 5 minutes.
+		 */
+		if (read_ret =3D=3D WD_READ_SKIP) {
+			/*
+			 * As the watchdog timer will be suspended, and
+			 * cs->last could keep unchanged for 5 minutes, reset
+			 * the counters.
+			 */
+			clocksource_reset_watchdog();
+			extra_wait =3D HZ * 300;
+			break;
+		}
+
 		/* Clocksource initialized ? */
 		if (!(cs->flags & CLOCK_SOURCE_WATCHDOG) ||
 		    atomic_read(&watchdog_reset_pending)) {
@@ -443,12 +473,20 @@ static void clocksource_watchdog(struct timer_list *unu=
sed)
 		/* Check the deviation from the watchdog clocksource. */
 		md =3D cs->uncertainty_margin + watchdog->uncertainty_margin;
 		if (abs(cs_nsec - wd_nsec) > md) {
+			u64 cs_wd_msec;
+			u64 wd_msec;
+			u32 wd_rem;
+
 			pr_warn("timekeeping watchdog on CPU%d: Marking clocksource '%s' as unsta=
ble because the skew is too large:\n",
 				smp_processor_id(), cs->name);
 			pr_warn("                      '%s' wd_nsec: %lld wd_now: %llx wd_last: %=
llx mask: %llx\n",
 				watchdog->name, wd_nsec, wdnow, wdlast, watchdog->mask);
 			pr_warn("                      '%s' cs_nsec: %lld cs_now: %llx cs_last: %=
llx mask: %llx\n",
 				cs->name, cs_nsec, csnow, cslast, cs->mask);
+			cs_wd_msec =3D div_u64_rem(cs_nsec - wd_nsec, 1000U * 1000U, &wd_rem);
+			wd_msec =3D div_u64_rem(wd_nsec, 1000U * 1000U, &wd_rem);
+			pr_warn("                      Clocksource '%s' skewed %lld ns (%lld ms) =
over watchdog '%s' interval of %lld ns (%lld ms)\n",
+				cs->name, cs_nsec - wd_nsec, cs_wd_msec, watchdog->name, wd_nsec, wd_mse=
c);
 			if (curr_clocksource =3D=3D cs)
 				pr_warn("                      '%s' is current clocksource.\n", cs->name=
);
 			else if (curr_clocksource)
@@ -512,7 +550,7 @@ static void clocksource_watchdog(struct timer_list *unuse=
d)
 	 * pair clocksource_stop_watchdog() clocksource_start_watchdog().
 	 */
 	if (!timer_pending(&watchdog_timer)) {
-		watchdog_timer.expires +=3D WATCHDOG_INTERVAL;
+		watchdog_timer.expires +=3D WATCHDOG_INTERVAL + extra_wait;
 		add_timer_on(&watchdog_timer, next_cpu);
 	}
 out:
@@ -537,14 +575,6 @@ static inline void clocksource_stop_watchdog(void)
 	watchdog_running =3D 0;
 }
=20
-static inline void clocksource_reset_watchdog(void)
-{
-	struct clocksource *cs;
-
-	list_for_each_entry(cs, &watchdog_list, wd_list)
-		cs->flags &=3D ~CLOCK_SOURCE_WATCHDOG;
-}
-
 static void clocksource_resume_watchdog(void)
 {
 	atomic_inc(&watchdog_reset_pending);
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 3ae661ab6260..e8c08292defc 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2089,7 +2089,7 @@ long hrtimer_nanosleep(ktime_t rqtp, const enum hrtimer=
_mode mode,
 	u64 slack;
=20
 	slack =3D current->timer_slack_ns;
-	if (dl_task(current) || rt_task(current))
+	if (rt_task(current))
 		slack =3D 0;
=20
 	hrtimer_init_sleeper_on_stack(&t, clockid, mode);
@@ -2126,6 +2126,7 @@ SYSCALL_DEFINE2(nanosleep, struct __kernel_timespec __u=
ser *, rqtp,
 	if (!timespec64_valid(&tu))
 		return -EINVAL;
=20
+	current->restart_block.fn =3D do_no_restart_syscall;
 	current->restart_block.nanosleep.type =3D rmtp ? TT_NATIVE : TT_NONE;
 	current->restart_block.nanosleep.rmtp =3D rmtp;
 	return hrtimer_nanosleep(timespec64_to_ktime(tu), HRTIMER_MODE_REL,
@@ -2147,6 +2148,7 @@ SYSCALL_DEFINE2(nanosleep_time32, struct old_timespec32=
 __user *, rqtp,
 	if (!timespec64_valid(&tu))
 		return -EINVAL;
=20
+	current->restart_block.fn =3D do_no_restart_syscall;
 	current->restart_block.nanosleep.type =3D rmtp ? TT_COMPAT : TT_NONE;
 	current->restart_block.nanosleep.compat_rmtp =3D rmtp;
 	return hrtimer_nanosleep(timespec64_to_ktime(tu), HRTIMER_MODE_REL,
@@ -2270,7 +2272,7 @@ void __init hrtimers_init(void)
 /**
  * schedule_hrtimeout_range_clock - sleep until timeout
  * @expires:	timeout value (ktime_t)
- * @delta:	slack in expires timeout (ktime_t)
+ * @delta:	slack in expires timeout (ktime_t) for SCHED_OTHER tasks
  * @mode:	timer mode
  * @clock_id:	timer clock to be used
  */
@@ -2297,6 +2299,13 @@ schedule_hrtimeout_range_clock(ktime_t *expires, u64 d=
elta,
 		return -EINTR;
 	}
=20
+	/*
+	 * Override any slack passed by the user if under
+	 * rt contraints.
+	 */
+	if (rt_task(current))
+		delta =3D 0;
+
 	hrtimer_init_sleeper_on_stack(&t, clock_id, mode);
 	hrtimer_set_expires_range_ns(&t.timer, *expires, delta);
 	hrtimer_sleeper_start_expires(&t, mode);
@@ -2316,7 +2325,7 @@ EXPORT_SYMBOL_GPL(schedule_hrtimeout_range_clock);
 /**
  * schedule_hrtimeout_range - sleep until timeout
  * @expires:	timeout value (ktime_t)
- * @delta:	slack in expires timeout (ktime_t)
+ * @delta:	slack in expires timeout (ktime_t) for SCHED_OTHER tasks
  * @mode:	timer mode
  *
  * Make the current task sleep until the given expiry time has
@@ -2324,7 +2333,8 @@ EXPORT_SYMBOL_GPL(schedule_hrtimeout_range_clock);
  * the current task state has been set (see set_current_state()).
  *
  * The @delta argument gives the kernel the freedom to schedule the
- * actual wakeup to a time that is both power and performance friendly.
+ * actual wakeup to a time that is both power and performance friendly
+ * for regular (non RT/DL) tasks.
  * The kernel give the normal best effort behavior for "@expires+@delta",
  * but may decide to fire the timer earlier, but no earlier than @expires.
  *
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index cb925e8ef9a8..2f5e9b34022c 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -243,13 +243,12 @@ static void proc_sample_cputime_atomic(struct task_cput=
ime_atomic *at,
  */
 static inline void __update_gt_cputime(atomic64_t *cputime, u64 sum_cputime)
 {
-	u64 curr_cputime;
-retry:
-	curr_cputime =3D atomic64_read(cputime);
-	if (sum_cputime > curr_cputime) {
-		if (atomic64_cmpxchg(cputime, curr_cputime, sum_cputime) !=3D curr_cputime)
-			goto retry;
-	}
+	u64 curr_cputime =3D atomic64_read(cputime);
+
+	do {
+		if (sum_cputime <=3D curr_cputime)
+			return;
+	} while (!atomic64_try_cmpxchg(cputime, &curr_cputime, sum_cputime));
 }
=20
 static void update_gt_cputime(struct task_cputime_atomic *cputime_atomic,
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 90ea5f373e50..828aeecbd1e8 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -147,6 +147,7 @@ SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_c=
lock, int, flags,
 		return -EINVAL;
 	if (flags & TIMER_ABSTIME)
 		rmtp =3D NULL;
+	current->restart_block.fn =3D do_no_restart_syscall;
 	current->restart_block.nanosleep.type =3D rmtp ? TT_NATIVE : TT_NONE;
 	current->restart_block.nanosleep.rmtp =3D rmtp;
 	texp =3D timespec64_to_ktime(t);
@@ -240,6 +241,7 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_=
clock, int, flags,
 		return -EINVAL;
 	if (flags & TIMER_ABSTIME)
 		rmtp =3D NULL;
+	current->restart_block.fn =3D do_no_restart_syscall;
 	current->restart_block.nanosleep.type =3D rmtp ? TT_COMPAT : TT_NONE;
 	current->restart_block.nanosleep.compat_rmtp =3D rmtp;
 	texp =3D timespec64_to_ktime(t);
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 5dead89308b7..0c8a87a11b39 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1270,6 +1270,7 @@ SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which=
_clock, int, flags,
 		return -EINVAL;
 	if (flags & TIMER_ABSTIME)
 		rmtp =3D NULL;
+	current->restart_block.fn =3D do_no_restart_syscall;
 	current->restart_block.nanosleep.type =3D rmtp ? TT_NATIVE : TT_NONE;
 	current->restart_block.nanosleep.rmtp =3D rmtp;
=20
@@ -1297,6 +1298,7 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, whic=
h_clock, int, flags,
 		return -EINVAL;
 	if (flags & TIMER_ABSTIME)
 		rmtp =3D NULL;
+	current->restart_block.fn =3D do_no_restart_syscall;
 	current->restart_block.nanosleep.type =3D rmtp ? TT_COMPAT : TT_NONE;
 	current->restart_block.nanosleep.compat_rmtp =3D rmtp;
=20
diff --git a/kernel/time/test_udelay.c b/kernel/time/test_udelay.c
index 13b11eb62685..20d5df631570 100644
--- a/kernel/time/test_udelay.c
+++ b/kernel/time/test_udelay.c
@@ -149,7 +149,7 @@ module_init(udelay_test_init);
 static void __exit udelay_test_exit(void)
 {
 	mutex_lock(&udelay_test_lock);
-	debugfs_remove(debugfs_lookup(DEBUGFS_FILENAME, NULL));
+	debugfs_lookup_and_remove(DEBUGFS_FILENAME, NULL);
 	mutex_unlock(&udelay_test_lock);
 }
=20

