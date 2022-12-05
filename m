Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAB9643013
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbiLESZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbiLESZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573C5209BF;
        Mon,  5 Dec 2022 10:25:15 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264712;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=px0gOeb7ikblRKz8qX8/dv8XPsZxul3gerxjK2KGYy0=;
        b=U2wY9yJWrm1B+Po63i03jAMh3HGi7Z+w1J5e7SF1DTu8p0mSoG1We8/Soc4pIWkq5qWsyp
        +GdpTb7mc/pUXwYZIFfYRECZOKLwVTPsxoLszLZvYwwUSAUqORqCvbg/C6kXIKiN0iUkF9
        inMyWVrh1fU/KtV5eCN9SWVqUXBSDjQIv/DH3qjWrwUJYndCA95B1k7e1WQEdCZWP4RMo2
        kWA9dxKBSN1DGM9V2nhwO+zVLAN7KQhDSQ5GaLSUgnOaQOH4+LCdGMC1QUmdaI+0LuYjU/
        n+F3T3p5FuvpKyR8ZUOTfYT7ITh6d/SWpVlGDZ+paS0lMGUQ4kvPjaXQmwbJ/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264712;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=px0gOeb7ikblRKz8qX8/dv8XPsZxul3gerxjK2KGYy0=;
        b=I3qLWlWxcMuLx+KRyXpBzrP5Xofv4MGi8oPAGYh+LI9OY1aXkanQL5QyQk/sAFzEcFBlp/
        zq64vnf7AxMXTMDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Provide post-enable dynamic allocation
 interfaces for MSI-X
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211126232735.547996838@linutronix.de>
References: <20211126232735.547996838@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026471171.4906.1771185011316059382.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     9e8abb30dddff204aa61c90a326cc9793da63efb
Gitweb:        https://git.kernel.org/tip/9e8abb30dddff204aa61c90a326cc9793da63efb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:26:24 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:21:04 +01:00

PCI/MSI: Provide post-enable dynamic allocation interfaces for MSI-X

MSI-X vectors can be allocated after the initial MSI-X enablement, but this
needs explicit support of the underlying interrupt domains.

Provide a function to query the ability and functions to allocate/free
individual vectors post-enable.

The allocation can either request a specific index in the MSI-X table or
with the index argument MSI_ANY_INDEX it allocates the next free vector.

The return value is a struct msi_map which on success contains both index
and the Linux interrupt number. In case of failure index is negative and
the Linux interrupt number is 0.

The allocation function is for a single MSI-X index at a time as that's
sufficient for the most urgent use case VFIO to get rid of the 'disable
MSI-X, reallocate, enable-MSI-X' cycle which is prone to lost interrupts
and redirections to the legacy and obviously unhandled INTx.

As single index allocation is also sufficient for the use cases Jason
Gunthorpe pointed out: Allocation of a MSI-X or IMS vector for a network
queue. See Link below.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/all/20211126232735.547996838@linutronix.de
Link: https://lore.kernel.org/r/20221124232326.731233614@linutronix.de

---
 drivers/pci/msi/api.c       | 67 ++++++++++++++++++++++++++++++++++++-
 drivers/pci/msi/irqdomain.c |  3 +-
 include/linux/pci.h         |  6 +++-
 3 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index 2d46a0c..c8816db 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -113,6 +113,73 @@ int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
 EXPORT_SYMBOL(pci_enable_msix_range);
 
 /**
+ * pci_msix_can_alloc_dyn - Query whether dynamic allocation after enabling
+ *			    MSI-X is supported
+ *
+ * @dev:	PCI device to operate on
+ *
+ * Return: True if supported, false otherwise
+ */
+bool pci_msix_can_alloc_dyn(struct pci_dev *dev)
+{
+	if (!dev->msix_cap)
+		return false;
+
+	return pci_msi_domain_supports(dev, MSI_FLAG_PCI_MSIX_ALLOC_DYN, DENY_LEGACY);
+}
+EXPORT_SYMBOL_GPL(pci_msix_can_alloc_dyn);
+
+/**
+ * pci_msix_alloc_irq_at - Allocate an MSI-X interrupt after enabling MSI-X
+ *			   at a given MSI-X vector index or any free vector index
+ *
+ * @dev:	PCI device to operate on
+ * @index:	Index to allocate. If @index == MSI_ANY_INDEX this allocates
+ *		the next free index in the MSI-X table
+ * @affdesc:	Optional pointer to an affinity descriptor structure. NULL otherwise
+ *
+ * Return: A struct msi_map
+ *
+ *	On success msi_map::index contains the allocated index (>= 0) and
+ *	msi_map::virq contains the allocated Linux interrupt number (> 0).
+ *
+ *	On fail msi_map::index contains the error code and msi_map::virq
+ *	is set to 0.
+ */
+struct msi_map pci_msix_alloc_irq_at(struct pci_dev *dev, unsigned int index,
+				     const struct irq_affinity_desc *affdesc)
+{
+	struct msi_map map = { .index = -ENOTSUPP };
+
+	if (!dev->msix_enabled)
+		return map;
+
+	if (!pci_msix_can_alloc_dyn(dev))
+		return map;
+
+	return msi_domain_alloc_irq_at(&dev->dev, MSI_DEFAULT_DOMAIN, index, affdesc, NULL);
+}
+EXPORT_SYMBOL_GPL(pci_msix_alloc_irq_at);
+
+/**
+ * pci_msix_free_irq - Free an interrupt on a PCI/MSIX interrupt domain
+ *		      which was allocated via pci_msix_alloc_irq_at()
+ *
+ * @dev:	The PCI device to operate on
+ * @map:	A struct msi_map describing the interrupt to free
+ *		as returned from the allocation function.
+ */
+void pci_msix_free_irq(struct pci_dev *dev, struct msi_map map)
+{
+	if (WARN_ON_ONCE(map.index < 0 || map.virq <= 0))
+		return;
+	if (WARN_ON_ONCE(!pci_msix_can_alloc_dyn(dev)))
+		return;
+	msi_domain_free_irqs_range(&dev->dev, MSI_DEFAULT_DOMAIN, map.index, map.index);
+}
+EXPORT_SYMBOL_GPL(pci_msix_free_irq);
+
+/**
  * pci_disable_msix() - Disable MSI-X interrupt mode on device
  * @dev: the PCI device to operate on
  *
diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 8afaef1..deb1930 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -225,7 +225,8 @@ static const struct msi_domain_template pci_msix_template = {
 	},
 
 	.info = {
-		.flags			= MSI_COMMON_FLAGS | MSI_FLAG_PCI_MSIX,
+		.flags			= MSI_COMMON_FLAGS | MSI_FLAG_PCI_MSIX |
+					  MSI_FLAG_PCI_MSIX_ALLOC_DYN,
 		.bus_token		= DOMAIN_BUS_PCI_DEVICE_MSIX,
 	},
 };
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 243e48f..68b14ba 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -38,6 +38,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/resource_ext.h>
+#include <linux/msi_api.h>
 #include <uapi/linux/pci.h>
 
 #include <linux/pci_ids.h>
@@ -1559,6 +1560,11 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 				   unsigned int max_vecs, unsigned int flags,
 				   struct irq_affinity *affd);
 
+bool pci_msix_can_alloc_dyn(struct pci_dev *dev);
+struct msi_map pci_msix_alloc_irq_at(struct pci_dev *dev, unsigned int index,
+				     const struct irq_affinity_desc *affdesc);
+void pci_msix_free_irq(struct pci_dev *pdev, struct msi_map map);
+
 void pci_free_irq_vectors(struct pci_dev *dev);
 int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
 const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev, int vec);
