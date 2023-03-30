Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234F96D0711
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjC3Nll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjC3Nlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:41:36 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDC5B477
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:41:32 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PnPhD0nzCzKqDF;
        Thu, 30 Mar 2023 21:41:00 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 21:41:29 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <mike.kravetz@oracle.com>
CC:     <vishal.moola@gmail.com>, <muchun.song@linux.dev>,
        <sidhartha.kumar@oracle.com>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH v4 2/6] userfaultfd: use kmap_local_page() in copy_huge_page_from_user()
Date:   Thu, 30 Mar 2023 21:40:41 +0800
Message-ID: <20230330134045.375163-3-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230330134045.375163-1-zhangpeng362@huawei.com>
References: <20230330134045.375163-1-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

kmap() and kmap_atomic() are being deprecated in favor of
kmap_local_page() which is appropriate for any thread local context.[1]

Let's replace the kmap() and kmap_atomic() with kmap_local_page() in
copy_huge_page_from_user(). When allow_pagefault is false, disable page
faults to prevent potential deadlock.[2]

[1] https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com/
[2] https://lkml.kernel.org/r/20221025220136.2366143-1-ira.weiny@intel.com

Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 mm/memory.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index f77fccb5310c..c47b8991410a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5866,16 +5866,14 @@ long copy_huge_page_from_user(struct page *dst_page,
 
 	for (i = 0; i < pages_per_huge_page; i++) {
 		subpage = nth_page(dst_page, i);
-		if (allow_pagefault)
-			page_kaddr = kmap(subpage);
-		else
-			page_kaddr = kmap_atomic(subpage);
+		page_kaddr = kmap_local_page(subpage);
+		if (!allow_pagefault)
+			pagefault_disable();
 		rc = copy_from_user(page_kaddr,
 				usr_src + i * PAGE_SIZE, PAGE_SIZE);
-		if (allow_pagefault)
-			kunmap(subpage);
-		else
-			kunmap_atomic(page_kaddr);
+		if (!allow_pagefault)
+			pagefault_enable();
+		kunmap_local(page_kaddr);
 
 		ret_val -= (PAGE_SIZE - rc);
 		if (rc)
-- 
2.25.1

