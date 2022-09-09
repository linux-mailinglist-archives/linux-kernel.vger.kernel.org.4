Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97AF5B3875
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiIINEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiIIND1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:03:27 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FDE1023C6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 06:03:26 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id e15so162541wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 06:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=Jcs+6ZlLyYHw9FZ1AFMfUXk9PpNg2BgTfj6tBszyRVU=;
        b=UFxGNEstPxa21k3IArpKNLRgJqLfsyPG4/TX/yU6gyonDdKnIIUTc2b5/ObszOyMiN
         SgMbl1XnoxfgQ9YdJLXqGGCGgK9idzBUN2Pguy5sl7LXPybxP8VY1a13B089GoalrO9d
         anzzerxxkyO+MzQmajvKG2pfmTBev8mYwVv3V0Y8hqjN4BVDneWzM/hlq+c+CCeWMV0b
         dVsezHL1EMS1LNbdCnw6dlH+QOT9wUKb3mWd/SekkTvMZTgwdXavMyPc5NiZLa42Bj7I
         A9r+MqUCrJXaA6OigL1dqjNFdXItpiq+d4c9qap+Bdlhl0EqXImSP5jHoCaN0eOe55Qp
         KHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Jcs+6ZlLyYHw9FZ1AFMfUXk9PpNg2BgTfj6tBszyRVU=;
        b=UrSIpVxfW+l/YfyTUPh8ktgmEMWwvaC5zlAHUE+PMgdcIVleDVb7zSYXq2wLThnrJO
         W22DRZYCa/HuFsHyJM5U5+D4cEhj9NoMkvRWW7wi83SUpZK6mCqQoYhPGQ1SJjpzRzzy
         1W2fPAKP9ZnkNSPjcmuttD6b004qT4/KJiD97Jj+s1bOfGMQLQPpRbUEgscEz95BoeVM
         21lK0gJJaomOpu4gL2JVKtwH5gj2r73/T1lsE9CJMVhgzo786Fx4F54bvmdA3pDywmQk
         CJ/q8+pLKf2ZDPOBqxa+55UVMiRUtLfmRKx2EfSVap9eawi7jy8rLNd1nN2xDYVwWqc0
         cXFw==
X-Gm-Message-State: ACgBeo1xgosZDfDq+Ms6dkUoCy740dAwaA1EuV7TSbwnFEgeyOQBK+hU
        xkgOjNvjJUz9Ak+OtPP7LfZMjA==
X-Google-Smtp-Source: AA6agR5P3QhcE3DPZyQgW1JiWRSA2pMst2eXi520E3ZRp0G03fJgX3Rz9MfGsyFj6oaw6YEHfyaLLQ==
X-Received: by 2002:a05:600c:1e8b:b0:3a6:1a09:2a89 with SMTP id be11-20020a05600c1e8b00b003a61a092a89mr5319379wmb.108.1662728605057;
        Fri, 09 Sep 2022 06:03:25 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:c6e:e86:ab92:92b7])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c3b0a00b003a5f4fccd4asm569909wms.35.2022.09.09.06.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 06:03:24 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 6/8] sched/fair: Add sched group latency support
Date:   Fri,  9 Sep 2022 15:03:07 +0200
Message-Id: <20220909130309.25458-7-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220909130309.25458-1-vincent.guittot@linaro.org>
References: <20220909130309.25458-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Task can set its latency priority, which is then used to decide to preempt
the current running entity of the cfs, but sched group entities still have
the default latency offset.

Add a latency field in task group to set the latency offset of the
sched_eneities of the group, which will be used against other entities in
the parent cfs when deciding which entity to schedule first.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c  | 24 ++++++++++++++++++++++++
 kernel/sched/fair.c  | 33 +++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  4 ++++
 3 files changed, 61 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 13cf794708ee..bfea862a3588 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10860,6 +10860,19 @@ static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
 {
 	return sched_group_set_idle(css_tg(css), idle);
 }
+
+static s64 cpu_latency_read_s64(struct cgroup_subsys_state *css,
+			       struct cftype *cft)
+{
+	return css_tg(css)->latency_offset;
+}
+
+static int cpu_latency_write_s64(struct cgroup_subsys_state *css,
+				struct cftype *cft, s64 latency)
+{
+	return sched_group_set_latency(css_tg(css), latency);
+}
+
 #endif
 
 static struct cftype cpu_legacy_files[] = {
@@ -10874,6 +10887,11 @@ static struct cftype cpu_legacy_files[] = {
 		.read_s64 = cpu_idle_read_s64,
 		.write_s64 = cpu_idle_write_s64,
 	},
+	{
+		.name = "latency",
+		.read_s64 = cpu_latency_read_s64,
+		.write_s64 = cpu_latency_write_s64,
+	},
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
@@ -11091,6 +11109,12 @@ static struct cftype cpu_files[] = {
 		.read_s64 = cpu_idle_read_s64,
 		.write_s64 = cpu_idle_write_s64,
 	},
+	{
+		.name = "latency",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_s64 = cpu_latency_read_s64,
+		.write_s64 = cpu_latency_write_s64,
+	},
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a20eadb0af97..6cc4f2a9725d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11769,6 +11769,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 		goto err;
 
 	tg->shares = NICE_0_LOAD;
+	tg->latency_offset = 0;
 
 	init_cfs_bandwidth(tg_cfs_bandwidth(tg));
 
@@ -11867,6 +11868,9 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 	}
 
 	se->my_q = cfs_rq;
+
+	se->latency_offset = tg->latency_offset;
+
 	/* guarantee group entities always have weight */
 	update_load_set(&se->load, NICE_0_LOAD);
 	se->parent = parent;
@@ -11997,6 +12001,35 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 	return 0;
 }
 
+int sched_group_set_latency(struct task_group *tg, long latency)
+{
+	int i;
+
+	if (tg == &root_task_group)
+		return -EINVAL;
+
+	if (abs(latency) > sysctl_sched_latency)
+		return -EINVAL;
+
+	mutex_lock(&shares_mutex);
+
+	if (tg->latency_offset == latency) {
+		mutex_unlock(&shares_mutex);
+		return 0;
+	}
+
+	tg->latency_offset = latency;
+
+	for_each_possible_cpu(i) {
+		struct sched_entity *se = tg->se[i];
+
+		WRITE_ONCE(se->latency_offset, latency);
+	}
+
+	mutex_unlock(&shares_mutex);
+	return 0;
+}
+
 #else /* CONFIG_FAIR_GROUP_SCHED */
 
 void free_fair_sched_group(struct task_group *tg) { }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c4beddb58ebd..117b23dfb912 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -406,6 +406,8 @@ struct task_group {
 
 	/* A positive value indicates that this is a SCHED_IDLE group. */
 	int			idle;
+	/* latency constraint of the group. */
+	int			latency_offset;
 
 #ifdef	CONFIG_SMP
 	/*
@@ -519,6 +521,8 @@ extern int sched_group_set_shares(struct task_group *tg, unsigned long shares);
 
 extern int sched_group_set_idle(struct task_group *tg, long idle);
 
+extern int sched_group_set_latency(struct task_group *tg, long latency);
+
 #ifdef CONFIG_SMP
 extern void set_task_rq_fair(struct sched_entity *se,
 			     struct cfs_rq *prev, struct cfs_rq *next);
-- 
2.17.1

