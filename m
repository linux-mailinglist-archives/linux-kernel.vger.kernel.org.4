Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1E85BA7BA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 10:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiIPIDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 04:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiIPIDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 04:03:19 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D51776965
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 01:03:18 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t14so34716611wrx.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 01:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=rlyri6gFQXbjH6qaw2UpG7VLO1J+noZ/tZbnqvT/NqA=;
        b=cbtlwBIw8fDZIrc6VcwUJDfMN81nSv2ZxE381xoq9sSmwXyFCTYnkEzjUjuxm10YI/
         jNoPibgJ8dccGjo8++yZJwIJo5SBOx1xPrSAbhaA4fp/kEyENqgXm0z/YPYp478oUAvi
         8jhs4dpemuhW70lRypnIgokER6fTQz5Y5mR+ggDICgSKE1uv4y7MKpIX5Xgq7rzeGN0v
         CbJSvinKuTzFvrh30V1pN55Vpt30bzAzGpLP7HRfBFkjE9fHXXxBwzb0hFwFtagezHJz
         W2tTwW4TFTsh7efH8Ugnzp6GQEELrOJqxKwMwG2me+g2uio4aPAdcs+Gb+VGY9tlLgKh
         Zpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rlyri6gFQXbjH6qaw2UpG7VLO1J+noZ/tZbnqvT/NqA=;
        b=E6kuWJi4I/zrFcXmfOw3ICrEmjk1qnuDs0uTrSbGWu677PraqM9T8sULSlmNn9La5X
         4z/eqc10PdYjWto/aishAdecZmYMP7fI2lrYs338IcI8q9yirZzQIyo1tSZVGK2dtLyv
         R2dy1gRQWuaayZsPrnVJcgHfxNypBNNZx/ELSork0lOjc0QJ8vtt7EpnI21NaIBYX4mo
         9vuAEBzV+ocrt584dFGGw8VdrH1oVpnis1r67eOcs8+t1CHVD1pKP+uQVTlX3ZIlzHF0
         WzRmeIaAKWGxa2yvOQiw3bd27I3hezmymKvBtJLU3IWmpBUvh92n1zgyPno04RbpzTlV
         86yw==
X-Gm-Message-State: ACrzQf3O2zmYQn4HP0kVzYcZDWNih5mRRXLAOWkhER5T1IqW74kHm9lO
        V9fJg9DIBWs3a7JAlVMCgf58LA==
X-Google-Smtp-Source: AMsMyM5lI+G1YA5QEH08DurxmDg/XogkbhgPk6QNlunzvc1YeuroQo6SHsFVXsBIb6x46kMV8y2j1g==
X-Received: by 2002:a5d:6d8c:0:b0:22a:da71:a2f5 with SMTP id l12-20020a5d6d8c000000b0022ada71a2f5mr1898711wrs.527.1663315396434;
        Fri, 16 Sep 2022 01:03:16 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:9ab:1164:827a:1548])
        by smtp.gmail.com with ESMTPSA id c9-20020adffb49000000b00228dbf15072sm4418116wrs.62.2022.09.16.01.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 01:03:15 -0700 (PDT)
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
Subject: [PATCH v4 2/8] sched/core: Propagate parent task's latency requirements to the child task
Date:   Fri, 16 Sep 2022 10:02:59 +0200
Message-Id: <20220916080305.29574-3-vincent.guittot@linaro.org>
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

Clone parent task's latency_nice attribute to the forked child task.

Reset the latency_nice value to default value when the child task is
set to sched_reset_on_fork.

Also, initialize init_task.latency_nice value with DEFAULT_LATENCY_NICE
value

Signed-off-by: Parth Shah <parth@linux.ibm.com>
[rebase]
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 init/init_task.c    | 1 +
 kernel/sched/core.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/init/init_task.c b/init/init_task.c
index 73cc8f03511a..225d11a39bc9 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -78,6 +78,7 @@ struct task_struct init_task
 	.prio		= MAX_PRIO - 20,
 	.static_prio	= MAX_PRIO - 20,
 	.normal_prio	= MAX_PRIO - 20,
+	.latency_nice	= DEFAULT_LATENCY_NICE,
 	.policy		= SCHED_NORMAL,
 	.cpus_ptr	= &init_task.cpus_mask,
 	.user_cpus_ptr	= NULL,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 603a80ec9b0e..3c5fb04f00e1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4511,6 +4511,9 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	 */
 	p->prio = current->normal_prio;
 
+	/* Propagate the parent's latency requirements to the child as well */
+	p->latency_nice = current->latency_nice;
+
 	uclamp_fork(p);
 
 	/*
@@ -4527,6 +4530,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 		p->prio = p->normal_prio = p->static_prio;
 		set_load_weight(p, false);
 
+		p->latency_nice = DEFAULT_LATENCY_NICE;
 		/*
 		 * We don't need the reset flag anymore after the fork. It has
 		 * fulfilled its duty:
-- 
2.17.1

