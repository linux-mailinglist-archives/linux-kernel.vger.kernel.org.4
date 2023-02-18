Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC6E69B6BE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjBRA33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjBRA3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:29:16 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D716ABC9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:28:55 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id l206-20020a25ccd7000000b006fdc6aaec4fso2656724ybf.20
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pz2nYroaVRrGSVy94qGG4nZ9E30MSqR5I0rmAzuTvq0=;
        b=V1UHwis97dacsHy0l1b3lzUp4aEffElgkQqFRGAP4R9Hw6zzh9pL3pU8TQ6LeCkOOO
         LAnGR0E6fLjGxKpr6E0yb8yofQJ3Yplq8n0cLT/bshgkpsM/hMNaBPY6WVg4rCJqcfel
         PmhHCvaQjRLpj3PZA4l3c17dZhuSlGVknfSXIUsszWjHRSH2g8HHkboEveCGaLYpHpYI
         huKFnLPcITV45hT7FdZX9JtRZdP0XFlN1WbgnsZXqSux2N7F1a5KMCJ3UlJJdxC6K6rW
         3mwyAccoa5IIH5iiNCO6YwhAkDP3JU0L27dI4gD0cC8hs7RdC32Vnk5NUwnl613BgcAj
         bg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pz2nYroaVRrGSVy94qGG4nZ9E30MSqR5I0rmAzuTvq0=;
        b=BtJwc+hq0KUweiaaK/OSQmOHE0bMaoAE+zp5RUzUHkGJ6wG049gVstSMxE0CrFL7sX
         LBwy5kaIXShajNOvYM5TNWqlh21yneKwgmdPGB0oNaqg9M7iCfFHtnb8ff3RSWhLCpoA
         d2WgR6Un3UnobYhlWBimcuvNt5/MExVniq9VYx3ARJGkGJvX8w0oEDf3KuBOApvMWRW2
         8aXacgWb10H+qwzflludmfyR8GBCCLb5LiI36lGDT1f5HBP6MWPjXRY1Yhd1AwEpY2Mv
         sCiYmpiX4V99MmRz+uwAFi5pneqtszFc6u+0VLOsj31RsYpdWDgZvCEBxYfmPZahnIx6
         8pcQ==
X-Gm-Message-State: AO0yUKU2PaKJSL8/EfMtDX9UlcHi62l3kDx1ODq92P3qZhSPYxMNzli8
        Xk7w44/o6p5ZO39LZs6wcgCEdE+IMIzCKWuV
X-Google-Smtp-Source: AK7set+zcld/vdofwpUCcvIXOcKa++WCtmqUm8NMGDjM4RjhBKN3Re9Z99sY+8b3ruIVEFKeHpX84TBdzsYueQO8
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6902:10c:b0:997:c919:4484 with SMTP
 id o12-20020a056902010c00b00997c9194484mr28393ybh.6.1676680134689; Fri, 17
 Feb 2023 16:28:54 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:27:44 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-12-jthoughton@google.com>
Subject: [PATCH v2 11/46] hugetlb: add hugetlb_pte to track HugeTLB page table entries
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After high-granularity mapping, page table entries for HugeTLB pages can
be of any size/type. (For example, we can have a 1G page mapped with a
mix of PMDs and PTEs.) This struct is to help keep track of a HugeTLB
PTE after we have done a page table walk.

Without this, we'd have to pass around the "size" of the PTE everywhere.
We effectively did this before; it could be fetched from the hstate,
which we pass around pretty much everywhere.

hugetlb_pte_present_leaf is included here as a helper function that will
be used frequently later on.

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index a1ceb9417f01..eeacadf3272b 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -26,6 +26,25 @@ typedef struct { unsigned long pd; } hugepd_t;
 #define __hugepd(x) ((hugepd_t) { (x) })
 #endif
 
