Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB22F6CB989
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjC1IfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjC1Ieu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:34:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA9A420A;
        Tue, 28 Mar 2023 01:34:49 -0700 (PDT)
Date:   Tue, 28 Mar 2023 08:34:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679992486;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8m0BjTV4H8QXJz3U7MbSbwIQl4vClbzedXdI0q9vbk0=;
        b=A5Rs7ZlVywkHISCBs2ltP5ZuEGo59QChlukr4iIaaJX1d9T/uqlOQFiIpIjaKLBCyRJ6Op
        1APtDLAf7FyJsz7oqgfsxYbeMALBspyauPXQ0T2ivpRMkL7A+BEJwPJuoWLALGZZ7afU41
        0f0hY7ynX1Ixrra4d8cvQlYeXGU7v4EAp5KF0wih/wnSCwqFilU+cgDlg5WCWRazI72zC5
        pDoC6GSHWJurczQUTXmncQ78E1SheM2Hi4GH5KifQFdhsouTWcoh+pvvLugUHzNhDAKqkH
        FN8trF+9jLbYC5nFbN7T/DBq2dBYQ+ToqY4IRpYwry2oPykK6/DnBSgSfwnSLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679992486;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8m0BjTV4H8QXJz3U7MbSbwIQl4vClbzedXdI0q9vbk0=;
        b=68mO9lTUsCvowwnlL0b2hMymSZLqP9J9P6O3aIUHwg1WEQgsZQXIDF7JesH//x9s22ypRZ
        TxCn3p5D+MSW/DAg==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] irq_work: Trace self-IPIs sent via arch_irq_work_raise()
Cc:     Valentin Schneider <vschneid@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230307143558.294354-5-vschneid@redhat.com>
References: <20230307143558.294354-5-vschneid@redhat.com>
MIME-Version: 1.0
Message-ID: <167999248584.5837.2675247233861998370.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     4468161a5ca2ea239c92de7c0a0dca61854ec4da
Gitweb:        https://git.kernel.org/tip/4468161a5ca2ea239c92de7c0a0dca61854ec4da
Author:        Valentin Schneider <vschneid@redhat.com>
AuthorDate:    Tue, 07 Mar 2023 14:35:55 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 24 Mar 2023 11:01:27 +01:00

irq_work: Trace self-IPIs sent via arch_irq_work_raise()

IPIs sent to remote CPUs via irq_work_queue_on() are now covered by
trace_ipi_send_cpumask(), add another instance of the tracepoint to cover
self-IPIs.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Link: https://lore.kernel.org/r/20230307143558.294354-5-vschneid@redhat.com
---
 kernel/irq_work.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 7afa40f..c33e88e 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -22,6 +22,8 @@
 #include <asm/processor.h>
 #include <linux/kasan.h>
 
+#include <trace/events/ipi.h>
+
 static DEFINE_PER_CPU(struct llist_head, raised_list);
 static DEFINE_PER_CPU(struct llist_head, lazy_list);
 static DEFINE_PER_CPU(struct task_struct *, irq_workd);
@@ -74,6 +76,16 @@ void __weak arch_irq_work_raise(void)
 	 */
 }
 
+static __always_inline void irq_work_raise(struct irq_work *work)
+{
+	if (trace_ipi_send_cpumask_enabled() && arch_irq_work_has_interrupt())
+		trace_ipi_send_cpumask(cpumask_of(smp_processor_id()),
+				       _RET_IP_,
+				       work->func);
+
+	arch_irq_work_raise();
+}
+
 /* Enqueue on current CPU, work must already be claimed and preempt disabled */
 static void __irq_work_queue_local(struct irq_work *work)
 {
@@ -99,7 +111,7 @@ static void __irq_work_queue_local(struct irq_work *work)
 
 	/* If the work is "lazy", handle it from next tick if any */
 	if (!lazy_work || tick_nohz_tick_stopped())
-		arch_irq_work_raise();
+		irq_work_raise(work);
 }
 
 /* Enqueue the irq work @work on the current CPU */
