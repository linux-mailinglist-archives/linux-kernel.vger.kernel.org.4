Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E93F70784C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 05:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjERDBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 23:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjERDBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 23:01:04 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D2B121
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 20:01:03 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6436dfa15b3so1089986b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 20:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684378863; x=1686970863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M31UFjRMNA+ol69v+jDv2vil0t39UiMHhdSd0bcsVeM=;
        b=CWXDoBcJupLZJTesgoewDVaIiHUgN/g79eHrK5PJWbvky/qRWF/RCKNRaASOqkErXf
         relzDaOA1TL/Rz2N3FQQta+wjHS//a8NSvHhJ4pddF8YsXeh6lk8iCI3aHIz1hvLynh5
         UVfxW4KFCODb10TqKItvwBFGiesMsrm2WYdXZG+Jj6+7trNiZyi+LGZ0M4mVeq1km2CA
         O0PRkVIX3Qk3Lcd2iN+5TDaJT87tzMCS0JQZw7bIPevmzyFP3cfjyABPuk4/hJ3KBvjd
         mjfSy00umbs7MrP04d99Z76FLGBB+VD5TQA42hPA9RiWNNMo0V2SVpbOxSLMFmlM9vNp
         LRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684378863; x=1686970863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M31UFjRMNA+ol69v+jDv2vil0t39UiMHhdSd0bcsVeM=;
        b=JJNdv75QXxXHQm9JUnY7ktt/wYb6uAR/k4UpxIIzdegW9/R5huPBrPhoBZMii8T4ke
         3sFOhk8t3PwjYJB+5NNfq0q8aIWA77D33XJOpg8Wx5F30em74ECcI35u2aznpRMxBtkC
         +OpIFWm7vc7isoMK861GfIaycyncqzKbRD6pi+BfJwmhS7l+o7BZpC1WH7iZ1KBMrMBE
         08bUoEGltgpRQSypvu0zbfQ+6RiacC66baTAkBcOOZk6KsJUwnlOP8IUJ9x2fGD0/d4z
         gISGMBOZJlhjYLizrxWeowjLG7hrWRF0LM2v8cPDXqADeHGWCoM47+xfqDwfDTDQJOgT
         Vmlg==
X-Gm-Message-State: AC+VfDyVW7eanX+DGD+gXLVo79Po7UDKvGea+fl/VS+od0hmH1fMoysl
        iHktLXfK3NDlROBVnqWDD4g=
X-Google-Smtp-Source: ACHHUZ7EuIVAytmX4fljMN2roz4YoiMAMy6E4ZLAAG1f+a5h/dv2y/709s6vD4DhBEREcgLAxIGpTg==
X-Received: by 2002:a05:6a21:328e:b0:102:2de7:ee36 with SMTP id yt14-20020a056a21328e00b001022de7ee36mr652028pzb.36.1684378862523;
        Wed, 17 May 2023 20:01:02 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:1c2f])
        by smtp.gmail.com with ESMTPSA id 133-20020a63048b000000b0050bc03741ffsm145902pge.84.2023.05.17.20.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 20:01:02 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 7/7] workqueue: Track and monitor per-workqueue CPU time usage
Date:   Wed, 17 May 2023 17:00:33 -1000
Message-Id: <20230518030033.4163274-8-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518030033.4163274-1-tj@kernel.org>
References: <20230518030033.4163274-1-tj@kernel.org>
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

v2: wq_monitor.py was using "cputime" as the key when outputting in json
    format. Use "cpu_time" instead for consistency with other fields.

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
index 4ca66384d288..ee16ddb0647c 100644
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
@@ -1136,6 +1137,8 @@ void wq_worker_tick(struct task_struct *task)
 	if (!pwq)
 		return;
 
+	pwq->stats[PWQ_STAT_CPU_TIME] += TICK_USEC;
+
 	/*
 	 * If the current worker is concurrency managed and hogged the CPU for
 	 * longer than wq_cpu_intensive_thresh_us, it's automatically marked
diff --git a/tools/workqueue/wq_monitor.py b/tools/workqueue/wq_monitor.py
index 7c6f523b9164..6e258d123e8c 100644
--- a/tools/workqueue/wq_monitor.py
+++ b/tools/workqueue/wq_monitor.py
@@ -11,6 +11,10 @@ https://github.com/osandov/drgn.
 
   infl     The number of currently in-flight work items.
 
+  CPUtime  Total CPU time consumed by the workqueue in seconds. This is
+           sampled from scheduler ticks and only provides ballpark
+           measurement. "nohz_full=" CPUs are excluded from measurement.
+
   CPUitsv  The number of times a concurrency-managed work item hogged CPU
            longer than the threshold (workqueue.cpu_intensive_thresh_us)
            and got excluded from concurrency management to avoid stalling
@@ -58,6 +62,7 @@ WQ_MEM_RECLAIM          = prog['WQ_MEM_RECLAIM']
 
 PWQ_STAT_STARTED        = prog['PWQ_STAT_STARTED']      # work items started execution
 PWQ_STAT_COMPLETED      = prog['PWQ_STAT_COMPLETED']	# work items completed execution
+PWQ_STAT_CPU_TIME       = prog['PWQ_STAT_CPU_TIME']     # total CPU time consumed
 PWQ_STAT_CPU_INTENSIVE  = prog['PWQ_STAT_CPU_INTENSIVE'] # wq_cpu_intensive_thresh_us violations
 PWQ_STAT_CM_WAKEUP      = prog['PWQ_STAT_CM_WAKEUP']    # concurrency-management worker wakeups
 PWQ_STAT_MAYDAY         = prog['PWQ_STAT_MAYDAY']	# maydays to rescuer
@@ -81,13 +86,14 @@ PWQ_NR_STATS            = prog['PWQ_NR_STATS']
                  'mem_reclaim'          : self.mem_reclaim,
                  'started'              : self.stats[PWQ_STAT_STARTED],
                  'completed'            : self.stats[PWQ_STAT_COMPLETED],
+                 'cpu_time'             : self.stats[PWQ_STAT_CPU_TIME],
                  'cpu_intensive'        : self.stats[PWQ_STAT_CPU_INTENSIVE],
                  'cm_wakeup'            : self.stats[PWQ_STAT_CM_WAKEUP],
                  'mayday'               : self.stats[PWQ_STAT_MAYDAY],
                  'rescued'              : self.stats[PWQ_STAT_RESCUED], }
 
     def table_header_str():
-        return f'{"":>24} {"total":>8} {"infl":>5} '\
+        return f'{"":>24} {"total":>8} {"infl":>5} {"CPUtime":>8} '\
             f'{"CPUitsv":>7} {"CMwake":>7} {"mayday":>7} {"rescued":>7}'
 
     def table_row_str(self):
@@ -107,6 +113,7 @@ PWQ_NR_STATS            = prog['PWQ_NR_STATS']
         out = f'{self.name[-24:]:24} ' \
               f'{self.stats[PWQ_STAT_STARTED]:8} ' \
               f'{max(self.stats[PWQ_STAT_STARTED] - self.stats[PWQ_STAT_COMPLETED], 0):5} ' \
+              f'{self.stats[PWQ_STAT_CPU_TIME] / 1000000:8.1f} ' \
               f'{cpu_intensive:>7} ' \
               f'{cm_wakeup:>7} ' \
               f'{mayday:>7} ' \
-- 
2.40.1

