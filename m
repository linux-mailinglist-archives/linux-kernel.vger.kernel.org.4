Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27291624864
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiKJRae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKJRaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:30:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89F6105
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668101373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xy6itbsEAp0E66lgRcrG4kD1bhigD79qgAawuv5aRhg=;
        b=ieozxaHqeAJ7lPcl0HaedH/+ECoIl8MFRCNtb+Vhq3f53qhMj82HTeVH9283PPLj/9sasd
        aICgSl1muAj1uLBJO4jJf0YnvKe3ExZbBHkGbnny/P1THWLd+2psEw1sR2JbrGccOd1qcX
        rcuc5mdbtXuwaCv9xcE9oK/IuHr6Iv4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-62-S662UmyMO0Gwj1aXjIHGRg-1; Thu, 10 Nov 2022 12:29:30 -0500
X-MC-Unique: S662UmyMO0Gwj1aXjIHGRg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 238E33C11042;
        Thu, 10 Nov 2022 17:29:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64B6C4A9256;
        Thu, 10 Nov 2022 17:29:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] mm: Make some folio and page function arguments const and use
 bool
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org
Cc:     dhowells@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 10 Nov 2022 17:29:28 +0000
Message-ID: <166810136860.3462948.16794726061248137027.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark the folio* argument to some of the folio accessor functions as a const
pointer and similarly make some page* arguments to some page functions
const.

Also switch the return values to bool rather than int where the test inside
produces a bool.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/mm.h         |   20 ++++-----
 include/linux/page-flags.h |   99 ++++++++++++++++++++++++--------------------
 mm/hugetlb.c               |    8 ++--
 mm/page_alloc.c            |    4 +-
 4 files changed, 70 insertions(+), 61 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7a7a287818ad..a069f6f70aed 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -711,7 +711,7 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
 struct mmu_gather;
 struct inode;
 
