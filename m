Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFE2649BB5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 11:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbiLLKJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 05:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiLLKJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 05:09:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDA3DFBD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:09:06 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670839745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=uplw0TRjTn5PPgMEhbdCdGuVdN3egN8WLUvIC33V3g4=;
        b=QVzKTcJZkVMP2j0AYQJoFheDdSTkelorxjP5jGOxihH7ITKQOUMtBFUcTc2r5g8p7P3tpC
        ypX6nU2c91ENfhUgwiJtakpAEDCimcQo+LiwBcM6Pob5+fEeuooNWUgOy2rrBCGn0O3Te4
        CbEVtghF/P9gV/sWNy7E924uXkdLv782/OIs2J6d62s6he3Y3Gdo641PNzosgSIrSMc6Kt
        HNY38zth9Qg9HDxoXBmsOEj6d0SU6sasBTKuOUW2Nx9y8z9g9+tNdgRt3N8Vnt7JZTC+4K
        Tk2wtAD/vxqJmk3qUWM6Hv6jUs9iI0pzuaXgH5A4Ry0O+E4fSGE00td2+dBXIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670839745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=uplw0TRjTn5PPgMEhbdCdGuVdN3egN8WLUvIC33V3g4=;
        b=yKHg7XTlCHD7S8woEI22tosy+O7hEYqynESRK8shOD9eGWz8LEhBzJRJMIyoGWhK4kT2Ag
        9mU5Pprosj3v0PBg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/apic for v6.2-rc1
References: <167083907785.564878.11381307641454805335.tglx@xen13.tec.linutronix.de>
Message-ID: <167083908411.564878.10748979729911169682.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 12 Dec 2022 11:09:05 +0100 (CET)
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URI_DOTEDU autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/apic branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-2022-12=
-10

up to:  283327556875: x86/of: Add support for boot time interrupt delivery mo=
de configuration

A set of changes for the x86 APIC code:

  - Handle the case where x2APIC is enabled and locked by the BIOS on a
    kernel with CONFIG_X86_X2APIC=3Dn gracefully. Instead of a panic which
    does not make it to the graphical console during very early boot,
    simply disable the local APIC completely and boot with the PIC and very
    limited functionality, which allows to diagnose the issue.

  - Convert x86 APIC device tree bindings to YAML

  - Extend x86 APIC device tree bindings to configure interrupt delivery
    mode and handle this in during init. This allows to boot with device
    tree on platforms which lack a legacy PIC.

Thanks,

	tglx

------------------>
Andy Shevchenko (1):
      x86/of: Remove unused early_init_dt_add_memory_arch()

Mateusz Jo=C5=84czyk (1):
      x86/apic: Handle no CONFIG_X86_X2APIC on systems with x2APIC enabled by=
 BIOS

Rahul Tanwar (4):
      dt-bindings: x86: apic: Convert Intel's APIC bindings to YAML schema
      dt-bindings: x86: apic: Introduce new optional bool property for lapic
      x86/of: Replace printk(KERN_LVL) with pr_lvl()
      x86/of: Add support for boot time interrupt delivery mode configuration


 .../interrupt-controller/intel,ce4100-ioapic.txt   | 26 --------
 .../interrupt-controller/intel,ce4100-ioapic.yaml  | 60 ++++++++++++++++++
 .../interrupt-controller/intel,ce4100-lapic.yaml   | 71 ++++++++++++++++++++=
++
 arch/x86/Kconfig                                   |  4 +-
 arch/x86/include/asm/apic.h                        |  3 +-
 arch/x86/kernel/apic/apic.c                        | 13 ++--
 arch/x86/kernel/devicetree.c                       | 18 +++---
 7 files changed, 152 insertions(+), 43 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/in=
