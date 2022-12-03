Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA490641490
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 07:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiLCGr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 01:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbiLCGrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 01:47:15 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD27B9562
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 22:47:08 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso10309562pjt.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 22:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQ9IGI0lvZd7sZdyMXj+WfEZS/rd3xjWPGVeKqKVEKY=;
        b=khI0UAtGVRIHMK20x75fbuHaK/TByq9dz4IucaM3ozOd+XebigOFovFp7VGm39XRyY
         EWgOh4GPnsWIvlbv/s9I6i7rHzNwhlHb5keP3re+A/qMwMdP9c1uLYgzBc8VLOzN2vfy
         Duc6avSgI+ilmEcWrkku563Bq3ILmBYrmOoMOwJoUn8lae0JmvDSlowHTOzY2AjrO3e/
         fN67jxBq3ygOVJ0XYAcC4z4/7x59KALOavwYx8QwlhZ3OHasDBhp5yBBwzcFB3Zirugu
         t/CsAi/6XPpnfRepF69gNCuAHryhpjWozj51iFb2YeYuAXdFxPsCFk+jtmwTWTBCSWWm
         583A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQ9IGI0lvZd7sZdyMXj+WfEZS/rd3xjWPGVeKqKVEKY=;
        b=M7PnmYqyZDw9hSm4AMyKj6j+pmuN1Z6xJRhFpUPLDD7eWBrVGooRYUz2sVn3CrKw3/
         AORBJaFAeEvB1rMN3yiEP/vQ3iMd5reRFP1X7G7OlCXNaRnJMPjAnMqK+yMZuO04ENq9
         jyjQ1uFWDjNCLyShgRuA75gyjyO5zWHZR+TVLO8WfQ6YLHVEKJ/4vFAlpzhiAjHadfNC
         JoMf5W2m1ao/nug0JFKvb2X9n85kRKPI6afHbv14pm9V/d6iB0OpSmZB/7jtKxiHItKR
         HGqjw+cEsiMVYcak05WAiNDg8qlS7y9+SYkw4Aa5RE36J3Iif+R5DpNA4Jt6n0iYQgSs
         CKoQ==
X-Gm-Message-State: ANoB5plj/hxUH0mfgx/M7BayXbvExkDp44QfDJ6oSTg3YufPdAkORgQX
        dekrvbfomApLwhqPOSNxs/MRJw==
X-Google-Smtp-Source: AA0mqf5C52Hz8wdvP0PUmhevITwFWnVOeIVLX1QegvmS1nPbjLZ8ARL6fPh6kZACMzUWA5AaJ5mAXw==
X-Received: by 2002:a17:90b:2d85:b0:213:258d:68ef with SMTP id sj5-20020a17090b2d8500b00213258d68efmr79431631pjb.235.1670050027815;
        Fri, 02 Dec 2022 22:47:07 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id t17-20020aa79471000000b00575c8242849sm6102091pfq.69.2022.12.02.22.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 22:47:07 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v15 4/9] RISC-V: Treat IPIs as normal Linux IRQs
Date:   Sat,  3 Dec 2022 12:16:24 +0530
Message-Id: <20221203064629.1601299-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221203064629.1601299-1-apatel@ventanamicro.com>
References: <20221203064629.1601299-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the RISC-V kernel provides arch specific hooks (i.e.
struct riscv_ipi_ops) to register IPI handling methods. The stats
gathering of IPIs is also arch specific in the RISC-V kernel.

Other architectures (such as ARM, ARM64, and MIPS) have moved away
from custom arch specific IPI handling methods. Currently, these
architectures have Linux irqchip drivers providing a range of Linux
IRQ numbers to be used as IPIs and IPI triggering is done using
generic IPI APIs. This approach allows architectures to treat IPIs
as normal Linux IRQs and IPI stats gathering is done by the generic
Linux IRQ subsystem.

