Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D465B7BE4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 22:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiIMUAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 16:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiIMT7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 15:59:41 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198A578223;
        Tue, 13 Sep 2022 12:59:01 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id w2so5985587qtv.9;
        Tue, 13 Sep 2022 12:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=fHU5ZUx5v+GumCekHv98dt5HtboTaZeeu0Gp9AlVmvA=;
        b=ZkQM2Xi16fac9Kxsd6JfpJUyj9dFTpL2a9fMxPQYb5tsP1AGTq9LrS3GQ23PdeUUAq
         KiAJoUd0eFmdtlIe31jI3xWYF3lNu2z6iPVbkhYktSoNmKAD7mOQ11g6lhzdx8PeDKqG
         lPt1LWxw7/FsEvYMWeWC/86MaywQjplVNZrIXdmUyLe5Nr4lwjgNum55ZdLf4luz/yKw
         pKJIZBfhsG2I2a6u/v5b8+uct94R+RrovFIPHm9V4i65FXFauBq/I0QO/UcUPxNQEMMR
         iJaQjUMSz8SAuIngfV/EGkXgYLEYcOdGnoAVuWBboXNtLXNpt0Nqru8cUMiF0ZW7269J
         6y+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fHU5ZUx5v+GumCekHv98dt5HtboTaZeeu0Gp9AlVmvA=;
        b=TLiGnzbzNnpVtdmLnUhd0AFA8QWa+PBw87tuV3W/LvTzOLgBhsN1JIt3QFJlFHy4w/
         Jo2cVSqDq426f/upNG84xxTH4silnHaN24IeqkYzivx6NDmgaRhW8y/2QgahAI/DGvQI
         ks/beEcY4PevVKLnCbEy9vROa0FcNUpZ734bb58qS/yT/EqR2RIZbKpstA1qtZW37O+b
         cAhxo7seSqYK0pEihEwWLs5Y5noVu8Tzu3Z8rXASG9EJoXldExjLRAU/k0SynMd/RkiV
         LTaFFQyJTQ+XRO0Y9+0oWcFk2bp8dg8BXba9D/Xx7XlzcHh3qzSrftHooMluxHtalzxI
         L9/g==
X-Gm-Message-State: ACgBeo3zt1eF5PUrQqYYXF4hrJS+5Avj7KHMqzGs0L82OcJAomdOBh+I
        u7Q1J0A+gXeck3OzfwsG3LI=
X-Google-Smtp-Source: AA6agR7yxxGK0L7lb4UY6ElTAIAR0o3jzl9zqXW4dIwQkZBtshIlrdqdJVz3avbMktN2rc9zUTYXIg==
X-Received: by 2002:ac8:570a:0:b0:343:73af:7cd8 with SMTP id 10-20020ac8570a000000b0034373af7cd8mr30203309qtw.16.1663099140678;
        Tue, 13 Sep 2022 12:59:00 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:59:00 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        - <devicetree-spec@vger.kernel.org>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux.dev
Subject: [PATCH 18/21] mm/cma: support CMA in Designated Movable Blocks
Date:   Tue, 13 Sep 2022 12:55:05 -0700
Message-Id: <20220913195508.3511038-19-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913195508.3511038-1-opendmb@gmail.com>
References: <20220913195508.3511038-1-opendmb@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit allows for different page allocator handling for
CMA areas that are within Designated Movable Blocks.

Specifically, the pageblocks are allowed to remain migratetype
MIGRATE_MOVABLE to allow more aggressive utilization by the
page allocator. This also means that the page allocator should
not consider these pages as part of the nr_free_cma metric it
uses for managing MIGRATE_CMA type pageblocks.

