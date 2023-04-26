Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5A16EF954
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237908AbjDZR0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238422AbjDZR0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:26:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB1276A1;
        Wed, 26 Apr 2023 10:26:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19DD16226F;
        Wed, 26 Apr 2023 17:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC87C433EF;
        Wed, 26 Apr 2023 17:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682529999;
        bh=88Hn/ndAK6iw0+8eulnL56wwhAQcUkbzhuH1m70WQFQ=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=e42+SB0EgnBOemKPFjqSDjSEBvFdrdbJg8NGNX7dq20/rPI/kuZZsBqvg5Y4BcVpG
         pFftXFjxmUlvzYyHfwbcA9SAky8XQW9ycO/p1UjiDul82DLKJo2dnqL9YAdUpWcbXt
         1lPzu+AljFXzZifiR7h4HJiWAMgs4AowK9yeoD+nz3ncON9B4hRkfJheaEP8PQEeTf
         C79wpxkFl5+ROonIPM55gtmVQcs9EAyshNgRRxwseH9Ll8YAnBZX6g9e1pezEeWjcP
         w0cWCQlovtnlrkGVdepz6Yx/jPaBekzJZCyOUckw8AFebnyPS70BHnPLEBIG+/ml7h
         QHgCrEsJVO7rg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 049A515405A6; Wed, 26 Apr 2023 10:26:38 -0700 (PDT)
Date:   Wed, 26 Apr 2023 10:26:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, tj@kernel.org, riel@surriel.com
Subject: [PATCH RFC rcu] Stop rcu_tasks_invoke_cbs() from using never-online
 CPUs
Message-ID: <83d037d1-ef12-4b31-a7b9-7b1ed6c3ae42@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rcu_tasks_invoke_cbs() relies on queue_work_on() to silently fall
back to WORK_CPU_UNBOUND when the specified CPU is offline.  However,
the queue_work_on() function's silent fallback mechanism relies on that
CPU having been online at some time in the past.  When queue_work_on()
is passed a CPU that has never been online, workqueue lockups ensue,
which can be bad for your kernel's general health and well-being.

This commit therefore checks whether a given CPU is currently online,
and, if not substitutes WORK_CPU_UNBOUND in the subsequent call to
queue_work_on().  Why not simply omit the queue_work_on() call entirely?
Because this function is flooding callback-invocation notifications
to all CPUs, and must deal with possibilities that include a sparse
cpu_possible_mask.

Fixes: d363f833c6d88 rcu-tasks: Use workqueues for multiple rcu_tasks_invoke_cbs() invocations
Reported-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index cf7b00af9474..055a5f152127 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -464,6 +464,8 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
 {
 	int cpu;
 	int cpunext;
+	int cpuwq1;
+	int cpuwq2;
 	unsigned long flags;
 	int len;
 	struct rcu_head *rhp;
@@ -474,11 +476,26 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
 	cpunext = cpu * 2 + 1;
 	if (cpunext < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
 		rtpcp_next = per_cpu_ptr(rtp->rtpcpu, cpunext);
-		queue_work_on(cpunext, system_wq, &rtpcp_next->rtp_work);
+
+		// If a CPU has never been online, queue_work_on()
+		// objects to queueing work on that CPU.  Approximate a
+		// check for this by checking if the CPU is currently online.
+
+		cpus_read_lock();
+		cpuwq1 = cpu_online(cpunext) ? cpunext : WORK_CPU_UNBOUND;
+		cpuwq2 = cpu_online(cpunext + 1) ? cpunext + 1 : WORK_CPU_UNBOUND;
+		cpus_read_unlock();
+
+		// Yes, either CPU could go offline here.  But that is
+		// OK because queue_work_on() will (in effect) silently
+		// fall back to WORK_CPU_UNBOUND for any CPU that has ever
+		// been online.
+
+		queue_work_on(cpuwq1, system_wq, &rtpcp_next->rtp_work);
 		cpunext++;
 		if (cpunext < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
 			rtpcp_next = per_cpu_ptr(rtp->rtpcpu, cpunext);
-			queue_work_on(cpunext, system_wq, &rtpcp_next->rtp_work);
+			queue_work_on(cpuwq2, system_wq, &rtpcp_next->rtp_work);
 		}
 	}
 
