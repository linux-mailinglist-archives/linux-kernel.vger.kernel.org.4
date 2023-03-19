Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2396BFFE8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 08:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjCSH5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 03:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCSH5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 03:57:09 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AA0EF93
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 00:56:51 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id p20so9477949plw.13
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 00:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679212611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pZUnST3j21m9F9a4UvCxqzWQ39NSngcoRf1fNjlPMo0=;
        b=FCcBCCENooJi8ff/XjxTocVx4aMrEp949GQloXOFJwFmaSniqIumwl/FfGil8QZoBS
         VjFYllNxi0mhg52pG17LuMdNRyvkt69qvEEpEI71390aK9ugaiwnbjacM1SDOcvCUDVS
         JLHte1i/kvKD5Dxf7G/WvCUrkChH5CCAuWlxryrWo8Gk1CpOAm/q/JXtsJ7bKRrshpJH
         hxrs/MDFqDQjy/Bh/Sr9Ov55FYgDp9HsLo1AIHU7+EhmHxQFD/5rqoGHX84hmT+ldCX0
         OJ150t+Y6ZISDY2aOXRlLdmVZbFnSkg62AHQ2hp10K3Wj8k1QFHk957f1peVB0VfK1sW
         v4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679212611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZUnST3j21m9F9a4UvCxqzWQ39NSngcoRf1fNjlPMo0=;
        b=aZJQkHIKjpr9sgf/VUmxqf1ZIP/cLWwEkXSnIuxDU9ZDgcddcTlaa0wSwM0WphsaQm
         fjjb/0lqQYYR7DQgM2qrszE+D+pc3lb3Otc+8q3gOWyPlZsheTpw++KU8FhnoaiVxCjO
         bOrEegmQfccDGeQAq/HNeO4GvpFebcau7qLIFsPQNX+e1vOFIHWBU3tLsRJqnOv0k26U
         rqJyIjw/aTDtHpKuJY5RVk+UsKyRASYC0A7DrXNtzIniqvAg8D7HiYzfZI9NJPzt/nNC
         H/PkZbdrcoklzkJC/5cuQFwLlXChNZRHY35uCEDo+5kQT1P767nlSsaGeqkSb96BcPpp
         FipA==
X-Gm-Message-State: AO0yUKXUHQieh6MqB5TjqRO5I7RbYCI+z82H1GQEfbn4l3RlPnPJ1Zg6
        Ke3Wul4K2evXvoN3XkVciH7Tb1FFhJayNw==
X-Google-Smtp-Source: AK7set8FVshNuXDGzOJ9FodmCA2DqcnrLDDTSitfbXn4m9bUvd/g5hLKtxWYh+uZRLP/aHIPlXwbig==
X-Received: by 2002:a17:902:f681:b0:19e:8076:9bd2 with SMTP id l1-20020a170902f68100b0019e80769bd2mr15021430plg.17.1679212610839;
        Sun, 19 Mar 2023 00:56:50 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id p11-20020a170902bd0b00b001994e74c094sm4307797pls.275.2023.03.19.00.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 00:56:50 -0700 (PDT)
From:   wuchi <wuchi.zero@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/core: Reduce cost of sched_move_task when config autogroup
Date:   Sun, 19 Mar 2023 15:56:43 +0800
Message-Id: <20230319075643.28312-1-wuchi.zero@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
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

Some sched_move_task calls of autogroup is useless when the
task_struct->sched_task_group isn't changed because of task_group
of cpu_cgroup overlay task_group of autogroup. The overlay key codes
are as follows:

sched_cgroup_fork->autogroup_task_group->task_wants_autogroup
sched_change_group->autogroup_task_group->autogroup_task_group

sched_move_task eg:
task A belongs to cpu_cgroup0 and autogroup0, it will always to
cpu_cgroup0 when doing exit. So there is no need to do {de|en}queue.
The call graph is as follow.

do_exit
  sched_autogroup_exit_task
    sched_move_task
      dequeue_task
        sched_change_group
	  A.sched_task_group = sched_get_task_group
      enqueue_task

So do some check before dequeue task in sched_move_task.

Signed-off-by: wuchi <wuchi.zero@gmail.com>
---
 kernel/sched/core.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a380f34789a2..acc9a0e391f4 100644
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
+	 * Some sched_move_task calls of autogroup is useless when the
+	 * task_struct->sched_task_group isn't changed because of task_group
+	 * of cpu_cgroup overlay task_group of autogroup. so do some check
+	 * before dequeue task in sched_move_task.
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
@@ -10369,6 +10390,9 @@ void sched_move_task(struct task_struct *tsk)
 	rq = task_rq_lock(tsk, &rf);
 	update_rq_clock(rq);
 
+	if (!sched_task_group_changed(tsk))
+		goto unlock;
+
 	running = task_current(rq, tsk);
 	queued = task_on_rq_queued(tsk);
 
@@ -10391,6 +10415,7 @@ void sched_move_task(struct task_struct *tsk)
 		resched_curr(rq);
 	}
 
+unlock:
 	task_rq_unlock(rq, tsk, &rf);
 }
 
-- 
2.20.1

