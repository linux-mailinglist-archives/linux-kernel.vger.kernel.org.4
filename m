Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A03A6BB0B8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjCOMUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbjCOMUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:20:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D638B84803
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678882753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YgxzsfQSDKWEcDKochbw04bI9bnEC0kJv7FwQRZ5yy0=;
        b=dlCz4+m2YnkYiLQK+hjQPgc85v+WWykpPaPlXQ5z5IZjVJSP9oMI3SjWmB39YGJZZps3SC
        TEYkFPiSK5Y2R/9hr2ezmv+/rZKTD8jNy76wC/2OnU+AgajOQJpxnhQuU6/yGGmFYD8Z26
        Rax9T6GxIng+WAcDKfjc+alXLakjSCE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-lviYAVyVOU6_WfSoCy_uvA-1; Wed, 15 Mar 2023 08:19:12 -0400
X-MC-Unique: lviYAVyVOU6_WfSoCy_uvA-1
Received: by mail-qv1-f71.google.com with SMTP id jo13-20020a056214500d00b004c6c72bf1d0so11409552qvb.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678882750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgxzsfQSDKWEcDKochbw04bI9bnEC0kJv7FwQRZ5yy0=;
        b=D2DXcqektU+Rkvtpcha4oFqlW+SiyPiDtArFJwJLKHuzTbmWz4/vS3+3JnuTnHKpdm
         H3G01NnbRMiOBH35YK9mGsAfL1QM3jsgFunb8kYX9D43tiTZWtAFsuW0RO7BYNjoda+k
         BkL9Bm4hqkd6zxmmwheiNsgM+bYwS2mk/L0IMw+5s4foewX2OqlxugR0lyfbpArrtAOO
         rQMv7tW63rrJmZlrkp8V0XujLzOe9XVDJTWhPZZqezBu6e/r3i0wHpi0QQlx1GPJn9/9
         FpNxXwKOLjTKTve8WwhzTvuOXaqGkez8aik6v+7D/TQA2X2rajSGZ13caMqSUgj5PZt2
         A+7w==
X-Gm-Message-State: AO0yUKXc4bSu9osI5q40KA28UFImM7Ix77sXHqKPQzDdPDAenRn0+g+9
        hD1aGR39VO6eKcKX4LBMM87MVSbea7JRAp0e3fG2PbwAOyCiJRxhmW3dCy+XclRjl9EQjLSM9OQ
        vAHUE5dZ1inGEEdeWpf//9MGb
X-Received: by 2002:ac8:7fc1:0:b0:3bf:b973:3078 with SMTP id b1-20020ac87fc1000000b003bfb9733078mr74469216qtk.13.1678882749781;
        Wed, 15 Mar 2023 05:19:09 -0700 (PDT)
X-Google-Smtp-Source: AK7set+/wStHq1rXJJw0yYzUIy3bNydpf3AKFTqXM2HUyMGI/0vx+gHZYLe3UMWwBwuE5JsQH3PJPg==
X-Received: by 2002:ac8:7fc1:0:b0:3bf:b973:3078 with SMTP id b1-20020ac87fc1000000b003bfb9733078mr74469175qtk.13.1678882749503;
        Wed, 15 Mar 2023 05:19:09 -0700 (PDT)
Received: from localhost.localdomain.com ([2a00:23c6:4a21:6f01:ac73:9611:643a:5397])
        by smtp.gmail.com with ESMTPSA id f11-20020ac8014b000000b003bd21323c80sm3672595qtg.11.2023.03.15.05.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 05:19:09 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [RFC PATCH 2/3] sched/cpuset: Keep track of SCHED_DEADLINE tasks in cpusets
Date:   Wed, 15 Mar 2023 12:18:11 +0000
Message-Id: <20230315121812.206079-3-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315121812.206079-1-juri.lelli@redhat.com>
References: <20230315121812.206079-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qais reported that iterating over all tasks when rebuilding root domains
for finding out which ones are DEADLINE and need their bandwidth
correctly restored on such root domains can be a costly operation (10+
ms delays on suspend-resume).

To fix the problem keep track of the number of DEADLINE tasks belonging
to each cpuset and then use this information (followup patch) to only
perform the above iteration if DEADLINE tasks are actually present in
the cpuset for which a corresponding root domain is being rebuilt.

