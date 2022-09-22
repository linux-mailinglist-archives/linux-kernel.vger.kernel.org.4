Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0CE5E6408
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiIVNps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiIVNpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:45:22 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0BD33E1D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 06:45:21 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MYGgw6yTFzHqKS;
        Thu, 22 Sep 2022 21:43:08 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 21:45:19 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 21:45:19 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Christoph Lameter <cl@linux.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 3/8] mm/slub.c: use hotplug_memory_notifier() directly
Date:   Thu, 22 Sep 2022 22:18:59 +0800
Message-ID: <20220922141904.3245505-4-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922141904.3245505-1-liushixin2@huawei.com>
References: <20220922141904.3245505-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
 mm/slub.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 234bf0e44262..9a0853e01fd7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4698,11 +4698,6 @@ static int slab_memory_callback(struct notifier_block *self,
 	return ret;
 }
 
-static struct notifier_block slab_memory_callback_nb = {
-	.notifier_call = slab_memory_callback,
-	.priority = SLAB_CALLBACK_PRI,
-};
-
 /********************************************************************
  *			Basic setup of slabs
  *******************************************************************/
@@ -4768,7 +4763,7 @@ void __init kmem_cache_init(void)
 	create_boot_cache(kmem_cache_node, "kmem_cache_node",
 		sizeof(struct kmem_cache_node), SLAB_HWCACHE_ALIGN, 0, 0);
 
-	register_hotmemory_notifier(&slab_memory_callback_nb);
+	hotplug_memory_notifier(slab_memory_callback, SLAB_CALLBACK_PRI);
 
 	/* Able to allocate the per node structures */
 	slab_state = PARTIAL;
-- 
2.25.1

