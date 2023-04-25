Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EED6EE7BA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbjDYSt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbjDYStL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:49:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12C916188
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:49:06 -0700 (PDT)
Message-ID: <20230425183313.143596887@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682448545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=me0I7Ik/2QPR1Cxbi2+BttUOdfbhm4wKXX1mgySouMM=;
        b=BZ/yP6BsoN6Kaono2yFEiQcD9foanNtBqch0FSIVVI7ewIsR2CtkITKpxKcAdGuAptLhEc
        bIHcVieXzzVpeJ5rG00ec5AyD8hzKv4rhzLlz0u1TpLucVTEGywLAv501vCuOUD59fi06L
        UxgpWTbGPyqJC6h2kET0SogqxEQ7WZj56KQ2oeT86f/iTrhXgbPdbKvq+iz8NGJx8dqHLc
        RH+/kF/vj0KkfA63z2OqdXmlLqVzgmJ43vg8442IMkjMytwWJ18j5IsvNHMGB39pTbwMx5
        fNPsiDurCMxLhrXAstojRe/B4ATAXCciNan3Vys/w0GdraUakDCrAaEZEAbzbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682448545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=me0I7Ik/2QPR1Cxbi2+BttUOdfbhm4wKXX1mgySouMM=;
        b=GecTvQlK3AjHVOha7Dld2H5pG/RjVzlGyVF9JQnFpRjNq5woiEBG2gQ+6/wkvMxpc6tDQi
        0HM/7nptC6ZwZmDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [patch 06/20] posix-timers: Annotate concurrent access to k_itimer::it_signal
References: <20230425181827.219128101@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 25 Apr 2023 20:49:05 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

k_itimer::it_signal is read lockless in the RCU protected hash lookup, but
it can be written concurrently in the timer_create() and timer_delete()
path. Annotate these places with READ_ONCE() and WRITE_ONCE()

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-timers.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -109,9 +109,9 @@ static struct k_itimer *__posix_timers_f
 {
 	struct k_itimer *timer;
 
-	hlist_for_each_entry_rcu(timer, head, t_hash,
-				 lockdep_is_held(&hash_lock)) {
-		if ((timer->it_signal == sig) && (timer->it_id == id))
+	hlist_for_each_entry_rcu(timer, head, t_hash, lockdep_is_held(&hash_lock)) {
+		/* timer->it_signal can be set concurrently */
+		if ((READ_ONCE(timer->it_signal) == sig) && (timer->it_id == id))
 			return timer;
 	}
 	return NULL;
@@ -557,7 +557,7 @@ static int do_timer_create(clockid_t whi
 
 	spin_lock_irq(&current->sighand->siglock);
 	/* This makes the timer valid in the hash table */
-	new_timer->it_signal = current->signal;
+	WRITE_ONCE(new_timer->it_signal, current->signal);
 	list_add(&new_timer->list, &current->signal->posix_timers);
 	spin_unlock_irq(&current->sighand->siglock);
 
@@ -1051,10 +1051,10 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
 	list_del(&timer->list);
 	spin_unlock(&current->sighand->siglock);
 	/*
-	 * This keeps any tasks waiting on the spin lock from thinking
-	 * they got something (see the lock code above).
+	 * A concurrent lookup could check timer::it_signal lockless. It
+	 * will reevaluate with timer::it_lock held and observe the NULL.
 	 */
-	timer->it_signal = NULL;
+	WRITE_ONCE(timer->it_signal, NULL);
 
 	unlock_timer(timer, flags);
 	release_posix_timer(timer, IT_ID_SET);

