Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8C673DE9D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjFZMOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjFZMN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:13:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83F6E6E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:13:52 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687781631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=guAMmtV1/LQW/9efZgn0pOJwtz/r5RWvqThZ+ES8NVQ=;
        b=kcK4te14PDWPtXxxL1l4U+Z/NGq4tPYP/ar1J9AnS1rXWQtwGpNIO5uI0KKUzJH/ARo5Ab
        mLFsZiCSiRgl/huLa6yIR6U+hR/P02qX946wlXKVNk/RKsPLf6HG/2p8JNrXG1y8SRSXWv
        L5vK/5Wfh8HojZluZz4r74pbfZV+zUh1CTrcpPdDQ7mr0b+XOXhqr1jACoDJrToJq24B8P
        vUHwLM+zjpD7LwcCK8Z7Ks05x12OechU5M0nJa5sjnfBSH7ku9o8KH2y1+wssflfFLNh3c
        niN1gohmECqSMJYPyoJRsWF6ok4fVkOKn/4cr7wVSwuBXpgLVXxaI6jyUhvgyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687781631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=guAMmtV1/LQW/9efZgn0pOJwtz/r5RWvqThZ+ES8NVQ=;
        b=Utem5kbvG58CjYOwqSIVDEsk8H4lDmv5FEd7mD+PJ69yZOEn3y8i60qID/4gGCRkwEIz3q
        aW3lSFK5mnrlyrBw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/core for v6.5-rc1
References: <168778150975.3634408.5562070824299155127.tglx@vps.praguecc.cz>
Message-ID: <168778151379.3634408.18079668842542971614.tglx@vps.praguecc.cz>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 26 Jun 2023 14:13:51 +0200 (CEST)
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

please pull the latest timers/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2023=
-06-26

up to:  d2b32be7debd: Merge tag 'timers-v6.5-rc1' of https://git.linaro.org/p=
eople/daniel.lezcano/linux into timers/core


Time, timekeeping and related device driver updates:

 - Core:

   - A set of fixes, cleanups and enhancements to the posix timer code:

     - Prevent another possible live lock scenario in the exit() path,
       which affects POSIX_CPU_TIMERS_TASK_WORK enabled architectures.

     - Fix a loop termination issue which was reported syzcaller/KSAN in
       the posix timer ID allocation code.

       That triggered a deeper look into the posix-timer code which
       unearthed more small issues.

     - Add missing READ/WRITE_ONCE() annotations

     - Fix or remove completely outdated comments

     - Document places which are subtle and completely undocumented.

   - Add missing hrtimer modes to the trace event decoder

   - Small cleanups and enhancements all over the place

 - Drivers:

     - Rework the Hyper-V clocksource and sched clock setup code

     - Remove a deprecated clocksource driver

     - Small fixes and enhancements all over the place

Thanks,

	tglx

------------------>
Arnd Bergmann (2):
      vdso/timens: Always provide arch_get_vdso_data() prototype for vdso
      posix-timers: Add sys_ni_posix_timers() prototype

Ben Dooks (1):
      hrtimer: Add missing sparse annotations to hrtimer locking

Feng Mingxi (1):
      clocksource/drivers/cadence-ttc: Fix memory leak in ttc_timer_probe

Keguang Zhang (3):
      MIPS: Loongson32: Remove deprecated PWM timer clocksource
      dt-bindings: timer: Add Loongson-1 clocksource
      clocksource/drivers/loongson1: Move PWM timer to clocksource framework

Li zeming (2):
      alarmtimer: Remove unnecessary initialization of variable 'ret'
      alarmtimer: Remove unnecessary (void *) cast

Lukas Bulwahn (1):
      posix-timers: Refer properly to CONFIG_HIGH_RES_TIMERS

Michael Kelley (1):
      clocksource/drivers/hyper-v: Rework clocksource and sched clock setup

Paul Cercueil (1):
      clocksource/drivers/ingenic-timer: Use pm_sleep_ptr() macro

Sebastian Andrzej Siewior (1):
      tracing/timer: Add missing hrtimer modes to decode_hrtimer_mode().

Sergio Paracuellos (1):
      dt-bindings: timers: Add Ralink SoCs timer

Stanislav Jakubek (1):
      dt-bindings: timer: brcm,kona-timer: convert to YAML

Thomas Gleixner (20):
      posix-timers: Prevent RT livelock in itimer_delete()
      posix-timers: Ensure timer ID search-loop limit is valid
      posix-timers: Clarify timer_wait_running() comment
      posix-timers: Cleanup comments about timer ID tracking
      posix-timers: Add comments about timer lookup
      posix-timers: Annotate concurrent access to k_itimer:: It_signal
      posix-timers: Set k_itimer:: It_signal to NULL on exit()
      posix-timers: Remove pointless irqsafe from hash_lock
      posix-timers: Split release_posix_timers()
      posix-timers: Document sys_clock_getres() correctly
      posix-timers: Document common_clock_get() correctly
      posix-timers: Document sys_clock_getoverrun()
      posix-timers: Document sys_clock_settime() permissions in place
      posix-timers: Document nanosleep() details
      posix-timers: Add proper comments in do_timer_create()
      posix-timers: Comment SIGEV_THREAD_ID properly
      posix-timers: Clarify posix_timer_rearm() comment
      posix-timers: Clarify posix_timer_fn() comments
      posix-timers: Remove pointless comments
      posix-timers: Polish coding style in a few places

Uwe Kleine-K=C3=B6nig (3):
      clocksource/drivers/imx-gpt: Use only a single name for functions
      clk: imx: Drop inclusion of unused header <soc/imx/timer.h>
      clocksource/drivers/imx-gpt: Fold <soc/imx/timer.h> into its only user

Wen Yang (1):
      tick/rcu: Fix bogus ratelimit condition


 .../devicetree/bindings/timer/brcm,kona-timer.txt  |  25 -
 .../devicetree/bindings/timer/brcm,kona-timer.yaml |  52 ++
 .../bindings/timer/loongson,ls1x-pwmtimer.yaml     |  48 ++
 .../bindings/timer/ralink,rt2880-timer.yaml        |  44 ++
 arch/alpha/kernel/osf_sys.c                        |   2 -
 arch/mips/include/asm/mach-loongson32/loongson1.h  |   1 -
 arch/mips/include/asm/mach-loongson32/regs-pwm.h   |  25 -
 arch/mips/loongson32/Kconfig                       |  37 --
 arch/mips/loongson32/common/time.c                 | 210 ---------
 drivers/clk/imx/clk-imx1.c                         |   1 -
 drivers/clk/imx/clk-imx27.c                        |   1 -
 drivers/clk/imx/clk-imx31.c                        |   1 -
 drivers/clk/imx/clk-imx35.c                        |   1 -
 drivers/clocksource/Kconfig                        |   9 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/hyperv_timer.c                 |  54 +--
 drivers/clocksource/ingenic-timer.c                |  10 +-
 drivers/clocksource/timer-cadence-ttc.c            |  19 +-
 drivers/clocksource/timer-imx-gpt.c                |  25 +-
 drivers/clocksource/timer-loongson1-pwm.c          | 236 +++++++++
 include/linux/sched/signal.h                       |   2 +-
 include/linux/syscalls.h                           |   1 +
 include/linux/time_namespace.h                     |   3 +-
 include/soc/imx/timer.h                            |  16 -
 include/trace/events/timer.h                       |   6 +-
 kernel/time/alarmtimer.c                           |   4 +-
 kernel/time/hrtimer.c                              |   3 +
 kernel/time/posix-timers.c                         | 525 +++++++++++++------=
--
 kernel/time/tick-sched.c                           |   2 +-
 29 files changed, 777 insertions(+), 587 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/brcm,kona-timer.t=
xt
 create mode 100644 Documentation/devicetree/bindings/timer/brcm,kona-timer.y=
aml
 create mode 100644 Documentation/devicetree/bindings/timer/loongson,ls1x-pwm=
timer.yaml
 create mode 100644 Documentation/devicetree/bindings/timer/ralink,rt2880-tim=
er.yaml
 delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-pwm.h
 create mode 100644 drivers/clocksource/timer-loongson1-pwm.c
 delete mode 100644 include/soc/imx/timer.h

