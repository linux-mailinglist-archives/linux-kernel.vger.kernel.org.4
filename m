Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBCF737BB1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjFUGyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjFUGyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:54:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400AB10D5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:54:10 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QmDjd4tYHzTkkX;
        Wed, 21 Jun 2023 14:53:25 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 21 Jun
 2023 14:54:06 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] sched/fair: fix possible active balance misbehavior
Date:   Wed, 21 Jun 2023 14:53:31 +0800
Message-ID: <20230621065331.3793767-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

In LBF_DST_PINNED case, env.dst_cpu won't be equal to this_cpu. So when
need_active_balance() returns true, env.dst_cpu should be used to do the
active balance stuff instead of this_cpu.

Fixes: 88b8dac0a14c ("sched: Improve balance_cpu() to consider other cpus in its group as target of (pinned) task")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/sched/fair.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5e90e9658528..28ff831ee847 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10968,14 +10968,14 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 			/*
 			 * Don't kick the active_load_balance_cpu_stop,
 			 * if the curr task on busiest CPU can't be
-			 * moved to this_cpu:
+			 * moved to env.dst_cpu:
 			 */
-			if (!cpumask_test_cpu(this_cpu, busiest->curr->cpus_ptr)) {
+			if (!cpumask_test_cpu(env.dst_cpu, busiest->curr->cpus_ptr)) {
 				raw_spin_rq_unlock_irqrestore(busiest, flags);
 				goto out_one_pinned;
 			}
 
-			/* Record that we found at least one task that could run on this_cpu */
+			/* Record that we found at least one task that could run on env.dst_cpu */
 			env.flags &= ~LBF_ALL_PINNED;
 
 			/*
@@ -10985,7 +10985,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 			 */
 			if (!busiest->active_balance) {
 				busiest->active_balance = 1;
-				busiest->push_cpu = this_cpu;
+				busiest->push_cpu = env.dst_cpu;
 				active_balance = 1;
 			}
 			raw_spin_rq_unlock_irqrestore(busiest, flags);
-- 
2.27.0

