Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8936A6173DC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 02:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiKCBsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 21:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKCBsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 21:48:51 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBF511458
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 18:48:49 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id l9so300040qkk.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 18:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lFObYSeYZinOp60nCg2L3aJtb9foCl68/mYnD6Lzi6g=;
        b=lcUcFgxRrwew3Oon/jVlgeHO+sKO2Ca2bCA9HEge6ww0BiKdo3ZObvfJ+IP9jYF0mQ
         NhA8NlbHoksdLMF/9A3a3l2GauCYwRbyZorbinDwoVCKGHrITlYMhjAW3rTLFEdLTQr5
         0O4o4HuxspV3llc/da5EQEWR1/qIIxMS94nJcdb0d1wWmSjzwag8z9Bxetq95Kes1Msa
         vRxJ/u2jmBRiSYEX/jn2FO6i65KAUkYHC9gcdHnft0dkCSuet3hRdGwdeP7Dl4xa6w3+
         NS2tantoXseSV4YDHKkbc7A0xeDgW8aG+jAcZZ0sSJ3jOLAbzgXi8zykH0xIpwq0ftGG
         kpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lFObYSeYZinOp60nCg2L3aJtb9foCl68/mYnD6Lzi6g=;
        b=XYnzVm8XYrtFlq6SjLK1BT9dbRXgudCGrK78UcinrZp24Qbi1egViJsGwNlEM1j1Bo
         REA+PKdceB+OZWh8e0UWztSSLBitcbuEESnCGfirqJnN3qAQDJroNY+/w393k2qSqv4J
         Y1BpisyQ6+g5rKRqqU+vH94lv8PcdIuc3dZOZ243LVZ+KwZ7G0DG9kmuHGJNq4Mlot8y
         /516Njcwv5R8cRqTbYS4jf6SAOVIvFlG+VeR7gKy6+FuM55W7lezWYZvDTLSv4cUbGbX
         VsEdZP269W1lWsX8SJbDVjflsPQ8VwB/neyp/fIHacZyEBJHJS0FaE+mtFHzbr/C+DCL
         BxKQ==
X-Gm-Message-State: ACrzQf2pqvEHs7RJOX+rugKRryg1xuMGJVVbJchVCM6Pxf23/6tPmtvT
        PsEpu/hRNbBQQquO0HMGHWVdOA==
X-Google-Smtp-Source: AMsMyM6r1BIrwQArKW07MgHk9/bQhL+BXmYLJYlMn0qhPu4IbSG6u6T6eBwuUucLX9+Apz/5e3gAOg==
X-Received: by 2002:a37:6945:0:b0:6f4:ae0f:648b with SMTP id e66-20020a376945000000b006f4ae0f648bmr19914995qkc.329.1667440128767;
        Wed, 02 Nov 2022 18:48:48 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f11-20020ac8498b000000b00399ad646794sm7554072qtq.41.2022.11.02.18.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 18:48:48 -0700 (PDT)
Date:   Wed, 2 Nov 2022 18:48:45 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        James Houghton <jthoughton@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 1/3] mm,hugetlb: use folio fields in second tail page
In-Reply-To: <5f52de70-975-e94f-f141-543765736181@google.com>
Message-ID: <3818cc9a-9999-d064-d778-9c94c5911e6@google.com>
References: <5f52de70-975-e94f-f141-543765736181@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to declare one more int in the first tail of a compound page:
that first tail page being valuable property, since every compound page
has a first tail, but perhaps no more than that.

