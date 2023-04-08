Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E926DBA3C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 12:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjDHKvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 06:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjDHKug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 06:50:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5166D11E99
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 03:49:39 -0700 (PDT)
Date:   Sat, 08 Apr 2023 10:45:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680950721;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fz/bm5FajTZFs8P70JdSabJaGE0oojvy1tgnadRPgIo=;
        b=HbSlx0tKckjoOGuB2sAw+bsisAJygF9rbrbsZLkXX0M2TQcT4SaAAhPzhyU9zJsFLTc0+Q
        DMExnTtLfXKakDUt3Sf7WjjcD33jWVmYa0R9kAtzTIYES15GxIFgR75BRQl1oWaJftqHCm
        KkXkfBJs9k0Xo0BRMghLJJ5bNa/Jmx7Gp/BglB49U9PJn3kP8LyS4BTtfsjJ1bWyytGMkq
        DgN87WXFjdpm5FNpy68Ej/CwCRa5CLCnDJxSHy1TTRacL6s5lDZVt4xIMGgunlwcO4q/dH
        bNTE5Fw4Azu2H/xFweXxMqYSFVGBG+JLIDvW68A7unanGdIYF/DB9iIhMKkOcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680950721;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fz/bm5FajTZFs8P70JdSabJaGE0oojvy1tgnadRPgIo=;
        b=FqoG1kihyEa07bdfdfFH+W96CAgnAmRylOjSGEmbL6mlOHvtjAMMH5LNUHXdjNnLWrL4Q4
        V6RSY2jXtgSDrmCg==
From:   "irqchip-bot for Shanker Donthineni" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gicv3: Workaround for NVIDIA
 erratum T241-FABRIC-4
Cc:     Vikram Sethi <vsethi@nvidia.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230319024314.3540573-2-sdonthineni@nvidia.com>
References: <20230319024314.3540573-2-sdonthineni@nvidia.com>
MIME-Version: 1.0
Message-ID: <168095072125.404.1312450909334575362.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     35727af2b15d98a2dd2811d631d3a3886111312e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/35727af2b15d98a2dd2811d631d3a3886111312e
Author:        Shanker Donthineni <sdonthineni@nvidia.com>
AuthorDate:    Sat, 18 Mar 2023 21:43:14 -05:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 08 Apr 2023 10:51:23 +01:00

irqchip/gicv3: Workaround for NVIDIA erratum T241-FABRIC-4

The T241 platform suffers from the T241-FABRIC-4 erratum which causes
unexpected behavior in the GIC when multiple transactions are received
simultaneously from different sources. This hardware issue impacts
NVIDIA server platforms that use more than two T241 chips
interconnected. Each chip has support for 320 {E}SPIs.

This issue occurs when multiple packets from different GICs are
incorrectly interleaved at the target chip. The erratum text below
specifies exactly what can cause multiple transfer packets susceptible
to interleaving and GIC state corruption. GIC state corruption can
lead to a range of problems, including kernel panics, and unexpected
behavior.

>From the erratum text:
  "In some cases, inter-socket AXI4 Stream packets with multiple
  transfers, may be interleaved by the fabric when presented to ARM
  Generic Interrupt Controller. GIC expects all transfers of a packet
  to be delivered without any interleaving.

  The following GICv3 commands may result in multiple transfer packets
  over inter-socket AXI4 Stream interface:
   - Register reads from GICD_I* and GICD_N*
   - Register writes to 64-bit GICD registers other than GICD_IROUTERn*
   - ITS command MOVALL

  Multiple commands in GICv4+ utilize multiple transfer packets,
  including VMOVP, VMOVI, VMAPP, and 64-bit register accesses."

  This issue impacts system configurations with more than 2 sockets,
  that require multi-transfer packets to be sent over inter-socket
  AXI4 Stream interface between GIC instances on different sockets.
  GICv4 cannot be supported. GICv3 SW model can only be supported
  with the workaround. Single and Dual socket configurations are not
  impacted by this issue and support GICv3 and GICv4."

Link: https://developer.nvidia.com/docs/t241-fabric-4/nvidia-t241-fabric-4-errata.pdf

Writing to the chip alias region of the GICD_In{E} registers except
GICD_ICENABLERn has an equivalent effect as writing to the global
distributor. The SPI interrupt deactivate path is not impacted by
the erratum.

To fix this problem, implement a workaround that ensures read accesses
to the GICD_In{E} registers are directed to the chip that owns the
SPI, and disable GICv4.x features. To simplify code changes, the
gic_configure_irq() function uses the same alias region for both read
and write operations to GICD_ICFGR.

