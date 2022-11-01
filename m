Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA84B614CA6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 15:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiKAOe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 10:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiKAOev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 10:34:51 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6FE1BE8B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 07:34:47 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id v17so10708821plo.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 07:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCFApjowkHqcmgqAiC1MbBrZXWJ5vIK43MVB0ul5n1U=;
        b=SiJYLc+UN1XMhds7AA/RbVSlAjvO+dKuYqc3qX3HxVQs8aFnuLF+yjY/hhV+9kMVUe
         +ttgjGhKUAeytbricL37EtQmWLW8xAvQ7RDYWlm907ZDf7bEKos/fa/U+cZAK3OTSyNA
         oITm67T/yN3bg8aChcyd+QWgXXR1Mym6IBQVQhQPnx3A8gNwpZRjj3ux8BH/FLSwb9q8
         VTaWYODKMXK189bt+jgyZ6en3YluiWT1pqpLFFLlzb+TZ24Gr4IU1kAeQSQZVAdx0ylO
         Fmg2yAnIP7MkZEHxaZtTuFubO2GWfRLorajb4lmAstlk67ijnixT3P8dC8uIDaxI6aWQ
         0siA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCFApjowkHqcmgqAiC1MbBrZXWJ5vIK43MVB0ul5n1U=;
        b=bzNZzrHBRNmCACjpZ6rvniWBwLfSRA8gOj1UDlrmmO68DwJYEC+hAl785KUVkZAX4o
         44AbK10/wqJ9oRi0tgNU+OX5506NN1EohiSg4NAtMCWnN2TBjTbsMeOGcDononNcPE6I
         N5HRvy9fD7VGaQrbJzAzo6qJv2JGLlj74tBuqNwQEATzcODJbzB2GrqTN6jmje+NKnSQ
         kRQP8DFiYIDLQHuXk9zzAGlV3JDekfsrJ7sYS4XwZ3PhalBj4xZRuIWAvwFzb1HJeHxj
         nPurA/HtvuWkQr6a1E1rXZ+S86iioHGnHY/Nwes8O+h4X2ka9qUoitZQ+v9GkdN8vuzR
         Qm8g==
X-Gm-Message-State: ACrzQf3MjyLNko/f/z9xxn2KKu8/4TFwo9OfRTzYh1fJ+oZBv2X2qkPo
        Hb56Dc4gCmKZO4+5zSqBnNAfhw==
X-Google-Smtp-Source: AMsMyM6MaeIlXtBSDMpjd3qwsmA45CwwPHWiEsP7U6CRrxlGB/fsQN/EYfUiFqaOJQDvRjkZ89KnPA==
X-Received: by 2002:a17:90a:8808:b0:213:c7d0:2217 with SMTP id s8-20020a17090a880800b00213c7d02217mr15354653pjn.231.1667313285202;
        Tue, 01 Nov 2022 07:34:45 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.80.52])
        by smtp.gmail.com with ESMTPSA id o20-20020a170903009400b0018685aaf41dsm6449055pld.18.2022.11.01.07.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 07:34:44 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v10 3/7] genirq: Add mechanism to multiplex a single HW IPI
Date:   Tue,  1 Nov 2022 20:03:56 +0530
Message-Id: <20221101143400.690000-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101143400.690000-1-apatel@ventanamicro.com>
References: <20221101143400.690000-1-apatel@ventanamicro.com>
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

To support multiple IPIs on RISC-V, we add a generic IPI multiplexing
mechanism which help us create multiple virtual IPIs using a single
HW IPI. This generic IPI multiplexing is inspired from the Apple AIC
irqchip driver and it is shared by various RISC-V irqchip drivers.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 include/linux/irq.h  |  18 +++
 kernel/irq/Kconfig   |   5 +
 kernel/irq/Makefile  |   1 +
 kernel/irq/ipi-mux.c | 260 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 284 insertions(+)
 create mode 100644 kernel/irq/ipi-mux.c

