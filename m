Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9510670B440
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 06:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjEVE5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 00:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjEVE5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 00:57:31 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBD9E9
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 21:57:30 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-561a33b6d63so74535077b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 21:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684731450; x=1687323450;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dk0QCHZ/ZrkXov8P0kyfxgscgrLXPV5n2YV5/OCWJso=;
        b=CynFLjQo0B1iyGJQ1Hhn7p6Dwng2pZKqC1sA23EZv3JCM+ZbaT1ahTTm4sUvOZtzCZ
         BowaOQG29xMNLY0nY/iY+TITfx8rXjfCpXFh5g/iSfQ5lmiD0WCo6dz+EbU/qzow4T48
         gIYfejZ6h5BXNTbcNV7JSAg8ejqfun0/YIkYFIX2j/yjnUq7/K2x26jXo8nJSL+Ur/DZ
         +SUB1nDtFHo1Zu1hnHccttoMBnxyawb0XgPXLVByf6aDR7smWV6B07cuec2Ws0N9yLdQ
         8jqD+ttVDEwqJC0ct/mh9eZgT02XjAOsBx+WhPs+42uDF1lV5/G1Bt1qT41SuPS3wH4j
         Fx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684731450; x=1687323450;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dk0QCHZ/ZrkXov8P0kyfxgscgrLXPV5n2YV5/OCWJso=;
        b=YK1zIOQ49dcbGpS3txrFSOTesTonQVRBTMM6A1ltKSiclOPz3bAohyoBlYI85BjIEw
         e/mdtEv6epRTCsVGNabnmxSQoN/cAwM9sJf3ISTXMHnzVxSxfDUg5/Gn7sSMhYgoNQSv
         ThzDjoq5Yvu7BG5UGqnQbS6JWGOli1ES2oZXuDicXqB6r/7Izu8U6t/5lcNJz00xpTGf
         MUXm4EJ5qGJJEaO0hMTwPOnNT0MA7n9JAPZEqVRYbuRnpfgclZcgLrdwE0wEX801DdrT
         QFRQlyVl5XQ9dCSKhxfYhMMkIMkJAXpdp6TINtVQeLrNlvx19xgUve7kPImEq7teV52t
         Eh1w==
X-Gm-Message-State: AC+VfDzKjNIUuEl3pEqoWLyD0pC3hazY5HBWVCMRHpm3d9yC0p1Va5rp
        w7MOd/JRQ0yrxJVtuJTJLiSKgA==
X-Google-Smtp-Source: ACHHUZ6bURP043biciXrsTo4ID2f5FUMVgcYdQ4w5Fut/Rhs5NuMHxd9s5+H+9KhMfle9QGb5MKZdA==
X-Received: by 2002:a81:9206:0:b0:55a:2ce1:2353 with SMTP id j6-20020a819206000000b0055a2ce12353mr9508264ywg.2.1684731449358;
        Sun, 21 May 2023 21:57:29 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c130-20020a814e88000000b0056183cdb2d9sm1794222ywb.60.2023.05.21.21.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 21:57:29 -0700 (PDT)
Date:   Sun, 21 May 2023 21:57:25 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 07/31] mm/page_vma_mapped: reformat map_pte() with less
 indentation
In-Reply-To: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
Message-ID: <4d93bd9-346c-938f-45d0-e073372323f6@google.com>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
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

