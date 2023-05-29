Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3577D7143F8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 08:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjE2GOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 02:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjE2GOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 02:14:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F8EF1
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 23:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685340869; x=1716876869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BU9rFfysv4elNLJ2GHzqi2liUatC3EzDYJWAUuFdw+0=;
  b=cJxrFtlCwIuI2Qjv4t0svwIYrYf8UN4laXVC3qIsq+xZpAtNS+1bPG4V
   w2QJ0pcsaEAY83MpX20jynYcuQx85NV01amjXU4pw5N6Wce5yK3+ICZco
   41D0VgIKfZ9U9tBkRoE7eoSFx7zxvflNl4lFRqZMY45WpwvyXiKECzKYT
   elWTHgSozyruFTewpFqcuPxnm6cR/8d9Em19AQ7PGiPVR9H9wt/F3wPRA
   2g10+RcObIGDHtdXWDAVaetUpmjRsxIdChk2PtJOWHZ0/DvM+vgpYAjU6
   bVaEpse+rgKHOv+FqDZRH/c4SEyvpOKupgPB0uKd3jBU92DGtOy9Zzq3I
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="357881854"
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="357881854"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 23:14:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="1036080010"
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="1036080010"
Received: from azhao3-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.28.126])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 23:14:25 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Chris Li <chrisl@kernel.org>
Subject: [PATCH -V3 4/5] swap: remove get/put_swap_device() in __swap_duplicate()
Date:   Mon, 29 May 2023 14:13:54 +0800
Message-Id: <20230529061355.125791-5-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230529061355.125791-1-ying.huang@intel.com>
References: <20230529061355.125791-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__swap_duplicate() is called by

- swap_shmem_alloc(): the folio in swap cache is locked.

- copy_nonpresent_pte() -> swap_duplicate() and try_to_unmap_one() ->
  swap_duplicate(): the page table lock is held.

- __read_swap_cache_async() -> swapcache_prepare(): enclosed with
  get/put_swap_device() in __read_swap_cache_async() already.

So, it's safe to remove get/put_swap_device() in __swap_duplicate().

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Chris Li <chrisl@kernel.org>
---
 mm/swapfile.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index e9cce775fb25..4dbaea64635d 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3264,9 +3264,7 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
 	unsigned char has_cache;
 	int err;
 
-	p = get_swap_device(entry);
-	if (!p)
-		return -EINVAL;
+	p = swp_swap_info(entry);
 
 	offset = swp_offset(entry);
 	ci = lock_cluster_or_swap_info(p, offset);
@@ -3313,7 +3311,6 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
 
 unlock_out:
 	unlock_cluster_or_swap_info(p, ci);
-	put_swap_device(p);
 	return err;
 }
 
-- 
2.39.2