-static inline unsigned int compound_order(struct page *page)
+static inline unsigned int compound_order(const struct page *page)
 {
 	if (!PageHead(page))
 		return 0;
@@ -727,7 +727,7 @@ static inline unsigned int compound_order(struct page *page)
  *
  * Return: The order of the folio.
  */
-static inline unsigned int folio_order(struct folio *folio)
+static inline unsigned int folio_order(const struct folio *folio)
 {
 	if (!folio_test_large(folio))
 		return 0;
@@ -945,7 +945,7 @@ static inline void set_compound_order(struct page *page, unsigned int order)
 }
 
 /* Returns the number of pages in this potentially compound page. */
-static inline unsigned long compound_nr(struct page *page)
+static inline unsigned long compound_nr(const struct page *page)
 {
 	if (!PageHead(page))
 		return 1;
@@ -1519,7 +1519,7 @@ static inline unsigned long page_to_section(const struct page *page)
  *
  * Return: The Page Frame Number of the first page in the folio.
  */
-static inline unsigned long folio_pfn(struct folio *folio)
+static inline unsigned long folio_pfn(const struct folio *folio)
 {
 	return page_to_pfn(&folio->page);
 }
@@ -1600,7 +1600,7 @@ static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
 
 /* MIGRATE_CMA and ZONE_MOVABLE do not allow pin pages */
 #ifdef CONFIG_MIGRATION
-static inline bool is_longterm_pinnable_page(struct page *page)
+static inline bool is_longterm_pinnable_page(const struct page *page)
 {
 #ifdef CONFIG_CMA
 	int mt = get_pageblock_migratetype(page);
@@ -1620,13 +1620,13 @@ static inline bool is_longterm_pinnable_page(struct page *page)
 	return !is_zone_movable_page(page);
 }
 #else
-static inline bool is_longterm_pinnable_page(struct page *page)
+static inline bool is_longterm_pinnable_page(const struct page *page)
 {
 	return true;
 }
 #endif
 
-static inline bool folio_is_longterm_pinnable(struct folio *folio)
+static inline bool folio_is_longterm_pinnable(const struct folio *folio)
 {
 	return is_longterm_pinnable_page(&folio->page);
 }
@@ -1659,7 +1659,7 @@ static inline void set_page_links(struct page *page, enum zone_type zone,
  *
  * Return: A positive power of two.
  */
-static inline long folio_nr_pages(struct folio *folio)
+static inline long folio_nr_pages(const struct folio *folio)
 {
 	if (!folio_test_large(folio))
 		return 1;
@@ -1701,7 +1701,7 @@ static inline struct folio *folio_next(struct folio *folio)
  * it from being split.  It is not necessary for the folio to be locked.
  * Return: The base-2 logarithm of the size of this folio.
  */
-static inline unsigned int folio_shift(struct folio *folio)
+static inline unsigned int folio_shift(const struct folio *folio)
 {
 	return PAGE_SHIFT + folio_order(folio);
 }
@@ -1714,7 +1714,7 @@ static inline unsigned int folio_shift(struct folio *folio)
  * it from being split.  It is not necessary for the folio to be locked.
  * Return: The number of bytes in this folio.
  */
-static inline size_t folio_size(struct folio *folio)
+static inline size_t folio_size(const struct folio *folio)
 {
 	return PAGE_SIZE << folio_order(folio);
 }
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 0b0ae5084e60..ee6604fcc1d1 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -243,7 +243,7 @@ static inline const struct page *page_fixed_fake_head(const struct page *page)
 }
 #endif
 
-static __always_inline int page_is_fake_head(struct page *page)
+static __always_inline bool page_is_fake_head(const struct page *page)
 {
 	return page_fixed_fake_head(page) != page;
 }
@@ -287,19 +287,19 @@ static inline unsigned long _compound_head(const struct page *page)
  */
 #define folio_page(folio, n)	nth_page(&(folio)->page, n)
 
-static __always_inline int PageTail(struct page *page)
+static __always_inline bool PageTail(const struct page *page)
 {
 	return READ_ONCE(page->compound_head) & 1 || page_is_fake_head(page);
 }
 
-static __always_inline int PageCompound(struct page *page)
+static __always_inline bool PageCompound(const struct page *page)
 {
 	return test_bit(PG_head, &page->flags) ||
 	       READ_ONCE(page->compound_head) & 1;
 }
 
 #define	PAGE_POISON_PATTERN	-1l
-static inline int PagePoisoned(const struct page *page)
+static inline bool PagePoisoned(const struct page *page)
 {
 	return READ_ONCE(page->flags) == PAGE_POISON_PATTERN;
 }
@@ -312,6 +312,15 @@ static inline void page_init_poison(struct page *page, size_t size)
 }
 #endif
 
+static const unsigned long *const_folio_flags(const struct folio *folio, unsigned n)
+{
+	const struct page *page = &folio->page;
+
+	VM_BUG_ON_PGFLAGS(PageTail(page), page);
+	VM_BUG_ON_PGFLAGS(n > 0 && !test_bit(PG_head, &page->flags), page);
+	return &page[n].flags;
+}
+
 static unsigned long *folio_flags(struct folio *folio, unsigned n)
 {
 	struct page *page = &folio->page;
@@ -377,9 +386,9 @@ static unsigned long *folio_flags(struct folio *folio, unsigned n)
  * Macros to create function definitions for page flags
  */
 #define TESTPAGEFLAG(uname, lname, policy)				\
-static __always_inline bool folio_test_##lname(struct folio *folio)	\
-{ return test_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); }	\
-static __always_inline int Page##uname(struct page *page)		\
+static __always_inline bool folio_test_##lname(const struct folio *folio) \
+{ return test_bit(PG_##lname, const_folio_flags(folio, FOLIO_##policy)); } \
+static __always_inline bool Page##uname(const struct page *page)	\
 { return test_bit(PG_##lname, &policy(page, 0)->flags); }
 
 #define SETPAGEFLAG(uname, lname, policy)				\
@@ -414,14 +423,14 @@ static __always_inline void __ClearPage##uname(struct page *page)	\
 static __always_inline							\
 bool folio_test_set_##lname(struct folio *folio)			\
 { return test_and_set_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); } \
-static __always_inline int TestSetPage##uname(struct page *page)	\
+static __always_inline bool TestSetPage##uname(struct page *page)	\
 { return test_and_set_bit(PG_##lname, &policy(page, 1)->flags); }
 
 #define TESTCLEARFLAG(uname, lname, policy)				\
 static __always_inline							\
 bool folio_test_clear_##lname(struct folio *folio)			\
 { return test_and_clear_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); } \
-static __always_inline int TestClearPage##uname(struct page *page)	\
+static __always_inline bool TestClearPage##uname(struct page *page)	\
 { return test_and_clear_bit(PG_##lname, &policy(page, 1)->flags); }
 
 #define PAGEFLAG(uname, lname, policy)					\
@@ -440,7 +449,7 @@ static __always_inline int TestClearPage##uname(struct page *page)	\
 
 #define TESTPAGEFLAG_FALSE(uname, lname)				\
 static inline bool folio_test_##lname(const struct folio *folio) { return false; } \
-static inline int Page##uname(const struct page *page) { return 0; }
+static inline bool Page##uname(const struct page *page) { return false; }
 
 #define SETPAGEFLAG_NOOP(uname, lname)					\
 static inline void folio_set_##lname(struct folio *folio) { }		\
@@ -456,13 +465,13 @@ static inline void __ClearPage##uname(struct page *page) {  }
 
 #define TESTSETFLAG_FALSE(uname, lname)					\
 static inline bool folio_test_set_##lname(struct folio *folio)		\
-{ return 0; }								\
-static inline int TestSetPage##uname(struct page *page) { return 0; }
+{ return false; }							\
+static inline bool TestSetPage##uname(struct page *page) { return false; }
 
 #define TESTCLEARFLAG_FALSE(uname, lname)				\
 static inline bool folio_test_clear_##lname(struct folio *folio)	\
-{ return 0; }								\
-static inline int TestClearPage##uname(struct page *page) { return 0; }
+{ return false; }							\
+static inline bool TestClearPage##uname(struct page *page) { return false; }
 
 #define PAGEFLAG_FALSE(uname, lname) TESTPAGEFLAG_FALSE(uname, lname)	\
 	SETPAGEFLAG_NOOP(uname, lname) CLEARPAGEFLAG_NOOP(uname, lname)
@@ -538,13 +547,13 @@ PAGEFLAG_FALSE(HighMem, highmem)
 #endif
 
 #ifdef CONFIG_SWAP
-static __always_inline bool folio_test_swapcache(struct folio *folio)
+static __always_inline bool folio_test_swapcache(const struct folio *folio)
 {
 	return folio_test_swapbacked(folio) &&
-			test_bit(PG_swapcache, folio_flags(folio, 0));
+			test_bit(PG_swapcache, const_folio_flags(folio, 0));
 }
 
-static __always_inline bool PageSwapCache(struct page *page)
+static __always_inline bool PageSwapCache(const struct page *page)
 {
 	return folio_test_swapcache(page_folio(page));
 }
@@ -643,22 +652,22 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
  */
 #define PAGE_MAPPING_DAX_COW	0x1
 
-static __always_inline bool folio_mapping_flags(struct folio *folio)
+static __always_inline bool folio_mapping_flags(const struct folio *folio)
 {
 	return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) != 0;
 }
 
-static __always_inline int PageMappingFlags(struct page *page)
+static __always_inline bool PageMappingFlags(const struct page *page)
 {
 	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) != 0;
 }
 
-static __always_inline bool folio_test_anon(struct folio *folio)
+static __always_inline bool folio_test_anon(const struct folio *folio)
 {
 	return ((unsigned long)folio->mapping & PAGE_MAPPING_ANON) != 0;
 }
 
-static __always_inline bool PageAnon(struct page *page)
+static __always_inline bool PageAnon(const struct page *page)
 {
 	return folio_test_anon(page_folio(page));
 }
@@ -669,7 +678,7 @@ static __always_inline bool __folio_test_movable(const struct folio *folio)
 			PAGE_MAPPING_MOVABLE;
 }
 
-static __always_inline int __PageMovable(struct page *page)
+static __always_inline bool __PageMovable(const struct page *page)
 {
 	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) ==
 				PAGE_MAPPING_MOVABLE;
@@ -682,13 +691,13 @@ static __always_inline int __PageMovable(struct page *page)
  * is found in VM_MERGEABLE vmas.  It's a PageAnon page, pointing not to any
  * anon_vma, but to that page's node of the stable tree.
  */
-static __always_inline bool folio_test_ksm(struct folio *folio)
+static __always_inline bool folio_test_ksm(const struct folio *folio)
 {
 	return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) ==
 				PAGE_MAPPING_KSM;
 }
 
-static __always_inline bool PageKsm(struct page *page)
+static __always_inline bool PageKsm(const struct page *page)
 {
 	return folio_test_ksm(page_folio(page));
 }
@@ -708,9 +717,9 @@ u64 stable_page_flags(struct page *page);
  * some of the bytes in it may be; see the is_partially_uptodate()
  * address_space operation.
  */
-static inline bool folio_test_uptodate(struct folio *folio)
+static inline bool folio_test_uptodate(const struct folio *folio)
 {
-	bool ret = test_bit(PG_uptodate, folio_flags(folio, 0));
+	bool ret = test_bit(PG_uptodate, const_folio_flags(folio, 0));
 	/*
 	 * Must ensure that the data we read out of the folio is loaded
 	 * _after_ we've loaded folio->flags to check the uptodate bit.
@@ -725,7 +734,7 @@ static inline bool folio_test_uptodate(struct folio *folio)
 	return ret;
 }
 
-static inline int PageUptodate(struct page *page)
+static inline bool PageUptodate(const struct page *page)
 {
 	return folio_test_uptodate(page_folio(page));
 }
@@ -777,12 +786,12 @@ static inline bool test_set_page_writeback(struct page *page)
 	return set_page_writeback(page);
 }
 
-static __always_inline bool folio_test_head(struct folio *folio)
+static __always_inline bool folio_test_head(const struct folio *folio)
 {
-	return test_bit(PG_head, folio_flags(folio, FOLIO_PF_ANY));
+	return test_bit(PG_head, const_folio_flags(folio, FOLIO_PF_ANY));
 }
 
-static __always_inline int PageHead(struct page *page)
+static __always_inline bool PageHead(const struct page *page)
 {
 	PF_POISONED_CHECK(page);
 	return test_bit(PG_head, &page->flags) && !page_is_fake_head(page);
@@ -798,7 +807,7 @@ CLEARPAGEFLAG(Head, head, PF_ANY)
  *
  * Return: True if the folio is larger than one page.
  */
-static inline bool folio_test_large(struct folio *folio)
+static inline bool folio_test_large(const struct folio *folio)
 {
 	return folio_test_head(folio);
 }
@@ -824,9 +833,9 @@ static inline void ClearPageCompound(struct page *page)
 #define PG_head_mask ((1UL << PG_head))
 
 #ifdef CONFIG_HUGETLB_PAGE
-int PageHuge(struct page *page);
-int PageHeadHuge(struct page *page);
-static inline bool folio_test_hugetlb(struct folio *folio)
+bool PageHuge(const struct page *page);
+bool PageHeadHuge(const struct page *page);
+static inline bool folio_test_hugetlb(const struct folio *folio)
 {
 	return PageHeadHuge(&folio->page);
 }
@@ -844,13 +853,13 @@ TESTPAGEFLAG_FALSE(HeadHuge, headhuge)
  * hugetlbfs pages, but not normal pages. PageTransHuge() can only be
  * called only in the core VM paths where hugetlbfs pages can't exist.
  */
-static inline int PageTransHuge(struct page *page)
+static inline bool PageTransHuge(const struct page *page)
 {
 	VM_BUG_ON_PAGE(PageTail(page), page);
 	return PageHead(page);
 }
 
-static inline bool folio_test_transhuge(struct folio *folio)
+static inline bool folio_test_transhuge(const struct folio *folio)
 {
 	return folio_test_head(folio);
 }
@@ -860,7 +869,7 @@ static inline bool folio_test_transhuge(struct folio *folio)
  * and hugetlbfs pages, so it should only be called when it's known
  * that hugetlbfs pages aren't involved.
  */
-static inline int PageTransCompound(struct page *page)
+static inline bool PageTransCompound(const struct page *page)
 {
 	return PageCompound(page);
 }
@@ -870,7 +879,7 @@ static inline int PageTransCompound(struct page *page)
  * and hugetlbfs pages, so it should only be called when it's known
  * that hugetlbfs pages aren't involved.
  */
-static inline int PageTransTail(struct page *page)
+static inline bool PageTransTail(const struct page *page)
 {
 	return PageTail(page);
 }
@@ -918,7 +927,7 @@ PAGEFLAG_FALSE(HasHWPoisoned, has_hwpoisoned)
  * best effort only and inherently racy: there is no way to synchronize with
  * failing hardware.
  */
-static inline bool is_page_hwpoison(struct page *page)
+static inline bool is_page_hwpoison(const struct page *page)
 {
 	if (PageHWPoison(page))
 		return true;
@@ -945,13 +954,13 @@ static inline bool is_page_hwpoison(struct page *page)
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
 
-static inline int page_has_type(struct page *page)
+static inline bool page_has_type(const struct page *page)
 {
 	return (int)page->page_type < PAGE_MAPCOUNT_RESERVE;
 }
 
 #define PAGE_TYPE_OPS(uname, lname)					\
-static __always_inline int Page##uname(struct page *page)		\
+static __always_inline bool Page##uname(const struct page *page)	\
 {									\
 	return PageType(page, PG_##lname);				\
 }									\
@@ -1011,11 +1020,11 @@ PAGE_TYPE_OPS(Table, table)
  */
 PAGE_TYPE_OPS(Guard, guard)
 
-extern bool is_free_buddy_page(struct page *page);
+extern bool is_free_buddy_page(const struct page *page);
 
 PAGEFLAG(Isolated, isolated, PF_ANY);
 
-static __always_inline int PageAnonExclusive(struct page *page)
+static __always_inline bool PageAnonExclusive(const struct page *page)
 {
 	VM_BUG_ON_PGFLAGS(!PageAnon(page), page);
 	VM_BUG_ON_PGFLAGS(PageHuge(page) && !PageHead(page), page);
@@ -1080,12 +1089,12 @@ static __always_inline void __ClearPageAnonExclusive(struct page *page)
  * Determine if a page has private stuff, indicating that release routines
  * should be invoked upon it.
  */
-static inline int page_has_private(struct page *page)
+static inline bool page_has_private(const struct page *page)
 {
 	return !!(page->flags & PAGE_FLAGS_PRIVATE);
 }
 
-static inline bool folio_has_private(struct folio *folio)
+static inline bool folio_has_private(const struct folio *folio)
 {
 	return page_has_private(&folio->page);
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 546df97c31e4..ac8bed42f276 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1886,10 +1886,10 @@ static bool prep_compound_gigantic_page_for_demote(struct page *page,
  * transparent huge pages.  See the PageTransHuge() documentation for more
  * details.
  */
-int PageHuge(struct page *page)
+bool PageHuge(const struct page *page)
 {
 	if (!PageCompound(page))
-		return 0;
+		return false;
 
 	page = compound_head(page);
 	return page[1].compound_dtor == HUGETLB_PAGE_DTOR;
@@ -1900,10 +1900,10 @@ EXPORT_SYMBOL_GPL(PageHuge);
  * PageHeadHuge() only returns true for hugetlbfs head page, but not for
  * normal or transparent huge pages.
  */
-int PageHeadHuge(struct page *page_head)
+bool PageHeadHuge(const struct page *page_head)
 {
 	if (!PageHead(page_head))
-		return 0;
+		return false;
 
 	return page_head[1].compound_dtor == HUGETLB_PAGE_DTOR;
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 218b28ee49ed..81ccca8364bb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9586,13 +9586,13 @@ void __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
 /*
  * This function returns a stable result only if called under zone lock.
  */
-bool is_free_buddy_page(struct page *page)
+bool is_free_buddy_page(const struct page *page)
 {
 	unsigned long pfn = page_to_pfn(page);
 	unsigned int order;
 
 	for (order = 0; order < MAX_ORDER; order++) {
-		struct page *page_head = page - (pfn & ((1 << order) - 1));
+		const struct page *page_head = page - (pfn & ((1 << order) - 1));
 
 		if (PageBuddy(page_head) &&
 		    buddy_order_unsafe(page_head) >= order)


