Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE5270F3AA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjEXKB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbjEXKBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:01:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA93312F;
        Wed, 24 May 2023 03:01:39 -0700 (PDT)
Date:   Wed, 24 May 2023 10:01:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684922496;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6FvvkhJf/VpDV2K3UEFi36r/TgLCYSuRfq0un7lMtc0=;
        b=Apcsf/ldQ3STJDYdOFw4txp9D9A5NgP6Tu5uaYIFrw05BacWvG/tNygtjIgSlxah5bPz5S
        Fs+Ggglat0z7o80EetmQkwkdGAX4cM6MkmPP769FqZuLPzCiCQl+0iyJGfqhWu4Vbgtjh+
        pmyQ5M1sk1DFugUTKVYUp240V4pqd+g9NLy1UN83u62zRr8E1EXCw8i2mEiyGFJrj01Vhr
        7jUveAHauKHgtFiuZLMlZx7B9ml8GTX3MlfWwdOhxB7rAqXMb2I8ONVszaW+rrCZcRKZI/
        DVQWYxpyzvy4AdzHSpL/fX/vzqtrvB+vWj2Z2ECX+vaMhE9F1KPUztSGX9y4Vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684922496;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6FvvkhJf/VpDV2K3UEFi36r/TgLCYSuRfq0un7lMtc0=;
        b=3QG3fcFPzMPy6K7+OGiGNu2KqawvhQ1XK9e6yzqUKRQepvqWefL23gwA60EMx9Ous4egUF
        eBKXoIh3ze15cHBw==
From:   "tip-bot2 for Shanker Donthineni" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Use a maple tree for interrupt descriptor management
Cc:     Shanker Donthineni <sdonthineni@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20230519134902.1495562-4-sdonthineni@nvidia.com>
References: <20230519134902.1495562-4-sdonthineni@nvidia.com>
MIME-Version: 1.0
Message-ID: <168492249583.404.6723379224465568533.tip-bot2@tip-bot2>
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

Commit-ID:     721255b9826bd11c7a38b585905fc2dd0fb94e52
Gitweb:        https://git.kernel.org/tip/721255b9826bd11c7a38b585905fc2dd0fb94e52
Author:        Shanker Donthineni <sdonthineni@nvidia.com>
AuthorDate:    Fri, 19 May 2023 08:49:02 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 24 May 2023 11:39:44 +02:00

genirq: Use a maple tree for interrupt descriptor management

The current implementation uses a static bitmap for interrupt descriptor
allocation and a radix tree to pointer store the pointer for lookup.

However, the size of the bitmap is constrained by the build time macro
MAX_SPARSE_IRQS, which may not be sufficient to support high-end servers,
particularly those with GICv4.1 hardware, which require a large interrupt
space to cover LPIs and vSGIs.

Replace the bitmap and the radix tree with a maple tree, which not only
stores pointers for lookup, but also provides a mechanism to find free
ranges. That removes the build time hardcoded upper limit.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230519134902.1495562-4-sdonthineni@nvidia.com

---
 kernel/irq/internals.h |  2 +-
 kernel/irq/irqdesc.c   | 57 +++++++++++++++++++++++------------------
 2 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index f3f2090..7bdb750 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -12,7 +12,7 @@
 #include <linux/sched/clock.h>
 
 #ifdef CONFIG_SPARSE_IRQ
-# define MAX_SPARSE_IRQS	(NR_IRQS + 8196)
+# define MAX_SPARSE_IRQS	INT_MAX
 #else
 # define MAX_SPARSE_IRQS	NR_IRQS
 #endif
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index e0d9dd9..27ca1c8 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -12,8 +12,7 @@
 #include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
-#include <linux/radix-tree.h>
-#include <linux/bitmap.h>
+#include <linux/maple_tree.h>
 #include <linux/irqdomain.h>
 #include <linux/sysfs.h>
 
@@ -131,17 +130,39 @@ int nr_irqs = NR_IRQS;
 EXPORT_SYMBOL_GPL(nr_irqs);
 
 static DEFINE_MUTEX(sparse_irq_lock);
