Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A315FC6B9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 15:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiJLNs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 09:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiJLNsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:48:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701AFC5128
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:48:49 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1665582527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ys29NQUoZ6Y0sxYtBGYIFg5FKgbZkjWr/I5LWtqHgsE=;
        b=EELEw1AqPn/aamnbwhq7tuT6ygzLRMWVCs7Ec9ktxbdjisL3AJAAqb9SUtNxuhofg8F9km
        D4XDFeAB8zoN5xCvpdxzKYoFDJeDMwvhB6WDURRugIHnDVL/9ScYvLmAqeQDTh0e1B5w0N
        Hx0lDy1eJd/Ea8icQimjGmvMKvKORmQefNcUmfTB0ZMcZ44rxDGEHOR0gAc58wSbMdsZJE
        RqvUWCfIMOyHZN3w9WI3roRzWyuIbO+R9Fg6PH8ITadsho8AtlEzte/w+EYWsTrEFhm7aK
        VapmqbWmT/2xZRjebkXBjuuHY4KmO6YjqIOxF5jiCbTWzWznSh6C9TvH/2C0+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1665582527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ys29NQUoZ6Y0sxYtBGYIFg5FKgbZkjWr/I5LWtqHgsE=;
        b=B6BuKNUD8pSaYTTL+E1yLM0w1mta6nnDpLpPDyVLoEaKMv4HMFNZNznG2gxRRvJhlzi6Vd
        dbImu1sIUwvjKEBQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/core for v6.1-rc1
Message-ID: <166558251511.208146.10184958171655902083.tglx@xen13.fritz.box>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Wed, 12 Oct 2022 15:48:46 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2022-10=
-12

up to:  b8d49bcd8fd1: Merge tag 'irqchip-fixes-6.1-1' of git://git.kernel.org=
/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

Interrupt subsystem updates:

  - Core code:

    - Provide a generic wrapper which can be utilized in drivers to handle
      the problem of force threaded demultiplex interrupts on RT enabled
      kernels. This avoids conditionals and horrible quirks in drivers all
      over the place.

    - Fix up affected pinctrl and GPIO drivers to make them cleanly RT safe.

  - Interrupt drivers:

    - A new driver for the FSL MU platform specific MSI implementation.

    - Make irqchip_init() available for pure ACPI based systems.

    - Provide a functional DT binding for the Realtek RTL interrupt chip.

    - The usual DT updates and small code improvements all over the place.


Sorry for the late pull request. The new driver caused a randconfig
regression due to a missing Kconfig dependency and we let the trivial fix
soak for a few days.

Thanks,

	tglx

------------------>
Apurva Nandan (2):
      dt-bindings: irqchip: ti,sci-inta: Fix warning for missing #interrupt-c=
ells
      dt-bindings: interrupt-controller: ti,sci-intr: Fix missing reg propert=
y in the binding

Frank Li (5):
      platform-msi: Export symbol platform_msi_create_irq_domain()
      irqchip: Allow extra fields to be passed to IRQCHIP_PLATFORM_DRIVER_END
      irqchip: Add IMX MU MSI controller driver
      dt-bindings: irqchip: Describe the IMX MU block as a MSI controller
      irqchip/imx-mu-msi: Fix wrong register offset for 8ulp

Geert Uytterhoeven (2):
      dt-bindings: irqchip: renesas,irqc: Add r8a779g0 support
      irqchip: IMX_MU_MSI should depend on ARCH_MXC

Huacai Chen (1):
      irqchip: Make irqchip_init() usable on pure ACPI systems

Sander Vanheule (3):
      irqchip/realtek-rtl: use irq_domain_add_linear()
      dt-bindings: interrupt-controller: realtek,rtl-intc: require parents
      irqchip/realtek-rtl: use parent interrupts

Sebastian Andrzej Siewior (6):
      genirq: Provide generic_handle_domain_irq_safe().
      pinctrl: amd: Use generic_handle_irq_safe()
      ssb: gpio: Use generic_handle_irq_safe()
      platform/x86: intel_int0002_vgpio: Use generic_handle_irq_safe()
      gpio: mlxbf2: Use generic_handle_irq_safe()
      bcma: gpio: Use generic_handle_irq_safe()

Vladimir Oltean (1):
      irqchip/ls-extirq: Fix invalid wait context by avoiding to use regmap

Zhiyuan Dai (1):
      irqchip/gic-v3: Fix typo in comment


 .../bindings/interrupt-controller/fsl,mu-msi.yaml  |  99 +++++
 .../interrupt-controller/realtek,rtl-intc.yaml     |  60 ++-
 .../interrupt-controller/renesas,irqc.yaml         |   1 +
 .../bindings/interrupt-controller/ti,sci-inta.yaml |   3 +
 .../bindings/interrupt-controller/ti,sci-intr.yaml |   3 +
 drivers/base/platform-msi.c                        |   1 +
 drivers/bcma/driver_gpio.c                         |   2 +-
 drivers/gpio/gpio-mlxbf2.c                         |   6 +-
 drivers/irqchip/Kconfig                            |  17 +-
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-gic-v3.c                       |   2 +-
 drivers/irqchip/irq-imx-mu-msi.c                   | 453 +++++++++++++++++++=
++
 drivers/irqchip/irq-ls-extirq.c                    |  87 ++--
 drivers/irqchip/irq-realtek-rtl.c                  | 134 +++---
 drivers/pinctrl/pinctrl-amd.c                      |   2 +-
 drivers/platform/x86/intel/int0002_vgpio.c         |   3 +-
 drivers/ssb/driver_gpio.c                          |   6 +-
 include/linux/irqchip.h                            |   4 +-
 include/linux/irqdesc.h                            |   1 +
 include/linux/of_irq.h                             |   6 +-
 kernel/irq/irqdesc.c                               |  24 ++
 21 files changed, 788 insertions(+), 127 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fs=
