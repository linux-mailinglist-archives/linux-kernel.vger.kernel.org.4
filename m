Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE129722A79
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbjFEPJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbjFEPId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:08:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6920BF3;
        Mon,  5 Jun 2023 08:08:32 -0700 (PDT)
Date:   Mon, 05 Jun 2023 15:08:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685977711;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qQgeEb9hS2OwslC7UYMEj5kd+JcImTvjidFJIvXXFOs=;
        b=jS1DOadp3IhmJDNaG14EhTQmT1+W7/QTKKTf9jWhDcFOqUERAJOz6qQj+meKSGzKlL15jM
        cLWMmwISBltGwbP0QllEHbHoMtBtD6DqNZ6lARHu6AOu3vTfR342xmkdoXT9C4MWMREe3m
        7ZjeN3+HnKrEC8yzPhEnCKhicuRy7n6KkF3cJtvJ9sD5uioDjoZxOYAbYxX3QEPL37MBX8
        +VaKVyPRDTGm17Tm1oRj75Xjqd3uyUM8/Pwi1hpCH4RX6s9iXtHiFPt+Y5XWzLW0cksVax
        yu68vNV4/innosGKBKwrQLooQsmKRwbtE88VfIaSIPZCd0SfF8kn9PIm7nBaTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685977711;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qQgeEb9hS2OwslC7UYMEj5kd+JcImTvjidFJIvXXFOs=;
        b=U1LBd8ErHQ6NvkVNFsv3pPQjmXOlBLNmWR2jKXS3khWdYoR0/qA3uL+HUsNIFtpA67Bc/6
        2loI/UUxOhuYq0CQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Annotate concurrent access to
 k_itimer:: It_signal
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230425183313.143596887@linutronix.de>
References: <20230425183313.143596887@linutronix.de>
MIME-Version: 1.0
Message-ID: <168597771061.404.17723098484982029633.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d69e873ee50459e3b77019263cf95236f063a97b
Gitweb:        https://git.kernel.org/tip/d69e873ee50459e3b77019263cf95236f063a97b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Apr 2023 20:49:05 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Jun 2023 17:03:37 +02:00

posix-timers: Annotate concurrent access to k_itimer:: It_signal

k_itimer::it_signal is read lockless in the RCU protected hash lookup, but
it can be written concurrently in the timer_create() and timer_delete()
path. Annotate these places with READ_ONCE() and WRITE_ONCE()

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230425183313.143596887@linutronix.de

---
 kernel/time/posix-timers.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index f6650c1..4333334 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -109,9 +109,9 @@ static struct k_itimer *__posix_timers_find(struct hlist_head *head,
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
@@ -558,7 +558,7 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 
 	spin_lock_irq(&current->sighand->siglock);
 	/* This makes the timer valid in the hash table */
-	new_timer->it_signal = current->signal;
+	WRITE_ONCE(new_timer->it_signal, current->signal);
 	list_add(&new_timer->list, &current->signal->posix_timers);
 	spin_unlock_irq(&current->sighand->siglock);
 
@@ -1052,10 +1052,10 @@ retry_delete:
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
