Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54C16FAC76
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbjEHLYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235653AbjEHLYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:24:18 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE1E37031
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 04:24:18 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QFJjf2dNpzpV29;
        Mon,  8 May 2023 19:20:06 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 19:24:14 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 1/2] mm: memory_failure: move memory_failure_attr_group under MEMORY_FAILURE
Date:   Mon, 8 May 2023 19:41:27 +0800
Message-ID: <20230508114128.37081-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

The memory_failure_attr_group is only called if MEMORY_FAILURE
enabled, move it under this configuration.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/mm.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d533ef955dd0..cdb0377f97fa 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3687,6 +3687,10 @@ extern void shake_page(struct page *p);
 extern atomic_long_t num_poisoned_pages __read_mostly;
 extern int soft_offline_page(unsigned long pfn, int flags);
 #ifdef CONFIG_MEMORY_FAILURE
+/*
+ * Sysfs entries for memory failure handling statistics.
+ */
+extern const struct attribute_group memory_failure_attr_group;
 extern void memory_failure_queue(unsigned long pfn, int flags);
 extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 					bool *migratable_cleared);
@@ -3779,11 +3783,6 @@ enum mf_action_page_type {
 	MF_MSG_UNKNOWN,
 };
 
-/*
- * Sysfs entries for memory failure handling statistics.
- */
-extern const struct attribute_group memory_failure_attr_group;
-
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
 extern void clear_huge_page(struct page *page,
 			    unsigned long addr_hint,
-- 
2.35.3

