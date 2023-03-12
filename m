Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3806B6CA7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 00:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjCLXmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 19:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjCLXmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 19:42:35 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177D32B9DD
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 16:42:34 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id o5-20020a05600c510500b003ec0e4ec6deso3673811wms.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 16:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678664552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5BwzPdb3pP6HQP4bpfNX6Ih3sOxfK6TuzT4vYnYmzI=;
        b=maz9e2QTegb5aGWaMrUn0W1T4Yb7pAPV4qShHMkAP0jmTAZnGYuceUYaHypxk3ZK3n
         ZDBqAaSh4+ktG95WP3CVzvvsS2QYlwldP0jD7mTJmW1UGRN168RC1lxMVOZZ1PQh6TOP
         +y2rQ91YejaLYBVYdHPFlUg3gA+SBPTgCXZkunTCQq/KKrnRLP5bUKBFIC/AQiIgFbRE
         9s1UuvtwQdsPaN9SJ22GP58vW9sS051TMmx+qiNlQayml8SjCelQJT8pch0Nw/dG8/SL
         tYw6OY+zWYtLnjRJ7LUlFPQgbzFk8ileybTIoNKp4/+CPVyIglWvzyNCWtisu9Kn/kcB
         nHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678664552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5BwzPdb3pP6HQP4bpfNX6Ih3sOxfK6TuzT4vYnYmzI=;
        b=Ncnfm4ip9PHNKcEfFoj5SqqjNJ+L4Bpfsr/g/kBHbhue7yrwwkfzoqcHcjMms+0RZw
         uyw+CR+C4/s7iPZYQWOqW5X7dYbvQnBSo7CLLzqzdA8/vROCA53vGCjVpXwn09MP1/ih
         QKekHqVB/beIjVx9GBfpw4HBnNySP3btLbmf61dvkUhwoNQV/JRmw3moGc+fvZAWoyj1
         dhWSonWJrvFzfKTNAtormTQylcAoaMFatOcXyOc0inxSLFDtfogiNT78wLfpxe7I9yXE
         Bq9U27Fd9YaCKS7ck9NRlMEwxhUvszQWy2mFNpzQHHFb6mfimvZHOcQCTERq9CW04lfA
         ER3Q==
X-Gm-Message-State: AO0yUKXr0O1jsUzY3w6GcwS35GLEW+BEl0Kf5Knp0BE9VARtHZxem1+y
        7yiLAhhNdPr/sEUuRRTsIRY=
X-Google-Smtp-Source: AK7set88QQ6jrd1M0hrmNofJDYtEfX1glIjDn7W2t6EdL0uThkNjlqD3H5zcW/MHqEOtS/rhvVi/CQ==
X-Received: by 2002:a05:600c:1d29:b0:3eb:3945:d3f4 with SMTP id l41-20020a05600c1d2900b003eb3945d3f4mr10055016wms.2.1678664552343;
        Sun, 12 Mar 2023 16:42:32 -0700 (PDT)
Received: from lucifer.home (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.googlemail.com with ESMTPSA id iz20-20020a05600c555400b003ed201ddef2sm3698376wmb.2.2023.03.12.16.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 16:42:31 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Christian Konig <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH 2/3] mm: Remove vmf_insert_pfn_xxx_prot() for huge page-table entries
Date:   Sun, 12 Mar 2023 23:40:14 +0000
Message-Id: <604c2ad79659d4b8a6e3e1611c6219d5d3233988.1678661628.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678661628.git.lstoakes@gmail.com>
References: <cover.1678661628.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This functionality's sole user, the drm ttm module, removed support for it
in commit 0d979509539e ("drm/ttm: remove ttm_bo_vm_insert_huge()") as the
whole approach is currently unworkable without a PMD/PUD special bit and
updates to GUP.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 include/linux/huge_mm.h | 39 ++-------------------------------------
 mm/huge_memory.c        | 31 +++++++++++++------------------
 2 files changed, 15 insertions(+), 55 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 70bd867eba94..3c52fc9d85dc 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -39,44 +39,9 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		    pmd_t *pmd, unsigned long addr, pgprot_t newprot,
 		    unsigned long cp_flags);
-vm_fault_t vmf_insert_pfn_pmd_prot(struct vm_fault *vmf, pfn_t pfn,
-				   pgprot_t pgprot, bool write);
 
