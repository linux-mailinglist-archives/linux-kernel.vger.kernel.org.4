Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E727860629D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiJTOO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJTOOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:14:19 -0400
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A9D1867B9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 07:14:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id 2575F9C0794;
        Thu, 20 Oct 2022 10:14:02 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
        by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Gk38oE8C0Tq3; Thu, 20 Oct 2022 10:14:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id A18709C073B;
        Thu, 20 Oct 2022 10:14:00 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com A18709C073B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
        t=1666275240; bh=OGmET8HWrWBU22FTwJ+6Tu9g87EbfiQCcesWxsajcmo=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=TwpiT532uiLMr9/6NKQfnGMnrXCxvNUbXWELkln6gQugpFZ/BxCMvtG47EUSl5X3y
         isLX0dRKXSjuwFLXgIRc/rFB7HVci24fYeNFDT5YMFtv3P05wGhknctFj1QItXdOmD
         PXLP5Q5sRu5C1YptLN5EZppzEaBK/uzrKX87ydeBtYvk3tksm+P1OoanRIZ7BUopiU
         oK/slJNC7aIabWmmkuF4P3DU9QGVebcmWvFvCB+91cK+DMwIiexEBbkk+SXIuYc/Gl
         tjQ4QwVSPCcgDyhaqOe3LAA8CrGgLtLUYp+3IaSwl97chmdPoBiAxMWEQuXN8Oqq2O
         5c6waSFeGVj0Q==
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
        by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1-n0iCiUntzG; Thu, 20 Oct 2022 10:14:00 -0400 (EDT)
Received: from localhost.localdomain (unknown [192.168.51.254])
        by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 758379C0735;
        Thu, 20 Oct 2022 10:14:00 -0400 (EDT)
From:   Firas Ashkar <firas.ashkar@savoirfairelinux.com>
To:     alex@digriz.org.uk, tglx@linutronix.de, maz@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Firas Ashkar <firas.ashkar@savoirfairelinux.com>
Subject: [PATCH v2] irqchip: add TS7800v1 fpga based controller driver
Date:   Thu, 20 Oct 2022 10:13:51 -0400
Message-Id: <20221020141351.14829-1-firas.ashkar@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. add TS-7800v1 fpga based irq controller driver, and
2. add related memory and irq resources

By default only mapped FPGA interrupts will be chained/multiplexed, these
chained interrupts will then be available to other device drivers to
request via the corresponding Linux IRQs.

$ cat /proc/cpuinfo
processor	: 0
model name	: Feroceon rev 0 (v5l)
BogoMIPS	: 333.33
Features	: swp half thumb fastmult edsp
CPU implementer	: 0x41
CPU architecture: 5TEJ
CPU variant	: 0x0
CPU part	: 0x926
CPU revision	: 0

Hardware	: Technologic Systems TS-78xx SBC
Revision	: 0000
Serial		: 0000000000000000
$

$ cat /proc/interrupts
           CPU0
  1:        902  orion_irq     Level     orion_tick
  4:        795  orion_irq     Level     ttyS0
 13:          0  orion_irq     Level     ehci_hcd:usb2
 18:          0  orion_irq     Level     ehci_hcd:usb1
 22:         69  orion_irq     Level     eth0
 23:        171  orion_irq     Level     orion-mdio
 29:          0  orion_irq     Level     mv_crypto
 31:          2  orion_irq     Level     mv_xor.0
 65:          1  ts7800-irqc   0 Edge      ts-dmac-cpupci
Err:          0
$

$ uname -a
Linux ts-7800 6.1.0-rc1 #2 PREEMPT Mon Oct 17 11:19:12 EDT 2022 armv5tel
 GNU/Linux
$

Signed-off-by: Firas Ashkar <firas.ashkar@savoirfairelinux.com>
---

Notes:
    Changes in V2
    * limit the commit message
    * format comments in source code
    * use raw spin locks to protect mask/unmask ops
    * use 'handle_edge_irq' and 'irq_ack' logic
    * remove 'irq_domain_xlate_onecell'
    * remove unnecessary status flags
    * use 'builtin_platform_driver' helper routine

