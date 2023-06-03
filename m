Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAB6720E82
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 09:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjFCHhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 03:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjFCHg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 03:36:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BB51A6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 00:36:55 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QYBWn2X8mzTkkH;
        Sat,  3 Jun 2023 15:36:37 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 3 Jun
 2023 15:36:51 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] sched/topology: mark set_sched_topology() __init
Date:   Sat, 3 Jun 2023 15:36:45 +0800
Message-ID: <20230603073645.1173332-1-linmiaohe@huawei.com>
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

All callers of set_sched_topology() are within __init section. Mark
it __init too.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/sched/topology.h | 2 +-
 kernel/sched/topology.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 816df6cc444e..67b573d5bf28 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -203,7 +203,7 @@ struct sched_domain_topology_level {
 #endif
 };
 
-extern void set_sched_topology(struct sched_domain_topology_level *tl);
+extern void __init set_sched_topology(struct sched_domain_topology_level *tl);
 
 #ifdef CONFIG_SCHED_DEBUG
 # define SD_INIT_NAME(type)		.name = #type
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index ca4472281c28..cb92dc5f5646 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1681,7 +1681,7 @@ static struct sched_domain_topology_level *sched_domain_topology_saved;
 #define for_each_sd_topology(tl)			\
 	for (tl = sched_domain_topology; tl->mask; tl++)
 
-void set_sched_topology(struct sched_domain_topology_level *tl)
+void __init set_sched_topology(struct sched_domain_topology_level *tl)
 {
 	if (WARN_ON_ONCE(sched_smp_initialized))
 		return;
-- 
2.27.0

