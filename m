Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C888A610B60
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiJ1HhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiJ1Hg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:36:56 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B2C1BB579
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:36:55 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h9so5894025wrt.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ySpaS8Fkj5Miw0XHBXwZ3O8DcUQ428wDyrUI4Txxz7I=;
        b=wqSeFbRdq2adahV/mdUOa1fqJD6aVJJovMUxYS+oMGCv12Q3FUv9AHXl4ggCN9Eo2j
         96+U5EEOxOoQZ+FUtLT0YZhrHzFKzFUx9VjE6IzHV2wkARJeZBxUAJfB1VSsKDLs5BSO
         5iqzHmI3yJT/4wMQ8sQ5l9fV6ReSQDtOEJfvUAxGwdiIQTaBuL89u4KmgRmWik2XLXIj
         zefQBzdrz6vtgunooANIBekXTuye4ROpVYuFsXCK98gV1PW5hzRkDB90d/Q+myXBBfXk
         ltabfUODHhh33AjDCP46QLX32FN7Jn59jmZcoy6SrGYwxVVVZ7D9WW8beT27BrFLYH44
         Utpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ySpaS8Fkj5Miw0XHBXwZ3O8DcUQ428wDyrUI4Txxz7I=;
        b=UmPuyyARMpFtRiab/cg5WDEwrDW5K8nCLxhgiKVBV7R/oLeYBHxez0K+9MZsAq68qj
         TY3dQiv/dAfCB2II8Wkte221leQ65+m1yI2xcdY9hAYuPmaIXXammXhdQqwllWM0Vtas
         mmpXrgEMaQbDHjTLqjQAVxFn0cM24zfp4mCJ3NkB0swvVh7HUol725HmAmCKMm7nVFxZ
         t1UfhDc6fIYJchxPWLO7LrGDdm++w4IPbOUqyBh73lfD7RSBgqwrEGUFVVI1dT1YLu5i
         dAL4AXYAHnZl1N40I8psVXp6f4h8MEoclSbGjNdBVz9uJgs7DYPBx/bvVV9Qlnouuglr
         hFWw==
X-Gm-Message-State: ACrzQf3TfBJST/uZRj8ZUziMbp46Ltp/dlyR9LfPZTdJuyedesLWXkPE
        omszR1T5Y8ZbCCJskZlp1waQrQ==
X-Google-Smtp-Source: AMsMyM5s2rnua4grp40Ak+zO2NRLcGO+4PO3DytgCXQ4tqeZj31oNI5aTmTEJuiqIK8cGZRP9StXww==
X-Received: by 2002:a05:6000:719:b0:236:73ff:9ca3 with SMTP id bs25-20020a056000071900b0023673ff9ca3mr15200834wrb.603.1666942613661;
        Fri, 28 Oct 2022 00:36:53 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:c12b:b448:f0a9:83ef])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b003b47e8a5d22sm7783129wmq.23.2022.10.28.00.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 00:36:52 -0700 (PDT)
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
Subject: [PATCH v6 3/9] sched/core: Propagate parent task's latency requirements to the child task
Date:   Fri, 28 Oct 2022 09:36:31 +0200
Message-Id: <20221028073637.31195-4-vincent.guittot@linaro.org>
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
 kernel/sched/core.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/init/init_task.c b/init/init_task.c
index ff6c4b9bfe6b..7dd71dd2d261 100644
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
index 02dc1b8e3cb6..54544353025b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4559,6 +4559,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 		p->prio = p->normal_prio = p->static_prio;
 		set_load_weight(p, false);
 
+		p->latency_nice = DEFAULT_LATENCY_NICE;
 		/*
 		 * We don't need the reset flag anymore after the fork. It has
 		 * fulfilled its duty:
-- 
2.17.1

