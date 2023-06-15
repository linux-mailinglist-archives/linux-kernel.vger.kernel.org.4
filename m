Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2300D7319A0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245176AbjFONME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240260AbjFONMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:12:01 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D48123
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1686834721;
  x=1718370721;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=1yRetSLviTkJw1LOdu72QcSIr3UF+ZQAyOZl+ZcLrGw=;
  b=ZxSKT/zqQOPkY4tqgDKw0re/0a44NdD5uTniNS/Sh9fUrwMixAVg3hzg
   1IvC01cGZe4aLXL45HO4vjM1xYtSJOqq7AtM8GXLzLbcw7K9rAKI4gkV2
   pl90d1qUQf4jT30EM8kqshihFY59erZlkvawwl2RaRBgvqz42Qvywm4Ck
   0uxCdgQFfGWHkbftUKwdiFxCgjpWAsz+W2mJVOFyKJJvgat4hF65WmPrB
   CiEu70gDwyGenMpT4LfEWyw8AgqcEZIjFWQDzbh++J2RxzAkUoMM94Ysa
   8n4sqatJYkUTdsHoYMp8ocEMxMVHdCE+l+9hn8r4Mv0onY3JdzAOaStSA
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Thu, 15 Jun 2023 15:11:57 +0200
Subject: [PATCH] genirq: Fix nested thread vs synchronize_hardirq()
 deadlock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230613-genirq-nested-v1-1-289dc15b7669@axis.com>
X-B4-Tracking: v=1; b=H4sIABwOi2QC/x2NywqDQAwAf0VybmAfuIf+SukhalZzybZJKQXx3
 117nIFhdnA2YYf7sIPxV1yadoi3AeaNdGWUpTOkkHIoMePKKvZGZf/wgiWNJSYqlcIIvZnIGSc
 jnberqq3lS7+Mq/z+m8fzOE6cdfTsdgAAAA==
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

Since the purpose of the INPROGRESS flag seems to be for hard IRQ
handlers, remove its usage in the nested threaded interrupt case and
instead re-use the active_threads mechanism to wait for nested threaded
interrupts to complete.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 kernel/irq/chip.c   | 5 +++--
 kernel/irq/manage.c | 4 ++++
 2 files changed, 7 insertions(+), 2 deletions(-)

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
index d2742af0f0fd8..58dcc9df6d72c 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1977,6 +1977,10 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 		}
 	}
 
+	/* Wait for any remaining nested threaded interrupts. */
+	wait_event(desc->wait_for_threads,
+		   !atomic_read(&desc->threads_active));
+
 	/* Last action releases resources */
 	if (!desc->action) {
 		/*

---
base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
change-id: 20230613-genirq-nested-625612a6fa05

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