+enum hugetlb_level {
+	HUGETLB_LEVEL_PTE = 1,
+	/*
+	 * We always include PMD, PUD, and P4D in this enum definition so that,
+	 * when logged as an integer, we can easily tell which level it is.
+	 */
+	HUGETLB_LEVEL_PMD,
+	HUGETLB_LEVEL_PUD,
+	HUGETLB_LEVEL_P4D,
+	HUGETLB_LEVEL_PGD,
+};
+
+struct hugetlb_pte {
+	pte_t *ptep;
+	unsigned int shift;
+	enum hugetlb_level level;
+	spinlock_t *ptl;
+};
+
 #ifdef CONFIG_HUGETLB_PAGE
 
 #include <linux/mempolicy.h>
@@ -39,6 +58,20 @@ typedef struct { unsigned long pd; } hugepd_t;
  */
 #define __NR_USED_SUBPAGE 3
 
+static inline
+unsigned long hugetlb_pte_size(const struct hugetlb_pte *hpte)
+{
+	return 1UL << hpte->shift;
+}
+
+static inline
+unsigned long hugetlb_pte_mask(const struct hugetlb_pte *hpte)
+{
+	return ~(hugetlb_pte_size(hpte) - 1);
+}
+
+bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte, pte_t pte);
+
 struct hugepage_subpool {
 	spinlock_t lock;
 	long count;
@@ -1234,6 +1267,45 @@ static inline spinlock_t *huge_pte_lock(struct hstate *h,
 	return ptl;
 }
 
+static inline
+spinlock_t *hugetlb_pte_lockptr(struct hugetlb_pte *hpte)
+{
+	return hpte->ptl;
+}
+
+static inline
+spinlock_t *hugetlb_pte_lock(struct hugetlb_pte *hpte)
+{
+	spinlock_t *ptl = hugetlb_pte_lockptr(hpte);
+
+	spin_lock(ptl);
+	return ptl;
+}
+
+static inline
+void __hugetlb_pte_init(struct hugetlb_pte *hpte, pte_t *ptep,
+			unsigned int shift, enum hugetlb_level level,
+			spinlock_t *ptl)
+{
+	/*
+	 * If 'shift' indicates that this PTE is contiguous, then @ptep must
+	 * be the first pte of the contiguous bunch.
+	 */
+	hpte->ptl = ptl;
+	hpte->ptep = ptep;
+	hpte->shift = shift;
+	hpte->level = level;
+}
+
+static inline
+void hugetlb_pte_init(struct mm_struct *mm, struct hugetlb_pte *hpte,
+		      pte_t *ptep, unsigned int shift,
+		      enum hugetlb_level level)
+{
+	__hugetlb_pte_init(hpte, ptep, shift, level,
+			   huge_pte_lockptr(shift, mm, ptep));
+}
+
 #if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_CMA)
 extern void __init hugetlb_cma_reserve(int order);
 #else
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5ca9eae0ac42..6c74adff43b6 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1269,6 +1269,35 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
 	return false;
 }
 
+bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte, pte_t pte)
+{
+	pgd_t pgd;
+	p4d_t p4d;
+	pud_t pud;
+	pmd_t pmd;
+
+	switch (hpte->level) {
+	case HUGETLB_LEVEL_PGD:
+		pgd = __pgd(pte_val(pte));
+		return pgd_present(pgd) && pgd_leaf(pgd);
+	case HUGETLB_LEVEL_P4D:
+		p4d = __p4d(pte_val(pte));
+		return p4d_present(p4d) && p4d_leaf(p4d);
+	case HUGETLB_LEVEL_PUD:
+		pud = __pud(pte_val(pte));
+		return pud_present(pud) && pud_leaf(pud);
+	case HUGETLB_LEVEL_PMD:
+		pmd = __pmd(pte_val(pte));
+		return pmd_present(pmd) && pmd_leaf(pmd);
+	case HUGETLB_LEVEL_PTE:
+		return pte_present(pte);
+	default:
+		WARN_ON_ONCE(1);
+		return false;
+	}
+}
+
+
 static void enqueue_hugetlb_folio(struct hstate *h, struct folio *folio)
 {
 	int nid = folio_nid(folio);
-- 
2.39.2.637.g21b0678d19-goog

