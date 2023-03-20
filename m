Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23256C1020
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjCTLDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjCTLDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:03:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7030D2D142;
        Mon, 20 Mar 2023 03:59:14 -0700 (PDT)
Date:   Mon, 20 Mar 2023 10:59:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679309948;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ybEABlhk2UNVE0tOULvxZHsvT0U8OTx27j31C0m6rnw=;
        b=axNXlj9EPuy4+fxTWTbEMpBrpv0LN5qrxeGR+zuqylVVMHxtpun24SEOk2rf6b891aIiod
        k/AQ8f1onuvs+pd8wna54Grkuw7OFPsuyyfjYa6A1Gvnltdgj6WVMcwKm7s3v3POWgISDu
        qJCyzD0izvevNkqFSqY/o6N0wfiioSQ9sPBvu2Gmomgx21krAqitDAxcsxrKrfjjQtYX+O
        t9WgFpyeGRw0+3TfPyuhUwYGNLZwrh4FfjSn2yPxWg2lH3xOpxekpcXyP4vyoj0pF/S6tx
        jWLjWw4NJAcJLFO5nsz4kae31AhqB19f4VfaKrcZn3guRT5kyWaC0gj+me4awA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679309948;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ybEABlhk2UNVE0tOULvxZHsvT0U8OTx27j31C0m6rnw=;
        b=riKIgSlXleXcx7kUXkrFn8pe801H48vcM9lPXjD2YMqENe4o1Mf4JExQaMZAXmn5j4NiB3
        4y5Y1BWIryrICkCw==
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
Message-ID: <167930994812.5837.18107013512395780738.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     3e2619c4ebba2cab8414c55b131b7a28f628de3b
Gitweb:        https://git.kernel.org/tip/3e2619c4ebba2cab8414c55b131b7a28f628de3b
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Sat, 25 Feb 2023 16:01:36 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 20 Mar 2023 11:57:12 +01:00

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
 include/linux/context_tracking.h | 1 +
 kernel/entry/common.c            | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

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
