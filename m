Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08DF5B9D02
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiIOOYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiIOOYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:24:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150749D660;
        Thu, 15 Sep 2022 07:24:14 -0700 (PDT)
Date:   Thu, 15 Sep 2022 14:24:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663251853;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sYLTbk1pAEcT6Czyezu6IS/EnqxfSbnZwJ7B0GvN8Rs=;
        b=2p9hRwEJJkJVUsqcQ53sUbQ+Tp0wGWVgjuR2Nc8kTqTe1IjFJ0eTGZrj2jc8yXjOdi/Yjb
        WS7NTiAIRstmhR+FyTEu0TLl86DM7RtPj4AzvQPVh09ddDuQUy4Ay0fXAy83hPWdwnv79F
        JTYji7Hb1t8wPLD5XgrSPclfTnMRnp4bPGbQQhOhZWt91AKiw6n3fVtFKRk9jdRpRMnL21
        gh0/uMOJeIJsj+hkH3eN8DdcENhNWjs3e+lyLsV5QC2p1sW+NjDMgqr8Gv0rbWHJCqHnnG
        TtlcyHEKeBMrp86cF8C6FvZbm5I7exyAkRNFJr8S5v0iecv3GIoIs6YRX/ME5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663251853;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sYLTbk1pAEcT6Czyezu6IS/EnqxfSbnZwJ7B0GvN8Rs=;
        b=Gr5sWrGNBoZiUz/GLzkLeWtK77nps+41kZk+AV0s4diYwXFRu1i3fR5lEt/GQmnMXRzu0Q
        4/ZdrnfO4wM8lUCw==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Make sure to try to detach at least one
 movable task
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220825122726.20819-2-vincent.guittot@linaro.org>
References: <20220825122726.20819-2-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <166325185230.401.16508642684014916444.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b0defa7ae03ecf91b8bfd10ede430cff12fcbd06
Gitweb:        https://git.kernel.org/tip/b0defa7ae03ecf91b8bfd10ede430cff12fcbd06
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Thu, 25 Aug 2022 14:27:23 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 15 Sep 2022 16:13:51 +02:00

sched/fair: Make sure to try to detach at least one movable task

During load balance, we try at most env->loop_max time to move a task.
But it can happen that the loop_max LRU tasks (ie tail of
the cfs_tasks list) can't be moved to dst_cpu because of affinity.
In this case, loop in the list until we found at least one.

The maximum of detached tasks remained the same as before.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220825122726.20819-2-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4e5b171..dae3bfa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8049,8 +8049,12 @@ static int detach_tasks(struct lb_env *env)
 		p = list_last_entry(tasks, struct task_struct, se.group_node);
 
 		env->loop++;
-		/* We've more or less seen every task there is, call it quits */
-		if (env->loop > env->loop_max)
+		/*
+		 * We've more or less seen every task there is, call it quits
+		 * unless we haven't found any movable task yet.
+		 */
+		if (env->loop > env->loop_max &&
+		    !(env->flags & LBF_ALL_PINNED))
 			break;
 
 		/* take a breather every nr_migrate tasks */
@@ -10179,7 +10183,9 @@ more_balance:
 
 		if (env.flags & LBF_NEED_BREAK) {
 			env.flags &= ~LBF_NEED_BREAK;
-			goto more_balance;
+			/* Stop if we tried all running tasks */
+			if (env.loop < busiest->nr_running)
+				goto more_balance;
 		}
 
 		/*
