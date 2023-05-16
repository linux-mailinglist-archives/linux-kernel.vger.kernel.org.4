Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56762704A65
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjEPKWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjEPKWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:22:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729FD359D;
        Tue, 16 May 2023 03:22:39 -0700 (PDT)
Date:   Tue, 16 May 2023 10:22:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684232557;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lvdq1fafd/82IfgwmiEjD7uNn1hH+uNf006eg2zF9BQ=;
        b=UABqdT1cSGtwHvhxWQUgLOZKYphRGOFVWqvBh4w/a8+Dh1eRKHhRpDv1jluy3XgUio+KdL
        ZD1kM+H/TA/JAfEA/wliqwlEF7LWYWJ2KHoVrm/fUb0Tz+CjL7wXIcs7XZHBCJ5JEeyiWK
        uzaUyD25klaDlVE6yvnzVwxZpTAmmUoDDvwxV5CmNgDvfVde/LHITBm1QKMsPVK5d9Y58C
        Y/rQPMVJhepxlXkhnE3FHP9CQOTJrTF4d7q1Gf6QfR5UvukIWXWMqzICOX0gcPrAAO8RCS
        fVeCvDNJcAM2tUge8RuIb706s9/MhFXUaL5/iuEDoXEVxq1L1nNnPEs+CcnAUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684232557;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lvdq1fafd/82IfgwmiEjD7uNn1hH+uNf006eg2zF9BQ=;
        b=9+BeIwMyk46WxzhHEmE5JYwgnm/fk2QnKzdEWjXgIdW8X1zdRQoRflewBxrnY2aIAwdFVk
        ly0dwaWRngwoUhAA==
From:   "irqchip-bot for Jiaxun Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/mips-gic: Use raw spinlock for gic_lock
Cc:     stable@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230424103156.66753-3-jiaxun.yang@flygoat.com>
References: <20230424103156.66753-3-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Message-ID: <168423255720.404.7840145628338294221.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     3d6a0e4197c04599d75d85a608c8bb16a630a38c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/3d6a0e4197c04599d75d85a608c8bb16a630a38c
Author:        Jiaxun Yang <jiaxun.yang@flygoat.com>
AuthorDate:    Mon, 24 Apr 2023 11:31:56 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 16 May 2023 10:59:28 +01:00

irqchip/mips-gic: Use raw spinlock for gic_lock

Since we may hold gic_lock in hardirq context, use raw spinlock
makes more sense given that it is for low-level interrupt handling
routine and the critical section is small.

Fixes BUG:

[    0.426106] =============================
[    0.426257] [ BUG: Invalid wait context ]
[    0.426422] 6.3.0-rc7-next-20230421-dirty #54 Not tainted
[    0.426638] -----------------------------
[    0.426766] swapper/0/1 is trying to lock:
[    0.426954] ffffffff8104e7b8 (gic_lock){....}-{3:3}, at: gic_set_type+0x30/08

Fixes: 95150ae8b330 ("irqchip: mips-gic: Implement irq_set_type callback")
Cc: stable@vger.kernel.org
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230424103156.66753-3-jiaxun.yang@flygoat.com
---
 drivers/irqchip/irq-mips-gic.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index b568d55..6d5ecc1 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -50,7 +50,7 @@ void __iomem *mips_gic_base;
 
 static DEFINE_PER_CPU_READ_MOSTLY(unsigned long[GIC_MAX_LONGS], pcpu_masks);
 
-static DEFINE_SPINLOCK(gic_lock);
+static DEFINE_RAW_SPINLOCK(gic_lock);
 static struct irq_domain *gic_irq_domain;
 static int gic_shared_intrs;
 static unsigned int gic_cpu_pin;
@@ -210,7 +210,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 
 	irq = GIC_HWIRQ_TO_SHARED(d->hwirq);
 
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 	switch (type & IRQ_TYPE_SENSE_MASK) {
 	case IRQ_TYPE_EDGE_FALLING:
 		pol = GIC_POL_FALLING_EDGE;
@@ -250,7 +250,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	else
 		irq_set_chip_handler_name_locked(d, &gic_level_irq_controller,
 						 handle_level_irq, NULL);
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
 
 	return 0;
 }
@@ -268,7 +268,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 		return -EINVAL;
 
 	/* Assumption : cpumask refers to a single CPU */
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 
 	/* Re-route this IRQ */
 	write_gic_map_vp(irq, BIT(mips_cm_vp_id(cpu)));
@@ -279,7 +279,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 		set_bit(irq, per_cpu_ptr(pcpu_masks, cpu));
 
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
 
 	return IRQ_SET_MASK_OK;
 }
@@ -357,12 +357,12 @@ static void gic_mask_local_irq_all_vpes(struct irq_data *d)
 	cd = irq_data_get_irq_chip_data(d);
 	cd->mask = false;
 
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 	for_each_online_cpu(cpu) {
 		write_gic_vl_other(mips_cm_vp_id(cpu));
 		write_gic_vo_rmask(BIT(intr));
 	}
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
 }
 
 static void gic_unmask_local_irq_all_vpes(struct irq_data *d)
@@ -375,12 +375,12 @@ static void gic_unmask_local_irq_all_vpes(struct irq_data *d)
 	cd = irq_data_get_irq_chip_data(d);
 	cd->mask = true;
 
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 	for_each_online_cpu(cpu) {
 		write_gic_vl_other(mips_cm_vp_id(cpu));
 		write_gic_vo_smask(BIT(intr));
 	}
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
 }
 
 static void gic_all_vpes_irq_cpu_online(void)
@@ -393,7 +393,7 @@ static void gic_all_vpes_irq_cpu_online(void)
 	unsigned long flags;
 	int i;
 
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 
 	for (i = 0; i < ARRAY_SIZE(local_intrs); i++) {
 		unsigned int intr = local_intrs[i];
@@ -407,7 +407,7 @@ static void gic_all_vpes_irq_cpu_online(void)
 			write_gic_vl_smask(BIT(intr));
 	}
 
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
 }
 
 static struct irq_chip gic_all_vpes_local_irq_controller = {
@@ -437,11 +437,11 @@ static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
 
 	data = irq_get_irq_data(virq);
 
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 	write_gic_map_pin(intr, GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
 	write_gic_map_vp(intr, BIT(mips_cm_vp_id(cpu)));
 	irq_data_update_effective_affinity(data, cpumask_of(cpu));
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
 
 	return 0;
 }
@@ -533,12 +533,12 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	if (!gic_local_irq_is_routable(intr))
 		return -EPERM;
 
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 	for_each_online_cpu(cpu) {
 		write_gic_vl_other(mips_cm_vp_id(cpu));
 		write_gic_vo_map(mips_gic_vx_map_reg(intr), map);
 	}
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
 
 	return 0;
 }