:100644 100644 2f4fe3ca5c1a ed8378893208 M	arch/arm/mach-orion5x/ts78xx-f=
pga.h
:100644 100644 af810e7ccd79 d319a68b7160 M	arch/arm/mach-orion5x/ts78xx-s=
etup.c
:100644 100644 7ef9f5e696d3 d184fb435c5d M	drivers/irqchip/Kconfig
:100644 100644 87b49a10962c b022eece2042 M	drivers/irqchip/Makefile
:000000 100644 000000000000 e975607fa4d5 A	drivers/irqchip/irq-ts7800.c
 arch/arm/mach-orion5x/ts78xx-fpga.h  |   1 +
 arch/arm/mach-orion5x/ts78xx-setup.c |  55 +++++
 drivers/irqchip/Kconfig              |  12 +
 drivers/irqchip/Makefile             |   1 +
 drivers/irqchip/irq-ts7800.c         | 347 +++++++++++++++++++++++++++
 5 files changed, 416 insertions(+)

diff --git a/arch/arm/mach-orion5x/ts78xx-fpga.h b/arch/arm/mach-orion5x/=
ts78xx-fpga.h
index 2f4fe3ca5c1a..ed8378893208 100644
--- a/arch/arm/mach-orion5x/ts78xx-fpga.h
+++ b/arch/arm/mach-orion5x/ts78xx-fpga.h
@@ -32,6 +32,7 @@ struct fpga_devices {
 	struct fpga_device	ts_rtc;
 	struct fpga_device	ts_nand;
 	struct fpga_device	ts_rng;
+	struct fpga_device	ts_irqc;
 };
=20
 struct ts78xx_fpga_data {
diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x=
/ts78xx-setup.c
index af810e7ccd79..d319a68b7160 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -322,6 +322,49 @@ static void ts78xx_ts_rng_unload(void)
 	platform_device_del(&ts78xx_ts_rng_device);
 }
=20
+/***********************************************************************=
******
+ * fpga irq controller
+ ***********************************************************************=
*****/
+#define TS_IRQC_CTRL (TS78XX_FPGA_REGS_PHYS_BASE + 0x200)
+#define TS_BRIDGE_CTRL (ORION5X_REGS_PHYS_BASE + 0x20400)
+#define TS_IRQC_PARENT 0x2
+static struct resource ts_irqc_resources[] =3D {
+	DEFINE_RES_MEM_NAMED(TS_IRQC_CTRL, 0x100, "ts_irqc"),
+	DEFINE_RES_MEM_NAMED(TS_BRIDGE_CTRL, 0x10, "ts_bridge"),
+	DEFINE_RES_IRQ_NAMED(TS_IRQC_PARENT, "ts_irqc_parent"),
+};
+
+static struct platform_device ts_irqc_device =3D {
+	.name =3D "ts7800-irqc",
+	.id =3D -1,
+	.resource =3D ts_irqc_resources,
+	.num_resources =3D ARRAY_SIZE(ts_irqc_resources),
+};
+
+static int ts_irqc_load(void)
+{
+	int rc;
+
+	if (ts78xx_fpga.supports.ts_irqc.init =3D=3D 0) {
+		rc =3D platform_device_register(&ts_irqc_device);
+		if (!rc)
+			ts78xx_fpga.supports.ts_irqc.init =3D 1;
+	} else {
+		rc =3D platform_device_add(&ts_irqc_device);
+	}
+
+	if (rc)
+		pr_info("FPGA based IRQ controller could not be registered: %d\n",
+			rc);
+
+	return rc;
+}
+
+static void ts_irqc_unload(void)
+{
+	platform_device_del(&ts_irqc_device);
+}
+
 /***********************************************************************=
******
  * FPGA 'hotplug' support code
  ***********************************************************************=
*****/
@@ -330,6 +373,7 @@ static void ts78xx_fpga_devices_zero_init(void)
 	ts78xx_fpga.supports.ts_rtc.init =3D 0;
 	ts78xx_fpga.supports.ts_nand.init =3D 0;
 	ts78xx_fpga.supports.ts_rng.init =3D 0;
+	ts78xx_fpga.supports.ts_irqc.init =3D 0;
 }
=20
 static void ts78xx_fpga_supports(void)
@@ -348,6 +392,7 @@ static void ts78xx_fpga_supports(void)
 		ts78xx_fpga.supports.ts_rtc.present =3D 1;
 		ts78xx_fpga.supports.ts_nand.present =3D 1;
 		ts78xx_fpga.supports.ts_rng.present =3D 1;
+		ts78xx_fpga.supports.ts_irqc.present =3D 1;
 		break;
 	default:
 		/* enable devices if magic matches */
