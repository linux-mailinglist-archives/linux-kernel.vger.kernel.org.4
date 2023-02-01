Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB52C682F1B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjAaOWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjAaOWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:22:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FA1222D1;
        Tue, 31 Jan 2023 06:22:29 -0800 (PST)
Date:   Tue, 31 Jan 2023 14:22:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675174947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d9aU86yIRrHT4SeqF5L9jK7lUvBot2TGYqlLipevtkA=;
        b=KfoLIlc2rNlG57K6ETARdDp1ly+yybcrfC8BmPi9hUEj5Zf0G6INKR9m1A/bSs7i82tmWw
        t3d5nwHgad0tnzmUXxZRZeweB96zkuIoBTfg4+70dGNEOC+M+tOwpgB/pW9slq7nndD0UN
        yj/QY2WgDc9o6ZAvXAaoByvjOr6soO5221lxw5jsx8bN8l/1op4tHFqMeTa4kg9lK3UG/0
        2H+gZ8L6jziVJ7SzVvtI74ZYfZ+u1/LlgMZSY8ECSxUTV6uZB2KpgSYFfmxbO+UjmYX9FW
        lSJ8r1HK4y+Xhhmgk/F3N0XXKaWUNKNPECXk034/atPuEvDK4AJ3+Q3LoPl7ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675174947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d9aU86yIRrHT4SeqF5L9jK7lUvBot2TGYqlLipevtkA=;
        b=lQu+ofjefPsq2Xg7d2vgTOXFqGUqt9O/9By4WDTjTU43QBNfsYgMw7XcWVu6Y+PUtalaRx
        7wJJdKWYCHu6hODg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/clock/x86: Mark sched_clock() noinstr
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230126151323.702003578@infradead.org>
References: <20230126151323.702003578@infradead.org>
MIME-Version: 1.0
Message-ID: <167517494734.4906.17956886323824650289.tip-bot2@tip-bot2>
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

Commit-ID:     8739c6811572b087decd561f96382087402cc343
Gitweb:        https://git.kernel.org/tip/8739c6811572b087decd561f96382087402cc343
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 26 Jan 2023 16:08:36 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 31 Jan 2023 15:01:47 +01:00

sched/clock/x86: Mark sched_clock() noinstr

In order to use sched_clock() from noinstr code, mark it and all it's
implenentations noinstr.

The whole pvclock thing (used by KVM/Xen) is a bit of a pain,
since it calls out to watchdogs, create a
pvclock_clocksource_read_nowd() variant doesn't do that and can be
noinstr.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230126151323.702003578@infradead.org
---
 arch/x86/include/asm/kvmclock.h |  2 +-
 arch/x86/include/asm/paravirt.h |  2 +-
 arch/x86/include/asm/pvclock.h  |  3 ++-
 arch/x86/kernel/cpu/vmware.c    |  2 +-
 arch/x86/kernel/kvmclock.c      |  6 +++---
 arch/x86/kernel/pvclock.c       | 19 +++++++++++++++----
 arch/x86/kernel/tsc.c           |  7 +++----
 arch/x86/xen/time.c             | 12 ++++++++++--
 include/linux/math64.h          |  4 ++--
 9 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/kvmclock.h b/arch/x86/include/asm/kvmclock.h
index 6c57651..511b350 100644
--- a/arch/x86/include/asm/kvmclock.h
+++ b/arch/x86/include/asm/kvmclock.h
@@ -8,7 +8,7 @@ extern struct clocksource kvm_clock;
 
 DECLARE_PER_CPU(struct pvclock_vsyscall_time_info *, hv_clock_per_cpu);
 
-static inline struct pvclock_vcpu_time_info *this_cpu_pvti(void)
+static __always_inline struct pvclock_vcpu_time_info *this_cpu_pvti(void)
 {
 	return &this_cpu_read(hv_clock_per_cpu)->pvti;
 }
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 86c9d83..cf40e81 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -26,7 +26,7 @@ DECLARE_STATIC_CALL(pv_sched_clock, dummy_sched_clock);
 
 void paravirt_set_sched_clock(u64 (*func)(void));
 
