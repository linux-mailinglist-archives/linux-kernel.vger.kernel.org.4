Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E550C5B33D9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiIIJ1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiIIJ0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:26:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A2ED9EA6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:25:28 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MP9TM129gzZcm2;
        Fri,  9 Sep 2022 17:20:55 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 9 Sep
 2022 17:25:26 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <david@redhat.com>, <osalvador@suse.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 02/16] mm/page_alloc: make zone_pcp_update() static
Date:   Fri, 9 Sep 2022 17:24:37 +0800
Message-ID: <20220909092451.24883-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220909092451.24883-1-linmiaohe@huawei.com>
References: <20220909092451.24883-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Since commit b92ca18e8ca5 ("mm/page_alloc: disassociate the pcp->high
from pcp->batch"), zone_pcp_update() is only used in mm/page_alloc.c.
Move zone_pcp_update() up to avoid forward declaration and then make
it static. No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/internal.h   |  1 -
 mm/page_alloc.c | 22 +++++++++++-----------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 4e5f3d0d5538..2424fcde6538 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -367,7 +367,6 @@ extern int user_min_free_kbytes;
 extern void free_unref_page(struct page *page, unsigned int order);
 extern void free_unref_page_list(struct list_head *list);
 
-extern void zone_pcp_update(struct zone *zone, int cpu_online);
 extern void zone_pcp_reset(struct zone *zone);
 extern void zone_pcp_disable(struct zone *zone);
 extern void zone_pcp_enable(struct zone *zone);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4b97a03fa2dd..2deac2fe3372 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7238,6 +7238,17 @@ void __meminit setup_zone_pageset(struct zone *zone)
 	zone_set_pageset_high_and_batch(zone, 0);
 }
 
+/*
+ * The zone indicated has a new number of managed_pages; batch sizes and percpu
+ * page high values need to be recalculated.
+ */
+static void zone_pcp_update(struct zone *zone, int cpu_online)
+{
+	mutex_lock(&pcp_batch_high_lock);
+	zone_set_pageset_high_and_batch(zone, cpu_online);
+	mutex_unlock(&pcp_batch_high_lock);
+}
+
 /*
  * Allocate per cpu pagesets and initialize them.
  * Before this call only boot pagesets were available.
@@ -9469,17 +9480,6 @@ void free_contig_range(unsigned long pfn, unsigned long nr_pages)
 }
 EXPORT_SYMBOL(free_contig_range);
 
-/*
- * The zone indicated has a new number of managed_pages; batch sizes and percpu
- * page high values need to be recalculated.
- */
-void zone_pcp_update(struct zone *zone, int cpu_online)
-{
-	mutex_lock(&pcp_batch_high_lock);
-	zone_set_pageset_high_and_batch(zone, cpu_online);
-	mutex_unlock(&pcp_batch_high_lock);
-}
-
 /*
  * Effectively disable pcplists for the zone by setting the high limit to 0
  * and draining all cpus. A concurrent page freeing on another CPU that's about
-- 
2.23.0

