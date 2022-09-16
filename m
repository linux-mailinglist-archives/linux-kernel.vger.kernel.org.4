Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626905BA763
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 09:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiIPHYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 03:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiIPHXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 03:23:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6A9A50DF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 00:23:41 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MTQSC111QzlW04;
        Fri, 16 Sep 2022 15:19:39 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 16 Sep
 2022 15:23:39 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <osalvador@suse.de>, <anshuman.khandual@arm.com>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 08/16] mm/page_alloc: add missing is_migrate_isolate() check in set_page_guard()
Date:   Fri, 16 Sep 2022 15:22:49 +0800
Message-ID: <20220916072257.9639-9-linmiaohe@huawei.com>
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

In MIGRATE_ISOLATE case, zone freepage state shouldn't be modified as
caller will take care of it. Add missing is_migrate_isolate() here to
avoid possible unbalanced freepage state. This would happen if someone
isolates the block, and then we face an MCE failure/soft-offline on a
page within that block. __mod_zone_freepage_state() will be triggered
via below call trace which already had been triggered back when block
was isolated:

take_page_off_buddy
  break_down_buddy_pages
    set_page_guard

Fixes: 06be6ff3d2ec ("mm,hwpoison: rework soft offline for free pages")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 mm/page_alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cad235770948..8fcc905ef317 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -873,7 +873,8 @@ static inline bool set_page_guard(struct zone *zone, struct page *page,
 	INIT_LIST_HEAD(&page->buddy_list);
 	set_page_private(page, order);
 	/* Guard pages are not available for any usage */
-	__mod_zone_freepage_state(zone, -(1 << order), migratetype);
+	if (!is_migrate_isolate(migratetype))
+		__mod_zone_freepage_state(zone, -(1 << order), migratetype);
 
 	return true;
 }
-- 
2.23.0

