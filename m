Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0295F5BA76C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 09:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiIPHYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 03:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiIPHXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 03:23:44 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637BEA50DD
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 00:23:43 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MTQVT4H5LzBsQh;
        Fri, 16 Sep 2022 15:21:37 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 16 Sep
 2022 15:23:41 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <osalvador@suse.de>, <anshuman.khandual@arm.com>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 12/16] mm/page_alloc: use helper macro SZ_1{K,M}
Date:   Fri, 16 Sep 2022 15:22:53 +0800
Message-ID: <20220916072257.9639-13-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220916072257.9639-1-linmiaohe@huawei.com>
References: <20220916072257.9639-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use helper macro SZ_1K and SZ_1M to do the size conversion. Minor
readability improvement.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/page_alloc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6bdc98c7019f..67ec8a2e1db2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7048,7 +7048,7 @@ static int zone_batchsize(struct zone *zone)
 	 * size is striking a balance between allocation latency
 	 * and zone lock contention.
 	 */
-	batch = min(zone_managed_pages(zone) >> 10, (1024 * 1024) / PAGE_SIZE);
+	batch = min(zone_managed_pages(zone) >> 10, SZ_1M / PAGE_SIZE);
 	batch /= 4;		/* We effectively *= 4 below */
 	if (batch < 1)
 		batch = 1;
@@ -8523,8 +8523,8 @@ void __init mem_init_print_info(void)
 #endif
 		")\n",
 		K(nr_free_pages()), K(physpages),
-		codesize >> 10, datasize >> 10, rosize >> 10,
-		(init_data_size + init_code_size) >> 10, bss_size >> 10,
+		codesize / SZ_1K, datasize / SZ_1K, rosize / SZ_1K,
+		(init_data_size + init_code_size) / SZ_1K, bss_size / SZ_1K,
 		K(physpages - totalram_pages() - totalcma_pages),
 		K(totalcma_pages)
 #ifdef	CONFIG_HIGHMEM
@@ -9049,8 +9049,8 @@ void *__init alloc_large_system_hash(const char *tablename,
 		numentries -= arch_reserved_kernel_pages();
 
 		/* It isn't necessary when PAGE_SIZE >= 1MB */
-		if (PAGE_SHIFT < 20)
-			numentries = round_up(numentries, (1<<20)/PAGE_SIZE);
+		if (PAGE_SIZE < SZ_1M)
+			numentries = round_up(numentries, SZ_1M / PAGE_SIZE);
 
 #if __BITS_PER_LONG > 32
 		if (!high_limit) {
-- 
2.23.0