This leads to the decision to remove these areas from the
CmaTotal metrics after initialization to avoid confusion.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 include/linux/cma.h | 13 ++++++---
 mm/cma.c            | 55 +++++++++++++++++++++++++-----------
 mm/page_alloc.c     | 69 +++++++++++++++++++++++++++++----------------
 3 files changed, 92 insertions(+), 45 deletions(-)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index 63873b93deaa..ffbb8ea2c5f8 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -31,11 +31,13 @@ extern phys_addr_t cma_get_base(const struct cma *cma);
 extern unsigned long cma_get_size(const struct cma *cma);
 extern const char *cma_get_name(const struct cma *cma);
 
-extern int __init cma_declare_contiguous_nid(phys_addr_t base,
+extern int __init __cma_declare_contiguous_nid(phys_addr_t base,
 			phys_addr_t size, phys_addr_t limit,
 			phys_addr_t alignment, unsigned int order_per_bit,
 			bool fixed, const char *name, struct cma **res_cma,
-			int nid);
+			int nid, bool in_dmb);
+#define cma_declare_contiguous_nid(b, s, l, a, o, f, n, r_c, nid)	\
+	__cma_declare_contiguous_nid(b, s, l, a, o, f, n, r_c, nid, false)
 static inline int __init cma_declare_contiguous(phys_addr_t base,
 			phys_addr_t size, phys_addr_t limit,
 			phys_addr_t alignment, unsigned int order_per_bit,
@@ -44,10 +46,13 @@ static inline int __init cma_declare_contiguous(phys_addr_t base,
 	return cma_declare_contiguous_nid(base, size, limit, alignment,
 			order_per_bit, fixed, name, res_cma, NUMA_NO_NODE);
 }
-extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
+extern int __cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 					unsigned int order_per_bit,
 					const char *name,
-					struct cma **res_cma);
+					struct cma **res_cma,
+					bool in_dmb);
+#define cma_init_reserved_mem(base, size, order, name, res_cma)		\
+	__cma_init_reserved_mem(base, size, order, name, res_cma, 0)
 extern struct page *cma_alloc(struct cma *cma, unsigned long count, unsigned int align,
 			      bool no_warn);
 extern bool cma_pages_valid(struct cma *cma, const struct page *pages, unsigned long count);
diff --git a/mm/cma.c b/mm/cma.c
index 6208a3e1cd9d..4f33cd54db9e 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -33,6 +33,7 @@
 #include <linux/kmemleak.h>
 #include <linux/page-isolation.h>
 #include <trace/events/cma.h>
+#include <linux/dmb.h>
 
 #include "cma.h"
 
@@ -98,6 +99,10 @@ static void __init cma_activate_area(struct cma *cma)
 {
 	unsigned long base_pfn = cma->base_pfn, pfn;
 	struct zone *zone;
+	int is_dmb = dmb_intersects(base_pfn, base_pfn + cma->count);
+
+	if (is_dmb == DMB_MIXED)
+		goto out_error;
 
 	cma->bitmap = bitmap_zalloc(cma_bitmap_maxno(cma), GFP_KERNEL);
 	if (!cma->bitmap)
@@ -116,13 +121,17 @@ static void __init cma_activate_area(struct cma *cma)
 			goto not_in_zone;
 	}
 
