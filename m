Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC376EE7BD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbjDYStZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbjDYStL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:49:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF0C17A11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:49:06 -0700 (PDT)
Message-ID: <20230425183313.091081515@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682448543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=7wcpMIbw4++5yEH81pAF+D9HvfAN0jWN9VmY7vCAJ2o=;
        b=3SzKiJcI84fHv6hDMwDFKj0dz+kgbttCLXlYgFOecKZJRDmMi0szOZUvy7KBF2j3Lg6yd0
        9KpLFScLvHwdT32fNzlqriqAfZtE+Jgf0SvhRakPY6eiILupjzmzoqtzYCqScnXZVD2UXn
        Rq9aZxTxE282mdxWUDCRtIn0oUaCcSGQf8BdhqVv9l7B5LE4uh7RCapG9WvIWcDv7e0eFS
        JOGPTLFyY304//XVIgQkKhnrPiNcxwri6bPzJpb5050SNcD30D9k0QDLbndUQzexS+UfB4
        PW0BPEg4NXc8LGkCrEneDEnnY12Kq6R6hm8rEzj64wyGX8LIWxsGdqwPSUPGoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682448543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=7wcpMIbw4++5yEH81pAF+D9HvfAN0jWN9VmY7vCAJ2o=;
        b=HU8bN7oO/c3cRXOmyVwL3LsFBo7MIrj2HiMwOpW6jqc7Szcr+61weSetUiD5ShUTjSSpIu
        nv+Jql9+XcLBmpBg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [patch 05/20] posix-timers: Add comments about timer lookup
References: <20230425181827.219128101@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 25 Apr 2023 20:49:03 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document how the timer ID validation in the hash table works.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-timers.c |   39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -505,6 +505,12 @@ static int do_timer_create(clockid_t whi
 		return -EAGAIN;
 
 	spin_lock_init(&new_timer->it_lock);
+
+	/*
+	 * Add the timer to the hash table. The timer is not yet valid
+	 * because new_timer::it_signal is still NULL. The timer id is also
+	 * not yet visible to user space.
+	 */
 	new_timer_id = posix_timer_add(new_timer);
 	if (new_timer_id < 0) {
 		error = new_timer_id;
@@ -550,6 +556,7 @@ static int do_timer_create(clockid_t whi
 		goto out;
 
 	spin_lock_irq(&current->sighand->siglock);
+	/* This makes the timer valid in the hash table */
 	new_timer->it_signal = current->signal;
 	list_add(&new_timer->list, &current->signal->posix_timers);
 	spin_unlock_irq(&current->sighand->siglock);
@@ -596,13 +603,6 @@ COMPAT_SYSCALL_DEFINE3(timer_create, clo
 }
 #endif
 
-/*
- * Locking issues: We need to protect the result of the id look up until
- * we get the timer locked down so it is not deleted under us.  The
- * removal is done under the idr spinlock so we use that here to bridge
- * the find to the timer lock.  To avoid a dead lock, the timer id MUST
- * be release with out holding the timer lock.
- */
 static struct k_itimer *__lock_timer(timer_t timer_id, unsigned long *flags)
 {
 	struct k_itimer *timr;
@@ -614,10 +614,35 @@ static struct k_itimer *__lock_timer(tim
 	if ((unsigned long long)timer_id > INT_MAX)
 		return NULL;
 
+	/*
+	 * The hash lookup and the timers are RCU protected.
+	 *
+	 * Timers are added to the hash in invalid state where
+	 * timr::it_signal == NULL. timer::it_signal is only set after the
+	 * rest of the initialization succeeded.
+	 *
+	 * Timer destruction happens in steps:
+	 *  1) Set timr::it_signal to NULL with timr::it_lock held
+	 *  2) Release timr::it_lock
+	 *  3) Remove from the hash under hash_lock
+	 *  4) Call RCU for removal after the grace period
+	 *
+	 * Holding rcu_read_lock() accross the lookup ensures that
+	 * the timer cannot be freed.
+	 *
+	 * The lookup validates locklessly that timr::it_signal ==
+	 * current::it_signal and timr::it_id == @timer_id. timr::it_id
+	 * can't change, but timr::it_signal becomes NULL during
+	 * destruction.
+	 */
 	rcu_read_lock();
 	timr = posix_timer_by_id(timer_id);
 	if (timr) {
 		spin_lock_irqsave(&timr->it_lock, *flags);
+		/*
+		 * Validate under timr::it_lock that timr::it_signal is
+		 * still valid. Pairs with #1 above.
+		 */
 		if (timr->it_signal == current->signal) {
 			rcu_read_unlock();
 			return timr;

