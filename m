Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF07F6CFD38
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjC3Hpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjC3Hpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:45:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398732111
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:45:42 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PnFk33fHlzSqrN;
        Thu, 30 Mar 2023 15:42:03 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 15:45:39 +0800
From:   Longlong Xia <xialonglong1@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linmiaohe@huawei.com>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Longlong Xia <xialonglong1@huawei.com>
Subject: [PATCH 1/2] mm: memory-failure: Refactor add_to_kill()
Date:   Thu, 30 Mar 2023 15:45:00 +0800
Message-ID: <20230330074501.205092-2-xialonglong1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230330074501.205092-1-xialonglong1@huawei.com>
References: <20230330074501.205092-1-xialonglong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page_address_in_vma() is used to find the user virtual address of page
in add_to_kill(), but it doesn't support ksm due to the ksm page->index
unusable, add an addr as parameter to add_to_kill(), let's the caller to
pass it, also rename the function to __add_to_kill(), and adding
add_to_kill_anon_file() for handling anonymous pages and file pages,
adding add_to_kill_fsdax() for handling fsdax pages.

Signed-off-by: Longlong Xia <xialonglong1@huawei.com>
---
 mm/memory-failure.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a1ede7bdce95e..9ca058f659121 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -405,9 +405,9 @@ static unsigned long dev_pagemap_mapping_shift(struct vm_area_struct *vma,
  * page->mapping are sufficient for mapping the page back to its
  * corresponding user virtual address.
  */
-static void add_to_kill(struct task_struct *tsk, struct page *p,
-			pgoff_t fsdax_pgoff, struct vm_area_struct *vma,
-			struct list_head *to_kill)
+static void __add_to_kill(struct task_struct *tsk, struct page *p,
+			  struct vm_area_struct *vma, struct list_head *to_kill,
+			  unsigned long addr, pgoff_t fsdax_pgoff)
 {
 	struct to_kill *tk;
 
@@ -417,7 +417,7 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
 		return;
 	}
 
-	tk->addr = page_address_in_vma(p, vma);
+	tk->addr = addr ? addr : page_address_in_vma(p, vma);
 	if (is_zone_device_page(p)) {
 		if (fsdax_pgoff != FSDAX_INVALID_PGOFF)
 			tk->addr = vma_pgoff_address(fsdax_pgoff, 1, vma);
@@ -448,6 +448,13 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
 	list_add_tail(&tk->nd, to_kill);
 }
 
+static void add_to_kill_anon_file(struct task_struct *tsk, struct page *p,
+				  struct vm_area_struct *vma,
+				  struct list_head *to_kill)
+{
+	__add_to_kill(tsk, p, vma, to_kill, 0, FSDAX_INVALID_PGOFF);
+}
+
 /*
  * Kill the processes that have been collected earlier.
  *
@@ -573,7 +580,7 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
 				continue;
 			if (!page_mapped_in_vma(page, vma))
 				continue;
-			add_to_kill(t, page, FSDAX_INVALID_PGOFF, vma, to_kill);
+			add_to_kill_anon_file(t, page, vma, to_kill);
 		}
 	}
 	read_unlock(&tasklist_lock);
@@ -609,8 +616,7 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
 			 * to be informed of all such data corruptions.
 			 */
 			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, FSDAX_INVALID_PGOFF, vma,
-					    to_kill);
+				add_to_kill_anon_file(t, page, vma, to_kill);
 		}
 	}
 	read_unlock(&tasklist_lock);
@@ -618,6 +624,13 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
 }
 
 #ifdef CONFIG_FS_DAX
+static void add_to_kill_fsdax(struct task_struct *tsk, struct page *p,
+			      struct vm_area_struct *vma,
+			      struct list_head *to_kill, pgoff_t pgoff)
+{
+	__add_to_kill(tsk, p, vma, to_kill, 0, pgoff);
+}
+
 /*
  * Collect processes when the error hit a fsdax page.
  */
@@ -637,7 +650,7 @@ static void collect_procs_fsdax(struct page *page,
 			continue;
 		vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
 			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, pgoff, vma, to_kill);
+				add_to_kill_fsdax(t, page, vma, to_kill, pgoff);
 		}
 	}
 	read_unlock(&tasklist_lock);
-- 
2.25.1