l,mu-msi.yaml
 create mode 100644 drivers/irqchip/irq-imx-mu-msi.c

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-ms=
i.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.ya=
ml
new file mode 100644
index 000000000000..799ae5c3e32a
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/fsl,mu-msi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale/NXP i.MX Messaging Unit (MU) work as msi controller
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+description: |
+  The Messaging Unit module enables two processors within the SoC to
+  communicate and coordinate by passing messages (e.g. data, status
+  and control) through the MU interface. The MU also provides the ability
+  for one processor (A side) to signal the other processor (B side) using
+  interrupts.
+
+  Because the MU manages the messaging between processors, the MU uses
+  different clocks (from each side of the different peripheral buses).
+  Therefore, the MU must synchronize the accesses from one side to the
+  other. The MU accomplishes synchronization using two sets of matching
+  registers (Processor A-side, Processor B-side).
+
+  MU can work as msi interrupt controller to do doorbell
+
+allOf:
+  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx6sx-mu-msi
+      - fsl,imx7ulp-mu-msi
+      - fsl,imx8ulp-mu-msi
+      - fsl,imx8ulp-mu-msi-s4
+
+  reg:
+    items:
+      - description: a side register base address
+      - description: b side register base address
+
+  reg-names:
+    items:
+      - const: processor-a-side
+      - const: processor-b-side
+
+  interrupts:
+    description: a side interrupt number.
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    items:
+      - description: a side power domain
+      - description: b side power domain
+
+  power-domain-names:
+    items:
+      - const: processor-a-side
+      - const: processor-b-side
+
+  interrupt-controller: true
+
+  msi-controller: true
+
+  "#msi-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - msi-controller
+  - "#msi-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/firmware/imx/rsrc.h>
+
+    msi-controller@5d270000 {
+        compatible =3D "fsl,imx6sx-mu-msi";
+        msi-controller;
+        #msi-cells =3D <0>;
+        interrupt-controller;
+        reg =3D <0x5d270000 0x10000>,     /* A side */
+              <0x5d300000 0x10000>;     /* B side */
+        reg-names =3D "processor-a-side", "processor-b-side";
+        interrupts =3D <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
+        power-domains =3D <&pd IMX_SC_R_MU_12A>,
+                        <&pd IMX_SC_R_MU_12B>;
+        power-domain-names =3D "processor-a-side", "processor-b-side";
+    };
diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,r=
tl-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/realtek=
,rtl-intc.yaml
index 9e76fff20323..13a893b18fb6 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc=
.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc=
.yaml
@@ -6,6 +6,14 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
=20
 title: Realtek RTL SoC interrupt controller devicetree bindings
=20
+description:
+  Interrupt controller and router for Realtek MIPS SoCs, allowing each SoC
+  interrupt to be routed to one parent CPU (hardware) interrupt, or left
+  disconnected.
+  All connected input lines from SoC peripherals can be masked individually,
+  and an interrupt status register is present to indicate which interrupts a=
re
+  pending.
+
 maintainers:
   - Birger Koblitz <mail@birger-koblitz.de>
   - Bert Vermeulen <bert@biot.com>
@@ -13,23 +21,33 @@ maintainers:
=20
 properties:
   compatible:
-    const: realtek,rtl-intc
+    oneOf:
+      - items:
+          - enum:
+              - realtek,rtl8380-intc
+          - const: realtek,rtl-intc
+      - const: realtek,rtl-intc
+        deprecated: true
=20
   "#interrupt-cells":
+    description:
+      SoC interrupt line index.
     const: 1
=20
   reg:
     maxItems: 1
=20
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 15
+    description:
+      List of parent interrupts, in the order that they are connected to this
+      interrupt router's outputs, starting at the first output.
=20
   interrupt-controller: true
=20
-  "#address-cells":
-    const: 0
-
   interrupt-map:
+    deprecated: true
     description: Describes mapping from SoC interrupts to CPU interrupts
=20
 required:
@@ -37,21 +55,33 @@ required:
   - reg
   - "#interrupt-cells"
   - interrupt-controller
-  - "#address-cells"
-  - interrupt-map
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: realtek,rtl-intc
+    then:
+      properties:
+        "#address-cells":
+          const: 0
+      required:
+        - "#address-cells"
+        - interrupt-map
+    else:
+      required:
+        - interrupts
=20
 additionalProperties: false
=20
 examples:
   - |
-    intc: interrupt-controller@3000 {
-      compatible =3D "realtek,rtl-intc";
+    interrupt-controller@3000 {
+      compatible =3D "realtek,rtl8380-intc", "realtek,rtl-intc";
       #interrupt-cells =3D <1>;
       interrupt-controller;
-      reg =3D <0x3000 0x20>;
-      #address-cells =3D <0>;
-      interrupt-map =3D
-              <31 &cpuintc 2>,
-              <30 &cpuintc 1>,
-              <29 &cpuintc 5>;
+      reg =3D <0x3000 0x18>;
+
+      interrupt-parent =3D <&cpuintc>;
+      interrupts =3D <2>, <3>, <4>, <5>, <6>;
     };
diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,i=
rqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,irq=
c.yaml
index 620f01775e42..62fd47c88275 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
@@ -37,6 +37,7 @@ properties:
           - renesas,intc-ex-r8a77990    # R-Car E3
           - renesas,intc-ex-r8a77995    # R-Car D3
           - renesas,intc-ex-r8a779a0    # R-Car V3U
+          - renesas,intc-ex-r8a779g0    # R-Car V4H
       - const: renesas,irqc
=20
   '#interrupt-cells':
diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-in=
ta.yaml b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.=
yaml
index 88c46e61732e..1151518859bd 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
@@ -59,6 +59,9 @@ properties:
=20
   interrupt-controller: true
=20
+  '#interrupt-cells':
+    const: 0
+
   msi-controller: true
=20
   ti,interrupt-ranges:
diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-in=
tr.yaml b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.=
yaml
index e12aee42b126..c99cc7323c71 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml
@@ -58,6 +58,9 @@ properties:
         1 =3D If intr supports edge triggered interrupts.
         4 =3D If intr supports level triggered interrupts.
=20
+  reg:
+    maxItems: 1
+
   interrupt-controller: true
=20
   '#interrupt-cells':
diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 296ea673d661..12b044151298 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -138,6 +138,7 @@ struct irq_domain *platform_msi_create_irq_domain(struct =
fwnode_handle *fwnode,
=20
 	return domain;
 }
+EXPORT_SYMBOL_GPL(platform_msi_create_irq_domain);
=20
 static int platform_msi_alloc_priv_data(struct device *dev, unsigned int nve=
c,
 					irq_write_msi_msg_t write_msi_msg)
diff --git a/drivers/bcma/driver_gpio.c b/drivers/bcma/driver_gpio.c
index fac8ff983aec..65fb9bad1577 100644
--- a/drivers/bcma/driver_gpio.c
+++ b/drivers/bcma/driver_gpio.c
@@ -115,7 +115,7 @@ static irqreturn_t bcma_gpio_irq_handler(int irq, void *d=
ev_id)
 		return IRQ_NONE;
=20
 	for_each_set_bit(gpio, &irqs, gc->ngpio)
-		generic_handle_irq(irq_find_mapping(gc->irq.domain, gpio));
+		generic_handle_domain_irq_safe(gc->irq.domain, gpio);
 	bcma_chipco_gpio_polarity(cc, irqs, val & irqs);
=20
 	return IRQ_HANDLED;
diff --git a/drivers/gpio/gpio-mlxbf2.c b/drivers/gpio/gpio-mlxbf2.c
index 64cb060d9d75..77a41151c921 100644
--- a/drivers/gpio/gpio-mlxbf2.c
+++ b/drivers/gpio/gpio-mlxbf2.c
@@ -273,10 +273,8 @@ static irqreturn_t mlxbf2_gpio_irq_handler(int irq, void=
 *ptr)
 	pending =3D readl(gs->gpio_io + YU_GPIO_CAUSE_OR_CAUSE_EVTEN0);
 	writel(pending, gs->gpio_io + YU_GPIO_CAUSE_OR_CLRCAUSE);
=20
-	for_each_set_bit(level, &pending, gc->ngpio) {
-		int gpio_irq =3D irq_find_mapping(gc->irq.domain, level);
-		generic_handle_irq(gpio_irq);
-	}
+	for_each_set_bit(level, &pending, gc->ngpio)
+		generic_handle_domain_irq_safe(gc->irq.domain, level);
=20
 	return IRQ_RETVAL(pending);
 }
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 66b9fa408bf2..93d990133f9a 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -3,7 +3,7 @@ menu "IRQ chip support"
=20
 config IRQCHIP
 	def_bool y
