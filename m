Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3835662A01D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237972AbiKORT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiKORTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:19:12 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08A415FED
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:19:03 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id h186-20020a1c21c3000000b003cfe48519a6so613264wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wENRkgQEb1UIrFAJEzEMVqSnf8X2lmPttrPLcOcx98M=;
        b=V8A8G6ryEkY5Zlffpr5423h5AkfoG7/Qhh7Vlc9PP2tE1WGksWc1eHVvpKMWVAlMIP
         LC2+wujeeQCObNicxOUGyWmP+3mepaba6VKelY6mL1fOpMT4RJfQuDFU5IiFtFj34H8H
         9Ivypn2vI8GqdeKikXiN0ZNL59NXJIOsMZToD+8SRuqnm8DTtnKgADjDp6k2k0Ar+o+Z
         FpmrRoKOri2cs7JrU4I/2SYXHZ8d6dDq36ZQqrRDRVhRrqJqnzFvxrmhMOsks2aDyDPf
         YnRPygFpUMxOZhJDIxdASEgxbJb8x3cW2tO3ieCbqCmsZ8/g5XrPi9AgTRnkUaZ5ufRT
         8ozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wENRkgQEb1UIrFAJEzEMVqSnf8X2lmPttrPLcOcx98M=;
        b=JndTdytMHVyNLCs5J8hAaLFjnL1c6KnKQAfKkU4sMusc+qt329UG2QDrZ2zI7ervLS
         sCgu/S1qLy0AAwqJ0JYcTi+Zcq1kdC2KfGBKL/E2hPoYODNHDMS0B/6i5/vaPUGlq1y2
         ip8WbKK49wxFy1V6qw1LCWmia5MwK1V3REZWmbrCqJ5UBQqLEb5JXCSBIrVR7oArLdQG
         xt9GF9yeWCCFchsMQdVd5CmHqlCRkZ+szXdEE/NrI0DOZU7JbIVxiXWgmGAG1pX8T7ck
         J/xxKseipjGQa61V9nPHSBjMN7KNhDtpztnrdRu16BQqkkPqZOHjG5k8EPNAt/DTbMpo
         7A1Q==
X-Gm-Message-State: ANoB5pmu/E3pyZqcTDEQS6T7b3aWrfgPzjN6lG+cihUgj4AZEjKzyCVD
        HeEDGeCzDNCmlQACv7lpvAm/0g==
X-Google-Smtp-Source: AA0mqf7nMTe6guElveXVE/wvqrl5omSDffFoegmqrDIlPfixEcwJrdP7oBML4YZ06ibMbWJkO6Bz/Q==
X-Received: by 2002:a05:600c:1d0a:b0:3cf:735c:9d5a with SMTP id l10-20020a05600c1d0a00b003cf735c9d5amr2297722wms.113.1668532742172;
        Tue, 15 Nov 2022 09:19:02 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:91c8:7496:8b73:811f])
        by smtp.gmail.com with ESMTPSA id bg40-20020a05600c3ca800b003cf78aafdd7sm16846461wmb.39.2022.11.15.09.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 09:19:01 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v9 2/9] sched: Introduce latency-nice as a per-task attribute
Date:   Tue, 15 Nov 2022 18:18:44 +0100
Message-Id: <20221115171851.835-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221115171851.835-1-vincent.guittot@linaro.org>
References: <20221115171851.835-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Parth Shah <parth@linux.ibm.com>

Latency-nice indicates the latency requirements of a task with respect
to the other tasks in the system. The value of the attribute can be within
the range of [-20, 19] both inclusive to be in-line with the values just
like task nice values.

latency_nice = -20 indicates the task to have the least latency as
compared to the tasks having latency_nice = +19.

The latency_nice may affect only the CFS SCHED_CLASS by getting
latency requirements from the userspace.

Additionally, add debugging bits for newly added latency_nice attribute.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
[rebase, move defines in sched/prio.h]
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/sched.h      |  1 +
 include/linux/sched/prio.h | 18 ++++++++++++++++++
 kernel/sched/debug.c       |  1 +
 3 files changed, 20 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 23de7fe86cc4..856240573300 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -784,6 +784,7 @@ struct task_struct {
 	int				static_prio;
 	int				normal_prio;
 	unsigned int			rt_priority;
+	int				latency_nice;
 
 	struct sched_entity		se;
 	struct sched_rt_entity		rt;
diff --git a/include/linux/sched/prio.h b/include/linux/sched/prio.h
index ab83d85e1183..bfcd7f1d1e11 100644
--- a/include/linux/sched/prio.h
+++ b/include/linux/sched/prio.h
@@ -42,4 +42,22 @@ static inline long rlimit_to_nice(long prio)
 	return (MAX_NICE - prio + 1);
 }
 
+/*
+ * Latency nice is meant to provide scheduler hints about the relative
+ * latency requirements of a task with respect to other tasks.
+ * Thus a task with latency_nice == 19 can be hinted as the task with no
+ * latency requirements, in contrast to the task with latency_nice == -20
+ * which should be given priority in terms of lower latency.
+ */
+#define MAX_LATENCY_NICE	19
+#define MIN_LATENCY_NICE	-20
+
+#define LATENCY_NICE_WIDTH	\
+	(MAX_LATENCY_NICE - MIN_LATENCY_NICE + 1)
+
+/*
+ * Default tasks should be treated as a task with latency_nice = 0.
+ */
+#define DEFAULT_LATENCY_NICE	0
+
 #endif /* _LINUX_SCHED_PRIO_H */
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 1637b65ba07a..68be7a3e42a3 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1043,6 +1043,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 #endif
 	P(policy);
 	P(prio);
+	P(latency_nice);
 	if (task_has_dl_policy(p)) {
 		P(dl.runtime);
 		P(dl.deadline);
-- 
2.17.1

