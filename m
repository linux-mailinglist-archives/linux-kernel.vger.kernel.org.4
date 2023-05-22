Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFF370B5F9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjEVHLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjEVHKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:10:03 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9F2E56
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684739378; x=1716275378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pFsVEqpuPiRv19w/rqm+IY358s8W3zh5r+eFbJEC2g0=;
  b=JUARmWfctMfmKL6sWx4fMCOtvswpiF2eMo/ghaJS8hRaZ/lFgceibrOP
   Mzfnnxhcs7f/yUNPKSmlmf3EPvXaCw9+K+y9d2RvGMERZI/Z/it1LK8n2
   aE8tAQGV5BRj9a3rwtcQNgNLbiS+4D/NADSLqH8IuM+CKPgVzKXX3hM0b
   TL9mLJpcOVexwjmWVbOR3MKmMxX+eiySzS3eZeZLqSwP+YdX5JeVkTmKf
   vdjmxeLqM8UO5n/k4iK05Gw8IBdiwSI015RastyRPXY1FU6Kjg/quZagl
   oTsRiIP/7loM5JkeMSqxoDx5W9LUJzCJzWcjAU0Bpf5RKOm7gAKpVvNjA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="337437062"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="337437062"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 00:09:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="773212746"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="773212746"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.5.152])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 00:09:34 -0700
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
Subject: [PATCH -V2 5/5] swap: comments get_swap_device() with usage rule
Date:   Mon, 22 May 2023 15:09:05 +0800
Message-Id: <20230522070905.16773-6-ying.huang@intel.com>
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

The general rule to use a swap entry is as follows.

When we get a swap entry, if there isn't some other way to prevent
swapoff, such as page lock for swap cache, page table lock, etc., the
swap entry may become invalid because of swapoff.  Then, we need to
enclose all swap related functions with get_swap_device() and
put_swap_device(), unless the swap functions call
get/put_swap_device() by themselves.

Add the rule as comments of get_swap_device().

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
 mm/swapfile.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4dbaea64635d..0c1cb935b2eb 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1219,6 +1219,13 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
 }
 
 /*
+ * When we get a swap entry, if there isn't some other way to prevent
+ * swapoff, such as page lock for swap cache, page table lock, etc.,
+ * the swap entry may become invalid because of swapoff.  Then, we
+ * need to enclose all swap related functions with get_swap_device()
+ * and put_swap_device(), unless the swap functions call
+ * get/put_swap_device() by themselves.
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

