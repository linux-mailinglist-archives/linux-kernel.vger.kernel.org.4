Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563625B3897
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiIINDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiIINDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:03:18 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC95B8F1E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 06:03:17 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so4403200wmk.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 06:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=zREa4GRmzGBOIzgpCLdUUrk2ik+zgQmFE/1EecWF98s=;
        b=NJSSbH4laihrup5pfaCYKDg8K6C8DbhDQr5QpZFUyEyCC9LZkIX6/+BA1A3F/ix1BX
         gMc6lUK1qs0XoqT1sSze3zHEHRKEfFmsciTJtwAQc3jUFKXVy6xWno9cWHeps38FDC6O
         o3EBTWU5Q4AR5SWzWnk/UnJ2Cn3BFQm4zq07FdbotpvRX81E+oJ2J5zd0/5m/7t8Mxol
         Oo6EmN2d53s5CorKgvkgQx5tQQt1AeLrP6wQEaTS9gm3gKenqQBbbJ6bo7KXuCWrShKK
         RXJZxQNwHEKYdzZGNliQCNM61WQsQCoDfxzddZTDMZSputZ/b4Xk6c6YcX+0BmnrHUrE
         Kk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zREa4GRmzGBOIzgpCLdUUrk2ik+zgQmFE/1EecWF98s=;
        b=kwiPDOqY7BAk+8uLndV3C0e8xoAkJ6voWTlz0I/4TJGapetUo7a+Wd36v6CM1uJq9m
         tA22xon9hM7QK74RyNR3s+AR/eD1Bwe+wmHnT3BuVuI47yqy2jgQ8IF7VnZVJgBrLbsV
         uFMfu8DIEsYPQr9suokeo7ldMwzRdn8q1I9welmYKp1E2ZRi7UtuvaEpBzHdHhTw/UyD
         s1nq1ROYGuZvrOtp6C2gPYnH/ZEbZVq2LqMph//mzhgI1M7ZfcaKhlaGUW++yVpAzgja
         4II0lgiieIzJa0Sm9nvOVjnN0/AlVWIHGb9xrWPvLeVfJG29Yu7ySkPQlS33qTIRPulZ
         PoQA==
X-Gm-Message-State: ACgBeo0ezJO+BwhqQ7uldasyDonvK19oBQGINh7RLDqHi8gh6uXhbcA7
        Jy/3mg5/zsfYhdWdNrAb9ekUKg==
X-Google-Smtp-Source: AA6agR6qCCPJOrw/4kBOZ9wBhNGB5IYvJMhF7B0Rh3diwo2uOj6ZQnX41ZZssaHKOTvh3g0s8tS2sQ==
X-Received: by 2002:a05:600c:1694:b0:3b4:6205:1f95 with SMTP id k20-20020a05600c169400b003b462051f95mr822977wmn.151.1662728595449;
        Fri, 09 Sep 2022 06:03:15 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:c6e:e86:ab92:92b7])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c3b0a00b003a5f4fccd4asm569909wms.35.2022.09.09.06.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 06:03:14 -0700 (PDT)
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
Subject: [PATCH v3 1/8] sched: Introduce latency-nice as a per-task attribute
Date:   Fri,  9 Sep 2022 15:03:02 +0200
Message-Id: <20220909130309.25458-2-vincent.guittot@linaro.org>
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
index 88b8817b827d..a0adb55efa1c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -773,6 +773,7 @@ struct task_struct {
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
index 74130a69d365..b927269b84f9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -124,6 +124,24 @@ extern int sched_rr_timeslice;
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

