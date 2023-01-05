Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C7B65E1F5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjAEAt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAEAsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:48:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F57630572;
        Wed,  4 Jan 2023 16:45:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4116618A0;
        Thu,  5 Jan 2023 00:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C8EC433EF;
        Thu,  5 Jan 2023 00:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879503;
        bh=kVT1HGBSl7LGywi0JFiEDrUmFvLHman/Yt/MTgK22Cc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QZg3Vmw+pnalljHEBPfGidZfVJkNWzTbNxrTJFrdmuXLqMrtlKhIyYsJJGwxSCfVm
         GyJGL7lJPn4EJ+Q60cntcETE+DTa4JH8nyT4Yl/ED+9N5xeiMWVsaBhKUWsktO3Xlo
         VMwSNlq3HcA4h8Urxcn0wXUeeb8t5FNXnRWK+WcntYtmyvkq/8O4ALU/nBAMr+sQ3i
         RwQx2iTPhm7b3GNoxCk4rdJXhUXqC4HJbPZIw7L0Shs1cXWNhwD3+u26B/O+5Kgu9+
         zOofsWii/ioo/yezCYFuy+9nIdNSMYHzfq9MgxKK5UB6iCDWFK7ivgbxZRpZ8ROy5l
         ucIF1h1pRWU1Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E11DC5C149B; Wed,  4 Jan 2023 16:45:02 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH rcu 3/6] rcu-tasks: Remove preemption disablement around srcu_read_[un]lock() calls
Date:   Wed,  4 Jan 2023 16:44:53 -0800
Message-Id: <20230105004501.1771332-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105004454.GA1771168@paulmck-ThinkPad-P17-Gen-1>
References: <20230105004454.GA1771168@paulmck-ThinkPad-P17-Gen-1>
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

From: Frederic Weisbecker <frederic@kernel.org>

Ever since the following commit:

	5a41344a3d83 ("srcu: Simplify __srcu_read_unlock() via this_cpu_dec()")

SRCU doesn't rely anymore on preemption to be disabled in order to
modify the per-CPU counter. And even then it used to be done from the API
itself.

Therefore and after checking further, it appears to be safe to remove
the preemption disablement around __srcu_read_[un]lock() in
exit_tasks_rcu_start() and exit_tasks_rcu_finish()

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Suggested-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 50d4c0ec7a89f..fbaed2637a7ff 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1008,9 +1008,7 @@ EXPORT_SYMBOL_GPL(show_rcu_tasks_classic_gp_kthread);
  */
 void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
 {
-	preempt_disable();
 	current->rcu_tasks_idx = __srcu_read_lock(&tasks_rcu_exit_srcu);
-	preempt_enable();
 }
 
 /*
@@ -1022,9 +1020,7 @@ void exit_tasks_rcu_finish(void) __releases(&tasks_rcu_exit_srcu)
 {
 	struct task_struct *t = current;
 
-	preempt_disable();
 	__srcu_read_unlock(&tasks_rcu_exit_srcu, t->rcu_tasks_idx);
-	preempt_enable();
 	exit_tasks_rcu_finish_trace(t);
 }
 
-- 
2.31.1.189.g2e36527f23

