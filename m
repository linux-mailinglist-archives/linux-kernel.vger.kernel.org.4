Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C7D64372B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbiLEVmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbiLEVlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:41:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981F52CCBD;
        Mon,  5 Dec 2022 13:41:49 -0800 (PST)
Date:   Mon, 05 Dec 2022 21:41:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670276507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4+4og2iRGnjKsCMs0wPcHVoyC3rJ6wiDAU1dBVNGDpo=;
        b=ymAHP4oBq4RHcDQiuz+zdKn/4HoYZVE7GR4g/Iaba5+NdrFNzOCoNkEwm1vNYW3u9KupHB
        g5AheSgHF3le/tVDPjW5on8HE+SGK3Ck/yMpC+caDCkHDxhmIN9vJu4/MeSP+NCYD778hs
        62Uq4TkmwsFHfSbGoYoDAt+ONp7LM6sHvoYpz4lrUMJgtqn1/tcx6rHDhTv5MrJJib/1uA
        611oJvf7CWRmAoBeZfhZ+PHhKS0w2yGith5NAGtRS7kmYz5npGthDZvgQU2wCQePRZCrCC
        d8fnUeubgz7UI28lcZO5JYkBVtvMcWNMg6CJNc0Ct+AYhco+HWOTC4SIQ/HqUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670276507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4+4og2iRGnjKsCMs0wPcHVoyC3rJ6wiDAU1dBVNGDpo=;
        b=YVf8brk9lqQVaiPIi2rGd0IqLWKUwDzJB3C1rilKcuyjHcJimneP3LXpW6ZobhJ5SWeSrN
        C+69vHQx7/6wo+AQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Provide pci_ims_alloc/free_irq()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124232326.961711347@linutronix.de>
References: <20221124232326.961711347@linutronix.de>
MIME-Version: 1.0
Message-ID: <167027650695.4906.1070294054247729124.tip-bot2@tip-bot2>
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

Commit-ID:     c9e5bea273834a63b5e9ba90ad94b305ba50704e
Gitweb:        https://git.kernel.org/tip/c9e5bea273834a63b5e9ba90ad94b305ba50704e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:26:31 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 22:22:35 +01:00

PCI/MSI: Provide pci_ims_alloc/free_irq()

Single vector allocation which allocates the next free index in the IMS
space. The free function releases.

All allocated vectors are released also via pci_free_vectors() which is
also releasing MSI/MSI-X vectors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124232326.961711347@linutronix.de

---
 drivers/pci/msi/api.c | 50 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/pci.h   |  3 +++-
 2 files changed, 53 insertions(+)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index c8816db..b8009aa 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -366,6 +366,56 @@ const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
 EXPORT_SYMBOL(pci_irq_get_affinity);
 
 /**
+ * pci_ims_alloc_irq - Allocate an interrupt on a PCI/IMS interrupt domain
+ * @dev:	The PCI device to operate on
+ * @icookie:	Pointer to an IMS implementation specific cookie for this
+ *		IMS instance (PASID, queue ID, pointer...).
+ *		The cookie content is copied into the MSI descriptor for the
+ *		interrupt chip callbacks or domain specific setup functions.
+ * @affdesc:	Optional pointer to an interrupt affinity descriptor
+ *
+ * There is no index for IMS allocations as IMS is an implementation
+ * specific storage and does not have any direct associations between
+ * index, which might be a pure software construct, and device
+ * functionality. This association is established by the driver either via
+ * the index - if there is a hardware table - or in case of purely software
+ * managed IMS implementation the association happens via the
+ * irq_write_msi_msg() callback of the implementation specific interrupt
+ * chip, which utilizes the provided @icookie to store the MSI message in
+ * the appropriate place.
+ *
+ * Return: A struct msi_map
+ *
+ *	On success msi_map::index contains the allocated index (>= 0) and
+ *	msi_map::virq the allocated Linux interrupt number (> 0).
+ *
+ *	On fail msi_map::index contains the error code and msi_map::virq
+ *	is set to 0.
+ */
+struct msi_map pci_ims_alloc_irq(struct pci_dev *dev, union msi_instance_cookie *icookie,
+				 const struct irq_affinity_desc *affdesc)
+{
+	return msi_domain_alloc_irq_at(&dev->dev, MSI_SECONDARY_DOMAIN, MSI_ANY_INDEX,
+				       affdesc, icookie);
+}
+EXPORT_SYMBOL_GPL(pci_ims_alloc_irq);
+
+/**
+ * pci_ims_free_irq - Allocate an interrupt on a PCI/IMS interrupt domain
+ *		      which was allocated via pci_ims_alloc_irq()
+ * @dev:	The PCI device to operate on
+ * @map:	A struct msi_map describing the interrupt to free as
+ *		returned from pci_ims_alloc_irq()
+ */
+void pci_ims_free_irq(struct pci_dev *dev, struct msi_map map)
+{
+	if (WARN_ON_ONCE(map.index < 0 || map.virq <= 0))
+		return;
+	msi_domain_free_irqs_range(&dev->dev, MSI_SECONDARY_DOMAIN, map.index, map.index);
+}
+EXPORT_SYMBOL_GPL(pci_ims_free_irq);
+
+/**
  * pci_free_irq_vectors() - Free previously allocated IRQs for a device
  * @dev: the PCI device to operate on
  *
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1592b63..aa514b5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2491,6 +2491,9 @@ struct msi_domain_template;
 
 bool pci_create_ims_domain(struct pci_dev *pdev, const struct msi_domain_template *template,
 			   unsigned int hwsize, void *data);
+struct msi_map pci_ims_alloc_irq(struct pci_dev *pdev, union msi_instance_cookie *icookie,
+				 const struct irq_affinity_desc *affdesc);
+void pci_ims_free_irq(struct pci_dev *pdev, struct msi_map map);
 
 #include <linux/dma-mapping.h>
 
