Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB91733F01
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 09:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbjFQHKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 03:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjFQHKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 03:10:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50417211D
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 00:10:31 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QjnD73DZ4ztQVr;
        Sat, 17 Jun 2023 15:07:51 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 17 Jun
 2023 15:10:23 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <rppt@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>
CC:     <peterz@infradead.org>, <dvhart@infradead.org>,
        <dave@stgolabs.net>, <andrealmeid@igalia.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/mm_init.c: remove obsolete macro HASH_SMALL
Date:   Sat, 17 Jun 2023 15:09:55 +0800
Message-ID: <20230617070955.1751393-1-linmiaohe@huawei.com>
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

HASH_SMALL only works when parameter numentries is 0. But the sole caller
futex_init() never calls alloc_large_system_hash() with numentries set to
0. So HASH_SMALL is obsolete and remove it.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/memblock.h |  2 --
 kernel/futex/core.c      |  3 +--
 mm/mm_init.c             | 10 +---------
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index f71ff9f0ec81..346d80809517 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -581,8 +581,6 @@ extern void *alloc_large_system_hash(const char *tablename,
 				     unsigned long high_limit);
 
 #define HASH_EARLY	0x00000001	/* Allocating during early boot? */
-#define HASH_SMALL	0x00000002	/* sub-page allocation allowed, min
-					 * shift passed via *_hash_shift */
 #define HASH_ZERO	0x00000004	/* Zero allocated hash table */
 
 /* Only NUMA needs hash distribution. 64bit NUMA architectures have
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 514e4582b863..f10587d1d481 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1132,8 +1132,7 @@ static int __init futex_init(void)
 #endif
 
 	futex_queues = alloc_large_system_hash("futex", sizeof(*futex_queues),
-					       futex_hashsize, 0,
-					       futex_hashsize < 256 ? HASH_SMALL : 0,
+					       futex_hashsize, 0, 0,
 					       &futex_shift, NULL,
 					       futex_hashsize, futex_hashsize);
 	futex_hashsize = 1UL << futex_shift;
diff --git a/mm/mm_init.c b/mm/mm_init.c
index d393631599a7..fab3c4649d5b 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2492,15 +2492,7 @@ void *__init alloc_large_system_hash(const char *tablename,
 		else
 			numentries <<= (PAGE_SHIFT - scale);
 
-		/* Make sure we've got at least a 0-order allocation.. */
-		if (unlikely(flags & HASH_SMALL)) {
-			/* Makes no sense without HASH_EARLY */
-			WARN_ON(!(flags & HASH_EARLY));
-			if (!(numentries >> *_hash_shift)) {
-				numentries = 1UL << *_hash_shift;
-				BUG_ON(!numentries);
-			}
-		} else if (unlikely((numentries * bucketsize) < PAGE_SIZE))
+		if (unlikely((numentries * bucketsize) < PAGE_SIZE))
 			numentries = PAGE_SIZE / bucketsize;
 	}
 	numentries = roundup_pow_of_two(numentries);
-- 
2.27.0

