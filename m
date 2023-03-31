Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581E86D1CBE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjCaJmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjCaJmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:42:02 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671994EE2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:41:52 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PnwKB5zpyzKpll;
        Fri, 31 Mar 2023 17:41:18 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 17:41:49 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <mike.kravetz@oracle.com>, <sidhartha.kumar@oracle.com>
CC:     <vishal.moola@gmail.com>, <muchun.song@linux.dev>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
        ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH v5 2/6] userfaultfd: use kmap_local_page() in copy_huge_page_from_user()
Date:   Fri, 31 Mar 2023 17:39:33 +0800
Message-ID: <20230331093937.945725-3-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331093937.945725-1-zhangpeng362@huawei.com>
References: <20230331093937.945725-1-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
index 387226d6094d..808f354bce65 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5880,16 +5880,14 @@ long copy_huge_page_from_user(struct page *dst_page,
 
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

