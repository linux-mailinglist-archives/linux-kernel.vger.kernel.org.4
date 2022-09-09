Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E475B42DB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 01:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiIIXHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 19:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiIIXGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:06:37 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E07113C5E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 16:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662764795; x=1694300795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ph2e/rZv3NU9Gpgu/xHvmk0/dbumZf1WgNIx8DuCq7c=;
  b=b/Is0rM6YF9A6hHBaYOwsZnTaTsPDi76V8P6+bwPKkgqqll8/ebKFPry
   nx2Nywzi4FSbnPMTARQIxoNRO4AlQ8LZj/RxUldX2RB5Dex8+uOTwBsTE
   edjW2qprm9vReGgZvMkyvudrtWTPOxz/NT4S/TKIHvkYx3mu0ndhN5QbI
   blpLG5SjvFhXaKPPj3iH6aVtpEOb//Nk7odww8XxA0B33iHdYA8CuKq83
   p9N6UkYuhbVyUacRRr6iTGZYPygyGMlVDftoG/IU1tC9HV5RM/AHTiQyR
   s6dhMlHCn3YjOtim96wHmnLyOK3SL6+DJuoeEsEp/kJVeW8n73CJoB7tf
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="298386913"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="298386913"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 16:06:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="677355003"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 09 Sep 2022 16:06:33 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: [RFC PATCH 10/23] sched/fair: Use classes of tasks when selecting a busiest runqueue
Date:   Fri,  9 Sep 2022 16:11:52 -0700
Message-Id: <20220909231205.14009-11-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For two runqueues of equal priority and equal number of running of tasks,
select the one whose current task would have the highest task class score
if placed on the destination CPU.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 kernel/sched/fair.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7368a0b453ee..085b1f75d90b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10009,6 +10009,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 	int i;
 
 	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
+		int busiest_class_delta_score = INT_MIN;
 		unsigned long capacity, load, util;
 		unsigned int nr_running;
 		enum fbq_type rt;
@@ -10118,6 +10119,20 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 			if (busiest_nr < nr_running) {
 				busiest_nr = nr_running;
 				busiest = rq;
+			} else if (sched_task_classes_enabled() &&
+				   busiest_nr == nr_running) {
+				int curr_class_delta_score;
+
+				curr_class_delta_score = arch_get_task_class_score(rq->curr->class,
+										   env->dst_cpu) -
+							 arch_get_task_class_score(rq->curr->class,
+										   cpu_of(rq));
+
+				if (busiest_class_delta_score < curr_class_delta_score) {
+					busiest_class_delta_score = curr_class_delta_score;
+					busiest_nr = nr_running;
+					busiest = rq;
+				}
 			}
 			break;
 
-- 
2.25.1

