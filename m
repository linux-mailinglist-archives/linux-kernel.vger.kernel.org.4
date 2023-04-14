Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1867E6E1A18
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 04:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjDNCSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 22:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDNCSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 22:18:33 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A82430DD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 19:18:31 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PyKld0Nf2z17SXm;
        Fri, 14 Apr 2023 10:14:53 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 14 Apr 2023 10:18:28 +0800
From:   Longlong Xia <xialonglong1@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linmiaohe@huawei.com>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Longlong Xia <xialonglong1@huawei.com>
Subject: [PATCH v2 2/2] mm: ksm: Support hwpoison for ksm page
Date:   Fri, 14 Apr 2023 10:17:41 +0800
Message-ID: <20230414021741.2597273-3-xialonglong1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230414021741.2597273-1-xialonglong1@huawei.com>
References: <20230414021741.2597273-1-xialonglong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hwpoison_user_mappings() is updated to support ksm pages, and add
collect_procs_ksm() to collect processes when the error hit an ksm
page. The difference from collect_procs_anon() is that it also needs
to traverse the rmap-item list on the stable node of the ksm page.
At the same time, add_to_kill_ksm() is added to handle ksm pages. And
task_in_to_kill_list() is added to avoid duplicate addition of tsk to
the to_kill list. This is because when scanning the list, if the pages
that make up the ksm page all come from the same process, they may be
added repeatedly.

Signed-off-by: Longlong Xia <xialonglong1@huawei.com>
Tested-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/ksm.h | 11 +++++++++++
 include/linux/mm.h  |  7 +++++++
 mm/ksm.c            | 45 +++++++++++++++++++++++++++++++++++++++++++++
 mm/memory-failure.c | 34 +++++++++++++++++++++++++---------
 4 files changed, 88 insertions(+), 9 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 7e232ba59b865..d9e701326a882 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -51,6 +51,10 @@ struct page *ksm_might_need_to_copy(struct page *page,
 void rmap_walk_ksm(struct folio *folio, struct rmap_walk_control *rwc);
 void folio_migrate_ksm(struct folio *newfolio, struct folio *folio);
 
+#ifdef CONFIG_MEMORY_FAILURE
+void collect_procs_ksm(struct page *page, struct list_head *to_kill,
+		       int force_early);
+#endif
 #else  /* !CONFIG_KSM */
 
 static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
@@ -62,6 +66,13 @@ static inline void ksm_exit(struct mm_struct *mm)
 {
 }
 
+#ifdef CONFIG_MEMORY_FAILURE
+static inline void collect_procs_ksm(struct page *page,
+				     struct list_head *to_kill, int force_early)
+{
+}
+#endif
+
 #ifdef CONFIG_MMU
 static inline int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		unsigned long end, int advice, unsigned long *vm_flags)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1f79667824eb6..342c0d1c31f92 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3453,6 +3453,7 @@ extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 					bool *migratable_cleared);
 void num_poisoned_pages_inc(unsigned long pfn);
 void num_poisoned_pages_sub(unsigned long pfn, long i);
+struct task_struct *task_early_kill(struct task_struct *tsk, int force_early);
 #else
 static inline void memory_failure_queue(unsigned long pfn, int flags)
 {
@@ -3473,6 +3474,12 @@ static inline void num_poisoned_pages_sub(unsigned long pfn, long i)
 }
 #endif
 
+#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_KSM)
+void add_to_kill_ksm(struct task_struct *tsk, struct page *p,
+		     struct vm_area_struct *vma, struct list_head *to_kill,
+		     unsigned long ksm_addr);
+#endif
+
 #if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_MEMORY_HOTPLUG)
 extern void memblk_nr_poison_inc(unsigned long pfn);
 extern void memblk_nr_poison_sub(unsigned long pfn, long i);
diff --git a/mm/ksm.c b/mm/ksm.c
index 2b8d30068cbbd..29e4be80b6c57 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2721,6 +2721,51 @@ void rmap_walk_ksm(struct folio *folio, struct rmap_walk_control *rwc)
 		goto again;
 }
 
