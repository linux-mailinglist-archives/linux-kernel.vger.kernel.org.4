Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465B96EE7BB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjDYStg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbjDYStM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:49:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9138E146CC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:49:11 -0700 (PDT)
Message-ID: <20230425183313.301432503@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682448550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=vtZji4fDdqL5JPXz+mZaSdd3HdqHgzTa/nenoaE7+wY=;
        b=MCl8sE1w2k63JlbLaZM3ljMGdbOyP8lh1xDJyAF9pKAUQ5tAH2q8NZVtrGyxEfxpKz3E7Z
        Ki89MTtfkQiGWSGP9J8/ysV723hlhZj1ofjPVPQ/xyzWTTlCFdJMXqlK5Io8GSy7P2jv5X
        HjC4PS1LOYB5H+0yqHNji+/C2Er8zFC4ZgzfQ8tDCW1IgCs4PbYOrXnOfLAM1ekpTzLnbD
        oVeGDLLwxctwm9+Cg50JqI01ILVTWRRlnoSUi1CytwKdt056mRCVweTQhRMf128hlnW+oI
        K+kENoBynan5rUsnfSdbEGNedUCj3RLI0JzicbOaPaqBuChhFeu9NsonXw+/7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682448550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=vtZji4fDdqL5JPXz+mZaSdd3HdqHgzTa/nenoaE7+wY=;
        b=ZSnJfceYpYgrPMsvVSjfSiZEzahyr073dsjTO3qxPWbU0DqMsMFDGv2Bf9ppE4JRQC3XP6
        ondNULoZGLnERuBg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [patch 09/20] posix-timers: Split release_posix_timers()
References: <20230425181827.219128101@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 25 Apr 2023 20:49:09 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

release_posix_timers() is called for cleaning up both hashed and unhashed
timers. The cases are differentiated by an argument and the usage is
hideous.

Seperate the actual free path out and use it for unhashed timers. Provide a
function for hashed timers.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-timers.c |   31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -465,20 +465,21 @@ static void k_itimer_rcu_free(struct rcu
 	kmem_cache_free(posix_timers_cache, tmr);
 }
 
-#define IT_ID_SET	1
-#define IT_ID_NOT_SET	0
-static void release_posix_timer(struct k_itimer *tmr, int it_id_set)
-{
-	if (it_id_set) {
-		spin_lock(&hash_lock, flags);
-		hlist_del_rcu(&tmr->t_hash);
-		spin_unlock(&hash_lock, flags);
-	}
+static void posix_timer_free(struct k_itimer *tmr)
+{
 	put_pid(tmr->it_pid);
 	sigqueue_free(tmr->sigq);
 	call_rcu(&tmr->rcu, k_itimer_rcu_free);
 }
 
+static void posix_timer_unhash_and_free(struct k_itimer *tmr)
+{
+	spin_lock(&hash_lock);
+	hlist_del_rcu(&tmr->t_hash);
+	spin_unlock(&hash_lock);
+	posix_timer_free(tmr);
+}
+
 static int common_timer_create(struct k_itimer *new_timer)
 {
 	hrtimer_init(&new_timer->it.real.timer, new_timer->it_clock, 0);
@@ -492,7 +493,6 @@ static int do_timer_create(clockid_t whi
 	const struct k_clock *kc = clockid_to_kclock(which_clock);
 	struct k_itimer *new_timer;
 	int error, new_timer_id;
-	int it_id_set = IT_ID_NOT_SET;
 
 	if (!kc)
 		return -EINVAL;
@@ -512,11 +512,10 @@ static int do_timer_create(clockid_t whi
 	 */
 	new_timer_id = posix_timer_add(new_timer);
 	if (new_timer_id < 0) {
-		error = new_timer_id;
-		goto out;
+		posix_timer_free(new_timer);
+		return new_timer_id;
 	}
 
-	it_id_set = IT_ID_SET;
 	new_timer->it_id = (timer_t) new_timer_id;
 	new_timer->it_clock = which_clock;
 	new_timer->kclock = kc;
@@ -568,7 +567,7 @@ static int do_timer_create(clockid_t whi
 	 * new_timer after the unlock call.
 	 */
 out:
-	release_posix_timer(new_timer, it_id_set);
+	posix_timer_unhash_and_free(new_timer);
 	return error;
 }
 
@@ -1056,7 +1055,7 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
 	WRITE_ONCE(timer->it_signal, NULL);
 
 	unlock_timer(timer, flags);
-	release_posix_timer(timer, IT_ID_SET);
+	posix_timer_unhash_and_free(timer);
 	return 0;
 }
 
@@ -1115,7 +1114,7 @@ static void itimer_delete(struct k_itime
 	WRITE_ONCE(timer->it_signal, NULL);
 
 	spin_unlock_irqrestore(&timer->it_lock, flags);
-	release_posix_timer(timer, IT_ID_SET);
+	posix_timer_unhash_and_free(timer);
 }
 
 /*

