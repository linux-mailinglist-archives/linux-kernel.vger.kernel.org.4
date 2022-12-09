Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C0F648350
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiLIOFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiLIOFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:05:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB367722C;
        Fri,  9 Dec 2022 06:05:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C28CE62270;
        Fri,  9 Dec 2022 14:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B410BC43322;
        Fri,  9 Dec 2022 14:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670594713;
        bh=TMyLqWF3g4BsvWN/vPIOrQXHZItfyvQpoJNh+QahnCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hXF3sBDMaTy2y9hAwRc40/AkC5aUSb78OM0u4aKmhoYp5Qy0aGxoKWhRUqzRio/3y
         ON8IwOiMehMqprgc0pLH3BmaZV9mhTD3K0Mxczv+7V2o3pzBzhUFM+73LWnhUKkUbS
         QIr/hVdZ5/v9+LMRq2X4h1sT36/vzh0+NBsJaqVcGCTleI4s6F+mhVj0es6GaZXxwF
         31W0aik7quS84VpvU1l78bdo26WSmlP+qu78XWc5UtOa6oPPVl9o+XMgzpHj2vf2eV
         5gDHYleGO0V4x4b7PPDAh2P22j8ty1wPtAPAt99AB3daJvII3vYynBE83MYD08ZOOZ
         BGkwWHqbtZcpg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1p3e0I-0000Rm-Ud; Fri, 09 Dec 2022 15:05:30 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH v3 09/19] irqdomain: Fix mapping-creation race
Date:   Fri,  9 Dec 2022 15:01:40 +0100
Message-Id: <20221209140150.1453-10-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221209140150.1453-1-johan+linaro@kernel.org>
References: <20221209140150.1453-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parallel probing (e.g. due to asynchronous probing) of devices that share
interrupts can currently result in two mappings for the same hardware
interrupt to be created.

Make sure to hold the irq_domain_mutex when creating mappings so that
looking for an existing mapping before creating a new one is done
atomically.

Fixes: 765230b5f084 ("driver-core: add asynchronous probing support for drivers")
Fixes: b62b2cf5759b ("irqdomain: Fix handling of type settings for existing mappings")
Cc: Dmitry Torokhov <dtor@chromium.org>
Cc: Jon Hunter <jonathanh@nvidia.com>
Link: https://lore.kernel.org/r/YuJXMHoT4ijUxnRb@hovoldconsulting.com
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 kernel/irq/irqdomain.c | 47 ++++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index d6139b0218d4..7232947eee3e 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -25,6 +25,9 @@ static DEFINE_MUTEX(irq_domain_mutex);
 
 static struct irq_domain *irq_default_domain;
 
+static int ___irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
+				    unsigned int nr_irqs, int node, void *arg,
+				    bool realloc, const struct irq_affinity_desc *affinity);
 static void irq_domain_check_hierarchy(struct irq_domain *domain);
 
 struct irqchip_fwid {
@@ -692,7 +695,7 @@ static unsigned int __irq_create_mapping_affinity(struct irq_domain *domain,
 		return 0;
 	}
 
-	if (irq_domain_associate(domain, virq, hwirq)) {
+	if (__irq_domain_associate(domain, virq, hwirq)) {
 		irq_free_desc(virq);
 		return 0;
 	}
@@ -728,14 +731,20 @@ unsigned int irq_create_mapping_affinity(struct irq_domain *domain,
 		return 0;
 	}
 
+	mutex_lock(&irq_domain_mutex);
+
 	/* Check if mapping already exists */
 	virq = irq_find_mapping(domain, hwirq);
 	if (virq) {
 		pr_debug("existing mapping on virq %d\n", virq);
-		return virq;
+		goto out;
 	}
 
-	return __irq_create_mapping_affinity(domain, hwirq, affinity);
+	virq = __irq_create_mapping_affinity(domain, hwirq, affinity);
+out:
+	mutex_unlock(&irq_domain_mutex);
+
+	return virq;
 }
 EXPORT_SYMBOL_GPL(irq_create_mapping_affinity);
 
@@ -802,6 +811,8 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 	if (WARN_ON(type & ~IRQ_TYPE_SENSE_MASK))
 		type &= IRQ_TYPE_SENSE_MASK;
 
+	mutex_lock(&irq_domain_mutex);
+
 	/*
 	 * If we've already configured this interrupt,
 	 * don't do it again, or hell will break loose.
@@ -814,7 +825,7 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 		 * interrupt number.
 		 */
 		if (type == IRQ_TYPE_NONE || type == irq_get_trigger_type(virq))
-			return virq;
+			goto out;
 
 		/*
 		 * If the trigger type has not been set yet, then set
@@ -823,36 +834,43 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 		if (irq_get_trigger_type(virq) == IRQ_TYPE_NONE) {
 			irq_data = irq_get_irq_data(virq);
 			if (!irq_data)
-				return 0;
+				goto err;
 
 			irqd_set_trigger_type(irq_data, type);
-			return virq;
+			goto out;
 		}
 
 		pr_warn("type mismatch, failed to map hwirq-%lu for %s!\n",
 			hwirq, of_node_full_name(to_of_node(fwspec->fwnode)));
-		return 0;
+		goto err;
 	}
 
 	if (irq_domain_is_hierarchy(domain)) {
-		virq = irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, fwspec);
+		virq = ___irq_domain_alloc_irqs(domain, -1, 1, NUMA_NO_NODE,
+						fwspec, false, NULL);
 		if (virq <= 0)
-			return 0;
+			goto err;
 	} else {
 		/* Create mapping */
 		virq = __irq_create_mapping_affinity(domain, hwirq, NULL);
 		if (!virq)
-			return virq;
+			goto err;
 	}
 
 	irq_data = irq_get_irq_data(virq);
 	if (WARN_ON(!irq_data))
-		return 0;
+		goto err;
 
 	/* Store trigger type */
 	irqd_set_trigger_type(irq_data, type);
+out:
+	mutex_unlock(&irq_domain_mutex);
 
 	return virq;
+err:
+	mutex_unlock(&irq_domain_mutex);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(irq_create_fwspec_mapping);
 
@@ -1877,6 +1895,13 @@ void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
 	irq_set_handler_data(virq, handler_data);
 }
 
+static int ___irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
+				    unsigned int nr_irqs, int node, void *arg,
+				    bool realloc, const struct irq_affinity_desc *affinity)
+{
+	return -EINVAL;
+}
+
 static void irq_domain_check_hierarchy(struct irq_domain *domain)
 {
 }
-- 
2.37.4