We extend the RISC-V IPI handling as-per above approach so that arch
specific IPI handling methods (struct riscv_ipi_ops) can be removed
and the IPI handling is done through the Linux IRQ subsystem.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/Kconfig                |   2 +
 arch/riscv/include/asm/sbi.h      |  10 +-
 arch/riscv/include/asm/smp.h      |  35 ++++---
 arch/riscv/kernel/Makefile        |   1 +
 arch/riscv/kernel/cpu-hotplug.c   |   3 +-
 arch/riscv/kernel/irq.c           |   3 +-
 arch/riscv/kernel/sbi-ipi.c       |  77 +++++++++++++++
 arch/riscv/kernel/sbi.c           | 106 +++-----------------
 arch/riscv/kernel/smp.c           | 155 +++++++++++++++---------------
 arch/riscv/kernel/smpboot.c       |   5 +-
 drivers/clocksource/timer-clint.c |  65 ++++++++++---
 drivers/irqchip/Kconfig           |   1 +
 drivers/irqchip/irq-riscv-intc.c  |  55 +++++------
 13 files changed, 283 insertions(+), 235 deletions(-)
 create mode 100644 arch/riscv/kernel/sbi-ipi.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c0e22648bd16..2fc20a189425 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -61,6 +61,8 @@ config RISCV
 	select GENERIC_GETTIMEOFDAY if HAVE_GENERIC_VDSO
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IOREMAP if MMU
+	select GENERIC_IRQ_IPI if SMP
+	select GENERIC_IRQ_IPI_MUX if SMP
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 2a0ef738695e..73e603428d68 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -268,8 +268,7 @@ long sbi_get_marchid(void);
 long sbi_get_mimpid(void);
 void sbi_set_timer(uint64_t stime_value);
 void sbi_shutdown(void);
-void sbi_clear_ipi(void);
-int sbi_send_ipi(const struct cpumask *cpu_mask);
+void sbi_send_ipi(unsigned int cpu);
 int sbi_remote_fence_i(const struct cpumask *cpu_mask);
 int sbi_remote_sfence_vma(const struct cpumask *cpu_mask,
 			   unsigned long start,
@@ -327,4 +326,11 @@ int sbi_err_map_linux_errno(int err);
 static inline int sbi_remote_fence_i(const struct cpumask *cpu_mask) { return -1; }
 static inline void sbi_init(void) {}
 #endif /* CONFIG_RISCV_SBI */
+
+#if IS_ENABLED(CONFIG_SMP) && IS_ENABLED(CONFIG_RISCV_SBI)
+void sbi_ipi_init(void);
+#else
+static inline void sbi_ipi_init(void) { }
+#endif
+
 #endif /* _ASM_RISCV_SBI_H */
diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index d3443be7eedc..79ed0b73cd4e 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -15,11 +15,6 @@
 struct seq_file;
 extern unsigned long boot_cpu_hartid;
 
-struct riscv_ipi_ops {
-	void (*ipi_inject)(const struct cpumask *target);
-	void (*ipi_clear)(void);
-};
-
 #ifdef CONFIG_SMP
 /*
  * Mapping between linux logical cpu index and hartid.
@@ -33,9 +28,6 @@ void show_ipi_stats(struct seq_file *p, int prec);
 /* SMP initialization hook for setup_arch */
 void __init setup_smp(void);
 
-/* Called from C code, this handles an IPI. */
-void handle_IPI(struct pt_regs *regs);
-
 /* Hook for the generic smp_call_function_many() routine. */
 void arch_send_call_function_ipi_mask(struct cpumask *mask);
 
@@ -44,11 +36,17 @@ void arch_send_call_function_single_ipi(int cpu);
 
 int riscv_hartid_to_cpuid(unsigned long hartid);
 
-/* Set custom IPI operations */
-void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops);
+/* Enable IPI for CPU hotplug */
+void riscv_ipi_enable(void);
+
+/* Disable IPI for CPU hotplug */
+void riscv_ipi_disable(void);
 
-/* Clear IPI for current CPU */
-void riscv_clear_ipi(void);
+/* Check if IPI interrupt numbers are available */
+bool riscv_ipi_have_virq_range(void);
+
+/* Set the IPI interrupt numbers for arch (called by irqchip drivers) */
+void riscv_ipi_set_virq_range(int virq, int nr);
 
 /* Secondary hart entry */
 asmlinkage void smp_callin(void);
@@ -82,11 +80,20 @@ static inline unsigned long cpuid_to_hartid_map(int cpu)
 	return boot_cpu_hartid;
 }
 
-static inline void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops)
+static inline void riscv_ipi_enable(void)
 {
 }
 
-static inline void riscv_clear_ipi(void)
+static inline void riscv_ipi_disable(void)
+{
+}
+
+static inline bool riscv_ipi_have_virq_range(void)
+{
+	return false;
+}
+
+static inline void riscv_ipi_set_virq_range(int virq, int nr)
 {
 }
 
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index db6e4b1294ba..939f60f971a4 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -74,6 +74,7 @@ obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
 obj-$(CONFIG_HAVE_PERF_REGS)	+= perf_regs.o
 obj-$(CONFIG_RISCV_SBI)		+= sbi.o
 ifeq ($(CONFIG_RISCV_SBI), y)
