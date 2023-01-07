Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47546660A97
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 01:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbjAGAKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 19:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjAGAK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 19:10:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AC873E13
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 16:10:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4F1EB81F39
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 00:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827B7C433EF;
        Sat,  7 Jan 2023 00:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673050224;
        bh=K2/PuTmRX9viLkgdMX73R6LPBfGmXCCrjVqdGlYZbu4=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=o1GoimRmZQIpITHQq4+zXq1XcNzS0ZjbEt0NxvdjqRg6LXuI6dbecNnqtPCpDA1uT
         BmQ/YZ+4loKyWi1i0PEb8xqpAQoEYG2INFN0hnmL5i+V5VoudDF5cvUaQT6MYDlq75
         uxtiDeJfEIeVnQQZTNwAcuoSoAUMl69KxJMGnGdEI5lOlGUFtjoO3npqNT1eBE1rwJ
         OvpIE1oTItPRjUera700bomPgu0RhTRVk51sM1vsMzyExfakXo9gIje14MI/OqmZkG
         HMxIjS3I5rWyCUHoEdzL8ui/VzcB+orZsIa6Iyiw3ojEGoQiKSFKXq0Y+R1ZjWeywg
         A1Su1tLFfWQww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0FF745C0A2D; Fri,  6 Jan 2023 16:10:24 -0800 (PST)
Date:   Fri, 6 Jan 2023 16:10:24 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH RFC] workqueue: Make show_pwq() use run-length encoding
Message-ID: <20230107001024.GA3893528@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The show_pwq() function dumps out a pool_workqueue structure's activity,
including the pending work-queue handlers:

 Showing busy workqueues and worker pools:
 workqueue events: flags=0x0
   pwq 0: cpus=0 node=0 flags=0x1 nice=0 active=10/256 refcnt=11
     in-flight: 7:test_work_func, 64:test_work_func, 249:test_work_func
     pending: test_work_func, test_work_func, test_work_func1, test_work_func1, test_work_func1, test_work_func1, test_work_func1

When large systems are facing certain types of hang conditions, it is not
unusual for this "pending" list to contain runs of hundreds of identical
function names.  This "wall of text" is difficult to read, and worse yet,
it can be interleaved with other output such as stack traces.

Therefore, make show_pwq() use run-length encoding so that the above
printout instead looks like this:

 Showing busy workqueues and worker pools:
 workqueue events: flags=0x0
   pwq 0: cpus=0 node=0 flags=0x1 nice=0 active=10/256 refcnt=11
     in-flight: 7:test_work_func, 64:test_work_func, 249:test_work_func
     pending: 2*test_work_func, 5*test_work_func1

When no comma would be printed, including the WORK_STRUCT_LINKED case,
a new run is started unconditionally.

This output is more readable, places less stress on the hardware,
firmware, and software on the console-log path, and reduces interference
with other output.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Dave Jones <davej@codemonkey.org.uk>
Cc: Rik van Riel <riel@surriel.com>

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 07895deca2711..73c4291776ab4 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4709,22 +4709,53 @@ static void pr_cont_pool_info(struct worker_pool *pool)
 	pr_cont(" flags=0x%x nice=%d", pool->flags, pool->attrs->nice);
 }
 
-static void pr_cont_work(bool comma, struct work_struct *work)
+struct pr_cont_work_struct {
+	bool comma;
+	work_func_t func;
+	long ctr;
+};
+
+static void pr_cont_work_flush(bool comma, work_func_t func, struct pr_cont_work_struct *pcwsp)
+{
+	if (!pcwsp->ctr)
+		goto out_record;
+	if (func == pcwsp->func) {
+		pcwsp->ctr++;
+		return;
+	}
+	if (pcwsp->ctr == 1)
+		pr_cont("%s %ps", pcwsp->comma ? "," : "", pcwsp->func);
+	else
+		pr_cont("%s %ld*%ps", pcwsp->comma ? "," : "", pcwsp->ctr, pcwsp->func);
+	pcwsp->ctr = 0;
+out_record:
+	if ((long)func == -1L)
+		return;
+	pcwsp->comma = comma;
+	pcwsp->func = func;
+	pcwsp->ctr = 1;
+}
+
+static void pr_cont_work(bool comma, struct work_struct *work, struct pr_cont_work_struct *pcwsp)
 {
 	if (work->func == wq_barrier_func) {
 		struct wq_barrier *barr;
 
 		barr = container_of(work, struct wq_barrier, work);
 
+		pr_cont_work_flush(comma, (work_func_t)-1, pcwsp);
 		pr_cont("%s BAR(%d)", comma ? "," : "",
 			task_pid_nr(barr->task));
 	} else {
-		pr_cont("%s %ps", comma ? "," : "", work->func);
+		if (!comma)
+			pr_cont_work_flush(comma, (work_func_t)-1, pcwsp);
+		pr_cont_work_flush(comma, work->func, pcwsp);
 	}
 }
 
 static void show_pwq(struct pool_workqueue *pwq)
 {
+	struct pr_cont_work_struct pcws = { .ctr = 0, };
 	struct worker_pool *pool = pwq->pool;
 	struct work_struct *work;
 	struct worker *worker;
@@ -4757,7 +4788,8 @@ static void show_pwq(struct pool_workqueue *pwq)
 				worker->rescue_wq ? "(RESCUER)" : "",
 				worker->current_func);
 			list_for_each_entry(work, &worker->scheduled, entry)
-				pr_cont_work(false, work);
+				pr_cont_work(false, work, &pcws);
+			pr_cont_work_flush(comma, (work_func_t)-1L, &pcws);
 			comma = true;
 		}
 		pr_cont("\n");
@@ -4777,9 +4809,10 @@ static void show_pwq(struct pool_workqueue *pwq)
 			if (get_work_pwq(work) != pwq)
 				continue;
 
-			pr_cont_work(comma, work);
+			pr_cont_work(comma, work, &pcws);
 			comma = !(*work_data_bits(work) & WORK_STRUCT_LINKED);
 		}
+		pr_cont_work_flush(comma, (work_func_t)-1L, &pcws);
 		pr_cont("\n");
 	}
 
@@ -4788,9 +4821,10 @@ static void show_pwq(struct pool_workqueue *pwq)
 
 		pr_info("    inactive:");
 		list_for_each_entry(work, &pwq->inactive_works, entry) {
-			pr_cont_work(comma, work);
+			pr_cont_work(comma, work, &pcws);
 			comma = !(*work_data_bits(work) & WORK_STRUCT_LINKED);
 		}
+		pr_cont_work_flush(comma, (work_func_t)-1L, &pcws);
 		pr_cont("\n");
 	}
 }
