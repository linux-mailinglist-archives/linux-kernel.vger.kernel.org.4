Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AB073171A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344189AbjFOLjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344072AbjFOLi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:38:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB4330F6;
        Thu, 15 Jun 2023 04:38:16 -0700 (PDT)
Date:   Thu, 15 Jun 2023 11:38:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686829094;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Myq8Q7URsY1/q1U+vXYUUEZfSehvUfElllJNvNzU0b0=;
        b=2cUrbUdlXaLvYvN6UDQQsMf0xyeEl82oKJdP//u3lPm1J/dKk5Nbvv6Bd2sg7fmEqVWO0p
        +Ay/mmo6f67vKIHKVWpuXNQTeOoZsUGsN1vs+Vz5GO+PAd+lUz+mTLHkM6bTWyLt6zDINe
        MEqacGSaR+6/EufDPPOXSu1XJwLhGxHFUWFGpg5I+3RuBaifiW1ttjkgBCm2/rKTFPeVHN
        KFeMn+kTuhjlWG+DO30XrNUkycWRP1CXWaO3SFlV014EwHGBM7QIaf9zFGnftPeDTQD/Dm
        i2JCjleQERVaaYJKp1jy/XVwv/IX80XBdKEuV+0n64OR7kuO3s9QJfczjevfnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686829094;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Myq8Q7URsY1/q1U+vXYUUEZfSehvUfElllJNvNzU0b0=;
        b=8JSqd2GIYnLX67sfWfWVSjEeSHMPGXVW+yJxKgJs7ctyY2JpfXcfytcD5i+3q3AisdZ8+O
        2GhIguwQ7usYOJBw==
From:   "tip-bot2 for Josh Don" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Add throttled time stat for throttled children
Cc:     Josh Don <joshdon@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230612232748.3948659-2-joshdon@google.com>
References: <20230612232748.3948659-2-joshdon@google.com>
MIME-Version: 1.0
Message-ID: <168682909407.404.10776337626527086205.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     06f5576bf513824b40d535d6b872c0265bb44c0d
Gitweb:        https://git.kernel.org/tip/06f5576bf513824b40d535d6b872c0265bb44c0d
Author:        Josh Don <joshdon@google.com>
AuthorDate:    Mon, 12 Jun 2023 16:27:48 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 15 Jun 2023 13:28:20 +02:00

sched: Add throttled time stat for throttled children

We currently export the total throttled time for cgroups that are given
a bandwidth limit. This patch extends this accounting to also account
the total time that each children cgroup has been throttled.

This is useful to understand the degree to which children have been
affected by the throttling control. Children which are not runnable
during the entire throttled period, for example, will not show any
self-throttling time during this period.

Expose this in a new interface, 'cpu.stat.local', which is similar to
how non-hierarchical events are accounted in 'memory.events.local'.

Signed-off-by: Josh Don <joshdon@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230612232748.3948659-2-joshdon@google.com
---
 include/linux/cgroup-defs.h |  2 ++-
 kernel/cgroup/cgroup.c      | 34 ++++++++++++++++++++++++++++-
 kernel/sched/core.c         | 44 ++++++++++++++++++++++++++++++++++++-
 kernel/sched/fair.c         | 21 ++++++++++++++++-
 kernel/sched/sched.h        |  2 ++-
 5 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 8a0d546..ae20dbb 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -661,6 +661,8 @@ struct cgroup_subsys {
 	void (*css_rstat_flush)(struct cgroup_subsys_state *css, int cpu);
 	int (*css_extra_stat_show)(struct seq_file *seq,
 				   struct cgroup_subsys_state *css);
+	int (*css_local_stat_show)(struct seq_file *seq,
+				   struct cgroup_subsys_state *css);
 
 	int (*can_attach)(struct cgroup_taskset *tset);
 	void (*cancel_attach)(struct cgroup_taskset *tset);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index b26ae20..eafbdb5 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3726,6 +3726,36 @@ static int cpu_stat_show(struct seq_file *seq, void *v)
 	return ret;
 }
 
+static int __maybe_unused cgroup_local_stat_show(struct seq_file *seq,
+						 struct cgroup *cgrp, int ssid)
+{
+	struct cgroup_subsys *ss = cgroup_subsys[ssid];
+	struct cgroup_subsys_state *css;
+	int ret;
+
+	if (!ss->css_local_stat_show)
+		return 0;
+
+	css = cgroup_tryget_css(cgrp, ss);
+	if (!css)
+		return 0;
+
+	ret = ss->css_local_stat_show(seq, css);
+	css_put(css);
+	return ret;
+}
+
+static int cpu_local_stat_show(struct seq_file *seq, void *v)
+{
+	struct cgroup __maybe_unused *cgrp = seq_css(seq)->cgroup;
+	int ret = 0;
+
+#ifdef CONFIG_CGROUP_SCHED
+	ret = cgroup_local_stat_show(seq, cgrp, cpu_cgrp_id);
+#endif
+	return ret;
+}
+
 #ifdef CONFIG_PSI
 static int cgroup_io_pressure_show(struct seq_file *seq, void *v)
 {
@@ -5276,6 +5306,10 @@ static struct cftype cgroup_base_files[] = {
 		.name = "cpu.stat",
 		.seq_show = cpu_stat_show,
 	},
+	{
+		.name = "cpu.stat.local",
+		.seq_show = cpu_local_stat_show,
+	},
 	{ }	/* terminate */
 };
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ac38225..962a8d0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11140,6 +11140,27 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
 
 	return 0;
 }
