Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14597694355
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjBMKoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjBMKnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:43:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FCF16AC7;
        Mon, 13 Feb 2023 02:43:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 292B560F9F;
        Mon, 13 Feb 2023 10:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E151C4323B;
        Mon, 13 Feb 2023 10:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676284997;
        bh=SMNKWR1xw4kKX0WCWGnKegPn3mimaO2YyT2LNW1Y/fY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PWrpM7fHMUvIv+/WI7Dhe+li+yuJRJ4Yu6knDS3W6jCZn34dRpXg9IxLyC0U0SAUl
         r/HxAkqr/floqgb/l5kt2a4nvw5tcUQ588sjJj2SWJIQvdlQE3DmuHXCFtR9fyb6gr
         9Eb9ti9trEwFk3D46vOImc4wGTI4tswahs+2Y/KSIe+NHhapLbazj85UK/R6CWtUcW
         E1MErfpQZcTlVAdZ6wF5Oyn2HeWdmPuKVycAvPHmPPv1pre+c8WkfYVAeZ5GpxE+2f
         xQcIykRNA1BuSeWUyhgheQSG6GST/4cnGZoUhjux4j4zIlDRnn7hKDx2HYb0JDGIZX
         yu41UlUvdK4CQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pRWJc-0004XE-Mk; Mon, 13 Feb 2023 11:44:08 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: [PATCH v6 20/20] irqdomain: Switch to per-domain locking
Date:   Mon, 13 Feb 2023 11:43:02 +0100
Message-Id: <20230213104302.17307-21-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213104302.17307-1-johan+linaro@kernel.org>
References: <20230213104302.17307-1-johan+linaro@kernel.org>
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

The IRQ domain structures are currently protected by the global
irq_domain_mutex. Switch to using more fine-grained per-domain locking,
which can speed up parallel probing by reducing lock contention.

On a recent arm64 laptop, the total time spent waiting for the locks
during boot drops from 160 to 40 ms on average, while the maximum
aggregate wait time drops from 550 to 90 ms over ten runs for example.

Note that the domain lock of the root domain (innermost domain) must be
used for hierarchical domains. For non-hierarchical domains (as for root
domains), the new root pointer is set to the domain itself so that
&domain->root->mutex always points to the right lock.

Also note that hierarchical domains should be constructed using
irq_domain_create_hierarchy() (or irq_domain_add_hierarchy()) to avoid
having racing allocations access a not fully initialised domain. As a
safeguard, the lockdep assertion in irq_domain_set_mapping() will catch
any offenders that also fail to set the root domain pointer.

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 include/linux/irqdomain.h |  4 +++
 kernel/irq/irqdomain.c    | 59 ++++++++++++++++++++++++++-------------
 2 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 16399de00b48..d320d15d4fba 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -125,6 +125,8 @@ struct irq_domain_chip_generic;
  *		core code.
  * @flags:	Per irq_domain flags
  * @mapcount:	The number of mapped interrupts
+ * @mutex:	Domain lock, hierarchical domains use root domain's lock
+ * @root:	Pointer to root domain, or containing structure if non-hierarchical
  *
  * Optional elements:
  * @fwnode:	Pointer to firmware node associated with the irq_domain. Pretty easy
