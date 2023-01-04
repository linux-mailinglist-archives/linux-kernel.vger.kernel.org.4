Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F5465E0A2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 00:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbjADW4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 17:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234571AbjADW4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 17:56:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7644730C
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 14:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672872927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YDqbXjeAi3fC7Raz+Oh8InMZYaeFp0RXTarC/jVXe5Y=;
        b=E4808Jt6ZVAbUbRgITjCOarR9mwP7JuMY0dtjEyiRbWcBhIeJ1fSpKCFjfwBpOzWw2QKhe
        rlLfsehmBF6Zi4Bo0+PT6MD/Bd+hFjVD4S4qAMCw93B4DFZWihdkptDcIbMk26pC5F9bnf
        ODYC7K+QdpCrt/5IaPuv2O1R7qxfKr8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-582-27EBYC0hPCGPXt5ZQm7vjA-1; Wed, 04 Jan 2023 17:52:15 -0500
X-MC-Unique: 27EBYC0hPCGPXt5ZQm7vjA-1
Received: by mail-qk1-f198.google.com with SMTP id v7-20020a05620a0f0700b006faffce43b2so23816237qkl.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 14:52:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDqbXjeAi3fC7Raz+Oh8InMZYaeFp0RXTarC/jVXe5Y=;
        b=vD3/78GlTir0y7kNibwUvoHI6pei0hR2kiEVQsnqrHqzksyx+gjJ9X3t6DywKd5RLk
         C+6//M5rPsnohrHNQjhz/0SLMUYN76jRJhZhCse131NjlDDYcIhTX1k9vKw94Y/PH8mR
         ZVUHEI/SNmKW4GwWtSMAEHqa1cWQHMHFVg80R0dqjs67znLhYV5ZyVEk83Ce8rQd6n1y
         OATKH+DPpjJMfKOTtcuJvYUREpJ/jjvmphIkAQ+FSmyDgm+vh9Sturushx017lkj7OMI
         1nNc3ShNJrUJVkf8ygJoZJE/X/JHYrA9OBWxYELhrUzyxJl+mg0e5RyC4+6mWimPtjcb
         MSpA==
X-Gm-Message-State: AFqh2kr4ul5JSispevfv/FoJVve2R9GU/GPN0/rpRqAVmXQp0jHp575N
        K3qefJBo9tYsRA1N/uUr75A8K3eh2lgnFZWwPK2l9/00la3wO+a+lsBlvWlgxROdrIPWZjpQIYx
        C1p1kPhdyDk2fLsmlKrcN9ZTs
X-Received: by 2002:a05:622a:5a98:b0:3ab:8c3f:328b with SMTP id fz24-20020a05622a5a9800b003ab8c3f328bmr54270798qtb.4.1672872735075;
        Wed, 04 Jan 2023 14:52:15 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs1Sxv8n1AMZb/GH6LHO27LqRI5J2ATLlS4R+n+Mc6li+QeToMA1bMR//t6nBuvUswKomKeqQ==
X-Received: by 2002:a05:622a:5a98:b0:3ab:8c3f:328b with SMTP id fz24-20020a05622a5a9800b003ab8c3f328bmr54270772qtb.4.1672872734836;
        Wed, 04 Jan 2023 14:52:14 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-39-70-52-228-144.dsl.bell.ca. [70.52.228.144])
        by smtp.gmail.com with ESMTPSA id r1-20020a05620a298100b006eeb3165565sm24654710qkp.80.2023.01.04.14.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 14:52:14 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/3] mm/mprotect: Use long for page accountings and retval
Date:   Wed,  4 Jan 2023 17:52:06 -0500
Message-Id: <20230104225207.1066932-3-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230104225207.1066932-1-peterx@redhat.com>
References: <20230104225207.1066932-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to use type "long" for page accountings and retval across the whole
procedure of change_protection().

The change should have shrinked the possible maximum page number to be half
comparing to previous (ULONG_MAX / 2), but it shouldn't overflow on any
system either because the maximum possible pages touched by change
protection should be ULONG_MAX / PAGE_SIZE.

Two reasons to switch from "unsigned long" to "long":

  1. It suites better on count_vm_numa_events(), whose 2nd parameter takes
     a long type.

  2. It paves way for returning negative (error) values in the future.

Currently the only caller that consumes this retval is change_prot_numa(),
where the unsigned long was converted to an int.  Since at it, touching up
the numa code to also take a long, so it'll avoid any possible overflow too
during the int-size convertion.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/hugetlb.h |  4 ++--
 include/linux/mm.h      |  2 +-
 mm/hugetlb.c            |  4 ++--
 mm/mempolicy.c          |  2 +-
 mm/mprotect.c           | 26 +++++++++++++-------------
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index b6b10101bea7..e3aa336df900 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -248,7 +248,7 @@ void hugetlb_vma_lock_release(struct kref *kref);
 
 int pmd_huge(pmd_t pmd);
 int pud_huge(pud_t pud);
-unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
+long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot,
 		unsigned long cp_flags);
 
