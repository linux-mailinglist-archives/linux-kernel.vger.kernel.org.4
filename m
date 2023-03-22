Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDCC6C4642
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjCVJXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCVJXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:23:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A82D5070C;
        Wed, 22 Mar 2023 02:22:27 -0700 (PDT)
Date:   Wed, 22 Mar 2023 09:22:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679476945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1HcTumDeaE8hefYvRKp1CarUG+FHryAI2Op27a6IOj0=;
        b=mXoIuD2vOZBuvdOrnRmtHPTnsw0NV6NFwAZw+jlUWOuPaus89B35wQlFeIxSw7ELyxRjQS
        jWvvXpGrPlI5aNBGxjBnP+O8M4d4dkYAmc36HYyMLZzLxZ8jLClemYWNuGDVp5eXXTd3g1
        wnxWAmUDZ51zSAirliPVtrX05rabniticwo7i1V6+DVTB+RSJKsJIpk3z1r2zcjHqPMWKi
        8vJ2h89bGKBS0M+Gdu+n5gajy3Ty6FeZR9OhWMhQEdqCIv0fRKtriiM1UhXo2xuK1QtZUF
        Gpn9HDiRxyBh/EkgevX+VCFQZLubEQbKqvs4pZgrgGXd6g8irA5JBzV45W60gQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679476945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1HcTumDeaE8hefYvRKp1CarUG+FHryAI2Op27a6IOj0=;
        b=D0pg/5I8vJwZWt7VtxCtFNKDz/e6p2QbvSXA7TseYJHrMwhx2lN9zZ3zv7dS7ZRhVGINwy
        udGBgGbHkW+x6sDw==
From:   "tip-bot2 for Shrikanth Hegde" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Interleave cfs bandwidth timers for improved
 single thread performance at low utilization
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Ben Segall <bsegall@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230223185153.1499710-1-sshegde@linux.vnet.ibm.com>
References: <20230223185153.1499710-1-sshegde@linux.vnet.ibm.com>
MIME-Version: 1.0
Message-ID: <167947694435.5837.4783661617019925229.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     41abdba9374734b743019fc1cc05e3225c82ba6b
Gitweb:        https://git.kernel.org/tip/41abdba9374734b743019fc1cc05e3225c82ba6b
Author:        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
AuthorDate:    Fri, 24 Feb 2023 00:21:53 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Mar 2023 10:10:58 +01:00

sched: Interleave cfs bandwidth timers for improved single thread performance at low utilization

CPU cfs bandwidth controller uses hrtimer. Currently there is no initial
value set. Hence all period timers would align at expiry.
This happens when there are multiple CPU cgroup's.

There is a performance gain that can be achieved here if the timers are
interleaved when the utilization of each CPU cgroup is low and total
utilization of all the CPU cgroup's is less than 50%. If the timers are
interleaved, then the unthrottled cgroup can run freely without many
context switches and can also benefit from SMT Folding. This effect will
be further amplified in SPLPAR environment.

This commit adds a random offset after initializing each hrtimer. This
would result in interleaving the timers at expiry, which helps in achieving
the said performance gain.

This was tested on powerpc platform with 8 core SMT=8. Socket power was
measured when the workload. Benchmarked the stress-ng with power
information. Throughput oriented benchmarks show significant gain up to
25% while power consumption increases up to 15%.

Workload: stress-ng --cpu=32 --cpu-ops=50000.
1CG - 1 cgroup is running.
2CG - 2 cgroups are running together.
Time taken to complete stress-ng in seconds and power is in watts.
each cgroup is throttled at 25% with 100ms as the period value.
           6.2-rc6                     |   with patch
8 core   1CG    power   2CG     power  |  1CG    power  2 CG    power
        27.5    80.6    40      90     |  27.3    82    32.3    104
        27.5    81      40.2    91     |  27.5    81    38.7     96
        27.7    80      40.1    89     |  27.6    80    29.7    106
        27.7    80.1    40.3    94     |  27.6    80    31.5    105

Latency might be affected by this change. That could happen if the CPU was
in a deep idle state which is possible if we interleave the timers. Used
schbench for measuring the latency. Each cgroup is throttled at 25% with
period value is set to 100ms. Numbers are when both the cgroups are
running simultaneously. Latency values don't degrade much. Some
improvement is seen in tail latencies.

		6.2-rc6        with patch
Groups: 16
50.0th:          39.5            42.5
75.0th:         924.0           922.0
90.0th:         972.0           968.0
95.0th:        1005.5           994.0
99.0th:        4166.0          2287.0
99.5th:        7314.0          7448.0
99.9th:       15024.0         13600.0

Groups: 32
50.0th:         819.0           463.0
75.0th:        1596.0           918.0
90.0th:        5992.0          1281.5
95.0th:       13184.0          2765.0
99.0th:       21792.0         14240.0
99.5th:       25696.0         18920.0
99.9th:       33280.0         35776.0

Groups: 64
50.0th:        4806.0          3440.0
75.0th:       31136.0         33664.0
90.0th:       54144.0         58752.0
95.0th:       66176.0         67200.0
99.0th:       84736.0         91520.0
99.5th:       97408.0        114048.0
99.9th:      136448.0        140032.0

Initial RFC PATCH, discussions and details on the problem:

Link1: https://lore.kernel.org/lkml/5ae3cb09-8c9a-11e8-75a7-cc774d9bc283@linux.vnet.ibm.com/
Link2: https://lore.kernel.org/lkml/9c57c92c-3e0c-b8c5-4be9-8f4df344a347@linux.vnet.ibm.com/
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Shrikanth Hegde<sshegde@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ben Segall <bsegall@google.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20230223185153.1499710-1-sshegde@linux.vnet.ibm.com
---
 kernel/sched/fair.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b572367..bc358dc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5923,6 +5923,10 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
 	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
 	cfs_b->period_timer.function = sched_cfs_period_timer;
+
+	/* Add a random offset so that timers interleave */
+	hrtimer_set_expires(&cfs_b->period_timer,
+			    get_random_u32_below(cfs_b->period));
 	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	cfs_b->slack_timer.function = sched_cfs_slack_timer;
 	cfs_b->slack_started = false;
