Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC597617BBE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiKCLiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 07:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiKCLi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:38:27 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2713B1209D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 04:38:25 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N31wV6FFmz15MKj;
        Thu,  3 Nov 2022 19:38:18 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 19:38:23 +0800
Received: from huawei.com (10.67.174.191) by dggpeml500018.china.huawei.com
 (7.185.36.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 19:38:23 +0800
From:   Zhang Qiao <zhangqiao22@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <brauner@kernel.org>,
        <yusongping@huawei.com>, Zhang Qiao <zhangqiao22@huawei.com>
Subject: [PATCH v2 2/2] sched: Fix sched_child_runs_first
Date:   Thu, 3 Nov 2022 20:07:20 +0800
Message-ID: <20221103120720.39873-3-zhangqiao22@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221103120720.39873-1-zhangqiao22@huawei.com>
References: <20221103120720.39873-1-zhangqiao22@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.191]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two cases that the sched_child_runs_first maybe not
work fine:
1) when call clone3() with CLONE_INTO_CGROUP flags, will creating
the child task into a cgroup different from the parent's cgroup,
so that child and parent's cfs_rq is diffent.
2) Assign a different cpu to the new task when fork balancing.

Above two case, the child and the parent will attach to different
cpu and cfs_rq. At this time, we can't swap the child and parent's
vruntime, and i think only do swap vruntime when the parent and
child in the same cfs_rq. This patch will add the cfs_rq check
before swap vruntime.

Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
---
 kernel/sched/fair.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 34845d425180..6061ceb1b7cb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11612,7 +11612,9 @@ static void task_fork_fair(struct task_struct *p)
 	}
 	place_entity(cfs_rq, se, 1);
 
-	if (sysctl_sched_child_runs_first && curr && entity_before(curr, se)) {
+	if (sysctl_sched_child_runs_first &&
+		cfs_rq == task_cfs_rq(current) &&
+		curr && entity_before(curr, se)) {
 		/*
 		 * Upon rescheduling, sched_class::put_prev_task() will place
 		 * 'current' within the tree based on its new key value.
-- 
2.17.1

