Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C1A5E7244
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 05:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbiIWDAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 23:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiIWDAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 23:00:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CFC6F559
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 20:00:14 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYcGq40mLzlXW9;
        Fri, 23 Sep 2022 10:56:03 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 11:00:12 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 23 Sep
 2022 11:00:12 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Christoph Lameter <cl@linux.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v4 7/8] memory: remove unused register_hotmemory_notifier()
Date:   Fri, 23 Sep 2022 11:33:46 +0800
Message-ID: <20220923033347.3935160-8-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220923033347.3935160-1-liushixin2@huawei.com>
References: <20220923033347.3935160-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused register_hotmemory_notifier().

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 include/linux/memory.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/memory.h b/include/linux/memory.h
index aa619464a1df..98d2a2ebcc10 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -19,7 +19,6 @@
 #include <linux/node.h>
 #include <linux/compiler.h>
 #include <linux/mutex.h>
-#include <linux/notifier.h>
 
 #define MIN_MEMORY_BLOCK_SIZE     (1UL << SECTION_SIZE_BITS)
 
@@ -136,9 +135,6 @@ static inline int hotplug_memory_notifier(notifier_fn_t fn, int pri)
 {
 	return 0;
 }
-/* These aren't inline functions due to a GCC bug. */
-#define register_hotmemory_notifier(nb)    ({ (void)(nb); 0; })
-#define unregister_hotmemory_notifier(nb)  ({ (void)(nb); })
 #else /* CONFIG_MEMORY_HOTPLUG */
 extern int register_memory_notifier(struct notifier_block *nb);
 extern void unregister_memory_notifier(struct notifier_block *nb);
@@ -166,8 +162,6 @@ int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
 		{ .notifier_call = fn, .priority = pri };\
 	register_memory_notifier(&fn##_mem_nb);			\
 })
-#define register_hotmemory_notifier(nb)		register_memory_notifier(nb)
-#define unregister_hotmemory_notifier(nb) 	unregister_memory_notifier(nb)
 
 #ifdef CONFIG_NUMA
 void memory_block_add_nid(struct memory_block *mem, int nid,
-- 
2.25.1

