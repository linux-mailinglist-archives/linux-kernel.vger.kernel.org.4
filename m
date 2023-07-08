Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1C374BCE8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 10:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjGHI5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 04:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjGHI5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 04:57:35 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88F22105
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 01:57:33 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QykfQ5qvgz1FDgw;
        Sat,  8 Jul 2023 16:57:02 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 8 Jul
 2023 16:57:31 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 8/8] mm: memory-failure: fix race window when trying to get hugetlb folio
Date:   Sat, 8 Jul 2023 16:57:44 +0800
Message-ID: <20230708085744.3599311-9-linmiaohe@huawei.com>
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

page_folio() is fetched before calling get_hwpoison_hugetlb_folio()
without hugetlb_lock being held. So hugetlb page could be demoted
before get_hwpoison_hugetlb_folio() holding hugetlb_lock but after
page_folio() is fetched. So get_hwpoison_hugetlb_folio() will hold
unexpected extra refcnt of hugetlb folio while leaving demoted page
un-refcnted.

Fixes: 25182f05ffed ("mm,hwpoison: fix race with hugetlb page allocation")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 76d88d27cdbe..066bf57f2d22 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1388,8 +1388,14 @@ static int __get_hwpoison_page(struct page *page, unsigned long flags)
 	bool hugetlb = false;
 
 	ret = get_hwpoison_hugetlb_folio(folio, &hugetlb, false);
-	if (hugetlb)
-		return ret;
+	if (hugetlb) {
+		if (folio == page_folio(page))
+			return ret;
+		if (ret > 0) {
+			folio_put(folio);
+			folio = page_folio(page);
+		}
+	}
 
 	/*
 	 * This check prevents from calling folio_try_get() for any
@@ -1478,8 +1484,12 @@ static int __get_unpoison_page(struct page *page)
 	bool hugetlb = false;
 
 	ret = get_hwpoison_hugetlb_folio(folio, &hugetlb, true);
-	if (hugetlb)
-		return ret;
+	if (hugetlb) {
+		if (folio == page_folio(page))
+			return ret;
+		if (ret > 0)
+			folio_put(folio);
+	}
 
 	/*
 	 * PageHWPoisonTakenOff pages are not only marked as PG_hwpoison,
-- 
2.33.0

