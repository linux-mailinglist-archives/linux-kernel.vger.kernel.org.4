Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9B97495BA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 08:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbjGFGiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 02:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbjGFGix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 02:38:53 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2219019B;
        Wed,  5 Jul 2023 23:38:50 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QxRdF3rm2zPjxF;
        Thu,  6 Jul 2023 14:36:33 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 6 Jul
 2023 14:38:46 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>
CC:     <ying.huang@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-cxl@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] memory tier: rename destroy_memory_type() to put_memory_type()
Date:   Thu, 6 Jul 2023 14:39:05 +0800
Message-ID: <20230706063905.543800-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.185]
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

It appears that destroy_memory_type() isn't a very good name because
we usually will not free the memory_type here. So rename it to a more
appropriate name i.e. put_memory_type().

Suggested-by: Huang, Ying <ying.huang@intel.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 drivers/dax/kmem.c           | 4 ++--
 include/linux/memory-tiers.h | 4 ++--
 mm/memory-tiers.c            | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 898ca9505754..c57acb73e3db 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -264,7 +264,7 @@ static int __init dax_kmem_init(void)
 	return rc;
 
 error_dax_driver:
-	destroy_memory_type(dax_slowmem_type);
+	put_memory_type(dax_slowmem_type);
 err_dax_slowmem_type:
 	kfree_const(kmem_name);
 	return rc;
@@ -275,7 +275,7 @@ static void __exit dax_kmem_exit(void)
 	dax_driver_unregister(&device_dax_kmem_driver);
 	if (!any_hotremove_failed)
 		kfree_const(kmem_name);
-	destroy_memory_type(dax_slowmem_type);
+	put_memory_type(dax_slowmem_type);
 }
 
 MODULE_AUTHOR("Intel Corporation");
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index fc9647b1b4f9..437441cdf78f 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -33,7 +33,7 @@ struct memory_dev_type {
 #ifdef CONFIG_NUMA
 extern bool numa_demotion_enabled;
 struct memory_dev_type *alloc_memory_type(int adistance);
-void destroy_memory_type(struct memory_dev_type *memtype);
+void put_memory_type(struct memory_dev_type *memtype);
 void init_node_memory_type(int node, struct memory_dev_type *default_type);
 void clear_node_memory_type(int node, struct memory_dev_type *memtype);
 #ifdef CONFIG_MIGRATION
@@ -68,7 +68,7 @@ static inline struct memory_dev_type *alloc_memory_type(int adistance)
 	return NULL;
 }
 
-static inline void destroy_memory_type(struct memory_dev_type *memtype)
+static inline void put_memory_type(struct memory_dev_type *memtype)
 {
 
 }
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 1719fa3bcf02..c49ab03f49b1 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -560,11 +560,11 @@ struct memory_dev_type *alloc_memory_type(int adistance)
 }
 EXPORT_SYMBOL_GPL(alloc_memory_type);
 
-void destroy_memory_type(struct memory_dev_type *memtype)
+void put_memory_type(struct memory_dev_type *memtype)
 {
 	kref_put(&memtype->kref, release_memtype);
 }
-EXPORT_SYMBOL_GPL(destroy_memory_type);
+EXPORT_SYMBOL_GPL(put_memory_type);
 
 void init_node_memory_type(int node, struct memory_dev_type *memtype)
 {
@@ -586,7 +586,7 @@ void clear_node_memory_type(int node, struct memory_dev_type *memtype)
 	 */
 	if (!node_memory_types[node].map_count) {
 		node_memory_types[node].memtype = NULL;
-		destroy_memory_type(memtype);
+		put_memory_type(memtype);
 	}
 	mutex_unlock(&memory_tier_lock);
 }
-- 
2.33.0