Co-developed-by: Vikram Sethi <vsethi@nvidia.com>
Signed-off-by: Vikram Sethi <vsethi@nvidia.com>
Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com> (for SMCCC/SOC ID bits)
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230319024314.3540573-2-sdonthineni@nvidia.com
---
 Documentation/arm64/silicon-errata.rst |   2 +-
 drivers/firmware/smccc/smccc.c         |  26 +++++-
 drivers/firmware/smccc/soc_id.c        |  28 +-----
 drivers/irqchip/Kconfig                |   1 +-
 drivers/irqchip/irq-gic-v3.c           | 115 +++++++++++++++++++++---
 include/linux/arm-smccc.h              |  18 ++++-
 6 files changed, 156 insertions(+), 34 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index ec5f889..e31f6c0 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -172,6 +172,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | NVIDIA         | Carmel Core     | N/A             | NVIDIA_CARMEL_CNP_ERRATUM   |
 +----------------+-----------------+-----------------+-----------------------------+
+| NVIDIA         | T241 GICv3/4.x  | T241-FABRIC-4   | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smccc.c
index 60ccf3e..db818f9 100644
--- a/drivers/firmware/smccc/smccc.c
+++ b/drivers/firmware/smccc/smccc.c
@@ -17,9 +17,13 @@ static enum arm_smccc_conduit smccc_conduit = SMCCC_CONDUIT_NONE;
 
 bool __ro_after_init smccc_trng_available = false;
 u64 __ro_after_init smccc_has_sve_hint = false;
+s32 __ro_after_init smccc_soc_id_version = SMCCC_RET_NOT_SUPPORTED;
+s32 __ro_after_init smccc_soc_id_revision = SMCCC_RET_NOT_SUPPORTED;
 
 void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
 {
+	struct arm_smccc_res res;
+
 	smccc_version = version;
 	smccc_conduit = conduit;
 
@@ -27,6 +31,18 @@ void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
 	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
 	    smccc_version >= ARM_SMCCC_VERSION_1_3)
 		smccc_has_sve_hint = true;
+
+	if ((smccc_version >= ARM_SMCCC_VERSION_1_2) &&
+	    (smccc_conduit != SMCCC_CONDUIT_NONE)) {
+		arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
+				     ARM_SMCCC_ARCH_SOC_ID, &res);
+		if ((s32)res.a0 >= 0) {
+			arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 0, &res);
+			smccc_soc_id_version = (s32)res.a0;
+			arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 1, &res);
+			smccc_soc_id_revision = (s32)res.a0;
+		}
+	}
 }
 
 enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void)
@@ -44,6 +60,16 @@ u32 arm_smccc_get_version(void)
 }
 EXPORT_SYMBOL_GPL(arm_smccc_get_version);
 
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
index dd7c3d5..890eb45 100644
--- a/drivers/firmware/smccc/soc_id.c
+++ b/drivers/firmware/smccc/soc_id.c
@@ -42,41 +42,23 @@ static int __init smccc_soc_init(void)
 	if (arm_smccc_get_version() < ARM_SMCCC_VERSION_1_2)
 		return 0;
 
