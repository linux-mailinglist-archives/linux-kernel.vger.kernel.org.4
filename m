Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62101728CFD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237565AbjFIBUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjFIBUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:20:10 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8EB198C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:20:09 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-565a022ef06so11190247b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 18:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686273609; x=1688865609;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W3t6elq9R4Rh1GonIcnIp9HMVNr0t0fb96tM78h+6lY=;
        b=sbrAsg5WUYRFtaZIknvbQiG6/TYzlsI+0wgQgiUfJThncdOkuzQD0khSKs1V9z07r2
         Tv51pW/PAoavvTS97xjUmu8LWWg94YJvp9vB5pfhhczalF5/DDl+Uv7HP4vGiWYqNo4X
         NvPImQC1dON//ZIIaJuY80thsOcoTmEarD24++KqimOdduTFWASKv9w7+mCL83HP6Bjj
         lCLJbqulD5C8g370KMX/kus7X70GOqLQ+qmTon2m/00V/c4ahLqm0Dsyh/zh31jb7WvE
         PrxBXcgSpFRmWGUOtPIfuBbXHPk/T7GjZ0IZtugAqqqNtfJYQbkhOVtUktXosevWE1uY
         kB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686273609; x=1688865609;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W3t6elq9R4Rh1GonIcnIp9HMVNr0t0fb96tM78h+6lY=;
        b=VEa5VIp0wlE6NJvD1tAfgLPLAUKBG2xNrPxnKYIG6/e6sDUPxQOP0f4e3nqQaZBIy6
         Bp2J/10wSkJ4fRb4NR0kIe80CNu2bqPtPpb7nd9gY8q7hQCN9r9bOuweNCu9IZsMJeJQ
         sJLqazlPoPBnoYRws9sqdVTgfn4ljT+f/DPSGVT+TGchNjQcZnPaMzgB9JN6gpouXAad
         5XBtzQRf32lLf5YZSBlKeq8TH6j7GQ+ociHdzSuB8oUt+uas4uuhXNJ0COFmLEURfl3m
         BOZHZZda5lTNehPCZ9jGP8IDXgMOMcB7r6X/DbUWOxx2+eq0kUCZjnB+pJZ1nfBudtLA
         rwtA==
X-Gm-Message-State: AC+VfDyjGnwoLqU/iR8IeD7GsqbtJh0W+i3ZhaY009LM/nQC8QZJanuJ
        DBcXsPNxb2NrSqXMwjhIEvM92g==
X-Google-Smtp-Source: ACHHUZ6n8W5YFW3Tw+jdRjglpr2r72K5tunXYPvH/mLAwhgJM3++HeY9qf1iqDSmIO6b6XIA/ifN5Q==
X-Received: by 2002:a0d:dd01:0:b0:568:b0f6:ce8a with SMTP id g1-20020a0ddd01000000b00568b0f6ce8amr1205033ywe.24.1686273608570;
        Thu, 08 Jun 2023 18:20:08 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j77-20020a819250000000b00565862c5e90sm289860ywg.83.2023.06.08.18.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 18:20:07 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:20:04 -0700 (PDT)
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
Subject: [PATCH v2 11/32] mm/vmwgfx: simplify pmd & pud mapping dirty
 helpers
In-Reply-To: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
Message-ID: <d3379c7-65db-26d3-1764-8e866490925f@google.com>
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

wp_clean_pmd_entry() need not check pmd_trans_unstable() or pmd_none(),
wp_clean_pud_entry() need not check pud_trans_unstable() or pud_none():
it's just the ACTION_CONTINUE when trans_huge or devmap that's needed
to prevent splitting, and we're hoping to remove pmd_trans_unstable().
Is that PUD #ifdef necessary?  Maybe some configs are missing a stub.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/mapping_dirty_helpers.c | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
index e1eb33f49059..87b4beeda4fa 100644
--- a/mm/mapping_dirty_helpers.c
+++ b/mm/mapping_dirty_helpers.c
@@ -128,19 +128,11 @@ static int wp_clean_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long end,
 {
 	pmd_t pmdval = pmdp_get_lockless(pmd);
 
-	if (!pmd_trans_unstable(&pmdval))
-		return 0;
-
-	if (pmd_none(pmdval)) {
-		walk->action = ACTION_AGAIN;
-		return 0;
-	}
-
-	/* Huge pmd, present or migrated */
-	walk->action = ACTION_CONTINUE;
-	if (pmd_trans_huge(pmdval) || pmd_devmap(pmdval))
+	/* Do not split a huge pmd, present or migrated */
+	if (pmd_trans_huge(pmdval) || pmd_devmap(pmdval)) {
 		WARN_ON(pmd_write(pmdval) || pmd_dirty(pmdval));
-
+		walk->action = ACTION_CONTINUE;
+	}
 	return 0;
 }
 
@@ -156,23 +148,15 @@ static int wp_clean_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long end,
 static int wp_clean_pud_entry(pud_t *pud, unsigned long addr, unsigned long end,
 			      struct mm_walk *walk)
 {
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 	pud_t pudval = READ_ONCE(*pud);
 
-	if (!pud_trans_unstable(&pudval))
-		return 0;
-
-	if (pud_none(pudval)) {
-		walk->action = ACTION_AGAIN;
-		return 0;
-	}
-
-#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-	/* Huge pud */
-	walk->action = ACTION_CONTINUE;
-	if (pud_trans_huge(pudval) || pud_devmap(pudval))
+	/* Do not split a huge pud */
+	if (pud_trans_huge(pudval) || pud_devmap(pudval)) {
 		WARN_ON(pud_write(pudval) || pud_dirty(pudval));
+		walk->action = ACTION_CONTINUE;
+	}
 #endif
-
 	return 0;
 }
 
-- 
2.35.3

