Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322117143F5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 08:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjE2GOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 02:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjE2GOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 02:14:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA7FAF
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 23:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685340858; x=1716876858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kl6+gAKi9abH9eFCSqmd4OqB2g+JQSA7OXalXR3MGok=;
  b=Gr+8bmWaXfU1i2tRBYM3nL3PQXbZgt/268Xjsm3ZBxKQWYMWzVcN4SEH
   GTXk2TJds4Gwexzcvj+SHCAYk+1anls4nGNRc3CQs4g+4nvdq4e0GT7ow
   sEPM1GgBQf6lCgXyomfpD1ez3ZBzPHz1dcyfpluD8iqwnlTu+wQlFl+iv
   uNppnq6zP5xoovxHB+RjR397xsmApZwGhzO1VABvAG7Z1rEj4zV20TLef
   zu6e5SVZ0AHwR/NBQYD8q1zPc8DMeIyIERDueZynyDNM020OktvQDmmln
   Fcpxa9178gNssT2pO+A+/s2xOOS43VzsI5N8IZ5PowrraH6txJw++bLL3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="357881783"
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="357881783"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 23:14:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="1036079982"
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="1036079982"
Received: from azhao3-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.28.126])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 23:14:15 -0700
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
Subject: [PATCH -V3 1/5] swap: Remove get/put_swap_device() in __swap_count()
Date:   Mon, 29 May 2023 14:13:51 +0800
Message-Id: <20230529061355.125791-2-ying.huang@intel.com>
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

get/put_swap_device() are added to __swap_count() in commit
eb085574a752 ("mm, swap: fix race between swapoff and some swap
operations").  Later, in commit 2799e77529c2 ("swap: fix
do_swap_page() race with swapoff"), get/put_swap_device() are added to
do_swap_page().  And they enclose the only call site of
__swap_count().  So, it's safe to remove get/put_swap_device() in
__swap_count() now.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
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

