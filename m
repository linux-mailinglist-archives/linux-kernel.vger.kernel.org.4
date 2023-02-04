Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E75268A816
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 05:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjBDEHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 23:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjBDEGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 23:06:54 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0440D93E3F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 20:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675483613; x=1707019613;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Gn7LOPh68jC6rQtBAdzLGiAHS3AXRc2KQzYf1z3imZ8=;
  b=X3FfTmHWBRDVLCV4bSpXufeKBUz85bdW35WbIdU7grhq3LmIbh0bZACb
   3sXYUYpwPdq3TfYApb32wcu8JzeyOLexGrP8OG2gTbRJlvPOhs82ObSkS
   dYj0e7TJssNHUf/W4+RQ8SqkGcyvL/pPa1R8qfCVCPwtOUmge4Mk+DE6I
   Vz8pCvw0wTo3299B0aMneAZREGpBUKB29bl22ADOnPTXYL6Sexz4gBbMo
   gptzVjeT9a9/jxXH95V0v3bMtvobyANnJSt1estD/zWN/MzK0ZeWV19JX
   DwirbfZsF9XXejQQF08s24T+DGwyNq0HCxcTwUiyXl5IwXMafNlUEuQmr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="391309393"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="391309393"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 20:06:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="734573746"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="734573746"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.125.166])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 20:06:50 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Fri, 03 Feb 2023 20:06:35 -0800
Subject: [PATCH v2 4/4] mm: Remove get_kernel_pages()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-get_kernel_pages-v2-4-f1dc4af273f1@intel.com>
References: <20230203-get_kernel_pages-v2-0-f1dc4af273f1@intel.com>
In-Reply-To: <20230203-get_kernel_pages-v2-0-f1dc4af273f1@intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-mm@kvack.org, Jens Wiklander <jens.wiklander@linaro.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>
X-Mailer: b4 0.12-dev-cc11a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675483603; l=2399;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=Gn7LOPh68jC6rQtBAdzLGiAHS3AXRc2KQzYf1z3imZ8=;
 b=dtMl0p52IOZ2AWrZlNxQC0o566NNoARG+88pUiatsr9mZ3kAamW4p30F2cWrtR7TWfG/NlmQ5P46
 nLpzu72hCrXm4hl+axUIWouYPD1240kahyv/zdlOeYxdAtDG2vnq
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only caller to get_kernel_pages() [shm_get_kernel_pages()] has been
updated to not need it.

Remove get_kernel_pages().

Cc: Mel Gorman <mgorman@suse.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Acked-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/mm.h |  2 --
 mm/swap.c          | 30 ------------------------------
 2 files changed, 32 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8f857163ac89..2041e6d4fa27 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2095,8 +2095,6 @@ int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
 			struct task_struct *task, bool bypass_rlim);
 
 struct kvec;
-int get_kernel_pages(const struct kvec *iov, int nr_pages, int write,
-			struct page **pages);
 struct page *get_dump_page(unsigned long addr);
 
 bool folio_mark_dirty(struct folio *folio);
diff --git a/mm/swap.c b/mm/swap.c
index 70e2063ef43a..4c03ecab698e 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -158,36 +158,6 @@ void put_pages_list(struct list_head *pages)
 }
 EXPORT_SYMBOL(put_pages_list);
 
-/*
- * get_kernel_pages() - pin kernel pages in memory
- * @kiov:	An array of struct kvec structures
- * @nr_segs:	number of segments to pin
- * @write:	pinning for read/write, currently ignored
- * @pages:	array that receives pointers to the pages pinned.
- *		Should be at least nr_segs long.
- *
- * Returns number of pages pinned. This may be fewer than the number requested.
- * If nr_segs is 0 or negative, returns 0.  If no pages were pinned, returns 0.
- * Each page returned must be released with a put_page() call when it is
- * finished with.
- */
-int get_kernel_pages(const struct kvec *kiov, int nr_segs, int write,
-		struct page **pages)
-{
-	int seg;
-
-	for (seg = 0; seg < nr_segs; seg++) {
-		if (WARN_ON(kiov[seg].iov_len != PAGE_SIZE))
-			return seg;
-
-		pages[seg] = kmap_to_page(kiov[seg].iov_base);
-		get_page(pages[seg]);
-	}
-
-	return seg;
-}
-EXPORT_SYMBOL_GPL(get_kernel_pages);
-
 typedef void (*move_fn_t)(struct lruvec *lruvec, struct folio *folio);
 
 static void lru_add_fn(struct lruvec *lruvec, struct folio *folio)

-- 
2.39.1
