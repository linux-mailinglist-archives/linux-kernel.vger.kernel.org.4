Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2EE73DE95
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjFZMOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjFZMNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:13:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A23E58
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:13:50 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687781628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=bGOJAHRnm9mFQcM9R9MThlGzWtoe4SkNn14tbFq7bhA=;
        b=g7NKYdAXxm3nXzctVf1IKakr3f75ebqMPVz4t7pHZGwudQP12nGL4L6SrPRm0IRrR/ciNE
        OZORxe+l2I94uC+TMIvuHk/E/DOuOWjm96OX9Lj+24zIphQx1oDvxQPxAThizly2HNMBab
        VQoqwm4uE9mCySmre5Jzpez5Rtd3GvIS0IajWy1SUk5VbvJf0vX9UkxoBKj7mtu1d7fSY7
        hnQBpP0BGGNFGyVkMSn0dd0qB8IaHrIeOo2FvwhIJhR7cCryKb7XuWfIaGLpVLDNUZzdBK
        fbnce0aahNUtiwkDJfI7/BflMgWHPql6pZigJUgbJIVKSVq4h2kiDfchFcy1Lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687781628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=bGOJAHRnm9mFQcM9R9MThlGzWtoe4SkNn14tbFq7bhA=;
        b=k2uCilVw9BOPbZCPlaD4pmnisftHUJV/YRsrSCEWht6rGEziYd6czvN/mBKUhJbfO/sZx0
        83vmMAYwj3iJzHCw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/core for v6.5-rc1
References: <168778150975.3634408.5562070824299155127.tglx@vps.praguecc.cz>
Message-ID: <168778151111.3634408.15121565787828756774.tglx@vps.praguecc.cz>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 26 Jun 2023 14:13:48 +0200 (CEST)
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

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2023-06=
-26

up to:  f121ab7f4ac3: Merge tag 'irqchip-6.5' of git://git.kernel.org/pub/scm=
/linux/kernel/git/maz/arm-platforms into irq/core


Updates for the interrupt subsystem:

 - Core:

   - Convert the interrupt descriptor storage to a maple tree to overcome
     the limitations of the radixtree + fixed size bitmap. This allows to
     handle real large servers with a huge number of guests without
     imposing a huge memory overhead on everyone.

   - Implement optional retriggering of interrupts which utilize the
     fasteoi handler to work around a GICv3 architecture issue.

 - Drivers:

   - A set of fixes and updates for the Loongson/Loongarch related drivers.

   - Workaound for an ASR8601 integration hickup which ends up with CPU
     numbering which can't be represented in the GIC implementation.

   - The usual set of boring fixes and updates all over the place.


Thanks,

	tglx

------------------>
Antonio Borneo (1):
      irqchip/stm32-exti: Fix warning on initialized field overwritten

Arnd Bergmann (6):
      irqdomain: Include internals.h for function prototypes
      irqchip/ftintc010: Mark all function static
      irqchip/mmp: Remove non-DT codepath
      irqchip/clps711x: Remove unused clps711x_intc_init() function
      irqchip/mxs: Include linux/irqchip/mxs.h
      irqchip/gicv3: Add a iort_pmsi_get_dev_id() prototype

Binbin Zhou (2):
      dt-bindings: interrupt-controller: Add Loongson EIOINTC
      irqchip/loongson-eiointc: Add DT init support

James Gowans (3):
      genirq: Expand doc for PENDING and REPLAY flags
      genirq: Allow fasteoi handler to resend interrupts on concurrent handli=
ng
      irqchip/gic-v3-its: Enable RESEND_WHEN_IN_PROGRESS for LPIs

Jianmin Lv (3):
      irqchip/loongson-pch-pic: Fix initialization of HT vector register
      irqchip/loongson-liointc: Fix IRQ trigger polarity
      irqchip/loongson-eiointc: Fix irq affinity setting during resume

John Paul Adrian Glaubitz (1):
      irqchip/jcore-aic: Fix missing allocation of IRQ descriptors

Liu Peibao (1):
      irqchip/loongson-pch-pic: Fix potential incorrect hwirq assignment

Marc Zyngier (3):
      irqchip/gic-v3: Improve affinity helper
      genirq: Use BIT() for the IRQD_* state flags
      Revert "irqchip/mxs: Include linux/irqchip/mxs.h"

Marek Vasut (1):
      irqchip/stm32-exti: Add STM32MP15xx IWDG2 EXTI to GIC map

Paolo Abeni (1):
      Revert "softirq: Let ksoftirqd do its job"

Shanker Donthineni (3):
      genirq: Use hlist for managing resend handlers
      genirq: Encapsulate sparse bitmap handling
      genirq: Use a maple tree for interrupt descriptor management

Yinbo Zhu (1):
      irqchip/loongson-liointc: Add IRQCHIP_SKIP_SET_WAKE flag

zhengyan (1):
      irqchip/gic-v3: Work around affinity issues on ASR8601


 Documentation/arm64/silicon-errata.rst             |   4 +
 .../interrupt-controller/loongson,eiointc.yaml     |  59 +++++++++
 drivers/irqchip/irq-clps711x.c                     |   7 --
 drivers/irqchip/irq-ftintc010.c                    |   4 +-
 drivers/irqchip/irq-gic-v3-its.c                   |   2 +
 drivers/irqchip/irq-gic-v3.c                       |  45 +++++--
 drivers/irqchip/irq-jcore-aic.c                    |   7 ++
 drivers/irqchip/irq-loongson-eiointc.c             | 135 +++++++++++++++----=
--
 drivers/irqchip/irq-loongson-liointc.c             |  13 +-
 drivers/irqchip/irq-loongson-pch-pic.c             |  10 +-
 drivers/irqchip/irq-mmp.c                          | 127 -------------------
 drivers/irqchip/irq-stm32-exti.c                   |  13 ++
 include/linux/acpi_iort.h                          |   3 +-
 include/linux/irq.h                                |  59 +++++----
 include/linux/irqchip/mmp.h                        |  10 --
 include/linux/irqdesc.h                            |   3 +
 kernel/irq/chip.c                                  |  17 ++-
 kernel/irq/debugfs.c                               |   2 +
 kernel/irq/internals.h                             |  13 +-
 kernel/irq/irqdesc.c                               |  77 +++++++-----
 kernel/irq/irqdomain.c                             |   2 +
 kernel/irq/resend.c                                |  47 ++++---
 kernel/softirq.c                                   |  22 +---
 23 files changed, 384 insertions(+), 297 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/lo=
ongson,eiointc.yaml
 delete mode 100644 include/linux/irqchip/mmp.h

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/sil=
icon-errata.rst
index 9e311bc43e05..d6430ade349d 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -214,3 +214,7 @@ stable kernels.
 +----------------+-----------------+-----------------+----------------------=
-------+
 | Fujitsu        | A64FX           | E#010001        | FUJITSU_ERRATUM_01000=
1      |
 +----------------+-----------------+-----------------+----------------------=
-------+
+
++----------------+-----------------+-----------------+----------------------=
-------+
+| ASR            | ASR8601         | #8601001        | N/A                  =
       |
++----------------+-----------------+-----------------+----------------------=
-------+
diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,=
eiointc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongso=
n,eiointc.yaml
new file mode 100644
index 000000000000..393c128a41d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc=
.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/loongson,eiointc.yam=
l#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson Extended I/O Interrupt Controller
+
+maintainers:
+  - Binbin Zhou <zhoubinbin@loongson.cn>
+
+description: |
+  This interrupt controller is found on the Loongson-3 family chips and
+  Loongson-2K series chips and is used to distribute interrupts directly to
+  individual cores without forwarding them through the HT's interrupt line.
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - loongson,ls2k0500-eiointc
+      - loongson,ls2k2000-eiointc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - '#interrupt-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    eiointc: interrupt-controller@1fe11600 {
+      compatible =3D "loongson,ls2k0500-eiointc";
+      reg =3D <0x1fe10000 0x10000>;
+
+      interrupt-controller;
+      #interrupt-cells =3D <1>;
+
+      interrupt-parent =3D <&cpuintc>;
+      interrupts =3D <3>;
+    };
+
+...
diff --git a/drivers/irqchip/irq-clps711x.c b/drivers/irqchip/irq-clps711x.c
index 77ebe7e47e0e..e731e0784f7e 100644
--- a/drivers/irqchip/irq-clps711x.c
+++ b/drivers/irqchip/irq-clps711x.c
@@ -212,12 +212,6 @@ static int __init _clps711x_intc_init(struct device_node=
 *np,
 	return err;
 }
