Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B14733DDC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 05:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjFQDq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 23:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFQDq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 23:46:56 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C00C1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 20:46:53 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Qjhm96QBsz18MCB;
        Sat, 17 Jun 2023 11:46:49 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 17 Jun
 2023 11:46:51 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm: page_alloc: make compound_page_dtors static
Date:   Sat, 17 Jun 2023 11:46:22 +0800
Message-ID: <20230617034622.1235913-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

It's only used inside page_alloc.c now. So make it static and remove the
declaration in mm.h.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/mm.h | 1 -
 mm/page_alloc.c    | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fdd966b11f79..441ab55e94c5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1220,7 +1220,6 @@ enum compound_dtor_id {
 #endif
 	NR_COMPOUND_DTORS,
 };
-extern compound_page_dtor * const compound_page_dtors[NR_COMPOUND_DTORS];
 
 static inline void folio_set_compound_dtor(struct folio *folio,
 		enum compound_dtor_id compound_dtor)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9eb42182eb90..3ab51fb9191c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -284,7 +284,7 @@ const char * const migratetype_names[MIGRATE_TYPES] = {
 #endif
 };
 
-compound_page_dtor * const compound_page_dtors[NR_COMPOUND_DTORS] = {
+static compound_page_dtor * const compound_page_dtors[NR_COMPOUND_DTORS] = {
 	[NULL_COMPOUND_DTOR] = NULL,
 	[COMPOUND_PAGE_DTOR] = free_compound_page,
 #ifdef CONFIG_HUGETLB_PAGE
-- 
2.27.0

