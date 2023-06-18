Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF9373485F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 22:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjFRUu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 16:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjFRUuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 16:50:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6D1E56;
        Sun, 18 Jun 2023 13:50:05 -0700 (PDT)
Date:   Sun, 18 Jun 2023 20:50:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687121404;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tE0PPSvgiBV5Ta1Wh/yehUxuOW1BM6BMnXtjBzy/htw=;
        b=YXig6ezMJyRfFkCpfFbX6sh4o8D7NyqqJqmbpSNVHpYy45kWDo454iLrYpIWbARmxs4h2W
        YUHMnbrCAvM1PEl9otel1Hems4kXriO+NjJUvHGKkXalI4CZ0jn597RZDmHC5L0TaHpz1F
        dTAxqAvXa9vN+OzgNsZp/V1FYP4tbn84YLgiphwnGJByvu156l5mP8VkFosJM4EbAhXEYT
        Oh10pSUT12qqsiREGfi0/v3pRafRpEHHD7fYPT/QSm0OmW4GjNnVG+3+R8DJgPUfHUVK89
        Wnd7OuGj36Tz/zcluRyuNp6ap8pcsygXiAp0MjvXld0jE82F1Y/45pHTij3DTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687121404;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tE0PPSvgiBV5Ta1Wh/yehUxuOW1BM6BMnXtjBzy/htw=;
        b=fmRgRd0fiNph0n3x+a2Zg2UAvRhX4KHr6kwajorvsh1CbTBCIeB+stKJT7vIlJzlrA9DbV
        Ab0b+jvRepTiUDCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Split release_posix_timers()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230425183313.301432503@linutronix.de>
References: <20230425183313.301432503@linutronix.de>
MIME-Version: 1.0
Message-ID: <168712140351.404.14009303465424230043.tip-bot2@tip-bot2>
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

Commit-ID:     8cc96ca2c75f6da59de41321797c87562703c9e1
Gitweb:        https://git.kernel.org/tip/8cc96ca2c75f6da59de41321797c87562703c9e1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Apr 2023 20:49:09 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 18 Jun 2023 22:41:50 +02:00

posix-timers: Split release_posix_timers()

release_posix_timers() is called for cleaning up both hashed and unhashed
timers. The cases are differentiated by an argument and the usage is
hideous.

Seperate the actual free path out and use it for unhashed timers. Provide a
function for hashed timers.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230425183313.301432503@linutronix.de

---
 kernel/time/posix-timers.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index ed7d260..6ac6933 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -466,20 +466,21 @@ static void k_itimer_rcu_free(struct rcu_head *head)
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
@@ -493,7 +494,6 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 	const struct k_clock *kc = clockid_to_kclock(which_clock);
 	struct k_itimer *new_timer;
 	int error, new_timer_id;
-	int it_id_set = IT_ID_NOT_SET;
 
 	if (!kc)
 		return -EINVAL;
@@ -513,11 +513,10 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
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
@@ -569,7 +568,7 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 	 * new_timer after the unlock call.
 	 */
 out:
-	release_posix_timer(new_timer, it_id_set);
+	posix_timer_unhash_and_free(new_timer);
 	return error;
 }
 
@@ -1057,7 +1056,7 @@ retry_delete:
 	WRITE_ONCE(timer->it_signal, NULL);
 
 	unlock_timer(timer, flags);
-	release_posix_timer(timer, IT_ID_SET);
+	posix_timer_unhash_and_free(timer);
 	return 0;
 }
 
@@ -1109,7 +1108,7 @@ retry_delete:
 	WRITE_ONCE(timer->it_signal, NULL);
 
 	spin_unlock_irqrestore(&timer->it_lock, flags);
-	release_posix_timer(timer, IT_ID_SET);
+	posix_timer_unhash_and_free(timer);
 }
 
 /*
