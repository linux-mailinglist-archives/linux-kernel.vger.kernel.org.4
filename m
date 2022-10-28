Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C76610B5F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiJ1Hg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiJ1Hgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:36:54 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01C71ABA1E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:36:52 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id g12so5819764wrs.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B0XWvRu1fVdTl/QBgfNPXdbzdRti+Q21J6ft5UqwBWk=;
        b=ubrUnxCv59FBkGL/I9iLuY7+6esUZPHBfx+yAm96qCrlGCvlGAcCtfUVoiutjB6GPs
         g1fvjamhlKaJQb1aMbtj/MHtmroYKlcNJLvES3rZi7WuwrD/pB8YT/GqMS+sLiU6T1so
         3u8YAP15ZgGwPVgXIoFiEjHOO2VFZBMg+D86M7u5J4D5AOS9Ecd/SQ4jgutIgOFgrw/9
         NHYywtWvxg+tnHzGJ7xevv6Rj0U76deop0og/hDZaAWdWm4dXlMxhMFTlDyYd3I0db0+
         5HR4XYfZcGhSrxp7s7Ml9dIayVTdKG6a+Yz7pujJTiCTxrGW6PB0jevR2rtKTo5q6BpZ
         ouPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B0XWvRu1fVdTl/QBgfNPXdbzdRti+Q21J6ft5UqwBWk=;
        b=dAAZJzEbOGGj0hkoZDDV8lsACIWFApojTqjt62OL1HXWypPuNYX5cSaa6ivn4jLl1H
         xzJjDtOfK0o1Xt2sZ2bmciQO06c19ndPruuag2X78IzanzSInxPSvaJ9dCvcAoMYMHzY
         IJkolxs7OcaKNAUQm44k4eJZ5ZySphAKQQ/Ll2plbuO9LcNMJ8TwDyhFZtyIz9FGMYyk
         vyWYEQgz0HlcT48kVkWakL19qAfSqXxFoZ8Jldsg7vW5qlHNRY5rJYkXY1kWdhXRCLLm
         GIWsQXS2e1IVidONRT9rth2qYNhjsHgljNCnbWci52ArWiiVPe1KTYWGc45ZP6aP7L5w
         Dnww==
X-Gm-Message-State: ACrzQf0R7YDqXq//MEAqs9fAd582UjkXJcdYylm7MdLNggPLeRCGDnbV
        wpvwmJIIY5e5LD4a3l3GS4YtyA==
X-Google-Smtp-Source: AMsMyM6gVavraBwdPuLrNqmSY9HQhqxYYYOspr0RZcgqq+Bla5MliEo92ij1zgl1hBB9n90xXRxNMA==
X-Received: by 2002:adf:ba8f:0:b0:22c:def3:1179 with SMTP id p15-20020adfba8f000000b0022cdef31179mr34940134wrg.571.1666942611258;
        Fri, 28 Oct 2022 00:36:51 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:c12b:b448:f0a9:83ef])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b003b47e8a5d22sm7783129wmq.23.2022.10.28.00.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 00:36:49 -0700 (PDT)
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
Subject: [PATCH v6 2/9] sched: Introduce latency-nice as a per-task attribute
Date:   Fri, 28 Oct 2022 09:36:30 +0200
Message-Id: <20221028073637.31195-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221028073637.31195-1-vincent.guittot@linaro.org>
References: <20221028073637.31195-1-vincent.guittot@linaro.org>
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
index cdb84aec8ed5..5445a894babd 100644
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

