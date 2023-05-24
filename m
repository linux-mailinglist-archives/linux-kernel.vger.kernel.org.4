Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E513470F3A8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjEXKBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjEXKBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:01:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C962FC;
        Wed, 24 May 2023 03:01:39 -0700 (PDT)
Date:   Wed, 24 May 2023 10:01:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684922497;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AZ9L36XPWY561QIqVzpNG8zVU3OgtA+q12Vb9JtEJbE=;
        b=L8/0qhF/A86lnjl862wH46TqxwqJc/62ZUtrYNEvr3H1BL6n9QPbsg9/oIioLvr0NFuEwW
        A3clN+oMWkjYSSL38T2QG6Nmqhy2+3lPjhWFQUVujjzJ7E8R/JEuqSy2DY7Oqy+erbf4lM
        lmbFWRTUTcW1BcQCSST/JHEOcYxmx5/tvJaUIuitNP0y7tcleT/b9cvRgm7lZeKDEKaCVf
        bWPBfuySWz+S7iF6KzXp2JtCbRVGKcqL6DgKCigDzx3eOWIJ9kh7lIqlyWv1bOIzDJaf8m
        wuiU8RIuI4vawLewos3fuOqBnd2y7WPTQEqDEvNQrTZPV2AmN5lBFeIqFdMKZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684922497;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AZ9L36XPWY561QIqVzpNG8zVU3OgtA+q12Vb9JtEJbE=;
        b=a6nn/Yj8oj1siXhrv3CMhy7Edj+MUlhuNU0xWSMMafc1c2aj7HY7aA49eVP2e7GCnW6OkE
        Ha3Zd04a/yV9YwAg==
From:   "tip-bot2 for Shanker Donthineni" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Use hlist for managing resend handlers
Cc:     Shanker Donthineni <sdonthineni@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20230519134902.1495562-2-sdonthineni@nvidia.com>
References: <20230519134902.1495562-2-sdonthineni@nvidia.com>
MIME-Version: 1.0
Message-ID: <168492249714.404.7171936178014634825.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     bc06a9e0874239cb6d4eebcb0ecd1a91ad9272db
Gitweb:        https://git.kernel.org/tip/bc06a9e0874239cb6d4eebcb0ecd1a91ad9272db
Author:        Shanker Donthineni <sdonthineni@nvidia.com>
AuthorDate:    Fri, 19 May 2023 08:49:00 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 24 May 2023 11:39:44 +02:00

genirq: Use hlist for managing resend handlers

The current implementation utilizes a bitmap for managing interrupt resend
handlers, which is allocated based on the SPARSE_IRQ/NR_IRQS macros.
However, this method may not efficiently utilize memory during runtime,
particularly when IRQ_BITMAP_BITS is large.

Address this issue by using an hlist to manage interrupt resend handlers
instead of relying on a static bitmap memory allocation. Additionally, a
new function, clear_irq_resend(), is introduced and called from
irq_shutdown to ensure a graceful teardown of the interrupt.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230519134902.1495562-2-sdonthineni@nvidia.com

