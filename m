Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4084D64148F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 07:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiLCGrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 01:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiLCGrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 01:47:05 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA19BB01F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 22:47:02 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id y17so6560220plp.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 22:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpJaq9SMivc7n8YOEwLCLYHs41XTFo8QrdoctGCfITY=;
        b=hwMgvdUurKCo6f0llPIH7ftSbz+rjFCYRA8au8ldJYXxBkeCmnaBvgiYiRpJsd/6/2
         JU+M5xqXcoll7wmbGKEzO8FC0L3rZSsNGekQrV5q7Wa1Vy08pw2CP8UM6ADSN2KxyHqR
         6zrTXBw0McAYqBniEgO8r3J9jK2dWDRdAc144UTF6RH6yssL+tqthebRbQS9xqe3bmt8
         2Q9Jo6ustpqz6y+g8KHx5BLlcBWH2HLTRWytAfDmgo97E3Rn5UBym8pUPX0CQVgGwk/o
         gEj+dPn49kprulDl30QWyFcV8ILwxnRQuVBPKu7Eq4YcXkfL4kT9mRxgsHK2z2EkZBW/
         4oJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpJaq9SMivc7n8YOEwLCLYHs41XTFo8QrdoctGCfITY=;
        b=DwGn8TmVXqShXTOz+HmfGM3Nvu+OE5q2wGkmCnBw7IrnMei3QQkns9kb/XbqhZv3qD
         +g1H5o3vAYkOLSp96K+nlnKEats2gpJ80TGNvGloQ1mxmNv5qRm5ZT8b7uz/YTW/L2Oh
         vT8pSbSUG5EPxIRfz+cEY7EBqhf2THAlnb7dTKu9TLkBvhDoYGhZZeA2FOY31gU4lR63
         JWMvEeaKHGZPIm4W2LLnDxI1sYwBUwQdPZpNmW8zrEVfXIhoQr8/F6bhbIdXBMvla767
         8hHIgUqEvvmm5xicJ3fLmyUht43OjJrqk4XKUMDdkximGlcWsE9exzZEcuSYg+F+9Sbr
         20cQ==
X-Gm-Message-State: ANoB5pmR78a8TOIE2FhgJvlHNojn+Jc1YPi11L0OPViAZw36xDsVR1MA
        wDiFEmqxeNzN9hRWC1NfC4TDIg==
X-Google-Smtp-Source: AA0mqf7ygYBWSWQBnzbTj/ozpEY3GVBgH2CHOBlpOU1nBZb4PnyqjXvP/okvtP4QmVV9v6ZCGDAY7Q==
X-Received: by 2002:a17:90b:e18:b0:219:31ed:22be with SMTP id ge24-20020a17090b0e1800b0021931ed22bemr31553121pjb.75.1670050021738;
        Fri, 02 Dec 2022 22:47:01 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id t17-20020aa79471000000b00575c8242849sm6102091pfq.69.2022.12.02.22.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 22:47:01 -0800 (PST)
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
Subject: [PATCH v15 3/9] genirq: Add mechanism to multiplex a single HW IPI
Date:   Sat,  3 Dec 2022 12:16:23 +0530
Message-Id: <20221203064629.1601299-4-apatel@ventanamicro.com>
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

All RISC-V platforms have a single HW IPI provided by the INTC local
interrupt controller. The HW method to trigger INTC IPI can be through
external irqchip (e.g. RISC-V AIA), through platform specific device
(e.g. SiFive CLINT timer), or through firmware (e.g. SBI IPI call).

To support multiple IPIs on RISC-V, add a generic IPI multiplexing
mechanism which help us create multiple virtual IPIs using a single
HW IPI. This generic IPI multiplexing is inspired by the Apple AIC
irqchip driver and it is shared by various RISC-V irqchip drivers.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 include/linux/irq.h  |   3 +
 kernel/irq/Kconfig   |   5 ++
 kernel/irq/Makefile  |   1 +
 kernel/irq/ipi-mux.c | 207 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 216 insertions(+)
 create mode 100644 kernel/irq/ipi-mux.c

diff --git a/include/linux/irq.h b/include/linux/irq.h
index c3eb89606c2b..b1b28affb32a 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1266,6 +1266,9 @@ int __ipi_send_mask(struct irq_desc *desc, const struct cpumask *dest);
 int ipi_send_single(unsigned int virq, unsigned int cpu);
 int ipi_send_mask(unsigned int virq, const struct cpumask *dest);
 
