Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7406D5C48
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 11:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbjDDJqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 05:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbjDDJqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 05:46:12 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC83E30DC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 02:45:50 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PrNCk3pgCzKntV;
        Tue,  4 Apr 2023 17:45:06 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 4 Apr 2023 17:45:41 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>
CC:     <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
        ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH] mm/madvise: Use vma_lookup() instead of find_vma()
Date:   Tue, 4 Apr 2023 17:45:15 +0800
Message-ID: <20230404094515.1883552-1-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ZhangPeng <zhangpeng362@huawei.com>

Using vma_lookup() verifies the address is contained in the found vma.
This results in easier to read the code.

Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 mm/madvise.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 340125d08c03..405a2c4a0a18 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -852,21 +852,9 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 		*prev = NULL; /* mmap_lock has been dropped, prev is stale */
 
 		mmap_read_lock(mm);
-		vma = find_vma(mm, start);
+		vma = vma_lookup(mm, start);
 		if (!vma)
 			return -ENOMEM;
-		if (start < vma->vm_start) {
-			/*
-			 * This "vma" under revalidation is the one
-			 * with the lowest vma->vm_start where start
-			 * is also < vma->vm_end. If start <
-			 * vma->vm_start it means an hole materialized
-			 * in the user address space within the
-			 * virtual range passed to MADV_DONTNEED
-			 * or MADV_FREE.
-			 */
-			return -ENOMEM;
-		}
 		/*
 		 * Potential end adjustment for hugetlb vma is OK as
 		 * the check below keeps end within vma.
-- 
2.25.1