+obj-$(CONFIG_SMP)		+= sbi-ipi.o
 obj-$(CONFIG_SMP) += cpu_ops_sbi.o
 endif
 obj-$(CONFIG_HOTPLUG_CPU)	+= cpu-hotplug.o
diff --git a/arch/riscv/kernel/cpu-hotplug.c b/arch/riscv/kernel/cpu-hotplug.c
index f7a832e3a1d1..39235cf50652 100644
--- a/arch/riscv/kernel/cpu-hotplug.c
+++ b/arch/riscv/kernel/cpu-hotplug.c
@@ -13,7 +13,7 @@
 #include <asm/irq.h>
 #include <asm/cpu_ops.h>
 #include <asm/numa.h>
-#include <asm/sbi.h>
+#include <asm/smp.h>
 
 bool cpu_has_hotplug(unsigned int cpu)
 {
@@ -43,6 +43,7 @@ int __cpu_disable(void)
 	remove_cpu_topology(cpu);
 	numa_remove_cpu(cpu);
 	set_cpu_online(cpu, false);
+	riscv_ipi_disable();
 	irq_migrate_all_off_this_cpu();
 
 	return ret;
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index 96d3171f0ca1..eb9a68a539e6 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -10,7 +10,7 @@
 #include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/seq_file.h>
-#include <asm/smp.h>
+#include <asm/sbi.h>
 
 static struct fwnode_handle *(*__get_intc_node)(void);
 
@@ -39,4 +39,5 @@ void __init init_IRQ(void)
 	irqchip_init();
 	if (!handle_arch_irq)
 		panic("No interrupt controller found.");
+	sbi_ipi_init();
 }
diff --git a/arch/riscv/kernel/sbi-ipi.c b/arch/riscv/kernel/sbi-ipi.c
new file mode 100644
index 000000000000..41981ab88493
--- /dev/null
+++ b/arch/riscv/kernel/sbi-ipi.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Multiplex several IPIs over a single HW IPI.
+ *
+ * Copyright (c) 2022 Ventana Micro Systems Inc.
+ */
+
+#define pr_fmt(fmt) "riscv: " fmt
+#include <linux/cpu.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <asm/sbi.h>
+
+static int sbi_ipi_virq;
+
+static void sbi_ipi_handle(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+
+	chained_irq_enter(chip, desc);
+
+	csr_clear(CSR_IP, IE_SIE);
+	ipi_mux_process();
+
+	chained_irq_exit(chip, desc);
+}
+
+static int sbi_ipi_starting_cpu(unsigned int cpu)
+{
+	enable_percpu_irq(sbi_ipi_virq, irq_get_trigger_type(sbi_ipi_virq));
+	return 0;
+}
+
+void __init sbi_ipi_init(void)
+{
+	int virq;
+	struct irq_domain *domain;
+
+	if (riscv_ipi_have_virq_range())
+		return;
+
+	domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(),
+					  DOMAIN_BUS_ANY);
+	if (!domain) {
+		pr_err("unable to find INTC IRQ domain\n");
+		return;
+	}
+
+	sbi_ipi_virq = irq_create_mapping(domain, RV_IRQ_SOFT);
+	if (!sbi_ipi_virq) {
+		pr_err("unable to create INTC IRQ mapping\n");
+		return;
+	}
+
+	virq = ipi_mux_create(BITS_PER_BYTE, sbi_send_ipi);
+	if (virq <= 0) {
+		pr_err("unable to create muxed IPIs\n");
+		irq_dispose_mapping(sbi_ipi_virq);
+		return;
+	}
+
+	irq_set_chained_handler(sbi_ipi_virq, sbi_ipi_handle);
+
+	/*
+	 * Don't disable IPI when CPU goes offline because
+	 * the masking/unmasking of virtual IPIs is done
+	 * via generic IPI-Mux
+	 */
+	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+			  "irqchip/sbi-ipi:starting",
+			  sbi_ipi_starting_cpu, NULL);
+
+	riscv_ipi_set_virq_range(virq, BITS_PER_BYTE);
+	pr_info("providing IPIs using SBI IPI extension\n");
+}
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index ac99a70ead6a..92b9b759ab3d 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -17,7 +17,7 @@ unsigned long sbi_spec_version __ro_after_init = SBI_SPEC_VERSION_DEFAULT;
 EXPORT_SYMBOL(sbi_spec_version);
 
 static void (*__sbi_set_timer)(uint64_t stime) __ro_after_init;
-static int (*__sbi_send_ipi)(const struct cpumask *cpu_mask) __ro_after_init;
+static void (*__sbi_send_ipi)(unsigned int cpu) __ro_after_init;
 static int (*__sbi_rfence)(int fid, const struct cpumask *cpu_mask,
 			   unsigned long start, unsigned long size,
 			   unsigned long arg4, unsigned long arg5) __ro_after_init;