-	depends on OF_IRQ
+	depends on (OF_IRQ || ACPI_GENERIC_GSI)
=20
 config ARM_GIC
 	bool
@@ -481,6 +481,21 @@ config IMX_INTMUX
 	help
 	  Support for the i.MX INTMUX interrupt multiplexer.
=20
+config IMX_MU_MSI
+	tristate "i.MX MU used as MSI controller"
+	depends on OF && HAS_IOMEM
+	depends on ARCH_MXC || COMPILE_TEST
+	default m if ARCH_MXC
+	select IRQ_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY
+	select GENERIC_MSI_IRQ_DOMAIN
+	help
+	  Provide a driver for the i.MX Messaging Unit block used as a
+	  CPU-to-CPU MSI controller. This requires a specially crafted DT
+	  to make use of this driver.
+
+	  If unsure, say N
+
 config LS1X_IRQ
 	bool "Loongson-1 Interrupt Controller"
 	depends on MACH_LOONGSON32
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index b6acbca2248b..87b49a10962c 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -99,6 +99,7 @@ obj-$(CONFIG_RISCV_INTC)		+=3D irq-riscv-intc.o
 obj-$(CONFIG_SIFIVE_PLIC)		+=3D irq-sifive-plic.o
 obj-$(CONFIG_IMX_IRQSTEER)		+=3D irq-imx-irqsteer.o
 obj-$(CONFIG_IMX_INTMUX)		+=3D irq-imx-intmux.o
+obj-$(CONFIG_IMX_MU_MSI)		+=3D irq-imx-mu-msi.o
 obj-$(CONFIG_MADERA_IRQ)		+=3D irq-madera.o
 obj-$(CONFIG_LS1X_IRQ)			+=3D irq-ls1x.o
 obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+=3D irq-ti-sci-intr.o
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 262658fd5f9e..34d58567b78d 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -978,7 +978,7 @@ static int __gic_update_rdist_properties(struct redist_re=
gion *region,
 	u64 typer =3D gic_read_typer(ptr + GICR_TYPER);
 	u32 ctlr =3D readl_relaxed(ptr + GICR_CTLR);
=20
-	/* Boot-time cleanip */
+	/* Boot-time cleanup */
 	if ((typer & GICR_TYPER_VLPIS) && (typer & GICR_TYPER_RVPEID)) {
 		u64 val;
=20
diff --git a/drivers/irqchip/irq-imx-mu-msi.c b/drivers/irqchip/irq-imx-mu-ms=
i.c
new file mode 100644
index 000000000000..229039eda1b1
--- /dev/null
+++ b/drivers/irqchip/irq-imx-mu-msi.c
@@ -0,0 +1,453 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Freescale MU used as MSI controller
+ *
+ * Copyright (c) 2018 Pengutronix, Oleksij Rempel <o.rempel@pengutronix.de>
+ * Copyright 2022 NXP
+ *	Frank Li <Frank.Li@nxp.com>
+ *	Peng Fan <peng.fan@nxp.com>
+ *
+ * Based on drivers/mailbox/imx-mailbox.c
+ */
+
+#include <linux/clk.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm_domain.h>
+#include <linux/spinlock.h>
+
+#define IMX_MU_CHANS            4
+
+enum imx_mu_xcr {
+	IMX_MU_GIER,
+	IMX_MU_GCR,
+	IMX_MU_TCR,
+	IMX_MU_RCR,
+	IMX_MU_xCR_MAX,
+};
+
+enum imx_mu_xsr {
+	IMX_MU_SR,
+	IMX_MU_GSR,
+	IMX_MU_TSR,
+	IMX_MU_RSR,
+	IMX_MU_xSR_MAX
+};
+
+enum imx_mu_type {
+	IMX_MU_V2 =3D BIT(1),
+};
+
+/* Receive Interrupt Enable */
+#define IMX_MU_xCR_RIEn(data, x) ((data->cfg->type) & IMX_MU_V2 ? BIT(x) : B=
IT(24 + (3 - (x))))
+#define IMX_MU_xSR_RFn(data, x) ((data->cfg->type) & IMX_MU_V2 ? BIT(x) : BI=
T(24 + (3 - (x))))
+
+struct imx_mu_dcfg {
+	enum imx_mu_type type;
+	u32     xTR;            /* Transmit Register0 */
+	u32     xRR;            /* Receive Register0 */
+	u32     xSR[IMX_MU_xSR_MAX];         /* Status Registers */
+	u32     xCR[IMX_MU_xCR_MAX];         /* Control Registers */
+};
+
+struct imx_mu_msi {
+	raw_spinlock_t			lock;
+	struct irq_domain		*msi_domain;
+	void __iomem			*regs;
+	phys_addr_t			msiir_addr;
+	const struct imx_mu_dcfg	*cfg;
+	unsigned long			used;
+	struct clk			*clk;
+};
+
+static void imx_mu_write(struct imx_mu_msi *msi_data, u32 val, u32 offs)
+{
+	iowrite32(val, msi_data->regs + offs);
+}
+
+static u32 imx_mu_read(struct imx_mu_msi *msi_data, u32 offs)
+{
+	return ioread32(msi_data->regs + offs);
+}
+
+static u32 imx_mu_xcr_rmw(struct imx_mu_msi *msi_data, enum imx_mu_xcr type,=
 u32 set, u32 clr)