-	if (arm_smccc_1_1_get_conduit() == SMCCC_CONDUIT_NONE) {
-		pr_err("%s: invalid SMCCC conduit\n", __func__);
-		return -EOPNOTSUPP;
-	}
-
-	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
-			     ARM_SMCCC_ARCH_SOC_ID, &res);
-
-	if ((int)res.a0 == SMCCC_RET_NOT_SUPPORTED) {
+	soc_id_version = arm_smccc_get_soc_id_version();
+	if (soc_id_version == SMCCC_RET_NOT_SUPPORTED) {
 		pr_info("ARCH_SOC_ID not implemented, skipping ....\n");
 		return 0;
 	}
 
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
 
-	soc_id_version = res.a0;
-
-	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 1, &res);
-	if ((int)res.a0 < 0) {
+	soc_id_rev = arm_smccc_get_soc_id_revision();
+	if (soc_id_rev < 0) {
 		pr_err("ARCH_SOC_ID(1) returned error: %lx\n", res.a0);
 		return -EINVAL;
 	}
 
-	soc_id_rev = res.a0;
-
 	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
 	if (!soc_dev_attr)
 		return -ENOMEM;
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index b744fd9..e7bb355 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -36,6 +36,7 @@ config ARM_GIC_V3
 	select IRQ_DOMAIN_HIERARCHY
 	select PARTITION_PERCPU
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
+	select HAVE_ARM_SMCCC_DISCOVERY
 
 config ARM_GIC_V3_ITS
 	bool
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index fd134e1..6fcee22 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -24,6 +24,9 @@
 #include <linux/irqchip/arm-gic-common.h>
 #include <linux/irqchip/arm-gic-v3.h>
 #include <linux/irqchip/irq-partition-percpu.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/arm-smccc.h>
 
 #include <asm/cputype.h>
 #include <asm/exception.h>
@@ -47,6 +50,7 @@ struct redist_region {
 
 struct gic_chip_data {
 	struct fwnode_handle	*fwnode;
+	phys_addr_t		dist_phys_base;
 	void __iomem		*dist_base;
 	struct redist_region	*redist_regions;
 	struct rdists		rdists;
@@ -59,6 +63,10 @@ struct gic_chip_data {
 	struct partition_desc	**ppi_descs;
 };
 
+#define T241_CHIPS_MAX		4
+static void __iomem *t241_dist_base_alias[T241_CHIPS_MAX] __read_mostly;
+static DEFINE_STATIC_KEY_FALSE(gic_nvidia_t241_erratum);
+
 static struct gic_chip_data gic_data __read_mostly;
 static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
 
@@ -179,6 +187,39 @@ static inline bool gic_irq_in_rdist(struct irq_data *d)
 	}
 }
 
+static inline void __iomem *gic_dist_base_alias(struct irq_data *d)
+{
+	if (static_branch_unlikely(&gic_nvidia_t241_erratum)) {
+		irq_hw_number_t hwirq = irqd_to_hwirq(d);
+		u32 chip;
+
+		/*
+		 * For the erratum T241-FABRIC-4, read accesses to GICD_In{E}
+		 * registers are directed to the chip that owns the SPI. The
+		 * the alias region can also be used for writes to the
+		 * GICD_In{E} except GICD_ICENABLERn. Each chip has support
+		 * for 320 {E}SPIs. Mappings for all 4 chips:
+		 *    Chip0 = 32-351
+		 *    Chip1 = 352-671
+		 *    Chip2 = 672-991
+		 *    Chip3 = 4096-4415
+		 */
+		switch (__get_intid_range(hwirq)) {
+		case SPI_RANGE:
+			chip = (hwirq - 32) / 320;
+			break;
+		case ESPI_RANGE:
+			chip = 3;
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
 		base = gic_data_rdist_sgi_base();
 	else
-		base = gic_data.dist_base;
+		base = gic_dist_base_alias(d);
 
 	return !!(readl_relaxed(base + offset + (index / 32) * 4) & mask);
 }
@@ -588,7 +629,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	if (gic_irq_in_rdist(d))
 		base = gic_data_rdist_sgi_base();
 	else
-		base = gic_data.dist_base;
+		base = gic_dist_base_alias(d);
 
 	offset = convert_offset_index(d, GICD_ICFGR, &index);
 
@@ -1708,6 +1749,43 @@ static bool gic_enable_quirk_hip06_07(void *data)
 	return false;
 }
 
+#define T241_CHIPN_MASK		GENMASK_ULL(45, 44)
+#define T241_CHIP_GICDA_OFFSET	0x1580000
+#define SMCCC_SOC_ID_T241	0x036b0241
+
+static bool gic_enable_quirk_nvidia_t241(void *data)
+{
+	s32 soc_id = arm_smccc_get_soc_id_version();
+	unsigned long chip_bmask = 0;
+	phys_addr_t phys;
+	u32 i;
+
+	/* Check JEP106 code for NVIDIA T241 chip (036b:0241) */
+	if ((soc_id < 0) || (soc_id != SMCCC_SOC_ID_T241))
+		return false;
+
+	/* Find the chips based on GICR regions PHYS addr */
+	for (i = 0; i < gic_data.nr_redist_regions; i++) {
+		chip_bmask |= BIT(FIELD_GET(T241_CHIPN_MASK,
+				  (u64)gic_data.redist_regions[i].phys_base));
+	}
+
+	if (hweight32(chip_bmask) < 3)
+		return false;
+
+	/* Setup GICD alias regions */
+	for (i = 0; i < ARRAY_SIZE(t241_dist_base_alias); i++) {
+		if (chip_bmask & BIT(i)) {
+			phys = gic_data.dist_phys_base + T241_CHIP_GICDA_OFFSET;
+			phys |= FIELD_PREP(T241_CHIPN_MASK, i);
+			t241_dist_base_alias[i] = ioremap(phys, SZ_64K);
+			WARN_ON_ONCE(!t241_dist_base_alias[i]);
+		}
+	}
+	static_branch_enable(&gic_nvidia_t241_erratum);
+	return true;
+}
+
 static const struct gic_quirk gic_quirks[] = {
 	{
 		.desc	= "GICv3: Qualcomm MSM8996 broken firmware",
@@ -1740,6 +1818,12 @@ static const struct gic_quirk gic_quirks[] = {
 		.init	= gic_enable_quirk_cavium_38539,
 	},
 	{
+		.desc	= "GICv3: NVIDIA erratum T241-FABRIC-4",
+		.iidr	= 0x0402043b,
+		.mask	= 0xffffffff,
+		.init	= gic_enable_quirk_nvidia_t241,
+	},
+	{
 	}
 };
 
@@ -1798,7 +1882,8 @@ static void gic_enable_nmi_support(void)
 		gic_chip.flags |= IRQCHIP_SUPPORTS_NMI;
 }
 
-static int __init gic_init_bases(void __iomem *dist_base,
+static int __init gic_init_bases(phys_addr_t dist_phys_base,
+				 void __iomem *dist_base,
 				 struct redist_region *rdist_regs,
 				 u32 nr_redist_regions,
 				 u64 redist_stride,
@@ -1814,6 +1899,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 		pr_info("GIC: Using split EOI/Deactivate mode\n");
 
 	gic_data.fwnode = handle;
+	gic_data.dist_phys_base = dist_phys_base;
 	gic_data.dist_base = dist_base;
 	gic_data.redist_regions = rdist_regs;
 	gic_data.nr_redist_regions = nr_redist_regions;
@@ -1841,10 +1927,13 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	gic_data.domain = irq_domain_create_tree(handle, &gic_irq_domain_ops,
 						 &gic_data);
 	gic_data.rdists.rdist = alloc_percpu(typeof(*gic_data.rdists.rdist));
-	gic_data.rdists.has_rvpeid = true;
-	gic_data.rdists.has_vlpis = true;
-	gic_data.rdists.has_direct_lpi = true;
-	gic_data.rdists.has_vpend_valid_dirty = true;
+	if (!static_branch_unlikely(&gic_nvidia_t241_erratum)) {
+		/* Disable GICv4.x features for the erratum T241-FABRIC-4 */
+		gic_data.rdists.has_rvpeid = true;
+		gic_data.rdists.has_vlpis = true;
+		gic_data.rdists.has_direct_lpi = true;
+		gic_data.rdists.has_vpend_valid_dirty = true;
+	}
 
 	if (WARN_ON(!gic_data.domain) || WARN_ON(!gic_data.rdists.rdist)) {
 		err = -ENOMEM;
@@ -2050,6 +2139,7 @@ static void __iomem *gic_of_iomap(struct device_node *node, int idx,
 
 static int __init gic_of_init(struct device_node *node, struct device_node *parent)
 {
+	phys_addr_t dist_phys_base;
 	void __iomem *dist_base;
 	struct redist_region *rdist_regs;
 	struct resource res;
@@ -2063,6 +2153,8 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 		return PTR_ERR(dist_base);
 	}
 
+	dist_phys_base = res.start;
+
 	err = gic_validate_dist_version(dist_base);
 	if (err) {
 		pr_err("%pOF: no distributor detected, giving up\n", node);
@@ -2094,8 +2186,8 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 
 	gic_enable_of_quirks(node, gic_quirks, &gic_data);
 
-	err = gic_init_bases(dist_base, rdist_regs, nr_redist_regions,
-			     redist_stride, &node->fwnode);
+	err = gic_init_bases(dist_phys_base, dist_base, rdist_regs,
+			     nr_redist_regions, redist_stride, &node->fwnode);
 	if (err)
 		goto out_unmap_rdist;
 
@@ -2411,8 +2503,9 @@ gic_acpi_init(union acpi_subtable_headers *header, const unsigned long end)
 		goto out_redist_unmap;
 	}
 
-	err = gic_init_bases(acpi_data.dist_base, acpi_data.redist_regs,
-			     acpi_data.nr_redist_regions, 0, gsi_domain_handle);
+	err = gic_init_bases(dist->base_address, acpi_data.dist_base,
+			     acpi_data.redist_regs, acpi_data.nr_redist_regions,
+			     0, gsi_domain_handle);
 	if (err)
 		goto out_fwhandle_free;
 
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 220c8c6..f196c19 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -227,6 +227,24 @@ void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit);
 extern u64 smccc_has_sve_hint;
 
 /**
+ * arm_smccc_get_soc_id_version()
+ *
+ * Returns the SOC ID version.
+ *
+ * When ARM_SMCCC_ARCH_SOC_ID is not present, returns SMCCC_RET_NOT_SUPPORTED.
+ */
+s32 arm_smccc_get_soc_id_version(void);
+
+/**
+ * arm_smccc_get_soc_id_revision()
+ *
+ * Returns the SOC ID revision.
+ *
+ * When ARM_SMCCC_ARCH_SOC_ID is not present, returns SMCCC_RET_NOT_SUPPORTED.
+ */
+s32 arm_smccc_get_soc_id_revision(void);
+
+/**
  * struct arm_smccc_res - Result from SMC/HVC call
  * @a0-a3 result values from registers 0 to 3
  */
