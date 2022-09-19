Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8D95BCC4B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiISM5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiISM5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:57:32 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD13D6340
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 05:57:30 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id v1so27821365plo.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 05:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=JKuDgaOyNjgYEWmjKPOFnPgDFLP9WPEUjmAgGHYvNKA=;
        b=FpKAkCZ8TH0BiA6szZglBYkO9+scLmOCkDcCwbCs6fEQBIK/Tp3lRM9ledR4+j07oC
         Zl+0kAfoMpn5sR8CqXFBad6zbexnT7RFtLia3OP5uIoWw07nbZE8Lutu4vanNEoGGI8T
         4AEK30DyJDqEqVLTFxc5GauadmEidaJ21FswdvaBKIeBElEIrZTwPFKXiufEauUCtQlN
         v5LTFti91n/v+mkNBE36q3rI+4AURDOMqhtEy1bJ1yxV2et+InlpU3iwvBboXI0onPKg
         VnH+ztPJYA+x/qgg3QrDpq4CYCUzpJ2yb+k2ICPHxih0DY0+g3VYgsnSUhGUnBco7NyK
         Oxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=JKuDgaOyNjgYEWmjKPOFnPgDFLP9WPEUjmAgGHYvNKA=;
        b=l/mkOTzN+itldD6t0OCGPCPaKpnnG8DdrOLpQqvaGi4bBIl0IhIImZSfKaLAWlPhXY
         JELmfiFPhj6K5IrQMX7LhJO2B905yW2wqgiH02E3v05oALiaqgWXZjCpFjurJnxI5yyd
         Hl2CEDZ83ZpAfmFrR5fdlXCFNPWqycMPJDmYCZznZxmfOkRbmL78nOwDfU2TelD772iZ
         vxrhasTTORt7HkRLa3KUDSYAJ7nNMEM27X4Ttj7OP02E8+A5wjkDsFrtuU29AjoyeCL8
         JGBs+sBxsOOMmOvoVihgv+zT+uSHDoc5koB/NTskAiAKvvDAYojWfFJvjNB4Wsk1801o
         2CVQ==
X-Gm-Message-State: ACrzQf0VlPNVUGoDoiZ6LxAPbkRGblbKJ/lixg9qSzcNy0AtHqgkCOYe
        ZPKEGRJS+Vz9uTKh1L+xO7Q=
X-Google-Smtp-Source: AMsMyM48hW84FhEzvllM4LjTgPOohgNgweZ65lzC65luMNjBclfKBI7hlN43SYjGbgIpPJwnjQqT3Q==
X-Received: by 2002:a17:90a:ce82:b0:200:aca2:5a19 with SMTP id g2-20020a17090ace8200b00200aca25a19mr30822240pju.156.1663592250307;
        Mon, 19 Sep 2022 05:57:30 -0700 (PDT)
Received: from hyeyoo.. ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id a75-20020a621a4e000000b0053f9466b1b2sm20081081pfa.35.2022.09.19.05.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 05:57:29 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>
Subject: [PATCH] mm: move PG_slab flag to page_type
Date:   Mon, 19 Sep 2022 21:57:08 +0900
Message-Id: <20220919125708.276864-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For now, only SLAB uses _mapcount field as a number of active objects in
a slab, and other slab allocators do not use it. As 16 bits are enough
for that, use remaining 16 bits of _mapcount as page_type even when
SLAB is used. And then move PG_slab flag to page_type!

Note that page_type is always placed in upper 16 bits of _mapcount to
avoid confusing normal _mapcount as page_type. As underflow (actually
I mean, yeah, overflow) is not a concern anymore, use more lower bits
except bit zero.

Add more folio helpers for PAGE_TYPE_OPS() not to break existing
slab implementations.

Remove PG_slab check from PAGE_FLAGS_CHECK_AT_FREE. buddy will still
check if _mapcount is properly set at free.

Exclude PG_slab from hwpoison and show_page_flags() for now.

Note that with this patch, page_mapped() and folio_mapped() always return
false for slab page.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Marco Elver <elver@google.com>
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---

I think this gives us two benefits:
- it frees a bit in flags field
- it makes it simpler to distinguish user-mapped pages and
  not-user-mapped pages.

Plus I'm writing a bit more of code including:
	0) a few cleanup for code that checks
	   !PageSlab() && page_mapped() or that does similar thing
	1) provide human-readale string of page_type in dump_page
	2) add show_page_types() for tracepoint
	3) fix hwpoison ...etc.

