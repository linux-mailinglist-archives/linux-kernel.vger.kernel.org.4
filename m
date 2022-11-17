Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2197B62DF31
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240414AbiKQPKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240382AbiKQPJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:09:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F11578193;
        Thu, 17 Nov 2022 07:08:15 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:08:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697694;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R92z052x0Z/RkxfXgzr+jnILqKcuvZPHjfI9VE/egSs=;
        b=xgN8M3xVeSpCmxs/oPqAq3f+giVII0ctVd7eCBTQ1bGmZ3IOQVygf6TZi5TMN+NjYij4p1
        i8RMfNUuT+nY950gmGOr+EZEf22f/Y3+j1Fk53aI8LEVTr7AJDWdmFfs9GYKXBfgbsNapu
        nXpZ0M16S/gNY7u+LJGcLetB3Pyw5q35jBQjeJeaD2UZ5G5T1X2i8zfT5/GAUeWaHX+Dd0
        nphY97x2GWdkfFnsSPH1rlvlSwpLj2vd2CHqwrQ6tpAkBTZLsmr6GzBlIX/KW4zWT8q4TQ
        qcpVcPIG8f0aEbyJ2DYTH0Qxmyx5rzlqEtpNE/rjQWNDeali5JKTWfv8idQOQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697694;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R92z052x0Z/RkxfXgzr+jnILqKcuvZPHjfI9VE/egSs=;
        b=Wf1Yl70CFREi1MIhlZO02x/LqA4isZNtP3mxeii6izSCQ/GSOev59RhowmXY45VQtOTm0S
        tsJ+idBcjE6ibWAQ==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Move pci_disable_msi() to api.c
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122014.696798036@linutronix.de>
References: <20221111122014.696798036@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869769325.4906.4999716857847805098.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b12d0bec385b7a58b9e83751e6cd9f04ec3b23a4
Gitweb:        https://git.kernel.org/tip/b12d0bec385b7a58b9e83751e6cd9f04ec3=
b23a4
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:54:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:20 +01:00

PCI/MSI: Move pci_disable_msi() to api.c

msi.c is a maze of randomly sorted functions which makes the code
unreadable. As a first step split the driver visible API and the internal
implementation which also allows proper API documentation via one file.

Create drivers/pci/msi/api.c to group all exported device-driver PCI/MSI
APIs in one C file.

Begin by moving pci_disable_msi() there and add kernel-doc for the function
as appropriate.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20221111122014.696798036@linutronix.de


---
 drivers/pci/msi/Makefile |  3 +--
 drivers/pci/msi/api.c    | 37 +++++++++++++++++++++++++++++++++++++
 drivers/pci/msi/msi.c    | 22 +++++-----------------
 drivers/pci/msi/msi.h    |  4 ++++
 4 files changed, 47 insertions(+), 19 deletions(-)
 create mode 100644 drivers/pci/msi/api.c

diff --git a/drivers/pci/msi/Makefile b/drivers/pci/msi/Makefile
index 4e0a7e0..839ff72 100644
--- a/drivers/pci/msi/Makefile
+++ b/drivers/pci/msi/Makefile
@@ -2,6 +2,5 @@
 #
 # Makefile for the PCI/MSI
 obj-$(CONFIG_PCI)			+=3D pcidev_msi.o
-obj-$(CONFIG_PCI_MSI)			+=3D msi.o
-obj-$(CONFIG_PCI_MSI)			+=3D irqdomain.o
+obj-$(CONFIG_PCI_MSI)			+=3D api.o msi.o irqdomain.o
 obj-$(CONFIG_PCI_MSI_ARCH_FALLBACKS)	+=3D legacy.o
diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
new file mode 100644
index 0000000..7485942
--- /dev/null
+++ b/drivers/pci/msi/api.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI MSI/MSI-X =E2=80=94 Exported APIs for device drivers
+ *
+ * Copyright (C) 2003-2004 Intel
+ * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
+ * Copyright (C) 2016 Christoph Hellwig.
+ * Copyright (C) 2022 Linutronix GmbH
+ */
+
+#include <linux/export.h>
+
+#include "msi.h"
+
+/**
+ * pci_disable_msi() - Disable MSI interrupt mode on device
+ * @dev: the PCI device to operate on
+ *
+ * Legacy device driver API to disable MSI interrupt mode on device,
+ * free earlier allocated interrupt vectors, and restore INTx emulation.
+ * The PCI device Linux IRQ (@dev->irq) is restored to its default
+ * pin-assertion IRQ. This is the cleanup pair of pci_enable_msi().
+ *
+ * NOTE: The newer pci_alloc_irq_vectors() / pci_free_irq_vectors() API
+ * pair should, in general, be used instead.
+ */
+void pci_disable_msi(struct pci_dev *dev)
+{
+	if (!pci_msi_enabled() || !dev || !dev->msi_enabled)
+		return;
+
+	msi_lock_descs(&dev->dev);
+	pci_msi_shutdown(dev);
+	pci_free_msi_irqs(dev);
+	msi_unlock_descs(&dev->dev);
+}
+EXPORT_SYMBOL(pci_disable_msi);
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 5c310df..4a1300b 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -163,7 +163,7 @@ void pci_write_msi_msg(unsigned int irq, struct msi_msg *=
msg)
 }
 EXPORT_SYMBOL_GPL(pci_write_msi_msg);
=20
-static void free_msi_irqs(struct pci_dev *dev)
+void pci_free_msi_irqs(struct pci_dev *dev)
 {
 	pci_msi_teardown_msi_irqs(dev);
=20
@@ -413,7 +413,7 @@ static int msi_capability_init(struct pci_dev *dev, int n=
vec,
=20
 err:
 	pci_msi_unmask(entry, msi_multi_mask(entry));
-	free_msi_irqs(dev);
+	pci_free_msi_irqs(dev);
 fail:
 	dev->msi_enabled =3D 0;
 unlock:
@@ -531,7 +531,7 @@ static int msix_setup_interrupts(struct pci_dev *dev, voi=
d __iomem *base,
 	goto out_unlock;
=20
 out_free:
-	free_msi_irqs(dev);
+	pci_free_msi_irqs(dev);
 out_unlock:
 	msi_unlock_descs(&dev->dev);
 	kfree(masks);
@@ -680,7 +680,7 @@ int pci_msi_vec_count(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_msi_vec_count);
=20
-static void pci_msi_shutdown(struct pci_dev *dev)
+void pci_msi_shutdown(struct pci_dev *dev)
 {
 	struct msi_desc *desc;
=20
@@ -701,18 +701,6 @@ static void pci_msi_shutdown(struct pci_dev *dev)
 	pcibios_alloc_irq(dev);
 }
=20
-void pci_disable_msi(struct pci_dev *dev)
-{
-	if (!pci_msi_enable || !dev || !dev->msi_enabled)
-		return;
-
-	msi_lock_descs(&dev->dev);
-	pci_msi_shutdown(dev);
-	free_msi_irqs(dev);
-	msi_unlock_descs(&dev->dev);
-}
-EXPORT_SYMBOL(pci_disable_msi);
-
 /**
  * pci_msix_vec_count - return the number of device's MSI-X table entries
  * @dev: pointer to the pci_dev data structure of MSI-X device function
@@ -797,7 +785,7 @@ void pci_disable_msix(struct pci_dev *dev)
=20
 	msi_lock_descs(&dev->dev);
 	pci_msix_shutdown(dev);
-	free_msi_irqs(dev);
+	pci_free_msi_irqs(dev);
 	msi_unlock_descs(&dev->dev);
 }
 EXPORT_SYMBOL(pci_disable_msix);
diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
index d8f62d9..6348792 100644
--- a/drivers/pci/msi/msi.h
+++ b/drivers/pci/msi/msi.h
@@ -84,6 +84,10 @@ static inline __attribute_const__ u32 msi_multi_mask(struc=
t msi_desc *desc)
 	return (1 << (1 << desc->pci.msi_attrib.multi_cap)) - 1;
 }
=20
+/* MSI internal functions invoked from the public APIs */
+void pci_msi_shutdown(struct pci_dev *dev);
+void pci_free_msi_irqs(struct pci_dev *dev);
+
 /* Legacy (!IRQDOMAIN) fallbacks */
 #ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
 int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
