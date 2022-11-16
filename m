Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5502A62B65E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238729AbiKPJWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237987AbiKPJWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:22:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FB427918;
        Wed, 16 Nov 2022 01:22:10 -0800 (PST)
Date:   Wed, 16 Nov 2022 09:22:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668590528;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BHQEDDMwoTFp0LWCfJMOqxB6Gfq97dnHEXsVY0s8iWI=;
        b=BvfKQVUEMiTwvi9uAg/nn+3ZgikN/BMKaJu7G5D931NSs+rcEtRizEMfdkuoXaxmqEbOFj
        kbp9G0o7JSAcQWaIw0EXqqOUc9nQxsWsJQnEwUs7jCFCxarPBQch6ZXd6BEbSpRAKbFzNb
        CgpMoUFRznRUJVOR/+l/QRwjjHcS2Na2F4W4EYhlwxjfatp0oyicQ3F89rVaHdbVCKqjyi
        v2mFJDfxOOBwhs4v8Uptt4Dc+rChIQ7r+j/Xi07oG3RBTg3AbJe2yKqJkwG1KkMsM9VD78
        qPm4AVEvzq0h0z7BZpeapoQCAwxd7gFsNF2w11JPbhIMLkG15/Z1Ra8MfbNW4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668590528;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BHQEDDMwoTFp0LWCfJMOqxB6Gfq97dnHEXsVY0s8iWI=;
        b=dnePpTk50Fn8RnEG3IS2dpORG2Ptqzs4b2zwj2KGLeM1OeWVpBL6Slsi5ksYDRfml6kep2
        QnUqeB7LqV28EYBw==
From:   "tip-bot2 for Tianchen Ding" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Clear ttwu_pending after enqueue_task()
Cc:     Tianchen Ding <dtcccc@linux.alibaba.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221104023601.12844-1-dtcccc@linux.alibaba.com>
References: <20221104023601.12844-1-dtcccc@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <166859052749.4906.16559111684554154074.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d6962c4fe8f96f7d384d6489b6b5ab5bf3e35991
Gitweb:        https://git.kernel.org/tip/d6962c4fe8f96f7d384d6489b6b5ab5bf3e35991
Author:        Tianchen Ding <dtcccc@linux.alibaba.com>
AuthorDate:    Fri, 04 Nov 2022 10:36:01 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 16 Nov 2022 10:13:05 +01:00

sched: Clear ttwu_pending after enqueue_task()

We found a long tail latency in schbench whem m*t is close to nr_cpus.
(e.g., "schbench -m 2 -t 16" on a machine with 32 cpus.)

This is because when the wakee cpu is idle, rq->ttwu_pending is cleared
too early, and idle_cpu() will return true until the wakee task enqueued.
This will mislead the waker when selecting idle cpu, and wake multiple
worker threads on the same wakee cpu. This situation is enlarged by
commit f3dd3f674555 ("sched: Remove the limitation of WF_ON_CPU on
wakelist if wakee cpu is idle") because it tends to use wakelist.

Here is the result of "schbench -m 2 -t 16" on a VM with 32vcpu
(Intel(R) Xeon(R) Platinum 8369B).

Latency percentiles (usec):
                base      base+revert_f3dd3f674555   base+this_patch
50.0000th:         9                            13                 9
75.0000th:        12                            19                12
90.0000th:        15                            22                15
95.0000th:        18                            24                17
*99.0000th:       27                            31                24
99.5000th:      3364                            33                27
99.9000th:     12560                            36                30

We also tested on unixbench and hackbench, and saw no performance
change.

Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lkml.kernel.org/r/20221104023601.12844-1-dtcccc@linux.alibaba.com
---
 kernel/sched/core.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 07ac08c..314c2c0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3739,13 +3739,6 @@ void sched_ttwu_pending(void *arg)
 	if (!llist)
 		return;
 
-	/*
-	 * rq::ttwu_pending racy indication of out-standing wakeups.
-	 * Races such that false-negatives are possible, since they
-	 * are shorter lived that false-positives would be.
-	 */
-	WRITE_ONCE(rq->ttwu_pending, 0);
-
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
 
@@ -3759,6 +3752,17 @@ void sched_ttwu_pending(void *arg)
 		ttwu_do_activate(rq, p, p->sched_remote_wakeup ? WF_MIGRATED : 0, &rf);
 	}
 
+	/*
+	 * Must be after enqueueing at least once task such that
+	 * idle_cpu() does not observe a false-negative -- if it does,
+	 * it is possible for select_idle_siblings() to stack a number
+	 * of tasks on this CPU during that window.
+	 *
+	 * It is ok to clear ttwu_pending when another task pending.
+	 * We will receive IPI after local irq enabled and then enqueue it.
+	 * Since now nr_running > 0, idle_cpu() will always get correct result.
+	 */
+	WRITE_ONCE(rq->ttwu_pending, 0);
 	rq_unlock_irqrestore(rq, &rf);
 }
 
