Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B42666573
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 22:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbjAKVSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 16:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjAKVRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 16:17:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA295193F4;
        Wed, 11 Jan 2023 13:17:39 -0800 (PST)
Date:   Wed, 11 Jan 2023 21:17:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673471857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AKh67uPHfbmI+HbMIOsQ9o2TE+DUxsmQOeyvozD8TjQ=;
        b=fek64BB+XyC94nI8sqlzVZAoH4KOpfiEfAZL+Ba5FfdghfKe95WrXSKEjWihRo7dpniTI1
        8sOhPn0zgEYtvga5gh8lt48/po4ODqpZodaZKrQqCRMnpqspwRBKUihKm1ZdHzWS3/2f6X
        3PkKEwM/QS8ghBvzv/aO4sZ3UwT41m3vYKArB0L1YoShICwmO2oOVhtyZCEE5gkR+UUjkV
        InkzNFfVXT13TjD2qhYws8XBiRpJQl66H7aui23OMyjuX6n1DcX5a/jepMycMSMZN1faau
        3pLzPFn9HesvKDVahlq+UABHur3aC6/5R98aebHXWbuNNDVmoQGQ3oY7/J6Zpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673471857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AKh67uPHfbmI+HbMIOsQ9o2TE+DUxsmQOeyvozD8TjQ=;
        b=2pnT0UudtDVNig8nNBWcTg/QpR89Asn/pEHSGEQJC+49mq5WMoE40x3t/SG3xsGZ/FdWVP
        yTHtj8IaV/zaazAQ==
From:   "tip-bot2 for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip: Use irq_domain_alloc_irqs()
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221213140844.15470-2-johan+linaro@kernel.org>
References: <20221213140844.15470-2-johan+linaro@kernel.org>
MIME-Version: 1.0
Message-ID: <167347185679.4906.16205383769173180943.tip-bot2@tip-bot2>
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

Commit-ID:     0e2213fe0ab4c04da0e2354e84ec3b90e59939a4
Gitweb:        https://git.kernel.org/tip/0e2213fe0ab4c04da0e2354e84ec3b90e59939a4
Author:        Johan Hovold <johan+linaro@kernel.org>
AuthorDate:    Tue, 13 Dec 2022 15:08:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 11 Jan 2023 19:51:39 +01:00

irqchip: Use irq_domain_alloc_irqs()

Use the irq_domain_alloc_irqs() wrapper instead of the full
__irq_domain_alloc_irqs() interface, which was only intended for some
legacy (x86) use cases.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20221213140844.15470-2-johan+linaro@kernel.org

