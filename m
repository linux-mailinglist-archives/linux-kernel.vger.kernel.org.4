Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D759574E684
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 07:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjGKFu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 01:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjGKFuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 01:50:08 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FFCE40
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 22:50:07 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R0VHt1MsqztQvN;
        Tue, 11 Jul 2023 13:47:06 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 11 Jul
 2023 13:50:03 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 6/8] mm: memory-failure: minor cleanup for comments and codestyle
Date:   Tue, 11 Jul 2023 13:50:14 +0800
Message-ID: <20230711055016.2286677-7-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230711055016.2286677-1-linmiaohe@huawei.com>
References: <20230711055016.2286677-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some wrong function names and grammar error in comments. Also remove
unneeded space after for_each_process. No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 0da6ddbdd718..db4c530944d6 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -608,7 +608,7 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
 
 	pgoff = page_to_pgoff(page);
 	read_lock(&tasklist_lock);
-	for_each_process (tsk) {
+	for_each_process(tsk) {
 		struct anon_vma_chain *vmac;
 		struct task_struct *t = task_early_kill(tsk, force_early);
 
@@ -652,7 +652,7 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
 			/*
 			 * Send early kill signal to tasks where a vma covers
 			 * the page but the corrupted page is not necessarily
-			 * mapped it in its pte.
+			 * mapped in its pte.
 			 * Assume applications who requested early kill want
 			 * to be informed of all such data corruptions.
 			 */
@@ -2127,7 +2127,7 @@ static DEFINE_MUTEX(mf_mutex);
  * detected by a background scrubber)
  *
  * Must run in process context (e.g. a work queue) with interrupts
- * enabled and no spinlocks hold.
+ * enabled and no spinlocks held.
  *
  * Return: 0 for successfully handled the memory error,
  *         -EOPNOTSUPP for hwpoison_filter() filtered the error event,
@@ -2232,7 +2232,7 @@ int memory_failure(unsigned long pfn, int flags)
 		 * otherwise it may race with THP split.
 		 * And the flag can't be set in get_hwpoison_page() since
 		 * it is called by soft offline too and it is just called
-		 * for !MF_COUNT_INCREASE.  So here seems to be the best
+		 * for !MF_COUNT_INCREASED.  So here seems to be the best
 		 * place.
 		 *
 		 * Don't need care about the above error handling paths for
@@ -2589,10 +2589,10 @@ static bool isolate_page(struct page *page, struct list_head *pagelist)
 
 	/*
 	 * If we succeed to isolate the page, we grabbed another refcount on
-	 * the page, so we can safely drop the one we got from get_any_pages().
+	 * the page, so we can safely drop the one we got from get_any_page().
 	 * If we failed to isolate the page, it means that we cannot go further
 	 * and we will return an error, so drop the reference we got from
-	 * get_any_pages() as well.
+	 * get_any_page() as well.
 	 */
 	put_page(page);
 	return isolated;
-- 
2.33.0

