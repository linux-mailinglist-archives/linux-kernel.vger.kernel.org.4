Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C60633910
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbiKVJwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbiKVJv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:51:56 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1F431212
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:51:56 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id jr19so8924843qtb.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d3Ih39NMegZAhP2Qu/k/4zxkPIuPc7SBENROtpvFlxw=;
        b=DSEt13C4pf2sdQMt8lU0G2oqdagEd8Wg/0MSUb37Kr7CrOmTWHPLhkVpmbZciGuNS9
         C8t/tI1CS+zRtzxXE5QADcgZLSJCWgPDlj8nmToiDwBydTdUx1eGXnzTKx6d4qr5lTrE
         DuYsCDI7UEpY3hZJVcgesjAvUuLBj83LldT8WJXRuWNH1z5a4+JfDyC2Uok9yQhaQxqn
         WTODQQSG5ouJQ13FeuU9VI7mf+8wihbLKoDgPFO4RdB0noECutAd9ilXZ7o85DkLcqsm
         FJ13Eaqs7CwdkfpBYOyVsc04MGLxm70lB2bNnbYxQOtH2Waeb8NcJ9OdQ84F03J/3/GY
         72Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d3Ih39NMegZAhP2Qu/k/4zxkPIuPc7SBENROtpvFlxw=;
        b=AIff07qs4IsHLGl+ZEloJQHL+eSTxyj9mV6EfqGg0iE81HUxvEllRIhQWUcYGDW0Tf
         G+QOZQduKJvE8q3wGyEu+OXqiqpZGlKgOxmAkL6d+flvJmHpnSqW24tvDs+2Qv03iwMb
         JZ02xIPZFWCx0lnw5TqfZLdNx7ci86o7TiSRgLwV1AM59Se9pPWl3Ne2yde80zA+VwNC
         i9vXSBPbou9KRPr6SWsiDWL907CPCtb4Nlh7pkP1z/TQkeW+6hgzk1BITHHtQFzUWfFH
         J4h+Zn1A5BWDxnRp2gKjmepm2DgEJnpyNovZpT9KdUNiF3hsptVBFPXutksA4UyF1V7G
         Rb0g==
X-Gm-Message-State: ANoB5pkbBv+ZAycUygc+uTezebTTudLNOwkPc0Er6kM94mFrx91oH+4+
        unbJlhzrZD1Qv7gDI5egU6TJQA==
X-Google-Smtp-Source: AA0mqf4JAFxf1BA3eOCanBBGSqdFaxKzFrzfW6x8iVMu2sZfmFx/p6NkCnNFdJDaTwbFQrMWZ+/NGw==
X-Received: by 2002:a05:622a:18a7:b0:3a5:62b5:9093 with SMTP id v39-20020a05622a18a700b003a562b59093mr10794835qtc.252.1669110715048;
        Tue, 22 Nov 2022 01:51:55 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id ci14-20020a05622a260e00b00398df095cf5sm1349951qtb.34.2022.11.22.01.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 01:51:53 -0800 (PST)
Date:   Tue, 22 Nov 2022 01:51:50 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        James Houghton <jthoughton@google.com>,
        Zach O'Keefe <zokeefe@google.com>, Yu Zhao <yuzhao@google.com>,
        Dan Carpenter <error27@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 3/3] mm,thp,rmap: clean up the end of
 __split_huge_pmd_locked()
In-Reply-To: <a5849eca-22f1-3517-bf29-95d982242742@google.com>
Message-ID: <d43748aa-fece-e0b9-c4ab-f23c9ebc9011@google.com>
References: <5f52de70-975-e94f-f141-543765736181@google.com> <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com> <a5849eca-22f1-3517-bf29-95d982242742@google.com>
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

It's hard to add a page_add_anon_rmap() into __split_huge_pmd_locked()'s
HPAGE_PMD_NR set_pte_at() loop, without wincing at the "freeze" case's
HPAGE_PMD_NR page_remove_rmap() loop below it.

It's just a mistake to add rmaps in the "freeze" (insert migration entries
prior to splitting huge page) case: the pmd_migration case already avoids
doing that, so just follow its lead.  page_add_ref() versus put_page()
likewise.  But why is one more put_page() needed in the "freeze" case?
Because it's removing the pmd rmap, already removed when pmd_migration
(and freeze and pmd_migration are mutually exclusive cases).

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
v2: same as v1, plus Ack from Kirill

 mm/huge_memory.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3dee8665c585..ab5ab1a013e1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2135,7 +2135,6 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		uffd_wp = pmd_uffd_wp(old_pmd);
 
 		VM_BUG_ON_PAGE(!page_count(page), page);
-		page_ref_add(page, HPAGE_PMD_NR - 1);
 
 		/*
 		 * Without "freeze", we'll simply split the PMD, propagating the
@@ -2155,6 +2154,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		anon_exclusive = PageAnon(page) && PageAnonExclusive(page);
 		if (freeze && anon_exclusive && page_try_share_anon_rmap(page))
 			freeze = false;
+		if (!freeze)
+			page_ref_add(page, HPAGE_PMD_NR - 1);
 	}
 
 	/*
@@ -2210,27 +2211,21 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 				entry = pte_mksoft_dirty(entry);
 			if (uffd_wp)
 				entry = pte_mkuffd_wp(entry);
+			page_add_anon_rmap(page + i, vma, addr, false);
 		}
 		pte = pte_offset_map(&_pmd, addr);
 		BUG_ON(!pte_none(*pte));
 		set_pte_at(mm, addr, pte, entry);
-		if (!pmd_migration)
-			page_add_anon_rmap(page + i, vma, addr, false);
 		pte_unmap(pte);
 	}
 
 	if (!pmd_migration)
 		page_remove_rmap(page, vma, true);
+	if (freeze)
+		put_page(page);
 
 	smp_wmb(); /* make pte visible before pmd */
 	pmd_populate(mm, pmd, pgtable);
-
-	if (freeze) {
-		for (i = 0; i < HPAGE_PMD_NR; i++) {
-			page_remove_rmap(page + i, vma, false);
-			put_page(page + i);
-		}
-	}
 }
 
 void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
-- 
2.35.3

