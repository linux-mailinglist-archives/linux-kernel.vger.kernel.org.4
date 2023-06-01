Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E932A7195E0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjFAInq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjFAInn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:43:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2387E2;
        Thu,  1 Jun 2023 01:43:41 -0700 (PDT)
Date:   Thu, 01 Jun 2023 08:43:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685609019;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wIIFMvgjgxkor3CmVyqf+o2BdJ8Bg7GR+jqwMYygP1E=;
        b=LYZVRReyKPTpzuCq0p6jAZRsls5oEZeJlJnz8PPWpregzWfZF8lJPFiLvtnPCe2IQA1ydZ
        tMSnQ/wItMj2IqoiKXqCHglzsv7K7HnOlZJcBH2uaiKtyG9YQd2vSM6IL4XUi9PUld30nt
        qlnq//AICv2yK+hOI7DAtLR0/Qpylu6yLouB2now715AyPTU7G+NjEUW3pwtSAgINZVZr7
        GBRwdhNzdaGkzO3/kTk0I8LlU88dERt3uLxku2YVtlonvOzau+ZFWn2IEOZEID+Y0uOBYG
        a7Zb3j/4eB1nu86yPV+pbhQu9RLYACsgjntiS9TsRma3q1OT0Gzj6x/mP6ALOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685609019;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wIIFMvgjgxkor3CmVyqf+o2BdJ8Bg7GR+jqwMYygP1E=;
        b=TUAtryl0ArtlByW2A5eoA/sWN0R5/MjCTjDJImnmjvgYrUtDQXlBeM8LgnNvkkR5u9iEW4
        bkV7eooUpSSD9QCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Cc:     Tejun Heo <tj@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168560901866.404.8439301702539997013.tip-bot2@tip-bot2>
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

Commit-ID:     c5214e13ad60bd0022bab45cbac2c9db6bc1e0d4
Gitweb:        https://git.kernel.org/tip/c5214e13ad60bd0022bab45cbac2c9db6bc1e0d4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 30 May 2023 13:20:46 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 01 Jun 2023 10:24:14 +02:00

sched/fair: Multi-LLC select_idle_sibling()

Tejun reported that when he targets workqueues towards a specific LLC
on his Zen2 machine with 3 cores / LLC and 4 LLCs in total, he gets
significant idle time.

This is, of course, because of how select_idle_sibling() will not
consider anything outside of the local LLC, and since all these tasks
are short running the periodic idle load balancer is ineffective.

And while it is good to keep work cache local, it is better to not
have significant idle time. Therefore, have select_idle_sibling() try
other LLCs inside the same node when the local one comes up empty.

Reported-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c     | 37 +++++++++++++++++++++++++++++++++++++
 kernel/sched/features.h |  1 +
 2 files changed, 38 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 48b6f0c..cd80e30 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7028,6 +7028,37 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool 
 }
 
 /*
+ * For the multiple-LLC per node case, make sure to try the other LLC's if the
+ * local LLC comes up empty.
+ */
+static int
+select_idle_node(struct task_struct *p, struct sched_domain *sd, int target)
+{
+	struct sched_domain *parent = sd->parent;
+	struct sched_group *sg;
+
+	/* Make sure to not cross nodes. */
+	if (!parent || parent->flags & SD_NUMA)
+		return -1;
+
+	sg = parent->groups;
+	do {
+		int cpu = cpumask_first(sched_group_span(sg));
+
+		if (!cpus_share_cache(cpu, target)) {
+			int i = select_idle_cpu(p, per_cpu(sd_llc, cpu),
+						test_idle_cores(cpu), cpu);
+			if ((unsigned)i < nr_cpumask_bits)
+				return i;
+		}
+
+		sg = sg->next;
+	} while (sg != parent->groups);
+
+	return -1;
+}
+
+/*
  * Scan the asym_capacity domain for idle CPUs; pick the first idle one on which
  * the task fits. If no CPU is big enough, but there are idle ones, try to
  * maximize capacity.
@@ -7199,6 +7230,12 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
+	if (sched_feat(SIS_NODE)) {
+		i = select_idle_node(p, sd, target);
+		if ((unsigned)i < nr_cpumask_bits)
+			return i;
+	}
+
 	return target;
 }
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index ee7f23c..9e390eb 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -62,6 +62,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
  */
 SCHED_FEAT(SIS_PROP, false)
 SCHED_FEAT(SIS_UTIL, true)
+SCHED_FEAT(SIS_NODE, true)
 
 /*
  * Issue a WARN when we do multiple update_rq_clock() calls
