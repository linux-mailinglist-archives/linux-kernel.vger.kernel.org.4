Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E886A4840
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjB0Ria (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjB0Rhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:37:51 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9C5241FE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:24 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536cad819c7so153272717b3.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q4IoNs8/2s63po158n4pCM20IldvB6LsORlyoWZYhDA=;
        b=bS7cuWSTvikNO5/1/KRQJLPoIX97MSDopLQjzIYhd9M4ATiilp+2nnzhJYwm+xkfAw
         CA4PkRjLFErdI6iJpWSrCW/0zzxhXa3aDXwe+0SrD6SM1VCA8VjhRHuY2QcHPeKNakQW
         P+DawdVxSLtrg/I5seo5dukO8m39Wj2s4hqiK8xve+bjTmkIkwxAaDpb3/Zo6UgfUlrQ
         EPB7WXnu31e6AaMIPOJ6t49a2aYPUJ8xG3eJeremwZc8bnMi2k5b+Q5ZfPziQ2FlHzzp
         w2I2hG7tsvd97Sj45eHKWDA+0nQshMfUHld0I+kGvTMYTZlSoT7VYdn14KEIlMTUGdtE
         e10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q4IoNs8/2s63po158n4pCM20IldvB6LsORlyoWZYhDA=;
        b=bWqMSu9z44RoJQR2jKkzEdgkMd6Xom6W1IYQFspFLgtrbClH5EqK2sdQgU9IXbIB1F
         5gpzj6cgATZnwmVILSxu6uoYia5dXJmF2Vdbl06y+aFdLkFkgoVqX85PBVuWtXXxEP2Z
         HgWTn4VFM7mBQYV6m938lzDXVhXJEixRaId2QNTL04IWnIAX2EeONVHcfNtLY3IutJ2v
         jnmL1RZfi082Fijgn0bxxLqZLMw41yFOi6irKyiDxh8FR/kuhaV2JbZ6ZEuSso6U9Pav
         zXE4Zb7B56odAJD2AEtuHf8Uu8wppmG2aA2trRe0lq/UMcmw1miBZDdazWmAUNcuIWYE
         oxsA==
X-Gm-Message-State: AO0yUKUWmwCVf+Pdplbi+TG957cHl+fK85y3V6wXimNL2myHzawgiUj1
        2Hvo40hHsbbpp3Wvg+qW7sszFi8TdkM=
X-Google-Smtp-Source: AK7set/PpfdmNkoTcymoja/27Ir9z6PS18iSX+0Y7AEWmCWJmOIOQsn+Wv7zMECojEbGHKP0cPXfu+hFpqg=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:e1f6:21d1:eead:3897])
 (user=surenb job=sendgmr) by 2002:a05:6902:1388:b0:855:fdcb:4467 with SMTP id
 x8-20020a056902138800b00855fdcb4467mr287176ybu.0.1677519442170; Mon, 27 Feb
 2023 09:37:22 -0800 (PST)
Date:   Mon, 27 Feb 2023 09:36:18 -0800
In-Reply-To: <20230227173632.3292573-1-surenb@google.com>
Mime-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227173632.3292573-20-surenb@google.com>
Subject: [PATCH v4 19/33] mm: conditionally write-lock VMA in free_pgtables
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        chriscli@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, rppt@kernel.org, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Suren Baghdasaryan <surenb@google.com>
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
Add a parameter to free_pgtables for such scenario.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/internal.h | 2 +-
 mm/memory.c   | 6 +++++-
 mm/mmap.c     | 5 +++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 08ce56dbb1d9..fce94775819c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -105,7 +105,7 @@ void folio_activate(struct folio *folio);
 
 void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
 		   struct vm_area_struct *start_vma, unsigned long floor,
-		   unsigned long ceiling);
+		   unsigned long ceiling, bool mm_wr_locked);
 void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
 
 struct zap_details;
diff --git a/mm/memory.c b/mm/memory.c
index bfa3100ec5a3..f7f412833e42 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -348,7 +348,7 @@ void free_pgd_range(struct mmu_gather *tlb,
 
 void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
 		   struct vm_area_struct *vma, unsigned long floor,
-		   unsigned long ceiling)
+		   unsigned long ceiling, bool mm_wr_locked)
 {
 	MA_STATE(mas, mt, vma->vm_end, vma->vm_end);
 
@@ -366,6 +366,8 @@ void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
 		 * Hide vma from rmap and truncate_pagecache before freeing
 		 * pgtables
 		 */
+		if (mm_wr_locked)
+			vma_start_write(vma);
 		unlink_anon_vmas(vma);
 		unlink_file_vma(vma);
 
@@ -380,6 +382,8 @@ void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
 			       && !is_vm_hugetlb_page(next)) {
 				vma = next;
 				next = mas_find(&mas, ceiling - 1);
+				if (mm_wr_locked)
+					vma_start_write(vma);
 				unlink_anon_vmas(vma);
 				unlink_file_vma(vma);
 			}
diff --git a/mm/mmap.c b/mm/mmap.c
index f7ed357056c4..ec745586785c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2152,7 +2152,8 @@ static void unmap_region(struct mm_struct *mm, struct maple_tree *mt,
 	update_hiwater_rss(mm);
 	unmap_vmas(&tlb, mt, vma, start, end, mm_wr_locked);
 	free_pgtables(&tlb, mt, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
-				 next ? next->vm_start : USER_PGTABLES_CEILING);
+				 next ? next->vm_start : USER_PGTABLES_CEILING,
+				 mm_wr_locked);
 	tlb_finish_mmu(&tlb);
 }
 
@@ -3056,7 +3057,7 @@ void exit_mmap(struct mm_struct *mm)
 	mmap_write_lock(mm);
 	mt_clear_in_rcu(&mm->mm_mt);
 	free_pgtables(&tlb, &mm->mm_mt, vma, FIRST_USER_ADDRESS,
-		      USER_PGTABLES_CEILING);
+		      USER_PGTABLES_CEILING, true);
 	tlb_finish_mmu(&tlb);
 
 	/*
-- 
2.39.2.722.g9855ee24e9-goog

