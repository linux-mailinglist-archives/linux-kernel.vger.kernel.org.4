Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C28733F42
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 09:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345804AbjFQHnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 03:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbjFQHnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 03:43:40 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823BC26BE
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 00:43:38 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Qjp1K05GFz18Lq7;
        Sat, 17 Jun 2023 15:43:33 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 17 Jun
 2023 15:43:34 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] sched/deadline: Use helper function task_current()
Date:   Sat, 17 Jun 2023 15:43:05 +0800
Message-ID: <20230617074305.1916633-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use helper function task_current() to check whether task is currently
running on the runqueue. No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/sched/deadline.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f827067ad03b..23284229e16b 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2424,7 +2424,7 @@ static void pull_dl_task(struct rq *this_rq)
 		 */
 		if (p && dl_time_before(p->dl.deadline, dmin) &&
 		    dl_task_is_earliest_deadline(p, this_rq)) {
-			WARN_ON(p == src_rq->curr);
+			WARN_ON(task_current(src_rq, p));
 			WARN_ON(!task_on_rq_queued(p));
 
 			/*
@@ -2636,7 +2636,7 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
 		return;
 	}
 
-	if (rq->curr != p) {
+	if (!task_current(rq, p)) {
 #ifdef CONFIG_SMP
 		if (p->nr_cpus_allowed > 1 && rq->dl.overloaded)
 			deadline_queue_push_tasks(rq);
-- 
2.27.0