+void ipi_mux_process(void);
+int ipi_mux_create(unsigned int nr_ipi, void (*mux_send)(unsigned int cpu));
+
 #ifdef CONFIG_GENERIC_IRQ_MULTI_HANDLER
 /*
  * Registers a generic IRQ handling function as the top-level IRQ handler in
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index db3d174c53d4..df17dbc54b02 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -86,6 +86,11 @@ config GENERIC_IRQ_IPI
 	depends on SMP
 	select IRQ_DOMAIN_HIERARCHY
 
+# Generic IRQ IPI Mux support
+config GENERIC_IRQ_IPI_MUX
+	bool
+	depends on SMP
+
 # Generic MSI interrupt support
 config GENERIC_MSI_IRQ
 	bool
diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
index b4f53717d143..f19d3080bf11 100644
--- a/kernel/irq/Makefile
+++ b/kernel/irq/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_GENERIC_IRQ_MIGRATION) += cpuhotplug.o
 obj-$(CONFIG_PM_SLEEP) += pm.o
 obj-$(CONFIG_GENERIC_MSI_IRQ) += msi.o
 obj-$(CONFIG_GENERIC_IRQ_IPI) += ipi.o
+obj-$(CONFIG_GENERIC_IRQ_IPI_MUX) += ipi-mux.o
 obj-$(CONFIG_SMP) += affinity.o
 obj-$(CONFIG_GENERIC_IRQ_DEBUGFS) += debugfs.o
 obj-$(CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR) += matrix.o
diff --git a/kernel/irq/ipi-mux.c b/kernel/irq/ipi-mux.c
new file mode 100644
index 000000000000..3a403c3a785d
--- /dev/null
+++ b/kernel/irq/ipi-mux.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Multiplex several virtual IPIs over a single HW IPI.
+ *
+ * Copyright The Asahi Linux Contributors
+ * Copyright (c) 2022 Ventana Micro Systems Inc.
+ */
+
+#define pr_fmt(fmt) "ipi-mux: " fmt
+#include <linux/cpu.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/jump_label.h>
+#include <linux/percpu.h>
+#include <linux/smp.h>
+
+struct ipi_mux_cpu {
+	atomic_t			enable;
+	atomic_t			bits;
+};
+
+static struct ipi_mux_cpu __percpu *ipi_mux_pcpu;
+static struct irq_domain *ipi_mux_domain;
+static void (*ipi_mux_send)(unsigned int cpu);
+
+static void ipi_mux_mask(struct irq_data *d)
+{
+	struct ipi_mux_cpu *icpu = this_cpu_ptr(ipi_mux_pcpu);
+
+	atomic_andnot(BIT(irqd_to_hwirq(d)), &icpu->enable);
+}
+
+static void ipi_mux_unmask(struct irq_data *d)
+{
+	struct ipi_mux_cpu *icpu = this_cpu_ptr(ipi_mux_pcpu);
+	u32 ibit = BIT(irqd_to_hwirq(d));
+
+	atomic_or(ibit, &icpu->enable);
+
+	/*
+	 * The atomic_or() above must complete before the atomic_read()
+	 * below to avoid racing ipi_mux_send_mask().
+	 */
+	smp_mb__after_atomic();
+
+	/* If a pending IPI was unmasked, raise a parent IPI immediately. */
+	if (atomic_read(&icpu->bits) & ibit)
+		ipi_mux_send(smp_processor_id());
+}
+
+static void ipi_mux_send_mask(struct irq_data *d, const struct cpumask *mask)
+{
+	struct ipi_mux_cpu *icpu = this_cpu_ptr(ipi_mux_pcpu);
+	u32 ibit = BIT(irqd_to_hwirq(d));
+	unsigned long pending;
+	int cpu;
+
+	for_each_cpu(cpu, mask) {
+		icpu = per_cpu_ptr(ipi_mux_pcpu, cpu);
+
+		/*
+		 * This sequence is the mirror of the one in ipi_mux_unmask();
+		 * see the comment there. Additionally, release semantics
+		 * ensure that the vIPI flag set is ordered after any shared
+		 * memory accesses that precede it. This therefore also pairs
+		 * with the atomic_fetch_andnot in ipi_mux_process().
+		 */
+		pending = atomic_fetch_or_release(ibit, &icpu->bits);
+
+		/*
+		 * The atomic_fetch_or_release() above must complete
+		 * before the atomic_read() below to avoid racing with
+		 * ipi_mux_unmask().
+		 */
+		smp_mb__after_atomic();
+
+		/*
+		 * The flag writes must complete before the physical IPI is
+		 * issued to another CPU. This is implied by the control
+		 * dependency on the result of atomic_read() below, which is
+		 * itself already ordered after the vIPI flag write.
+		 */
+		if (!(pending & ibit) && (atomic_read(&icpu->enable) & ibit))
+			ipi_mux_send(cpu);
+	}
+}
+
+static const struct irq_chip ipi_mux_chip = {
+	.name		= "IPI Mux",
+	.irq_mask	= ipi_mux_mask,
+	.irq_unmask	= ipi_mux_unmask,
+	.ipi_send_mask	= ipi_mux_send_mask,
+};
+
+static int ipi_mux_domain_alloc(struct irq_domain *d, unsigned int virq,
+				unsigned int nr_irqs, void *arg)
+{
+	int i;
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_set_percpu_devid(virq + i);
+		irq_domain_set_info(d, virq + i, i, &ipi_mux_chip, NULL,
+				    handle_percpu_devid_irq, NULL, NULL);
+	}
+
+	return 0;
+}
+
+static const struct irq_domain_ops ipi_mux_domain_ops = {
+	.alloc		= ipi_mux_domain_alloc,
+	.free		= irq_domain_free_irqs_top,
+};
+
+/**
+ * ipi_mux_process - Process multiplexed virtual IPIs
+ */
+void ipi_mux_process(void)
+{
+	struct ipi_mux_cpu *icpu = this_cpu_ptr(ipi_mux_pcpu);
+	irq_hw_number_t hwirq;
+	unsigned long ipis;
+	unsigned int en;
+
+	/*
+	 * Reading enable mask does not need to be ordered as long as
+	 * this function is called from interrupt handler because only
+	 * the CPU itself can change it's own enable mask.
+	 */
+	en = atomic_read(&icpu->enable);
+
+	/*
+	 * Clear the IPIs we are about to handle. This pairs with the
+	 * atomic_fetch_or_release() in ipi_mux_send_mask().
+	 */
+	ipis = atomic_fetch_andnot(en, &icpu->bits) & en;
+
+	for_each_set_bit(hwirq, &ipis, BITS_PER_TYPE(int))
+		generic_handle_domain_irq(ipi_mux_domain, hwirq);
+}
+
+/**
+ * ipi_mux_create - Create virtual IPIs multiplexed on top of a single
+ * parent IPI.
+ * @nr_ipi:		number of virtual IPIs to create. This should
+ *			be <= BITS_PER_TYPE(int)
+ * @mux_send:		callback to trigger parent IPI for a particular CPU
+ *
+ * Returns first virq of the newly created virtual IPIs upon success
+ * or <=0 upon failure
+ */
+int ipi_mux_create(unsigned int nr_ipi, void (*mux_send)(unsigned int cpu))
+{
+	struct fwnode_handle *fwnode;
+	struct irq_domain *domain;
+	int rc;
+
+	if (ipi_mux_domain)
+		return -EEXIST;
+
+	if (BITS_PER_TYPE(int) < nr_ipi || !mux_send)
+		return -EINVAL;
+
+	ipi_mux_pcpu = alloc_percpu(typeof(*ipi_mux_pcpu));
+	if (!ipi_mux_pcpu)
+		return -ENOMEM;
+
+	fwnode = irq_domain_alloc_named_fwnode("IPI-Mux");
+	if (!fwnode) {
+		pr_err("unable to create IPI Mux fwnode\n");
+		rc = -ENOMEM;
+		goto fail_free_cpu;
+	}
+
+	domain = irq_domain_create_linear(fwnode, nr_ipi,
+					  &ipi_mux_domain_ops, NULL);
+	if (!domain) {
+		pr_err("unable to add IPI Mux domain\n");
+		rc = -ENOMEM;
+		goto fail_free_fwnode;
+	}
+
+	domain->flags |= IRQ_DOMAIN_FLAG_IPI_SINGLE;
+	irq_domain_update_bus_token(domain, DOMAIN_BUS_IPI);
+
+	rc = __irq_domain_alloc_irqs(domain, -1, nr_ipi,
+				     NUMA_NO_NODE, NULL, false, NULL);
+	if (rc <= 0) {
+		pr_err("unable to alloc IRQs from IPI Mux domain\n");
+		goto fail_free_domain;
+	}
+
+	ipi_mux_domain = domain;
+	ipi_mux_send = mux_send;
+
+	return rc;
+
+fail_free_domain:
+	irq_domain_remove(domain);
+fail_free_fwnode:
+	irq_domain_free_fwnode(fwnode);
+fail_free_cpu:
+	free_percpu(ipi_mux_pcpu);
+	return rc;
+}
-- 
2.34.1

