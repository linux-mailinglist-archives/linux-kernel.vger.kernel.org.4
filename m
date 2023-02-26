Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1696A2CAD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 01:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBZABs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 19:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBZABr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 19:01:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41D813D7B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 16:01:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53D50B80B62
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 00:01:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815CDC433EF;
        Sun, 26 Feb 2023 00:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677369703;
        bh=eWj6PIOaCae4y8z9IQbNFV+J1m/e0EEztX9tQWxRspc=;
        h=From:To:Cc:Subject:Date:From;
        b=tCEOKJ8UPoF6+r0yC5w5nKqYONy5Pz8vioHFiiKzWyx/UNNcfeZPjt5RaCwVfAASk
         LrieXXyp0tu1aQUl3GukQEOS8sBjZH+JBzijTq9HsaUlKeP8VBHWmQgUj3RgWSk2l4
         WOmHctB03WR9K7tYdMh7s0bIjx5pU5q6H4zuAK1teVbMUbOSTAX/q6+pWJHMLkdWuc
         ligk7fbyNj8BTx8J4U+wPunQAV5v3NRAwh90fwiLX4Z/D/NN6YXFgo890TBU2Rp3xa
         RKXqSBm7SWzh1PuvEATRqRU91ks34DUlroq2MPjArSs4dgsBEopXNw4NJiQLizxWwJ
         EXOp+/Xpuk3zQ==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/entry: Fix noinstr warning in __enter_from_user_mode()
Date:   Sat, 25 Feb 2023 16:01:36 -0800
Message-Id: <d8955fa6d68dc955dda19baf13ae014ae27926f5.1677369694.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 include/linux/context_tracking.h | 1 +
 kernel/entry/common.c            | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index d4afa8508a80..3a7909ed5498 100644
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
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 846add8394c4..1314894d2efa 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -21,7 +21,7 @@ static __always_inline void __enter_from_user_mode(struct pt_regs *regs)
 	arch_enter_from_user_mode(regs);
 	lockdep_hardirqs_off(CALLER_ADDR0);
 
-	CT_WARN_ON(ct_state() != CONTEXT_USER);
+	CT_WARN_ON(__ct_state() != CONTEXT_USER);
 	user_exit_irqoff();
 
 	instrumentation_begin();
-- 
2.39.1

