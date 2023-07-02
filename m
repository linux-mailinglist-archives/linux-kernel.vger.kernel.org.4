Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459AE745154
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjGBTqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjGBTog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:44:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A5010E6;
        Sun,  2 Jul 2023 12:42:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6894D60C82;
        Sun,  2 Jul 2023 19:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024B2C433C8;
        Sun,  2 Jul 2023 19:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326927;
        bh=UFDHGs6fpeodWDqr2Whh3M5Y1Q3b3u99BHi/gIiL/bs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ih+1xxrS7GcZXpX1qejnsWP5jh9MeHnip7HxBMNNaiVLrVDsmsRtA0i7qXwGgTkKa
         EOD51VJi+GXqAfrwBhVtgMsHpdDEijPuvhkrH3q1LgnkkyXLbbr3UJQDhQ3VP4Cs3N
         +YAOkV7xZo1tJkkf+jd8O23cZrggxpM4Bfc0kpnXhfrYZsH6TuqqQdumydyaSTdfw4
         mwJXkZdUDW+WHevPDC/BM8Ib1M7DRxx+PfzKYK3u4zS8lcN/DaEGpv7vKMpgQAaQPb
         JEP4ruotW5hllDN46l4E1LoD69SKUo1n60IKlFYuEKH2b8zXJncfc1fyqQSc07K//z
         w3mDUqAUBPCMg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sasha Levin <sashal@kernel.org>, ebiederm@xmission.com
Subject: [PATCH AUTOSEL 5.10 6/7] posix-timers: Ensure timer ID search-loop limit is valid
Date:   Sun,  2 Jul 2023 15:41:55 -0400
Message-Id: <20230702194156.1778977-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702194156.1778977-1-sashal@kernel.org>
References: <20230702194156.1778977-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.186
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index ae60f838ebb92..2c634010cc7bd 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -125,7 +125,7 @@ struct signal_struct {
 #ifdef CONFIG_POSIX_TIMERS
 
 	/* POSIX.1b Interval Timers */
-	int			posix_timer_id;
+	unsigned int		next_posix_timer_id;
 	struct list_head	posix_timers;
 
 	/* ITIMER_REAL timer for the process */
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index d089627f2f2b4..1bbc4b513c793 100644
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
-- 
2.39.2