Anyway This is an early RFC, I will very appreciate feedbacks!

 include/linux/mm_types.h       | 22 +++++++--
 include/linux/page-flags.h     | 83 ++++++++++++++++++++++++++--------
 include/trace/events/mmflags.h |  1 -
 mm/memory-failure.c            |  8 ----
 mm/slab.h                      | 11 ++++-
 5 files changed, 92 insertions(+), 33 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index cf97f3884fda..4b217c6fbe1f 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -193,12 +193,24 @@ struct page {
 		atomic_t _mapcount;
 
 		/*
-		 * If the page is neither PageSlab nor mappable to userspace,
-		 * the value stored here may help determine what this page
-		 * is used for.  See page-flags.h for a list of page types
-		 * which are currently stored here.
+		 * If the page is not mappable to userspace, the value
+		 * stored here may help determine what this page is used for.
+		 * See page-flags.h for a list of page types which are currently
+		 * stored here.
 		 */
-		unsigned int page_type;
+		struct {
+			/*
+			 * Always place page_type in
+			 * upper 16 bits of _mapcount
+			 */
+#ifdef CPU_BIG_ENDIAN
+			__u16 page_type;
+			__u16 active;
+#else
+			__u16 active;
+			__u16 page_type;
+#endif
+		};
 	};
 
 	/* Usage count. *DO NOT USE DIRECTLY*. See page_ref.h */
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 465ff35a8c00..b414d0996639 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -107,7 +107,6 @@ enum pageflags {
 	PG_workingset,
 	PG_waiters,		/* Page has waiters, check its waitqueue. Must be bit #7 and in the same byte as "PG_locked" */
 	PG_error,
-	PG_slab,
 	PG_owner_priv_1,	/* Owner use. If pagecache, fs may use*/
 	PG_arch_1,
 	PG_reserved,
@@ -484,7 +483,6 @@ PAGEFLAG(Active, active, PF_HEAD) __CLEARPAGEFLAG(Active, active, PF_HEAD)
 	TESTCLEARFLAG(Active, active, PF_HEAD)
 PAGEFLAG(Workingset, workingset, PF_HEAD)
 	TESTCLEARFLAG(Workingset, workingset, PF_HEAD)
-__PAGEFLAG(Slab, slab, PF_NO_TAIL)
 __PAGEFLAG(SlobFree, slob_free, PF_NO_TAIL)
 PAGEFLAG(Checked, checked, PF_NO_COMPOUND)	   /* Used by some filesystems */
 
@@ -926,44 +924,90 @@ static inline bool is_page_hwpoison(struct page *page)
 }
 
 /*
- * For pages that are never mapped to userspace (and aren't PageSlab),
- * page_type may be used.  Because it is initialised to -1, we invert the
- * sense of the bit, so __SetPageFoo *clears* the bit used for PageFoo, and
- * __ClearPageFoo *sets* the bit used for PageFoo.  We reserve a few high and
- * low bits so that an underflow or overflow of page_mapcount() won't be
- * mistaken for a page type value.
+ * For pages that are never mapped to userspace, page_type may be used.
+ * Because it is initialised to -1, we invert the sense of the bit,
+ * so __SetPageFoo *clears* the bit used for PageFoo, and __ClearPageFoo
+ * *sets* the bit used for PageFoo.  We reserve a few high and low bits
+ * so that an underflow or overflow of page_mapcount() won't be mistaken
+ * for a page type value.
  */
 
-#define PAGE_TYPE_BASE	0xf0000000
-/* Reserve		0x0000007f to catch underflows of page_mapcount */
-#define PAGE_MAPCOUNT_RESERVE	-128
-#define PG_buddy	0x00000080
-#define PG_offline	0x00000100
-#define PG_table	0x00000200
-#define PG_guard	0x00000400
+#define PAGE_TYPE_BASE	0xf000
+#define PAGE_MAPCOUNT_RESERVE	-1
+#define PG_buddy	0x0002
+#define PG_offline	0x0004
+#define PG_table	0x0008
+#define PG_guard	0x0010
+#define PG_slab		0x0020
 
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
 
-static inline int page_has_type(struct page *page)
+#define PAGE_TYPE_MASK	((1UL << (BITS_PER_BYTE * sizeof(__u16))) - 1)
+
+static inline bool page_has_type(struct page *page)
 {
 	return (int)page->page_type < PAGE_MAPCOUNT_RESERVE;
 }
 
