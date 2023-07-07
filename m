Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB8074AD5E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjGGIv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjGGIv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:51:56 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC55129
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 01:51:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vmo.NB4_1688719910;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vmo.NB4_1688719910)
          by smtp.aliyun-inc.com;
          Fri, 07 Jul 2023 16:51:51 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, vbabka@suse.cz, david@redhat.com,
        ying.huang@intel.com, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm: compaction: skip the memory hole rapidly when isolating free pages
Date:   Fri,  7 Jul 2023 16:51:47 +0800
Message-Id: <d2ba7e41ee566309b594311207ffca736375fc16.1688715750.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <b21cd8e2e32b9a1d9bc9e43ebf8acaf35e87f8df.1688715750.git.baolin.wang@linux.alibaba.com>
References: <b21cd8e2e32b9a1d9bc9e43ebf8acaf35e87f8df.1688715750.git.baolin.wang@linux.alibaba.com>
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

On my machine with below memory layout, and I can see it will take more
time to skip the larger memory hole (range: 0x100000000 - 0x1800000000)
when isolating free pages. So adding a new helper to skip the memory
hole rapidly, which can reduce the time consumed from about 70us to less
than 1us.

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

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/compaction.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 43358efdbdc2..9641e2131901 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -249,11 +249,31 @@ static unsigned long skip_offline_sections(unsigned long start_pfn)
 
 	return 0;
 }
+
+static unsigned long skip_offline_sections_reverse(unsigned long start_pfn)
+{
+	unsigned long start_nr = pfn_to_section_nr(start_pfn);
+
+	if (!start_nr || online_section_nr(start_nr))
+		return 0;
+
+	while (start_nr-- > 0) {
+		if (online_section_nr(start_nr))
+			return section_nr_to_pfn(start_nr) + PAGES_PER_SECTION - 1;
+	}
+
+	return 0;
+}
 #else
 static unsigned long skip_offline_sections(unsigned long start_pfn)
 {
 	return 0;
 }
+
+static unsigned long skip_offline_sections_reverse(unsigned long start_pfn)
+{
+	return 0;
+}
 #endif
 
 /*
@@ -1668,8 +1688,16 @@ static void isolate_freepages(struct compact_control *cc)
 
 		page = pageblock_pfn_to_page(block_start_pfn, block_end_pfn,
 									zone);
-		if (!page)
+		if (!page) {
+			unsigned long next_pfn;
+
+			next_pfn = skip_offline_sections_reverse(block_start_pfn);
+			if (next_pfn)
+				block_start_pfn = max(pageblock_start_pfn(next_pfn),
+						      low_pfn);
+
 			continue;
+		}
 
 		/* Check the block is suitable for migration */
 		if (!suitable_migration_target(cc, page))
-- 
2.39.3

