Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A2D5ED4D7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbiI1GZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbiI1GZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:25:26 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B443AB2A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 23:25:25 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 28S5M7NJ004175
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 23:25:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=q0UrbPQLdJQEcsKptCdXrK/5wopl161PAMQD94MdseI=;
 b=dag43a8fc5dYCQc0y4j29Io9Ll4hyaFs3sGg/qut76zqwKS+jZQf8/BjRhTrxRM7VxZl
 wyZp37I9dU/pVCDH28VXpssN/ffGyWtfArYF1Ca46YvgQ/ln5rrcidR6TozB8Y7sRuEI
 MysobS3R5wXpFtXBNvtXoRQPTjeF8XXS+p8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3juxp6qdpv-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 23:25:24 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub204.TheFacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 23:25:21 -0700
Received: from twshared34348.07.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 23:25:21 -0700
Received: by devvm6390.atn0.facebook.com (Postfix, from userid 352741)
        id 76A41443E385; Tue, 27 Sep 2022 23:25:09 -0700 (PDT)
From:   <alexlzhu@fb.com>
To:     <linux-mm@kvack.org>
CC:     <willy@infradead.org>, <akpm@linux-foundation.org>,
        <riel@surriel.com>, <hannes@cmpxchg.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Alexander Zhu <alexlzhu@fb.com>
Subject: [PATCH 2/3] mm: changes to split_huge_page() to free zero filled tail pages
Date:   Tue, 27 Sep 2022 23:25:05 -0700
Message-ID: <94de34378bb748196e7709205a75331569d1d28e.1664344829.git.alexlzhu@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1664344829.git.alexlzhu@fb.com>
References: <cover.1664344829.git.alexlzhu@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: a6JJWAGWJdC8vwjaQRjYFMgt8KWNiQ_u
X-Proofpoint-ORIG-GUID: a6JJWAGWJdC8vwjaQRjYFMgt8KWNiQ_u
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_02,2022-09-27_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Zhu <alexlzhu@fb.com>

Currently, when /sys/kernel/mm/transparent_hugepage/enabled=3Dalways is set
there are a large number of transparent hugepages that are almost entirely
zero filled.  This is mentioned in a number of previous patchsets
including:
https://lore.kernel.org/all/20210731063938.1391602-1-yuzhao@google.com/
https://lore.kernel.org/all/
1635422215-99394-1-git-send-email-ningzhang@linux.alibaba.com/

Currently, split_huge_page() does not have a way to identify zero filled
pages within the THP. Thus these zero pages get remapped and continue to
create memory waste. In this patch, we identify and free tail pages that
are zero filled in split_huge_page(). In this way, we avoid mapping these
pages back into page table entries and can free up unused memory within
THPs. This is based off the previously mentioned patchset by Yu Zhao.
However, we chose to free anonymous zero tail pages whenever they are
encountered instead of only on reclaim or migration.

We also add self tests to verify the RssAnon value to make sure zero
pages are not remapped except in the case of userfaultfd. In the case
of userfaultfd we remap to the shared zero page, similar to what is
done by KSM.

Signed-off-by: Alexander Zhu <alexlzhu@fb.com>
---
 include/linux/rmap.h                          |   2 +-
 include/linux/vm_event_item.h                 |   3 +
 mm/huge_memory.c                              |  44 ++++++-
 mm/migrate.c                                  |  72 +++++++++--
 mm/migrate_device.c                           |   4 +-
 mm/vmstat.c                                   |   3 +
 .../selftests/vm/split_huge_page_test.c       | 113 +++++++++++++++++-
 tools/testing/selftests/vm/vm_util.c          |  23 ++++
 tools/testing/selftests/vm/vm_util.h          |   1 +
 9 files changed, 250 insertions(+), 15 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index b89b4b86951f..f7d5d5639dea 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -372,7 +372,7 @@ int folio_mkclean(struct folio *);
 int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t p=
