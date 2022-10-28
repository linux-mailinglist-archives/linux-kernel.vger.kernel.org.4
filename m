Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0CE610D62
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJ1JfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiJ1JfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:35:04 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7D26565F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:34:59 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so3298061wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kTjYYbmOvEwchQQqZbLCLNfz1JMqxHsTlxBK50VB9/E=;
        b=cnPkAzvA7ZunlGQgpe9Oq+kAlUCjdMbfFqvsgXSX/EWKP3acuINt9hk5sqL4jkcxF4
         axbd3Yz6hs7Vp4VEhzoevNhSgPBKOK5kVUiTArZW+Tw8tIcHhY+GzNSwh4BFB0zwE0/E
         ewNjGWn4ABPBWjMrAgjw6Y3+yOfNyVOXeVoXW6a4NBPBujlut854iDR+PjkzjZKDPDVr
         hJ6NJWUCW3eAjTJmnklFGcGNmZBoPc7q/UyoIA8uQ2H6e62x1Xhfx+0me2BZ8I2vAb18
         VOjd0as/3PRniDM7xgOc27MTaAK0w30y0dZWrdEn649JOYFiLiqeUKGvkQ8DEELMLzCg
         xY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kTjYYbmOvEwchQQqZbLCLNfz1JMqxHsTlxBK50VB9/E=;
        b=w+nzGlZzj0A9uS+6RX3OhT2SX7RcrhbS0nDWXAE6jIO+GpwVqV5kIGg0nw7tioNiGZ
         WQ0tG6HtQsoOfLP4XC62xE4lmu40FHAPmlhhbwwdlPOKGmJaba6kFhKrya29+d7y3Qle
         rSoO9Ydts1Hz7tKkV1YttfKt4nbe5cbXZmthIgSgY+bOylHoUQZHzHy9SAx/X5V1cAGR
         SzTlCFkuQUzOS6lm7H/ENFZI64+va1O+UXiEQzrANl6UgQCcYXCQv0nHJ+GCcK6g6ipe
         Eiudwhp9DPrQ3fQ6SaF2N/x21qV+q1D5lmObCDW/CwyS0vw4xF83mzM3755BZ7OTNmln
         ZD1Q==
X-Gm-Message-State: ACrzQf3HM/nwhsN7Dgo+oP4HsDcDQm0FlmzOg+TbK+Lce1peAUftxo7z
        LtC4pf6WwKCpyeL73B6on17I0Q==
X-Google-Smtp-Source: AMsMyM7uaBdQBF2KnyeED9qZeu6WSrt/3Vdl5NTq8Z56wYtYvR4Gnsgk3ymbyRXY66OjoWg+LOIOag==
X-Received: by 2002:a05:600c:3b17:b0:3c6:eaed:675 with SMTP id m23-20020a05600c3b1700b003c6eaed0675mr8864458wms.129.1666949698364;
        Fri, 28 Oct 2022 02:34:58 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:c12b:b448:f0a9:83ef])
        by smtp.gmail.com with ESMTPSA id k3-20020a05600c1c8300b003c6b7f5567csm10909426wms.0.2022.10.28.02.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 02:34:57 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v7 2/9] sched: Introduce latency-nice as a per-task attribute
Date:   Fri, 28 Oct 2022 11:33:56 +0200
Message-Id: <20221028093403.6673-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221028093403.6673-1-vincent.guittot@linaro.org>
References: <20221028093403.6673-1-vincent.guittot@linaro.org>
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
[rebase]
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/sched.h |  1 +
 kernel/sched/debug.c  |  1 +
 kernel/sched/sched.h  | 18 ++++++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 15e3bd96e4ce..6805f378a9c3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -783,6 +783,7 @@ struct task_struct {
 	int				static_prio;
 	int				normal_prio;
 	unsigned int			rt_priority;
+	int				latency_nice;
 
 	struct sched_entity		se;
 	struct sched_rt_entity		rt;
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index bb3d63bdf4ae..a3f7876217a6 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1042,6 +1042,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 #endif
 	P(policy);
 	P(prio);
+	P(latency_nice);
 	if (task_has_dl_policy(p)) {
 		P(dl.runtime);
 		P(dl.deadline);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 14879d429919..4bf9d7777f99 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -125,6 +125,24 @@ extern int sched_rr_timeslice;
  */
 #define NS_TO_JIFFIES(TIME)	((unsigned long)(TIME) / (NSEC_PER_SEC / HZ))
 
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
 /*
  * Increase resolution of nice-level calculations for 64-bit architectures.
  * The extra resolution improves shares distribution and load balancing of
-- 
2.17.1

