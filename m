Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA69630E6D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 12:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiKSLcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 06:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbiKSLb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 06:31:56 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A6682BD0;
        Sat, 19 Nov 2022 03:31:54 -0800 (PST)
Received: (Authenticated sender: ash@heyquark.com)
        by mail.gandi.net (Postfix) with ESMTPSA id ACDC3FF80B;
        Sat, 19 Nov 2022 11:31:44 +0000 (UTC)
From:   Ash Logan <ash@heyquark.com>
To:     krzysztof.kozlowski+dt@linaro.org, paulus@samba.org,
        mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        robh+dt@kernel.org, benh@kernel.crashing.org,
        segher@kernel.crashing.org, pali@kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        j.ne@posteo.net, linkmauve@linkmauve.fr,
        rw-r-r-0644@protonmail.com, devicetree@vger.kernel.org,
        joel@jms.id.au
Subject: [PATCH v4 07/11] powerpc: wiiu: espresso interrupt controller support
Date:   Sat, 19 Nov 2022 22:30:37 +1100
Message-Id: <20221119113041.284419-8-ash@heyquark.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221119113041.284419-1-ash@heyquark.com>
References: <20220628133144.142185-1-ash@heyquark.com>
 <20221119113041.284419-1-ash@heyquark.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the "Espresso" interrupt controller in the Nintendo Wii
U.

Signed-off-by: Ash Logan <ash@heyquark.com>
Co-developed-by: Roberto Van Eeden <rw-r-r-0644@protonmail.com>
Signed-off-by: Roberto Van Eeden <rw-r-r-0644@protonmail.com>
---
 arch/powerpc/platforms/wiiu/Makefile       |   1 +
 arch/powerpc/platforms/wiiu/espresso-pic.c | 183 +++++++++++++++++++++
 arch/powerpc/platforms/wiiu/espresso-pic.h |  59 +++++++
 3 files changed, 243 insertions(+)
 create mode 100644 arch/powerpc/platforms/wiiu/espresso-pic.c
 create mode 100644 arch/powerpc/platforms/wiiu/espresso-pic.h

diff --git a/arch/powerpc/platforms/wiiu/Makefile b/arch/powerpc/platforms/wiiu/Makefile
index b1e0e1307f6e..aabf4b43e806 100644
--- a/arch/powerpc/platforms/wiiu/Makefile
+++ b/arch/powerpc/platforms/wiiu/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
+obj-$(CONFIG_WIIU) += espresso-pic.o
 obj-$(CONFIG_LATTEIPC_UDBG) += udbg_latteipc.o
