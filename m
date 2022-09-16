Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829005BA766
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 09:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiIPHYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 03:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiIPHXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 03:23:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BA6A50DF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 00:23:37 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MTQSM5lVJzmVSS;
        Fri, 16 Sep 2022 15:19:47 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 16 Sep
 2022 15:23:35 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <osalvador@suse.de>, <anshuman.khandual@arm.com>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 01/16] mm/page_alloc: ensure kswapd doesn't accidentally go to sleep
Date:   Fri, 16 Sep 2022 15:22:42 +0800
Message-ID: <20220916072257.9639-2-linmiaohe@huawei.com>
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

If ALLOC_KSWAPD is set, wake_all_kswapds() will be called to ensure
kswapd doesn't accidentally go to sleep. But when reserve_flags is
set, alloc_flags will be overwritten and ALLOC_KSWAPD is thus lost.
Preserve the ALLOC_KSWAPD flag in alloc_flags to ensure kswapd won't
go to sleep accidentally.

Fixes: 0a79cdad5eb2 ("mm: use alloc_flags to record if kswapd can wake")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 mm/page_alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ef3f51c9815d..35e18514215a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5148,7 +5148,8 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 
 	reserve_flags = __gfp_pfmemalloc_flags(gfp_mask);
 	if (reserve_flags)
-		alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, reserve_flags);
+		alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, reserve_flags) |
+					  (alloc_flags & ALLOC_KSWAPD);
 
 	/*
 	 * Reset the nodemask and zonelist iterators if memory policies can be
-- 
2.23.0