goff,
 		      struct vm_area_struct *vma);
=20
-void remove_migration_ptes(struct folio *src, struct folio *dst, bool lock=
ed);
+void remove_migration_ptes(struct folio *src, struct folio *dst, bool lock=
ed, bool unmap_clean);
=20
 int page_mapped_in_vma(struct page *page, struct vm_area_struct *vma);
=20
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index f3fc36cd2276..bc7eac636fe4 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -111,6 +111,9 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 		THP_SPLIT_PUD,
 #endif
+		THP_SPLIT_FREE,
+		THP_SPLIT_UNMAP,
+		THP_SPLIT_REMAP_READONLY_ZERO_PAGE,
 		THP_ZERO_PAGE_ALLOC,
 		THP_ZERO_PAGE_ALLOC_FAILED,
 		THP_SWPOUT,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a05d6a42cf0a..b905d9d1a3f2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2442,7 +2442,7 @@ static void unmap_page(struct page *page)
 		try_to_unmap(folio, ttu_flags | TTU_IGNORE_MLOCK);
 }
=20
-static void remap_page(struct folio *folio, unsigned long nr)
+static void remap_page(struct folio *folio, unsigned long nr, bool unmap_c=
lean)
 {
 	int i =3D 0;
=20
@@ -2450,7 +2450,7 @@ static void remap_page(struct folio *folio, unsigned =
long nr)
 	if (!folio_test_anon(folio))
 		return;
 	for (;;) {
-		remove_migration_ptes(folio, folio, true);
+		remove_migration_ptes(folio, folio, true, unmap_clean);
 		i +=3D folio_nr_pages(folio);
 		if (i >=3D nr)
 			break;
@@ -2564,6 +2564,8 @@ static void __split_huge_page(struct page *page, stru=
ct list_head *list,
 	struct address_space *swap_cache =3D NULL;
 	unsigned long offset =3D 0;
 	unsigned int nr =3D thp_nr_pages(head);
+	LIST_HEAD(pages_to_free);
+	int nr_pages_to_free =3D 0;
 	int i;
=20
 	/* complete memcg works before add pages to LRU */
@@ -2626,7 +2628,7 @@ static void __split_huge_page(struct page *page, stru=
ct list_head *list,
 	}
 	local_irq_enable();
=20
-	remap_page(folio, nr);
+	remap_page(folio, nr, PageAnon(head));
=20
 	if (PageSwapCache(head)) {
 		swp_entry_t entry =3D { .val =3D page_private(head) };
@@ -2640,6 +2642,33 @@ static void __split_huge_page(struct page *page, str=
uct list_head *list,
 			continue;
 		unlock_page(subpage);
=20
+		/*
+		 * If a tail page has only two references left, one inherited
+		 * from the isolation of its head and the other from
+		 * lru_add_page_tail() which we are about to drop, it means this
+		 * tail page was concurrently zapped. Then we can safely free it
+		 * and save page reclaim or migration the trouble of trying it.
+		 */
+		if (list && page_ref_freeze(subpage, 2)) {
+			VM_BUG_ON_PAGE(PageLRU(subpage), subpage);
+			VM_BUG_ON_PAGE(PageCompound(subpage), subpage);
+			VM_BUG_ON_PAGE(page_mapped(subpage), subpage);
+
+			ClearPageActive(subpage);
+			ClearPageUnevictable(subpage);
+			list_move(&subpage->lru, &pages_to_free);
+			nr_pages_to_free++;
+			continue;
+		}
+		/*
+		 * If a tail page has only one reference left, it will be freed
+		 * by the call to free_page_and_swap_cache below. Since zero
+		 * subpages are no longer remapped, there will only be one
+		 * reference left in cases outside of reclaim or migration.
+		 */
+		if (page_ref_count(subpage) =3D=3D 1)
+			nr_pages_to_free++;
+
 		/*
 		 * Subpages may be freed if there wasn't any mapping
 		 * like if add_to_swap() is running on a lru page that
@@ -2649,6 +2678,13 @@ static void __split_huge_page(struct page *page, str=
uct list_head *list,
 		 */
 		free_page_and_swap_cache(subpage);
 	}
+
+	if (!nr_pages_to_free)
+		return;
+
+	mem_cgroup_uncharge_list(&pages_to_free);
+	free_unref_page_list(&pages_to_free);
+	count_vm_events(THP_SPLIT_FREE, nr_pages_to_free);
 }
=20
 /* Racy check whether the huge page can be split */
@@ -2811,7 +2847,7 @@ int split_huge_page_to_list(struct page *page, struct=
 list_head *list)
 		if (mapping)
 			xas_unlock(&xas);
 		local_irq_enable();
-		remap_page(folio, folio_nr_pages(folio));
+		remap_page(folio, folio_nr_pages(folio), false);
 		ret =3D -EBUSY;
 	}
=20
diff --git a/mm/migrate.c b/mm/migrate.c
index 6a1597c92261..8da61f900ad9 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -167,13 +167,62 @@ void putback_movable_pages(struct list_head *l)
 	}
 }
