Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628F964B20A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbiLMJOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbiLMJM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:12:58 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD10101E8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:11:21 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NWXgW3V50zqT0X;
        Tue, 13 Dec 2022 17:07:03 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 13 Dec 2022 17:11:19 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        SeongJae Park <sj@kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <damon@lists.linux.dev>, <vishal.moola@gmail.com>,
        <willy@infradead.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 2/8] mm: page_idle: Convert page idle to use folios
Date:   Tue, 13 Dec 2022 17:27:29 +0800
Message-ID: <20221213092735.187924-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221213092735.187924-1-wangkefeng.wang@huawei.com>
References: <20221213092735.187924-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change and rename all page related function to use folio,
which save many compound_head() calls and kernel text.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/page_idle.c | 91 ++++++++++++++++++++++++--------------------------
 1 file changed, 44 insertions(+), 47 deletions(-)

diff --git a/mm/page_idle.c b/mm/page_idle.c
index bc08332a609c..38641f94cf49 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -19,34 +19,33 @@
 #define BITMAP_CHUNK_BITS	(BITMAP_CHUNK_SIZE * BITS_PER_BYTE)
 
 /*
- * Idle page tracking only considers user memory pages, for other types of
- * pages the idle flag is always unset and an attempt to set it is silently
+ * Idle folio tracking only considers user memory folios, for other types of
+ * folios the idle flag is always unset and an attempt to set it is silently
  * ignored.
  *
- * We treat a page as a user memory page if it is on an LRU list, because it is
- * always safe to pass such a page to rmap_walk(), which is essential for idle
- * page tracking. With such an indicator of user pages we can skip isolated
- * pages, but since there are not usually many of them, it will hardly affect
+ * We treat a folio as a user memory folio if it is on an LRU list, because it is
+ * always safe to pass such a folio to rmap_walk(), which is essential for idle
+ * folio tracking. With such an indicator of user folios we can skip isolated
+ * folios, but since there are not usually many of them, it will hardly affect
  * the overall result.
  *
- * This function tries to get a user memory page by pfn as described above.
+ * This function tries to get a user memory folio by pfn as described above.
  */
