Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF1F70F3A9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjEXKBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjEXKBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:01:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7D9BF;
        Wed, 24 May 2023 03:01:39 -0700 (PDT)
Date:   Wed, 24 May 2023 10:01:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684922497;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QrAb+l/HjWoyP4CIXE6QlhYtbPeXEH0GKICQft7HWZ8=;
        b=hoPIEDBYNnkl6gxqK4pf5DTv/QGA7sH1q/mKL3TNL+w6Ab4H0fFtgYhl/gkgfnu87YsnmC
        f4KWXMV9XrRoljrZsnW8KX+CUah84DFSag6nw5U7s7MdfFb64lZOb8mJykWmJDhqlx42qB
        UqS+OF/NUTQQEyURibewi/kvM1jLATwIXheNxaShowY7vE1n6NDOEmLx2wVc+2W1gPMZlx
        AVVDlB3a6Q1gbeVpboSChypbVYweFhMRkL3A6wUHws8jK1YvFAbGyFuBLqWHb24u/1tA3U
        Rd5ajpnRrLsT/ugqUFGy3e+r6+so/PZVuA0fhSMWCGfmh9+H9qrR9aNCuCWEQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684922497;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QrAb+l/HjWoyP4CIXE6QlhYtbPeXEH0GKICQft7HWZ8=;
        b=Tf+iaaVTVgkvW2USqwB+STbwveEWVbDYfOgnSfhOl5D8c+qVT1+cHumZJz2rj456zULmUr
        5BE3x4nm9DCrXcBA==
From:   "tip-bot2 for Shanker Donthineni" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Encapsulate sparse bitmap handling
Cc:     Shanker Donthineni <sdonthineni@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20230519134902.1495562-3-sdonthineni@nvidia.com>
References: <20230519134902.1495562-3-sdonthineni@nvidia.com>
MIME-Version: 1.0
Message-ID: <168492249655.404.8417655957342691240.tip-bot2@tip-bot2>
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

Commit-ID:     5e630aa8d9fcd4c0cb6d5d09422009533aba979a
Gitweb:        https://git.kernel.org/tip/5e630aa8d9fcd4c0cb6d5d09422009533aba979a
Author:        Shanker Donthineni <sdonthineni@nvidia.com>
AuthorDate:    Fri, 19 May 2023 08:49:01 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 24 May 2023 11:39:44 +02:00

genirq: Encapsulate sparse bitmap handling

Move the open coded sparse bitmap handling into helper functions as
a preparatory step for converting the sparse interrupt management
to a maple tree.

No functional change.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230519134902.1495562-3-sdonthineni@nvidia.com

---
 kernel/irq/internals.h |  4 ++--
 kernel/irq/irqdesc.c   | 30 ++++++++++++++++++++----------
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 51fc8c4..f3f2090 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -12,9 +12,9 @@
 #include <linux/sched/clock.h>
 
 #ifdef CONFIG_SPARSE_IRQ
-# define IRQ_BITMAP_BITS	(NR_IRQS + 8196)
+# define MAX_SPARSE_IRQS	(NR_IRQS + 8196)
 #else
-# define IRQ_BITMAP_BITS	NR_IRQS
+# define MAX_SPARSE_IRQS	NR_IRQS
 #endif
 
 #define istate core_internal_state__do_not_mess_with_it
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index b401b89..e0d9dd9 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -131,7 +131,18 @@ int nr_irqs = NR_IRQS;
 EXPORT_SYMBOL_GPL(nr_irqs);
 
 static DEFINE_MUTEX(sparse_irq_lock);
-static DECLARE_BITMAP(allocated_irqs, IRQ_BITMAP_BITS);
+static DECLARE_BITMAP(allocated_irqs, MAX_SPARSE_IRQS);
+
+static int irq_find_free_area(unsigned int from, unsigned int cnt)
+{
+	return bitmap_find_next_zero_area(allocated_irqs, MAX_SPARSE_IRQS,
+					  from, cnt, 0);
+}
+
+static unsigned int irq_find_at_or_after(unsigned int offset)
+{
+	return find_next_bit(allocated_irqs, nr_irqs, offset);
+}
 
 #ifdef CONFIG_SPARSE_IRQ
 
@@ -517,7 +528,7 @@ err:
 
 static int irq_expand_nr_irqs(unsigned int nr)
 {
-	if (nr > IRQ_BITMAP_BITS)
+	if (nr > MAX_SPARSE_IRQS)
 		return -ENOMEM;
 	nr_irqs = nr;
 	return 0;
@@ -535,11 +546,11 @@ int __init early_irq_init(void)
 	printk(KERN_INFO "NR_IRQS: %d, nr_irqs: %d, preallocated irqs: %d\n",
 	       NR_IRQS, nr_irqs, initcnt);
 
-	if (WARN_ON(nr_irqs > IRQ_BITMAP_BITS))
-		nr_irqs = IRQ_BITMAP_BITS;
+	if (WARN_ON(nr_irqs > MAX_SPARSE_IRQS))
+		nr_irqs = MAX_SPARSE_IRQS;
 
-	if (WARN_ON(initcnt > IRQ_BITMAP_BITS))
-		initcnt = IRQ_BITMAP_BITS;
+	if (WARN_ON(initcnt > MAX_SPARSE_IRQS))
+		initcnt = MAX_SPARSE_IRQS;
 
 	if (initcnt > nr_irqs)
 		nr_irqs = initcnt;
@@ -812,8 +823,7 @@ __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
 
 	mutex_lock(&sparse_irq_lock);
 
-	start = bitmap_find_next_zero_area(allocated_irqs, IRQ_BITMAP_BITS,
-					   from, cnt, 0);
+	start = irq_find_free_area(from, cnt);
 	ret = -EEXIST;
 	if (irq >=0 && start != irq)
 		goto unlock;
@@ -834,11 +844,11 @@ EXPORT_SYMBOL_GPL(__irq_alloc_descs);
  * irq_get_next_irq - get next allocated irq number
  * @offset:	where to start the search
  *
- * Returns next irq number after offset or nr_irqs if none is found.
+ * Returns next irq number at or after offset or nr_irqs if none is found.
  */
 unsigned int irq_get_next_irq(unsigned int offset)
 {
-	return find_next_bit(allocated_irqs, nr_irqs, offset);
+	return irq_find_at_or_after(offset);
 }
 
 struct irq_desc *
