Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F8E6ED428
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjDXSNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjDXSNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:13:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA004C03
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:13:28 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682360007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=5sjVCOTOKGYRbG6sN/eB48N/lr9EVJZJBYkiv7M5Xtk=;
        b=crCBb33rNTQwC2r/kIJQ//fkPQbfblrSkp+F+69SMbhp39firjtqFIkJdlhE0KTfabwQd4
        0N84vilNU1P3scJrmtccbHAlR5O3ik/GRZLcclX0Ol9O+ac1DTOjfqBCBD/yqdkk50dIly
        +SisVGXk0MiHS2sLOc/K98Y6+dqs5ecc7P0jBY8bZhWG5sJMor9FX+4DglujcaDLb5Hkx6
        ETRGBtHwGB3N1V14j7xU2OVNzDCSj+/oeHp9gQ+oifr1vq1MSXjtyVL8jT/85FK3JoRuS2
        ExwIszlj08ni7auFv0SMU7sNEHaFq9/bS+ALBjKI3/DDDKUlaVZ0p+4IRYuf0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682360007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=5sjVCOTOKGYRbG6sN/eB48N/lr9EVJZJBYkiv7M5Xtk=;
        b=6MQhgk3mRc2sr+JJRXGfLNksi2WYIs0nUwH9yDndM520W+O+CUWvkza3g2XkK/s5i2+elO
        6tATPS+L+glmhKBQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/core for 6.4-rc1
References: <168235968801.840202.17752066425816055574.tglx@xen13>
Message-ID: <168235969096.840202.4914424488387974308.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 24 Apr 2023 20:13:26 +0200 (CEST)
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

please pull the latest irq/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2023-04=
-24

up to:  f37202aa6e5d: Merge tag 'irqchip-6.4' of git://git.kernel.org/pub/scm=
/linux/kernel/git/maz/arm-platforms into irq/core


Interrupt core and drivers updates:

 - Core:

   - Add tracepoints for tasklet callbacks which makes it possible to
     analyze individual tasklet functions instead of guess working
     from the overall duration of tasklet processing

   - Ensure that secondary interrupt threads have their affinity adjusted
     correctly.

 - Drivers:

   - A large rework of the RISC-V IPI management to prepare for a new
     RISC-V interrupt architecture

   - Small fixes and enhancements all over the place

   - Removal of support for various obsolete hardware platforms and the
     related code

Thanks,

	tglx

------------------>
Alain Volmat (1):
      irqchip/st: Remove stih415/stih416 and stid127 platforms support

Anup Patel (7):
      RISC-V: Clear SIP bit only when using SBI IPI operations
      irqchip/riscv-intc: Allow drivers to directly discover INTC hwnode
      RISC-V: Treat IPIs as normal Linux IRQs
      RISC-V: Allow marking IPIs as suitable for remote FENCEs
      RISC-V: Use IPIs for remote TLB flush when possible
      RISC-V: Use IPIs for remote icache flush when possible
      irqchip/riscv-intc: Add empty irq_eoi() for chained irq handlers

Jianmin Lv (5):
      irqchip/loongson-eiointc: Fix returned value on parsing MADT
      irqchip/loongson-eiointc: Fix incorrect use of acpi_get_vec_parent
      irqchip/loongson-eiointc: Fix registration of syscore_ops
      irqchip/loongson-pch-pic: Fix registration of syscore_ops
      irqchip/loongson-pch-pic: Fix pch_pic_acpi_init calling

John Keeping (1):
      genirq: Update affinity of secondary threads

Lingutla Chandrasekhar (1):
      softirq: Add trace points for tasklet entry/exit

Marc Zyngier (1):
      irqchip/gic: Drop support for board files

Mason Huo (1):
      irqchip/irq-sifive-plic: Add syscore callbacks for hibernation

Rob Herring (1):
      irqchip: Use of_property_read_bool() for boolean properties

Sebastian Reichel (1):
      irqchip/gic-v3: Add Rockchip 3588001 erratum workaround

Shanker Donthineni (1):
      irqchip/gicv3: Workaround for NVIDIA erratum T241-FABRIC-4

=C3=81lvaro Fern=C3=A1ndez Rojas (1):
      irqchip/bcm-6345-l1: Request memory region


 Documentation/arm64/silicon-errata.rst |   5 +
 arch/arm64/Kconfig                     |  10 ++
 arch/riscv/Kconfig                     |   2 +
 arch/riscv/include/asm/irq.h           |   4 +
 arch/riscv/include/asm/sbi.h           |   9 +-
 arch/riscv/include/asm/smp.h           |  49 +++++++---
 arch/riscv/kernel/Makefile             |   1 +
 arch/riscv/kernel/cpu-hotplug.c        |   3 +-
 arch/riscv/kernel/irq.c                |  21 +++-
 arch/riscv/kernel/sbi-ipi.c            |  77 +++++++++++++++
 arch/riscv/kernel/sbi.c                | 100 +++----------------
 arch/riscv/kernel/smp.c                | 171 +++++++++++++++++--------------=
--
 arch/riscv/kernel/smpboot.c            |   5 +-
 arch/riscv/mm/cacheflush.c             |   5 +-
 arch/riscv/mm/tlbflush.c               |  93 +++++++++++++++---
 drivers/clocksource/timer-clint.c      |  65 ++++++++++---
 drivers/firmware/smccc/smccc.c         |  26 +++++
 drivers/firmware/smccc/soc_id.c        |  28 +-----
 drivers/irqchip/Kconfig                |   3 +
 drivers/irqchip/irq-bcm6345-l1.c       |   6 +-
 drivers/irqchip/irq-csky-apb-intc.c    |   2 +-
 drivers/irqchip/irq-gic-v2m.c          |   2 +-
 drivers/irqchip/irq-gic-v3-its.c       |  35 +++++++
 drivers/irqchip/irq-gic-v3.c           | 115 +++++++++++++++++++---
 drivers/irqchip/irq-gic.c              |  60 +-----------
 drivers/irqchip/irq-loongson-eiointc.c |  32 ++++--
 drivers/irqchip/irq-loongson-pch-pic.c |   6 +-
 drivers/irqchip/irq-riscv-intc.c       |  71 ++++++++------
 drivers/irqchip/irq-sifive-plic.c      |  93 +++++++++++++++++-
 drivers/irqchip/irq-st.c               |  15 ---
 include/linux/arm-smccc.h              |  18 ++++
 include/linux/irqchip/arm-gic.h        |   6 --
 include/trace/events/irq.h             |  47 +++++++++
 kernel/irq/manage.c                    |   5 +-
 kernel/softirq.c                       |   9 +-
 35 files changed, 819 insertions(+), 380 deletions(-)
 create mode 100644 arch/riscv/kernel/sbi-ipi.c

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/sil=
icon-errata.rst
index ec5f889d7681..9e311bc43e05 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -172,6 +172,8 @@ stable kernels.
 +----------------+-----------------+-----------------+----------------------=
-------+
 | NVIDIA         | Carmel Core     | N/A             | NVIDIA_CARMEL_CNP_ERR=
ATUM   |
 +----------------+-----------------+-----------------+----------------------=
-------+
+| NVIDIA         | T241 GICv3/4.x  | T241-FABRIC-4   | N/A                  =
       |
++----------------+-----------------+-----------------+----------------------=
-------+
 +----------------+-----------------+-----------------+----------------------=
-------+
 | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585  =
       |
 +----------------+-----------------+-----------------+----------------------=
-------+
@@ -205,6 +207,9 @@ stable kernels.
 +----------------+-----------------+-----------------+----------------------=
-------+
 | Qualcomm Tech. | Kryo4xx Gold    | N/A             | ARM64_ERRATUM_1286807=
       |
 +----------------+-----------------+-----------------+----------------------=
-------+
++----------------+-----------------+-----------------+----------------------=
-------+
+| Rockchip       | RK3588          | #3588001        | ROCKCHIP_ERRATUM_3588=
001    |
++----------------+-----------------+-----------------+----------------------=
-------+
=20
 +----------------+-----------------+-----------------+----------------------=
-------+
 | Fujitsu        | A64FX           | E#010001        | FUJITSU_ERRATUM_01000=
1      |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1023e896d46b..02789215d251 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1150,6 +1150,16 @@ config NVIDIA_CARMEL_CNP_ERRATUM
=20
 	  If unsure, say Y.
=20
+config ROCKCHIP_ERRATUM_3588001
+	bool "Rockchip 3588001: GIC600 can not support shareability attributes"
+	default y
+	help
+	  The Rockchip RK3588 GIC600 SoC integration does not support ACE/ACE-lite.
+	  This means, that its sharability feature may not be used, even though it
+	  is supported by the IP itself.
+
+	  If unsure, say Y.
+
 config SOCIONEXT_SYNQUACER_PREITS
 	bool "Socionext Synquacer: Workaround for GICv3 pre-ITS"
 	default y
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index eb7f29a412f8..139055bcfcae 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -63,6 +63,8 @@ config RISCV
 	select GENERIC_GETTIMEOFDAY if HAVE_GENERIC_VDSO
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IOREMAP if MMU
+	select GENERIC_IRQ_IPI if SMP
+	select GENERIC_IRQ_IPI_MUX if SMP
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index e4c435509983..43b9ebfbd943 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -12,6 +12,10 @@
=20
 #include <asm-generic/irq.h>
=20
+void riscv_set_intc_hwnode_fn(struct fwnode_handle *(*fn)(void));
+
+struct fwnode_handle *riscv_get_intc_hwnode(void);
+
 extern void __init init_IRQ(void);
=20
 #endif /* _ASM_RISCV_IRQ_H */
diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 945b7be249c1..acab4410ef2a 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -271,8 +271,7 @@ long sbi_get_marchid(void);
 long sbi_get_mimpid(void);
 void sbi_set_timer(uint64_t stime_value);
 void sbi_shutdown(void);
