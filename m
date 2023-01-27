Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A3567EEA5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbjA0Tor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjA0TnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:43:24 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F98241DB
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:43:04 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5066df312d7so65762327b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PbZvlTacNRMtTYgLZEFyk5N8KO4rHMcD13osXtjRKQc=;
        b=dIXUHHJyt3zldvcJ25OA8M/N2ekAkSadxrM4Vc86G1vAxHUN7FQNbSzlWzbH3EF3Ay
         Np/mC7lgd8yNrbdx+fJZdOiPs5Ax7Y+isaOSeA0W3slHJVunqRE0R5gvKOYJUJLOV6vy
         eusS7uxTBSUHthbBE/M+AcF029iuITRiXxkeDAE1bHTcC4qSxwHlMi32ImCbpO9h9EMV
         +wvjzOskJitBDhg128jcOLxlukATYCWhVPwB6m3ynKWMcyTvnD5SZLfuK2oGD5H+Rl4/
         hAABUVAQozzvBCIG2lhb5atfzqUlxx9w7Rjl6rs3/T9zVK0hATJevSe9VLcJ9uJd0aXA
         HxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PbZvlTacNRMtTYgLZEFyk5N8KO4rHMcD13osXtjRKQc=;
        b=OKM2kmpli9KDeUFRuIAXDrdxpZOJYp8dv2/63eL69ttgejgCS+EsZUlJA4VrOOM3UW
         BL6G0wRFMHsNk1RSDZpx7WDYC7LrH0rVKJWGcmsY8VHIWtwQpqJ4aLIfBI6cAG2v9bMy
         E0oR0cNENUDepWaos+sR3+hfXD5sKgvGkPXgluCn2DWtZKBJPnEXTqqYsHXgiDKUVeav
         UNRt56YcZS+ZLX0qqyBsqkdp+2x+u5ZHGvxD5XU2TLpy2GwtXE8SpSCX/FyQEOU/XfCn
         R3mmYNA/ge/p7O/+OeviQeNO2G+7vVqgektrIj5L4DEu38jg3hpfTEeflrqe1/RlAnBG
         kqKQ==
X-Gm-Message-State: AFqh2ko0Ble8j1LpeqmY2aFD5MF7qmLw1UYTHcYIgDrHvynN3MT5BQrb
        jujQt567/JM1MpY/Fv0KdTbje95qbmo=
X-Google-Smtp-Source: AMrXdXtxOfNby/WJjyD0PPf8WyFmfovtGs47EqfediusuKgjOEAtqZl1SXyt3bJWMQsRbQEhpFz5LQpAf70=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:4e19:be9:c5d0:8483])
 (user=surenb job=sendgmr) by 2002:a81:cd4:0:b0:4dc:e929:40fa with SMTP id
 203-20020a810cd4000000b004dce92940famr5633708ywm.331.1674848519684; Fri, 27
 Jan 2023 11:41:59 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:40:56 -0800
In-Reply-To: <20230127194110.533103-1-surenb@google.com>
Mime-Version: 1.0
References: <20230127194110.533103-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230127194110.533103-20-surenb@google.com>
Subject: [PATCH v2 19/33] mm: conditionally write-lock VMA in free_pgtables
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
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
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
Add a parameter to free_pgtables for such scenario.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/internal.h | 2 +-
 mm/memory.c   | 6 +++++-
 mm/mmap.c     | 5 +++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 90bb2078444c..52d7e9c2e58f 100644
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
index 7a04a1130ec1..d48c76e9fa57 100644
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
index 5bdfd087b632..57cb3a2ac9b1 100644
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