tel,ce4100-ioapic.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/in=
tel,ce4100-ioapic.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/in=
tel,ce4100-lapic.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/intel,ce4=
100-ioapic.txt b/Documentation/devicetree/bindings/interrupt-controller/intel=
,ce4100-ioapic.txt
deleted file mode 100644
index 7d19f494f19a..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioa=
pic.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Interrupt chips
----------------
-
-* Intel I/O Advanced Programmable Interrupt Controller (IO APIC)
-
-  Required properties:
-  --------------------
-     compatible =3D "intel,ce4100-ioapic";
-     #interrupt-cells =3D <2>;
-
-  Device's interrupt property:
-
-     interrupts =3D <P S>;
-
-  The first number (P) represents the interrupt pin which is wired to the
-  IO APIC. The second number (S) represents the sense of interrupt which
-  should be configured and can be one of:
-    0 - Edge Rising
-    1 - Level Low
-    2 - Level High
-    3 - Edge Falling
-
-* Local APIC
-  Required property:
-
-     compatible =3D "intel,ce4100-lapic";
diff --git a/Documentation/devicetree/bindings/interrupt-controller/intel,ce4=
100-ioapic.yaml b/Documentation/devicetree/bindings/interrupt-controller/inte=
l,ce4100-ioapic.yaml
new file mode 100644
index 000000000000..39ab8cdd19b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioa=
pic.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/interrupt-controller/intel,ce4100-ioapic=
.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Intel I/O Advanced Programmable Interrupt Controller (IO APIC)
+
+maintainers:
+  - Rahul Tanwar <rtanwar@maxlinear.com>
+
+description: |
+  Intel's Advanced Programmable Interrupt Controller (APIC) is a
+  family of interrupt controllers. The APIC is a split
+  architecture design, with a local component (LAPIC) integrated
+  into the processor itself and an external I/O APIC. Local APIC
+  (lapic) receives interrupts from the processor's interrupt pins,
+  from internal sources and from an external I/O APIC (ioapic).
+  And it sends these to the processor core for handling.
+  See [1] Chapter 8 for more details.
+
+  Many of the Intel's generic devices like hpet, ioapic, lapic have
+  the ce4100 name in their compatible property names because they
+  first appeared in CE4100 SoC.
+
+  This schema defines bindings for I/O APIC interrupt controller.
+
+  [1] https://pdos.csail.mit.edu/6.828/2008/readings/ia32/IA32-3A.pdf
+
+properties:
+  compatible:
+    const: intel,ce4100-ioapic
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    ioapic1: interrupt-controller@fec00000 {
+        compatible =3D "intel,ce4100-ioapic";
+        reg =3D <0xfec00000 0x1000>;
+        interrupt-controller;
+        #interrupt-cells =3D <2>;
+    };
diff --git a/Documentation/devicetree/bindings/interrupt-controller/intel,ce4=
100-lapic.yaml b/Documentation/devicetree/bindings/interrupt-controller/intel=
,ce4100-lapic.yaml
new file mode 100644
index 000000000000..d2d0145cb889
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-lap=
ic.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/interrupt-controller/intel,ce4100-lapic.=
yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Intel Local Advanced Programmable Interrupt Controller (LAPIC)
+
+maintainers:
+  - Rahul Tanwar <rtanwar@maxlinear.com>
+
+description: |
+  Intel's Advanced Programmable Interrupt Controller (APIC) is a
+  family of interrupt controllers. The APIC is a split
+  architecture design, with a local component (LAPIC) integrated
+  into the processor itself and an external I/O APIC. Local APIC
+  (lapic) receives interrupts from the processor's interrupt pins,
+  from internal sources and from an external I/O APIC (ioapic).
+  And it sends these to the processor core for handling.
+  See [1] Chapter 8 for more details.
+
+  Many of the Intel's generic devices like hpet, ioapic, lapic have
+  the ce4100 name in their compatible property names because they
+  first appeared in CE4100 SoC.
+
+  This schema defines bindings for local APIC interrupt controller.
+
+  [1] https://pdos.csail.mit.edu/6.828/2008/readings/ia32/IA32-3A.pdf
+
+properties:
+  compatible:
+    const: intel,ce4100-lapic
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+
+  intel,virtual-wire-mode:
+    description: Intel defines a few possible interrupt delivery
+      modes. With respect to boot/init time, mainly two interrupt
+      delivery modes are possible.
+      PIC Mode - Legacy external 8259 compliant PIC interrupt controller.
+      Virtual Wire Mode - use lapic as virtual wire interrupt delivery mode.
+      For ACPI or MPS spec compliant systems, it is figured out by some read
+      only bit field/s available in their respective defined data structures.
+      For OF based systems, it is by default set to PIC mode.
+      But if this optional boolean property is set, then the interrupt deliv=
ery
+      mode is configured to virtual wire compatibility mode.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    lapic0: interrupt-controller@fee00000 {
+        compatible =3D "intel,ce4100-lapic";
+        reg =3D <0xfee00000 0x1000>;
+        interrupt-controller;
+        #interrupt-cells =3D <2>;
+        intel,virtual-wire-mode;
+    };
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 67745ceab0db..b2c0fce3f257 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -462,8 +462,8 @@ config X86_X2APIC
=20
 	  Some Intel systems circa 2022 and later are locked into x2APIC mode
 	  and can not fall back to the legacy APIC modes if SGX or TDX are
