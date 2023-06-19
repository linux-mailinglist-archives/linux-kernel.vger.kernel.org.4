Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE04B734A16
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 04:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjFSCWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 22:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjFSCWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 22:22:43 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E42E1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 19:22:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VlNkAdD_1687141356;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VlNkAdD_1687141356)
          by smtp.aliyun-inc.com;
          Mon, 19 Jun 2023 10:22:37 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, vbabka@suse.cz, david@redhat.com,
        ying.huang@intel.com, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] mm: compaction: skip memory hole rapidly when isolating migratable pages
Date:   Mon, 19 Jun 2023 10:22:24 +0800
Message-Id: <a1d859c28af0c7e85e91795e7473f553eb180a9d.1686813379.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some machines, the normal zone can have a large memory hole like
below memory layout, and we can see the range from 0x100000000 to
0x1800000000 is a hole. So when isolating some migratable pages, the
scanner can meet the hole and it will take more time to skip the large
hole. From my measurement, I can see the isolation scanner will take
80us ~ 100us to skip the large hole [0x100000000 - 0x1800000000].

So adding a new helper to fast search next online memory section
to skip the large hole can help to find next suitable pageblock
efficiently. With this patch, I can see the large hole scanning only
takes < 1us.

[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x0000001fa7ffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000040000000-0x0000000fffffffff]
[    0.000000]   node   0: [mem 0x0000001800000000-0x0000001fa3c7ffff]
[    0.000000]   node   0: [mem 0x0000001fa3c80000-0x0000001fa3ffffff]
[    0.000000]   node   0: [mem 0x0000001fa4000000-0x0000001fa402ffff]
[    0.000000]   node   0: [mem 0x0000001fa4030000-0x0000001fa40effff]
[    0.000000]   node   0: [mem 0x0000001fa40f0000-0x0000001fa73cffff]
[    0.000000]   node   0: [mem 0x0000001fa73d0000-0x0000001fa745ffff]
[    0.000000]   node   0: [mem 0x0000001fa7460000-0x0000001fa746ffff]
[    0.000000]   node   0: [mem 0x0000001fa7470000-0x0000001fa758ffff]
[    0.000000]   node   0: [mem 0x0000001fa7590000-0x0000001fa7ffffff]

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: "Huang, Ying" <ying.huang@intel.com>
---
Changes from v3:
 - Limit next_ptn to not exceed cc->free_pfn.
Changes from v2:
 - Simplify the function suggested by David.
 - Collect acked tag from David and Ying. Thanks.
Changes from v1:
 - Fix building errors if CONFIG_SPARSEMEM is not selected.
 - Use NR_MEM_SECTIONS instead of '-1' per Huang Ying.
---
 mm/compaction.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 3398ef3a55fe..3dc3b804bcbb 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -229,6 +229,33 @@ static void reset_cached_positions(struct zone *zone)
 				pageblock_start_pfn(zone_end_pfn(zone) - 1);
 }
 
+#ifdef CONFIG_SPARSEMEM
+/*
+ * If the PFN falls into an offline section, return the start PFN of the
+ * next online section. If the PFN falls into an online section or if
+ * there is no next online section, return 0.
+ */
+static unsigned long skip_offline_sections(unsigned long start_pfn)
+{
+	unsigned long start_nr = pfn_to_section_nr(start_pfn);
+
+	if (online_section_nr(start_nr))
+		return 0;
+
+	while (++start_nr <= __highest_present_section_nr) {
+		if (online_section_nr(start_nr))
+			return section_nr_to_pfn(start_nr);
+	}
+
+	return 0;
+}
+#else
+static unsigned long skip_offline_sections(unsigned long start_pfn)
+{
+	return 0;
+}
+#endif
+
 /*
  * Compound pages of >= pageblock_order should consistently be skipped until
  * released. It is always pointless to compact pages of such order (if they are
@@ -1991,8 +2018,14 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
 
 		page = pageblock_pfn_to_page(block_start_pfn,
 						block_end_pfn, cc->zone);
-		if (!page)
+		if (!page) {
+			unsigned long next_pfn;
+
+			next_pfn = skip_offline_sections(block_start_pfn);
+			if (next_pfn)
+				block_end_pfn = min(next_pfn, cc->free_pfn);
 			continue;
+		}
 
 		/*
 		 * If isolation recently failed, do not retry. Only check the
-- 
2.27.0

