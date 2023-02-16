Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE8C698BB7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjBPFUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjBPFTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:19:21 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98BD42DCE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:45 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k9-20020a25bec9000000b00944353b6a81so863507ybm.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=65rn53nYPCehqawxI5VHHUH5OXR7IFklQh11X90VOGk=;
        b=ngrSSnFGdDPlYz5zuJYWd2ZcJdDDxwAT/RtnIL5xzVfAFVgHCKIj7A9xwEDcTyX2aB
         3vsZSlkeyPVpcwi1aa9l93eu/icfxKL0DIaqQVOS2lNklMJwu2jpUpq532q1GD3mJcXZ
         OYyJWX25F7RdsRsm0bO+ULQDs6kU+hJx2yHcqT8VTisE8SVpLjiLy4deYJxyu/llv5yd
         uNDnBwf4OPlsNNTMONtuv4dnuvjdk8hbLw2jK3U2tc3OA2ZTvVJ3/lGJPyy4Jcy7H5Vt
         +ZqHtuuBA7mxmkHLm02ywaCux2tqtjmQCbr0/F6E0nSC73lfB2u+G7wX3tsYtQZiJlY+
         ecqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=65rn53nYPCehqawxI5VHHUH5OXR7IFklQh11X90VOGk=;
        b=If914xyNZ6E6JKn7JwPiydaFH9m235YeOJJjL/0kh0TjuFOcDzgmXtRrXJhjCMHDBo
         SewVQlA9iQFZBoC2ydiSQscZ46Vt51irOxbqdbPemMpg6t4QQ9fjhsRimf33SdhFuSVw
         rE/6vInHrhZLQcPnU590LauLe1Vup2MsFv1Rnb5q8DVXWBZ3YJKLkF37lWqgUfHm9uTx
         Z3qzTY3yMkJQ4I4Mw9VJOc1bKaiA5eGnJTVjUUrbdkUMH12hp1OWvbTDI/KEhG2nMZQL
         58Rs2Fp9jmqQiE4dyZHQS0WDg8/zpwDvWr+KZt4LjyoPcPcbv42jkbo2eDdN9zBK7AwB
         EM+Q==
X-Gm-Message-State: AO0yUKUKFoUUb+u5EjrxgeHJRO/K9ZmhN9fdKH/eDARrjH331nWPjWuO
        GQcXRMn9bh/ItRfqN+A5OKCVL+/6IAE=
X-Google-Smtp-Source: AK7set9eBfEal0C1jR4VjCmFFWO3/hvdavzvid6pMzzd4bvHowMVw43Kn34On8e4ZBDtcDdaQHGRoUI6tN4=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f781:d5ed:1806:6ebb])
 (user=surenb job=sendgmr) by 2002:a81:b704:0:b0:52b:fcf0:4fd1 with SMTP id
 v4-20020a81b704000000b0052bfcf04fd1mr5ywh.1.1676524723168; Wed, 15 Feb 2023
 21:18:43 -0800 (PST)
Date:   Wed, 15 Feb 2023 21:17:35 -0800
In-Reply-To: <20230216051750.3125598-1-surenb@google.com>
Mime-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230216051750.3125598-21-surenb@google.com>
Subject: [PATCH v3 20/35] mm: conditionally write-lock VMA in free_pgtables
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
index fc01fd092ea5..400c302fbf47 100644
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
index f456f3b5049c..8177c59ffd2d 100644
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
index aaa359a147b2..118b2246bba9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2157,7 +2157,8 @@ static void unmap_region(struct mm_struct *mm, struct maple_tree *mt,
 	update_hiwater_rss(mm);
 	unmap_vmas(&tlb, mt, vma, start, end, mm_wr_locked);
 	free_pgtables(&tlb, mt, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
-				 next ? next->vm_start : USER_PGTABLES_CEILING);
+				 next ? next->vm_start : USER_PGTABLES_CEILING,
+				 mm_wr_locked);
 	tlb_finish_mmu(&tlb);
 }
 
@@ -3069,7 +3070,7 @@ void exit_mmap(struct mm_struct *mm)
 	mmap_write_lock(mm);
 	mt_clear_in_rcu(&mm->mm_mt);
 	free_pgtables(&tlb, &mm->mm_mt, vma, FIRST_USER_ADDRESS,
-		      USER_PGTABLES_CEILING);
+		      USER_PGTABLES_CEILING, true);
 	tlb_finish_mmu(&tlb);
 
 	/*
-- 
2.39.1

