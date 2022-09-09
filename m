Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCBA5B3297
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiIIJBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiIIJAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:00:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC202EF3D;
        Fri,  9 Sep 2022 02:00:30 -0700 (PDT)
Date:   Fri, 09 Sep 2022 09:00:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662714028;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zmBqnugyFSwUbAVLFK207QeMtERovpuxVQBJ8i1MZNw=;
        b=ACSp71+lOfINWQmQdQviqXhbapEOK/L/cRQX1SH4BZbgBPDy0GFZzG6YXF7PZbiLwAIOR4
        cAwjv88ReOa8e5VdLc5SxqE6x1jeVGL33X+dvtzTeMypjQOummusDaCEwx0pETbQhfQpia
        y8jNhYcFw6QL7WwcgW7VGu4LwrLa4UhyXsuuWlvvX1Vg1yRsyaLhk6P00Kn3xikw1l4K2m
        lWJoabNeBtawgzqfqNRln0gG+lrWHnVjHewUadpR7pni2GX9NNlbZVzuljOx78mgYIh9eb
        mJVMBvNFfsZmZAchVhzsp8fMTKdOPJ41QC4bDG0C2nOfnzLZzpx9YzhFtZzVcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662714028;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zmBqnugyFSwUbAVLFK207QeMtERovpuxVQBJ8i1MZNw=;
        b=NYnXAI2wRyQdy8jNZSyA2YXGr4hREO4jDoZpjPvPVaIRQfnbkaXoFkrN5uYOhpoHl881jn
        /pUM4l7lx2NA4fBA==
From:   "tip-bot2 for Abel Wu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Cleanup for SIS_PROP
Cc:     Abel Wu <wuyun.abel@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220907112000.1854-6-wuyun.abel@bytedance.com>
References: <20220907112000.1854-6-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Message-ID: <166271402714.401.13027499685283802470.tip-bot2@tip-bot2>
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

Commit-ID:     96c1c0cfe493a7ed549169a6f044bbb83e490fb5
Gitweb:        https://git.kernel.org/tip/96c1c0cfe493a7ed549169a6f044bbb83e490fb5
Author:        Abel Wu <wuyun.abel@bytedance.com>
AuthorDate:    Wed, 07 Sep 2022 19:20:00 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Sep 2022 21:53:47 +02:00

sched/fair: Cleanup for SIS_PROP

The sched-domain of this cpu is only used for some heuristics when
SIS_PROP is enabled, and it should be irrelevant whether the local
sd_llc is valid or not, since all we care about is target sd_llc
if !SIS_PROP.

Access the local domain only when there is a need.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lore.kernel.org/r/20220907112000.1854-6-wuyun.abel@bytedance.com
---
 kernel/sched/fair.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 23b020c..7bad641 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6396,19 +6396,19 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool 
 	struct sched_domain_shared *sd_share;
 	struct rq *this_rq = this_rq();
 	int this = smp_processor_id();
-	struct sched_domain *this_sd;
+	struct sched_domain *this_sd = NULL;
 	u64 time = 0;
 
-	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
-	if (!this_sd)
-		return -1;
-
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
 	if (sched_feat(SIS_PROP) && !has_idle_core) {
 		u64 avg_cost, avg_idle, span_avg;
 		unsigned long now = jiffies;
 
+		this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
+		if (!this_sd)
+			return -1;
+
 		/*
 		 * If we're busy, the assumption that the last idle period
 		 * predicts the future is flawed; age away the remaining
@@ -6462,7 +6462,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool 
 	if (has_idle_core)
 		set_idle_cores(target, false);
 
-	if (sched_feat(SIS_PROP) && !has_idle_core) {
+	if (sched_feat(SIS_PROP) && this_sd && !has_idle_core) {
 		time = cpu_clock(this) - time;
 
 		/*
