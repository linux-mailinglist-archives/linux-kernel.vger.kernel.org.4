Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BD37143FC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 08:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjE2GOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 02:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjE2GOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 02:14:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8435D8
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 23:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685340872; x=1716876872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gqcq606hnAPL/bQemwK8mT4rmFd1An/GN7J3orZJsNQ=;
  b=SSYZBD301JuYZBoBT7PD8AXXBoFzSO4yCeBuFXJdalYNwpHI8vbfrPgq
   7Ojw1/FHjZ+1gCzdD4TEc5ri+ul3ewyumOgpcMLepDI5OJSUpJKK1rwiL
   UIAzJnVIbsBW5YVZXHfSxvqrcYple6lvkmaBoze5nwoHu/6am0CmRbWRy
   jD0F06lFIx6fZmBgyAq9NX5SxAEusvXQOjWzJdfEJTtE2dQ9VPgcY4f4B
   EiMbSLer25BIcWAtrD+QZr/7bjBGWH3AVR6yqxLWqyj8mXMrPBZ3aLUm+
   aw051r7ZzpD8TPUBIYQo7EYnKVYKenAUSCbuztyX40qRLhWQ/0HTkBlCh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="357881879"
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="357881879"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 23:14:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="1036080021"
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="1036080021"
Received: from azhao3-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.28.126])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 23:14:29 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Chris Li <chrisl@kernel.org>
Subject: [PATCH -V3 5/5] swap: comments get_swap_device() with usage rule
Date:   Mon, 29 May 2023 14:13:55 +0800
Message-Id: <20230529061355.125791-6-ying.huang@intel.com>
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

The general rule to use a swap entry is as follows.

When we get a swap entry, if there aren't some other ways to prevent
swapoff, such as the folio in swap cache is locked, page table lock is
held, etc., the swap entry may become invalid because of swapoff.
Then, we need to enclose all swap related functions with
get_swap_device() and put_swap_device(), unless the swap functions
call get/put_swap_device() by themselves.

Add the rule as comments of get_swap_device().

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
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
 mm/swapfile.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4dbaea64635d..3d0e932497f0 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1219,6 +1219,13 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
 }
 
 /*
+ * When we get a swap entry, if there aren't some other ways to
+ * prevent swapoff, such as the folio in swap cache is locked, page
+ * table lock is held, etc., the swap entry may become invalid because
+ * of swapoff.  Then, we need to enclose all swap related functions
+ * with get_swap_device() and put_swap_device(), unless the swap
+ * functions call get/put_swap_device() by themselves.
+ *
  * Check whether swap entry is valid in the swap device.  If so,
  * return pointer to swap_info_struct, and keep the swap entry valid
  * via preventing the swap device from being swapoff, until
@@ -1227,9 +1234,8 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
  * Notice that swapoff or swapoff+swapon can still happen before the
  * percpu_ref_tryget_live() in get_swap_device() or after the
  * percpu_ref_put() in put_swap_device() if there isn't any other way
- * to prevent swapoff, such as page lock, page table lock, etc.  The
- * caller must be prepared for that.  For example, the following
- * situation is possible.
+ * to prevent swapoff.  The caller must be prepared for that.  For
+ * example, the following situation is possible.
  *
  *   CPU1				CPU2
  *   do_swap_page()
-- 
2.39.2

