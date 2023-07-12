Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C654750D31
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbjGLPzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjGLPzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:55:08 -0400
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7531BDA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689177302; x=1720713302;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LVjgjUbjERTsFVSNtscDtjPvDGcfdrNKfXLSL6zFYW8=;
  b=UQHqRtp1G/n/WavAhgqV2EE93BSBWOQ1xt0u3DsjJqyrhld1U809NsxA
   ktI7oN8u/qbbD6yH7fbi8NP8ZM6kQsoaivFQvPXiVLS37I1MbmWElNvce
   3txnjTPUITJ6GO9K05gRp/p1AW1KUtqFJKu0esIFFCbsLX9yMGh51akNn
   Q=;
X-IronPort-AV: E=Sophos;i="6.01,200,1684800000"; 
   d="scan'208";a="659499494"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-edda28d4.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 15:54:55 +0000
Received: from EX19D014EUC004.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-m6i4x-edda28d4.us-east-1.amazon.com (Postfix) with ESMTPS id 9940480531;
        Wed, 12 Jul 2023 15:54:51 +0000 (UTC)
Received: from u5d18b891348c5b.ant.amazon.com (10.146.13.225) by
 EX19D014EUC004.ant.amazon.com (10.252.51.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 12 Jul 2023 15:54:44 +0000
From:   James Gowans <jgowans@amazon.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        James Gowans <jgowans@amazon.com>,
        =?UTF-8?q?Jan=20H=20=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Minghao Chi <chi.minghao@zte.com.cn>
Subject: [RFC] mm: compaction: suitable_migration_target checks for higher order buddies
Date:   Wed, 12 Jul 2023 17:54:21 +0200
Message-ID: <20230712155421.875491-1-jgowans@amazon.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.146.13.225]
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huge page compaction finds free target pages to which source pages can
be migrated when compacting.  A huge page sized and aligned block is
considered a valid source of target pages if it passes the
suitable_migration_target() test. One of the things which
suitable_migration_target() does is to ensure that the entire block
isn't currently free. It would counter productive to use an already
fully free huge page sized block as a migration target because using
pages from that free huge page block would decrease the number of
available huge pages in the system.

suitable_migration_source() attempts to ensure that the supplied block
is not currently a fully free block by checking PageBuddy flag on the
starting page of the huge page sized and aligned block. This approach is
flawed: the buddy list can and does maintain buddies at a larger order
than huge page size. For example on a typical x86 system, huge page
pageblock_order is 2 MiB, but the buddy list MAX_ORDER is 4 MiB. Because
of this, a pageblock_order sized block may be free because it is part of
a larger order buddy list buddy, but the pageblock_order sized block
won't itself be part of the buddy list, only the larger order block will
be. The current suitable_migration_target() implementation of just
checking the PageBuddy flag on the pageblock_order block is hence
insufficient as it will appear that the block is not free and hence try
to use it as a source of migration target pages.

Enhance suitable_migration_target() to cater for this case by scanning
up the buddy orders from the current pageblock_order page to MAX_ORDER
to see if any of the larger page blocks have the PageBuddy flag set.

In practice incorrectly considering a page block as a suitable migration
target doesn't actually cause the block to be broken down. That block is
passed to isolate_freepages_block() which will scan it for any pages
currently in the buddy list. The assumption is that buddy list nodes
will be found because the entire block is not free. In the case
described above actually no buddy list nodes will be found because the
higher order block is free. It's just unnecessary scanning.

As such, the user visible effect of this change is only (in theory [1])
very slightly faster huge compaction by avoiding scanning entirely free
blocks for free pages. Even if the effect is negligible, this change
better conveys what the function is attempting to do: check whether this
page block is entirely free or not.

[1] I have not actually measured whether the difference is noticeable.

Notes and caveats for this RFC:

- If the supplied struct page is already the "left most" page in a
MAX_ORDER block, the page will be checked multiple times unnecessarily.
Iterating up the orders will result in zeroing bits which were already
zero. Not sure if we want to get fancier here and detect this by finding
the starting order?

- The PFN bit masking is somewhat yucky. We could use helper functions
but the ones I know of rely on knowing the existing order of the
supplied struct page, which this function is currently oblivious to.

- Is this change even worth it? My contention is "yes" or else this
function wouldn't bother checking the PageBuddy flag today - it clearly
wants to try to avoid unnecessary scans... Either let's do the job
properly or delete the check rather than a half job.

Suggested-by: Jan H. Schönherr <jschoenh@amazon.de>
Signed-off-by: James Gowans <jgowans@amazon.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Minghao Chi <chi.minghao@zte.com.cn>
---
 mm/compaction.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 9641e2131901..fb0e37d99364 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1342,15 +1342,40 @@ static bool suitable_migration_source(struct compact_control *cc,
 static bool suitable_migration_target(struct compact_control *cc,
 							struct page *page)
 {
-	/* If the page is a large free page, then disallow migration */
-	if (PageBuddy(page)) {
+	unsigned int higher_order;
+	/*
+	 * If the supplied page is part of a pageblock_order or larger free
+	 * block it is not a suitable migration target block. Detect this case
+	 * by starting at the pageorder_block aligned page and scan upwards to
+	 * MAX_ORDER aligned page. Scan to see if any of the struct pages are
+	 * in the buddy list for the order of the larger block. Disallow
+	 * migration if so.
+	 */
+	for (higher_order = pageblock_order; higher_order <= MAX_ORDER; ++higher_order) {
+		struct page *higher_order_page;
+		unsigned long higher_order_pfn;
 		/*
-		 * We are checking page_order without zone->lock taken. But
-		 * the only small danger is that we skip a potentially suitable
-		 * pageblock, so it's not worth to check order for valid range.
+		 * This is legal provided that struct pages are always initialised
+		 * to at least start at MAX_ORDER alignment.
 		 */
-		if (buddy_order_unsafe(page) >= pageblock_order)
-			return false;
+		higher_order_pfn &= ~((1 << higher_order) - 1);
+		higher_order_page = pfn_to_page(higher_order_pfn);
+		if (PageBuddy(higher_order_page)) {
+			/*
+			 * We are checking page_order without zone->lock taken. But
+			 * the only small danger is that we skip a potentially suitable
+			 * pageblock, so it's not worth to check order for valid range.
+			 */
+			if (buddy_order_unsafe(higher_order_page) >= higher_order)
+				return false;
+			/*
+			 * This is a buddy but not a sufficiently large buddy.
+			 * There will never be a larger one above this.
+			 */
+			else
+				break;
+		}
+
 	}
 
 	if (cc->ignore_block_suitable)
-- 
2.25.1

