Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEC46FBD10
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 04:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbjEICU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 22:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbjEICU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 22:20:26 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E906693CD
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 19:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683598825; x=1715134825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jhv+F2tb9b4VuUgfQs8d2vVC/9qfFsg1b8FLFSc2Iok=;
  b=nPQzQgm7dX/tKdF/YaYQwF+DpVqXCtTawxjKUdgqXhOYf21xo2wEbFGP
   cLmmbdQPbN6upG/ww4nv7x11A7xtrdbiT1jOYN7ssag8UhJe0XGcewZ/b
   4Qzfd11S0KLx//yr7jxcZ3vNpS21Kz/L6oMpSMOeOqqBy+HWWDpc45799
   2tlF17SwoX8nj5HfPg8xon6bra85x1W+tcbmkfwVlYeiFlsAUKbtdUcDW
   jw8O4pxdcdk3j1epy+3VRCfAFwFVs34DXYuSL5QAINKSdCraXDyfBfyC0
   De/+/TqOtbuj7M61q0Lj7evh4HRlV8TcfxoFqnihErx7TPPZWgDADftf1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="330155080"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="330155080"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 19:20:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="731515730"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="731515730"
Received: from jiudongl-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.30.15])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 19:20:23 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Xin Hao <xhao@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH 2/2] migrate_pages_batch: code cleanup: remove is_large
Date:   Tue,  9 May 2023 10:20:14 +0800
Message-Id: <20230509022014.380493-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509022014.380493-1-ying.huang@intel.com>
References: <20230509022014.380493-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, in migrate_pages_batch we need to track whether the source
folio is large/THP before splitting.  So is_large is used to cache
folio_test_large() result.  Now, we don't need that variable any more
because we don't count retrying and failure of large folios (only
counting that of THP folios).  So, in this patch, is_large is removed
to simplify the code.

This is just code cleanup, no functionality changes are expected.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Xin Hao <xhao@linux.alibaba.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Alistair Popple <apopple@nvidia.com>
---
 mm/migrate.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 10709aed76d3..2ac927a82bbc 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1618,7 +1618,6 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 	int nr_failed = 0;
 	int nr_retry_pages = 0;
 	int pass = 0;
-	bool is_large = false;
 	bool is_thp = false;
 	struct folio *folio, *folio2, *dst = NULL, *dst2;
 	int rc, rc_saved = 0, nr_pages;
@@ -1635,13 +1634,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 		nr_retry_pages = 0;
 
 		list_for_each_entry_safe(folio, folio2, from, lru) {
-			/*
-			 * Large folio statistics is based on the source large
-			 * folio. Capture required information that might get
-			 * lost during migration.
-			 */
-			is_large = folio_test_large(folio);
-			is_thp = is_large && folio_test_pmd_mappable(folio);
+			is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);
 			nr_pages = folio_nr_pages(folio);
 
 			cond_resched();
@@ -1688,7 +1681,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 				nr_failed++;
 				stats->nr_thp_failed += is_thp;
 				/* Large folio NUMA faulting doesn't split to retry. */
-				if (is_large && !nosplit) {
+				if (folio_test_large(folio) && !nosplit) {
 					int ret = try_split_folio(folio, split_folios);
 
 					if (!ret) {
-- 
2.39.2

