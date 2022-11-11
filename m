Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C98A62641D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 23:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbiKKWCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 17:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbiKKWCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:02:00 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BC8CE0A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 14:01:55 -0800 (PST)
Received: from vihara.intra.ispras.ru (unknown [10.10.3.38])
        by mail.ispras.ru (Postfix) with ESMTP id 0D90F419E9CE;
        Fri, 11 Nov 2022 22:01:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 0D90F419E9CE
From:   Alexey Izbyshev <izbyshev@ispras.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Yang Tao <yang.tao172@zte.com.cn>
Subject: [PATCH] futex: Resend potentially swallowed owner death notification
Date:   Sat, 12 Nov 2022 00:54:39 +0300
Message-Id: <20221111215439.248185-1-izbyshev@ispras.ru>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ca16d5bee598 ("futex: Prevent robust futex exit race") addressed
two cases when tasks waiting on a robust non-PI futex remained blocked
despite the futex not being owned anymore:

* if the owner died after writing zero to the futex word, but before
  waking up a waiter

* if a task waiting on the futex was woken up, but died before updating
  the futex word (effectively swallowing the notification without acting
  on it)

In the second case, the task could be woken up either by the previous
owner (after the futex word was reset to zero) or by the kernel (after
the OWNER_DIED bit was set and the TID part of the futex word was reset
to zero) if the previous owner died without the resetting the futex.
Because the referenced commit wakes up a potential waiter only if the
whole futex word is zero, the latter subcase remained unaddressed.

Fix this by looking only at the TID part of the futex when deciding
whether a wake up is needed.

Fixes: ca16d5bee598 ("futex: Prevent robust futex exit race")
Signed-off-by: Alexey Izbyshev <izbyshev@ispras.ru>
---
 kernel/futex/core.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index b22ef1efe751..514e4582b863 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -638,6 +638,7 @@ static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr,
 			      bool pi, bool pending_op)
 {
 	u32 uval, nval, mval;
+	pid_t owner;
 	int err;
 
 	/* Futex address must be 32bit aligned */
@@ -659,6 +660,10 @@ static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr,
 	 * 2. A woken up waiter is killed before it can acquire the
 	 *    futex in user space.
 	 *
+	 * In the second case, the wake up notification could be generated
+	 * by the unlock path in user space after setting the futex value
+	 * to zero or by the kernel after setting the OWNER_DIED bit below.
+	 *
 	 * In both cases the TID validation below prevents a wakeup of
 	 * potential waiters which can cause these waiters to block
 	 * forever.
@@ -667,24 +672,27 @@ static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr,
 	 *
 	 *	1) task->robust_list->list_op_pending != NULL
 	 *	   @pending_op == true
-	 *	2) User space futex value == 0
+	 *	2) The owner part of user space futex value == 0
 	 *	3) Regular futex: @pi == false
 	 *
 	 * If these conditions are met, it is safe to attempt waking up a
 	 * potential waiter without touching the user space futex value and
-	 * trying to set the OWNER_DIED bit. The user space futex value is
-	 * uncontended and the rest of the user space mutex state is
-	 * consistent, so a woken waiter will just take over the
-	 * uncontended futex. Setting the OWNER_DIED bit would create
-	 * inconsistent state and malfunction of the user space owner died
-	 * handling.
+	 * trying to set the OWNER_DIED bit. If the futex value is zero,
+	 * the rest of the user space mutex state is consistent, so a woken
+	 * waiter will just take over the uncontended futex. Setting the
+	 * OWNER_DIED bit would create inconsistent state and malfunction
+	 * of the user space owner died handling. Otherwise, the OWNER_DIED
+	 * bit is already set, and the woken waiter is expected to deal with
+	 * this.
 	 */
-	if (pending_op && !pi && !uval) {
+	owner = uval & FUTEX_TID_MASK;
+
+	if (pending_op && !pi && !owner) {
 		futex_wake(uaddr, 1, 1, FUTEX_BITSET_MATCH_ANY);
 		return 0;
 	}
 
-	if ((uval & FUTEX_TID_MASK) != task_pid_vnr(curr))
+	if (owner != task_pid_vnr(curr))
 		return 0;
 
 	/*
-- 
2.37.2

