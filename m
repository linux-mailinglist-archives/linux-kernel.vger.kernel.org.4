Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742A5682F19
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjAaOWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjAaOW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:22:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB861D921;
        Tue, 31 Jan 2023 06:22:28 -0800 (PST)
Date:   Tue, 31 Jan 2023 14:22:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675174947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JPOiL8d13pVh7cjK6ZqkyQedTFgedP/wdaFxgHoNMP8=;
        b=T6HUW4VsjQzy6NakQ/7U7DGzPSzgzRWcGM+COW7neHxjFlgf9U1ujLnl/cAsiNhrEMMOyW
        c9z0wJYt4xtVRUInzo1bPwry5vcFcgS60ahWr64F+L7iYXMegw9SIeb6Fe0/EQAMB6p+XE
        5Uvkmq4rN6I9csM6SL1TmpzsRTyjVkiKJUKmKBfxsbXXvFzFCJQPiYYUynRJibFf8nXHra
        cAL+J0eMtBUZAZQoYIpqueRWtV0TXjVkGTNiMBN7Vp4ecFOv+KiQnOVGlABIPNMQt/YtGy
        gSsQSvM9ktUpnlKEDLhlUtCGTKcn+VMT1CWlwhPySEVFORvxIljncxaevLhFWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675174947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JPOiL8d13pVh7cjK6ZqkyQedTFgedP/wdaFxgHoNMP8=;
        b=Jy2ZkTcFo5b85msl2GS4vnQDjdudrXqq5s8wf/qKcwwee3WzMDq6i8oXyCnHxCwEb1hvNH
        tO41tNhJjsKv4kCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/clock: Make local_clock() noinstr
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230126151323.760767043@infradead.org>
References: <20230126151323.760767043@infradead.org>
MIME-Version: 1.0
Message-ID: <167517494685.4906.17448351475328183018.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     776f22913b8e50011004c6ae43004711dab7efa5
Gitweb:        https://git.kernel.org/tip/776f22913b8e50011004c6ae43004711dab7efa5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 26 Jan 2023 16:08:37 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 31 Jan 2023 15:01:47 +01:00

sched/clock: Make local_clock() noinstr

With sched_clock() noinstr, provide a noinstr implementation of
local_clock().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230126151323.760767043@infradead.org
---
 include/linux/sched/clock.h |  8 +++-----
 kernel/sched/clock.c        | 27 +++++++++++++++++++++------
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched/clock.h b/include/linux/sched/clock.h
index 867d588..ca008f7 100644
--- a/include/linux/sched/clock.h
+++ b/include/linux/sched/clock.h
@@ -45,7 +45,7 @@ static inline u64 cpu_clock(int cpu)
 	return sched_clock();
 }
 
-static inline u64 local_clock(void)
+static __always_inline u64 local_clock(void)
 {
 	return sched_clock();
 }
@@ -79,10 +79,8 @@ static inline u64 cpu_clock(int cpu)
 	return sched_clock_cpu(cpu);
 }
 
-static inline u64 local_clock(void)
-{
-	return sched_clock_cpu(raw_smp_processor_id());
-}
+extern u64 local_clock(void);
+
 #endif
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index e374c0c..5732fa7 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -93,7 +93,7 @@ struct sched_clock_data {
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct sched_clock_data, sched_clock_data);
 
-notrace static inline struct sched_clock_data *this_scd(void)
+static __always_inline struct sched_clock_data *this_scd(void)
 {
 	return this_cpu_ptr(&sched_clock_data);
 }
@@ -244,12 +244,12 @@ late_initcall(sched_clock_init_late);
  * min, max except they take wrapping into account
  */
 
-notrace static inline u64 wrap_min(u64 x, u64 y)
+static __always_inline u64 wrap_min(u64 x, u64 y)
 {
 	return (s64)(x - y) < 0 ? x : y;
 }
 
-notrace static inline u64 wrap_max(u64 x, u64 y)
+static __always_inline u64 wrap_max(u64 x, u64 y)
 {
 	return (s64)(x - y) > 0 ? x : y;
 }
@@ -260,7 +260,7 @@ notrace static inline u64 wrap_max(u64 x, u64 y)
  *  - filter out backward motion
  *  - use the GTOD tick value to create a window to filter crazy TSC values
  */
-notrace static u64 sched_clock_local(struct sched_clock_data *scd)
+static __always_inline u64 sched_clock_local(struct sched_clock_data *scd)
 {
 	u64 now, clock, old_clock, min_clock, max_clock, gtod;
 	s64 delta;
@@ -287,13 +287,28 @@ again:
 	clock = wrap_max(clock, min_clock);
 	clock = wrap_min(clock, max_clock);
 
-	if (!try_cmpxchg64(&scd->clock, &old_clock, clock))
+	if (!arch_try_cmpxchg64(&scd->clock, &old_clock, clock))
 		goto again;
 
 	return clock;
 }
 
-notrace static u64 sched_clock_remote(struct sched_clock_data *scd)
+noinstr u64 local_clock(void)
+{
+	u64 clock;
+
+	if (static_branch_likely(&__sched_clock_stable))
+		return sched_clock() + __sched_clock_offset;
+
+	preempt_disable_notrace();
+	clock = sched_clock_local(this_scd());
+	preempt_enable_notrace();
+
+	return clock;
+}
+EXPORT_SYMBOL_GPL(local_clock);
+
+static notrace u64 sched_clock_remote(struct sched_clock_data *scd)
 {
 	struct sched_clock_data *my_scd = this_scd();
 	u64 this_clock, remote_clock;