=20
+static bool try_to_unmap_clean(struct page_vma_mapped_walk *pvmw, struct p=
age *page)
+{
+	void *addr;
+	bool dirty;
+	pte_t newpte;
+
+	VM_BUG_ON_PAGE(PageCompound(page), page);
+	VM_BUG_ON_PAGE(!PageAnon(page), page);
+	VM_BUG_ON_PAGE(!PageLocked(page), page);
+	VM_BUG_ON_PAGE(pte_present(*pvmw->pte), page);
+
+	if (PageMlocked(page) || (pvmw->vma->vm_flags & VM_LOCKED))
+		return false;
+
+	/*
+	 * The pmd entry mapping the old thp was flushed and the pte mapping
+	 * this subpage has been non present. Therefore, this subpage is
+	 * inaccessible. We don't need to remap it if it contains only zeros.
+	 */
+	addr =3D kmap_local_page(page);
+	dirty =3D memchr_inv(addr, 0, PAGE_SIZE);
+	kunmap_local(addr);
+
+	if (dirty)
+		return false;
+
+	pte_clear_not_present_full(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, fa=
lse);
+
+	if (userfaultfd_armed(pvmw->vma)) {
+		newpte =3D pte_mkspecial(pfn_pte(page_to_pfn(ZERO_PAGE(pvmw->address)),
+					       pvmw->vma->vm_page_prot));
+		ptep_clear_flush(pvmw->vma, pvmw->address, pvmw->pte);
+		set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
+		dec_mm_counter(pvmw->vma->vm_mm, MM_ANONPAGES);
+		count_vm_event(THP_SPLIT_REMAP_READONLY_ZERO_PAGE);
+		return true;
+	}
+
+	dec_mm_counter(pvmw->vma->vm_mm, mm_counter(page));
+	count_vm_event(THP_SPLIT_UNMAP);
+	return true;
+}
+
+struct rmap_walk_arg {
+	struct folio *folio;
+	bool unmap_clean;
+};
+
 /*
  * Restore a potential migration pte to a working pte entry
  */
 static bool remove_migration_pte(struct folio *folio,
-		struct vm_area_struct *vma, unsigned long addr, void *old)
+		struct vm_area_struct *vma, unsigned long addr, void *arg)
 {
-	DEFINE_FOLIO_VMA_WALK(pvmw, old, vma, addr, PVMW_SYNC | PVMW_MIGRATION);
+	struct rmap_walk_arg *rmap_walk_arg =3D arg;
+	DEFINE_FOLIO_VMA_WALK(pvmw, rmap_walk_arg->folio, vma, addr, PVMW_SYNC | =
PVMW_MIGRATION);
=20
 	while (page_vma_mapped_walk(&pvmw)) {
 		rmap_t rmap_flags =3D RMAP_NONE;
@@ -196,6 +245,8 @@ static bool remove_migration_pte(struct folio *folio,
 			continue;
 		}
 #endif
+		if (rmap_walk_arg->unmap_clean && try_to_unmap_clean(&pvmw, new))
+			continue;
=20
 		folio_get(folio);
 		pte =3D pte_mkold(mk_pte(new, READ_ONCE(vma->vm_page_prot)));
@@ -267,13 +318,20 @@ static bool remove_migration_pte(struct folio *folio,
  * Get rid of all migration entries and replace them by
  * references to the indicated page.
  */
-void remove_migration_ptes(struct folio *src, struct folio *dst, bool lock=
ed)
+void remove_migration_ptes(struct folio *src, struct folio *dst, bool lock=
ed, bool unmap_clean)
 {
+	struct rmap_walk_arg rmap_walk_arg =3D {
+		.folio =3D src,
+		.unmap_clean =3D unmap_clean,
+	};
+
 	struct rmap_walk_control rwc =3D {
 		.rmap_one =3D remove_migration_pte,
-		.arg =3D src,
+		.arg =3D &rmap_walk_arg,
 	};
=20
+	VM_BUG_ON_FOLIO(unmap_clean && src !=3D dst, src);
+
 	if (locked)
 		rmap_walk_locked(dst, &rwc);
 	else
@@ -849,7 +907,7 @@ static int writeout(struct address_space *mapping, stru=
ct folio *folio)
 	 * At this point we know that the migration attempt cannot
 	 * be successful.
 	 */
-	remove_migration_ptes(folio, folio, false);
+	remove_migration_ptes(folio, folio, false, false);
=20
 	rc =3D mapping->a_ops->writepage(&folio->page, &wbc);
=20
@@ -1108,7 +1166,7 @@ static int __unmap_and_move(struct page *page, struct=
 page *newpage,
=20
 	if (page_was_mapped)
 		remove_migration_ptes(folio,
-			rc =3D=3D MIGRATEPAGE_SUCCESS ? dst : folio, false);
+			rc =3D=3D MIGRATEPAGE_SUCCESS ? dst : folio, false, false);
=20
 out_unlock_both:
 	unlock_page(newpage);
@@ -1318,7 +1376,7 @@ static int unmap_and_move_huge_page(new_page_t get_ne=
w_page,
=20
 	if (page_was_mapped)
 		remove_migration_ptes(src,
-			rc =3D=3D MIGRATEPAGE_SUCCESS ? dst : src, false);
+			rc =3D=3D MIGRATEPAGE_SUCCESS ? dst : src, false, false);
=20
 unlock_put_anon:
 	unlock_page(new_hpage);
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index dbf6c7a7a7c9..518aacc914c9 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -413,7 +413,7 @@ static void migrate_vma_unmap(struct migrate_vma *migra=
te)
 			continue;
=20
 		folio =3D page_folio(page);
-		remove_migration_ptes(folio, folio, false);
+		remove_migration_ptes(folio, folio, false, false);
=20
 		migrate->src[i] =3D 0;
 		folio_unlock(folio);
@@ -789,7 +789,7 @@ void migrate_vma_finalize(struct migrate_vma *migrate)
=20
 		src =3D page_folio(page);
 		dst =3D page_folio(newpage);
-		remove_migration_ptes(src, dst, false);
+		remove_migration_ptes(src, dst, false, false);
 		folio_unlock(src);
=20
 		if (is_zone_device_page(page))
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 90af9a8572f5..c8461b8db243 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1370,6 +1370,9 @@ const char * const vmstat_text[] =3D {
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 	"thp_split_pud",
 #endif
+	"thp_split_free",
+	"thp_split_unmap",
+	"thp_split_remap_readonly_zero_page",
 	"thp_zero_page_alloc",
 	"thp_zero_page_alloc_failed",
 	"thp_swpout",
diff --git a/tools/testing/selftests/vm/split_huge_page_test.c b/tools/test=
ing/selftests/vm/split_huge_page_test.c
index 6aa2b8253aed..2c669aadbfd0 100644
--- a/tools/testing/selftests/vm/split_huge_page_test.c
+++ b/tools/testing/selftests/vm/split_huge_page_test.c
@@ -16,6 +16,9 @@
 #include <sys/mount.h>
 #include <malloc.h>
 #include <stdbool.h>
+#include <sys/syscall.h> /* Definition of SYS_* constants */
+#include <linux/userfaultfd.h>
+#include <sys/ioctl.h>
 #include "vm_util.h"
=20
 uint64_t pagesize;
@@ -88,6 +91,113 @@ static void write_debugfs(const char *fmt, ...)
 	}
 }
=20
+static char *allocate_zero_filled_hugepage(size_t len)
+{
+	char *result;
+	size_t i;
+
+	result =3D memalign(pmd_pagesize, len);
+	if (!result) {
+		printf("Fail to allocate memory\n");
+		exit(EXIT_FAILURE);
+	}
+	madvise(result, len, MADV_HUGEPAGE);
+
+	for (i =3D 0; i < len; i++)
+		result[i] =3D (char)0;
+
+	return result;
+}
+
+static void verify_rss_anon_split_huge_page_all_zeroes(char *one_page, siz=
e_t len)
+{
+	uint64_t thp_size, rss_anon_before, rss_anon_after;
+	size_t i;
+
+	thp_size =3D check_huge(one_page);
+	if (!thp_size) {
+		printf("No THP is allocated\n");
+		exit(EXIT_FAILURE);
+	}
+
+	rss_anon_before =3D rss_anon();
+	if (!rss_anon_before) {
+		printf("No RssAnon is allocated before split\n");
+		exit(EXIT_FAILURE);
+	}
+	/* split all THPs */
+	write_debugfs(PID_FMT, getpid(), (uint64_t)one_page,
+		      (uint64_t)one_page + len);
+
+	for (i =3D 0; i < len; i++)
+		if (one_page[i] !=3D (char)0) {
+			printf("%ld byte corrupted\n", i);
+			exit(EXIT_FAILURE);
+		}
+
+	thp_size =3D check_huge(one_page);
+	if (thp_size) {
+		printf("Still %ld kB AnonHugePages not split\n", thp_size);
+		exit(EXIT_FAILURE);
+	}
+
+	rss_anon_after =3D rss_anon();
+	if (rss_anon_after >=3D rss_anon_before) {
+		printf("Incorrect RssAnon value. Before: %ld After: %ld\n",
+		       rss_anon_before, rss_anon_after);
+		exit(EXIT_FAILURE);
+	}
+}
+
+void split_pmd_zero_pages(void)
+{
+	char *one_page;
+	size_t len =3D 4 * pmd_pagesize;
+
+	one_page =3D allocate_zero_filled_hugepage(len);
+	verify_rss_anon_split_huge_page_all_zeroes(one_page, len);
+	printf("Split zero filled huge pages successful\n");
+	free(one_page);
+}
+
+void split_pmd_zero_pages_uffd(void)
+{
+	char *one_page;
+	size_t len =3D 4 * pmd_pagesize;
+	long uffd; /* userfaultfd file descriptor */
+	struct uffdio_api uffdio_api;
+	struct uffdio_register uffdio_register;
+
+	/* Create and enable userfaultfd object. */
+
+	uffd =3D syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+	if (uffd =3D=3D -1) {
+		perror("userfaultfd");
+		exit(1);
+	}
+
+	uffdio_api.api =3D UFFD_API;
+	uffdio_api.features =3D 0;
+	if (ioctl(uffd, UFFDIO_API, &uffdio_api) =3D=3D -1) {
+		perror("ioctl-UFFDIO_API");
+		exit(1);
+	}
+
+	one_page =3D allocate_zero_filled_hugepage(len);
+
+	uffdio_register.range.start =3D (unsigned long)one_page;
+	uffdio_register.range.len =3D len;
+	uffdio_register.mode =3D UFFDIO_REGISTER_MODE_WP;
+	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) =3D=3D -1) {
+		perror("ioctl-UFFDIO_REGISTER");
+		exit(1);
+	}
+
+	verify_rss_anon_split_huge_page_all_zeroes(one_page, len);
+	printf("Split zero filled huge pages with uffd successful\n");
+	free(one_page);
+}
+
 void split_pmd_thp(void)
 {
 	char *one_page;
@@ -123,7 +233,6 @@ void split_pmd_thp(void)
 			exit(EXIT_FAILURE);
 		}
=20
-
 	thp_size =3D check_huge(one_page);
 	if (thp_size) {
 		printf("Still %ld kB AnonHugePages not split\n", thp_size);
@@ -305,6 +414,8 @@ int main(int argc, char **argv)
 	pageshift =3D ffs(pagesize) - 1;
 	pmd_pagesize =3D read_pmd_pagesize();
=20
+	split_pmd_zero_pages();
+	split_pmd_zero_pages_uffd();
 	split_pmd_thp();
 	split_pte_mapped_thp();
 	split_file_backed_thp();
diff --git a/tools/testing/selftests/vm/vm_util.c b/tools/testing/selftests=
/vm/vm_util.c
index b58ab11a7a30..c6a785a67fc9 100644
--- a/tools/testing/selftests/vm/vm_util.c
+++ b/tools/testing/selftests/vm/vm_util.c
@@ -6,6 +6,7 @@
=20
 #define PMD_SIZE_FILE_PATH "/sys/kernel/mm/transparent_hugepage/hpage_pmd_=
size"
 #define SMAP_FILE_PATH "/proc/self/smaps"
+#define STATUS_FILE_PATH "/proc/self/status"
 #define MAX_LINE_LENGTH 500
=20
 uint64_t pagemap_get_entry(int fd, char *start)
@@ -72,6 +73,28 @@ uint64_t read_pmd_pagesize(void)
 	return strtoul(buf, NULL, 10);
 }
=20
+uint64_t rss_anon(void)
+{
+	uint64_t rss_anon =3D 0;
+	int ret;
+	FILE *fp;
+	char buffer[MAX_LINE_LENGTH];
+
+	fp =3D fopen(STATUS_FILE_PATH, "r");
+	if (!fp)
+		ksft_exit_fail_msg("%s: Failed to open file %s\n", __func__, STATUS_FILE=
_PATH);
+
+	if (!check_for_pattern(fp, "RssAnon:", buffer))
+		goto err_out;
+
+	if (sscanf(buffer, "RssAnon:%10ld kB", &rss_anon) !=3D 1)
+		ksft_exit_fail_msg("Reading status error\n");
+
+err_out:
+	fclose(fp);
+	return rss_anon;
+}
+
 uint64_t check_huge(void *addr)
 {
 	uint64_t thp =3D 0;
diff --git a/tools/testing/selftests/vm/vm_util.h b/tools/testing/selftests=
/vm/vm_util.h
index 2e512bd57ae1..00b92ccef20d 100644
--- a/tools/testing/selftests/vm/vm_util.h
+++ b/tools/testing/selftests/vm/vm_util.h
@@ -6,4 +6,5 @@ uint64_t pagemap_get_entry(int fd, char *start);
 bool pagemap_is_softdirty(int fd, char *start);
 void clear_softdirty(void);
 uint64_t read_pmd_pagesize(void);
+uint64_t rss_anon(void);
 uint64_t check_huge(void *addr);
--=20
2.30.2

