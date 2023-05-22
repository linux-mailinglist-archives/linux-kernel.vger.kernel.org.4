Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D0770B3FC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 06:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjEVEFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 00:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjEVEE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 00:04:58 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E1BCA
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 21:04:56 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QPkM46PxQzLmJn;
        Mon, 22 May 2023 12:03:12 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 22 May
 2023 12:04:38 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] sched/deadline: simplify dl_bw_cpus() using cpumask_weight_and()
Date:   Mon, 22 May 2023 19:56:05 +0800
Message-ID: <20230522115605.1238227-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpumask_weight_and() can be used to count of bits both in rd->span and
cpu_active_mask. No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/sched/deadline.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 166c3e6eae61..fe983ed7bb12 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -110,20 +110,11 @@ static inline struct dl_bw *dl_bw_of(int i)
 static inline int dl_bw_cpus(int i)
 {
 	struct root_domain *rd = cpu_rq(i)->rd;
-	int cpus;
 
 	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
 			 "sched RCU must be held");
 
-	if (cpumask_subset(rd->span, cpu_active_mask))
-		return cpumask_weight(rd->span);
-
-	cpus = 0;
-
-	for_each_cpu_and(i, rd->span, cpu_active_mask)
-		cpus++;
-
-	return cpus;
+	return cpumask_weight_and(rd->span, cpu_active_mask);
 }
 
 static inline unsigned long __dl_bw_capacity(const struct cpumask *mask)
-- 
2.27.0