-	for (pfn = base_pfn; pfn < base_pfn + cma->count;
-	     pfn += pageblock_nr_pages) {
-		struct page *page = pfn_to_page(pfn);
+	if (is_dmb == DMB_INTERSECTS) {
+		totalcma_pages -= cma->count;
+	} else {
+		for (pfn = base_pfn; pfn < base_pfn + cma->count;
+		     pfn += pageblock_nr_pages) {
+			struct page *page = pfn_to_page(pfn);
 
-		set_pageblock_migratetype(page, MIGRATE_CMA);
-		init_reserved_pageblock(page);
-		page_zone(page)->cma_pages += pageblock_nr_pages;
+			set_pageblock_migratetype(page, MIGRATE_CMA);
+			init_reserved_pageblock(page);
+			page_zone(page)->cma_pages += pageblock_nr_pages;
+		}
 	}
 
 	spin_lock_init(&cma->lock);
@@ -141,7 +150,8 @@ static void __init cma_activate_area(struct cma *cma)
 	if (!cma->reserve_pages_on_error) {
 		for (pfn = base_pfn; pfn < base_pfn + cma->count;
 		     pfn += pageblock_nr_pages)
-			init_reserved_pageblock(pfn_to_page(pfn));
+			if (!dmb_intersects(pfn, pfn + pageblock_nr_pages))
+				init_reserved_pageblock(pfn_to_page(pfn));
 	}
 	totalcma_pages -= cma->count;
 	cma->count = 0;
@@ -166,7 +176,7 @@ void __init cma_reserve_pages_on_error(struct cma *cma)
 }
 
 /**
- * cma_init_reserved_mem() - create custom contiguous area from reserved memory
+ * __cma_init_reserved_mem() - create custom contiguous area in reserved memory
  * @base: Base address of the reserved area
  * @size: Size of the reserved area (in bytes),
  * @order_per_bit: Order of pages represented by one bit on bitmap.
@@ -174,15 +184,18 @@ void __init cma_reserve_pages_on_error(struct cma *cma)
  *        the area will be set to "cmaN", where N is a running counter of
  *        used areas.
  * @res_cma: Pointer to store the created cma region.
+ * @in_dmb: Designate the reserved memory as a Designated Movable Block.
  *
  * This function creates custom contiguous area from already reserved memory.
  */
