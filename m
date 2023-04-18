Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B066E6791
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjDROxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjDROxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:53:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE2FAD2A;
        Tue, 18 Apr 2023 07:53:31 -0700 (PDT)
Date:   Tue, 18 Apr 2023 14:53:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681829609;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=idUFnLwc9DEicaszUNU0vcf7I7imSGPqvv4DdMdr8TA=;
        b=mV2CO4dmI6IEPEdsbfIHwEROgvvjDutm5oXeKCuSPCD9nBdriYVBIblnu8rharWNHnmYE3
        Su6JU9JBwoVt7M/vgEvJ1eeifnzT4eVXJDPHsApMx2NsfbGPlpxY33spA9AEYWHQXAPII+
        kNoM9ZI/JTYPT0xqR0x89TiqGEVWMY39pv3Ax+oZZr7E4Nw+xhgiyg70te8bzcKULMMtoo
        2P0qKQvGs6Mx++zDWeIDYfMHMvX6BwdaGPU37rjZF22gwDK37JVhKnjceg9IICs+LLWp0T
        YnROErOEHr5TBIfFqYMgQhSi/UXJU+HgGV3/PXtL4EiqMwdLJIrOgGxJ+GSkyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681829609;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=idUFnLwc9DEicaszUNU0vcf7I7imSGPqvv4DdMdr8TA=;
        b=hejqBdWfk07hDMeXqdHKjDzZ6XFbBu7X9RWV8G29DlTc6xy2gSs28kwXyMhmYtywx2g2cS
        oeRKITnDX1iPs7CA==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers/nohz: Add a comment about broken iowait
 counter update race
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230222144649.624380-5-frederic@kernel.org>
References: <20230222144649.624380-5-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <168182960920.404.6558173122716747219.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ead70b75237371c735a481a9843b411cfbb18404
Gitweb:        https://git.kernel.org/tip/ead70b75237371c735a481a9843b411cfbb18404
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 22 Feb 2023 15:46:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Apr 2023 16:35:12 +02:00

timers/nohz: Add a comment about broken iowait counter update race

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

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230222144649.624380-5-frederic@kernel.org

---
 kernel/time/tick-sched.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 90d9b7b..edd6e9f 100644
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
