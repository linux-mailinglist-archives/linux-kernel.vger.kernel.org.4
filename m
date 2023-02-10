Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9851269208B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjBJOKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbjBJOJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:09:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E64674998
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:09:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C466B824CF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 14:09:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE88C433EF;
        Fri, 10 Feb 2023 14:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676038174;
        bh=H1/1wQpakm7Rwe+HqpYOF44S3z7tTyE+Intx0NLRpx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DDFnJHQOZ66Z8Tl3ybE0nX4k4L/0RQNDRp2D04Wg023oD/b/WgkR/ryauQ70mOTJ6
         45qevKmTRI7WuMliaLFNQVIEmLo7ozbu8cUMYP4mNGgIIOdokUmWR5vrzZNqngvaTk
         lcEtMzqME/TABgcQjOSAMWr1oM2XPW1NoNH+0xlpa8VR6jZHsquv4s0Mtg4SyvVWSn
         VRuKc9pscKhM40MDPYz+ErJ+ujq1YgKXCgvCuUf0dNVc8Vo3gA/oQs8PWHcnRhAnO/
         9qslSokLvZDWXpIa+c7auLCdX0bJn3g1vPocg1jQPBDFOam9Ex1sEF9i5OINpplvne
         x6BmcZmSCQumQ==
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
Subject: [PATCH 4/6] timers/nohz: Add a comment about broken iowait counter update race
Date:   Fri, 10 Feb 2023 15:09:15 +0100
Message-Id: <20230210140917.279062-5-frederic@kernel.org>
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

The per-cpu iowait task counter is incremented locally upon sleeping.
But since the task can be woken to (and by) another CPU, the counter may
then be decremented remotely. This is the source of a race involving
readers VS writer of idle/iowait sleeptime.

The following scenario shows an example where a /proc/stat reader
observes a pending sleep time as IO whereas that pending sleep time
later eventually gets accounted as non-IO.

    CPU 0                       CPU  1                    CPU 2
    -----                       -----                     ------
    //io_schedule() TASK A
    current->in_iowait = 1
    rq(0)->nr_iowait++
    //switch to idle
                        // READ /proc/stat
                        // See nr_iowait_cpu(0) == 1
                        return ts->iowait_sleeptime +
                               ktime_sub(ktime_get(), ts->idle_entrytime)

                                                          //try_to_wake_up(TASK A)
                                                          rq(0)->nr_iowait--
    //idle exit
    // See nr_iowait_cpu(0) == 0
    ts->idle_sleeptime += ktime_sub(ktime_get(), ts->idle_entrytime)

As a result subsequent reads on /proc/stat may expose backward progress.

This is unfortunately hardly fixable. Just add a comment about that
condition.

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
 kernel/time/tick-sched.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 757e03ef4409..bd9499fb15b3 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -706,7 +706,10 @@ static u64 get_cpu_sleep_time_us(int cpu, ktime_t *sleeptime,
  * counters if NULL.
  *
  * Return the cumulative idle time (since boot) for a given
- * CPU, in microseconds.
+ * CPU, in microseconds. Note this is partially broken due to
+ * the counter of iowait tasks that can be remotely updated without
+ * any synchronization. Therefore it is possible to observe backward
+ * values within two consecutive reads.
  *
  * This time is measured via accounting rather than sampling,
  * and is as accurate as ktime_get() is.
@@ -729,7 +732,10 @@ EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
  * counters if NULL.
  *
  * Return the cumulative iowait time (since boot) for a given
- * CPU, in microseconds.
+ * CPU, in microseconds. Note this is partially broken due to
+ * the counter of iowait tasks that can be remotely updated without
+ * any synchronization. Therefore it is possible to observe backward
+ * values within two consecutive reads.
  *
  * This time is measured via accounting rather than sampling,
  * and is as accurate as ktime_get() is.
-- 
2.34.1

