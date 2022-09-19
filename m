Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146BE5BC3D5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 09:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiISH6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 03:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiISH6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 03:58:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B813D1F2C0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 00:58:11 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MWH4Y5f0RzlVwP;
        Mon, 19 Sep 2022 15:54:05 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 15:58:10 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 19 Sep
 2022 15:58:09 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>
Subject: [PATCH 8/9] memory: replace IPC_CALLBACK_PRI with MM_BATCH_CALLBACK_PRI
Date:   Mon, 19 Sep 2022 16:31:51 +0800
Message-ID: <20220919083152.1824305-9-liushixin2@huawei.com>
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

Since there is nothing to do with ipc, it is strange to use IPC_CALLBACK_PRI
here. Replace IPC_CALLBACK_PRI with MM_BATCH_CALLBACK_PRI for easy reading.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 include/linux/memory.h | 4 ++--
 mm/mm_init.c           | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/memory.h b/include/linux/memory.h
index 98d2a2ebcc10..e5f71d3d9af8 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -112,8 +112,8 @@ struct mem_section;
  * Priorities for the hotplug memory callback routines (stored in decreasing
  * order in the callback chain)
  */
-#define SLAB_CALLBACK_PRI       1
-#define IPC_CALLBACK_PRI        10
+#define SLAB_CALLBACK_PRI	1
+#define MM_BATCH_CALLBACK_PRI	10
 
 #ifndef CONFIG_MEMORY_HOTPLUG
 static inline void memory_dev_init(void)
diff --git a/mm/mm_init.c b/mm/mm_init.c
index ec6989fcf762..30381cae9688 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -181,7 +181,7 @@ static int __meminit mm_compute_batch_notifier(struct notifier_block *self,
 static int __init mm_compute_batch_init(void)
 {
 	mm_compute_batch(sysctl_overcommit_memory);
-	hotplug_memory_notifier(&mm_compute_batch_notifier, IPC_CALLBACK_PRI);
+	hotplug_memory_notifier(&mm_compute_batch_notifier, MM_BATCH_CALLBACK_PRI);
 	return 0;
 }
 
-- 
2.25.1

