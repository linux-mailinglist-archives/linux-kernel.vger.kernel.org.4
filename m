Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07134619AB5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiKDO6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiKDO6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:58:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6275C317ED
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:57:59 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667573878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VJsZTf9koJv37AGxRjIxMnvDNnKc+RAv8HmlgWGKkig=;
        b=o0/2YzYr/C5Go2NsXHPKNZJGD+J2HxmJl+Kr/NLzpNWobjibKzEfXWod7WDzTIbEX8BLhj
        5hPmG++t7DcmlxmGkVzOKwT5aXSaM5j+BwzcLZ1/hLvYzfcMq3in9p4VMNXTfvMfH2yRRg
        xnyiksuALIrSMX1z0jwfJU1gykJlRTHX3qxCKdpH6I7OKMin+UVrVjukJnOskvf+9xHa4W
        MBwGfHXN2uw0LYv1tYT75/tvYh63ffHCrwR0mgXvC57DTX7i91WlNx8XTlh4S487iPSODy
        KwKPEGZn5vB+geOzDHyW3OfCEErhOEJ1SeEX29wmNCV2QvDdZ2SVvCEgCjMFrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667573878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VJsZTf9koJv37AGxRjIxMnvDNnKc+RAv8HmlgWGKkig=;
        b=Vj6IDZ1QZdyOaQNVKe/daLQVKtBKVcMoIZ7FfaXD0S387W6BRXx7Bu36atSulSuCOu3jzk
        RawRexfhN0phzmDw==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v4 10/16] timer: Add get next timer interrupt functionality for remote CPUs
Date:   Fri,  4 Nov 2022 15:57:31 +0100
Message-Id: <20221104145737.71236-11-anna-maria@linutronix.de>
In-Reply-To: <20221104145737.71236-1-anna-maria@linutronix.de>
References: <20221104145737.71236-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare for the conversion of the NOHZ timer placement to a pull at
expiry time model it's required to have functionality available getting the
next timer interrupt on a remote CPU.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/tick-internal.h |  3 +++
 kernel/time/timer.c         | 41 +++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 6f5f164506d5..7b65abc9d803 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -170,6 +170,9 @@ DECLARE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases);
 
 extern void forward_and_idle_timer_bases(unsigned long basej, u64 basem,
 					 struct timer_events *tevt);
+extern void get_next_timer_interrupt_remote(unsigned long basej, u64 basem,
+					    struct timer_events *tevt,
+					    unsigned int cpu);
 void timer_clear_idle(void);
 
 #define CLOCK_SET_WALL							\
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 853089febf83..1b82661f6172 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1759,6 +1759,47 @@ static void forward_base_clk(struct timer_base *base, unsigned long nextevt,
 	}
 }
 
+/**
+ * get_next_timer_interrupt_remote
+ * @basej:	base time jiffies
+ * @basem:	base time clock monotonic
+ * @tevt:	Pointer to the storage for the expiry values
+ * @cpu:	Remote CPU
+ *
+ * Stores the next pending local and global timer expiry values in the
+ * struct pointed to by @tevt. If a queue is empty the corresponding
+ * field is set to KTIME_MAX. If local event expires before global
+ * event, global event is set to KTIME_MAX as well.
+ */
+void get_next_timer_interrupt_remote(unsigned long basej, u64 basem,
+				     struct timer_events *tevt,
+				     unsigned int cpu)
+{
+	struct timer_base *base_local, *base_global;
+	unsigned long flags;
+
+	/* Preset local / global events */
+	tevt->local = tevt->global = KTIME_MAX;
+
+	/*
+	 * Pretend that there is no timer pending if the cpu is offline.
+	 * Possible pending timers will be migrated later to an active cpu.
+	 */
+	if (cpu_is_offline(cpu))
+		return;
+
+	base_local = per_cpu_ptr(&timer_bases[BASE_LOCAL], cpu);
+	base_global = per_cpu_ptr(&timer_bases[BASE_GLOBAL], cpu);
+
+	raw_spin_lock_irqsave(&base_local->lock, flags);
+	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
+
+	get_next_timer_interrupt(base_local, base_global, basej, basem, tevt);
+
+	raw_spin_unlock(&base_global->lock);
+	raw_spin_unlock_irqrestore(&base_local->lock, flags);
+}
+
 /**
  * forward_and_idle_timer_bases
  * @basej:	base time jiffies
-- 
2.30.2

