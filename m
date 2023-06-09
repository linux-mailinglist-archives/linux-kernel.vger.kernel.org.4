Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BF8728CF2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237442AbjFIBPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjFIBPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:15:51 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011A2184
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:15:48 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3f9d8aa9025so314401cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 18:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686273348; x=1688865348;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9VYOFAJpcVHpYrrS1TQZcIVdYEqSjI0GrwCgA5USRTU=;
        b=qGqUUKrUhXZqdfIpdRpru1enURAlAM37w3JnFCBdqcN5NOVKva/5ZB+Wx1AncWuaoB
         4NOGT/sluCqCWe9k46AbMdrfO/y7S/uoPCSIv3YcbyPtfcHQLmMhf87/VSB5iKcTyY2z
         DvH2xbXgY53bvpfsWKoRD42G3UAVdO/UJ+NkrWhrUDvDf4DfgkGc7vx+86uzLhaB2Vdl
         OBAdZ3Qvm5QESmYlbn3dnRPJ/xpFtDzek+36j2PNxi4y2bmdWvVJycdWxpou775822Zd
         vv/wKkp98uy9cbO4mRL/ywca8CgLJugp1BRNkerDGGNXhj+j6x2eNtUbygfDvk9GNFDY
         1+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686273348; x=1688865348;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9VYOFAJpcVHpYrrS1TQZcIVdYEqSjI0GrwCgA5USRTU=;
        b=Icv9/FZFuPUNs31zosXQhizhDMouvqCGP6C+6z4ybduYeYfS9FUuRcqjtYVGBTWaZs
         Eart5unOrjk/xdStmc82tnDo0Qbs7urWpnvuKkg6gZRm24Bkcj4UAZDSPEKitOyUQrBt
         CBBwCz1+LyZUtzgaiNiu4vEZJh8UVIPcuwta8zvXyLbJVPcuf1EStT7dffWi4D3sSg3R
         Ig6NkAIo+uxSKzmaElzqPIFn6FIwbEVVrniaPx7oFNLzeoBiaRA43gKUeeq4NtOHeG9U
         gvtra5VT3xe41IxaIXUSh9HdytNZT0VJyT2g05TaEl1IaT09Pm1quDWkt0zHnJtsiGVi
         FYFw==
X-Gm-Message-State: AC+VfDygGNirJyjv3y0l0pEs35ebzrsmxj2uknHVBi/tqB+uwRcBFyIS
        Jyed0TDyT0IaIPKK7FOWohjgmw==
X-Google-Smtp-Source: ACHHUZ5RPLaTpoCJzmmgtuS8+EduaIDi339U1d6YVPQERnp7XZzVYgUh9cqEFrnN8L2JonZ6XbEg1g==
X-Received: by 2002:ac8:57d2:0:b0:3f6:9a18:e67c with SMTP id w18-20020ac857d2000000b003f69a18e67cmr42699qta.66.1686273348055;
        Thu, 08 Jun 2023 18:15:48 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id u15-20020a25840f000000b00b9e2ef25f1asm583095ybk.44.2023.06.08.18.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 18:15:47 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:15:43 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 08/32] mm/page_vma_mapped: pte_offset_map_nolock() not
 pte_lockptr()
In-Reply-To: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
Message-ID: <cba186e0-5ed7-e81b-6cd-dade4c33c248@google.com>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

map_pte() use pte_offset_map_nolock(), to make sure of the ptl belonging
to pte, even if pmd entry is then changed racily: page_vma_mapped_walk()
use that instead of getting pte_lockptr() later, or restart if map_pte()
found no page table.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/page_vma_mapped.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 947dc7491815..2af734274073 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -13,16 +13,28 @@ static inline bool not_found(struct page_vma_mapped_walk *pvmw)
 	return false;
 }
 
-static bool map_pte(struct page_vma_mapped_walk *pvmw)
+static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
 {
 	if (pvmw->flags & PVMW_SYNC) {
 		/* Use the stricter lookup */
 		pvmw->pte = pte_offset_map_lock(pvmw->vma->vm_mm, pvmw->pmd,
 						pvmw->address, &pvmw->ptl);
-		return true;
+		*ptlp = pvmw->ptl;
+		return !!pvmw->pte;
 	}
 
-	pvmw->pte = pte_offset_map(pvmw->pmd, pvmw->address);
+	/*
+	 * It is important to return the ptl corresponding to pte,
+	 * in case *pvmw->pmd changes underneath us; so we need to
+	 * return it even when choosing not to lock, in case caller
+	 * proceeds to loop over next ptes, and finds a match later.
+	 * Though, in most cases, page lock already protects this.
+	 */
+	pvmw->pte = pte_offset_map_nolock(pvmw->vma->vm_mm, pvmw->pmd,
+					  pvmw->address, ptlp);
+	if (!pvmw->pte)
+		return false;
+
 	if (pvmw->flags & PVMW_MIGRATION) {
 		if (!is_swap_pte(*pvmw->pte))
 			return false;
@@ -51,7 +63,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw)
 	} else if (!pte_present(*pvmw->pte)) {
 		return false;
 	}
-	pvmw->ptl = pte_lockptr(pvmw->vma->vm_mm, pvmw->pmd);
+	pvmw->ptl = *ptlp;
 	spin_lock(pvmw->ptl);
 	return true;
 }
@@ -156,6 +168,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 	struct vm_area_struct *vma = pvmw->vma;
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long end;
+	spinlock_t *ptl;
 	pgd_t *pgd;
 	p4d_t *p4d;
 	pud_t *pud;
@@ -257,8 +270,11 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			step_forward(pvmw, PMD_SIZE);
 			continue;
 		}
-		if (!map_pte(pvmw))
+		if (!map_pte(pvmw, &ptl)) {
+			if (!pvmw->pte)
+				goto restart;
 			goto next_pte;
+		}
 this_pte:
 		if (check_pte(pvmw))
 			return true;
@@ -281,7 +297,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		} while (pte_none(*pvmw->pte));
 
 		if (!pvmw->ptl) {
-			pvmw->ptl = pte_lockptr(mm, pvmw->pmd);
+			pvmw->ptl = ptl;
 			spin_lock(pvmw->ptl);
 		}
 		goto this_pte;
-- 
2.35.3

