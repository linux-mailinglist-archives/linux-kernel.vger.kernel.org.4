Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0907E654F34
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 11:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiLWKej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 05:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbiLWKeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 05:34:25 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F6927DF1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 02:33:58 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id b2so4608844pld.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 02:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I5Sm9Ccj2qcEeR/s7nTr8U/5P4ZeiJGl77hvijQ2XZ4=;
        b=rTdFYxkJ5D7p5t2kErJf2y21stnHGD0lfybzshpQXFYwzCFNLTwkLL14O1fYzvcz6Y
         I5JT8Yy6T5fTIc4j/iH5s6R8AlvclPfJuPed4Gww/48tQuSoII8V8SS2BehVqAfuoK4f
         nuAb5JZDDocrwvDREJ1z7R/cQFDNr/OdcsM6AuiPwmcrpQe2jJq2hrTd/qU6JmmPLBv7
         ilPvPmrqfm8r/DISz9zGCcH5Z9JHmVRGtHzENo5PGK8bskJIZMaHvDb96984CnbnKI3N
         74wlmxAFPGkT0QiV8VbDQbnwomJ5gcCB9RsJndPcK2leo1WLRxAfwJ8J3YiFOhAJk/5N
         vQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5Sm9Ccj2qcEeR/s7nTr8U/5P4ZeiJGl77hvijQ2XZ4=;
        b=q2SM+FoE8JyqYj7tLvLFbOQr54o0sZY3d7Es2wmVGTiAsmZVGM/cQd8GjwBFfCDNWG
         6kyqjH1l9wJ0Cke0rxFsiFdScWkK2H+bHEFQgDfac1XSlIsgr5Q68rDeYRrlvVqIa0ae
         zv0cGv/gAAL32WUF14Khx0s4GPaf3JLeASWBBO2PZEqSRvb84G9XBGblR/nlbeWuxw+n
         bLbDggTvnd8QKVHd7HrrYoveQHAhkPjAm+bEX5IJFJxYAugvaIfh223OAsZ0OoSVtXip
         OFYjStu+cx0kITRYgHOVm4oLiPyCu6EbSr9MSZaPWU4GmV/4VCteHaacqSS4AjTOJRCw
         OclA==
X-Gm-Message-State: AFqh2kpEL8KAz4oyO/iBP5qmRem1fapgkhTwtzEJcyLqr1M/m4uKtL3C
        DuVNVgGe6rbPWfi7jd1YbyCYew==
X-Google-Smtp-Source: AMrXdXsV4V8MgH803jIRErPqoLdxeRFXtQKMaSd0UqA6c9wY2uMHBBMqcuLzgv099zg2xaAd5LP15Q==
X-Received: by 2002:a17:90a:6904:b0:219:8e19:6ebf with SMTP id r4-20020a17090a690400b002198e196ebfmr10118238pjj.0.1671791638135;
        Fri, 23 Dec 2022 02:33:58 -0800 (PST)
Received: from localhost.localdomain ([2409:8a28:e6b:a810:15ee:4139:496a:7697])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090a430700b0020bfd6586c6sm1976207pjg.7.2022.12.23.02.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 02:33:57 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v6 1/2] sched/core: Minor optimize ttwu_runnable()
Date:   Fri, 23 Dec 2022 18:32:56 +0800
Message-Id: <20221223103257.4962-1-zhouchengming@bytedance.com>
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
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
v6:
 - Improve the comment in ttwu_runnable() per Steve. Thanks!

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
index 314c2c0219d9..607a5430b192 100644
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
+			 * it should preempt the task that is current now.
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

