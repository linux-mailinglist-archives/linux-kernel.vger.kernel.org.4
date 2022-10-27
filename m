Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B3B6102AC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 22:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236996AbiJ0U0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 16:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236987AbiJ0U0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 16:26:11 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E15862902
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:26:09 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id bq6-20020a056a000e0600b0056bcbc6720fso1380883pfb.22
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RzZ+vF4gE05dMWHZyKFtCSH9kQcTRyTNNdiKLvSe3jo=;
        b=T/ZYVbx0KbeZBXLgRwYuBgqxOeGY20vOvKPpeSFgk80Bm4qJo2NKG2ect8jMo4JN9h
         4T8sk777O4897XlrfmS5X327Uqmb0T5Vt5hb8SI/9kF9hAukRqyq+Z9RqYvH8VnZgFk/
         i7Gn33PnRLk48kAdh519ilvi0LjmAl3OsC6TYsYnP8Xd+Fp3nRIrJw9wh8X8+3WzWI2H
         VvnBwQKb7k7ppOCT9Q6SD/pdOyZKJAIQe+d6Dc4yPkp5CM6v7glFZb9C5xmJFsn7A860
         VMPZi6/UWThPlzQvG+L/5jJvr6GbXa8jSuuwBYo7ruqeg4cW54euqKpWrD6LYvRWMQ11
         Marw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RzZ+vF4gE05dMWHZyKFtCSH9kQcTRyTNNdiKLvSe3jo=;
        b=qL+hm773H+FectBbga7kueHGKu4/88pAObhiObkfeCUNYg+mhAwkzeHEfVOEgDo4tY
         Z3wC0ImmO5nk3mtMbYTvmjIrx1zrrk06EWsEIH1EpBbfYKvLW8YVeCwISM7LbPZtJrAp
         3LRwOK4ZyqYHptAQQd1hJgVL1tvGuLhQaaif0SlEnklDqsRwUei4rLtF5yO2q+oYHPqe
         Uf+5E+FOLZYEA4dCQU6VqHxYoFCBjIgZJiHAgo+KKjr1PI7ybPlm31oWCp0NRg5G6saH
         e7m7aOL7Th5fjGC87abca4dKWXIOtwdDmZxwPLwSw5G+b4xozh8/keiFjDGxDiWxwCoF
         o19w==
X-Gm-Message-State: ACrzQf0GlAO01jurwnxwkJx5tX96pucqj84Zlm9u+rh6xLshtbTtzEQl
        xAxmUuct1OZf/nouhSLNGET8emEo7d4=
X-Google-Smtp-Source: AMsMyM48vPEqZao00Z8Youfvv/5sVG75DTsKLDY87vecWQ4LhAJKhgIiX3/lptJ+lDIKLQRfk26F0aiePsQ=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:11:d8ef:d6b0:eaf1:152])
 (user=avagin job=sendgmr) by 2002:a05:6a00:cc9:b0:56c:b47:a73e with SMTP id
 b9-20020a056a000cc900b0056c0b47a73emr17753597pfv.19.1666902369143; Thu, 27
 Oct 2022 13:26:09 -0700 (PDT)
Date:   Thu, 27 Oct 2022 13:26:03 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221027202603.670616-1-avagin@google.com>
Subject: [PATCH] sched: consider WF_SYNC to find idle siblings
From:   Andrei Vagin <avagin@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

WF_SYNC means that the waker goes to sleep after wakeup, so the current
cpu can be considered idle if the waker is the only process that is
running on it.

The perf pipe benchmark shows that this change reduces the average time
per operation from 8.8 usecs/op to 3.7 usecs/op.

Before:
 $ ./tools/perf/perf bench sched pipe
 # Running 'sched/pipe' benchmark:
 # Executed 1000000 pipe operations between two processes

     Total time: 8.813 [sec]

       8.813985 usecs/op
         113456 ops/sec

After:
 $ ./tools/perf/perf bench sched pipe
 # Running 'sched/pipe' benchmark:
 # Executed 1000000 pipe operations between two processes

     Total time: 3.743 [sec]

       3.743971 usecs/op
         267096 ops/sec

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e4a0b8bd941c..40ac3cc68f5b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7245,7 +7245,8 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
 	} else if (wake_flags & WF_TTWU) { /* XXX always ? */
 		/* Fast path */
-		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
+		if (!sync || cpu != new_cpu || this_rq()->nr_running != 1)
+			new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
 	}
 	rcu_read_unlock();
 
-- 
2.34.1

