Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E826C2F9C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjCUKzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjCUKzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:55:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95571556B;
        Tue, 21 Mar 2023 03:54:59 -0700 (PDT)
Date:   Tue, 21 Mar 2023 10:54:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679396098;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GjIQ6cqwjUWanLpYa24zwS4pnPehno8Ojf1BeB1SOW0=;
        b=YKEdosmZRNeYmaqYK0fzS2Wnq9eMh4EYMBCyCUbS3Gzzwrskhw8j48gojQBF8B5MIiBPxm
        07IaiqKYIbR3ka8f80Ey2kVJCFz91ydi2NZoM9yHCtSLUDcFn1Agx2B4ymal7OQGniR3jC
        E25pepyQApZdEnrF/9WjKB7cGJE/jqO1PFsUs3RM3b6aW48ieXLW2WhBLtclS/y+Km9fC0
        /zS2Kb7+npOdtvM8OGSL6aLzAJe6ddXjC1GooDukdfEi0X3mJd7a0Wcq/YEdhcZQO8c+TE
        ZoLG6VVhLjJTJOF0AZpFSrPV5+/Z7AKxJ/ARGsTvCkkWMN7yzvfrz29awI096w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679396098;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GjIQ6cqwjUWanLpYa24zwS4pnPehno8Ojf1BeB1SOW0=;
        b=Gxt1B/nmM07316Skxb64BB9AWd4fN2+3AfUu5Wi6gLc9aZxMdFJJLOHdY3WZRgdSbCn8uZ
        aSjhXzKVU/GEKzDQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] entry: Fix noinstr warning in __enter_from_user_mode()
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <d8955fa6d68dc955dda19baf13ae014ae27926f5.1677369694.git.jpoimboe@kernel.org>
References: <d8955fa6d68dc955dda19baf13ae014ae27926f5.1677369694.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <167939609749.5837.2095598522697085146.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     f87d28673b71b35b248231a2086f9404afbb7f28
Gitweb:        https://git.kernel.org/tip/f87d28673b71b35b248231a2086f9404afbb7f28
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Sat, 25 Feb 2023 16:01:36 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 21 Mar 2023 11:53:16 +01:00

entry: Fix noinstr warning in __enter_from_user_mode()

__enter_from_user_mode() is triggering noinstr warnings with
CONFIG_DEBUG_PREEMPT due to its call of preempt_count_add() via
ct_state().

The preemption disable isn't needed as interrupts are already disabled.
And the context_tracking_enabled() check in ct_state() also isn't needed
as that's already being done by the CT_WARN_ON().

Just use __ct_state() instead.

Fixes the following warnings:

  vmlinux.o: warning: objtool: enter_from_user_mode+0xba: call to preempt_count_add() leaves .noinstr.text section
  vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0xf9: call to preempt_count_add() leaves .noinstr.text section
  vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0xc7: call to preempt_count_add() leaves .noinstr.text section
  vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0xba: call to preempt_count_add() leaves .noinstr.text section

Fixes: 171476775d32 ("context_tracking: Convert state to atomic_t")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/d8955fa6d68dc955dda19baf13ae014ae27926f5.1677369694.git.jpoimboe@kernel.org

---
 include/linux/context_tracking.h       | 1 +
 include/linux/context_tracking_state.h | 2 ++
 kernel/entry/common.c                  | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index d4afa85..3a7909e 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -96,6 +96,7 @@ static inline void user_exit_irqoff(void) { }
 static inline int exception_enter(void) { return 0; }
 static inline void exception_exit(enum ctx_state prev_ctx) { }
 static inline int ct_state(void) { return -1; }
+static inline int __ct_state(void) { return -1; }
 static __always_inline bool context_tracking_guest_enter(void) { return false; }
 static inline void context_tracking_guest_exit(void) { }
 #define CT_WARN_ON(cond) do { } while (0)
diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 4a4d56f..fdd537e 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -46,7 +46,9 @@ struct context_tracking {
 
 #ifdef CONFIG_CONTEXT_TRACKING
 DECLARE_PER_CPU(struct context_tracking, context_tracking);
+#endif
 
+#ifdef CONFIG_CONTEXT_TRACKING_USER
 static __always_inline int __ct_state(void)
 {
 	return arch_atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_STATE_MASK;
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 846add8..1314894 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -21,7 +21,7 @@ static __always_inline void __enter_from_user_mode(struct pt_regs *regs)
 	arch_enter_from_user_mode(regs);
 	lockdep_hardirqs_off(CALLER_ADDR0);
 
-	CT_WARN_ON(ct_state() != CONTEXT_USER);
+	CT_WARN_ON(__ct_state() != CONTEXT_USER);
 	user_exit_irqoff();
 
 	instrumentation_begin();
