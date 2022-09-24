Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA885E8E53
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 18:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiIXQFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 12:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbiIXQEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 12:04:54 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6184917589
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 09:04:53 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d24so2696349pls.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 09:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=314wVdYAbgqap/HedcQfys+N3Xis6KXvo1NfnKZNHgc=;
        b=CZCVpRxxVzeYhNm/x70UdHHhzVQWbGw6Kh8IKft+cHlpM60VR24WnUIH8lVOzznRo7
         Aq3NHv17ByPbuh+AoYNNGxIxpA8gfkn0iHlVdttNLATSv8o71dr44ySQfOaqAtxFjzU5
         jGnpIq40MsVrmPPYbMPN8wDUQQfrEZRFI1hi4wBjVEhEbkikmIhUyVcSm+JaBb46lFQK
         rNJq0NAQPzjkzdp5lyfFEP9xpJHQilMaXbl71FDV3hE89dU4pXD6+NdLDt/mVfIdy/TO
         Cl9ieCntLr2s/Wnbpoma0n/pLH0YtDUEgd5fOsJqYn8qSWhUeI8TYNpBHnUVnyuxeTxl
         VI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=314wVdYAbgqap/HedcQfys+N3Xis6KXvo1NfnKZNHgc=;
        b=0QdI8kBZC6djyXFCiwncr2gTgYIDr5SAUVIz/pkRPY6YDywe3oLEpZesfx+4OhNJwo
         +cz47fkv3ngjiHJ939F653CBrHEC/rvwiPZUxU6W2ZT5iqkqxopJvyW+lrtpbMiWYAft
         twwB6i6w1OEf5vyJhDwUGcV6STaSNR+7wp6IVYV7fCPDvpA1z9VGCSI0kRYMq2aAhGb3
         ICKqNXPJIB/3eTyR4aGP/cnqoqTQ0PiToOR22dl9xajK75g78dSywCrGKDLxL9KBmU7D
         X9W5loKpJbpdOBTRGoxAvpE0foAruvVfGQKJgd0vy71MTLRrUkBC52kFAQFRpFow+sVG
         MyOg==
X-Gm-Message-State: ACrzQf1CQjbi1kkbKkjpYEYYbfJ6FZ8gi+vHGY35X/i/ckk6IU7zGHGy
        XjsKILw6UUnFwPEz2n8VtLm8NW8JRkJquQ==
X-Google-Smtp-Source: AMsMyM4i3j/np2ICmpjF9udMg+W3XvNewY6ZRWAmedIHDnEN/h16qbT4kUo9yLcdmUoM1Y3ZZVtodQ==
X-Received: by 2002:a17:902:b94c:b0:178:336f:13d6 with SMTP id h12-20020a170902b94c00b00178336f13d6mr14239531pls.64.1664035492899;
        Sat, 24 Sep 2022 09:04:52 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e65:7770:2059:e8ad:fa8b:a6bd])
        by smtp.gmail.com with ESMTPSA id q15-20020a170902a3cf00b0017691eb7e17sm7879975plb.239.2022.09.24.09.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 09:04:52 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 2/2] sched/fair: Fix vruntime_normalized() for TASK_NEW
Date:   Sun, 25 Sep 2022 00:04:29 +0800
Message-Id: <20220924160429.71312-2-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220924160429.71312-1-zhouchengming@bytedance.com>
References: <20220924160429.71312-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When !on_rq, vruntime of the task has usually NOT been normalized.
But there are two cases where it has already been normalized:
1. A forked child which is waiting for being woken up by
   wake_up_new_task().
2. A task which has been woken up by try_to_wake_up() and
   waiting for actually being woken up by sched_ttwu_pending().

The current code use !se->sum_exec_runtime to check the first case,
which is not always correct, like a !on_rq RT task switched_to_fair()
for the first time, its se->sum_exec_runtime == 0 but not TASK_NEW.

Although its vruntime is normalized indeed, we should add cfs_rq->min_vruntime
to be renormalized for this !on_rq !fair task when switched_to_fair().
Or later enqueue_entity() won't renorm it either, which cause abnormal
vruntime. OTOW, vruntime_normalized() should return false for this case.

Fix it by using the clearer TASK_NEW state to only consider a forked
child which is waiting for being woken up by wake_up_new_task().

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/fair.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index dea86d8a6c02..36614bfd452f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11655,8 +11655,6 @@ prio_changed_fair(struct rq *rq, struct task_struct *p, int oldprio)
 
 static inline bool vruntime_normalized(struct task_struct *p)
 {
-	struct sched_entity *se = &p->se;
-
 	/*
 	 * In both the TASK_ON_RQ_QUEUED and TASK_ON_RQ_MIGRATING cases,
 	 * the dequeue_entity(.flags=0) will already have normalized the
@@ -11674,7 +11672,7 @@ static inline bool vruntime_normalized(struct task_struct *p)
 	 * - A task which has been woken up by try_to_wake_up() and
 	 *   waiting for actually being woken up by sched_ttwu_pending().
 	 */
-	if (!se->sum_exec_runtime ||
+	if (READ_ONCE(p->__state) == TASK_NEW ||
 	    (READ_ONCE(p->__state) == TASK_WAKING && p->sched_remote_wakeup))
 		return true;
 
-- 
2.37.2

