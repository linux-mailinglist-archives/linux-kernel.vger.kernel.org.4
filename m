Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449C85ED719
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbiI1IG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbiI1IGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:06:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA37A1D69;
        Wed, 28 Sep 2022 01:06:54 -0700 (PDT)
Date:   Wed, 28 Sep 2022 08:06:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664352412;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=LhtL89DRlTurUMZxa9IsHASMoyqZvNkFZYmuL+2iZ3E=;
        b=Q/kC2IZKITe7XYFfIPKcVXjMAJGIYZ321RdbxekJQW84jU4dAlwOZaJ7xyZ3psjYcsOXxI
        alPbPwl097OhS70bsl+ENGCW2gNEeM3OYGzjQatGvrzCDxHG5uDgN++btk/M/Tt2xsmybK
        +GvC/0oLUIVywxiDFOVeQCq+NnlEbnPrKWSjoA8bDIywAf2pMcRGSUtVdQ0iX07nKWmeXJ
        jAz4KvobIgtjriafg0zMf5dXeo8FNo0nzLlDkGZ4wMUDhCVh6WTzNyR9/F40AeNlOSNE6J
        ZG6a9+h+rhqbL+V29p5dgDq98Tz4xDCI0NJ5Qg66T0UpBsz6ANxGXUriLHjEVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664352412;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=LhtL89DRlTurUMZxa9IsHASMoyqZvNkFZYmuL+2iZ3E=;
        b=Ym4HRb2rIJ1ywBuxLw7p9ksrCnWbalT229Ye1lQYSyLvXanb3yw/nDCAl2WuD4wJWtLD52
        bzlzAhlQvC1lqeBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fix TASK_state comparisons
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166435241084.401.18105248631464873710.tip-bot2@tip-bot2>
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

Commit-ID:     5aec788aeb8eb74282b75ac1b317beb0fbb69a42
Gitweb:        https://git.kernel.org/tip/5aec788aeb8eb74282b75ac1b317beb0fbb69a42
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 27 Sep 2022 21:02:34 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 28 Sep 2022 10:00:16 +02:00

sched: Fix TASK_state comparisons

Task state is fundamentally a bitmask; direct comparisons are probably
not working as intended. Specifically the normal wait-state have
a number of possible modifiers:

  TASK_UNINTERRUPTIBLE:	TASK_WAKEKILL, TASK_NOLOAD, TASK_FREEZABLE
  TASK_INTERRUPTIBLE:   TASK_FREEZABLE

Specifically, the addition of TASK_FREEZABLE wrecked
__wait_is_interruptible(). This however led to an audit of direct
comparisons yielding the rest of the changes.

Fixes: f5d39b020809 ("freezer,sched: Rewrite core freezer logic")
Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Debugged-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 include/linux/wait.h | 2 +-
 kernel/hung_task.c   | 8 ++++++--
 kernel/sched/core.c  | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 14ad8a0..7f5a51a 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -281,7 +281,7 @@ static inline void wake_up_pollfree(struct wait_queue_head *wq_head)
 
 #define ___wait_is_interruptible(state)						\
 	(!__builtin_constant_p(state) ||					\
-		state == TASK_INTERRUPTIBLE || state == TASK_KILLABLE)		\
+	 (state & (TASK_INTERRUPTIBLE | TASK_WAKEKILL)))
 
 extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
 
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index f1321c0..3a15169 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -191,6 +191,8 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 	hung_task_show_lock = false;
 	rcu_read_lock();
 	for_each_process_thread(g, t) {
+		unsigned int state;
+
 		if (!max_count--)
 			goto unlock;
 		if (time_after(jiffies, last_break + HUNG_TASK_LOCK_BREAK)) {
@@ -198,8 +200,10 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 				goto unlock;
 			last_break = jiffies;
 		}
-		/* use "==" to skip the TASK_KILLABLE tasks waiting on NFS */
-		if (READ_ONCE(t->__state) == TASK_UNINTERRUPTIBLE)
+		/* skip the TASK_KILLABLE tasks -- these can be killed */
+		state = READ_ONCE(t->__state);
+		if ((state & TASK_UNINTERRUPTIBLE) &&
+		    !(state & TASK_WAKEKILL))
 			check_hung_task(t, timeout);
 	}
  unlock:
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4fa4a3d..02dc1b8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8884,7 +8884,7 @@ state_filter_match(unsigned long state_filter, struct task_struct *p)
 	 * When looking for TASK_UNINTERRUPTIBLE skip TASK_IDLE (allows
 	 * TASK_KILLABLE).
 	 */
-	if (state_filter == TASK_UNINTERRUPTIBLE && state == TASK_IDLE)
+	if (state_filter == TASK_UNINTERRUPTIBLE && (state & TASK_NOLOAD))
 		return false;
 
 	return true;
