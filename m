Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EB069CB37
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 13:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjBTMl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 07:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjBTMlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:41:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEC61BAF2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 04:41:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D8B260E33
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 12:41:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC05CC4339C;
        Mon, 20 Feb 2023 12:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676896908;
        bh=60UVPMKRBBZlhZputsHs6D/GUWH9jHmYFrcL5ldfROQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PW/cfZURgb8rw72fj8OFpH2k/DraGTS8gVcDyP305YoNKlpHDRioW9LsBiA7vPQOp
         Flgz9pbIQbhsiWWlFjoLpfC8hDdVX8Bk4OuXEHhiEl6znb/tocE/D68iLJp8BwR9Vs
         Kil48MoAV47ng/G5qZUxpdaTvWPnppG/5QjFqegLjX+qXSzuahgwUstYDZMYjPF+O8
         emFAvnmIYNw32LTP2LLKk5NIvMtDlQFDh7VwJXgi4luIeewp0Pz6GM2+c4h3I+JLyg
         9mfkcXtlucp6lY+q8D7WRfxsMIGHi3ZuAZVBOJ8lzVFxm8N5nJ2LjVf5MaW0nNKyPc
         G2hja8GTgz2rQ==
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
Subject: [PATCH 4/7] timers/nohz: Add a comment about broken iowait counter update race
Date:   Mon, 20 Feb 2023 13:41:26 +0100
Message-Id: <20230220124129.519477-5-frederic@kernel.org>
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
 kernel/time/tick-sched.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 90d9b7b29875..edd6e9f26d16 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -705,7 +705,10 @@ static u64 get_cpu_sleep_time_us(struct tick_sched *ts, ktime_t *sleeptime,
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
@@ -728,7 +731,10 @@ EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
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

