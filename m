Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE2469B6C3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjBRA3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjBRA3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:29:17 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118F16ABF3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:28:56 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5365a2b9e4fso19053897b3.15
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Coc3VejVpx2o70gw2F1FMLmVPB7+pJmCD4QBd1TWaEQ=;
        b=b9QeURwuMOHoR6oMuvaNhmrHn5fZGAuH6iVnLRa9UH1kSasBCwgdba6QJPd+K6jzHb
         xz6s/6q+eVA72+3bOi37v4IpLi+gt+dDSU4ZiqKrbXd+tRUGRvRJ1mGjZ02I2XMyurj4
         SsSE1g1trZVfhuYlrhfBM4w2eQv5qoEpUPlr5CJMDFyaM52fzsGSeRGzxi0rFH4dVLC6
         IFd4sxykmk7qNUAT62W1oRvfIgHfE5E1BizMsR8G5eNcCZgGLkwZhgNod0TNXPX+Z62j
         6Y1IxEaN7fiBpSKCe960CuuSJGub6psv+J5ih1KSgDonLBFQ4O9QsMNnykmF5WR/o4UG
         3CMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Coc3VejVpx2o70gw2F1FMLmVPB7+pJmCD4QBd1TWaEQ=;
        b=klwZ9okWf7daMKyeDQ0qFM8L7FDsN5pOwsL7CRHRgZ3SM5JhPzz8QOzOydPwjoACUj
         7VXFCi3kyGhJ/jRrOZWSw6ogAjQdaktugZf/lpSroB8MctgELZQvGyiL7jNbYp2emez5
         10KCnYsM+OEL+oVtyRjRjZnDc1YxPuHnkjQUgOhsZ13E+ppVw97ZCuFFqrtO9YltPny/
         rtxU+99k/BnlmDBAaHpvY4wf7hmkeSRQ3GvPIl6fQWXFsSowC2dJH6x3p2An5L9yALLe
         N7RuUwpGn3UDSLYPU3UPdaivWXw/GeGnesY12IhtIN17lrJrQhTJf+6fSBr+80UmIlf3
         ziPQ==
X-Gm-Message-State: AO0yUKXOH+ifzjGYDFbF9mVdSLaY0CypMaP58GQQo72c/iJJTcrXjhom
        h4kxniod5CGCa2R7DnPUSoThV53CdGmIAxcB
X-Google-Smtp-Source: AK7set9ALTOiMY3O/c14DOIxwwoyqi8AmUxl79K9DJLNuYtBmR+KN/t3Tjueou+iosR6XToAl+9j+ymfqMf1UvES
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a81:b705:0:b0:534:d71f:14e6 with SMTP
 id v5-20020a81b705000000b00534d71f14e6mr53501ywh.9.1676680135521; Fri, 17 Feb
 2023 16:28:55 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:27:45 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-13-jthoughton@google.com>
Subject: [PATCH v2 12/46] hugetlb: add hugetlb_alloc_pmd and hugetlb_alloc_pte
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

These functions are used to allocate new PTEs below the hstate PTE. This
will be used by hugetlb_walk_step, which implements stepping forwards in
a HugeTLB high-granularity page table walk.

The reasons that we don't use the standard pmd_alloc/pte_alloc*
functions are:
 1) This prevents us from accidentally overwriting swap entries or
    attempting to use swap entries as present non-leaf PTEs (see
    pmd_alloc(); we assume that !pte_none means pte_present and
    non-leaf).
 2) Locking hugetlb PTEs can different than regular PTEs. (Although, as
    implemented right now, locking is the same.)
 3) We can maintain compatibility with CONFIG_HIGHPTE. That is, HugeTLB
    HGM won't use HIGHPTE, but the kernel can still be built with it,
    and other mm code will use it.

When GENERAL_HUGETLB supports P4D-based hugepages, we will need to
implement hugetlb_pud_alloc to implement hugetlb_walk_step.

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index eeacadf3272b..9d839519c875 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -72,6 +72,11 @@ unsigned long hugetlb_pte_mask(const struct hugetlb_pte *hpte)
 
 bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte, pte_t pte);
 