@@ -130,17 +130,6 @@ void sbi_shutdown(void)
 }
 EXPORT_SYMBOL(sbi_shutdown);
 
-/**
- * sbi_clear_ipi() - Clear any pending IPIs for the calling hart.
- *
- * Return: None
- */
-void sbi_clear_ipi(void)
-{
-	sbi_ecall(SBI_EXT_0_1_CLEAR_IPI, 0, 0, 0, 0, 0, 0, 0);
-}
-EXPORT_SYMBOL(sbi_clear_ipi);
-
 /**
  * __sbi_set_timer_v01() - Program the timer for next timer event.
  * @stime_value: The value after which next timer event should fire.
@@ -157,17 +146,12 @@ static void __sbi_set_timer_v01(uint64_t stime_value)
 #endif
 }
 
-static int __sbi_send_ipi_v01(const struct cpumask *cpu_mask)
+static void __sbi_send_ipi_v01(unsigned int cpu)
 {
-	unsigned long hart_mask;
-
-	if (!cpu_mask || cpumask_empty(cpu_mask))
-		cpu_mask = cpu_online_mask;
-	hart_mask = __sbi_v01_cpumask_to_hartmask(cpu_mask);
-
+	unsigned long hart_mask =
+		__sbi_v01_cpumask_to_hartmask(cpumask_of(cpu));
 	sbi_ecall(SBI_EXT_0_1_SEND_IPI, 0, (unsigned long)(&hart_mask),
 		  0, 0, 0, 0, 0);
-	return 0;
 }
 
 static int __sbi_rfence_v01(int fid, const struct cpumask *cpu_mask,
@@ -216,12 +200,10 @@ static void __sbi_set_timer_v01(uint64_t stime_value)
 		sbi_major_version(), sbi_minor_version());
 }
 
-static int __sbi_send_ipi_v01(const struct cpumask *cpu_mask)
+static void __sbi_send_ipi_v01(unsigned int cpu)
 {
 	pr_warn("IPI extension is not available in SBI v%lu.%lu\n",
 		sbi_major_version(), sbi_minor_version());
-
-	return 0;
 }
 
 static int __sbi_rfence_v01(int fid, const struct cpumask *cpu_mask,
@@ -248,55 +230,18 @@ static void __sbi_set_timer_v02(uint64_t stime_value)
 #endif
 }
 
-static int __sbi_send_ipi_v02(const struct cpumask *cpu_mask)
+static void __sbi_send_ipi_v02(unsigned int cpu)
 {
-	unsigned long hartid, cpuid, hmask = 0, hbase = 0, htop = 0;
-	struct sbiret ret = {0};
 	int result;
+	struct sbiret ret = {0};
 
-	if (!cpu_mask || cpumask_empty(cpu_mask))
-		cpu_mask = cpu_online_mask;
-
-	for_each_cpu(cpuid, cpu_mask) {
-		hartid = cpuid_to_hartid_map(cpuid);
-		if (hmask) {
-			if (hartid + BITS_PER_LONG <= htop ||
-			    hbase + BITS_PER_LONG <= hartid) {
-				ret = sbi_ecall(SBI_EXT_IPI,
-						SBI_EXT_IPI_SEND_IPI, hmask,
-						hbase, 0, 0, 0, 0);
-				if (ret.error)
-					goto ecall_failed;
-				hmask = 0;
-			} else if (hartid < hbase) {
-				/* shift the mask to fit lower hartid */
-				hmask <<= hbase - hartid;
-				hbase = hartid;
-			}
-		}
-		if (!hmask) {
-			hbase = hartid;
-			htop = hartid;
-		} else if (hartid > htop) {
-			htop = hartid;
-		}
-		hmask |= BIT(hartid - hbase);
-	}
-
-	if (hmask) {
-		ret = sbi_ecall(SBI_EXT_IPI, SBI_EXT_IPI_SEND_IPI,
-				hmask, hbase, 0, 0, 0, 0);
-		if (ret.error)
-			goto ecall_failed;
+	ret = sbi_ecall(SBI_EXT_IPI, SBI_EXT_IPI_SEND_IPI,
+			1UL, cpuid_to_hartid_map(cpu), 0, 0, 0, 0);
+	if (ret.error) {
+		result = sbi_err_map_linux_errno(ret.error);
+		pr_err("%s: hbase = [%lu] failed (error [%d])\n",
+			__func__, cpuid_to_hartid_map(cpu), result);
 	}
-
-	return 0;
-
-ecall_failed:
-	result = sbi_err_map_linux_errno(ret.error);
-	pr_err("%s: hbase = [%lu] hmask = [0x%lx] failed (error [%d])\n",
-	       __func__, hbase, hmask, result);
-	return result;
 }
 
 static int __sbi_rfence_v02_call(unsigned long fid, unsigned long hmask,
@@ -410,13 +355,11 @@ void sbi_set_timer(uint64_t stime_value)
 
 /**
  * sbi_send_ipi() - Send an IPI to any hart.
- * @cpu_mask: A cpu mask containing all the target harts.
- *
- * Return: 0 on success, appropriate linux error code otherwise.
+ * @cpu: Logical id of the target CPU.
  */
-int sbi_send_ipi(const struct cpumask *cpu_mask)
+void sbi_send_ipi(unsigned int cpu)
 {
-	return __sbi_send_ipi(cpu_mask);
+	__sbi_send_ipi(cpu);
 }
 EXPORT_SYMBOL(sbi_send_ipi);
 
@@ -641,21 +584,6 @@ long sbi_get_mimpid(void)
 }
 EXPORT_SYMBOL_GPL(sbi_get_mimpid);
 
