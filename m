Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15F26C2A9C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjCUGpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjCUGpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:45:07 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3799EC0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:45:05 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c18so15036923ple.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679381105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hmo/in41rdsjqnIvRdoFRZ/GQusTqKDlZYzqHkG5bV8=;
        b=brlTlv10D4jrx36zyNqEvemH3HRxmkZ/MnVJO0AoSSmDWDLwTgTlknZezhxVA8jZ4l
         AZofYUQ2SWwhzvgpkvCo0vv6acHkPGUUkLBP3u7oVTevB4CjDIvaJZgnuNKvbNgF5EV+
         2kdIq353xDxaIhaaTo5X8ooT9WmwBIBm1SdRglJX7OsbQxjE+qYzgXbJFzxqDiXu/KRT
         nOhEFZCAwain/gs8HxrLBUm6UX/l0pSGI0/EH6yzCvW0RVdivfbvc9xHfnyjvJq8YtB5
         jVZNnPVD5MSYWJsLAzb0og0XQl9GWmhK2PLwbgfx/FBoPRf6YpdL2hALah1kll+7gTk6
         DPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679381105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmo/in41rdsjqnIvRdoFRZ/GQusTqKDlZYzqHkG5bV8=;
        b=lPFlP4uL/zGNolFa0TaaU7sREcBmM3mlU8VBA0xWL9eJcBgz+d0TH0SuJm3VTxbaF7
         VgrV+LqBtKTbD7n+jR+rq68sMs6frw0NEZIPCC9tUinVxi7N8MopgBu3h2DuCy9SKqCw
         PoU0srXbv6HUU04JFOx2GAsnFMu3QZRdZwYU6seaHElN+2ooFG6yV5fzSqpZSscmWVKK
         hJMEYgb3QxaLeXfoIs8Be8sM6XIvG/TLQse9AYS8CGH0xyHx9CjQvtVb0jXWPINci546
         09r1PtbtyrvgC0wHAe9LoX0/BjR2GpWDBNzZFEmoTcuCn+G0tGnT6LQc85uaCPjOlfK+
         dPMw==
X-Gm-Message-State: AO0yUKVNU5Gtv5kL11JE6atqQbmLFCgP7k1Z9w7IPZFOiOTbvPA58JRL
        5SAYNJHJPJPvvbTphA0UOwE=
X-Google-Smtp-Source: AK7set+MyHdj+9KrLosUzl+Oy2unZ/Rnoj2j+lJ5DW6//iOyRcCGmvM8FZDBLiz3pL68pcjgU9X74g==
X-Received: by 2002:a17:903:84c:b0:1a0:49eb:4cb2 with SMTP id ks12-20020a170903084c00b001a049eb4cb2mr1360863plb.13.1679381105394;
        Mon, 20 Mar 2023 23:45:05 -0700 (PDT)
Received: from C02FG34WMD6R.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902b60200b0019602274208sm7804335pls.186.2023.03.20.23.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 23:45:05 -0700 (PDT)
From:   wuchi <wuchi.zero@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched/core: Reduce cost of sched_move_task when config autogroup
Date:   Tue, 21 Mar 2023 14:44:59 +0800
Message-Id: <20230321064459.39421-1-wuchi.zero@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some sched_move_task calls are useless because that
task_struct->sched_task_group maybe not changed (equals task_group
of cpu_cgroup) when system enable autogroup. So do some checks in
sched_move_task.

sched_move_task eg:
task A belongs to cpu_cgroup0 and autogroup0, it will always belong
to cpu_cgroup0 when do_exit. So there is no need to do {de|en}queue.
The call graph is as follow.

do_exit
  sched_autogroup_exit_task
    sched_move_task
      dequeue_task
        sched_change_group
	  A.sched_task_group = sched_get_task_group (=cpu_cgroup0)
      enqueue_task

Performance results:
===========================
1. env
        cpu: bogomips=4600.00
     kernel: 6.3.0-rc3
 cpu_cgroup: 6:cpu,cpuacct:/user.slice

2. cmds
do_exit script:
```
for i in {0..10000}; do
    sleep 0 &
    done
wait
```
Run the above script, then use the following bpftrace cmd to get
the cost of sched_move_task:

bpftrace -e 'k:sched_move_task { @ts[tid] = nsecs; }
             kr:sched_move_task /@ts[tid]/
                { @ns += nsecs - @ts[tid]; delete(@ts[tid]); }'

3. cost time(ns):
 without patch: 43528033
 with    patch: 18541416
          diff:-24986617  -57.4%

As the result show, the patch will save 57.4% in the scenario.

Signed-off-by: wuchi <wuchi.zero@gmail.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a380f34789a2..1e7d6a8c3455 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10330,7 +10330,7 @@ void sched_release_group(struct task_group *tg)
 	spin_unlock_irqrestore(&task_group_lock, flags);
 }
 
-static void sched_change_group(struct task_struct *tsk)
+static struct task_group *sched_get_task_group(struct task_struct *tsk)
 {
 	struct task_group *tg;
 
@@ -10342,7 +10342,28 @@ static void sched_change_group(struct task_struct *tsk)
 	tg = container_of(task_css_check(tsk, cpu_cgrp_id, true),
 			  struct task_group, css);
 	tg = autogroup_task_group(tsk, tg);
-	tsk->sched_task_group = tg;
+
+	return tg;
+}
+
+static bool sched_task_group_changed(struct task_struct *tsk)
+{
+	/*
+	 * Some sched_move_task calls are useless because that
+	 * task_struct->sched_task_group maybe not changed (equals
+	 * task_group of cpu_cgroup) when system enable autogroup.
+	 * So do some checks in sched_move_task.
+	 */
+#ifdef CONFIG_SCHED_AUTOGROUP
+	return sched_get_task_group(tsk) != tsk->sched_task_group;
+#else
+	return true;
+#endif /* CONFIG_SCHED_AUTOGROUP */
+}
+
+static void sched_change_group(struct task_struct *tsk)
+{
+	tsk->sched_task_group = sched_get_task_group(tsk);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	if (tsk->sched_class->task_change_group)
@@ -10367,6 +10388,10 @@ void sched_move_task(struct task_struct *tsk)
 	struct rq *rq;
 
 	rq = task_rq_lock(tsk, &rf);
+
+	if (!sched_task_group_changed(tsk))
+		goto unlock;
+
 	update_rq_clock(rq);
 
 	running = task_current(rq, tsk);
@@ -10391,6 +10416,7 @@ void sched_move_task(struct task_struct *tsk)
 		resched_curr(rq);
 	}
 
+unlock:
 	task_rq_unlock(rq, tsk, &rf);
 }
 
-- 
2.20.1

