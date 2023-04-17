Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320C96E513E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjDQTyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjDQTy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:54:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BF8768A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681761204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4kH7JNUmkrK1TIcnPTAjFCorjkRaA4Lvx3pRbnAdGF0=;
        b=DhpRqkZRL+PyubNkgjQLYvdqNoS8PA/GFNH+eqtPKZ7vnOaryAbdXhAgmuI0MMwiL18wAS
        2yrkhugf+gYB+50wyWHaiWwWr3GWzRudfr1jQhQZUsse0zp3tdGtEL4sl0SCm7NUwySJOH
        Ache4MCxJ3IbCz3iR8qk6FB9rDhveiE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-bZNAUa01Og6OBn0MA0NVDQ-1; Mon, 17 Apr 2023 15:53:23 -0400
X-MC-Unique: bZNAUa01Og6OBn0MA0NVDQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3ef3116d1dcso1937081cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681761202; x=1684353202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kH7JNUmkrK1TIcnPTAjFCorjkRaA4Lvx3pRbnAdGF0=;
        b=erSSpw18DqBkI7lPsT0vjPRhltyoosVxEY341273gKeBXc+SBYkvL9rI+OMy6Wywsk
         GpiXhHzXzjrB5Q78hfczXuFu1wzcNQabdvzd6RdOUiQtr0aWqJxuoyD4qrZSv4WXK2ML
         zYeDwCLeQ+9tLBYm4Pbr+pT60q8RHgHcCqzZz8HGfjnGwSVgus//ULkOKilFoXS64Zcv
         RWWfy3tiaUzowAkzNjj6yoOjOdYFo3G7okiAvEiDfZ4SUh5aeBtkrLd39uFQnRI8iWQZ
         ZwJ+kSkUwngaR83tkh/dBH3TeFxS6UF4gcaMfEWOZHo+xUIhGevde/1/OSyewsfaP8+r
         UwlQ==
X-Gm-Message-State: AAQBX9fVKVFvdZD7+PnlufjxxSN841QHpG/o/8QHvqMXY+Gr76d3VZ5L
        X0n7gH/GnQudYqmKEwj0mM3CQHv0S7MME1DpM6kJvd6CAi4wxfXZlO8V1MFC1+4oO6CrbGmRw2Y
        ET4leZungotSeVpEnuUeq9JD4onHJqeSwA+Rupkda1KrsZh0MBMB0RjC+LYgs9EMI+hVWT8hZQm
        UdpuuCIQ==
X-Received: by 2002:a05:622a:19a4:b0:3e8:e986:b20b with SMTP id u36-20020a05622a19a400b003e8e986b20bmr17654479qtc.6.1681761202064;
        Mon, 17 Apr 2023 12:53:22 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZImFWbK1bH7N466hKMggFlbQGVKGvl3FHNzHOn9K4F9JpZRZ/yhdls5xIATBP5zpu3FcayoQ==
X-Received: by 2002:a05:622a:19a4:b0:3e8:e986:b20b with SMTP id u36-20020a05622a19a400b003e8e986b20bmr17654449qtc.6.1681761201723;
        Mon, 17 Apr 2023 12:53:21 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id r17-20020ac87ef1000000b003edfb5d7637sm1731278qtc.73.2023.04.17.12.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 12:53:21 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        linux-stable <stable@vger.kernel.org>
Subject: [PATCH v2 1/6] mm/hugetlb: Fix uffd-wp during fork()
Date:   Mon, 17 Apr 2023 15:53:12 -0400
Message-Id: <20230417195317.898696-2-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230417195317.898696-1-peterx@redhat.com>
References: <20230417195317.898696-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f16b25b1a6b9..0213efaf31be 100644
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
@@ -5032,14 +5036,12 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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
+			bool uffd_wp = pte_swp_uffd_wp(entry);
 
 			if (!is_readable_migration_entry(swp_entry) && cow) {
 				/*
@@ -5050,10 +5052,10 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 							swp_offset(swp_entry));
 				entry = swp_entry_to_pte(swp_entry);
 				if (userfaultfd_wp(src_vma) && uffd_wp)
-					entry = huge_pte_mkuffd_wp(entry);
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