diff --git a/Documentation/devicetree/bindings/timer/brcm,kona-timer.txt b/Do=
cumentation/devicetree/bindings/timer/brcm,kona-timer.txt
deleted file mode 100644
index 39adf54b4388..000000000000
--- a/Documentation/devicetree/bindings/timer/brcm,kona-timer.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Broadcom Kona Family timer
------------------------------------------------------
-This timer is used in the following Broadcom SoCs:
- BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
-
-Required properties:
-- compatible : "brcm,kona-timer"
-- DEPRECATED: compatible : "bcm,kona-timer"
-- reg : Register range for the timer
-- interrupts : interrupt for the timer
-- clocks: phandle + clock specifier pair of the external clock
-- clock-frequency: frequency that the clock operates
-
-Only one of clocks or clock-frequency should be specified.
-
-Refer to clocks/clock-bindings.txt for generic clock consumer properties.
-
-Example:
-	timer@35006000 {
-		compatible =3D "brcm,kona-timer";
-		reg =3D <0x35006000 0x1000>;
-		interrupts =3D <0x0 7 0x4>;
-		clocks =3D <&hub_timer_clk>;
-	};
-
diff --git a/Documentation/devicetree/bindings/timer/brcm,kona-timer.yaml b/D=
ocumentation/devicetree/bindings/timer/brcm,kona-timer.yaml
new file mode 100644
index 000000000000..d6af8383d6fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/brcm,kona-timer.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/brcm,kona-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Kona family timer
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+properties:
+  compatible:
+    const: brcm,kona-timer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-frequency: true
+
+oneOf:
+  - required:
+      - clocks
+  - required:
+      - clock-frequency
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/bcm281xx.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    timer@35006000 {
+        compatible =3D "brcm,kona-timer";
+        reg =3D <0x35006000 0x1000>;
+        interrupts =3D <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+        clocks =3D <&aon_ccu BCM281XX_AON_CCU_HUB_TIMER>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/timer/loongson,ls1x-pwmtimer.y=
aml b/Documentation/devicetree/bindings/timer/loongson,ls1x-pwmtimer.yaml
new file mode 100644
index 000000000000..ad61ae55850b
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/loongson,ls1x-pwmtimer.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/loongson,ls1x-pwmtimer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson-1 PWM timer
+
+maintainers:
+  - Keguang Zhang <keguang.zhang@gmail.com>
+
+description:
+  Loongson-1 PWM timer can be used for system clock source
+  and clock event timers.
+
+properties:
+  compatible:
+    const: loongson,ls1b-pwmtimer
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/loongson,ls1x-clk.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    clocksource: timer@1fe5c030 {
+        compatible =3D "loongson,ls1b-pwmtimer";
+        reg =3D <0x1fe5c030 0x10>;
+
+        clocks =3D <&clkc LS1X_CLKID_APB>;
+        interrupt-parent =3D <&intc0>;
+        interrupts =3D <20 IRQ_TYPE_LEVEL_HIGH>;
+    };
diff --git a/Documentation/devicetree/bindings/timer/ralink,rt2880-timer.yaml=
 b/Documentation/devicetree/bindings/timer/ralink,rt2880-timer.yaml
new file mode 100644
index 000000000000..daa7832babe3
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/ralink,rt2880-timer.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/ralink,rt2880-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Timer present in Ralink family SoCs
+
+maintainers:
+  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
+
+properties:
+  compatible:
+    const: ralink,rt2880-timer
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    timer@100 {
+        compatible =3D "ralink,rt2880-timer";
+        reg =3D <0x100 0x20>;
+
+        clocks =3D <&sysc 3>;
+
+        interrupt-parent =3D <&intc>;
+        interrupts =3D <1>;
+    };
+...
diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index 2a9a877a0508..d98701ee36c6 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -1014,8 +1014,6 @@ SYSCALL_DEFINE2(osf_settimeofday, struct timeval32 __us=
er *, tv,
 	return do_sys_settimeofday64(tv ? &kts : NULL, tz ? &ktz : NULL);
 }
=20
-asmlinkage long sys_ni_posix_timers(void);
-
 SYSCALL_DEFINE2(osf_utimes, const char __user *, filename,
 		struct timeval32 __user *, tvs)
 {
diff --git a/arch/mips/include/asm/mach-loongson32/loongson1.h b/arch/mips/in=
clude/asm/mach-loongson32/loongson1.h
index eb3ddbec1752..d8f9dec0ecc3 100644
--- a/arch/mips/include/asm/mach-loongson32/loongson1.h
+++ b/arch/mips/include/asm/mach-loongson32/loongson1.h
@@ -47,7 +47,6 @@
=20
 #include <regs-clk.h>
 #include <regs-mux.h>
-#include <regs-pwm.h>
 #include <regs-rtc.h>
 #include <regs-wdt.h>
=20
diff --git a/arch/mips/include/asm/mach-loongson32/regs-pwm.h b/arch/mips/inc=
lude/asm/mach-loongson32/regs-pwm.h
deleted file mode 100644
index ec870c82d492..000000000000
--- a/arch/mips/include/asm/mach-loongson32/regs-pwm.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (c) 2014 Zhang, Keguang <keguang.zhang@gmail.com>
- *
- * Loongson 1 PWM Register Definitions.
- */
-
-#ifndef __ASM_MACH_LOONGSON32_REGS_PWM_H
-#define __ASM_MACH_LOONGSON32_REGS_PWM_H
-
-/* Loongson 1 PWM Timer Register Definitions */
-#define PWM_CNT			0x0
-#define PWM_HRC			0x4
-#define PWM_LRC			0x8
-#define PWM_CTRL		0xc
-
-/* PWM Control Register Bits */
-#define CNT_RST			BIT(7)
-#define INT_SR			BIT(6)
-#define INT_EN			BIT(5)
-#define PWM_SINGLE		BIT(4)
-#define PWM_OE			BIT(3)
-#define CNT_EN			BIT(0)
-
-#endif /* __ASM_MACH_LOONGSON32_REGS_PWM_H */
diff --git a/arch/mips/loongson32/Kconfig b/arch/mips/loongson32/Kconfig
index 2ef9da0016df..a7c500959577 100644
--- a/arch/mips/loongson32/Kconfig
+++ b/arch/mips/loongson32/Kconfig
@@ -35,41 +35,4 @@ config LOONGSON1_LS1C
 	select COMMON_CLK
 endchoice
=20
-menuconfig CEVT_CSRC_LS1X
-	bool "Use PWM Timer for clockevent/clocksource"
-	select MIPS_EXTERNAL_TIMER
-	depends on CPU_LOONGSON32
-	help
-	  This option changes the default clockevent/clocksource to PWM Timer,
-	  and is required by Loongson1 CPUFreq support.
-
-	  If unsure, say N.
-
-choice
-	prompt "Select clockevent/clocksource"
-	depends on CEVT_CSRC_LS1X
-	default TIMER_USE_PWM0
-
-config TIMER_USE_PWM0
-	bool "Use PWM Timer 0"
-	help
-	  Use PWM Timer 0 as the default clockevent/clocksourcer.
-
-config TIMER_USE_PWM1
-	bool "Use PWM Timer 1"
-	help
-	  Use PWM Timer 1 as the default clockevent/clocksourcer.
-
-config TIMER_USE_PWM2
-	bool "Use PWM Timer 2"
-	help
-	  Use PWM Timer 2 as the default clockevent/clocksourcer.
-
-config TIMER_USE_PWM3
-	bool "Use PWM Timer 3"
-	help
-	  Use PWM Timer 3 as the default clockevent/clocksourcer.
-
-endchoice
-
 endif # MACH_LOONGSON32
diff --git a/arch/mips/loongson32/common/time.c b/arch/mips/loongson32/common=
/time.c
index 965c04aa56fd..74ad2b17918d 100644
--- a/arch/mips/loongson32/common/time.c
+++ b/arch/mips/loongson32/common/time.c
@@ -5,208 +5,8 @@
=20
 #include <linux/clk.h>
 #include <linux/of_clk.h>
-#include <linux/interrupt.h>
-#include <linux/sizes.h>
 #include <asm/time.h>
=20
-#include <loongson1.h>
-#include <platform.h>
-
-#ifdef CONFIG_CEVT_CSRC_LS1X
-
-#if defined(CONFIG_TIMER_USE_PWM1)
-#define LS1X_TIMER_BASE	LS1X_PWM1_BASE
-#define LS1X_TIMER_IRQ	LS1X_PWM1_IRQ
-
-#elif defined(CONFIG_TIMER_USE_PWM2)
-#define LS1X_TIMER_BASE	LS1X_PWM2_BASE
-#define LS1X_TIMER_IRQ	LS1X_PWM2_IRQ
-
-#elif defined(CONFIG_TIMER_USE_PWM3)
-#define LS1X_TIMER_BASE	LS1X_PWM3_BASE
-#define LS1X_TIMER_IRQ	LS1X_PWM3_IRQ
-
-#else
-#define LS1X_TIMER_BASE	LS1X_PWM0_BASE
-#define LS1X_TIMER_IRQ	LS1X_PWM0_IRQ
-#endif
-
-DEFINE_RAW_SPINLOCK(ls1x_timer_lock);
-
-static void __iomem *timer_reg_base;
-static uint32_t ls1x_jiffies_per_tick;
-
-static inline void ls1x_pwmtimer_set_period(uint32_t period)
-{
-	__raw_writel(period, timer_reg_base + PWM_HRC);
-	__raw_writel(period, timer_reg_base + PWM_LRC);
-}
-
-static inline void ls1x_pwmtimer_restart(void)
-{
-	__raw_writel(0x0, timer_reg_base + PWM_CNT);
-	__raw_writel(INT_EN | CNT_EN, timer_reg_base + PWM_CTRL);
-}
-
-void __init ls1x_pwmtimer_init(void)
-{
-	timer_reg_base =3D ioremap(LS1X_TIMER_BASE, SZ_16);
-	if (!timer_reg_base)
-		panic("Failed to remap timer registers");
-
-	ls1x_jiffies_per_tick =3D DIV_ROUND_CLOSEST(mips_hpt_frequency, HZ);
-
-	ls1x_pwmtimer_set_period(ls1x_jiffies_per_tick);
-	ls1x_pwmtimer_restart();
-}
-
-static u64 ls1x_clocksource_read(struct clocksource *cs)
-{
-	unsigned long flags;
-	int count;
-	u32 jifs;
-	static int old_count;
-	static u32 old_jifs;
-
-	raw_spin_lock_irqsave(&ls1x_timer_lock, flags);
-	/*
-	 * Although our caller may have the read side of xtime_lock,
-	 * this is now a seqlock, and we are cheating in this routine
-	 * by having side effects on state that we cannot undo if
-	 * there is a collision on the seqlock and our caller has to
-	 * retry.  (Namely, old_jifs and old_count.)  So we must treat
-	 * jiffies as volatile despite the lock.  We read jiffies
-	 * before latching the timer count to guarantee that although
-	 * the jiffies value might be older than the count (that is,
-	 * the counter may underflow between the last point where
-	 * jiffies was incremented and the point where we latch the
-	 * count), it cannot be newer.
-	 */
-	jifs =3D jiffies;
-	/* read the count */
-	count =3D __raw_readl(timer_reg_base + PWM_CNT);
-
-	/*
-	 * It's possible for count to appear to go the wrong way for this
-	 * reason:
-	 *
-	 *  The timer counter underflows, but we haven't handled the resulting
-	 *  interrupt and incremented jiffies yet.
-	 *
-	 * Previous attempts to handle these cases intelligently were buggy, so
-	 * we just do the simple thing now.
-	 */
-	if (count < old_count && jifs =3D=3D old_jifs)
-		count =3D old_count;
-
-	old_count =3D count;
-	old_jifs =3D jifs;
-
-	raw_spin_unlock_irqrestore(&ls1x_timer_lock, flags);
-
-	return (u64) (jifs * ls1x_jiffies_per_tick) + count;
-}
-
-static struct clocksource ls1x_clocksource =3D {
-	.name		=3D "ls1x-pwmtimer",
-	.read		=3D ls1x_clocksource_read,
-	.mask		=3D CLOCKSOURCE_MASK(24),
-	.flags		=3D CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
-static irqreturn_t ls1x_clockevent_isr(int irq, void *devid)
-{
-	struct clock_event_device *cd =3D devid;
-
-	ls1x_pwmtimer_restart();
-	cd->event_handler(cd);
-
-	return IRQ_HANDLED;
-}
-
-static int ls1x_clockevent_set_state_periodic(struct clock_event_device *cd)
-{
-	raw_spin_lock(&ls1x_timer_lock);
-	ls1x_pwmtimer_set_period(ls1x_jiffies_per_tick);
-	ls1x_pwmtimer_restart();
-	__raw_writel(INT_EN | CNT_EN, timer_reg_base + PWM_CTRL);
-	raw_spin_unlock(&ls1x_timer_lock);
-
-	return 0;
-}
-
-static int ls1x_clockevent_tick_resume(struct clock_event_device *cd)
-{
-	raw_spin_lock(&ls1x_timer_lock);
-	__raw_writel(INT_EN | CNT_EN, timer_reg_base + PWM_CTRL);
-	raw_spin_unlock(&ls1x_timer_lock);
-
-	return 0;
-}
-
-static int ls1x_clockevent_set_state_shutdown(struct clock_event_device *cd)
-{
-	raw_spin_lock(&ls1x_timer_lock);
-	__raw_writel(__raw_readl(timer_reg_base + PWM_CTRL) & ~CNT_EN,
-		     timer_reg_base + PWM_CTRL);
-	raw_spin_unlock(&ls1x_timer_lock);
-
-	return 0;
-}
-
-static int ls1x_clockevent_set_next(unsigned long evt,
-				    struct clock_event_device *cd)
-{
-	raw_spin_lock(&ls1x_timer_lock);
-	ls1x_pwmtimer_set_period(evt);
-	ls1x_pwmtimer_restart();
-	raw_spin_unlock(&ls1x_timer_lock);
-
-	return 0;
-}
-
-static struct clock_event_device ls1x_clockevent =3D {
-	.name			=3D "ls1x-pwmtimer",
-	.features		=3D CLOCK_EVT_FEAT_PERIODIC,
-	.rating			=3D 300,
-	.irq			=3D LS1X_TIMER_IRQ,
-	.set_next_event		=3D ls1x_clockevent_set_next,
-	.set_state_shutdown	=3D ls1x_clockevent_set_state_shutdown,
-	.set_state_periodic	=3D ls1x_clockevent_set_state_periodic,
-	.set_state_oneshot	=3D ls1x_clockevent_set_state_shutdown,
-	.tick_resume		=3D ls1x_clockevent_tick_resume,
-};
-
-static void __init ls1x_time_init(void)
-{
-	struct clock_event_device *cd =3D &ls1x_clockevent;
-	int ret;
-
-	if (!mips_hpt_frequency)
-		panic("Invalid timer clock rate");
-
-	ls1x_pwmtimer_init();
-
-	clockevent_set_clock(cd, mips_hpt_frequency);
-	cd->max_delta_ns =3D clockevent_delta2ns(0xffffff, cd);
-	cd->max_delta_ticks =3D 0xffffff;
-	cd->min_delta_ns =3D clockevent_delta2ns(0x000300, cd);
-	cd->min_delta_ticks =3D 0x000300;
-	cd->cpumask =3D cpumask_of(smp_processor_id());
-	clockevents_register_device(cd);
-
-	ls1x_clocksource.rating =3D 200 + mips_hpt_frequency / 10000000;
-	ret =3D clocksource_register_hz(&ls1x_clocksource, mips_hpt_frequency);
-	if (ret)
-		panic(KERN_ERR "Failed to register clocksource: %d\n", ret);
-
-	if (request_irq(LS1X_TIMER_IRQ, ls1x_clockevent_isr,
-			IRQF_PERCPU | IRQF_TIMER, "ls1x-pwmtimer",
-			&ls1x_clockevent))
-		pr_err("Failed to register ls1x-pwmtimer interrupt\n");
-}
-#endif /* CONFIG_CEVT_CSRC_LS1X */
-
 void __init plat_time_init(void)
 {
 	struct clk *clk =3D NULL;
@@ -214,20 +14,10 @@ void __init plat_time_init(void)
 	/* initialize LS1X clocks */
 	of_clk_init(NULL);
=20
-#ifdef CONFIG_CEVT_CSRC_LS1X
-	/* setup LS1X PWM timer */
-	clk =3D clk_get(NULL, "ls1x-pwmtimer");
-	if (IS_ERR(clk))
-		panic("unable to get timer clock, err=3D%ld", PTR_ERR(clk));
-
-	mips_hpt_frequency =3D clk_get_rate(clk);
-	ls1x_time_init();
-#else
 	/* setup mips r4k timer */
 	clk =3D clk_get(NULL, "cpu_clk");
 	if (IS_ERR(clk))
 		panic("unable to get cpu clock, err=3D%ld", PTR_ERR(clk));
=20
 	mips_hpt_frequency =3D clk_get_rate(clk) / 2;
-#endif /* CONFIG_CEVT_CSRC_LS1X */
 }
diff --git a/drivers/clk/imx/clk-imx1.c b/drivers/clk/imx/clk-imx1.c
index 22fc7491ba00..f6ea7e5052d5 100644
--- a/drivers/clk/imx/clk-imx1.c
+++ b/drivers/clk/imx/clk-imx1.c
@@ -10,7 +10,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <dt-bindings/clock/imx1-clock.h>
-#include <soc/imx/timer.h>
 #include <asm/irq.h>
=20
 #include "clk.h"
diff --git a/drivers/clk/imx/clk-imx27.c b/drivers/clk/imx/clk-imx27.c
index 5d177125728d..99618ded0939 100644
--- a/drivers/clk/imx/clk-imx27.c
+++ b/drivers/clk/imx/clk-imx27.c
@@ -8,7 +8,6 @@
 #include <linux/of_address.h>
 #include <dt-bindings/clock/imx27-clock.h>
 #include <soc/imx/revision.h>
-#include <soc/imx/timer.h>
 #include <asm/irq.h>
=20
 #include "clk.h"
diff --git a/drivers/clk/imx/clk-imx31.c b/drivers/clk/imx/clk-imx31.c
index c44e18c6f63f..4c8d9ff0b2ad 100644
--- a/drivers/clk/imx/clk-imx31.c
+++ b/drivers/clk/imx/clk-imx31.c
@@ -11,7 +11,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <soc/imx/revision.h>
-#include <soc/imx/timer.h>
 #include <asm/irq.h>
=20
 #include "clk.h"
diff --git a/drivers/clk/imx/clk-imx35.c b/drivers/clk/imx/clk-imx35.c
index 7dcbaea3fea3..3b6fdb4e0be7 100644
--- a/drivers/clk/imx/clk-imx35.c
+++ b/drivers/clk/imx/clk-imx35.c
@@ -10,7 +10,6 @@
 #include <linux/of.h>
 #include <linux/err.h>
 #include <soc/imx/revision.h>
-#include <soc/imx/timer.h>
 #include <asm/irq.h>
=20
 #include "clk.h"
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 526382dc7482..c4d671a5a13d 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -612,6 +612,15 @@ config TIMER_IMX_SYS_CTR
 	  Enable this option to use i.MX system counter timer as a
 	  clockevent.
=20
+config CLKSRC_LOONGSON1_PWM
+	bool "Clocksource using Loongson1 PWM"
+	depends on MACH_LOONGSON32 || COMPILE_TEST
+	select MIPS_EXTERNAL_TIMER
+	select TIMER_OF
+	help
+	  Enable this option to use Loongson1 PWM timer as clocksource
+	  instead of the performance counter.
+
 config CLKSRC_ST_LPC
 	bool "Low power clocksource found in the LPC" if COMPILE_TEST
 	select TIMER_OF if OF
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index f12d3987a960..5d93c9e3fc55 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -89,3 +89,4 @@ obj-$(CONFIG_MICROCHIP_PIT64B)		+=3D timer-microchip-pit64b=
.o
 obj-$(CONFIG_MSC313E_TIMER)		+=3D timer-msc313e.o
 obj-$(CONFIG_GOLDFISH_TIMER)		+=3D timer-goldfish.o
 obj-$(CONFIG_GXP_TIMER)			+=3D timer-gxp.o
+obj-$(CONFIG_CLKSRC_LOONGSON1_PWM)	+=3D timer-loongson1-pwm.o
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_=
timer.c
index bcd9042a0c9f..9fc008c16636 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -475,15 +475,9 @@ static u64 notrace read_hv_clock_msr_cs(struct clocksour=
ce *arg)
 	return read_hv_clock_msr();
 }
=20
-static u64 notrace read_hv_sched_clock_msr(void)
-{
-	return (read_hv_clock_msr() - hv_sched_clock_offset) *
-		(NSEC_PER_SEC / HV_CLOCK_HZ);
-}
-
 static struct clocksource hyperv_cs_msr =3D {
 	.name	=3D "hyperv_clocksource_msr",
-	.rating	=3D 500,
+	.rating	=3D 495,
 	.read	=3D read_hv_clock_msr_cs,
 	.mask	=3D CLOCKSOURCE_MASK(64),
 	.flags	=3D CLOCK_SOURCE_IS_CONTINUOUS,
@@ -513,7 +507,7 @@ static __always_inline void hv_setup_sched_clock(void *sc=
hed_clock)
 static __always_inline void hv_setup_sched_clock(void *sched_clock) {}
 #endif /* CONFIG_GENERIC_SCHED_CLOCK */
=20
-static bool __init hv_init_tsc_clocksource(void)
+static void __init hv_init_tsc_clocksource(void)
 {
 	union hv_reference_tsc_msr tsc_msr;
=20
@@ -524,17 +518,14 @@ static bool __init hv_init_tsc_clocksource(void)
 	 * Hyper-V Reference TSC rating, causing the generic TSC to be used.
 	 * TSC_INVARIANT is not offered on ARM64, so the Hyper-V Reference
 	 * TSC will be preferred over the virtualized ARM64 arch counter.
-	 * While the Hyper-V MSR clocksource won't be used since the
-	 * Reference TSC clocksource is present, change its rating as
-	 * well for consistency.
 	 */
 	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
 		hyperv_cs_tsc.rating =3D 250;
-		hyperv_cs_msr.rating =3D 250;
+		hyperv_cs_msr.rating =3D 245;
 	}
=20
 	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
-		return false;
+		return;
=20
 	hv_read_reference_counter =3D read_hv_clock_tsc;
=20
@@ -565,33 +556,34 @@ static bool __init hv_init_tsc_clocksource(void)
=20
 	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
=20
-	hv_sched_clock_offset =3D hv_read_reference_counter();
-	hv_setup_sched_clock(read_hv_sched_clock_tsc);
-
-	return true;
+	/*
+	 * If TSC is invariant, then let it stay as the sched clock since it
+	 * will be faster than reading the TSC page. But if not invariant, use
+	 * the TSC page so that live migrations across hosts with different
+	 * frequencies is handled correctly.
+	 */
+	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT)) {
+		hv_sched_clock_offset =3D hv_read_reference_counter();
+		hv_setup_sched_clock(read_hv_sched_clock_tsc);
+	}
 }
