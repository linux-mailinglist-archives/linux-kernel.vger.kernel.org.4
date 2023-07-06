Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E45749EDE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbjGFOWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbjGFOWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:22:32 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B452519B2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 07:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1688653350;
  x=1720189350;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=1o7aveQWecFPzGtagC4A9kaMPCQ7Zc86x30Gtpg6+KQ=;
  b=VtUD74kc1EjcK6Kae92CNvsgFsdlQabACUfRFxBR08+mCEq+bhXPmR7L
   27J8dDCMSPGM6D68xVdUOizrqPos9j96zzTX0oGYcOi1zWuYN3qUk84Cl
   tBDNiW8I/OLHZeTyM9VRkMGs1HqrLJB3ufat2YWDb1wh/38FEsBi7481z
   clUfMFzFAIKcgiJT7cOA1109/BJVGjmkog4l1Ocyphj+AsZd0YdLi02lU
   SULG0fT2IbS0SP6GKqYLYVmpQYbGVHBlo0JNB0e33b2k9dpWOcSL4vcxB
   ewmXBuz4OkOxUIWUZeGrH1I/wiN+4sj07+nMr0M7FDuIVCDgHdVH6FN8m
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Thu, 6 Jul 2023 16:22:25 +0200
Subject: [PATCH v3] genirq: Fix nested thread vs synchronize_hardirq()
 deadlock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230613-genirq-nested-v3-1-ae58221143eb@axis.com>
X-B4-Tracking: v=1; b=H4sIACDOpmQC/32NvQ7CIBRGX8Uwi+kFQevkexgHfi4tg6DQkJqm7
 y50ctHxfMn5zkIyJo+ZXHYLSVh89jFU4PsdMaMKA1JvKxPWMd5J4HTA4NOLBswTWiqZkMCUdKo
 TpDpaZaQ6qWDGZrkYeZufCZ2ft8ztXnn0eYrpvVULtPVXoAAFys69NSD0Scr+qmafDyY+SDsq7
 K/MquysADhqwL4zX/K6rh/eq351/QAAAA==
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
Changes in v3:
- Do not take spinlock around wake_up(), to fix -rt.
- Reuse wake_threads_waitq().
- Reflow synchronize_irq() after refactoring.
- Link to v2: https://lore.kernel.org/r/20230613-genirq-nested-v2-1-fd5114b1e90c@axis.com

Changes in v2:
- Reword commit message.
- Refactor and reuse synchronize_irq() instead of ending up open coding
  it.
- Link to v1: https://lore.kernel.org/r/20230613-genirq-nested-v1-1-289dc15b7669@axis.com
---
 kernel/irq/chip.c      | 11 ++++-------
 kernel/irq/internals.h |  2 ++
 kernel/irq/manage.c    | 26 ++++++++++++++------------
 3 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 49e7bc871fece..c5d722f1903c9 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -472,11 +472,12 @@ void handle_nested_irq(unsigned int irq)
 	action = desc->action;
 	if (unlikely(!action || irqd_irq_disabled(&desc->irq_data))) {
 		desc->istate |= IRQS_PENDING;
-		goto out_unlock;
+		raw_spin_unlock_irq(&desc->lock);
+		return;
 	}
 
 	kstat_incr_irqs_this_cpu(desc);
-	irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS);
+	atomic_inc(&desc->threads_active);
 	raw_spin_unlock_irq(&desc->lock);
 
 	action_ret = IRQ_NONE;
@@ -486,11 +487,7 @@ void handle_nested_irq(unsigned int irq)
 	if (!irq_settings_no_debug(desc))
 		note_interrupt(desc, action_ret);
 
-	raw_spin_lock_irq(&desc->lock);
-	irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
-
-out_unlock:
-	raw_spin_unlock_irq(&desc->lock);
+	wake_threads_waitq(desc);
 }
 EXPORT_SYMBOL_GPL(handle_nested_irq);
 
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 5fdc0b5575797..f7e2be805b53f 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -116,6 +116,8 @@ int check_irq_resend(struct irq_desc *desc, bool inject);
 bool irq_wait_for_poll(struct irq_desc *desc);
 void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action);
 
+void wake_threads_waitq(struct irq_desc *desc);
+
 #ifdef CONFIG_PROC_FS
 extern void register_irq_proc(unsigned int irq, struct irq_desc *desc);
 extern void unregister_irq_proc(unsigned int irq, struct irq_desc *desc);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index d2742af0f0fd8..d309ba84e08a9 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -108,6 +108,16 @@ bool synchronize_hardirq(unsigned int irq)
 }
 EXPORT_SYMBOL(synchronize_hardirq);
 
+static void __synchronize_irq(struct irq_desc *desc)
+{
+	__synchronize_hardirq(desc, true);
+	/*
+	 * We made sure that no hardirq handler is running. Now verify that no
+	 * threaded handlers are active.
+	 */
+	wait_event(desc->wait_for_threads, !atomic_read(&desc->threads_active));
+}
+
 /**
  *	synchronize_irq - wait for pending IRQ handlers (on other CPUs)
  *	@irq: interrupt number to wait for
@@ -127,16 +137,8 @@ void synchronize_irq(unsigned int irq)
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
 
@@ -1216,7 +1218,7 @@ static irqreturn_t irq_thread_fn(struct irq_desc *desc,
 	return ret;
 }
 
-static void wake_threads_waitq(struct irq_desc *desc)
+void wake_threads_waitq(struct irq_desc *desc)
 {
 	if (atomic_dec_and_test(&desc->threads_active))
 		wake_up(&desc->wait_for_threads);
@@ -1944,7 +1946,7 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
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

