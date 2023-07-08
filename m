Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D6F74BCED
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 10:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjGHI5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 04:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjGHI5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 04:57:35 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EBE1FEE
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 01:57:33 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qykdf41dVzTkgk;
        Sat,  8 Jul 2023 16:56:22 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 8 Jul
 2023 16:57:29 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 2/8] mm: memory-failure: ensure moving HWPoison flag to the raw error pages
Date:   Sat, 8 Jul 2023 16:57:38 +0800
Message-ID: <20230708085744.3599311-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230708085744.3599311-1-linmiaohe@huawei.com>
References: <20230708085744.3599311-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If hugetlb_vmemmap_optimized is enabled, folio_clear_hugetlb_hwpoison()
called from try_memory_failure_hugetlb() won't transfer HWPoison flag to
subpages while folio's HWPoison flag is cleared. So when trying to free
this hugetlb page into buddy, folio_clear_hugetlb_hwpoison() is not called
to move HWPoison flag from head page to the raw error pages even if now
hugetlb_vmemmap_optimized is cleared. This will results in HWPoisoned page
being used again and raw_hwp_page leak.

Fixes: ac5fcde0a96a ("mm, hwpoison: make unpoison aware of raw error info in hwpoisoned hugepage")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index d21ee27ad412..c155122e3c66 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1913,6 +1913,8 @@ void folio_clear_hugetlb_hwpoison(struct folio *folio)
 {
 	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
 		return;
+	if (folio_test_hugetlb_vmemmap_optimized(folio))
+		return;
 	folio_clear_hwpoison(folio);
 	folio_free_raw_hwp(folio, true);
 }
-- 
2.33.0

