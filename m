Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96065BC3C9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 09:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiISH6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 03:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiISH6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 03:58:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790521EEDC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 00:58:09 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MWH3q4TKczMn3p;
        Mon, 19 Sep 2022 15:53:27 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 15:58:07 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 19 Sep
 2022 15:58:07 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>
Subject: [PATCH 1/9] cgroup/cpuset: use hotplug_memory_notifier() directly
Date:   Mon, 19 Sep 2022 16:31:44 +0800
Message-ID: <20220919083152.1824305-2-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220919083152.1824305-1-liushixin2@huawei.com>
References: <20220919083152.1824305-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since patch 316346243be6 has already updated the minimum gcc version to 5.1.
The previous problem mentioned in patch f02c69680088 is not existed. So we
can now revert to use hotplug_memory_notifier() directly rather than
register_hotmemory_notifier().

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 kernel/cgroup/cpuset.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index b474289c15b8..0c6db6a4f427 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3630,11 +3630,6 @@ static int cpuset_track_online_nodes(struct notifier_block *self,
 	return NOTIFY_OK;
 }
 
-static struct notifier_block cpuset_track_online_nodes_nb = {
-	.notifier_call = cpuset_track_online_nodes,
-	.priority = 10,		/* ??! */
-};
-
 /**
  * cpuset_init_smp - initialize cpus_allowed
  *
@@ -3652,7 +3647,7 @@ void __init cpuset_init_smp(void)
 	cpumask_copy(top_cpuset.effective_cpus, cpu_active_mask);
 	top_cpuset.effective_mems = node_states[N_MEMORY];
 
-	register_hotmemory_notifier(&cpuset_track_online_nodes_nb);
+	hotplug_memory_notifier(cpuset_track_online_nodes, 10);
 
 	cpuset_migrate_mm_wq = alloc_ordered_workqueue("cpuset_migrate_mm", 0);
 	BUG_ON(!cpuset_migrate_mm_wq);
-- 
2.25.1