@@ -437,7 +437,7 @@ static inline void move_hugetlb_state(struct folio *old_folio,
 {
 }
 
-static inline unsigned long hugetlb_change_protection(
+static inline long hugetlb_change_protection(
 			struct vm_area_struct *vma, unsigned long address,
 			unsigned long end, pgprot_t newprot,
 			unsigned long cp_flags)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c37f9330f14e..86fe17e6ded7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2132,7 +2132,7 @@ static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma
 }
 bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
-extern unsigned long change_protection(struct mmu_gather *tlb,
+extern long change_protection(struct mmu_gather *tlb,
 			      struct vm_area_struct *vma, unsigned long start,
 			      unsigned long end, unsigned long cp_flags);
 extern int mprotect_fixup(struct mmu_gather *tlb, struct vm_area_struct *vma,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 017d9159cddf..84bc665c7c86 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6613,7 +6613,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	return i ? i : err;
 }
 
-unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
+long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end,
 		pgprot_t newprot, unsigned long cp_flags)
 {
@@ -6622,7 +6622,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	pte_t *ptep;
 	pte_t pte;
 	struct hstate *h = hstate_vma(vma);
-	unsigned long pages = 0, psize = huge_page_size(h);
+	long pages = 0, psize = huge_page_size(h);
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
 	unsigned long last_addr_mask;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d3558248a0f0..a86b8f15e2f0 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -631,7 +631,7 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
 			unsigned long addr, unsigned long end)
 {
 	struct mmu_gather tlb;
-	int nr_updated;
+	long nr_updated;
 
 	tlb_gather_mmu(&tlb, vma->vm_mm);
 
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 71358e45a742..0af22ab59ea8 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -80,13 +80,13 @@ bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
 	return pte_dirty(pte);
 }
 
-static unsigned long change_pte_range(struct mmu_gather *tlb,
+static long change_pte_range(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, pmd_t *pmd, unsigned long addr,
 		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
 {
 	pte_t *pte, oldpte;
 	spinlock_t *ptl;
-	unsigned long pages = 0;
+	long pages = 0;
 	int target_node = NUMA_NO_NODE;
 	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
@@ -353,13 +353,13 @@ uffd_wp_protect_file(struct vm_area_struct *vma, unsigned long cp_flags)
 		}							\
 	} while (0)
 
-static inline unsigned long change_pmd_range(struct mmu_gather *tlb,
+static inline long change_pmd_range(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, pud_t *pud, unsigned long addr,
 		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
 {
 	pmd_t *pmd;
 	unsigned long next;
-	unsigned long pages = 0;
+	long pages = 0;
 	unsigned long nr_huge_updates = 0;
 	struct mmu_notifier_range range;
 
@@ -367,7 +367,7 @@ static inline unsigned long change_pmd_range(struct mmu_gather *tlb,
 
 	pmd = pmd_offset(pud, addr);
 	do {
-		unsigned long this_pages;
+		long this_pages;
 
 		next = pmd_addr_end(addr, end);
 
@@ -437,13 +437,13 @@ static inline unsigned long change_pmd_range(struct mmu_gather *tlb,
 	return pages;
 }
 
-static inline unsigned long change_pud_range(struct mmu_gather *tlb,
+static inline long change_pud_range(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, p4d_t *p4d, unsigned long addr,
 		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
 {
 	pud_t *pud;
 	unsigned long next;
-	unsigned long pages = 0;
+	long pages = 0;
 
 	pud = pud_offset(p4d, addr);
 	do {
@@ -458,13 +458,13 @@ static inline unsigned long change_pud_range(struct mmu_gather *tlb,
 	return pages;
 }
 
-static inline unsigned long change_p4d_range(struct mmu_gather *tlb,
+static inline long change_p4d_range(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, pgd_t *pgd, unsigned long addr,
 		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
 {
 	p4d_t *p4d;
 	unsigned long next;
-	unsigned long pages = 0;
+	long pages = 0;
 
 	p4d = p4d_offset(pgd, addr);
 	do {
@@ -479,14 +479,14 @@ static inline unsigned long change_p4d_range(struct mmu_gather *tlb,
 	return pages;
 }
 
-static unsigned long change_protection_range(struct mmu_gather *tlb,
+static long change_protection_range(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, unsigned long addr,
 		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgd;
 	unsigned long next;
-	unsigned long pages = 0;
+	long pages = 0;
 
 	BUG_ON(addr >= end);
 	pgd = pgd_offset(mm, addr);
@@ -505,12 +505,12 @@ static unsigned long change_protection_range(struct mmu_gather *tlb,
 	return pages;
 }
 
-unsigned long change_protection(struct mmu_gather *tlb,
+long change_protection(struct mmu_gather *tlb,
 		       struct vm_area_struct *vma, unsigned long start,
 		       unsigned long end, unsigned long cp_flags)
 {
 	pgprot_t newprot = vma->vm_page_prot;
-	unsigned long pages;
+	long pages;
 
 	BUG_ON((cp_flags & MM_CP_UFFD_WP_ALL) == MM_CP_UFFD_WP_ALL);
 
-- 
2.37.3

