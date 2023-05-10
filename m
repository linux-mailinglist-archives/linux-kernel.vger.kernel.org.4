Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3E26FDF22
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237020AbjEJNuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237279AbjEJNtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:49:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D541D3A88;
        Wed, 10 May 2023 06:49:20 -0700 (PDT)
Date:   Wed, 10 May 2023 13:49:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683726554;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F7U5mUytH1qvTyKHQoLqeFYjjmc4tobmvVpTivDaTIU=;
        b=nDuz4WFmI0GZJWiuhkG7YKkRPTdOPylceCe3yHWPTowHLIPDkCSPz8CbBZQvJ2Wx4AiggV
        u7Qm890xqtR7tSk2Eyrs9XuLQCkjdoAyqe7Kc2GB3K1+v/PJcSb4OumAjqBxeX2W2VlNez
        ZlOmzGSRMxYBAWr1zymIRODy2iYDBB+QizarvH8uqBzrQoXpzWrBdfzDF9+XeHGJmUeozh
        KY0GyMeR0FhhUaNzmv4TiK/gR29Q4GMFP3vroEKL+ZVjYgb3svA6X/IKrSAzqGMPyiWLaw
        mWEkoReimw+4WaurTBqQCdsAP58Vjqzg+0sO7y2Q7RqxLHuqisemyREsjSf73g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683726554;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F7U5mUytH1qvTyKHQoLqeFYjjmc4tobmvVpTivDaTIU=;
        b=+Gh1gSuEBpmfx8fNenN4VYs2RPDi9f08TOfu0q+GNBMoQ/O1DNTP8ZYQd6794dNfsiW4S5
        Gqe0QcDwH3iN+GAg==
From:   "tip-bot2 for Ricardo Neri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Let low-priority cores help
 high-priority busy SMT cores
Cc:     Valentin Schneider <vschneid@redhat.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230406203148.19182-5-ricardo.neri-calderon@linux.intel.com>
References: <20230406203148.19182-5-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Message-ID: <168372655417.404.18317397549108469001.tip-bot2@tip-bot2>
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

Commit-ID:     18ad34532755feb5b9f4284b07769b1bfec18ab3
Gitweb:        https://git.kernel.org/tip/18ad34532755feb5b9f4284b07769b1bfec18ab3
Author:        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate:    Thu, 06 Apr 2023 13:31:40 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 08 May 2023 10:58:35 +02:00

sched/fair: Let low-priority cores help high-priority busy SMT cores

Using asym_packing priorities within an SMT core is straightforward. Just
follow the priorities that hardware indicates.

When balancing load from an SMT core, also consider the idle state of its
siblings. Priorities do not reflect that an SMT core divides its throughput
among all its busy siblings. They only makes sense when exactly one sibling
is busy.

Indicate that active balance is needed if the destination CPU has lower
priority than the source CPU but the latter has busy SMT siblings.

Make find_busiest_queue() not skip higher-priority SMT cores with more than
busy sibling.

Suggested-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lore.kernel.org/r/20230406203148.19182-5-ricardo.neri-calderon@linux.intel.com
---
 kernel/sched/fair.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a8a02ae..85ce249 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10551,8 +10551,15 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		    nr_running == 1)
 			continue;
 
-		/* Make sure we only pull tasks from a CPU of lower priority */
+		/*
+		 * Make sure we only pull tasks from a CPU of lower priority
+		 * when balancing between SMT siblings.
+		 *
+		 * If balancing between cores, let lower priority CPUs help
+		 * SMT cores with more than one busy sibling.
+		 */
 		if ((env->sd->flags & SD_ASYM_PACKING) &&
+		    sched_use_asym_prio(env->sd, i) &&
 		    sched_asym_prefer(i, env->dst_cpu) &&
 		    nr_running == 1)
 			continue;
@@ -10645,10 +10652,15 @@ asym_active_balance(struct lb_env *env)
 	 * priority CPUs in order to pack all tasks in the highest priority
 	 * CPUs. When done between cores, do it only if the whole core if the
 	 * whole core is idle.
+	 *
+	 * If @env::src_cpu is an SMT core with busy siblings, let
+	 * the lower priority @env::dst_cpu help it. Do not follow
+	 * CPU priority.
 	 */
 	return env->idle != CPU_NOT_IDLE && (env->sd->flags & SD_ASYM_PACKING) &&
 	       sched_use_asym_prio(env->sd, env->dst_cpu) &&
-	       sched_asym_prefer(env->dst_cpu, env->src_cpu);
+	       (sched_asym_prefer(env->dst_cpu, env->src_cpu) ||
+		!sched_use_asym_prio(env->sd, env->src_cpu));
 }
 
 static inline bool