+
+static u64 throttled_time_self(struct task_group *tg)
+{
+	int i;
+	u64 total = 0;
+
+	for_each_possible_cpu(i) {
+		total += READ_ONCE(tg->cfs_rq[i]->throttled_clock_self_time);
+	}
+
+	return total;
+}
+
+static int cpu_cfs_local_stat_show(struct seq_file *sf, void *v)
+{
+	struct task_group *tg = css_tg(seq_css(sf));
+
+	seq_printf(sf, "throttled_time %llu\n", throttled_time_self(tg));
+
+	return 0;
+}
 #endif /* CONFIG_CFS_BANDWIDTH */
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
@@ -11216,6 +11237,10 @@ static struct cftype cpu_legacy_files[] = {
 		.name = "stat",
 		.seq_show = cpu_cfs_stat_show,
 	},
+	{
+		.name = "stat.local",
+		.seq_show = cpu_cfs_local_stat_show,
+	},
 #endif
 #ifdef CONFIG_RT_GROUP_SCHED
 	{
@@ -11272,6 +11297,24 @@ static int cpu_extra_stat_show(struct seq_file *sf,
 	return 0;
 }
 
+static int cpu_local_stat_show(struct seq_file *sf,
+			       struct cgroup_subsys_state *css)
+{
+#ifdef CONFIG_CFS_BANDWIDTH
+	{
+		struct task_group *tg = css_tg(css);
+		u64 throttled_self_usec;
+
+		throttled_self_usec = throttled_time_self(tg);
+		do_div(throttled_self_usec, NSEC_PER_USEC);
+
+		seq_printf(sf, "throttled_usec %llu\n",
+			   throttled_self_usec);
+	}
+#endif
+	return 0;
+}
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 static u64 cpu_weight_read_u64(struct cgroup_subsys_state *css,
 			       struct cftype *cft)
@@ -11450,6 +11493,7 @@ struct cgroup_subsys cpu_cgrp_subsys = {
 	.css_released	= cpu_cgroup_css_released,
 	.css_free	= cpu_cgroup_css_free,
 	.css_extra_stat_show = cpu_extra_stat_show,
+	.css_local_stat_show = cpu_local_stat_show,
 #ifdef CONFIG_RT_GROUP_SCHED
 	.can_attach	= cpu_cgroup_can_attach,
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b56c86c..819efad 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4877,8 +4877,12 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 			list_add_leaf_cfs_rq(cfs_rq);
 		} else {
 #ifdef CONFIG_CFS_BANDWIDTH
+			struct rq *rq = rq_of(cfs_rq);
+
 			if (!cfs_rq->throttled_clock)
-				cfs_rq->throttled_clock = rq_clock(rq_of(cfs_rq));
+				cfs_rq->throttled_clock = rq_clock(rq);
+			if (!cfs_rq->throttled_clock_self)
+				cfs_rq->throttled_clock_self = rq_clock(rq);
 #endif
 		}
 	}
@@ -5385,6 +5389,17 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 			list_add_leaf_cfs_rq(cfs_rq);
 	}
 
+	if (cfs_rq->throttled_clock_self) {
+		u64 delta = rq_clock(rq) - cfs_rq->throttled_clock_self;
+
+		cfs_rq->throttled_clock_self = 0;
+
+		if (SCHED_WARN_ON((s64)delta < 0))
+			delta = 0;
+
+		cfs_rq->throttled_clock_self_time += delta;
+	}
+
 	return 0;
 }
 
@@ -5400,6 +5415,10 @@ static int tg_throttle_down(struct task_group *tg, void *data)
 	}
 	cfs_rq->throttle_count++;
 
+	SCHED_WARN_ON(cfs_rq->throttled_clock_self);
+	if (cfs_rq->nr_running)
+		cfs_rq->throttled_clock_self = rq_clock(rq);
+
 	return 0;
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 556496c..46f8a01 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -636,6 +636,8 @@ struct cfs_rq {
 	u64			throttled_clock;
 	u64			throttled_clock_pelt;
 	u64			throttled_clock_pelt_time;
+	u64			throttled_clock_self;
+	u64			throttled_clock_self_time;
 	int			throttled;
 	int			throttle_count;
 	struct list_head	throttled_list;
