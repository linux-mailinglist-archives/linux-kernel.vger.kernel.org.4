Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F377B722F7C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbjFETQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbjFETQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:16:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242EA106;
        Mon,  5 Jun 2023 12:16:18 -0700 (PDT)
Date:   Mon, 05 Jun 2023 19:16:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685992576;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=loUCh3mQ7cd9tnMZzQQVTLxAaBWXXDkTcaTj6SaaSWc=;
        b=1A1sUf/DK+dYMcVeqdxtMmTg4olFzIbCXci5FVoAnjCg4N++wjHU9MdL0ejAhEV7tkknb8
        Bt10svxOvrFPdMV5smeyMa+rSRCFjUOoCCMpVBH1jkaZu7Jrn+SEaHq02KhoXdmHV/r2Uz
        +0Vz/jjW9Z/+yI78euoZojqUVj641CplVeKTRTljraoYwY6349sg+Hfz7Iqkh99vwKOmuG
        aPnF4eDJe9Ak+/o19dC5oDye9KeIRfirzuwvuZCFqgJyBuGkiy6YgxDJLyq74WIqn0Tij3
        knKctEALFu0Ldpqk4n6WddjcgBsSh1kxvxEp3F8VJIFN/e6RgU4CjQ1G7yC9/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685992576;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=loUCh3mQ7cd9tnMZzQQVTLxAaBWXXDkTcaTj6SaaSWc=;
        b=IOufVU2FZqxbeTIqsnA1d9LwDWWJ1cb25k0T+wS/NzbAmcHty0/dhciHpQLhw+lGdaaZoN
        zeg1vSjG1otmsLCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/clock: Provide local_clock_noinstr()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230519102715.978624636@infradead.org>
References: <20230519102715.978624636@infradead.org>
MIME-Version: 1.0
Message-ID: <168599257584.404.17317155359728357563.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fb7d4948c4da2dbd26da4b7ec76bbd2f19ff862a
Gitweb:        https://git.kernel.org/tip/fb7d4948c4da2dbd26da4b7ec76bbd2f19ff862a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 19 May 2023 12:21:10 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 21:11:09 +02:00

sched/clock: Provide local_clock_noinstr()

Now that all ARCH_WANTS_NO_INSTR architectures (arm64, loongarch,
s390, x86) provide sched_clock_noinstr(), use this to provide
local_clock_noinstr().

This local_clock_noinstr() will be safe to use from noinstr code with
the assumption that any such noinstr code is non-preemptible (it had
better be, entry code will have IRQs disabled while __cpuidle must
have preemption disabled).

Specifically, preempt_enable_notrace(), a common part of many a
sched_clock() implementation calls out to schedule() -- even though,
per the above, it will never trigger -- which frustrates noinstr
validation.

  vmlinux.o: warning: objtool: local_clock+0xb5: call to preempt_schedule_notrace_thunk() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>  # Hyper-V
Link: https://lore.kernel.org/r/20230519102715.978624636@infradead.org
---
 include/linux/sched/clock.h | 17 ++++++++++++++++-
 kernel/sched/clock.c        | 19 +++++++++++++------
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched/clock.h b/include/linux/sched/clock.h
index ca008f7..196f0ca 100644
--- a/include/linux/sched/clock.h
+++ b/include/linux/sched/clock.h
@@ -12,7 +12,16 @@
  *
  * Please use one of the three interfaces below.
  */
-extern unsigned long long notrace sched_clock(void);
+extern u64 sched_clock(void);
+
+#if defined(CONFIG_ARCH_WANTS_NO_INSTR) || defined(CONFIG_GENERIC_SCHED_CLOCK)
+extern u64 sched_clock_noinstr(void);
+#else
+static __always_inline u64 sched_clock_noinstr(void)
+{
+	return sched_clock();
+}
+#endif
 
 /*
  * See the comment in kernel/sched/clock.c
@@ -45,6 +54,11 @@ static inline u64 cpu_clock(int cpu)
 	return sched_clock();
 }
 
+static __always_inline u64 local_clock_noinstr(void)
+{
+	return sched_clock_noinstr();
+}
+
 static __always_inline u64 local_clock(void)
 {
 	return sched_clock();
@@ -79,6 +93,7 @@ static inline u64 cpu_clock(int cpu)
 	return sched_clock_cpu(cpu);
 }
 
+extern u64 local_clock_noinstr(void);
 extern u64 local_clock(void);
 
 #endif
diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index b5cc2b5..5a575a0 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -266,7 +266,7 @@ static __always_inline u64 sched_clock_local(struct sched_clock_data *scd)
 	s64 delta;
 
 again:
-	now = sched_clock();
+	now = sched_clock_noinstr();
 	delta = now - scd->tick_raw;
 	if (unlikely(delta < 0))
 		delta = 0;
@@ -293,22 +293,29 @@ again:
 	return clock;
 }
 
-noinstr u64 local_clock(void)
+noinstr u64 local_clock_noinstr(void)
 {
 	u64 clock;
 
 	if (static_branch_likely(&__sched_clock_stable))
-		return sched_clock() + __sched_clock_offset;
+		return sched_clock_noinstr() + __sched_clock_offset;
 
 	if (!static_branch_likely(&sched_clock_running))
-		return sched_clock();
+		return sched_clock_noinstr();
 
-	preempt_disable_notrace();
 	clock = sched_clock_local(this_scd());
-	preempt_enable_notrace();
 
 	return clock;
 }
+
+u64 local_clock(void)
+{
+	u64 now;
+	preempt_disable_notrace();
+	now = local_clock_noinstr();
+	preempt_enable_notrace();
+	return now;
+}
 EXPORT_SYMBOL_GPL(local_clock);
 
 static notrace u64 sched_clock_remote(struct sched_clock_data *scd)
