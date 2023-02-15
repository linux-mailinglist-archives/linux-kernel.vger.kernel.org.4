Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EE76979EF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 11:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjBOKdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 05:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBOKdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 05:33:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD18186;
        Wed, 15 Feb 2023 02:33:06 -0800 (PST)
Date:   Wed, 15 Feb 2023 10:33:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676457184;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QFD08+6x4LcuZWtbybKfkEqklRkLIIXjz6/O5w+ibSE=;
        b=vLtBivGghk2AkZ3XPXI6uar0pc+bpNVfv5VpA60k380s77A4ptIpabGF10g+f5NDMOiFiB
        lVpIw367RtIyeoCzJe0QflvoMKfllxsL2CwJIjypZv6cM5OA/Xar6UiMM07ZCJN9iKdH0n
        AGUheN272AHc5GCBpALWbBWw6+cf9LRcwPKm8KyeFsbGXkGkBOCSDGvlO0BiNSBH67vVXW
        ubqCHrJ0nCOk7WpNPaoY4BnRUU92dM19LQXXsltgJpRX9tkVKMYau7DiwgyP8yaKtIqmYY
        W7J5O2AXiZJOyqvZtATvws8jh2ypmzgp1cRLPYEjuIucdstmDTnhjmsKF8Qu1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676457184;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QFD08+6x4LcuZWtbybKfkEqklRkLIIXjz6/O5w+ibSE=;
        b=XQN9p7bY7Il7/5Tpi6r4R9gsXVgDkXjYzQR0kpEX9jLvQ+reEQt6pVrtlU+LhBYztKiTi4
        CU5UtiAolZIcUaAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] freezer,umh: Fix call_usermode_helper_exec() vs SIGKILL
Cc:     syzbot+6cd18e123583550cf469@syzkaller.appspotmail.com,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Y90ar35uKQoUrLEK@hirez.programming.kicks-ass.net>
References: <Y90ar35uKQoUrLEK@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <167645718365.4906.7791868073788545242.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     eedeb787ebb53de5c5dcf7b7b39d01bf1b0f037d
Gitweb:        https://git.kernel.org/tip/eedeb787ebb53de5c5dcf7b7b39d01bf1b0f037d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 03 Feb 2023 15:31:11 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Feb 2023 16:36:14 +01:00

freezer,umh: Fix call_usermode_helper_exec() vs SIGKILL

Tetsuo-San noted that commit f5d39b020809 ("freezer,sched: Rewrite
core freezer logic") broke call_usermodehelper_exec() for the KILLABLE
case.

Specifically it was missed that the second, unconditional,
wait_for_completion() was not optional and ensures the on-stack
completion is unused before going out-of-scope.

Fixes: f5d39b020809 ("freezer,sched: Rewrite core freezer logic")
Reported-by: syzbot+6cd18e123583550cf469@syzkaller.appspotmail.com
Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Debugged-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/Y90ar35uKQoUrLEK@hirez.programming.kicks-ass.net
---
 kernel/umh.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/umh.c b/kernel/umh.c
index 8506315..fbf872c 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -438,21 +438,27 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
 	if (wait == UMH_NO_WAIT)	/* task has freed sub_info */
 		goto unlock;
 
-	if (wait & UMH_KILLABLE)
-		state |= TASK_KILLABLE;
-
 	if (wait & UMH_FREEZABLE)
 		state |= TASK_FREEZABLE;
 
-	retval = wait_for_completion_state(&done, state);
-	if (!retval)
-		goto wait_done;
-
 	if (wait & UMH_KILLABLE) {
+		retval = wait_for_completion_state(&done, state | TASK_KILLABLE);
+		if (!retval)
+			goto wait_done;
+
 		/* umh_complete() will see NULL and free sub_info */
 		if (xchg(&sub_info->complete, NULL))
 			goto unlock;
+
+		/*
+		 * fallthrough; in case of -ERESTARTSYS now do uninterruptible
+		 * wait_for_completion_state(). Since umh_complete() shall call
+		 * complete() in a moment if xchg() above returned NULL, this
+		 * uninterruptible wait_for_completion_state() will not block
+		 * SIGKILL'ed processes for long.
+		 */
 	}
+	wait_for_completion_state(&done, state);
 
 wait_done:
 	retval = sub_info->retval;
