Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F0165E8D0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjAEKUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbjAEKTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:19:36 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DA050E62
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:09 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a4-20020a5b0004000000b006fdc6aaec4fso36882545ybp.20
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HlgWOjaAJz0zfdNn9cG/30nMIJO7QLF2mBB2gxe7Hq8=;
        b=iSz2ooNkUZGnH87sDmHD2gCBj2Hey3YSf423VRaH6AnWyafV22fMV2Sw9PR3D4uqic
         CllJH2wRMj7/tkZJT/L4HrkszREidz8xo8elOcL/ubDPrXdbjKqcvSwNuBpfIvAGVtvR
         A5ldBvPdHR0ntED8Zu2n7yVUxfVZ9fS2FUgGqGsf9I7fh5DevYo9DWvQ14UI5opS2Ndf
         9pyDdSpxBL6nohGJDqj9v21g+a96iXBzAfKohulMwY8yNne3UYL+LmR1Lm/zk3AAVII7
         QovdH+ZXsH6oWLiYCENZhk3nLT5IEtiB909u4krXh79gZLNok0fXXDBeFzffTBDi9IPZ
         p31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HlgWOjaAJz0zfdNn9cG/30nMIJO7QLF2mBB2gxe7Hq8=;
        b=wcblBh12TaQq6mHqq11VfhPP/Hyd/XimXS7JLcJNeXV645s/vu1HbXX5EpTqkcJZvr
         8OlnJicystYc1XAdmAbLd0z62zZosa9DIktDTNAYu7O0vDFTAxvovW3fMvrlJUKSt8av
         FbUzHLiS/qQwAXu5RCoqFH10184LDmB/xon6sVHsQbtVx7kTT3gJznZygex1ks8CwNy+
         Zc7FpCSwQdxCpIn3bGIvddMNLMeQO9L679lyh9BfDj2BKK1wQC4kA1nqXEMNv9Oyi4wc
         hOYH+BxPLt3vL9hBnC8S/LPpF4eHClXTAYyVQzbTBAhp27uwuas1xYrqgbP92l/an9MA
         0KsA==
X-Gm-Message-State: AFqh2koSq0UeMM73dgyhmunoSpG1B/I1b02dnzaj4dAgmVEoy8jHf8ze
        W3DB7TYFg+7LZ9P/boF45XDgE8vuTcQQdKCq
X-Google-Smtp-Source: AMrXdXuWXwTFKt3tEGwcWkM+8Z5EJbSUAOSB4/uJq2eHaPtcD22bcM4r//hqZZqHWIknAkMmLTX/CoDS7t5HOrA7
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:42c2:0:b0:758:bd9:8a70 with SMTP id
 p185-20020a2542c2000000b007580bd98a70mr4286087yba.377.1672913949470; Thu, 05
 Jan 2023 02:19:09 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:09 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-12-jthoughton@google.com>
Subject: [PATCH 11/46] hugetlb: add hugetlb_pte to track HugeTLB page table entries
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
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
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
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
---
 include/linux/hugetlb.h | 72 +++++++++++++++++++++++++++++++++++++++++
 mm/hugetlb.c            | 29 +++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 3f098363cd6e..bf441d8a1b52 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -38,6 +38,54 @@ typedef struct { unsigned long pd; } hugepd_t;
  */
 #define __NR_USED_SUBPAGE 3
 
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
+static inline
+void __hugetlb_pte_populate(struct hugetlb_pte *hpte, pte_t *ptep,
+			    unsigned int shift, enum hugetlb_level level,
+			    spinlock_t *ptl)
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
@@ -1232,6 +1280,30 @@ static inline spinlock_t *huge_pte_lock(struct hstate *h,
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
+void hugetlb_pte_populate(struct mm_struct *mm, struct hugetlb_pte *hpte,
+			  pte_t *ptep, unsigned int shift,
+			  enum hugetlb_level level)
+{
+	__hugetlb_pte_populate(hpte, ptep, shift, level,
+			huge_pte_lockptr(shift, mm, ptep));
+}
+
 #if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_CMA)
 extern void __init hugetlb_cma_reserve(int order);
 #else
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4db38dc79d0e..2d83a2c359a2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1266,6 +1266,35 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
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
2.39.0.314.g84b9a713c41-goog

