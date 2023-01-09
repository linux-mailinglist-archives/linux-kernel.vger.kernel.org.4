Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B12D663208
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237714AbjAIU5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237759AbjAIU4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:56:11 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F7A8BF16
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:54:42 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4c6bd2981d8so66551767b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AwPKUNzvgMd9Kf7LcbfBV8kCxW3mIJvnnhSUrm6UVIM=;
        b=PUe2nQQDxcDIZZYDvSnvU7x/WgxDknYnlEY7L4Z8C3iDtsfKJ6ipNpTRC5N0+o397w
         Zlr5LNQCm8jIObT2qwQm+iFFbmfCf3so91ezlzHPCZn3+26NE3G0VG8VYTX74hVikOaP
         hXnC1hgxqMkKtkdKCm4ja7+1OhhfuKZ8QD3Yt7TKznRnTkaA7k7w1KBOtddu/hOGuQp+
         p5yPJ6DKvl3ugNtnIXuytmcOf3bXiekUrutBQkFLl092Px87ewbl/fVBINgSpD18bwdH
         tuw54xfQPY3gshaLVXYSV9JTTyWxRw4/COwHM+KjA25VHZQUSDq3VtesXUsv3nuWcWdU
         OueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AwPKUNzvgMd9Kf7LcbfBV8kCxW3mIJvnnhSUrm6UVIM=;
        b=YdMaEkicky6wdP1JKSEXim3FmXKEud5lmJ2XZxkOaulRGgp9tnIG3+RSqetcvnaOd8
         xMNDQMbb0ItU+auSXS0Ps1t+MR6YZp639Lz03jPdLNNPZrfhHTZa7Qfa2ACZrGXdcHLy
         ByF+QMOT4Q9DVUhLDY4i91GZurReuyhH47Rs6pEFXNGuSOFtOdQv3/oeiFbM+goFNu1d
         FLairNgoYobDFBu4CCDLZLJPQ+oXfaddGANTpMwaOS5sJ1qqZlNpISWzuOX5Qh5sLnMD
         E2ffAVrvHgUKn0vPy58qPyAvM8K7DYEEsVNbQQg35BpSlgADAAZLflk29UhLDSSXjZpd
         1XTg==
X-Gm-Message-State: AFqh2koECELcScCp90JIcDFNgVhX0C7dhiKw22THVl+yAe3t998G5r0C
        Ad9L/hC0rJSj4O2z4Qpa7OWYPYavYHE=
X-Google-Smtp-Source: AMrXdXsf9qNWBP/q4HbIX0JjhZtra/GO9q6jv0FDi4j+zY41mh+XeX3qFvEfYkTJ9YCl7ccm1I7VEz8cc3E=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a81:4702:0:b0:4cd:f764:1911 with SMTP id
 u2-20020a814702000000b004cdf7641911mr673145ywa.403.1673297681920; Mon, 09 Jan
 2023 12:54:41 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:53:19 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-25-surenb@google.com>
Subject: [PATCH 24/41] mm: conditionally write-lock VMA in free_pgtables
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        surenb@google.com
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

Normally free_pgtables needs to lock affected VMAs except for the case
when VMAs were isolated under VMA write-lock. munmap() does just that,
isolating while holding appropriate locks and then downgrading mmap_lock
and dropping per-VMA locks before freeing page tables.
Add a parameter to free_pgtables and unmap_region for such scenario.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/internal.h |  2 +-
 mm/memory.c   |  6 +++++-
 mm/mmap.c     | 18 ++++++++++++------
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index bcf75a8b032d..5ea4ff1a70e7 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -87,7 +87,7 @@ void folio_activate(struct folio *folio);
 
 void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
 		   struct vm_area_struct *start_vma, unsigned long floor,
-		   unsigned long ceiling);
+		   unsigned long ceiling, bool lock_vma);
 void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
 
 struct zap_details;
