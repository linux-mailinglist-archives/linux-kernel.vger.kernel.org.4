Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D79736AB3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjFTLQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 07:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjFTLQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:16:13 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1907C4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1687259767;
  x=1718795767;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=jUSYZgaftLFTXoGuck09rxFUuGbEnF1/FEdMdmbgZCI=;
  b=hkjBAvWiZafNtu1YNGsxATAgmD0ywmAPKDoZmo90K28CUkdqvgXsP4vm
   etZT4DlhojMVl7kwVl9/yg7y/udmS51lHVj2t5tYm34NwbqNLmA6U2aRs
   eW+o7ST/rCq1tbys4c4zJZLssO5bKmqqh8LKsEmAlhEPN4eI86ztSS3bP
   dRIRmJ9qp1MB23wy5peVJLodDRunxc3tgDitUxe+Sct5WuJAJh7iw53zx
   gOj6yotnxUJ1AEu3IIDHqTMAbD95d+RsYGj/hhcdX4fES5+sJn3MokOpi
   z109Pudk+cleh1aRCk+3zuUoMjO6lSCZiCO65Kv7BVNRG+lrzZtzgWxax
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Tue, 20 Jun 2023 13:16:00 +0200
Subject: [PATCH v2] genirq: Fix nested thread vs synchronize_hardirq()
 deadlock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230613-genirq-nested-v2-1-fd5114b1e90c@axis.com>
X-B4-Tracking: v=1; b=H4sIAG+KkWQC/3WNQQ6CMBAAv0L27BpaQhVP/sNwaMsCe7CVLiEYw
 t8t3D3OJJPZQCgxCTyKDRItLBxDBn0pwI82DITcZQZd6qo0qsKBAqcJA8lMHRpdG6Wt6W1ZQ26
 cFUKXbPDjUfUxVof+JOp5PTevNvPIMsf0Pa+LOuy/waJQob43nVe1uxnTPO3KcvXxDe2+7z8u8
 RQOwAAAAA==
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a possibility of deadlock if synchronize_hardirq() is called
when the nested threaded interrupt is active.  The following scenario
was observed on a uniprocessor PREEMPT_NONE system:

 Thread 1                      Thread 2

 handle_nested_thread()
  Set INPROGRESS
  Call ->thread_fn()
   thread_fn goes to sleep

                              free_irq()
                               __synchronize_hardirq()
                                Busy-loop forever waiting for INPROGRESS
                                to be cleared

The INPROGRESS flag is only supposed to be used for hard interrupt
handlers.  Remove the incorrect usage in the nested threaded interrupt
case and instead re-use the threads_active / wait_for_threads mechanism
to wait for nested threaded interrupts to complete.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
Changes in v2:
- Reword commit message.
- Refactor and reuse synchronize_irq() instead of ending up open coding
  it.
- Link to v1: https://lore.kernel.org/r/20230613-genirq-nested-v1-1-289dc15b7669@axis.com
---
 kernel/irq/chip.c   |  5 +++--
 kernel/irq/manage.c | 26 +++++++++++++++-----------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 49e7bc871fece..3e4b4c6de8195 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -476,7 +476,7 @@ void handle_nested_irq(unsigned int irq)
 	}
 
 	kstat_incr_irqs_this_cpu(desc);
-	irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS);
+	atomic_inc(&desc->threads_active);
 	raw_spin_unlock_irq(&desc->lock);
 
 	action_ret = IRQ_NONE;
@@ -487,7 +487,8 @@ void handle_nested_irq(unsigned int irq)
 		note_interrupt(desc, action_ret);
 
 	raw_spin_lock_irq(&desc->lock);
-	irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
+	if (atomic_dec_and_test(&desc->threads_active))
+		wake_up(&desc->wait_for_threads);
 
 out_unlock:
 	raw_spin_unlock_irq(&desc->lock);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index d2742af0f0fd8..b38c2c7c5c705 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -108,6 +108,18 @@ bool synchronize_hardirq(unsigned int irq)
 }
 EXPORT_SYMBOL(synchronize_hardirq);
 
+static void __synchronize_irq(struct irq_desc *desc)
+{
+	__synchronize_hardirq(desc, true);
+	/*
+	 * We made sure that no hardirq handler is
+	 * running. Now verify that no threaded handlers are
+	 * active.
+	 */
+	wait_event(desc->wait_for_threads,
+		   !atomic_read(&desc->threads_active));
+}
+
 /**
  *	synchronize_irq - wait for pending IRQ handlers (on other CPUs)
  *	@irq: interrupt number to wait for
@@ -127,16 +139,8 @@ void synchronize_irq(unsigned int irq)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 
-	if (desc) {
-		__synchronize_hardirq(desc, true);
-		/*
-		 * We made sure that no hardirq handler is
-		 * running. Now verify that no threaded handlers are
-		 * active.
-		 */
-		wait_event(desc->wait_for_threads,
-			   !atomic_read(&desc->threads_active));
-	}
+	if (desc)
+		__synchronize_irq(desc);
 }
 EXPORT_SYMBOL(synchronize_irq);
 
@@ -1944,7 +1948,7 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 	 * supports it also make sure that there is no (not yet serviced)
 	 * interrupt in flight at the hardware level.
 	 */
-	__synchronize_hardirq(desc, true);
+	__synchronize_irq(desc);
 
 #ifdef CONFIG_DEBUG_SHIRQ
 	/*

---
base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
change-id: 20230613-genirq-nested-625612a6fa05

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

