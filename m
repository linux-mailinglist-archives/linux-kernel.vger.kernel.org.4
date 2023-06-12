Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BBC72C8D0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238283AbjFLOko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbjFLOkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:40:35 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E0493
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 07:40:33 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qfv1W5KKgzTl09;
        Mon, 12 Jun 2023 22:18:39 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 22:19:07 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>, <jgowans@amazon.com>, <yuzhao@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 2/2] mm: kill [add|del]_page_to_lru_list()
Date:   Mon, 12 Jun 2023 22:34:14 +0800
Message-ID: <20230612143414.186389-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230612143414.186389-1-wangkefeng.wang@huawei.com>
References: <20230612143414.186389-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now no one call [add|del]_page_to_lru_list(), let's drop unused
page interfaces.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/mm_inline.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 0e1d239a882c..e9cdeb290841 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -323,12 +323,6 @@ void lruvec_add_folio(struct lruvec *lruvec, struct folio *folio)
 		list_add(&folio->lru, &lruvec->lists[lru]);
 }
 
-static __always_inline void add_page_to_lru_list(struct page *page,
-				struct lruvec *lruvec)
-{
-	lruvec_add_folio(lruvec, page_folio(page));
-}
-
 static __always_inline
 void lruvec_add_folio_tail(struct lruvec *lruvec, struct folio *folio)
 {
@@ -357,12 +351,6 @@ void lruvec_del_folio(struct lruvec *lruvec, struct folio *folio)
 			-folio_nr_pages(folio));
 }
 
-static __always_inline void del_page_from_lru_list(struct page *page,
-				struct lruvec *lruvec)
-{
-	lruvec_del_folio(lruvec, page_folio(page));
-}
-
 #ifdef CONFIG_ANON_VMA_NAME
 /*
  * mmap_lock should be read-locked when calling anon_vma_name(). Caller should
-- 
2.35.3