=20
-void __init clps711x_intc_init(phys_addr_t base, resource_size_t size)
-{
-	BUG_ON(_clps711x_intc_init(NULL, base, size));
-}
-
-#ifdef CONFIG_IRQCHIP
 static int __init clps711x_intc_init_dt(struct device_node *np,
 					struct device_node *parent)
 {
@@ -231,4 +225,3 @@ static int __init clps711x_intc_init_dt(struct device_nod=
e *np,
 	return _clps711x_intc_init(np, res.start, resource_size(&res));
 }
 IRQCHIP_DECLARE(clps711x, "cirrus,ep7209-intc", clps711x_intc_init_dt);
-#endif
diff --git a/drivers/irqchip/irq-ftintc010.c b/drivers/irqchip/irq-ftintc010.c
index 46a3aa60e50e..359efc1d1be7 100644
--- a/drivers/irqchip/irq-ftintc010.c
+++ b/drivers/irqchip/irq-ftintc010.c
@@ -125,7 +125,7 @@ static struct irq_chip ft010_irq_chip =3D {
 /* Local static for the IRQ entry call */
 static struct ft010_irq_data firq;
=20
-asmlinkage void __exception_irq_entry ft010_irqchip_handle_irq(struct pt_reg=
s *regs)
+static asmlinkage void __exception_irq_entry ft010_irqchip_handle_irq(struct=
 pt_regs *regs)
 {
 	struct ft010_irq_data *f =3D &firq;
 	int irq;
@@ -162,7 +162,7 @@ static const struct irq_domain_ops ft010_irqdomain_ops =
=3D {
 	.xlate =3D irq_domain_xlate_onetwocell,
 };
=20
-int __init ft010_of_init_irq(struct device_node *node,
+static int __init ft010_of_init_irq(struct device_node *node,
 			      struct device_node *parent)
 {
 	struct ft010_irq_data *f =3D &firq;
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-it=
s.c
index 0ec2b1e1df75..1994541eaef8 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3585,6 +3585,7 @@ static int its_irq_domain_alloc(struct irq_domain *doma=
in, unsigned int virq,
 		irqd =3D irq_get_irq_data(virq + i);
 		irqd_set_single_target(irqd);
 		irqd_set_affinity_on_activate(irqd);
+		irqd_set_resend_when_in_progress(irqd);
 		pr_debug("ID:%d pID:%d vID:%d\n",
 			 (int)(hwirq + i - its_dev->event_map.lpi_base),
 			 (int)(hwirq + i), virq + i);
@@ -4523,6 +4524,7 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *=
domain, unsigned int virq
 		irq_domain_set_hwirq_and_chip(domain, virq + i, i,
 					      irqchip, vm->vpes[i]);
 		set_bit(i, bitmap);
+		irqd_set_resend_when_in_progress(irq_get_irq_data(virq + i));
 	}
=20
 	if (err) {
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index a605aa79435a..0c6c1af9a5b7 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -40,6 +40,7 @@
 #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
 #define FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539	(1ULL << 1)
 #define FLAGS_WORKAROUND_MTK_GICR_SAVE		(1ULL << 2)
+#define FLAGS_WORKAROUND_ASR_ERRATUM_8601001	(1ULL << 3)
=20
 #define GIC_IRQ_TYPE_PARTITION	(GIC_IRQ_TYPE_LPI + 1)
=20
@@ -656,10 +657,16 @@ static int gic_irq_set_vcpu_affinity(struct irq_data *d=
, void *vcpu)
 	return 0;
 }
=20
-static u64 gic_mpidr_to_affinity(unsigned long mpidr)
+static u64 gic_cpu_to_affinity(int cpu)
 {
+	u64 mpidr =3D cpu_logical_map(cpu);
 	u64 aff;
=20
+	/* ASR8601 needs to have its affinities shifted down... */
+	if (unlikely(gic_data.flags & FLAGS_WORKAROUND_ASR_ERRATUM_8601001))
+		mpidr =3D (MPIDR_AFFINITY_LEVEL(mpidr, 1)	|
+			 (MPIDR_AFFINITY_LEVEL(mpidr, 2) << 8));
+
 	aff =3D ((u64)MPIDR_AFFINITY_LEVEL(mpidr, 3) << 32 |
 	       MPIDR_AFFINITY_LEVEL(mpidr, 2) << 16 |
 	       MPIDR_AFFINITY_LEVEL(mpidr, 1) << 8  |
@@ -914,7 +921,7 @@ static void __init gic_dist_init(void)
 	 * Set all global interrupts to the boot CPU only. ARE must be
 	 * enabled.
 	 */
-	affinity =3D gic_mpidr_to_affinity(cpu_logical_map(smp_processor_id()));
+	affinity =3D gic_cpu_to_affinity(smp_processor_id());
 	for (i =3D 32; i < GIC_LINE_NR; i++)
 		gic_write_irouter(affinity, base + GICD_IROUTER + i * 8);
=20
@@ -963,7 +970,7 @@ static int gic_iterate_rdists(int (*fn)(struct redist_reg=
ion *, void __iomem *))
=20
 static int __gic_populate_rdist(struct redist_region *region, void __iomem *=
ptr)
 {
-	unsigned long mpidr =3D cpu_logical_map(smp_processor_id());
+	unsigned long mpidr;
 	u64 typer;
 	u32 aff;
=20
@@ -971,6 +978,8 @@ static int __gic_populate_rdist(struct redist_region *reg=
ion, void __iomem *ptr)
 	 * Convert affinity to a 32bit value that can be matched to
 	 * GICR_TYPER bits [63:32].
 	 */
+	mpidr =3D gic_cpu_to_affinity(smp_processor_id());
+
 	aff =3D (MPIDR_AFFINITY_LEVEL(mpidr, 3) << 24 |
 	       MPIDR_AFFINITY_LEVEL(mpidr, 2) << 16 |
 	       MPIDR_AFFINITY_LEVEL(mpidr, 1) << 8 |
@@ -1084,7 +1093,7 @@ static inline bool gic_dist_security_disabled(void)
 static void gic_cpu_sys_reg_init(void)
 {
 	int i, cpu =3D smp_processor_id();
-	u64 mpidr =3D cpu_logical_map(cpu);
+	u64 mpidr =3D gic_cpu_to_affinity(cpu);
 	u64 need_rss =3D MPIDR_RS(mpidr);
 	bool group0;
 	u32 pribits;
@@ -1183,11 +1192,11 @@ static void gic_cpu_sys_reg_init(void)
 	for_each_online_cpu(i) {
 		bool have_rss =3D per_cpu(has_rss, i) && per_cpu(has_rss, cpu);
=20
-		need_rss |=3D MPIDR_RS(cpu_logical_map(i));
+		need_rss |=3D MPIDR_RS(gic_cpu_to_affinity(i));
 		if (need_rss && (!have_rss))
 			pr_crit("CPU%d (%lx) can't SGI CPU%d (%lx), no RSS\n",
 				cpu, (unsigned long)mpidr,
-				i, (unsigned long)cpu_logical_map(i));
+				i, (unsigned long)gic_cpu_to_affinity(i));
 	}
=20
 	/**
@@ -1263,9 +1272,11 @@ static u16 gic_compute_target_list(int *base_cpu, cons=
t struct cpumask *mask,
 				   unsigned long cluster_id)
 {
 	int next_cpu, cpu =3D *base_cpu;
-	unsigned long mpidr =3D cpu_logical_map(cpu);
+	unsigned long mpidr;
 	u16 tlist =3D 0;
=20
+	mpidr =3D gic_cpu_to_affinity(cpu);
+
 	while (cpu < nr_cpu_ids) {
 		tlist |=3D 1 << (mpidr & 0xf);
=20
@@ -1274,7 +1285,7 @@ static u16 gic_compute_target_list(int *base_cpu, const=
 struct cpumask *mask,
 			goto out;
 		cpu =3D next_cpu;
=20
-		mpidr =3D cpu_logical_map(cpu);
+		mpidr =3D gic_cpu_to_affinity(cpu);
=20
 		if (cluster_id !=3D MPIDR_TO_SGI_CLUSTER_ID(mpidr)) {
 			cpu--;
@@ -1319,7 +1330,7 @@ static void gic_ipi_send_mask(struct irq_data *d, const=
 struct cpumask *mask)
 	dsb(ishst);
=20
 	for_each_cpu(cpu, mask) {
-		u64 cluster_id =3D MPIDR_TO_SGI_CLUSTER_ID(cpu_logical_map(cpu));
+		u64 cluster_id =3D MPIDR_TO_SGI_CLUSTER_ID(gic_cpu_to_affinity(cpu));
 		u16 tlist;
=20
 		tlist =3D gic_compute_target_list(&cpu, mask, cluster_id);
@@ -1377,7 +1388,7 @@ static int gic_set_affinity(struct irq_data *d, const s=
truct cpumask *mask_val,
=20
 	offset =3D convert_offset_index(d, GICD_IROUTER, &index);
 	reg =3D gic_dist_base(d) + offset + (index * 8);
-	val =3D gic_mpidr_to_affinity(cpu_logical_map(cpu));
+	val =3D gic_cpu_to_affinity(cpu);
=20
 	gic_write_irouter(val, reg);
=20
@@ -1796,12 +1807,26 @@ static bool gic_enable_quirk_nvidia_t241(void *data)
 	return true;
 }
=20
+static bool gic_enable_quirk_asr8601(void *data)
+{
+	struct gic_chip_data *d =3D data;
+
+	d->flags |=3D FLAGS_WORKAROUND_ASR_ERRATUM_8601001;
+
+	return true;
+}
+
 static const struct gic_quirk gic_quirks[] =3D {
 	{
 		.desc	=3D "GICv3: Qualcomm MSM8996 broken firmware",
 		.compatible =3D "qcom,msm8996-gic-v3",
 		.init	=3D gic_enable_quirk_msm8996,
 	},
+	{
+		.desc	=3D "GICv3: ASR erratum 8601001",
+		.compatible =3D "asr,asr8601-gic-v3",
+		.init	=3D gic_enable_quirk_asr8601,
+	},
 	{
 		.desc	=3D "GICv3: Mediatek Chromebook GICR save problem",
 		.property =3D "mediatek,broken-save-restore-fw",
diff --git a/drivers/irqchip/irq-jcore-aic.c b/drivers/irqchip/irq-jcore-aic.c
index 5f47d8ee4ae3..b9dcc8e78c75 100644
--- a/drivers/irqchip/irq-jcore-aic.c
+++ b/drivers/irqchip/irq-jcore-aic.c
@@ -68,6 +68,7 @@ static int __init aic_irq_of_init(struct device_node *node,
 	unsigned min_irq =3D JCORE_AIC2_MIN_HWIRQ;
 	unsigned dom_sz =3D JCORE_AIC_MAX_HWIRQ+1;
 	struct irq_domain *domain;
+	int ret;
=20
 	pr_info("Initializing J-Core AIC\n");
=20
@@ -100,6 +101,12 @@ static int __init aic_irq_of_init(struct device_node *no=
de,
 	jcore_aic.irq_unmask =3D noop;
 	jcore_aic.name =3D "AIC";
=20
+	ret =3D irq_alloc_descs(-1, min_irq, dom_sz - min_irq,
+			      of_node_to_nid(node));
+
+	if (ret < 0)
+		return ret;
+
 	domain =3D irq_domain_add_legacy(node, dom_sz - min_irq, min_irq, min_irq,
 				       &jcore_aic_irqdomain_ops,
 				       &jcore_aic);
diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loo=
ngson-eiointc.c
index 71ef19f77a5a..92d8aa28bdf5 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -36,6 +36,7 @@ static int nr_pics;
=20
 struct eiointc_priv {
 	u32			node;
+	u32			vec_count;
 	nodemask_t		node_map;
 	cpumask_t		cpuspan_map;
 	struct fwnode_handle	*domain_handle;
@@ -153,18 +154,18 @@ static int eiointc_router_init(unsigned int cpu)
 	if ((cpu_logical_map(cpu) % CORES_PER_EIO_NODE) =3D=3D 0) {
 		eiointc_enable();
=20
-		for (i =3D 0; i < VEC_COUNT / 32; i++) {
+		for (i =3D 0; i < eiointc_priv[0]->vec_count / 32; i++) {
 			data =3D (((1 << (i * 2 + 1)) << 16) | (1 << (i * 2)));
 			iocsr_write32(data, EIOINTC_REG_NODEMAP + i * 4);
 		}
=20
-		for (i =3D 0; i < VEC_COUNT / 32 / 4; i++) {
+		for (i =3D 0; i < eiointc_priv[0]->vec_count / 32 / 4; i++) {
 			bit =3D BIT(1 + index); /* Route to IP[1 + index] */
 			data =3D bit | (bit << 8) | (bit << 16) | (bit << 24);
 			iocsr_write32(data, EIOINTC_REG_IPMAP + i * 4);
 		}
=20
-		for (i =3D 0; i < VEC_COUNT / 4; i++) {
+		for (i =3D 0; i < eiointc_priv[0]->vec_count / 4; i++) {
 			/* Route to Node-0 Core-0 */
 			if (index =3D=3D 0)
 				bit =3D BIT(cpu_logical_map(0));
@@ -175,7 +176,7 @@ static int eiointc_router_init(unsigned int cpu)
 			iocsr_write32(data, EIOINTC_REG_ROUTE + i * 4);
 		}
=20
-		for (i =3D 0; i < VEC_COUNT / 32; i++) {
+		for (i =3D 0; i < eiointc_priv[0]->vec_count / 32; i++) {
 			data =3D 0xffffffff;
 			iocsr_write32(data, EIOINTC_REG_ENABLE + i * 4);
 			iocsr_write32(data, EIOINTC_REG_BOUNCE + i * 4);
@@ -195,7 +196,7 @@ static void eiointc_irq_dispatch(struct irq_desc *desc)
=20
 	chained_irq_enter(chip, desc);
=20
-	for (i =3D 0; i < VEC_REG_COUNT; i++) {
+	for (i =3D 0; i < eiointc_priv[0]->vec_count / VEC_COUNT_PER_REG; i++) {
 		pending =3D iocsr_read64(EIOINTC_REG_ISR + (i << 3));
 		iocsr_write64(pending, EIOINTC_REG_ISR + (i << 3));
 		while (pending) {
@@ -310,11 +311,11 @@ static void eiointc_resume(void)
 	eiointc_router_init(0);
=20
 	for (i =3D 0; i < nr_pics; i++) {
-		for (j =3D 0; j < VEC_COUNT; j++) {
+		for (j =3D 0; j < eiointc_priv[0]->vec_count; j++) {
 			desc =3D irq_resolve_mapping(eiointc_priv[i]->eiointc_domain, j);
 			if (desc && desc->handle_irq && desc->handle_irq !=3D handle_bad_irq) {
 				raw_spin_lock(&desc->lock);
-				irq_data =3D &desc->irq_data;
+				irq_data =3D irq_domain_get_irq_data(eiointc_priv[i]->eiointc_domain, ir=
q_desc_get_irq(desc));
 				eiointc_set_irq_affinity(irq_data, irq_data->common->affinity, 0);
 				raw_spin_unlock(&desc->lock);
 			}
@@ -375,11 +376,47 @@ static int __init acpi_cascade_irqdomain_init(void)
 	return 0;
 }
=20
+static int __init eiointc_init(struct eiointc_priv *priv, int parent_irq,
+			       u64 node_map)
+{
+	int i;
+
+	node_map =3D node_map ? node_map : -1ULL;
+	for_each_possible_cpu(i) {
+		if (node_map & (1ULL << (cpu_to_eio_node(i)))) {
+			node_set(cpu_to_eio_node(i), priv->node_map);
+			cpumask_or(&priv->cpuspan_map, &priv->cpuspan_map,
+				   cpumask_of(i));
+		}
+	}
+
+	priv->eiointc_domain =3D irq_domain_create_linear(priv->domain_handle,
+							priv->vec_count,
+							&eiointc_domain_ops,
+							priv);
+	if (!priv->eiointc_domain) {
+		pr_err("loongson-extioi: cannot add IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	eiointc_priv[nr_pics++] =3D priv;
+	eiointc_router_init(0);
+	irq_set_chained_handler_and_data(parent_irq, eiointc_irq_dispatch, priv);
+
+	if (nr_pics =3D=3D 1) {
+		register_syscore_ops(&eiointc_syscore_ops);
+		cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_LOONGARCH_STARTING,
+					  "irqchip/loongarch/intc:starting",
+					  eiointc_router_init, NULL);
+	}
+
+	return 0;
+}
+
 int __init eiointc_acpi_init(struct irq_domain *parent,
 				     struct acpi_madt_eio_pic *acpi_eiointc)
 {
-	int i, ret, parent_irq;
-	unsigned long node_map;
+	int parent_irq, ret;
 	struct eiointc_priv *priv;
 	int node;
=20
@@ -394,37 +431,14 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
 		goto out_free_priv;
 	}
=20
+	priv->vec_count =3D VEC_COUNT;
 	priv->node =3D acpi_eiointc->node;
-	node_map =3D acpi_eiointc->node_map ? : -1ULL;
-
-	for_each_possible_cpu(i) {
-		if (node_map & (1ULL << cpu_to_eio_node(i))) {
-			node_set(cpu_to_eio_node(i), priv->node_map);
-			cpumask_or(&priv->cpuspan_map, &priv->cpuspan_map, cpumask_of(i));
-		}
-	}
-
-	/* Setup IRQ domain */
-	priv->eiointc_domain =3D irq_domain_create_linear(priv->domain_handle, VEC_=
COUNT,
-					&eiointc_domain_ops, priv);
-	if (!priv->eiointc_domain) {
-		pr_err("loongson-eiointc: cannot add IRQ domain\n");
-		goto out_free_handle;
-	}
-
-	eiointc_priv[nr_pics++] =3D priv;
-
-	eiointc_router_init(0);
=20
 	parent_irq =3D irq_create_mapping(parent, acpi_eiointc->cascade);
-	irq_set_chained_handler_and_data(parent_irq, eiointc_irq_dispatch, priv);
=20
-	if (nr_pics =3D=3D 1) {
-		register_syscore_ops(&eiointc_syscore_ops);
-		cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_LOONGARCH_STARTING,
-				  "irqchip/loongarch/intc:starting",
-				  eiointc_router_init, NULL);
-	}
+	ret =3D eiointc_init(priv, parent_irq, acpi_eiointc->node_map);
+	if (ret < 0)
+		goto out_free_handle;
=20
 	if (cpu_has_flatmode)
 		node =3D cpu_to_node(acpi_eiointc->node * CORES_PER_EIO_NODE);
@@ -432,7 +446,10 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
 		node =3D acpi_eiointc->node;
 	acpi_set_vec_parent(node, priv->eiointc_domain, pch_group);
 	acpi_set_vec_parent(node, priv->eiointc_domain, msi_group);
+
 	ret =3D acpi_cascade_irqdomain_init();
+	if (ret < 0)
+		goto out_free_handle;
=20
 	return ret;
=20
@@ -444,3 +461,49 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
=20
 	return -ENOMEM;
 }
+
+static int __init eiointc_of_init(struct device_node *of_node,
+				  struct device_node *parent)
+{
+	int parent_irq, ret;
+	struct eiointc_priv *priv;
+
+	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	parent_irq =3D irq_of_parse_and_map(of_node, 0);
+	if (parent_irq <=3D 0) {
+		ret =3D -ENODEV;
+		goto out_free_priv;
+	}
+
+	ret =3D irq_set_handler_data(parent_irq, priv);
+	if (ret < 0)
+		goto out_free_priv;
+
+	/*
+	 * In particular, the number of devices supported by the LS2K0500
+	 * extended I/O interrupt vector is 128.
+	 */
+	if (of_device_is_compatible(of_node, "loongson,ls2k0500-eiointc"))
+		priv->vec_count =3D 128;
+	else
+		priv->vec_count =3D VEC_COUNT;
+
+	priv->node =3D 0;
+	priv->domain_handle =3D of_node_to_fwnode(of_node);
+
+	ret =3D eiointc_init(priv, parent_irq, 0);
+	if (ret < 0)
+		goto out_free_priv;
+
+	return 0;
+
+out_free_priv:
+	kfree(priv);
+	return ret;
+}
+
+IRQCHIP_DECLARE(loongson_ls2k0500_eiointc, "loongson,ls2k0500-eiointc", eioi=
ntc_of_init);
+IRQCHIP_DECLARE(loongson_ls2k2000_eiointc, "loongson,ls2k2000-eiointc", eioi=
ntc_of_init);
diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loo=
ngson-liointc.c
index 8d00a9ad5b00..e4b33aed1c97 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -32,6 +32,10 @@
 #define LIOINTC_REG_INTC_EN_STATUS	(LIOINTC_INTC_CHIP_START + 0x04)
 #define LIOINTC_REG_INTC_ENABLE	(LIOINTC_INTC_CHIP_START + 0x08)
 #define LIOINTC_REG_INTC_DISABLE	(LIOINTC_INTC_CHIP_START + 0x0c)
+/*
+ * LIOINTC_REG_INTC_POL register is only valid for Loongson-2K series, and
+ * Loongson-3 series behave as noops.
+ */
 #define LIOINTC_REG_INTC_POL	(LIOINTC_INTC_CHIP_START + 0x10)
 #define LIOINTC_REG_INTC_EDGE	(LIOINTC_INTC_CHIP_START + 0x14)
=20
@@ -116,19 +120,19 @@ static int liointc_set_type(struct irq_data *data, unsi=
gned int type)
 	switch (type) {
 	case IRQ_TYPE_LEVEL_HIGH:
 		liointc_set_bit(gc, LIOINTC_REG_INTC_EDGE, mask, false);
-		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, true);
+		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, false);
 		break;
 	case IRQ_TYPE_LEVEL_LOW:
 		liointc_set_bit(gc, LIOINTC_REG_INTC_EDGE, mask, false);
-		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, false);
+		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, true);
 		break;
 	case IRQ_TYPE_EDGE_RISING:
 		liointc_set_bit(gc, LIOINTC_REG_INTC_EDGE, mask, true);
-		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, true);
+		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, false);
 		break;
 	case IRQ_TYPE_EDGE_FALLING:
 		liointc_set_bit(gc, LIOINTC_REG_INTC_EDGE, mask, true);
-		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, false);
+		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, true);
 		break;
 	default:
 		irq_gc_unlock_irqrestore(gc, flags);
@@ -291,6 +295,7 @@ static int liointc_init(phys_addr_t addr, unsigned long s=
ize, int revision,
 	ct->chip.irq_mask =3D irq_gc_mask_disable_reg;
 	ct->chip.irq_mask_ack =3D irq_gc_mask_disable_reg;
 	ct->chip.irq_set_type =3D liointc_set_type;
+	ct->chip.flags =3D IRQCHIP_SKIP_SET_WAKE;
=20
 	gc->mask_cache =3D 0;
 	priv->gc =3D gc;
diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loo=
ngson-pch-pic.c
index e5fe4d50be05..93a71f66efeb 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -164,7 +164,7 @@ static int pch_pic_domain_translate(struct irq_domain *d,
 		if (fwspec->param_count < 2)
 			return -EINVAL;
=20
-		*hwirq =3D fwspec->param[0] + priv->ht_vec_base;
+		*hwirq =3D fwspec->param[0];
 		*type =3D fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
 	} else {
 		if (fwspec->param_count < 1)
@@ -196,7 +196,7 @@ static int pch_pic_alloc(struct irq_domain *domain, unsig=
ned int virq,
=20
 	parent_fwspec.fwnode =3D domain->parent->fwnode;
 	parent_fwspec.param_count =3D 1;
-	parent_fwspec.param[0] =3D hwirq;
+	parent_fwspec.param[0] =3D hwirq + priv->ht_vec_base;
=20
 	err =3D irq_domain_alloc_irqs_parent(domain, virq, 1, &parent_fwspec);
 	if (err)
@@ -401,14 +401,12 @@ static int __init acpi_cascade_irqdomain_init(void)
 int __init pch_pic_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_bio_pic *acpi_pchpic)
 {
-	int ret, vec_base;
+	int ret;
 	struct fwnode_handle *domain_handle;
=20
 	if (find_pch_pic(acpi_pchpic->gsi_base) >=3D 0)
 		return 0;
=20
-	vec_base =3D acpi_pchpic->gsi_base - GSI_MIN_PCH_IRQ;
-
 	domain_handle =3D irq_domain_alloc_fwnode(&acpi_pchpic->address);
 	if (!domain_handle) {
 		pr_err("Unable to allocate domain handle\n");
@@ -416,7 +414,7 @@ int __init pch_pic_acpi_init(struct irq_domain *parent,
 	}
=20
 	ret =3D pch_pic_init(acpi_pchpic->address, acpi_pchpic->size,
-				vec_base, parent, domain_handle, acpi_pchpic->gsi_base);
+				0, parent, domain_handle, acpi_pchpic->gsi_base);
=20
 	if (ret < 0) {
 		irq_domain_free_fwnode(domain_handle);
diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index 83455ca72439..25cf4f80e767 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -244,132 +244,6 @@ static void __exception_irq_entry mmp2_handle_irq(struc=
t pt_regs *regs)
 	generic_handle_domain_irq(icu_data[0].domain, hwirq);
 }
=20
-/* MMP (ARMv5) */
-void __init icu_init_irq(void)
-{
-	int irq;
-
-	max_icu_nr =3D 1;
-	mmp_icu_base =3D ioremap(0xd4282000, 0x1000);
-	icu_data[0].conf_enable =3D mmp_conf.conf_enable;
-	icu_data[0].conf_disable =3D mmp_conf.conf_disable;
-	icu_data[0].conf_mask =3D mmp_conf.conf_mask;
-	icu_data[0].nr_irqs =3D 64;
-	icu_data[0].virq_base =3D 0;
-	icu_data[0].domain =3D irq_domain_add_legacy(NULL, 64, 0, 0,
-						   &irq_domain_simple_ops,
-						   &icu_data[0]);
-	for (irq =3D 0; irq < 64; irq++) {
-		icu_mask_irq(irq_get_irq_data(irq));
-		irq_set_chip_and_handler(irq, &icu_irq_chip, handle_level_irq);
-	}
-	irq_set_default_host(icu_data[0].domain);
-	set_handle_irq(mmp_handle_irq);
-}
-
-/* MMP2 (ARMv7) */
-void __init mmp2_init_icu(void)
-{
-	int irq, end;
-
-	max_icu_nr =3D 8;
-	mmp_icu_base =3D ioremap(0xd4282000, 0x1000);
-	icu_data[0].conf_enable =3D mmp2_conf.conf_enable;
-	icu_data[0].conf_disable =3D mmp2_conf.conf_disable;
-	icu_data[0].conf_mask =3D mmp2_conf.conf_mask;
-	icu_data[0].nr_irqs =3D 64;
-	icu_data[0].virq_base =3D 0;
-	icu_data[0].domain =3D irq_domain_add_legacy(NULL, 64, 0, 0,
-						   &irq_domain_simple_ops,
-						   &icu_data[0]);
-	icu_data[1].reg_status =3D mmp_icu_base + 0x150;
-	icu_data[1].reg_mask =3D mmp_icu_base + 0x168;
-	icu_data[1].clr_mfp_irq_base =3D icu_data[0].virq_base +
-				icu_data[0].nr_irqs;
-	icu_data[1].clr_mfp_hwirq =3D 1;		/* offset to IRQ_MMP2_PMIC_BASE */
-	icu_data[1].nr_irqs =3D 2;
-	icu_data[1].cascade_irq =3D 4;
-	icu_data[1].virq_base =3D icu_data[0].virq_base + icu_data[0].nr_irqs;
-	icu_data[1].domain =3D irq_domain_add_legacy(NULL, icu_data[1].nr_irqs,
-						   icu_data[1].virq_base, 0,
-						   &irq_domain_simple_ops,
-						   &icu_data[1]);
-	icu_data[2].reg_status =3D mmp_icu_base + 0x154;
-	icu_data[2].reg_mask =3D mmp_icu_base + 0x16c;
-	icu_data[2].nr_irqs =3D 2;
-	icu_data[2].cascade_irq =3D 5;
-	icu_data[2].virq_base =3D icu_data[1].virq_base + icu_data[1].nr_irqs;
-	icu_data[2].domain =3D irq_domain_add_legacy(NULL, icu_data[2].nr_irqs,
-						   icu_data[2].virq_base, 0,
-						   &irq_domain_simple_ops,
-						   &icu_data[2]);
-	icu_data[3].reg_status =3D mmp_icu_base + 0x180;
-	icu_data[3].reg_mask =3D mmp_icu_base + 0x17c;
-	icu_data[3].nr_irqs =3D 3;
-	icu_data[3].cascade_irq =3D 9;
-	icu_data[3].virq_base =3D icu_data[2].virq_base + icu_data[2].nr_irqs;
-	icu_data[3].domain =3D irq_domain_add_legacy(NULL, icu_data[3].nr_irqs,
-						   icu_data[3].virq_base, 0,
-						   &irq_domain_simple_ops,
-						   &icu_data[3]);
-	icu_data[4].reg_status =3D mmp_icu_base + 0x158;
-	icu_data[4].reg_mask =3D mmp_icu_base + 0x170;
-	icu_data[4].nr_irqs =3D 5;
-	icu_data[4].cascade_irq =3D 17;
-	icu_data[4].virq_base =3D icu_data[3].virq_base + icu_data[3].nr_irqs;
-	icu_data[4].domain =3D irq_domain_add_legacy(NULL, icu_data[4].nr_irqs,
-						   icu_data[4].virq_base, 0,
-						   &irq_domain_simple_ops,
-						   &icu_data[4]);
-	icu_data[5].reg_status =3D mmp_icu_base + 0x15c;
-	icu_data[5].reg_mask =3D mmp_icu_base + 0x174;
-	icu_data[5].nr_irqs =3D 15;
-	icu_data[5].cascade_irq =3D 35;
-	icu_data[5].virq_base =3D icu_data[4].virq_base + icu_data[4].nr_irqs;
-	icu_data[5].domain =3D irq_domain_add_legacy(NULL, icu_data[5].nr_irqs,
-						   icu_data[5].virq_base, 0,
-						   &irq_domain_simple_ops,
-						   &icu_data[5]);
-	icu_data[6].reg_status =3D mmp_icu_base + 0x160;
-	icu_data[6].reg_mask =3D mmp_icu_base + 0x178;
-	icu_data[6].nr_irqs =3D 2;
-	icu_data[6].cascade_irq =3D 51;
-	icu_data[6].virq_base =3D icu_data[5].virq_base + icu_data[5].nr_irqs;
-	icu_data[6].domain =3D irq_domain_add_legacy(NULL, icu_data[6].nr_irqs,
-						   icu_data[6].virq_base, 0,
-						   &irq_domain_simple_ops,
-						   &icu_data[6]);
-	icu_data[7].reg_status =3D mmp_icu_base + 0x188;
-	icu_data[7].reg_mask =3D mmp_icu_base + 0x184;
-	icu_data[7].nr_irqs =3D 2;
-	icu_data[7].cascade_irq =3D 55;
-	icu_data[7].virq_base =3D icu_data[6].virq_base + icu_data[6].nr_irqs;
-	icu_data[7].domain =3D irq_domain_add_legacy(NULL, icu_data[7].nr_irqs,
-						   icu_data[7].virq_base, 0,
-						   &irq_domain_simple_ops,
-						   &icu_data[7]);
-	end =3D icu_data[7].virq_base + icu_data[7].nr_irqs;
-	for (irq =3D 0; irq < end; irq++) {
-		icu_mask_irq(irq_get_irq_data(irq));
-		if (irq =3D=3D icu_data[1].cascade_irq ||
-		    irq =3D=3D icu_data[2].cascade_irq ||
-		    irq =3D=3D icu_data[3].cascade_irq ||
-		    irq =3D=3D icu_data[4].cascade_irq ||
-		    irq =3D=3D icu_data[5].cascade_irq ||
-		    irq =3D=3D icu_data[6].cascade_irq ||
-		    irq =3D=3D icu_data[7].cascade_irq) {
-			irq_set_chip(irq, &icu_irq_chip);
-			irq_set_chained_handler(irq, icu_mux_irq_demux);
-		} else {
-			irq_set_chip_and_handler(irq, &icu_irq_chip,
-						 handle_level_irq);
-		}
-	}
-	irq_set_default_host(icu_data[0].domain);
-	set_handle_irq(mmp2_handle_irq);
-}
-
-#ifdef CONFIG_OF
 static int __init mmp_init_bases(struct device_node *node)
 {
 	int ret, nr_irqs, irq, i =3D 0;
@@ -548,4 +422,3 @@ static int __init mmp2_mux_of_init(struct device_node *no=
de,
 	return -EINVAL;
 }
 IRQCHIP_DECLARE(mmp2_mux_intc, "mrvl,mmp2-mux-intc", mmp2_mux_of_init);
-#endif
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-ext=
i.c
index 6a3f7498ea8e..b5fa76ce5046 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -173,6 +173,16 @@ static struct irq_chip stm32_exti_h_chip_direct;
 #define EXTI_INVALID_IRQ       U8_MAX
 #define STM32MP1_DESC_IRQ_SIZE (ARRAY_SIZE(stm32mp1_exti_banks) * IRQS_PER_B=
ANK)
=20
+/*
+ * Use some intentionally tricky logic here to initialize the whole array to
+ * EXTI_INVALID_IRQ, but then override certain fields, requiring us to indic=
ate
+ * that we "know" that there are overrides in this structure, and we'll need=
 to
+ * disable that warning from W=3D1 builds.
+ */
+__diag_push();
+__diag_ignore_all("-Woverride-init",
+		  "logic to initialize all and then override some is OK");
+
 static const u8 stm32mp1_desc_irq[] =3D {
 	/* default value */
 	[0 ... (STM32MP1_DESC_IRQ_SIZE - 1)] =3D EXTI_INVALID_IRQ,
@@ -208,6 +218,7 @@ static const u8 stm32mp1_desc_irq[] =3D {
 	[31] =3D 53,
 	[32] =3D 82,
 	[33] =3D 83,
+	[46] =3D 151,
 	[47] =3D 93,
 	[48] =3D 138,
 	[50] =3D 139,
@@ -266,6 +277,8 @@ static const u8 stm32mp13_desc_irq[] =3D {
 	[70] =3D 98,
 };
=20
+__diag_pop();
+
 static const struct stm32_exti_drv_data stm32mp1_drv_data =3D {
 	.exti_banks =3D stm32mp1_exti_banks,
 	.bank_nr =3D ARRAY_SIZE(stm32mp1_exti_banks),
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index b43be0987b19..6b70d02bc5f9 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -26,13 +26,14 @@ int iort_register_domain_token(int trans_id, phys_addr_t =
base,
 			       struct fwnode_handle *fw_node);
 void iort_deregister_domain_token(int trans_id);
 struct fwnode_handle *iort_find_domain_token(int trans_id);
+int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
+
 #ifdef CONFIG_ACPI_IORT
 void acpi_iort_init(void);
 u32 iort_msi_map_id(struct device *dev, u32 id);
 struct irq_domain *iort_get_device_domain(struct device *dev, u32 id,
 					  enum irq_domain_bus_token bus_token);
 void acpi_configure_pmsi_domain(struct device *dev);
-int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
 void iort_get_rmr_sids(struct fwnode_handle *iommu_fwnode,
 		       struct list_head *head);
 void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode,
diff --git a/include/linux/irq.h b/include/linux/irq.h
index b1b28affb32a..d8a6fdce9373 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -223,32 +223,35 @@ struct irq_data {
  *				  irq_chip::irq_set_affinity() when deactivated.
  * IRQD_IRQ_ENABLED_ON_SUSPEND	- Interrupt is enabled on suspend by irq pm if
  *				  irqchip have flag IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND set.
+ * IRQD_RESEND_WHEN_IN_PROGRESS	- Interrupt may fire when already in progres=
s in which
+ *				  case it must be resent at the next available opportunity.
  */
 enum {
 	IRQD_TRIGGER_MASK		=3D 0xf,
-	IRQD_SETAFFINITY_PENDING	=3D (1 <<  8),
-	IRQD_ACTIVATED			=3D (1 <<  9),
-	IRQD_NO_BALANCING		=3D (1 << 10),
-	IRQD_PER_CPU			=3D (1 << 11),
-	IRQD_AFFINITY_SET		=3D (1 << 12),
-	IRQD_LEVEL			=3D (1 << 13),
-	IRQD_WAKEUP_STATE		=3D (1 << 14),
-	IRQD_MOVE_PCNTXT		=3D (1 << 15),
-	IRQD_IRQ_DISABLED		=3D (1 << 16),
-	IRQD_IRQ_MASKED			=3D (1 << 17),
-	IRQD_IRQ_INPROGRESS		=3D (1 << 18),
-	IRQD_WAKEUP_ARMED		=3D (1 << 19),
-	IRQD_FORWARDED_TO_VCPU		=3D (1 << 20),
-	IRQD_AFFINITY_MANAGED		=3D (1 << 21),
-	IRQD_IRQ_STARTED		=3D (1 << 22),
-	IRQD_MANAGED_SHUTDOWN		=3D (1 << 23),
-	IRQD_SINGLE_TARGET		=3D (1 << 24),
-	IRQD_DEFAULT_TRIGGER_SET	=3D (1 << 25),
-	IRQD_CAN_RESERVE		=3D (1 << 26),
-	IRQD_MSI_NOMASK_QUIRK		=3D (1 << 27),
-	IRQD_HANDLE_ENFORCE_IRQCTX	=3D (1 << 28),
-	IRQD_AFFINITY_ON_ACTIVATE	=3D (1 << 29),
-	IRQD_IRQ_ENABLED_ON_SUSPEND	=3D (1 << 30),
+	IRQD_SETAFFINITY_PENDING	=3D BIT(8),
+	IRQD_ACTIVATED			=3D BIT(9),
+	IRQD_NO_BALANCING		=3D BIT(10),
+	IRQD_PER_CPU			=3D BIT(11),
+	IRQD_AFFINITY_SET		=3D BIT(12),
+	IRQD_LEVEL			=3D BIT(13),
+	IRQD_WAKEUP_STATE		=3D BIT(14),
+	IRQD_MOVE_PCNTXT		=3D BIT(15),
+	IRQD_IRQ_DISABLED		=3D BIT(16),
+	IRQD_IRQ_MASKED			=3D BIT(17),
+	IRQD_IRQ_INPROGRESS		=3D BIT(18),
+	IRQD_WAKEUP_ARMED		=3D BIT(19),
+	IRQD_FORWARDED_TO_VCPU		=3D BIT(20),
+	IRQD_AFFINITY_MANAGED		=3D BIT(21),
+	IRQD_IRQ_STARTED		=3D BIT(22),
+	IRQD_MANAGED_SHUTDOWN		=3D BIT(23),
+	IRQD_SINGLE_TARGET		=3D BIT(24),
+	IRQD_DEFAULT_TRIGGER_SET	=3D BIT(25),
+	IRQD_CAN_RESERVE		=3D BIT(26),
+	IRQD_MSI_NOMASK_QUIRK		=3D BIT(27),
+	IRQD_HANDLE_ENFORCE_IRQCTX	=3D BIT(28),
+	IRQD_AFFINITY_ON_ACTIVATE	=3D BIT(29),
+	IRQD_IRQ_ENABLED_ON_SUSPEND	=3D BIT(30),
+	IRQD_RESEND_WHEN_IN_PROGRESS    =3D BIT(31),
 };
=20
 #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
@@ -448,6 +451,16 @@ static inline bool irqd_affinity_on_activate(struct irq_=
data *d)
 	return __irqd_to_state(d) & IRQD_AFFINITY_ON_ACTIVATE;
 }
=20
+static inline void irqd_set_resend_when_in_progress(struct irq_data *d)
+{
+	__irqd_to_state(d) |=3D IRQD_RESEND_WHEN_IN_PROGRESS;
+}
+
+static inline bool irqd_needs_resend_when_in_progress(struct irq_data *d)
+{
+	return __irqd_to_state(d) & IRQD_RESEND_WHEN_IN_PROGRESS;
+}
+
 #undef __irqd_to_state
=20
 static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
diff --git a/include/linux/irqchip/mmp.h b/include/linux/irqchip/mmp.h
deleted file mode 100644
index aa1813749a4f..000000000000
--- a/include/linux/irqchip/mmp.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef	__IRQCHIP_MMP_H
-#define	__IRQCHIP_MMP_H
-
-extern struct irq_chip icu_irq_chip;
-
-extern void icu_init_irq(void);
-extern void mmp2_init_icu(void);
-
-#endif	/* __IRQCHIP_MMP_H */
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 844a8e30e6de..d9451d456a73 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -102,6 +102,9 @@ struct irq_desc {
 	int			parent_irq;
 	struct module		*owner;
 	const char		*name;
+#ifdef CONFIG_HARDIRQS_SW_RESEND
+	struct hlist_node	resend_node;
+#endif
 } ____cacheline_internodealigned_in_smp;
=20
 #ifdef CONFIG_SPARSE_IRQ
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 49e7bc871fec..ee8c0acf39df 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -306,6 +306,7 @@ static void __irq_disable(struct irq_desc *desc, bool mas=
k);
 void irq_shutdown(struct irq_desc *desc)
 {
 	if (irqd_is_started(&desc->irq_data)) {
+		clear_irq_resend(desc);
 		desc->depth =3D 1;
 		if (desc->irq_data.chip->irq_shutdown) {
 			desc->irq_data.chip->irq_shutdown(&desc->irq_data);
@@ -692,8 +693,16 @@ void handle_fasteoi_irq(struct irq_desc *desc)
=20
 	raw_spin_lock(&desc->lock);
=20
-	if (!irq_may_run(desc))
+	/*
+	 * When an affinity change races with IRQ handling, the next interrupt
+	 * can arrive on the new CPU before the original CPU has completed
+	 * handling the previous one - it may need to be resent.
+	 */
+	if (!irq_may_run(desc)) {
+		if (irqd_needs_resend_when_in_progress(&desc->irq_data))
+			desc->istate |=3D IRQS_PENDING;
 		goto out;
+	}
=20
 	desc->istate &=3D ~(IRQS_REPLAY | IRQS_WAITING);
=20
@@ -715,6 +724,12 @@ void handle_fasteoi_irq(struct irq_desc *desc)
=20
 	cond_unmask_eoi_irq(desc, chip);
=20
+	/*
+	 * When the race described above happens this will resend the interrupt.
+	 */
+	if (unlikely(desc->istate & IRQS_PENDING))
+		check_irq_resend(desc, false);
+
 	raw_spin_unlock(&desc->lock);
 	return;
 out:
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index bbcaac64038e..5971a66be034 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -133,6 +133,8 @@ static const struct irq_bit_descr irqdata_states[] =3D {
 	BIT_MASK_DESCR(IRQD_HANDLE_ENFORCE_IRQCTX),
=20
 	BIT_MASK_DESCR(IRQD_IRQ_ENABLED_ON_SUSPEND),
+
+	BIT_MASK_DESCR(IRQD_RESEND_WHEN_IN_PROGRESS),
 };
=20
 static const struct irq_bit_descr irqdesc_states[] =3D {
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 5fdc0b557579..bdd35bb9c735 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -12,9 +12,9 @@
 #include <linux/sched/clock.h>
=20
 #ifdef CONFIG_SPARSE_IRQ
-# define IRQ_BITMAP_BITS	(NR_IRQS + 8196)
+# define MAX_SPARSE_IRQS	INT_MAX
 #else
-# define IRQ_BITMAP_BITS	NR_IRQS
+# define MAX_SPARSE_IRQS	NR_IRQS
 #endif
=20
 #define istate core_internal_state__do_not_mess_with_it
@@ -47,9 +47,12 @@ enum {
  *				  detection
  * IRQS_POLL_INPROGRESS		- polling in progress
  * IRQS_ONESHOT			- irq is not unmasked in primary handler
- * IRQS_REPLAY			- irq is replayed
+ * IRQS_REPLAY			- irq has been resent and will not be resent
+ * 				  again until the handler has run and cleared
+ * 				  this flag.
  * IRQS_WAITING			- irq is waiting
- * IRQS_PENDING			- irq is pending and replayed later
+ * IRQS_PENDING			- irq needs to be resent and should be resent
+ * 				  at the next available opportunity.
  * IRQS_SUSPENDED		- irq is suspended
  * IRQS_NMI			- irq line is used to deliver NMIs
  * IRQS_SYSFS			- descriptor has been added to sysfs
@@ -113,6 +116,8 @@ irqreturn_t handle_irq_event(struct irq_desc *desc);
=20
 /* Resending of interrupts :*/
 int check_irq_resend(struct irq_desc *desc, bool inject);
+void clear_irq_resend(struct irq_desc *desc);
+void irq_resend_init(struct irq_desc *desc);
 bool irq_wait_for_poll(struct irq_desc *desc);
 void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action);
=20
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 240e145e969f..27ca1c866f29 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -12,8 +12,7 @@
 #include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
-#include <linux/radix-tree.h>
-#include <linux/bitmap.h>
+#include <linux/maple_tree.h>
 #include <linux/irqdomain.h>
 #include <linux/sysfs.h>
=20
@@ -131,7 +130,40 @@ int nr_irqs =3D NR_IRQS;
 EXPORT_SYMBOL_GPL(nr_irqs);
=20
 static DEFINE_MUTEX(sparse_irq_lock);
-static DECLARE_BITMAP(allocated_irqs, IRQ_BITMAP_BITS);
+static struct maple_tree sparse_irqs =3D MTREE_INIT_EXT(sparse_irqs,
+					MT_FLAGS_ALLOC_RANGE |
+					MT_FLAGS_LOCK_EXTERN |
+					MT_FLAGS_USE_RCU,
+					sparse_irq_lock);
+
+static int irq_find_free_area(unsigned int from, unsigned int cnt)
+{
+	MA_STATE(mas, &sparse_irqs, 0, 0);
+
+	if (mas_empty_area(&mas, from, MAX_SPARSE_IRQS, cnt))
+		return -ENOSPC;
+	return mas.index;
+}
+
+static unsigned int irq_find_at_or_after(unsigned int offset)
+{
+	unsigned long index =3D offset;
+	struct irq_desc *desc =3D mt_find(&sparse_irqs, &index, nr_irqs);
+
+	return desc ? irq_desc_get_irq(desc) : nr_irqs;
+}
+
+static void irq_insert_desc(unsigned int irq, struct irq_desc *desc)
+{
+	MA_STATE(mas, &sparse_irqs, irq, irq);
+	WARN_ON(mas_store_gfp(&mas, desc, GFP_KERNEL) !=3D 0);
+}
+
+static void delete_irq_desc(unsigned int irq)
+{
+	MA_STATE(mas, &sparse_irqs, irq, irq);
+	mas_erase(&mas);
+}
=20
 #ifdef CONFIG_SPARSE_IRQ
=20
@@ -344,26 +376,14 @@ static void irq_sysfs_del(struct irq_desc *desc) {}
=20
 #endif /* CONFIG_SYSFS */
=20
-static RADIX_TREE(irq_desc_tree, GFP_KERNEL);
-
-static void irq_insert_desc(unsigned int irq, struct irq_desc *desc)
-{
-	radix_tree_insert(&irq_desc_tree, irq, desc);
-}
-
 struct irq_desc *irq_to_desc(unsigned int irq)
 {
-	return radix_tree_lookup(&irq_desc_tree, irq);
+	return mtree_load(&sparse_irqs, irq);
 }
 #ifdef CONFIG_KVM_BOOK3S_64_HV_MODULE
 EXPORT_SYMBOL_GPL(irq_to_desc);
 #endif
=20
-static void delete_irq_desc(unsigned int irq)
-{
-	radix_tree_delete(&irq_desc_tree, irq);
-}
-
 #ifdef CONFIG_SMP
 static void free_masks(struct irq_desc *desc)
 {
@@ -415,6 +435,7 @@ static struct irq_desc *alloc_desc(int irq, int node, uns=
igned int flags,
 	desc_set_defaults(irq, desc, node, affinity, owner);
 	irqd_set(&desc->irq_data, flags);
 	kobject_init(&desc->kobj, &irq_kobj_type);
+	irq_resend_init(desc);
=20
 	return desc;
=20
@@ -505,7 +526,6 @@ static int alloc_descs(unsigned int start, unsigned int c=
nt, int node,
 		irq_sysfs_add(start + i, desc);
 		irq_add_debugfs_entry(start + i, desc);
 	}
-	bitmap_set(allocated_irqs, start, cnt);
 	return start;
=20
 err:
@@ -516,7 +536,7 @@ static int alloc_descs(unsigned int start, unsigned int c=
nt, int node,
=20
 static int irq_expand_nr_irqs(unsigned int nr)
 {
-	if (nr > IRQ_BITMAP_BITS)
+	if (nr > MAX_SPARSE_IRQS)
 		return -ENOMEM;
 	nr_irqs =3D nr;
 	return 0;
@@ -534,18 +554,17 @@ int __init early_irq_init(void)
 	printk(KERN_INFO "NR_IRQS: %d, nr_irqs: %d, preallocated irqs: %d\n",
 	       NR_IRQS, nr_irqs, initcnt);
=20
-	if (WARN_ON(nr_irqs > IRQ_BITMAP_BITS))
-		nr_irqs =3D IRQ_BITMAP_BITS;
+	if (WARN_ON(nr_irqs > MAX_SPARSE_IRQS))
+		nr_irqs =3D MAX_SPARSE_IRQS;
=20
-	if (WARN_ON(initcnt > IRQ_BITMAP_BITS))
-		initcnt =3D IRQ_BITMAP_BITS;
+	if (WARN_ON(initcnt > MAX_SPARSE_IRQS))
+		initcnt =3D MAX_SPARSE_IRQS;
=20
 	if (initcnt > nr_irqs)
 		nr_irqs =3D initcnt;
=20
 	for (i =3D 0; i < initcnt; i++) {
 		desc =3D alloc_desc(i, node, 0, NULL, NULL);
-		set_bit(i, allocated_irqs);
 		irq_insert_desc(i, desc);
 	}
 	return arch_early_irq_init();
@@ -581,6 +600,7 @@ int __init early_irq_init(void)
 		mutex_init(&desc[i].request_mutex);
 		init_waitqueue_head(&desc[i].wait_for_threads);
 		desc_set_defaults(i, &desc[i], node, NULL, NULL);
+		irq_resend_init(desc);
 	}
 	return arch_early_irq_init();
 }
@@ -599,6 +619,7 @@ static void free_desc(unsigned int irq)
 	raw_spin_lock_irqsave(&desc->lock, flags);
 	desc_set_defaults(irq, desc, irq_desc_get_node(desc), NULL, NULL);
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
+	delete_irq_desc(irq);
 }
=20
 static inline int alloc_descs(unsigned int start, unsigned int cnt, int node,
@@ -611,8 +632,8 @@ static inline int alloc_descs(unsigned int start, unsigne=
d int cnt, int node,
 		struct irq_desc *desc =3D irq_to_desc(start + i);
=20
 		desc->owner =3D owner;
+		irq_insert_desc(start + i, desc);
 	}
-	bitmap_set(allocated_irqs, start, cnt);
 	return start;
 }
=20
@@ -624,7 +645,7 @@ static int irq_expand_nr_irqs(unsigned int nr)
 void irq_mark_irq(unsigned int irq)
 {
 	mutex_lock(&sparse_irq_lock);
-	bitmap_set(allocated_irqs, irq, 1);
+	irq_insert_desc(irq, irq_desc + irq);
 	mutex_unlock(&sparse_irq_lock);
 }
=20
@@ -768,7 +789,6 @@ void irq_free_descs(unsigned int from, unsigned int cnt)
 	for (i =3D 0; i < cnt; i++)
 		free_desc(from + i);
=20
-	bitmap_clear(allocated_irqs, from, cnt);
 	mutex_unlock(&sparse_irq_lock);
 }
 EXPORT_SYMBOL_GPL(irq_free_descs);
@@ -810,8 +830,7 @@ __irq_alloc_descs(int irq, unsigned int from, unsigned in=
t cnt, int node,
=20
 	mutex_lock(&sparse_irq_lock);
=20
-	start =3D bitmap_find_next_zero_area(allocated_irqs, IRQ_BITMAP_BITS,
-					   from, cnt, 0);
+	start =3D irq_find_free_area(from, cnt);
 	ret =3D -EEXIST;
 	if (irq >=3D0 && start !=3D irq)
 		goto unlock;
@@ -836,7 +855,7 @@ EXPORT_SYMBOL_GPL(__irq_alloc_descs);
  */
 unsigned int irq_get_next_irq(unsigned int offset)
 {
-	return find_next_bit(allocated_irqs, nr_irqs, offset);
+	return irq_find_at_or_after(offset);
 }
=20
 struct irq_desc *
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index f34760a1e222..5bd01624e447 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1915,6 +1915,8 @@ static void irq_domain_check_hierarchy(struct irq_domai=
n *domain)
 #endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
=20
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
+#include "internals.h"
+
 static struct dentry *domain_dir;
=20
 static void
diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index 0c46e9fe3a89..edec335c0a7a 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -21,8 +21,9 @@
=20
 #ifdef CONFIG_HARDIRQS_SW_RESEND
=20
-/* Bitmap to handle software resend of interrupts: */
-static DECLARE_BITMAP(irqs_resend, IRQ_BITMAP_BITS);
+/* hlist_head to handle software resend of interrupts: */
+static HLIST_HEAD(irq_resend_list);
+static DEFINE_RAW_SPINLOCK(irq_resend_lock);
=20
 /*
  * Run software resends of IRQ's
@@ -30,18 +31,17 @@ static DECLARE_BITMAP(irqs_resend, IRQ_BITMAP_BITS);
 static void resend_irqs(struct tasklet_struct *unused)
 {
 	struct irq_desc *desc;
-	int irq;
-
-	while (!bitmap_empty(irqs_resend, nr_irqs)) {
-		irq =3D find_first_bit(irqs_resend, nr_irqs);
-		clear_bit(irq, irqs_resend);
-		desc =3D irq_to_desc(irq);
-		if (!desc)
-			continue;
-		local_irq_disable();
+
+	raw_spin_lock_irq(&irq_resend_lock);
+	while (!hlist_empty(&irq_resend_list)) {
+		desc =3D hlist_entry(irq_resend_list.first, struct irq_desc,
+				   resend_node);
+		hlist_del_init(&desc->resend_node);
+		raw_spin_unlock(&irq_resend_lock);
 		desc->handle_irq(desc);
-		local_irq_enable();
+		raw_spin_lock(&irq_resend_lock);
 	}
+	raw_spin_unlock_irq(&irq_resend_lock);
 }
=20
 /* Tasklet to handle resend: */
@@ -49,8 +49,6 @@ static DECLARE_TASKLET(resend_tasklet, resend_irqs);
=20
 static int irq_sw_resend(struct irq_desc *desc)
 {
-	unsigned int irq =3D irq_desc_get_irq(desc);
-
 	/*
 	 * Validate whether this interrupt can be safely injected from
 	 * non interrupt context
@@ -70,16 +68,31 @@ static int irq_sw_resend(struct irq_desc *desc)
 		 */
 		if (!desc->parent_irq)
 			return -EINVAL;
-		irq =3D desc->parent_irq;
 	}
=20
-	/* Set it pending and activate the softirq: */
-	set_bit(irq, irqs_resend);
+	/* Add to resend_list and activate the softirq: */
+	raw_spin_lock(&irq_resend_lock);
+	hlist_add_head(&desc->resend_node, &irq_resend_list);
+	raw_spin_unlock(&irq_resend_lock);
 	tasklet_schedule(&resend_tasklet);
 	return 0;
 }
=20
+void clear_irq_resend(struct irq_desc *desc)
+{
+	raw_spin_lock(&irq_resend_lock);
+	hlist_del_init(&desc->resend_node);
+	raw_spin_unlock(&irq_resend_lock);
+}
+
+void irq_resend_init(struct irq_desc *desc)
+{
+	INIT_HLIST_NODE(&desc->resend_node);
+}
 #else
+void clear_irq_resend(struct irq_desc *desc) {}
+void irq_resend_init(struct irq_desc *desc) {}
+
 static int irq_sw_resend(struct irq_desc *desc)
 {
 	return -EINVAL;
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 1b725510dd0f..807b34ccd797 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -80,21 +80,6 @@ static void wakeup_softirqd(void)
 		wake_up_process(tsk);
 }
=20
-/*
- * If ksoftirqd is scheduled, we do not want to process pending softirqs
- * right now. Let ksoftirqd handle this at its own rate, to get fairness,
- * unless we're doing some of the synchronous softirqs.
- */
-#define SOFTIRQ_NOW_MASK ((1 << HI_SOFTIRQ) | (1 << TASKLET_SOFTIRQ))
-static bool ksoftirqd_running(unsigned long pending)
-{
-	struct task_struct *tsk =3D __this_cpu_read(ksoftirqd);
-
-	if (pending & SOFTIRQ_NOW_MASK)
-		return false;
-	return tsk && task_is_running(tsk) && !__kthread_should_park(tsk);
-}
-
 #ifdef CONFIG_TRACE_IRQFLAGS
 DEFINE_PER_CPU(int, hardirqs_enabled);
 DEFINE_PER_CPU(int, hardirq_context);
@@ -236,7 +221,7 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int =
cnt)
 		goto out;
=20
 	pending =3D local_softirq_pending();
-	if (!pending || ksoftirqd_running(pending))
+	if (!pending)
 		goto out;
=20
 	/*
@@ -432,9 +417,6 @@ static inline bool should_wake_ksoftirqd(void)
=20
 static inline void invoke_softirq(void)
 {
-	if (ksoftirqd_running(local_softirq_pending()))
-		return;
-
 	if (!force_irqthreads() || !__this_cpu_read(ksoftirqd)) {
 #ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
 		/*
@@ -468,7 +450,7 @@ asmlinkage __visible void do_softirq(void)
=20
 	pending =3D local_softirq_pending();
=20
-	if (pending && !ksoftirqd_running(pending))
+	if (pending)
 		do_softirq_own_stack();
=20
 	local_irq_restore(flags);

