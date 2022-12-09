Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14417648363
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiLIOGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiLIOFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:05:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075D473F69;
        Fri,  9 Dec 2022 06:05:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18EE362275;
        Fri,  9 Dec 2022 14:05:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37EFC433F1;
        Fri,  9 Dec 2022 14:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670594714;
        bh=Vr1RWEE1BLL3F5ODipwAjwleNPdE5gnPm2mw3W0gbGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DzsRaw4wb2Khse5EZuyLvwhozm4UKC6pAm6PodJFWnWXqIY2vIqI4cSbO+bcuQA0w
         6mmTvv7Hgz9bwJhJbDPPtyi8oQLGdeFB3WZh4lZXvURZq53QUY7jzMa7K0kEtwVjGO
         8zRT9wdLd5cMpvYSbELaa3pZJ/5QQJe/nx6695C/EmvdwmHuHRbO/JH0axDFI3aisK
         Y/S2J3HgcQ/lZ32vCRTLbBSu0hKr0IElmOwNkkboTWMJClv9SIj7vgBukvKaKbI7bt
         NuIe87GrS6Kbv++RUtf2Ps53UltTalh4qxbmQXWyW2/r7M+/fx1/KU1Mr+8PMMaBCi
         bPlNFlVv+wrPw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1p3e0J-0000SG-T5; Fri, 09 Dec 2022 15:05:31 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 19/19] irqdomain: Switch to per-domain locking
Date:   Fri,  9 Dec 2022 15:01:50 +0100
Message-Id: <20221209140150.1453-20-johan+linaro@kernel.org>
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

The IRQ domain structures are currently protected by the global
irq_domain_mutex. Switch to using more fine-grained per-domain locking,
which may potentially speed up parallel probing somewhat.

Note that the domain lock of the root domain (innermost domain) must be
used for hierarchical domains. For non-hierarchical domain (as for root
domains), the new root pointer is set to the domain itself so that
domain->root->mutex can be used in shared code paths.

Also note that hierarchical domains should be constructed using
irq_domain_create_hierarchy() (or irq_domain_add_hierarchy()) to avoid
poking at irqdomain internals.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 include/linux/irqdomain.h |  4 ++++
 kernel/irq/irqdomain.c    | 48 ++++++++++++++++++++++-----------------
 2 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 16399de00b48..cad47737a052 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -125,6 +125,8 @@ struct irq_domain_chip_generic;
  *		core code.
  * @flags:	Per irq_domain flags
  * @mapcount:	The number of mapped interrupts
+ * @mutex:	Domain lock, hierarhical domains use root domain's lock
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
index 6f2b8a1248e1..3faea8b66120 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -217,6 +217,7 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int s
 
 	/* Fill structure */
 	INIT_RADIX_TREE(&domain->revmap_tree, GFP_KERNEL);
+	mutex_init(&domain->mutex);
 	domain->ops = ops;
 	domain->host_data = host_data;
 	domain->hwirq_max = hwirq_max;
@@ -227,6 +228,7 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int s
 	domain->revmap_size = size;
 
 	irq_domain_check_hierarchy(domain);
+	domain->root = domain;
 
 	mutex_lock(&irq_domain_mutex);
 	debugfs_add_domain_dir(domain);
