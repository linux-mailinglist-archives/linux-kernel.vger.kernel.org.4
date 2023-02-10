Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20E869208C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjBJOKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjBJOJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:09:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F01B74077
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:09:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E4E3B8252A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 14:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21966C4339B;
        Fri, 10 Feb 2023 14:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676038177;
        bh=/jXn/vnDl0cDz/KxBmavjhz+/0Xao8NYmx2pabP5Zx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K/0jBDC/fMsnlIotZfR27XyUnoZAGtly6nQErhHRgQGnqqJKeNqcwk4AifODzILik
         kAKP+wCFxOBpg8K7GGp48xIXbzDFrmmS6IbNgnYFH0F5iB3DUg02eTjc0xi/YLHbt7
         Fp5IDGzrrXA6YVu2fiqpcTa/JSZkR8I467GGH59b1zgQSHmKQrY0ZMGTCw1QK+zu6p
         bT4dkVZGhq7YrXFv4dxexV95Rylakm7gf3RqcBFSLBz9kvtlPffJ1pnKh7pXozchBd
         RUX8WwYq4wE8/s6gYsYcntQXf/vuqwmUvLGETk+SYEMrS5EdFw6I2S026Oa23G8pBc
         TMzu2JVON+NvQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wei Li <liwei391@huawei.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 5/6] timers/nohz: Remove middle-function __tick_nohz_idle_stop_tick()
Date:   Fri, 10 Feb 2023 15:09:16 +0100
Message-Id: <20230210140917.279062-6-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230210140917.279062-1-frederic@kernel.org>
References: <20230210140917.279062-1-frederic@kernel.org>
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

There is no need for the __tick_nohz_idle_stop_tick() function between
tick_nohz_idle_stop_tick() and its implementation. Remove that
unnecessary step.

Cc: Hillf Danton <hdanton@sina.com>
Cc: Yu Liao <liaoyu15@huawei.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wei Li <liwei391@huawei.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index bd9499fb15b3..7065c6e373e9 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1080,10 +1080,16 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
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
@@ -1115,16 +1121,6 @@ static void __tick_nohz_idle_stop_tick(struct tick_sched *ts)
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

