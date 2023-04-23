Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772586EBEFB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 13:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjDWLAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 07:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjDWLAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 07:00:07 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F771728
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 03:59:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VgjjRNn_1682247580;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VgjjRNn_1682247580)
          by smtp.aliyun-inc.com;
          Sun, 23 Apr 2023 18:59:41 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     rppt@kernel.org, ying.huang@intel.com, mgorman@techsingularity.net,
        vbabka@suse.cz, mhocko@suse.com, david@redhat.com,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mm/page_alloc: add some comments to explain the possible hole in __pageblock_pfn_to_page()
Date:   Sun, 23 Apr 2023 18:59:11 +0800
Message-Id: <0733a4cf57109a4136de5ae46fac83fb15bdd528.1682229876.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <9fc85cce8908938f4fd75ff50bc981c073779aa5.1682229876.git.baolin.wang@linux.alibaba.com>
References: <9fc85cce8908938f4fd75ff50bc981c073779aa5.1682229876.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the __pageblock_pfn_to_page() is used by set_zone_contiguous(), which
checks whether the given zone contains holes, and uses pfn_to_online_page()
to validate if the start pfn is online and valid, as well as using pfn_valid()
to validate the end pfn.

However, the __pageblock_pfn_to_page() function may return non-NULL even
if the end pfn of a pageblock is in a memory hole in some situations. For
example, if the pageblock order is MAX_ORDER, which will fall into 2
sub-sections, and the end pfn of the pageblock may be hole even though
the start pfn is online and valid.

This did not break anything until now, but the zone continuous is fragile
in this possible scenario. So as previous discussion[1], it is better to
add some comments to explain this possible issue in case there are some
future pfn walkers that rely on this.

[1] https://lore.kernel.org/all/87r0sdsmr6.fsf@yhuang6-desk2.ccr.corp.intel.com/

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
Changes from v1:
 - Update the comments per Ying and Mike, thanks.
---
 mm/page_alloc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6457b64fe562..9756d66f471c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1502,6 +1502,13 @@ void __free_pages_core(struct page *page, unsigned int order)
  * interleaving within a single pageblock. It is therefore sufficient to check
  * the first and last page of a pageblock and avoid checking each individual
  * page in a pageblock.
+ *
+ * Note: the function may return non-NULL even if the end pfn of a pageblock
+ * is in a memory hole in some situations. For example, if the pageblock
+ * order is MAX_ORDER, which will fall into 2 sub-sections, and the end pfn
+ * of the pageblock may be hole even though the start pfn is online and valid.
+ * This did not break anything until now, but be careful about this possible
+ * issue when checking whether all pfns of a pageblock are valid.
  */
 struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
 				     unsigned long end_pfn, struct zone *zone)
-- 
2.27.0

