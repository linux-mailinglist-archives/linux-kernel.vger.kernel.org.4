Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C85C722A7D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjFEPJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbjFEPIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:08:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9DDE8;
        Mon,  5 Jun 2023 08:08:31 -0700 (PDT)
Date:   Mon, 05 Jun 2023 15:08:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685977710;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OBdeCUFo/IU1pBwgRAOi17itc3qlLbBiaXExgTWjgC8=;
        b=1+wmDHao8XBiMfVll797Q6pRfFex5htu6uDgDFtq+hPBoX0eRhuwtG8qFmThIHj31UVnDi
        B7bMA99ZujZkjkSMA6NLOaTymYTbCVc5rWDH2I9/3sk7rbwXOhg9w77cvSKK9dXK5u1i+k
        Eafy1cV2yhHqDb/OSY0AeG7/Ve4CRgMNv7yVeaHtlNJFROu2mIUQ87zOpT0zJSX9NOhD3l
        Jj603lay0U72LRFcZWdpe2G+aGXrYACh99lt87f84iOTKXx7C7nmg9pO/0/HaQQNt0y8wc
        smFXNeaK3k2yqOJJNY5OyqI6nGPGszo16yine/euJoQCtHw/JoT+l2e6w7Sslw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685977710;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OBdeCUFo/IU1pBwgRAOi17itc3qlLbBiaXExgTWjgC8=;
        b=aPaY2BmLV1ycdu7pg56oqpa1lG5CLmSUd+yEmj47BTlSO3z0FhV28k9mTzq6HAMd4nCZM6
        tOmAeHwKjZuw5jBQ==
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
Message-ID: <168597770958.404.15665270041131228632.tip-bot2@tip-bot2>
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

Commit-ID:     e7441aa344046cbdcb402ac173fb163613471097
Gitweb:        https://git.kernel.org/tip/e7441aa344046cbdcb402ac173fb163613471097
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Apr 2023 20:49:09 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Jun 2023 17:03:37 +02:00

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
index d8d4cdf..8153374 100644
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
