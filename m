Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA89669743
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241271AbjAMMfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241244AbjAMMcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1645551D3;
        Fri, 13 Jan 2023 04:31:12 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613070;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZScG3rP7uVfoE13aE9dCeQr5jYORwblUn6nax2uOQMs=;
        b=JsqQPVy8Pkzg6i79GvY1yWIAc0qk4Ozm7KqSJlla/hoTlB7/yzMRgVDu2CazIluvLzVSBe
        s+YRAJIA3mZXS4cogwTThmTpfLlpoFpqkaFNU4rNvcyz4w0zRSAXZnvqlLDySyh5Gf7q+K
        tTDlIG/F/lNpwUGJYDEDijaHXNU43xiiROskTmSnVsbO4ypKai2YpYGe50fynKcA/cDQyE
        FeGuHIe4Gy4EbFTq7DGUtpz6EoUOMFx7WAn1lsmbEuUSMLzrWwXb40FzujyPYlgSeX+aab
        YeStYggeLRBKLoFFMOWg6i2M1TL/PyknJrngietPhIsnnFD/YjJEpki97mU9zQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613070;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZScG3rP7uVfoE13aE9dCeQr5jYORwblUn6nax2uOQMs=;
        b=lQE4Cecwc7EuMYAaxXEUgLnTbw+C22J/PDtCaVJE368QT8o+mGqneE7NA8pH6bdzVRT/mI
        4WLSeWDCZyf/FlBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpuidle, sched: Remove instrumentation from
 TIF_{POLLING_NRFLAG,NEED_RESCHED}
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195540.988741683@infradead.org>
References: <20230112195540.988741683@infradead.org>
MIME-Version: 1.0
Message-ID: <167361306962.4906.12963081149493363429.tip-bot2@tip-bot2>
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

Commit-ID:     e4df1511e1f4bcaa0d590aa7bbffe8bbbd6dfb49
Gitweb:        https://git.kernel.org/tip/e4df1511e1f4bcaa0d590aa7bbffe8bbbd6dfb49
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:43:41 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:48:16 +01:00

cpuidle, sched: Remove instrumentation from TIF_{POLLING_NRFLAG,NEED_RESCHED}

objtool pointed out that various idle-TIF management methods
have instrumentation:

  vmlinux.o: warning: objtool: mwait_idle+0x5: call to current_set_polling_and_test() leaves .noinstr.text section
  vmlinux.o: warning: objtool: acpi_processor_ffh_cstate_enter+0xc5: call to current_set_polling_and_test() leaves .noinstr.text section
  vmlinux.o: warning: objtool: cpu_idle_poll.isra.0+0x73: call to test_ti_thread_flag() leaves .noinstr.text section
  vmlinux.o: warning: objtool: intel_idle+0xbc: call to current_set_polling_and_test() leaves .noinstr.text section
  vmlinux.o: warning: objtool: intel_idle_irq+0xea: call to current_set_polling_and_test() leaves .noinstr.text section
  vmlinux.o: warning: objtool: intel_idle_s2idle+0xb4: call to current_set_polling_and_test() leaves .noinstr.text section

  vmlinux.o: warning: objtool: intel_idle+0xa6: call to current_clr_polling() leaves .noinstr.text section
  vmlinux.o: warning: objtool: intel_idle_irq+0xbf: call to current_clr_polling() leaves .noinstr.text section
  vmlinux.o: warning: objtool: intel_idle_s2idle+0xa1: call to current_clr_polling() leaves .noinstr.text section

  vmlinux.o: warning: objtool: mwait_idle+0xe: call to __current_set_polling() leaves .noinstr.text section
  vmlinux.o: warning: objtool: acpi_processor_ffh_cstate_enter+0xc5: call to __current_set_polling() leaves .noinstr.text section
  vmlinux.o: warning: objtool: cpu_idle_poll.isra.0+0x73: call to test_ti_thread_flag() leaves .noinstr.text section
  vmlinux.o: warning: objtool: intel_idle+0xbc: call to __current_set_polling() leaves .noinstr.text section
  vmlinux.o: warning: objtool: intel_idle_irq+0xea: call to __current_set_polling() leaves .noinstr.text section
  vmlinux.o: warning: objtool: intel_idle_s2idle+0xb4: call to __current_set_polling() leaves .noinstr.text section

  vmlinux.o: warning: objtool: cpu_idle_poll.isra.0+0x73: call to test_ti_thread_flag() leaves .noinstr.text section
  vmlinux.o: warning: objtool: intel_idle_s2idle+0x73: call to test_ti_thread_flag.constprop.0() leaves .noinstr.text section
  vmlinux.o: warning: objtool: intel_idle_irq+0x91: call to test_ti_thread_flag.constprop.0() leaves .noinstr.text section
  vmlinux.o: warning: objtool: intel_idle+0x78: call to test_ti_thread_flag.constprop.0() leaves .noinstr.text section
  vmlinux.o: warning: objtool: acpi_safe_halt+0xf: call to test_ti_thread_flag.constprop.0() leaves .noinstr.text section