@@ -358,11 +403,13 @@ static void ts78xx_fpga_supports(void)
 			ts78xx_fpga.supports.ts_rtc.present =3D 1;
 			ts78xx_fpga.supports.ts_nand.present =3D 1;
 			ts78xx_fpga.supports.ts_rng.present =3D 1;
+			ts78xx_fpga.supports.ts_irqc.present =3D 1;
 			break;
 		default:
 			ts78xx_fpga.supports.ts_rtc.present =3D 0;
 			ts78xx_fpga.supports.ts_nand.present =3D 0;
 			ts78xx_fpga.supports.ts_rng.present =3D 0;
+			ts78xx_fpga.supports.ts_irqc.present =3D 0;
 		}
 	}
 }
@@ -371,6 +418,12 @@ static int ts78xx_fpga_load_devices(void)
 {
 	int tmp, ret =3D 0;
=20
+	if (ts78xx_fpga.supports.ts_irqc.present =3D=3D 1) {
+		tmp =3D ts_irqc_load();
+		if (tmp)
+			ts78xx_fpga.supports.ts_irqc.present =3D 0;
+		ret |=3D tmp;
+	}
 	if (ts78xx_fpga.supports.ts_rtc.present =3D=3D 1) {
 		tmp =3D ts78xx_ts_rtc_load();
 		if (tmp)
@@ -402,6 +455,8 @@ static int ts78xx_fpga_unload_devices(void)
 		ts78xx_ts_nand_unload();
 	if (ts78xx_fpga.supports.ts_rng.present =3D=3D 1)
 		ts78xx_ts_rng_unload();
+	if (ts78xx_fpga.supports.ts_irqc.present =3D=3D 1)
+		ts_irqc_unload();
=20
 	return 0;
 }
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 7ef9f5e696d3..d184fb435c5d 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -290,6 +290,18 @@ config TS4800_IRQ
 	help
 	  Support for the TS-4800 FPGA IRQ controller
=20
+config TS7800_IRQ
+	tristate "TS-7800 IRQ controller"
+	select IRQ_DOMAIN
+	depends on HAS_IOMEM
+	depends on MACH_TS78XX
+	help
+	  Support for TS-7800 FPGA based IRQ controller.
+	  This IRQ controller acts as a multiplexer chaining mapped
+	  FPGA interrupts to a single system bridge interrupt.
+
+	  If you have an FPGA IP corresponding to this driver, say Y or M here.
+
 config VERSATILE_FPGA_IRQ
 	bool
 	select IRQ_DOMAIN
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 87b49a10962c..b022eece2042 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_ARCH_VT8500)		+=3D irq-vt8500.o
 obj-$(CONFIG_ST_IRQCHIP)		+=3D irq-st.o
 obj-$(CONFIG_TB10X_IRQC)		+=3D irq-tb10x.o
 obj-$(CONFIG_TS4800_IRQ)		+=3D irq-ts4800.o
+obj-$(CONFIG_TS7800_IRQ)		+=3D irq-ts7800.o
 obj-$(CONFIG_XTENSA)			+=3D irq-xtensa-pic.o
 obj-$(CONFIG_XTENSA_MX)			+=3D irq-xtensa-mx.o
 obj-$(CONFIG_XILINX_INTC)		+=3D irq-xilinx-intc.o