diff --git a/mm/memory.c b/mm/memory.c
index 2fabf89b2be9..9ece18548db1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -348,7 +348,7 @@ void free_pgd_range(struct mmu_gather *tlb,
 
 void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
 		   struct vm_area_struct *vma, unsigned long floor,
-		   unsigned long ceiling)
+		   unsigned long ceiling, bool lock_vma)
 {
 	MA_STATE(mas, mt, vma->vm_end, vma->vm_end);
 
@@ -366,6 +366,8 @@ void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
 		 * Hide vma from rmap and truncate_pagecache before freeing
 		 * pgtables
 		 */
+		if (lock_vma)
+			vma_write_lock(vma);
 		unlink_anon_vmas(vma);
 		unlink_file_vma(vma);
 
@@ -380,6 +382,8 @@ void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
 			       && !is_vm_hugetlb_page(next)) {
 				vma = next;
 				next = mas_find(&mas, ceiling - 1);
+				if (lock_vma)
+					vma_write_lock(vma);
 				unlink_anon_vmas(vma);
 				unlink_file_vma(vma);
 			}
diff --git a/mm/mmap.c b/mm/mmap.c
index be289e0b693b..0d767ce043af 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -78,7 +78,7 @@ core_param(ignore_rlimit_data, ignore_rlimit_data, bool, 0644);
 static void unmap_region(struct mm_struct *mm, struct maple_tree *mt,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
 		struct vm_area_struct *next, unsigned long start,
-		unsigned long end);
+		unsigned long end, bool lock_vma);
 
 static pgprot_t vm_pgprot_modify(pgprot_t oldprot, unsigned long vm_flags)
 {
@@ -2202,7 +2202,7 @@ static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
 static void unmap_region(struct mm_struct *mm, struct maple_tree *mt,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
 		struct vm_area_struct *next,
-		unsigned long start, unsigned long end)
+		unsigned long start, unsigned long end, bool lock_vma)
 {
 	struct mmu_gather tlb;
 
@@ -2211,7 +2211,8 @@ static void unmap_region(struct mm_struct *mm, struct maple_tree *mt,
 	update_hiwater_rss(mm);
 	unmap_vmas(&tlb, mt, vma, start, end);
 	free_pgtables(&tlb, mt, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
-				 next ? next->vm_start : USER_PGTABLES_CEILING);
+				 next ? next->vm_start : USER_PGTABLES_CEILING,
+				 lock_vma);
 	tlb_finish_mmu(&tlb);
 }
 
@@ -2468,7 +2469,11 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 			mmap_write_downgrade(mm);
 	}
 
-	unmap_region(mm, &mt_detach, vma, prev, next, start, end);
+	/*
+	 * We can free page tables without locking the vmas because they were
+	 * isolated before we downgraded mmap_lock and dropped per-vma locks.
+	 */
+	unmap_region(mm, &mt_detach, vma, prev, next, start, end, !downgrade);
 	/* Statistics and freeing VMAs */
 	mas_set(&mas_detach, start);
 	remove_mt(mm, &mas_detach);
@@ -2785,7 +2790,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vma->vm_file = NULL;
 
 	/* Undo any partial mapping done by a device driver. */
-	unmap_region(mm, mas.tree, vma, prev, next, vma->vm_start, vma->vm_end);
+	unmap_region(mm, mas.tree, vma, prev, next, vma->vm_start, vma->vm_end,
+		     true);
 	if (file && (vm_flags & VM_SHARED))
 		mapping_unmap_writable(file->f_mapping);
 free_vma:
@@ -3130,7 +3136,7 @@ void exit_mmap(struct mm_struct *mm)
 	mmap_write_lock(mm);
 	mt_clear_in_rcu(&mm->mm_mt);
 	free_pgtables(&tlb, &mm->mm_mt, vma, FIRST_USER_ADDRESS,
-		      USER_PGTABLES_CEILING);
+		      USER_PGTABLES_CEILING, true);
 	tlb_finish_mmu(&tlb);
 
 	/*
-- 
2.39.0

