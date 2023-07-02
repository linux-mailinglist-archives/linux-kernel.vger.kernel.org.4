Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35091745171
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjGBTqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbjGBTpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:45:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3274E1729;
        Sun,  2 Jul 2023 12:42:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8A2C60C98;
        Sun,  2 Jul 2023 19:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E1BC433C7;
        Sun,  2 Jul 2023 19:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326939;
        bh=PaZIgf4kssaSKm1oYdLOpGrtKovPUbwEtVojjxeP0lU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cdNcOe6ScMJUUqZM7SHftnKaT60W42Te0K3GWnIrI37KAbzm/27eLnNom0X+QN9jX
         a/Jo5XV6NcLA9YUO0w5tkv+Wj00/qGYsAGuzGq1OgT6TWsK1YHHMa/6imIQ/zAp9O4
         Gszevo1onSGlBjAZJR+dJ32ZSgW1zSTIi9mh05Ll97z41eA/pJPwGVeEEaXs7RkCBI
         ihH0yxGgoonpahMBulLaTFFeGKebcmsMvfc1dWsxkjFxBOPhsEuNCLAE8ZaYU4sXfs
         q6UymgdrfitLfjLTFdqtN6J4AGmrbfGX3aZ0PkH9hpdxkyzVI9yTwPGTemOoaEqrGZ
         BM8vk45ZLlUXQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sasha Levin <sashal@kernel.org>, ebiederm@xmission.com
Subject: [PATCH AUTOSEL 5.4 5/5] posix-timers: Ensure timer ID search-loop limit is valid
Date:   Sun,  2 Jul 2023 15:42:09 -0400
Message-Id: <20230702194209.1779267-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702194209.1779267-1-sashal@kernel.org>
References: <20230702194209.1779267-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.249
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 8ce8849dd1e78dadcee0ec9acbd259d239b7069f ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sched/signal.h |  2 +-
 kernel/time/posix-timers.c   | 31 ++++++++++++++++++-------------
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index b3f88470cbb58..2f355c3c0d15f 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -123,7 +123,7 @@ struct signal_struct {
 #ifdef CONFIG_POSIX_TIMERS
 
 	/* POSIX.1b Interval Timers */
-	int			posix_timer_id;
+	unsigned int		next_posix_timer_id;
 	struct list_head	posix_timers;
 
 	/* ITIMER_REAL timer for the process */
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index efe3873021a37..f3b8313475acd 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -138,25 +138,30 @@ static struct k_itimer *posix_timer_by_id(timer_t id)
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
-- 
2.39.2