diff --git a/drivers/irqchip/irq-ts7800.c b/drivers/irqchip/irq-ts7800.c
new file mode 100644
index 000000000000..e975607fa4d5
--- /dev/null
+++ b/drivers/irqchip/irq-ts7800.c
@@ -0,0 +1,347 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * FPGA based IRQ contorller driver for TS-7800v1
+ *
+ * Copyright (C) 2022 Savoir-faire Linux Inc.
+ *
+ */
+
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+
+#define DRIVER_NAME "ts7800-irqc"
+
+#define IRQ_MASK_REG 0x4
+#define IRQ_STATUS_REG 0x8
+#define TS7800_IRQ_NUM 0x20
+
+/*
+ * FPGA IRQ Controller, list of all mappable/chainable interrupts
+ *
+ * IRQ  Description
+ * ---  -----------
+ * 0x0  dma_cpu_pci_dack_o
+ * 0x1  dma_fpga_dack_o
+ * 0x2  SD Busy#
+ * 0x3  isa_irq3
+ * 0x4  isa_irq4
+ * 0x5  isa_irq5
+ * 0x6  isa_irq6
+ * 0x7  isa_irq7
+ * 0x8  Reserved
+ * 0x9  isa_irq9
+ * 0xa  isa_irq10
+ * 0xb  isa_irq11
+ * 0xc  isa_irq12
+ * 0xd  isa_irq14
+ * 0xe  isa_irq15
+ * 0x10:0x19  tsuart_irqs
+ *
+ * To map or enable a specific FPGA interrupt, add its corresponding num=
ber to
+ * 'enabled_mappings'.
+ * Example:
+ *  1. For 'dma_cpu_pci_dack_o' (FPGA based DMA controller), add 0x0 to
+ *     'enabled_mappings'
+ *  2. For 'tsuart_irqs' (FPGA based UARTs), add their FPGA interrupt ra=
nge of
+ *     0x10-0x19 to 'enabled_mappings'
+ *
+ * By default only mapped/enabled interrupts will be chained/multiplexed=
,
+ * these chained interrupts will then be available to other device drive=
rs to
+ * request via the corresponding Linux IRQs.
+ *
+ * Each mapped FPGA interrupt will have a corresponding Linux IRQ, this =
new IRQ
+ * will be appended to the system's current list of Linux IRQs, on TS78x=
x, the
+ * first mapped FPGA interrupt will have a corresponding new Linux IRQ s=
tarting
+ * at 65. The next mapped FPGA interrupt will have a Linux IRQ of 66 and=
 so
+ * forth.
+ *
+ * Example-1:
+ *  In order for a device driver, say the FPGA based DMA controller driv=
er
+ *  'TS-DMAC', to use either of the corresponding FPGA interrupts
+ *  'dma_cpu_pci_dack_o' and 'dma_fpga_dack_o', the 'TS-DMAC' driver has=
 to:
+ *
+ *  1. add FPGA interrupt numbers 0x0 and 0x1 to 'enabled_mappings', in =
this
+ *     file, and
+ *  2. request the corresponding Linux IRQ numbers 65 and 66 respectivel=
y in its
+ *     implementation.
+ *
+ * Eample-2:
+ *  In order for another device driver, say the FPGA based 'TSUART' driv=
er, to
+ *  use the related FPGA interrupts, the 'TSUART' driver has to:
+ *
+ *  1. append FPGA interrupt numbers 0x10, 0x11, 0x12, 0x13, 0x14, 0x15,=
 0x16,
+ *     0x17, 0x18, 0x19 to 'enabled_mappings', in this file, and
+ *  2. request the corresponding Linux IRQ numbers, these IRQs could sta=
rt from
+ *     65 till 74, if no previous FPGA interrupts where mapped. However,=
 if
+ *     other FPGA interrupts, say those of 'TS-DMAC' in Example-1 were a=
lso
+ *     mapped/enabled, then the correct corresponding Linux IRQs would s=
tart
+ *     from 67 till 76.
+ */
+
+static irq_hw_number_t enabled_mappings[] =3D { 0x0, 0x1 };
+
+struct ts7800_irq_data {
+	int mpp7_virq;
+	raw_spinlock_t lock;
+	void __iomem *base;
+	void __iomem *bridge;
+	struct irq_domain *domain;
+	struct irq_chip irq_chip;
+};
+
+static void ts7800_irq_mask(struct irq_data *d)
+{
+	struct ts7800_irq_data *data =3D irq_data_get_irq_chip_data(d);
+	u32 fpga_mask_reg =3D readl(data->base + IRQ_MASK_REG);
+	u32 mask_bits =3D 1 << d->hwirq;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&data->lock, flags);
+	writel(fpga_mask_reg & ~mask_bits, data->base + IRQ_MASK_REG);
+	writel(fpga_mask_reg & ~mask_bits, data->bridge + IRQ_MASK_REG);
+	raw_spin_unlock_irqrestore(&data->lock, flags);
+}
+
+static void ts7800_irq_unmask(struct irq_data *d)
+{
+	struct ts7800_irq_data *data =3D irq_data_get_irq_chip_data(d);
+	u32 fpga_mask_reg =3D readl(data->base + IRQ_MASK_REG);
+	u32 mask_bits =3D 1 << d->hwirq;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&data->lock, flags);
+	writel(fpga_mask_reg | mask_bits, data->base + IRQ_MASK_REG);
+	writel(fpga_mask_reg | mask_bits, data->bridge + IRQ_MASK_REG);
+	raw_spin_unlock_irqrestore(&data->lock, flags);
+}
+
+static void ts7800_irq_ack(struct irq_data *d)
+{
+	struct ts7800_irq_data *data =3D irq_data_get_irq_chip_data(d);
+	u32 status =3D readl(data->bridge);
+	u32 mask_bits =3D 1 << d->hwirq;
+	unsigned int bit =3D __ffs(mask_bits);
+	unsigned long flags;
+
+	status &=3D ~(1 << bit);
+
+	raw_spin_lock_irqsave(&data->lock, flags);
+	writel(status, data->bridge);
+	raw_spin_unlock_irqrestore(&data->lock, flags);
+}
+
+static int ts7800_irqdomain_map(struct irq_domain *d, unsigned int irq,
+				irq_hw_number_t hwirq)
+{
+	struct ts7800_irq_data *data =3D d->host_data;
+
+	irq_set_chip_and_handler(irq, &data->irq_chip, handle_edge_irq);
+	irq_clear_status_flags(irq, IRQ_LEVEL);
+	irq_set_chip_data(irq, data);
+	irq_set_noprobe(irq);
+
+	return 0;
+}
+
+static void ts7800_irqdomain_unmap(struct irq_domain *d, unsigned int ir=
q)
+{
+	irq_set_chip_and_handler(irq, NULL, NULL);
+	irq_set_chip_data(irq, NULL);
+}
+
+static const struct irq_domain_ops ts7800_ic_ops =3D {
+	.map =3D ts7800_irqdomain_map,
+	.unmap =3D ts7800_irqdomain_unmap
+};
+
+static void ts7800_ic_chained_handle_irq(struct irq_desc *desc)
+{
+	struct ts7800_irq_data *data =3D irq_desc_get_handler_data(desc);
+	struct irq_chip *chip =3D irq_desc_get_chip(desc);
+	u32 mask_bits =3D readl(data->base + IRQ_MASK_REG);
+	u32 status =3D readl(data->bridge);
+
+	chained_irq_enter(chip, desc);
+
+	if (unlikely(status =3D=3D 0)) {
+		handle_bad_irq(desc);
+		goto out;
+	}
+
+	do {
+		unsigned int bit =3D __ffs(status);
+		int irq =3D irq_find_mapping(data->domain, bit);
+
+		if (irq && (mask_bits & BIT(bit)))
+			generic_handle_irq(irq);
+
+		status &=3D ~(1 << bit);
+
+	} while (status);
+
+out:
+	chained_irq_exit(chip, desc);
+}
+
+static int ts7800_ic_probe(struct platform_device *pdev)
+{
+	struct ts7800_irq_data *data =3D NULL;
+	struct resource *mem_res =3D NULL, *brdg_res =3D NULL, *irq_res =3D NUL=
L;
+	unsigned int irqdomain;
+	int i, ret;
+
+	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (IS_ERR_OR_NULL(data)) {
+		dev_err(&pdev->dev,
+			"Failed to allocate TS7800 data, error %ld\n",
+			PTR_ERR(data));
+		ret =3D PTR_ERR(data);
+		goto devm_kzalloc_err;
+	}
+
+	mem_res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "ts_irqc=
");
+	if (IS_ERR_OR_NULL(mem_res)) {
+		dev_err(&pdev->dev,
+			"Failed to get platform memory resource, error %ld\n",
+			PTR_ERR(mem_res));
+		ret =3D PTR_ERR(mem_res);
+		goto pltfrm_get_res_mem_err;
+	}
+
+	data->base =3D devm_ioremap_resource(&pdev->dev, mem_res);
+	if (IS_ERR_OR_NULL(data->base)) {
+		dev_err(&pdev->dev,
+			"Failed to IO map mem-region %s, error %ld\n",
+			mem_res->name, PTR_ERR(data->base));
+		ret =3D PTR_ERR(data->base);
+		goto devm_ioremap_res_mem_err;
+	}
+
+	brdg_res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "ts_bri=
dge");
+	if (IS_ERR_OR_NULL(brdg_res)) {
+		dev_err(&pdev->dev,
+			"Failed to get platform bridge resource, error %ld\n",
+			PTR_ERR(brdg_res));
+		ret =3D PTR_ERR(brdg_res);
+		goto pltfrm_get_res_brdg_err;
+	}
+
+	data->bridge =3D devm_ioremap_resource(&pdev->dev, brdg_res);
+	if (IS_ERR_OR_NULL(data->bridge)) {
+		dev_err(&pdev->dev,
+			"Failed to IO map bridge-region %s, error %ld\n",
+			mem_res->name, PTR_ERR(data->bridge));
+		ret =3D PTR_ERR(data->bridge);
+		goto devm_ioremap_res_brdge_err;
+	}
+
+	irq_res =3D platform_get_resource_byname(pdev, IORESOURCE_IRQ,
+					       "ts_irqc_parent");
+	if (IS_ERR_OR_NULL(irq_res)) {
+		dev_err(&pdev->dev,
+			"Failed to get platform parent irq resource, error %ld\n",
+			PTR_ERR(irq_res));
+		ret =3D PTR_ERR(irq_res);
+		goto pltfrm_get_res_irq_err;
+	}
+
+	raw_spin_lock_init(&data->lock);
+	data->mpp7_virq =3D irq_res->start;
+	data->irq_chip.name =3D dev_name(&pdev->dev);
+	data->irq_chip.irq_mask =3D ts7800_irq_mask;
+	data->irq_chip.irq_unmask =3D ts7800_irq_unmask;
+	data->irq_chip.irq_ack =3D ts7800_irq_ack;
+
+	writel(0x0, data->bridge);
+	writel(0x0, data->bridge + IRQ_MASK_REG);
+	writel(0x0, data->base + IRQ_MASK_REG);
+
+	data->domain =3D irq_domain_add_linear(pdev->dev.of_node, TS7800_IRQ_NU=
M,
+					     &ts7800_ic_ops, data);
+	if (IS_ERR_OR_NULL(data->domain)) {
+		dev_err(&pdev->dev, "cannot add IRQ domain\n");
+		ret =3D PTR_ERR(data->domain);
+		goto irq_domain_add_linear_err;
+	}
+
+	for (i =3D 0; i < ARRAY_SIZE(enabled_mappings); ++i) {
+		irqdomain =3D
+			irq_create_mapping(data->domain, enabled_mappings[i]);
+	}
+
+	irq_set_chained_handler_and_data(data->mpp7_virq,
+					 ts7800_ic_chained_handle_irq, data);
+
+	platform_set_drvdata(pdev, data);
+
+	return 0;
+
+irq_domain_add_linear_err:
+pltfrm_get_res_irq_err:
+	devm_iounmap(&pdev->dev, data->bridge);
+
+devm_ioremap_res_brdge_err:
+pltfrm_get_res_brdg_err:
+	devm_iounmap(&pdev->dev, data->base);
+
+devm_ioremap_res_mem_err:
+pltfrm_get_res_mem_err:
+	devm_kfree(&pdev->dev, data);
+
+devm_kzalloc_err:
+	return ret;
+}
+
+static int ts7800_ic_remove(struct platform_device *pdev)
+{
+	struct ts7800_irq_data *data =3D platform_get_drvdata(pdev);
+	int i;
+
+	if (!IS_ERR_OR_NULL(data)) {
+		irq_set_chained_handler_and_data(data->mpp7_virq, NULL, NULL);
+
+		for (i =3D 0; i < ARRAY_SIZE(enabled_mappings); ++i)
+			irq_dispose_mapping(irq_find_mapping(
+				data->domain, enabled_mappings[i]));
+
+		irq_domain_remove(data->domain);
+	}
+
+	return 0;
+}
+
+static const struct platform_device_id ts7800v1_ic_ids[] =3D {
+	{
+		.name =3D DRIVER_NAME,
+	},
+	{
+		/* sentinel */
+	}
+};
+
+MODULE_DEVICE_TABLE(platform, ts7800v1_ic_ids);
+
+static struct platform_driver ts7800_ic_driver =3D {
+	.probe  =3D ts7800_ic_probe,
+	.remove =3D ts7800_ic_remove,
+	.id_table	=3D ts7800v1_ic_ids,
+	.driver =3D {
+		.name =3D DRIVER_NAME,
+		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+builtin_platform_driver(ts7800_ic_driver);
+
+MODULE_ALIAS("platform:ts7800-irqc");
+MODULE_DESCRIPTION("TS-7800v1 FPGA based IRQ controller Driver");
+MODULE_AUTHOR("Firas Ashkar <firas.ashkar@savoirfairelinux.com>");
+MODULE_LICENSE("GPL");
--=20
2.34.1

