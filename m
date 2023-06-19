Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27FF735574
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjFSLGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbjFSLFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:05:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E321BC1;
        Mon, 19 Jun 2023 04:04:53 -0700 (PDT)
Date:   Mon, 19 Jun 2023 11:04:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687172691;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6HJ+EWkrX10ljGl7K8BAce/hg/LIYukKCp9hwGTV8Is=;
        b=GdzjjDcRJ4MG0RrL2miNDvypDr5Buw+fprgogjGgofXXrmQ1UYdBfsarIIaS4vz2nq9co8
        R1fK1shBXNrVGNqX8R3WwJBud3XCH6tsk4ZMDL0kmbzO9q7T8G9Ij+GOBR48dvgbhSPN8a
        /26gRCv5RrqBWkp1fPMbOIa1N7VsR6PAKr+NRr6d1WBeVFdG6gZqQ2/ctAMS+umtXxZk8L
        OF14aq+7KytoEFXIR2CvZ17MwZVS7UPzQXE6Ho1kZqIxj62hS/wzIhD/KFG0shuy/8Y7ql
        HpWiQOotpOLc7xm+HCk+c4/v8Lg1jP5KMeHEPMgUqwn0S5AtQu5T8VMI8zSsXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687172691;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6HJ+EWkrX10ljGl7K8BAce/hg/LIYukKCp9hwGTV8Is=;
        b=NVHMgAj8araB2PV4/4RKTDBrhoR1GNGvyToyPJWwuswJ7aDUyQjaxPsv2qq/G3n9jsZJwb
        JlwBUIlOu9rRFHDA==
From:   "tip-bot2 for Hao Jia" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Avoid double calling update_rq_clock()
 in __balance_push_cpu_stop()
Cc:     Hao Jia <jiahao.os@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230613082012.49615-3-jiahao.os@bytedance.com>
References: <20230613082012.49615-3-jiahao.os@bytedance.com>
MIME-Version: 1.0
Message-ID: <168717269089.404.10438864985621759181.tip-bot2@tip-bot2>
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

Commit-ID:     96500560f0c73c71bca1b27536c6254fa0e8ce37
Gitweb:        https://git.kernel.org/tip/96500560f0c73c71bca1b27536c6254fa0e8ce37
Author:        Hao Jia <jiahao.os@bytedance.com>
AuthorDate:    Tue, 13 Jun 2023 16:20:10 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Jun 2023 22:08:12 +02:00

sched/core: Avoid double calling update_rq_clock() in __balance_push_cpu_stop()

There is a double update_rq_clock() invocation:

  __balance_push_cpu_stop()
    update_rq_clock()
    __migrate_task()
      update_rq_clock()

Sadly select_fallback_rq() also needs update_rq_clock() for
__do_set_cpus_allowed(), it is not possible to remove the update from
__balance_push_cpu_stop(). So remove it from __migrate_task() and
ensure all callers of this function call update_rq_clock() prior to
calling it.

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20230613082012.49615-3-jiahao.os@bytedance.com
---
 kernel/sched/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 442efe5..c7db597 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2546,7 +2546,6 @@ static struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
 	if (!is_cpu_allowed(p, dest_cpu))
 		return rq;
 
-	update_rq_clock(rq);
 	rq = move_queued_task(rq, rf, p, dest_cpu);
 
 	return rq;
@@ -2604,10 +2603,12 @@ static int migration_cpu_stop(void *data)
 				goto out;
 		}
 
-		if (task_on_rq_queued(p))
+		if (task_on_rq_queued(p)) {
+			update_rq_clock(rq);
 			rq = __migrate_task(rq, &rf, p, arg->dest_cpu);
-		else
+		} else {
 			p->wake_cpu = arg->dest_cpu;
+		}
 
 		/*
 		 * XXX __migrate_task() can fail, at which point we might end