@@ -503,7 +505,7 @@ static bool irq_domain_is_nomap(struct irq_domain *domain)
 static void irq_domain_clear_mapping(struct irq_domain *domain,
 				     irq_hw_number_t hwirq)
 {
-	lockdep_assert_held(&irq_domain_mutex);
+	lockdep_assert_held(&domain->root->mutex);
 
 	if (irq_domain_is_nomap(domain))
 		return;
@@ -518,7 +520,7 @@ static void irq_domain_set_mapping(struct irq_domain *domain,
 				   irq_hw_number_t hwirq,
 				   struct irq_data *irq_data)
 {
-	lockdep_assert_held(&irq_domain_mutex);
+	lockdep_assert_held(&domain->root->mutex);
 
 	if (irq_domain_is_nomap(domain))
 		return;
@@ -540,7 +542,7 @@ static void irq_domain_disassociate(struct irq_domain *domain, unsigned int irq)
 
 	hwirq = irq_data->hwirq;
 
-	mutex_lock(&irq_domain_mutex);
+	mutex_lock(&domain->mutex);
 
 	irq_set_status_flags(irq, IRQ_NOREQUEST);
 
@@ -562,7 +564,7 @@ static void irq_domain_disassociate(struct irq_domain *domain, unsigned int irq)
 	/* Clear reverse map for this hwirq */
 	irq_domain_clear_mapping(domain, hwirq);
 
-	mutex_unlock(&irq_domain_mutex);
+	mutex_unlock(&domain->mutex);
 }
 
 static int __irq_domain_associate(struct irq_domain *domain, unsigned int virq,
@@ -612,9 +614,9 @@ int irq_domain_associate(struct irq_domain *domain, unsigned int virq,
 {
 	int ret;
 
-	mutex_lock(&irq_domain_mutex);
+	mutex_lock(&domain->mutex);
 	ret = __irq_domain_associate(domain, virq, hwirq);
-	mutex_unlock(&irq_domain_mutex);
+	mutex_unlock(&domain->mutex);
 
 	return ret;
 }
@@ -731,7 +733,7 @@ unsigned int irq_create_mapping_affinity(struct irq_domain *domain,
 		return 0;
 	}
 
-	mutex_lock(&irq_domain_mutex);
+	mutex_lock(&domain->mutex);
 
 	/* Check if mapping already exists */
 	virq = irq_find_mapping(domain, hwirq);
@@ -742,7 +744,7 @@ unsigned int irq_create_mapping_affinity(struct irq_domain *domain,
 
 	virq = __irq_create_mapping_affinity(domain, hwirq, affinity);
 out:
-	mutex_unlock(&irq_domain_mutex);
+	mutex_unlock(&domain->mutex);
 
 	return virq;
 }
@@ -811,7 +813,7 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 	if (WARN_ON(type & ~IRQ_TYPE_SENSE_MASK))
 		type &= IRQ_TYPE_SENSE_MASK;
 
-	mutex_lock(&irq_domain_mutex);
+	mutex_lock(&domain->root->mutex);
 
 	/*
 	 * If we've already configured this interrupt,
@@ -864,11 +866,11 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 	/* Store trigger type */
 	irqd_set_trigger_type(irq_data, type);
 out:
-	mutex_unlock(&irq_domain_mutex);
+	mutex_unlock(&domain->root->mutex);
 
 	return virq;
 err:
-	mutex_unlock(&irq_domain_mutex);
+	mutex_unlock(&domain->root->mutex);
 
 	return 0;
 }
@@ -1132,6 +1134,7 @@ struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
 	else
 		domain = irq_domain_create_tree(fwnode, ops, host_data);
 	if (domain) {
+		domain->root = parent->root;
 		domain->parent = parent;
 		domain->flags |= flags;
 	}
@@ -1528,10 +1531,10 @@ int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
 			return -EINVAL;
 	}
 
-	mutex_lock(&irq_domain_mutex);
+	mutex_lock(&domain->root->mutex);
 	ret = ___irq_domain_alloc_irqs(domain, irq_base, nr_irqs, node, arg,
 				       realloc, affinity);
-	mutex_unlock(&irq_domain_mutex);
+	mutex_unlock(&domain->root->mutex);
 
 	return ret;
 }
@@ -1542,7 +1545,7 @@ static void irq_domain_fix_revmap(struct irq_data *d)
 {
 	void __rcu **slot;
 
-	lockdep_assert_held(&irq_domain_mutex);
+	lockdep_assert_held(&d->domain->root->mutex);
 
 	if (irq_domain_is_nomap(d->domain))
 		return;
@@ -1608,7 +1611,7 @@ int irq_domain_push_irq(struct irq_domain *domain, int virq, void *arg)
 	if (!parent_irq_data)
 		return -ENOMEM;
 
-	mutex_lock(&irq_domain_mutex);
+	mutex_lock(&domain->root->mutex);
 
 	/* Copy the original irq_data. */
 	*parent_irq_data = *irq_data;
@@ -1636,7 +1639,7 @@ int irq_domain_push_irq(struct irq_domain *domain, int virq, void *arg)
 	irq_domain_fix_revmap(parent_irq_data);
 	irq_domain_set_mapping(domain, irq_data->hwirq, irq_data);
 error:
-	mutex_unlock(&irq_domain_mutex);
+	mutex_unlock(&domain->root->mutex);
 
 	return rv;
 }
@@ -1691,7 +1694,7 @@ int irq_domain_pop_irq(struct irq_domain *domain, int virq)
 	if (WARN_ON(!parent_irq_data))
 		return -EINVAL;
 
-	mutex_lock(&irq_domain_mutex);
+	mutex_lock(&domain->root->mutex);
 
 	irq_data->parent_data = NULL;
 
@@ -1703,7 +1706,7 @@ int irq_domain_pop_irq(struct irq_domain *domain, int virq)
 
 	irq_domain_fix_revmap(irq_data);
 
-	mutex_unlock(&irq_domain_mutex);
+	mutex_unlock(&domain->root->mutex);
 
 	kfree(parent_irq_data);
 
@@ -1719,17 +1722,20 @@ EXPORT_SYMBOL_GPL(irq_domain_pop_irq);
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
2.37.4