-static void sbi_send_cpumask_ipi(const struct cpumask *target)
-{
-	sbi_send_ipi(target);
-}
-
-static void sbi_ipi_clear(void)
-{
-	csr_clear(CSR_IP, IE_SIE);
-}
-
-static const struct riscv_ipi_ops sbi_ipi_ops = {
-	.ipi_inject = sbi_send_cpumask_ipi,
-	.ipi_clear = sbi_ipi_clear
-};
-
 void __init sbi_init(void)
 {
 	int ret;
@@ -702,6 +630,4 @@ void __init sbi_init(void)
 		__sbi_send_ipi	= __sbi_send_ipi_v01;
 		__sbi_rfence	= __sbi_rfence_v01;
 	}
-
-	riscv_set_ipi_ops(&sbi_ipi_ops);
 }
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index c56d67f53ea9..e8a20454d65b 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -12,14 +12,15 @@
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/percpu.h>
 #include <linux/profile.h>
 #include <linux/smp.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/delay.h>
+#include <linux/irq.h>
 #include <linux/irq_work.h>
 
-#include <asm/sbi.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 
@@ -41,11 +42,10 @@ void __init smp_setup_processor_id(void)
 	cpuid_to_hartid_map(0) = boot_cpu_hartid;
 }
 
-/* A collection of single bit ipi messages.  */
-static struct {
-	unsigned long stats[IPI_MAX] ____cacheline_aligned;
-	unsigned long bits ____cacheline_aligned;
-} ipi_data[NR_CPUS] __cacheline_aligned;
+static DEFINE_PER_CPU_READ_MOSTLY(int, ipi_dummy_dev);
+static int ipi_virq_base __ro_after_init;
+static int nr_ipi __ro_after_init = IPI_MAX;
+static struct irq_desc *ipi_desc[IPI_MAX] __read_mostly;
 
 int riscv_hartid_to_cpuid(unsigned long hartid)
 {
@@ -71,46 +71,14 @@ static void ipi_stop(void)
 		wait_for_interrupt();
 }
 
-static const struct riscv_ipi_ops *ipi_ops __ro_after_init;
-
-void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops)
-{
-	ipi_ops = ops;
-}
-EXPORT_SYMBOL_GPL(riscv_set_ipi_ops);
-
-void riscv_clear_ipi(void)
-{
-	if (ipi_ops && ipi_ops->ipi_clear)
-		ipi_ops->ipi_clear();
-}
-EXPORT_SYMBOL_GPL(riscv_clear_ipi);
-
 static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
 {
-	int cpu;
-
-	smp_mb__before_atomic();
-	for_each_cpu(cpu, mask)
-		set_bit(op, &ipi_data[cpu].bits);
-	smp_mb__after_atomic();
-
-	if (ipi_ops && ipi_ops->ipi_inject)
-		ipi_ops->ipi_inject(mask);
-	else
-		pr_warn("SMP: IPI inject method not available\n");
+	__ipi_send_mask(ipi_desc[op], mask);
 }
 
 static void send_ipi_single(int cpu, enum ipi_message_type op)
 {
-	smp_mb__before_atomic();
-	set_bit(op, &ipi_data[cpu].bits);
-	smp_mb__after_atomic();
-
-	if (ipi_ops && ipi_ops->ipi_inject)
-		ipi_ops->ipi_inject(cpumask_of(cpu));
-	else
-		pr_warn("SMP: IPI inject method not available\n");
+	__ipi_send_mask(ipi_desc[op], cpumask_of(cpu));
 }
 
 #ifdef CONFIG_IRQ_WORK
