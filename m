Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA875E93AC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 16:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiIYOlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 10:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiIYOlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 10:41:17 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CDE1105
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 07:41:16 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id d12-20020a05600c3acc00b003b4c12e47f3so2392968wms.4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 07:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=oSSdXMqnb9jEQAlol2YdyD+HZ/O1tyTS1XWv0Aq1bWg=;
        b=cPHEcE8rvpBq+wrpZUPeVwFolO1d4AqBpn5RK/4Q2kFuaLwKE4flQC0JZ3Sx1VYUwn
         VYyg8Ymx9i5eC1JTiKu2fBkqUhaKBC1tE81t15VmqMOqndvj6SjNpBiDN7/rtTZwAfSr
         L/g9f2jOm8HXkKgEQWLCuP+Jx1mDr1zdmiYykDm3WHSvrU1DTudDEP60FXLWqqdh0fzk
         n+B0Gc7TTeZcxy5IEwfrnZ2+VtvqjV3x68Bwjyau1NNd+4OOAF0ip52hq2hemdsIjl4T
         u+TljLKLnf8ScuEXRq1+iWixRLSKZU4wlURs2ZfRdkIw+ofduqOHRlf1ix7Jx0YGgtGS
         SzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=oSSdXMqnb9jEQAlol2YdyD+HZ/O1tyTS1XWv0Aq1bWg=;
        b=Bv3KHrFQVIIFVyUCpv0mVvvywinQWsYBLQLN0Ea7o6qJxOLRPjKpmQ/dEA4oQoR+1t
         D9xKBD0sVMZgWF8DBAFRyKyUZ4rHP9EaRYj6BTXtd1GUEwy2JMQMOmZhjdTO4q3nzpWQ
         To0mMK0Qy9D5oMEEw6bwm6uteJ9Sr8So/uzCIeyQhvH/S6PzdmGB6SfqYxwp921Uvj/H
         RsOoro4mmZyM5lCTCdq0j58iyUz24B4cQ58CDmJdtkRGgfDpbmMD5MVR+cJNPuIJe/b9
         Azg/cYYjZNtzYf/WkR9yH8aGI6gkx025yPb3PrCoDo0ICxTgkJmj0JgrgrlBwMIvNPpH
         vgkA==
X-Gm-Message-State: ACrzQf3MajZihhH+iHjjuQFHjXuCKx5MbGqfasQG6mKe2NzXXwYAF4fq
        ZT3rwxHDKRSq0jHumk2ByGSgCg==
X-Google-Smtp-Source: AMsMyM6nl1MuYVtLHYyjYzrrUXNiLpdSNYU6mn3qAP8bNIBYG5B1PRxaBBiyiQluWfURdtdLz4IOLg==
X-Received: by 2002:a7b:cbc4:0:b0:3b4:fd67:d70d with SMTP id n4-20020a7bcbc4000000b003b4fd67d70dmr13819004wmi.98.1664116874616;
        Sun, 25 Sep 2022 07:41:14 -0700 (PDT)
Received: from localhost.localdomain (91-160-61-128.subs.proxad.net. [91.160.61.128])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c3b0a00b003b47b913901sm20774761wms.1.2022.09.25.07.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 07:41:13 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v5 1/7] sched: Introduce latency-nice as a per-task attribute
Date:   Sun, 25 Sep 2022 16:39:02 +0200
Message-Id: <20220925143908.10846-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220925143908.10846-1-vincent.guittot@linaro.org>
References: <20220925143908.10846-1-vincent.guittot@linaro.org>
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
index 1fc198be1ffd..eeb6efb0b610 100644
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

