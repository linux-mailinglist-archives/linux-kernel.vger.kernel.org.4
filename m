Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2F56FF971
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 20:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239289AbjEKSU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 14:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239208AbjEKSUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 14:20:04 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8844740ED
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 11:19:55 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-644d9bf05b7so4507884b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 11:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683829195; x=1686421195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkYqgFUcqMwizBouzYCG0qlgoOAQQIMFoBJwBvsb0Vs=;
        b=GjrHUo2ELF5xX6tAJ6WCz3klJ0+A896W4F4H3/SRCD+B3wCrensN8UKMgygN2Iixiq
         Hm7POiTzcSOEOK1tEgviFTB3lwTeQ3HKnbeCqSbTy0KY+U2WL/MTLnaX74v0bqkPg9/d
         +VfXmmg5cyILkqqAtcSlNMcFq8GkWDpTZIu6+iawBItBCddnYwF512URFvaNBcm2Okxj
         CUYM52k+LdvsqFo0a68PkdmPb/GarXaYafROcpzoiFbEaCoh+Zrrw0Y6ikY6VIEuDJlc
         Slo1ttHJBzLpPYnAWPopfKQVbdSTksiSuDMg8ipFCBHnklXp0BoPJsZIY70t7RS9ns7l
         2gkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683829195; x=1686421195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JkYqgFUcqMwizBouzYCG0qlgoOAQQIMFoBJwBvsb0Vs=;
        b=Jsgz9Ftg3T+YjxynCQK7LTOj60RjwF+zKjyWjYkS5qE/Vr+q6FVqBWM50hWmZcmEg+
         nbWFHhlo2Dpuro1E/GAowBCiBcMxKS9qtohEMKmRZI69bu987nyRK+/ZLIs9AkG954UK
         272Ikuj0r+i+3+7sncg2p+LVjCo4Sx+BwMjzwMMkPLoefpgAMqUwHW8gO5MKL0UzVbhH
         Q+XWbOIfnYA8WTyU1TNZCZNLTz+R1oM5lKsnkxeyMWHAymWVLH7uoyJkOs3yn2lJJjme
         GigEwTBtd/gIYbC85bAiw10MsQil8hr/7sWMDprMPMzeJYQlLMIQojZEgzXEaxw1qVcH
         dtZQ==
X-Gm-Message-State: AC+VfDw2khoybVMgHnZfN0FBGiU6fANRkcsm/Lo8tBEXRi4uTHFkMYqw
        vS5dAj6E6adN3hqkcWFmOZg=
X-Google-Smtp-Source: ACHHUZ44SzTyICYITfxsgSVnIjj3SySgJUibfB0jBhxGMl9cJBHMxqXCCxJn/2VtxR+YNTmyOUHDFg==
X-Received: by 2002:a05:6a00:1950:b0:647:2ce5:57c4 with SMTP id s16-20020a056a00195000b006472ce557c4mr12932714pfk.5.1683829194472;
        Thu, 11 May 2023 11:19:54 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id h5-20020a62b405000000b0062dd9a8c1b8sm5593895pfn.100.2023.05.11.11.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:19:54 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 7/7] workqueue: Track and monitor per-workqueue CPU time usage
Date:   Thu, 11 May 2023 08:19:31 -1000
Message-Id: <20230511181931.869812-8-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230511181931.869812-1-tj@kernel.org>
References: <20230511181931.869812-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that wq_worker_tick() is there, we can easily track the rough CPU time
consumption of each workqueue by charging the whole tick whenever a tick
hits an active workqueue. While not super accurate, it provides reasonable
visibility into the workqueues that consume a lot of CPU cycles.
wq_monitor.py is updated to report the per-workqueue CPU times.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 Documentation/core-api/workqueue.rst | 38 ++++++++++++++--------------
 kernel/workqueue.c                   |  3 +++
 tools/workqueue/wq_monitor.py        |  9 ++++++-
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index a389f31b025c..a4c9b9d1905f 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -354,25 +354,25 @@ Monitoring
 Use tools/workqueue/wq_monitor.py to monitor workqueue operations: ::
 
   $ tools/workqueue/wq_monitor.py events
