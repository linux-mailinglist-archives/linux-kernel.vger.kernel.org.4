Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5705B33FA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiIIJ2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiIIJ05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:26:57 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D2EE293C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:25:32 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MP9VC1sbRzlVql;
        Fri,  9 Sep 2022 17:21:39 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 9 Sep
 2022 17:25:30 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <david@redhat.com>, <osalvador@suse.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 11/16] mm/page_alloc: make boot_nodestats static
Date:   Fri, 9 Sep 2022 17:24:46 +0800
Message-ID: <20220909092451.24883-12-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220909092451.24883-1-linmiaohe@huawei.com>
References: <20220909092451.24883-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

It's only used in mm/page_alloc.c now. Make it static.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/internal.h   | 2 --
 mm/page_alloc.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 2424fcde6538..43a441d35baf 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -864,8 +864,6 @@ int migrate_device_coherent_page(struct page *page);
  */
 struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags);
 
-DECLARE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
-
 extern bool mirrored_kernelcore;
 
 static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3417232afa45..7a8a6bb08a15 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6571,7 +6571,7 @@ static void per_cpu_pages_init(struct per_cpu_pages *pcp, struct per_cpu_zonesta
 #define BOOT_PAGESET_BATCH	1
 static DEFINE_PER_CPU(struct per_cpu_pages, boot_pageset);
 static DEFINE_PER_CPU(struct per_cpu_zonestat, boot_zonestats);
-DEFINE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
+static DEFINE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
 
 static void __build_all_zonelists(void *data)
 {
-- 
2.23.0