-static DECLARE_BITMAP(allocated_irqs, MAX_SPARSE_IRQS);
+static struct maple_tree sparse_irqs = MTREE_INIT_EXT(sparse_irqs,
+					MT_FLAGS_ALLOC_RANGE |
+					MT_FLAGS_LOCK_EXTERN |
+					MT_FLAGS_USE_RCU,
+					sparse_irq_lock);
 
 static int irq_find_free_area(unsigned int from, unsigned int cnt)
 {
-	return bitmap_find_next_zero_area(allocated_irqs, MAX_SPARSE_IRQS,
-					  from, cnt, 0);
+	MA_STATE(mas, &sparse_irqs, 0, 0);
+
+	if (mas_empty_area(&mas, from, MAX_SPARSE_IRQS, cnt))
+		return -ENOSPC;
+	return mas.index;
 }
 
 static unsigned int irq_find_at_or_after(unsigned int offset)
 {
-	return find_next_bit(allocated_irqs, nr_irqs, offset);
+	unsigned long index = offset;
+	struct irq_desc *desc = mt_find(&sparse_irqs, &index, nr_irqs);
+
+	return desc ? irq_desc_get_irq(desc) : nr_irqs;
+}
+
+static void irq_insert_desc(unsigned int irq, struct irq_desc *desc)
+{
+	MA_STATE(mas, &sparse_irqs, irq, irq);
+	WARN_ON(mas_store_gfp(&mas, desc, GFP_KERNEL) != 0);
+}
+
+static void delete_irq_desc(unsigned int irq)
+{
+	MA_STATE(mas, &sparse_irqs, irq, irq);
+	mas_erase(&mas);
 }
 
 #ifdef CONFIG_SPARSE_IRQ
@@ -355,26 +376,14 @@ static void irq_sysfs_del(struct irq_desc *desc) {}
 
 #endif /* CONFIG_SYSFS */
 
-static RADIX_TREE(irq_desc_tree, GFP_KERNEL);
-
-static void irq_insert_desc(unsigned int irq, struct irq_desc *desc)
-{
-	radix_tree_insert(&irq_desc_tree, irq, desc);
-}
-
 struct irq_desc *irq_to_desc(unsigned int irq)
 {
-	return radix_tree_lookup(&irq_desc_tree, irq);
+	return mtree_load(&sparse_irqs, irq);
 }
 #ifdef CONFIG_KVM_BOOK3S_64_HV_MODULE
 EXPORT_SYMBOL_GPL(irq_to_desc);
 #endif
 
-static void delete_irq_desc(unsigned int irq)
-{
-	radix_tree_delete(&irq_desc_tree, irq);
-}
-
 #ifdef CONFIG_SMP
 static void free_masks(struct irq_desc *desc)
 {
@@ -517,7 +526,6 @@ static int alloc_descs(unsigned int start, unsigned int cnt, int node,
 		irq_sysfs_add(start + i, desc);
 		irq_add_debugfs_entry(start + i, desc);
 	}
-	bitmap_set(allocated_irqs, start, cnt);
 	return start;
 
 err:
@@ -557,7 +565,6 @@ int __init early_irq_init(void)
 
 	for (i = 0; i < initcnt; i++) {
 		desc = alloc_desc(i, node, 0, NULL, NULL);
-		set_bit(i, allocated_irqs);
 		irq_insert_desc(i, desc);
 	}
 	return arch_early_irq_init();
@@ -612,6 +619,7 @@ static void free_desc(unsigned int irq)
 	raw_spin_lock_irqsave(&desc->lock, flags);
 	desc_set_defaults(irq, desc, irq_desc_get_node(desc), NULL, NULL);
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
+	delete_irq_desc(irq);
 }
 
 static inline int alloc_descs(unsigned int start, unsigned int cnt, int node,
@@ -624,8 +632,8 @@ static inline int alloc_descs(unsigned int start, unsigned int cnt, int node,
 		struct irq_desc *desc = irq_to_desc(start + i);
 
 		desc->owner = owner;
+		irq_insert_desc(start + i, desc);
 	}
-	bitmap_set(allocated_irqs, start, cnt);
 	return start;
 }
 
@@ -637,7 +645,7 @@ static int irq_expand_nr_irqs(unsigned int nr)
 void irq_mark_irq(unsigned int irq)
 {
 	mutex_lock(&sparse_irq_lock);
-	bitmap_set(allocated_irqs, irq, 1);
+	irq_insert_desc(irq, irq_desc + irq);
 	mutex_unlock(&sparse_irq_lock);
 }
 
@@ -781,7 +789,6 @@ void irq_free_descs(unsigned int from, unsigned int cnt)
 	for (i = 0; i < cnt; i++)
 		free_desc(from + i);
 
-	bitmap_clear(allocated_irqs, from, cnt);
 	mutex_unlock(&sparse_irq_lock);
 }
 EXPORT_SYMBOL_GPL(irq_free_descs);
@@ -844,7 +851,7 @@ EXPORT_SYMBOL_GPL(__irq_alloc_descs);
  * irq_get_next_irq - get next allocated irq number
  * @offset:	where to start the search
  *
- * Returns next irq number at or after offset or nr_irqs if none is found.
+ * Returns next irq number after offset or nr_irqs if none is found.
  */
 unsigned int irq_get_next_irq(unsigned int offset)
 {
