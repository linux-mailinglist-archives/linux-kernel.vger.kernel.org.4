Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013D5733F95
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 10:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346251AbjFQIUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 04:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjFQIT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 04:19:58 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D976173A
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 01:19:57 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QjpqF1rqjz18MBy;
        Sat, 17 Jun 2023 16:19:53 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 17 Jun
 2023 16:19:54 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] sched/topology: remove unneeded do while loop in cpu_attach_domain()
Date:   Sat, 17 Jun 2023 16:19:26 +0800
Message-ID: <20230617081926.2035113-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

When sg != sd->groups, the do while loop would cause deadloop here. But
that won't occur because sg is always equal to sd->groups now. Remove
this unneeded do while loop.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/sched/topology.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index ca4472281c28..9010c93c3fdb 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -750,10 +750,7 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 			 * domain for convenience. Clear such flags since
 			 * the child is being destroyed.
 			 */
-			do {
-				sg->flags = 0;
-			} while (sg != sd->groups);
-
+			sg->flags = 0;
 			sd->child = NULL;
 		}
 	}
-- 
2.27.0