No problem on 64-bit: there is already space for it.  No problem with
32-bit THPs: 5.18 commit 5232c63f46fd ("mm: Make compound_pincount always
available") kindly cleared the space for it, apparently not realizing
that only 64-bit architectures enable CONFIG_THP_SWAP (whose use of tail
page->private might conflict) - but make sure of that in its Kconfig.

But hugetlb pages use tail page->private of the first tail page for a
subpool pointer, which will conflict; and they also use page->private
of the 2nd, 3rd and 4th tails.

Undo "mm: add private field of first tail to struct page and struct
folio"'s recent addition of private_1 to the folio tail: instead add
hugetlb_subpool, hugetlb_cgroup, hugetlb_cgroup_rsvd, hugetlb_hwpoison
to a second tail page of the folio: THP has long been using several
fields of that tail, so make better use of it for hugetlb too.
This is not how a generic folio should be declared in future,
but it is an effective transitional way to make use of it.

Delete the SUBPAGE_INDEX stuff, but keep __NR_USED_SUBPAGE: now 3.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/hugetlb.h        | 23 +++--------
 include/linux/hugetlb_cgroup.h | 31 +++++----------
 include/linux/mm_types.h       | 72 ++++++++++++++++++++++------------
 mm/Kconfig                     |  2 +-
 mm/memory-failure.c            |  5 +--
 5 files changed, 65 insertions(+), 68 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 65ea34022aa2..03ecf1c5e46f 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -33,22 +33,9 @@ typedef struct { unsigned long pd; } hugepd_t;
 /*
  * For HugeTLB page, there are more metadata to save in the struct page. But
  * the head struct page cannot meet our needs, so we have to abuse other tail
- * struct page to store the metadata. In order to avoid conflicts caused by
- * subsequent use of more tail struct pages, we gather these discrete indexes
- * of tail struct page here.
+ * struct page to store the metadata.
  */
-enum {
-	SUBPAGE_INDEX_SUBPOOL = 1,	/* reuse page->private */
-#ifdef CONFIG_CGROUP_HUGETLB
-	SUBPAGE_INDEX_CGROUP,		/* reuse page->private */
-	SUBPAGE_INDEX_CGROUP_RSVD,	/* reuse page->private */
-	__MAX_CGROUP_SUBPAGE_INDEX = SUBPAGE_INDEX_CGROUP_RSVD,
-#endif
-#ifdef CONFIG_MEMORY_FAILURE
-	SUBPAGE_INDEX_HWPOISON,
-#endif
-	__NR_USED_SUBPAGE,
-};
+#define __NR_USED_SUBPAGE 3
 
 struct hugepage_subpool {
 	spinlock_t lock;
@@ -722,11 +709,11 @@ extern unsigned int default_hstate_idx;
 
 static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio)
 {
-	return (void *)folio_get_private_1(folio);
+	return folio->_hugetlb_subpool;
 }
 
 /*
- * hugetlb page subpool pointer located in hpage[1].private
+ * hugetlb page subpool pointer located in hpage[2].hugetlb_subpool
  */
 static inline struct hugepage_subpool *hugetlb_page_subpool(struct page *hpage)
 {
@@ -736,7 +723,7 @@ static inline struct hugepage_subpool *hugetlb_page_subpool(struct page *hpage)
 static inline void hugetlb_set_folio_subpool(struct folio *folio,
 					struct hugepage_subpool *subpool)
 {
-	folio_set_private_1(folio, (unsigned long)subpool);
+	folio->_hugetlb_subpool = subpool;
 }
 
 static inline void hugetlb_set_page_subpool(struct page *hpage,
diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index c70f92fe493e..f706626a8063 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -24,12 +24,10 @@ struct file_region;
 #ifdef CONFIG_CGROUP_HUGETLB
 /*
  * Minimum page order trackable by hugetlb cgroup.
- * At least 4 pages are necessary for all the tracking information.
- * The second tail page (hpage[SUBPAGE_INDEX_CGROUP]) is the fault
- * usage cgroup. The third tail page (hpage[SUBPAGE_INDEX_CGROUP_RSVD])
- * is the reservation usage cgroup.
+ * At least 3 pages are necessary for all the tracking information.
+ * The second tail page contains all of the hugetlb-specific fields.
  */
-#define HUGETLB_CGROUP_MIN_ORDER order_base_2(__MAX_CGROUP_SUBPAGE_INDEX + 1)
+#define HUGETLB_CGROUP_MIN_ORDER order_base_2(__NR_USED_SUBPAGE)
 
 enum hugetlb_memory_event {
 	HUGETLB_MAX,
@@ -69,21 +67,13 @@ struct hugetlb_cgroup {
 static inline struct hugetlb_cgroup *
 __hugetlb_cgroup_from_folio(struct folio *folio, bool rsvd)
 {
-	struct page *tail;
-
 	VM_BUG_ON_FOLIO(!folio_test_hugetlb(folio), folio);
 	if (folio_order(folio) < HUGETLB_CGROUP_MIN_ORDER)
 		return NULL;
-
-	if (rsvd) {
-		tail = folio_page(folio, SUBPAGE_INDEX_CGROUP_RSVD);
-		return (void *)page_private(tail);
-	}
-
-	else {
-		tail = folio_page(folio, SUBPAGE_INDEX_CGROUP);
-		return (void *)page_private(tail);
-	}
+	if (rsvd)
+		return folio->_hugetlb_cgroup_rsvd;
+	else
+		return folio->_hugetlb_cgroup;
 }
 
 static inline struct hugetlb_cgroup *hugetlb_cgroup_from_folio(struct folio *folio)
@@ -101,15 +91,12 @@ static inline void __set_hugetlb_cgroup(struct folio *folio,
 				       struct hugetlb_cgroup *h_cg, bool rsvd)
 {
 	VM_BUG_ON_FOLIO(!folio_test_hugetlb(folio), folio);
-
 	if (folio_order(folio) < HUGETLB_CGROUP_MIN_ORDER)
 		return;
 	if (rsvd)
-		set_page_private(folio_page(folio, SUBPAGE_INDEX_CGROUP_RSVD),
-				 (unsigned long)h_cg);
+		folio->_hugetlb_cgroup_rsvd = h_cg;
 	else
-		set_page_private(folio_page(folio, SUBPAGE_INDEX_CGROUP),
-				 (unsigned long)h_cg);
+		folio->_hugetlb_cgroup = h_cg;
 }
 
 static inline void set_hugetlb_cgroup(struct folio *folio,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 834022721bc6..728eb6089bba 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -145,15 +145,22 @@ struct page {
 			atomic_t compound_pincount;
 #ifdef CONFIG_64BIT
 			unsigned int compound_nr; /* 1 << compound_order */
-			unsigned long _private_1;
 #endif
 		};
-		struct {	/* Second tail page of compound page */
+		struct {	/* Second tail page of transparent huge page */
 			unsigned long _compound_pad_1;	/* compound_head */
 			unsigned long _compound_pad_2;
 			/* For both global and memcg */
 			struct list_head deferred_list;
 		};
+		struct {	/* Second tail page of hugetlb page */
+			unsigned long _hugetlb_pad_1;	/* compound_head */
+			void *hugetlb_subpool;
+			void *hugetlb_cgroup;
+			void *hugetlb_cgroup_rsvd;
+			void *hugetlb_hwpoison;
+			/* No more space on 32-bit: use third tail if more */
+		};
 		struct {	/* Page table pages */
 			unsigned long _pt_pad_1;	/* compound_head */
 			pgtable_t pmd_huge_pte; /* protected by page->ptl */
@@ -260,13 +267,16 @@ struct page {
  *    to find how many references there are to this folio.
  * @memcg_data: Memory Control Group data.
  * @_flags_1: For large folios, additional page flags.
- * @__head: Points to the folio.  Do not use.
+ * @_head_1: Points to the folio.  Do not use.
  * @_folio_dtor: Which destructor to use for this folio.
  * @_folio_order: Do not use directly, call folio_order().
  * @_total_mapcount: Do not use directly, call folio_entire_mapcount().
  * @_pincount: Do not use directly, call folio_maybe_dma_pinned().
  * @_folio_nr_pages: Do not use directly, call folio_nr_pages().
- * @_private_1: Do not use directly, call folio_get_private_1().
+ * @_hugetlb_subpool: Do not use directly, use accessor in hugetlb.h.
+ * @_hugetlb_cgroup: Do not use directly, use accessor in hugetlb_cgroup.h.
+ * @_hugetlb_cgroup_rsvd: Do not use directly, use accessor in hugetlb_cgroup.h.
+ * @_hugetlb_hwpoison: Do not use directly, call raw_hwp_list_head().
  *
  * A folio is a physically, virtually and logically contiguous set
  * of bytes.  It is a power-of-two in size, and it is aligned to that
@@ -305,16 +315,31 @@ struct folio {
 		};
 		struct page page;
 	};
-	unsigned long _flags_1;
-	unsigned long __head;
-	unsigned char _folio_dtor;
-	unsigned char _folio_order;
-	atomic_t _total_mapcount;
-	atomic_t _pincount;
+	union {
+		struct {
+			unsigned long _flags_1;
+			unsigned long _head_1;
+			unsigned char _folio_dtor;
+			unsigned char _folio_order;
+			atomic_t _total_mapcount;
+			atomic_t _pincount;
 #ifdef CONFIG_64BIT
-	unsigned int _folio_nr_pages;
+			unsigned int _folio_nr_pages;
 #endif
-	unsigned long _private_1;
+		};
+		struct page page_1;
+	};
+	union {
+		struct {
+			unsigned long _flags_2;
+			unsigned long _head_2;
+			void *_hugetlb_subpool;
+			void *_hugetlb_cgroup;
+			void *_hugetlb_cgroup_rsvd;
+			void *_hugetlb_hwpoison;
+		};
+		struct page page_2;
+	};
 };
 
 #define FOLIO_MATCH(pg, fl)						\
@@ -335,16 +360,25 @@ FOLIO_MATCH(memcg_data, memcg_data);
 	static_assert(offsetof(struct folio, fl) ==			\
 			offsetof(struct page, pg) + sizeof(struct page))
 FOLIO_MATCH(flags, _flags_1);
-FOLIO_MATCH(compound_head, __head);
+FOLIO_MATCH(compound_head, _head_1);
 FOLIO_MATCH(compound_dtor, _folio_dtor);
 FOLIO_MATCH(compound_order, _folio_order);
 FOLIO_MATCH(compound_mapcount, _total_mapcount);
 FOLIO_MATCH(compound_pincount, _pincount);
 #ifdef CONFIG_64BIT
 FOLIO_MATCH(compound_nr, _folio_nr_pages);
-FOLIO_MATCH(_private_1, _private_1);
 #endif
 #undef FOLIO_MATCH
+#define FOLIO_MATCH(pg, fl)						\
+	static_assert(offsetof(struct folio, fl) ==			\
+			offsetof(struct page, pg) + 2 * sizeof(struct page))
+FOLIO_MATCH(flags, _flags_2);
+FOLIO_MATCH(compound_head, _head_2);
+FOLIO_MATCH(hugetlb_subpool, _hugetlb_subpool);
+FOLIO_MATCH(hugetlb_cgroup, _hugetlb_cgroup);
+FOLIO_MATCH(hugetlb_cgroup_rsvd, _hugetlb_cgroup_rsvd);
+FOLIO_MATCH(hugetlb_hwpoison, _hugetlb_hwpoison);
+#undef FOLIO_MATCH
 
 static inline atomic_t *folio_mapcount_ptr(struct folio *folio)
 {
@@ -388,16 +422,6 @@ static inline void *folio_get_private(struct folio *folio)
 	return folio->private;
 }
 
-static inline void folio_set_private_1(struct folio *folio, unsigned long private)
-{
-	folio->_private_1 = private;
-}
-
-static inline unsigned long folio_get_private_1(struct folio *folio)
-{
-	return folio->_private_1;
-}
-
 struct page_frag_cache {
 	void * va;
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
diff --git a/mm/Kconfig b/mm/Kconfig
index 57e1d8c5b505..bc7e7dacfcd5 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -775,7 +775,7 @@ endchoice
 
 config THP_SWAP
 	def_bool y
-	depends on TRANSPARENT_HUGEPAGE && ARCH_WANTS_THP_SWAP && SWAP
+	depends on TRANSPARENT_HUGEPAGE && ARCH_WANTS_THP_SWAP && SWAP && 64BIT
 	help
 	  Swap transparent huge pages in one piece, without splitting.
 	  XXX: For now, swap cluster backing transparent huge page
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 779a426d2cab..63d8501001c6 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1687,8 +1687,7 @@ EXPORT_SYMBOL_GPL(mf_dax_kill_procs);
 #ifdef CONFIG_HUGETLB_PAGE
 /*
  * Struct raw_hwp_page represents information about "raw error page",
- * constructing singly linked list originated from ->private field of
- * SUBPAGE_INDEX_HWPOISON-th tail page.
+ * constructing singly linked list from ->_hugetlb_hwpoison field of folio.
  */
 struct raw_hwp_page {
 	struct llist_node node;
@@ -1697,7 +1696,7 @@ struct raw_hwp_page {
 
 static inline struct llist_head *raw_hwp_list_head(struct page *hpage)
 {
-	return (struct llist_head *)&page_private(hpage + SUBPAGE_INDEX_HWPOISON);
+	return (struct llist_head *)&page_folio(hpage)->_hugetlb_hwpoison;
 }
 
 static unsigned long __free_raw_hwp_pages(struct page *hpage, bool move_flag)
-- 
2.35.3