Reported-by: Qais Yousef <qyousef@layalina.io>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/cpuset.h |  4 ++++
 kernel/cgroup/cgroup.c |  4 ++++
 kernel/cgroup/cpuset.c | 25 +++++++++++++++++++++++++
 kernel/sched/core.c    | 10 ++++++++++
 4 files changed, 43 insertions(+)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 355f796c5f07..0348dba5680e 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -71,6 +71,8 @@ extern void cpuset_init_smp(void);
 extern void cpuset_force_rebuild(void);
 extern void cpuset_update_active_cpus(void);
 extern void cpuset_wait_for_hotplug(void);
+extern void inc_dl_tasks_cs(struct task_struct *task);
+extern void dec_dl_tasks_cs(struct task_struct *task);
 extern void cpuset_lock(void);
 extern void cpuset_unlock(void);
 extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
@@ -196,6 +198,8 @@ static inline void cpuset_update_active_cpus(void)
 
 static inline void cpuset_wait_for_hotplug(void) { }
 
+static inline void inc_dl_tasks_cs(struct task_struct *task) { }
+static inline void dec_dl_tasks_cs(struct task_struct *task) { }
 static inline void cpuset_lock(void) { }
 static inline void cpuset_unlock(void) { }
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index c099cf3fa02d..357925e1e4af 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -57,6 +57,7 @@
 #include <linux/file.h>
 #include <linux/fs_parser.h>
 #include <linux/sched/cputime.h>
+#include <linux/sched/deadline.h>
 #include <linux/psi.h>
 #include <net/sock.h>
 
@@ -6673,6 +6674,9 @@ void cgroup_exit(struct task_struct *tsk)
 	list_add_tail(&tsk->cg_list, &cset->dying_tasks);
 	cset->nr_tasks--;
 
+	if (dl_task(tsk))
+		dec_dl_tasks_cs(tsk);
+
 	WARN_ON_ONCE(cgroup_task_frozen(tsk));
 	if (unlikely(!(tsk->flags & PF_KTHREAD) &&
 		     test_bit(CGRP_FREEZE, &task_dfl_cgroup(tsk)->flags)))
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 8d82d66d432b..57bc60112618 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -193,6 +193,12 @@ struct cpuset {
 	int use_parent_ecpus;
 	int child_ecpus_count;
 
+	/*
+	 * number of SCHED_DEADLINE tasks attached to this cpuset, so that we
+	 * know when to rebuild associated root domain bandwidth information.
+	 */
+	int nr_deadline_tasks;
+
 	/* Invalid partition error code, not lock protected */
 	enum prs_errcode prs_err;
 
@@ -245,6 +251,20 @@ static inline struct cpuset *parent_cs(struct cpuset *cs)
 	return css_cs(cs->css.parent);
 }
 
+void inc_dl_tasks_cs(struct task_struct *p)
+{
+	struct cpuset *cs = task_cs(p);
+
+	cs->nr_deadline_tasks++;
+}
+
+void dec_dl_tasks_cs(struct task_struct *p)
+{
+	struct cpuset *cs = task_cs(p);
+
+	cs->nr_deadline_tasks--;
+}
+
 /* bits in struct cpuset flags field */
 typedef enum {
 	CS_ONLINE,
@@ -2472,6 +2492,11 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 		ret = security_task_setscheduler(task);
 		if (ret)
 			goto out_unlock;
+
+		if (dl_task(task)) {
+			cs->nr_deadline_tasks++;
+			cpuset_attach_old_cs->nr_deadline_tasks--;
+		}
 	}
 
 	/*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5902cbb5e751..d586a8440348 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7683,6 +7683,16 @@ static int __sched_setscheduler(struct task_struct *p,
 		goto unlock;
 	}
 
+	/*
+	 * In case a task is setscheduled to SCHED_DEADLINE, or if a task is
+	 * moved to a different sched policy, we need to keep track of that on
+	 * its cpuset (for correct bandwidth tracking).
+	 */
+	if (dl_policy(policy) && !dl_task(p))
+		inc_dl_tasks_cs(p);
+	else if (dl_task(p) && !dl_policy(policy))
+		dec_dl_tasks_cs(p);
+
 	p->sched_reset_on_fork = reset_on_fork;
 	oldprio = p->prio;
 
-- 
2.39.2

