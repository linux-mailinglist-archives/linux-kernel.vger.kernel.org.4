Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFC574E680
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 07:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjGKFuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 01:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjGKFuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 01:50:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1D11A7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 22:50:05 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R0VHV6bLdzMqSB;
        Tue, 11 Jul 2023 13:46:46 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 11 Jul
 2023 13:50:02 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 4/8] mm: memory-failure: use local variable huge to check hugetlb page
Date:   Tue, 11 Jul 2023 13:50:12 +0800
Message-ID: <20230711055016.2286677-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230711055016.2286677-1-linmiaohe@huawei.com>
References: <20230711055016.2286677-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use local variable huge to check whether page is hugetlb page to avoid
calling PageHuge() multiple times to save cpu cycles. PageHuge() will
be stable while extra page refcnt is held.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index c80b7d9505d8..239e0711f832 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2628,7 +2628,7 @@ static int soft_offline_in_use_page(struct page *page)
 	}
 
 	lock_page(page);
-	if (!PageHuge(page))
+	if (!huge)
 		wait_on_page_writeback(page);
 	if (PageHWPoison(page)) {
 		unlock_page(page);
@@ -2637,7 +2637,7 @@ static int soft_offline_in_use_page(struct page *page)
 		return 0;
 	}
 
-	if (!PageHuge(page) && PageLRU(page) && !PageSwapCache(page))
+	if (!huge && PageLRU(page) && !PageSwapCache(page))
 		/*
 		 * Try to invalidate first. This should work for
 		 * non dirty unmapped page cache pages.
-- 
2.33.0