-                              total  infl CPUitsv  CMwake  mayday rescued
-  events                      18545     0       0       5       -       -
-  events_highpri                  8     0       0       0       -       -
-  events_long                     3     0       0       0       -       -
-  events_unbound              38306     0       -       -       -       -
-  events_freezable                0     0       0       0       -       -
-  events_power_efficient      29598     0       0       0       -       -
-  events_freezable_power_        10     0       0       0       -       -
-  sock_diag_events                0     0       0       0       -       -
-
-                              total  infl CPUitsv  CMwake  mayday rescued
-  events                      18548     0       0       5       -       -
-  events_highpri                  8     0       0       0       -       -
-  events_long                     3     0       0       0       -       -
-  events_unbound              38322     0       -       -       -       -
-  events_freezable                0     0       0       0       -       -
-  events_power_efficient      29603     0       0       0       -       -
-  events_freezable_power_        10     0       0       0       -       -
-  sock_diag_events                0     0       0       0       -       -
+                              total  infl  CPUtime  CPUhog  CMwake  mayday rescued
+  events                      18545     0      6.1       0       5       -       -
+  events_highpri                  8     0      0.0       0       0       -       -
+  events_long                     3     0      0.0       0       0       -       -
+  events_unbound              38306     0      0.1       -       -       -       -
+  events_freezable                0     0      0.0       0       0       -       -
+  events_power_efficient      29598     0      0.2       0       0       -       -
+  events_freezable_power_        10     0      0.0       0       0       -       -
+  sock_diag_events                0     0      0.0       0       0       -       -
+
+                              total  infl  CPUtime  CPUhog  CMwake  mayday rescued
+  events                      18548     0      6.1       0       5       -       -
+  events_highpri                  8     0      0.0       0       0       -       -
+  events_long                     3     0      0.0       0       0       -       -
+  events_unbound              38322     0      0.1       -       -       -       -
+  events_freezable                0     0      0.0       0       0       -       -
+  events_power_efficient      29603     0      0.2       0       0       -       -
+  events_freezable_power_        10     0      0.0       0       0       -       -
+  sock_diag_events                0     0      0.0       0       0       -       -
 
   ...
 
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b85d70f133f7..42c41d5368dc 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -212,6 +212,7 @@ struct worker_pool {
 enum pool_workqueue_stats {
 	PWQ_STAT_STARTED,	/* work items started execution */
 	PWQ_STAT_COMPLETED,	/* work items completed execution */
+	PWQ_STAT_CPU_TIME,	/* total CPU time consumed */
 	PWQ_STAT_CPU_INTENSIVE,	/* wq_cpu_intensive_thresh_us violations */
 	PWQ_STAT_CM_WAKEUP,	/* concurrency-management worker wakeups */
 	PWQ_STAT_MAYDAY,	/* maydays to rescuer */
@@ -1170,6 +1171,8 @@ void wq_worker_tick(struct task_struct *task)
 	if (!pwq)
 		return;
 
+	pwq->stats[PWQ_STAT_CPU_TIME] += TICK_USEC;
+
 	/*
 	 * If the current worker is concurrency managed and hogged the CPU for
 	 * longer than wq_cpu_intensive_thresh_us, it's automatically marked
diff --git a/tools/workqueue/wq_monitor.py b/tools/workqueue/wq_monitor.py
index 5dc0b61b36e8..3c35239d50c4 100644
--- a/tools/workqueue/wq_monitor.py
+++ b/tools/workqueue/wq_monitor.py
@@ -12,6 +12,10 @@ https://github.com/osandov/drgn.
 
   infl     The number of currently in-flight work items.
 
+  CPUtime  Total CPU time consumed by the workqueue in seconds. This is
+           sampled from scheduler ticks and only provides ballpark
+           measurement. "nohz_full=" CPUs are excluded from measurement.
+
   CPUitsv  The number of times a concurrency-managed work item hogged CPU
            longer than the threshold (workqueue.cpu_intensive_thresh_us)
            and got excluded from concurrency management to avoid stalling
@@ -59,6 +63,7 @@ WQ_MEM_RECLAIM          = prog['WQ_MEM_RECLAIM']
 
 PWQ_STAT_STARTED        = prog['PWQ_STAT_STARTED']      # work items started execution
 PWQ_STAT_COMPLETED      = prog['PWQ_STAT_COMPLETED']	# work items completed execution
+PWQ_STAT_CPU_TIME       = prog['PWQ_STAT_CPU_TIME']     # total CPU time consumed
 PWQ_STAT_CPU_INTENSIVE  = prog['PWQ_STAT_CPU_INTENSIVE'] # wq_cpu_intensive_thresh_us violations
 PWQ_STAT_CM_WAKEUP      = prog['PWQ_STAT_CM_WAKEUP']    # concurrency-management worker wakeups
 PWQ_STAT_MAYDAY         = prog['PWQ_STAT_MAYDAY']	# maydays to rescuer
@@ -82,13 +87,14 @@ PWQ_NR_STATS            = prog['PWQ_NR_STATS']
                  'mem_reclaim'          : self.mem_reclaim,
                  'started'              : self.stats[PWQ_STAT_STARTED],
                  'completed'            : self.stats[PWQ_STAT_COMPLETED],
+                 'cputime'              : self.stats[PWQ_STAT_CPU_TIME],
                  'cpu_intensive'        : self.stats[PWQ_STAT_CPU_INTENSIVE],
                  'cm_wakeup'            : self.stats[PWQ_STAT_CM_WAKEUP],
                  'mayday'               : self.stats[PWQ_STAT_MAYDAY],
                  'rescued'              : self.stats[PWQ_STAT_RESCUED], }
 
     def table_header_str():
-        return f'{"":>24} {"total":>8} {"infl":>5} {"CPUitsv":>7} '\
+        return f'{"":>24} {"total":>8} {"infl":>5} {"CPUtime":>8} {"CPUitsv":>7} '\
             f'{"CMwake":>7} {"mayday":>7} {"rescued":>7}'
 
     def table_row_str(self):
@@ -108,6 +114,7 @@ PWQ_NR_STATS            = prog['PWQ_NR_STATS']
         out = f'{self.name[-24:]:24} ' \
               f'{self.stats[PWQ_STAT_STARTED]:8} ' \
               f'{max(self.stats[PWQ_STAT_STARTED] - self.stats[PWQ_STAT_COMPLETED], 0):5} ' \
+              f'{self.stats[PWQ_STAT_CPU_TIME] / 1000000:8.1f} ' \
               f'{cpu_intensive:>7} ' \
               f'{cm_wakeup:>7} ' \
               f'{mayday:>7} ' \
-- 
2.40.1

