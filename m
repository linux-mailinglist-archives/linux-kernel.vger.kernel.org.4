Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CAA6950D2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjBMTky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjBMTko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:40:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8463591
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:40:42 -0800 (PST)
Date:   Mon, 13 Feb 2023 19:40:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676317240;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qI4FbZwqe+Y9Pa0jyC270B+yzaYHraui8XNVwxKBE54=;
        b=Kiu6GJNmIkuMqjhZPkEnM9coU5l1hiobL8EBhaN8ldNW6U/Wu5amewk//EHilatxXtQbFU
        Ye1UhzbRAtzCprcxZ53qo7YuvOzbTNeMEEpxq2pRhZ8I0OGmXPn6S1Ekwm73L5nhP5OYJk
        pOr75namDh325UyevOeLbxv80EKx5ItehJXmloS5wvwe0w+OEoXKc/uH+mWLExagn4zgYd
        C+i/MELPxffzhGlfyFbfVgy+CCvE9bQDdz1+EBlJizpVMLw87otrfvEGwHa+MZio2TCgM/
        0yXFtEoTZGe6vqEV6y/QBxkC6bbvIiu9BbncKq7wevCTy6KL1+SUvixLQDXdQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676317240;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qI4FbZwqe+Y9Pa0jyC270B+yzaYHraui8XNVwxKBE54=;
        b=Fcmfj9/gsyYV+HvgbvtrGT79S+CIb3f1HbU3z8MLRd4Xf3KbOSLPg0NhHfbzlBWebNn/wf
        ZEnGfGfvtTYxiSCQ==
From:   "irqchip-bot for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqdomain: Switch to per-domain locking
Cc:     "Hsin-Yi Wang" <hsinyi@chromium.org>,
        "Mark-PK Tsai" <mark-pk.tsai@mediatek.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230213104302.17307-21-johan+linaro@kernel.org>
References: <20230213104302.17307-21-johan+linaro@kernel.org>
MIME-Version: 1.0
Message-ID: <167631723945.4906.5127547300479241477.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     9dbb8e3452aba34e6fa4f63054b3adc66aceb7ec
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/9dbb8e3452aba34e6fa4f63054b3adc66aceb7ec
Author:        Johan Hovold <johan+linaro@kernel.org>
AuthorDate:    Mon, 13 Feb 2023 11:43:02 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 13 Feb 2023 19:31:25 

irqdomain: Switch to per-domain locking

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
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230213104302.17307-21-johan+linaro@kernel.org
---
 include/linux/irqdomain.h |  4 +++-
 kernel/irq/irqdomain.c    | 59 +++++++++++++++++++++++++-------------
 2 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 16399de..d320d15 100644
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
index 6d480dc..1983f1b 100644
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
