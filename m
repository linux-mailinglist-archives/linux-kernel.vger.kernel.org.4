Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C296365C473
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238326AbjACRAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238186AbjACRAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:00:10 -0500
Received: from fx302.security-mail.net (mxout.security-mail.net [85.31.212.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C632813CC2
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 09:00:03 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by fx302.security-mail.net (Postfix) with ESMTP id ECE1A1C3E485
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:44:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1672764273;
        bh=XmEVO/W9RCIsv+5a0Ys6Iw1YMkuCx/jMas9cClmLkO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=NJq2fIIDL/BCEz8VsXUzoCxci59UAulQ8IyGe05AGEtXd3g6CYMn/XCSoBJ4ld5vS
         s6lAqT9gJxF8IYRyeKE7WDKTb0ZUdhSKVd7j8h/7X4QapMI2wVLOW810ngxDxfxyve
         U+hVylbAD5O8mhfpJrcYaSY4CNQIKo4nt17EVXvE=
Received: from fx302 (localhost [127.0.0.1]) by fx302.security-mail.net
 (Postfix) with ESMTP id C46D11C3E441; Tue,  3 Jan 2023 17:44:32 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx302.security-mail.net (Postfix) with ESMTPS id 401A81C3E364; Tue,  3 Jan
 2023 17:44:32 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id DC86027E03FE; Tue,  3 Jan 2023
 17:44:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id BD94927E03FB; Tue,  3 Jan 2023 17:44:31 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 1fSAHxuZWgbn; Tue,  3 Jan 2023 17:44:31 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 7AEA227E03F9; Tue,  3 Jan 2023
 17:44:31 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <b1bc.63b45b70.1a3a6.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu BD94927E03FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1672764271;
 bh=DcrML+uqKPQ0L1Tbo8/AemP2FUwa4E+/v0wOXs9cNtU=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=RGksZ6yEQ6/lnsZGPPOy1+7N4GPVJFFL/FAsrLBaBoekm4XEdY24BgsumI95t0fCa
 YVACs234vk6yirfCut1AppcdShaqSvjd9nUwtHSpA+lz9Oy3Dcdo4iGBhNSZAOHW9c
 4PeuOLaXb4uiPPljiyHEoUoLEWolGCbXm0CeGKKQ=
From:   Yann Sionneau <ysionneau@kalray.eu>
Cc:     Yann Sionneau <ysionneau@kalray.eu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Julian Vetter <jvetter@kalray.eu>,
        Luc Michel <lmichel@kalray.eu>,
        Vincent Chardon <vincent.chardon@elsys-design.com>
Subject: [RFC PATCH 09/25] kvx: irqchip: Add support for irq controllers
Date:   Tue,  3 Jan 2023 17:43:43 +0100
Message-ID: <20230103164359.24347-10-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230103164359.24347-1-ysionneau@kalray.eu>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for kvx irq controllers found in Coolidge MPPA SoC

The core-intc:

Each kvx core includes a hardware interrupt controller (core ITC)
with the following features:
* 32 independent interrupt sources
* 4-bit priotity level
* Individual interrupt enable bit
* Interrupt status bit displaying the pending interrupts
* Priority management between the 32 interrupts

Among those 32 interrupt sources, the first are hard-wired to hardware
sources. The remaining interrupt sources can be triggered via software
by directly writing to the ILR SFR.

The hard-wired interrupt sources are the following:
0: Timer 0
1: Timer 1
2: Watchdog
3: Performance Monitors
4: APIC GIC line 0
5: APIC GIC line 1
6: APIC GIC line 2
7: APIC GIC line 3
12: SECC error from memory system
13: Arithmetic exception (carry and IEEE 754 flags)
16: Data Asynchronous Memory Error (DAME), raised for DECC/DSYS errors
17: CLI (Cache Line Invalidation) for L1D or L1I following DECC/DSYS/Parity
    errors

The APIC GIC lines will be used to route interrupts coming from SoC peripherals
from outside the Cluster to the kvx core. Those peripherals include USB host
controller, eMMC/SD host controller, i2c, spi, PCIe, IOMMUs etc...

The APIC GIC:

Each Cluster of the Coolidge SoC includes an APIC
(Advanced Programmable Interrupt Controller) GIC (Generic Interrupt Controller).
The APIC GIC acts as an intermediary interrupt controller, muxing/routing
incoming interrupts to output interrupts connected to the kvx core ITC lines.
The first 128 incoming interrupt lines come from the mailbox controller (itself
containing 128 mailboxes).
The remaining 11 interrupt lines come from external interrupt sources (NoC
router, the 5 IOMMUs, L2$ DMA job fifo, watchdog, SECC, DECC, D NoC).
The APIC GIC has 72 output interrupts: 4 per kvx cores in the cluster
(1 RM and 16 PE) connected to the "APIC GIC lines" described above and 1 for the
L2$ controller which makes 69 interrupts lines (rounded up to 72).

The APIC Mailbox:

The APIC includes a mailbox controller, containing 128 mailboxes.
This hardware block is basically a 1 Kb of smart memory space.
Each mailbox is an 8 bytes word memory location which can generate and
interrupt.
Each mailbox has a trigger function and an input function.
When a mailbox is written to, if the condition described by the
trigger function is satisfied, the corresponding interrupt
will fire.
Since this hardware block generates IRQs based on writes
at some memory locations, it is both an interrupt controller
and an MSI controller.

The ITGEN:

The ITGEN (InTerrupt GENerator) is an interrupt controller block.
It's purpose is to convert IRQ lines coming from SoC peripherals
(USB host controller for instance) into writes on the AXI bus.
Those writes are targeting the APIC Mailboxes.

CC: Thomas Gleixner <tglx@linutronix.de>
CC: Marc Zyngier <maz@kernel.org>
CC: Rob Herring <robh+dt@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: linux-kernel@vger.kernel.org
CC: devicetree@vger.kernel.org
Co-developed-by: Clement Leger <clement.leger@bootlin.com>
Signed-off-by: Clement Leger <clement.leger@bootlin.com>
Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
Co-developed-by: Julian Vetter <jvetter@kalray.eu>
Signed-off-by: Julian Vetter <jvetter@kalray.eu>
Co-developed-by: Luc Michel <lmichel@kalray.eu>
Signed-off-by: Luc Michel <lmichel@kalray.eu>
Co-developed-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Signed-off-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---
 .../kalray,kvx-core-intc.txt                  |  22 +
 drivers/irqchip/Kconfig                       |  27 +
 drivers/irqchip/Makefile                      |   4 +
 drivers/irqchip/irq-kvx-apic-gic.c            | 349 +++++++++++++
 drivers/irqchip/irq-kvx-apic-mailbox.c        | 465 ++++++++++++++++++
 drivers/irqchip/irq-kvx-core-intc.c           |  82 +++
 drivers/irqchip/irq-kvx-itgen.c               | 224 +++++++++
 include/linux/irqchip/irq-kvx-apic-gic.h      |  21 +
 include/linux/irqchip/irq-kvx-apic-mailbox.h  |  29 ++
 include/linux/irqchip/irq-kvx-itgen.h         |  24 +
 10 files changed, 1247 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kalray,kvx-core-intc.txt
 create mode 100644 drivers/irqchip/irq-kvx-apic-gic.c
 create mode 100644 drivers/irqchip/irq-kvx-apic-mailbox.c
 create mode 100644 drivers/irqchip/irq-kvx-core-intc.c
 create mode 100644 drivers/irqchip/irq-kvx-itgen.c
 create mode 100644 include/linux/irqchip/irq-kvx-apic-gic.h
 create mode 100644 include/linux/irqchip/irq-kvx-apic-mailbox.h
 create mode 100644 include/linux/irqchip/irq-kvx-itgen.h

diff --git a/Documentation/devicetree/bindings/interrupt-controller/kalray,kvx-core-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/kalray,kvx-core-intc.txt
new file mode 100644
index 000000000000..503a661e1e84
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/kalray,kvx-core-intc.txt
@@ -0,0 +1,22 @@
+* KVX Core Interrupt controller
+
+Required properties:
+
+- compatible: must to be "kalray,kvx-core-intc".
+- interrupt-controller
+- #interrupt-cells: has to be <1>: an interrupt index
+- regs: Base address of interrupt controller registers.
+
+Optional properties:
+
+- kalray,intc-nr-irqs: Number of irqs handled by the controller.
+  if not given, will default to 32.
+
+Example:
+
+	core_intc: core_intc@0 {
+		compatible = "kalray,kvx-core-intc";
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		interrupt-parent = <&core_intc>;
+	};
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 7ef9f5e696d3..7c7753b33d4e 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -334,6 +334,33 @@ config MIPS_GIC
 	select IRQ_DOMAIN_HIERARCHY
 	select MIPS_CM
 
+config KVX_CORE_INTC
+	bool
+	depends on KVX
+	select IRQ_DOMAIN
+
+config KVX_APIC_GIC
+	bool
+	depends on KVX
+	select IRQ_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY
+
+config KVX_APIC_MAILBOX
+	bool
+	depends on KVX
+	select GENERIC_IRQ_IPI if SMP
+	select GENERIC_MSI_IRQ_DOMAIN
+	select IRQ_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY
+
+config KVX_ITGEN
+	bool
+	depends on KVX
+	select GENERIC_IRQ_IPI if SMP
+	select GENERIC_MSI_IRQ_DOMAIN
+	select IRQ_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY
+
 config INGENIC_IRQ
 	bool
 	depends on MACH_INGENIC
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 87b49a10962c..4e7e374314c3 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -69,6 +69,10 @@ obj-$(CONFIG_BCM7120_L2_IRQ)		+= irq-bcm7120-l2.o
 obj-$(CONFIG_BRCMSTB_L2_IRQ)		+= irq-brcmstb-l2.o
 obj-$(CONFIG_KEYSTONE_IRQ)		+= irq-keystone.o
 obj-$(CONFIG_MIPS_GIC)			+= irq-mips-gic.o
+obj-$(CONFIG_KVX_CORE_INTC)		+= irq-kvx-core-intc.o
+obj-$(CONFIG_KVX_APIC_GIC)		+= irq-kvx-apic-gic.o
+obj-$(CONFIG_KVX_APIC_MAILBOX)		+= irq-kvx-apic-mailbox.o
+obj-$(CONFIG_KVX_ITGEN)			+= irq-kvx-itgen.o
 obj-$(CONFIG_ARCH_MEDIATEK)		+= irq-mtk-sysirq.o irq-mtk-cirq.o
 obj-$(CONFIG_ARCH_DIGICOLOR)		+= irq-digicolor.o
 obj-$(CONFIG_ARCH_SA1100)		+= irq-sa11x0.o
diff --git a/drivers/irqchip/irq-kvx-apic-gic.c b/drivers/irqchip/irq-kvx-apic-gic.c
new file mode 100644
index 000000000000..42d28c8b3322
--- /dev/null
+++ b/drivers/irqchip/irq-kvx-apic-gic.c
@@ -0,0 +1,349 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017 - 2022 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Julian Vetter
+ */
+
+#define pr_fmt(fmt)	"kvx_apic_gic: " fmt
+
+#include <linux/irqchip/irq-kvx-apic-gic.h>
+#include <linux/of_address.h>
+#include <linux/cpuhotplug.h>
+#include <linux/interrupt.h>
+#include <linux/irqdomain.h>
+#include <linux/spinlock.h>
+#include <linux/irqchip.h>
+#include <linux/of_irq.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/of.h>
+
+/* APIC is organized in 18 groups of 4 output lines
+ * However, the two upper lines are for Secure RM and DMA engine
+ * Thus, we do not have to use them
+ */
+#define GIC_CPU_OUT_COUNT	16
+#define GIC_PER_CPU_IT_COUNT	4
+
+/**
+ * For each CPU, there is 4 output lines coming from the apic GIC.
+ * We only use 1 line and this structure represent this line.
+ * @base Output line base address
+ * @cpu CPU associated to this line
+ */
+struct gic_out_irq_line {
+	void __iomem *base;
+	unsigned int cpu;
+};
+
+/**
+ * Input irq line.
+ * This structure is used to store the status of the input line and the
+ * associated output line.
+ * @enabled Boolean for line status
+ * @cpu CPU currently receiving this interrupt
+ * @it_num Interrupt number
+ */
+struct gic_in_irq_line {
+	bool enabled;
+	struct gic_out_irq_line *out_line;
+	unsigned int it_num;
+};
+
+/**
+ * struct kvx_apic_gic - kvx apic gic
+ * @base: Base address of the controller
+ * @domain Domain for this controller
+ * @input_nr_irqs: maximum number of supported input interrupts
+ * @cpus: Per cpu interrupt configuration
+ * @output_irq: Array of output irq lines
+ * @input_irq: Array of input irq lines
+ */
+struct kvx_apic_gic {
+	raw_spinlock_t lock;
+	void __iomem *base;
+	struct irq_domain *domain;
+	uint32_t input_nr_irqs;
+	/* For each cpu, there is a output IT line */
+	struct gic_out_irq_line output_irq[GIC_CPU_OUT_COUNT];
+
+	/* Input interrupt status */
+	struct gic_in_irq_line input_irq[KVX_GIC_INPUT_IT_COUNT];
+};
+
+static int gic_parent_irq;
+
+/**
+ * Enable/Disable an output irq line
+ * This function is used by both mask/unmask to disable/enable the line.
+ */
+static void irq_line_set_enable(struct gic_out_irq_line *irq_line,
+				struct gic_in_irq_line *in_irq_line,
+				int enable)
+{
+	void __iomem *enable_line_addr = irq_line->base +
+	       KVX_GIC_ENABLE_OFFSET +
+	       in_irq_line->it_num * KVX_GIC_ENABLE_ELEM_SIZE;
+
+	writeb((uint8_t) enable ? 1 : 0, enable_line_addr);
+	in_irq_line->enabled = enable;
+}
+
+static void kvx_apic_gic_set_line(struct irq_data *data, int enable)
+{
+	struct kvx_apic_gic *gic = irq_data_get_irq_chip_data(data);
+	unsigned int in_irq = irqd_to_hwirq(data);
+	struct gic_in_irq_line *in_line = &gic->input_irq[in_irq];
+	struct gic_out_irq_line *out_line = in_line->out_line;
+
+	raw_spin_lock(&gic->lock);
+	/* Set line enable on currently assigned cpu */
+	irq_line_set_enable(out_line, in_line, enable);
+	raw_spin_unlock(&gic->lock);
+}
+
+static void kvx_apic_gic_mask(struct irq_data *data)
+{
+	kvx_apic_gic_set_line(data, 0);
+}
+
+static void kvx_apic_gic_unmask(struct irq_data *data)
+{
+	kvx_apic_gic_set_line(data, 1);
+}
+
+#ifdef CONFIG_SMP
+
+static int kvx_apic_gic_set_affinity(struct irq_data *d,
+				     const struct cpumask *cpumask,
+				     bool force)
+{
+	struct kvx_apic_gic *gic = irq_data_get_irq_chip_data(d);
+	unsigned int new_cpu;
+	unsigned int hw_irq = irqd_to_hwirq(d);
+	struct gic_in_irq_line *input_line = &gic->input_irq[hw_irq];
+	struct gic_out_irq_line *new_out_line;
+
+	/* We assume there is only one cpu in the mask */
+	new_cpu = cpumask_first(cpumask);
+	new_out_line = &gic->output_irq[new_cpu];
+
+	raw_spin_lock(&gic->lock);
+
+	/* Nothing to do, line is the same */
+	if (new_out_line == input_line->out_line)
+		goto out;
+
+	/* If old line was enabled, enable the new one before disabling
+	 * the old one
+	 */
+	if (input_line->enabled)
+		irq_line_set_enable(new_out_line, input_line, 1);
+
+	/* Disable it on old line */
+	irq_line_set_enable(input_line->out_line, input_line, 0);
+
+	/* Assign new output line to input IRQ */
+	input_line->out_line = new_out_line;
+
+out:
+	raw_spin_unlock(&gic->lock);
+
+	irq_data_update_effective_affinity(d, cpumask_of(new_cpu));
+
+	return IRQ_SET_MASK_OK;
+}
+#endif
+
+static struct irq_chip kvx_apic_gic_chip = {
+	.name           = "kvx apic gic",
+	.irq_mask	= kvx_apic_gic_mask,
+	.irq_unmask	= kvx_apic_gic_unmask,
+#ifdef CONFIG_SMP
+	.irq_set_affinity = kvx_apic_gic_set_affinity,
+#endif
+};
+
+static int kvx_apic_gic_alloc(struct irq_domain *domain, unsigned int virq,
+				   unsigned int nr_irqs, void *args)
+{
+	int i;
+	struct irq_fwspec *fwspec = args;
+	int hwirq = fwspec->param[0];
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_domain_set_info(domain, virq + i, hwirq + i,
+				    &kvx_apic_gic_chip,
+				    domain->host_data, handle_simple_irq,
+				    NULL, NULL);
+	}
+
+	return 0;
+}
+
+static const struct irq_domain_ops kvx_apic_gic_domain_ops = {
+	.alloc  = kvx_apic_gic_alloc,
+	.free   = irq_domain_free_irqs_common,
+};
+
+static void irq_line_get_status_lac(struct gic_out_irq_line *out_irq_line,
+			uint64_t status[KVX_GIC_STATUS_LAC_ARRAY_SIZE])
+{
+	int i;
+
+	for (i = 0; i < KVX_GIC_STATUS_LAC_ARRAY_SIZE; i++) {
+		status[i] = readq(out_irq_line->base +
+				  KVX_GIC_STATUS_LAC_OFFSET +
+				  i * KVX_GIC_STATUS_LAC_ELEM_SIZE);
+	}
+}
+
+static void kvx_apic_gic_handle_irq(struct irq_desc *desc)
+{
+	struct kvx_apic_gic *gic_data = irq_desc_get_handler_data(desc);
+	struct gic_out_irq_line *out_line;
+	uint64_t status[KVX_GIC_STATUS_LAC_ARRAY_SIZE];
+	unsigned long irqn, cascade_irq;
+	unsigned long cpu = smp_processor_id();
+
+	out_line = &gic_data->output_irq[cpu];
+
+	irq_line_get_status_lac(out_line, status);
+
+	for_each_set_bit(irqn, (unsigned long *) status,
+			KVX_GIC_STATUS_LAC_ARRAY_SIZE * BITS_PER_LONG) {
+
+		cascade_irq = irq_find_mapping(gic_data->domain, irqn);
+
+		generic_handle_irq(cascade_irq);
+	}
+}
+
+static void __init apic_gic_init(struct kvx_apic_gic *gic)
+{
+	unsigned int cpu, line;
+	struct gic_in_irq_line *input_irq_line;
+	struct gic_out_irq_line *output_irq_line;
+	uint64_t status[KVX_GIC_STATUS_LAC_ARRAY_SIZE];
+
+	/* Initialize all input lines (device -> )*/
+	for (line = 0; line < KVX_GIC_INPUT_IT_COUNT; line++) {
+		input_irq_line = &gic->input_irq[line];
+		input_irq_line->enabled = false;
+		/* All input lines map on output 0 */
+		input_irq_line->out_line = &gic->output_irq[0];
+		input_irq_line->it_num = line;
+	}
+
+	/* Clear all output lines (-> cpus) */
+	for (cpu = 0; cpu < GIC_CPU_OUT_COUNT; cpu++) {
+		output_irq_line = &gic->output_irq[cpu];
+		output_irq_line->cpu = cpu;
+		output_irq_line->base = gic->base +
+			cpu * (KVX_GIC_ELEM_SIZE * GIC_PER_CPU_IT_COUNT);
+
+		/* Disable all external lines on this core */
+		for (line = 0; line < KVX_GIC_INPUT_IT_COUNT; line++)
+			irq_line_set_enable(output_irq_line,
+					&gic->input_irq[line], 0x0);
+
+		irq_line_get_status_lac(output_irq_line, status);
+	}
+}
+
+static int kvx_gic_starting_cpu(unsigned int cpu)
+{
+	enable_percpu_irq(gic_parent_irq, IRQ_TYPE_NONE);
+
+	return 0;
+}
+
+static int kvx_gic_dying_cpu(unsigned int cpu)
+{
+	disable_percpu_irq(gic_parent_irq);
+
+	return 0;
+}
+
+static int __init kvx_init_apic_gic(struct device_node *node,
+				    struct device_node *parent)
+{
+	struct kvx_apic_gic *gic;
+	int ret;
+	unsigned int irq;
+
+	if (!parent) {
+		pr_err("kvx apic gic does not have parent\n");
+		return -EINVAL;
+	}
+
+	gic = kzalloc(sizeof(*gic), GFP_KERNEL);
+	if (!gic)
+		return -ENOMEM;
+
+	if (of_property_read_u32(node, "kalray,intc-nr-irqs",
+						&gic->input_nr_irqs))
+		gic->input_nr_irqs = KVX_GIC_INPUT_IT_COUNT;
+
+	if (WARN_ON(gic->input_nr_irqs > KVX_GIC_INPUT_IT_COUNT)) {
+		ret = -EINVAL;
+		goto err_kfree;
+	}
+
+	gic->base = of_io_request_and_map(node, 0, node->name);
+	if (!gic->base) {
+		ret = -EINVAL;
+		goto err_kfree;
+	}
+
+	raw_spin_lock_init(&gic->lock);
+	apic_gic_init(gic);
+
+	gic->domain = irq_domain_add_linear(node,
+					gic->input_nr_irqs,
+					&kvx_apic_gic_domain_ops,
+					gic);
+	if (!gic->domain) {
+		pr_err("Failed to add IRQ domain\n");
+		ret = -EINVAL;
+		goto err_iounmap;
+	}
+
+	irq = irq_of_parse_and_map(node, 0);
+	if (irq <= 0) {
+		pr_err("unable to parse irq\n");
+		ret = -EINVAL;
+		goto err_irq_domain_remove;
+	}
+
+	irq_set_chained_handler_and_data(irq, kvx_apic_gic_handle_irq,
+								gic);
+
+	gic_parent_irq = irq;
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+				"kvx/gic:online",
+				kvx_gic_starting_cpu,
+				kvx_gic_dying_cpu);
+	if (ret < 0) {
+		pr_err("Failed to setup hotplug state");
+		goto err_irq_unmap;
+	}
+
+	pr_info("Initialized interrupt controller with %d interrupts\n",
+							gic->input_nr_irqs);
+	return 0;
+
+err_irq_unmap:
+	irq_dispose_mapping(irq);
+err_irq_domain_remove:
+	irq_domain_remove(gic->domain);
+err_iounmap:
+	iounmap(gic->base);
+err_kfree:
+	kfree(gic);
+
+	return ret;
+}
+
+IRQCHIP_DECLARE(kvx_apic_gic, "kalray,kvx-apic-gic", kvx_init_apic_gic);
diff --git a/drivers/irqchip/irq-kvx-apic-mailbox.c b/drivers/irqchip/irq-kvx-apic-mailbox.c
new file mode 100644
index 000000000000..c279a29ee7d0
--- /dev/null
+++ b/drivers/irqchip/irq-kvx-apic-mailbox.c
@@ -0,0 +1,465 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017 - 2022 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Jules Maselbas
+ */
+
+#define pr_fmt(fmt)	"kvx_apic_mailbox: " fmt
+
+#include <linux/irqchip/irq-kvx-apic-mailbox.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/of_address.h>
+#include <linux/interrupt.h>
+#include <linux/irqdomain.h>
+#include <linux/iommu.h>
+#include <linux/irqchip.h>
+#include <linux/module.h>
+#include <linux/of_irq.h>
+#include <linux/init.h>
+#include <linux/msi.h>
+#include <linux/of.h>
+
+#define MAILBOXES_MAX_COUNT 128
+
+/* Mailboxes are 64 bits wide */
+#define MAILBOXES_BIT_SIZE 64
+
+/* Maximum number of mailboxes available */
+#define MAILBOXES_MAX_BIT_COUNT (MAILBOXES_MAX_COUNT * MAILBOXES_BIT_SIZE)
+
+/* Mailboxes are grouped by 8 in a single page */
+#define MAILBOXES_BITS_PER_PAGE (8 * MAILBOXES_BIT_SIZE)
+
+/**
+ * struct mb_data - per mailbox data
+ * @cpu: CPU on which the mailbox is routed
+ * @parent_irq: Parent IRQ on the GIC
+ */
+struct mb_data {
+	unsigned int cpu;
+	unsigned int parent_irq;
+};
+
+/**
+ * struct kvx_apic_mailbox - kvx apic mailbox
+ * @base: base address of the controller
+ * @device_domain: IRQ device domain for mailboxes
+ * @msi_domain: platform MSI domain for MSI interface
+ * @domain_info: Domain information needed for the MSI domain
+ * @mb_count: Count of mailboxes we are handling
+ * @available: bitmap of availables bits in mailboxes
+ * @mailboxes_lock: lock for irq migration
+ * @mask_lock: lock for irq masking
+ * @mb_data: data associated to each mailbox
+ */
+struct kvx_apic_mailbox {
+	void __iomem *base;
+	phys_addr_t phys_base;
+	struct irq_domain *device_domain;
+	struct irq_domain *msi_domain;
+	struct msi_domain_info domain_info;
+	/* Start and count of device mailboxes */
+	unsigned int mb_count;
+	/* Bitmap of allocated bits in mailboxes */
+	DECLARE_BITMAP(available, MAILBOXES_MAX_BIT_COUNT);
+	spinlock_t mailboxes_lock;
+	raw_spinlock_t mask_lock;
+	struct mb_data mb_data[MAILBOXES_MAX_COUNT];
+};
+
+/**
+ * struct kvx_irq_data - per irq data
+ * @mb: Mailbox structure
+ */
+struct kvx_irq_data {
+	struct kvx_apic_mailbox *mb;
+};
+
+static void kvx_mailbox_get_from_hwirq(unsigned int hw_irq,
+				       unsigned int *mailbox_num,
+				       unsigned int *mailbox_bit)
+{
+	*mailbox_num = hw_irq / MAILBOXES_BIT_SIZE;
+	*mailbox_bit = hw_irq % MAILBOXES_BIT_SIZE;
+}
+
+static void __iomem *kvx_mailbox_get_addr(struct kvx_apic_mailbox *mb,
+				   unsigned int num)
+{
+	return mb->base + (num * KVX_MAILBOX_ELEM_SIZE);
+}
+
+static phys_addr_t kvx_mailbox_get_phys_addr(struct kvx_apic_mailbox *mb,
+				   unsigned int num)
+{
+	return mb->phys_base + (num * KVX_MAILBOX_ELEM_SIZE);
+}
+
+static void kvx_mailbox_msi_compose_msg(struct irq_data *data,
+					struct msi_msg *msg)
+{
+	struct kvx_irq_data *kd = irq_data_get_irq_chip_data(data);
+	struct kvx_apic_mailbox *mb = kd->mb;
+	unsigned int mb_num, mb_bit;
+	phys_addr_t mb_addr;
+
+	kvx_mailbox_get_from_hwirq(irqd_to_hwirq(data), &mb_num, &mb_bit);
+	mb_addr = kvx_mailbox_get_phys_addr(mb, mb_num);
+
+	msg->address_hi = upper_32_bits(mb_addr);
+	msg->address_lo = lower_32_bits(mb_addr);
+	msg->data = mb_bit;
+
+	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), msg);
+}
+
+static void kvx_mailbox_set_irq_enable(struct irq_data *data,
+				     bool enabled)
+{
+	struct kvx_irq_data *kd = irq_data_get_irq_chip_data(data);
+	struct kvx_apic_mailbox *mb = kd->mb;
+	unsigned int mb_num, mb_bit;
+	void __iomem *mb_addr;
+	u64 mask_value, mb_value;
+
+	kvx_mailbox_get_from_hwirq(irqd_to_hwirq(data), &mb_num, &mb_bit);
+	mb_addr = kvx_mailbox_get_addr(mb, mb_num);
+
+	raw_spin_lock(&mb->mask_lock);
+	mask_value = readq(mb_addr + KVX_MAILBOX_MASK_OFFSET);
+	if (enabled)
+		mask_value |= BIT_ULL(mb_bit);
+	else
+		mask_value &= ~BIT_ULL(mb_bit);
+
+	writeq(mask_value, mb_addr + KVX_MAILBOX_MASK_OFFSET);
+
+	raw_spin_unlock(&mb->mask_lock);
+
+	/**
+	 * Since interrupts on mailboxes are edge triggered and are only
+	 * triggered when writing the value, we need to trigger it manually
+	 * after updating the mask if enabled. If the interrupt was triggered by
+	 * the device just after the mask write, we can trigger a spurious
+	 * interrupt but that is still better than missing one...
+	 * Moreover, the mailbox is configured in OR mode which means that even
+	 * if we write a single bit, all other bits will be kept intact.
+	 */
+	if (enabled) {
+		mb_value = readq(mb_addr + KVX_MAILBOX_VALUE_OFFSET);
+		if (mb_value & BIT_ULL(mb_bit))
+			writeq(BIT_ULL(mb_bit),
+			       mb_addr + KVX_MAILBOX_VALUE_OFFSET);
+	}
+}
+
+static void kvx_mailbox_mask(struct irq_data *data)
+{
+	kvx_mailbox_set_irq_enable(data, false);
+}
+
+static void kvx_mailbox_unmask(struct irq_data *data)
+{
+	kvx_mailbox_set_irq_enable(data, true);
+}
+
+static void kvx_mailbox_set_cpu(struct kvx_apic_mailbox *mb, int mb_id,
+			       int new_cpu)
+{
+	irq_set_affinity(mb->mb_data[mb_id].parent_irq, cpumask_of(new_cpu));
+	mb->mb_data[mb_id].cpu = new_cpu;
+}
+
+static void kvx_mailbox_free_bit(struct kvx_apic_mailbox *mb, int hw_irq)
+{
+	unsigned int mb_num, mb_bit;
+
+	kvx_mailbox_get_from_hwirq(hw_irq, &mb_num, &mb_bit);
+	bitmap_clear(mb->available, hw_irq, 1);
+
+	/* If there is no more IRQ on this mailbox, reset it to CPU 0 */
+	if (mb->available[mb_num] == 0)
+		kvx_mailbox_set_cpu(mb, mb_num, 0);
+}
+
+struct irq_chip kvx_apic_mailbox_irq_chip = {
+	.name = "kvx apic mailbox",
+	.irq_compose_msi_msg = kvx_mailbox_msi_compose_msg,
+	.irq_mask = kvx_mailbox_mask,
+	.irq_unmask = kvx_mailbox_unmask,
+};
+
+static int kvx_mailbox_allocate_bits(struct kvx_apic_mailbox *mb, int num_req)
+{
+	int first, align_mask = 0;
+
+	/* This must be a power of 2 for bitmap_find_next_zero_area to work */
+	BUILD_BUG_ON((MAILBOXES_BITS_PER_PAGE & (MAILBOXES_BITS_PER_PAGE - 1)));
+
+	/*
+	 * If user requested more than 1 mailbox, we must make sure it will be
+	 * aligned on a page size for iommu_dma_prepare_msi to be correctly
+	 * mapped in a single page.
+	 */
+	if (num_req > 1)
+		align_mask = (MAILBOXES_BITS_PER_PAGE - 1);
+
+	spin_lock(&mb->mailboxes_lock);
+
+	first = bitmap_find_next_zero_area(mb->available,
+			mb->mb_count * MAILBOXES_BIT_SIZE, 0,
+			num_req, align_mask);
+	if (first >= MAILBOXES_MAX_BIT_COUNT) {
+		spin_unlock(&mb->mailboxes_lock);
+		return -ENOSPC;
+	}
+
+	bitmap_set(mb->available, first, num_req);
+
+	spin_unlock(&mb->mailboxes_lock);
+
+	return first;
+}
+
+static int kvx_apic_mailbox_msi_alloc(struct irq_domain *domain,
+				      unsigned int virq,
+				      unsigned int nr_irqs, void *args)
+{
+	int i, err;
+	int hwirq = 0;
+	u64 mb_addr;
+	struct irq_data *d;
+	struct kvx_irq_data *kd;
+	struct kvx_apic_mailbox *mb = domain->host_data;
+	struct msi_alloc_info *msi_info = (struct msi_alloc_info *)args;
+	struct msi_desc *desc = msi_info->desc;
+	unsigned int mb_num, mb_bit;
+
+	/* We will not be able to guarantee page alignment ! */
+	if (nr_irqs > MAILBOXES_BITS_PER_PAGE)
+		return -EINVAL;
+
+	hwirq = kvx_mailbox_allocate_bits(mb, nr_irqs);
+	if (hwirq < 0)
+		return hwirq;
+
+	kvx_mailbox_get_from_hwirq(hwirq, &mb_num, &mb_bit);
+	mb_addr = (u64) kvx_mailbox_get_phys_addr(mb, mb_num);
+	err = iommu_dma_prepare_msi(desc, mb_addr);
+	if (err)
+		goto free_mb_bits;
+
+	for (i = 0; i < nr_irqs; i++) {
+		kd = kmalloc(sizeof(*kd), GFP_KERNEL);
+		if (!kd) {
+			err = -ENOMEM;
+			goto free_irq_data;
+		}
+
+		kd->mb = mb;
+		irq_domain_set_info(domain, virq + i, hwirq + i,
+				    &kvx_apic_mailbox_irq_chip,
+				    kd, handle_simple_irq,
+				    NULL, NULL);
+	}
+
+	return 0;
+
+free_irq_data:
+	for (i--; i >= 0; i--) {
+		d = irq_domain_get_irq_data(domain, virq + i);
+		kd = irq_data_get_irq_chip_data(d);
+		kfree(kd);
+	}
+
+free_mb_bits:
+	spin_lock(&mb->mailboxes_lock);
+	bitmap_clear(mb->available, hwirq, nr_irqs);
+	spin_unlock(&mb->mailboxes_lock);
+
+	return err;
+}
+
+static void kvx_apic_mailbox_msi_free(struct irq_domain *domain,
+				      unsigned int virq,
+				      unsigned int nr_irqs)
+{
+	int i;
+	struct irq_data *d;
+	struct kvx_irq_data *kd;
+	struct kvx_apic_mailbox *mb = domain->host_data;
+
+	spin_lock(&mb->mailboxes_lock);
+
+	for (i = 0; i < nr_irqs; i++) {
+		d = irq_domain_get_irq_data(domain, virq + i);
+		kd = irq_data_get_irq_chip_data(d);
+		kfree(kd);
+		kvx_mailbox_free_bit(mb, d->hwirq);
+	}
+
+	spin_unlock(&mb->mailboxes_lock);
+}
+
+static const struct irq_domain_ops kvx_apic_mailbox_domain_ops = {
+	.alloc  = kvx_apic_mailbox_msi_alloc,
+	.free	= kvx_apic_mailbox_msi_free
+};
+
+static struct irq_chip kvx_msi_irq_chip = {
+	.name	= "KVX MSI",
+};
+
+static void kvx_apic_mailbox_handle_irq(struct irq_desc *desc)
+{
+	struct irq_data *data = irq_desc_get_irq_data(desc);
+	struct kvx_apic_mailbox *mb = irq_desc_get_handler_data(desc);
+	void __iomem *mb_addr = kvx_mailbox_get_addr(mb, irqd_to_hwirq(data));
+	unsigned int irqn, cascade_irq, bit;
+	u64 mask_value, masked_its;
+	u64 mb_value;
+	/* Since we allocate 64 interrupts for each mailbox, the scheme
+	 * to find the hwirq associated to a mailbox irq is the
+	 * following:
+	 * hw_irq = mb_num * MAILBOXES_BIT_SIZE + bit
+	 */
+	unsigned int mb_hwirq = irqd_to_hwirq(data) * MAILBOXES_BIT_SIZE;
+
+	mb_value = readq(mb_addr + KVX_MAILBOX_LAC_OFFSET);
+	mask_value = readq(mb_addr + KVX_MAILBOX_MASK_OFFSET);
+	/* Mask any disabled interrupts */
+	mb_value &= mask_value;
+
+	/**
+	 * Write all pending ITs that are masked to process them later
+	 * Since the mailbox is in OR mode, these bits will be merged with any
+	 * already set bits and thus avoid losing any interrupts.
+	 */
+	masked_its = (~mask_value) & mb_value;
+	if (masked_its)
+		writeq(masked_its, mb_addr + KVX_MAILBOX_LAC_OFFSET);
+
+	for_each_set_bit(bit, (unsigned long *) &mb_value, BITS_PER_LONG) {
+		irqn = bit + mb_hwirq;
+		cascade_irq = irq_find_mapping(mb->device_domain, irqn);
+		generic_handle_irq(cascade_irq);
+	}
+}
+
+static void __init
+apic_mailbox_reset(struct kvx_apic_mailbox *mb)
+{
+	unsigned int i;
+	unsigned int mb_end = mb->mb_count;
+	void __iomem *mb_addr;
+	u64 funct_val = (KVX_MAILBOX_MODE_OR << KVX_MAILBOX_FUNCT_MODE_SHIFT) |
+		(KVX_MAILBOX_TRIG_DOORBELL << KVX_MAILBOX_FUNCT_TRIG_SHIFT);
+
+	for (i = 0; i < mb_end; i++) {
+		mb_addr = kvx_mailbox_get_addr(mb, i);
+		/* Disable all interrupts */
+		writeq(0ULL, mb_addr + KVX_MAILBOX_MASK_OFFSET);
+		/* Set mailbox to OR mode + trigger */
+		writeq(funct_val, mb_addr + KVX_MAILBOX_FUNCT_OFFSET);
+		/* Load & Clear mailbox value */
+		readq(mb_addr + KVX_MAILBOX_LAC_OFFSET);
+	}
+}
+
+static struct msi_domain_ops kvx_msi_domain_ops = {
+};
+
+static struct msi_domain_info kvx_msi_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
+	.ops	= &kvx_msi_domain_ops,
+	.chip	= &kvx_msi_irq_chip,
+};
+
+static int __init
+kvx_init_apic_mailbox(struct device_node *node,
+		      struct device_node *parent)
+{
+	struct kvx_apic_mailbox *mb;
+	unsigned int parent_irq, irq_count;
+	struct resource res;
+	int ret, i;
+
+	mb = kzalloc(sizeof(*mb), GFP_KERNEL);
+	if (!mb)
+		return -ENOMEM;
+
+	ret = of_address_to_resource(node, 0, &res);
+	if (ret)
+		return -EINVAL;
+
+	mb->phys_base = res.start;
+	mb->base = of_io_request_and_map(node, 0, node->name);
+	if (!mb->base) {
+		ret = -EINVAL;
+		goto err_kfree;
+	}
+
+	spin_lock_init(&mb->mailboxes_lock);
+	raw_spin_lock_init(&mb->mask_lock);
+
+	irq_count = of_irq_count(node);
+	if (irq_count == 0 || irq_count > MAILBOXES_MAX_COUNT) {
+		ret = -EINVAL;
+		goto err_kfree;
+	}
+	mb->mb_count = irq_count;
+
+	apic_mailbox_reset(mb);
+
+	mb->device_domain = irq_domain_add_tree(node,
+						&kvx_apic_mailbox_domain_ops,
+						mb);
+	if (!mb->device_domain) {
+		pr_err("Failed to setup device domain\n");
+		ret = -EINVAL;
+		goto err_iounmap;
+	}
+
+	mb->msi_domain = platform_msi_create_irq_domain(of_node_to_fwnode(node),
+						     &kvx_msi_domain_info,
+						     mb->device_domain);
+	if (!mb->msi_domain) {
+		ret = -EINVAL;
+		goto err_irq_domain_add_tree;
+	}
+
+	/* Chain all interrupts from gic to mailbox */
+	for (i = 0; i < irq_count; i++) {
+		parent_irq = irq_of_parse_and_map(node, i);
+		if (parent_irq == 0) {
+			pr_err("unable to parse irq\n");
+			ret = -EINVAL;
+			goto err_irq_domain_msi_create;
+		}
+		mb->mb_data[i].parent_irq = parent_irq;
+
+		irq_set_chained_handler_and_data(parent_irq,
+						 kvx_apic_mailbox_handle_irq,
+						 mb);
+	}
+
+	pr_info("Init with %d device interrupt\n",
+					mb->mb_count * MAILBOXES_BIT_SIZE);
+
+	return 0;
+
+err_irq_domain_msi_create:
+	irq_domain_remove(mb->msi_domain);
+err_irq_domain_add_tree:
+	irq_domain_remove(mb->device_domain);
+err_iounmap:
+	iounmap(mb->base);
+err_kfree:
+	kfree(mb);
+
+	return ret;
+}
+
+IRQCHIP_DECLARE(kvx_apic_mailbox, "kalray,kvx-apic-mailbox",
+		kvx_init_apic_mailbox);
diff --git a/drivers/irqchip/irq-kvx-core-intc.c b/drivers/irqchip/irq-kvx-core-intc.c
new file mode 100644
index 000000000000..4315108d563c
--- /dev/null
+++ b/drivers/irqchip/irq-kvx-core-intc.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017 - 2022 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#define pr_fmt(fmt)	"kvx_core_intc: " fmt
+
+#include <linux/interrupt.h>
+#include <linux/irqdomain.h>
+#include <linux/irqchip.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/of.h>
+#include <asm/irq.h>
+
+#define KVX_CORE_INTC_IRQ	32
+
+
+static void kvx_irq_mask(struct irq_data *data)
+{
+	kvx_sfr_clear_bit(ILE, data->hwirq);
+}
+
+static void kvx_irq_unmask(struct irq_data *data)
+{
+	kvx_sfr_set_bit(ILE, data->hwirq);
+}
+
+static struct irq_chip kvx_irq_chip = {
+	.name           = "kvx core Intc",
+	.irq_mask	= kvx_irq_mask,
+	.irq_unmask	= kvx_irq_unmask,
+};
+
+static int kvx_irq_map(struct irq_domain *d, unsigned int irq,
+			 irq_hw_number_t hw)
+{
+	/* All interrupts for core are per cpu */
+	irq_set_percpu_devid(irq);
+	irq_set_chip_and_handler(irq, &kvx_irq_chip, handle_percpu_irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops kvx_irq_ops = {
+	.xlate = irq_domain_xlate_onecell,
+	.map = kvx_irq_map,
+};
+
+static int __init
+kvx_init_core_intc(struct device_node *intc, struct device_node *parent)
+{
+	struct irq_domain *root_domain;
+	uint32_t core_nr_irqs;
+
+	if (parent)
+		panic("DeviceTree core intc not a root irq controller\n");
+
+	if (of_property_read_u32(intc, "kalray,intc-nr-irqs", &core_nr_irqs))
+		core_nr_irqs = KVX_CORE_INTC_IRQ;
+
+	/* We only have up to 32 interrupts, according to IRQ-domain.txt,
+	 * linear is likely to be the best choice
+	 */
+	root_domain = irq_domain_add_linear(intc, core_nr_irqs,
+						&kvx_irq_ops, NULL);
+	if (!root_domain)
+		panic("root irq domain not avail\n");
+
+	/*
+	 * Needed for primary domain lookup to succeed
+	 * This is a primary irqchip, and can never have a parent
+	 */
+	irq_set_default_host(root_domain);
+
+	pr_info("Initialized with %d interrupts\n", core_nr_irqs);
+
+	return 0;
+}
+
+IRQCHIP_DECLARE(kvx_core_intc, "kalray,kvx-core-intc", kvx_init_core_intc);
diff --git a/drivers/irqchip/irq-kvx-itgen.c b/drivers/irqchip/irq-kvx-itgen.c
new file mode 100644
index 000000000000..1d35c2c772a0
--- /dev/null
+++ b/drivers/irqchip/irq-kvx-itgen.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017 - 2022 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Julian Vetter
+ *            Vincent Chardon
+ */
+
+#include <linux/irqchip/irq-kvx-itgen.h>
+#include <linux/platform_device.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/interrupt.h>
+#include <linux/irqdomain.h>
+#include <linux/irqchip.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+
+#define MB_ADDR_CLUSTER_SHIFT	24
+#define MB_ADDR_MAILBOX_SHIFT	9
+
+/**
+ * struct kvx_itgen - kvx interrupt generator (MSI client)
+ * @base: base address of the itgen controller
+ * @domain: IRQ domain of the controller
+ * @pdev: Platform device associated to the controller
+ */
+struct kvx_itgen {
+	void __iomem *base;
+	struct irq_domain *domain;
+	struct platform_device *pdev;
+};
+
+static void __iomem *get_itgen_cfg_offset(struct kvx_itgen *itgen,
+						irq_hw_number_t hwirq)
+{
+	return itgen->base + KVX_ITGEN_CFG_TARGET_OFFSET +
+				hwirq * KVX_ITGEN_CFG_ELEM_SIZE;
+}
+
+void __iomem *get_itgen_param_offset(struct kvx_itgen *itgen)
+{
+	return itgen->base + KVX_ITGEN_PARAM_OFFSET;
+}
+
+static void kvx_itgen_enable(struct irq_data *data, u32 value)
+{
+	struct kvx_itgen *itgen = irq_data_get_irq_chip_data(data);
+	void __iomem *enable_reg =
+		get_itgen_cfg_offset(itgen, irqd_to_hwirq(data)) +
+		KVX_ITGEN_CFG_ENABLE_OFFSET;
+
+	dev_dbg(&itgen->pdev->dev, "%sabling hwirq %d, addr %p\n",
+		 value ? "En" : "Dis",
+		 (int) irqd_to_hwirq(data),
+		 enable_reg);
+	writel(value, enable_reg);
+}
+
+static void kvx_itgen_mask(struct irq_data *data)
+{
+	kvx_itgen_enable(data, 0x0);
+	irq_chip_mask_parent(data);
+}
+
+static void kvx_itgen_unmask(struct irq_data *data)
+{
+	kvx_itgen_enable(data, 0x1);
+	irq_chip_unmask_parent(data);
+}
+
+#ifdef CONFIG_SMP
+static int kvx_itgen_irq_set_affinity(struct irq_data *data,
+				      const struct cpumask *dest, bool force)
+{
+	return -ENOSYS;
+}
+#endif
+
+static struct irq_chip itgen_irq_chip = {
+	.name =			"kvx-itgen",
+	.irq_mask =		kvx_itgen_mask,
+	.irq_unmask =		kvx_itgen_unmask,
+#ifdef CONFIG_SMP
+	.irq_set_affinity =	kvx_itgen_irq_set_affinity,
+#endif
+};
+
+#define ITGEN_UNSUPPORTED_TYPES (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_EDGE_FALLING)
+
+static int kvx_itgen_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				   unsigned int nr_irqs, void *args)
+{
+	int i, err;
+	struct irq_fwspec *fwspec = args;
+	int hwirq = fwspec->param[0];
+	int type = IRQ_TYPE_NONE;
+	struct kvx_itgen *itgen;
+
+	if (fwspec->param_count >= 2)
+		type = fwspec->param[1];
+
+	WARN_ON(type & ITGEN_UNSUPPORTED_TYPES);
+
+	err = platform_msi_device_domain_alloc(domain, virq, nr_irqs);
+	if (err)
+		return err;
+
+	itgen = platform_msi_get_host_data(domain);
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
+				      &itgen_irq_chip, itgen);
+		if (type == IRQ_TYPE_LEVEL_HIGH)
+			irq_set_handler(virq + i, handle_level_irq);
+	}
+
+	return 0;
+}
+
+static const struct irq_domain_ops itgen_domain_ops = {
+	.alloc		= kvx_itgen_domain_alloc,
+	.free		= irq_domain_free_irqs_common,
+};
+
+static void kvx_itgen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	struct irq_data *d = irq_get_irq_data(desc->irq);
+	struct kvx_itgen *itgen = irq_data_get_irq_chip_data(d);
+	uint32_t cfg_val = 0;
+	uintptr_t dest_addr = ((uint64_t) msg->address_hi << 32) |
+							msg->address_lo;
+	void __iomem *cfg = get_itgen_cfg_offset(itgen, irqd_to_hwirq(d));
+
+	/**
+	 * Address in the msi data is the address of the targeted mailbox.
+	 * To save a few cells of hw, itgen configuration expects the
+	 * target of the write using mppa id, cluster id and mailbox id instead
+	 * of address.
+	 * We extract these information from mailbox address.
+	 */
+
+	cfg_val |= (((kvx_sfr_get(PCR) & KVX_SFR_PCR_CID_MASK) >>
+				 KVX_SFR_PCR_CID_SHIFT)
+				<< KVX_ITGEN_CFG_TARGET_CLUSTER_SHIFT);
+	cfg_val |= ((dest_addr >> MB_ADDR_MAILBOX_SHIFT) &
+		     KVX_ITGEN_CFG_TARGET_MAILBOX_MASK)
+		    << KVX_ITGEN_CFG_TARGET_MAILBOX_SHIFT;
+
+	/**
+	 * msg->data contains the bit number to be written and is included in
+	 * the itgen config
+	 */
+	cfg_val |= ((msg->data << KVX_ITGEN_CFG_TARGET_SELECT_BIT_SHIFT)
+		    & KVX_ITGEN_CFG_TARGET_SELECT_BIT_MASK);
+
+	dev_dbg(&itgen->pdev->dev,
+		"Writing dest_addr %lx, value %x to cfg %p\n",
+		dest_addr, cfg_val, cfg);
+
+	writel(cfg_val, cfg);
+}
+
+static int
+kvx_itgen_device_probe(struct platform_device *pdev)
+{
+	struct kvx_itgen *itgen;
+	u32 it_count;
+	struct resource *mem;
+
+	itgen = devm_kzalloc(&pdev->dev, sizeof(*itgen), GFP_KERNEL);
+	if (!itgen)
+		return -ENOMEM;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	itgen->base = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(itgen->base)) {
+		dev_err(&pdev->dev, "Failed to ioremap itgen\n");
+		return PTR_ERR(itgen->base);
+	}
+
+	itgen->pdev = pdev;
+	it_count = readl(get_itgen_param_offset(itgen) +
+				KVX_ITGEN_PARAM_IT_NUM_OFFSET);
+
+	itgen->domain = platform_msi_create_device_domain(&pdev->dev,
+						   it_count,
+						   kvx_itgen_write_msg,
+						   &itgen_domain_ops,
+						   itgen);
+	if (!itgen->domain) {
+		dev_err(&pdev->dev, "Failed to create device domain\n");
+		return -ENOMEM;
+	}
+
+	dev_info(&pdev->dev, "Probed with %d interrupts\n", it_count);
+
+	platform_set_drvdata(pdev, itgen);
+
+	return 0;
+}
+
+static const struct of_device_id itgen_of_match[] = {
+	{ .compatible = "kalray,kvx-itgen" },
+	{ /* END */ }
+};
+MODULE_DEVICE_TABLE(of, itgen_of_match);
+
+static struct platform_driver itgen_platform_driver = {
+	.driver = {
+		.name		= "kvx-itgen",
+		.of_match_table	= itgen_of_match,
+	},
+	.probe			= kvx_itgen_device_probe,
+};
+
+static int __init kvx_itgen_init(void)
+{
+	return platform_driver_register(&itgen_platform_driver);
+}
+
+arch_initcall(kvx_itgen_init);
diff --git a/include/linux/irqchip/irq-kvx-apic-gic.h b/include/linux/irqchip/irq-kvx-apic-gic.h
new file mode 100644
index 000000000000..8efbcd05f3ea
--- /dev/null
+++ b/include/linux/irqchip/irq-kvx-apic-gic.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018-2023 Kalray Inc.
+ * Author: Clement Leger
+ */
+
+#ifndef KVX_APIC_GIC_H
+#define KVX_APIC_GIC_H
+
+/* GIC enable register definitions */
+#define KVX_GIC_ENABLE_OFFSET     0x0
+#define KVX_GIC_ENABLE_ELEM_SIZE  0x1
+#define KVX_GIC_INPUT_IT_COUNT 0x9D
+#define KVX_GIC_ELEM_SIZE 0x400
+
+/* GIC status lac register definitions */
+#define KVX_GIC_STATUS_LAC_OFFSET     0x120
+#define KVX_GIC_STATUS_LAC_ELEM_SIZE  0x8
+#define KVX_GIC_STATUS_LAC_ARRAY_SIZE 0x3
+
+#endif /* KVX_APIC_GIC_H */
diff --git a/include/linux/irqchip/irq-kvx-apic-mailbox.h b/include/linux/irqchip/irq-kvx-apic-mailbox.h
new file mode 100644
index 000000000000..40ec60de155c
--- /dev/null
+++ b/include/linux/irqchip/irq-kvx-apic-mailbox.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018-2023 Kalray Inc.
+ */
+
+#ifndef IRQ_KVX_APIC_MAILBOX_H
+#define IRQ_KVX_APIC_MAILBOX_H
+
+#define KVX_MAILBOX_MODE_WRITE  0x0
+#define KVX_MAILBOX_MODE_OR  0x1
+#define KVX_MAILBOX_MODE_ADD  0x2
+
+#define KVX_MAILBOX_TRIG_NO_TRIG 0x0
+#define KVX_MAILBOX_TRIG_DOORBELL 0x1
+#define KVX_MAILBOX_TRIG_MATCH 0x2
+#define KVX_MAILBOX_TRIG_BARRIER 0x3
+#define KVX_MAILBOX_TRIG_THRESHOLD 0x4
+
+/* Mailbox defines */
+#define KVX_MAILBOX_OFFSET 0x0
+#define KVX_MAILBOX_ELEM_SIZE 0x200
+#define KVX_MAILBOX_MASK_OFFSET     0x10
+#define KVX_MAILBOX_FUNCT_OFFSET     0x18
+#define KVX_MAILBOX_LAC_OFFSET     0x8
+#define KVX_MAILBOX_VALUE_OFFSET     0x0
+#define KVX_MAILBOX_FUNCT_MODE_SHIFT  0x0
+#define KVX_MAILBOX_FUNCT_TRIG_SHIFT 0x8
+
+#endif /* IRQ_KVX_APIC_MAILBOX_H */
diff --git a/include/linux/irqchip/irq-kvx-itgen.h b/include/linux/irqchip/irq-kvx-itgen.h
new file mode 100644
index 000000000000..6845a2509b14
--- /dev/null
+++ b/include/linux/irqchip/irq-kvx-itgen.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018-2023 Kalray Inc.
+ */
+
+#ifndef IRQ_KVX_ITGEN_H
+#define IRQ_KVX_ITGEN_H
+
+/* Parameters */
+#define KVX_ITGEN_PARAM_OFFSET 0x1100
+#define KVX_ITGEN_PARAM_IT_NUM_OFFSET     0x0
+
+/* Target configuration */
+#define KVX_ITGEN_CFG_ENABLE_OFFSET     0x8
+#define KVX_ITGEN_CFG_ELEM_SIZE 0x10
+#define KVX_ITGEN_CFG_TARGET_OFFSET     0x0
+#define KVX_ITGEN_CFG_TARGET_MAILBOX_SHIFT    0x0
+#define KVX_ITGEN_CFG_TARGET_MAILBOX_MASK     0x7FUL
+#define KVX_ITGEN_CFG_TARGET_CLUSTER_SHIFT    0x8
+#define KVX_ITGEN_CFG_TARGET_CLUSTER_MASK     0x700UL
+#define KVX_ITGEN_CFG_TARGET_SELECT_BIT_SHIFT 0x18
+#define KVX_ITGEN_CFG_TARGET_SELECT_BIT_MASK  0x3F000000UL
+
+#endif /* IRQ_KVX_ITGEN_H */
-- 
2.37.2