-/**
- * vmf_insert_pfn_pmd - insert a pmd size pfn
- * @vmf: Structure describing the fault
- * @pfn: pfn to insert
- * @pgprot: page protection to use
- * @write: whether it's a write fault
- *
- * Insert a pmd size pfn. See vmf_insert_pfn() for additional info.
- *
- * Return: vm_fault_t value.
- */
-static inline vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn,
-					    bool write)
-{
-	return vmf_insert_pfn_pmd_prot(vmf, pfn, vmf->vma->vm_page_prot, write);
-}
-vm_fault_t vmf_insert_pfn_pud_prot(struct vm_fault *vmf, pfn_t pfn,
-				   pgprot_t pgprot, bool write);
-
-/**
- * vmf_insert_pfn_pud - insert a pud size pfn
- * @vmf: Structure describing the fault
- * @pfn: pfn to insert
- * @pgprot: page protection to use
- * @write: whether it's a write fault
- *
- * Insert a pud size pfn. See vmf_insert_pfn() for additional info.
- *
- * Return: vm_fault_t value.
- */
-static inline vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn,
-					    bool write)
-{
-	return vmf_insert_pfn_pud_prot(vmf, pfn, vmf->vma->vm_page_prot, write);
-}
+vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
+vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
 
 enum transparent_hugepage_flag {
 	TRANSPARENT_HUGEPAGE_NEVER_DAX,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b0ab247939e0..5a0e5e84ab13 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -889,23 +889,20 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 }
 
 /**
- * vmf_insert_pfn_pmd_prot - insert a pmd size pfn
+ * vmf_insert_pfn_pmd - insert a pmd size pfn
  * @vmf: Structure describing the fault
  * @pfn: pfn to insert
- * @pgprot: page protection to use
  * @write: whether it's a write fault
  *
- * Insert a pmd size pfn. See vmf_insert_pfn() for additional info and
- * also consult the vmf_insert_mixed_prot() documentation when
- * @pgprot != @vmf->vma->vm_page_prot.
+ * Insert a pmd size pfn. See vmf_insert_pfn() for additional info.
  *
  * Return: vm_fault_t value.
  */
-vm_fault_t vmf_insert_pfn_pmd_prot(struct vm_fault *vmf, pfn_t pfn,
-				   pgprot_t pgprot, bool write)
+vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
 {
 	unsigned long addr = vmf->address & PMD_MASK;
 	struct vm_area_struct *vma = vmf->vma;
+	pgprot_t pgprot = vma->vm_page_prot;
 	pgtable_t pgtable = NULL;
 
 	/*
@@ -933,7 +930,7 @@ vm_fault_t vmf_insert_pfn_pmd_prot(struct vm_fault *vmf, pfn_t pfn,
 	insert_pfn_pmd(vma, addr, vmf->pmd, pfn, pgprot, write, pgtable);
 	return VM_FAULT_NOPAGE;
 }
-EXPORT_SYMBOL_GPL(vmf_insert_pfn_pmd_prot);
+EXPORT_SYMBOL_GPL(vmf_insert_pfn_pmd);
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 static pud_t maybe_pud_mkwrite(pud_t pud, struct vm_area_struct *vma)
@@ -944,9 +941,10 @@ static pud_t maybe_pud_mkwrite(pud_t pud, struct vm_area_struct *vma)
 }
 
 static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
-		pud_t *pud, pfn_t pfn, pgprot_t prot, bool write)
+		pud_t *pud, pfn_t pfn, bool write)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	pgprot_t prot = vma->vm_page_prot;
 	pud_t entry;
 	spinlock_t *ptl;
 
@@ -980,23 +978,20 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 }
 
 /**
- * vmf_insert_pfn_pud_prot - insert a pud size pfn
+ * vmf_insert_pfn_pud - insert a pud size pfn
  * @vmf: Structure describing the fault
  * @pfn: pfn to insert
- * @pgprot: page protection to use
  * @write: whether it's a write fault
  *
- * Insert a pud size pfn. See vmf_insert_pfn() for additional info and
- * also consult the vmf_insert_mixed_prot() documentation when
- * @pgprot != @vmf->vma->vm_page_prot.
+ * Insert a pud size pfn. See vmf_insert_pfn() for additional info.
  *
  * Return: vm_fault_t value.
  */
-vm_fault_t vmf_insert_pfn_pud_prot(struct vm_fault *vmf, pfn_t pfn,
-				   pgprot_t pgprot, bool write)
+vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 {
 	unsigned long addr = vmf->address & PUD_MASK;
 	struct vm_area_struct *vma = vmf->vma;
+	pgprot_t pgprot = vma->vm_page_prot;
 
 	/*
 	 * If we had pud_special, we could avoid all these restrictions,
@@ -1014,10 +1009,10 @@ vm_fault_t vmf_insert_pfn_pud_prot(struct vm_fault *vmf, pfn_t pfn,
 
 	track_pfn_insert(vma, &pgprot, pfn);
 
-	insert_pfn_pud(vma, addr, vmf->pud, pfn, pgprot, write);
+	insert_pfn_pud(vma, addr, vmf->pud, pfn, write);
 	return VM_FAULT_NOPAGE;
 }
-EXPORT_SYMBOL_GPL(vmf_insert_pfn_pud_prot);
+EXPORT_SYMBOL_GPL(vmf_insert_pfn_pud);
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 
 static void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
-- 
2.39.2

