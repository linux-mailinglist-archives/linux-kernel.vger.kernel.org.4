Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BE1737C37
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjFUHQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjFUHQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:16:44 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249531703
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 00:16:43 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QmFDK6X21z1FDds;
        Wed, 21 Jun 2023 15:16:33 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 21 Jun
 2023 15:16:40 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] sched/fair: fix returning possible non-optimal candidate
Date:   Wed, 21 Jun 2023 15:16:05 +0800
Message-ID: <20230621071605.3853119-1-linmiaohe@huawei.com>
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

In best_fits < 0 case, best_thermal_cap > prev_thermal_cap is checked to
determine whether best_energy_cpu should be returned. But prev_fits can
be > 0 in this case and it should be preferred.

Fixes: e5ed0550c04c ("sched/fair: unlink misfit task from cpu overutilized")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 28ff831ee847..a4e300fc44be 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7684,7 +7684,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 	if ((best_fits > prev_fits) ||
 	    ((best_fits > 0) && (best_delta < prev_delta)) ||
-	    ((best_fits < 0) && (best_thermal_cap > prev_thermal_cap)))
+	    ((best_fits < 0) && (prev_fits < 0) && (best_thermal_cap > prev_thermal_cap)))
 		target = best_energy_cpu;
 
 	return target;
-- 
2.27.0

