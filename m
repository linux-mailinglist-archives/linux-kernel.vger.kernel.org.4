Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E61B6E3CE1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 02:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjDPX7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 19:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPX7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 19:59:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA38E1FE0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 16:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681689581; x=1713225581;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8ItCe/3pGalePCdA1Zg7PlF+EcL1t8Mnxe0wX8c5at0=;
  b=FJHrZk1+pJLhN96Tp0356GkgkkcubTkgneOGRELzxdOIximK6DKnqL5k
   PWQz8/l0iyFdPykXM/QFNhUkxvoiwS0TXF4E1XGImcbDDzwcNBSZW4oAk
   +5OQ1xu2BLqRXR3g2qpVeutlafq6rZqRSdCpYI8SOwMtdBwL2+8OqqjPK
   QUA+gtlloiGym2dbxr5XA/iIoCNMkqNusHOAojZDZtNcLRAyzCU37gG6V
   uyeaQw9pdal6Yl6GMTVbr/sjDYAWg69MIPIvJkkPU0fhyEcBV8PZWLV/h
   oxh3dBIWDgCqBkOH9IP1Scos1YxRM3ZB4+zjLRMWhG6VwX8/HTlKgTdhE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="328931875"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="328931875"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 16:59:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="720933757"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="720933757"
Received: from haowang7-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.28.119])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 16:59:38 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH] migrate_pages_batch: fix statistics for longterm pin retry
Date:   Mon, 17 Apr 2023 07:59:29 +0800
Message-Id: <20230416235929.1040194-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit fd4a7ac32918 ("mm: migrate: try again if THP split is failed
due to page refcnt"), if the THP splitting fails due to page reference
count, we will retry to improve migration successful rate.  But the
failed splitting is counted as migration failure and migration retry,
which will cause duplicated failure counting.  So, in this patch, this
is fixed via undoing the failure counting if we decide to retry.  The
patch is tested via failure injection.

Fixes: fd4a7ac32918 ("mm: migrate: try again if THP split is failed due to page refcnt")
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>
---
 mm/migrate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index b34a0f383795..47a1e8445f45 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1743,6 +1743,9 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 							large_retry++;
 							thp_retry += is_thp;
 							nr_retry_pages += nr_pages;
+							/* Undo duplicated failure counting. */
+							nr_large_failed--;
+							stats->nr_thp_failed -= is_thp;
 							break;
 						}
 					}
-- 
2.39.2