+static inline bool page_type_valid(__u16 page_type)
+{
+	return (page_type & PAGE_TYPE_BASE) == PAGE_TYPE_BASE;
+}
+
 #define PAGE_TYPE_OPS(uname, lname)					\
 static __always_inline int Page##uname(struct page *page)		\
 {									\
 	return PageType(page, PG_##lname);				\
 }									\
+static __always_inline int folio_test_##lname(struct folio *folio)	\
+{									\
+	struct page *page = &folio->page;				\
+									\
+	VM_BUG_ON_PAGE(PageTail(page), page);				\
+	return PageType(page, PG_##lname);				\
+}									\
+static __always_inline int __folio_test_##lname(struct folio *folio)	\
+{									\
+	struct page *page = &folio->page;				\
+									\
+	return PageType(page, PG_##lname);				\
+}									\
 static __always_inline void __SetPage##uname(struct page *page)		\
 {									\
 	VM_BUG_ON_PAGE(!PageType(page, 0), page);			\
 	page->page_type &= ~PG_##lname;					\
 }									\
+static __always_inline void folio_set_##lname(struct folio *folio)	\
+{									\
+	struct page *page = &folio->page;				\
+									\
+	VM_BUG_ON_PAGE(PageTail(page), page);				\
+	__SetPage##uname(page);						\
+}									\
+static __always_inline void __folio_set_##lname(struct folio *folio)	\
+{									\
+	struct page *page = &folio->page;				\
+									\
+	__SetPage##uname(page);						\
+}									\
 static __always_inline void __ClearPage##uname(struct page *page)	\
 {									\
 	VM_BUG_ON_PAGE(!Page##uname(page), page);			\
 	page->page_type |= PG_##lname;					\
+}									\
+static __always_inline void folio_clear_##lname(struct folio *folio)	\
+{									\
+	struct page *page = &folio->page;				\
+									\
+	VM_BUG_ON_PAGE(PageTail(page), page);				\
+	__ClearPage##uname(page);					\
+}									\
+static __always_inline void __folio_clear_##lname(struct folio *folio)	\
+{									\
+	struct page *page = &folio->page;				\
+									\
+	__ClearPage##uname(page);					\
 }
 
 /*
@@ -996,6 +1040,9 @@ PAGE_TYPE_OPS(Buddy, buddy)
  */
 PAGE_TYPE_OPS(Offline, offline)
 
+/* PageSlab() indicates that the page is used by slab subsystem. */
+PAGE_TYPE_OPS(Slab, slab)
+
 extern void page_offline_freeze(void);
 extern void page_offline_thaw(void);
 extern void page_offline_begin(void);
@@ -1057,8 +1104,8 @@ static __always_inline void __ClearPageAnonExclusive(struct page *page)
 	(1UL << PG_lru		| 1UL << PG_locked	|	\
 	 1UL << PG_private	| 1UL << PG_private_2	|	\
 	 1UL << PG_writeback	| 1UL << PG_reserved	|	\
-	 1UL << PG_slab		| 1UL << PG_active 	|	\
-	 1UL << PG_unevictable	| __PG_MLOCKED)
+	 1UL << PG_active	| 1UL << PG_unevictable	|	\
+	 __PG_MLOCKED)
 
 /*
  * Flags checked when a page is prepped for return by the page allocator.
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index e87cb2b80ed3..fa5aa9e983ec 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -113,7 +113,6 @@
 	{1UL << PG_lru,			"lru"		},		\
 	{1UL << PG_active,		"active"	},		\
 	{1UL << PG_workingset,		"workingset"	},		\
-	{1UL << PG_slab,		"slab"		},		\
 	{1UL << PG_owner_priv_1,	"owner_priv_1"	},		\
 	{1UL << PG_arch_1,		"arch_1"	},		\
 	{1UL << PG_reserved,		"reserved"	},		\
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 14439806b5ef..9a25d10d7391 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1123,7 +1123,6 @@ static int me_huge_page(struct page_state *ps, struct page *p)
 #define mlock		(1UL << PG_mlocked)
 #define lru		(1UL << PG_lru)
 #define head		(1UL << PG_head)
-#define slab		(1UL << PG_slab)
 #define reserved	(1UL << PG_reserved)
 
 static struct page_state error_states[] = {
@@ -1133,13 +1132,6 @@ static struct page_state error_states[] = {
 	 * PG_buddy pages only make a small fraction of all free pages.
 	 */
 
-	/*
-	 * Could in theory check if slab page is free or if we can drop
-	 * currently unused objects without touching them. But just
-	 * treat it as standard kernel for now.
-	 */
-	{ slab,		slab,		MF_MSG_SLAB,	me_kernel },
-
 	{ head,		head,		MF_MSG_HUGE,		me_huge_page },
 
 	{ sc|dirty,	sc|dirty,	MF_MSG_DIRTY_SWAPCACHE,	me_swapcache_dirty },
diff --git a/mm/slab.h b/mm/slab.h
index 985820b9069b..a5273e189265 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -20,7 +20,16 @@ struct slab {
 		};
 		struct rcu_head rcu_head;
 	};
-	unsigned int active;
+	struct {
+		/* always place page_type in upper 16 bits of _mapcount */
+#ifdef CPU_BIG_ENDIAN
+		__u16 page_type;
+		__u16 active;
+#else
+		__u16 active;
+		__u16 page_type;
+#endif
+	};
 
 #elif defined(CONFIG_SLUB)
 
-- 
2.32.0

