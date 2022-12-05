Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCA2643060
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbiLES3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbiLESZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C320A20BD2;
        Mon,  5 Dec 2022 10:25:23 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264722;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NDH8l4Wxx5e8MUWqcN44DvP8vAxTaA+Dc4mm5fhhLEY=;
        b=m/25FXv+6inR7+RYx4EPDyyMKFOd4e1RYjI5JPu6IpBz74I4sDtP3uF6A+FtDQ/VD0dwAV
        BlVNt0ri44FZWdt+p2jOUT1aaAHL1nRAlV/8crXlG5oNyCzv/29ANyJkV4EWLXIisjGfou
        F2ZIc3XiU+AWpTorc8YUDIMerm6qqB6oE/b4WmmrJt8nvXGCWWRIwFMk7qbm7AWcPwv9y6
        Dd/voTMhXteN5JbBpZseyrPASDx1mlPuiXDnYr8M2ta23dE9HEIQHLBjsdB4QNHy3M1sSk
        eb43XCZO+l/vgU/GmBPwN4d6sfOOl1sDmSzF4yWcj99AeHVgFj13SUYrW8wlpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264722;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NDH8l4Wxx5e8MUWqcN44DvP8vAxTaA+Dc4mm5fhhLEY=;
        b=rLvYzlI+lyeha8gHiCAYAYdfCokY4r2uVcDqil2KaAqCCjYg1kplZ7xKeD3WllBaHn3Pcv
        4qESTE+QkNu+gDDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Move IRQ_DOMAIN_MSI_NOMASK_QUIRK to MSI flags
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124230313.454246167@linutronix.de>
References: <20221124230313.454246167@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026472218.4906.17353441487523538459.tip-bot2@tip-bot2>
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

Commit-ID:     3dad5f9ad99b77dfd234d31e2ea3d77f620efc09
Gitweb:        https://git.kernel.org/tip/3dad5f9ad99b77dfd234d31e2ea3d77f620efc09
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:24:08 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:20:58 +01:00

genirq/msi: Move IRQ_DOMAIN_MSI_NOMASK_QUIRK to MSI flags

It's truly a MSI only flag and for the upcoming per device MSI domains this
must be in the MSI flags so it can be set during domain setup without
exposing this quirk outside of x86.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124230313.454246167@linutronix.de

---
 arch/x86/kernel/apic/msi.c |  5 ++---
 include/linux/irqdomain.h  |  9 +--------
 include/linux/msi.h        |  6 ++++++
 kernel/irq/msi.c           |  2 +-
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 248a6a5..71c8751 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -176,7 +176,8 @@ static struct msi_domain_ops pci_msi_domain_ops = {
 
 static struct msi_domain_info pci_msi_domain_info = {
 	.flags		= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-			  MSI_FLAG_PCI_MSIX,
+			  MSI_FLAG_PCI_MSIX | MSI_FLAG_NOMASK_QUIRK,
+
 	.ops		= &pci_msi_domain_ops,
 	.chip		= &pci_msi_controller,
 	.handler	= handle_edge_irq,
@@ -200,8 +201,6 @@ struct irq_domain * __init native_create_pci_msi_domain(void)
 	if (!d) {
 		irq_domain_free_fwnode(fn);
 		pr_warn("Failed to initialize PCI-MSI irqdomain.\n");
-	} else {
-		d->flags |= IRQ_DOMAIN_MSI_NOMASK_QUIRK;
 	}
 	return d;
 }
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index a4af7f8..c42c369 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -186,15 +186,8 @@ enum {
 	/* Irq domain implements MSI remapping */
 	IRQ_DOMAIN_FLAG_MSI_REMAP	= (1 << 5),
 
-	/*
-	 * Quirk to handle MSI implementations which do not provide
-	 * masking. Currently known to affect x86, but partially
-	 * handled in core code.
-	 */
-	IRQ_DOMAIN_MSI_NOMASK_QUIRK	= (1 << 6),
-
 	/* Irq domain doesn't translate anything */
-	IRQ_DOMAIN_FLAG_NO_MAP		= (1 << 7),
+	IRQ_DOMAIN_FLAG_NO_MAP		= (1 << 6),
 
 	/*
 	 * Flags starting from IRQ_DOMAIN_FLAG_NONCORE are reserved
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 1ce9d5e..2d87e00 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -399,6 +399,12 @@ enum {
 	MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS	= (1 << 9),
 	/* Free MSI descriptors */
 	MSI_FLAG_FREE_MSI_DESCS		= (1 << 10),
+	/*
+	 * Quirk to handle MSI implementations which do not provide
+	 * masking. Currently known to affect x86, but has to be partially
+	 * handled in the core MSI code.
+	 */
+	MSI_FLAG_NOMASK_QUIRK		= (1 << 11),
 };
 
 int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 4b99f37..c37c0be 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -875,7 +875,7 @@ static int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev
 		 * MSI affinity setting requires a special quirk (X86) when
 		 * reservation mode is active.
 		 */
-		if (domain->flags & IRQ_DOMAIN_MSI_NOMASK_QUIRK)
+		if (info->flags & MSI_FLAG_NOMASK_QUIRK)
 			vflags |= VIRQ_NOMASK_QUIRK;
 	}
 