-static struct page *page_idle_get_page(unsigned long pfn)
+static struct folio *folio_idle_get_folio(unsigned long pfn)
 {
-	struct page *page = pfn_to_online_page(pfn);
+	struct folio *folio = pfn_to_online_folio(pfn);
 
-	if (!page || !PageLRU(page) ||
-	    !get_page_unless_zero(page))
+	if (!folio || !folio_test_lru(folio) || !folio_try_get(folio))
 		return NULL;
 
-	if (unlikely(!PageLRU(page))) {
-		put_page(page);
-		page = NULL;
+	if (unlikely(!folio_test_lru(folio))) {
+		folio_put(folio);
+		folio = NULL;
 	}
-	return page;
+	return folio;
 }
 
-static bool page_idle_clear_pte_refs_one(struct folio *folio,
+static bool folio_idle_clear_pte_refs_one(struct folio *folio,
 					struct vm_area_struct *vma,
 					unsigned long addr, void *arg)
 {
@@ -74,8 +73,8 @@ static bool page_idle_clear_pte_refs_one(struct folio *folio,
 	if (referenced) {
 		folio_clear_idle(folio);
 		/*
-		 * We cleared the referenced bit in a mapping to this page. To
-		 * avoid interference with page reclaim, mark it young so that
+		 * We cleared the referenced bit in a mapping to this folio. To
+		 * avoid interference with folio reclaim, mark it young so that
 		 * folio_referenced() will return > 0.
 		 */
 		folio_set_young(folio);
@@ -83,16 +82,14 @@ static bool page_idle_clear_pte_refs_one(struct folio *folio,
 	return true;
 }
 
-static void page_idle_clear_pte_refs(struct page *page)
+static void folio_idle_clear_pte_refs(struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
-
 	/*
 	 * Since rwc.try_lock is unused, rwc is effectively immutable, so we
 	 * can make it static to save some cycles and stack.
 	 */
 	static struct rmap_walk_control rwc = {
-		.rmap_one = page_idle_clear_pte_refs_one,
+		.rmap_one = folio_idle_clear_pte_refs_one,
 		.anon_lock = folio_lock_anon_vma_read,
 	};
 	bool need_lock;
@@ -110,12 +107,12 @@ static void page_idle_clear_pte_refs(struct page *page)
 		folio_unlock(folio);
 }
 
-static ssize_t page_idle_bitmap_read(struct file *file, struct kobject *kobj,
+static ssize_t folio_idle_bitmap_read(struct file *file, struct kobject *kobj,
 				     struct bin_attribute *attr, char *buf,
 				     loff_t pos, size_t count)
 {
 	u64 *out = (u64 *)buf;
-	struct page *page;
+	struct folio *folio;
 	unsigned long pfn, end_pfn;
 	int bit;
 
@@ -134,19 +131,19 @@ static ssize_t page_idle_bitmap_read(struct file *file, struct kobject *kobj,
 		bit = pfn % BITMAP_CHUNK_BITS;
 		if (!bit)
 			*out = 0ULL;
-		page = page_idle_get_page(pfn);
-		if (page) {
-			if (page_is_idle(page)) {
+		folio = folio_idle_get_folio(pfn);
+		if (folio) {
+			if (folio_test_idle(folio)) {
 				/*
-				 * The page might have been referenced via a
+				 * The folio might have been referenced via a
 				 * pte, in which case it is not idle. Clear
 				 * refs and recheck.
 				 */
-				page_idle_clear_pte_refs(page);
-				if (page_is_idle(page))
+				folio_idle_clear_pte_refs(folio);
+				if (folio_test_idle(folio))
 					*out |= 1ULL << bit;
 			}
-			put_page(page);
+			folio_put(folio);
 		}
 		if (bit == BITMAP_CHUNK_BITS - 1)
 			out++;
@@ -155,12 +152,12 @@ static ssize_t page_idle_bitmap_read(struct file *file, struct kobject *kobj,
 	return (char *)out - buf;
 }
 
-static ssize_t page_idle_bitmap_write(struct file *file, struct kobject *kobj,
+static ssize_t folio_idle_bitmap_write(struct file *file, struct kobject *kobj,
 				      struct bin_attribute *attr, char *buf,
 				      loff_t pos, size_t count)
 {
 	const u64 *in = (u64 *)buf;
-	struct page *page;
+	struct folio *folio;
 	unsigned long pfn, end_pfn;
 	int bit;
 
@@ -178,11 +175,11 @@ static ssize_t page_idle_bitmap_write(struct file *file, struct kobject *kobj,
 	for (; pfn < end_pfn; pfn++) {
 		bit = pfn % BITMAP_CHUNK_BITS;
 		if ((*in >> bit) & 1) {
-			page = page_idle_get_page(pfn);
-			if (page) {
-				page_idle_clear_pte_refs(page);
-				set_page_idle(page);
-				put_page(page);
+			folio = folio_idle_get_folio(pfn);
+			if (folio) {
+				folio_idle_clear_pte_refs(folio);
+				folio_set_idle(folio);
+				folio_put(folio);
 			}
 		}
 		if (bit == BITMAP_CHUNK_BITS - 1)
@@ -192,29 +189,29 @@ static ssize_t page_idle_bitmap_write(struct file *file, struct kobject *kobj,
 	return (char *)in - buf;
 }
 
-static struct bin_attribute page_idle_bitmap_attr =
+static struct bin_attribute folio_idle_bitmap_attr =
 		__BIN_ATTR(bitmap, 0600,
-			   page_idle_bitmap_read, page_idle_bitmap_write, 0);
+			   folio_idle_bitmap_read, folio_idle_bitmap_write, 0);
 
-static struct bin_attribute *page_idle_bin_attrs[] = {
-	&page_idle_bitmap_attr,
+static struct bin_attribute *folio_idle_bin_attrs[] = {
+	&folio_idle_bitmap_attr,
 	NULL,
 };
 
-static const struct attribute_group page_idle_attr_group = {
-	.bin_attrs = page_idle_bin_attrs,
+static const struct attribute_group folio_idle_attr_group = {
+	.bin_attrs = folio_idle_bin_attrs,
 	.name = "page_idle",
 };
 
-static int __init page_idle_init(void)
+static int __init folio_idle_init(void)
 {
 	int err;
 
-	err = sysfs_create_group(mm_kobj, &page_idle_attr_group);
+	err = sysfs_create_group(mm_kobj, &folio_idle_attr_group);
 	if (err) {
 		pr_err("page_idle: register sysfs failed\n");
 		return err;
 	}
 	return 0;
 }
-subsys_initcall(page_idle_init);
+subsys_initcall(folio_idle_init);
-- 
2.35.3