---
 drivers/irqchip/irq-apple-aic.c     |  4 +---
 drivers/irqchip/irq-armada-370-xp.c |  3 +--
 drivers/irqchip/irq-bcm2836.c       |  5 +----
 drivers/irqchip/irq-gic-v3.c        |  4 +---
 drivers/irqchip/irq-gic-v4.c        |  9 +++------
 drivers/irqchip/irq-gic.c           |  4 +---
 6 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index ae3437f..cf513b6 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -924,9 +924,7 @@ static int __init aic_init_smp(struct aic_irq_chip *irqc, struct device_node *no
 	ipi_domain->flags |= IRQ_DOMAIN_FLAG_IPI_SINGLE;
 	irq_domain_update_bus_token(ipi_domain, DOMAIN_BUS_IPI);
 
-	base_ipi = __irq_domain_alloc_irqs(ipi_domain, -1, AIC_NR_SWIPI,
-					   NUMA_NO_NODE, NULL, false, NULL);
-
+	base_ipi = irq_domain_alloc_irqs(ipi_domain, AIC_NR_SWIPI, NUMA_NO_NODE, NULL);
 	if (WARN_ON(!base_ipi)) {
 		irq_domain_remove(ipi_domain);
 		return -ENODEV;
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index ee18eb3..a555284 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -454,8 +454,7 @@ static __init void armada_xp_ipi_init(struct device_node *node)
 		return;
 
 	irq_domain_update_bus_token(ipi_domain, DOMAIN_BUS_IPI);
-	base_ipi = __irq_domain_alloc_irqs(ipi_domain, -1, IPI_DOORBELL_END,
-					   NUMA_NO_NODE, NULL, false, NULL);
+	base_ipi = irq_domain_alloc_irqs(ipi_domain, IPI_DOORBELL_END, NUMA_NO_NODE, NULL);
 	if (WARN_ON(!base_ipi))
 		return;
 
diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index 51491c3..e5f1059 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -268,10 +268,7 @@ static void __init bcm2836_arm_irqchip_smp_init(void)
 	ipi_domain->flags |= IRQ_DOMAIN_FLAG_IPI_SINGLE;
 	irq_domain_update_bus_token(ipi_domain, DOMAIN_BUS_IPI);
 
-	base_ipi = __irq_domain_alloc_irqs(ipi_domain, -1, BITS_PER_MBOX,
-					   NUMA_NO_NODE, NULL,
-					   false, NULL);
-
+	base_ipi = irq_domain_alloc_irqs(ipi_domain, BITS_PER_MBOX, NUMA_NO_NODE, NULL);
 	if (WARN_ON(!base_ipi))
 		return;
 
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 997104d..bb57ab8 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1310,9 +1310,7 @@ static void __init gic_smp_init(void)
 				  gic_starting_cpu, NULL);
 
 	/* Register all 8 non-secure SGIs */
-	base_sgi = __irq_domain_alloc_irqs(gic_data.domain, -1, 8,
-					   NUMA_NO_NODE, &sgi_fwspec,
-					   false, NULL);
+	base_sgi = irq_domain_alloc_irqs(gic_data.domain, 8, NUMA_NO_NODE, &sgi_fwspec);
 	if (WARN_ON(base_sgi <= 0))
 		return;
 
diff --git a/drivers/irqchip/irq-gic-v4.c b/drivers/irqchip/irq-gic-v4.c
index a6277de..94d56a0 100644
--- a/drivers/irqchip/irq-gic-v4.c
+++ b/drivers/irqchip/irq-gic-v4.c
@@ -139,9 +139,7 @@ static int its_alloc_vcpu_sgis(struct its_vpe *vpe, int idx)
 	if (!vpe->sgi_domain)
 		goto err;
 
-	sgi_base = __irq_domain_alloc_irqs(vpe->sgi_domain, -1, 16,
-					       NUMA_NO_NODE, vpe,
-					       false, NULL);
+	sgi_base = irq_domain_alloc_irqs(vpe->sgi_domain, 16, NUMA_NO_NODE, vpe);
 	if (sgi_base <= 0)
 		goto err;
 
@@ -176,9 +174,8 @@ int its_alloc_vcpu_irqs(struct its_vm *vm)
 		vm->vpes[i]->idai = true;
 	}
 
-	vpe_base_irq = __irq_domain_alloc_irqs(vm->domain, -1, vm->nr_vpes,
-					       NUMA_NO_NODE, vm,
-					       false, NULL);
+	vpe_base_irq = irq_domain_alloc_irqs(vm->domain, vm->nr_vpes,
+					     NUMA_NO_NODE, vm);
 	if (vpe_base_irq <= 0)
 		goto err;
 
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 210bc2f..4fa4d8a 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -868,9 +868,7 @@ static __init void gic_smp_init(void)
 				  "irqchip/arm/gic:starting",
 				  gic_starting_cpu, NULL);
 
-	base_sgi = __irq_domain_alloc_irqs(gic_data[0].domain, -1, 8,
-					   NUMA_NO_NODE, &sgi_fwspec,
-					   false, NULL);
+	base_sgi = irq_domain_alloc_irqs(gic_data[0].domain, 8, NUMA_NO_NODE, &sgi_fwspec);
 	if (WARN_ON(base_sgi <= 0))
 		return;
 
