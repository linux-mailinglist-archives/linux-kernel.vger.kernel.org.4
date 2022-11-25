Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5E06388DB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiKYLfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiKYLf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:35:29 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325A01CFC3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:35:23 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NJXkM72MHzbngP;
        Fri, 25 Nov 2022 19:31:23 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 25 Nov 2022 19:35:21 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 25 Nov 2022 19:35:20 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] pmem: use TestClearPageHWPoison() directly
Date:   Fri, 25 Nov 2022 19:53:08 +0800
Message-ID: <20221125115308.104059-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TESTSCFLAG_FALSE(HWPoison, hwpoison) for HWPoison in
page flags, then drop privite test_and_clear_pmem_poison().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/nvdimm/pmem.c      |  2 +-
 drivers/nvdimm/pmem.h      | 12 ------------
 include/linux/page-flags.h |  1 +
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 3c63dc2cdc81..1fa6b3980221 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -80,7 +80,7 @@ static void pmem_mkpage_present(struct pmem_device *pmem, phys_addr_t offset,
 		 * here since we're in the driver I/O path and
 		 * outstanding I/O requests pin the dev_pagemap.
 		 */
-		if (test_and_clear_pmem_poison(page))
+		if (TestClearPageHWPoison(page))
 			clear_mce_nospec(pfn);
 	}
 }
diff --git a/drivers/nvdimm/pmem.h b/drivers/nvdimm/pmem.h
index 392b0b38acb9..6f5c2f35b93a 100644
--- a/drivers/nvdimm/pmem.h
+++ b/drivers/nvdimm/pmem.h
@@ -1,7 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __NVDIMM_PMEM_H__
 #define __NVDIMM_PMEM_H__
-#include <linux/page-flags.h>
 #include <linux/badblocks.h>
 #include <linux/memremap.h>
 #include <linux/types.h>
@@ -33,15 +32,4 @@ long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
 		pfn_t *pfn);
 
-#ifdef CONFIG_MEMORY_FAILURE
-static inline bool test_and_clear_pmem_poison(struct page *page)
-{
-	return TestClearPageHWPoison(page);
-}
-#else
-static inline bool test_and_clear_pmem_poison(struct page *page)
-{
-	return false;
-}
-#endif
 #endif /* __NVDIMM_PMEM_H__ */
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index e42c55a7e012..5e877b6c7b90 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -582,6 +582,7 @@ extern bool take_page_off_buddy(struct page *page);
 extern bool put_page_back_buddy(struct page *page);
 #else
 PAGEFLAG_FALSE(HWPoison, hwpoison)
+TESTSCFLAG_FALSE(HWPoison, hwpoison)
 #define __PG_HWPOISON 0
 #endif
 
-- 
2.35.3