diff --git a/include/linux/irq.h b/include/linux/irq.h
index c3eb89606c2b..5ab702cb0a5b 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1266,6 +1266,24 @@ int __ipi_send_mask(struct irq_desc *desc, const struct cpumask *dest);
 int ipi_send_single(unsigned int virq, unsigned int cpu);
 int ipi_send_mask(unsigned int virq, const struct cpumask *dest);
 
+/**
+ * struct ipi_mux_ops - IPI multiplex operations
+ *
+ * @ipi_mux_pre_handle:	Optional function called before handling parent IPI
+ * @ipi_mux_post_handle:Optional function called after handling parent IPI
+ * @ipi_mux_send:	Trigger parent IPI on target CPUs
+ */
+struct ipi_mux_ops {
+	void (*ipi_mux_pre_handle)(unsigned int parent_virq, void *data);
+	void (*ipi_mux_post_handle)(unsigned int parent_virq, void *data);
+	void (*ipi_mux_send)(unsigned int parent_virq, void *data,
+			     const struct cpumask *mask);
+};
+
+void ipi_mux_process(void);
+int ipi_mux_create(unsigned int parent_virq, unsigned int nr_ipi,
+		   const struct ipi_mux_ops *ops, void *data);
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
index 000000000000..5ea7ab61e5cc
--- /dev/null
+++ b/kernel/irq/ipi-mux.c
@@ -0,0 +1,260 @@
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
+	struct cpumask			send_mask;
+};
+
+struct ipi_mux_control {
+	void				*data;
+	unsigned int			nr;
+	unsigned int			parent_virq;
+	struct irq_domain		*domain;
+	const struct ipi_mux_ops	*ops;
+	struct ipi_mux_cpu __percpu	*cpu;
+};
+
+static struct ipi_mux_control *imux;
+static DEFINE_STATIC_KEY_FALSE(imux_pre_handle);
+static DEFINE_STATIC_KEY_FALSE(imux_post_handle);
+
+static void ipi_mux_mask(struct irq_data *d)
+{
+	struct ipi_mux_cpu *icpu = this_cpu_ptr(imux->cpu);
+
+	atomic_andnot(BIT(irqd_to_hwirq(d)), &icpu->enable);
+}
+
+static void ipi_mux_unmask(struct irq_data *d)
+{
+	u32 ibit = BIT(irqd_to_hwirq(d));
+	struct ipi_mux_cpu *icpu = this_cpu_ptr(imux->cpu);
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
+		imux->ops->ipi_mux_send(imux->parent_virq, imux->data,
+					cpumask_of(smp_processor_id()));
+}
+
+static void ipi_mux_send_mask(struct irq_data *d, const struct cpumask *mask)
+{
+	u32 ibit = BIT(irqd_to_hwirq(d));
+	struct ipi_mux_cpu *icpu = this_cpu_ptr(imux->cpu);
+	struct cpumask *send_mask = &icpu->send_mask;
+	unsigned long pending;
+	int cpu;
+
+	cpumask_clear(send_mask);
+
+	for_each_cpu(cpu, mask) {
+		icpu = per_cpu_ptr(imux->cpu, cpu);
+		pending = atomic_fetch_or_release(ibit, &icpu->bits);
+
+		/*
+		 * The atomic_fetch_or_release() above must complete before
+		 * the atomic_read() below to avoid racing ipi_mux_unmask().
+		 */
+		smp_mb__after_atomic();
+
+		if (!(pending & ibit) &&
+		    (atomic_read(&icpu->enable) & ibit))
+			cpumask_set_cpu(cpu, send_mask);
+	}
+
+	/* Trigger the parent IPI */
+	imux->ops->ipi_mux_send(imux->parent_virq, imux->data, send_mask);
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
+		irq_domain_set_info(d, virq + i, i,
+				    &ipi_mux_chip, d->host_data,
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
+	struct ipi_mux_cpu *icpu = this_cpu_ptr(imux->cpu);
+	irq_hw_number_t hwirq;
+	unsigned long ipis;
+	int en;
+
+	if (static_branch_unlikely(&imux_pre_handle))
+		imux->ops->ipi_mux_pre_handle(imux->parent_virq, imux->data);
+
+	/*
+	 * Reading enable mask does not need to be ordered as long as
+	 * this function called from interrupt handler because only
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
+	for_each_set_bit(hwirq, &ipis, imux->nr)
+		generic_handle_domain_irq(imux->domain, hwirq);
+
+	if (static_branch_unlikely(&imux_post_handle))
+		imux->ops->ipi_mux_post_handle(imux->parent_virq, imux->data);
+}
+
+static void ipi_mux_handler(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+
+	chained_irq_enter(chip, desc);
+	ipi_mux_process();
+	chained_irq_exit(chip, desc);
+}
+
+/**
+ * ipi_mux_create - Create virtual IPIs multiplexed on top of a single
+ * parent IPI.
+ * @parent_virq:	virq of the parent per-CPU IRQ
+ * @nr_ipi:		number of virtual IPIs to create. This should
+ *			be <= BITS_PER_TYPE(int)
+ * @ops:		multiplexing operations for the parent IPI
+ * @data:		opaque data used by the multiplexing operations
+ *
+ * If the parent IPI > 0 then ipi_mux_process() will be automatically
+ * called via chained handler.
+ *
+ * If the parent IPI <= 0 then it is responsibility of irqchip drivers
+ * to explicitly call ipi_mux_process() for processing muxed IPIs.
+ *
+ * Returns first virq of the newly created virtual IPIs upon success
+ * or <=0 upon failure
+ */
+int ipi_mux_create(unsigned int parent_virq, unsigned int nr_ipi,
+		   const struct ipi_mux_ops *ops, void *data)
+{
+	struct fwnode_handle *fwnode;
+	struct irq_domain *domain;
+	int rc;
+
+	if (imux)
+		return -EEXIST;
+
+	if (BITS_PER_TYPE(int) < nr_ipi || !ops || !ops->ipi_mux_send)
+		return -EINVAL;
+
+	if (parent_virq &&
+	    !irqd_is_per_cpu(irq_desc_get_irq_data(irq_to_desc(parent_virq))))
+		return -EINVAL;
+
+	imux = kzalloc(sizeof(*imux), GFP_KERNEL);
+	if (!imux)
+		return -ENOMEM;
+
+	imux->cpu = alloc_percpu(typeof(*imux->cpu));
+	if (!imux->cpu) {
+		rc = -ENOMEM;
+		goto fail_free_mux;
+	}
+
+	fwnode = irq_domain_alloc_named_fwnode("IPI-Mux");
+	if (!fwnode) {
+		pr_err("unable to create IPI Mux fwnode\n");
+		rc = -ENOMEM;
+		goto fail_free_cpu;
+	}
+
+	domain = irq_domain_create_simple(fwnode, nr_ipi, 0,
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
+	imux->domain = domain;
+	imux->data = data;
+	imux->nr = nr_ipi;
+	imux->parent_virq = parent_virq;
+	imux->ops = ops;
+
+	if (imux->ops->ipi_mux_pre_handle)
+		static_branch_enable(&imux_pre_handle);
+
+	if (imux->ops->ipi_mux_post_handle)
+		static_branch_enable(&imux_post_handle);
+
+	if (parent_virq > 0)
+		irq_set_chained_handler(parent_virq, ipi_mux_handler);
+
+	return rc;
+
+fail_free_domain:
+	irq_domain_remove(domain);
+fail_free_fwnode:
+	irq_domain_free_fwnode(fwnode);
+fail_free_cpu:
+	free_percpu(imux->cpu);
+fail_free_mux:
+	kfree(imux);
+	imux = NULL;
+	return rc;
+}
-- 
2.34.1

