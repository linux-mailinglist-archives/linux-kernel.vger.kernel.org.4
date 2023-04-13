Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D029A6E17EC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 01:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjDMXMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 19:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjDMXMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:12:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1254488
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681427487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yQk3ShNsJBmwBAeq1XAgk+wt78LOM0H1LyrpvOkMJhI=;
        b=Pj0oA1VaVaTBz7Co/mHv7+3QEOlqTk/prCxWkwerwaFt1yDy7Lzmj6IrjslmO3Ryyht08R
        gXKCHMXs9YK4YXdNU3KJWOLEWNgbLW7MKsnBHcu7bjdShCWi8ngSFoVT7nW1fkKCyjuD/N
        9SvoktEMDqwxidZFnkQ/vOQor1M73Os=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-MrpqThBnNPWN7iSdYw2WJA-1; Thu, 13 Apr 2023 19:11:26 -0400
X-MC-Unique: MrpqThBnNPWN7iSdYw2WJA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3e699015faeso6672201cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681427484; x=1684019484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQk3ShNsJBmwBAeq1XAgk+wt78LOM0H1LyrpvOkMJhI=;
        b=g8b6WmadfC2NmQDbfmDyPceJY6eYY8V/U0OXh5egq63F2Vi85m8TrTmvIX1nhzMMmx
         lmH5Eczde+rCPvVtYl/uHuYJtTDMEWT6b+ZbG02iT6pfGa60aDvBfVjyRbK308LxPAMx
         Au35nep0E8WRqfAre1eqEP/rfOjJwM2uNc8UgAxLIEb+fi8wJp/tcrIQvpsJt2iGtPv8
         wwTAh0RLnL2YwyXD6ZDC5kp41UhbsoUvv425gCgu6/WjjaDom3Qs7JNyxZr2r5+AevLD
         62dZGy6IXgnVB7+PHLd4X727R3b5oZjd3JWfLB5KeP0XEuvSwM8fZXYY5qYpBImOFsul
         c59Q==
X-Gm-Message-State: AAQBX9fi2rMT9jOGElttwPmEz6hSo3i98VCN+NY5jLzyMMER5SMUD/N9
        72onLwON3IAnE8Vjpe4tkxNmVhKYnhQvTrkYnmU7ONqAn1qIoiN7XqKQdTU9Xzec1m70cQdILbN
        yupi8hCvZExDzY1l7auVbfShV2AY2bqJxKko8hhEasbOwjyuPDnzfaf+eFrs/Tx1qazMQUrL+c7
        +XWDtl4w==
X-Received: by 2002:a05:622a:19a1:b0:3e3:98cf:68ae with SMTP id u33-20020a05622a19a100b003e398cf68aemr1101164qtc.2.1681427484669;
        Thu, 13 Apr 2023 16:11:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350bljVojz9f9gM3R2vNG1p3GyeG+24EcdnppJPHidpEMFzohOSepYYLSiIIjIIlL/AyTNhMu9Q==
X-Received: by 2002:a05:622a:19a1:b0:3e3:98cf:68ae with SMTP id u33-20020a05622a19a100b003e398cf68aemr1101122qtc.2.1681427484321;
        Thu, 13 Apr 2023 16:11:24 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id g3-20020ac81243000000b003ea1b97acfasm612446qtj.49.2023.04.13.16.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 16:11:23 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-stable <stable@vger.kernel.org>
Subject: [PATCH 1/6] mm/hugetlb: Fix uffd-wp during fork()
Date:   Thu, 13 Apr 2023 19:11:15 -0400
Message-Id: <20230413231120.544685-2-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230413231120.544685-1-peterx@redhat.com>
References: <20230413231120.544685-1-peterx@redhat.com>
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

There're a bunch of things that were wrong:

  - Reading uffd-wp bit from a swap entry should use pte_swp_uffd_wp()
    rather than huge_pte_uffd_wp().

  - When copying over a pte, we should drop uffd-wp bit when
    !EVENT_FORK (aka, when !userfaultfd_wp(dst_vma)).

  - When doing early CoW for private hugetlb (e.g. when the parent page was
    pinned), uffd-wp bit should be properly carried over if necessary.