+pmd_t *hugetlb_alloc_pmd(struct mm_struct *mm, struct hugetlb_pte *hpte,
+		unsigned long addr);
+pte_t *hugetlb_alloc_pte(struct mm_struct *mm, struct hugetlb_pte *hpte,
+		unsigned long addr);
+
 struct hugepage_subpool {
 	spinlock_t lock;
 	long count;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6c74adff43b6..bb424cdf79e4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -483,6 +483,120 @@ static bool has_same_uncharge_info(struct file_region *rg,
 #endif
 }
 
+/*
+ * hugetlb_alloc_pmd -- Allocate or find a PMD beneath a PUD-level hpte.
+ *
+ * This is meant to be used to implement hugetlb_walk_step when one must go to
+ * step down to a PMD. Different architectures may implement hugetlb_walk_step
+ * differently, but hugetlb_alloc_pmd and hugetlb_alloc_pte are architecture-
+ * independent.
+ *
+ * Returns:
+ *	On success: the pointer to the PMD. This should be placed into a
+ *		    hugetlb_pte. @hpte is not changed.
+ *	ERR_PTR(-EINVAL): hpte is not PUD-level
+ *	ERR_PTR(-EEXIST): there is a non-leaf and non-empty PUD in @hpte
+ *	ERR_PTR(-ENOMEM): could not allocate the new PMD
+ */
+pmd_t *hugetlb_alloc_pmd(struct mm_struct *mm, struct hugetlb_pte *hpte,
+		unsigned long addr)
+{
+	spinlock_t *ptl = hugetlb_pte_lockptr(hpte);
+	pmd_t *new;
+	pud_t *pudp;
+	pud_t pud;
+
+	if (hpte->level != HUGETLB_LEVEL_PUD)
+		return ERR_PTR(-EINVAL);
+
+	pudp = (pud_t *)hpte->ptep;
+retry:
+	pud = READ_ONCE(*pudp);
+	if (likely(pud_present(pud)))
+		return unlikely(pud_leaf(pud))
+			? ERR_PTR(-EEXIST)
+			: pmd_offset(pudp, addr);
+	else if (!pud_none(pud))
+		/*
+		 * Not present and not none means that a swap entry lives here,
+		 * and we can't get rid of it.
+		 */
+		return ERR_PTR(-EEXIST);
+
+	new = pmd_alloc_one(mm, addr);
+	if (!new)
+		return ERR_PTR(-ENOMEM);
+
+	spin_lock(ptl);
+	if (!pud_same(pud, *pudp)) {
+		spin_unlock(ptl);
+		pmd_free(mm, new);
+		goto retry;
+	}
+
+	mm_inc_nr_pmds(mm);
+	smp_wmb(); /* See comment in pmd_install() */
+	pud_populate(mm, pudp, new);
+	spin_unlock(ptl);
+	return pmd_offset(pudp, addr);
+}
+
+/*
+ * hugetlb_alloc_pte -- Allocate a PTE beneath a pmd_none PMD-level hpte.
+ *
+ * See the comment above hugetlb_alloc_pmd.
+ */
+pte_t *hugetlb_alloc_pte(struct mm_struct *mm, struct hugetlb_pte *hpte,
+		unsigned long addr)
+{
+	spinlock_t *ptl = hugetlb_pte_lockptr(hpte);
+	pgtable_t new;
+	pmd_t *pmdp;
+	pmd_t pmd;
+
+	if (hpte->level != HUGETLB_LEVEL_PMD)
+		return ERR_PTR(-EINVAL);
+
+	pmdp = (pmd_t *)hpte->ptep;
+retry:
+	pmd = READ_ONCE(*pmdp);
+	if (likely(pmd_present(pmd)))
+		return unlikely(pmd_leaf(pmd))
+			? ERR_PTR(-EEXIST)
+			: pte_offset_kernel(pmdp, addr);
+	else if (!pmd_none(pmd))
+		/*
+		 * Not present and not none means that a swap entry lives here,
+		 * and we can't get rid of it.
+		 */
+		return ERR_PTR(-EEXIST);
+
+	/*
+	 * With CONFIG_HIGHPTE, calling `pte_alloc_one` directly may result
+	 * in page tables being allocated in high memory, needing a kmap to
+	 * access. Instead, we call __pte_alloc_one directly with
+	 * GFP_PGTABLE_USER to prevent these PTEs being allocated in high
+	 * memory.
+	 */
+	new = __pte_alloc_one(mm, GFP_PGTABLE_USER);
+	if (!new)
+		return ERR_PTR(-ENOMEM);
+
+	spin_lock(ptl);
+	if (!pmd_same(pmd, *pmdp)) {
+		spin_unlock(ptl);
+		pgtable_pte_page_dtor(new);
+		__free_page(new);
+		goto retry;
+	}
+
+	mm_inc_nr_ptes(mm);
+	smp_wmb(); /* See comment in pmd_install() */
+	pmd_populate(mm, pmdp, new);
+	spin_unlock(ptl);
+	return pte_offset_kernel(pmdp, addr);
+}
+
 static void coalesce_file_region(struct resv_map *resv, struct file_region *rg)
 {
 	struct file_region *nrg, *prg;
-- 
2.39.2.637.g21b0678d19-goog

