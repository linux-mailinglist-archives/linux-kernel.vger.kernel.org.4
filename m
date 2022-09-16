Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9148B5BA7BB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 10:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiIPID0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 04:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiIPIDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 04:03:17 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1FC901B1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 01:03:16 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h8so27741962wrf.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 01:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=zREa4GRmzGBOIzgpCLdUUrk2ik+zgQmFE/1EecWF98s=;
        b=IjWcihR8x/pv9hp6TJ1LwlTrgXv4ROqNYEeTSIjUfeZxoavGR2jLtb3MOqjTWkpOOD
         PxfA20mvMboBK4Bg1SXSdPdlM7zNz0voiUQf0xNc0PLaWeeUdNfhrghuAg7qA7gBE4hf
         AOlT7gYE4bOPFA7L6zifortH5ul6yWkej/t53n8wQZxcyuxHLhDM5O8sEi99meW/uMXY
         VNnu9EySyBC/LQ3mQPFy1ps7Wfuky4N/YOcD7jFUsAMaiSKzD4VGmuiCfOckeX06qsck
         DOA+UfXkbMZ+7trJbNpIOWpM5fOMlEliuIPjSwCJ326AEei3wg5qFaJy/0wzCk1YrOzc
         OQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zREa4GRmzGBOIzgpCLdUUrk2ik+zgQmFE/1EecWF98s=;
        b=fOoBWkztBzAgw8jn+OrZr53BZ3mW10qDioAkfSYDdIM4PBYGOa+r+cSVbAJx5KBT+x
         p1W2omUpGIH3vS0L5YIltjA4NN0e9h7fIsiKm3wberUAJqfx36zDVT2E5oKlTx95qtrN
         wmrxFpQi5KMrFd93A1OqVFDTTKToY7jHyGWpWQVyqjwX0qUAW7uSFc+YNJHwQnN4pbxd
         A6dJaeI3ZMIvSGT+BHvxaCzlWofuf84NTnCRBY2mCi1p7BUG3bwW5fnkogQoHThhsoio
         pfV2kP3DKRIJuMo486fFH0RrtZsCyPXd7ijafDyqma36MczGljTtBAlNt5Z0SnR4nSoL
         a9cg==
X-Gm-Message-State: ACrzQf2946oKGi/1xlMmcADxkMaJjFXcRtWLGTlNkjQFNaLoB31PrKKi
        PX/AX61GntlMEh6ovRziruz9+g==
X-Google-Smtp-Source: AMsMyM7iYasWvi0FhMzg8jSYSngsyPmNZ9M0SFLmnengM93KXWz61rIkWhXJgSjIaQMgvQvcUrhWFQ==
X-Received: by 2002:adf:f8ca:0:b0:226:e456:1896 with SMTP id f10-20020adff8ca000000b00226e4561896mr2051981wrq.177.1663315394724;
        Fri, 16 Sep 2022 01:03:14 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:9ab:1164:827a:1548])
        by smtp.gmail.com with ESMTPSA id c9-20020adffb49000000b00228dbf15072sm4418116wrs.62.2022.09.16.01.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 01:03:13 -0700 (PDT)
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
Subject: [PATCH v4 1/8] sched: Introduce latency-nice as a per-task attribute
Date:   Fri, 16 Sep 2022 10:02:58 +0200
Message-Id: <20220916080305.29574-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220916080305.29574-1-vincent.guittot@linaro.org>
References: <20220916080305.29574-1-vincent.guittot@linaro.org>
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

