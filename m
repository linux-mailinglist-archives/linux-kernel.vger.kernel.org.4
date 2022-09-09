Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9B25B32A8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiIIJCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiIIJAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:00:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55615F10D4;
        Fri,  9 Sep 2022 02:00:32 -0700 (PDT)
Date:   Fri, 09 Sep 2022 09:00:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662714029;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=05YG9MvHh0j7AEAuQ44oyynnYp17xNRkIy236iobukM=;
        b=Qp6SULMipbrbctlJe7DVDZDOi2NdNf5c68neGma4sSWysYMb9slY0Ju1xyZd4UszRHwCLh
        NHf9L+thVD5MxaNd1phVyiE+SAWt8xkXigzPnxZmKAw8G9eK+wO/8xoY5FhEvcL5+p0ptm
        EbnEwsaAvu0CYFp+JyRbuiyg6UZrabqhykfXv6L00c82JwaheAKMPiaopDdVMA6X9G9h6N
        6ZA58fjzhH/QCoCIAVal/LbAA/SFNJZvXrugSlZM0IIba1Sv2HhOrHqKVoqDiBGVJ0mqiJ
        JBiTlT0Zk2U6BRVFrKLIwIpIPNnFRZtW2Wme7h/UrGHH++PaNhS1Pg3sIAieuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662714029;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=05YG9MvHh0j7AEAuQ44oyynnYp17xNRkIy236iobukM=;
        b=FcZH15SfJvc/CjXlbYKqM7qdLaY4vlb1bcUQ8OIgfW5xRY0PCNTLvGVvIrd0JrxJkHPIzK
        J4OcKseR9Rb5JTCw==
From:   "tip-bot2 for Abel Wu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Default to false in test_idle_cores()
Cc:     Abel Wu <wuyun.abel@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Don <joshdon@google.com>,
        Mel Gorman <mgorman@techsingularity.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220907112000.1854-5-wuyun.abel@bytedance.com>
References: <20220907112000.1854-5-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Message-ID: <166271402832.401.6641123344828384147.tip-bot2@tip-bot2>
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

Commit-ID:     398ba2b0cc0a43964fe3d2dd19cb2a478f1f220b
Gitweb:        https://git.kernel.org/tip/398ba2b0cc0a43964fe3d2dd19cb2a478f1f220b
Author:        Abel Wu <wuyun.abel@bytedance.com>
AuthorDate:    Wed, 07 Sep 2022 19:19:59 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Sep 2022 21:53:47 +02:00

sched/fair: Default to false in test_idle_cores()

It's uncertain whether idle cores exist or not if shared sched-
domains are not ready, so returning "no idle cores" usually
makes sense.

While __update_idle_core() is an exception, it checks status
of this core and set hint to shared sched-domain if necessary.
So the whole logic of this function depends on the existence
of shared sched-domain, and can certainly bail out early if
it is not available.

It's somehow a little tricky, and as Josh suggested that it
should be transient while the domain isn't ready. So remove
the self-defined default value to make things more clearer.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Josh Don <joshdon@google.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Link: https://lore.kernel.org/r/20220907112000.1854-5-wuyun.abel@bytedance.com
---
 kernel/sched/fair.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 03ce650..23b020c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1588,11 +1588,11 @@ numa_type numa_classify(unsigned int imbalance_pct,
 
 #ifdef CONFIG_SCHED_SMT
 /* Forward declarations of select_idle_sibling helpers */
-static inline bool test_idle_cores(int cpu, bool def);
+static inline bool test_idle_cores(int cpu);
 static inline int numa_idle_core(int idle_core, int cpu)
 {
 	if (!static_branch_likely(&sched_smt_present) ||
-	    idle_core >= 0 || !test_idle_cores(cpu, false))
+	    idle_core >= 0 || !test_idle_cores(cpu))
 		return idle_core;
 
 	/*
@@ -6271,7 +6271,7 @@ static inline void set_idle_cores(int cpu, int val)
 		WRITE_ONCE(sds->has_idle_cores, val);
 }
 
-static inline bool test_idle_cores(int cpu, bool def)
+static inline bool test_idle_cores(int cpu)
 {
 	struct sched_domain_shared *sds;
 
@@ -6279,7 +6279,7 @@ static inline bool test_idle_cores(int cpu, bool def)
 	if (sds)
 		return READ_ONCE(sds->has_idle_cores);
 
-	return def;
+	return false;
 }
 
 /*
@@ -6295,7 +6295,7 @@ void __update_idle_core(struct rq *rq)
 	int cpu;
 
 	rcu_read_lock();
-	if (test_idle_cores(core, true))
+	if (test_idle_cores(core))
 		goto unlock;
 
 	for_each_cpu(cpu, cpu_smt_mask(core)) {
@@ -6367,9 +6367,9 @@ static inline void set_idle_cores(int cpu, int val)
 {
 }
 
-static inline bool test_idle_cores(int cpu, bool def)
+static inline bool test_idle_cores(int cpu)
 {
-	return def;
+	return false;
 }
 
 static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
@@ -6608,7 +6608,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		return target;
 
 	if (sched_smt_active()) {
-		has_idle_core = test_idle_cores(target, false);
+		has_idle_core = test_idle_cores(target);
 
 		if (!has_idle_core && cpus_share_cache(prev, target)) {
 			i = select_idle_smt(p, prev);
