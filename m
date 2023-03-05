Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADD46AAEA6
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 09:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjCEIzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 03:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCEIzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 03:55:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34E3BBB1
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 00:55:00 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678006497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=G5qK0cf96IOotNupUsQvBaE4OYdkjC+Vg5n4Iv6niHg=;
        b=I8VpbrhAS1DupUj7g0z21VhlQU/avesiXSxcO4ylP6fed/iGxhso8j7joczA2h0XW3A3si
        KATyN3zmC9xLkv87qXv1w5GR5tZkg1FjjzVmCaZVFskAtqjJicJ3fVRmjmJRB1KYFZXnN4
        /MA92lUhFYBdb0elP1McGmctjLJMLl7ianQdMbqr8eHiQuIwxcf1alg7qgQ65i29FUbCu7
        u5mjutyCDsQoI62BV6C3ew083lN/to6NmAahi4EUkmLtCdaZJcjokLEHqi0qFTd51R1wMG
        h8AdtvLSDkEqQGxa48FvO0XX4M2tbDVhpdXl/DU5utFlgSqpVnUZC9iVaLbL1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678006497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=G5qK0cf96IOotNupUsQvBaE4OYdkjC+Vg5n4Iv6niHg=;
        b=3cb4O1U24M7od50mfx9ciDOm13bkNOP7H4sVAjkpDuOgOzm75nXtBsGkhQ+VcuBnMgC060
        sxWIw3sRpo5QSKCQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for v6.3-rc1
Message-ID: <167800644191.309766.5757985605946414576.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun,  5 Mar 2023 09:54:57 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2023-=
03-05

up to:  0fb7fb713461: genirq/msi, platform-msi: Ensure that MSI descriptors a=
re unreferenced


A set of updates for the interrupt susbsystem:

  - Prevent possible NULL pointer derefences in irq_data_get_affinity_mask()
    and irq_domain_create_hierarchy().

  - Take the per device MSI lock before invoking code which relies
    on it being hold.

  - Make sure that MSI descriptors are unreferenced before freeing
    them. This was overlooked when the platform MSI code was converted to
    use core infrastructure and results in a fals positive warning.

  - Remove dead code in the MSI subsystem.

  - Clarify the documentation for pci_msix_free_irq().

  - More kobj_type constification.

Thanks,

	tglx

------------------>
Johan Hovold (21):
      genirq/msi: Drop dead domain name assignment

Juergen Gross (1):
      irqdomain: Add missing NULL pointer check in irq_domain_create_hierarch=
y()

Marc Zyngier (4):
      genirq/msi: Take the per-device MSI lock before validating the control =
structure

Reinette Chatre (1):
      PCI/MSI: Clarify usage of pci_msix_free_irq()

Sergey Shtylyov (1):
      genirq/ipi: Fix NULL pointer deref in irq_data_get_affinity_mask()

Thomas Gleixner (1):
      genirq/msi, platform-msi: Ensure that MSI descriptors are unreferenced

Thomas Wei=C3=9Fschuh (1):
      genirq/irqdesc: Make kobj_type structures constant

 drivers/base/platform-msi.c |    1 +
 drivers/pci/msi/api.c       |    4 ++--
 include/linux/msi.h         |    2 ++
 kernel/irq/ipi.c            |    8 ++++++--
 kernel/irq/irqdesc.c        |    4 ++--
 kernel/irq/irqdomain.c      |    3 ++-
 kernel/irq/msi.c            |   28 +++++++++++++++++++++++-----
 kernel/irq/msi.c            |    9 ++++++---
 8 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 5883e7634a2b..f37ad34c80ec 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -324,6 +324,7 @@ void platform_msi_device_domain_free(struct irq_domain *d=
omain, unsigned int vir
 	struct platform_msi_priv_data *data =3D domain->host_data;
=20
 	msi_lock_descs(data->dev);
+	msi_domain_depopulate_descs(data->dev, virq, nr_irqs);
 	irq_domain_free_irqs_common(domain, virq, nr_irqs);
 	msi_free_msi_descs_range(data->dev, virq, virq + nr_irqs - 1);
 	msi_unlock_descs(data->dev);
diff --git a/include/linux/msi.h b/include/linux/msi.h
index a112b913fff9..15dd71817996 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -631,6 +631,8 @@ int msi_domain_prepare_irqs(struct irq_domain *domain, st=
ruct device *dev,
 			    int nvec, msi_alloc_info_t *args);
 int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
 			     int virq, int nvec, msi_alloc_info_t *args);
