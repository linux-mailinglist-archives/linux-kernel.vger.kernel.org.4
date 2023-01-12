Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE38B667217
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjALMZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjALMZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:25:32 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DFC116F
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 04:25:29 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Nt3d30sZ6zJrKC;
        Thu, 12 Jan 2023 20:24:07 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 12 Jan 2023 20:25:25 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <willy@infradead.org>,
        <vishal.moola@gmail.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next] mm: madvise: use vm_normal_folio() in madvise_free_pte_range()
Date:   Thu, 12 Jan 2023 20:40:28 +0800
Message-ID: <20230112124028.16964-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is already a vm_normal_folio(), use it to make
madvise_free_pte_range() only use a folio.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/madvise.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 4561aaa0e46c..7931d2649de1 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -614,7 +614,6 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	spinlock_t *ptl;
 	pte_t *orig_pte, *pte, ptent;
 	struct folio *folio;
-	struct page *page;
 	int nr_swap = 0;
 	unsigned long next;
 
@@ -655,10 +654,9 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 			continue;
 		}
 
-		page = vm_normal_page(vma, addr, ptent);
-		if (!page || is_zone_device_page(page))
+		folio = vm_normal_folio(vma, addr, ptent);
+		if (!folio || folio_is_zone_device(folio))
 			continue;
-		folio = page_folio(page);
 
 		/*
 		 * If pmd isn't transhuge but the folio is large and
-- 
2.35.3

