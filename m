Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B2274E685
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 07:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjGKFu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 01:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjGKFuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 01:50:08 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF441BC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 22:50:07 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R0VHv0DmQztR5C;
        Tue, 11 Jul 2023 13:47:07 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 11 Jul
 2023 13:50:04 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 8/8] mm: memory-failure: fix race window when trying to get hugetlb folio
Date:   Tue, 11 Jul 2023 13:50:16 +0800
Message-ID: <20230711055016.2286677-9-linmiaohe@huawei.com>
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

page_folio() is fetched before calling get_hwpoison_hugetlb_folio()
without hugetlb_lock being held. So hugetlb page could be demoted
before get_hwpoison_hugetlb_folio() holding hugetlb_lock but after
page_folio() is fetched. So get_hwpoison_hugetlb_folio() will hold
unexpected extra refcnt of hugetlb folio while leaving demoted page
un-refcnted.

Fixes: 25182f05ffed ("mm,hwpoison: fix race with hugetlb page allocation")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index af34fd4669d3..9ab97016877e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1383,8 +1383,15 @@ static int __get_hwpoison_page(struct page *page, unsigned long flags)
 	bool hugetlb = false;
 
 	ret = get_hwpoison_hugetlb_folio(folio, &hugetlb, false);
-	if (hugetlb)
-		return ret;
+	if (hugetlb) {
+		/* Make sure hugetlb demotion did not happen from under us. */
+		if (folio == page_folio(page))
+			return ret;
+		if (ret > 0) {
+			folio_put(folio);
+			folio = page_folio(page);
+		}
+	}
 
 	/*
 	 * This check prevents from calling folio_try_get() for any
@@ -1473,8 +1480,13 @@ static int __get_unpoison_page(struct page *page)
 	bool hugetlb = false;
 
 	ret = get_hwpoison_hugetlb_folio(folio, &hugetlb, true);
-	if (hugetlb)
-		return ret;
+	if (hugetlb) {
+		/* Make sure hugetlb demotion did not happen from under us. */
+		if (folio == page_folio(page))
+			return ret;
+		if (ret > 0)
+			folio_put(folio);
+	}
 
 	/*
 	 * PageHWPoisonTakenOff pages are not only marked as PG_hwpoison,
-- 
2.33.0

