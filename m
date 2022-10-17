Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44203601169
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiJQOqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiJQOqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:46:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AE96717C;
        Mon, 17 Oct 2022 07:45:50 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:45:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666017948;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FUiSU7bA5nGiiF57G7D3vhxso7yviXcr1ZoOAiG495U=;
        b=Pmeaz3CXRLYaPWeCmhhCt8CLvIlDmkOnKbiChGuY9aZSGGNl93PmGGX8fkwb2jQYULoDT0
        KqJhN/fKxg3QEn0IkhFMcK9ruzkM894X8SlwAYlXGWIIwXOpEORGfwtlcG2nGdz/hhVqpk
        OSJ6NIFbQqRdg1MnUm6uQQaNFrWDMoeFNb0rIDoMLOGrXz2NDOAg5jjr9fsewixtr6tgTU
        ZB1HJg+yhvmydP0fmKF2hBpm7TJ8SJr8PIEYLgjeZ7Bd7K8e0BEAjEMPFjdvsp4SWjsJPz
        fnrEZAje/M7zuFwSUVqLGuGFwxihrwf8AAMqweCJurBKC7EHi751EH/oOZqlDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666017948;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FUiSU7bA5nGiiF57G7D3vhxso7yviXcr1ZoOAiG495U=;
        b=E9taiW2J7tFnvXMAHWWgnZGLRZGiOxVNYWQzIv1wQ2OKHHMVYW0KMm7Kjgfil7SLWOpMjJ
        e98lOI58z8+dppBQ==
From:   "tip-bot2 for Lin Shengwang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/core: Fix comparison in sched_group_cookie_match()
Cc:     Lin Shengwang <linshengwang1@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221008022709.642-1-linshengwang1@huawei.com>
References: <20221008022709.642-1-linshengwang1@huawei.com>
MIME-Version: 1.0
Message-ID: <166601794728.401.12715574315291898146.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     e705968dd687574b6ca3ebe772683d5642759132
Gitweb:        https://git.kernel.org/tip/e705968dd687574b6ca3ebe772683d5642759132
Author:        Lin Shengwang <linshengwang1@huawei.com>
AuthorDate:    Sat, 08 Oct 2022 10:27:09 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:24 +02:00

sched/core: Fix comparison in sched_group_cookie_match()

In commit 97886d9dcd86 ("sched: Migration changes for core scheduling"),
sched_group_cookie_match() was added to help determine if a cookie
matches the core state.

However, while it iterates the SMT group, it fails to actually use the
RQ for each of the CPUs iterated, use cpu_rq(cpu) instead of rq to fix
things.

Fixes: 97886d9dcd86 ("sched: Migration changes for core scheduling")
Signed-off-by: Lin Shengwang <linshengwang1@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221008022709.642-1-linshengwang1@huawei.com
---
 kernel/sched/sched.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1644242..0d08511 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1182,6 +1182,14 @@ static inline bool is_migration_disabled(struct task_struct *p)
 #endif
 }
 
+DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+
+#define cpu_rq(cpu)		(&per_cpu(runqueues, (cpu)))
+#define this_rq()		this_cpu_ptr(&runqueues)
+#define task_rq(p)		cpu_rq(task_cpu(p))
+#define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
+#define raw_rq()		raw_cpu_ptr(&runqueues)
+
 struct sched_group;
 #ifdef CONFIG_SCHED_CORE
 static inline struct cpumask *sched_group_span(struct sched_group *sg);
@@ -1269,7 +1277,7 @@ static inline bool sched_group_cookie_match(struct rq *rq,
 		return true;
 
 	for_each_cpu_and(cpu, sched_group_span(group), p->cpus_ptr) {
-		if (sched_core_cookie_match(rq, p))
+		if (sched_core_cookie_match(cpu_rq(cpu), p))
 			return true;
 	}
 	return false;
@@ -1384,14 +1392,6 @@ static inline void update_idle_core(struct rq *rq)
 static inline void update_idle_core(struct rq *rq) { }
 #endif
 
-DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
-
-#define cpu_rq(cpu)		(&per_cpu(runqueues, (cpu)))
-#define this_rq()		this_cpu_ptr(&runqueues)
-#define task_rq(p)		cpu_rq(task_cpu(p))
-#define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
-#define raw_rq()		raw_cpu_ptr(&runqueues)
-
 #ifdef CONFIG_FAIR_GROUP_SCHED
 static inline struct task_struct *task_of(struct sched_entity *se)
 {
