Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948B25B32AA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbiIIJCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiIIJAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:00:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF4B97B30;
        Fri,  9 Sep 2022 02:00:34 -0700 (PDT)
Date:   Fri, 09 Sep 2022 09:00:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662714032;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9xH0WeBJKnJFQar3yJnkHKynkb8/OANpkMyvjRSBRBs=;
        b=1LBlnvsNOOr5Ni2DmJ1k7h/kIa2w/SMUH6IuPsCNM0BzjXPOKVTRPnyb/VR64cuNUj69Pv
        Xi2jPQTWMZ0JnkGDE9s8d86ze+gqXUX+0/q6NE/ued1WqhLhH5E33E7e+sFY0U1KKX7bk3
        0ifvyO6Mf9C994Z8aNZKxVRFc7kTSjtJsL5yhqaX0IcR8OCBLxcGAssH3QEthDjjPWpOca
        +tkgc5rpLfChSa1fUONlX86tF0Lo3fy3W5Fp2c5VoJNdhEHdSK46i8NPfOnuSFNRPdOMAA
        YpJAV316ktGa5dCqAv/1lNe3nuoRUXUF8sj/nCKoq9629Q59hfq2+g3WGItZ6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662714032;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9xH0WeBJKnJFQar3yJnkHKynkb8/OANpkMyvjRSBRBs=;
        b=+ITJ28egXuHJYTbmf3kfPg48CSo2Q+RzTqJ2nRQcrOQvTYkjOkRCe1qm2opA0Goqo/dOE7
        pmMu5QYcuzzjBzCA==
From:   "tip-bot2 for Abel Wu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Remove redundant check in select_idle_smt()
Cc:     Abel Wu <wuyun.abel@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Don <joshdon@google.com>,
        Mel Gorman <mgorman@techsingularity.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220907112000.1854-2-wuyun.abel@bytedance.com>
References: <20220907112000.1854-2-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Message-ID: <166271403165.401.12761825338092319966.tip-bot2@tip-bot2>
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

Commit-ID:     3e6efe87cd5ccabf0f1d4e3ef25881ca0fd337e7
Gitweb:        https://git.kernel.org/tip/3e6efe87cd5ccabf0f1d4e3ef25881ca0fd337e7
Author:        Abel Wu <wuyun.abel@bytedance.com>
AuthorDate:    Wed, 07 Sep 2022 19:19:56 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Sep 2022 21:53:46 +02:00

sched/fair: Remove redundant check in select_idle_smt()

If two cpus share LLC cache, then the two cores they belong to
are also in the same LLC domain.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Josh Don <joshdon@google.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Link: https://lore.kernel.org/r/20220907112000.1854-2-wuyun.abel@bytedance.com
---
 kernel/sched/fair.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index efceb67..9657c7d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6350,14 +6350,11 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 /*
  * Scan the local SMT mask for idle CPUs.
  */
-static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
+static int select_idle_smt(struct task_struct *p, int target)
 {
 	int cpu;
 
-	for_each_cpu(cpu, cpu_smt_mask(target)) {
-		if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||
-		    !cpumask_test_cpu(cpu, sched_domain_span(sd)))
-			continue;
+	for_each_cpu_and(cpu, cpu_smt_mask(target), p->cpus_ptr) {
 		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
 			return cpu;
 	}
@@ -6381,7 +6378,7 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
 	return __select_idle_cpu(core, p);
 }
 
-static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
+static inline int select_idle_smt(struct task_struct *p, int target)
 {
 	return -1;
 }
@@ -6615,7 +6612,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		has_idle_core = test_idle_cores(target, false);
 
 		if (!has_idle_core && cpus_share_cache(prev, target)) {
-			i = select_idle_smt(p, sd, prev);
+			i = select_idle_smt(p, prev);
 			if ((unsigned int)i < nr_cpumask_bits)
 				return i;
 		}