Remove the instrumentation, because these methods are used in low-level
cpuidle code moving between states, that should not be instrumented.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230112195540.988741683@infradead.org
---
 include/linux/sched/idle.h  | 40 +++++++++++++++++++++++++++---------
 include/linux/thread_info.h | 18 +++++++++++++++-
 2 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
index d73d314..478084f 100644
--- a/include/linux/sched/idle.h
+++ b/include/linux/sched/idle.h
@@ -23,12 +23,37 @@ static inline void wake_up_if_idle(int cpu) { }
  */
 #ifdef TIF_POLLING_NRFLAG
 
-static inline void __current_set_polling(void)
+#ifdef _ASM_GENERIC_BITOPS_INSTRUMENTED_ATOMIC_H
+
+static __always_inline void __current_set_polling(void)
 {
-	set_thread_flag(TIF_POLLING_NRFLAG);
+	arch_set_bit(TIF_POLLING_NRFLAG,
+		     (unsigned long *)(&current_thread_info()->flags));
 }
 
-static inline bool __must_check current_set_polling_and_test(void)
+static __always_inline void __current_clr_polling(void)
+{
+	arch_clear_bit(TIF_POLLING_NRFLAG,
+		       (unsigned long *)(&current_thread_info()->flags));
+}
+
+#else
+
+static __always_inline void __current_set_polling(void)
+{
+	set_bit(TIF_POLLING_NRFLAG,
+		(unsigned long *)(&current_thread_info()->flags));
+}
+
+static __always_inline void __current_clr_polling(void)
+{
+	clear_bit(TIF_POLLING_NRFLAG,
+		  (unsigned long *)(&current_thread_info()->flags));
+}
+
+#endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_ATOMIC_H */
+
+static __always_inline bool __must_check current_set_polling_and_test(void)
 {
 	__current_set_polling();
 
@@ -41,12 +66,7 @@ static inline bool __must_check current_set_polling_and_test(void)
 	return unlikely(tif_need_resched());
 }
 
-static inline void __current_clr_polling(void)
-{
-	clear_thread_flag(TIF_POLLING_NRFLAG);
-}
-
-static inline bool __must_check current_clr_polling_and_test(void)
+static __always_inline bool __must_check current_clr_polling_and_test(void)
 {
 	__current_clr_polling();
 
@@ -73,7 +93,7 @@ static inline bool __must_check current_clr_polling_and_test(void)
 }
 #endif
 
-static inline void current_clr_polling(void)
+static __always_inline void current_clr_polling(void)
 {
 	__current_clr_polling();
 
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 9f392ec..c026468 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -177,7 +177,23 @@ static __always_inline unsigned long read_ti_thread_flags(struct thread_info *ti
 	clear_ti_thread_flag(task_thread_info(t), TIF_##fl)
 #endif /* !CONFIG_GENERIC_ENTRY */
 
-#define tif_need_resched() test_thread_flag(TIF_NEED_RESCHED)
+#ifdef _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H
+
+static __always_inline bool tif_need_resched(void)
+{
+	return arch_test_bit(TIF_NEED_RESCHED,
+			     (unsigned long *)(&current_thread_info()->flags));
+}
+
+#else
+
+static __always_inline bool tif_need_resched(void)
+{
+	return test_bit(TIF_NEED_RESCHED,
+			(unsigned long *)(&current_thread_info()->flags));
+}
+
+#endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H */
 
 #ifndef CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES
 static inline int arch_within_stack_frames(const void * const stack,
