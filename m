Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B5C69C9ED
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjBTLdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjBTLdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:33:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A4C61A9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 03:32:54 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676892773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=92TRsDP8VIF6zbg/oLVIEjgN2ClLsaRZ9Lvj8cB7NH0=;
        b=TJHG+X8RIsdRQtk0O7BPYIQqRV5Luj+2IcDLSVypVrCRdSg/5UFe/guOzfAU55qUgChd+v
        fjiR1bJVHTHILlLTQ5n1vS7UbBPecIOZfzpgk3x959pL2aDFFVde+lFzCXvZ81maTTXpVz
        QANRjDAWuOroUro+Tyc1PElFpcq1JPaphQpM7vN9MBuANNd/lIaR52UdEAtrjxMB/LEVFP
        dngVQXb1Vkz6Gjbb+cHEgpdo49rK1/il/xabEAMs4HchaR0DumWKwB3x+j/W5A88anZUsZ
        5zwROYc29Z7kIKIUJxdgveinQIN3TnOV3gZiwBBZ/7xlvg4AewGMfTGsd1Wc0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676892773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=92TRsDP8VIF6zbg/oLVIEjgN2ClLsaRZ9Lvj8cB7NH0=;
        b=ToqTIJZs5wsorTtgZ5pYoCHaqkV2SP2XwghTb0qkOmHStHPVZ4MLUhrqsXR1wekfG231dE
        PtjwRU2iLRvrysCA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/core for v6.3-rc1
Message-ID: <167689254797.295764.1600565060995031919.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 20 Feb 2023 12:32:52 +0100 (CET)
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

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2023-02=
-20

up to:  6f3ee0e22b4c: Merge tag 'irqchip-6.3' of git://git.kernel.org/pub/scm=
/linux/kernel/git/maz/arm-platforms into irq/core


Updates for the interrupt subsystem:

  Core:

    - Move the interrupt affinity spreading mechanism into lib/group_cpus
      so it can be used for similar spreading requirements, e.g. in the
      block multi-queue code.

      This also contains a first usecase in the block multi-queue code which
      Jens asked to take along with the librarization.

    - Improve irqdomain locking to close a number race conditions which
      can be observed with massive parallel device driver probing.

    - Enforce and document the semantics of disable_irq() which cannot be
      invoked safely from non-sleepable context.

    - Move the IPI multiplexing code from the Apple AIC driver into the
      core. so it can be reused by RISCV.

  Drivers:

    - Plug OF node refcounting leaks in various drivers.

    - Correctly mark level triggered interrupts in the Broadcom L2 drivers.

    - The usual small fixes and improvements.

    - No new drivers for the record!

Thanks,

	tglx

------------------>
Alexander Sverdlin (1):
      docs: locking: Discourage from calling disable_irq() in atomic

Anup Patel (1):
      genirq: Add mechanism to multiplex a single HW IPI

Florian Fainelli (2):
      irqchip/irq-brcmstb-l2: Set IRQ_LEVEL for level triggered interrupts
      irqchip/irq-bcm7120-l2: Set IRQ_LEVEL for level triggered interrupts

Huacai Chen (1):
      irqchip/loongson-liointc: Save/restore int_edge/int_pol registers durin=
g S3/S4

Ingo Molnar (1):
      genirq/affinity: Only build SMP-only helper functions on SMP kernels

Johan Hovold (20):
      irqchip: Use irq_domain_alloc_irqs()
      irqdomain: Fix association race
      irqdomain: Fix disassociation race
      irqdomain: Drop bogus fwspec-mapping error handling
      irqdomain: Look for existing mapping only once
      irqdomain: Refactor __irq_domain_alloc_irqs()
      irqdomain: Fix mapping-creation race
      irqdomain: Drop revmap mutex
      irqdomain: Drop dead domain-name assignment
      irqdomain: Drop leftover brackets
      irqdomain: Clean up irq_domain_push/pop_irq()
      x86/ioapic: Use irq_domain_create_hierarchy()
      x86/uv: Use irq_domain_create_hierarchy()
      irqchip/alpine-msi: Use irq_domain_add_hierarchy()
      irqchip/gic-v2m: Use irq_domain_create_hierarchy()
      irqchip/gic-v3-its: Use irq_domain_create_hierarchy()
      irqchip/gic-v3-mbi: Use irq_domain_create_hierarchy()
      irqchip/loongson-pch-msi: Use irq_domain_create_hierarchy()
      irqchip/mvebu-odmi: Use irq_domain_create_hierarchy()
      irqdomain: Switch to per-domain locking

Lukas Bulwahn (1):
      irqchip/ls-scfg-msi: Simplify Kconfig dependencies

Manfred Spraul (1):
      genirq: Add might_sleep() to disable_irq()

Marc Zyngier (3):
      irqchip/apple-aic: Move over to core ipi-mux
      genirq/ipi-mux: Use irq_domain_alloc_irqs()
      irqdomain: Fix domain registration race

Miaoqian Lin (4):
      irqchip: Fix refcount leak in platform_irqchip_probe
      irqchip/alpine-msi: Fix refcount leak in alpine_msix_init_domains
      irqchip/irq-mvebu-gicp: Fix refcount leak in mvebu_gicp_probe
      irqchip/ti-sci: Fix refcount leak in ti_sci_intr_irq_domain_probe

Ming Lei (6):
      genirq/affinity: Remove the 'firstvec' parameter from irq_build_affinit=
y_masks
      genirq/affinity: Pass affinity managed mask array to irq_build_affinity=
_masks
      genirq/affinity: Don't pass irq_affinity_desc array to irq_build_affini=
ty_masks
      genirq/affinity: Rename irq_build_affinity_masks as group_cpus_evenly
      genirq/affinity: Move group_cpus_evenly() into lib/
      blk-mq: Build default queue map via group_cpus_evenly()

Ryan Chen (1):
      irqchip/aspeed-scu-ic: Correctly initialise status and enable registers


 Documentation/kernel-hacking/locking.rst           |   4 +-
 .../translations/it_IT/kernel-hacking/locking.rst  |   4 +-
 MAINTAINERS                                        |   2 +
 arch/x86/kernel/apic/io_apic.c                     |   7 +-
 arch/x86/platform/uv/uv_irq.c                      |   7 +-
 block/blk-mq-cpumap.c                              |  63 +--
 drivers/irqchip/Kconfig                            |   3 +-
 drivers/irqchip/irq-alpine-msi.c                   |   9 +-
 drivers/irqchip/irq-apple-aic.c                    | 161 +-------
 drivers/irqchip/irq-armada-370-xp.c                |   3 +-
 drivers/irqchip/irq-aspeed-scu-ic.c                |   5 +-
 drivers/irqchip/irq-bcm2836.c                      |   5 +-
 drivers/irqchip/irq-bcm7120-l2.c                   |   3 +-
 drivers/irqchip/irq-brcmstb-l2.c                   |   6 +-
 drivers/irqchip/irq-gic-v2m.c                      |   5 +-
 drivers/irqchip/irq-gic-v3-its.c                   |  13 +-
 drivers/irqchip/irq-gic-v3-mbi.c                   |   5 +-
 drivers/irqchip/irq-gic-v3.c                       |   4 +-
 drivers/irqchip/irq-gic-v4.c                       |   9 +-
 drivers/irqchip/irq-gic.c                          |   4 +-
 drivers/irqchip/irq-loongson-liointc.c             |  13 +
 drivers/irqchip/irq-loongson-pch-msi.c             |   9 +-
 drivers/irqchip/irq-mvebu-gicp.c                   |   1 +
 drivers/irqchip/irq-mvebu-odmi.c                   |  13 +-
 drivers/irqchip/irq-ti-sci-intr.c                  |   1 +
 drivers/irqchip/irqchip.c                          |   8 +-
 include/linux/group_cpus.h                         |  14 +
 include/linux/irq.h                                |   3 +
 include/linux/irqdomain.h                          |   6 +-
 kernel/irq/Kconfig                                 |   5 +
 kernel/irq/Makefile                                |   1 +
 kernel/irq/affinity.c                              | 405 +------------------
 kernel/irq/ipi-mux.c                               | 206 ++++++++++
 kernel/irq/irqdomain.c                             | 408 ++++++++++++--------
 kernel/irq/manage.c                                |   5 +-
 lib/Makefile                                       |   2 +
 lib/group_cpus.c                                   | 428 +++++++++++++++++++=
++
 37 files changed, 1020 insertions(+), 830 deletions(-)
 create mode 100644 include/linux/group_cpus.h
 create mode 100644 kernel/irq/ipi-mux.c
 create mode 100644 lib/group_cpus.c

diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-=
hacking/locking.rst
index c756786e17ae..dff0646a717b 100644
--- a/Documentation/kernel-hacking/locking.rst
+++ b/Documentation/kernel-hacking/locking.rst
@@ -1277,11 +1277,11 @@ Manfred Spraul points out that you can still do this,=
 even if the data
 is very occasionally accessed in user context or softirqs/tasklets. The
 irq handler doesn't use a lock, and all other accesses are done as so::
=20
-        spin_lock(&lock);
+        mutex_lock(&lock);
         disable_irq(irq);
         ...
         enable_irq(irq);
-        spin_unlock(&lock);
+        mutex_unlock(&lock);
=20
 The disable_irq() prevents the irq handler from running
 (and waits for it to finish if it's currently running on other CPUs).
diff --git a/Documentation/translations/it_IT/kernel-hacking/locking.rst b/Do=
cumentation/translations/it_IT/kernel-hacking/locking.rst
index b8ecf41273c5..05d362b16bf0 100644
--- a/Documentation/translations/it_IT/kernel-hacking/locking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/locking.rst
@@ -1307,11 +1307,11 @@ se i dati vengono occasionalmente utilizzati da un co=
ntesto utente o
 da un'interruzione software. Il gestore d'interruzione non utilizza alcun
 *lock*, e tutti gli altri accessi verranno fatti cos=C3=AC::
=20
-        spin_lock(&lock);
+        mutex_lock(&lock);
         disable_irq(irq);
         ...
         enable_irq(irq);
-        spin_unlock(&lock);
+        mutex_unlock(&lock);
=20
 La funzione disable_irq() impedisce al gestore d'interruzioni
 d'essere eseguito (e aspetta che finisca nel caso fosse in esecuzione su
diff --git a/MAINTAINERS b/MAINTAINERS
index 42fc47c6edfd..cb4748840195 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10935,6 +10935,8 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
 F:	kernel/irq/
+F:	include/linux/group_cpus.h
+F:	lib/group_cpus.c
=20
 IRQCHIP DRIVERS
 M:	Thomas Gleixner <tglx@linutronix.de>
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index a868b76cd3d4..1f83b052bb74 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2364,9 +2364,8 @@ static int mp_irqdomain_create(int ioapic)
 		return -ENODEV;
 	}
=20
-	ip->irqdomain =3D irq_domain_create_linear(fn, hwirqs, cfg->ops,
-						 (void *)(long)ioapic);
-
+	ip->irqdomain =3D irq_domain_create_hierarchy(parent, 0, hwirqs, fn, cfg->o=
ps,
+						    (void *)(long)ioapic);
 	if (!ip->irqdomain) {
 		/* Release fw handle if it was allocated above */
 		if (!cfg->dev)
@@ -2374,8 +2373,6 @@ static int mp_irqdomain_create(int ioapic)
 		return -ENOMEM;
 	}
