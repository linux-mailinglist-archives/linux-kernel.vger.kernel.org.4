Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57458648345
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiLIOF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiLIOFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:05:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A6E77229;
        Fri,  9 Dec 2022 06:05:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95C3962269;
        Fri,  9 Dec 2022 14:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBE8C433AA;
        Fri,  9 Dec 2022 14:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670594713;
        bh=25WzgH8MXrRT4j0vWI1/G7WvfbKjDj7LuhqI1OtgHDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mjFT4DQ8z9ZlKuB/SCMNZRZ/RzrAZgiOOrJ0PfRUJaVRThztlaUcCpQPOu4kqduKI
         gyxKZjq/e81Mu8CIHXWLq5xUKKGKb6JyuIJBw/BylQS0Rpr25Rl3TOUYd2YtZajdd5
         /WC7iKD80xZ7YxL4zrOzLMKnC9D7Ht+/pt5o/OBx4dZavApxI8yvOky/JU4yNe2Zhx
         Bj6cCE12Jif+aEbiNW9BRmMocaSxG2Dfyfe3YM4tV/JdJouLMRwajSrkkIQrqvPIpo
         iDinKaUbIMvf9pkyu2PeDD5xjNlU9HxV06/rZ2hAcYBptCO30KGgY3pOYVwhez79pw
         kvPrnTrp/85Lw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1p3e0I-0000Rc-Kt; Fri, 09 Dec 2022 15:05:30 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 06/19] irqdomain: Drop revmap mutex
Date:   Fri,  9 Dec 2022 15:01:37 +0100
Message-Id: <20221209140150.1453-7-johan+linaro@kernel.org>
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

The global irq_domain_mutex is now held in all paths that update the
revmap structures so there is no longer any need for the revmap mutex.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 include/linux/irqdomain.h |  2 --
 kernel/irq/irqdomain.c    | 13 ++++++-------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index a372086750ca..16399de00b48 100644
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
index 23f5919e58b7..248e6acfafbe 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -214,7 +214,6 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int s
 
 	/* Fill structure */
 	INIT_RADIX_TREE(&domain->revmap_tree, GFP_KERNEL);
-	mutex_init(&domain->revmap_mutex);
 	domain->ops = ops;
 	domain->host_data = host_data;
 	domain->hwirq_max = hwirq_max;
@@ -501,30 +500,30 @@ static bool irq_domain_is_nomap(struct irq_domain *domain)
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
@@ -1511,11 +1510,12 @@ static void irq_domain_fix_revmap(struct irq_data *d)
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
@@ -1524,7 +1524,6 @@ static void irq_domain_fix_revmap(struct irq_data *d)
 		if (slot)
 			radix_tree_replace_slot(&d->domain->revmap_tree, slot, d);
 	}
-	mutex_unlock(&d->domain->revmap_mutex);
 }
 
 /**
-- 
2.37.4