-int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
-				 unsigned int order_per_bit,
-				 const char *name,
-				 struct cma **res_cma)
+int __init __cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
+				   unsigned int order_per_bit,
+				   const char *name,
+				   struct cma **res_cma,
+				   bool in_dmb)
 {
 	struct cma *cma;
+	int err;
 
 	/* Sanity checks */
 	if (cma_area_count == ARRAY_SIZE(cma_areas)) {
@@ -201,6 +214,14 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 	if (!IS_ALIGNED(base | size, CMA_MIN_ALIGNMENT_BYTES))
 		return -EINVAL;
 
+	if (in_dmb) {
+		err = dmb_reserve(base, size, NULL);
+		if (err) {
+			pr_err("Cannot reserve DMB for CMA!\n");
+			return err;
+		}
+	}
+
 	/*
 	 * Each reserved area must be initialised later, when more kernel
 	 * subsystems (like slab allocator) are available.
@@ -223,7 +244,7 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 }
 
 /**
- * cma_declare_contiguous_nid() - reserve custom contiguous area
+ * __cma_declare_contiguous_nid() - reserve custom contiguous area
  * @base: Base address of the reserved area optional, use 0 for any
  * @size: Size of the reserved area (in bytes),
  * @limit: End address of the reserved memory (optional, 0 for any).
@@ -233,6 +254,7 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
  * @name: The name of the area. See function cma_init_reserved_mem()
  * @res_cma: Pointer to store the created cma region.
  * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
+ * @in_dmb: Designate the reserved memory as a Designated Movable Block.
  *
  * This function reserves memory from early allocator. It should be
  * called by arch specific code once the early allocator (memblock or bootmem)
@@ -242,11 +264,11 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
  * If @fixed is true, reserve contiguous area at exactly @base.  If false,
  * reserve in range from @base to @limit.
  */
-int __init cma_declare_contiguous_nid(phys_addr_t base,
+int __init __cma_declare_contiguous_nid(phys_addr_t base,
 			phys_addr_t size, phys_addr_t limit,
 			phys_addr_t alignment, unsigned int order_per_bit,
 			bool fixed, const char *name, struct cma **res_cma,
-			int nid)
+			int nid, bool in_dmb)
 {
 	phys_addr_t memblock_end = memblock_end_of_DRAM();
 	phys_addr_t highmem_start;
@@ -374,7 +396,8 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
 		base = addr;
 	}
 
-	ret = cma_init_reserved_mem(base, size, order_per_bit, name, res_cma);
+	ret = __cma_init_reserved_mem(base, size, order_per_bit, name, res_cma,
+				      in_dmb);
 	if (ret)
 		goto free_mem;
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e38dd1b32771..09d00c178bc8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9233,29 +9233,8 @@ int __alloc_contig_migrate_range(struct compact_control *cc,
 	return 0;
 }
 
-/**
- * alloc_contig_range() -- tries to allocate given range of pages
- * @start:	start PFN to allocate
- * @end:	one-past-the-last PFN to allocate
- * @migratetype:	migratetype of the underlying pageblocks (either
- *			#MIGRATE_MOVABLE or #MIGRATE_CMA).  All pageblocks
- *			in range must have the same migratetype and it must
- *			be either of the two.
- * @gfp_mask:	GFP mask to use during compaction
- *
- * The PFN range does not have to be pageblock aligned. The PFN range must
- * belong to a single zone.
- *
- * The first thing this routine does is attempt to MIGRATE_ISOLATE all
- * pageblocks in the range.  Once isolated, the pageblocks should not
- * be modified by others.
- *
- * Return: zero on success or negative error code.  On success all
- * pages which PFN is in [start, end) are allocated for the caller and
- * need to be freed with free_contig_range().
- */
-int alloc_contig_range(unsigned long start, unsigned long end,
-		       unsigned migratetype, gfp_t gfp_mask)
+int _alloc_contig_range(unsigned long start, unsigned long end,
+			unsigned int migratetype, gfp_t gfp_mask)
 {
 	unsigned long outer_start, outer_end;
 	int order;
@@ -9379,6 +9358,46 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	undo_isolate_page_range(start, end, migratetype);
 	return ret;
 }
+
+/**
+ * alloc_contig_range() -- tries to allocate given range of pages
+ * @start:	start PFN to allocate
+ * @end:	one-past-the-last PFN to allocate
+ * @migratetype:	migratetype of the underlying pageblocks (either
+ *			#MIGRATE_MOVABLE or #MIGRATE_CMA).  All pageblocks
+ *			in range must have the same migratetype and it must
+ *			be either of the two.
+ * @gfp_mask:	GFP mask to use during compaction
+ *
+ * The PFN range does not have to be pageblock aligned. The PFN range must
+ * belong to a single zone.
+ *
+ * The first thing this routine does is attempt to MIGRATE_ISOLATE all
+ * pageblocks in the range.  Once isolated, the pageblocks should not
+ * be modified by others.
+ *
+ * Return: zero on success or negative error code.  On success all
+ * pages which PFN is in [start, end) are allocated for the caller and
+ * need to be freed with free_contig_range().
+ */
+int alloc_contig_range(unsigned long start, unsigned long end,
+		       unsigned int migratetype, gfp_t gfp_mask)
+{
+	switch (dmb_intersects(start, end)) {
+	case DMB_DISJOINT:
+		break;
+	case DMB_INTERSECTS:
+		if (migratetype == MIGRATE_CMA)
+			migratetype = MIGRATE_MOVABLE;
+		else
+			return -EBUSY;
+		break;
+	default:
+		return -EBUSY;
+	}
+
+	return _alloc_contig_range(start, end, migratetype, gfp_mask);
+}
 EXPORT_SYMBOL(alloc_contig_range);
 
 static int __alloc_contig_pages(unsigned long start_pfn,
@@ -9386,8 +9405,8 @@ static int __alloc_contig_pages(unsigned long start_pfn,
 {
 	unsigned long end_pfn = start_pfn + nr_pages;
 
-	return alloc_contig_range(start_pfn, end_pfn, MIGRATE_MOVABLE,
-				  gfp_mask);
+	return _alloc_contig_range(start_pfn, end_pfn, MIGRATE_MOVABLE,
+				   gfp_mask);
 }
 
 static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
-- 
2.25.1