=20
-	ip->irqdomain->parent =3D parent;
-
 	if (cfg->type =3D=3D IOAPIC_DOMAIN_LEGACY ||
 	    cfg->type =3D=3D IOAPIC_DOMAIN_STRICT)
 		ioapic_dynirq_base =3D max(ioapic_dynirq_base,
diff --git a/arch/x86/platform/uv/uv_irq.c b/arch/x86/platform/uv/uv_irq.c
index 1a536a187d74..ee21d6a36a80 100644
--- a/arch/x86/platform/uv/uv_irq.c
+++ b/arch/x86/platform/uv/uv_irq.c
@@ -166,10 +166,9 @@ static struct irq_domain *uv_get_irq_domain(void)
 	if (!fn)
 		goto out;
=20
-	uv_domain =3D irq_domain_create_tree(fn, &uv_domain_ops, NULL);
-	if (uv_domain)
-		uv_domain->parent =3D x86_vector_domain;
-	else
+	uv_domain =3D irq_domain_create_hierarchy(x86_vector_domain, 0, 0, fn,
+						&uv_domain_ops, NULL);
+	if (!uv_domain)
 		irq_domain_free_fwnode(fn);
 out:
 	mutex_unlock(&uv_lock);
diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 9c2fce1a7b50..0c612c19feb8 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -10,66 +10,29 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/cpu.h>
+#include <linux/group_cpus.h>
=20
 #include <linux/blk-mq.h>
 #include "blk.h"
 #include "blk-mq.h"
=20
-static int queue_index(struct blk_mq_queue_map *qmap,
-		       unsigned int nr_queues, const int q)
-{
-	return qmap->queue_offset + (q % nr_queues);
-}
-
-static int get_first_sibling(unsigned int cpu)
-{
-	unsigned int ret;
-
-	ret =3D cpumask_first(topology_sibling_cpumask(cpu));
-	if (ret < nr_cpu_ids)
-		return ret;
-
-	return cpu;
-}
-
 void blk_mq_map_queues(struct blk_mq_queue_map *qmap)
 {
-	unsigned int *map =3D qmap->mq_map;
-	unsigned int nr_queues =3D qmap->nr_queues;
-	unsigned int cpu, first_sibling, q =3D 0;
-
-	for_each_possible_cpu(cpu)
-		map[cpu] =3D -1;
-
-	/*
-	 * Spread queues among present CPUs first for minimizing
-	 * count of dead queues which are mapped by all un-present CPUs
-	 */
-	for_each_present_cpu(cpu) {
-		if (q >=3D nr_queues)
-			break;
-		map[cpu] =3D queue_index(qmap, nr_queues, q++);
+	const struct cpumask *masks;
+	unsigned int queue, cpu;
+
+	masks =3D group_cpus_evenly(qmap->nr_queues);
+	if (!masks) {
+		for_each_possible_cpu(cpu)
+			qmap->mq_map[cpu] =3D qmap->queue_offset;
+		return;
 	}
=20
-	for_each_possible_cpu(cpu) {
-		if (map[cpu] !=3D -1)
-			continue;
-		/*
-		 * First do sequential mapping between CPUs and queues.
-		 * In case we still have CPUs to map, and we have some number of
-		 * threads per cores then map sibling threads to the same queue
-		 * for performance optimizations.
-		 */
-		if (q < nr_queues) {
-			map[cpu] =3D queue_index(qmap, nr_queues, q++);
-		} else {
-			first_sibling =3D get_first_sibling(cpu);
-			if (first_sibling =3D=3D cpu)
-				map[cpu] =3D queue_index(qmap, nr_queues, q++);
-			else
-				map[cpu] =3D map[first_sibling];
-		}
+	for (queue =3D 0; queue < qmap->nr_queues; queue++) {
+		for_each_cpu(cpu, &masks[queue])
+			qmap->mq_map[cpu] =3D qmap->queue_offset + queue;
 	}
+	kfree(masks);
 }
 EXPORT_SYMBOL_GPL(blk_mq_map_queues);
=20
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index caa952c40ff9..7abdb98f805d 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -389,7 +389,7 @@ config LS_EXTIRQ
=20
 config LS_SCFG_MSI
 	def_bool y if SOC_LS1021A || ARCH_LAYERSCAPE
-	depends on PCI && PCI_MSI
+	depends on PCI_MSI
=20
 config PARTITION_PERCPU
 	bool
@@ -658,6 +658,7 @@ config APPLE_AIC
 	bool "Apple Interrupt Controller (AIC)"
 	depends on ARM64
 	depends on ARCH_APPLE || COMPILE_TEST
+	select GENERIC_IRQ_IPI_MUX
 	help
 	  Support for the Apple Interrupt Controller found on Apple Silicon SoCs,
 	  such as the M1.
diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpine-ms=
i.c
index 5ddb8e578ac6..9c8b1349ee17 100644
--- a/drivers/irqchip/irq-alpine-msi.c
+++ b/drivers/irqchip/irq-alpine-msi.c
@@ -199,21 +199,20 @@ static int alpine_msix_init_domains(struct alpine_msix_=
data *priv,
 	}
=20
 	gic_domain =3D irq_find_host(gic_node);
+	of_node_put(gic_node);
 	if (!gic_domain) {
 		pr_err("Failed to find the GIC domain\n");
 		return -ENXIO;
 	}
=20
-	middle_domain =3D irq_domain_add_tree(NULL,
-					    &alpine_msix_middle_domain_ops,
-					    priv);
+	middle_domain =3D irq_domain_add_hierarchy(gic_domain, 0, 0, NULL,
+						 &alpine_msix_middle_domain_ops,
+						 priv);
 	if (!middle_domain) {
 		pr_err("Failed to create the MSIX middle domain\n");
 		return -ENOMEM;
 	}
=20
-	middle_domain->parent =3D gic_domain;
-
 	msi_domain =3D pci_msi_create_irq_domain(of_node_to_fwnode(node),
 					       &alpine_msix_domain_info,
 					       middle_domain);
diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index ae3437f03e6c..eabb3b92965b 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -292,7 +292,6 @@ struct aic_irq_chip {
 	void __iomem *base;
 	void __iomem *event;
 	struct irq_domain *hw_domain;
-	struct irq_domain *ipi_domain;
 	struct {
 		cpumask_t aff;
 	} *fiq_aff[AIC_NR_FIQ];
@@ -307,9 +306,6 @@ struct aic_irq_chip {
=20
 static DEFINE_PER_CPU(uint32_t, aic_fiq_unmasked);
=20
-static DEFINE_PER_CPU(atomic_t, aic_vipi_flag);
-static DEFINE_PER_CPU(atomic_t, aic_vipi_enable);
-
 static struct aic_irq_chip *aic_irqc;
=20
 static void aic_handle_ipi(struct pt_regs *regs);
@@ -751,98 +747,8 @@ static void aic_ipi_send_fast(int cpu)
 	isb();
 }
=20
-static void aic_ipi_mask(struct irq_data *d)
-{
-	u32 irq_bit =3D BIT(irqd_to_hwirq(d));
-
-	/* No specific ordering requirements needed here. */
-	atomic_andnot(irq_bit, this_cpu_ptr(&aic_vipi_enable));
-}
-
-static void aic_ipi_unmask(struct irq_data *d)
-{
-	struct aic_irq_chip *ic =3D irq_data_get_irq_chip_data(d);
-	u32 irq_bit =3D BIT(irqd_to_hwirq(d));
-
-	atomic_or(irq_bit, this_cpu_ptr(&aic_vipi_enable));
-
-	/*
-	 * The atomic_or() above must complete before the atomic_read()
-	 * below to avoid racing aic_ipi_send_mask().
-	 */
-	smp_mb__after_atomic();
-
-	/*
-	 * If a pending vIPI was unmasked, raise a HW IPI to ourselves.
-	 * No barriers needed here since this is a self-IPI.
-	 */
-	if (atomic_read(this_cpu_ptr(&aic_vipi_flag)) & irq_bit) {
-		if (static_branch_likely(&use_fast_ipi))
-			aic_ipi_send_fast(smp_processor_id());
-		else
-			aic_ic_write(ic, AIC_IPI_SEND, AIC_IPI_SEND_CPU(smp_processor_id()));
-	}
-}
-
-static void aic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
-{
-	struct aic_irq_chip *ic =3D irq_data_get_irq_chip_data(d);
-	u32 irq_bit =3D BIT(irqd_to_hwirq(d));
-	u32 send =3D 0;
-	int cpu;
-	unsigned long pending;
-
-	for_each_cpu(cpu, mask) {
-		/*
-		 * This sequence is the mirror of the one in aic_ipi_unmask();
-		 * see the comment there. Additionally, release semantics
-		 * ensure that the vIPI flag set is ordered after any shared
-		 * memory accesses that precede it. This therefore also pairs
-		 * with the atomic_fetch_andnot in aic_handle_ipi().
-		 */
-		pending =3D atomic_fetch_or_release(irq_bit, per_cpu_ptr(&aic_vipi_flag, c=
pu));
-
-		/*
-		 * The atomic_fetch_or_release() above must complete before the
-		 * atomic_read() below to avoid racing aic_ipi_unmask().
-		 */
-		smp_mb__after_atomic();
-
-		if (!(pending & irq_bit) &&
-		    (atomic_read(per_cpu_ptr(&aic_vipi_enable, cpu)) & irq_bit)) {
-			if (static_branch_likely(&use_fast_ipi))
-				aic_ipi_send_fast(cpu);
-			else
-				send |=3D AIC_IPI_SEND_CPU(cpu);
-		}
-	}
-
-	/*
-	 * The flag writes must complete before the physical IPI is issued
-	 * to another CPU. This is implied by the control dependency on
-	 * the result of atomic_read_acquire() above, which is itself
-	 * already ordered after the vIPI flag write.
-	 */
-	if (send)
-		aic_ic_write(ic, AIC_IPI_SEND, send);
-}
-
-static struct irq_chip ipi_chip =3D {
-	.name =3D "AIC-IPI",
-	.irq_mask =3D aic_ipi_mask,
-	.irq_unmask =3D aic_ipi_unmask,
-	.ipi_send_mask =3D aic_ipi_send_mask,
-};
-
-/*
- * IPI IRQ domain
- */
-
 static void aic_handle_ipi(struct pt_regs *regs)
 {
-	int i;
-	unsigned long enabled, firing;
-
 	/*
 	 * Ack the IPI. We need to order this after the AIC event read, but
 	 * that is enforced by normal MMIO ordering guarantees.
@@ -857,27 +763,7 @@ static void aic_handle_ipi(struct pt_regs *regs)
 		aic_ic_write(aic_irqc, AIC_IPI_ACK, AIC_IPI_OTHER);
 	}
=20
-	/*
-	 * The mask read does not need to be ordered. Only we can change
-	 * our own mask anyway, so no races are possible here, as long as
-	 * we are properly in the interrupt handler (which is covered by
-	 * the barrier that is part of the top-level AIC handler's readl()).
-	 */
-	enabled =3D atomic_read(this_cpu_ptr(&aic_vipi_enable));
-
-	/*
-	 * Clear the IPIs we are about to handle. This pairs with the
-	 * atomic_fetch_or_release() in aic_ipi_send_mask(), and needs to be
-	 * ordered after the aic_ic_write() above (to avoid dropping vIPIs) and
-	 * before IPI handling code (to avoid races handling vIPIs before they
-	 * are signaled). The former is taken care of by the release semantics
-	 * of the write portion, while the latter is taken care of by the
-	 * acquire semantics of the read portion.
-	 */
-	firing =3D atomic_fetch_andnot(enabled, this_cpu_ptr(&aic_vipi_flag)) & ena=
bled;
-
-	for_each_set_bit(i, &firing, AIC_NR_SWIPI)
-		generic_handle_domain_irq(aic_irqc->ipi_domain, i);
+	ipi_mux_process();
=20
 	/*
 	 * No ordering needed here; at worst this just changes the timing of
@@ -887,55 +773,24 @@ static void aic_handle_ipi(struct pt_regs *regs)
 		aic_ic_write(aic_irqc, AIC_IPI_MASK_CLR, AIC_IPI_OTHER);
 }
=20
-static int aic_ipi_alloc(struct irq_domain *d, unsigned int virq,
-			 unsigned int nr_irqs, void *args)
+static void aic_ipi_send_single(unsigned int cpu)
 {
-	int i;
-
-	for (i =3D 0; i < nr_irqs; i++) {
-		irq_set_percpu_devid(virq + i);
-		irq_domain_set_info(d, virq + i, i, &ipi_chip, d->host_data,
-				    handle_percpu_devid_irq, NULL, NULL);
-	}
-
-	return 0;
-}
-
-static void aic_ipi_free(struct irq_domain *d, unsigned int virq, unsigned i=
nt nr_irqs)
-{
-	/* Not freeing IPIs */
+	if (static_branch_likely(&use_fast_ipi))
+		aic_ipi_send_fast(cpu);
+	else
+		aic_ic_write(aic_irqc, AIC_IPI_SEND, AIC_IPI_SEND_CPU(cpu));
 }
=20
-static const struct irq_domain_ops aic_ipi_domain_ops =3D {
-	.alloc =3D aic_ipi_alloc,
-	.free =3D aic_ipi_free,
-};
-
 static int __init aic_init_smp(struct aic_irq_chip *irqc, struct device_node=
 *node)
 {
-	struct irq_domain *ipi_domain;
 	int base_ipi;
=20
-	ipi_domain =3D irq_domain_create_linear(irqc->hw_domain->fwnode, AIC_NR_SWI=
PI,
-					      &aic_ipi_domain_ops, irqc);
-	if (WARN_ON(!ipi_domain))
-		return -ENODEV;
-
-	ipi_domain->flags |=3D IRQ_DOMAIN_FLAG_IPI_SINGLE;
-	irq_domain_update_bus_token(ipi_domain, DOMAIN_BUS_IPI);
-
-	base_ipi =3D __irq_domain_alloc_irqs(ipi_domain, -1, AIC_NR_SWIPI,
-					   NUMA_NO_NODE, NULL, false, NULL);
-
-	if (WARN_ON(!base_ipi)) {
-		irq_domain_remove(ipi_domain);
+	base_ipi =3D ipi_mux_create(AIC_NR_SWIPI, aic_ipi_send_single);
+	if (WARN_ON(base_ipi <=3D 0))
 		return -ENODEV;
-	}
=20
 	set_smp_ipi_range(base_ipi, AIC_NR_SWIPI);
=20
-	irqc->ipi_domain =3D ipi_domain;
-
 	return 0;
 }
=20
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index ee18eb3e72b7..a55528469278 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -454,8 +454,7 @@ static __init void armada_xp_ipi_init(struct device_node =
*node)
 		return;
=20
 	irq_domain_update_bus_token(ipi_domain, DOMAIN_BUS_IPI);
-	base_ipi =3D __irq_domain_alloc_irqs(ipi_domain, -1, IPI_DOORBELL_END,
-					   NUMA_NO_NODE, NULL, false, NULL);
+	base_ipi =3D irq_domain_alloc_irqs(ipi_domain, IPI_DOORBELL_END, NUMA_NO_NO=
DE, NULL);
 	if (WARN_ON(!base_ipi))
 		return;
=20
diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed=
-scu-ic.c
index 279e92cf0b16..94a7223e95df 100644
--- a/drivers/irqchip/irq-aspeed-scu-ic.c
+++ b/drivers/irqchip/irq-aspeed-scu-ic.c
@@ -17,8 +17,9 @@
=20
 #define ASPEED_SCU_IC_REG		0x018
 #define ASPEED_SCU_IC_SHIFT		0
-#define ASPEED_SCU_IC_ENABLE		GENMASK(6, ASPEED_SCU_IC_SHIFT)
+#define ASPEED_SCU_IC_ENABLE		GENMASK(15, ASPEED_SCU_IC_SHIFT)
 #define ASPEED_SCU_IC_NUM_IRQS		7
+#define ASPEED_SCU_IC_STATUS		GENMASK(28, 16)
 #define ASPEED_SCU_IC_STATUS_SHIFT	16
=20
 #define ASPEED_AST2600_SCU_IC0_REG	0x560
@@ -155,6 +156,8 @@ static int aspeed_scu_ic_of_init_common(struct aspeed_scu=
_ic *scu_ic,
 		rc =3D PTR_ERR(scu_ic->scu);
 		goto err;
 	}
+	regmap_write_bits(scu_ic->scu, scu_ic->reg, ASPEED_SCU_IC_STATUS, ASPEED_SC=
U_IC_STATUS);
+	regmap_write_bits(scu_ic->scu, scu_ic->reg, ASPEED_SCU_IC_ENABLE, 0);
=20
 	irq =3D irq_of_parse_and_map(node, 0);
 	if (!irq) {
diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index 51491c3c6fdd..e5f1059b989f 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -268,10 +268,7 @@ static void __init bcm2836_arm_irqchip_smp_init(void)
 	ipi_domain->flags |=3D IRQ_DOMAIN_FLAG_IPI_SINGLE;
 	irq_domain_update_bus_token(ipi_domain, DOMAIN_BUS_IPI);
=20
-	base_ipi =3D __irq_domain_alloc_irqs(ipi_domain, -1, BITS_PER_MBOX,
-					   NUMA_NO_NODE, NULL,
-					   false, NULL);
-
+	base_ipi =3D irq_domain_alloc_irqs(ipi_domain, BITS_PER_MBOX, NUMA_NO_NODE,=
 NULL);
 	if (WARN_ON(!base_ipi))
 		return;
=20
diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l=
2.c
index bb6609cebdbc..1e9dab6e0d86 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -279,7 +279,8 @@ static int __init bcm7120_l2_intc_probe(struct device_nod=
e *dn,
 		flags |=3D IRQ_GC_BE_IO;
=20
 	ret =3D irq_alloc_domain_generic_chips(data->domain, IRQS_PER_WORD, 1,
-				dn->full_name, handle_level_irq, clr, 0, flags);
+				dn->full_name, handle_level_irq, clr,
+				IRQ_LEVEL, flags);
 	if (ret) {
 		pr_err("failed to allocate generic irq chip\n");
 		goto out_free_domain;
diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l=
2.c
index e4efc08ac594..091b0fe7e324 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -161,6 +161,7 @@ static int __init brcmstb_l2_intc_of_init(struct device_n=
ode *np,
 					  *init_params)
 {
 	unsigned int clr =3D IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
+	unsigned int set =3D 0;
 	struct brcmstb_l2_intc_data *data;
 	struct irq_chip_type *ct;
 	int ret;
@@ -208,9 +209,12 @@ static int __init brcmstb_l2_intc_of_init(struct device_=
node *np,
 	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
 		flags |=3D IRQ_GC_BE_IO;
=20
+	if (init_params->handler =3D=3D handle_level_irq)
+		set |=3D IRQ_LEVEL;
+
 	/* Allocate a single Generic IRQ chip for this node */
 	ret =3D irq_alloc_domain_generic_chips(data->domain, 32, 1,
-			np->full_name, init_params->handler, clr, 0, flags);
+			np->full_name, init_params->handler, clr, set, flags);
 	if (ret) {
 		pr_err("failed to allocate generic irq chip\n");
 		goto out_free_domain;
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index f4d7eeb13951..f1e75b35a52a 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -287,15 +287,14 @@ static __init int gicv2m_allocate_domains(struct irq_do=
main *parent)
 	if (!v2m)
 		return 0;
=20
-	inner_domain =3D irq_domain_create_tree(v2m->fwnode,
-					      &gicv2m_domain_ops, v2m);
+	inner_domain =3D irq_domain_create_hierarchy(parent, 0, 0, v2m->fwnode,
+						   &gicv2m_domain_ops, v2m);
 	if (!inner_domain) {
 		pr_err("Failed to create GICv2m domain\n");
 		return -ENOMEM;
 	}
=20
 	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_NEXUS);
-	inner_domain->parent =3D parent;
 	pci_domain =3D pci_msi_create_irq_domain(v2m->fwnode,
 					       &gicv2m_msi_domain_info,
 					       inner_domain);
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-it=
s.c
index 973ede0197e3..5634d29b644d 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4909,18 +4909,19 @@ static int its_init_domain(struct fwnode_handle *hand=
le, struct its_node *its)
 	if (!info)
 		return -ENOMEM;
=20
-	inner_domain =3D irq_domain_create_tree(handle, &its_domain_ops, its);
+	info->ops =3D &its_msi_domain_ops;
+	info->data =3D its;
+
+	inner_domain =3D irq_domain_create_hierarchy(its_parent,
+						   its->msi_domain_flags, 0,
+						   handle, &its_domain_ops,
+						   info);
 	if (!inner_domain) {
 		kfree(info);
 		return -ENOMEM;
 	}
=20
-	inner_domain->parent =3D its_parent;
 	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_NEXUS);
-	inner_domain->flags |=3D its->msi_domain_flags;
-	info->ops =3D &its_msi_domain_ops;
-	info->data =3D its;
-	inner_domain->host_data =3D info;
=20
 	return 0;
 }
diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mb=
i.c
index e1efdec9e9ac..dbb8b1efda44 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -233,13 +233,12 @@ static int mbi_allocate_domains(struct irq_domain *pare=
nt)
 	struct irq_domain *nexus_domain, *pci_domain, *plat_domain;
 	int err;
=20
-	nexus_domain =3D irq_domain_create_tree(parent->fwnode,
-					      &mbi_domain_ops, NULL);
+	nexus_domain =3D irq_domain_create_hierarchy(parent, 0, 0, parent->fwnode,
+						   &mbi_domain_ops, NULL);
 	if (!nexus_domain)
 		return -ENOMEM;
=20
 	irq_domain_update_bus_token(nexus_domain, DOMAIN_BUS_NEXUS);
-	nexus_domain->parent =3D parent;
=20
 	err =3D mbi_allocate_pci_domain(nexus_domain, &pci_domain);
=20
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 997104d4338e..bb57ab8bff6a 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1310,9 +1310,7 @@ static void __init gic_smp_init(void)
 				  gic_starting_cpu, NULL);
=20
 	/* Register all 8 non-secure SGIs */
-	base_sgi =3D __irq_domain_alloc_irqs(gic_data.domain, -1, 8,
-					   NUMA_NO_NODE, &sgi_fwspec,
-					   false, NULL);
+	base_sgi =3D irq_domain_alloc_irqs(gic_data.domain, 8, NUMA_NO_NODE, &sgi_f=
wspec);
 	if (WARN_ON(base_sgi <=3D 0))
 		return;
=20
diff --git a/drivers/irqchip/irq-gic-v4.c b/drivers/irqchip/irq-gic-v4.c
index a6277dea4c7a..94d56a03b175 100644
--- a/drivers/irqchip/irq-gic-v4.c
+++ b/drivers/irqchip/irq-gic-v4.c
@@ -139,9 +139,7 @@ static int its_alloc_vcpu_sgis(struct its_vpe *vpe, int i=
dx)
 	if (!vpe->sgi_domain)
 		goto err;
=20
-	sgi_base =3D __irq_domain_alloc_irqs(vpe->sgi_domain, -1, 16,
-					       NUMA_NO_NODE, vpe,
-					       false, NULL);
+	sgi_base =3D irq_domain_alloc_irqs(vpe->sgi_domain, 16, NUMA_NO_NODE, vpe);
 	if (sgi_base <=3D 0)
 		goto err;
=20
@@ -176,9 +174,8 @@ int its_alloc_vcpu_irqs(struct its_vm *vm)
 		vm->vpes[i]->idai =3D true;
 	}
=20
-	vpe_base_irq =3D __irq_domain_alloc_irqs(vm->domain, -1, vm->nr_vpes,
-					       NUMA_NO_NODE, vm,
-					       false, NULL);
+	vpe_base_irq =3D irq_domain_alloc_irqs(vm->domain, vm->nr_vpes,
+					     NUMA_NO_NODE, vm);
 	if (vpe_base_irq <=3D 0)
 		goto err;
=20
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 210bc2f4d555..4fa4d8ac76d9 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -868,9 +868,7 @@ static __init void gic_smp_init(void)
 				  "irqchip/arm/gic:starting",
 				  gic_starting_cpu, NULL);
=20
-	base_sgi =3D __irq_domain_alloc_irqs(gic_data[0].domain, -1, 8,
-					   NUMA_NO_NODE, &sgi_fwspec,
-					   false, NULL);
+	base_sgi =3D irq_domain_alloc_irqs(gic_data[0].domain, 8, NUMA_NO_NODE, &sg=
i_fwspec);
 	if (WARN_ON(base_sgi <=3D 0))
 		return;
=20
diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loo=
ngson-liointc.c
index 85b754f7f4e6..8d00a9ad5b00 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -55,6 +55,8 @@ struct liointc_priv {
 	struct liointc_handler_data	handler[LIOINTC_NUM_PARENT];
 	void __iomem			*core_isr[LIOINTC_NUM_CORES];
 	u8				map_cache[LIOINTC_CHIP_IRQ];
+	u32				int_pol;
+	u32				int_edge;
 	bool				has_lpc_irq_errata;
 };
=20
@@ -138,6 +140,14 @@ static int liointc_set_type(struct irq_data *data, unsig=
ned int type)
 	return 0;
 }
=20
+static void liointc_suspend(struct irq_chip_generic *gc)
+{
+	struct liointc_priv *priv =3D gc->private;
+
+	priv->int_pol =3D readl(gc->reg_base + LIOINTC_REG_INTC_POL);
+	priv->int_edge =3D readl(gc->reg_base + LIOINTC_REG_INTC_EDGE);
+}
+
 static void liointc_resume(struct irq_chip_generic *gc)
 {
 	struct liointc_priv *priv =3D gc->private;
@@ -150,6 +160,8 @@ static void liointc_resume(struct irq_chip_generic *gc)
 	/* Restore map cache */
 	for (i =3D 0; i < LIOINTC_CHIP_IRQ; i++)
 		writeb(priv->map_cache[i], gc->reg_base + i);
+	writel(priv->int_pol, gc->reg_base + LIOINTC_REG_INTC_POL);
+	writel(priv->int_edge, gc->reg_base + LIOINTC_REG_INTC_EDGE);
 	/* Restore mask cache */
 	writel(gc->mask_cache, gc->reg_base + LIOINTC_REG_INTC_ENABLE);
 	irq_gc_unlock_irqrestore(gc, flags);
@@ -269,6 +281,7 @@ static int liointc_init(phys_addr_t addr, unsigned long s=
ize, int revision,
 	gc->private =3D priv;
 	gc->reg_base =3D base;
 	gc->domain =3D domain;
+	gc->suspend =3D liointc_suspend;
 	gc->resume =3D liointc_resume;
=20
 	ct =3D gc->chip_types;
diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loo=
ngson-pch-msi.c
index a72ede90ffc6..6e1e1f011bb2 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -163,16 +163,15 @@ static int pch_msi_init_domains(struct pch_msi_data *pr=
iv,
 {
 	struct irq_domain *middle_domain, *msi_domain;
=20
-	middle_domain =3D irq_domain_create_linear(domain_handle,
-						priv->num_irqs,
-						&pch_msi_middle_domain_ops,
-						priv);
+	middle_domain =3D irq_domain_create_hierarchy(parent, 0, priv->num_irqs,
+						    domain_handle,
+						    &pch_msi_middle_domain_ops,
+						    priv);
 	if (!middle_domain) {
 		pr_err("Failed to create the MSI middle domain\n");
 		return -ENOMEM;
 	}
=20
-	middle_domain->parent =3D parent;
 	irq_domain_update_bus_token(middle_domain, DOMAIN_BUS_NEXUS);
=20
 	msi_domain =3D pci_msi_create_irq_domain(domain_handle,
diff --git a/drivers/irqchip/irq-mvebu-gicp.c b/drivers/irqchip/irq-mvebu-gic=
p.c
index fe88a782173d..c43a345061d5 100644
--- a/drivers/irqchip/irq-mvebu-gicp.c
+++ b/drivers/irqchip/irq-mvebu-gicp.c
@@ -221,6 +221,7 @@ static int mvebu_gicp_probe(struct platform_device *pdev)
 	}
=20
 	parent_domain =3D irq_find_host(irq_parent_dn);
+	of_node_put(irq_parent_dn);
 	if (!parent_domain) {
 		dev_err(&pdev->dev, "failed to find parent IRQ domain\n");
 		return -ENODEV;
diff --git a/drivers/irqchip/irq-mvebu-odmi.c b/drivers/irqchip/irq-mvebu-odm=
i.c
index dc4145abdd6f..108091533e10 100644
--- a/drivers/irqchip/irq-mvebu-odmi.c
+++ b/drivers/irqchip/irq-mvebu-odmi.c
@@ -161,7 +161,7 @@ static struct msi_domain_info odmi_msi_domain_info =3D {
 static int __init mvebu_odmi_init(struct device_node *node,
 				  struct device_node *parent)
 {
-	struct irq_domain *inner_domain, *plat_domain;
+	struct irq_domain *parent_domain, *inner_domain, *plat_domain;
 	int ret, i;
=20
 	if (of_property_read_u32(node, "marvell,odmi-frames", &odmis_count))
@@ -197,16 +197,17 @@ static int __init mvebu_odmi_init(struct device_node *n=
ode,
 		}
 	}
=20
-	inner_domain =3D irq_domain_create_linear(of_node_to_fwnode(node),
-						odmis_count * NODMIS_PER_FRAME,
-						&odmi_domain_ops, NULL);
+	parent_domain =3D irq_find_host(parent);
+
+	inner_domain =3D irq_domain_create_hierarchy(parent_domain, 0,
+						   odmis_count * NODMIS_PER_FRAME,
+						   of_node_to_fwnode(node),
+						   &odmi_domain_ops, NULL);
 	if (!inner_domain) {
 		ret =3D -ENOMEM;
 		goto err_unmap;
 	}
=20
-	inner_domain->parent =3D irq_find_host(parent);
-
 	plat_domain =3D platform_msi_create_irq_domain(of_node_to_fwnode(node),
 						     &odmi_msi_domain_info,
 						     inner_domain);
diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-i=
ntr.c
index fe8fad22bcf9..020ddf29efb8 100644
--- a/drivers/irqchip/irq-ti-sci-intr.c
+++ b/drivers/irqchip/irq-ti-sci-intr.c
@@ -236,6 +236,7 @@ static int ti_sci_intr_irq_domain_probe(struct platform_d=
evice *pdev)
 	}
=20
 	parent_domain =3D irq_find_host(parent_node);
+	of_node_put(parent_node);
 	if (!parent_domain) {
 		dev_err(dev, "Failed to find IRQ parent domain\n");
 		return -ENODEV;
diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
index 3570f0a588c4..7899607fbee8 100644
--- a/drivers/irqchip/irqchip.c
+++ b/drivers/irqchip/irqchip.c
@@ -38,8 +38,10 @@ int platform_irqchip_probe(struct platform_device *pdev)
 	struct device_node *par_np =3D of_irq_find_parent(np);
 	of_irq_init_cb_t irq_init_cb =3D of_device_get_match_data(&pdev->dev);
=20
-	if (!irq_init_cb)
+	if (!irq_init_cb) {
+		of_node_put(par_np);
 		return -EINVAL;
+	}
=20
 	if (par_np =3D=3D np)
 		par_np =3D NULL;
@@ -52,8 +54,10 @@ int platform_irqchip_probe(struct platform_device *pdev)
 	 * interrupt controller. The actual initialization callback of this
 	 * interrupt controller can check for specific domains as necessary.
 	 */
-	if (par_np && !irq_find_matching_host(par_np, DOMAIN_BUS_ANY))
+	if (par_np && !irq_find_matching_host(par_np, DOMAIN_BUS_ANY)) {
+		of_node_put(par_np);
 		return -EPROBE_DEFER;
+	}
=20
 	return irq_init_cb(np, par_np);
 }
diff --git a/include/linux/group_cpus.h b/include/linux/group_cpus.h
new file mode 100644
index 000000000000..e42807ec61f6
--- /dev/null
+++ b/include/linux/group_cpus.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2016 Thomas Gleixner.
+ * Copyright (C) 2016-2017 Christoph Hellwig.
+ */
+
+#ifndef __LINUX_GROUP_CPUS_H
+#define __LINUX_GROUP_CPUS_H
+#include <linux/kernel.h>
+#include <linux/cpu.h>
+
+struct cpumask *group_cpus_evenly(unsigned int numgrps);
+
+#endif
diff --git a/include/linux/irq.h b/include/linux/irq.h
index c3eb89606c2b..b1b28affb32a 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1266,6 +1266,9 @@ int __ipi_send_mask(struct irq_desc *desc, const struct=
 cpumask *dest);
 int ipi_send_single(unsigned int virq, unsigned int cpu);
 int ipi_send_mask(unsigned int virq, const struct cpumask *dest);
=20
+void ipi_mux_process(void);
+int ipi_mux_create(unsigned int nr_ipi, void (*mux_send)(unsigned int cpu));
+
 #ifdef CONFIG_GENERIC_IRQ_MULTI_HANDLER
 /*
  * Registers a generic IRQ handling function as the top-level IRQ handler in
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index a372086750ca..d320d15d4fba 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -125,6 +125,8 @@ struct irq_domain_chip_generic;
  *		core code.
  * @flags:	Per irq_domain flags
  * @mapcount:	The number of mapped interrupts
+ * @mutex:	Domain lock, hierarchical domains use root domain's lock
+ * @root:	Pointer to root domain, or containing structure if non-hierarchical
  *
  * Optional elements:
  * @fwnode:	Pointer to firmware node associated with the irq_domain. Pretty =
easy
@@ -143,7 +145,6 @@ struct irq_domain_chip_generic;
  * Revmap data, used internally by the irq domain code:
  * @revmap_size:	Size of the linear map table @revmap[]
  * @revmap_tree:	Radix map tree for hwirqs that don't fit in the linear map
- * @revmap_mutex:	Lock for the revmap
  * @revmap:		Linear table of irq_data pointers
  */
 struct irq_domain {
@@ -153,6 +154,8 @@ struct irq_domain {
 	void				*host_data;
 	unsigned int			flags;
 	unsigned int			mapcount;
+	struct mutex			mutex;
+	struct irq_domain		*root;
=20
 	/* Optional data */
 	struct fwnode_handle		*fwnode;
@@ -171,7 +174,6 @@ struct irq_domain {
 	irq_hw_number_t			hwirq_max;
 	unsigned int			revmap_size;
 	struct radix_tree_root		revmap_tree;
-	struct mutex			revmap_mutex;
 	struct irq_data __rcu		*revmap[];
 };
=20
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index b64c44ae4c25..2531f3496ab6 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -86,6 +86,11 @@ config GENERIC_IRQ_IPI
 	depends on SMP
 	select IRQ_DOMAIN_HIERARCHY
=20
+# Generic IRQ IPI Mux support
+config GENERIC_IRQ_IPI_MUX
+	bool
+	depends on SMP
+
 # Generic MSI hierarchical interrupt domain support
 config GENERIC_MSI_IRQ
 	bool
diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
index b4f53717d143..f19d3080bf11 100644
--- a/kernel/irq/Makefile
+++ b/kernel/irq/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_GENERIC_IRQ_MIGRATION) +=3D cpuhotplug.o
 obj-$(CONFIG_PM_SLEEP) +=3D pm.o
 obj-$(CONFIG_GENERIC_MSI_IRQ) +=3D msi.o
 obj-$(CONFIG_GENERIC_IRQ_IPI) +=3D ipi.o
+obj-$(CONFIG_GENERIC_IRQ_IPI_MUX) +=3D ipi-mux.o
 obj-$(CONFIG_SMP) +=3D affinity.o
 obj-$(CONFIG_GENERIC_IRQ_DEBUGFS) +=3D debugfs.o
 obj-$(CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR) +=3D matrix.o
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index d9a5c1d65a79..44a4eba80315 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -7,398 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/cpu.h>
-#include <linux/sort.h>
-
-static void irq_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
-				unsigned int cpus_per_vec)
-{
-	const struct cpumask *siblmsk;
-	int cpu, sibl;
-
-	for ( ; cpus_per_vec > 0; ) {
-		cpu =3D cpumask_first(nmsk);
-
-		/* Should not happen, but I'm too lazy to think about it */
-		if (cpu >=3D nr_cpu_ids)
-			return;
-
-		cpumask_clear_cpu(cpu, nmsk);
-		cpumask_set_cpu(cpu, irqmsk);
-		cpus_per_vec--;
-
-		/* If the cpu has siblings, use them first */
-		siblmsk =3D topology_sibling_cpumask(cpu);
-		for (sibl =3D -1; cpus_per_vec > 0; ) {
-			sibl =3D cpumask_next(sibl, siblmsk);
-			if (sibl >=3D nr_cpu_ids)
-				break;
-			if (!cpumask_test_and_clear_cpu(sibl, nmsk))
-				continue;
-			cpumask_set_cpu(sibl, irqmsk);
-			cpus_per_vec--;
-		}
-	}
-}
-
-static cpumask_var_t *alloc_node_to_cpumask(void)
-{
-	cpumask_var_t *masks;
-	int node;
-
-	masks =3D kcalloc(nr_node_ids, sizeof(cpumask_var_t), GFP_KERNEL);
-	if (!masks)
-		return NULL;
-
-	for (node =3D 0; node < nr_node_ids; node++) {
-		if (!zalloc_cpumask_var(&masks[node], GFP_KERNEL))
-			goto out_unwind;
-	}
-
-	return masks;
-
-out_unwind:
-	while (--node >=3D 0)
-		free_cpumask_var(masks[node]);
-	kfree(masks);
-	return NULL;
-}
-
-static void free_node_to_cpumask(cpumask_var_t *masks)
-{
-	int node;
-
-	for (node =3D 0; node < nr_node_ids; node++)
-		free_cpumask_var(masks[node]);
-	kfree(masks);
-}
-
-static void build_node_to_cpumask(cpumask_var_t *masks)
-{
-	int cpu;
-
-	for_each_possible_cpu(cpu)
-		cpumask_set_cpu(cpu, masks[cpu_to_node(cpu)]);
-}
-
-static int get_nodes_in_cpumask(cpumask_var_t *node_to_cpumask,
-				const struct cpumask *mask, nodemask_t *nodemsk)
-{
-	int n, nodes =3D 0;
-
-	/* Calculate the number of nodes in the supplied affinity mask */
-	for_each_node(n) {
-		if (cpumask_intersects(mask, node_to_cpumask[n])) {
-			node_set(n, *nodemsk);
-			nodes++;
-		}
-	}
-	return nodes;
-}
-
-struct node_vectors {
-	unsigned id;
-
-	union {
-		unsigned nvectors;
-		unsigned ncpus;
-	};
-};
-
-static int ncpus_cmp_func(const void *l, const void *r)
-{
-	const struct node_vectors *ln =3D l;
-	const struct node_vectors *rn =3D r;
-
-	return ln->ncpus - rn->ncpus;
-}
-
-/*
- * Allocate vector number for each node, so that for each node:
- *
- * 1) the allocated number is >=3D 1
- *
- * 2) the allocated numbver is <=3D active CPU number of this node
- *
- * The actual allocated total vectors may be less than @numvecs when
- * active total CPU number is less than @numvecs.
- *
- * Active CPUs means the CPUs in '@cpu_mask AND @node_to_cpumask[]'
- * for each node.
- */
-static void alloc_nodes_vectors(unsigned int numvecs,
-				cpumask_var_t *node_to_cpumask,
-				const struct cpumask *cpu_mask,
-				const nodemask_t nodemsk,
-				struct cpumask *nmsk,
-				struct node_vectors *node_vectors)
-{
-	unsigned n, remaining_ncpus =3D 0;
-
-	for (n =3D 0; n < nr_node_ids; n++) {
-		node_vectors[n].id =3D n;
-		node_vectors[n].ncpus =3D UINT_MAX;
-	}
-
-	for_each_node_mask(n, nodemsk) {
-		unsigned ncpus;
-
-		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
-		ncpus =3D cpumask_weight(nmsk);
-
-		if (!ncpus)
-			continue;
-		remaining_ncpus +=3D ncpus;
-		node_vectors[n].ncpus =3D ncpus;
-	}
-
-	numvecs =3D min_t(unsigned, remaining_ncpus, numvecs);
-
-	sort(node_vectors, nr_node_ids, sizeof(node_vectors[0]),
-	     ncpus_cmp_func, NULL);
-
-	/*
-	 * Allocate vectors for each node according to the ratio of this
-	 * node's nr_cpus to remaining un-assigned ncpus. 'numvecs' is
-	 * bigger than number of active numa nodes. Always start the
-	 * allocation from the node with minimized nr_cpus.
-	 *
-	 * This way guarantees that each active node gets allocated at
-	 * least one vector, and the theory is simple: over-allocation
-	 * is only done when this node is assigned by one vector, so
-	 * other nodes will be allocated >=3D 1 vector, since 'numvecs' is
-	 * bigger than number of numa nodes.
-	 *
-	 * One perfect invariant is that number of allocated vectors for
-	 * each node is <=3D CPU count of this node:
-	 *
-	 * 1) suppose there are two nodes: A and B
-	 * 	ncpu(X) is CPU count of node X
-	 * 	vecs(X) is the vector count allocated to node X via this
-	 * 	algorithm
-	 *
-	 * 	ncpu(A) <=3D ncpu(B)
-	 * 	ncpu(A) + ncpu(B) =3D N
-	 * 	vecs(A) + vecs(B) =3D V
-	 *
-	 * 	vecs(A) =3D max(1, round_down(V * ncpu(A) / N))
-	 * 	vecs(B) =3D V - vecs(A)
-	 *
-	 * 	both N and V are integer, and 2 <=3D V <=3D N, suppose
-	 * 	V =3D N - delta, and 0 <=3D delta <=3D N - 2
-	 *
-	 * 2) obviously vecs(A) <=3D ncpu(A) because:
-	 *
-	 * 	if vecs(A) is 1, then vecs(A) <=3D ncpu(A) given
-	 * 	ncpu(A) >=3D 1
-	 *
-	 * 	otherwise,
-	 * 		vecs(A) <=3D V * ncpu(A) / N <=3D ncpu(A), given V <=3D N
-	 *
-	 * 3) prove how vecs(B) <=3D ncpu(B):
-	 *
-	 * 	if round_down(V * ncpu(A) / N) =3D=3D 0, vecs(B) won't be
-	 * 	over-allocated, so vecs(B) <=3D ncpu(B),
-	 *
-	 * 	otherwise:
-	 *
-	 * 	vecs(A) =3D
-	 * 		round_down(V * ncpu(A) / N) =3D
-	 * 		round_down((N - delta) * ncpu(A) / N) =3D
-	 * 		round_down((N * ncpu(A) - delta * ncpu(A)) / N)	 >=3D
-	 * 		round_down((N * ncpu(A) - delta * N) / N)	 =3D
-	 * 		cpu(A) - delta
-	 *
-	 * 	then:
-	 *
-	 * 	vecs(A) - V >=3D ncpu(A) - delta - V
-	 * 	=3D>
-	 * 	V - vecs(A) <=3D V + delta - ncpu(A)
-	 * 	=3D>
-	 * 	vecs(B) <=3D N - ncpu(A)
-	 * 	=3D>
-	 * 	vecs(B) <=3D cpu(B)
-	 *
-	 * For nodes >=3D 3, it can be thought as one node and another big
-	 * node given that is exactly what this algorithm is implemented,
-	 * and we always re-calculate 'remaining_ncpus' & 'numvecs', and
-	 * finally for each node X: vecs(X) <=3D ncpu(X).
-	 *
-	 */
-	for (n =3D 0; n < nr_node_ids; n++) {
-		unsigned nvectors, ncpus;
-
-		if (node_vectors[n].ncpus =3D=3D UINT_MAX)
-			continue;
-
-		WARN_ON_ONCE(numvecs =3D=3D 0);
-
-		ncpus =3D node_vectors[n].ncpus;
-		nvectors =3D max_t(unsigned, 1,
-				 numvecs * ncpus / remaining_ncpus);
-		WARN_ON_ONCE(nvectors > ncpus);
-
-		node_vectors[n].nvectors =3D nvectors;
-
-		remaining_ncpus -=3D ncpus;
-		numvecs -=3D nvectors;
-	}
-}
-
-static int __irq_build_affinity_masks(unsigned int startvec,
-				      unsigned int numvecs,
-				      unsigned int firstvec,
-				      cpumask_var_t *node_to_cpumask,
-				      const struct cpumask *cpu_mask,
-				      struct cpumask *nmsk,
-				      struct irq_affinity_desc *masks)
-{
-	unsigned int i, n, nodes, cpus_per_vec, extra_vecs, done =3D 0;
-	unsigned int last_affv =3D firstvec + numvecs;
-	unsigned int curvec =3D startvec;
-	nodemask_t nodemsk =3D NODE_MASK_NONE;
-	struct node_vectors *node_vectors;
-
-	if (cpumask_empty(cpu_mask))
-		return 0;
-
-	nodes =3D get_nodes_in_cpumask(node_to_cpumask, cpu_mask, &nodemsk);
-
-	/*
-	 * If the number of nodes in the mask is greater than or equal the
-	 * number of vectors we just spread the vectors across the nodes.
-	 */
-	if (numvecs <=3D nodes) {
-		for_each_node_mask(n, nodemsk) {
-			/* Ensure that only CPUs which are in both masks are set */
-			cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
-			cpumask_or(&masks[curvec].mask, &masks[curvec].mask, nmsk);
-			if (++curvec =3D=3D last_affv)
-				curvec =3D firstvec;
-		}
-		return numvecs;
-	}
-
-	node_vectors =3D kcalloc(nr_node_ids,
-			       sizeof(struct node_vectors),
-			       GFP_KERNEL);
-	if (!node_vectors)
-		return -ENOMEM;
-
-	/* allocate vector number for each node */
-	alloc_nodes_vectors(numvecs, node_to_cpumask, cpu_mask,
-			    nodemsk, nmsk, node_vectors);
-
-	for (i =3D 0; i < nr_node_ids; i++) {
-		unsigned int ncpus, v;
-		struct node_vectors *nv =3D &node_vectors[i];
-
-		if (nv->nvectors =3D=3D UINT_MAX)
-			continue;
-
-		/* Get the cpus on this node which are in the mask */
-		cpumask_and(nmsk, cpu_mask, node_to_cpumask[nv->id]);
-		ncpus =3D cpumask_weight(nmsk);
-		if (!ncpus)
-			continue;
-
-		WARN_ON_ONCE(nv->nvectors > ncpus);
-
-		/* Account for rounding errors */
-		extra_vecs =3D ncpus - nv->nvectors * (ncpus / nv->nvectors);
-
-		/* Spread allocated vectors on CPUs of the current node */
-		for (v =3D 0; v < nv->nvectors; v++, curvec++) {
-			cpus_per_vec =3D ncpus / nv->nvectors;
-
-			/* Account for extra vectors to compensate rounding errors */
-			if (extra_vecs) {
-				cpus_per_vec++;
-				--extra_vecs;
-			}
-
-			/*
-			 * wrapping has to be considered given 'startvec'
-			 * may start anywhere
-			 */
-			if (curvec >=3D last_affv)
-				curvec =3D firstvec;
-			irq_spread_init_one(&masks[curvec].mask, nmsk,
-						cpus_per_vec);
-		}
-		done +=3D nv->nvectors;
-	}
-	kfree(node_vectors);
-	return done;
-}
-
-/*
- * build affinity in two stages:
- *	1) spread present CPU on these vectors
- *	2) spread other possible CPUs on these vectors
- */
-static int irq_build_affinity_masks(unsigned int startvec, unsigned int numv=
ecs,
-				    unsigned int firstvec,
-				    struct irq_affinity_desc *masks)
-{
-	unsigned int curvec =3D startvec, nr_present =3D 0, nr_others =3D 0;
-	cpumask_var_t *node_to_cpumask;
-	cpumask_var_t nmsk, npresmsk;
-	int ret =3D -ENOMEM;
-
-	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
-		return ret;
-
-	if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
-		goto fail_nmsk;
-
-	node_to_cpumask =3D alloc_node_to_cpumask();
-	if (!node_to_cpumask)
-		goto fail_npresmsk;
-
-	/* Stabilize the cpumasks */
-	cpus_read_lock();
-	build_node_to_cpumask(node_to_cpumask);
-
-	/* Spread on present CPUs starting from affd->pre_vectors */
-	ret =3D __irq_build_affinity_masks(curvec, numvecs, firstvec,
-					 node_to_cpumask, cpu_present_mask,
-					 nmsk, masks);
-	if (ret < 0)
-		goto fail_build_affinity;
-	nr_present =3D ret;
-
-	/*
-	 * Spread on non present CPUs starting from the next vector to be
-	 * handled. If the spreading of present CPUs already exhausted the
-	 * vector space, assign the non present CPUs to the already spread
-	 * out vectors.
-	 */
-	if (nr_present >=3D numvecs)
-		curvec =3D firstvec;
-	else
-		curvec =3D firstvec + nr_present;
-	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
-	ret =3D __irq_build_affinity_masks(curvec, numvecs, firstvec,
-					 node_to_cpumask, npresmsk, nmsk,
-					 masks);
-	if (ret >=3D 0)
-		nr_others =3D ret;
-
- fail_build_affinity:
-	cpus_read_unlock();
-
-	if (ret >=3D 0)
-		WARN_ON(nr_present + nr_others < numvecs);
-
-	free_node_to_cpumask(node_to_cpumask);
-
- fail_npresmsk:
-	free_cpumask_var(npresmsk);
-
- fail_nmsk:
-	free_cpumask_var(nmsk);
-	return ret < 0 ? ret : 0;
-}
+#include <linux/group_cpus.h>
=20
 static void default_calc_sets(struct irq_affinity *affd, unsigned int affvec=
s)
 {
@@ -461,14 +70,18 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq=
_affinity *affd)
 	 */
 	for (i =3D 0, usedvecs =3D 0; i < affd->nr_sets; i++) {
 		unsigned int this_vecs =3D affd->set_size[i];
-		int ret;
+		int j;
+		struct cpumask *result =3D group_cpus_evenly(this_vecs);
=20
-		ret =3D irq_build_affinity_masks(curvec, this_vecs,
-					       curvec, masks);
-		if (ret) {
+		if (!result) {
 			kfree(masks);
 			return NULL;
 		}
+
+		for (j =3D 0; j < this_vecs; j++)
+			cpumask_copy(&masks[curvec + j].mask, &result[j]);
+		kfree(result);
+
 		curvec +=3D this_vecs;
 		usedvecs +=3D this_vecs;
 	}
diff --git a/kernel/irq/ipi-mux.c b/kernel/irq/ipi-mux.c
new file mode 100644
index 000000000000..fa4fc18c6131
--- /dev/null
+++ b/kernel/irq/ipi-mux.c
@@ -0,0 +1,206 @@
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
+	struct ipi_mux_cpu *icpu =3D this_cpu_ptr(ipi_mux_pcpu);
+
+	atomic_andnot(BIT(irqd_to_hwirq(d)), &icpu->enable);
+}
+
+static void ipi_mux_unmask(struct irq_data *d)
+{
+	struct ipi_mux_cpu *icpu =3D this_cpu_ptr(ipi_mux_pcpu);
+	u32 ibit =3D BIT(irqd_to_hwirq(d));
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
+	struct ipi_mux_cpu *icpu =3D this_cpu_ptr(ipi_mux_pcpu);
+	u32 ibit =3D BIT(irqd_to_hwirq(d));
+	unsigned long pending;
+	int cpu;
+
+	for_each_cpu(cpu, mask) {
+		icpu =3D per_cpu_ptr(ipi_mux_pcpu, cpu);
+
+		/*
+		 * This sequence is the mirror of the one in ipi_mux_unmask();
+		 * see the comment there. Additionally, release semantics
+		 * ensure that the vIPI flag set is ordered after any shared
+		 * memory accesses that precede it. This therefore also pairs
+		 * with the atomic_fetch_andnot in ipi_mux_process().
+		 */
+		pending =3D atomic_fetch_or_release(ibit, &icpu->bits);
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
+static const struct irq_chip ipi_mux_chip =3D {
+	.name		=3D "IPI Mux",
+	.irq_mask	=3D ipi_mux_mask,
+	.irq_unmask	=3D ipi_mux_unmask,
+	.ipi_send_mask	=3D ipi_mux_send_mask,
+};
+
+static int ipi_mux_domain_alloc(struct irq_domain *d, unsigned int virq,
+				unsigned int nr_irqs, void *arg)
+{
+	int i;
+
+	for (i =3D 0; i < nr_irqs; i++) {
+		irq_set_percpu_devid(virq + i);
+		irq_domain_set_info(d, virq + i, i, &ipi_mux_chip, NULL,
+				    handle_percpu_devid_irq, NULL, NULL);
+	}
+
+	return 0;
+}
+
+static const struct irq_domain_ops ipi_mux_domain_ops =3D {
+	.alloc		=3D ipi_mux_domain_alloc,
+	.free		=3D irq_domain_free_irqs_top,
+};
+
+/**
+ * ipi_mux_process - Process multiplexed virtual IPIs
+ */
+void ipi_mux_process(void)
+{
+	struct ipi_mux_cpu *icpu =3D this_cpu_ptr(ipi_mux_pcpu);
+	irq_hw_number_t hwirq;
+	unsigned long ipis;
+	unsigned int en;
+
+	/*
+	 * Reading enable mask does not need to be ordered as long as
+	 * this function is called from interrupt handler because only
+	 * the CPU itself can change it's own enable mask.
+	 */
+	en =3D atomic_read(&icpu->enable);
+
+	/*
+	 * Clear the IPIs we are about to handle. This pairs with the
+	 * atomic_fetch_or_release() in ipi_mux_send_mask().
+	 */
+	ipis =3D atomic_fetch_andnot(en, &icpu->bits) & en;
+
+	for_each_set_bit(hwirq, &ipis, BITS_PER_TYPE(int))
+		generic_handle_domain_irq(ipi_mux_domain, hwirq);
+}
+
+/**
+ * ipi_mux_create - Create virtual IPIs multiplexed on top of a single
+ * parent IPI.
+ * @nr_ipi:		number of virtual IPIs to create. This should
+ *			be <=3D BITS_PER_TYPE(int)
+ * @mux_send:		callback to trigger parent IPI for a particular CPU
+ *
+ * Returns first virq of the newly created virtual IPIs upon success
+ * or <=3D0 upon failure
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
+	ipi_mux_pcpu =3D alloc_percpu(typeof(*ipi_mux_pcpu));
+	if (!ipi_mux_pcpu)
+		return -ENOMEM;
+
+	fwnode =3D irq_domain_alloc_named_fwnode("IPI-Mux");
+	if (!fwnode) {
+		pr_err("unable to create IPI Mux fwnode\n");
+		rc =3D -ENOMEM;
+		goto fail_free_cpu;
+	}
+
+	domain =3D irq_domain_create_linear(fwnode, nr_ipi,
+					  &ipi_mux_domain_ops, NULL);
+	if (!domain) {
+		pr_err("unable to add IPI Mux domain\n");
+		rc =3D -ENOMEM;
+		goto fail_free_fwnode;
+	}
+
+	domain->flags |=3D IRQ_DOMAIN_FLAG_IPI_SINGLE;
+	irq_domain_update_bus_token(domain, DOMAIN_BUS_IPI);
+
+	rc =3D irq_domain_alloc_irqs(domain, nr_ipi, NUMA_NO_NODE, NULL);
+	if (rc <=3D 0) {
+		pr_err("unable to alloc IRQs from IPI Mux domain\n");
+		goto fail_free_domain;
+	}
+
+	ipi_mux_domain =3D domain;
+	ipi_mux_send =3D mux_send;
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
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 8fe1da9614ee..1983f1beeec7 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -25,6 +25,9 @@ static DEFINE_MUTEX(irq_domain_mutex);
=20
 static struct irq_domain *irq_default_domain;
=20
+static int irq_domain_alloc_irqs_locked(struct irq_domain *domain, int irq_b=
ase,
+					unsigned int nr_irqs, int node, void *arg,
+					bool realloc, const struct irq_affinity_desc *affinity);
 static void irq_domain_check_hierarchy(struct irq_domain *domain);
=20
 struct irqchip_fwid {
@@ -123,23 +126,12 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnod=
e)
 }
 EXPORT_SYMBOL_GPL(irq_domain_free_fwnode);
=20
-/**
- * __irq_domain_add() - Allocate a new irq_domain data structure
- * @fwnode: firmware node for the interrupt controller
- * @size: Size of linear map; 0 for radix mapping only
- * @hwirq_max: Maximum number of interrupts supported by controller
- * @direct_max: Maximum value of direct maps; Use ~0 for no limit; 0 for no
- *              direct mapping
- * @ops: domain callbacks
- * @host_data: Controller private data pointer
- *
- * Allocates and initializes an irq_domain structure.
- * Returns pointer to IRQ domain, or NULL on failure.
- */
-struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned i=
nt size,
-				    irq_hw_number_t hwirq_max, int direct_max,
-				    const struct irq_domain_ops *ops,
-				    void *host_data)
+static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
+					      unsigned int size,
+					      irq_hw_number_t hwirq_max,
+					      int direct_max,
+					      const struct irq_domain_ops *ops,
+					      void *host_data)
 {
 	struct irqchip_fwid *fwid;
 	struct irq_domain *domain;
@@ -214,25 +206,66 @@ struct irq_domain *__irq_domain_add(struct fwnode_handl=
e *fwnode, unsigned int s
=20
 	/* Fill structure */
 	INIT_RADIX_TREE(&domain->revmap_tree, GFP_KERNEL);
-	mutex_init(&domain->revmap_mutex);
 	domain->ops =3D ops;
 	domain->host_data =3D host_data;
 	domain->hwirq_max =3D hwirq_max;
=20
-	if (direct_max) {
+	if (direct_max)
 		domain->flags |=3D IRQ_DOMAIN_FLAG_NO_MAP;
-	}
=20
 	domain->revmap_size =3D size;
=20
+	/*
+	 * Hierarchical domains use the domain lock of the root domain
+	 * (innermost domain).
+	 *
+	 * For non-hierarchical domains (as for root domains), the root
+	 * pointer is set to the domain itself so that &domain->root->mutex
+	 * always points to the right lock.
+	 */
+	mutex_init(&domain->mutex);
+	domain->root =3D domain;
+
 	irq_domain_check_hierarchy(domain);
=20
+	return domain;
+}
+
+static void __irq_domain_publish(struct irq_domain *domain)
+{
 	mutex_lock(&irq_domain_mutex);
 	debugfs_add_domain_dir(domain);
 	list_add(&domain->link, &irq_domain_list);
 	mutex_unlock(&irq_domain_mutex);
=20
 	pr_debug("Added domain %s\n", domain->name);
+}
+
+/**
+ * __irq_domain_add() - Allocate a new irq_domain data structure
+ * @fwnode: firmware node for the interrupt controller
+ * @size: Size of linear map; 0 for radix mapping only
+ * @hwirq_max: Maximum number of interrupts supported by controller
+ * @direct_max: Maximum value of direct maps; Use ~0 for no limit; 0 for no
+ *              direct mapping
+ * @ops: domain callbacks
+ * @host_data: Controller private data pointer
+ *
+ * Allocates and initializes an irq_domain structure.
+ * Returns pointer to IRQ domain, or NULL on failure.
+ */
+struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned i=
nt size,
+				    irq_hw_number_t hwirq_max, int direct_max,
+				    const struct irq_domain_ops *ops,
+				    void *host_data)
+{
+	struct irq_domain *domain;
+
+	domain =3D __irq_domain_create(fwnode, size, hwirq_max, direct_max,
+				     ops, host_data);
+	if (domain)
+		__irq_domain_publish(domain);
+
 	return domain;
 }
 EXPORT_SYMBOL_GPL(__irq_domain_add);
@@ -502,30 +535,34 @@ static bool irq_domain_is_nomap(struct irq_domain *doma=
in)
 static void irq_domain_clear_mapping(struct irq_domain *domain,
 				     irq_hw_number_t hwirq)
 {
+	lockdep_assert_held(&domain->root->mutex);
+
 	if (irq_domain_is_nomap(domain))
 		return;
=20
-	mutex_lock(&domain->revmap_mutex);
 	if (hwirq < domain->revmap_size)
 		rcu_assign_pointer(domain->revmap[hwirq], NULL);
 	else
 		radix_tree_delete(&domain->revmap_tree, hwirq);
-	mutex_unlock(&domain->revmap_mutex);
 }
=20
 static void irq_domain_set_mapping(struct irq_domain *domain,
 				   irq_hw_number_t hwirq,
 				   struct irq_data *irq_data)
 {
+	/*
+	 * This also makes sure that all domains point to the same root when
+	 * called from irq_domain_insert_irq() for each domain in a hierarchy.
+	 */
+	lockdep_assert_held(&domain->root->mutex);
+
 	if (irq_domain_is_nomap(domain))
 		return;
=20
-	mutex_lock(&domain->revmap_mutex);
 	if (hwirq < domain->revmap_size)
 		rcu_assign_pointer(domain->revmap[hwirq], irq_data);
 	else
 		radix_tree_insert(&domain->revmap_tree, hwirq, irq_data);
-	mutex_unlock(&domain->revmap_mutex);
 }
=20
 static void irq_domain_disassociate(struct irq_domain *domain, unsigned int =
irq)
@@ -538,6 +575,9 @@ static void irq_domain_disassociate(struct irq_domain *do=
main, unsigned int irq)
 		return;
=20
 	hwirq =3D irq_data->hwirq;
+
+	mutex_lock(&domain->root->mutex);
+
 	irq_set_status_flags(irq, IRQ_NOREQUEST);
=20
 	/* remove chip and handler */
@@ -557,10 +597,12 @@ static void irq_domain_disassociate(struct irq_domain *=
domain, unsigned int irq)
=20
 	/* Clear reverse map for this hwirq */
 	irq_domain_clear_mapping(domain, hwirq);
+
+	mutex_unlock(&domain->root->mutex);
 }
=20
-int irq_domain_associate(struct irq_domain *domain, unsigned int virq,
-			 irq_hw_number_t hwirq)
+static int irq_domain_associate_locked(struct irq_domain *domain, unsigned i=
nt virq,
+				       irq_hw_number_t hwirq)
 {
 	struct irq_data *irq_data =3D irq_get_irq_data(virq);
 	int ret;
@@ -573,7 +615,6 @@ int irq_domain_associate(struct irq_domain *domain, unsig=
ned int virq,
 	if (WARN(irq_data->domain, "error: virq%i is already associated", virq))
 		return -EINVAL;
=20
-	mutex_lock(&irq_domain_mutex);
 	irq_data->hwirq =3D hwirq;
 	irq_data->domain =3D domain;
 	if (domain->ops->map) {
@@ -590,23 +631,29 @@ int irq_domain_associate(struct irq_domain *domain, uns=
igned int virq,
 			}
 			irq_data->domain =3D NULL;
 			irq_data->hwirq =3D 0;
-			mutex_unlock(&irq_domain_mutex);
 			return ret;
 		}
-
-		/* If not already assigned, give the domain the chip's name */
-		if (!domain->name && irq_data->chip)
-			domain->name =3D irq_data->chip->name;
 	}
=20
 	domain->mapcount++;
 	irq_domain_set_mapping(domain, hwirq, irq_data);
-	mutex_unlock(&irq_domain_mutex);
=20
 	irq_clear_status_flags(virq, IRQ_NOREQUEST);
=20
 	return 0;
 }
+
+int irq_domain_associate(struct irq_domain *domain, unsigned int virq,
+			 irq_hw_number_t hwirq)
+{
+	int ret;
+
+	mutex_lock(&domain->root->mutex);
+	ret =3D irq_domain_associate_locked(domain, virq, hwirq);
+	mutex_unlock(&domain->root->mutex);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(irq_domain_associate);
=20
 void irq_domain_associate_many(struct irq_domain *domain, unsigned int irq_b=
ase,
@@ -619,9 +666,8 @@ void irq_domain_associate_many(struct irq_domain *domain,=
 unsigned int irq_base,
 	pr_debug("%s(%s, irqbase=3D%i, hwbase=3D%i, count=3D%i)\n", __func__,
 		of_node_full_name(of_node), irq_base, (int)hwirq_base, count);
=20
-	for (i =3D 0; i < count; i++) {
+	for (i =3D 0; i < count; i++)
 		irq_domain_associate(domain, irq_base + i, hwirq_base + i);
-	}
 }
 EXPORT_SYMBOL_GPL(irq_domain_associate_many);
=20
@@ -668,6 +714,34 @@ unsigned int irq_create_direct_mapping(struct irq_domain=
 *domain)
 EXPORT_SYMBOL_GPL(irq_create_direct_mapping);
 #endif
=20
+static unsigned int irq_create_mapping_affinity_locked(struct irq_domain *do=
main,
+						       irq_hw_number_t hwirq,
+						       const struct irq_affinity_desc *affinity)
+{
+	struct device_node *of_node =3D irq_domain_get_of_node(domain);
+	int virq;
+
+	pr_debug("irq_create_mapping(0x%p, 0x%lx)\n", domain, hwirq);
+
+	/* Allocate a virtual interrupt number */
+	virq =3D irq_domain_alloc_descs(-1, 1, hwirq, of_node_to_nid(of_node),
+				      affinity);
+	if (virq <=3D 0) {
+		pr_debug("-> virq allocation failed\n");
+		return 0;
+	}
+
+	if (irq_domain_associate_locked(domain, virq, hwirq)) {
+		irq_free_desc(virq);
+		return 0;
+	}
+
+	pr_debug("irq %lu on domain %s mapped to virtual irq %u\n",
+		hwirq, of_node_full_name(of_node), virq);
+
+	return virq;
+}
+
 /**
  * irq_create_mapping_affinity() - Map a hardware interrupt into linux irq s=
pace
  * @domain: domain owning this hardware interrupt or NULL for default domain
@@ -680,14 +754,11 @@ EXPORT_SYMBOL_GPL(irq_create_direct_mapping);
  * on the number returned from that call.
  */
 unsigned int irq_create_mapping_affinity(struct irq_domain *domain,
-				       irq_hw_number_t hwirq,
-				       const struct irq_affinity_desc *affinity)
+					 irq_hw_number_t hwirq,
+					 const struct irq_affinity_desc *affinity)
 {
-	struct device_node *of_node;
 	int virq;
=20
-	pr_debug("irq_create_mapping(0x%p, 0x%lx)\n", domain, hwirq);
-
 	/* Look for default domain if necessary */
 	if (domain =3D=3D NULL)
 		domain =3D irq_default_domain;
@@ -695,32 +766,19 @@ unsigned int irq_create_mapping_affinity(struct irq_dom=
ain *domain,
 		WARN(1, "%s(, %lx) called with NULL domain\n", __func__, hwirq);
 		return 0;
 	}
-	pr_debug("-> using domain @%p\n", domain);
=20
-	of_node =3D irq_domain_get_of_node(domain);
+	mutex_lock(&domain->root->mutex);
=20
 	/* Check if mapping already exists */
 	virq =3D irq_find_mapping(domain, hwirq);
 	if (virq) {
-		pr_debug("-> existing mapping on virq %d\n", virq);
-		return virq;
-	}
-
-	/* Allocate a virtual interrupt number */
-	virq =3D irq_domain_alloc_descs(-1, 1, hwirq, of_node_to_nid(of_node),
-				      affinity);
-	if (virq <=3D 0) {
-		pr_debug("-> virq allocation failed\n");
-		return 0;
-	}
-
-	if (irq_domain_associate(domain, virq, hwirq)) {
-		irq_free_desc(virq);
-		return 0;
+		pr_debug("existing mapping on virq %d\n", virq);
+		goto out;
 	}
=20
-	pr_debug("irq %lu on domain %s mapped to virtual irq %u\n",
-		hwirq, of_node_full_name(of_node), virq);
+	virq =3D irq_create_mapping_affinity_locked(domain, hwirq, affinity);
+out:
+	mutex_unlock(&domain->root->mutex);
=20
 	return virq;
 }
@@ -789,6 +847,8 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec =
*fwspec)
 	if (WARN_ON(type & ~IRQ_TYPE_SENSE_MASK))
 		type &=3D IRQ_TYPE_SENSE_MASK;
=20
+	mutex_lock(&domain->root->mutex);
+
 	/*
 	 * If we've already configured this interrupt,
 	 * don't do it again, or hell will break loose.
@@ -801,7 +861,7 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec =
*fwspec)
 		 * interrupt number.
 		 */
 		if (type =3D=3D IRQ_TYPE_NONE || type =3D=3D irq_get_trigger_type(virq))
-			return virq;
+			goto out;
=20
 		/*
 		 * If the trigger type has not been set yet, then set
@@ -809,40 +869,45 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspe=
c *fwspec)
 		 */
 		if (irq_get_trigger_type(virq) =3D=3D IRQ_TYPE_NONE) {
 			irq_data =3D irq_get_irq_data(virq);
-			if (!irq_data)
-				return 0;
+			if (!irq_data) {
+				virq =3D 0;
+				goto out;
+			}
=20
 			irqd_set_trigger_type(irq_data, type);
-			return virq;
+			goto out;
 		}
=20
 		pr_warn("type mismatch, failed to map hwirq-%lu for %s!\n",
 			hwirq, of_node_full_name(to_of_node(fwspec->fwnode)));
-		return 0;
+		virq =3D 0;
+		goto out;
 	}
=20
 	if (irq_domain_is_hierarchy(domain)) {
-		virq =3D irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, fwspec);
-		if (virq <=3D 0)
-			return 0;
+		virq =3D irq_domain_alloc_irqs_locked(domain, -1, 1, NUMA_NO_NODE,
+						    fwspec, false, NULL);
+		if (virq <=3D 0) {
+			virq =3D 0;
+			goto out;
+		}
 	} else {
 		/* Create mapping */
-		virq =3D irq_create_mapping(domain, hwirq);
+		virq =3D irq_create_mapping_affinity_locked(domain, hwirq, NULL);
 		if (!virq)
-			return virq;
+			goto out;
 	}
=20
 	irq_data =3D irq_get_irq_data(virq);
-	if (!irq_data) {
-		if (irq_domain_is_hierarchy(domain))
-			irq_domain_free_irqs(virq, 1);
-		else
-			irq_dispose_mapping(virq);
-		return 0;
+	if (WARN_ON(!irq_data)) {
+		virq =3D 0;
+		goto out;
 	}
=20
 	/* Store trigger type */
 	irqd_set_trigger_type(irq_data, type);
+out:
+	mutex_unlock(&domain->root->mutex);
=20
 	return virq;
 }
@@ -1102,12 +1167,16 @@ struct irq_domain *irq_domain_create_hierarchy(struct=
 irq_domain *parent,
 	struct irq_domain *domain;
=20
 	if (size)
-		domain =3D irq_domain_create_linear(fwnode, size, ops, host_data);
+		domain =3D __irq_domain_create(fwnode, size, size, 0, ops, host_data);
 	else
-		domain =3D irq_domain_create_tree(fwnode, ops, host_data);
+		domain =3D __irq_domain_create(fwnode, 0, ~0, 0, ops, host_data);
+
 	if (domain) {
+		domain->root =3D parent->root;
 		domain->parent =3D parent;
 		domain->flags |=3D flags;
+
+		__irq_domain_publish(domain);
 	}
=20
 	return domain;
@@ -1123,10 +1192,6 @@ static void irq_domain_insert_irq(int virq)
=20
 		domain->mapcount++;
 		irq_domain_set_mapping(domain, data->hwirq, data);
-
-		/* If not already assigned, give the domain the chip's name */
-		if (!domain->name && data->chip)
-			domain->name =3D data->chip->name;
 	}
=20
 	irq_clear_status_flags(virq, IRQ_NOREQUEST);
@@ -1426,40 +1491,12 @@ int irq_domain_alloc_irqs_hierarchy(struct irq_domain=
 *domain,
 	return domain->ops->alloc(domain, irq_base, nr_irqs, arg);
 }
=20
-/**
- * __irq_domain_alloc_irqs - Allocate IRQs from domain
- * @domain:	domain to allocate from
- * @irq_base:	allocate specified IRQ number if irq_base >=3D 0
- * @nr_irqs:	number of IRQs to allocate
- * @node:	NUMA node id for memory allocation
- * @arg:	domain specific argument
- * @realloc:	IRQ descriptors have already been allocated if true
- * @affinity:	Optional irq affinity mask for multiqueue devices
- *
- * Allocate IRQ numbers and initialized all data structures to support
- * hierarchy IRQ domains.
- * Parameter @realloc is mainly to support legacy IRQs.
- * Returns error code or allocated IRQ number
- *
- * The whole process to setup an IRQ has been split into two steps.
- * The first step, __irq_domain_alloc_irqs(), is to allocate IRQ
- * descriptor and required hardware resources. The second step,
- * irq_domain_activate_irq(), is to program the hardware with preallocated
- * resources. In this way, it's easier to rollback when failing to
- * allocate resources.
- */
-int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
-			    unsigned int nr_irqs, int node, void *arg,
-			    bool realloc, const struct irq_affinity_desc *affinity)
+static int irq_domain_alloc_irqs_locked(struct irq_domain *domain, int irq_b=
ase,
+					unsigned int nr_irqs, int node, void *arg,
+					bool realloc, const struct irq_affinity_desc *affinity)
 {
 	int i, ret, virq;
=20
-	if (domain =3D=3D NULL) {
-		domain =3D irq_default_domain;
-		if (WARN(!domain, "domain is NULL; cannot allocate IRQ\n"))
-			return -EINVAL;
-	}
-
 	if (realloc && irq_base >=3D 0) {
 		virq =3D irq_base;
 	} else {
@@ -1478,24 +1515,18 @@ int __irq_domain_alloc_irqs(struct irq_domain *domain=
, int irq_base,
 		goto out_free_desc;
 	}
=20
-	mutex_lock(&irq_domain_mutex);
 	ret =3D irq_domain_alloc_irqs_hierarchy(domain, virq, nr_irqs, arg);
-	if (ret < 0) {
-		mutex_unlock(&irq_domain_mutex);
+	if (ret < 0)
 		goto out_free_irq_data;
-	}
=20
 	for (i =3D 0; i < nr_irqs; i++) {
 		ret =3D irq_domain_trim_hierarchy(virq + i);
-		if (ret) {
-			mutex_unlock(&irq_domain_mutex);
+		if (ret)
 			goto out_free_irq_data;
-		}
 	}
-=09
+
 	for (i =3D 0; i < nr_irqs; i++)
 		irq_domain_insert_irq(virq + i);
-	mutex_unlock(&irq_domain_mutex);
=20
 	return virq;
=20
@@ -1505,6 +1536,48 @@ int __irq_domain_alloc_irqs(struct irq_domain *domain,=
 int irq_base,
 	irq_free_descs(virq, nr_irqs);
 	return ret;
 }
+
+/**
+ * __irq_domain_alloc_irqs - Allocate IRQs from domain
+ * @domain:	domain to allocate from
+ * @irq_base:	allocate specified IRQ number if irq_base >=3D 0
+ * @nr_irqs:	number of IRQs to allocate
+ * @node:	NUMA node id for memory allocation
+ * @arg:	domain specific argument
+ * @realloc:	IRQ descriptors have already been allocated if true
+ * @affinity:	Optional irq affinity mask for multiqueue devices
+ *
+ * Allocate IRQ numbers and initialized all data structures to support
+ * hierarchy IRQ domains.
+ * Parameter @realloc is mainly to support legacy IRQs.
+ * Returns error code or allocated IRQ number
+ *
+ * The whole process to setup an IRQ has been split into two steps.
+ * The first step, __irq_domain_alloc_irqs(), is to allocate IRQ
+ * descriptor and required hardware resources. The second step,
+ * irq_domain_activate_irq(), is to program the hardware with preallocated
+ * resources. In this way, it's easier to rollback when failing to
+ * allocate resources.
+ */
+int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
+			    unsigned int nr_irqs, int node, void *arg,
+			    bool realloc, const struct irq_affinity_desc *affinity)
+{
+	int ret;
+
+	if (domain =3D=3D NULL) {
+		domain =3D irq_default_domain;
+		if (WARN(!domain, "domain is NULL; cannot allocate IRQ\n"))
+			return -EINVAL;
+	}
+
+	mutex_lock(&domain->root->mutex);
+	ret =3D irq_domain_alloc_irqs_locked(domain, irq_base, nr_irqs, node, arg,
+					   realloc, affinity);
+	mutex_unlock(&domain->root->mutex);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(__irq_domain_alloc_irqs);
=20
 /* The irq_data was moved, fix the revmap to refer to the new location */
@@ -1512,11 +1585,12 @@ static void irq_domain_fix_revmap(struct irq_data *d)
 {
 	void __rcu **slot;
=20
+	lockdep_assert_held(&d->domain->root->mutex);
+
 	if (irq_domain_is_nomap(d->domain))
 		return;
=20
 	/* Fix up the revmap. */
-	mutex_lock(&d->domain->revmap_mutex);
 	if (d->hwirq < d->domain->revmap_size) {
 		/* Not using radix tree */
 		rcu_assign_pointer(d->domain->revmap[d->hwirq], d);
@@ -1525,7 +1599,6 @@ static void irq_domain_fix_revmap(struct irq_data *d)
 		if (slot)
 			radix_tree_replace_slot(&d->domain->revmap_tree, slot, d);
 	}
-	mutex_unlock(&d->domain->revmap_mutex);
 }
=20
 /**
@@ -1541,8 +1614,8 @@ static void irq_domain_fix_revmap(struct irq_data *d)
  */
 int irq_domain_push_irq(struct irq_domain *domain, int virq, void *arg)
 {
-	struct irq_data *child_irq_data;
-	struct irq_data *root_irq_data =3D irq_get_irq_data(virq);
+	struct irq_data *irq_data =3D irq_get_irq_data(virq);
+	struct irq_data *parent_irq_data;
 	struct irq_desc *desc;
 	int rv =3D 0;
=20
@@ -1567,47 +1640,46 @@ int irq_domain_push_irq(struct irq_domain *domain, in=
t virq, void *arg)
 	if (WARN_ON(!irq_domain_is_hierarchy(domain)))
 		return -EINVAL;
=20
-	if (!root_irq_data)
+	if (!irq_data)
 		return -EINVAL;
=20
-	if (domain->parent !=3D root_irq_data->domain)
+	if (domain->parent !=3D irq_data->domain)
 		return -EINVAL;
=20
-	child_irq_data =3D kzalloc_node(sizeof(*child_irq_data), GFP_KERNEL,
-				      irq_data_get_node(root_irq_data));
-	if (!child_irq_data)
+	parent_irq_data =3D kzalloc_node(sizeof(*parent_irq_data), GFP_KERNEL,
+				       irq_data_get_node(irq_data));
+	if (!parent_irq_data)
 		return -ENOMEM;
=20
-	mutex_lock(&irq_domain_mutex);
+	mutex_lock(&domain->root->mutex);
=20
 	/* Copy the original irq_data. */
-	*child_irq_data =3D *root_irq_data;
+	*parent_irq_data =3D *irq_data;
=20
 	/*
-	 * Overwrite the root_irq_data, which is embedded in struct
-	 * irq_desc, with values for this domain.
+	 * Overwrite the irq_data, which is embedded in struct irq_desc, with
+	 * values for this domain.
 	 */
-	root_irq_data->parent_data =3D child_irq_data;
-	root_irq_data->domain =3D domain;
-	root_irq_data->mask =3D 0;
-	root_irq_data->hwirq =3D 0;
-	root_irq_data->chip =3D NULL;
-	root_irq_data->chip_data =3D NULL;
+	irq_data->parent_data =3D parent_irq_data;
+	irq_data->domain =3D domain;
+	irq_data->mask =3D 0;
+	irq_data->hwirq =3D 0;
+	irq_data->chip =3D NULL;
+	irq_data->chip_data =3D NULL;
=20
 	/* May (probably does) set hwirq, chip, etc. */
 	rv =3D irq_domain_alloc_irqs_hierarchy(domain, virq, 1, arg);
 	if (rv) {
 		/* Restore the original irq_data. */
-		*root_irq_data =3D *child_irq_data;
-		kfree(child_irq_data);
+		*irq_data =3D *parent_irq_data;
+		kfree(parent_irq_data);
 		goto error;
 	}
=20
-	irq_domain_fix_revmap(child_irq_data);
-	irq_domain_set_mapping(domain, root_irq_data->hwirq, root_irq_data);
-
+	irq_domain_fix_revmap(parent_irq_data);
+	irq_domain_set_mapping(domain, irq_data->hwirq, irq_data);
 error:
-	mutex_unlock(&irq_domain_mutex);
+	mutex_unlock(&domain->root->mutex);
=20
 	return rv;
 }
@@ -1623,8 +1695,8 @@ EXPORT_SYMBOL_GPL(irq_domain_push_irq);
  */
 int irq_domain_pop_irq(struct irq_domain *domain, int virq)
 {
-	struct irq_data *root_irq_data =3D irq_get_irq_data(virq);
-	struct irq_data *child_irq_data;
+	struct irq_data *irq_data =3D irq_get_irq_data(virq);
+	struct irq_data *parent_irq_data;
 	struct irq_data *tmp_irq_data;
 	struct irq_desc *desc;
=20
@@ -1646,37 +1718,37 @@ int irq_domain_pop_irq(struct irq_domain *domain, int=
 virq)
 	if (domain =3D=3D NULL)
 		return -EINVAL;
=20
-	if (!root_irq_data)
+	if (!irq_data)
 		return -EINVAL;
=20
 	tmp_irq_data =3D irq_domain_get_irq_data(domain, virq);
=20
 	/* We can only "pop" if this domain is at the top of the list */
-	if (WARN_ON(root_irq_data !=3D tmp_irq_data))
+	if (WARN_ON(irq_data !=3D tmp_irq_data))
 		return -EINVAL;
=20
-	if (WARN_ON(root_irq_data->domain !=3D domain))
+	if (WARN_ON(irq_data->domain !=3D domain))
 		return -EINVAL;
=20
-	child_irq_data =3D root_irq_data->parent_data;
-	if (WARN_ON(!child_irq_data))
+	parent_irq_data =3D irq_data->parent_data;
+	if (WARN_ON(!parent_irq_data))
 		return -EINVAL;
=20
-	mutex_lock(&irq_domain_mutex);
+	mutex_lock(&domain->root->mutex);
=20
-	root_irq_data->parent_data =3D NULL;
+	irq_data->parent_data =3D NULL;
=20
-	irq_domain_clear_mapping(domain, root_irq_data->hwirq);
+	irq_domain_clear_mapping(domain, irq_data->hwirq);
 	irq_domain_free_irqs_hierarchy(domain, virq, 1);
=20
 	/* Restore the original irq_data. */
-	*root_irq_data =3D *child_irq_data;
+	*irq_data =3D *parent_irq_data;
=20
-	irq_domain_fix_revmap(root_irq_data);
+	irq_domain_fix_revmap(irq_data);
=20
-	mutex_unlock(&irq_domain_mutex);
+	mutex_unlock(&domain->root->mutex);
=20
-	kfree(child_irq_data);
+	kfree(parent_irq_data);
=20
 	return 0;
 }
@@ -1690,17 +1762,20 @@ EXPORT_SYMBOL_GPL(irq_domain_pop_irq);
 void irq_domain_free_irqs(unsigned int virq, unsigned int nr_irqs)
 {
 	struct irq_data *data =3D irq_get_irq_data(virq);
+	struct irq_domain *domain;
 	int i;
=20
 	if (WARN(!data || !data->domain || !data->domain->ops->free,
 		 "NULL pointer, cannot free irq\n"))
 		return;
=20
-	mutex_lock(&irq_domain_mutex);
+	domain =3D data->domain;
+
+	mutex_lock(&domain->root->mutex);
 	for (i =3D 0; i < nr_irqs; i++)
 		irq_domain_remove_irq(virq + i);
-	irq_domain_free_irqs_hierarchy(data->domain, virq, nr_irqs);
-	mutex_unlock(&irq_domain_mutex);
+	irq_domain_free_irqs_hierarchy(domain, virq, nr_irqs);
+	mutex_unlock(&domain->root->mutex);
=20
 	irq_domain_free_irq_data(virq, nr_irqs);
 	irq_free_descs(virq, nr_irqs);
@@ -1865,6 +1940,13 @@ void irq_domain_set_info(struct irq_domain *domain, un=
signed int virq,
 	irq_set_handler_data(virq, handler_data);
 }
=20
+static int irq_domain_alloc_irqs_locked(struct irq_domain *domain, int irq_b=
ase,
+					unsigned int nr_irqs, int node, void *arg,
+					bool realloc, const struct irq_affinity_desc *affinity)
+{
+	return -EINVAL;
+}
+
 static void irq_domain_check_hierarchy(struct irq_domain *domain)
 {
 }
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 5b7cf28df290..8ce75495e04f 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -723,10 +723,13 @@ EXPORT_SYMBOL(disable_irq_nosync);
  *	to complete before returning. If you use this function while
  *	holding a resource the IRQ handler may need you will deadlock.
  *
- *	This function may be called - with care - from IRQ context.
+ *	Can only be called from preemptible code as it might sleep when
+ *	an interrupt thread is associated to @irq.
+ *
  */
 void disable_irq(unsigned int irq)
 {
+	might_sleep();
 	if (!__disable_irq_nosync(irq))
 		synchronize_irq(irq);
 }
diff --git a/lib/Makefile b/lib/Makefile
index 4d9461bfea42..a4665a802e87 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -353,6 +353,8 @@ obj-$(CONFIG_SBITMAP) +=3D sbitmap.o
=20
 obj-$(CONFIG_PARMAN) +=3D parman.o
=20
+obj-y +=3D group_cpus.o
+
 # GCC library routines
 obj-$(CONFIG_GENERIC_LIB_ASHLDI3) +=3D ashldi3.o
 obj-$(CONFIG_GENERIC_LIB_ASHRDI3) +=3D ashrdi3.o
diff --git a/lib/group_cpus.c b/lib/group_cpus.c
new file mode 100644
index 000000000000..9c837a35fef7
--- /dev/null
+++ b/lib/group_cpus.c
@@ -0,0 +1,428 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016 Thomas Gleixner.
+ * Copyright (C) 2016-2017 Christoph Hellwig.
+ */
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/cpu.h>
+#include <linux/sort.h>
+#include <linux/group_cpus.h>
+
+#ifdef CONFIG_SMP
+
+static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
+				unsigned int cpus_per_grp)
+{
+	const struct cpumask *siblmsk;
+	int cpu, sibl;
+
+	for ( ; cpus_per_grp > 0; ) {
+		cpu =3D cpumask_first(nmsk);
+
+		/* Should not happen, but I'm too lazy to think about it */
+		if (cpu >=3D nr_cpu_ids)
+			return;
+
+		cpumask_clear_cpu(cpu, nmsk);
+		cpumask_set_cpu(cpu, irqmsk);
+		cpus_per_grp--;
+
+		/* If the cpu has siblings, use them first */
+		siblmsk =3D topology_sibling_cpumask(cpu);
+		for (sibl =3D -1; cpus_per_grp > 0; ) {
+			sibl =3D cpumask_next(sibl, siblmsk);
+			if (sibl >=3D nr_cpu_ids)
+				break;
+			if (!cpumask_test_and_clear_cpu(sibl, nmsk))
+				continue;
+			cpumask_set_cpu(sibl, irqmsk);
+			cpus_per_grp--;
+		}
+	}
+}
+
+static cpumask_var_t *alloc_node_to_cpumask(void)
+{
+	cpumask_var_t *masks;
+	int node;
+
+	masks =3D kcalloc(nr_node_ids, sizeof(cpumask_var_t), GFP_KERNEL);
+	if (!masks)
+		return NULL;
+
+	for (node =3D 0; node < nr_node_ids; node++) {
+		if (!zalloc_cpumask_var(&masks[node], GFP_KERNEL))
+			goto out_unwind;
+	}
+
+	return masks;
+
+out_unwind:
+	while (--node >=3D 0)
+		free_cpumask_var(masks[node]);
+	kfree(masks);
+	return NULL;
+}
+
+static void free_node_to_cpumask(cpumask_var_t *masks)
+{
+	int node;
+
+	for (node =3D 0; node < nr_node_ids; node++)
+		free_cpumask_var(masks[node]);
+	kfree(masks);
+}
+
+static void build_node_to_cpumask(cpumask_var_t *masks)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		cpumask_set_cpu(cpu, masks[cpu_to_node(cpu)]);
+}
+
+static int get_nodes_in_cpumask(cpumask_var_t *node_to_cpumask,
+				const struct cpumask *mask, nodemask_t *nodemsk)
+{
+	int n, nodes =3D 0;
+
+	/* Calculate the number of nodes in the supplied affinity mask */
+	for_each_node(n) {
+		if (cpumask_intersects(mask, node_to_cpumask[n])) {
+			node_set(n, *nodemsk);
+			nodes++;
+		}
+	}
+	return nodes;
+}
+
+struct node_groups {
+	unsigned id;
+
+	union {
+		unsigned ngroups;
+		unsigned ncpus;
+	};
+};
+
+static int ncpus_cmp_func(const void *l, const void *r)
+{
+	const struct node_groups *ln =3D l;
+	const struct node_groups *rn =3D r;
+
+	return ln->ncpus - rn->ncpus;
+}
+
+/*
+ * Allocate group number for each node, so that for each node:
+ *
+ * 1) the allocated number is >=3D 1
+ *
+ * 2) the allocated number is <=3D active CPU number of this node
+ *
+ * The actual allocated total groups may be less than @numgrps when
+ * active total CPU number is less than @numgrps.
+ *
+ * Active CPUs means the CPUs in '@cpu_mask AND @node_to_cpumask[]'
+ * for each node.
+ */
+static void alloc_nodes_groups(unsigned int numgrps,
+			       cpumask_var_t *node_to_cpumask,
+			       const struct cpumask *cpu_mask,
+			       const nodemask_t nodemsk,
+			       struct cpumask *nmsk,
+			       struct node_groups *node_groups)
+{
+	unsigned n, remaining_ncpus =3D 0;
+
+	for (n =3D 0; n < nr_node_ids; n++) {
+		node_groups[n].id =3D n;
+		node_groups[n].ncpus =3D UINT_MAX;
+	}
+
+	for_each_node_mask(n, nodemsk) {
+		unsigned ncpus;
+
+		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
+		ncpus =3D cpumask_weight(nmsk);
+
+		if (!ncpus)
+			continue;
+		remaining_ncpus +=3D ncpus;
+		node_groups[n].ncpus =3D ncpus;
+	}
+
+	numgrps =3D min_t(unsigned, remaining_ncpus, numgrps);
+
+	sort(node_groups, nr_node_ids, sizeof(node_groups[0]),
+	     ncpus_cmp_func, NULL);
+
+	/*
+	 * Allocate groups for each node according to the ratio of this
+	 * node's nr_cpus to remaining un-assigned ncpus. 'numgrps' is
+	 * bigger than number of active numa nodes. Always start the
+	 * allocation from the node with minimized nr_cpus.
+	 *
+	 * This way guarantees that each active node gets allocated at
+	 * least one group, and the theory is simple: over-allocation
+	 * is only done when this node is assigned by one group, so
+	 * other nodes will be allocated >=3D 1 groups, since 'numgrps' is
+	 * bigger than number of numa nodes.
+	 *
+	 * One perfect invariant is that number of allocated groups for
+	 * each node is <=3D CPU count of this node:
+	 *
+	 * 1) suppose there are two nodes: A and B
+	 * 	ncpu(X) is CPU count of node X
+	 * 	grps(X) is the group count allocated to node X via this
+	 * 	algorithm
+	 *
+	 * 	ncpu(A) <=3D ncpu(B)
+	 * 	ncpu(A) + ncpu(B) =3D N
+	 * 	grps(A) + grps(B) =3D G
+	 *
+	 * 	grps(A) =3D max(1, round_down(G * ncpu(A) / N))
+	 * 	grps(B) =3D G - grps(A)
+	 *
+	 * 	both N and G are integer, and 2 <=3D G <=3D N, suppose
+	 * 	G =3D N - delta, and 0 <=3D delta <=3D N - 2
+	 *
+	 * 2) obviously grps(A) <=3D ncpu(A) because:
+	 *
+	 * 	if grps(A) is 1, then grps(A) <=3D ncpu(A) given
+	 * 	ncpu(A) >=3D 1
+	 *
+	 * 	otherwise,
+	 * 		grps(A) <=3D G * ncpu(A) / N <=3D ncpu(A), given G <=3D N
+	 *
+	 * 3) prove how grps(B) <=3D ncpu(B):
+	 *
+	 * 	if round_down(G * ncpu(A) / N) =3D=3D 0, vecs(B) won't be
+	 * 	over-allocated, so grps(B) <=3D ncpu(B),
+	 *
+	 * 	otherwise:
+	 *
+	 * 	grps(A) =3D
+	 * 		round_down(G * ncpu(A) / N) =3D
+	 * 		round_down((N - delta) * ncpu(A) / N) =3D
+	 * 		round_down((N * ncpu(A) - delta * ncpu(A)) / N)	 >=3D
+	 * 		round_down((N * ncpu(A) - delta * N) / N)	 =3D
+	 * 		cpu(A) - delta
+	 *
+	 * 	then:
+	 *
+	 * 	grps(A) - G >=3D ncpu(A) - delta - G
+	 * 	=3D>
+	 * 	G - grps(A) <=3D G + delta - ncpu(A)
+	 * 	=3D>
+	 * 	grps(B) <=3D N - ncpu(A)
+	 * 	=3D>
+	 * 	grps(B) <=3D cpu(B)
+	 *
+	 * For nodes >=3D 3, it can be thought as one node and another big
+	 * node given that is exactly what this algorithm is implemented,
+	 * and we always re-calculate 'remaining_ncpus' & 'numgrps', and
+	 * finally for each node X: grps(X) <=3D ncpu(X).
+	 *
+	 */
+	for (n =3D 0; n < nr_node_ids; n++) {
+		unsigned ngroups, ncpus;
+
+		if (node_groups[n].ncpus =3D=3D UINT_MAX)
+			continue;
+
+		WARN_ON_ONCE(numgrps =3D=3D 0);
+
+		ncpus =3D node_groups[n].ncpus;
+		ngroups =3D max_t(unsigned, 1,
+				 numgrps * ncpus / remaining_ncpus);
+		WARN_ON_ONCE(ngroups > ncpus);
+
+		node_groups[n].ngroups =3D ngroups;
+
+		remaining_ncpus -=3D ncpus;
+		numgrps -=3D ngroups;
+	}
+}
+
+static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
+			       cpumask_var_t *node_to_cpumask,
+			       const struct cpumask *cpu_mask,
+			       struct cpumask *nmsk, struct cpumask *masks)
+{
+	unsigned int i, n, nodes, cpus_per_grp, extra_grps, done =3D 0;
+	unsigned int last_grp =3D numgrps;
+	unsigned int curgrp =3D startgrp;
+	nodemask_t nodemsk =3D NODE_MASK_NONE;
+	struct node_groups *node_groups;
+
+	if (cpumask_empty(cpu_mask))
+		return 0;
+
+	nodes =3D get_nodes_in_cpumask(node_to_cpumask, cpu_mask, &nodemsk);
+
+	/*
+	 * If the number of nodes in the mask is greater than or equal the
+	 * number of groups we just spread the groups across the nodes.
+	 */
+	if (numgrps <=3D nodes) {
+		for_each_node_mask(n, nodemsk) {
+			/* Ensure that only CPUs which are in both masks are set */
+			cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
+			cpumask_or(&masks[curgrp], &masks[curgrp], nmsk);
+			if (++curgrp =3D=3D last_grp)
+				curgrp =3D 0;
+		}
+		return numgrps;
+	}
+
+	node_groups =3D kcalloc(nr_node_ids,
+			       sizeof(struct node_groups),
+			       GFP_KERNEL);
+	if (!node_groups)
+		return -ENOMEM;
+
+	/* allocate group number for each node */
+	alloc_nodes_groups(numgrps, node_to_cpumask, cpu_mask,
+			   nodemsk, nmsk, node_groups);
+	for (i =3D 0; i < nr_node_ids; i++) {
+		unsigned int ncpus, v;
+		struct node_groups *nv =3D &node_groups[i];
+
+		if (nv->ngroups =3D=3D UINT_MAX)
+			continue;
+
+		/* Get the cpus on this node which are in the mask */
+		cpumask_and(nmsk, cpu_mask, node_to_cpumask[nv->id]);
+		ncpus =3D cpumask_weight(nmsk);
+		if (!ncpus)
+			continue;
+
+		WARN_ON_ONCE(nv->ngroups > ncpus);
+
+		/* Account for rounding errors */
+		extra_grps =3D ncpus - nv->ngroups * (ncpus / nv->ngroups);
+
+		/* Spread allocated groups on CPUs of the current node */
+		for (v =3D 0; v < nv->ngroups; v++, curgrp++) {
+			cpus_per_grp =3D ncpus / nv->ngroups;
+
+			/* Account for extra groups to compensate rounding errors */
+			if (extra_grps) {
+				cpus_per_grp++;
+				--extra_grps;
+			}
+
+			/*
+			 * wrapping has to be considered given 'startgrp'
+			 * may start anywhere
+			 */
+			if (curgrp >=3D last_grp)
+				curgrp =3D 0;
+			grp_spread_init_one(&masks[curgrp], nmsk,
+						cpus_per_grp);
+		}
+		done +=3D nv->ngroups;
+	}
+	kfree(node_groups);
+	return done;
+}
+
+/**
+ * group_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
+ * @numgrps: number of groups
+ *
+ * Return: cpumask array if successful, NULL otherwise. And each element
+ * includes CPUs assigned to this group
+ *
+ * Try to put close CPUs from viewpoint of CPU and NUMA locality into
+ * same group, and run two-stage grouping:
+ *	1) allocate present CPUs on these groups evenly first
+ *	2) allocate other possible CPUs on these groups evenly
+ *
+ * We guarantee in the resulted grouping that all CPUs are covered, and
+ * no same CPU is assigned to multiple groups
+ */
+struct cpumask *group_cpus_evenly(unsigned int numgrps)
+{
+	unsigned int curgrp =3D 0, nr_present =3D 0, nr_others =3D 0;
+	cpumask_var_t *node_to_cpumask;
+	cpumask_var_t nmsk, npresmsk;
+	int ret =3D -ENOMEM;
+	struct cpumask *masks =3D NULL;
+
+	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
+		return NULL;
+
+	if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
+		goto fail_nmsk;
+
+	node_to_cpumask =3D alloc_node_to_cpumask();
+	if (!node_to_cpumask)
+		goto fail_npresmsk;
+
+	masks =3D kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
+	if (!masks)
+		goto fail_node_to_cpumask;
+
+	/* Stabilize the cpumasks */
+	cpus_read_lock();
+	build_node_to_cpumask(node_to_cpumask);
+
+	/* grouping present CPUs first */
+	ret =3D __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
+				  cpu_present_mask, nmsk, masks);
+	if (ret < 0)
+		goto fail_build_affinity;
+	nr_present =3D ret;
+
+	/*
+	 * Allocate non present CPUs starting from the next group to be
+	 * handled. If the grouping of present CPUs already exhausted the
+	 * group space, assign the non present CPUs to the already
+	 * allocated out groups.
+	 */
+	if (nr_present >=3D numgrps)
+		curgrp =3D 0;
+	else
+		curgrp =3D nr_present;
+	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
+	ret =3D __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
+				  npresmsk, nmsk, masks);
+	if (ret >=3D 0)
+		nr_others =3D ret;
+
+ fail_build_affinity:
+	cpus_read_unlock();
+
+	if (ret >=3D 0)
+		WARN_ON(nr_present + nr_others < numgrps);
+
+ fail_node_to_cpumask:
+	free_node_to_cpumask(node_to_cpumask);
+
+ fail_npresmsk:
+	free_cpumask_var(npresmsk);
+
+ fail_nmsk:
+	free_cpumask_var(nmsk);
+	if (ret < 0) {
+		kfree(masks);
+		return NULL;
+	}
+	return masks;
+}
+#else /* CONFIG_SMP */
+struct cpumask *group_cpus_evenly(unsigned int numgrps)
+{
+	struct cpumask *masks =3D kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
+
+	if (!masks)
+		return NULL;
+
+	/* assign all CPUs(cpu 0) to the 1st group only */
+	cpumask_copy(&masks[0], cpu_possible_mask);
+	return masks;
+}
+#endif /* CONFIG_SMP */

