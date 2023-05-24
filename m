Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBAE70EB5B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 04:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239043AbjEXCd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 22:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbjEXCdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 22:33:55 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D11FE6
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 19:33:53 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QQwFM4H6ZzLmGj;
        Wed, 24 May 2023 10:32:23 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 24 May
 2023 10:33:50 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] sched/deadline: remove unused dl_bandwidth
Date:   Wed, 24 May 2023 18:25:14 +0800
Message-ID: <20230524102514.407486-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default deadline bandwidth control structure has been removed since
commit eb77cf1c151c ("sched/deadline: Remove unused def_dl_bandwidth")
leading to unused init_dl_bandwidth() and struct dl_bandwidth. Remove
them to clean up the code.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/sched/deadline.c | 7 -------
 kernel/sched/sched.h    | 7 -------
 2 files changed, 14 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index fe983ed7bb12..7c98ca1f7300 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -482,13 +482,6 @@ static inline int is_leftmost(struct task_struct *p, struct dl_rq *dl_rq)
 
 static void init_dl_rq_bw_ratio(struct dl_rq *dl_rq);
 
-void init_dl_bandwidth(struct dl_bandwidth *dl_b, u64 period, u64 runtime)
-{
-	raw_spin_lock_init(&dl_b->dl_runtime_lock);
-	dl_b->dl_period = period;
-	dl_b->dl_runtime = runtime;
-}
-
 void init_dl_bw(struct dl_bw *dl_b)
 {
 	raw_spin_lock_init(&dl_b->lock);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1704763897d0..d79f4fd53600 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -286,12 +286,6 @@ struct rt_bandwidth {
 
 void __dl_clear_params(struct task_struct *p);
 
-struct dl_bandwidth {
-	raw_spinlock_t		dl_runtime_lock;
-	u64			dl_runtime;
-	u64			dl_period;
-};
-
 static inline int dl_bandwidth_enabled(void)
 {
 	return sysctl_sched_rt_runtime >= 0;
@@ -2394,7 +2388,6 @@ extern struct rt_bandwidth def_rt_bandwidth;
 extern void init_rt_bandwidth(struct rt_bandwidth *rt_b, u64 period, u64 runtime);
 extern bool sched_rt_bandwidth_account(struct rt_rq *rt_rq);
 
-extern void init_dl_bandwidth(struct dl_bandwidth *dl_b, u64 period, u64 runtime);
 extern void init_dl_task_timer(struct sched_dl_entity *dl_se);
 extern void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se);
 
-- 
2.27.0

