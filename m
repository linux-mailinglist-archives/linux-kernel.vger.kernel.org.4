Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFD265476A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 21:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiLVUmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 15:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLVUmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:42:12 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EFC11F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 12:42:11 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id z12so2304435qtv.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 12:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tZV/0sDZ7NRfwGKBq6mHwBasInBGHVDFUdPPeXHm9Rg=;
        b=TzW24rCa4e8C15tFOOWZ7pmpUCdmpbw+64G2xzNN4/Sq/+QOE6J+K7juRWwFtIvBVw
         L/8k/vuK7JN25MWgSxDvbDhi2Fkvf1liQbDAaO3Se4uFVLbtTgG+3ADI40c/x3fw5QHz
         Lk1LMUyeWj4RoEzCK36scnKywO63MjDfM8bt/qQbvGEtT41hME90BUGcBd8j2P3QBMbp
         9EKK7t4XIOxzUz4DuoIwJ1Vs6k0QpcrzyFMUIxPdv6CKOSxS7FUj7DRSyOG0vhI+yW89
         L7GH3/1PzRPDLHcM/tNndVSmvYSpJPPedNvq5AbaIO/S67kmoat9zl+3EvgVZ22tqEsy
         R4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tZV/0sDZ7NRfwGKBq6mHwBasInBGHVDFUdPPeXHm9Rg=;
        b=x6PSciyc3o1cWIaO9BjTZifxbgzk3Egnm1SFJ4QixLvzbExJG10bBIaC0hIOAvNz6Y
         H7lfQv9UcGJFNamsUragxztLXGHpSopgB8Uj7i7CiAV6fiDvT+LP/UcH0sk6HCcvubve
         SZGn3mW8KsliB02kh7Q+CTk22agYL+Aq1rIMkA52fvXeWuNN52VlQAuKDKyqz4jK7VBr
         H6tBXgjZnzAKbx6ua1K9aUmgaUw+bDpoZnIFYwyIdphyExBElNzAdB5fhMVN/rewv0RV
         x2+LKcLznb+Suz+hxwIsPMsMK62H3B6LNo4Fw/I5oAF8cmJt3Jl5SINQ5Q9yDKC3jplD
         ghPg==
X-Gm-Message-State: AFqh2kqqWamK63S9ncmwcHE3/+vsNbFNySoz6XKPeyuF+Ktf75esk/ho
        4g2E7I9RRlfyb5wmVsmcVjP7zg==
X-Google-Smtp-Source: AMrXdXsS4pfVufbB8p+zEzKjunFe2SUSzdllt/cCSVI75tW1M6UEfHywDzvLi3JRZ3B+n4ldFj2Mlg==
X-Received: by 2002:ac8:1085:0:b0:3a9:6b48:a130 with SMTP id a5-20020ac81085000000b003a96b48a130mr10119937qtj.34.1671741730924;
        Thu, 22 Dec 2022 12:42:10 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h19-20020a05620a245300b006f9e103260dsm936918qkn.91.2022.12.22.12.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 12:42:10 -0800 (PST)
Date:   Thu, 22 Dec 2022 12:41:50 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Jann Horn <jannh@google.com>, Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm/khugepaged: fix collapse_pte_mapped_thp() to allow
 anon_vma
Message-ID: <b740c9fb-edba-92ba-59fb-7a5592e5dfc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uprobe_write_opcode() uses collapse_pte_mapped_thp() to restore huge pmd,
when removing a breakpoint from hugepage text: vma->anon_vma is always
set in that case, so undo the prohibition.  And MADV_COLLAPSE ought to be
able to collapse some page tables in a vma which happens to have anon_vma
set from CoWing elsewhere.

Is anon_vma lock required?  Almost not: if any page other than expected
subpage of the non-anon huge page is found in the page table, collapse is
aborted without making any change.  However, it is possible that an anon
page was CoWed from this extent in another mm or vma, in which case a
concurrent lookup might look here: so keep it away while clearing pmd
(but perhaps we shall go back to using pmd_lock() there in future).

Note that collapse_pte_mapped_thp() is exceptional in freeing a page table
without having cleared its ptes: I'm uneasy about that, and had thought
pte_clear()ing appropriate; but exclusive i_mmap lock does fix the problem,
and we would have to move the mmu_notification if clearing those ptes.

Fixes: 8d3c106e19e8 ("mm/khugepaged: take the right locks for page table retraction")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Zach O'Keefe <zokeefe@google.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: <stable@vger.kernel.org>    [5.4+]
---
What this fixes is not a dangerous instability!  But I suggest Cc stable
because uprobes "healing" has regressed in that way, so this should follow
8d3c106e19e8 into those stable releases where it was backported (and may
want adjustment there - I'll supply backports as needed).

 mm/khugepaged.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

--- 6.2-rc/mm/khugepaged.c
+++ linux/mm/khugepaged.c
@@ -1460,14 +1460,6 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	if (!hugepage_vma_check(vma, vma->vm_flags, false, false, false))
 		return SCAN_VMA_CHECK;
 
-	/*
-	 * Symmetry with retract_page_tables(): Exclude MAP_PRIVATE mappings
-	 * that got written to. Without this, we'd have to also lock the
-	 * anon_vma if one exists.
-	 */
-	if (vma->anon_vma)
-		return SCAN_VMA_CHECK;
-
 	/* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
 	if (userfaultfd_wp(vma))
 		return SCAN_PTE_UFFD_WP;
@@ -1567,8 +1559,14 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	}
 
 	/* step 4: remove pte entries */
+	/* we make no change to anon, but protect concurrent anon page lookup */
+	if (vma->anon_vma)
+		anon_vma_lock_write(vma->anon_vma);
+
 	collapse_and_free_pmd(mm, vma, haddr, pmd);
 
+	if (vma->anon_vma)
+		anon_vma_unlock_write(vma->anon_vma);
 	i_mmap_unlock_write(vma->vm_file->f_mapping);
 
 maybe_install_pmd:
