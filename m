Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35B95EBFCD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiI0KeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiI0KeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:34:09 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5783C8D9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 03:34:07 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4McGBs39yRzHqMZ;
        Tue, 27 Sep 2022 18:31:49 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 18:34:05 +0800
Received: from ubuntu1804.huawei.com (10.67.175.30) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 18:34:04 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <naoya.horiguchi@nec.com>
CC:     <linmiaohe@huawei.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <tanghui20@huawei.com>
Subject: [PATCH] mm/hwpoison: fix build error without CONFIG_MEMORY_FAILURE
Date:   Tue, 27 Sep 2022 18:29:46 +0800
Message-ID: <20220927102946.98622-1-tanghui20@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.30]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building without CONFIG_MEMORY_FAILURE will fail:

mm/memory-failure.o: In function `action_result':
memory-failure.c: undefined reference to `memblk_nr_poison_inc'
mm/memory-failure.o: In function `page_handle_poison':
memory-failure.c: undefined reference to `memblk_nr_poison_inc'
mm/memory-failure.o: In function `__get_huge_page_for_hwpoison':
memory-failure.c: undefined reference to `memblk_nr_poison_inc'
mm/memory-failure.o: In function `unpoison_memory':
memory-failure.c: undefined reference to `memblk_nr_poison_sub'
mm/memory-failure.o: In function `num_poisoned_pages_inc':
memory-failure.c: undefined reference to `memblk_nr_poison_inc'

Add CONFIG_MEMORY_FAILURE wrapper for invoking memblk_nr_poison_{inc|sub}.

Fixes: 69b496f03bb4 ("mm/hwpoison: introduce per-memory_block hwpoison counter")
Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 mm/memory-failure.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 03479895086d..5bb9d2d20234 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -77,14 +77,18 @@ static bool hw_memory_failure __read_mostly = false;
 void num_poisoned_pages_inc(unsigned long pfn)
 {
 	atomic_long_inc(&num_poisoned_pages);
+#ifdef CONFIG_MEMORY_FAILURE
 	memblk_nr_poison_inc(pfn);
+#endif
 }
 
 static inline void num_poisoned_pages_sub(unsigned long pfn, long i)
 {
 	atomic_long_sub(i, &num_poisoned_pages);
+#ifdef CONFIG_MEMORY_FAILURE
 	if (pfn != -1UL)
 		memblk_nr_poison_sub(pfn, i);
+#endif
 }
 
 /*
-- 
2.17.1