+{
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&msi_data->lock, flags);
+	val =3D imx_mu_read(msi_data, msi_data->cfg->xCR[type]);
+	val &=3D ~clr;
+	val |=3D set;
+	imx_mu_write(msi_data, val, msi_data->cfg->xCR[type]);
+	raw_spin_unlock_irqrestore(&msi_data->lock, flags);
+
+	return val;
+}
+
+static void imx_mu_msi_parent_mask_irq(struct irq_data *data)
+{
+	struct imx_mu_msi *msi_data =3D irq_data_get_irq_chip_data(data);
+
+	imx_mu_xcr_rmw(msi_data, IMX_MU_RCR, 0, IMX_MU_xCR_RIEn(msi_data, data->hwi=
rq));
+}
+
+static void imx_mu_msi_parent_unmask_irq(struct irq_data *data)
+{
+	struct imx_mu_msi *msi_data =3D irq_data_get_irq_chip_data(data);
+
+	imx_mu_xcr_rmw(msi_data, IMX_MU_RCR, IMX_MU_xCR_RIEn(msi_data, data->hwirq)=
, 0);
+}
+
+static void imx_mu_msi_parent_ack_irq(struct irq_data *data)
+{
+	struct imx_mu_msi *msi_data =3D irq_data_get_irq_chip_data(data);
+
+	imx_mu_read(msi_data, msi_data->cfg->xRR + data->hwirq * 4);
+}
+
+static struct irq_chip imx_mu_msi_irq_chip =3D {
+	.name =3D "MU-MSI",
+	.irq_ack =3D irq_chip_ack_parent,
+};
+
+static struct msi_domain_ops imx_mu_msi_irq_ops =3D {
+};
+
+static struct msi_domain_info imx_mu_msi_domain_info =3D {
+	.flags	=3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
+	.ops	=3D &imx_mu_msi_irq_ops,
+	.chip	=3D &imx_mu_msi_irq_chip,
+};
+
+static void imx_mu_msi_parent_compose_msg(struct irq_data *data,
+					  struct msi_msg *msg)
+{
+	struct imx_mu_msi *msi_data =3D irq_data_get_irq_chip_data(data);
+	u64 addr =3D msi_data->msiir_addr + 4 * data->hwirq;
+
+	msg->address_hi =3D upper_32_bits(addr);
+	msg->address_lo =3D lower_32_bits(addr);
+	msg->data =3D data->hwirq;
+}
+
+static int imx_mu_msi_parent_set_affinity(struct irq_data *irq_data,
+				   const struct cpumask *mask, bool force)
+{
+	return -EINVAL;
+}
+
+static struct irq_chip imx_mu_msi_parent_chip =3D {
+	.name		=3D "MU",
+	.irq_mask	=3D imx_mu_msi_parent_mask_irq,
+	.irq_unmask	=3D imx_mu_msi_parent_unmask_irq,
+	.irq_ack	=3D imx_mu_msi_parent_ack_irq,
+	.irq_compose_msi_msg	=3D imx_mu_msi_parent_compose_msg,
+	.irq_set_affinity =3D imx_mu_msi_parent_set_affinity,
+};
+
+static int imx_mu_msi_domain_irq_alloc(struct irq_domain *domain,
+					unsigned int virq,
+					unsigned int nr_irqs,
+					void *args)
+{
+	struct imx_mu_msi *msi_data =3D domain->host_data;
+	unsigned long flags;
+	int pos, err =3D 0;
+
+	WARN_ON(nr_irqs !=3D 1);
+
+	raw_spin_lock_irqsave(&msi_data->lock, flags);
+	pos =3D find_first_zero_bit(&msi_data->used, IMX_MU_CHANS);
+	if (pos < IMX_MU_CHANS)
+		__set_bit(pos, &msi_data->used);
+	else
+		err =3D -ENOSPC;
+	raw_spin_unlock_irqrestore(&msi_data->lock, flags);
+
+	if (err)
+		return err;
+
+	irq_domain_set_info(domain, virq, pos,
+			    &imx_mu_msi_parent_chip, msi_data,
+			    handle_edge_irq, NULL, NULL);
+	return 0;
+}
+
+static void imx_mu_msi_domain_irq_free(struct irq_domain *domain,
+				       unsigned int virq, unsigned int nr_irqs)
+{
+	struct irq_data *d =3D irq_domain_get_irq_data(domain, virq);
+	struct imx_mu_msi *msi_data =3D irq_data_get_irq_chip_data(d);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&msi_data->lock, flags);
+	__clear_bit(d->hwirq, &msi_data->used);
+	raw_spin_unlock_irqrestore(&msi_data->lock, flags);
+}
+
+static const struct irq_domain_ops imx_mu_msi_domain_ops =3D {
+	.alloc	=3D imx_mu_msi_domain_irq_alloc,
+	.free	=3D imx_mu_msi_domain_irq_free,
+};
+
+static void imx_mu_msi_irq_handler(struct irq_desc *desc)
+{
+	struct imx_mu_msi *msi_data =3D irq_desc_get_handler_data(desc);
+	struct irq_chip *chip =3D irq_desc_get_chip(desc);
+	u32 status;
+	int i;
+
+	status =3D imx_mu_read(msi_data, msi_data->cfg->xSR[IMX_MU_RSR]);
+
+	chained_irq_enter(chip, desc);
+	for (i =3D 0; i < IMX_MU_CHANS; i++) {
+		if (status & IMX_MU_xSR_RFn(msi_data, i))
+			generic_handle_domain_irq(msi_data->msi_domain, i);
+	}
+	chained_irq_exit(chip, desc);
+}
+
+static int imx_mu_msi_domains_init(struct imx_mu_msi *msi_data, struct devic=
e *dev)
+{
+	struct fwnode_handle *fwnodes =3D dev_fwnode(dev);
+	struct irq_domain *parent;
+
+	/* Initialize MSI domain parent */
+	parent =3D irq_domain_create_linear(fwnodes,
+					    IMX_MU_CHANS,
+					    &imx_mu_msi_domain_ops,
+					    msi_data);
+	if (!parent) {
+		dev_err(dev, "failed to create IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
+
+	msi_data->msi_domain =3D platform_msi_create_irq_domain(fwnodes,
+					&imx_mu_msi_domain_info,
+					parent);
+
+	if (!msi_data->msi_domain) {
+		dev_err(dev, "failed to create MSI domain\n");
+		irq_domain_remove(parent);
+		return -ENOMEM;
+	}
+
+	irq_domain_set_pm_device(msi_data->msi_domain, dev);
+
+	return 0;
+}
+
+/* Register offset of different version MU IP */
+static const struct imx_mu_dcfg imx_mu_cfg_imx6sx =3D {
+	.type	=3D 0,
+	.xTR    =3D 0x0,
+	.xRR    =3D 0x10,
+	.xSR    =3D {
+			[IMX_MU_SR]  =3D 0x20,
+			[IMX_MU_GSR] =3D 0x20,
+			[IMX_MU_TSR] =3D 0x20,
+			[IMX_MU_RSR] =3D 0x20,
+		  },
+	.xCR    =3D {
+			[IMX_MU_GIER] =3D 0x24,
+			[IMX_MU_GCR]  =3D 0x24,
+			[IMX_MU_TCR]  =3D 0x24,
+			[IMX_MU_RCR]  =3D 0x24,
+		  },
+};
+
+static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp =3D {
+	.type	=3D 0,
+	.xTR    =3D 0x20,
+	.xRR    =3D 0x40,
+	.xSR    =3D {
+			[IMX_MU_SR]  =3D 0x60,
+			[IMX_MU_GSR] =3D 0x60,
+			[IMX_MU_TSR] =3D 0x60,
+			[IMX_MU_RSR] =3D 0x60,
+		  },
+	.xCR    =3D {
+			[IMX_MU_GIER] =3D 0x64,
+			[IMX_MU_GCR]  =3D 0x64,
+			[IMX_MU_TCR]  =3D 0x64,
+			[IMX_MU_RCR]  =3D 0x64,
+		  },
+};
+
+static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp =3D {
+	.type   =3D IMX_MU_V2,
+	.xTR    =3D 0x200,
+	.xRR    =3D 0x280,
+	.xSR    =3D {
+			[IMX_MU_SR]  =3D 0xC,
+			[IMX_MU_GSR] =3D 0x118,
+			[IMX_MU_TSR] =3D 0x124,
+			[IMX_MU_RSR] =3D 0x12C,
+		  },
+	.xCR    =3D {
+			[IMX_MU_GIER] =3D 0x110,
+			[IMX_MU_GCR]  =3D 0x114,
+			[IMX_MU_TCR]  =3D 0x120,
+			[IMX_MU_RCR]  =3D 0x128
+		  },
+};
+
+static int __init imx_mu_of_init(struct device_node *dn,
+				 struct device_node *parent,
+				 const struct imx_mu_dcfg *cfg)
+{
+	struct platform_device *pdev =3D of_find_device_by_node(dn);
+	struct device_link *pd_link_a;
+	struct device_link *pd_link_b;
+	struct imx_mu_msi *msi_data;
+	struct resource *res;
+	struct device *pd_a;
+	struct device *pd_b;
+	struct device *dev;
+	int ret;
+	int irq;
+
+	dev =3D &pdev->dev;
+
+	msi_data =3D devm_kzalloc(&pdev->dev, sizeof(*msi_data), GFP_KERNEL);
+	if (!msi_data)
+		return -ENOMEM;
+
+	msi_data->cfg =3D cfg;
+
+	msi_data->regs =3D devm_platform_ioremap_resource_byname(pdev, "processor-a=
-side");
+	if (IS_ERR(msi_data->regs)) {
+		dev_err(&pdev->dev, "failed to initialize 'regs'\n");
+		return PTR_ERR(msi_data->regs);
+	}
+
+	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "processor-b-sid=
e");
+	if (!res)
+		return -EIO;
+
+	msi_data->msiir_addr =3D res->start + msi_data->cfg->xTR;
+
+	irq =3D platform_get_irq(pdev, 0);
+	if (irq <=3D 0)
+		return -ENODEV;
+
+	platform_set_drvdata(pdev, msi_data);
+
+	msi_data->clk =3D devm_clk_get(dev, NULL);
+	if (IS_ERR(msi_data->clk))
+		return PTR_ERR(msi_data->clk);
+
+	pd_a =3D dev_pm_domain_attach_by_name(dev, "processor-a-side");
+	if (IS_ERR(pd_a))
+		return PTR_ERR(pd_a);
+
+	pd_b =3D dev_pm_domain_attach_by_name(dev, "processor-b-side");
+	if (IS_ERR(pd_b))
+		return PTR_ERR(pd_b);
+
+	pd_link_a =3D device_link_add(dev, pd_a,
+			DL_FLAG_STATELESS |
+			DL_FLAG_PM_RUNTIME |
+			DL_FLAG_RPM_ACTIVE);
+
+	if (!pd_link_a) {
+		dev_err(dev, "Failed to add device_link to mu a.\n");
+		goto err_pd_a;
+	}
+
+	pd_link_b =3D device_link_add(dev, pd_b,
+			DL_FLAG_STATELESS |
+			DL_FLAG_PM_RUNTIME |
+			DL_FLAG_RPM_ACTIVE);
+
+
+	if (!pd_link_b) {
+		dev_err(dev, "Failed to add device_link to mu a.\n");
+		goto err_pd_b;
+	}
+
+	ret =3D imx_mu_msi_domains_init(msi_data, dev);
+	if (ret)
+		goto err_dm_init;
+
+	pm_runtime_enable(dev);
+
+	irq_set_chained_handler_and_data(irq,
+					 imx_mu_msi_irq_handler,
+					 msi_data);
+
+	return 0;
+
+err_dm_init:
+	device_link_remove(dev,	pd_b);
+err_pd_b:
+	device_link_remove(dev, pd_a);
+err_pd_a:
+	return -EINVAL;
+}
+
+static int __maybe_unused imx_mu_runtime_suspend(struct device *dev)
+{
+	struct imx_mu_msi *priv =3D dev_get_drvdata(dev);
+
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static int __maybe_unused imx_mu_runtime_resume(struct device *dev)
+{
+	struct imx_mu_msi *priv =3D dev_get_drvdata(dev);
+	int ret;
+
+	ret =3D clk_prepare_enable(priv->clk);
+	if (ret)
+		dev_err(dev, "failed to enable clock\n");
+
+	return ret;
+}
+
+static const struct dev_pm_ops imx_mu_pm_ops =3D {
+	SET_RUNTIME_PM_OPS(imx_mu_runtime_suspend,
+			   imx_mu_runtime_resume, NULL)
+};
+
+static int __init imx_mu_imx7ulp_of_init(struct device_node *dn,
+					 struct device_node *parent)
+{
+	return imx_mu_of_init(dn, parent, &imx_mu_cfg_imx7ulp);
+}
+
+static int __init imx_mu_imx6sx_of_init(struct device_node *dn,
+					struct device_node *parent)
+{
+	return imx_mu_of_init(dn, parent, &imx_mu_cfg_imx6sx);
+}
+
+static int __init imx_mu_imx8ulp_of_init(struct device_node *dn,
+					 struct device_node *parent)
+{
+	return imx_mu_of_init(dn, parent, &imx_mu_cfg_imx8ulp);
+}
+
+IRQCHIP_PLATFORM_DRIVER_BEGIN(imx_mu_msi)
+IRQCHIP_MATCH("fsl,imx7ulp-mu-msi", imx_mu_imx7ulp_of_init)
+IRQCHIP_MATCH("fsl,imx6sx-mu-msi", imx_mu_imx6sx_of_init)
+IRQCHIP_MATCH("fsl,imx8ulp-mu-msi", imx_mu_imx8ulp_of_init)
+IRQCHIP_PLATFORM_DRIVER_END(imx_mu_msi, .pm =3D &imx_mu_pm_ops)
+
+
+MODULE_AUTHOR("Frank Li <Frank.Li@nxp.com>");
+MODULE_DESCRIPTION("Freescale MU MSI controller driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/irqchip/irq-ls-extirq.c b/drivers/irqchip/irq-ls-extirq.c
index 853b3972dbe7..d8d48b1f7c29 100644
--- a/drivers/irqchip/irq-ls-extirq.c
+++ b/drivers/irqchip/irq-ls-extirq.c
@@ -6,8 +6,7 @@
 #include <linux/irqchip.h>
 #include <linux/irqdomain.h>
 #include <linux/of.h>
-#include <linux/mfd/syscon.h>
-#include <linux/regmap.h>
+#include <linux/of_address.h>
 #include <linux/slab.h>
=20
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -16,13 +15,41 @@
 #define LS1021A_SCFGREVCR 0x200
=20
 struct ls_extirq_data {
-	struct regmap		*syscon;
-	u32			intpcr;
+	void __iomem		*intpcr;
+	raw_spinlock_t		lock;
+	bool			big_endian;
 	bool			is_ls1021a_or_ls1043a;
 	u32			nirq;
 	struct irq_fwspec	map[MAXIRQ];
 };
=20
+static void ls_extirq_intpcr_rmw(struct ls_extirq_data *priv, u32 mask,
+				 u32 value)
+{
+	u32 intpcr;
+
+	/*
+	 * Serialize concurrent calls to ls_extirq_set_type() from multiple
+	 * IRQ descriptors, making sure the read-modify-write is atomic.
+	 */
+	raw_spin_lock(&priv->lock);
+
+	if (priv->big_endian)
+		intpcr =3D ioread32be(priv->intpcr);
+	else
+		intpcr =3D ioread32(priv->intpcr);
+
+	intpcr &=3D ~mask;
+	intpcr |=3D value;
+
+	if (priv->big_endian)
+		iowrite32be(intpcr, priv->intpcr);
+	else
+		iowrite32(intpcr, priv->intpcr);
+
+	raw_spin_unlock(&priv->lock);
+}
+
 static int
 ls_extirq_set_type(struct irq_data *data, unsigned int type)
 {
@@ -51,7 +78,8 @@ ls_extirq_set_type(struct irq_data *data, unsigned int type)
 	default:
 		return -EINVAL;
 	}
-	regmap_update_bits(priv->syscon, priv->intpcr, mask, value);
+
+	ls_extirq_intpcr_rmw(priv, mask, value);
=20
 	return irq_chip_set_type_parent(data, type);
 }
@@ -143,7 +171,6 @@ ls_extirq_parse_map(struct ls_extirq_data *priv, struct d=
evice_node *node)
 static int __init
 ls_extirq_of_init(struct device_node *node, struct device_node *parent)
 {
-
 	struct irq_domain *domain, *parent_domain;
 	struct ls_extirq_data *priv;
 	int ret;
@@ -151,40 +178,52 @@ ls_extirq_of_init(struct device_node *node, struct devi=
ce_node *parent)
 	parent_domain =3D irq_find_host(parent);
 	if (!parent_domain) {
 		pr_err("Cannot find parent domain\n");
-		return -ENODEV;
+		ret =3D -ENODEV;
+		goto err_irq_find_host;
 	}
=20
 	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	priv->syscon =3D syscon_node_to_regmap(node->parent);
-	if (IS_ERR(priv->syscon)) {
-		ret =3D PTR_ERR(priv->syscon);
-		pr_err("Failed to lookup parent regmap\n");
-		goto out;
+	if (!priv) {
+		ret =3D -ENOMEM;
+		goto err_alloc_priv;
 	}
-	ret =3D of_property_read_u32(node, "reg", &priv->intpcr);
-	if (ret) {
-		pr_err("Missing INTPCR offset value\n");
-		goto out;
+
+	/*
+	 * All extirq OF nodes are under a scfg/syscon node with
+	 * the 'ranges' property
+	 */
+	priv->intpcr =3D of_iomap(node, 0);
+	if (!priv->intpcr) {
+		pr_err("Cannot ioremap OF node %pOF\n", node);
+		ret =3D -ENOMEM;
+		goto err_iomap;
 	}
=20
 	ret =3D ls_extirq_parse_map(priv, node);
 	if (ret)
-		goto out;
+		goto err_parse_map;
=20
+	priv->big_endian =3D of_device_is_big_endian(parent);
 	priv->is_ls1021a_or_ls1043a =3D of_device_is_compatible(node, "fsl,ls1021a-=
extirq") ||
 				      of_device_is_compatible(node, "fsl,ls1043a-extirq");
+	raw_spin_lock_init(&priv->lock);
=20
 	domain =3D irq_domain_add_hierarchy(parent_domain, 0, priv->nirq, node,
 					  &extirq_domain_ops, priv);
-	if (!domain)
+	if (!domain) {
 		ret =3D -ENOMEM;
+		goto err_add_hierarchy;
+	}
=20
-out:
-	if (ret)
-		kfree(priv);
+	return 0;
+
+err_add_hierarchy:
+err_parse_map:
+	iounmap(priv->intpcr);
+err_iomap:
+	kfree(priv);
+err_alloc_priv:
+err_irq_find_host:
 	return ret;
 }
=20
diff --git a/drivers/irqchip/irq-realtek-rtl.c b/drivers/irqchip/irq-realtek-=
rtl.c
index 56bf502d9c67..2a349082af81 100644
--- a/drivers/irqchip/irq-realtek-rtl.c
+++ b/drivers/irqchip/irq-realtek-rtl.c
@@ -21,11 +21,33 @@
 #define RTL_ICTL_IRR2		0x10
 #define RTL_ICTL_IRR3		0x14
=20
+#define RTL_ICTL_NUM_INPUTS	32
+
 #define REG(x)		(realtek_ictl_base + x)
=20
 static DEFINE_RAW_SPINLOCK(irq_lock);
 static void __iomem *realtek_ictl_base;
=20
+/*
+ * IRR0-IRR3 store 4 bits per interrupt, but Realtek uses inverted numbering,
+ * placing IRQ 31 in the first four bits. A routing value of '0' means the
+ * interrupt is left disconnected. Routing values {1..15} connect to output
+ * lines {0..14}.
+ */
+#define IRR_OFFSET(idx)		(4 * (3 - (idx * 4) / 32))
+#define IRR_SHIFT(idx)		((idx * 4) % 32)
+
+static void write_irr(void __iomem *irr0, int idx, u32 value)
+{
+	unsigned int offset =3D IRR_OFFSET(idx);
+	unsigned int shift =3D IRR_SHIFT(idx);
+	u32 irr;
+
+	irr =3D readl(irr0 + offset) & ~(0xf << shift);
+	irr |=3D (value & 0xf) << shift;
+	writel(irr, irr0 + offset);
+}
+
 static void realtek_ictl_unmask_irq(struct irq_data *i)
 {
 	unsigned long flags;
@@ -62,8 +84,14 @@ static struct irq_chip realtek_ictl_irq =3D {
=20
 static int intc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t =
hw)
 {
+	unsigned long flags;
+
 	irq_set_chip_and_handler(irq, &realtek_ictl_irq, handle_level_irq);
=20
+	raw_spin_lock_irqsave(&irq_lock, flags);
+	write_irr(REG(RTL_ICTL_IRR0), hw, 1);
+	raw_spin_unlock_irqrestore(&irq_lock, flags);
+
 	return 0;
 }
=20
@@ -95,90 +123,50 @@ static void realtek_irq_dispatch(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
=20
-/*
- * SoC interrupts are cascaded to MIPS CPU interrupts according to the
- * interrupt-map in the device tree. Each SoC interrupt gets 4 bits for
- * the CPU interrupt in an Interrupt Routing Register. Max 32 SoC interrupts
- * thus go into 4 IRRs. A routing value of '0' means the interrupt is left
- * disconnected. Routing values {1..15} connect to output lines {0..14}.
- */
-static int __init map_interrupts(struct device_node *node, struct irq_domain=
 *domain)
-{
-	struct device_node *cpu_ictl;
-	const __be32 *imap;
-	u32 imaplen, soc_int, cpu_int, tmp, regs[4];
-	int ret, i, irr_regs[] =3D {
-		RTL_ICTL_IRR3,
-		RTL_ICTL_IRR2,
-		RTL_ICTL_IRR1,
-		RTL_ICTL_IRR0,
-	};
-	u8 mips_irqs_set;
-
-	ret =3D of_property_read_u32(node, "#address-cells", &tmp);
-	if (ret || tmp)
-		return -EINVAL;
-
-	imap =3D of_get_property(node, "interrupt-map", &imaplen);
-	if (!imap || imaplen % 3)
-		return -EINVAL;
-
-	mips_irqs_set =3D 0;
-	memset(regs, 0, sizeof(regs));
-	for (i =3D 0; i < imaplen; i +=3D 3 * sizeof(u32)) {
-		soc_int =3D be32_to_cpup(imap);
-		if (soc_int > 31)
-			return -EINVAL;
-
-		cpu_ictl =3D of_find_node_by_phandle(be32_to_cpup(imap + 1));
-		if (!cpu_ictl)
-			return -EINVAL;
-		ret =3D of_property_read_u32(cpu_ictl, "#interrupt-cells", &tmp);
-		of_node_put(cpu_ictl);
-		if (ret || tmp !=3D 1)
-			return -EINVAL;
-
-		cpu_int =3D be32_to_cpup(imap + 2);
-		if (cpu_int > 7 || cpu_int < 2)
-			return -EINVAL;
-
-		if (!(mips_irqs_set & BIT(cpu_int))) {
-			irq_set_chained_handler_and_data(cpu_int, realtek_irq_dispatch,
-							 domain);
-			mips_irqs_set |=3D BIT(cpu_int);
-		}
-
-		/* Use routing values (1..6) for CPU interrupts (2..7) */
-		regs[(soc_int * 4) / 32] |=3D (cpu_int - 1) << (soc_int * 4) % 32;
-		imap +=3D 3;
-	}
-
-	for (i =3D 0; i < 4; i++)
-		writel(regs[i], REG(irr_regs[i]));
-
-	return 0;
-}
-
 static int __init realtek_rtl_of_init(struct device_node *node, struct devic=
e_node *parent)
 {
+	struct of_phandle_args oirq;
 	struct irq_domain *domain;
-	int ret;
+	unsigned int soc_irq;
+	int parent_irq;
=20
 	realtek_ictl_base =3D of_iomap(node, 0);
 	if (!realtek_ictl_base)
 		return -ENXIO;
=20
-	/* Disable all cascaded interrupts */
+	/* Disable all cascaded interrupts and clear routing */
 	writel(0, REG(RTL_ICTL_GIMR));
+	for (soc_irq =3D 0; soc_irq < RTL_ICTL_NUM_INPUTS; soc_irq++)
+		write_irr(REG(RTL_ICTL_IRR0), soc_irq, 0);
+
+	if (WARN_ON(!of_irq_count(node))) {
+		/*
+		 * If DT contains no parent interrupts, assume MIPS CPU IRQ 2
+		 * (HW0) is connected to the first output. This is the case for
+		 * all known hardware anyway. "interrupt-map" is deprecated, so
+		 * don't bother trying to parse that.
+		 */
+		oirq.np =3D of_find_compatible_node(NULL, NULL, "mti,cpu-interrupt-control=
ler");
+		oirq.args_count =3D 1;
+		oirq.args[0] =3D 2;
+
+		parent_irq =3D irq_create_of_mapping(&oirq);
+
+		of_node_put(oirq.np);
+	} else {
+		parent_irq =3D of_irq_get(node, 0);
+	}
=20
-	domain =3D irq_domain_add_simple(node, 32, 0,
-				       &irq_domain_ops, NULL);
+	if (parent_irq < 0)
+		return parent_irq;
+	else if (!parent_irq)
+		return -ENODEV;
=20
-	ret =3D map_interrupts(node, domain);
-	if (ret) {
-		pr_err("invalid interrupt map\n");
-		return ret;
-	}
+	domain =3D irq_domain_add_linear(node, RTL_ICTL_NUM_INPUTS, &irq_domain_ops=
, NULL);
+	if (!domain)
+		return -ENOMEM;
+
+	irq_set_chained_handler_and_data(parent_irq, realtek_irq_dispatch, domain);
=20
 	return 0;
 }
diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 4691a33bc374..4ed2b4ba9568 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -639,7 +639,7 @@ static bool do_amd_gpio_irq_handler(int irq, void *dev_id)
 			if (!(regval & PIN_IRQ_PENDING) ||
 			    !(regval & BIT(INTERRUPT_MASK_OFF)))
 				continue;
-			generic_handle_domain_irq(gc->irq.domain, irqnr + i);
+			generic_handle_domain_irq_safe(gc->irq.domain, irqnr + i);
=20
 			/* Clear interrupt.
 			 * We must read the pin register again, in case the
diff --git a/drivers/platform/x86/intel/int0002_vgpio.c b/drivers/platform/x8=
6/intel/int0002_vgpio.c
index 617dbf98980e..97cfbc520a02 100644
--- a/drivers/platform/x86/intel/int0002_vgpio.c
+++ b/drivers/platform/x86/intel/int0002_vgpio.c
@@ -125,8 +125,7 @@ static irqreturn_t int0002_irq(int irq, void *data)
 	if (!(gpe_sts_reg & GPE0A_PME_B0_STS_BIT))
 		return IRQ_NONE;
=20
-	generic_handle_irq(irq_find_mapping(chip->irq.domain,
-					    GPE0A_PME_B0_VIRT_GPIO_PIN));
+	generic_handle_domain_irq_safe(chip->irq.domain, GPE0A_PME_B0_VIRT_GPIO_PIN=
);
=20
 	pm_wakeup_hard_event(chip->parent);
=20
diff --git a/drivers/ssb/driver_gpio.c b/drivers/ssb/driver_gpio.c
index 2de3896489c8..897cb8db5084 100644
--- a/drivers/ssb/driver_gpio.c
+++ b/drivers/ssb/driver_gpio.c
@@ -132,7 +132,8 @@ static irqreturn_t ssb_gpio_irq_chipco_handler(int irq, v=
oid *dev_id)
 		return IRQ_NONE;
=20
 	for_each_set_bit(gpio, &irqs, bus->gpio.ngpio)
-		generic_handle_irq(ssb_gpio_to_irq(&bus->gpio, gpio));
+		generic_handle_domain_irq_safe(bus->irq_domain, gpio);
+
 	ssb_chipco_gpio_polarity(chipco, irqs, val & irqs);
=20
 	return IRQ_HANDLED;
@@ -330,7 +331,8 @@ static irqreturn_t ssb_gpio_irq_extif_handler(int irq, vo=
id *dev_id)
 		return IRQ_NONE;
=20
 	for_each_set_bit(gpio, &irqs, bus->gpio.ngpio)
-		generic_handle_irq(ssb_gpio_to_irq(&bus->gpio, gpio));
+		generic_handle_domain_irq_safe(bus->irq_domain, gpio);
+
 	ssb_extif_gpio_polarity(extif, irqs, val & irqs);
=20
 	return IRQ_HANDLED;
diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
index 3a091d0710ae..d5e6024cb2a8 100644
--- a/include/linux/irqchip.h
+++ b/include/linux/irqchip.h
@@ -44,7 +44,8 @@ static const struct of_device_id drv_name##_irqchip_match_t=
able[] =3D {
 #define IRQCHIP_MATCH(compat, fn) { .compatible =3D compat,		\
 				    .data =3D typecheck_irq_init_cb(fn), },
=20
-#define IRQCHIP_PLATFORM_DRIVER_END(drv_name)				\
+
+#define IRQCHIP_PLATFORM_DRIVER_END(drv_name, ...)			\
 	{},								\
 };									\
 MODULE_DEVICE_TABLE(of, drv_name##_irqchip_match_table);		\
@@ -56,6 +57,7 @@ static struct platform_driver drv_name##_driver =3D {			\
 		.owner =3D THIS_MODULE,					\
 		.of_match_table =3D drv_name##_irqchip_match_table,	\
 		.suppress_bind_attrs =3D true,				\
+		__VA_ARGS__						\
 	},								\
 };									\
 builtin_platform_driver(drv_name##_driver)
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 1cd4e36890fb..844a8e30e6de 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -169,6 +169,7 @@ int generic_handle_irq_safe(unsigned int irq);
  * conversion failed.
  */
 int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq);
+int generic_handle_domain_irq_safe(struct irq_domain *domain, unsigned int h=
wirq);
 int generic_handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq);
 #endif
=20
diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
index 83fccd0c9bba..d6d3eae2f145 100644
--- a/include/linux/of_irq.h
+++ b/include/linux/of_irq.h
@@ -37,9 +37,8 @@ extern unsigned int irq_create_of_mapping(struct of_phandle=
_args *irq_data);
 extern int of_irq_to_resource(struct device_node *dev, int index,
 			      struct resource *r);
=20
-extern void of_irq_init(const struct of_device_id *matches);
-
 #ifdef CONFIG_OF_IRQ
+extern void of_irq_init(const struct of_device_id *matches);
 extern int of_irq_parse_one(struct device_node *device, int index,
 			  struct of_phandle_args *out_irq);
 extern int of_irq_count(struct device_node *dev);
@@ -57,6 +56,9 @@ extern struct irq_domain *of_msi_map_get_device_domain(stru=
ct device *dev,
 extern void of_msi_configure(struct device *dev, struct device_node *np);
 u32 of_msi_map_id(struct device *dev, struct device_node *msi_np, u32 id_in);
 #else
+static inline void of_irq_init(const struct of_device_id *matches)
+{
+}
 static inline int of_irq_parse_one(struct device_node *device, int index,
 				   struct of_phandle_args *out_irq)
 {
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 5db0230aa6b5..a91f9001103c 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -705,6 +705,30 @@ int generic_handle_domain_irq(struct irq_domain *domain,=
 unsigned int hwirq)
 }
 EXPORT_SYMBOL_GPL(generic_handle_domain_irq);
=20
+ /**
+ * generic_handle_irq_safe - Invoke the handler for a HW irq belonging
+ *			     to a domain from any context.
+ * @domain:	The domain where to perform the lookup
+ * @hwirq:	The HW irq number to convert to a logical one
+ *
+ * Returns:	0 on success, a negative value on error.
+ *
+ * This function can be called from any context (IRQ or process
+ * context). If the interrupt is marked as 'enforce IRQ-context only' then
+ * the function must be invoked from hard interrupt context.
+ */
+int generic_handle_domain_irq_safe(struct irq_domain *domain, unsigned int h=
wirq)
+{
+	unsigned long flags;
+	int ret;
+
+	local_irq_save(flags);
+	ret =3D handle_irq_desc(irq_resolve_mapping(domain, hwirq));
+	local_irq_restore(flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(generic_handle_domain_irq_safe);
+
 /**
  * generic_handle_domain_nmi - Invoke the handler for a HW nmi belonging
  *                             to a domain.

