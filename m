Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E7F73CA07
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 11:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjFXJWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 05:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjFXJWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 05:22:38 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C10F10FD
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 02:22:36 -0700 (PDT)
Received: from kwepemi500017.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qp7qD6ww7ztQcG;
        Sat, 24 Jun 2023 17:19:52 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.175.30) by
 kwepemi500017.china.huawei.com (7.221.188.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 24 Jun 2023 17:22:32 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <tanghui20@huawei.com>,
        <judy.chenhui@huawei.com>, <zhangqiao22@huawei.com>
Subject: [PATCH] sched/rt: Fix possible warn when push_rt_task
Date:   Sat, 24 Jun 2023 17:21:30 +0800
Message-ID: <20230624092130.174409-1-tanghui20@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.30]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500017.china.huawei.com (7.221.188.110)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A warn may be triggered during reboot, as follows:

reboot
  ->kernel_restart
    ->machine_restart
      ->smp_send_stop --- ipi handler set_cpu_online(cpu, false)

balance_callback
-> __balance_callback
  ->push_rt_task
    -> find_lock_lowest_rq  --- offline cpu in vec->mask not be cleared
      -> find_lowest_rq
        -> cpupri_find
          -> cpupri_find_fitness
            -> __cpupri_find [cpumask_and(..., vec->mask)]
    -> set_task_cpu(next_task, lowest_rq->cpu) --- WARN_ON(!oneline(cpu)

So add !cpu_online(lowest_rq->cpu) check before set_task_cpu().
The fix does not completely fix the problem, since cpu_online_mask may
be cleared after check.

Fixes: 4ff9083b8a9a8 ("sched/core: WARN() when migrating to an offline CPU")
Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 kernel/sched/rt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 00e0e5074115..852ef18b6a50 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2159,6 +2159,9 @@ static int push_rt_task(struct rq *rq, bool pull)
 		goto retry;
 	}
 
+	if (unlikely(!cpu_online(lowest_rq->cpu)))
+		goto out;
+
 	deactivate_task(rq, next_task, 0);
 	set_task_cpu(next_task, lowest_rq->cpu);
 	activate_task(lowest_rq, next_task, 0);
-- 
2.17.1

