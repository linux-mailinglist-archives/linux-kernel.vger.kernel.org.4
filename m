Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A248D6950DF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjBMTlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjBMTkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:40:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB00E21298
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:40:46 -0800 (PST)
Date:   Mon, 13 Feb 2023 19:40:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676317245;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i0PCYOhUdk1wVFPCezjGMR3/OaTG/q/QU5lOobz+7uk=;
        b=rrlQ6kJF6vhvbfV1fK0/FAGMugeIzZ6Ki0PQZKbco2PNMF1jfjkdqo316OCYCTKKAm1hni
        oBYH4RCxWEueWQLbF/oB+JpLeLp1vDeslagInosDOSbOhoqt+SKS9YL7CDEXkuL0E9a/rM
        sHE4RZFPwPf4s/EpeFWDc3nXjhsIKka1TA2cm4N9VPXowmfW7YR5jzIIQwV4WdaDIOk9Tb
        k8b/DzHK11MGUDsSwLSup3DPIb3pBdjoSa999e9pMWcpimAiMnCnQqT3uVicbfYAMaqlas
        GRlc/zLFXwS0kmuwF39k+GB993yp0M/AvD/AnkWkBrCQXfO45q9GNIrDFcWfAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676317245;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i0PCYOhUdk1wVFPCezjGMR3/OaTG/q/QU5lOobz+7uk=;
        b=FiEdRNq5PXemgehMdop550L6LnMOh4z1F+OOivm73dWtZLsTISarbpKiBhiUJmzfnx6psl
        BQXKbFlaxrDj+YAA==
From:   "irqchip-bot for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqdomain: Drop revmap mutex
Cc:     "Hsin-Yi Wang" <hsinyi@chromium.org>,
        "Mark-PK Tsai" <mark-pk.tsai@mediatek.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230213104302.17307-9-johan+linaro@kernel.org>
References: <20230213104302.17307-9-johan+linaro@kernel.org>
MIME-Version: 1.0
Message-ID: <167631724497.4906.15252452660937628189.tip-bot2@tip-bot2>
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

Commit-ID:     47d1932f37de99bae3345bb93f098ac8750ab0fb
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/47d1932f37de99bae3345bb93f098ac8750ab0fb
Author:        Johan Hovold <johan+linaro@kernel.org>
AuthorDate:    Mon, 13 Feb 2023 11:42:50 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 13 Feb 2023 19:31:24 

irqdomain: Drop revmap mutex

The revmap mutex is essentially only used to maintain the integrity of
the radix tree during updates (lookups use RCU).

As the global irq_domain_mutex is now held in all paths that update the
revmap structures there is strictly no longer any need for the dedicated
mutex, which can be removed.

Drop the revmap mutex and add lockdep assertions to the revmap helpers
to make sure that the global lock is always held when updating the
revmap.

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230213104302.17307-9-johan+linaro@kernel.org
---
 include/linux/irqdomain.h |  2 --
 kernel/irq/irqdomain.c    | 13 ++++++-------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index a372086..16399de 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -143,7 +143,6 @@ struct irq_domain_chip_generic;
  * Revmap data, used internally by the irq domain code:
  * @revmap_size:	Size of the linear map table @revmap[]
  * @revmap_tree:	Radix map tree for hwirqs that don't fit in the linear map
- * @revmap_mutex:	Lock for the revmap
  * @revmap:		Linear table of irq_data pointers
  */
 struct irq_domain {
@@ -171,7 +170,6 @@ struct irq_domain {
 	irq_hw_number_t			hwirq_max;
 	unsigned int			revmap_size;
 	struct radix_tree_root		revmap_tree;
-	struct mutex			revmap_mutex;
 	struct irq_data __rcu		*revmap[];
 };
 
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index a6d1b10..c7113e7 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -206,7 +206,6 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 
 	/* Fill structure */
 	INIT_RADIX_TREE(&domain->revmap_tree, GFP_KERNEL);
-	mutex_init(&domain->revmap_mutex);
 	domain->ops = ops;
 	domain->host_data = host_data;
 	domain->hwirq_max = hwirq_max;
@@ -526,30 +525,30 @@ static bool irq_domain_is_nomap(struct irq_domain *domain)
 static void irq_domain_clear_mapping(struct irq_domain *domain,
 				     irq_hw_number_t hwirq)
 {
+	lockdep_assert_held(&irq_domain_mutex);
+
 	if (irq_domain_is_nomap(domain))
 		return;
 
-	mutex_lock(&domain->revmap_mutex);
 	if (hwirq < domain->revmap_size)
 		rcu_assign_pointer(domain->revmap[hwirq], NULL);
 	else
 		radix_tree_delete(&domain->revmap_tree, hwirq);
-	mutex_unlock(&domain->revmap_mutex);
 }
 
 static void irq_domain_set_mapping(struct irq_domain *domain,
 				   irq_hw_number_t hwirq,
 				   struct irq_data *irq_data)
 {
+	lockdep_assert_held(&irq_domain_mutex);
+
 	if (irq_domain_is_nomap(domain))
 		return;
 
-	mutex_lock(&domain->revmap_mutex);
 	if (hwirq < domain->revmap_size)
 		rcu_assign_pointer(domain->revmap[hwirq], irq_data);
 	else
 		radix_tree_insert(&domain->revmap_tree, hwirq, irq_data);
-	mutex_unlock(&domain->revmap_mutex);
 }
 
 static void irq_domain_disassociate(struct irq_domain *domain, unsigned int irq)
@@ -1580,11 +1579,12 @@ static void irq_domain_fix_revmap(struct irq_data *d)
 {
 	void __rcu **slot;
 
+	lockdep_assert_held(&irq_domain_mutex);
+
 	if (irq_domain_is_nomap(d->domain))
 		return;
 
 	/* Fix up the revmap. */
-	mutex_lock(&d->domain->revmap_mutex);
 	if (d->hwirq < d->domain->revmap_size) {
 		/* Not using radix tree */
 		rcu_assign_pointer(d->domain->revmap[d->hwirq], d);
@@ -1593,7 +1593,6 @@ static void irq_domain_fix_revmap(struct irq_data *d)
 		if (slot)
 			radix_tree_replace_slot(&d->domain->revmap_tree, slot, d);
 	}
-	mutex_unlock(&d->domain->revmap_mutex);
 }
 
 /**
