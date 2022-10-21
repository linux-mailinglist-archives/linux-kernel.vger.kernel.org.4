Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDA6607C68
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiJUQiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiJUQha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:37:30 -0400
Received: from mail-ua1-x94a.google.com (mail-ua1-x94a.google.com [IPv6:2607:f8b0:4864:20::94a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C5A27B56F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:26 -0700 (PDT)
Received: by mail-ua1-x94a.google.com with SMTP id h11-20020ab0470b000000b003bf1da44886so2348922uac.17
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fki+um4ICIptosTnJrWPKrPDlP+wU0UwwTN9RPzv9+o=;
        b=ND0Wnc7owKsedJs2eeuHEmNDxzWNQ8LJ9L6l2O850QzH0C/poOjJndJ7AVL7Po1zjY
         RTH3QeNCDw8Ggm9zXm0JwsqpfhqKci87zPwqjusR19zNbpEUtAwPucBKje4NDjKnw/yN
         JTUX7XoJ4tpG9TXphw9fp2FSGuVr5cTSuyjJYTpAt1r53VPzmdcNWylmEckjVlQivsUE
         doMwgo1hmTPDhQyun6/Q6ld67hLjwxbbwc8Uuj99/wST20NLCwvhvHvgbjaU/OG+tOnz
         +6TkRssWN2qGSoBubKtF0OdCdQxRP8LDpfebPGhVmTNXhq3XL/JjAXpxQmoXgb5b4WfY
         YwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fki+um4ICIptosTnJrWPKrPDlP+wU0UwwTN9RPzv9+o=;
        b=TlL4s2l6x5Kum61eScvmz35zXKbBMWdiUsXcigpIKhz7d1O/mgFIreWOf421RqJ/xl
         E5UJD5XQzfVs/S7ndfSqnO/75jvHq5eJwRAJqPPEfBVoMwwRQHp8GAEXhcMgP3x3Y9GR
         Qk7dR4Qb2N9dnvpJd3lAjF9q3S96nBFkIfUdCU0zeKjtLJ746o6+kTs4wpQTDm7WIPn2
         weOGulcdbzb/SyaPMthNI0cTgTRvQftW8lT33tPGsdZcGyaoF6lFbTnX86zrSdhvE/9E
         P7zgbyzBq04xdahXNuKB1YqcPd1lZjNDJqivFa41fUyLeKh+WfZLO0dsPrm51ih+wwVC
         2GdQ==
X-Gm-Message-State: ACrzQf0MrHUR3dsJJf81gxyV+il7ztqV4GexocjlrF+sRm9buKDgeUv2
        b3ub21ja88kvhiDvwukZuNlKUGflndZ8wIis
X-Google-Smtp-Source: AMsMyM5QFhBSyeYC9Di8NxouECHRYWC0hrCK9vBz/FU8ZymUfIUKH+oIBZ8yx3ZjzVdzlHzg9sxxP3WTZJzBD3WK
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6102:3e1a:b0:3a9:7543:204a with
 SMTP id j26-20020a0561023e1a00b003a97543204amr13044013vsv.53.1666370245924;
 Fri, 21 Oct 2022 09:37:25 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:26 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-11-jthoughton@google.com>
Subject: [RFC PATCH v2 10/47] hugetlb: add hugetlb_pte to track HugeTLB page
 table entries
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
 include/linux/hugetlb.h | 88 +++++++++++++++++++++++++++++++++++++++++
 mm/hugetlb.c            | 29 ++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index db3ed6095b1c..d30322108b34 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -50,6 +50,75 @@ enum {
 	__NR_USED_SUBPAGE,
 };
 
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
+void hugetlb_pte_populate(struct hugetlb_pte *hpte, pte_t *ptep,
+			  unsigned int shift, enum hugetlb_level level)
+{
+	WARN_ON_ONCE(!ptep);
+	hpte->ptep = ptep;
+	hpte->shift = shift;
+	hpte->level = level;
+	hpte->ptl = NULL;
+}
+
+static inline
+unsigned long hugetlb_pte_size(const struct hugetlb_pte *hpte)
+{
+	WARN_ON_ONCE(!hpte->ptep);
+	return 1UL << hpte->shift;
+}
+
+static inline
+unsigned long hugetlb_pte_mask(const struct hugetlb_pte *hpte)
+{
+	WARN_ON_ONCE(!hpte->ptep);
+	return ~(hugetlb_pte_size(hpte) - 1);
+}
+
+static inline
+unsigned int hugetlb_pte_shift(const struct hugetlb_pte *hpte)
+{
+	WARN_ON_ONCE(!hpte->ptep);
+	return hpte->shift;
+}
+
+static inline
+enum hugetlb_level hugetlb_pte_level(const struct hugetlb_pte *hpte)
+{
+	WARN_ON_ONCE(!hpte->ptep);
+	return hpte->level;
+}
+
+static inline
+void hugetlb_pte_copy(struct hugetlb_pte *dest, const struct hugetlb_pte *src)
+{
+	dest->ptep = src->ptep;
+	dest->shift = src->shift;
+	dest->level = src->level;
+	dest->ptl = src->ptl;
+}
+
+bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte, pte_t pte);
+
 struct hugepage_subpool {
 	spinlock_t lock;
 	long count;
@@ -1210,6 +1279,25 @@ static inline spinlock_t *huge_pte_lock(struct hstate *h,
 	return ptl;
 }
 
+static inline
+spinlock_t *hugetlb_pte_lockptr(struct mm_struct *mm, struct hugetlb_pte *hpte)
+{
+
+	BUG_ON(!hpte->ptep);
+	if (hpte->ptl)
+		return hpte->ptl;
+	return huge_pte_lockptr(hugetlb_pte_shift(hpte), mm, hpte->ptep);
+}
+
+static inline
+spinlock_t *hugetlb_pte_lock(struct mm_struct *mm, struct hugetlb_pte *hpte)
+{
+	spinlock_t *ptl = hugetlb_pte_lockptr(mm, hpte);
+
+	spin_lock(ptl);
+	return ptl;
+}
+
 #if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_CMA)
 extern void __init hugetlb_cma_reserve(int order);
 #else
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ef7662bd0068..a0e46d35dabc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1127,6 +1127,35 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
 	return false;
 }
 
+bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte, pte_t pte)
+{
+	pgd_t pgd;
+	p4d_t p4d;
+	pud_t pud;
+	pmd_t pmd;
+
+	WARN_ON_ONCE(!hpte->ptep);
+	switch (hugetlb_pte_level(hpte)) {
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
 static void enqueue_huge_page(struct hstate *h, struct page *page)
 {
 	int nid = page_to_nid(page);
-- 
2.38.0.135.g90850a2211-goog

