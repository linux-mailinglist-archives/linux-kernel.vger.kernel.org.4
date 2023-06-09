Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956DC728CE9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbjFIBOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjFIBOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:14:19 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082BF184
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:14:18 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-568af2f6454so11288867b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 18:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686273257; x=1688865257;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dk0QCHZ/ZrkXov8P0kyfxgscgrLXPV5n2YV5/OCWJso=;
        b=b0CpC9XpkwDMafp8znPdIUsufEoFF4TcEqSqtaBP/NRJK+TenjbuJzsvixBg7OeqD/
         2YfCQZOz9K140u4I0LV9p7i9HmUHhwPj5OjQEN4SArRt2Or8i+5jxZhLGecB/haRDICX
         vtLEyf8OOmoIO0wzxw5muMOyeWGS5tJSD8isNbt74/I3PyUiS3JXgFtf8p9995UjX66/
         sVUXiIkxjAllgABbdRX2liHFwE/N9RUJ3gtPDEiB01DtZbdswHmgd6fCDnuNDxOd5cgB
         2PYb4O3ns/eFa8oej3CUcEw8DbK3FH4hcK4a5VnPjgKE3o+d2ZfZbD5hqntDTaQ68DiO
         87/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686273257; x=1688865257;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dk0QCHZ/ZrkXov8P0kyfxgscgrLXPV5n2YV5/OCWJso=;
        b=cZXaLpHOW5f8K39tCp7RAuFbU3hl5zL6ywwsqG+zO0l/3C13RfPSWbIVVJM+xipJXC
         3PGWQmCmcL0yBLp9+Za5rNVMAQ9l1/lAKIKDDretRntFJbdYXBnh3qX6QADMAHgplGpa
         uRPffwTBtnYxx1IV1CQa1c9YEQKBiustagzNgUfmUmMrPDsPI+5TEYAEmA6pKkjNN8lG
         R21R3D0PuVLCMNABrZBohoCNHxKsA5y848nQmw1jLfotBCDrA0rhsEy6HyKml2KKpH5I
         WJfpaK5LGW67kVb4lw+Pml6dbd5DY+N3PuodXhhQL3Y+1ozwVL77+szLjpWOlWRxNC7v
         CCBA==
X-Gm-Message-State: AC+VfDyZwd2f27vAbE5tA8HDrxaVfyydBA4JaASCGvged51YxnV/4OeL
        ci3PKe6kUqiT5XBm2dpowG5rrw==
X-Google-Smtp-Source: ACHHUZ6G5/QqeKVeqB1vcKg8Kl9KAE//8sPZoP2ai/tJpfMIrL/rfl6x9oi+hpyk1yDqLu4iwiQrEA==
X-Received: by 2002:a0d:d6c8:0:b0:549:2623:6f65 with SMTP id y191-20020a0dd6c8000000b0054926236f65mr1346506ywd.33.1686273257036;
        Thu, 08 Jun 2023 18:14:17 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t66-20020a815f45000000b0054fba955474sm301207ywb.17.2023.06.08.18.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 18:14:16 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:14:12 -0700 (PDT)
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
Subject: [PATCH v2 07/32] mm/page_vma_mapped: reformat map_pte() with less
 indentation
In-Reply-To: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
Message-ID: <bf723f59-e3fc-6839-1cc3-c0631ee248bc@google.com>
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

No functional change here, but adjust the format of map_pte() so that the
following commit will be easier to read: separate out the PVMW_SYNC case
first, and remove two levels of indentation from the ZONE_DEVICE case.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/page_vma_mapped.c | 65 +++++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 31 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 007dc7456f0e..947dc7491815 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -15,38 +15,41 @@ static inline bool not_found(struct page_vma_mapped_walk *pvmw)
 
 static bool map_pte(struct page_vma_mapped_walk *pvmw)
 {
-	pvmw->pte = pte_offset_map(pvmw->pmd, pvmw->address);
-	if (!(pvmw->flags & PVMW_SYNC)) {
-		if (pvmw->flags & PVMW_MIGRATION) {
-			if (!is_swap_pte(*pvmw->pte))
-				return false;
-		} else {
-			/*
-			 * We get here when we are trying to unmap a private
-			 * device page from the process address space. Such
-			 * page is not CPU accessible and thus is mapped as
-			 * a special swap entry, nonetheless it still does
-			 * count as a valid regular mapping for the page (and
-			 * is accounted as such in page maps count).
-			 *
-			 * So handle this special case as if it was a normal
-			 * page mapping ie lock CPU page table and returns
-			 * true.
-			 *
-			 * For more details on device private memory see HMM
-			 * (include/linux/hmm.h or mm/hmm.c).
-			 */
-			if (is_swap_pte(*pvmw->pte)) {
-				swp_entry_t entry;
+	if (pvmw->flags & PVMW_SYNC) {
+		/* Use the stricter lookup */
+		pvmw->pte = pte_offset_map_lock(pvmw->vma->vm_mm, pvmw->pmd,
+						pvmw->address, &pvmw->ptl);
+		return true;
+	}
 
-				/* Handle un-addressable ZONE_DEVICE memory */
-				entry = pte_to_swp_entry(*pvmw->pte);
-				if (!is_device_private_entry(entry) &&
-				    !is_device_exclusive_entry(entry))
-					return false;
-			} else if (!pte_present(*pvmw->pte))
-				return false;
-		}
+	pvmw->pte = pte_offset_map(pvmw->pmd, pvmw->address);
+	if (pvmw->flags & PVMW_MIGRATION) {
+		if (!is_swap_pte(*pvmw->pte))
+			return false;
+	} else if (is_swap_pte(*pvmw->pte)) {
+		swp_entry_t entry;
+		/*
+		 * Handle un-addressable ZONE_DEVICE memory.
+		 *
+		 * We get here when we are trying to unmap a private
+		 * device page from the process address space. Such
+		 * page is not CPU accessible and thus is mapped as
+		 * a special swap entry, nonetheless it still does
+		 * count as a valid regular mapping for the page
+		 * (and is accounted as such in page maps count).
+		 *
+		 * So handle this special case as if it was a normal
+		 * page mapping ie lock CPU page table and return true.
+		 *
+		 * For more details on device private memory see HMM
+		 * (include/linux/hmm.h or mm/hmm.c).
+		 */
+		entry = pte_to_swp_entry(*pvmw->pte);
+		if (!is_device_private_entry(entry) &&
+		    !is_device_exclusive_entry(entry))
+			return false;
+	} else if (!pte_present(*pvmw->pte)) {
+		return false;
 	}
 	pvmw->ptl = pte_lockptr(pvmw->vma->vm_mm, pvmw->pmd);
 	spin_lock(pvmw->ptl);
-- 
2.35.3

