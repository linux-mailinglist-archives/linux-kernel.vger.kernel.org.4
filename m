Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF34462B1F5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 04:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiKPDwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 22:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbiKPDv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 22:51:58 -0500
Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FDCDCD4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 19:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=mxUoc
        FvherJGTnqKrGqP9XwP0x8frYPYHY3cRrvAGko=; b=jOGAss/noC4c+foei6sNY
        0fRytzSt3KNXMOe2groizBwyFysrQSWHXjjFV7hryVp19I/3fiGpFgOR8GVe5P3h
        3+epX4N6IiMX9C33rpND/6WQIX5TKQXNsXvkbCL381WuTk1uUrMCV1sNgjBYvq77
        YenIRpO2kcEseZkMxCdCQQ=
Received: from localhost (unknown [49.235.41.28])
        by smtp13 (Coremail) with SMTP id EcCowAD3R5rwXXRjqLUHpw--.28813S2;
        Wed, 16 Nov 2022 11:50:09 +0800 (CST)
Date:   Wed, 16 Nov 2022 11:50:08 +0800
From:   Hui Su <suhui_kernel@163.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     suhui@zeku.com
Subject: [PATCH] sched: use nr_cpus_node() here
Message-ID: <Y3Rd8B7oRjds4yCB@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: EcCowAD3R5rwXXRjqLUHpw--.28813S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xry8Aw1kKry7GryrGr15urg_yoWkXrg_W3
        Wrur1Fgw1vvw4IvFZrAw4xXr9Yqa48KFnakw1fKayUZryUtrZxA3s8AF95Xrn5Xws7JFZx
        trn0qFsxtrn8GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjdcTJUUUUU==
X-Originating-IP: [49.235.41.28]
X-CM-SenderInfo: 5vxk3xhbnh20lho6il2tof0z/1tbivBG7bWASZ2bXgwAAsc
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use nr_cpus_node() here

Signed-off-by: Hui Su <suhui_kernel@163.com>
---
 kernel/sched/fair.c     | 2 +-
 kernel/sched/topology.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e4a0b8bd941c..94e3c9169a8f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1805,7 +1805,7 @@ static void update_numa_stats(struct task_numa_env *env,
 	}
 	rcu_read_unlock();
 
-	ns->weight = cpumask_weight(cpumask_of_node(nid));
+	ns->weight = nr_cpus_node(nid);
 
 	ns->node_type = numa_classify(env->imbalance_pct, ns);
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8739c2a5a54e..4d06ec82c61b 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1999,7 +1999,7 @@ void sched_update_numa(int cpu, bool online)
 	 * Scheduler NUMA topology is updated when the first CPU of a
 	 * node is onlined or the last CPU of a node is offlined.
 	 */
-	if (cpumask_weight(cpumask_of_node(node)) != 1)
+	if (nr_cpus_node(node) != 1)
 		return;
 
 	sched_reset_numa();
-- 
2.34.1