=20
 void __init hv_init_clocksource(void)
 {
 	/*
-	 * Try to set up the TSC page clocksource. If it succeeds, we're
-	 * done. Otherwise, set up the MSR clocksource.  At least one of
-	 * these will always be available except on very old versions of
-	 * Hyper-V on x86.  In that case we won't have a Hyper-V
+	 * Try to set up the TSC page clocksource, then the MSR clocksource.
+	 * At least one of these will always be available except on very old
+	 * versions of Hyper-V on x86.  In that case we won't have a Hyper-V
 	 * clocksource, but Linux will still run with a clocksource based
 	 * on the emulated PIT or LAPIC timer.
+	 *
+	 * Never use the MSR clocksource as sched clock.  It's too slow.
+	 * Better to use the native sched clock as the fallback.
 	 */
-	if (hv_init_tsc_clocksource())
-		return;
-
-	if (!(ms_hyperv.features & HV_MSR_TIME_REF_COUNT_AVAILABLE))
-		return;
-
-	hv_read_reference_counter =3D read_hv_clock_msr;
-	clocksource_register_hz(&hyperv_cs_msr, NSEC_PER_SEC/100);
+	hv_init_tsc_clocksource();
=20
-	hv_sched_clock_offset =3D hv_read_reference_counter();
-	hv_setup_sched_clock(read_hv_sched_clock_msr);
+	if (ms_hyperv.features & HV_MSR_TIME_REF_COUNT_AVAILABLE)
+		clocksource_register_hz(&hyperv_cs_msr, NSEC_PER_SEC/100);
 }
=20
 void __init hv_remap_tsc_clocksource(void)
diff --git a/drivers/clocksource/ingenic-timer.c b/drivers/clocksource/ingeni=
c-timer.c
index 089ce64b1c3f..154ee5f7954a 100644
--- a/drivers/clocksource/ingenic-timer.c
+++ b/drivers/clocksource/ingenic-timer.c
@@ -369,7 +369,7 @@ static int __init ingenic_tcu_probe(struct platform_devic=
e *pdev)
 	return 0;
 }
=20
-static int __maybe_unused ingenic_tcu_suspend(struct device *dev)
+static int ingenic_tcu_suspend(struct device *dev)
 {
 	struct ingenic_tcu *tcu =3D dev_get_drvdata(dev);
 	unsigned int cpu;
@@ -382,7 +382,7 @@ static int __maybe_unused ingenic_tcu_suspend(struct devi=
ce *dev)
 	return 0;
 }
=20
-static int __maybe_unused ingenic_tcu_resume(struct device *dev)
+static int ingenic_tcu_resume(struct device *dev)
 {
 	struct ingenic_tcu *tcu =3D dev_get_drvdata(dev);
 	unsigned int cpu;
@@ -406,7 +406,7 @@ static int __maybe_unused ingenic_tcu_resume(struct devic=
e *dev)
 	return ret;
 }
