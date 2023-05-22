Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A6A70B5F2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjEVHKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjEVHKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:10:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECF4E52
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684739378; x=1716275378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YSumEPT2C3HRRYpGGamb3AFAC7MiJLIPce/70xDMyEY=;
  b=NkRZCdaazOPXQGcQnNsUdcHvnyC1e+/SbhGKcnai7yZTjUtGHvdVt0U+
   KlnwZ9kixdS60Zb3iZIfYGb6UxOBudnbY5zIpfq6oFafe5ykcTnGtvMzk
   6PlA2htXbJzaH6PGpYxShfiP10uYrpog0dKiM9Z1C+wLLURlc9FD4h9Mf
   AAXiIfvcQDrtxLB2vQHp4Y+rq1IJNWCh+FN4pMeyCApVDB69Ebj5+89Pd
   +msENVg5qHQb77JHd1pFW8tSHlO8MWyfqch0sx+oouIf7Agy7iA2mM5/2
   xdaR8ZNLMMuxQ2VS7McORAUc3QmaHDdaEXIA4+Qqyj7d2lR9P2JoWtoCm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="337437037"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="337437037"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 00:09:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="773212723"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="773212723"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.5.152])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 00:09:31 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>
Subject: [PATCH -V2 4/5] swap: remove get/put_swap_device() in __swap_duplicate()
Date:   Mon, 22 May 2023 15:09:04 +0800
Message-Id: <20230522070905.16773-5-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522070905.16773-1-ying.huang@intel.com>
References: <20230522070905.16773-1-ying.huang@intel.com>
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

__swap_duplicate() is called by

- swap_shmem_alloc(): the page lock of the swap cache is held.

- copy_nonpresent_pte() -> swap_duplicate() and try_to_unmap_one() ->
  swap_duplicate(): the page table lock is held.

- __read_swap_cache_async() -> swapcache_prepare(): enclosed with
  get/put_swap_device() in __read_swap_cache_async() already.

So, it's safe to remove get/put_swap_device() in __swap_duplicate().

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Yu Zhao <yuzhao@google.com>
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

