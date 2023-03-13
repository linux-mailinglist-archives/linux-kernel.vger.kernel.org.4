Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7256B743F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjCMKiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjCMKh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:37:56 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021B65F532
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:37:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VdlJ.M3_1678703847;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VdlJ.M3_1678703847)
          by smtp.aliyun-inc.com;
          Mon, 13 Mar 2023 18:37:27 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, osalvador@suse.de, vbabka@suse.cz,
        william.lam@bytedance.com, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm: compaction: fix the possible deadlock when isolating hugetlb pages
Date:   Mon, 13 Mar 2023 18:37:17 +0800
Message-Id: <a24a86fbae09711e61dc4424aa7aebff718e9995.1678703534.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <1bc1c955b03603c4e14f56dfbbef9f637f18dbbd.1678703534.git.baolin.wang@linux.alibaba.com>
References: <1bc1c955b03603c4e14f56dfbbef9f637f18dbbd.1678703534.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to isolate a migratable pageblock, it can contain several
normal pages or several hugetlb pages (e.g. CONT-PTE 64K hugetlb on arm64)
in a pageblock. That means we may hold the lru lock of a normal page to
continue to isolate the next hugetlb page by isolate_or_dissolve_huge_page()
in the same migratable pageblock.

However in the isolate_or_dissolve_huge_page(), it may allocate a new hugetlb
page and dissolve the old one by alloc_and_dissolve_hugetlb_folio() if the
hugetlb's refcount is zero. That means we can still enter the direct compaction
path to allocate a new hugetlb page under the current lru lock, which
may cause possible deadlock.

To avoid this possible deadlock, we should release the lru lock when trying
to isolate a hugetbl page. Moreover it does not make sense to take the lru
lock to isolate a hugetlb, which is not in the lru list.

Fixes: 369fa227c219 ("mm: make alloc_contig_range handle free hugetlb pages")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/compaction.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index c9d9ad958e2a..ac8ff152421a 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -893,6 +893,11 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		}
 
 		if (PageHuge(page) && cc->alloc_contig) {
+			if (locked) {
+				unlock_page_lruvec_irqrestore(locked, flags);
+				locked = NULL;
+			}
+
 			ret = isolate_or_dissolve_huge_page(page, &cc->migratepages);
 
 			/*
-- 
2.27.0

