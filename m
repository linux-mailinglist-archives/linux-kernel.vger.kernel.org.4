Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0430717F7B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbjEaMEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbjEaMEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:04:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63693101;
        Wed, 31 May 2023 05:04:49 -0700 (PDT)
Date:   Wed, 31 May 2023 12:04:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685534688;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=mkFR1p6NGaVWzqWo+3Ov+dWA/Fp3KYe2OtV0WYPqN04=;
        b=nBrT/TPqM41GvLPhCmDpjc/a0IxKU0UeTYMWjU948RcZoLU5VeK0HkhuFoEWoRi6ItlU5z
        92RxOwRSlnkTFOgUd39L0oFWoXs4VEol7Efu6Fqig/WU3Ou5WWpks+CKly26pULggh09CJ
        JQgv0/UdecmscS3j062BJkeV2x510OHfhKmu5XepB9WYiPpDkf38c3TKlal3LDEgtJLTCw
        Lr242c3S06MMhlmKTvlNBMyHXAkx7msg+0Ln8iGIGlJrY+4FDs2bNHsLwcW6R3UHolKGKI
        tqySc3PInnxZ5X8b3HFdiE0joUyhV7kpjSuZUZhgSZNRv+lAP927xHnfpV4C5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685534688;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=mkFR1p6NGaVWzqWo+3Ov+dWA/Fp3KYe2OtV0WYPqN04=;
        b=hGCRxsGF8qfCyZv5UuIc7qLThGLIDp9AuPgGt8kuS87j5yf/GlHrhHY7/vDHqWJXLgHEdp
        eQJonsaWqtdDodCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Cc:     Tejun Heo <tj@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168553468754.404.2298362895524875073.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c7dfd6b9122d29d0e9a4587ab470c0564d7f92ab
Gitweb:        https://git.kernel.org/tip/c7dfd6b9122d29d0e9a4587ab470c0564d7f92ab
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 30 May 2023 13:20:46 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 30 May 2023 22:46:27 +02:00

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
 kernel/sched/fair.c     | 38 ++++++++++++++++++++++++++++++++++++++
 kernel/sched/features.h |  1 +
 2 files changed, 39 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 48b6f0c..0172458 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7028,6 +7028,38 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool 
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
+		struct sched_domain *sd_child;
+
+		sd_child = per_cpu(sd_llc, cpu);
+		if (sd_child != sd) {
+			int i = select_idle_cpu(p, sd_child, test_idle_cores(cpu), cpu);
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
@@ -7199,6 +7231,12 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
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
