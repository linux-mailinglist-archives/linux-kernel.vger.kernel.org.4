Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5AC5E607B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiIVLJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiIVLJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:09:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2A312768
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 04:09:39 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYCCW1Fj3zpTvy;
        Thu, 22 Sep 2022 19:06:47 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 19:09:36 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <akpm@linux-foundation.org>, <yuzhao@google.com>,
        <heftig@archlinux.org>, <suleiman@google.com>,
        <bgeffon@google.com>, <arnd@arndb.de>, <surenb@google.com>,
        <hughd@google.com>, <willy@infradead.org>, <peterx@redhat.com>,
        <cuigaosheng1@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm: Remove unused inline functions from include/linux/mm_inline.h
Date:   Thu, 22 Sep 2022 19:09:35 +0800
Message-ID: <20220922110935.1495099-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the following unused inline functions from mm_inline.h:
1. All uses of add_page_to_lru_list_tail() have
been removed since commit 7a3dbfe8a52b ("mm/swap: convert
lru_deactivate_file to a folio_batch"), and it can be replaced by
lruvec_add_folio_tail().

2. All uses of __clear_page_lru_flags() have
been removed since commit 188e8caee968 ("mm/swap: convert
__page_cache_release() to use a folio"), and it can be replaced
by __folio_clear_lru_flags().

They are useless, so remove them.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 include/linux/mm_inline.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 4949eda9a9a2..e8ed225d8f7c 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -76,11 +76,6 @@ static __always_inline void __folio_clear_lru_flags(struct folio *folio)
 	__folio_clear_unevictable(folio);
 }
 
-static __always_inline void __clear_page_lru_flags(struct page *page)
-{
-	__folio_clear_lru_flags(page_folio(page));
-}
-
 /**
  * folio_lru_list - Which LRU list should a folio be on?
  * @folio: The folio to test.
@@ -348,12 +343,6 @@ void lruvec_add_folio_tail(struct lruvec *lruvec, struct folio *folio)
 	list_add_tail(&folio->lru, &lruvec->lists[lru]);
 }
 
-static __always_inline void add_page_to_lru_list_tail(struct page *page,
-				struct lruvec *lruvec)
-{
-	lruvec_add_folio_tail(lruvec, page_folio(page));
-}
-
 static __always_inline
 void lruvec_del_folio(struct lruvec *lruvec, struct folio *folio)
 {
-- 
2.25.1

