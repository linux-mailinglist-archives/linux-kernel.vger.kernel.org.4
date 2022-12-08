Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57FD6467A5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 04:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiLHDUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 22:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLHDUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 22:20:36 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE5C3205F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 19:20:35 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so210005pjd.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 19:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DidHp4dr0fWeFR8xVy68PDFg1LI1b914KdhJ5z4MM1o=;
        b=lF4Z1bpeiU+0/VyLQD4BCIcaJpZ+4TqW6tPFr5AWD2ttPoJDsO0LytoHzThnKN0Kqv
         zjLEOvqtHb0zz3hi85a2T8etV19dpFoWzkNEWeTlZNhe4cFwwdVYKQ3GA9u5do567wo8
         4fHTf67dSSEzShdgOlF7Ej5iCWyQ2kH0VDKCeszVst5i75NCWdMgjY0/WKkdpYylv+nZ
         sTDWBDxI4LZnCGYaGT/RdPxU3q/bMmhi9y2vCBGq6qasDWK/7tc/910oLrybBMGtaXxk
         c/oDkpvXR6kbxHwWTeUbwfz1peHFkwGsO3f7s6cqlk64R7foPbPbGZrJA5yLSqMhxTD7
         pa1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DidHp4dr0fWeFR8xVy68PDFg1LI1b914KdhJ5z4MM1o=;
        b=FLpl4XajdcyDz8cj0v6j3OYqUNqST8GPkA/fAhe8CejDdd0xHuKR3axNfD7EOG9jaw
         rcF0kXlIz+hxD+lHjgC4PUM6J4ybNCc83mddLd9e9WP+YW8dZeCcrBNr5ICqxGaiDCh3
         w/CpMilvfDtfw65I1HfJgbU5a2GkpuH/eaScSZClWw4D5gA4Vso3uikQq6CexK7Kd7of
         Yn2UvgI2xwiMrMaDbGs9UMk3ZOmXMN1HX3aJDnFvPIji6EC5Mj7IBX8Ouq3WRQmZp+E9
         71EF5VGTF3REMuAR7DB2FclgvKwt+vOH87lhsVNWOki7BvHjPcJP0PmC6C45aQ3WDo0+
         3bNg==
X-Gm-Message-State: ANoB5pn5DVysj/SNmEq9Wy2D5e0E0Jabajl5ypuY1LkOkTpGssareUot
        bkKSEnbRk/Mge3e6fVOMPQF2Gw==
X-Google-Smtp-Source: AA0mqf4NpXHB8EpEWrWLeTSS5HtGvbxrvg67vFIOCVNcHcRuv7yyEKdz8lLvVWuFcRecPoJVr5RaAw==
X-Received: by 2002:a17:903:2798:b0:189:f06e:fd8d with SMTP id jw24-20020a170903279800b00189f06efd8dmr7743656plb.163.1670469635042;
        Wed, 07 Dec 2022 19:20:35 -0800 (PST)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id mm13-20020a17090b358d00b00200461cfa99sm1846781pjb.11.2022.12.07.19.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 19:20:34 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, bagasdotme@gmail.com,
        yu.c.chen@intel.com, Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v5 1/2] sched/core: Minor optimize ttwu_runnable()
Date:   Thu,  8 Dec 2022 11:20:06 +0800
Message-Id: <20221208032007.94459-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
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

ttwu_runnable() is used as a fast wakeup path when the wakee task
is running on CPU or runnable on RQ, in both cases we can just
set its state to TASK_RUNNING to prevent a sleep.

If the wakee task is on_cpu running, we don't need to update_rq_clock()
or check_preempt_curr().

But if the wakee task is on_rq && !on_cpu (e.g. an IRQ hit before
the task got to schedule() and the task been preempted), we should
check_preempt_curr() to see if it can preempt the current running.

This also removes the class->task_woken() callback from ttwu_runnable(),
which wasn't required per the RT/DL implementations: any required push
operation would have been queued during class->set_next_task() when p
got preempted.

ttwu_runnable() also loses the update to rq->idle_stamp, as by definition
the rq cannot be idle in this scenario.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Suggested-by: Valentin Schneider <vschneid@redhat.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
---
v5:
 - Split the reorganization and optimization into two patches
   per Chen Yu. Thanks!

v4:
 - s/This patch reorg/Reorganize/ per Bagas Sanjaya. Thanks!

v3:
 - Improve the changelog per Valentin Schneider. Thanks!

v2:
 - keep check_preempt_curr() for on_rq && !on_cpu case in ttwu_runnable(),
   per Valentin Schneider.
 - reorg ttwu_do_wakeup() and ttwu_do_activate() code, so ttwu_do_wakeup()
   can be reused in ttwu_runnable(), per Peter Zijlstra.
 - reuse ttwu_do_wakeup() in try_to_wake_up() (p == current) fast path too,
   so ttwu_do_wakeup() become the only place we mark task runnable.
---
 kernel/sched/core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 314c2c0219d9..60aa7774e5f4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3718,9 +3718,16 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
 
 	rq = __task_rq_lock(p, &rf);
 	if (task_on_rq_queued(p)) {
-		/* check_preempt_curr() may use rq clock */
-		update_rq_clock(rq);
-		ttwu_do_wakeup(rq, p, wake_flags, &rf);
+		if (!task_on_cpu(rq, p)) {
+			/*
+			 * When on_rq && !on_cpu the task is preempted, see if
+			 * it should preempt whatever is current there now.
+			 */
+			update_rq_clock(rq);
+			check_preempt_curr(rq, p, wake_flags);
+		}
+		WRITE_ONCE(p->__state, TASK_RUNNING);
+		trace_sched_wakeup(p);
 		ret = 1;
 	}
 	__task_rq_unlock(rq, &rf);
-- 
2.37.2