@@ -120,55 +88,88 @@ void arch_irq_work_raise(void)
 }
 #endif
 
-void handle_IPI(struct pt_regs *regs)
+static irqreturn_t handle_IPI(int irq, void *data)
+{
+	int ipi = irq - ipi_virq_base;
+
+	switch (ipi) {
+	case IPI_RESCHEDULE:
+		scheduler_ipi();
+		break;
+	case IPI_CALL_FUNC:
+		generic_smp_call_function_interrupt();
+		break;
+	case IPI_CPU_STOP:
+		ipi_stop();
+		break;
+	case IPI_IRQ_WORK:
+		irq_work_run();
+		break;
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
+	case IPI_TIMER:
+		tick_receive_broadcast();
+		break;
+#endif
+	default:
+		pr_warn("CPU%d: unhandled IPI%d\n", smp_processor_id(), ipi);
+		break;
+	};
+
+	return IRQ_HANDLED;
+}
+
+void riscv_ipi_enable(void)
 {
-	unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
-	unsigned long *stats = ipi_data[smp_processor_id()].stats;
+	int i;
 
-	riscv_clear_ipi();
+	if (WARN_ON_ONCE(!ipi_virq_base))
+		return;
 
-	while (true) {
-		unsigned long ops;
+	for (i = 0; i < nr_ipi; i++)
+		enable_percpu_irq(ipi_virq_base + i, 0);
+}
 
-		/* Order bit clearing and data access. */
-		mb();
+void riscv_ipi_disable(void)
+{
+	int i;
 
-		ops = xchg(pending_ipis, 0);
-		if (ops == 0)
-			return;
+	if (WARN_ON_ONCE(!ipi_virq_base))
+		return;
 
-		if (ops & (1 << IPI_RESCHEDULE)) {
-			stats[IPI_RESCHEDULE]++;
-			scheduler_ipi();
-		}
+	for (i = 0; i < nr_ipi; i++)
+		disable_percpu_irq(ipi_virq_base + i);
+}
 
-		if (ops & (1 << IPI_CALL_FUNC)) {
-			stats[IPI_CALL_FUNC]++;
-			generic_smp_call_function_interrupt();
-		}
+bool riscv_ipi_have_virq_range(void)
+{
+	return (ipi_virq_base) ? true : false;
+}
 
-		if (ops & (1 << IPI_CPU_STOP)) {
-			stats[IPI_CPU_STOP]++;
-			ipi_stop();
-		}
+void riscv_ipi_set_virq_range(int virq, int nr)
+{
+	int i, err;
 
-		if (ops & (1 << IPI_IRQ_WORK)) {
-			stats[IPI_IRQ_WORK]++;
-			irq_work_run();
-		}
+	if (WARN_ON(ipi_virq_base))
+		return;
 
-#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
-		if (ops & (1 << IPI_TIMER)) {
-			stats[IPI_TIMER]++;
-			tick_receive_broadcast();
-		}
-#endif
-		BUG_ON((ops >> IPI_MAX) != 0);
+	WARN_ON(nr < IPI_MAX);
+	nr_ipi = min(nr, IPI_MAX);
+	ipi_virq_base = virq;
+
+	/* Request IPIs */
+	for (i = 0; i < nr_ipi; i++) {
+		err = request_percpu_irq(ipi_virq_base + i, handle_IPI,
+					 "IPI", &ipi_dummy_dev);
+		WARN_ON(err);
 
-		/* Order data access and bit testing. */
-		mb();
+		ipi_desc[i] = irq_to_desc(ipi_virq_base + i);
+		irq_set_status_flags(ipi_virq_base + i, IRQ_HIDDEN);
 	}
+
+	/* Enabled IPIs for boot CPU immediately */
+	riscv_ipi_enable();
 }
+EXPORT_SYMBOL_GPL(riscv_ipi_set_virq_range);
 
 static const char * const ipi_names[] = {
 	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
@@ -186,7 +187,7 @@ void show_ipi_stats(struct seq_file *p, int prec)
 		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
 			   prec >= 4 ? " " : "");
 		for_each_online_cpu(cpu)
-			seq_printf(p, "%10lu ", ipi_data[cpu].stats[i]);
+			seq_printf(p, "%10u ", irq_desc_kstat_cpu(ipi_desc[i], cpu));
 		seq_printf(p, " %s\n", ipi_names[i]);
 	}
 }
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 3373df413c88..9cbdb960515b 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -30,7 +30,6 @@
 #include <asm/numa.h>
 #include <asm/tlbflush.h>
 #include <asm/sections.h>
