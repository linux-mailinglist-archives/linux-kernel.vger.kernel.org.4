Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D26672438F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237880AbjFFNEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236069AbjFFNEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:04:37 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12547E77
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 06:04:35 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qb9YG1VhszqSSH;
        Tue,  6 Jun 2023 20:59:46 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 6 Jun
 2023 21:04:32 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] sched/fair: remove cfs_bandwidth_used() when !CONFIG_CFS_BANDWIDTH
Date:   Tue, 6 Jun 2023 21:04:20 +0800
Message-ID: <20230606130420.479325-1-linmiaohe@huawei.com>
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

When CONFIG_CFS_BANDWIDTH is disabled, cfs_bandwidth_used() is not used.
Remove it. Also remove unneeded cfs_bandwidth_used() forward declaration.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/sched/fair.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1b626310cf8c..771bc9f1efb3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4781,8 +4781,6 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
 
-static inline bool cfs_bandwidth_used(void);
-
 /*
  * MIGRATION
  *
@@ -6134,11 +6132,6 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 
 #else /* CONFIG_CFS_BANDWIDTH */
 
-static inline bool cfs_bandwidth_used(void)
-{
-	return false;
-}
-
 static void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec) {}
 static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq) { return false; }
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq) {}
-- 
2.27.0

