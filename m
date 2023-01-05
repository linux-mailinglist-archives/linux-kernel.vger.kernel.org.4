Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0279B65E215
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjAEAzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjAEAyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:54:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F544D726;
        Wed,  4 Jan 2023 16:51:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43A8A61892;
        Thu,  5 Jan 2023 00:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB9CC43392;
        Thu,  5 Jan 2023 00:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879887;
        bh=KvTTOEuf3w3HlqviVybOzjEM5gng/swpX4BJIk+B47g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NGyVkmIQee17I1jwvZ64LOwKtzTsgwKuE0my358MPYotRSPRdZhIZ3vtVkzDvbKz5
         ZAIIt/oVOVISlenv3a+kWgsc8VbatWUXzybT92E7FQelrR85cuDLjTbjmbdZVxYcUT
         K6y1Q/8lF1SxKprLJKDuYOxvVWiOXBn4T4S666bnBjBa6XsGEbJFMzOUhkP8WNrJs/
         Be+frtvWL4W/NnvgnZFen+zoKiya4EP6ACJPFk98n//QO3s1+uOxyrY1H3ME2+f8Cp
         rLLno0Fur/WiCmHb96lAI9CH1+KBQZmxQV1l3oM6qc+SXR9rb9HzZRmHatQfRJGkql
         uP7lTROTxuaEg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 574A75C1ADF; Wed,  4 Jan 2023 16:51:27 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Zhen Lei <thunder.leizhen@huawei.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 5/6] rcu: Align the output of RCU CPU stall warning messages
Date:   Wed,  4 Jan 2023 16:51:25 -0800
Message-Id: <20230105005126.1772294-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105005105.GA1772125@paulmck-ThinkPad-P17-Gen-1>
References: <20230105005105.GA1772125@paulmck-ThinkPad-P17-Gen-1>
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

From: Zhen Lei <thunder.leizhen@huawei.com>

Time stamps are added to the output in kernels built with
CONFIG_PRINTK_TIME=y, which causes misaligned output.  Therefore,
replace pr_cont() with pr_err(), which fixes alignment and gets
rid of a couple of despised pr_cont() calls.

Before:
[   37.567343] rcu: INFO: rcu_preempt self-detected stall on CPU
[   37.567839] rcu:     0-....: (1500 ticks this GP) idle=***
[   37.568270]  (t=1501 jiffies g=4717 q=28 ncpus=4)
[   37.568668] CPU: 0 PID: 313 Comm: test0 Not tainted 6.1.0-rc4 #8

After:
[   36.762074] rcu: INFO: rcu_preempt self-detected stall on CPU
[   36.762543] rcu:     0-....: (1499 ticks this GP) idle=***
[   36.763003] rcu:     (t=1500 jiffies g=5097 q=27 ncpus=4)
[   36.763522] CPU: 0 PID: 313 Comm: test0 Not tainted 6.1.0-rc4 #9

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 6de15fb10bc47..f360894f5599d 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -619,7 +619,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 
 	for_each_possible_cpu(cpu)
 		totqlen += rcu_get_n_cbs_cpu(cpu);
-	pr_cont("\t(detected by %d, t=%ld jiffies, g=%ld, q=%lu ncpus=%d)\n",
+	pr_err("\t(detected by %d, t=%ld jiffies, g=%ld, q=%lu ncpus=%d)\n",
 	       smp_processor_id(), (long)(jiffies - gps),
 	       (long)rcu_seq_current(&rcu_state.gp_seq), totqlen, rcu_state.n_online_cpus);
 	if (ndetected) {
@@ -680,7 +680,7 @@ static void print_cpu_stall(unsigned long gps)
 	raw_spin_unlock_irqrestore_rcu_node(rdp->mynode, flags);
 	for_each_possible_cpu(cpu)
 		totqlen += rcu_get_n_cbs_cpu(cpu);
-	pr_cont("\t(t=%lu jiffies g=%ld q=%lu ncpus=%d)\n",
+	pr_err("\t(t=%lu jiffies g=%ld q=%lu ncpus=%d)\n",
 		jiffies - gps,
 		(long)rcu_seq_current(&rcu_state.gp_seq), totqlen, rcu_state.n_online_cpus);
 
-- 
2.31.1.189.g2e36527f23

