Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCD6732FD2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345691AbjFPLZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344732AbjFPLZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:25:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7194F1BD6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:25:28 -0700 (PDT)
Date:   Fri, 16 Jun 2023 11:25:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686914726;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GBW/u5jteEzbS+iks2mQBApirya2z8cfSr+rX0ycXmE=;
        b=LLv03VulAYgbP8jhAqoulqlIaatUil++yOvfNWT/eg/3TrPnq8PBwUZRj5srN5RKt17fvH
        6PbQfBG/Xhmzai29vTccxHpUT4zPdoyZBKmRWRab1GyIQVemD5ethLV5fkVCzc69INeO0F
        4GZTC2r9PpqHK2mkyE2WVJLgdj+UyFnCX4RRfBrWDtmsfOz5MSwHsFP8aW+okoVrIueTQ7
        TEGxFDDp3XmMKSrsPx+1OzYuEf9It5QokWz2yc5G9E6GHBGUD8go3lWEsXNHo9Gmk+ANjQ
        h3GI97D6jqSQdLKTc4cl43wbvCnvfnzQEvvBMiDmd9JCs/NNQcKywuYYfP6Mgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686914726;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GBW/u5jteEzbS+iks2mQBApirya2z8cfSr+rX0ycXmE=;
        b=nDg4oJltsNCP1JuHHEd5W6Q6RfMAonwFB71YT7UxA7KMdw3ySzpBHKMiy5K6bsRAoaoGf1
        4ikML+Mo7w2wGdCQ==
From:   "irqchip-bot for James Gowans" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq: Allow fasteoi handler to resend
 interrupts on concurrent handling
Cc:     Marc Zyngier <maz@kernel.org>, James Gowans <jgowans@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        KarimAllah Raslan <karahmed@amazon.com>,
        Yipeng Zou <zouyipeng@huawei.com>,
        Zhang Jianhua <chris.zjh@huawei.com>
In-Reply-To: <20230608120021.3273400-3-jgowans@amazon.com>
References: <20230608120021.3273400-3-jgowans@amazon.com>
MIME-Version: 1.0
Message-ID: <168691472548.404.9894845741875593434.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     9c15eeb5362c48dd27d51bd72e8873341fa9383c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/9c15eeb5362c48dd27d51bd72e8873341fa9383c
Author:        James Gowans <jgowans@amazon.com>
AuthorDate:    Thu, 08 Jun 2023 14:00:20 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 16 Jun 2023 12:22:35 +01:00

genirq: Allow fasteoi handler to resend interrupts on concurrent handling

There is a class of interrupt controllers out there that, once they
have signalled a given interrupt number, will still signal incoming
instances of the *same* interrupt despite the original interrupt
not having been EOIed yet.

As long as the new interrupt reaches the *same* CPU, nothing bad
happens, as that CPU still has its interrupts globally disabled,
and we will only take the new interrupt once the interrupt has
been EOIed.

However, things become more "interesting" if an affinity change comes
in while the interrupt is being handled. More specifically, while
the per-irq lock is being dropped. This results in the affinity change
taking place immediately. At this point, there is nothing that prevents
the interrupt from firing on the new target CPU. We end-up with the
interrupt running concurrently on two CPUs, which isn't a good thing.

And that's where things become worse: the new CPU notices that the
interrupt handling is in progress (irq_may_run() return false), and
*drops the interrupt on the floor*.

The whole race looks like this:

           CPU 0             |          CPU 1
-----------------------------|-----------------------------
interrupt start              |
  handle_fasteoi_irq         | set_affinity(CPU 1)
    handler                  |
    ...                      | interrupt start
    ...                      |   handle_fasteoi_irq -> early out
  handle_fasteoi_irq return  | interrupt end
interrupt end                |

If the interrupt was an edge, too bad. The interrupt is lost, and
the system will eventually die one way or another. Not great.

A way to avoid this situation is to detect this problem at the point
we handle the interrupt on the new target. Instead of dropping the
interrupt, use the resend mechanism to force it to be replayed.

