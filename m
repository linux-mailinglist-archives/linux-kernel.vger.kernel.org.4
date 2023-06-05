Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047A7722F82
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbjFETQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbjFETQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:16:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C8C109;
        Mon,  5 Jun 2023 12:16:18 -0700 (PDT)
Date:   Mon, 05 Jun 2023 19:16:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685992576;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YS7puzy0F12PrihIN3ZXJfwGTwkSXPTPP9QLsT1w4Xo=;
        b=HCZYpTQaIRv87id4XWJ7/Nc2RiFuSbFFjS/ewDo8EBmJMTpAZIZwZrpb5Z6NjBwnbmrksP
        ZnB8WsxgOG85PWcGNs278o66cv6/HR64Zkq3FfjcEC1Teh5osNlO+OmQk+bo216Ot89FyX
        +0Oj2UkVqJNEhyk0MWteHxRdJ2NrlmnRt9zXVomx9WnVIauZr4v/xkg+v8T/uvXfnbujRe
        y7H7ww7I5z5MY4cCzclDBoU6iDRv1vyJ8GrlqdYn78O5lDfJLaaz7Z6jl5F0OMFyGFQukw
        hOqHxI4dSij0LfZ8ZUd1WiMqDI5yJtTBCIa8f+JuTETMz7mUZaXQq+2kpsnq3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685992576;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YS7puzy0F12PrihIN3ZXJfwGTwkSXPTPP9QLsT1w4Xo=;
        b=2EvkrWzUbvn1X750HydIK1DU4jfxinvfYshYAlrl76rZZpPJC4Nm90i6Fev8PvImZT3E7d
        Pe5o3nT3P7BNRjDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86/tsc: Provide sched_clock_noinstr()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230519102715.910937674@infradead.org>
References: <20230519102715.910937674@infradead.org>
MIME-Version: 1.0
Message-ID: <168599257618.404.5379549502996624214.tip-bot2@tip-bot2>
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

Commit-ID:     5c5e9a2b25b6a79d4b7a5f2a54d02ef1c36dc35a
Gitweb:        https://git.kernel.org/tip/5c5e9a2b25b6a79d4b7a5f2a54d02ef1c36dc35a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 19 May 2023 12:21:09 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 21:11:08 +02:00

x86/tsc: Provide sched_clock_noinstr()

With the intent to provide local_clock_noinstr(), a variant of
local_clock() that's safe to be called from noinstr code (with the
assumption that any such code will already be non-preemptible),
prepare for things by providing a noinstr sched_clock_noinstr()
function.

Specifically, preempt_enable_*() calls out to schedule(), which upsets
noinstr validation efforts.

  vmlinux.o: warning: objtool: native_sched_clock+0x96: call to preempt_schedule_notrace_thunk() leaves .noinstr.text section
  vmlinux.o: warning: objtool: kvm_clock_read+0x22: call to preempt_schedule_notrace_thunk() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>  # Hyper-V
Link: https://lore.kernel.org/r/20230519102715.910937674@infradead.org
---
 arch/x86/kernel/kvmclock.c |  4 ++--
 arch/x86/kernel/tsc.c      | 38 ++++++++++++++++++++++++++++---------
 arch/x86/xen/time.c        |  3 +--
 3 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 0f35d44..fb8f521 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -71,7 +71,7 @@ static int kvm_set_wallclock(const struct timespec64 *now)
 	return -ENODEV;
 }
 
-static noinstr u64 kvm_clock_read(void)
+static u64 kvm_clock_read(void)
 {
 	u64 ret;
 
@@ -88,7 +88,7 @@ static u64 kvm_clock_get_cycles(struct clocksource *cs)
 
 static noinstr u64 kvm_sched_clock_read(void)
 {
-	return kvm_clock_read() - kvm_sched_clock_offset;
+	return pvclock_clocksource_read_nowd(this_cpu_pvti()) - kvm_sched_clock_offset;
 }
 
 static inline void kvm_sched_clock_init(bool stable)
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 3446988..782a90e 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -69,12 +69,10 @@ static int __init tsc_early_khz_setup(char *buf)
 }
 early_param("tsc_early_khz", tsc_early_khz_setup);
 