=20
-static const struct dev_pm_ops __maybe_unused ingenic_tcu_pm_ops =3D {
+static const struct dev_pm_ops ingenic_tcu_pm_ops =3D {
 	/* _noirq: We want the TCU clocks to be gated last / ungated first */
 	.suspend_noirq =3D ingenic_tcu_suspend,
 	.resume_noirq  =3D ingenic_tcu_resume,
@@ -415,9 +415,7 @@ static const struct dev_pm_ops __maybe_unused ingenic_tcu=
_pm_ops =3D {
 static struct platform_driver ingenic_tcu_driver =3D {
 	.driver =3D {
 		.name	=3D "ingenic-tcu-timer",
-#ifdef CONFIG_PM_SLEEP
-		.pm	=3D &ingenic_tcu_pm_ops,
-#endif
+		.pm	=3D pm_sleep_ptr(&ingenic_tcu_pm_ops),
 		.of_match_table =3D ingenic_tcu_of_match,
 	},
 };
diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/ti=
mer-cadence-ttc.c
index 4efd0cf3b602..0d52e28fea4d 100644
--- a/drivers/clocksource/timer-cadence-ttc.c
+++ b/drivers/clocksource/timer-cadence-ttc.c
@@ -486,10 +486,10 @@ static int __init ttc_timer_probe(struct platform_devic=
e *pdev)
 	 * and use it. Note that the event timer uses the interrupt and it's the
 	 * 2nd TTC hence the irq_of_parse_and_map(,1)
 	 */
-	timer_baseaddr =3D of_iomap(timer, 0);
-	if (!timer_baseaddr) {
+	timer_baseaddr =3D devm_of_iomap(&pdev->dev, timer, 0, NULL);
+	if (IS_ERR(timer_baseaddr)) {
 		pr_err("ERROR: invalid timer base address\n");
-		return -ENXIO;
+		return PTR_ERR(timer_baseaddr);
 	}
=20
 	irq =3D irq_of_parse_and_map(timer, 1);
@@ -513,20 +513,27 @@ static int __init ttc_timer_probe(struct platform_devic=
e *pdev)
 	clk_ce =3D of_clk_get(timer, clksel);
 	if (IS_ERR(clk_ce)) {
 		pr_err("ERROR: timer input clock not found\n");
-		return PTR_ERR(clk_ce);
+		ret =3D PTR_ERR(clk_ce);
+		goto put_clk_cs;
 	}
=20
 	ret =3D ttc_setup_clocksource(clk_cs, timer_baseaddr, timer_width);
 	if (ret)
-		return ret;
+		goto put_clk_ce;
=20
 	ret =3D ttc_setup_clockevent(clk_ce, timer_baseaddr + 4, irq);
 	if (ret)
-		return ret;
+		goto put_clk_ce;
=20
 	pr_info("%pOFn #0 at %p, irq=3D%d\n", timer, timer_baseaddr, irq);
=20
 	return 0;
+
+put_clk_ce:
+	clk_put(clk_ce);
+put_clk_cs:
+	clk_put(clk_cs);
+	return ret;
 }
=20
 static const struct of_device_id ttc_timer_of_match[] =3D {
diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-=
imx-gpt.c
index ca3e4cbc80c6..28ab4f1a7c71 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -16,7 +16,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <soc/imx/timer.h>
=20
 /*
  * There are 4 versions of the timer hardware on Freescale MXC hardware.
@@ -25,6 +24,12 @@
  *  - MX25, MX31, MX35, MX37, MX51, MX6Q(rev1.0)
  *  - MX6DL, MX6SX, MX6Q(rev1.1+)
  */
+enum imx_gpt_type {
+	GPT_TYPE_IMX1,		/* i.MX1 */
+	GPT_TYPE_IMX21,		/* i.MX21/27 */
+	GPT_TYPE_IMX31,		/* i.MX31/35/25/37/51/6Q */
+	GPT_TYPE_IMX6DL,	/* i.MX6DL/SX/SL */
+};
=20
 /* defines common for all i.MX */
 #define MXC_TCTL		0x00
@@ -93,13 +98,11 @@ static void imx1_gpt_irq_disable(struct imx_timer *imxtm)
 	tmp =3D readl_relaxed(imxtm->base + MXC_TCTL);
 	writel_relaxed(tmp & ~MX1_2_TCTL_IRQEN, imxtm->base + MXC_TCTL);
 }
-#define imx21_gpt_irq_disable imx1_gpt_irq_disable
=20
 static void imx31_gpt_irq_disable(struct imx_timer *imxtm)
 {
 	writel_relaxed(0, imxtm->base + V2_IR);
 }
-#define imx6dl_gpt_irq_disable imx31_gpt_irq_disable
=20
 static void imx1_gpt_irq_enable(struct imx_timer *imxtm)
 {
@@ -108,13 +111,11 @@ static void imx1_gpt_irq_enable(struct imx_timer *imxtm)
 	tmp =3D readl_relaxed(imxtm->base + MXC_TCTL);
 	writel_relaxed(tmp | MX1_2_TCTL_IRQEN, imxtm->base + MXC_TCTL);
 }
-#define imx21_gpt_irq_enable imx1_gpt_irq_enable
=20
 static void imx31_gpt_irq_enable(struct imx_timer *imxtm)
 {
 	writel_relaxed(1<<0, imxtm->base + V2_IR);
 }
-#define imx6dl_gpt_irq_enable imx31_gpt_irq_enable
=20
 static void imx1_gpt_irq_acknowledge(struct imx_timer *imxtm)
 {
@@ -131,7 +132,6 @@ static void imx31_gpt_irq_acknowledge(struct imx_timer *i=
mxtm)
 {
 	writel_relaxed(V2_TSTAT_OF1, imxtm->base + V2_TSTAT);
 }
-#define imx6dl_gpt_irq_acknowledge imx31_gpt_irq_acknowledge
=20
 static void __iomem *sched_clock_reg;
=20
@@ -296,7 +296,6 @@ static void imx1_gpt_setup_tctl(struct imx_timer *imxtm)
 	tctl_val =3D MX1_2_TCTL_FRR | MX1_2_TCTL_CLK_PCLK1 | MXC_TCTL_TEN;
 	writel_relaxed(tctl_val, imxtm->base + MXC_TCTL);
 }
-#define imx21_gpt_setup_tctl imx1_gpt_setup_tctl
=20
 static void imx31_gpt_setup_tctl(struct imx_timer *imxtm)
 {
@@ -343,10 +342,10 @@ static const struct imx_gpt_data imx21_gpt_data =3D {
 	.reg_tstat =3D MX1_2_TSTAT,
 	.reg_tcn =3D MX1_2_TCN,
 	.reg_tcmp =3D MX1_2_TCMP,
-	.gpt_irq_enable =3D imx21_gpt_irq_enable,
-	.gpt_irq_disable =3D imx21_gpt_irq_disable,
+	.gpt_irq_enable =3D imx1_gpt_irq_enable,
+	.gpt_irq_disable =3D imx1_gpt_irq_disable,
 	.gpt_irq_acknowledge =3D imx21_gpt_irq_acknowledge,
-	.gpt_setup_tctl =3D imx21_gpt_setup_tctl,
+	.gpt_setup_tctl =3D imx1_gpt_setup_tctl,
 	.set_next_event =3D mx1_2_set_next_event,
 };
=20
@@ -365,9 +364,9 @@ static const struct imx_gpt_data imx6dl_gpt_data =3D {
 	.reg_tstat =3D V2_TSTAT,
 	.reg_tcn =3D V2_TCN,
 	.reg_tcmp =3D V2_TCMP,
-	.gpt_irq_enable =3D imx6dl_gpt_irq_enable,
-	.gpt_irq_disable =3D imx6dl_gpt_irq_disable,
-	.gpt_irq_acknowledge =3D imx6dl_gpt_irq_acknowledge,
+	.gpt_irq_enable =3D imx31_gpt_irq_enable,
+	.gpt_irq_disable =3D imx31_gpt_irq_disable,
+	.gpt_irq_acknowledge =3D imx31_gpt_irq_acknowledge,
 	.gpt_setup_tctl =3D imx6dl_gpt_setup_tctl,
 	.set_next_event =3D v2_set_next_event,
 };
diff --git a/drivers/clocksource/timer-loongson1-pwm.c b/drivers/clocksource/=
timer-loongson1-pwm.c
new file mode 100644
index 000000000000..6335fee03017
--- /dev/null
+++ b/drivers/clocksource/timer-loongson1-pwm.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Clocksource driver for Loongson-1 SoC
+ *
+ * Copyright (c) 2023 Keguang Zhang <keguang.zhang@gmail.com>
+ */
+
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/sizes.h>
+#include "timer-of.h"
+
+/* Loongson-1 PWM Timer Register Definitions */
+#define PWM_CNTR		0x0
+#define PWM_HRC			0x4
+#define PWM_LRC			0x8
+#define PWM_CTRL		0xc
+
+/* PWM Control Register Bits */
+#define INT_LRC_EN		BIT(11)
+#define INT_HRC_EN		BIT(10)
+#define CNTR_RST		BIT(7)
+#define INT_SR			BIT(6)
+#define INT_EN			BIT(5)
+#define PWM_SINGLE		BIT(4)
+#define PWM_OE			BIT(3)
+#define CNT_EN			BIT(0)
+
+#define CNTR_WIDTH		24
+
+DEFINE_RAW_SPINLOCK(ls1x_timer_lock);
+
+struct ls1x_clocksource {
+	void __iomem *reg_base;
+	unsigned long ticks_per_jiffy;
+	struct clocksource clksrc;
+};
+
+static inline struct ls1x_clocksource *to_ls1x_clksrc(struct clocksource *c)
+{
+	return container_of(c, struct ls1x_clocksource, clksrc);
+}
+
+static inline void ls1x_pwmtimer_set_period(unsigned int period,
+					    struct timer_of *to)
+{
+	writel(period, timer_of_base(to) + PWM_LRC);
+	writel(period, timer_of_base(to) + PWM_HRC);
+}
+
+static inline void ls1x_pwmtimer_clear(struct timer_of *to)
+{
+	writel(0, timer_of_base(to) + PWM_CNTR);
+}
+
+static inline void ls1x_pwmtimer_start(struct timer_of *to)
+{
+	writel((INT_EN | PWM_OE | CNT_EN), timer_of_base(to) + PWM_CTRL);
+}
+
+static inline void ls1x_pwmtimer_stop(struct timer_of *to)
+{
+	writel(0, timer_of_base(to) + PWM_CTRL);
+}
+
+static inline void ls1x_pwmtimer_irq_ack(struct timer_of *to)
+{
+	int val;
+
+	val =3D readl(timer_of_base(to) + PWM_CTRL);
+	val |=3D INT_SR;
+	writel(val, timer_of_base(to) + PWM_CTRL);
+}
+
+static irqreturn_t ls1x_clockevent_isr(int irq, void *dev_id)
+{
+	struct clock_event_device *clkevt =3D dev_id;
+	struct timer_of *to =3D to_timer_of(clkevt);
+
+	ls1x_pwmtimer_irq_ack(to);
+	ls1x_pwmtimer_clear(to);
+	ls1x_pwmtimer_start(to);
+
+	clkevt->event_handler(clkevt);
+
+	return IRQ_HANDLED;
+}
+
+static int ls1x_clockevent_set_state_periodic(struct clock_event_device *clk=
evt)
+{
+	struct timer_of *to =3D to_timer_of(clkevt);
+
+	raw_spin_lock(&ls1x_timer_lock);
+	ls1x_pwmtimer_set_period(timer_of_period(to), to);
+	ls1x_pwmtimer_clear(to);
+	ls1x_pwmtimer_start(to);
+	raw_spin_unlock(&ls1x_timer_lock);
+
+	return 0;
+}
+
+static int ls1x_clockevent_tick_resume(struct clock_event_device *clkevt)
+{
+	raw_spin_lock(&ls1x_timer_lock);
+	ls1x_pwmtimer_start(to_timer_of(clkevt));
+	raw_spin_unlock(&ls1x_timer_lock);
+
+	return 0;
+}
+
+static int ls1x_clockevent_set_state_shutdown(struct clock_event_device *clk=
evt)
+{
+	raw_spin_lock(&ls1x_timer_lock);
+	ls1x_pwmtimer_stop(to_timer_of(clkevt));
+	raw_spin_unlock(&ls1x_timer_lock);
+
+	return 0;
+}
+
+static int ls1x_clockevent_set_next(unsigned long evt,
+				    struct clock_event_device *clkevt)
+{
+	struct timer_of *to =3D to_timer_of(clkevt);
+
+	raw_spin_lock(&ls1x_timer_lock);
+	ls1x_pwmtimer_set_period(evt, to);
+	ls1x_pwmtimer_clear(to);
+	ls1x_pwmtimer_start(to);
+	raw_spin_unlock(&ls1x_timer_lock);
+
+	return 0;
+}
+
+static struct timer_of ls1x_to =3D {
+	.flags =3D TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
+	.clkevt =3D {
+		.name			=3D "ls1x-pwmtimer",
+		.features		=3D CLOCK_EVT_FEAT_PERIODIC |
+					  CLOCK_EVT_FEAT_ONESHOT,
+		.rating			=3D 300,
+		.set_next_event		=3D ls1x_clockevent_set_next,
+		.set_state_periodic	=3D ls1x_clockevent_set_state_periodic,
+		.set_state_oneshot	=3D ls1x_clockevent_set_state_shutdown,
+		.set_state_shutdown	=3D ls1x_clockevent_set_state_shutdown,
+		.tick_resume		=3D ls1x_clockevent_tick_resume,
+	},
+	.of_irq =3D {
+		.handler		=3D ls1x_clockevent_isr,
+		.flags			=3D IRQF_TIMER,
+	},
+};
+
+/*
+ * Since the PWM timer overflows every two ticks, its not very useful
+ * to just read by itself. So use jiffies to emulate a free
+ * running counter:
+ */
+static u64 ls1x_clocksource_read(struct clocksource *cs)
+{
+	struct ls1x_clocksource *ls1x_cs =3D to_ls1x_clksrc(cs);
+	unsigned long flags;
+	int count;
+	u32 jifs;
+	static int old_count;
+	static u32 old_jifs;
+
+	raw_spin_lock_irqsave(&ls1x_timer_lock, flags);
+	/*
+	 * Although our caller may have the read side of xtime_lock,
+	 * this is now a seqlock, and we are cheating in this routine
+	 * by having side effects on state that we cannot undo if
+	 * there is a collision on the seqlock and our caller has to
+	 * retry.  (Namely, old_jifs and old_count.)  So we must treat
+	 * jiffies as volatile despite the lock.  We read jiffies
+	 * before latching the timer count to guarantee that although
+	 * the jiffies value might be older than the count (that is,
+	 * the counter may underflow between the last point where
+	 * jiffies was incremented and the point where we latch the
+	 * count), it cannot be newer.
+	 */
+	jifs =3D jiffies;
+	/* read the count */
+	count =3D readl(ls1x_cs->reg_base + PWM_CNTR);
+
+	/*
+	 * It's possible for count to appear to go the wrong way for this
+	 * reason:
+	 *
+	 *  The timer counter underflows, but we haven't handled the resulting
+	 *  interrupt and incremented jiffies yet.
+	 *
+	 * Previous attempts to handle these cases intelligently were buggy, so
+	 * we just do the simple thing now.
+	 */
+	if (count < old_count && jifs =3D=3D old_jifs)
+		count =3D old_count;
+
+	old_count =3D count;
+	old_jifs =3D jifs;
+
+	raw_spin_unlock_irqrestore(&ls1x_timer_lock, flags);
+
+	return (u64)(jifs * ls1x_cs->ticks_per_jiffy) + count;
+}
+
+static struct ls1x_clocksource ls1x_clocksource =3D {
+	.clksrc =3D {
+		.name           =3D "ls1x-pwmtimer",
+		.rating		=3D 300,
+		.read           =3D ls1x_clocksource_read,
+		.mask           =3D CLOCKSOURCE_MASK(CNTR_WIDTH),
+		.flags          =3D CLOCK_SOURCE_IS_CONTINUOUS,
+	},
+};
+
+static int __init ls1x_pwm_clocksource_init(struct device_node *np)
+{
+	struct timer_of *to =3D &ls1x_to;
+	int ret;
+
+	ret =3D timer_of_init(np, to);
+	if (ret)
+		return ret;
+
+	clockevents_config_and_register(&to->clkevt, timer_of_rate(to),
+					0x1, GENMASK(CNTR_WIDTH - 1, 0));
+
+	ls1x_clocksource.reg_base =3D timer_of_base(to);
+	ls1x_clocksource.ticks_per_jiffy =3D timer_of_period(to);
+
+	return clocksource_register_hz(&ls1x_clocksource.clksrc,
+				       timer_of_rate(to));
+}
+
+TIMER_OF_DECLARE(ls1x_pwm_clocksource, "loongson,ls1b-pwmtimer",
+		 ls1x_pwm_clocksource_init);
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 20099268fa25..669e8cff40c7 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -135,7 +135,7 @@ struct signal_struct {
 #ifdef CONFIG_POSIX_TIMERS
=20
 	/* POSIX.1b Interval Timers */
-	int			posix_timer_id;
+	unsigned int		next_posix_timer_id;
 	struct list_head	posix_timers;
=20
 	/* ITIMER_REAL timer for the process */
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 33a0ee3bcb2e..24871f8ec8bb 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1280,6 +1280,7 @@ asmlinkage long sys_ni_syscall(void);
=20
 #endif /* CONFIG_ARCH_HAS_SYSCALL_WRAPPER */
=20
+asmlinkage long sys_ni_posix_timers(void);
=20
 /*
  * Kernel code should not call syscalls (i.e., sys_xyzyyz()) directly.
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index bb9d3f5542f8..03d9c5ac01d1 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -44,7 +44,6 @@ struct time_namespace *copy_time_ns(unsigned long flags,
 				    struct time_namespace *old_ns);
 void free_time_ns(struct time_namespace *ns);
 void timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk);
-struct vdso_data *arch_get_vdso_data(void *vvar_page);
 struct page *find_timens_vvar_page(struct vm_area_struct *vma);
=20
 static inline void put_time_ns(struct time_namespace *ns)
@@ -163,4 +162,6 @@ static inline ktime_t timens_ktime_to_host(clockid_t cloc=
kid, ktime_t tim)
 }
 #endif
=20
+struct vdso_data *arch_get_vdso_data(void *vvar_page);
+
 #endif /* _LINUX_TIMENS_H */
diff --git a/include/soc/imx/timer.h b/include/soc/imx/timer.h
deleted file mode 100644
index 25f29c6bbd0b..000000000000
--- a/include/soc/imx/timer.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright 2015 Linaro Ltd.
- */
-
-#ifndef __SOC_IMX_TIMER_H__
-#define __SOC_IMX_TIMER_H__
-
-enum imx_gpt_type {
-	GPT_TYPE_IMX1,		/* i.MX1 */
-	GPT_TYPE_IMX21,		/* i.MX21/27 */
-	GPT_TYPE_IMX31,		/* i.MX31/35/25/37/51/6Q */
-	GPT_TYPE_IMX6DL,	/* i.MX6DL/SX/SL */
-};
-
-#endif  /* __SOC_IMX_TIMER_H__ */
diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index 3e8619c72f77..b4bc2828fa09 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -158,7 +158,11 @@ DEFINE_EVENT(timer_class, timer_cancel,
 		{ HRTIMER_MODE_ABS_SOFT,	"ABS|SOFT"	},	\
 		{ HRTIMER_MODE_REL_SOFT,	"REL|SOFT"	},	\
 		{ HRTIMER_MODE_ABS_PINNED_SOFT,	"ABS|PINNED|SOFT" },	\
-		{ HRTIMER_MODE_REL_PINNED_SOFT,	"REL|PINNED|SOFT" })
+		{ HRTIMER_MODE_REL_PINNED_SOFT,	"REL|PINNED|SOFT" },	\
+		{ HRTIMER_MODE_ABS_HARD,	"ABS|HARD" },		\
+		{ HRTIMER_MODE_REL_HARD,	"REL|HARD" },		\
+		{ HRTIMER_MODE_ABS_PINNED_HARD, "ABS|PINNED|HARD" },	\
+		{ HRTIMER_MODE_REL_PINNED_HARD,	"REL|PINNED|HARD" })
=20
 /**
  * hrtimer_init - called when the hrtimer is initialized
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 82b28ab0f328..8d9f13d847f0 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -751,7 +751,7 @@ static int alarm_timer_create(struct k_itimer *new_timer)
 static enum alarmtimer_restart alarmtimer_nsleep_wakeup(struct alarm *alarm,
 								ktime_t now)
 {
-	struct task_struct *task =3D (struct task_struct *)alarm->data;
+	struct task_struct *task =3D alarm->data;
=20
 	alarm->data =3D NULL;
 	if (task)
@@ -847,7 +847,7 @@ static int alarm_timer_nsleep(const clockid_t which_clock=
, int flags,
 	struct restart_block *restart =3D &current->restart_block;
 	struct alarm alarm;
 	ktime_t exp;
-	int ret =3D 0;
+	int ret;
=20
 	if (!alarmtimer_get_rtcdev())
 		return -EOPNOTSUPP;
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index e8c08292defc..238262e4aba7 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -164,6 +164,7 @@ static inline bool is_migration_base(struct hrtimer_clock=
_base *base)
 static
 struct hrtimer_clock_base *lock_hrtimer_base(const struct hrtimer *timer,
 					     unsigned long *flags)
+	__acquires(&timer->base->lock)
 {
 	struct hrtimer_clock_base *base;
=20
@@ -280,6 +281,7 @@ static inline bool is_migration_base(struct hrtimer_clock=
_base *base)
=20
 static inline struct hrtimer_clock_base *
 lock_hrtimer_base(const struct hrtimer *timer, unsigned long *flags)
+	__acquires(&timer->base->cpu_base->lock)
 {
 	struct hrtimer_clock_base *base =3D timer->base;
=20
@@ -1013,6 +1015,7 @@ void hrtimers_resume_local(void)
  */
 static inline
 void unlock_hrtimer_base(const struct hrtimer *timer, unsigned long *flags)
+	__releases(&timer->base->cpu_base->lock)
 {
 	raw_spin_unlock_irqrestore(&timer->base->cpu_base->lock, *flags);
 }
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 808a247205a9..b924f0f096fa 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -35,20 +35,17 @@
 #include "timekeeping.h"
 #include "posix-timers.h"
=20
-/*
- * Management arrays for POSIX timers. Timers are now kept in static hash ta=
ble
- * with 512 entries.
- * Timer ids are allocated by local routine, which selects proper hash head =
by
- * key, constructed from current->signal address and per signal struct count=
er.
- * This keeps timer ids unique per process, but now they can intersect betwe=
en
- * processes.
- */
+static struct kmem_cache *posix_timers_cache;
=20
 /*
- * Lets keep our timers in a slab cache :-)
+ * Timers are managed in a hash table for lockless lookup. The hash key is
+ * constructed from current::signal and the timer ID and the timer is
+ * matched against current::signal and the timer ID when walking the hash
+ * bucket list.
+ *
+ * This allows checkpoint/restore to reconstruct the exact timer IDs for
+ * a process.
  */
-static struct kmem_cache *posix_timers_cache;
-
 static DEFINE_HASHTABLE(posix_timers_hashtable, 9);
 static DEFINE_SPINLOCK(hash_lock);
=20
@@ -56,52 +53,12 @@ static const struct k_clock * const posix_clocks[];
 static const struct k_clock *clockid_to_kclock(const clockid_t id);
 static const struct k_clock clock_realtime, clock_monotonic;
=20
-/*
- * we assume that the new SIGEV_THREAD_ID shares no bits with the other
- * SIGEV values.  Here we put out an error if this assumption fails.
- */
+/* SIGEV_THREAD_ID cannot share a bit with the other SIGEV values. */
 #if SIGEV_THREAD_ID !=3D (SIGEV_THREAD_ID & \
-                       ~(SIGEV_SIGNAL | SIGEV_NONE | SIGEV_THREAD))
+			~(SIGEV_SIGNAL | SIGEV_NONE | SIGEV_THREAD))
 #error "SIGEV_THREAD_ID must not share bit with other SIGEV values!"
 #endif
=20
-/*
- * The timer ID is turned into a timer address by idr_find().
- * Verifying a valid ID consists of:
- *
- * a) checking that idr_find() returns other than -1.
- * b) checking that the timer id matches the one in the timer itself.
- * c) that the timer owner is in the callers thread group.
- */
-
-/*
- * CLOCKs: The POSIX standard calls for a couple of clocks and allows us
- *	    to implement others.  This structure defines the various
- *	    clocks.
- *
- * RESOLUTION: Clock resolution is used to round up timer and interval
- *	    times, NOT to report clock times, which are reported with as
- *	    much resolution as the system can muster.  In some cases this
- *	    resolution may depend on the underlying clock hardware and
- *	    may not be quantifiable until run time, and only then is the
- *	    necessary code is written.	The standard says we should say
- *	    something about this issue in the documentation...
- *
- * FUNCTIONS: The CLOCKs structure defines possible functions to
- *	    handle various clock functions.
- *
- *	    The standard POSIX timer management code assumes the
- *	    following: 1.) The k_itimer struct (sched.h) is used for
- *	    the timer.  2.) The list, it_lock, it_clock, it_id and
- *	    it_pid fields are not modified by timer code.
- *
- * Permissions: It is assumed that the clock_settime() function defined
- *	    for each clock will take care of permission checks.	 Some
- *	    clocks may be set able by any user (i.e. local process
- *	    clocks) others not.	 Currently the only set able clock we
- *	    have is CLOCK_REALTIME and its high res counter part, both of
- *	    which we beg off on and pass to do_sys_settimeofday().
- */
 static struct k_itimer *__lock_timer(timer_t timer_id, unsigned long *flags);
=20
 #define lock_timer(tid, flags)						   \
@@ -121,9 +78,9 @@ static struct k_itimer *__posix_timers_find(struct hlist_h=
ead *head,
 {
 	struct k_itimer *timer;
=20
-	hlist_for_each_entry_rcu(timer, head, t_hash,
-				 lockdep_is_held(&hash_lock)) {
-		if ((timer->it_signal =3D=3D sig) && (timer->it_id =3D=3D id))
+	hlist_for_each_entry_rcu(timer, head, t_hash, lockdep_is_held(&hash_lock)) {
+		/* timer->it_signal can be set concurrently */
+		if ((READ_ONCE(timer->it_signal) =3D=3D sig) && (timer->it_id =3D=3D id))
 			return timer;
 	}
 	return NULL;
@@ -140,25 +97,30 @@ static struct k_itimer *posix_timer_by_id(timer_t id)
 static int posix_timer_add(struct k_itimer *timer)
 {
 	struct signal_struct *sig =3D current->signal;
-	int first_free_id =3D sig->posix_timer_id;
 	struct hlist_head *head;
-	int ret =3D -ENOENT;
+	unsigned int cnt, id;
=20
-	do {
+	/*
+	 * FIXME: Replace this by a per signal struct xarray once there is
+	 * a plan to handle the resulting CRIU regression gracefully.
+	 */
+	for (cnt =3D 0; cnt <=3D INT_MAX; cnt++) {
 		spin_lock(&hash_lock);
-		head =3D &posix_timers_hashtable[hash(sig, sig->posix_timer_id)];
-		if (!__posix_timers_find(head, sig, sig->posix_timer_id)) {
+		id =3D sig->next_posix_timer_id;
+
+		/* Write the next ID back. Clamp it to the positive space */
+		sig->next_posix_timer_id =3D (id + 1) & INT_MAX;
+
+		head =3D &posix_timers_hashtable[hash(sig, id)];
+		if (!__posix_timers_find(head, sig, id)) {
 			hlist_add_head_rcu(&timer->t_hash, head);
-			ret =3D sig->posix_timer_id;
+			spin_unlock(&hash_lock);
+			return id;
 		}
-		if (++sig->posix_timer_id < 0)
-			sig->posix_timer_id =3D 0;
-		if ((sig->posix_timer_id =3D=3D first_free_id) && (ret =3D=3D -ENOENT))
-			/* Loop over all possible ids completed */
-			ret =3D -EAGAIN;
 		spin_unlock(&hash_lock);
-	} while (ret =3D=3D -ENOENT);
-	return ret;
+	}
+	/* POSIX return code when no timer ID could be allocated */
+	return -EAGAIN;
 }
=20
 static inline void unlock_timer(struct k_itimer *timr, unsigned long flags)
@@ -166,7 +128,6 @@ static inline void unlock_timer(struct k_itimer *timr, un=
signed long flags)
 	spin_unlock_irqrestore(&timr->it_lock, flags);
 }
=20
-/* Get clock_realtime */
 static int posix_get_realtime_timespec(clockid_t which_clock, struct timespe=
c64 *tp)
 {
 	ktime_get_real_ts64(tp);
@@ -178,7 +139,6 @@ static ktime_t posix_get_realtime_ktime(clockid_t which_c=
lock)
 	return ktime_get_real();
 }
=20
-/* Set clock_realtime */
 static int posix_clock_realtime_set(const clockid_t which_clock,
 				    const struct timespec64 *tp)
 {
@@ -191,9 +151,6 @@ static int posix_clock_realtime_adj(const clockid_t which=
_clock,
 	return do_adjtimex(t);
 }
=20
-/*
- * Get monotonic time for posix timers
- */
 static int posix_get_monotonic_timespec(clockid_t which_clock, struct timesp=
ec64 *tp)
 {
 	ktime_get_ts64(tp);
@@ -206,9 +163,6 @@ static ktime_t posix_get_monotonic_ktime(clockid_t which_=
clock)
 	return ktime_get();
 }
=20
-/*
- * Get monotonic-raw time for posix timers
- */
 static int posix_get_monotonic_raw(clockid_t which_clock, struct timespec64 =
*tp)
 {
 	ktime_get_raw_ts64(tp);
@@ -216,7 +170,6 @@ static int posix_get_monotonic_raw(clockid_t which_clock,=
 struct timespec64 *tp)
 	return 0;
 }
=20
-
 static int posix_get_realtime_coarse(clockid_t which_clock, struct timespec6=
4 *tp)
 {
 	ktime_get_coarse_real_ts64(tp);
@@ -267,9 +220,6 @@ static int posix_get_hrtimer_res(clockid_t which_clock, s=
truct timespec64 *tp)
 	return 0;
 }
=20
-/*
- * Initialize everything, well, just everything in Posix clocks/timers ;)
- */
 static __init int init_posix_timers(void)
 {
 	posix_timers_cache =3D kmem_cache_create("posix_timers_cache",
@@ -300,15 +250,9 @@ static void common_hrtimer_rearm(struct k_itimer *timr)
 }
=20
 /*
- * This function is exported for use by the signal deliver code.  It is
- * called just prior to the info block being released and passes that
- * block to us.  It's function is to update the overrun entry AND to
- * restart the timer.  It should only be called if the timer is to be
- * restarted (i.e. we have flagged this in the sys_private entry of the
- * info block).
- *
- * To protect against the timer going away while the interrupt is queued,
- * we require that the it_requeue_pending flag be set.
+ * This function is called from the signal delivery code if
+ * info->si_sys_private is not zero, which indicates that the timer has to
+ * be rearmed. Restart the timer and update info::si_overrun.
  */
 void posixtimer_rearm(struct kernel_siginfo *info)
 {
@@ -357,18 +301,18 @@ int posix_timer_event(struct k_itimer *timr, int si_pri=
vate)
 }
=20
 /*
- * This function gets called when a POSIX.1b interval timer expires.  It
- * is used as a callback from the kernel internal timer.  The
- * run_timer_list code ALWAYS calls with interrupts on.
-
- * This code is for CLOCK_REALTIME* and CLOCK_MONOTONIC* timers.
+ * This function gets called when a POSIX.1b interval timer expires from
+ * the HRTIMER interrupt (soft interrupt on RT kernels).
+ *
+ * Handles CLOCK_REALTIME, CLOCK_MONOTONIC, CLOCK_BOOTTIME and CLOCK_TAI
+ * based timers.
  */
 static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 {
+	enum hrtimer_restart ret =3D HRTIMER_NORESTART;
 	struct k_itimer *timr;
 	unsigned long flags;
 	int si_private =3D 0;
-	enum hrtimer_restart ret =3D HRTIMER_NORESTART;
=20
 	timr =3D container_of(timer, struct k_itimer, it.real.timer);
 	spin_lock_irqsave(&timr->it_lock, flags);
@@ -379,9 +323,10 @@ static enum hrtimer_restart posix_timer_fn(struct hrtime=
r *timer)
=20
 	if (posix_timer_event(timr, si_private)) {
 		/*
-		 * signal was not sent because of sig_ignor
-		 * we will not get a call back to restart it AND
-		 * it should be restarted.
+		 * The signal was not queued due to SIG_IGN. As a
+		 * consequence the timer is not going to be rearmed from
+		 * the signal delivery path. But as a real signal handler
+		 * can be installed later the timer must be rearmed here.
 		 */
 		if (timr->it_interval !=3D 0) {
 			ktime_t now =3D hrtimer_cb_get_time(timer);
@@ -390,34 +335,35 @@ static enum hrtimer_restart posix_timer_fn(struct hrtim=
er *timer)
 			 * FIXME: What we really want, is to stop this
 			 * timer completely and restart it in case the
 			 * SIG_IGN is removed. This is a non trivial
-			 * change which involves sighand locking
-			 * (sigh !), which we don't want to do late in
-			 * the release cycle.
+			 * change to the signal handling code.
+			 *
+			 * For now let timers with an interval less than a
+			 * jiffie expire every jiffie and recheck for a
+			 * valid signal handler.
+			 *
+			 * This avoids interrupt starvation in case of a
+			 * very small interval, which would expire the
+			 * timer immediately again.
+			 *
+			 * Moving now ahead of time by one jiffie tricks
+			 * hrtimer_forward() to expire the timer later,
+			 * while it still maintains the overrun accuracy
+			 * for the price of a slight inconsistency in the
+			 * timer_gettime() case. This is at least better
+			 * than a timer storm.
 			 *
-			 * For now we just let timers with an interval
-			 * less than a jiffie expire every jiffie to
-			 * avoid softirq starvation in case of SIG_IGN
-			 * and a very small interval, which would put
-			 * the timer right back on the softirq pending
-			 * list. By moving now ahead of time we trick
-			 * hrtimer_forward() to expire the timer
-			 * later, while we still maintain the overrun
-			 * accuracy, but have some inconsistency in
-			 * the timer_gettime() case. This is at least
-			 * better than a starved softirq. A more
-			 * complex fix which solves also another related
-			 * inconsistency is already in the pipeline.
+			 * Only required when high resolution timers are
+			 * enabled as the periodic tick based timers are
+			 * automatically aligned to the next tick.
 			 */
-#ifdef CONFIG_HIGH_RES_TIMERS
-			{
-				ktime_t kj =3D NSEC_PER_SEC / HZ;
+			if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS)) {
+				ktime_t kj =3D TICK_NSEC;
=20
 				if (timr->it_interval < kj)
 					now =3D ktime_add(now, kj);
 			}
-#endif
-			timr->it_overrun +=3D hrtimer_forward(timer, now,
-							    timr->it_interval);
+
+			timr->it_overrun +=3D hrtimer_forward(timer, now, timr->it_interval);
 			ret =3D HRTIMER_RESTART;
 			++timr->it_requeue_pending;
 			timr->it_active =3D 1;
@@ -454,8 +400,8 @@ static struct pid *good_sigevent(sigevent_t * event)
=20
 static struct k_itimer * alloc_posix_timer(void)
 {
-	struct k_itimer *tmr;
-	tmr =3D kmem_cache_zalloc(posix_timers_cache, GFP_KERNEL);
+	struct k_itimer *tmr =3D kmem_cache_zalloc(posix_timers_cache, GFP_KERNEL);
+
 	if (!tmr)
 		return tmr;
 	if (unlikely(!(tmr->sigq =3D sigqueue_alloc()))) {
@@ -473,21 +419,21 @@ static void k_itimer_rcu_free(struct rcu_head *head)
 	kmem_cache_free(posix_timers_cache, tmr);
 }
=20
-#define IT_ID_SET	1
-#define IT_ID_NOT_SET	0
-static void release_posix_timer(struct k_itimer *tmr, int it_id_set)
+static void posix_timer_free(struct k_itimer *tmr)
 {
-	if (it_id_set) {
-		unsigned long flags;
-		spin_lock_irqsave(&hash_lock, flags);
-		hlist_del_rcu(&tmr->t_hash);
-		spin_unlock_irqrestore(&hash_lock, flags);
-	}
 	put_pid(tmr->it_pid);
 	sigqueue_free(tmr->sigq);
 	call_rcu(&tmr->rcu, k_itimer_rcu_free);
 }
=20
+static void posix_timer_unhash_and_free(struct k_itimer *tmr)
+{
+	spin_lock(&hash_lock);
+	hlist_del_rcu(&tmr->t_hash);
+	spin_unlock(&hash_lock);
+	posix_timer_free(tmr);
+}
+
 static int common_timer_create(struct k_itimer *new_timer)
 {
 	hrtimer_init(&new_timer->it.real.timer, new_timer->it_clock, 0);
@@ -501,7 +447,6 @@ static int do_timer_create(clockid_t which_clock, struct =
sigevent *event,
 	const struct k_clock *kc =3D clockid_to_kclock(which_clock);
 	struct k_itimer *new_timer;
 	int error, new_timer_id;
-	int it_id_set =3D IT_ID_NOT_SET;
=20
 	if (!kc)
 		return -EINVAL;
@@ -513,13 +458,18 @@ static int do_timer_create(clockid_t which_clock, struc=
t sigevent *event,
 		return -EAGAIN;
=20
 	spin_lock_init(&new_timer->it_lock);
+
+	/*
+	 * Add the timer to the hash table. The timer is not yet valid
+	 * because new_timer::it_signal is still NULL. The timer id is also
+	 * not yet visible to user space.
+	 */
 	new_timer_id =3D posix_timer_add(new_timer);
 	if (new_timer_id < 0) {
-		error =3D new_timer_id;
-		goto out;
+		posix_timer_free(new_timer);
+		return new_timer_id;
 	}
=20
-	it_id_set =3D IT_ID_SET;
 	new_timer->it_id =3D (timer_t) new_timer_id;
 	new_timer->it_clock =3D which_clock;
 	new_timer->kclock =3D kc;
@@ -547,30 +497,33 @@ static int do_timer_create(clockid_t which_clock, struc=
t sigevent *event,
 	new_timer->sigq->info.si_tid   =3D new_timer->it_id;
 	new_timer->sigq->info.si_code  =3D SI_TIMER;
=20
-	if (copy_to_user(created_timer_id,
-			 &new_timer_id, sizeof (new_timer_id))) {
+	if (copy_to_user(created_timer_id, &new_timer_id, sizeof (new_timer_id))) {
 		error =3D -EFAULT;
 		goto out;
 	}
-
+	/*
+	 * After succesful copy out, the timer ID is visible to user space
+	 * now but not yet valid because new_timer::signal is still NULL.
+	 *
+	 * Complete the initialization with the clock specific create
+	 * callback.
+	 */
 	error =3D kc->timer_create(new_timer);
 	if (error)
 		goto out;
=20
 	spin_lock_irq(&current->sighand->siglock);
-	new_timer->it_signal =3D current->signal;
+	/* This makes the timer valid in the hash table */
+	WRITE_ONCE(new_timer->it_signal, current->signal);
 	list_add(&new_timer->list, &current->signal->posix_timers);
 	spin_unlock_irq(&current->sighand->siglock);
-
-	return 0;
 	/*
-	 * In the case of the timer belonging to another task, after
-	 * the task is unlocked, the timer is owned by the other task
-	 * and may cease to exist at any time.  Don't use or modify
-	 * new_timer after the unlock call.
+	 * After unlocking sighand::siglock @new_timer is subject to
+	 * concurrent removal and cannot be touched anymore
 	 */
+	return 0;
 out:
-	release_posix_timer(new_timer, it_id_set);
+	posix_timer_unhash_and_free(new_timer);
 	return error;
 }
=20
@@ -604,13 +557,6 @@ COMPAT_SYSCALL_DEFINE3(timer_create, clockid_t, which_cl=
ock,
 }
 #endif
=20
-/*
- * Locking issues: We need to protect the result of the id look up until
- * we get the timer locked down so it is not deleted under us.  The
- * removal is done under the idr spinlock so we use that here to bridge
- * the find to the timer lock.  To avoid a dead lock, the timer id MUST
- * be release with out holding the timer lock.
- */
 static struct k_itimer *__lock_timer(timer_t timer_id, unsigned long *flags)
 {
 	struct k_itimer *timr;
@@ -622,10 +568,35 @@ static struct k_itimer *__lock_timer(timer_t timer_id, =
unsigned long *flags)
 	if ((unsigned long long)timer_id > INT_MAX)
 		return NULL;
=20
+	/*
+	 * The hash lookup and the timers are RCU protected.
+	 *
+	 * Timers are added to the hash in invalid state where
+	 * timr::it_signal =3D=3D NULL. timer::it_signal is only set after the
+	 * rest of the initialization succeeded.
+	 *
+	 * Timer destruction happens in steps:
+	 *  1) Set timr::it_signal to NULL with timr::it_lock held
+	 *  2) Release timr::it_lock
+	 *  3) Remove from the hash under hash_lock
+	 *  4) Call RCU for removal after the grace period
+	 *
+	 * Holding rcu_read_lock() accross the lookup ensures that
+	 * the timer cannot be freed.
+	 *
+	 * The lookup validates locklessly that timr::it_signal =3D=3D
+	 * current::it_signal and timr::it_id =3D=3D @timer_id. timr::it_id
+	 * can't change, but timr::it_signal becomes NULL during
+	 * destruction.
+	 */
 	rcu_read_lock();
 	timr =3D posix_timer_by_id(timer_id);
 	if (timr) {
 		spin_lock_irqsave(&timr->it_lock, *flags);
+		/*
+		 * Validate under timr::it_lock that timr::it_signal is
+		 * still valid. Pairs with #1 above.
+		 */
 		if (timr->it_signal =3D=3D current->signal) {
 			rcu_read_unlock();
 			return timr;
@@ -652,20 +623,16 @@ static s64 common_hrtimer_forward(struct k_itimer *timr=
, ktime_t now)
 }
=20
 /*
- * Get the time remaining on a POSIX.1b interval timer.  This function
- * is ALWAYS called with spin_lock_irq on the timer, thus it must not
- * mess with irq.
+ * Get the time remaining on a POSIX.1b interval timer.
  *
- * We have a couple of messes to clean up here.  First there is the case
- * of a timer that has a requeue pending.  These timers should appear to
- * be in the timer list with an expiry as if we were to requeue them
- * now.
+ * Two issues to handle here:
  *
- * The second issue is the SIGEV_NONE timer which may be active but is
- * not really ever put in the timer list (to save system resources).
- * This timer may be expired, and if so, we will do it here.  Otherwise
- * it is the same as a requeue pending timer WRT to what we should
- * report.
+ *  1) The timer has a requeue pending. The return value must appear as
+ *     if the timer has been requeued right now.
+ *
+ *  2) The timer is a SIGEV_NONE timer. These timers are never enqueued
+ *     into the hrtimer queue and therefore never expired. Emulate expiry
+ *     here taking #1 into account.
  */
 void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_settin=
g)
 {
@@ -681,8 +648,12 @@ void common_timer_get(struct k_itimer *timr, struct itim=
erspec64 *cur_setting)
 		cur_setting->it_interval =3D ktime_to_timespec64(iv);
 	} else if (!timr->it_active) {
 		/*
-		 * SIGEV_NONE oneshot timers are never queued. Check them
-		 * below.
+		 * SIGEV_NONE oneshot timers are never queued and therefore
+		 * timr->it_active is always false. The check below
+		 * vs. remaining time will handle this case.
+		 *
+		 * For all other timers there is nothing to update here, so
+		 * return.
 		 */
 		if (!sig_none)
 			return;
@@ -691,18 +662,29 @@ void common_timer_get(struct k_itimer *timr, struct iti=
merspec64 *cur_setting)
 	now =3D kc->clock_get_ktime(timr->it_clock);
=20
 	/*
-	 * When a requeue is pending or this is a SIGEV_NONE timer move the
-	 * expiry time forward by intervals, so expiry is > now.
+	 * If this is an interval timer and either has requeue pending or
+	 * is a SIGEV_NONE timer move the expiry time forward by intervals,
+	 * so expiry is > now.
 	 */
 	if (iv && (timr->it_requeue_pending & REQUEUE_PENDING || sig_none))
 		timr->it_overrun +=3D kc->timer_forward(timr, now);
=20
 	remaining =3D kc->timer_remaining(timr, now);
-	/* Return 0 only, when the timer is expired and not pending */
+	/*
+	 * As @now is retrieved before a possible timer_forward() and
+	 * cannot be reevaluated by the compiler @remaining is based on the
+	 * same @now value. Therefore @remaining is consistent vs. @now.
+	 *
+	 * Consequently all interval timers, i.e. @iv > 0, cannot have a
+	 * remaining time <=3D 0 because timer_forward() guarantees to move
+	 * them forward so that the next timer expiry is > @now.
+	 */
 	if (remaining <=3D 0) {
 		/*
-		 * A single shot SIGEV_NONE timer must return 0, when
-		 * it is expired !
+		 * A single shot SIGEV_NONE timer must return 0, when it is
+		 * expired! Timers which have a real signal delivery mode
+		 * must return a remaining time greater than 0 because the
+		 * signal has not yet been delivered.
 		 */
 		if (!sig_none)
 			cur_setting->it_value.tv_nsec =3D 1;
@@ -711,11 +693,10 @@ void common_timer_get(struct k_itimer *timr, struct iti=
merspec64 *cur_setting)
 	}
 }
=20
-/* Get the time remaining on a POSIX.1b interval timer. */
 static int do_timer_gettime(timer_t timer_id,  struct itimerspec64 *setting)
 {
-	struct k_itimer *timr;
 	const struct k_clock *kc;
+	struct k_itimer *timr;
 	unsigned long flags;
 	int ret =3D 0;
=20
@@ -765,20 +746,29 @@ SYSCALL_DEFINE2(timer_gettime32, timer_t, timer_id,
=20
 #endif
=20
-/*
- * Get the number of overruns of a POSIX.1b interval timer.  This is to
- * be the overrun of the timer last delivered.  At the same time we are
- * accumulating overruns on the next timer.  The overrun is frozen when
- * the signal is delivered, either at the notify time (if the info block
- * is not queued) or at the actual delivery time (as we are informed by
- * the call back to posixtimer_rearm().  So all we need to do is
- * to pick up the frozen overrun.
+/**
+ * sys_timer_getoverrun - Get the number of overruns of a POSIX.1b interval =
timer
+ * @timer_id:	The timer ID which identifies the timer
+ *
+ * The "overrun count" of a timer is one plus the number of expiration
+ * intervals which have elapsed between the first expiry, which queues the
+ * signal and the actual signal delivery. On signal delivery the "overrun
+ * count" is calculated and cached, so it can be returned directly here.
+ *
+ * As this is relative to the last queued signal the returned overrun count
+ * is meaningless outside of the signal delivery path and even there it
+ * does not accurately reflect the current state when user space evaluates
+ * it.
+ *
+ * Returns:
+ *	-EINVAL		@timer_id is invalid
+ *	1..INT_MAX	The number of overruns related to the last delivered signal
  */
 SYSCALL_DEFINE1(timer_getoverrun, timer_t, timer_id)
 {
 	struct k_itimer *timr;
-	int overrun;
 	unsigned long flags;
+	int overrun;
=20
 	timr =3D lock_timer(timer_id, &flags);
 	if (!timr)
@@ -831,10 +821,18 @@ static void common_timer_wait_running(struct k_itimer *=
timer)
 }
=20
 /*
- * On PREEMPT_RT this prevent priority inversion against softirq kthread in
- * case it gets preempted while executing a timer callback. See comments in
- * hrtimer_cancel_wait_running. For PREEMPT_RT=3Dn this just results in a
- * cpu_relax().
+ * On PREEMPT_RT this prevents priority inversion and a potential livelock
+ * against the ksoftirqd thread in case that ksoftirqd gets preempted while
+ * executing a hrtimer callback.
+ *
+ * See the comments in hrtimer_cancel_wait_running(). For PREEMPT_RT=3Dn this
+ * just results in a cpu_relax().
+ *
+ * For POSIX CPU timers with CONFIG_POSIX_CPU_TIMERS_TASK_WORK=3Dn this is
+ * just a cpu_relax(). With CONFIG_POSIX_CPU_TIMERS_TASK_WORK=3Dy this
+ * prevents spinning on an eventually scheduled out task and a livelock
+ * when the task which tries to delete or disarm the timer has preempted
+ * the task which runs the expiry in task work context.
  */
 static struct k_itimer *timer_wait_running(struct k_itimer *timer,
 					   unsigned long *flags)
@@ -943,8 +941,7 @@ SYSCALL_DEFINE4(timer_settime, timer_t, timer_id, int, fl=
ags,
 		const struct __kernel_itimerspec __user *, new_setting,
 		struct __kernel_itimerspec __user *, old_setting)
 {
-	struct itimerspec64 new_spec, old_spec;
-	struct itimerspec64 *rtn =3D old_setting ? &old_spec : NULL;
+	struct itimerspec64 new_spec, old_spec, *rtn;
 	int error =3D 0;
=20
 	if (!new_setting)
@@ -953,6 +950,7 @@ SYSCALL_DEFINE4(timer_settime, timer_t, timer_id, int, fl=
ags,
 	if (get_itimerspec64(&new_spec, new_setting))
 		return -EFAULT;
=20
+	rtn =3D old_setting ? &old_spec : NULL;
 	error =3D do_timer_settime(timer_id, flags, &new_spec, rtn);
 	if (!error && old_setting) {
 		if (put_itimerspec64(&old_spec, old_setting))
@@ -1026,38 +1024,71 @@ SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
 	list_del(&timer->list);
 	spin_unlock(&current->sighand->siglock);
 	/*
-	 * This keeps any tasks waiting on the spin lock from thinking
-	 * they got something (see the lock code above).
+	 * A concurrent lookup could check timer::it_signal lockless. It
+	 * will reevaluate with timer::it_lock held and observe the NULL.
 	 */
-	timer->it_signal =3D NULL;
+	WRITE_ONCE(timer->it_signal, NULL);
=20
 	unlock_timer(timer, flags);
-	release_posix_timer(timer, IT_ID_SET);
+	posix_timer_unhash_and_free(timer);
 	return 0;
 }
=20
 /*
- * return timer owned by the process, used by exit_itimers
+ * Delete a timer if it is armed, remove it from the hash and schedule it
+ * for RCU freeing.
  */
 static void itimer_delete(struct k_itimer *timer)
 {
-retry_delete:
-	spin_lock_irq(&timer->it_lock);
+	unsigned long flags;
=20
+	/*
+	 * irqsave is required to make timer_wait_running() work.
+	 */
+	spin_lock_irqsave(&timer->it_lock, flags);
+
+retry_delete:
+	/*
+	 * Even if the timer is not longer accessible from other tasks
+	 * it still might be armed and queued in the underlying timer
+	 * mechanism. Worse, that timer mechanism might run the expiry
+	 * function concurrently.
+	 */
 	if (timer_delete_hook(timer) =3D=3D TIMER_RETRY) {
-		spin_unlock_irq(&timer->it_lock);
+		/*
+		 * Timer is expired concurrently, prevent livelocks
+		 * and pointless spinning on RT.
+		 *
+		 * timer_wait_running() drops timer::it_lock, which opens
+		 * the possibility for another task to delete the timer.
+		 *
+		 * That's not possible here because this is invoked from
+		 * do_exit() only for the last thread of the thread group.
+		 * So no other task can access and delete that timer.
+		 */
+		if (WARN_ON_ONCE(timer_wait_running(timer, &flags) !=3D timer))
+			return;
+
 		goto retry_delete;
 	}
 	list_del(&timer->list);
=20
-	spin_unlock_irq(&timer->it_lock);
-	release_posix_timer(timer, IT_ID_SET);
+	/*
+	 * Setting timer::it_signal to NULL is technically not required
+	 * here as nothing can access the timer anymore legitimately via
+	 * the hash table. Set it to NULL nevertheless so that all deletion
+	 * paths are consistent.
+	 */
+	WRITE_ONCE(timer->it_signal, NULL);
+
+	spin_unlock_irqrestore(&timer->it_lock, flags);
+	posix_timer_unhash_and_free(timer);
 }
=20
 /*
- * This is called by do_exit or de_thread, only when nobody else can
- * modify the signal->posix_timers list. Yet we need sighand->siglock
- * to prevent the race with /proc/pid/timers.
+ * Invoked from do_exit() when the last thread of a thread group exits.
+ * At that point no other task can access the timers of the dying
+ * task anymore.
  */
 void exit_itimers(struct task_struct *tsk)
 {
@@ -1067,10 +1098,12 @@ void exit_itimers(struct task_struct *tsk)
 	if (list_empty(&tsk->signal->posix_timers))
 		return;
=20
+	/* Protect against concurrent read via /proc/$PID/timers */
 	spin_lock_irq(&tsk->sighand->siglock);
 	list_replace_init(&tsk->signal->posix_timers, &timers);
 	spin_unlock_irq(&tsk->sighand->siglock);
=20
+	/* The timers are not longer accessible via tsk::signal */
 	while (!list_empty(&timers)) {
 		tmr =3D list_first_entry(&timers, struct k_itimer, list);
 		itimer_delete(tmr);
@@ -1089,6 +1122,10 @@ SYSCALL_DEFINE2(clock_settime, const clockid_t, which_=
clock,
 	if (get_timespec64(&new_tp, tp))
 		return -EFAULT;
=20
+	/*
+	 * Permission checks have to be done inside the clock specific
+	 * setter callback.
+	 */
 	return kc->clock_set(which_clock, &new_tp);
 }
=20
@@ -1139,6 +1176,79 @@ SYSCALL_DEFINE2(clock_adjtime, const clockid_t, which_=
clock,
 	return err;
 }
=20
+/**
+ * sys_clock_getres - Get the resolution of a clock
+ * @which_clock:	The clock to get the resolution for
+ * @tp:			Pointer to a a user space timespec64 for storage
+ *
+ * POSIX defines:
+ *
+ * "The clock_getres() function shall return the resolution of any
+ * clock. Clock resolutions are implementation-defined and cannot be set by
+ * a process. If the argument res is not NULL, the resolution of the
+ * specified clock shall be stored in the location pointed to by res. If
+ * res is NULL, the clock resolution is not returned. If the time argument
+ * of clock_settime() is not a multiple of res, then the value is truncated
+ * to a multiple of res."
+ *
+ * Due to the various hardware constraints the real resolution can vary
+ * wildly and even change during runtime when the underlying devices are
+ * replaced. The kernel also can use hardware devices with different
+ * resolutions for reading the time and for arming timers.
+ *
+ * The kernel therefore deviates from the POSIX spec in various aspects:
+ *
+ * 1) The resolution returned to user space
+ *
+ *    For CLOCK_REALTIME, CLOCK_MONOTONIC, CLOCK_BOOTTIME, CLOCK_TAI,
+ *    CLOCK_REALTIME_ALARM, CLOCK_BOOTTIME_ALAREM and CLOCK_MONOTONIC_RAW
+ *    the kernel differentiates only two cases:
+ *
+ *    I)  Low resolution mode:
+ *
+ *	  When high resolution timers are disabled at compile or runtime
+ *	  the resolution returned is nanoseconds per tick, which represents
+ *	  the precision at which timers expire.
+ *
+ *    II) High resolution mode:
+ *
+ *	  When high resolution timers are enabled the resolution returned
+ *	  is always one nanosecond independent of the actual resolution of
+ *	  the underlying hardware devices.
+ *
+ *	  For CLOCK_*_ALARM the actual resolution depends on system
+ *	  state. When system is running the resolution is the same as the
+ *	  resolution of the other clocks. During suspend the actual
+ *	  resolution is the resolution of the underlying RTC device which
+ *	  might be way less precise than the clockevent device used during
+ *	  running state.
+ *
+ *   For CLOCK_REALTIME_COARSE and CLOCK_MONOTONIC_COARSE the resolution
+ *   returned is always nanoseconds per tick.
+ *
+ *   For CLOCK_PROCESS_CPUTIME and CLOCK_THREAD_CPUTIME the resolution
+ *   returned is always one nanosecond under the assumption that the
+ *   underlying scheduler clock has a better resolution than nanoseconds
+ *   per tick.
+ *
+ *   For dynamic POSIX clocks (PTP devices) the resolution returned is
+ *   always one nanosecond.
+ *
+ * 2) Affect on sys_clock_settime()
+ *
+ *    The kernel does not truncate the time which is handed in to
+ *    sys_clock_settime(). The kernel internal timekeeping is always using
+ *    nanoseconds precision independent of the clocksource device which is
+ *    used to read the time from. The resolution of that device only
+ *    affects the presicion of the time returned by sys_clock_gettime().
+ *
+ * Returns:
+ *	0		Success. @tp contains the resolution
+ *	-EINVAL		@which_clock is not a valid clock ID
+ *	-EFAULT		Copying the resolution to @tp faulted
+ *	-ENODEV		Dynamic POSIX clock is not backed by a device
+ *	-EOPNOTSUPP	Dynamic POSIX clock does not support getres()
+ */
 SYSCALL_DEFINE2(clock_getres, const clockid_t, which_clock,
 		struct __kernel_timespec __user *, tp)
 {
@@ -1230,7 +1340,7 @@ SYSCALL_DEFINE2(clock_getres_time32, clockid_t, which_c=
lock,
 #endif
=20
 /*
- * nanosleep for monotonic and realtime clocks
+ * sys_clock_nanosleep() for CLOCK_REALTIME and CLOCK_TAI
  */
 static int common_nsleep(const clockid_t which_clock, int flags,
 			 const struct timespec64 *rqtp)
@@ -1242,8 +1352,13 @@ static int common_nsleep(const clockid_t which_clock, =
int flags,
 				 which_clock);
 }
=20
+/*
+ * sys_clock_nanosleep() for CLOCK_MONOTONIC and CLOCK_BOOTTIME
+ *
+ * Absolute nanosleeps for these clocks are time-namespace adjusted.
+ */
 static int common_nsleep_timens(const clockid_t which_clock, int flags,
-			 const struct timespec64 *rqtp)
+				const struct timespec64 *rqtp)
 {
 	ktime_t texp =3D timespec64_to_ktime(*rqtp);
=20
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 52254679ec48..89055050d1ac 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1030,7 +1030,7 @@ static bool report_idle_softirq(void)
 			return false;
 	}
=20
-	if (ratelimit < 10)
+	if (ratelimit >=3D 10)
 		return false;
=20
 	/* On RT, softirqs handling may be waiting on some lock */