Also, in order to limit the impact of this workaround to the pathetic
architectures that require it, gate it behind a new irq flag aptly
named IRQD_RESEND_WHEN_IN_PROGRESS.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: James Gowans <jgowans@amazon.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: KarimAllah Raslan <karahmed@amazon.com>
Cc: Yipeng Zou <zouyipeng@huawei.com>
Cc: Zhang Jianhua <chris.zjh@huawei.com>
[maz: reworded commit mesage]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230608120021.3273400-3-jgowans@amazon.com
---
 include/linux/irq.h  | 13 +++++++++++++
 kernel/irq/chip.c    | 16 +++++++++++++++-
 kernel/irq/debugfs.c |  2 ++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index d9c86db..d8a6fdc 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -223,6 +223,8 @@ struct irq_data {
  *				  irq_chip::irq_set_affinity() when deactivated.
  * IRQD_IRQ_ENABLED_ON_SUSPEND	- Interrupt is enabled on suspend by irq pm if
  *				  irqchip have flag IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND set.
+ * IRQD_RESEND_WHEN_IN_PROGRESS	- Interrupt may fire when already in progress in which
+ *				  case it must be resent at the next available opportunity.
  */
 enum {
 	IRQD_TRIGGER_MASK		= 0xf,
@@ -249,6 +251,7 @@ enum {
 	IRQD_HANDLE_ENFORCE_IRQCTX	= BIT(28),
 	IRQD_AFFINITY_ON_ACTIVATE	= BIT(29),
 	IRQD_IRQ_ENABLED_ON_SUSPEND	= BIT(30),
+	IRQD_RESEND_WHEN_IN_PROGRESS    = BIT(31),
 };
 
 #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
@@ -448,6 +451,16 @@ static inline bool irqd_affinity_on_activate(struct irq_data *d)
 	return __irqd_to_state(d) & IRQD_AFFINITY_ON_ACTIVATE;
 }
 
+static inline void irqd_set_resend_when_in_progress(struct irq_data *d)
+{
+	__irqd_to_state(d) |= IRQD_RESEND_WHEN_IN_PROGRESS;
+}
+
+static inline bool irqd_needs_resend_when_in_progress(struct irq_data *d)
+{
+	return __irqd_to_state(d) & IRQD_RESEND_WHEN_IN_PROGRESS;
+}
+
 #undef __irqd_to_state
 
 static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 49e7bc8..57cd8f4 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -692,8 +692,16 @@ void handle_fasteoi_irq(struct irq_desc *desc)
 
 	raw_spin_lock(&desc->lock);
 
-	if (!irq_may_run(desc))
+	/*
+	 * When an affinity change races with IRQ handling, the next interrupt
+	 * can arrive on the new CPU before the original CPU has completed
+	 * handling the previous one - it may need to be resent.
+	 */
+	if (!irq_may_run(desc)) {
+		if (irqd_needs_resend_when_in_progress(&desc->irq_data))
+			desc->istate |= IRQS_PENDING;
 		goto out;
+	}
 
 	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
 
@@ -715,6 +723,12 @@ void handle_fasteoi_irq(struct irq_desc *desc)
 
 	cond_unmask_eoi_irq(desc, chip);
 
+	/*
+	 * When the race described above happens this will resend the interrupt.
+	 */
+	if (unlikely(desc->istate & IRQS_PENDING))
+		check_irq_resend(desc, false);
+
 	raw_spin_unlock(&desc->lock);
 	return;
 out:
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index bbcaac6..5971a66 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -133,6 +133,8 @@ static const struct irq_bit_descr irqdata_states[] = {
 	BIT_MASK_DESCR(IRQD_HANDLE_ENFORCE_IRQCTX),
 
 	BIT_MASK_DESCR(IRQD_IRQ_ENABLED_ON_SUSPEND),
+
+	BIT_MASK_DESCR(IRQD_RESEND_WHEN_IN_PROGRESS),
 };
 
 static const struct irq_bit_descr irqdesc_states[] = {
