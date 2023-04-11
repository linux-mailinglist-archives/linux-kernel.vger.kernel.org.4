Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7186DD0EA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 06:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjDKE0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 00:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjDKE0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 00:26:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE13C30FC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:25:36 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v67-20020a254846000000b00b8189f73e94so30494977yba.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681187136; x=1683779136;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JX517IRT7COXCefv+Z6JEfzB3hFBTiM6JAYd9NR6DHw=;
        b=n9OxpFiiHvxNx2CGROwrN80pWd5CJMjso971ZiubbKw5jiObrq1Mgugo656rBrOxZI
         ALNs0u7HNNBRzN3hFKunqUuD60DBlEUJuSpu5M63wGVw+oZk7tL/Ft+aZ0bLKw7wP1Jb
         IJn5E27ux0G9/iqH6GdQ9ZyiXmFtQBbbHVW3IMjByLI5KO0xXyFGvKS57q2/jepT3ZtF
         xRk9XIm340tUnkDYpUl65TsRljG/MUSXWNAY+85L7vgnqlIlnfFRY/6W/wocYOXk7KHq
         m22eKPovkhjAGGHSZRv8wh2PZEQJuxXNkF5YuM2gSkkysxEuMgqlM0HwIfMR2UDg9rFy
         fANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681187136; x=1683779136;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JX517IRT7COXCefv+Z6JEfzB3hFBTiM6JAYd9NR6DHw=;
        b=pIpPfgA742YbsTa2Art3pA43Aq34lnw55C3P+piGcdVV9/e2bqW6sqmUdnBGKQwOrA
         FWq055BzxLxO8t/afOjCQLGyGtKXLKNHvtXWM+uACOiD0HmGg+LmplI3YmuqvLXsJILZ
         1N8VmpFfwZWCLRTArcsx3tCJiuHfgIgU8OT6FWXv3JPfAJDEYOh1S04OcT59ZmTGgnqg
         XUtI5NXSHngCXoF3Ti0XbwN+A5LiyQufxbUBtIUuInqO6iS3UVbDzy9BEex2bKU/l5lw
         +KtbOxcOf41wqPe1Xe9ntxTSWZqh4lTloBSdSbaVo4N4yqP3u4h4wpNREybhKJhsS44I
         OH4g==
X-Gm-Message-State: AAQBX9fEqAjXowjyTnmzxRdYbwMqsJlfVGVC4nNlLLJOOYxpID6CXYCl
        us+5dL0AXWjqezPUDw0FnbU7AHpBtG9T2k3/k0ZDUtf95pX62go11PJlsrIXUm/OYGU9xPLZRX6
        JiU3hH8R5J/UNHuCgDFLSemnLSSooQ2AUH6sCj+qLpjkyCugk0RY1/xRd8cNN94Np6O19KTQ=
X-Google-Smtp-Source: AKy350Zcs3W4gptUndbilLC3UgkG7fame+KRWIflBq00QUXM77IOGDtAvm9f3ebv6zQqUhxbZCRJV8UxM+5A
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6902:12c7:b0:b26:884:c35e with SMTP id
 j7-20020a05690212c700b00b260884c35emr10795372ybu.4.1681187136322; Mon, 10 Apr
 2023 21:25:36 -0700 (PDT)
Date:   Tue, 11 Apr 2023 04:25:07 +0000
In-Reply-To: <20230411042511.1606592-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230411042511.1606592-1-jstultz@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230411042511.1606592-11-jstultz@google.com>
Subject: [PATCH v3 10/14] sched: Unnest ttwu_runnable in prep for proxy-execution
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Slightly rework ttwu_runnable to minimize the nesting to help
make the proxy-execution changes easier to read.

Should be no logical change here.

Cc: Joel Fernandes <joelaf@google.com>
Cc: Qais Yousef <qyousef@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/sched/core.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a9cf8397c601..82a62480d8d7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3776,18 +3776,20 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
 	int ret = 0;
 
 	rq = __task_rq_lock(p, &rf);
-	if (task_on_rq_queued(p)) {
-		if (!task_on_cpu(rq, p)) {
-			/*
-			 * When on_rq && !on_cpu the task is preempted, see if
-			 * it should preempt the task that is current now.
-			 */
-			update_rq_clock(rq);
-			check_preempt_curr(rq, p, wake_flags);
-		}
-		ttwu_do_wakeup(p);
-		ret = 1;
+	if (!task_on_rq_queued(p))
+		goto out_unlock;
+
+	if (!task_on_cpu(rq, p)) {
+		/*
+		 * When on_rq && !on_cpu the task is preempted, see if
+		 * it should preempt the task that is current now.
+		 */
+		update_rq_clock(rq);
+		check_preempt_curr(rq, p, wake_flags);
 	}
+	ttwu_do_wakeup(p);
+	ret = 1;
+out_unlock:
 	__task_rq_unlock(rq, &rf);
 
 	return ret;
-- 
2.40.0.577.gac1e443424-goog

