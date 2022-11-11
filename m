Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CF5625C24
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 15:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbiKKOBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 09:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiKKOAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 09:00:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCCE56EDD;
        Fri, 11 Nov 2022 05:56:45 -0800 (PST)
Message-ID: <20221111132706.276545278@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=zA5ha748LKhDmb5FPzI8a0g9w0FaiptQdqB8uQ3jTXw=;
        b=EbvSbUXW9nFHqG2WDwQcBgXL97thkoo4raFmOln8yVqrphIoC0l+9hZHMP5m9yUF/GECc4
        KewKET9LzTLaaXlMfLo6KTDhrcxx4M5+mX+9+vH3yYqyIGJ/ZqTeq2DmusSXPt1Z68YxgY
        gm2HvOi0toYYKQZQ96JGxXlsPwFT9gZusZx6nLe+KC+CcnkaRsxW5Uc9XoWBoK0wRPgpYj
        J9QRr2LKPx5Q804UiQ1NffH88HSjiEsfcQn5mEmtNTxXFAgI6qhyQc/nQJlD73AOgazk1w
        bu8MzrlM0qKn3suCr6/sTsQSpD4UC91v1Vt+zPorCA7ZbBpnJ9Sh7zdcWOaIyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=zA5ha748LKhDmb5FPzI8a0g9w0FaiptQdqB8uQ3jTXw=;
        b=T9IEE38gSYKi57w85Y2z1rWZQqe1G0LxfHLdyp2W+2FRPXDVlQDagn6EzBEVSfUZrqqmvL
        KkP6szVnXinU4rAg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [patch 04/20] genirq/irqdomain: Provide IRQ_DOMAIN_FLAG_MSI_PARENT
References: <20221111131813.914374272@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:56:43 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new PCI/IMS (Interrupt Message Store) functionality is allowing
hardware vendors to provide implementation specific storage for the MSI
messages. This can be device memory and also host/guest memory, e.g. in
queue memory which is shared with the hardware.

This requires device specific MSI interrupt domains, which cannot be
achived by expanding the existing PCI/MSI interrupt domain concept which is
a global interrupt domain shared by all PCI devices on a particular (IOMMU)
segment:

                                         |--- device 1
     [Vector]---[Remapping]---[PCI/MSI]--|...
                                         |--- device N

This works because the PCI/MSI[-X] space is uniform, but falls apart with
PCI/IMS which is implementation defined and must be available along with
PCI/MSI[-X] on the same device.

To support PCI/MSI[-X] plus PCI/IMS on the same device it is required to
rework the PCI/MSI interrupt domain hierarchy concept in the following way:

                              |--- [PCI/MSI] device 1
     [Vector]---[Remapping]---|...
                              |--- [PCI/MSI] device N

That allows in the next step to create multiple interrupt domains per device:


                              |--- [PCI/MSI] device 1
                              |--- [PCI/IMS] device 1
     [Vector]---[Remapping]---|...
                              |--- [PCI/MSI] device N
                              |--- [PCI/IMS] device N

So the domain which previously created the global PCI/MSI domain must now
act as parent domain for the per device domains.

The hierarchy depth is the same as before, but the PCI/MSI domains are then
device specific and not longer global.

Provide IRQ_DOMAIN_FLAG_MSI_PARENT, which allows to identify these parent
domains, along with helpers to query it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irqdomain.h |   14 ++++++++++++++
 1 file changed, 14 insertions(+)
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -189,6 +189,9 @@ enum {
 	/* Irq domain doesn't translate anything */
 	IRQ_DOMAIN_FLAG_NO_MAP		= (1 << 6),
 
+	/* Irq domain is a MSI parent domain */
+	IRQ_DOMAIN_FLAG_MSI_PARENT	= (1 << 8),
+
 	/*
 	 * Flags starting from IRQ_DOMAIN_FLAG_NONCORE are reserved
 	 * for implementation specific purposes and ignored by the
@@ -551,6 +554,11 @@ static inline bool irq_domain_is_msi_rem
 
 extern bool irq_domain_hierarchical_is_msi_remap(struct irq_domain *domain);
 
+static inline bool irq_domain_is_msi_parent(struct irq_domain *domain)
+{
+	return domain->flags & IRQ_DOMAIN_FLAG_MSI_PARENT;
+}
+
 #else	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
 static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
 			unsigned int nr_irqs, int node, void *arg)
@@ -596,6 +604,12 @@ irq_domain_hierarchical_is_msi_remap(str
 {
 	return false;
 }
+
+static inline bool irq_domain_is_msi_parent(struct irq_domain *domain)
+{
+	return false;
+}
+
 #endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
 
 #else /* CONFIG_IRQ_DOMAIN */

