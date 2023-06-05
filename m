Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373F7722A74
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbjFEPJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbjFEPIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:08:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98007EA;
        Mon,  5 Jun 2023 08:08:33 -0700 (PDT)
Date:   Mon, 05 Jun 2023 15:08:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685977712;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PfMToWDxPv5J5JbDhDT83VuH0HT/Op8EtRYHFkNW/o0=;
        b=IS+cm/SKPW/6kVryIUDkBqgefBmGwDPUfORcB/+vBvV1c5hWZbpqshL/7OzNELoJGXcpSK
        NkX9Z6lQqElpUp/4Gmwxrd7wGpU3myx4DTcd298W2ntn/2oz+a43YkdvyLzV7IlrxbWLGw
        D7Nom7kp3gkBAIZ0hln5P7AiiscLResxxVNS7CakGuEoK22iIeq2eq6lPTO1smswQtl79N
        r4dUV7XtGkdNSJjxwDDBGv2jIy3D6ZsuiwmZ3IemvTGZ/LbMfIOx6mu1U/FrPT9snaQOov
        FBavTPeBi9BCOJi5JB1+ikiYQdd8r0VVpgkVIsHV6XrM1Pz+3MeoJH4AbApB3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685977712;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PfMToWDxPv5J5JbDhDT83VuH0HT/Op8EtRYHFkNW/o0=;
        b=1+JgioHB4cYuFggB1tBOSKmJH55Cn+kGlpNbdNmoyosr+wQcu26N3t1FrX0ot6LEXA/vro
        8Ui5vPRSyktEpAAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Ensure timer ID search-loop limit is valid
Cc:     syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87bkhzdn6g.ffs@tglx>
References: <87bkhzdn6g.ffs@tglx>
MIME-Version: 1.0
Message-ID: <168597771182.404.4875965937942774336.tip-bot2@tip-bot2>
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

Commit-ID:     cec58cad4614f44b76624f8d62ef771c8725c483
Gitweb:        https://git.kernel.org/tip/cec58cad4614f44b76624f8d62ef771c8725c483
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 01 Jun 2023 20:58:47 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Jun 2023 17:03:36 +02:00

posix-timers: Ensure timer ID search-loop limit is valid

posix_timer_add() tries to allocate a posix timer ID by starting from the
cached ID which was stored by the last successful allocation.

This is done in a loop searching the ID space for a free slot one by
one. The loop has to terminate when the search wrapped around to the
starting point.

But that's racy vs. establishing the starting point. That is read out
lockless, which leads to the following problem:

CPU0	  	      	     	   CPU1
posix_timer_add()
  start = sig->posix_timer_id;
  lock(hash_lock);
  ...				   posix_timer_add()
  if (++sig->posix_timer_id < 0)
      			             start = sig->posix_timer_id;
     sig->posix_timer_id = 0;

So CPU1 can observe a negative start value, i.e. -1, and the loop break
never happens because the condition can never be true:

  if (sig->posix_timer_id == start)
     break;

While this is unlikely to ever turn into an endless loop as the ID space is
huge (INT_MAX), the racy read of the start value caught the attention of
KCSAN and Dmitry unearthed that incorrectness.

Rewrite it so that all id operations are under the hash lock.

Reported-by: syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/87bkhzdn6g.ffs@tglx

---
 include/linux/sched/signal.h |  2 +-
 kernel/time/posix-timers.c   | 31 ++++++++++++++++++-------------
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 2009926..669e8cf 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -135,7 +135,7 @@ struct signal_struct {
 #ifdef CONFIG_POSIX_TIMERS
 
 	/* POSIX.1b Interval Timers */
-	int			posix_timer_id;
+	unsigned int		next_posix_timer_id;
 	struct list_head	posix_timers;
 
 	/* ITIMER_REAL timer for the process */
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 2d835c2..2c5daeb 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -140,25 +140,30 @@ static struct k_itimer *posix_timer_by_id(timer_t id)
 static int posix_timer_add(struct k_itimer *timer)
 {
 	struct signal_struct *sig = current->signal;
-	int first_free_id = sig->posix_timer_id;
 	struct hlist_head *head;
-	int ret = -ENOENT;
+	unsigned int cnt, id;
 
-	do {
+	/*
+	 * FIXME: Replace this by a per signal struct xarray once there is
+	 * a plan to handle the resulting CRIU regression gracefully.
+	 */
+	for (cnt = 0; cnt <= INT_MAX; cnt++) {
 		spin_lock(&hash_lock);
-		head = &posix_timers_hashtable[hash(sig, sig->posix_timer_id)];
-		if (!__posix_timers_find(head, sig, sig->posix_timer_id)) {
+		id = sig->next_posix_timer_id;
+
+		/* Write the next ID back. Clamp it to the positive space */
+		sig->next_posix_timer_id = (id + 1) & INT_MAX;
+
+		head = &posix_timers_hashtable[hash(sig, id)];
+		if (!__posix_timers_find(head, sig, id)) {
 			hlist_add_head_rcu(&timer->t_hash, head);
-			ret = sig->posix_timer_id;
+			spin_unlock(&hash_lock);
+			return id;
 		}
-		if (++sig->posix_timer_id < 0)
-			sig->posix_timer_id = 0;
-		if ((sig->posix_timer_id == first_free_id) && (ret == -ENOENT))
-			/* Loop over all possible ids completed */
-			ret = -EAGAIN;
 		spin_unlock(&hash_lock);
-	} while (ret == -ENOENT);
-	return ret;
+	}
+	/* POSIX return code when no timer ID could be allocated */
+	return -EAGAIN;
 }
 
 static inline void unlock_timer(struct k_itimer *timr, unsigned long flags)