-#include <asm/sbi.h>
 #include <asm/smp.h>
 
 #include "head.h"
@@ -157,12 +156,12 @@ asmlinkage __visible void smp_callin(void)
 	struct mm_struct *mm = &init_mm;
 	unsigned int curr_cpuid = smp_processor_id();
 
-	riscv_clear_ipi();
-
 	/* All kernel threads share the same mm context.  */
 	mmgrab(mm);
 	current->active_mm = mm;
 
+	riscv_ipi_enable();
+
 	store_cpu_topology(curr_cpuid);
 	notify_cpu_starting(curr_cpuid);
 	numa_add_cpu(curr_cpuid);
diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
index 6cfe2ab73eb0..7ccc16dd6a76 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -17,6 +17,9 @@
 #include <linux/sched_clock.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
 #include <linux/of_irq.h>
 #include <linux/smp.h>
 #include <linux/timex.h>
@@ -31,6 +34,7 @@
 
 /* CLINT manages IPI and Timer for RISC-V M-mode  */
 static u32 __iomem *clint_ipi_base;
+static unsigned int clint_ipi_irq;
 static u64 __iomem *clint_timer_cmp;
 static u64 __iomem *clint_timer_val;
 static unsigned long clint_timer_freq;
@@ -41,12 +45,10 @@ u64 __iomem *clint_time_val;
 EXPORT_SYMBOL(clint_time_val);
 #endif
 
-static void clint_send_ipi(const struct cpumask *target)
+#ifdef CONFIG_SMP
+static void clint_send_ipi(unsigned int cpu)
 {
-	unsigned int cpu;
-
-	for_each_cpu(cpu, target)
-		writel(1, clint_ipi_base + cpuid_to_hartid_map(cpu));
+	writel(1, clint_ipi_base + cpuid_to_hartid_map(cpu));
 }
 
 static void clint_clear_ipi(void)
@@ -54,10 +56,18 @@ static void clint_clear_ipi(void)
 	writel(0, clint_ipi_base + cpuid_to_hartid_map(smp_processor_id()));
 }
 
-static struct riscv_ipi_ops clint_ipi_ops = {
-	.ipi_inject = clint_send_ipi,
-	.ipi_clear = clint_clear_ipi,
-};
+static void clint_ipi_interrupt(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+
+	chained_irq_enter(chip, desc);
+
+	clint_clear_ipi();
+	ipi_mux_process();
+
+	chained_irq_exit(chip, desc);
+}
+#endif
 
 #ifdef CONFIG_64BIT
 #define clint_get_cycles()	readq_relaxed(clint_timer_val)
@@ -125,12 +135,19 @@ static int clint_timer_starting_cpu(unsigned int cpu)
 
 	enable_percpu_irq(clint_timer_irq,
 			  irq_get_trigger_type(clint_timer_irq));
+	enable_percpu_irq(clint_ipi_irq,
+			  irq_get_trigger_type(clint_ipi_irq));
 	return 0;
 }
 
 static int clint_timer_dying_cpu(unsigned int cpu)
 {
 	disable_percpu_irq(clint_timer_irq);
+	/*
+	 * Don't disable IPI when CPU goes offline because
+	 * the masking/unmasking of virtual IPIs is done
+	 * via generic IPI-Mux
+	 */
 	return 0;
 }
 
@@ -170,6 +187,12 @@ static int __init clint_timer_init_dt(struct device_node *np)
 			return -ENODEV;
 		}
 
+		/* Find parent irq domain and map ipi irq */
+		if (!clint_ipi_irq &&
+		    oirq.args[0] == RV_IRQ_SOFT &&
+		    irq_find_host(oirq.np))
+			clint_ipi_irq = irq_of_parse_and_map(np, i);
+
 		/* Find parent irq domain and map timer irq */
 		if (!clint_timer_irq &&
 		    oirq.args[0] == RV_IRQ_TIMER &&
@@ -177,9 +200,9 @@ static int __init clint_timer_init_dt(struct device_node *np)
 			clint_timer_irq = irq_of_parse_and_map(np, i);
 	}
 
-	/* If CLINT timer irq not found then fail */
-	if (!clint_timer_irq) {
-		pr_err("%pOFP: timer irq not found\n", np);
+	/* If CLINT ipi or timer irq not found then fail */
+	if (!clint_ipi_irq || !clint_timer_irq) {
+		pr_err("%pOFP: ipi/timer irq not found\n", np);
 		return -ENODEV;
 	}
 
@@ -219,6 +242,19 @@ static int __init clint_timer_init_dt(struct device_node *np)
 		goto fail_iounmap;
 	}
 
