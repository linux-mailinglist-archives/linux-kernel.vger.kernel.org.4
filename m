Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2066364305C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbiLES3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbiLESZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9142125F;
        Mon,  5 Dec 2022 10:25:23 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264721;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KXVakGKH2LOihN+bIN4jS+1Evn0MKrSAk5MxXyMx8N4=;
        b=jodtXJnROUurpjr2mp5+VFrk+U/8BAOzAjMVKNK58RtS94ejqmWhBDLlhZp2ZiH/ZomHNw
        sg0VgtLyIlIzj+Q9CW9GHorblWvVkJROeoV2QxxSfCzSmNbeJZ1GnhO53sONP3y3GguIx6
        yumQSlwHrbuQTUqTFUiZgbMqRHgSavMpGWhja6toqbpMnDhS3CBidxnx6C56DtZeGv32dB
        BmA7LTrwy4WVCYhRq248OTrtgqIF7B3UJtwI2cpWJjVPfxjA+AmqRC8Rvq1A/MBeu0T1RE
        T88TL9TJPJCpLAbmD52n3GG8z2yMowYHWxPKlMRxg91xQQJNoNUNWqIOi0c2jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264721;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KXVakGKH2LOihN+bIN4jS+1Evn0MKrSAk5MxXyMx8N4=;
        b=O4QXpuyK4JfboFmr/UPjGAURzT+gep5/Zpom/yIF6dDWHWewpIdkqZx2J7S9j53FkXzR5R
        zjMsY1FRnD7qNiDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/irqdomain: Provide IRQ_DOMAIN_FLAG_MSI_PARENT
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124230313.690038274@linutronix.de>
References: <20221124230313.690038274@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026472142.4906.9843449600680865188.tip-bot2@tip-bot2>
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

Commit-ID:     b749e6d31c88cff2202b968aaba246e5d7379038
Gitweb:        https://git.kernel.org/tip/b749e6d31c88cff2202b968aaba246e5d7379038
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:24:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:20:58 +01:00

genirq/irqdomain: Provide IRQ_DOMAIN_FLAG_MSI_PARENT

The new PCI/IMS (Interrupt Message Store) functionality is allowing
hardware vendors to provide implementation specific storage for the MSI
messages. This can be device memory and also host/guest memory, e.g. in
queue memory which is shared with the hardware.

This requires device specific MSI interrupt domains, which cannot be
achieved by expanding the existing PCI/MSI interrupt domain concept which is
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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124230313.690038274@linutronix.de

---
 include/linux/irqdomain.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index aa76da8..f837db9 100644
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
@@ -551,6 +554,11 @@ static inline bool irq_domain_is_msi_remap(struct irq_domain *domain)
 
 extern bool irq_domain_hierarchical_is_msi_remap(struct irq_domain *domain);
 
+static inline bool irq_domain_is_msi_parent(struct irq_domain *domain)
+{
+	return domain->flags & IRQ_DOMAIN_FLAG_MSI_PARENT;
+}
+
 #else	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
 static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
 			unsigned int nr_irqs, int node, void *arg)
@@ -596,6 +604,12 @@ irq_domain_hierarchical_is_msi_remap(struct irq_domain *domain)
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
