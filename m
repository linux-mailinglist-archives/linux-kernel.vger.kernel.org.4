Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601D55F9D3C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 13:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbiJJLCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 07:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiJJLCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 07:02:03 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0581C6D9FC;
        Mon, 10 Oct 2022 04:01:57 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 29AB0i36074609
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Mon, 10 Oct 2022 19:00:45 +0800 (CST)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 10 Oct 2022 19:00:44 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <linux-mm@kvack.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ke.wang@unisoc.com>, <steve.kang@unisoc.com>
Subject: [RFC PATCH] mm: skip GFP_IO if swap is zram only
Date:   Mon, 10 Oct 2022 19:00:22 +0800
Message-ID: <1665399622-20236-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 29AB0i36074609
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

__GFP_IO is believed to prevent the allocation being suspended due to accessing
physical block devices when reclaiming dirty pages. Zram is not considered as
such kind of device from kernel perspective of view. Do swap things if the system
is zram only.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 include/linux/swap.h     | 1 +
 include/linux/swapfile.h | 1 -
 mm/swapfile.c            | 7 +++++++
 mm/vmscan.c              | 3 ++-
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 43150b9..c160b2e 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -505,6 +505,7 @@ static inline long get_nr_swap_pages(void)
 extern int init_swap_address_space(unsigned int type, unsigned long nr_pages);
 extern void exit_swap_address_space(unsigned int type);
 extern struct swap_info_struct *get_swap_device(swp_entry_t entry);
+extern bool if_swap_zram_only(void);
 sector_t swap_page_sector(struct page *page);
 
 static inline void put_swap_device(struct swap_info_struct *si)
diff --git a/include/linux/swapfile.h b/include/linux/swapfile.h
index 5407854..e229c36 100644
--- a/include/linux/swapfile.h
+++ b/include/linux/swapfile.h
@@ -9,5 +9,4 @@
 extern struct swap_info_struct *swap_info[];
 extern unsigned long generic_max_swapfile_size(void);
 extern unsigned long max_swapfile_size(void);
-
 #endif /* _LINUX_SWAPFILE_H */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 1fdccd2..e1b2969 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3663,6 +3663,13 @@ void __cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask)
 }
 #endif
 
+bool if_swap_zram_only(void)
+{
+	return ((nr_swapfiles == 1)
+		&& !strncmp(swap_info[0]->bdev->bd_disk->disk_name, "zram", 4));
+}
+EXPORT_SYMBOL_GPL(if_swap_zram_only);
+
 static int __init swapfile_init(void)
 {
 	int nid;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b2b1431..37500b5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1770,7 +1770,8 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 		 */
 		if (folio_test_anon(folio) && folio_test_swapbacked(folio)) {
 			if (!folio_test_swapcache(folio)) {
-				if (!(sc->gfp_mask & __GFP_IO))
+				if (!(sc->gfp_mask & __GFP_IO)
+					&& !if_swap_zram_only())
 					goto keep_locked;
 				if (folio_maybe_dma_pinned(folio))
 					goto keep_locked;
-- 
1.9.1

