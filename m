Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C0367657F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 10:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjAUJt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 04:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjAUJtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 04:49:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754205C0FD;
        Sat, 21 Jan 2023 01:49:38 -0800 (PST)
Date:   Sat, 21 Jan 2023 09:49:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674294577;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IbbhcF8jjbhatiPNBh3NGG62KRGU4zaxGafUDJYl9Xo=;
        b=3qdi+WCe7F+binSuegDbdFWwtU6R5n49zTlkJ4OQI9qZbjLigiIBGhaDb8eT/hYKFtOHqt
        096KIQXmTYg9Lqu+Hxt5rU76EC8cwRXHzfNRZL930XMIB4x6oSFINqYdHXN6aJ2QJx5Ym/
        zTDQz5WezMTe2VrEnnR1A1uv/xdN2Ii4ZQC8BauktC/lEbr5lglMQthvFW3+npnNm9J86S
        R8t5iItd7KxDvmoURglFWukbl2ZK+A1ATS10DhV5CgtWThWJmlZOausUUfdCGCFoI0Bzmt
        Vs4KiWlNTeu4xJ/fNU8HXb76XoZMW+eXCX5pvMa341U28VDvyDYRzvbZDmIp4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674294577;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IbbhcF8jjbhatiPNBh3NGG62KRGU4zaxGafUDJYl9Xo=;
        b=rty5S76/5R5b00dXHLgRjXA43kXY9IMoRjtQNj+Q+YSpFzPtq9ywb2RGjAeR07Z23bifWb
        SDZbxU5AE7tSkfBg==
From:   "tip-bot2 for Nicholas Piggin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] exit: Detect and fix irq disabled state in oops
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167429457670.4906.17321070796908774567.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     001c28e57187570e4b5aa4492c7a957fb6d65d7b
Gitweb:        https://git.kernel.org/tip/001c28e57187570e4b5aa4492c7a957fb6d65d7b
Author:        Nicholas Piggin <npiggin@gmail.com>
AuthorDate:    Fri, 20 Jan 2023 11:18:20 +10:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 21 Jan 2023 00:06:10 +01:00

exit: Detect and fix irq disabled state in oops

If a task oopses with irqs disabled, this can cause various cascading
problems in the oops path such as sleep-from-invalid warnings, and
potentially worse.

Since commit 0258b5fd7c712 ("coredump: Limit coredumps to a single
thread group"), the unconditional irq enable in coredump_task_exit()
will "fix" the irq state to be enabled early in do_exit(), so currently
this may not be triggerable, but that is coincidental and fragile.

Detect and fix the irqs_disabled() condition in the oops path before
calling do_exit(), similarly to the way in_atomic() is handled.

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Link: https://lore.kernel.org/lkml/20221004094401.708299-1-npiggin@gmail.com/
---
 kernel/exit.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/exit.c b/kernel/exit.c
index 15dc2ec..bccfa42 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -807,6 +807,8 @@ void __noreturn do_exit(long code)
 	struct task_struct *tsk = current;
 	int group_dead;
 
+	WARN_ON(irqs_disabled());
+
 	synchronize_group_exit(tsk, code);
 
 	WARN_ON(tsk->plug);
@@ -938,6 +940,11 @@ void __noreturn make_task_dead(int signr)
 	if (unlikely(!tsk->pid))
 		panic("Attempted to kill the idle task!");
 
+	if (unlikely(irqs_disabled())) {
+		pr_info("note: %s[%d] exited with irqs disabled\n",
+			current->comm, task_pid_nr(current));
+		local_irq_enable();
+	}
 	if (unlikely(in_atomic())) {
 		pr_info("note: %s[%d] exited with preempt_count %d\n",
 			current->comm, task_pid_nr(current),