+#ifdef CONFIG_SMP
+	rc = ipi_mux_create(BITS_PER_BYTE, clint_send_ipi);
+	if (rc <= 0) {
+		pr_err("unable to create muxed IPIs\n");
+		rc = (rc < 0) ? rc : -ENODEV;
+		goto fail_free_irq;
+	}
+
+	irq_set_chained_handler(clint_ipi_irq, clint_ipi_interrupt);
+	riscv_ipi_set_virq_range(rc, BITS_PER_BYTE);
+	clint_clear_ipi();
+#endif
+
 	rc = cpuhp_setup_state(CPUHP_AP_CLINT_TIMER_STARTING,
 				"clockevents/clint/timer:starting",
 				clint_timer_starting_cpu,
@@ -228,13 +264,10 @@ static int __init clint_timer_init_dt(struct device_node *np)
 		goto fail_free_irq;
 	}
 
-	riscv_set_ipi_ops(&clint_ipi_ops);
-	clint_clear_ipi();
-
 	return 0;
 
 fail_free_irq:
-	free_irq(clint_timer_irq, &clint_clock_event);
+	free_percpu_irq(clint_timer_irq, &clint_clock_event);
 fail_iounmap:
 	iounmap(base);
 	return rc;
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 7ef9f5e696d3..131379aa8424 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -540,6 +540,7 @@ config TI_PRUSS_INTC
 config RISCV_INTC
 	bool "RISC-V Local Interrupt Controller"
 	depends on RISCV
+	select IRQ_DOMAIN_HIERARCHY
 	default y
 	help
 	   This enables support for the per-HART local interrupt controller
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 9066467e99e4..784d25645704 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -26,20 +26,7 @@ static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
 	if (unlikely(cause >= BITS_PER_LONG))
 		panic("unexpected interrupt cause");
 
-	switch (cause) {
-#ifdef CONFIG_SMP
-	case RV_IRQ_SOFT:
-		/*
-		 * We only use software interrupts to pass IPIs, so if a
-		 * non-SMP system gets one, then we don't know what to do.
-		 */
-		handle_IPI(regs);
-		break;
-#endif
-	default:
-		generic_handle_domain_irq(intc_domain, cause);
-		break;
-	}
+	generic_handle_domain_irq(intc_domain, cause);
 }
 
 /*
@@ -59,18 +46,6 @@ static void riscv_intc_irq_unmask(struct irq_data *d)
 	csr_set(CSR_IE, BIT(d->hwirq));
 }
 
-static int riscv_intc_cpu_starting(unsigned int cpu)
-{
-	csr_set(CSR_IE, BIT(RV_IRQ_SOFT));
-	return 0;
-}
-
-static int riscv_intc_cpu_dying(unsigned int cpu)
-{
-	csr_clear(CSR_IE, BIT(RV_IRQ_SOFT));
-	return 0;
-}
-
 static struct irq_chip riscv_intc_chip = {
 	.name = "RISC-V INTC",
 	.irq_mask = riscv_intc_irq_mask,
@@ -87,9 +62,32 @@ static int riscv_intc_domain_map(struct irq_domain *d, unsigned int irq,
 	return 0;
 }
 
+static int riscv_intc_domain_alloc(struct irq_domain *domain,
+				   unsigned int virq, unsigned int nr_irqs,
+				   void *arg)
+{
+	int i, ret;
+	irq_hw_number_t hwirq;
+	unsigned int type = IRQ_TYPE_NONE;
+	struct irq_fwspec *fwspec = arg;
+
+	ret = irq_domain_translate_onecell(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++) {
+		ret = riscv_intc_domain_map(domain, virq + i, hwirq + i);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static const struct irq_domain_ops riscv_intc_domain_ops = {
 	.map	= riscv_intc_domain_map,
 	.xlate	= irq_domain_xlate_onecell,
+	.alloc	= riscv_intc_domain_alloc
 };
 
 static struct fwnode_handle *riscv_intc_hwnode(void)
@@ -133,11 +131,6 @@ static int __init riscv_intc_init(struct device_node *node,
 
 	riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
 
-	cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_STARTING,
-			  "irqchip/riscv/intc:starting",
-			  riscv_intc_cpu_starting,
-			  riscv_intc_cpu_dying);
-
 	pr_info("%d local interrupts mapped\n", BITS_PER_LONG);
 
 	return 0;
-- 
2.34.1

