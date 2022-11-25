Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AE6638BA5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiKYNzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiKYNzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:55:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3660B21E;
        Fri, 25 Nov 2022 05:55:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC87962457;
        Fri, 25 Nov 2022 13:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE43C433D6;
        Fri, 25 Nov 2022 13:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669384509;
        bh=Q8JjNQ5bUk4AZ2CfSjRxxwMV7KD/wuw64pWCocyDRgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JaRLG4y8AXSHW+V/j1dU5Z7h2CjWGPm9A3Hve6Luaou4atZcm0ge2x8XLpWVJ3yV6
         m7EpeG4ynFyGNSgYyCFDOs3gR+Re6P2x6BaqO0eOd76kOKWV14Ojnl4iKjsHVkPFsm
         WMJtIw5d8oqBJLgNd7cGWS8ovokOyJKTGI/OeWuDWgSRmIa6mlN+asvF+vijYbfHlD
         nvsmj3RVm19vGniDoCTbTsDJvWz2WCPcdtTHsNLE21Qjf2g9VR+igHQIrlyRyf9d+b
         u/st5dXe6yQ2xtnj2cPHEghdY+Dq+ecDmDZD6frC7fCFU10cWTSjlk301WXkaZEz4G
         aK5negbtrDb1g==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org
Subject: [PATCH 1/3] rcu-tasks: Improve comments explaining tasks_rcu_exit_srcu purpose
Date:   Fri, 25 Nov 2022 14:54:58 +0100
Message-Id: <20221125135500.1653800-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221125135500.1653800-1-frederic@kernel.org>
References: <20221125135500.1653800-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure we don't need to look again into the depths of git blame in
order not to miss a subtle part about how rcu-tasks is dealing with
exiting tasks.

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Suggested-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tasks.h | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 4a991311be9b..7deed6135f73 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -827,11 +827,21 @@ static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
 static void rcu_tasks_postscan(struct list_head *hop)
 {
 	/*
-	 * Wait for tasks that are in the process of exiting.  This
-	 * does only part of the job, ensuring that all tasks that were
-	 * previously exiting reach the point where they have disabled
-	 * preemption, allowing the later synchronize_rcu() to finish
-	 * the job.
+	 * Exiting tasks may escape the tasklist scan. Those are vulnerable
+	 * until their final schedule() with TASK_DEAD state. To cope with
+	 * this, divide the fragile exit path part in two intersecting
+	 * read side critical sections:
+	 *
+	 * 1) An _SRCU_ read side starting before calling exit_notify(),
+	 *    which may remove the task from the tasklist, and ending after
+	 *    the final preempt_disable() call in do_exit().
+	 *
+	 * 2) An _RCU_ read side starting with the final preempt_disable()
+	 *    call in do_exit() and ending with the final call to schedule()
+	 *    with TASK_DEAD state.
+	 *
+	 * This handles the part 1). And postgp will handle part 2) with a
+	 * call to synchronize_rcu().
 	 */
 	synchronize_srcu(&tasks_rcu_exit_srcu);
 }
@@ -898,7 +908,10 @@ static void rcu_tasks_postgp(struct rcu_tasks *rtp)
 	 *
 	 * In addition, this synchronize_rcu() waits for exiting tasks
 	 * to complete their final preempt_disable() region of execution,
-	 * cleaning up after the synchronize_srcu() above.
+	 * cleaning up after synchronize_srcu(&tasks_rcu_exit_srcu),
+	 * enforcing the whole region before tasklist removal until
+	 * the final schedule() with TASK_DEAD state to be an RCU TASKS
+	 * read side critical section.
 	 */
 	synchronize_rcu();
 }
@@ -988,7 +1001,11 @@ void show_rcu_tasks_classic_gp_kthread(void)
 EXPORT_SYMBOL_GPL(show_rcu_tasks_classic_gp_kthread);
 #endif // !defined(CONFIG_TINY_RCU)
 
-/* Do the srcu_read_lock() for the above synchronize_srcu().  */
+/*
+ * Contribute to protect against tasklist scan blind spot while the
+ * task is exiting and may be removed from the tasklist. See
+ * corresponding synchronize_srcu() for further details.
+ */
 void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
 {
 	preempt_disable();
@@ -996,7 +1013,11 @@ void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
 	preempt_enable();
 }
 
-/* Do the srcu_read_unlock() for the above synchronize_srcu().  */
+/*
+ * Contribute to protect against tasklist scan blind spot while the
+ * task is exiting and may be removed from the tasklist. See
+ * corresponding synchronize_srcu() for further details.
+ */
 void exit_tasks_rcu_finish(void) __releases(&tasks_rcu_exit_srcu)
 {
 	struct task_struct *t = current;
-- 
2.25.1

