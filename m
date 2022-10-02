Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C605F20BC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 02:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiJBAXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 20:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJBAXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 20:23:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADCF53D0B
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 17:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664670214; x=1696206214;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CCJ9DvVnhSMgehlzBf8ksWsMMNT3cd5lyxVwLoYRSKQ=;
  b=lA9NuNnPPl70q6h+v+8Y95Pts7Ag9V5ob11eSsbInw9J9aPTduw5dcB9
   C+gcER2WXKVkGJGBZdfsIk2KJeRNFPHcPKcPl6mqLMUGuWwLKc4ZS74Km
   /F6zaBvf//85wqelyVkGnr6ECfQmOOmAq4zTtqZiBozPW0q+KQfejppRS
   o61YhMq63+XIR8YfcxwpdEmYm/S3EzlLZ0zsQssRJqZyTO0B12CaVAiQi
   Evfc9nph4WRONJnPRRwWA0L+28HLRXcF6cXLgAq4zD2YI+2wvBf7o90mY
   cpRIEuAwWVPhhKxIF4wxvoiRBJ0MTDnckDgWIxfsTi65u9nUTIP7YxA6Z
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10487"; a="285564527"
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="285564527"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2022 17:23:34 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10487"; a="656347047"
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="656347047"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.213.181.73])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2022 17:23:33 -0700
From:   ira.weiny@intel.com
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, Mel Gorman <mgorman@suse.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 4/4] mm: Remove get_kernel_pages()
Date:   Sat,  1 Oct 2022 17:23:26 -0700
Message-Id: <20221002002326.946620-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221002002326.946620-1-ira.weiny@intel.com>
References: <20221002002326.946620-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The only caller to get_kernel_pages() [shm_get_kernel_pages()] has been
updated to not need it.

Remove get_kernel_pages().

Cc: Mel Gorman <mgorman@suse.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/mm.h |  2 --
 mm/swap.c          | 30 ------------------------------
 2 files changed, 32 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8bbcccbc5565..9a06df4f057c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1969,8 +1969,6 @@ int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
 			struct task_struct *task, bool bypass_rlim);
 
 struct kvec;
-int get_kernel_pages(const struct kvec *iov, int nr_pages, int write,
-			struct page **pages);
 struct page *get_dump_page(unsigned long addr);
 
 bool folio_mark_dirty(struct folio *folio);
diff --git a/mm/swap.c b/mm/swap.c
index 955930f41d20..a9aa648eb0d0 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -157,36 +157,6 @@ void put_pages_list(struct list_head *pages)
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
2.37.2