@@ -152,6 +154,8 @@ struct irq_domain {
 	void				*host_data;
 	unsigned int			flags;
 	unsigned int			mapcount;
+	struct mutex			mutex;
+	struct irq_domain		*root;
 
 	/* Optional data */
 	struct fwnode_handle		*fwnode;
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 2213d972f083..aa5b7eeeceb8 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -215,6 +215,17 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 
 	domain->revmap_size = size;
 
+	/*
+	 * Hierarchical domains use the domain lock of the root domain
+	 * (innermost domain).
+	 *
+	 * For non-hierarchical domains (as for root domains), the root
+	 * pointer is set to the domain itself so that &domain->root->mutex
+	 * always points to the right lock.
+	 */
+	mutex_init(&domain->mutex);
+	domain->root = domain;
+
 	irq_domain_check_hierarchy(domain);
 
 	return domain;
@@ -524,7 +535,7 @@ static bool irq_domain_is_nomap(struct irq_domain *domain)
 static void irq_domain_clear_mapping(struct irq_domain *domain,
 				     irq_hw_number_t hwirq)
 {
-	lockdep_assert_held(&irq_domain_mutex);
+	lockdep_assert_held(&domain->root->mutex);
 
 	if (irq_domain_is_nomap(domain))
 		return;
@@ -539,7 +550,11 @@ static void irq_domain_set_mapping(struct irq_domain *domain,
 				   irq_hw_number_t hwirq,
 				   struct irq_data *irq_data)
 {
-	lockdep_assert_held(&irq_domain_mutex);
+	/*
+	 * This also makes sure that all domains point to the same root when
+	 * called from irq_domain_insert_irq() for each domain in a hierarchy.
+	 */
+	lockdep_assert_held(&domain->root->mutex);
 
 	if (irq_domain_is_nomap(domain))
 		return;
@@ -561,7 +576,7 @@ static void irq_domain_disassociate(struct irq_domain *domain, unsigned int irq)
 
 	hwirq = irq_data->hwirq;
 
-	mutex_lock(&irq_domain_mutex);
+	mutex_lock(&domain->root->mutex);
 
 	irq_set_status_flags(irq, IRQ_NOREQUEST);
 
@@ -583,7 +598,7 @@ static void irq_domain_disassociate(struct irq_domain *domain, unsigned int irq)
 	/* Clear reverse map for this hwirq */
 	irq_domain_clear_mapping(domain, hwirq);
 
-	mutex_unlock(&irq_domain_mutex);
+	mutex_unlock(&domain->root->mutex);
 }
 
 static int irq_domain_associate_locked(struct irq_domain *domain, unsigned int virq,
@@ -633,9 +648,9 @@ int irq_domain_associate(struct irq_domain *domain, unsigned int virq,
 {
 	int ret;
 
-	mutex_lock(&irq_domain_mutex);
+	mutex_lock(&domain->root->mutex);
 	ret = irq_domain_associate_locked(domain, virq, hwirq);
-	mutex_unlock(&irq_domain_mutex);
+	mutex_unlock(&domain->root->mutex);
 
 	return ret;
 }
@@ -752,7 +767,7 @@ unsigned int irq_create_mapping_affinity(struct irq_domain *domain,
 		return 0;
 	}
 
-	mutex_lock(&irq_domain_mutex);
+	mutex_lock(&domain->root->mutex);
 
 	/* Check if mapping already exists */
 	virq = irq_find_mapping(domain, hwirq);
@@ -763,7 +778,7 @@ unsigned int irq_create_mapping_affinity(struct irq_domain *domain,
 
 	virq = irq_create_mapping_affinity_locked(domain, hwirq, affinity);
 out:
-	mutex_unlock(&irq_domain_mutex);
+	mutex_unlock(&domain->root->mutex);
 
 	return virq;
 }
@@ -832,7 +847,7 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 	if (WARN_ON(type & ~IRQ_TYPE_SENSE_MASK))
 		type &= IRQ_TYPE_SENSE_MASK;
 
-	mutex_lock(&irq_domain_mutex);
+	mutex_lock(&domain->root->mutex);
 
 	/*
 	 * If we've already configured this interrupt,
@@ -892,7 +907,7 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 	/* Store trigger type */
 	irqd_set_trigger_type(irq_data, type);
 out:
-	mutex_unlock(&irq_domain_mutex);
+	mutex_unlock(&domain->root->mutex);
 
 	return virq;
 }
@@ -1157,6 +1172,7 @@ struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
 		domain = __irq_domain_create(fwnode, 0, ~0, 0, ops, host_data);
 
 	if (domain) {
+		domain->root = parent->root;
 		domain->parent = parent;
 		domain->flags |= flags;
 
@@ -1555,10 +1571,10 @@ int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
 			return -EINVAL;
 	}
 
-	mutex_lock(&irq_domain_mutex);
+	mutex_lock(&domain->root->mutex);
 	ret = irq_domain_alloc_irqs_locked(domain, irq_base, nr_irqs, node, arg,
 					   realloc, affinity);
-	mutex_unlock(&irq_domain_mutex);
+	mutex_unlock(&domain->root->mutex);
 
 	return ret;
 }
@@ -1569,7 +1585,7 @@ static void irq_domain_fix_revmap(struct irq_data *d)
 {
 	void __rcu **slot;
 
-	lockdep_assert_held(&irq_domain_mutex);
+	lockdep_assert_held(&d->domain->root->mutex);
 
 	if (irq_domain_is_nomap(d->domain))
 		return;
@@ -1635,7 +1651,7 @@ int irq_domain_push_irq(struct irq_domain *domain, int virq, void *arg)
 	if (!parent_irq_data)
 		return -ENOMEM;
 
-	mutex_lock(&irq_domain_mutex);
+	mutex_lock(&domain->root->mutex);
 
 	/* Copy the original irq_data. */
 	*parent_irq_data = *irq_data;
@@ -1663,7 +1679,7 @@ int irq_domain_push_irq(struct irq_domain *domain, int virq, void *arg)
 	irq_domain_fix_revmap(parent_irq_data);
 	irq_domain_set_mapping(domain, irq_data->hwirq, irq_data);
 error:
-	mutex_unlock(&irq_domain_mutex);
+	mutex_unlock(&domain->root->mutex);
 
 	return rv;
 }
@@ -1718,7 +1734,7 @@ int irq_domain_pop_irq(struct irq_domain *domain, int virq)
 	if (WARN_ON(!parent_irq_data))
 		return -EINVAL;
 
-	mutex_lock(&irq_domain_mutex);
+	mutex_lock(&domain->root->mutex);
 
 	irq_data->parent_data = NULL;
 
@@ -1730,7 +1746,7 @@ int irq_domain_pop_irq(struct irq_domain *domain, int virq)
 
 	irq_domain_fix_revmap(irq_data);
 
-	mutex_unlock(&irq_domain_mutex);
+	mutex_unlock(&domain->root->mutex);
 
 	kfree(parent_irq_data);
 
@@ -1746,17 +1762,20 @@ EXPORT_SYMBOL_GPL(irq_domain_pop_irq);
 void irq_domain_free_irqs(unsigned int virq, unsigned int nr_irqs)
 {
 	struct irq_data *data = irq_get_irq_data(virq);
+	struct irq_domain *domain;
 	int i;
 
 	if (WARN(!data || !data->domain || !data->domain->ops->free,
 		 "NULL pointer, cannot free irq\n"))
 		return;
 
-	mutex_lock(&irq_domain_mutex);
+	domain = data->domain;
+
+	mutex_lock(&domain->root->mutex);
 	for (i = 0; i < nr_irqs; i++)
 		irq_domain_remove_irq(virq + i);
-	irq_domain_free_irqs_hierarchy(data->domain, virq, nr_irqs);
-	mutex_unlock(&irq_domain_mutex);
+	irq_domain_free_irqs_hierarchy(domain, virq, nr_irqs);
+	mutex_unlock(&domain->root->mutex);
 
 	irq_domain_free_irq_data(virq, nr_irqs);
 	irq_free_descs(virq, nr_irqs);
-- 
2.39.1