No bug reported probably because most people do not even care about these
corner cases, but they are still bugs and can be exposed by the recent unit
tests introduced, so fix all of them in one shot.

Cc: linux-stable <stable@vger.kernel.org>
Fixes: bc70fbf269fd ("mm/hugetlb: handle uffd-wp during fork()")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f16b25b1a6b9..7320e64aacc6 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4953,11 +4953,15 @@ static bool is_hugetlb_entry_hwpoisoned(pte_t pte)
 
 static void
 hugetlb_install_folio(struct vm_area_struct *vma, pte_t *ptep, unsigned long addr,
-		     struct folio *new_folio)
+		      struct folio *new_folio, pte_t old)
 {
+	pte_t newpte = make_huge_pte(vma, &new_folio->page, 1);
+
 	__folio_mark_uptodate(new_folio);
 	hugepage_add_new_anon_rmap(new_folio, vma, addr);
-	set_huge_pte_at(vma->vm_mm, addr, ptep, make_huge_pte(vma, &new_folio->page, 1));
+	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(old))
+		newpte = huge_pte_mkuffd_wp(newpte);
+	set_huge_pte_at(vma->vm_mm, addr, ptep, newpte);
 	hugetlb_count_add(pages_per_huge_page(hstate_vma(vma)), vma->vm_mm);
 	folio_set_hugetlb_migratable(new_folio);
 }
@@ -5032,14 +5036,11 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			 */
 			;
 		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry))) {
-			bool uffd_wp = huge_pte_uffd_wp(entry);
-
-			if (!userfaultfd_wp(dst_vma) && uffd_wp)
+			if (!userfaultfd_wp(dst_vma))
 				entry = huge_pte_clear_uffd_wp(entry);
 			set_huge_pte_at(dst, addr, dst_pte, entry);
 		} else if (unlikely(is_hugetlb_entry_migration(entry))) {
 			swp_entry_t swp_entry = pte_to_swp_entry(entry);
-			bool uffd_wp = huge_pte_uffd_wp(entry);
 
 			if (!is_readable_migration_entry(swp_entry) && cow) {
 				/*
@@ -5049,11 +5050,12 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				swp_entry = make_readable_migration_entry(
 							swp_offset(swp_entry));
 				entry = swp_entry_to_pte(swp_entry);
-				if (userfaultfd_wp(src_vma) && uffd_wp)
-					entry = huge_pte_mkuffd_wp(entry);
+				if (userfaultfd_wp(src_vma) &&
+				    pte_swp_uffd_wp(entry))
+					entry = pte_swp_mkuffd_wp(entry);
 				set_huge_pte_at(src, addr, src_pte, entry);
 			}
-			if (!userfaultfd_wp(dst_vma) && uffd_wp)
+			if (!userfaultfd_wp(dst_vma))
 				entry = huge_pte_clear_uffd_wp(entry);
 			set_huge_pte_at(dst, addr, dst_pte, entry);
 		} else if (unlikely(is_pte_marker(entry))) {
@@ -5114,7 +5116,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 					/* huge_ptep of dst_pte won't change as in child */
 					goto again;
 				}
-				hugetlb_install_folio(dst_vma, dst_pte, addr, new_folio);
+				hugetlb_install_folio(dst_vma, dst_pte, addr,
+						      new_folio, src_pte_old);
 				spin_unlock(src_ptl);
 				spin_unlock(dst_ptl);
 				continue;
@@ -5132,6 +5135,9 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				entry = huge_pte_wrprotect(entry);
 			}
 
+			if (!userfaultfd_wp(dst_vma))
+				entry = huge_pte_clear_uffd_wp(entry);
+
 			set_huge_pte_at(dst, addr, dst_pte, entry);
 			hugetlb_count_add(npages, dst);
 		}
-- 
2.39.1