-	  enabled in the BIOS.  They will be unable to boot without enabling
-	  this option.
+	  enabled in the BIOS. They will boot with very reduced functionality
+	  without enabling this option.
=20
 	  If you don't know what to do here, say N.
=20
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 3415321c8240..3216da7074ba 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -249,7 +249,6 @@ static inline u64 native_x2apic_icr_read(void)
 extern int x2apic_mode;
 extern int x2apic_phys;
 extern void __init x2apic_set_max_apicid(u32 apicid);
-extern void __init check_x2apic(void);
 extern void x2apic_setup(void);
 static inline int x2apic_enabled(void)
 {
@@ -258,13 +257,13 @@ static inline int x2apic_enabled(void)
=20
 #define x2apic_supported()	(boot_cpu_has(X86_FEATURE_X2APIC))
 #else /* !CONFIG_X86_X2APIC */
-static inline void check_x2apic(void) { }
 static inline void x2apic_setup(void) { }
 static inline int x2apic_enabled(void) { return 0; }
=20
 #define x2apic_mode		(0)
 #define	x2apic_supported()	(0)
 #endif /* !CONFIG_X86_X2APIC */
+extern void __init check_x2apic(void);
=20
 struct irq_data;
=20
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index c6876d3ea4b1..20d9a604da7c 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1931,16 +1931,19 @@ void __init check_x2apic(void)
 	}
 }
 #else /* CONFIG_X86_X2APIC */
-static int __init validate_x2apic(void)
+void __init check_x2apic(void)
 {
 	if (!apic_is_x2apic_enabled())
-		return 0;
+		return;
 	/*
-	 * Checkme: Can we simply turn off x2apic here instead of panic?
+	 * Checkme: Can we simply turn off x2APIC here instead of disabling the API=
C?
 	 */
-	panic("BIOS has enabled x2apic but kernel doesn't support x2apic, please di=
sable x2apic in BIOS.\n");
+	pr_err("Kernel does not support x2APIC, please recompile with CONFIG_X86_X2=
APIC.\n");
+	pr_err("Disabling APIC, expect reduced performance and functionality.\n");
+
+	disable_apic =3D 1;
+	setup_clear_cpu_cap(X86_FEATURE_APIC);
 }
-early_initcall(validate_x2apic);
=20
 static inline void try_to_enable_x2apic(int remap_mode) { }
 static inline void __x2apic_enable(void) { }
diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 5cd51f25f446..28da5dd83fc0 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -31,11 +31,6 @@ char __initdata cmd_line[COMMAND_LINE_SIZE];
=20
 int __initdata of_ioapic;
=20
-void __init early_init_dt_add_memory_arch(u64 base, u64 size)
-{
-	BUG();
-}
-
 void __init add_dtb(u64 data)
 {
 	initial_dtb =3D data + offsetof(struct setup_data, data);
@@ -167,7 +162,14 @@ static void __init dtb_lapic_setup(void)
 			return;
 	}
 	smp_found_config =3D 1;
-	pic_mode =3D 1;
+	if (of_property_read_bool(dn, "intel,virtual-wire-mode")) {
+		pr_info("Virtual Wire compatibility mode.\n");
+		pic_mode =3D 0;
+	} else {
+		pr_info("IMCR and PIC compatibility mode.\n");
+		pic_mode =3D 1;
+	}
+
 	register_lapic_address(lapic_addr);
 }
=20
@@ -248,7 +250,7 @@ static void __init dtb_add_ioapic(struct device_node *dn)
=20
 	ret =3D of_address_to_resource(dn, 0, &r);
 	if (ret) {
-		printk(KERN_ERR "Can't obtain address from device node %pOF.\n", dn);
+		pr_err("Can't obtain address from device node %pOF.\n", dn);
 		return;
 	}
 	mp_register_ioapic(++ioapic_id, r.start, gsi_top, &cfg);
@@ -265,7 +267,7 @@ static void __init dtb_ioapic_setup(void)
 		of_ioapic =3D 1;
 		return;
 	}
-	printk(KERN_ERR "Error: No information about IO-APIC in OF.\n");
+	pr_err("Error: No information about IO-APIC in OF.\n");
 }
 #else
 static void __init dtb_ioapic_setup(void) {}

