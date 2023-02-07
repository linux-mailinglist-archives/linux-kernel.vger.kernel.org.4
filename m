Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398B968D4BC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjBGKsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBGKr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:47:58 -0500
X-Greylist: delayed 507 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Feb 2023 02:47:56 PST
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 428D36EB1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:47:56 -0800 (PST)
HMM_SOURCE_IP: 172.18.0.218:35084.590389526
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-10.133.8.199 (unknown [172.18.0.218])
        by chinatelecom.cn (HERMES) with SMTP id F24C728009E;
        Tue,  7 Feb 2023 18:38:41 +0800 (CST)
X-189-SAVE-TO-SEND: +sunshouxin@chinatelecom.cn
Received: from  ([10.133.8.199])
        by app0025 with ESMTP id da9ed40eb9614456999228de222a632f for mingo@redhat.com;
        Tue, 07 Feb 2023 18:38:59 CST
X-Transaction-ID: da9ed40eb9614456999228de222a632f
X-Real-From: sunshouxin@chinatelecom.cn
X-Receive-IP: 10.133.8.199
X-MEDUSA-Status: 0
Sender: sunshouxin@chinatelecom.cn
From:   Sun Shouxin <sunshouxin@chinatelecom.cn>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, huyd12@chinatelecom.cn,
        sunshouxin@chinatelecom.cn
Subject: [PATCH] sched: sd_llc_id initialized
Date:   Tue,  7 Feb 2023 02:36:36 -0800
Message-Id: <20230207103636.13783-1-sunshouxin@chinatelecom.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In my test,I use isolcpus to isolate cpu for specific,
and then I noticed different scenario when core binding.

For example, the NUMA topology is as follows,
NUMA node0 CPU(s):               0-15,32-47
NUMA node1 CPU(s):               16-31,48-63

and the 'isolcpus' is as follows,
isolcpus=14,15,30,31,46,47,62,63

One task initially running on the non-isolated core belong to NUMA0
was bind to one isolated core on NUMA1, and then change its cpu affinity
to all cores, I notice the task can be scheduled back to the
non-isolated core on NUMA0.

1.taskset -pc 0-13 3512  (task running on core 1)
2.taskset -pc 63 3512    (task running on isolated core 63)
3.taskset -pc 0-63 3512  (task running on core 1)

Another case, one task initially running on the non-isolated core
belong to NUMA1 was bind to one isolated core on NUMA1,
and then change its cpu affinity to  all cores,
the task can not be scheduled out and always run on the isolated core.

1.taskset -pc 16-29 3512 (task running on core 17)
2.taskset -pc 63 3512    (task running on isolated core 63)
3.taskset -pc 0-63 3512  (task still running on core 63
                          and not schedule out)

The root cause is isolcpu not initialized sd_llc_id,
the default value is 0, and it causes cpus_share_cache doesn't work.
  select_task_rq_fair()
        select_idle_sibling()
                cpus_share_cache()

Suggested-by: Hu Yadi <huyd12@chinatelecom.cn>
Signed-off-by: Sun Shouxin <sunshouxin@chinatelecom.cn>
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8739c2a5a54e..89e98d410a8f 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -663,7 +663,7 @@ static void destroy_sched_domains(struct sched_domain *sd)
  */
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DEFINE_PER_CPU(int, sd_llc_size);
-DEFINE_PER_CPU(int, sd_llc_id);
+DEFINE_PER_CPU(int, sd_llc_id) = -1;
 DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
-- 
2.27.0