diff --git a/arch/powerpc/platforms/wiiu/espresso-pic.c b/arch/powerpc/platforms/wiiu/espresso-pic.c
new file mode 100644
index 000000000000..1aa5d88002d5
--- /dev/null
+++ b/arch/powerpc/platforms/wiiu/espresso-pic.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Nintendo Wii U "Espresso" interrupt controller support
+ * Copyright (C) 2022 The linux-wiiu Team
+ *
+ * Based on flipper-pic.c
+ * Copyright (C) 2004-2009 The GameCube Linux Team
+ * Copyright (C) 2007-2009 Albert Herranz
+ */
+
+#define DRV_MODULE_NAME "espresso-pic"
+#define pr_fmt(fmt) DRV_MODULE_NAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/io.h>
+#include "espresso-pic.h"
+
+static DEFINE_PER_CPU(struct espresso_pic *, espresso_pic_cpu);
+
+/*
+ * IRQ chip operations
+ */
+
+static void espresso_pic_mask_and_ack(struct irq_data *d)
+{
+	struct espresso_pic *pic = *this_cpu_ptr(&espresso_pic_cpu);
+	u32 mask = 1 << irqd_to_hwirq(d);
+
+	out_be32(&pic->icr, mask);
+	clrbits32(&pic->imr, mask);
+}
+
+static void espresso_pic_ack(struct irq_data *d)
+{
+	struct espresso_pic *pic = *this_cpu_ptr(&espresso_pic_cpu);
+	u32 mask = 1 << irqd_to_hwirq(d);
+
+	out_be32(&pic->icr, mask);
+}
+
+static void espresso_pic_mask(struct irq_data *d)
+{
+	struct espresso_pic *pic = *this_cpu_ptr(&espresso_pic_cpu);
+	u32 mask = 1 << irqd_to_hwirq(d);
+
+	clrbits32(&pic->imr, mask);
+}
+
+static void espresso_pic_unmask(struct irq_data *d)
+{
+	struct espresso_pic *pic = *this_cpu_ptr(&espresso_pic_cpu);
+	u32 mask = 1 << irqd_to_hwirq(d);
+
+	setbits32(&pic->imr, mask);
+}
+
+static struct irq_chip espresso_pic_chip = {
+	.name = "espresso-pic",
+	.irq_ack = espresso_pic_ack,
+	.irq_mask_ack = espresso_pic_mask_and_ack,
+	.irq_mask = espresso_pic_mask,
+	.irq_unmask = espresso_pic_unmask,
+};
+
+/*
+ * Domain Ops
+ */
+
+static int espresso_pic_match(struct irq_domain *h, struct device_node *node,
+			      enum irq_domain_bus_token bus_token)
+{
+	if (h->fwnode == &node->fwnode) {
+		pr_debug("espresso-pic: %s IRQ matches with this driver\n",
+			 node->name);
+		return 1;
+	}
+	return 0;
+}
+
+static int espresso_pic_alloc(struct irq_domain *h, unsigned int virq,
+			      unsigned int nr_irqs, void *arg)
+{
+	unsigned int i;
+	struct irq_fwspec *fwspec = arg;
+	irq_hw_number_t hwirq = fwspec->param[0];
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_set_chip_data(virq + i, h->host_data);
+		irq_set_status_flags(virq + i, IRQ_LEVEL);
+		irq_set_chip_and_handler(virq + i, &espresso_pic_chip,
+					 handle_level_irq);
+		irq_domain_set_hwirq_and_chip(h, virq + i, hwirq + i,
+					      &espresso_pic_chip, h->host_data);
+	}
+	return 0;
+}
+
+static void espresso_pic_free(struct irq_domain *h, unsigned int virq,
+			      unsigned int nr_irqs)
+{
+	pr_debug("free\n");
+}
+
+const struct irq_domain_ops espresso_pic_ops = {
+	.match = espresso_pic_match,
+	.alloc = espresso_pic_alloc,
+	.free = espresso_pic_free,
+};
+
+/* Store irq domain for espresso_pic_get_irq (the function gets no arguments) */
+static struct irq_domain *espresso_irq_domain;
+
+unsigned int espresso_pic_get_irq(void)
+{
+	struct espresso_pic *pic = *this_cpu_ptr(&espresso_pic_cpu);
+	u32 irq_status, irq;
+
+	irq_status = in_be32(&pic->icr) & in_be32(&pic->imr);
+
+	if (irq_status == 0)
+		return 0; /* No IRQs pending */
+
+	/* Return first IRQ */
+	irq = __ffs(irq_status);
+	return irq_linear_revmap(espresso_irq_domain, irq);
+}
+
+void __init espresso_pic_init(void)
+{
+	struct device_node *np =
+		of_find_compatible_node(NULL, NULL, "nintendo,espresso-pic");
+	struct irq_domain *host;
+	struct resource res;
+	void __iomem *regbase;
+	unsigned int cpu;
+
+	if (!np) {
+		pr_err("could not find device node\n");
+		return;
+	}
+
+	if (of_address_to_resource(np, 0, &res) != 0) {
+		pr_err("could not find resource address\n");
+		goto out;
+	}
+
+	regbase = ioremap(res.start, resource_size(&res));
+	if (IS_ERR(regbase)) {
+		pr_err("could not map controller\n");
+		goto out;
+	}
+
+	for_each_present_cpu(cpu) {
+		struct espresso_pic **pic = per_cpu_ptr(&espresso_pic_cpu, cpu);
+
+		/* Compute pic address */
+		*pic = regbase + (sizeof(struct espresso_pic) * cpu);
+
+		/* Mask and Ack all IRQs */
+		out_be32(&(*pic)->imr, 0);
+		out_be32(&(*pic)->icr, 0xFFFFFFFF);
+	}
+
+	host = irq_domain_add_linear(np, ESPRESSO_NR_IRQS, &espresso_pic_ops,
+				     NULL);
+	if (!host) {
+		pr_err("failed to allocate irq_domain\n");
+		goto out;
+	}
+
+	/* Save irq domain for espresso_pic_get_irq */
+	espresso_irq_domain = host;
+
+	irq_set_default_host(host);
+
+out:
+	of_node_put(np);
+}
diff --git a/arch/powerpc/platforms/wiiu/espresso-pic.h b/arch/powerpc/platforms/wiiu/espresso-pic.h
new file mode 100644
index 000000000000..b5b4e44ad60e
--- /dev/null
+++ b/arch/powerpc/platforms/wiiu/espresso-pic.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Nintendo Wii U "Espresso" interrupt controller support
+ * Copyright (C) 2022 The linux-wiiu Team
+ */
+
+#ifndef __ESPRESSO_PIC_H
+#define __ESPRESSO_PIC_H
+
+/*
+ * Instead of using COS custom IRQ remapping, the normal IRQ mapping is used:
+ *
+ * IRQ  Description
+ * -------------------------------------------
+ * 0    Error
+ * 1    Unused
+ * 2    Unused
+ * 3    Audio Interface (TV)
+ * 4    Unused
+ * 5    DSP Accelerator
+ * 6    DSP
+ * 7    DSP DMA
+ * 8    Unused
+ * 9    Unused
+ * 10   GPIPPC (?)
+ * 11   Unused
+ * 12   Audio Interface (Gamepad)
+ * 13   I2C
+ * 14   Unused
+ * 15   Unused
+ * 16   Unused
+ * 17   Unused
+ * 18   Unused
+ * 19   Unused
+ * 20   Unused
+ * 21   Unused
+ * 22   Unused
+ * 23   GX2
+ * 24   Latte IRQ Controller
+ * 25   Unused
+ * 26   IPC (CPU2)
+ * 27   Unused
+ * 28   IPC (CPU1)
+ * 29   Unused
+ * 30   IPC (CPU0)
+ * 31   Unused
+ */
+
+struct espresso_pic {
+	__be32 icr; /* Triggered IRQs */
+	__be32 imr; /* Allowed IRQs */
+} __packed;
+
+#define ESPRESSO_NR_IRQS 32
+
+unsigned int espresso_pic_get_irq(void);
+void espresso_pic_init(void);
+
+#endif
-- 
2.38.1

