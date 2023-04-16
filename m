Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74B06E3C2F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 23:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjDPVeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 17:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDPVeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 17:34:15 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5680F2113
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 14:34:13 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-552d922f0faso7865217b3.14
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 14:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681680852; x=1684272852;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cP9JSIgzIwKlCqJpR4LA/JOVMTfnunGFo8i5nV2KCy4=;
        b=LAVowwSFzzEA0L+f0tMquJ92ekEc5sfLhZ9bBNxI7qWsRP7eKrMiUCBK69pdkwVPaK
         gDr2MHmCxALvq3RTf0hf+2lGikMDg3q6OC30WUUrOAyGnKbmUS3U9uBEqwgN2fRfLEi2
         kutcf/cZ5P9ooCX9GdPt3RBNB6sCtXpXm7KNzxaQIEJ0sHZTRlj72Krr+LCC7uz5ql0B
         MZ4IyoYMChGStCfuLaqIS2/k4xZhV/EH3gpwd/ZU2fcr79qR1BBWd181mUJizmUvmkHC
         /PU6s+aI3mzGbgfhXq2yn/u/I5TP6R6qYXmFVHjGOmDkqiQFgwS7FPVDZeW1VjszCuVJ
         x3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681680852; x=1684272852;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cP9JSIgzIwKlCqJpR4LA/JOVMTfnunGFo8i5nV2KCy4=;
        b=a47hscXsn7e6xTS2o3/Whg1rmau9CiMD/RiqoXF3fAvh4Tm1HNdJ/DGgWxSmMHcI6k
         iyIdMCIXx+ES8YuChU13IxmqCA6ca5SaQRFfZo0tEOTxkD4hQOCUjgC8QZPKz8Oe1Nqp
         s1pAu/+/+TX9AwI6BSFWWTEpO7Ak2Eo9291rTkKtetIfGXNFQMtNqYMcKdHh9gv9+cLO
         jM4lY6bajnz2CQnbYPO4BwVDTgnvY4x414Qr0U3gDsO5enJJSguyZlk2CWBpJlnQhJ85
         bSxnmsLItWiwo3B/EU7wr8oEDzRFbutsa0iQ0ZHNwBhqisz0KULGE2n0o/TSGrjP49Kz
         VQgg==
X-Gm-Message-State: AAQBX9eAwHD4M3pLl77v16igtRVV4gYDaEPGOE8TTl+Mm3p+B2ZfLQ3P
        RlfKicso9hbHrhgXavJEJkVjCCSYwDJG
X-Google-Smtp-Source: AKy350YWot17ls0vE8VsKj6RzJTYf5B9iZn0jHLB0tn26sQ2C66qiY+SKQdmRNgmy8illcx6LlN3AQ607AQc
X-Received: from davidai2.mtv.corp.google.com ([2620:15c:211:201:ebde:c661:1fa9:4737])
 (user=davidai job=sendgmr) by 2002:a81:ae1a:0:b0:545:5b2c:4bf6 with SMTP id
 m26-20020a81ae1a000000b005455b2c4bf6mr8064815ywh.7.1681680852603; Sun, 16 Apr
 2023 14:34:12 -0700 (PDT)
Date:   Sun, 16 Apr 2023 14:34:04 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230416213406.2966521-1-davidai@google.com>
Subject: [RFC PATCH v1] sched/uclamp: Introduce SCHED_FLAG_RESET_UCLAMP_ON_FORK
 flag
From:   David Dai <davidai@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     David Dai <davidai@google.com>, Qais Yousef <qyousef@google.com>,
        Quentin Perret <qperret@google.com>,
        Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
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

A userspace service may manage uclamp dynamically for individual tasks and
a child task will unintentionally inherit a pesudo-random uclamp setting.
This could result in the child task being stuck with a static uclamp value
that results in poor performance or poor power.

Using SCHED_FLAG_RESET_ON_FORK is too coarse for this usecase and will
reset other useful scheduler attributes. Adding a
SCHED_FLAG_RESET_UCLAMP_ON_FORK will allow userspace to have finer control
over scheduler attributes of child processes.

Cc: Qais Yousef <qyousef@google.com>
Cc: Quentin Perret <qperret@google.com>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: David Dai <davidai@google.com>
---
 include/linux/sched.h            | 3 +++
 include/uapi/linux/sched.h       | 4 +++-
 kernel/sched/core.c              | 6 +++++-
 tools/include/uapi/linux/sched.h | 4 +++-
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 63d242164b1a..b1676b9381f9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -885,6 +885,9 @@ struct task_struct {
 	unsigned			sched_reset_on_fork:1;
 	unsigned			sched_contributes_to_load:1;
 	unsigned			sched_migrated:1;
+#ifdef CONFIG_UCLAMP_TASK
+	unsigned			sched_reset_uclamp_on_fork:1;
+#endif
 
 	/* Force alignment to the next boundary: */
 	unsigned			:0;
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 3bac0a8ceab2..7515106e1f1a 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -132,12 +132,14 @@ struct clone_args {
 #define SCHED_FLAG_KEEP_PARAMS		0x10
 #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
 #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
+#define SCHED_FLAG_RESET_UCLAMP_ON_FORK	0x80
 
 #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
 				 SCHED_FLAG_KEEP_PARAMS)
 
 #define SCHED_FLAG_UTIL_CLAMP	(SCHED_FLAG_UTIL_CLAMP_MIN | \
-				 SCHED_FLAG_UTIL_CLAMP_MAX)
+				 SCHED_FLAG_UTIL_CLAMP_MAX | \
+				 SCHED_FLAG_RESET_UCLAMP_ON_FORK)
 
 #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
 			 SCHED_FLAG_RECLAIM		| \
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0d18c3969f90..f2d5f7911855 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1943,6 +1943,10 @@ static void __setscheduler_uclamp(struct task_struct *p,
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
 			      attr->sched_util_max, true);
 	}
+
+	p->sched_reset_uclamp_on_fork = !!(attr->sched_flags &
+				     SCHED_FLAG_RESET_UCLAMP_ON_FORK);
+
 }
 
 static void uclamp_fork(struct task_struct *p)
@@ -1956,7 +1960,7 @@ static void uclamp_fork(struct task_struct *p)
 	for_each_clamp_id(clamp_id)
 		p->uclamp[clamp_id].active = false;
 
-	if (likely(!p->sched_reset_on_fork))
+	if (likely(!p->sched_reset_on_fork && !p->sched_reset_uclamp_on_fork))
 		return;
 
 	for_each_clamp_id(clamp_id) {
diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/sched.h
index 3bac0a8ceab2..d52c59a2e0d0 100644
--- a/tools/include/uapi/linux/sched.h
+++ b/tools/include/uapi/linux/sched.h
@@ -132,12 +132,14 @@ struct clone_args {
 #define SCHED_FLAG_KEEP_PARAMS		0x10
 #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
 #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
+#define SCHED_FLAG_RESET_UCLAMP_ON_FORK 0x80
 
 #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
 				 SCHED_FLAG_KEEP_PARAMS)
 
 #define SCHED_FLAG_UTIL_CLAMP	(SCHED_FLAG_UTIL_CLAMP_MIN | \
-				 SCHED_FLAG_UTIL_CLAMP_MAX)
+				 SCHED_FLAG_UTIL_CLAMP_MAX | \
+				 SCHED_FLAG_RESET_UCLAMP_ON_FORK)
 
 #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
 			 SCHED_FLAG_RECLAIM		| \
-- 
2.40.0.634.g4ca3ef3211-goog