---
 include/linux/irqdesc.h |  3 +++-
 kernel/irq/chip.c       |  1 +-
 kernel/irq/internals.h  |  2 ++-
 kernel/irq/irqdesc.c    |  2 ++-
 kernel/irq/resend.c     | 47 +++++++++++++++++++++++++---------------
 5 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 844a8e3..d9451d4 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -102,6 +102,9 @@ struct irq_desc {
 	int			parent_irq;
 	struct module		*owner;
 	const char		*name;
+#ifdef CONFIG_HARDIRQS_SW_RESEND
+	struct hlist_node	resend_node;
+#endif
 } ____cacheline_internodealigned_in_smp;
 
 #ifdef CONFIG_SPARSE_IRQ
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 49e7bc8..2eac553 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -306,6 +306,7 @@ static void __irq_disable(struct irq_desc *desc, bool mask);
 void irq_shutdown(struct irq_desc *desc)
 {
 	if (irqd_is_started(&desc->irq_data)) {
+		clear_irq_resend(desc);
 		desc->depth = 1;
 		if (desc->irq_data.chip->irq_shutdown) {
 			desc->irq_data.chip->irq_shutdown(&desc->irq_data);
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 5fdc0b5..51fc8c4 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -113,6 +113,8 @@ irqreturn_t handle_irq_event(struct irq_desc *desc);
 
 /* Resending of interrupts :*/
 int check_irq_resend(struct irq_desc *desc, bool inject);
+void clear_irq_resend(struct irq_desc *desc);
+void irq_resend_init(struct irq_desc *desc);
 bool irq_wait_for_poll(struct irq_desc *desc);
 void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action);
 
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 240e145..b401b89 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -415,6 +415,7 @@ static struct irq_desc *alloc_desc(int irq, int node, unsigned int flags,
 	desc_set_defaults(irq, desc, node, affinity, owner);
 	irqd_set(&desc->irq_data, flags);
 	kobject_init(&desc->kobj, &irq_kobj_type);
+	irq_resend_init(desc);
 
 	return desc;
 
@@ -581,6 +582,7 @@ int __init early_irq_init(void)
 		mutex_init(&desc[i].request_mutex);
 		init_waitqueue_head(&desc[i].wait_for_threads);
 		desc_set_defaults(i, &desc[i], node, NULL, NULL);
+		irq_resend_init(desc);
 	}
 	return arch_early_irq_init();
 }
diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index 0c46e9f..edec335 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -21,8 +21,9 @@
 
 #ifdef CONFIG_HARDIRQS_SW_RESEND
 
-/* Bitmap to handle software resend of interrupts: */
-static DECLARE_BITMAP(irqs_resend, IRQ_BITMAP_BITS);
+/* hlist_head to handle software resend of interrupts: */
+static HLIST_HEAD(irq_resend_list);
+static DEFINE_RAW_SPINLOCK(irq_resend_lock);
 
 /*
  * Run software resends of IRQ's
@@ -30,18 +31,17 @@ static DECLARE_BITMAP(irqs_resend, IRQ_BITMAP_BITS);
 static void resend_irqs(struct tasklet_struct *unused)
 {
 	struct irq_desc *desc;
-	int irq;
-
-	while (!bitmap_empty(irqs_resend, nr_irqs)) {
-		irq = find_first_bit(irqs_resend, nr_irqs);
-		clear_bit(irq, irqs_resend);
-		desc = irq_to_desc(irq);
-		if (!desc)
-			continue;
-		local_irq_disable();
+
+	raw_spin_lock_irq(&irq_resend_lock);
+	while (!hlist_empty(&irq_resend_list)) {
+		desc = hlist_entry(irq_resend_list.first, struct irq_desc,
+				   resend_node);
+		hlist_del_init(&desc->resend_node);
+		raw_spin_unlock(&irq_resend_lock);
 		desc->handle_irq(desc);
-		local_irq_enable();
+		raw_spin_lock(&irq_resend_lock);
 	}
+	raw_spin_unlock_irq(&irq_resend_lock);
 }
 
 /* Tasklet to handle resend: */
@@ -49,8 +49,6 @@ static DECLARE_TASKLET(resend_tasklet, resend_irqs);
 
 static int irq_sw_resend(struct irq_desc *desc)
 {
-	unsigned int irq = irq_desc_get_irq(desc);
-
 	/*
 	 * Validate whether this interrupt can be safely injected from
 	 * non interrupt context
@@ -70,16 +68,31 @@ static int irq_sw_resend(struct irq_desc *desc)
 		 */
 		if (!desc->parent_irq)
 			return -EINVAL;
-		irq = desc->parent_irq;
 	}
 
-	/* Set it pending and activate the softirq: */
-	set_bit(irq, irqs_resend);
+	/* Add to resend_list and activate the softirq: */
+	raw_spin_lock(&irq_resend_lock);
+	hlist_add_head(&desc->resend_node, &irq_resend_list);
+	raw_spin_unlock(&irq_resend_lock);
 	tasklet_schedule(&resend_tasklet);
 	return 0;
 }
 
+void clear_irq_resend(struct irq_desc *desc)
+{
+	raw_spin_lock(&irq_resend_lock);
+	hlist_del_init(&desc->resend_node);
+	raw_spin_unlock(&irq_resend_lock);
+}
+
+void irq_resend_init(struct irq_desc *desc)
+{
+	INIT_HLIST_NODE(&desc->resend_node);
+}
 #else
+void clear_irq_resend(struct irq_desc *desc) {}
+void irq_resend_init(struct irq_desc *desc) {}
+
 static int irq_sw_resend(struct irq_desc *desc)
 {
 	return -EINVAL;
