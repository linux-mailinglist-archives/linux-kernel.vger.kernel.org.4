Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D80170B5FA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjEVHLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbjEVHJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:09:59 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81675129
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684739375; x=1716275375;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CAvLy4/ErwSMMyC1M2gR5vND9soNKvGVJOF+Oh8rPBI=;
  b=jQ7kzQqNSlMe8jzZScES1iN5M7sHDn2IentIcu0hBl/1rAre/gNE7EJz
   qyEN+e1EcjZ2s2CfIEFpUcpSw+hNHZ+g3IZEiYvtbgfypMHWI45qCcv3r
   X0oX5LXcc4ry3oo5KeQ2xoQAjkQAsISucPjYIJgVjOEwYNRnWfxJhlnm+
   nitOjbh9tuk8fWrsxnN+2xHmHHE8Uwl2uE65TFkAVvTXhUMnqWoIsW4+R
   9c9PCzAsD7iUsJwjDIYXre0tp4351VB4iffcMJqfpM5ZA4B3tG9luGEMA
   0CKsxzS+Y/LWj5C+tjF2TneOlWlzCXEDAV7mXMLCnmmMiDq/YCMNMq4SP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="337436974"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="337436974"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 00:09:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="773212678"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="773212678"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.5.152])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 00:09:22 -0700
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
Subject: [PATCH -V2 1/5] swap: Remove get/put_swap_device() in __swap_count()
Date:   Mon, 22 May 2023 15:09:01 +0800
Message-Id: <20230522070905.16773-2-ying.huang@intel.com>
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

__swap_count() is called in do_swap_page() only, which encloses the
call site with get/put_swap_device() already.

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
 mm/swapfile.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 274bbf797480..8419cba9c192 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1432,16 +1432,10 @@ void swapcache_free_entries(swp_entry_t *entries, int n)
 
 int __swap_count(swp_entry_t entry)
 {
-	struct swap_info_struct *si;
+	struct swap_info_struct *si = swp_swap_info(entry);
 	pgoff_t offset = swp_offset(entry);
-	int count = 0;
 
-	si = get_swap_device(entry);
-	if (si) {
-		count = swap_count(si->swap_map[offset]);
-		put_swap_device(si);
-	}
-	return count;
+	return swap_count(si->swap_map[offset]);
 }
 
 /*
-- 
2.39.2

