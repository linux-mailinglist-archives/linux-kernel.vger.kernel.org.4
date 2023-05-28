Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E9171388B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 09:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjE1HxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 03:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjE1HxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 03:53:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709AAD8
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 00:52:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685260377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PgjARaT4SsuXlumh7cdFIfXQM8u/8TYdwhPtNHzDTHM=;
        b=UCCBbeRvpk8+2O/jamwY0ak3Y3sl+BqeUadetIQtNIeP4jFLjaEiZ3p6fSvDC1XZ+aeiRs
        jLd1OgEEQLfqbBD+D0bUnle+7919iHCf3IGCEwLB3W/pwo9nadSJx2dAOlB43tRiAp245f
        9d7FRoZNTKna5AhaVlUcFTaa3fvh8GLY7p7k1CAxHk67Cb8O0ZNULsy3qLRilt2XesBd3J
        E9F+Z165s709fHjczkoZjSJGIdJqDFBu2bZ/8PB96+1yfmPu4A08C44aGY6RSaC+F5zMZ1
        ViVKBN0gUoKJ5TWe3fBuq6ideqxaX189V8yaXepKSisLNIxkUTJTyYCOwkwzlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685260377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PgjARaT4SsuXlumh7cdFIfXQM8u/8TYdwhPtNHzDTHM=;
        b=Q8BoTr0j5FcDQVl3y0QHXwo+Xnwok4Tg6FfFD/I4mShuOKMTyhlYTFwOBMbbjwtrLXkzj2
        kJixTawIdxQ2LjBQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for 6.4-rc4
Message-ID: <168526035526.3457722.14103350194452732675.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 28 May 2023 09:52:56 +0200 (CEST)
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

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2023-=
05-28

up to:  4115af49d2c2: Merge tag 'irqchip-fixes-6.4-1' of git://git.kernel.org=
/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent


A set of fixes for interrupt chip drivers:

  - Prevent loss of state in the MIPS GIC interrupt controller.

  - Disable pseudo NMIs on Mediatek based Chromebooks as they have
    firmware issues which cause instantenous chrashes and freezes
    wen pseudo NMIs are used.

  - Fix the error handling path in the MBIGEN driver and a defined but not
    used warning in the meson-gpio interrupt chip driver.

Thanks,

	tglx

------------------>
Douglas Anderson (2):
      dt-bindings: interrupt-controller: arm,gic-v3: Add quirk for Mediatek S=
oCs w/ broken FW
      irqchip/gic-v3: Disable pseudo NMIs on Mediatek devices w/ firmware iss=
ues

Jiaxun Yang (2):
      irqchip/mips-gic: Don't touch vl_map if a local interrupt is not routab=
le
      irqchip/mips-gic: Use raw spinlock for gic_lock

Kefeng Wang (1):
      irqchip/mbigen: Unify the error handling in mbigen_of_create_domain()

Krzysztof Kozlowski (1):
      irqchip/meson-gpio: Mark OF related data as maybe unused


 .../bindings/interrupt-controller/arm,gic-v3.yaml  |  6 ++++
 drivers/irqchip/irq-gic-common.c                   |  8 ++++--
 drivers/irqchip/irq-gic-common.h                   |  1 +
 drivers/irqchip/irq-gic-v3.c                       | 20 ++++++++++++++
 drivers/irqchip/irq-mbigen.c                       | 31 ++++++++++++---------
 drivers/irqchip/irq-meson-gpio.c                   |  2 +-
 drivers/irqchip/irq-mips-gic.c                     | 32 ++++++++++++--------=
--
 7 files changed, 69 insertions(+), 31 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v=
3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.ya=
ml
index 92117261e1e1..39e64c7f6360 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
@@ -166,6 +166,12 @@ properties:
   resets:
     maxItems: 1
=20
+  mediatek,broken-save-restore-fw:
+    type: boolean
+    description:
+      Asserts that the firmware on this device has issues saving and restori=
ng
+      GICR registers when the GIC redistributors are powered off.
+
 dependencies:
   mbi-ranges: [ msi-controller ]
   msi-controller: [ mbi-ranges ]
diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-commo=
n.c
index a610821c8ff2..de47b51cdadb 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -16,7 +16,11 @@ void gic_enable_of_quirks(const struct device_node *np,
 			  const struct gic_quirk *quirks, void *data)
 {
 	for (; quirks->desc; quirks++) {
-		if (!of_device_is_compatible(np, quirks->compatible))
+		if (quirks->compatible &&
+		    !of_device_is_compatible(np, quirks->compatible))
+			continue;
+		if (quirks->property &&
+		    !of_property_read_bool(np, quirks->property))
 			continue;
 		if (quirks->init(data))
 			pr_info("GIC: enabling workaround for %s\n",
@@ -28,7 +32,7 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk *qu=
irks,
 		void *data)
 {
 	for (; quirks->desc; quirks++) {
-		if (quirks->compatible)
+		if (quirks->compatible || quirks->property)
 			continue;
 		if (quirks->iidr !=3D (quirks->mask & iidr))
 			continue;
diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-commo=
n.h
index 27e3d4ed4f32..3db4592cda1c 100644
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -13,6 +13,7 @@
 struct gic_quirk {
 	const char *desc;
 	const char *compatible;
+	const char *property;
 	bool (*init)(void *data);
 	u32 iidr;
 	u32 mask;
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 6fcee221f201..a605aa79435a 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -39,6 +39,7 @@
=20
 #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
 #define FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539	(1ULL << 1)
+#define FLAGS_WORKAROUND_MTK_GICR_SAVE		(1ULL << 2)
=20
 #define GIC_IRQ_TYPE_PARTITION	(GIC_IRQ_TYPE_LPI + 1)
=20
@@ -1720,6 +1721,15 @@ static bool gic_enable_quirk_msm8996(void *data)
 	return true;
 }
=20
+static bool gic_enable_quirk_mtk_gicr(void *data)
+{
+	struct gic_chip_data *d =3D data;
+
+	d->flags |=3D FLAGS_WORKAROUND_MTK_GICR_SAVE;
+
+	return true;
+}
+
 static bool gic_enable_quirk_cavium_38539(void *data)
 {
 	struct gic_chip_data *d =3D data;
@@ -1792,6 +1802,11 @@ static const struct gic_quirk gic_quirks[] =3D {
 		.compatible =3D "qcom,msm8996-gic-v3",
 		.init	=3D gic_enable_quirk_msm8996,
 	},
+	{
+		.desc	=3D "GICv3: Mediatek Chromebook GICR save problem",
+		.property =3D "mediatek,broken-save-restore-fw",
+		.init	=3D gic_enable_quirk_mtk_gicr,
+	},
 	{
 		.desc	=3D "GICv3: HIP06 erratum 161010803",
 		.iidr	=3D 0x0204043b,
@@ -1834,6 +1849,11 @@ static void gic_enable_nmi_support(void)
 	if (!gic_prio_masking_enabled())
 		return;
=20
+	if (gic_data.flags & FLAGS_WORKAROUND_MTK_GICR_SAVE) {
+		pr_warn("Skipping NMI enable due to firmware issues\n");
+		return;
+	}
+
 	ppi_nmi_refs =3D kcalloc(gic_data.ppi_nr, sizeof(*ppi_nmi_refs), GFP_KERNEL=
);
 	if (!ppi_nmi_refs)
 		return;
diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index eada5e0e3eb9..5101a3fb11df 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -240,26 +240,27 @@ static int mbigen_of_create_domain(struct platform_devi=
ce *pdev,
 	struct irq_domain *domain;
 	struct device_node *np;
 	u32 num_pins;
+	int ret =3D 0;
+
+	parent =3D bus_get_dev_root(&platform_bus_type);
+	if (!parent)
+		return -ENODEV;
=20
 	for_each_child_of_node(pdev->dev.of_node, np) {
 		if (!of_property_read_bool(np, "interrupt-controller"))
 			continue;
=20
-		parent =3D bus_get_dev_root(&platform_bus_type);
-		if (parent) {
-			child =3D of_platform_device_create(np, NULL, parent);
-			put_device(parent);
-			if (!child) {
-				of_node_put(np);
-				return -ENOMEM;
-			}
+		child =3D of_platform_device_create(np, NULL, parent);
+		if (!child) {
+			ret =3D -ENOMEM;
+			break;
 		}
=20
 		if (of_property_read_u32(child->dev.of_node, "num-pins",
 					 &num_pins) < 0) {
 			dev_err(&pdev->dev, "No num-pins property\n");
-			of_node_put(np);
-			return -EINVAL;
+			ret =3D -EINVAL;
+			break;
 		}
=20
 		domain =3D platform_msi_create_device_domain(&child->dev, num_pins,
@@ -267,12 +268,16 @@ static int mbigen_of_create_domain(struct platform_devi=
ce *pdev,
 							   &mbigen_domain_ops,
 							   mgn_chip);
 		if (!domain) {
-			of_node_put(np);
-			return -ENOMEM;
+			ret =3D -ENOMEM;
+			break;
 		}
 	}
=20
-	return 0;
+	put_device(parent);
+	if (ret)
+		of_node_put(np);
+
+	return ret;
 }
=20
 #ifdef CONFIG_ACPI
diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpi=
o.c
index 2aaa9aad3e87..7da18ef95211 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -150,7 +150,7 @@ static const struct meson_gpio_irq_params s4_params =3D {
 	INIT_MESON_S4_COMMON_DATA(82)
 };
=20
-static const struct of_device_id meson_irq_gpio_matches[] =3D {
+static const struct of_device_id meson_irq_gpio_matches[] __maybe_unused =3D=
 {
 	{ .compatible =3D "amlogic,meson8-gpio-intc", .data =3D &meson8_params },
 	{ .compatible =3D "amlogic,meson8b-gpio-intc", .data =3D &meson8b_params },
 	{ .compatible =3D "amlogic,meson-gxbb-gpio-intc", .data =3D &gxbb_params },
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 046c355e120b..6d5ecc10a870 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -50,7 +50,7 @@ void __iomem *mips_gic_base;
=20
 static DEFINE_PER_CPU_READ_MOSTLY(unsigned long[GIC_MAX_LONGS], pcpu_masks);
=20
-static DEFINE_SPINLOCK(gic_lock);
+static DEFINE_RAW_SPINLOCK(gic_lock);
 static struct irq_domain *gic_irq_domain;
 static int gic_shared_intrs;
 static unsigned int gic_cpu_pin;
@@ -210,7 +210,7 @@ static int gic_set_type(struct irq_data *d, unsigned int =
type)
=20
 	irq =3D GIC_HWIRQ_TO_SHARED(d->hwirq);
=20
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 	switch (type & IRQ_TYPE_SENSE_MASK) {
 	case IRQ_TYPE_EDGE_FALLING:
 		pol =3D GIC_POL_FALLING_EDGE;
@@ -250,7 +250,7 @@ static int gic_set_type(struct irq_data *d, unsigned int =
type)
 	else
 		irq_set_chip_handler_name_locked(d, &gic_level_irq_controller,
 						 handle_level_irq, NULL);
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
=20
 	return 0;
 }
@@ -268,7 +268,7 @@ static int gic_set_affinity(struct irq_data *d, const str=
uct cpumask *cpumask,
 		return -EINVAL;
=20
 	/* Assumption : cpumask refers to a single CPU */
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
=20
 	/* Re-route this IRQ */
 	write_gic_map_vp(irq, BIT(mips_cm_vp_id(cpu)));
@@ -279,7 +279,7 @@ static int gic_set_affinity(struct irq_data *d, const str=
uct cpumask *cpumask,
 		set_bit(irq, per_cpu_ptr(pcpu_masks, cpu));
=20
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
=20
 	return IRQ_SET_MASK_OK;
 }
@@ -357,12 +357,12 @@ static void gic_mask_local_irq_all_vpes(struct irq_data=
 *d)
 	cd =3D irq_data_get_irq_chip_data(d);
 	cd->mask =3D false;
=20
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 	for_each_online_cpu(cpu) {
 		write_gic_vl_other(mips_cm_vp_id(cpu));
 		write_gic_vo_rmask(BIT(intr));
 	}
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
 }
=20
 static void gic_unmask_local_irq_all_vpes(struct irq_data *d)
@@ -375,12 +375,12 @@ static void gic_unmask_local_irq_all_vpes(struct irq_da=
ta *d)
 	cd =3D irq_data_get_irq_chip_data(d);
 	cd->mask =3D true;
=20
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 	for_each_online_cpu(cpu) {
 		write_gic_vl_other(mips_cm_vp_id(cpu));
 		write_gic_vo_smask(BIT(intr));
 	}
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
 }
=20
 static void gic_all_vpes_irq_cpu_online(void)
@@ -393,19 +393,21 @@ static void gic_all_vpes_irq_cpu_online(void)
 	unsigned long flags;
 	int i;
=20
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
=20
 	for (i =3D 0; i < ARRAY_SIZE(local_intrs); i++) {
 		unsigned int intr =3D local_intrs[i];
 		struct gic_all_vpes_chip_data *cd;
=20
+		if (!gic_local_irq_is_routable(intr))
+			continue;
 		cd =3D &gic_all_vpes_chip_data[intr];
 		write_gic_vl_map(mips_gic_vx_map_reg(intr), cd->map);
 		if (cd->mask)
 			write_gic_vl_smask(BIT(intr));
 	}
=20
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
 }
=20
 static struct irq_chip gic_all_vpes_local_irq_controller =3D {
@@ -435,11 +437,11 @@ static int gic_shared_irq_domain_map(struct irq_domain =
*d, unsigned int virq,
=20
 	data =3D irq_get_irq_data(virq);
=20
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 	write_gic_map_pin(intr, GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
 	write_gic_map_vp(intr, BIT(mips_cm_vp_id(cpu)));
 	irq_data_update_effective_affinity(data, cpumask_of(cpu));
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
=20
 	return 0;
 }
@@ -531,12 +533,12 @@ static int gic_irq_domain_map(struct irq_domain *d, uns=
igned int virq,
 	if (!gic_local_irq_is_routable(intr))
 		return -EPERM;
=20
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 	for_each_online_cpu(cpu) {
 		write_gic_vl_other(mips_cm_vp_id(cpu));
 		write_gic_vo_map(mips_gic_vx_map_reg(intr), map);
 	}
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
=20
 	return 0;
 }

