Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3DE6BB3CD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbjCONCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjCONCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:02:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1846077E20
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:02:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF888B81DF9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 13:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838A8C433D2;
        Wed, 15 Mar 2023 13:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678885346;
        bh=FCByffgKXOFceb1+C/GUkafmefAIy9ksJu08WJ+iYPk=;
        h=From:To:Cc:Subject:Date:From;
        b=FfxAL1el6r355cvoc2EQsk9sLe5YiaSkQKhlUz9ej3kzt7eBwxZpG4xV2YMaMiGgS
         u6B0UUldJz7Fk80nONG5FIrcKYXS9I4OMZKMyPfW2W0mM1UzRJUDNjUcb5lPdZ4fvn
         1x70sLXVOenoYbRBN0l8BWwwqn8pUuUS8K6LOpTgUF+W3XYhW8sAJahLGK3mpZ4JQf
         e0axmAW0jD0AIIt+5EH0uV6j0C7CAzheZ5S0FWhuX/yBa0O6nR67i42/y/vX37P7cG
         NLcuZNXz66TF6+f5/2X2H9+UyVbOWoBGJxpX05WeTCwh8TsxfqHuFKSGYNSkfeO05H
         lWQyJn0BnHq0Q==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1pcQls-000Gp3-31;
        Wed, 15 Mar 2023 13:02:24 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] irqchip/gic: Drop support for board files
Date:   Wed, 15 Mar 2023 13:02:18 +0000
Message-Id: <20230315130218.3212033-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, arnd@arndb.de, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the last non-OF, non-ACPI user of the GIC being removed in
e73307b9ebc4 ("ARM: cns3xxx: remove entire platform"), we can finally
drop the entry point and do some minor cleanup.

We also make the driver depend on CONFIG_OF, which is required
even when CONFIG_ACPI is selected.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/Kconfig         |  1 +
 drivers/irqchip/irq-gic.c       | 60 ++-------------------------------
 include/linux/irqchip/arm-gic.h |  6 ----
 3 files changed, 4 insertions(+), 63 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 7dc990eb2c9b..b744fd905c92 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -7,6 +7,7 @@ config IRQCHIP
 
 config ARM_GIC
 	bool
+	depends on OF
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 95e3d2a71db6..412196a7dad5 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1081,10 +1081,6 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 	return 0;
 }
 
-static void gic_irq_domain_unmap(struct irq_domain *d, unsigned int irq)
-{
-}
-
 static int gic_irq_domain_translate(struct irq_domain *d,
 				    struct irq_fwspec *fwspec,
 				    unsigned long *hwirq,
@@ -1167,11 +1163,6 @@ static const struct irq_domain_ops gic_irq_domain_hierarchy_ops = {
 	.free = irq_domain_free_irqs_top,
 };
 
-static const struct irq_domain_ops gic_irq_domain_ops = {
-	.map = gic_irq_domain_map,
-	.unmap = gic_irq_domain_unmap,
-};
-
 static int gic_init_bases(struct gic_chip_data *gic,
 			  struct fwnode_handle *handle)
 {
@@ -1219,30 +1210,9 @@ static int gic_init_bases(struct gic_chip_data *gic,
 		gic_irqs = 1020;
 	gic->gic_irqs = gic_irqs;
 
-	if (handle) {		/* DT/ACPI */
-		gic->domain = irq_domain_create_linear(handle, gic_irqs,
-						       &gic_irq_domain_hierarchy_ops,
-						       gic);
-	} else {		/* Legacy support */
-		/*
-		 * For primary GICs, skip over SGIs.
-		 * No secondary GIC support whatsoever.
-		 */
-		int irq_base;
-
-		gic_irqs -= 16; /* calculate # of irqs to allocate */
-
-		irq_base = irq_alloc_descs(16, 16, gic_irqs,
-					   numa_node_id());
-		if (irq_base < 0) {
-			WARN(1, "Cannot allocate irq_descs @ IRQ16, assuming pre-allocated\n");
-			irq_base = 16;
-		}
-
-		gic->domain = irq_domain_add_legacy(NULL, gic_irqs, irq_base,
-						    16, &gic_irq_domain_ops, gic);
-	}
-
+	gic->domain = irq_domain_create_linear(handle, gic_irqs,
+					       &gic_irq_domain_hierarchy_ops,
+					       gic);
 	if (WARN_ON(!gic->domain)) {
 		ret = -ENODEV;
 		goto error;
@@ -1297,23 +1267,6 @@ static int __init __gic_init_bases(struct gic_chip_data *gic,
 	return ret;
 }
 
-void __init gic_init(void __iomem *dist_base, void __iomem *cpu_base)
-{
-	struct gic_chip_data *gic;
-
-	/*
-	 * Non-DT/ACPI systems won't run a hypervisor, so let's not
-	 * bother with these...
-	 */
-	static_branch_disable(&supports_deactivate_key);
-
-	gic = &gic_data[0];
-	gic->raw_dist_base = dist_base;
-	gic->raw_cpu_base = cpu_base;
-
-	__gic_init_bases(gic, NULL);
-}
-
 static void gic_teardown(struct gic_chip_data *gic)
 {
 	if (WARN_ON(!gic))
@@ -1325,7 +1278,6 @@ static void gic_teardown(struct gic_chip_data *gic)
 		iounmap(gic->raw_cpu_base);
 }
 
-#ifdef CONFIG_OF
 static int gic_cnt __initdata;
 static bool gicv2_force_probe;
 
@@ -1570,12 +1522,6 @@ IRQCHIP_DECLARE(cortex_a7_gic, "arm,cortex-a7-gic", gic_of_init);
 IRQCHIP_DECLARE(msm_8660_qgic, "qcom,msm-8660-qgic", gic_of_init);
 IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", gic_of_init);
 IRQCHIP_DECLARE(pl390, "arm,pl390", gic_of_init);
-#else
-int gic_of_init_child(struct device *dev, struct gic_chip_data **gic, int irq)
-{
-	return -ENOTSUPP;
-}
-#endif
 
 #ifdef CONFIG_ACPI
 static struct
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 5686711b0f40..2223f95079ce 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -151,12 +151,6 @@ int gic_of_init(struct device_node *node, struct device_node *parent);
  */
 int gic_of_init_child(struct device *dev, struct gic_chip_data **gic, int irq);
 
-/*
- * Legacy platforms not converted to DT yet must use this to init
- * their GIC
- */
-void gic_init(void __iomem *dist , void __iomem *cpu);
-
 void gic_send_sgi(unsigned int cpu_id, unsigned int irq);
 int gic_get_cpu_id(unsigned int cpu);
 void gic_migrate_target(unsigned int new_cpu_id);
-- 
2.34.1

