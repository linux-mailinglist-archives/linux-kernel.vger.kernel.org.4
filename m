Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEB65BA76B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 09:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiIPHZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 03:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiIPHXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 03:23:48 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E10A50E2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 00:23:47 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MTQSY1KpqzmVRN;
        Fri, 16 Sep 2022 15:19:57 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 16 Sep
 2022 15:23:43 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <osalvador@suse.de>, <anshuman.khandual@arm.com>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 16/16] mm/page_alloc: fix obsolete comment in deferred_pfn_valid()
Date:   Fri, 16 Sep 2022 15:22:57 +0800
Message-ID: <20220916072257.9639-17-linmiaohe@huawei.com>
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

There are no architectures that can have holes in the memory map within
a pageblock since commit 859a85ddf90e ("mm: remove pfn_valid_within()
and CONFIG_HOLES_IN_ZONE"). Update the corresponding comment.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 mm/page_alloc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3d2ad5c197d5..d7b20bf09c1c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1929,11 +1929,7 @@ static inline void __init pgdat_init_report_one_done(void)
 /*
  * Returns true if page needs to be initialized or freed to buddy allocator.
  *
- * First we check if pfn is valid on architectures where it is possible to have
- * holes within pageblock_nr_pages. On systems where it is not possible, this
- * function is optimized out.
- *
- * Then, we check if a current large page is valid by only checking the validity
+ * We check if a current large page is valid by only checking the validity
  * of the head pfn.
  */
 static inline bool __init deferred_pfn_valid(unsigned long pfn)
-- 
2.23.0

