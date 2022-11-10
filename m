Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2877662489F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiKJRua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiKJRuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:50:23 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC04303FF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:50:21 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id k8so3390506wrh.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kTjYYbmOvEwchQQqZbLCLNfz1JMqxHsTlxBK50VB9/E=;
        b=qH89BUBgJl4VFhynofvsQ2sQni4rCZBBOn8OKk2XdXbz/RsioKXkLySMkmDMKVgDyj
         RU5rLwRY2brdjghKJ/NkmM7ayZBNvmf8ZCEHLj7DcLLZb4815z1dXSo1xxpXpsKGuIVJ
         owqapyZC2XspP1M2u38vfzoLOzTUTeOjbfzR0kxls4ZEBD+OL3dzweM2sRzLF6O1Ihx0
         csjk5jKZW+TnCPTpATOo5/PSzrBMn7GKELzlUsI/QGudky0PDAh0bpGP9TfN5fivqI5t
         Em0u87DGeW0ouPlOAsYOTFKxK+O/9cS1i41AL2EbyFg1UYfQ3wueMGD1Y17NZgap7Yb6
         MDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kTjYYbmOvEwchQQqZbLCLNfz1JMqxHsTlxBK50VB9/E=;
        b=LcyJwgUa0BiELHzdnpzp5zH0Nnk1kp/IqI+NAwCI+CS9tg5rmL0rPlJ6XFphfPXhbw
         YCZDaMRrRvTRzcyxIRcaKjQNJXjN1hoUvLMsMoNys+2bGxg9qr2qcVca9UeHBiPDGmyz
         49Ed2wcU6HzKhC4KHjaEjkVssVo/sYGcIw4mb1iMqFyMYKgn6uVPs5FCxxh7+/WHbQ+s
         /3/WLkNn/Gr4f/bcIaynC6rennmuhm/9z9uypN/8sLt0A5ubGeSNSnPqJKdIFz8hQbsw
         JqdEkJVCQ+GhBPi5vLy+8CYsiJmtncP4z5/wAUcQkNi7MbP7NYKvZYUvlWBQdjZNM5XQ
         h6fw==
X-Gm-Message-State: ACrzQf26CgsCvZwpespXzmK5OKq9Yz12+6TEYJ4fRWVUhUD+S4CGy4jz
        LzGwI0dsl94rddbAHXEnQGs6yw==
X-Google-Smtp-Source: AMsMyM5ChPi/CeTgB/OprgW8mHUmZgQ8pkXAKNgbSj0AyDoVAW/Cc46FldL+QGHVWms9und/ppnUxA==
X-Received: by 2002:adf:d226:0:b0:235:d9ae:1de9 with SMTP id k6-20020adfd226000000b00235d9ae1de9mr43167752wrh.599.1668102619818;
        Thu, 10 Nov 2022 09:50:19 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:342a:468f:562a:9cc4])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c4e8600b003cfc02ab8basm6514677wmq.33.2022.11.10.09.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 09:50:18 -0800 (PST)
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
Subject: [PATCH v8 2/9] sched: Introduce latency-nice as a per-task attribute
Date:   Thu, 10 Nov 2022 18:50:02 +0100
Message-Id: <20221110175009.18458-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221110175009.18458-1-vincent.guittot@linaro.org>
References: <20221110175009.18458-1-vincent.guittot@linaro.org>
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