-void sbi_clear_ipi(void);
-int sbi_send_ipi(const struct cpumask *cpu_mask);
+void sbi_send_ipi(unsigned int cpu);
 int sbi_remote_fence_i(const struct cpumask *cpu_mask);
 int sbi_remote_sfence_vma(const struct cpumask *cpu_mask,
 			   unsigned long start,
@@ -335,4 +334,10 @@ unsigned long riscv_cached_mvendorid(unsigned int cpu_id=
);
 unsigned long riscv_cached_marchid(unsigned int cpu_id);
 unsigned long riscv_cached_mimpid(unsigned int cpu_id);
=20
+#if IS_ENABLED(CONFIG_SMP) && IS_ENABLED(CONFIG_RISCV_SBI)
+void sbi_ipi_init(void);
+#else
+static inline void sbi_ipi_init(void) { }
+#endif
+
 #endif /* _ASM_RISCV_SBI_H */
diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 3831b638ecab..c4b77017ec58 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -15,12 +15,10 @@
 struct seq_file;
 extern unsigned long boot_cpu_hartid;
=20
-struct riscv_ipi_ops {
-	void (*ipi_inject)(const struct cpumask *target);
-	void (*ipi_clear)(void);
-};
-
 #ifdef CONFIG_SMP
+
+#include <linux/jump_label.h>
+
 /*
  * Mapping between linux logical cpu index and hartid.
  */
@@ -33,9 +31,6 @@ void show_ipi_stats(struct seq_file *p, int prec);
 /* SMP initialization hook for setup_arch */
 void __init setup_smp(void);
=20
-/* Called from C code, this handles an IPI. */
-void handle_IPI(struct pt_regs *regs);
-
 /* Hook for the generic smp_call_function_many() routine. */
 void arch_send_call_function_ipi_mask(struct cpumask *mask);
=20
@@ -44,11 +39,22 @@ void arch_send_call_function_single_ipi(int cpu);
=20
 int riscv_hartid_to_cpuid(unsigned long hartid);
=20
-/* Set custom IPI operations */
-void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops);
+/* Enable IPI for CPU hotplug */
+void riscv_ipi_enable(void);
+
+/* Disable IPI for CPU hotplug */
+void riscv_ipi_disable(void);
=20
-/* Clear IPI for current CPU */
-void riscv_clear_ipi(void);
+/* Check if IPI interrupt numbers are available */
+bool riscv_ipi_have_virq_range(void);
+
+/* Set the IPI interrupt numbers for arch (called by irqchip drivers) */
+void riscv_ipi_set_virq_range(int virq, int nr, bool use_for_rfence);
+
+/* Check if we can use IPIs for remote FENCEs */
+DECLARE_STATIC_KEY_FALSE(riscv_ipi_for_rfence);
+#define riscv_use_ipi_for_rfence() \
+	static_branch_unlikely(&riscv_ipi_for_rfence)
=20
 /* Check other CPUs stop or not */
 bool smp_crash_stop_failed(void);
@@ -85,14 +91,29 @@ static inline unsigned long cpuid_to_hartid_map(int cpu)
 	return boot_cpu_hartid;
 }
=20
-static inline void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops)
+static inline void riscv_ipi_enable(void)
+{
+}
+
+static inline void riscv_ipi_disable(void)
 {
 }
=20
-static inline void riscv_clear_ipi(void)
+static inline bool riscv_ipi_have_virq_range(void)
+{
+	return false;
+}
+
+static inline void riscv_ipi_set_virq_range(int virq, int nr,
+					    bool use_for_rfence)
 {
 }
=20
+static inline bool riscv_use_ipi_for_rfence(void)
+{
+	return false;
+}
+
 #endif /* CONFIG_SMP */
=20
 #if defined(CONFIG_HOTPLUG_CPU) && (CONFIG_SMP)
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 4cf303a779ab..67f542be1bea 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -74,6 +74,7 @@ obj-$(CONFIG_PERF_EVENTS)	+=3D perf_callchain.o
 obj-$(CONFIG_HAVE_PERF_REGS)	+=3D perf_regs.o
 obj-$(CONFIG_RISCV_SBI)		+=3D sbi.o
 ifeq ($(CONFIG_RISCV_SBI), y)
+obj-$(CONFIG_SMP)		+=3D sbi-ipi.o
 obj-$(CONFIG_SMP) +=3D cpu_ops_sbi.o
 endif
 obj-$(CONFIG_HOTPLUG_CPU)	+=3D cpu-hotplug.o
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
=20
 bool cpu_has_hotplug(unsigned int cpu)
 {
@@ -43,6 +43,7 @@ int __cpu_disable(void)
 	remove_cpu_topology(cpu);
 	numa_remove_cpu(cpu);
 	set_cpu_online(cpu, false);
+	riscv_ipi_disable();
 	irq_migrate_all_off_this_cpu();
=20
 	return ret;
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index 7207fa08d78f..eb9a68a539e6 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -7,8 +7,26 @@
=20
 #include <linux/interrupt.h>
 #include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
 #include <linux/seq_file.h>
-#include <asm/smp.h>
+#include <asm/sbi.h>
+
+static struct fwnode_handle *(*__get_intc_node)(void);
+
+void riscv_set_intc_hwnode_fn(struct fwnode_handle *(*fn)(void))
+{
+	__get_intc_node =3D fn;
+}
+
+struct fwnode_handle *riscv_get_intc_hwnode(void)
+{
+	if (__get_intc_node)
+		return __get_intc_node();
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(riscv_get_intc_hwnode);
=20
 int arch_show_interrupts(struct seq_file *p, int prec)
 {
@@ -21,4 +39,5 @@ void __init init_IRQ(void)
 	irqchip_init();
 	if (!handle_arch_irq)
 		panic("No interrupt controller found.");
+	sbi_ipi_init();
 }
diff --git a/arch/riscv/kernel/sbi-ipi.c b/arch/riscv/kernel/sbi-ipi.c
new file mode 100644
index 000000000000..a4559695ce62
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
+	struct irq_chip *chip =3D irq_desc_get_chip(desc);
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
+	domain =3D irq_find_matching_fwnode(riscv_get_intc_hwnode(),
+					  DOMAIN_BUS_ANY);
+	if (!domain) {
+		pr_err("unable to find INTC IRQ domain\n");
+		return;
+	}
+
+	sbi_ipi_virq =3D irq_create_mapping(domain, RV_IRQ_SOFT);
+	if (!sbi_ipi_virq) {
+		pr_err("unable to create INTC IRQ mapping\n");
+		return;
+	}
+
+	virq =3D ipi_mux_create(BITS_PER_BYTE, sbi_send_ipi);
+	if (virq <=3D 0) {
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
+	riscv_ipi_set_virq_range(virq, BITS_PER_BYTE, false);
+	pr_info("providing IPIs using SBI IPI extension\n");
+}
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 5c87db8fdff2..92b9b759ab3d 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -17,7 +17,7 @@ unsigned long sbi_spec_version __ro_after_init =3D SBI_SPEC=
_VERSION_DEFAULT;
 EXPORT_SYMBOL(sbi_spec_version);
=20
 static void (*__sbi_set_timer)(uint64_t stime) __ro_after_init;
-static int (*__sbi_send_ipi)(const struct cpumask *cpu_mask) __ro_after_init;
+static void (*__sbi_send_ipi)(unsigned int cpu) __ro_after_init;
 static int (*__sbi_rfence)(int fid, const struct cpumask *cpu_mask,
 			   unsigned long start, unsigned long size,
 			   unsigned long arg4, unsigned long arg5) __ro_after_init;
@@ -130,17 +130,6 @@ void sbi_shutdown(void)
 }
 EXPORT_SYMBOL(sbi_shutdown);
=20
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
=20
-static int __sbi_send_ipi_v01(const struct cpumask *cpu_mask)
+static void __sbi_send_ipi_v01(unsigned int cpu)
 {
-	unsigned long hart_mask;
-
-	if (!cpu_mask || cpumask_empty(cpu_mask))
-		cpu_mask =3D cpu_online_mask;
-	hart_mask =3D __sbi_v01_cpumask_to_hartmask(cpu_mask);
-
+	unsigned long hart_mask =3D
+		__sbi_v01_cpumask_to_hartmask(cpumask_of(cpu));
 	sbi_ecall(SBI_EXT_0_1_SEND_IPI, 0, (unsigned long)(&hart_mask),
 		  0, 0, 0, 0, 0);
-	return 0;
 }
=20
 static int __sbi_rfence_v01(int fid, const struct cpumask *cpu_mask,
@@ -216,12 +200,10 @@ static void __sbi_set_timer_v01(uint64_t stime_value)
 		sbi_major_version(), sbi_minor_version());
 }
=20
-static int __sbi_send_ipi_v01(const struct cpumask *cpu_mask)
+static void __sbi_send_ipi_v01(unsigned int cpu)
 {
 	pr_warn("IPI extension is not available in SBI v%lu.%lu\n",
 		sbi_major_version(), sbi_minor_version());
-
-	return 0;
 }
=20
 static int __sbi_rfence_v01(int fid, const struct cpumask *cpu_mask,
@@ -248,55 +230,18 @@ static void __sbi_set_timer_v02(uint64_t stime_value)
 #endif
 }
=20
-static int __sbi_send_ipi_v02(const struct cpumask *cpu_mask)
+static void __sbi_send_ipi_v02(unsigned int cpu)
 {
-	unsigned long hartid, cpuid, hmask =3D 0, hbase =3D 0, htop =3D 0;
-	struct sbiret ret =3D {0};
 	int result;
+	struct sbiret ret =3D {0};
=20
-	if (!cpu_mask || cpumask_empty(cpu_mask))
-		cpu_mask =3D cpu_online_mask;
-
-	for_each_cpu(cpuid, cpu_mask) {
-		hartid =3D cpuid_to_hartid_map(cpuid);
-		if (hmask) {
-			if (hartid + BITS_PER_LONG <=3D htop ||
-			    hbase + BITS_PER_LONG <=3D hartid) {
-				ret =3D sbi_ecall(SBI_EXT_IPI,
-						SBI_EXT_IPI_SEND_IPI, hmask,
-						hbase, 0, 0, 0, 0);
-				if (ret.error)
-					goto ecall_failed;
-				hmask =3D 0;
-			} else if (hartid < hbase) {
-				/* shift the mask to fit lower hartid */
-				hmask <<=3D hbase - hartid;
-				hbase =3D hartid;
-			}
-		}
-		if (!hmask) {
-			hbase =3D hartid;
-			htop =3D hartid;
-		} else if (hartid > htop) {
-			htop =3D hartid;
-		}
-		hmask |=3D BIT(hartid - hbase);
-	}
-
-	if (hmask) {
-		ret =3D sbi_ecall(SBI_EXT_IPI, SBI_EXT_IPI_SEND_IPI,
-				hmask, hbase, 0, 0, 0, 0);
-		if (ret.error)
-			goto ecall_failed;
+	ret =3D sbi_ecall(SBI_EXT_IPI, SBI_EXT_IPI_SEND_IPI,
+			1UL, cpuid_to_hartid_map(cpu), 0, 0, 0, 0);
+	if (ret.error) {
+		result =3D sbi_err_map_linux_errno(ret.error);
+		pr_err("%s: hbase =3D [%lu] failed (error [%d])\n",
+			__func__, cpuid_to_hartid_map(cpu), result);
 	}
-
-	return 0;
-
-ecall_failed:
-	result =3D sbi_err_map_linux_errno(ret.error);
-	pr_err("%s: hbase =3D [%lu] hmask =3D [0x%lx] failed (error [%d])\n",
-	       __func__, hbase, hmask, result);
-	return result;
 }
=20
 static int __sbi_rfence_v02_call(unsigned long fid, unsigned long hmask,
@@ -410,13 +355,11 @@ void sbi_set_timer(uint64_t stime_value)
=20
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
=20
@@ -641,15 +584,6 @@ long sbi_get_mimpid(void)
 }
 EXPORT_SYMBOL_GPL(sbi_get_mimpid);
=20
-static void sbi_send_cpumask_ipi(const struct cpumask *target)
-{
-	sbi_send_ipi(target);
-}
-
-static const struct riscv_ipi_ops sbi_ipi_ops =3D {
-	.ipi_inject =3D sbi_send_cpumask_ipi
-};
-
 void __init sbi_init(void)
 {
 	int ret;
@@ -696,6 +630,4 @@ void __init sbi_init(void)
 		__sbi_send_ipi	=3D __sbi_send_ipi_v01;
 		__sbi_rfence	=3D __sbi_rfence_v01;
 	}
-
-	riscv_set_ipi_ops(&sbi_ipi_ops);
 }
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 8c3b59f1f9b8..5f985a197eff 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -13,14 +13,15 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/kexec.h>
+#include <linux/percpu.h>
 #include <linux/profile.h>
 #include <linux/smp.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/delay.h>
