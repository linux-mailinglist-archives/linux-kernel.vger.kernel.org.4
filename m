Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63E36405D4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbiLBL3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiLBL3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:29:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C27CD3A3A;
        Fri,  2 Dec 2022 03:28:55 -0800 (PST)
Date:   Fri, 02 Dec 2022 11:28:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669980534;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K5ex9nqQicUtIknKSQ+fIyf0Cui4gT0k3HCej5xdGY0=;
        b=kXo7O9Cy5S8Z9750W/dmhVupdZZWqYXX/AoIrRQVWVLnyra6+mzYad9lY+jSkFvmTtJltE
        WEaKWNK+BrCbquMatqMPaoOx7DehZRXqtf450Hjjjb6BuPJ6o9Htk8Hh/xrwa7UuNIUdix
        C/L4vYi4hlbfoSNjyM+A35XIe4Fs9dgPOfjMpA+a2mUhM+FnZcxBe2l7TV3TZ9nzlkeJfE
        xZ1W6KcfO/pyVcq3rPGGU3RemflDi+PRX816j1kNFKf7egxIyC9eR1AYca+3kOqU7AzUXV
        /gPossxuFW8n32totuYeqGsttjfCbAlw98rjm/V1soaoSM5Ok7RHwugEr6Nu1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669980534;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K5ex9nqQicUtIknKSQ+fIyf0Cui4gT0k3HCej5xdGY0=;
        b=4ZXBvnX7F06hA50qa+VcDHu5j/qoOFMxKYzPR93NrNAN4i7ePwunC1ZbiJRh6/2ACDDzeu
        LJI1Z98ByVSlKqDg==
From:   "tip-bot2 for Alexey Izbyshev" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Resend potentially swallowed owner death
 notification
Cc:     Alexey Izbyshev <izbyshev@ispras.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221111215439.248185-1-izbyshev@ispras.ru>
References: <20221111215439.248185-1-izbyshev@ispras.ru>
MIME-Version: 1.0
Message-ID: <166998053282.4906.6953226342195740637.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     90d758896787048fa3d4209309d4800f3920e66f
Gitweb:        https://git.kernel.org/tip/90d758896787048fa3d4209309d4800f3920e66f
Author:        Alexey Izbyshev <izbyshev@ispras.ru>
AuthorDate:    Sat, 12 Nov 2022 00:54:39 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Dec 2022 12:20:24 +01:00

futex: Resend potentially swallowed owner death notification

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
whole futex word is zero, the latter subcase remains unaddressed.

Fix this by looking only at the TID part of the futex when deciding
whether a wake up is needed.

Fixes: ca16d5bee598 ("futex: Prevent robust futex exit race")
Signed-off-by: Alexey Izbyshev <izbyshev@ispras.ru>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20221111215439.248185-1-izbyshev@ispras.ru

---
 kernel/futex/core.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index b22ef1e..514e458 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -638,6 +638,7 @@ static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr,
 			      bool pi, bool pending_op)
 {
 	u32 uval, nval, mval;
+	pid_t owner;
 	int err;
 
 	/* Futex address must be 32bit aligned */
@@ -659,6 +660,10 @@ retry:
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
@@ -667,24 +672,27 @@ retry:
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
