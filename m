Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5388623886
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 02:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiKJBBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 20:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiKJBBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:01:22 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3BA5FF6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 17:01:19 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668042073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LZhDh1uahsd47jJNGhPV+SbjCcOYXWN6ABbFCp5N+hI=;
        b=Em3jFLIpa/fvxtBYEUNC1CmNd8EWRhTpmCj1rzHgvSRFkCmHsawbvlrE4uF3fzaf6WgCtT
        ++q2ndNi6unw0Djsvj8Hn5htfJxMnnT8/niQjl+AZInF2obyqKT+AQb9sC8Nsgdu1/bF2U
        0zsZQJNJeeCXih8W/8f2rQgaMBbD3jY=
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu
Subject: [PATCH] KVM: arm64: Move arch-specific headers out of include/kvm/
Date:   Thu, 10 Nov 2022 00:58:08 +0000
Message-Id: <20221110005812.3381334-1-oliver.upton@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Long ago in a galaxy far, far away, KVM was supported on both 32 bit and
64 bit arm architectures. A considerable portion of the code was shared
between these architectures, hence some headers needed to live in an
arch-generic path.

KVM/arm64 is the only supported arm KVM port now. Sweep some remaining
residue into the arch-specific include path.

No functional change intended.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
Change-Id: Iec1caf5a426fba5003abff2dc7f814e0ba398e00
---
 MAINTAINERS                                              | 1 -
 .../arm64/include/asm/kvm_arch_timer.h                   | 5 +++--
 arch/arm64/include/asm/kvm_host.h                        | 7 +++----
 .../arm64/include/asm/kvm_hypercalls.h                   | 4 ++--
 .../kvm/arm_pmu.h => arch/arm64/include/asm/kvm_pmu.h    | 5 +++--
 .../kvm/arm_psci.h => arch/arm64/include/asm/kvm_psci.h  | 6 +++---
 .../kvm/arm_vgic.h => arch/arm64/include/asm/kvm_vgic.h  | 4 ++--
 arch/arm64/kvm/arch_timer.c                              | 5 ++---
 arch/arm64/kvm/arm.c                                     | 9 ++++-----
 arch/arm64/kvm/guest.c                                   | 2 +-
 arch/arm64/kvm/handle_exit.c                             | 3 +--
 arch/arm64/kvm/hyp/include/hyp/switch.h                  | 3 +--
 arch/arm64/kvm/hyp/nvhe/switch.c                         | 3 +--
 arch/arm64/kvm/hyp/vhe/switch.c                          | 3 +--
 arch/arm64/kvm/hypercalls.c                              | 5 ++---
 arch/arm64/kvm/irq.h                                     | 7 +++----
 arch/arm64/kvm/pmu-emul.c                                | 4 ++--
 arch/arm64/kvm/psci.c                                    | 5 ++---
 arch/arm64/kvm/pvtime.c                                  | 3 +--
 arch/arm64/kvm/reset.c                                   | 3 +--
 arch/arm64/kvm/trace_arm.h                               | 2 +-
 arch/arm64/kvm/trng.c                                    | 3 +--
 arch/arm64/kvm/vgic/vgic-debug.c                         | 2 +-
 arch/arm64/kvm/vgic/vgic-init.c                          | 2 +-
 arch/arm64/kvm/vgic/vgic-irqfd.c                         | 2 +-
 arch/arm64/kvm/vgic/vgic-kvm-device.c                    | 2 +-
 arch/arm64/kvm/vgic/vgic-mmio-v2.c                       | 2 +-
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                       | 2 +-
 arch/arm64/kvm/vgic/vgic-mmio.c                          | 4 ++--
 arch/arm64/kvm/vgic/vgic-v2.c                            | 2 +-
 arch/arm64/kvm/vgic/vgic-v3.c                            | 4 ++--
 31 files changed, 51 insertions(+), 63 deletions(-)
 rename include/kvm/arm_arch_timer.h => arch/arm64/include/asm/kvm_arch_timer.h (96%)
 rename include/kvm/arm_hypercalls.h => arch/arm64/include/asm/kvm_hypercalls.h (94%)
 rename include/kvm/arm_pmu.h => arch/arm64/include/asm/kvm_pmu.h (98%)
 rename include/kvm/arm_psci.h => arch/arm64/include/asm/kvm_psci.h (91%)
 rename include/kvm/arm_vgic.h => arch/arm64/include/asm/kvm_vgic.h (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 379945f82a64..f7742e89e7b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11218,7 +11218,6 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git
 F:	arch/arm64/include/asm/kvm*
 F:	arch/arm64/include/uapi/asm/kvm*
 F:	arch/arm64/kvm/
-F:	include/kvm/arm_*
 F:	tools/testing/selftests/kvm/*/aarch64/
 F:	tools/testing/selftests/kvm/aarch64/
 
diff --git a/include/kvm/arm_arch_timer.h b/arch/arm64/include/asm/kvm_arch_timer.h
similarity index 96%
rename from include/kvm/arm_arch_timer.h
rename to arch/arm64/include/asm/kvm_arch_timer.h
index cd6d8f260eab..8982845a59d8 100644
--- a/include/kvm/arm_arch_timer.h
+++ b/arch/arm64/include/asm/kvm_arch_timer.h
@@ -4,11 +4,12 @@
  * Author: Marc Zyngier <marc.zyngier@arm.com>
  */
 
-#ifndef __ASM_ARM_KVM_ARCH_TIMER_H
-#define __ASM_ARM_KVM_ARCH_TIMER_H
+#ifndef __ARM64_KVM_ARCH_TIMER_H
+#define __ARM64_KVM_ARCH_TIMER_H
 
 #include <linux/clocksource.h>
 #include <linux/hrtimer.h>
+#include <linux/kvm.h>
 
 enum kvm_arch_timers {
 	TIMER_PTIMER,
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 45e2136322ba..e33ed7c09a28 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -25,16 +25,15 @@
 #include <asm/daifflags.h>
 #include <asm/fpsimd.h>
 #include <asm/kvm.h>
+#include <asm/kvm_arch_timer.h>
 #include <asm/kvm_asm.h>
+#include <asm/kvm_pmu.h>
+#include <asm/kvm_vgic.h>
 
 #define __KVM_HAVE_ARCH_INTC_INITIALIZED
 
 #define KVM_HALT_POLL_NS_DEFAULT 500000
 
-#include <kvm/arm_vgic.h>
-#include <kvm/arm_arch_timer.h>
-#include <kvm/arm_pmu.h>
-
 #define KVM_MAX_VCPUS VGIC_V3_MAX_CPUS
 
 #define KVM_VCPU_MAX_FEATURES 7
diff --git a/include/kvm/arm_hypercalls.h b/arch/arm64/include/asm/kvm_hypercalls.h
similarity index 94%
rename from include/kvm/arm_hypercalls.h
rename to arch/arm64/include/asm/kvm_hypercalls.h
index 1188f116cf4e..dfebe8dd8dcd 100644
--- a/include/kvm/arm_hypercalls.h
+++ b/arch/arm64/include/asm/kvm_hypercalls.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2019 Arm Ltd. */
 
-#ifndef __KVM_ARM_HYPERCALLS_H
-#define __KVM_ARM_HYPERCALLS_H
+#ifndef __ARM64_KVM_HYPERCALLS_H
+#define __ARM64_KVM_HYPERCALLS_H
 
 #include <asm/kvm_emulate.h>
 
diff --git a/include/kvm/arm_pmu.h b/arch/arm64/include/asm/kvm_pmu.h
similarity index 98%
rename from include/kvm/arm_pmu.h
rename to arch/arm64/include/asm/kvm_pmu.h
index c0b868ce6a8f..04a1a1565d4a 100644
--- a/include/kvm/arm_pmu.h
+++ b/arch/arm64/include/asm/kvm_pmu.h
@@ -4,9 +4,10 @@
  * Author: Shannon Zhao <shannon.zhao@linaro.org>
  */
 
-#ifndef __ASM_ARM_KVM_PMU_H
-#define __ASM_ARM_KVM_PMU_H
+#ifndef __ARM64_KVM_PMU_H
+#define __ARM64_KVM_PMU_H
 
+#include <linux/kvm.h>
 #include <linux/perf_event.h>
 #include <asm/perf_event.h>
 
diff --git a/include/kvm/arm_psci.h b/arch/arm64/include/asm/kvm_psci.h
similarity index 91%
rename from include/kvm/arm_psci.h
rename to arch/arm64/include/asm/kvm_psci.h
index 6e55b9283789..befec38c572a 100644
--- a/include/kvm/arm_psci.h
+++ b/arch/arm64/include/asm/kvm_psci.h
@@ -4,8 +4,8 @@
  * Author: Marc Zyngier <marc.zyngier@arm.com>
  */
 
-#ifndef __KVM_ARM_PSCI_H__
-#define __KVM_ARM_PSCI_H__
+#ifndef __ARM64_KVM_PSCI_H__
+#define __ARM64_KVM_PSCI_H__
 
 #include <linux/kvm_host.h>
 #include <uapi/linux/psci.h>
@@ -39,4 +39,4 @@ static inline int kvm_psci_version(struct kvm_vcpu *vcpu)
 
 int kvm_psci_call(struct kvm_vcpu *vcpu);
 
-#endif /* __KVM_ARM_PSCI_H__ */
+#endif /* __ARM64_KVM_PSCI_H__ */
diff --git a/include/kvm/arm_vgic.h b/arch/arm64/include/asm/kvm_vgic.h
similarity index 99%
rename from include/kvm/arm_vgic.h
rename to arch/arm64/include/asm/kvm_vgic.h
index 4df9e73a8bb5..2a261ca9f8ea 100644
--- a/include/kvm/arm_vgic.h
+++ b/arch/arm64/include/asm/kvm_vgic.h
@@ -2,8 +2,8 @@
 /*
  * Copyright (C) 2015, 2016 ARM Ltd.
  */
-#ifndef __KVM_ARM_VGIC_H
-#define __KVM_ARM_VGIC_H
+#ifndef __ARM64_KVM_VGIC_H
+#define __ARM64_KVM_VGIC_H
 
 #include <linux/bits.h>
 #include <linux/kvm.h>
diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
index bb24a76b4224..f99430a48e0e 100644
--- a/arch/arm64/kvm/arch_timer.c
+++ b/arch/arm64/kvm/arch_timer.c
@@ -14,11 +14,10 @@
 
 #include <clocksource/arm_arch_timer.h>
 #include <asm/arch_timer.h>
+#include <asm/kvm_arch_timer.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_hyp.h>
-
-#include <kvm/arm_vgic.h>
-#include <kvm/arm_arch_timer.h>
+#include <asm/kvm_vgic.h>
 
 #include "trace.h"
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 94d33e296e10..6f0b56e7f8c7 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -36,14 +36,13 @@
 #include <asm/virt.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_asm.h>
-#include <asm/kvm_mmu.h>
 #include <asm/kvm_emulate.h>
+#include <asm/kvm_hypercalls.h>
+#include <asm/kvm_mmu.h>
+#include <asm/kvm_pmu.h>
+#include <asm/kvm_psci.h>
 #include <asm/sections.h>
 
-#include <kvm/arm_hypercalls.h>
-#include <kvm/arm_pmu.h>
-#include <kvm/arm_psci.h>
-
 static enum kvm_mode kvm_mode = KVM_MODE_DEFAULT;
 DEFINE_STATIC_KEY_FALSE(kvm_protected_mode_initialized);
 
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 2ff13a3f8479..f60d7886df03 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -18,12 +18,12 @@
 #include <linux/string.h>
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
-#include <kvm/arm_hypercalls.h>
 #include <asm/cputype.h>
 #include <linux/uaccess.h>
 #include <asm/fpsimd.h>
 #include <asm/kvm.h>
 #include <asm/kvm_emulate.h>
+#include <asm/kvm_hypercalls.h>
 #include <asm/sigcontext.h>
 
 #include "trace.h"
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index e778eefcf214..cdfd7aef385e 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -15,13 +15,12 @@
 #include <asm/exception.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_emulate.h>
+#include <asm/kvm_hypercalls.h>
 #include <asm/kvm_mmu.h>
 #include <asm/debug-monitors.h>
 #include <asm/stacktrace/nvhe.h>
 #include <asm/traps.h>
 
-#include <kvm/arm_hypercalls.h>
-
 #define CREATE_TRACE_POINTS
 #include "trace_handle_exit.h"
 
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 6cbbb6c02f66..d033fc531ada 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -16,8 +16,6 @@
 #include <linux/jump_label.h>
 #include <uapi/linux/psci.h>
 
-#include <kvm/arm_psci.h>
-
 #include <asm/barrier.h>
 #include <asm/cpufeature.h>
 #include <asm/extable.h>
@@ -26,6 +24,7 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_hyp.h>
 #include <asm/kvm_mmu.h>
+#include <asm/kvm_psci.h>
 #include <asm/fpsimd.h>
 #include <asm/debug-monitors.h>
 #include <asm/processor.h>
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 8e9d49a964be..02a4f5d10de5 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -13,8 +13,6 @@
 #include <linux/jump_label.h>
 #include <uapi/linux/psci.h>
 
-#include <kvm/arm_psci.h>
-
 #include <asm/barrier.h>
 #include <asm/cpufeature.h>
 #include <asm/kprobes.h>
@@ -22,6 +20,7 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_hyp.h>
 #include <asm/kvm_mmu.h>
+#include <asm/kvm_psci.h>
 #include <asm/fpsimd.h>
 #include <asm/debug-monitors.h>
 #include <asm/processor.h>
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 7acb87eaa092..fe3db6a1cbac 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -13,8 +13,6 @@
 #include <linux/percpu.h>
 #include <uapi/linux/psci.h>
 
-#include <kvm/arm_psci.h>
-
 #include <asm/barrier.h>
 #include <asm/cpufeature.h>
 #include <asm/kprobes.h>
@@ -22,6 +20,7 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_hyp.h>
 #include <asm/kvm_mmu.h>
+#include <asm/kvm_psci.h>
 #include <asm/fpsimd.h>
 #include <asm/debug-monitors.h>
 #include <asm/processor.h>
diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index c9f401fa01a9..6804075ce57f 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -5,9 +5,8 @@
 #include <linux/kvm_host.h>
 
 #include <asm/kvm_emulate.h>
-
-#include <kvm/arm_hypercalls.h>
-#include <kvm/arm_psci.h>
+#include <asm/kvm_hypercalls.h>
+#include <asm/kvm_psci.h>
 
 #define KVM_ARM_SMCCC_STD_FEATURES				\
 	GENMASK(KVM_REG_ARM_STD_BMAP_BIT_COUNT - 1, 0)
diff --git a/arch/arm64/kvm/irq.h b/arch/arm64/kvm/irq.h
index 0d257de42c10..e79301e48938 100644
--- a/arch/arm64/kvm/irq.h
+++ b/arch/arm64/kvm/irq.h
@@ -3,14 +3,13 @@
  * irq.h: in kernel interrupt controller related definitions
  * Copyright (c) 2016 Red Hat, Inc.
  *
- * This header is included by irqchip.c. However, on ARM, interrupt
- * controller declarations are located in include/kvm/arm_vgic.h since
- * they are mostly shared between arm and arm64.
+ * This header is included by irqchip.c. However, on arm64, interrupt
+ * controller declarations are located in arch/arm64/include/asm/kvm_vgic.h
  */
 
 #ifndef __IRQ_H
 #define __IRQ_H
 
-#include <kvm/arm_vgic.h>
+#include <asm/kvm_vgic.h>
 
 #endif
diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 0003c7d37533..c370ffe41076 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -12,8 +12,8 @@
 #include <linux/perf/arm_pmu.h>
 #include <linux/uaccess.h>
 #include <asm/kvm_emulate.h>
-#include <kvm/arm_pmu.h>
-#include <kvm/arm_vgic.h>
+#include <asm/kvm_pmu.h>
+#include <asm/kvm_vgic.h>
 
 DEFINE_STATIC_KEY_FALSE(kvm_arm_pmu_available);
 
diff --git a/arch/arm64/kvm/psci.c b/arch/arm64/kvm/psci.c
index 7fbc4c1b9df0..809710808b25 100644
--- a/arch/arm64/kvm/psci.c
+++ b/arch/arm64/kvm/psci.c
@@ -12,9 +12,8 @@
 
 #include <asm/cputype.h>
 #include <asm/kvm_emulate.h>
-
-#include <kvm/arm_psci.h>
-#include <kvm/arm_hypercalls.h>
+#include <asm/kvm_hypercalls.h>
+#include <asm/kvm_psci.h>
 
 /*
  * This is an implementation of the Power State Coordination Interface
diff --git a/arch/arm64/kvm/pvtime.c b/arch/arm64/kvm/pvtime.c
index 78a09f7a6637..614b2e70b815 100644
--- a/arch/arm64/kvm/pvtime.c
+++ b/arch/arm64/kvm/pvtime.c
@@ -5,11 +5,10 @@
 #include <linux/kvm_host.h>
 #include <linux/sched/stat.h>
 
+#include <asm/kvm_hypercalls.h>
 #include <asm/kvm_mmu.h>
 #include <asm/pvclock-abi.h>
 
-#include <kvm/arm_hypercalls.h>
-
 void kvm_update_stolen_time(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 5ae18472205a..86321c968de7 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -17,12 +17,11 @@
 #include <linux/string.h>
 #include <linux/types.h>
 
-#include <kvm/arm_arch_timer.h>
-
 #include <asm/cpufeature.h>
 #include <asm/cputype.h>
 #include <asm/fpsimd.h>
 #include <asm/ptrace.h>
+#include <asm/kvm_arch_timer.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_emulate.h>
diff --git a/arch/arm64/kvm/trace_arm.h b/arch/arm64/kvm/trace_arm.h
index 33e4e7dd2719..a4028b46f22f 100644
--- a/arch/arm64/kvm/trace_arm.h
+++ b/arch/arm64/kvm/trace_arm.h
@@ -2,7 +2,7 @@
 #if !defined(_TRACE_ARM_ARM64_KVM_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_ARM_ARM64_KVM_H
 
-#include <kvm/arm_arch_timer.h>
+#include <asm/kvm_arch_timer.h>
 #include <linux/tracepoint.h>
 
 #undef TRACE_SYSTEM
diff --git a/arch/arm64/kvm/trng.c b/arch/arm64/kvm/trng.c
index 99bdd7103c9c..b257d4eace50 100644
--- a/arch/arm64/kvm/trng.c
+++ b/arch/arm64/kvm/trng.c
@@ -4,10 +4,9 @@
 #include <linux/arm-smccc.h>
 #include <linux/kvm_host.h>
 
+#include <asm/kvm_hypercalls.h>
 #include <asm/kvm_emulate.h>
 
-#include <kvm/arm_hypercalls.h>
-
 #define ARM_SMCCC_TRNG_VERSION_1_0	0x10000UL
 
 /* Those values are deliberately separate from the generic SMCCC definitions. */
diff --git a/arch/arm64/kvm/vgic/vgic-debug.c b/arch/arm64/kvm/vgic/vgic-debug.c
index 78cde687383c..a75d423b6c2e 100644
--- a/arch/arm64/kvm/vgic/vgic-debug.c
+++ b/arch/arm64/kvm/vgic/vgic-debug.c
@@ -9,8 +9,8 @@
 #include <linux/interrupt.h>
 #include <linux/kvm_host.h>
 #include <linux/seq_file.h>
-#include <kvm/arm_vgic.h>
 #include <asm/kvm_mmu.h>
+#include <asm/kvm_vgic.h>
 #include "vgic.h"
 
 /*
diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
index f6d4f4052555..7adc0beae769 100644
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -7,9 +7,9 @@
 #include <linux/interrupt.h>
 #include <linux/cpu.h>
 #include <linux/kvm_host.h>
-#include <kvm/arm_vgic.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_mmu.h>
+#include <asm/kvm_vgic.h>
 #include "vgic.h"
 
 /*
diff --git a/arch/arm64/kvm/vgic/vgic-irqfd.c b/arch/arm64/kvm/vgic/vgic-irqfd.c
index 475059bacedf..c2005f85a614 100644
--- a/arch/arm64/kvm/vgic/vgic-irqfd.c
+++ b/arch/arm64/kvm/vgic/vgic-irqfd.c
@@ -5,8 +5,8 @@
 
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
+#include <asm/kvm_vgic.h>
 #include <trace/events/kvm.h>
-#include <kvm/arm_vgic.h>
 #include "vgic.h"
 
 /**
diff --git a/arch/arm64/kvm/vgic/vgic-kvm-device.c b/arch/arm64/kvm/vgic/vgic-kvm-device.c
index edeac2380591..3d628f4916f3 100644
--- a/arch/arm64/kvm/vgic/vgic-kvm-device.c
+++ b/arch/arm64/kvm/vgic/vgic-kvm-device.c
@@ -6,7 +6,7 @@
  * Author: Marc Zyngier <marc.zyngier@arm.com>
  */
 #include <linux/kvm_host.h>
-#include <kvm/arm_vgic.h>
+#include <asm/kvm_vgic.h>
 #include <linux/uaccess.h>
 #include <asm/kvm_mmu.h>
 #include <asm/cputype.h>
diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v2.c b/arch/arm64/kvm/vgic/vgic-mmio-v2.c
index e070cda86e12..682a5a86c512 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v2.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v2.c
@@ -7,9 +7,9 @@
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
 #include <linux/nospec.h>
+#include <asm/kvm_vgic.h>
 
 #include <kvm/iodev.h>
-#include <kvm/arm_vgic.h>
 
 #include "vgic.h"
 #include "vgic-mmio.h"
diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 91201f743033..96a2a3460c3f 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -8,8 +8,8 @@
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
 #include <linux/interrupt.h>
+#include <asm/kvm_vgic.h>
 #include <kvm/iodev.h>
-#include <kvm/arm_vgic.h>
 
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_arm.h>
diff --git a/arch/arm64/kvm/vgic/vgic-mmio.c b/arch/arm64/kvm/vgic/vgic-mmio.c
index b32d434c1d4a..046a65485ce9 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio.c
@@ -9,9 +9,9 @@
 #include <linux/irq.h>
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
+#include <asm/kvm_arch_timer.h>
+#include <asm/kvm_vgic.h>
 #include <kvm/iodev.h>
-#include <kvm/arm_arch_timer.h>
-#include <kvm/arm_vgic.h>
 
 #include "vgic.h"
 #include "vgic-mmio.h"
diff --git a/arch/arm64/kvm/vgic/vgic-v2.c b/arch/arm64/kvm/vgic/vgic-v2.c
index 645648349c99..2a803be83b4b 100644
--- a/arch/arm64/kvm/vgic/vgic-v2.c
+++ b/arch/arm64/kvm/vgic/vgic-v2.c
@@ -6,7 +6,7 @@
 #include <linux/irqchip/arm-gic.h>
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
-#include <kvm/arm_vgic.h>
+#include <asm/kvm_vgic.h>
 #include <asm/kvm_mmu.h>
 
 #include "vgic.h"
diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
index 826ff6f2a4e7..f904447fc740 100644
--- a/arch/arm64/kvm/vgic/vgic-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-v3.c
@@ -5,10 +5,10 @@
 #include <linux/irqdomain.h>
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
-#include <kvm/arm_vgic.h>
+#include <asm/kvm_asm.h>
 #include <asm/kvm_hyp.h>
 #include <asm/kvm_mmu.h>
-#include <asm/kvm_asm.h>
+#include <asm/kvm_vgic.h>
 
 #include "vgic.h"
 

base-commit: 30a0b95b1335e12efef89dd78518ed3e4a71a763
-- 
2.38.1.431.g37b22c650d-goog