+#include <linux/irq.h>
 #include <linux/irq_work.h>
=20
-#include <asm/sbi.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 #include <asm/cpu_ops.h>
@@ -44,11 +45,10 @@ void __init smp_setup_processor_id(void)
 	cpuid_to_hartid_map(0) =3D boot_cpu_hartid;
 }
=20
-/* A collection of single bit ipi messages.  */
-static struct {
-	unsigned long stats[IPI_MAX] ____cacheline_aligned;
-	unsigned long bits ____cacheline_aligned;
-} ipi_data[NR_CPUS] __cacheline_aligned;
+static DEFINE_PER_CPU_READ_MOSTLY(int, ipi_dummy_dev);
+static int ipi_virq_base __ro_after_init;
+static int nr_ipi __ro_after_init =3D IPI_MAX;
+static struct irq_desc *ipi_desc[IPI_MAX] __read_mostly;
=20
 int riscv_hartid_to_cpuid(unsigned long hartid)
 {
@@ -100,48 +100,14 @@ static inline void ipi_cpu_crash_stop(unsigned int cpu,=
 struct pt_regs *regs)
 }
 #endif
=20
-static const struct riscv_ipi_ops *ipi_ops __ro_after_init;
-
-void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops)
-{
-	ipi_ops =3D ops;
-}
-EXPORT_SYMBOL_GPL(riscv_set_ipi_ops);
-
-void riscv_clear_ipi(void)
-{
-	if (ipi_ops && ipi_ops->ipi_clear)
-		ipi_ops->ipi_clear();
-
-	csr_clear(CSR_IP, IE_SIE);
-}
-EXPORT_SYMBOL_GPL(riscv_clear_ipi);
-
 static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type =
op)
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
=20
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
=20
 #ifdef CONFIG_IRQ_WORK
@@ -151,59 +117,98 @@ void arch_irq_work_raise(void)
 }
 #endif
=20
-void handle_IPI(struct pt_regs *regs)
+static irqreturn_t handle_IPI(int irq, void *data)
 {
-	unsigned int cpu =3D smp_processor_id();
-	unsigned long *pending_ipis =3D &ipi_data[cpu].bits;
-	unsigned long *stats =3D ipi_data[cpu].stats;
+	int ipi =3D irq - ipi_virq_base;
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
+	case IPI_CPU_CRASH_STOP:
+		ipi_cpu_crash_stop(smp_processor_id(), get_irq_regs());
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
+	}
=20
-	riscv_clear_ipi();
+	return IRQ_HANDLED;
+}
=20
-	while (true) {
-		unsigned long ops;
+void riscv_ipi_enable(void)
+{
+	int i;
=20
-		/* Order bit clearing and data access. */
-		mb();
+	if (WARN_ON_ONCE(!ipi_virq_base))
+		return;
=20
-		ops =3D xchg(pending_ipis, 0);
-		if (ops =3D=3D 0)
-			return;
+	for (i =3D 0; i < nr_ipi; i++)
+		enable_percpu_irq(ipi_virq_base + i, 0);
+}
=20
-		if (ops & (1 << IPI_RESCHEDULE)) {
-			stats[IPI_RESCHEDULE]++;
-			scheduler_ipi();
-		}
+void riscv_ipi_disable(void)
+{
+	int i;
=20
-		if (ops & (1 << IPI_CALL_FUNC)) {
-			stats[IPI_CALL_FUNC]++;
-			generic_smp_call_function_interrupt();
-		}
+	if (WARN_ON_ONCE(!ipi_virq_base))
+		return;
=20
-		if (ops & (1 << IPI_CPU_STOP)) {
-			stats[IPI_CPU_STOP]++;
-			ipi_stop();
-		}
+	for (i =3D 0; i < nr_ipi; i++)
+		disable_percpu_irq(ipi_virq_base + i);
+}
=20
-		if (ops & (1 << IPI_CPU_CRASH_STOP)) {
-			ipi_cpu_crash_stop(cpu, get_irq_regs());
-		}
+bool riscv_ipi_have_virq_range(void)
+{
+	return (ipi_virq_base) ? true : false;
+}
=20
-		if (ops & (1 << IPI_IRQ_WORK)) {
-			stats[IPI_IRQ_WORK]++;
-			irq_work_run();
-		}
+DEFINE_STATIC_KEY_FALSE(riscv_ipi_for_rfence);
+EXPORT_SYMBOL_GPL(riscv_ipi_for_rfence);
=20
-#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
-		if (ops & (1 << IPI_TIMER)) {
-			stats[IPI_TIMER]++;
-			tick_receive_broadcast();
-		}
-#endif
-		BUG_ON((ops >> IPI_MAX) !=3D 0);
+void riscv_ipi_set_virq_range(int virq, int nr, bool use_for_rfence)
+{
+	int i, err;
+
+	if (WARN_ON(ipi_virq_base))
+		return;
+
+	WARN_ON(nr < IPI_MAX);
+	nr_ipi =3D min(nr, IPI_MAX);
+	ipi_virq_base =3D virq;
=20
-		/* Order data access and bit testing. */
-		mb();
+	/* Request IPIs */
+	for (i =3D 0; i < nr_ipi; i++) {
+		err =3D request_percpu_irq(ipi_virq_base + i, handle_IPI,
+					 "IPI", &ipi_dummy_dev);
+		WARN_ON(err);
+
+		ipi_desc[i] =3D irq_to_desc(ipi_virq_base + i);
+		irq_set_status_flags(ipi_virq_base + i, IRQ_HIDDEN);
 	}
+
+	/* Enabled IPIs for boot CPU immediately */
+	riscv_ipi_enable();
+
+	/* Update RFENCE static key */
+	if (use_for_rfence)
+		static_branch_enable(&riscv_ipi_for_rfence);
+	else
+		static_branch_disable(&riscv_ipi_for_rfence);
 }
=20
 static const char * const ipi_names[] =3D {
@@ -223,7 +228,7 @@ void show_ipi_stats(struct seq_file *p, int prec)
 		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
 			   prec >=3D 4 ? " " : "");
 		for_each_online_cpu(cpu)
-			seq_printf(p, "%10lu ", ipi_data[cpu].stats[i]);
+			seq_printf(p, "%10u ", irq_desc_kstat_cpu(ipi_desc[i], cpu));
 		seq_printf(p, " %s\n", ipi_names[i]);
 	}
 }
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index ddb2afba6d25..00b53913d4c6 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -30,7 +30,6 @@
 #include <asm/numa.h>
 #include <asm/tlbflush.h>
 #include <asm/sections.h>
-#include <asm/sbi.h>
 #include <asm/smp.h>
=20
 #include "head.h"
@@ -158,12 +157,12 @@ asmlinkage __visible void smp_callin(void)
 	struct mm_struct *mm =3D &init_mm;
 	unsigned int curr_cpuid =3D smp_processor_id();
=20
-	riscv_clear_ipi();
-
 	/* All kernel threads share the same mm context.  */
 	mmgrab(mm);
 	current->active_mm =3D mm;
=20
+	riscv_ipi_enable();
+
 	store_cpu_topology(curr_cpuid);
 	notify_cpu_starting(curr_cpuid);
 	numa_add_cpu(curr_cpuid);
diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index fcd6145fbead..20cec5e7cdbf 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -19,7 +19,7 @@ void flush_icache_all(void)
 {
 	local_flush_icache_all();
=20
-	if (IS_ENABLED(CONFIG_RISCV_SBI))
+	if (IS_ENABLED(CONFIG_RISCV_SBI) && !riscv_use_ipi_for_rfence())
 		sbi_remote_fence_i(NULL);
 	else
 		on_each_cpu(ipi_remote_fence_i, NULL, 1);
@@ -67,7 +67,8 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
 		 * with flush_icache_deferred().
 		 */
 		smp_mb();
-	} else if (IS_ENABLED(CONFIG_RISCV_SBI)) {
+	} else if (IS_ENABLED(CONFIG_RISCV_SBI) &&
+		   !riscv_use_ipi_for_rfence()) {
 		sbi_remote_fence_i(&others);
 	} else {
 		on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index ef701fa83f36..77be59aadc73 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -23,14 +23,62 @@ static inline void local_flush_tlb_page_asid(unsigned lon=
g addr,
 			: "memory");
 }
=20
+static inline void local_flush_tlb_range(unsigned long start,
+		unsigned long size, unsigned long stride)
+{
+	if (size <=3D stride)
+		local_flush_tlb_page(start);
+	else
+		local_flush_tlb_all();
+}
+
+static inline void local_flush_tlb_range_asid(unsigned long start,
+		unsigned long size, unsigned long stride, unsigned long asid)
+{
+	if (size <=3D stride)
+		local_flush_tlb_page_asid(start, asid);
+	else
+		local_flush_tlb_all_asid(asid);
+}
+
+static void __ipi_flush_tlb_all(void *info)
+{
+	local_flush_tlb_all();
+}
+
 void flush_tlb_all(void)
 {
-	sbi_remote_sfence_vma(NULL, 0, -1);
+	if (riscv_use_ipi_for_rfence())
+		on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
+	else
+		sbi_remote_sfence_vma(NULL, 0, -1);
+}
+
+struct flush_tlb_range_data {
+	unsigned long asid;
+	unsigned long start;
+	unsigned long size;
+	unsigned long stride;
+};
+
+static void __ipi_flush_tlb_range_asid(void *info)
+{
+	struct flush_tlb_range_data *d =3D info;
+
+	local_flush_tlb_range_asid(d->start, d->size, d->stride, d->asid);
+}
+
+static void __ipi_flush_tlb_range(void *info)
+{
+	struct flush_tlb_range_data *d =3D info;
+
+	local_flush_tlb_range(d->start, d->size, d->stride);
 }