+#ifdef CONFIG_MEMORY_FAILURE
+/*
+ * Collect processes when the error hit an ksm page.
+ */
+void collect_procs_ksm(struct page *page, struct list_head *to_kill,
+		       int force_early)
+{
+	struct ksm_stable_node *stable_node;
+	struct ksm_rmap_item *rmap_item;
+	struct folio *folio = page_folio(page);
+	struct vm_area_struct *vma;
+	struct task_struct *tsk;
+
+	stable_node = folio_stable_node(folio);
+	if (!stable_node)
+		return;
+	hlist_for_each_entry(rmap_item, &stable_node->hlist, hlist) {
+		struct anon_vma *av = rmap_item->anon_vma;
+
+		anon_vma_lock_read(av);
+		read_lock(&tasklist_lock);
+		for_each_process(tsk) {
+			struct anon_vma_chain *vmac;
+			unsigned long addr;
+			struct task_struct *t =
+				task_early_kill(tsk, force_early);
+			if (!t)
+				continue;
+			anon_vma_interval_tree_foreach(vmac, &av->rb_root, 0,
+						       ULONG_MAX)
+			{
+				vma = vmac->vma;
+				if (vma->vm_mm == t->mm) {
+					addr = rmap_item->address & PAGE_MASK;
+					add_to_kill_ksm(t, page, vma, to_kill,
+							addr);
+				}
+			}
+		}
+		read_unlock(&tasklist_lock);
+		anon_vma_unlock_read(av);
+	}
+}
+#endif
+
 #ifdef CONFIG_MIGRATION
 void folio_migrate_ksm(struct folio *newfolio, struct folio *folio)
 {
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index f5e1d80a82738..6ed97e78b5b8a 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -455,6 +455,27 @@ static void add_to_kill_anon_file(struct task_struct *tsk, struct page *p,
 	__add_to_kill(tsk, p, vma, to_kill, 0, FSDAX_INVALID_PGOFF);
 }
 
+#ifdef CONFIG_KSM
+static bool task_in_to_kill_list(struct list_head *to_kill,
+				 struct task_struct *tsk)
+{
+	struct to_kill *tk, *next;
+
+	list_for_each_entry_safe(tk, next, to_kill, nd) {
+		if (tk->tsk == tsk)
+			return true;
+	}
+
+	return false;
+}
+void add_to_kill_ksm(struct task_struct *tsk, struct page *p,
+		     struct vm_area_struct *vma, struct list_head *to_kill,
+		     unsigned long ksm_addr)
+{
+	if (!task_in_to_kill_list(to_kill, tsk))
+		__add_to_kill(tsk, p, vma, to_kill, ksm_addr, FSDAX_INVALID_PGOFF);
+}
+#endif
 /*
  * Kill the processes that have been collected earlier.
  *
@@ -534,8 +555,7 @@ static struct task_struct *find_early_kill_thread(struct task_struct *tsk)
  * processes sharing the same error page,if the process is "early kill", the
  * task_struct of the dedicated thread will also be returned.
  */
-static struct task_struct *task_early_kill(struct task_struct *tsk,
-					   int force_early)
+struct task_struct *task_early_kill(struct task_struct *tsk, int force_early)
 {
 	if (!tsk->mm)
 		return NULL;
@@ -666,8 +686,9 @@ static void collect_procs(struct page *page, struct list_head *tokill,
 {
 	if (!page->mapping)
 		return;
-
-	if (PageAnon(page))
+	if (unlikely(PageKsm(page)))
+		collect_procs_ksm(page, tokill, force_early);
+	else if (PageAnon(page))
 		collect_procs_anon(page, tokill, force_early);
 	else
 		collect_procs_file(page, tokill, force_early);
@@ -1522,11 +1543,6 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	if (!page_mapped(hpage))
 		return true;
 
-	if (PageKsm(p)) {
-		pr_err("%#lx: can't handle KSM pages.\n", pfn);
-		return false;
-	}
-
 	if (PageSwapCache(p)) {
 		pr_err("%#lx: keeping poisoned page in swap cache\n", pfn);
 		ttu &= ~TTU_HWPOISON;
-- 
2.25.1

