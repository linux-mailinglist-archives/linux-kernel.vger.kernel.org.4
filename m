Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EE27320BE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 22:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbjFOUOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 16:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjFOUON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 16:14:13 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0343130FC
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:13:47 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-565de4b5be5so951407b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686860018; x=1689452018;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CEZv/6sGhvOMhQWxnDExbwTM685+qPRmRKEGe7ClWdI=;
        b=txXDxOuAgvISduwhNORlog6PD3uTMSCFN9bEfs929D/4zo30iziM6RQp6/EPYtLr6w
         MirYt4C82nwhJ/MjoHs1UuLMiiPMkHNDKBql+WfzmmKrkcO8E/lusmOAlPmuJBL0OAd7
         loM13cEvQW8fpCXG3Vx7cXVGSrmiN5q2SHKHeRVoxHkN8CwtkSIYMLwsSgXKVv7OFsL6
         +vQ1/aT36BMArNIVLBtWMEKU69RDSoGoOD9RtDemIT1orr7S11CetMrXv4QVSTn1j40f
         VZG2cDcYJOaxyh7dvS7Jxp/t/yJ04pYxaXXILbV+U0fxOJA8ppCY+wOcY4QoikCNbWJ0
         O4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686860018; x=1689452018;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CEZv/6sGhvOMhQWxnDExbwTM685+qPRmRKEGe7ClWdI=;
        b=gFuTekO5COeq84UvGT2vzJnyO3M18h3gT4mWPDr7iEULKrZvSkZOurJN7yoNjAPk+J
         kJhR9MMwBzzOUuIXiHB5o4tT2QtAL1TbuXCNsMIHYrdf6dyosaUmBE2bYjjT+PCbNjot
         39m/UAUfpVSx5xJrwQc0MZIwnV8pIEkFha9Pf3/yg/b75irS72bZ5jUe9+suPrH+IjE/
         C7NihRFo8Gv4TIEY4r+9ziytGwK6EMSTqwbTpmvNL5YUy1IJmCgL+UbeBcwFltE1I04E
         /PeWlOqzcdJEgWWZjv8lbW83QfnPTTjc+j2gcEJi3izL96AHyYZLOtXwOtQF1HhSVDY0
         4SHg==
X-Gm-Message-State: AC+VfDwpZ2dNzB3J9cn+mbI6Yx45otTzzjGLlQe05B0bKMWTtpqNXFYQ
        QpbPm/i5cVyWCn3ndI3HgMbdwmQkr+eE
X-Google-Smtp-Source: ACHHUZ7fub+ZneecI125XhEQnxclGHvXLDs4wlnjbXfEDnLCkyXCSv9Fk9oJDsZRHN1dMWjIYVn3s8W2nVqx
X-Received: from joshdon-desktop.svl.corp.google.com ([2620:15c:2d4:203:5083:2e33:474b:405c])
 (user=joshdon job=sendgmr) by 2002:a81:ad1f:0:b0:56d:255:e2b6 with SMTP id
 l31-20020a81ad1f000000b0056d0255e2b6mr2752990ywh.7.1686860018034; Thu, 15 Jun
 2023 13:13:38 -0700 (PDT)
Date:   Thu, 15 Jun 2023 13:12:52 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230615201252.1009678-1-joshdon@google.com>
Subject: [PATCH] sched: fix throttle accounting with nested bandwidth limits
From:   Josh Don <joshdon@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes two issues:
- throttled_clock should only be set on the group that is actually
  getting throttled
- self-throttled time should only be accounted on entry/exit to
  throttled state when we have nested limits

Fixes: 88cb2868250c ("sched: add throttled time stat for throttled children")
Fixes: 3ab150d011da ("sched: don't account throttle time for empty groups")
Signed-off-by: Josh Don <joshdon@google.com>
---
 kernel/sched/fair.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0219cf870cef..a5fc825a8d70 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4787,6 +4787,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 }
 
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
+static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq);
 
 static inline bool cfs_bandwidth_used(void);
 
@@ -4879,7 +4880,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 #ifdef CONFIG_CFS_BANDWIDTH
 			struct rq *rq = rq_of(cfs_rq);
 
-			if (!cfs_rq->throttled_clock)
+			if (cfs_rq_throttled(cfs_rq) && !cfs_rq->throttled_clock)
 				cfs_rq->throttled_clock = rq_clock(rq);
 			if (!cfs_rq->throttled_clock_self)
 				cfs_rq->throttled_clock_self = rq_clock(rq);
@@ -5387,17 +5388,17 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 		/* Add cfs_rq with load or one or more already running entities to the list */
 		if (!cfs_rq_is_decayed(cfs_rq))
 			list_add_leaf_cfs_rq(cfs_rq);
-	}
 
-	if (cfs_rq->throttled_clock_self) {
-		u64 delta = rq_clock(rq) - cfs_rq->throttled_clock_self;
+		if (cfs_rq->throttled_clock_self) {
+			u64 delta = rq_clock(rq) - cfs_rq->throttled_clock_self;
 
-		cfs_rq->throttled_clock_self = 0;
+			cfs_rq->throttled_clock_self = 0;
 
-		if (SCHED_WARN_ON((s64)delta < 0))
-			delta = 0;
+			if (SCHED_WARN_ON((s64)delta < 0))
+				delta = 0;
 
-		cfs_rq->throttled_clock_self_time += delta;
+			cfs_rq->throttled_clock_self_time += delta;
+		}
 	}
 
 	return 0;
@@ -5412,13 +5413,13 @@ static int tg_throttle_down(struct task_group *tg, void *data)
 	if (!cfs_rq->throttle_count) {
 		cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
 		list_del_leaf_cfs_rq(cfs_rq);
+
+		SCHED_WARN_ON(cfs_rq->throttled_clock_self);
+		if (cfs_rq->nr_running)
+			cfs_rq->throttled_clock_self = rq_clock(rq);
 	}
 	cfs_rq->throttle_count++;
 
-	SCHED_WARN_ON(cfs_rq->throttled_clock_self);
-	if (cfs_rq->nr_running)
-		cfs_rq->throttled_clock_self = rq_clock(rq);
-
 	return 0;
 }
 
-- 
2.41.0.162.gfafddb0af9-goog