=20
-static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
-				  unsigned long size, unsigned long stride)
+static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
+			      unsigned long size, unsigned long stride)
 {
+	struct flush_tlb_range_data ftd;
 	struct cpumask *cmask =3D mm_cpumask(mm);
 	unsigned int cpuid;
 	bool broadcast;
@@ -45,19 +93,34 @@ static void __sbi_tlb_flush_range(struct mm_struct *mm, u=
nsigned long start,
 		unsigned long asid =3D atomic_long_read(&mm->context.id) & asid_mask;
=20
 		if (broadcast) {
-			sbi_remote_sfence_vma_asid(cmask, start, size, asid);
-		} else if (size <=3D stride) {
-			local_flush_tlb_page_asid(start, asid);
+			if (riscv_use_ipi_for_rfence()) {
+				ftd.asid =3D asid;
+				ftd.start =3D start;
+				ftd.size =3D size;
+				ftd.stride =3D stride;
+				on_each_cpu_mask(cmask,
+						 __ipi_flush_tlb_range_asid,
+						 &ftd, 1);
+			} else
+				sbi_remote_sfence_vma_asid(cmask,
+							   start, size, asid);
 		} else {
-			local_flush_tlb_all_asid(asid);
+			local_flush_tlb_range_asid(start, size, stride, asid);
 		}
 	} else {
 		if (broadcast) {
-			sbi_remote_sfence_vma(cmask, start, size);
-		} else if (size <=3D stride) {
-			local_flush_tlb_page(start);
+			if (riscv_use_ipi_for_rfence()) {
+				ftd.asid =3D 0;
+				ftd.start =3D start;
+				ftd.size =3D size;
+				ftd.stride =3D stride;
+				on_each_cpu_mask(cmask,
+						 __ipi_flush_tlb_range,
+						 &ftd, 1);
+			} else
+				sbi_remote_sfence_vma(cmask, start, size);
 		} else {
-			local_flush_tlb_all();
+			local_flush_tlb_range(start, size, stride);
 		}
 	}
=20
@@ -66,23 +129,23 @@ static void __sbi_tlb_flush_range(struct mm_struct *mm, =
unsigned long start,
=20
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	__sbi_tlb_flush_range(mm, 0, -1, PAGE_SIZE);
+	__flush_tlb_range(mm, 0, -1, PAGE_SIZE);
 }
=20
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 {
-	__sbi_tlb_flush_range(vma->vm_mm, addr, PAGE_SIZE, PAGE_SIZE);
+	__flush_tlb_range(vma->vm_mm, addr, PAGE_SIZE, PAGE_SIZE);
 }
=20
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		     unsigned long end)
 {
-	__sbi_tlb_flush_range(vma->vm_mm, start, end - start, PAGE_SIZE);
+	__flush_tlb_range(vma->vm_mm, start, end - start, PAGE_SIZE);
 }
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end)
 {
-	__sbi_tlb_flush_range(vma->vm_mm, start, end - start, PMD_SIZE);
+	__flush_tlb_range(vma->vm_mm, start, end - start, PMD_SIZE);
 }
 #endif
diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-cl=
int.c
index 6cfe2ab73eb0..9a55e733ae99 100644
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
=20
 /* CLINT manages IPI and Timer for RISC-V M-mode  */
 static u32 __iomem *clint_ipi_base;
+static unsigned int clint_ipi_irq;
 static u64 __iomem *clint_timer_cmp;
 static u64 __iomem *clint_timer_val;
 static unsigned long clint_timer_freq;
@@ -41,12 +45,10 @@ u64 __iomem *clint_time_val;
 EXPORT_SYMBOL(clint_time_val);
 #endif
=20
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
=20
 static void clint_clear_ipi(void)
@@ -54,10 +56,18 @@ static void clint_clear_ipi(void)
 	writel(0, clint_ipi_base + cpuid_to_hartid_map(smp_processor_id()));
 }
=20
-static struct riscv_ipi_ops clint_ipi_ops =3D {
-	.ipi_inject =3D clint_send_ipi,
-	.ipi_clear =3D clint_clear_ipi,
-};
+static void clint_ipi_interrupt(struct irq_desc *desc)
+{
+	struct irq_chip *chip =3D irq_desc_get_chip(desc);
+
+	chained_irq_enter(chip, desc);
+
+	clint_clear_ipi();
+	ipi_mux_process();
+
+	chained_irq_exit(chip, desc);
+}
+#endif
=20
 #ifdef CONFIG_64BIT
 #define clint_get_cycles()	readq_relaxed(clint_timer_val)
@@ -125,12 +135,19 @@ static int clint_timer_starting_cpu(unsigned int cpu)
=20
 	enable_percpu_irq(clint_timer_irq,
 			  irq_get_trigger_type(clint_timer_irq));
+	enable_percpu_irq(clint_ipi_irq,
+			  irq_get_trigger_type(clint_ipi_irq));
 	return 0;
 }
=20
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
=20
@@ -170,6 +187,12 @@ static int __init clint_timer_init_dt(struct device_node=
 *np)
 			return -ENODEV;
 		}
=20
+		/* Find parent irq domain and map ipi irq */
+		if (!clint_ipi_irq &&
+		    oirq.args[0] =3D=3D RV_IRQ_SOFT &&
+		    irq_find_host(oirq.np))
+			clint_ipi_irq =3D irq_of_parse_and_map(np, i);
+
 		/* Find parent irq domain and map timer irq */
 		if (!clint_timer_irq &&
 		    oirq.args[0] =3D=3D RV_IRQ_TIMER &&
@@ -177,9 +200,9 @@ static int __init clint_timer_init_dt(struct device_node =
*np)
 			clint_timer_irq =3D irq_of_parse_and_map(np, i);
 	}
=20
-	/* If CLINT timer irq not found then fail */
-	if (!clint_timer_irq) {
-		pr_err("%pOFP: timer irq not found\n", np);
+	/* If CLINT ipi or timer irq not found then fail */
+	if (!clint_ipi_irq || !clint_timer_irq) {
+		pr_err("%pOFP: ipi/timer irq not found\n", np);
 		return -ENODEV;
 	}
=20
@@ -219,6 +242,19 @@ static int __init clint_timer_init_dt(struct device_node=
 *np)
 		goto fail_iounmap;
 	}
=20
+#ifdef CONFIG_SMP
+	rc =3D ipi_mux_create(BITS_PER_BYTE, clint_send_ipi);
+	if (rc <=3D 0) {
+		pr_err("unable to create muxed IPIs\n");
+		rc =3D (rc < 0) ? rc : -ENODEV;
+		goto fail_free_irq;
+	}
+
+	irq_set_chained_handler(clint_ipi_irq, clint_ipi_interrupt);
+	riscv_ipi_set_virq_range(rc, BITS_PER_BYTE, true);
+	clint_clear_ipi();
+#endif
+
 	rc =3D cpuhp_setup_state(CPUHP_AP_CLINT_TIMER_STARTING,
 				"clockevents/clint/timer:starting",
 				clint_timer_starting_cpu,
@@ -228,13 +264,10 @@ static int __init clint_timer_init_dt(struct device_nod=
e *np)
 		goto fail_free_irq;
 	}
=20
-	riscv_set_ipi_ops(&clint_ipi_ops);
-	clint_clear_ipi();
-
 	return 0;
=20
 fail_free_irq:
-	free_irq(clint_timer_irq, &clint_clock_event);
+	free_percpu_irq(clint_timer_irq, &clint_clock_event);
 fail_iounmap:
 	iounmap(base);
 	return rc;
diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smccc.c
index 60ccf3e90d7d..db818f9dcb8e 100644
--- a/drivers/firmware/smccc/smccc.c
+++ b/drivers/firmware/smccc/smccc.c
@@ -17,9 +17,13 @@ static enum arm_smccc_conduit smccc_conduit =3D SMCCC_COND=
UIT_NONE;
=20
 bool __ro_after_init smccc_trng_available =3D false;
 u64 __ro_after_init smccc_has_sve_hint =3D false;
+s32 __ro_after_init smccc_soc_id_version =3D SMCCC_RET_NOT_SUPPORTED;
+s32 __ro_after_init smccc_soc_id_revision =3D SMCCC_RET_NOT_SUPPORTED;
=20
 void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit condu=
it)
 {
+	struct arm_smccc_res res;
+
 	smccc_version =3D version;
 	smccc_conduit =3D conduit;
=20
@@ -27,6 +31,18 @@ void __init arm_smccc_version_init(u32 version, enum arm_s=
mccc_conduit conduit)
 	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
 	    smccc_version >=3D ARM_SMCCC_VERSION_1_3)
 		smccc_has_sve_hint =3D true;
+
+	if ((smccc_version >=3D ARM_SMCCC_VERSION_1_2) &&
+	    (smccc_conduit !=3D SMCCC_CONDUIT_NONE)) {
+		arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
+				     ARM_SMCCC_ARCH_SOC_ID, &res);
+		if ((s32)res.a0 >=3D 0) {
+			arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 0, &res);
+			smccc_soc_id_version =3D (s32)res.a0;
+			arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 1, &res);
+			smccc_soc_id_revision =3D (s32)res.a0;
+		}
+	}
 }
=20
 enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void)
@@ -44,6 +60,16 @@ u32 arm_smccc_get_version(void)
 }
 EXPORT_SYMBOL_GPL(arm_smccc_get_version);
