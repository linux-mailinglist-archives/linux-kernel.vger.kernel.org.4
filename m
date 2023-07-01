Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF75744661
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 05:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjGADgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 23:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjGADer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 23:34:47 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBEE297C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 20:29:02 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QtHfh1HWqzLn4k;
        Sat,  1 Jul 2023 11:26:52 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 1 Jul 2023 11:28:59 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>, <sidhartha.kumar@oracle.com>
CC:     <akpm@linux-foundation.org>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH v2 1/2] mm: use a folio in fault_dirty_shared_page()
Date:   Sat, 1 Jul 2023 11:28:52 +0800
Message-ID: <20230701032853.258697-2-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230701032853.258697-1-zhangpeng362@huawei.com>
References: <20230701032853.258697-1-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ZhangPeng <zhangpeng362@huawei.com>

We can replace four implicit calls to compound_head() with one by using
folio.

Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/memory.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 765e5d8ed1f4..9a2f4dab872f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2968,20 +2968,20 @@ static vm_fault_t fault_dirty_shared_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct address_space *mapping;
-	struct page *page = vmf->page;
+	struct folio *folio = page_folio(vmf->page);
 	bool dirtied;
 	bool page_mkwrite = vma->vm_ops && vma->vm_ops->page_mkwrite;
 
-	dirtied = set_page_dirty(page);
-	VM_BUG_ON_PAGE(PageAnon(page), page);
+	dirtied = folio_mark_dirty(folio);
+	VM_BUG_ON_FOLIO(folio_test_anon(folio), folio);
 	/*
-	 * Take a local copy of the address_space - page.mapping may be zeroed
-	 * by truncate after unlock_page().   The address_space itself remains
-	 * pinned by vma->vm_file's reference.  We rely on unlock_page()'s
+	 * Take a local copy of the address_space - folio.mapping may be zeroed
+	 * by truncate after folio_unlock().   The address_space itself remains
+	 * pinned by vma->vm_file's reference.  We rely on folio_unlock()'s
 	 * release semantics to prevent the compiler from undoing this copying.
 	 */
-	mapping = page_rmapping(page);
-	unlock_page(page);
+	mapping = folio_raw_mapping(folio);
+	folio_unlock(folio);
 
 	if (!page_mkwrite)
 		file_update_time(vma->vm_file);
-- 
2.25.1

