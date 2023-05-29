Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC57714990
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjE2MhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjE2MhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:37:17 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970EAAD
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 05:37:14 -0700 (PDT)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QVFP50DRgzLmPC;
        Mon, 29 May 2023 20:35:37 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 29 May 2023 20:37:10 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>, <kirill.shutemov@linux.intel.com>,
        <hughd@google.com>
CC:     <n-horiguchi@ah.jp.nec.com>, <jmarchan@redhat.com>,
        <willy@infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <mawupeng1@huawei.com>
Subject: [RFC PATCH stable 5.10/5.15] mm: Pass head page to clear_page_mlock for page_remove_rmap
Date:   Mon, 29 May 2023 20:37:05 +0800
Message-ID: <20230529123705.955378-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ma Wupeng <mawupeng1@huawei.com>

Our syzbot report a mlock related problem. During exit_mm, tail page is
passed to clear_page_mlock which final lead to kernel panic.

During unmap_page_range, if compound is false, it means this page is
seen as a small page. This page is passed to isolate_lru_page if this
page is PageMlocked and finally lead to "trying to isolate tail page"
warning.

Here is the simplified calltrace:

unmap_page_range
  zap_pte_range
    page_remove_rmap(page, false);	// compound is false means to handle
					   to small page not compound page
	  nr_pages = thp_nr_pages(page);
	  clear_page_mlock(page)	// maybe tail page here
		isolate_lru_page
		  WARN_RATELIMIT(PageTail(page), "trying to isolate tail page");

Since mlock is not supposed to handle tail, we pass head page to
clear_page_mlock() to slove this problem.

This bug can lead to multiple reports. Here ares the simplified reports:

------------[ cut here ]------------
trying to isolate tail page
WARNING: CPU: 1 PID: 24489 at mm/vmscan.c:2031 isolate_lru_page+0x574/0x660

page:fffffc000eb7a300 refcount:512 mapcount:0 mapping:0000000000000000 index:0x2008c pfn:0x3ede8c
head:fffffc000eb78000 order:9 compound_mapcount:0 compound_pincount:0
memcg:ffff0000d24bc000
anon flags: 0x37ffff80009080c(uptodate|dirty|arch_1|head|swapbacked|node=1|zone=2|lastcpupid=0xfffff)
raw: 037ffff800000800 fffffc000eb78001 fffffc000eb7a308 dead000000000400
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 037ffff80009080c fffffc000eb70008 fffffc000e350708 ffff0003829eb839
head: 0000000000020000 0000000000000000 00000200ffffffff ffff0000d24bc000
page dumped because: VM_WARN_ON_ONCE_PAGE(!memcg && !mem_cgroup_disabled())
------------[ cut here ]------------
WARNING: CPU: 1 PID: 24489 at include/linux/memcontrol.h:767 lock_page_lruvec_irq+0x148/0x190

page:fffffc000eb7a300 refcount:0 mapcount:0 mapping:dead000000000400 index:0x0 pfn:0x3ede8c
failed to read mapping contents, not a valid kernel address?
flags: 0x37ffff800000800(arch_1|node=1|zone=2|lastcpupid=0xfffff)
raw: 037ffff800000800 dead000000000100 dead000000000122 dead000000000400
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: VM_BUG_ON_PAGE(((unsigned int) page_ref_count(page) + 127u <= 127u))
------------[ cut here ]------------
kernel BUG at include/linux/mm.h:1213!
Call trace:
 lru_cache_add+0x2d4/0x2e8
 putback_lru_page+0x2c/0x168
 clear_page_mlock+0x254/0x318
 page_remove_rmap+0x900/0x9c0
 unmap_page_range+0xa78/0x16a0
 unmap_single_vma+0x114/0x1a0
 unmap_vmas+0x100/0x220
 exit_mmap+0x120/0x410
 mmput+0x174/0x498
 exit_mm+0x33c/0x460
 do_exit+0x3c0/0x1310
 do_group_exit+0x98/0x170
 get_signal+0x370/0x13d0
 do_notify_resume+0x5a0/0x968
 el0_da+0x154/0x188
 el0t_64_sync_handler+0x88/0xb8
 el0t_64_sync+0x1a0/0x1a4
Code: 912b0021 aa1503e0 910c0021 9401a49c (d4210000)

This bug can be reproduced in both linux-5.10.y & linux-5.15.y and maybe
fixed after commit 889a3747b3b7 ("mm/lru: Add folio LRU functions").
This patch turn page into folio for LRU related operations, all
operations to page is turn to folio which means head page after this
patch.

Fixes: d281ee614518 ("rmap: add argument to charge compound page")
Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 mm/rmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 330b361a460e..8838f6a9d65d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1372,7 +1372,7 @@ void page_remove_rmap(struct page *page, bool compound)
 	__dec_lruvec_page_state(page, NR_ANON_MAPPED);
 
 	if (unlikely(PageMlocked(page)))
-		clear_page_mlock(page);
+		clear_page_mlock(compound_head(page));
 
 	if (PageTransCompound(page))
 		deferred_split_huge_page(compound_head(page));
-- 
2.25.1

