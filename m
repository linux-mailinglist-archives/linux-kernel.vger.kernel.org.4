Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541326421AE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 03:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiLECru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 21:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiLECrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 21:47:48 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0281365D0
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 18:47:47 -0800 (PST)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NQScd5mJCzRpkX;
        Mon,  5 Dec 2022 10:46:57 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Dec 2022 10:47:44 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <akpm@linux-foundation.org>, <shli@kernel.org>, <hughd@google.com>,
        <arnd@arndb.de>, <minchan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <chenwandun@huawei.com>
Subject: [PATCH] swapfile: fix uncorrect statistical count about free swap
Date:   Mon, 5 Dec 2022 10:47:26 +0800
Message-ID: <20221205024726.3111808-1-chenwandun@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The counter of free swap turn to negtive during swapoff, this
phenomenon can be observed in oom log, such as:

1226 total pagecache pages
47 pages in swap cache
Swap cache stats: add 119633, delete 119814, find 26832/82125
Free swap  = -31796kB
Total swap = 0kB
1048576 pages RAM

Subtract the size of swap partition from free swap should put behind
try_to_unuse, otherwise, it will result in negtive counter if swap
partition is in use.

Fixes: ec8acf20afb8 ("swap: add per-partition lock for swapfile")
Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 mm/swapfile.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 72e481aacd5d..5b9b695be84b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2316,8 +2316,6 @@ static void setup_swap_info(struct swap_info_struct *p, int prio,
 static void _enable_swap_info(struct swap_info_struct *p)
 {
 	p->flags |= SWP_WRITEOK;
-	atomic_long_add(p->pages, &nr_swap_pages);
-	total_swap_pages += p->pages;
 
 	assert_spin_locked(&swap_lock);
 	/*
@@ -2353,6 +2351,8 @@ static void enable_swap_info(struct swap_info_struct *p, int prio,
 	spin_lock(&swap_lock);
 	spin_lock(&p->lock);
 	_enable_swap_info(p);
+	atomic_long_add(p->pages, &nr_swap_pages);
+	total_swap_pages += p->pages;
 	spin_unlock(&p->lock);
 	spin_unlock(&swap_lock);
 }
@@ -2444,8 +2444,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 		least_priority++;
 	}
 	plist_del(&p->list, &swap_active_head);
-	atomic_long_sub(p->pages, &nr_swap_pages);
-	total_swap_pages -= p->pages;
 	p->flags &= ~SWP_WRITEOK;
 	spin_unlock(&p->lock);
 	spin_unlock(&swap_lock);
@@ -2500,6 +2498,8 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 		spin_lock(&p->lock);
 	}
 
+	atomic_long_sub(p->pages, &nr_swap_pages);
+	total_swap_pages -= p->pages;
 	swap_file = p->swap_file;
 	old_block_size = p->old_block_size;
 	p->swap_file = NULL;
-- 
2.25.1

