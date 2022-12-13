Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC84C64B208
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbiLMJOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbiLMJM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:12:58 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A53D1006C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:11:20 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NWXlL3417z15NBs;
        Tue, 13 Dec 2022 17:10:22 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 13 Dec 2022 17:11:18 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        SeongJae Park <sj@kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <damon@lists.linux.dev>, <vishal.moola@gmail.com>,
        <willy@infradead.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 1/8] mm: memory_hotplug: add pfn_to_online_folio()
Date:   Tue, 13 Dec 2022 17:27:28 +0800
Message-ID: <20221213092735.187924-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221213092735.187924-1-wangkefeng.wang@huawei.com>
References: <20221213092735.187924-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a wrapper function pfn_to_online_folio(), which calls
pfn_to_online_page() and returns the folio of the page found,
or null if no page.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/memory_hotplug.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 9fcbf5706595..e841e4fb52a7 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -265,6 +265,13 @@ static inline void pgdat_kswapd_unlock(pg_data_t *pgdat) {}
 static inline void pgdat_kswapd_lock_init(pg_data_t *pgdat) {}
 #endif /* ! CONFIG_MEMORY_HOTPLUG */
 
+static inline struct folio *pfn_to_online_folio(unsigned long pfn)
+{
+	struct page *page = pfn_to_online_page(pfn);
+
+	return page ? page_folio(page) : NULL;
+}
+
 /*
  * Keep this declaration outside CONFIG_MEMORY_HOTPLUG as some
  * platforms might override and use arch_get_mappable_range()
-- 
2.35.3