-static inline u64 paravirt_sched_clock(void)
+static __always_inline u64 paravirt_sched_clock(void)
 {
 	return static_call(pv_sched_clock)();
 }
diff --git a/arch/x86/include/asm/pvclock.h b/arch/x86/include/asm/pvclock.h
index 19b695f..0c92db8 100644
--- a/arch/x86/include/asm/pvclock.h
+++ b/arch/x86/include/asm/pvclock.h
@@ -7,6 +7,7 @@
 
 /* some helper functions for xen and kvm pv clock sources */
 u64 pvclock_clocksource_read(struct pvclock_vcpu_time_info *src);
+u64 pvclock_clocksource_read_nowd(struct pvclock_vcpu_time_info *src);
 u8 pvclock_read_flags(struct pvclock_vcpu_time_info *src);
 void pvclock_set_flags(u8 flags);
 unsigned long pvclock_tsc_khz(struct pvclock_vcpu_time_info *src);
@@ -39,7 +40,7 @@ bool pvclock_read_retry(const struct pvclock_vcpu_time_info *src,
  * Scale a 64-bit delta by scaling and multiplying by a 32-bit fraction,
  * yielding a 64-bit result.
  */
-static inline u64 pvclock_scale_delta(u64 delta, u32 mul_frac, int shift)
+static __always_inline u64 pvclock_scale_delta(u64 delta, u32 mul_frac, int shift)
 {
 	u64 product;
 #ifdef __i386__
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 02039ec..11f83d0 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -143,7 +143,7 @@ static __init int parse_no_stealacc(char *arg)
 }
 early_param("no-steal-acc", parse_no_stealacc);
 
-static unsigned long long notrace vmware_sched_clock(void)
+static noinstr u64 vmware_sched_clock(void)
 {
 	unsigned long long ns;
 
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 16333ba..0f35d44 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -71,12 +71,12 @@ static int kvm_set_wallclock(const struct timespec64 *now)
 	return -ENODEV;
 }
 
-static u64 kvm_clock_read(void)
+static noinstr u64 kvm_clock_read(void)
 {
 	u64 ret;
 
 	preempt_disable_notrace();
-	ret = pvclock_clocksource_read(this_cpu_pvti());
+	ret = pvclock_clocksource_read_nowd(this_cpu_pvti());
 	preempt_enable_notrace();
 	return ret;
 }
@@ -86,7 +86,7 @@ static u64 kvm_clock_get_cycles(struct clocksource *cs)
 	return kvm_clock_read();
 }
 
-static u64 kvm_sched_clock_read(void)
+static noinstr u64 kvm_sched_clock_read(void)
 {
 	return kvm_clock_read() - kvm_sched_clock_offset;
 }
diff --git a/arch/x86/kernel/pvclock.c b/arch/x86/kernel/pvclock.c
index 5a2a517..56acf53 100644
--- a/arch/x86/kernel/pvclock.c
+++ b/arch/x86/kernel/pvclock.c
@@ -64,7 +64,8 @@ u8 pvclock_read_flags(struct pvclock_vcpu_time_info *src)
 	return flags & valid_flags;
 }
 
-u64 pvclock_clocksource_read(struct pvclock_vcpu_time_info *src)
+static __always_inline
+u64 __pvclock_clocksource_read(struct pvclock_vcpu_time_info *src, bool dowd)
 {
 	unsigned version;
 	u64 ret;
@@ -77,7 +78,7 @@ u64 pvclock_clocksource_read(struct pvclock_vcpu_time_info *src)
 		flags = src->flags;
 	} while (pvclock_read_retry(src, version));
 
