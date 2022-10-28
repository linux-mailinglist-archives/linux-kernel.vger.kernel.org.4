Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B99610D63
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiJ1JfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiJ1JfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:35:04 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AE93AE6E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:35:02 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so3318013wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ySpaS8Fkj5Miw0XHBXwZ3O8DcUQ428wDyrUI4Txxz7I=;
        b=Zethr+YWyoUGDOt2rSohY9VmL73GzBzAwYGQEAGWroUFVHBUusEYYVEBpbH75EicLj
         BjKrnpFuUeH4KuiATZH3NG2IuYUForNMhX5m4BoeRUqw/VhhYL5lKPXzXe2mJtq7djRd
         +ek/gTBwQ+3+V+38QrWHiVkgUqmGAHF2ShTtfV39CIVdHdItLpmnJmfmk0CLwTajg9I9
         rESYyReYeAnaJNOl1JFjKdMTYDdG4x88pFhps3W5j+U8SoH2FIb3uf1fbPUrW3+mefMw
         pCGxyJ1pnkkUguvEocJbLw1qdaVpx8CklB4UeFeo5Prt1A0k8CpztK6CghqHxc6oIiT4
         pEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ySpaS8Fkj5Miw0XHBXwZ3O8DcUQ428wDyrUI4Txxz7I=;
        b=FwgdjMdh4c3e3T7liLGpT3QL4YsAkEj3CUobU9fgyFw1sPaOuSvJRZPlU7tE+P0jen
         vbDHdLJ4eo249fLcjFslh7pHLmWMUU4g8otNgLuNGHfudysueDIugDx8FRpGF+OuAVtn
         2mlTnZpXhsUGEKkoI4PTbsAozb89nesxIFxKbYBlKJziEuPHOpyOx9hgH9qkANdmuTXP
         L6ApLY2PIxXrORA338ZsJ5cDpd6crhJRfZ+O5+ALpz3Bb3u1Dsd4AwzaqLscFDvPpYWo
         u++DDua4W1N5j5N2JVLYzGvK8IPcT3kTibrSai6Kl2q/xkuEC8gAASpacfHA1EojgWO7
         mNlQ==
X-Gm-Message-State: ACrzQf1CZAegLm6SNoxr2LnUJ4mv8/YhIYbPk9HK9kqX2bpcEtZsLmZu
        52sWg5AWc2QKaCF+C68Tkgi5Hg==
X-Google-Smtp-Source: AMsMyM7R8eILqCqs1G2NyHYDJWYoMYBh3GMejybWEZkJFg5xqY2Usqi9eupvN7kLS+9lhLu2odLXVQ==
X-Received: by 2002:a05:600c:468a:b0:3c6:f84a:1fae with SMTP id p10-20020a05600c468a00b003c6f84a1faemr8586054wmo.148.1666949700484;
        Fri, 28 Oct 2022 02:35:00 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:c12b:b448:f0a9:83ef])
        by smtp.gmail.com with ESMTPSA id k3-20020a05600c1c8300b003c6b7f5567csm10909426wms.0.2022.10.28.02.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 02:34:59 -0700 (PDT)
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
Subject: [PATCH v7 3/9] sched/core: Propagate parent task's latency requirements to the child task
Date:   Fri, 28 Oct 2022 11:33:57 +0200
Message-Id: <20221028093403.6673-4-vincent.guittot@linaro.org>
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