+void msi_domain_depopulate_descs(struct device *dev, int virq, int nvec);
+
 struct irq_domain *
 __platform_msi_create_device_domain(struct device *dev,
 				    unsigned int nvec,
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index aa5b7eeeceb8..6522dfb2e49c 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1172,7 +1172,8 @@ struct irq_domain *irq_domain_create_hierarchy(struct i=
rq_domain *parent,
 		domain =3D __irq_domain_create(fwnode, 0, ~0, 0, ops, host_data);
=20
 	if (domain) {
-		domain->root =3D parent->root;
+		if (parent)
+			domain->root =3D parent->root;
 		domain->parent =3D parent;
 		domain->flags |=3D flags;
=20
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 13d96495e6d0..d169ee0c1799 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -830,11 +830,8 @@ static struct irq_domain *__msi_create_irq_domain(struct=
 fwnode_handle *fwnode,
 	domain =3D irq_domain_create_hierarchy(parent, flags | IRQ_DOMAIN_FLAG_MSI,=
 0,
 					     fwnode, &msi_domain_ops, info);
=20
-	if (domain) {
-		if (!domain->name && info->chip)
-			domain->name =3D info->chip->name;
+	if (domain)
 		irq_domain_update_bus_token(domain, info->bus_token);
-	}
=20
 	return domain;
 }
@@ -1112,14 +1109,35 @@ int msi_domain_populate_irqs(struct irq_domain *domai=
n, struct device *dev,
 	return 0;
=20
 fail:
-	for (--virq; virq >=3D virq_base; virq--)
+	for (--virq; virq >=3D virq_base; virq--) {
+		msi_domain_depopulate_descs(dev, virq, 1);
 		irq_domain_free_irqs_common(domain, virq, 1);
+	}
 	msi_domain_free_descs(dev, &ctrl);
 unlock:
 	msi_unlock_descs(dev);
 	return ret;
 }
=20
+void msi_domain_depopulate_descs(struct device *dev, int virq_base, int nvec)
+{
+	struct msi_ctrl ctrl =3D {
+		.domid	=3D MSI_DEFAULT_DOMAIN,
+		.first  =3D virq_base,
+		.last	=3D virq_base + nvec - 1,
+	};
+	struct msi_desc *desc;
+	struct xarray *xa;
+	unsigned long idx;
+
+	if (!msi_ctrl_valid(dev, &ctrl))
+		return;
+
+	xa =3D &dev->msi.data->__domains[ctrl.domid].store;
+	xa_for_each_range(xa, idx, desc, ctrl.first, ctrl.last)
+		desc->irq =3D 0;
+}
+
 /*
  * Carefully check whether the device can use reservation mode. If
  * reservation mode is enabled then the early activation will assign a
diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index b8009aa11f3c..be679aa5db64 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -163,11 +163,11 @@ EXPORT_SYMBOL_GPL(pci_msix_alloc_irq_at);
=20
 /**
  * pci_msix_free_irq - Free an interrupt on a PCI/MSIX interrupt domain
- *		      which was allocated via pci_msix_alloc_irq_at()
  *
  * @dev:	The PCI device to operate on
  * @map:	A struct msi_map describing the interrupt to free
- *		as returned from the allocation function.
+ *
+ * Undo an interrupt vector allocation. Does not disable MSI-X.
  */
 void pci_msix_free_irq(struct pci_dev *dev, struct msi_map map)
 {
diff --git a/kernel/irq/ipi.c b/kernel/irq/ipi.c
index bbd945bacef0..961d4af76af3 100644
--- a/kernel/irq/ipi.c
+++ b/kernel/irq/ipi.c
@@ -188,9 +188,9 @@ EXPORT_SYMBOL_GPL(ipi_get_hwirq);
 static int ipi_send_verify(struct irq_chip *chip, struct irq_data *data,
 			   const struct cpumask *dest, unsigned int cpu)
 {
-	const struct cpumask *ipimask =3D irq_data_get_affinity_mask(data);
+	const struct cpumask *ipimask;
=20
-	if (!chip || !ipimask)
+	if (!chip || !data)
 		return -EINVAL;
=20
 	if (!chip->ipi_send_single && !chip->ipi_send_mask)
@@ -199,6 +199,10 @@ static int ipi_send_verify(struct irq_chip *chip, struct=
 irq_data *data,
 	if (cpu >=3D nr_cpu_ids)
 		return -EINVAL;
=20
+	ipimask =3D irq_data_get_affinity_mask(data);
+	if (!ipimask)
+		return -EINVAL;
+
 	if (dest) {
 		if (!cpumask_subset(dest, ipimask))
 			return -EINVAL;
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index fd0996274401..240e145e969f 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -277,7 +277,7 @@ static struct attribute *irq_attrs[] =3D {
 };
 ATTRIBUTE_GROUPS(irq);
=20
-static struct kobj_type irq_kobj_type =3D {
+static const struct kobj_type irq_kobj_type =3D {
 	.release	=3D irq_kobj_release,
 	.sysfs_ops	=3D &kobj_sysfs_ops,
 	.default_groups =3D irq_groups,
@@ -335,7 +335,7 @@ postcore_initcall(irq_sysfs_init);
=20
 #else /* !CONFIG_SYSFS */
=20
-static struct kobj_type irq_kobj_type =3D {
+static const struct kobj_type irq_kobj_type =3D {
 	.release	=3D irq_kobj_release,
 };
=20
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 783a3e6a0b10..13d96495e6d0 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1084,10 +1084,13 @@ int msi_domain_populate_irqs(struct irq_domain *domai=
n, struct device *dev,
 	struct xarray *xa;
 	int ret, virq;
=20
-	if (!msi_ctrl_valid(dev, &ctrl))
-		return -EINVAL;
-
 	msi_lock_descs(dev);
+
+	if (!msi_ctrl_valid(dev, &ctrl)) {
+		ret =3D -EINVAL;
+		goto unlock;
+	}
+
 	ret =3D msi_domain_add_simple_msi_descs(dev, &ctrl);
 	if (ret)
 		goto unlock;

