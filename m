Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E5F69CB38
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 13:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjBTMmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 07:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjBTMlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:41:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F54F1C7D9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 04:41:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FA9560DFE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 12:41:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F66DC433EF;
        Mon, 20 Feb 2023 12:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676896910;
        bh=/vEaMsqtOE5BkbGfNS7gZR33SAARhK8GonMdLs7ceS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a5srEQPiwndG2qYWSkwb6rz1hH5ZVUDeQ2bFUcDI6YBO+xzbD/iIfGszglsuGKp5e
         MH7Ad4jfdvMpfhuoJavBuWPhogEG7Kz800j04tctQ6gZNCI6dfGJYU/TZ8PWSxkvYf
         4nPImLjb7Vd0cZtcctfDUsklZIC5ei4MAj9Jza9gPa9wo6Ur+1vUyoKzANBpVz7RM8
         M/8Su6Lw/ro331OCHWm3ehQckWGNT//2EWfYRLxnjHdBKYQrrP0cmoGbJcyYYdivtR
         cSWmBMlDUiwQYK7K42MOUibMQG2vSYBxP7pAmQcSqR2ER/thhC8yWCDZKSuMnOTJ0S
         2TZS50Vr4z6LQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wei Li <liwei391@huawei.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Yu Liao <liaoyu15@huawei.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 5/7] timers/nohz: Remove middle-function __tick_nohz_idle_stop_tick()
Date:   Mon, 20 Feb 2023 13:41:27 +0100
Message-Id: <20230220124129.519477-6-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220124129.519477-1-frederic@kernel.org>
References: <20230220124129.519477-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need for the __tick_nohz_idle_stop_tick() function between
tick_nohz_idle_stop_tick() and its implementation. Remove that
unnecessary step.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Yu Liao <liaoyu15@huawei.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wei Li <liwei391@huawei.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index edd6e9f26d16..3b53b894ca98 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1079,10 +1079,16 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 	return true;
 }
 
-static void __tick_nohz_idle_stop_tick(struct tick_sched *ts)
+/**
+ * tick_nohz_idle_stop_tick - stop the idle tick from the idle task
+ *
+ * When the next event is more than a tick into the future, stop the idle tick
+ */
+void tick_nohz_idle_stop_tick(void)
 {
+	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
+	int cpu = smp_processor_id();
 	ktime_t expires;
-	int cpu = smp_processor_id();
 
 	/*
 	 * If tick_nohz_get_sleep_length() ran tick_nohz_next_event(), the
@@ -1114,16 +1120,6 @@ static void __tick_nohz_idle_stop_tick(struct tick_sched *ts)
 	}
 }
 
-/**
- * tick_nohz_idle_stop_tick - stop the idle tick from the idle task
- *
- * When the next event is more than a tick into the future, stop the idle tick
- */
-void tick_nohz_idle_stop_tick(void)
-{
-	__tick_nohz_idle_stop_tick(this_cpu_ptr(&tick_cpu_sched));
-}
-
 void tick_nohz_idle_retain_tick(void)
 {
 	tick_nohz_retain_tick(this_cpu_ptr(&tick_cpu_sched));
-- 
2.34.1