=20
+s32 arm_smccc_get_soc_id_version(void)
+{
+	return smccc_soc_id_version;
+}
+
+s32 arm_smccc_get_soc_id_revision(void)
+{
+	return smccc_soc_id_revision;
+}
+
 static int __init smccc_devices_init(void)
 {
 	struct platform_device *pdev;
diff --git a/drivers/firmware/smccc/soc_id.c b/drivers/firmware/smccc/soc_id.c
index dd7c3d5e8b0b..890eb454599a 100644
--- a/drivers/firmware/smccc/soc_id.c
+++ b/drivers/firmware/smccc/soc_id.c
@@ -42,41 +42,23 @@ static int __init smccc_soc_init(void)
 	if (arm_smccc_get_version() < ARM_SMCCC_VERSION_1_2)
 		return 0;
=20
-	if (arm_smccc_1_1_get_conduit() =3D=3D SMCCC_CONDUIT_NONE) {
-		pr_err("%s: invalid SMCCC conduit\n", __func__);
-		return -EOPNOTSUPP;
-	}
-
-	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
-			     ARM_SMCCC_ARCH_SOC_ID, &res);
-
-	if ((int)res.a0 =3D=3D SMCCC_RET_NOT_SUPPORTED) {
+	soc_id_version =3D arm_smccc_get_soc_id_version();
+	if (soc_id_version =3D=3D SMCCC_RET_NOT_SUPPORTED) {
 		pr_info("ARCH_SOC_ID not implemented, skipping ....\n");
 		return 0;
 	}
=20
-	if ((int)res.a0 < 0) {
-		pr_info("ARCH_FEATURES(ARCH_SOC_ID) returned error: %lx\n",
-			res.a0);
-		return -EINVAL;
-	}
-
-	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 0, &res);
-	if ((int)res.a0 < 0) {
+	if (soc_id_version < 0) {
 		pr_err("ARCH_SOC_ID(0) returned error: %lx\n", res.a0);
 		return -EINVAL;
 	}
=20
-	soc_id_version =3D res.a0;
-
-	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 1, &res);
-	if ((int)res.a0 < 0) {
+	soc_id_rev =3D arm_smccc_get_soc_id_revision();
+	if (soc_id_rev < 0) {
 		pr_err("ARCH_SOC_ID(1) returned error: %lx\n", res.a0);
 		return -EINVAL;
 	}
=20
-	soc_id_rev =3D res.a0;
-
 	soc_dev_attr =3D kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
 	if (!soc_dev_attr)
 		return -ENOMEM;
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 7dc990eb2c9b..09e422da482f 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -7,6 +7,7 @@ config IRQCHIP
=20
 config ARM_GIC
 	bool
+	depends on OF
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
=20
@@ -35,6 +36,7 @@ config ARM_GIC_V3
 	select IRQ_DOMAIN_HIERARCHY
 	select PARTITION_PERCPU
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
+	select HAVE_ARM_SMCCC_DISCOVERY
=20
 config ARM_GIC_V3_ITS
 	bool
@@ -535,6 +537,7 @@ config TI_PRUSS_INTC
 config RISCV_INTC
 	bool
 	depends on RISCV
+	select IRQ_DOMAIN_HIERARCHY
=20
 config SIFIVE_PLIC
 	bool
diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l=
1.c
index 6899e37810a8..fa113cb2529a 100644
--- a/drivers/irqchip/irq-bcm6345-l1.c
+++ b/drivers/irqchip/irq-bcm6345-l1.c
@@ -257,6 +257,9 @@ static int __init bcm6345_l1_init_one(struct device_node =
*dn,
 	if (!cpu->map_base)
 		return -ENOMEM;
=20
+	if (!request_mem_region(res.start, sz, res.name))
+		pr_err("failed to request intc memory");
+
 	for (i =3D 0; i < n_words; i++) {
 		cpu->enable_cache[i] =3D 0;
 		__raw_writel(0, cpu->map_base + reg_enable(intc, i));
@@ -335,8 +338,7 @@ static int __init bcm6345_l1_of_init(struct device_node *=
dn,
 	for_each_cpu(idx, &intc->cpumask) {
 		struct bcm6345_l1_cpu *cpu =3D intc->cpus[idx];
=20
-		pr_info("  CPU%u at MMIO 0x%p (irq =3D %d)\n", idx,
-				cpu->map_base, cpu->parent_irq);
+		pr_info("  CPU%u (irq =3D %d)\n", idx, cpu->parent_irq);
 	}
=20
 	return 0;
diff --git a/drivers/irqchip/irq-csky-apb-intc.c b/drivers/irqchip/irq-csky-a=
pb-intc.c
index 42d8a2438ebc..6710691e4c25 100644
--- a/drivers/irqchip/irq-csky-apb-intc.c
+++ b/drivers/irqchip/irq-csky-apb-intc.c
@@ -68,7 +68,7 @@ static void __init ck_set_gc(struct device_node *node, void=
 __iomem *reg_base,
 	gc->chip_types[0].chip.irq_mask =3D irq_gc_mask_clr_bit;
 	gc->chip_types[0].chip.irq_unmask =3D irq_gc_mask_set_bit;
=20
-	if (of_find_property(node, "csky,support-pulse-signal", NULL))
+	if (of_property_read_bool(node, "csky,support-pulse-signal"))
 		gc->chip_types[0].chip.irq_unmask =3D irq_ck_mask_set_bit;
 }
=20
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index f1e75b35a52a..f2ff4387870d 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -421,7 +421,7 @@ static int __init gicv2m_of_init(struct fwnode_handle *pa=
rent_handle,
 		u32 spi_start =3D 0, nr_spis =3D 0;
 		struct resource res;
=20
-		if (!of_find_property(child, "msi-controller", NULL))
+		if (!of_property_read_bool(child, "msi-controller"))
 			continue;
=20
 		ret =3D of_address_to_resource(child, 0, &res);
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-it=
s.c
index 586271b8aa39..fa4641a5dfd8 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -42,9 +42,11 @@
 #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_23144	(1ULL << 2)
+#define ITS_FLAGS_FORCE_NON_SHAREABLE		(1ULL << 3)
=20
 #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
 #define RDIST_FLAGS_RD_TABLES_PREALLOCATED	(1 << 1)
+#define RDIST_FLAGS_FORCE_NON_SHAREABLE		(1 << 2)
=20
 #define RD_LOCAL_LPI_ENABLED                    BIT(0)
 #define RD_LOCAL_PENDTABLE_PREALLOCATED         BIT(1)
@@ -2359,6 +2361,9 @@ static int its_setup_baser(struct its_node *its, struct=
 its_baser *baser,
 	its_write_baser(its, baser, val);
 	tmp =3D baser->val;
=20
+	if (its->flags & ITS_FLAGS_FORCE_NON_SHAREABLE)
+		tmp &=3D ~GITS_BASER_SHAREABILITY_MASK;
+
 	if ((val ^ tmp) & GITS_BASER_SHAREABILITY_MASK) {
 		/*
 		 * Shareability didn't stick. Just use
@@ -3096,6 +3101,9 @@ static void its_cpu_init_lpis(void)
 	gicr_write_propbaser(val, rbase + GICR_PROPBASER);
 	tmp =3D gicr_read_propbaser(rbase + GICR_PROPBASER);
=20
+	if (gic_rdists->flags & RDIST_FLAGS_FORCE_NON_SHAREABLE)
+		tmp &=3D ~GICR_PROPBASER_SHAREABILITY_MASK;
+
 	if ((tmp ^ val) & GICR_PROPBASER_SHAREABILITY_MASK) {
 		if (!(tmp & GICR_PROPBASER_SHAREABILITY_MASK)) {
 			/*
@@ -3120,6 +3128,9 @@ static void its_cpu_init_lpis(void)
 	gicr_write_pendbaser(val, rbase + GICR_PENDBASER);
 	tmp =3D gicr_read_pendbaser(rbase + GICR_PENDBASER);
=20
+	if (gic_rdists->flags & RDIST_FLAGS_FORCE_NON_SHAREABLE)
+		tmp &=3D ~GICR_PENDBASER_SHAREABILITY_MASK;
+
 	if (!(tmp & GICR_PENDBASER_SHAREABILITY_MASK)) {
 		/*
 		 * The HW reports non-shareable, we must remove the
@@ -4710,6 +4721,19 @@ static bool __maybe_unused its_enable_quirk_hip07_1616=
00802(void *data)
 	return true;
 }
=20
+static bool __maybe_unused its_enable_rk3588001(void *data)
+{
+	struct its_node *its =3D data;
+
+	if (!of_machine_is_compatible("rockchip,rk3588"))
+		return false;
+
+	its->flags |=3D ITS_FLAGS_FORCE_NON_SHAREABLE;
+	gic_rdists->flags |=3D RDIST_FLAGS_FORCE_NON_SHAREABLE;
+
+	return true;
+}
+
 static const struct gic_quirk its_quirks[] =3D {
 #ifdef CONFIG_CAVIUM_ERRATUM_22375
 	{
@@ -4755,6 +4779,14 @@ static const struct gic_quirk its_quirks[] =3D {
 		.mask	=3D 0xffffffff,
 		.init	=3D its_enable_quirk_hip07_161600802,
 	},
+#endif
+#ifdef CONFIG_ROCKCHIP_ERRATUM_3588001
+	{
+		.desc   =3D "ITS: Rockchip erratum RK3588001",
+		.iidr   =3D 0x0201743b,
+		.mask   =3D 0xffffffff,
+		.init   =3D its_enable_rk3588001,
+	},
 #endif
 	{
 	}
@@ -5096,6 +5128,9 @@ static int __init its_probe_one(struct resource *res,
 	gits_write_cbaser(baser, its->base + GITS_CBASER);
 	tmp =3D gits_read_cbaser(its->base + GITS_CBASER);
=20
+	if (its->flags & ITS_FLAGS_FORCE_NON_SHAREABLE)
+		tmp &=3D ~GITS_CBASER_SHAREABILITY_MASK;
+
 	if ((tmp ^ baser) & GITS_CBASER_SHAREABILITY_MASK) {
 		if (!(tmp & GITS_CBASER_SHAREABILITY_MASK)) {
 			/*
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index fd134e1f481a..6fcee221f201 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -24,6 +24,9 @@
 #include <linux/irqchip/arm-gic-common.h>
 #include <linux/irqchip/arm-gic-v3.h>
 #include <linux/irqchip/irq-partition-percpu.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/arm-smccc.h>
=20
 #include <asm/cputype.h>
 #include <asm/exception.h>
@@ -47,6 +50,7 @@ struct redist_region {
=20
 struct gic_chip_data {
 	struct fwnode_handle	*fwnode;
+	phys_addr_t		dist_phys_base;
 	void __iomem		*dist_base;
 	struct redist_region	*redist_regions;
 	struct rdists		rdists;
@@ -59,6 +63,10 @@ struct gic_chip_data {
 	struct partition_desc	**ppi_descs;
 };
=20
+#define T241_CHIPS_MAX		4
+static void __iomem *t241_dist_base_alias[T241_CHIPS_MAX] __read_mostly;
+static DEFINE_STATIC_KEY_FALSE(gic_nvidia_t241_erratum);
+
 static struct gic_chip_data gic_data __read_mostly;
 static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
=20
@@ -179,6 +187,39 @@ static inline bool gic_irq_in_rdist(struct irq_data *d)
 	}
 }
=20
+static inline void __iomem *gic_dist_base_alias(struct irq_data *d)
+{
+	if (static_branch_unlikely(&gic_nvidia_t241_erratum)) {
+		irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
+		u32 chip;
+
+		/*
+		 * For the erratum T241-FABRIC-4, read accesses to GICD_In{E}
+		 * registers are directed to the chip that owns the SPI. The
+		 * the alias region can also be used for writes to the
+		 * GICD_In{E} except GICD_ICENABLERn. Each chip has support
+		 * for 320 {E}SPIs. Mappings for all 4 chips:
+		 *    Chip0 =3D 32-351
+		 *    Chip1 =3D 352-671
+		 *    Chip2 =3D 672-991
+		 *    Chip3 =3D 4096-4415
+		 */
+		switch (__get_intid_range(hwirq)) {
+		case SPI_RANGE:
+			chip =3D (hwirq - 32) / 320;
+			break;
+		case ESPI_RANGE:
+			chip =3D 3;
+			break;
+		default:
+			unreachable();
+		}
+		return t241_dist_base_alias[chip];
+	}
+
+	return gic_data.dist_base;
+}
+
 static inline void __iomem *gic_dist_base(struct irq_data *d)
 {
 	switch (get_intid_range(d)) {
@@ -337,7 +378,7 @@ static int gic_peek_irq(struct irq_data *d, u32 offset)
 	if (gic_irq_in_rdist(d))
 		base =3D gic_data_rdist_sgi_base();
 	else
-		base =3D gic_data.dist_base;
+		base =3D gic_dist_base_alias(d);
=20
 	return !!(readl_relaxed(base + offset + (index / 32) * 4) & mask);
 }
@@ -588,7 +629,7 @@ static int gic_set_type(struct irq_data *d, unsigned int =
type)
 	if (gic_irq_in_rdist(d))
 		base =3D gic_data_rdist_sgi_base();
 	else
-		base =3D gic_data.dist_base;
+		base =3D gic_dist_base_alias(d);
=20
 	offset =3D convert_offset_index(d, GICD_ICFGR, &index);
=20
@@ -1708,6 +1749,43 @@ static bool gic_enable_quirk_hip06_07(void *data)
 	return false;
 }
=20
+#define T241_CHIPN_MASK		GENMASK_ULL(45, 44)
+#define T241_CHIP_GICDA_OFFSET	0x1580000
+#define SMCCC_SOC_ID_T241	0x036b0241
+
+static bool gic_enable_quirk_nvidia_t241(void *data)
+{
+	s32 soc_id =3D arm_smccc_get_soc_id_version();
+	unsigned long chip_bmask =3D 0;
+	phys_addr_t phys;
+	u32 i;
+
+	/* Check JEP106 code for NVIDIA T241 chip (036b:0241) */
+	if ((soc_id < 0) || (soc_id !=3D SMCCC_SOC_ID_T241))
+		return false;
+
+	/* Find the chips based on GICR regions PHYS addr */
+	for (i =3D 0; i < gic_data.nr_redist_regions; i++) {
+		chip_bmask |=3D BIT(FIELD_GET(T241_CHIPN_MASK,
+				  (u64)gic_data.redist_regions[i].phys_base));
+	}
+
+	if (hweight32(chip_bmask) < 3)
+		return false;
+
+	/* Setup GICD alias regions */
+	for (i =3D 0; i < ARRAY_SIZE(t241_dist_base_alias); i++) {
+		if (chip_bmask & BIT(i)) {
+			phys =3D gic_data.dist_phys_base + T241_CHIP_GICDA_OFFSET;
+			phys |=3D FIELD_PREP(T241_CHIPN_MASK, i);
+			t241_dist_base_alias[i] =3D ioremap(phys, SZ_64K);
+			WARN_ON_ONCE(!t241_dist_base_alias[i]);
+		}
+	}
+	static_branch_enable(&gic_nvidia_t241_erratum);
+	return true;
+}
+
 static const struct gic_quirk gic_quirks[] =3D {
 	{
 		.desc	=3D "GICv3: Qualcomm MSM8996 broken firmware",
@@ -1739,6 +1817,12 @@ static const struct gic_quirk gic_quirks[] =3D {
 		.mask	=3D 0xe8f00fff,
 		.init	=3D gic_enable_quirk_cavium_38539,
 	},
+	{
+		.desc	=3D "GICv3: NVIDIA erratum T241-FABRIC-4",
+		.iidr	=3D 0x0402043b,
+		.mask	=3D 0xffffffff,
+		.init	=3D gic_enable_quirk_nvidia_t241,
+	},
 	{
 	}
 };
@@ -1798,7 +1882,8 @@ static void gic_enable_nmi_support(void)
 		gic_chip.flags |=3D IRQCHIP_SUPPORTS_NMI;
 }
=20
-static int __init gic_init_bases(void __iomem *dist_base,
+static int __init gic_init_bases(phys_addr_t dist_phys_base,
+				 void __iomem *dist_base,
 				 struct redist_region *rdist_regs,
 				 u32 nr_redist_regions,
 				 u64 redist_stride,
@@ -1814,6 +1899,7 @@ static int __init gic_init_bases(void __iomem *dist_bas=
e,
 		pr_info("GIC: Using split EOI/Deactivate mode\n");
=20
 	gic_data.fwnode =3D handle;
+	gic_data.dist_phys_base =3D dist_phys_base;
 	gic_data.dist_base =3D dist_base;
 	gic_data.redist_regions =3D rdist_regs;
 	gic_data.nr_redist_regions =3D nr_redist_regions;
@@ -1841,10 +1927,13 @@ static int __init gic_init_bases(void __iomem *dist_b=
ase,
 	gic_data.domain =3D irq_domain_create_tree(handle, &gic_irq_domain_ops,
 						 &gic_data);
 	gic_data.rdists.rdist =3D alloc_percpu(typeof(*gic_data.rdists.rdist));
-	gic_data.rdists.has_rvpeid =3D true;
-	gic_data.rdists.has_vlpis =3D true;
-	gic_data.rdists.has_direct_lpi =3D true;
-	gic_data.rdists.has_vpend_valid_dirty =3D true;
+	if (!static_branch_unlikely(&gic_nvidia_t241_erratum)) {
+		/* Disable GICv4.x features for the erratum T241-FABRIC-4 */
+		gic_data.rdists.has_rvpeid =3D true;
+		gic_data.rdists.has_vlpis =3D true;
+		gic_data.rdists.has_direct_lpi =3D true;
+		gic_data.rdists.has_vpend_valid_dirty =3D true;
+	}
=20
 	if (WARN_ON(!gic_data.domain) || WARN_ON(!gic_data.rdists.rdist)) {
 		err =3D -ENOMEM;
@@ -2050,6 +2139,7 @@ static void __iomem *gic_of_iomap(struct device_node *n=
ode, int idx,
=20
 static int __init gic_of_init(struct device_node *node, struct device_node *=
parent)
 {
+	phys_addr_t dist_phys_base;
 	void __iomem *dist_base;
 	struct redist_region *rdist_regs;
 	struct resource res;
@@ -2063,6 +2153,8 @@ static int __init gic_of_init(struct device_node *node,=
 struct device_node *pare
 		return PTR_ERR(dist_base);
 	}
=20
+	dist_phys_base =3D res.start;
+
 	err =3D gic_validate_dist_version(dist_base);
 	if (err) {
 		pr_err("%pOF: no distributor detected, giving up\n", node);
@@ -2094,8 +2186,8 @@ static int __init gic_of_init(struct device_node *node,=
 struct device_node *pare
=20
 	gic_enable_of_quirks(node, gic_quirks, &gic_data);
=20
-	err =3D gic_init_bases(dist_base, rdist_regs, nr_redist_regions,
-			     redist_stride, &node->fwnode);
+	err =3D gic_init_bases(dist_phys_base, dist_base, rdist_regs,
+			     nr_redist_regions, redist_stride, &node->fwnode);
 	if (err)
 		goto out_unmap_rdist;
=20
@@ -2411,8 +2503,9 @@ gic_acpi_init(union acpi_subtable_headers *header, cons=
t unsigned long end)
 		goto out_redist_unmap;
 	}
=20
-	err =3D gic_init_bases(acpi_data.dist_base, acpi_data.redist_regs,
-			     acpi_data.nr_redist_regions, 0, gsi_domain_handle);
+	err =3D gic_init_bases(dist->base_address, acpi_data.dist_base,
+			     acpi_data.redist_regs, acpi_data.nr_redist_regions,
+			     0, gsi_domain_handle);
 	if (err)
 		goto out_fwhandle_free;
=20
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 95e3d2a71db6..412196a7dad5 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1081,10 +1081,6 @@ static int gic_irq_domain_map(struct irq_domain *d, un=
signed int irq,
 	return 0;
 }
=20
-static void gic_irq_domain_unmap(struct irq_domain *d, unsigned int irq)
-{
-}
-
 static int gic_irq_domain_translate(struct irq_domain *d,
 				    struct irq_fwspec *fwspec,
 				    unsigned long *hwirq,
@@ -1167,11 +1163,6 @@ static const struct irq_domain_ops gic_irq_domain_hier=
archy_ops =3D {
 	.free =3D irq_domain_free_irqs_top,
 };
=20
-static const struct irq_domain_ops gic_irq_domain_ops =3D {
-	.map =3D gic_irq_domain_map,
-	.unmap =3D gic_irq_domain_unmap,
-};
-
 static int gic_init_bases(struct gic_chip_data *gic,
 			  struct fwnode_handle *handle)
 {
@@ -1219,30 +1210,9 @@ static int gic_init_bases(struct gic_chip_data *gic,
 		gic_irqs =3D 1020;
 	gic->gic_irqs =3D gic_irqs;
=20
-	if (handle) {		/* DT/ACPI */
-		gic->domain =3D irq_domain_create_linear(handle, gic_irqs,
-						       &gic_irq_domain_hierarchy_ops,
-						       gic);
-	} else {		/* Legacy support */
-		/*
-		 * For primary GICs, skip over SGIs.
-		 * No secondary GIC support whatsoever.
-		 */
-		int irq_base;
-
-		gic_irqs -=3D 16; /* calculate # of irqs to allocate */
-
-		irq_base =3D irq_alloc_descs(16, 16, gic_irqs,
-					   numa_node_id());
-		if (irq_base < 0) {
-			WARN(1, "Cannot allocate irq_descs @ IRQ16, assuming pre-allocated\n");
-			irq_base =3D 16;
-		}
-
-		gic->domain =3D irq_domain_add_legacy(NULL, gic_irqs, irq_base,
-						    16, &gic_irq_domain_ops, gic);
-	}
-
+	gic->domain =3D irq_domain_create_linear(handle, gic_irqs,
+					       &gic_irq_domain_hierarchy_ops,
+					       gic);
 	if (WARN_ON(!gic->domain)) {
 		ret =3D -ENODEV;
 		goto error;
@@ -1297,23 +1267,6 @@ static int __init __gic_init_bases(struct gic_chip_dat=
a *gic,
 	return ret;
 }
=20
-void __init gic_init(void __iomem *dist_base, void __iomem *cpu_base)
-{
-	struct gic_chip_data *gic;
-
-	/*
-	 * Non-DT/ACPI systems won't run a hypervisor, so let's not
-	 * bother with these...
-	 */
-	static_branch_disable(&supports_deactivate_key);
-
-	gic =3D &gic_data[0];
-	gic->raw_dist_base =3D dist_base;
-	gic->raw_cpu_base =3D cpu_base;
-
-	__gic_init_bases(gic, NULL);
-}
-
 static void gic_teardown(struct gic_chip_data *gic)
 {
 	if (WARN_ON(!gic))
@@ -1325,7 +1278,6 @@ static void gic_teardown(struct gic_chip_data *gic)
 		iounmap(gic->raw_cpu_base);
 }
=20
-#ifdef CONFIG_OF
 static int gic_cnt __initdata;
 static bool gicv2_force_probe;
=20
@@ -1570,12 +1522,6 @@ IRQCHIP_DECLARE(cortex_a7_gic, "arm,cortex-a7-gic", gi=
c_of_init);
 IRQCHIP_DECLARE(msm_8660_qgic, "qcom,msm-8660-qgic", gic_of_init);
 IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", gic_of_init);
 IRQCHIP_DECLARE(pl390, "arm,pl390", gic_of_init);
-#else
-int gic_of_init_child(struct device *dev, struct gic_chip_data **gic, int ir=
q)
-{
-	return -ENOTSUPP;
-}
-#endif
=20
 #ifdef CONFIG_ACPI
 static struct
diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loo=
ngson-eiointc.c
index d15fd38c1756..90181c42840b 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -280,9 +280,6 @@ static void acpi_set_vec_parent(int node, struct irq_doma=
in *parent, struct acpi
 {
 	int i;
=20
-	if (cpu_has_flatmode)
-		node =3D cpu_to_node(node * CORES_PER_EIO_NODE);
-
 	for (i =3D 0; i < MAX_IO_PICS; i++) {
 		if (node =3D=3D vec_group[i].node) {
 			vec_group[i].parent =3D parent;
@@ -343,19 +340,27 @@ static int __init pch_pic_parse_madt(union acpi_subtabl=
e_headers *header,
 	if (parent)
 		return pch_pic_acpi_init(parent, pchpic_entry);
=20
-	return -EINVAL;
+	return 0;
 }
=20
 static int __init pch_msi_parse_madt(union acpi_subtable_headers *header,
 					const unsigned long end)
 {
+	struct irq_domain *parent;
 	struct acpi_madt_msi_pic *pchmsi_entry =3D (struct acpi_madt_msi_pic *)head=
er;
-	struct irq_domain *parent =3D acpi_get_vec_parent(eiointc_priv[nr_pics - 1]=
->node, msi_group);
+	int node;
+
+	if (cpu_has_flatmode)
+		node =3D cpu_to_node(eiointc_priv[nr_pics - 1]->node * CORES_PER_EIO_NODE);
+	else
+		node =3D eiointc_priv[nr_pics - 1]->node;
+
+	parent =3D acpi_get_vec_parent(node, msi_group);
=20
 	if (parent)
 		return pch_msi_acpi_init(parent, pchmsi_entry);
=20
-	return -EINVAL;
+	return 0;
 }
=20
 static int __init acpi_cascade_irqdomain_init(void)
@@ -379,6 +384,7 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
 	int i, ret, parent_irq;
 	unsigned long node_map;
 	struct eiointc_priv *priv;
+	int node;
=20
 	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -416,13 +422,19 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
 	parent_irq =3D irq_create_mapping(parent, acpi_eiointc->cascade);
 	irq_set_chained_handler_and_data(parent_irq, eiointc_irq_dispatch, priv);
=20
-	register_syscore_ops(&eiointc_syscore_ops);
-	cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_LOONGARCH_STARTING,
+	if (nr_pics =3D=3D 1) {
+		register_syscore_ops(&eiointc_syscore_ops);
+		cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_LOONGARCH_STARTING,
 				  "irqchip/loongarch/intc:starting",
 				  eiointc_router_init, NULL);
+	}
=20
-	acpi_set_vec_parent(acpi_eiointc->node, priv->eiointc_domain, pch_group);
-	acpi_set_vec_parent(acpi_eiointc->node, priv->eiointc_domain, msi_group);
+	if (cpu_has_flatmode)
+		node =3D cpu_to_node(acpi_eiointc->node * CORES_PER_EIO_NODE);
+	else
+		node =3D acpi_eiointc->node;
+	acpi_set_vec_parent(node, priv->eiointc_domain, pch_group);
+	acpi_set_vec_parent(node, priv->eiointc_domain, msi_group);
 	ret =3D acpi_cascade_irqdomain_init();
=20
 	return ret;
diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loo=
ngson-pch-pic.c
index 437f1af693d0..e5fe4d50be05 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -311,7 +311,8 @@ static int pch_pic_init(phys_addr_t addr, unsigned long s=
ize, int vec_base,
 	pch_pic_handle[nr_pics] =3D domain_handle;
 	pch_pic_priv[nr_pics++] =3D priv;
=20
-	register_syscore_ops(&pch_pic_syscore_ops);
+	if (nr_pics =3D=3D 1)
+		register_syscore_ops(&pch_pic_syscore_ops);
=20
 	return 0;
=20
@@ -403,6 +404,9 @@ int __init pch_pic_acpi_init(struct irq_domain *parent,
 	int ret, vec_base;
 	struct fwnode_handle *domain_handle;
=20
+	if (find_pch_pic(acpi_pchpic->gsi_base) >=3D 0)
+		return 0;
+
 	vec_base =3D acpi_pchpic->gsi_base - GSI_MIN_PCH_IRQ;
=20
 	domain_handle =3D irq_domain_alloc_fwnode(&acpi_pchpic->address);
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-int=
c.c
index 499e5f81b3fe..f229e3e66387 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -26,20 +26,7 @@ static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
 	if (unlikely(cause >=3D BITS_PER_LONG))
 		panic("unexpected interrupt cause");
=20
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
=20
 /*
@@ -59,22 +46,27 @@ static void riscv_intc_irq_unmask(struct irq_data *d)
 	csr_set(CSR_IE, BIT(d->hwirq));
 }
=20
-static int riscv_intc_cpu_starting(unsigned int cpu)
-{
-	csr_set(CSR_IE, BIT(RV_IRQ_SOFT));
-	return 0;
-}
-
-static int riscv_intc_cpu_dying(unsigned int cpu)
+static void riscv_intc_irq_eoi(struct irq_data *d)
 {
-	csr_clear(CSR_IE, BIT(RV_IRQ_SOFT));
-	return 0;
+	/*
+	 * The RISC-V INTC driver uses handle_percpu_devid_irq() flow
+	 * for the per-HART local interrupts and child irqchip drivers
+	 * (such as PLIC, SBI IPI, CLINT, APLIC, IMSIC, etc) implement
+	 * chained handlers for the per-HART local interrupts.
+	 *
+	 * In the absence of irq_eoi(), the chained_irq_enter() and
+	 * chained_irq_exit() functions (used by child irqchip drivers)
+	 * will do unnecessary mask/unmask of per-HART local interrupts
+	 * at the time of handling interrupts. To avoid this, we provide
+	 * an empty irq_eoi() callback for RISC-V INTC irqchip.
+	 */
 }
=20
 static struct irq_chip riscv_intc_chip =3D {
 	.name =3D "RISC-V INTC",
 	.irq_mask =3D riscv_intc_irq_mask,
 	.irq_unmask =3D riscv_intc_irq_unmask,
+	.irq_eoi =3D riscv_intc_irq_eoi,
 };
=20
 static int riscv_intc_domain_map(struct irq_domain *d, unsigned int irq,
@@ -87,11 +79,39 @@ static int riscv_intc_domain_map(struct irq_domain *d, un=
signed int irq,
 	return 0;
 }
=20
+static int riscv_intc_domain_alloc(struct irq_domain *domain,
+				   unsigned int virq, unsigned int nr_irqs,
+				   void *arg)
+{
+	int i, ret;
+	irq_hw_number_t hwirq;
+	unsigned int type =3D IRQ_TYPE_NONE;
+	struct irq_fwspec *fwspec =3D arg;
+
+	ret =3D irq_domain_translate_onecell(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	for (i =3D 0; i < nr_irqs; i++) {
+		ret =3D riscv_intc_domain_map(domain, virq + i, hwirq + i);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static const struct irq_domain_ops riscv_intc_domain_ops =3D {
 	.map	=3D riscv_intc_domain_map,
 	.xlate	=3D irq_domain_xlate_onecell,
+	.alloc	=3D riscv_intc_domain_alloc
 };
=20
+static struct fwnode_handle *riscv_intc_hwnode(void)
+{
+	return intc_domain->fwnode;
+}
+
 static int __init riscv_intc_init(struct device_node *node,
 				  struct device_node *parent)
 {
@@ -126,10 +146,7 @@ static int __init riscv_intc_init(struct device_node *no=
de,
 		return rc;
 	}
=20
-	cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_STARTING,
-			  "irqchip/riscv/intc:starting",
-			  riscv_intc_cpu_starting,
-			  riscv_intc_cpu_dying);
+	riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
=20
 	pr_info("%d local interrupts mapped\n", BITS_PER_LONG);
=20
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-p=
lic.c
index ff47bd0dec45..e1484905b7bd 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -17,6 +17,7 @@
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
+#include <linux/syscore_ops.h>
 #include <asm/smp.h>
=20
 /*
@@ -67,6 +68,8 @@ struct plic_priv {
 	struct irq_domain *irqdomain;
 	void __iomem *regs;
 	unsigned long plic_quirks;
+	unsigned int nr_irqs;
+	unsigned long *prio_save;
 };
=20
 struct plic_handler {
@@ -78,6 +81,7 @@ struct plic_handler {
 	 */
 	raw_spinlock_t		enable_lock;
 	void __iomem		*enable_base;
+	u32			*enable_save;
 	struct plic_priv	*priv;
 };
 static int plic_parent_irq __ro_after_init;
@@ -229,6 +233,71 @@ static int plic_irq_set_type(struct irq_data *d, unsigne=
d int type)
 	return IRQ_SET_MASK_OK;
 }
=20
+static int plic_irq_suspend(void)
+{
+	unsigned int i, cpu;
+	u32 __iomem *reg;
+	struct plic_priv *priv;
+
+	priv =3D per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
+
+	for (i =3D 0; i < priv->nr_irqs; i++)
+		if (readl(priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID))
+			__set_bit(i, priv->prio_save);
+		else
+			__clear_bit(i, priv->prio_save);
+
+	for_each_cpu(cpu, cpu_present_mask) {
+		struct plic_handler *handler =3D per_cpu_ptr(&plic_handlers, cpu);
+
+		if (!handler->present)
+			continue;
+
+		raw_spin_lock(&handler->enable_lock);
+		for (i =3D 0; i < DIV_ROUND_UP(priv->nr_irqs, 32); i++) {
+			reg =3D handler->enable_base + i * sizeof(u32);
+			handler->enable_save[i] =3D readl(reg);
+		}
+		raw_spin_unlock(&handler->enable_lock);
+	}
+
+	return 0;
+}
+
+static void plic_irq_resume(void)
+{
+	unsigned int i, index, cpu;
+	u32 __iomem *reg;
+	struct plic_priv *priv;
+
+	priv =3D per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
+
+	for (i =3D 0; i < priv->nr_irqs; i++) {
+		index =3D BIT_WORD(i);
+		writel((priv->prio_save[index] & BIT_MASK(i)) ? 1 : 0,
+		       priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID);
+	}
+
+	for_each_cpu(cpu, cpu_present_mask) {
+		struct plic_handler *handler =3D per_cpu_ptr(&plic_handlers, cpu);
+
+		if (!handler->present)
+			continue;
+
+		raw_spin_lock(&handler->enable_lock);
+		for (i =3D 0; i < DIV_ROUND_UP(priv->nr_irqs, 32); i++) {
+			reg =3D handler->enable_base + i * sizeof(u32);
+			writel(handler->enable_save[i], reg);
+		}
+		raw_spin_unlock(&handler->enable_lock);
+	}
+}
+
+static struct syscore_ops plic_irq_syscore_ops =3D {
+	.suspend	=3D plic_irq_suspend,
+	.resume		=3D plic_irq_resume,
+};
+
 static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
 			      irq_hw_number_t hwirq)
 {
@@ -345,6 +414,7 @@ static int __init __plic_init(struct device_node *node,
 	u32 nr_irqs;
 	struct plic_priv *priv;
 	struct plic_handler *handler;
+	unsigned int cpu;
=20
 	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -363,15 +433,21 @@ static int __init __plic_init(struct device_node *node,
 	if (WARN_ON(!nr_irqs))
 		goto out_iounmap;
=20
+	priv->nr_irqs =3D nr_irqs;
+
+	priv->prio_save =3D bitmap_alloc(nr_irqs, GFP_KERNEL);
+	if (!priv->prio_save)
+		goto out_free_priority_reg;
+
 	nr_contexts =3D of_irq_count(node);
 	if (WARN_ON(!nr_contexts))
-		goto out_iounmap;
+		goto out_free_priority_reg;
=20
 	error =3D -ENOMEM;
 	priv->irqdomain =3D irq_domain_add_linear(node, nr_irqs + 1,
 			&plic_irqdomain_ops, priv);
 	if (WARN_ON(!priv->irqdomain))
-		goto out_iounmap;
+		goto out_free_priority_reg;
=20
 	for (i =3D 0; i < nr_contexts; i++) {
 		struct of_phandle_args parent;
@@ -441,6 +517,11 @@ static int __init __plic_init(struct device_node *node,
 		handler->enable_base =3D priv->regs + CONTEXT_ENABLE_BASE +
 			i * CONTEXT_ENABLE_SIZE;
 		handler->priv =3D priv;
+
+		handler->enable_save =3D  kcalloc(DIV_ROUND_UP(nr_irqs, 32),
+						sizeof(*handler->enable_save), GFP_KERNEL);
+		if (!handler->enable_save)
+			goto out_free_enable_reg;
 done:
 		for (hwirq =3D 1; hwirq <=3D nr_irqs; hwirq++) {
 			plic_toggle(handler, hwirq, 0);
@@ -461,11 +542,19 @@ static int __init __plic_init(struct device_node *node,
 				  plic_starting_cpu, plic_dying_cpu);
 		plic_cpuhp_setup_done =3D true;
 	}
+	register_syscore_ops(&plic_irq_syscore_ops);
=20
 	pr_info("%pOFP: mapped %d interrupts with %d handlers for"
 		" %d contexts.\n", node, nr_irqs, nr_handlers, nr_contexts);
 	return 0;
=20
+out_free_enable_reg:
+	for_each_cpu(cpu, cpu_present_mask) {
+		handler =3D per_cpu_ptr(&plic_handlers, cpu);
+		kfree(handler->enable_save);
+	}
+out_free_priority_reg:
+	kfree(priv->prio_save);
 out_iounmap:
 	iounmap(priv->regs);
 out_free_priv:
diff --git a/drivers/irqchip/irq-st.c b/drivers/irqchip/irq-st.c
index 1b83512b29c6..819a12297b58 100644
--- a/drivers/irqchip/irq-st.c
+++ b/drivers/irqchip/irq-st.c
@@ -15,10 +15,7 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
=20
-#define STIH415_SYSCFG_642		0x0a8
-#define STIH416_SYSCFG_7543		0x87c
 #define STIH407_SYSCFG_5102		0x198
-#define STID127_SYSCFG_734		0x088
=20
 #define ST_A9_IRQ_MASK			0x001FFFFF
 #define ST_A9_IRQ_MAX_CHANS		2
@@ -44,22 +41,10 @@ struct st_irq_syscfg {
 };
=20
 static const struct of_device_id st_irq_syscfg_match[] =3D {
-	{
-		.compatible =3D "st,stih415-irq-syscfg",
-		.data =3D (void *)STIH415_SYSCFG_642,
-	},
-	{
-		.compatible =3D "st,stih416-irq-syscfg",
-		.data =3D (void *)STIH416_SYSCFG_7543,
-	},
 	{
 		.compatible =3D "st,stih407-irq-syscfg",
 		.data =3D (void *)STIH407_SYSCFG_5102,
 	},
-	{
-		.compatible =3D "st,stid127-irq-syscfg",
-		.data =3D (void *)STID127_SYSCFG_734,
-	},
 	{}
 };
=20
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 220c8c60e021..f196c19f8e55 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -226,6 +226,24 @@ void __init arm_smccc_version_init(u32 version, enum arm=
_smccc_conduit conduit);
=20
 extern u64 smccc_has_sve_hint;
=20
+/**
+ * arm_smccc_get_soc_id_version()
+ *
+ * Returns the SOC ID version.
+ *
+ * When ARM_SMCCC_ARCH_SOC_ID is not present, returns SMCCC_RET_NOT_SUPPORTE=
D.
+ */
+s32 arm_smccc_get_soc_id_version(void);
+
+/**
+ * arm_smccc_get_soc_id_revision()
+ *
+ * Returns the SOC ID revision.
+ *
+ * When ARM_SMCCC_ARCH_SOC_ID is not present, returns SMCCC_RET_NOT_SUPPORTE=
D.
+ */
+s32 arm_smccc_get_soc_id_revision(void);
+
 /**
  * struct arm_smccc_res - Result from SMC/HVC call
  * @a0-a3 result values from registers 0 to 3
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 5686711b0f40..2223f95079ce 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -151,12 +151,6 @@ int gic_of_init(struct device_node *node, struct device_=
node *parent);
  */
 int gic_of_init_child(struct device *dev, struct gic_chip_data **gic, int ir=
q);
=20
-/*
- * Legacy platforms not converted to DT yet must use this to init
- * their GIC
- */
-void gic_init(void __iomem *dist , void __iomem *cpu);
-
 void gic_send_sgi(unsigned int cpu_id, unsigned int irq);
 int gic_get_cpu_id(unsigned int cpu);
 void gic_migrate_target(unsigned int new_cpu_id);
diff --git a/include/trace/events/irq.h b/include/trace/events/irq.h
index eeceafaaea4c..a07b4607b663 100644
--- a/include/trace/events/irq.h
+++ b/include/trace/events/irq.h
@@ -160,6 +160,53 @@ DEFINE_EVENT(softirq, softirq_raise,
 	TP_ARGS(vec_nr)
 );
=20
+DECLARE_EVENT_CLASS(tasklet,
+
+	TP_PROTO(struct tasklet_struct *t, void *func),
+
+	TP_ARGS(t, func),
+
+	TP_STRUCT__entry(
+		__field(	void *,	tasklet)
+		__field(	void *,	func)
+	),
+
+	TP_fast_assign(
+		__entry->tasklet =3D t;
+		__entry->func =3D func;
+	),
+
+	TP_printk("tasklet=3D%ps function=3D%ps", __entry->tasklet, __entry->func)
+);
+
+/**
+ * tasklet_entry - called immediately before the tasklet is run
+ * @t: tasklet pointer
+ * @func: tasklet callback or function being run
+ *
+ * Used to find individual tasklet execution time
+ */
+DEFINE_EVENT(tasklet, tasklet_entry,
+
+	TP_PROTO(struct tasklet_struct *t, void *func),
+
+	TP_ARGS(t, func)
+);
+
+/**
+ * tasklet_exit - called immediately after the tasklet is run
+ * @t: tasklet pointer
+ * @func: tasklet callback or function being run
+ *
+ * Used to find individual tasklet execution time
+ */
+DEFINE_EVENT(tasklet, tasklet_exit,
+
+	TP_PROTO(struct tasklet_struct *t, void *func),
+
+	TP_ARGS(t, func)
+);
+
 #endif /*  _TRACE_IRQ_H */
=20
 /* This part must be outside protection */
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 8ce75495e04f..d2742af0f0fd 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -189,9 +189,12 @@ void irq_set_thread_affinity(struct irq_desc *desc)
 {
 	struct irqaction *action;
=20
-	for_each_action_of_desc(desc, action)
+	for_each_action_of_desc(desc, action) {
 		if (action->thread)
 			set_bit(IRQTF_AFFINITY, &action->thread_flags);
+		if (action->secondary && action->secondary->thread)
+			set_bit(IRQTF_AFFINITY, &action->secondary->thread_flags);
+	}
 }
=20
 #ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
diff --git a/kernel/softirq.c b/kernel/softirq.c
index c8a6913c067d..1b725510dd0f 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -793,10 +793,15 @@ static void tasklet_action_common(struct softirq_action=
 *a,
 		if (tasklet_trylock(t)) {
 			if (!atomic_read(&t->count)) {
 				if (tasklet_clear_sched(t)) {
-					if (t->use_callback)
+					if (t->use_callback) {
+						trace_tasklet_entry(t, t->callback);
 						t->callback(t);
-					else
+						trace_tasklet_exit(t, t->callback);
+					} else {
+						trace_tasklet_entry(t, t->func);
 						t->func(t->data);
+						trace_tasklet_exit(t, t->func);
+					}
 				}
 				tasklet_unlock(t);
 				continue;