-	if (unlikely((flags & PVCLOCK_GUEST_STOPPED) != 0)) {
+	if (dowd && unlikely((flags & PVCLOCK_GUEST_STOPPED) != 0)) {
 		src->flags &= ~PVCLOCK_GUEST_STOPPED;
 		pvclock_touch_watchdogs();
 	}
@@ -100,15 +101,25 @@ u64 pvclock_clocksource_read(struct pvclock_vcpu_time_info *src)
 	 * updating at the same time, and one of them could be slightly behind,
 	 * making the assumption that last_value always go forward fail to hold.
 	 */
-	last = atomic64_read(&last_value);
+	last = arch_atomic64_read(&last_value);
 	do {
 		if (ret <= last)
 			return last;
-	} while (!atomic64_try_cmpxchg(&last_value, &last, ret));
+	} while (!arch_atomic64_try_cmpxchg(&last_value, &last, ret));
 
 	return ret;
 }
 
+u64 pvclock_clocksource_read(struct pvclock_vcpu_time_info *src)
+{
+	return __pvclock_clocksource_read(src, true);
+}
+
+noinstr u64 pvclock_clocksource_read_nowd(struct pvclock_vcpu_time_info *src)
+{
+	return __pvclock_clocksource_read(src, false);
+}
+
 void pvclock_read_wallclock(struct pvclock_wall_clock *wall_clock,
 			    struct pvclock_vcpu_time_info *vcpu_time,
 			    struct timespec64 *ts)
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index a78e73d..8c33936 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -215,7 +215,7 @@ static void __init cyc2ns_init_secondary_cpus(void)
 /*
  * Scheduler clock - returns current time in nanosec units.
  */
-u64 native_sched_clock(void)
+noinstr u64 native_sched_clock(void)
 {
 	if (static_branch_likely(&__use_tsc)) {
 		u64 tsc_now = rdtsc();
@@ -248,7 +248,7 @@ u64 native_sched_clock_from_tsc(u64 tsc)
 /* We need to define a real function for sched_clock, to override the
    weak default version */
 #ifdef CONFIG_PARAVIRT
-unsigned long long sched_clock(void)
+noinstr u64 sched_clock(void)
 {
 	return paravirt_sched_clock();
 }
@@ -258,8 +258,7 @@ bool using_native_sched_clock(void)
 	return static_call_query(pv_sched_clock) == native_sched_clock;
 }
 #else
-unsigned long long
-sched_clock(void) __attribute__((alias("native_sched_clock")));
+u64 sched_clock(void) __attribute__((alias("native_sched_clock")));
 
 bool using_native_sched_clock(void) { return true; }
 #endif
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 9ef0a5c..6b8836d 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -60,9 +60,17 @@ static u64 xen_clocksource_get_cycles(struct clocksource *cs)
 	return xen_clocksource_read();
 }
 
-static u64 xen_sched_clock(void)
+static noinstr u64 xen_sched_clock(void)
 {
-	return xen_clocksource_read() - xen_sched_clock_offset;
+        struct pvclock_vcpu_time_info *src;
+	u64 ret;
+
+	preempt_disable_notrace();
+	src = &__this_cpu_read(xen_vcpu)->time;
+	ret = pvclock_clocksource_read_nowd(src);
+	ret -= xen_sched_clock_offset;
+	preempt_enable_notrace();
+	return ret;
 }
 
 static void xen_read_wallclock(struct timespec64 *ts)
diff --git a/include/linux/math64.h b/include/linux/math64.h
index 8958f4c..8b9191a 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -161,7 +161,7 @@ static inline u64 mul_u32_u32(u32 a, u32 b)
 #if defined(CONFIG_ARCH_SUPPORTS_INT128) && defined(__SIZEOF_INT128__)
 
 #ifndef mul_u64_u32_shr
-static inline u64 mul_u64_u32_shr(u64 a, u32 mul, unsigned int shift)
+static __always_inline u64 mul_u64_u32_shr(u64 a, u32 mul, unsigned int shift)
 {
 	return (u64)(((unsigned __int128)a * mul) >> shift);
 }
@@ -177,7 +177,7 @@ static inline u64 mul_u64_u64_shr(u64 a, u64 mul, unsigned int shift)
 #else
 
 #ifndef mul_u64_u32_shr
-static inline u64 mul_u64_u32_shr(u64 a, u32 mul, unsigned int shift)
+static __always_inline u64 mul_u64_u32_shr(u64 a, u32 mul, unsigned int shift)
 {
 	u32 ah, al;
 	u64 ret;