-__always_inline void cyc2ns_read_begin(struct cyc2ns_data *data)
+__always_inline void __cyc2ns_read(struct cyc2ns_data *data)
 {
 	int seq, idx;
 
-	preempt_disable_notrace();
-
 	do {
 		seq = this_cpu_read(cyc2ns.seq.seqcount.sequence);
 		idx = seq & 1;
@@ -86,6 +84,12 @@ __always_inline void cyc2ns_read_begin(struct cyc2ns_data *data)
 	} while (unlikely(seq != this_cpu_read(cyc2ns.seq.seqcount.sequence)));
 }
 
+__always_inline void cyc2ns_read_begin(struct cyc2ns_data *data)
+{
+	preempt_disable_notrace();
+	__cyc2ns_read(data);
+}
+
 __always_inline void cyc2ns_read_end(void)
 {
 	preempt_enable_notrace();
@@ -115,18 +119,25 @@ __always_inline void cyc2ns_read_end(void)
  *                      -johnstul@us.ibm.com "math is hard, lets go shopping!"
  */
 
-static __always_inline unsigned long long cycles_2_ns(unsigned long long cyc)
+static __always_inline unsigned long long __cycles_2_ns(unsigned long long cyc)
 {
 	struct cyc2ns_data data;
 	unsigned long long ns;
 
-	cyc2ns_read_begin(&data);
+	__cyc2ns_read(&data);
 
 	ns = data.cyc2ns_offset;
 	ns += mul_u64_u32_shr(cyc, data.cyc2ns_mul, data.cyc2ns_shift);
 
-	cyc2ns_read_end();
+	return ns;
+}
 
+static __always_inline unsigned long long cycles_2_ns(unsigned long long cyc)
+{
+	unsigned long long ns;
+	preempt_disable_notrace();
+	ns = __cycles_2_ns(cyc);
+	preempt_enable_notrace();
 	return ns;
 }
 
@@ -223,7 +234,7 @@ noinstr u64 native_sched_clock(void)
 		u64 tsc_now = rdtsc();
 
 		/* return the value in ns */
-		return cycles_2_ns(tsc_now);
+		return __cycles_2_ns(tsc_now);
 	}
 
 	/*
@@ -250,7 +261,7 @@ u64 native_sched_clock_from_tsc(u64 tsc)
 /* We need to define a real function for sched_clock, to override the
    weak default version */
 #ifdef CONFIG_PARAVIRT
-noinstr u64 sched_clock(void)
+noinstr u64 sched_clock_noinstr(void)
 {
 	return paravirt_sched_clock();
 }
@@ -260,11 +271,20 @@ bool using_native_sched_clock(void)
 	return static_call_query(pv_sched_clock) == native_sched_clock;
 }
 #else
-u64 sched_clock(void) __attribute__((alias("native_sched_clock")));
+u64 sched_clock_noinstr(void) __attribute__((alias("native_sched_clock")));
 
 bool using_native_sched_clock(void) { return true; }
 #endif
 
+notrace u64 sched_clock(void)
+{
+	u64 now;
+	preempt_disable_notrace();
+	now = sched_clock_noinstr();
+	preempt_enable_notrace();
+	return now;
+}
+
 int check_tsc_unstable(void)
 {
 	return tsc_unstable;
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index b74ac25..52fa560 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -66,11 +66,10 @@ static noinstr u64 xen_sched_clock(void)
         struct pvclock_vcpu_time_info *src;
 	u64 ret;
 
-	preempt_disable_notrace();
 	src = &__this_cpu_read(xen_vcpu)->time;
 	ret = pvclock_clocksource_read_nowd(src);
 	ret -= xen_sched_clock_offset;
-	preempt_enable_notrace();
+
 	return ret;
 }
 
