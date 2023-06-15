Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361A373172E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344091AbjFOLkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343981AbjFOLi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:38:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CE530F7;
        Thu, 15 Jun 2023 04:38:16 -0700 (PDT)
Date:   Thu, 15 Jun 2023 11:38:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686829094;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xKw1YBpgHN/11BK0WoeM1YbOvRJ2iSF8stqvZRVIrRU=;
        b=lLKRgL3NHZgHESBg49E9zH/g2+Oo0EQDbu5yFKqRlU9E2uGzxJfUVCCzXqTgH+43GZqgZO
        Gskjwh5Ra/e50Illa+B/cA8YE5YiW3035gds4FD9VOTkV/0peIZKsNRBqAEDUR6KYiAL6I
        SQBmCRmmpN2/gwZJHwHhWdo1orIKwcqV6Z9JHm7ozPQjXEeHd6NTA9WixlbNGkk4PEwP1d
        KfJ722v948kf6dGJ5LEbhACN+zcAhImAktXkz00Pj6b6+zxzzlj6lkUqo5IwYYb7YvXYqX
        0DkQ/vsSLl55Bx7Gh0cws4hDDR6OOi5fpS4Izj4RkjDTJQDSQJw+tAb4qaWrbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686829095;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xKw1YBpgHN/11BK0WoeM1YbOvRJ2iSF8stqvZRVIrRU=;
        b=Ds0y7YF+T/dBSLMHzoh2EF0U4lCu7L094KcC24iirQ+h6mnhSwLBDJPeK7XYsDZFzQXcyp
        DBRGAxNeNJwJHsDA==
From:   "tip-bot2 for Josh Don" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Don't account throttle time for empty groups
Cc:     Josh Don <joshdon@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230612232748.3948659-1-joshdon@google.com>
References: <20230612232748.3948659-1-joshdon@google.com>
MIME-Version: 1.0
Message-ID: <168682909442.404.8265948687296102348.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     eed673d4f701e17b8f887dbcbfd3b4bcc53503ec
Gitweb:        https://git.kernel.org/tip/eed673d4f701e17b8f887dbcbfd3b4bcc53503ec
Author:        Josh Don <joshdon@google.com>
AuthorDate:    Mon, 12 Jun 2023 16:27:47 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 15 Jun 2023 13:28:19 +02:00

sched: Don't account throttle time for empty groups

It is easy for a cfs_rq to become throttled even when it has no enqueued
entities (for example, if we have just put_prev()'d the last runnable
task of the cfs_rq, and the cfs_rq is out of quota).

Avoid accounting this time towards total throttle time, since it
otherwise falsely inflates the stats.

Note that the dequeue path is special, since we normally disallow
migrations when a task is in a throttled hierarchy (see
throttled_lb_pair()).

Signed-off-by: Josh Don <joshdon@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230612232748.3948659-1-joshdon@google.com
---
 kernel/sched/fair.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6189d1a..b56c86c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4873,8 +4873,14 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	if (cfs_rq->nr_running == 1) {
 		check_enqueue_throttle(cfs_rq);
-		if (!throttled_hierarchy(cfs_rq))
+		if (!throttled_hierarchy(cfs_rq)) {
 			list_add_leaf_cfs_rq(cfs_rq);
+		} else {
+#ifdef CONFIG_CFS_BANDWIDTH
+			if (!cfs_rq->throttled_clock)
+				cfs_rq->throttled_clock = rq_clock(rq_of(cfs_rq));
+#endif
+		}
 	}
 }
 
@@ -5480,7 +5486,9 @@ done:
 	 * throttled-list.  rq->lock protects completion.
 	 */
 	cfs_rq->throttled = 1;
-	cfs_rq->throttled_clock = rq_clock(rq);
+	SCHED_WARN_ON(cfs_rq->throttled_clock);
+	if (cfs_rq->nr_running)
+		cfs_rq->throttled_clock = rq_clock(rq);
 	return true;
 }
 
@@ -5498,7 +5506,10 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	update_rq_clock(rq);
 
 	raw_spin_lock(&cfs_b->lock);
-	cfs_b->throttled_time += rq_clock(rq) - cfs_rq->throttled_clock;
+	if (cfs_rq->throttled_clock) {
+		cfs_b->throttled_time += rq_clock(rq) - cfs_rq->throttled_clock;
+		cfs_rq->throttled_clock = 0;
+	}
 	list_del_rcu(&cfs_rq->throttled_list);
 	raw_spin_unlock(&cfs_b->lock);
 
