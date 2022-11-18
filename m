Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D81562F0D4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241622AbiKRJQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241886AbiKRJQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:16:25 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C183490B1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 01:16:24 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id d8so2983766qki.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 01:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3l1Y5HSD6/V1oMjNmRLOOT3WB8p/T/AI0RfUdUHqvkM=;
        b=jqFHAvcXPb8pPqSgsQoBpVV2smoWYv0AsTkrJ+kQJiaRB6AMS+3EqMCC/cEs362x4u
         /+p301ynz83gOJciwL/+JhWXLwlzDXQtAVxI0pJDDB9GKFE/gP/ZecyBXVb0vVwGcrua
         B2vrLedGOjYteL855XQk1CA0/49+fnprzI25uu1e5Bx/oqPl9AG+803KHDKtnT/PLG+k
         Un9d7IN9ioEtrMxSurRiCVuroEOut7A/yFcb7dN8ho/9Rkdo002NkBdMT4cXDl7VmAKN
         uEfp7YDyLrXETMesR0xnhm5rSncI0B+2YFfyWAA1DTtmX6CIW2s8s/afyp7n0DlEMUch
         nA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3l1Y5HSD6/V1oMjNmRLOOT3WB8p/T/AI0RfUdUHqvkM=;
        b=NWwOcIuMQeEDAA55zo5SXJCi8Qkg/L6zT7znB9M4qkO53LpLMdYCNkeKAFrJYAxcGw
         6jhYDicUAc5AvQ5nGrQ78UdCmG+RdWO5TRH55oQ/s9jNh9zrjWl0CS5VM14NG8MBekA/
         XIW5buOjtt6JhfiR4vQNEy4x+ZybR934QekysYlO5rXUbOs1phbK9jg3l2EKXSmomiFW
         rxs4KTx/RKhgnoVHCVHVQ5X7wSNaBUpvBjKcEFtIJ1IdFQz4QRGB6EornQm7dr5tO8uo
         /ZvhkhWPFMJ81AErhx4K0VaTAjSS8yQ4a8fxX0kyLt0FShwwKK1aS4AaE/IjY7q+O9Pa
         /fUA==
X-Gm-Message-State: ANoB5pllEk2ez37DIGeWOZCBTCNm+lS9v8F7k8tOyOvo1QWP4P9717+V
        YrYWsrVESXsaTb7OcAV5HznTDA==
X-Google-Smtp-Source: AA0mqf64Gro9oee+mIQaltmjl0aWGdxSPUg7f+VNTF3pGS8eJ15VWOe1XhqGaEeBSf5jYOQDXt97hQ==
X-Received: by 2002:a37:6554:0:b0:6f9:f236:1b2b with SMTP id z81-20020a376554000000b006f9f2361b2bmr4845776qkb.299.1668762983133;
        Fri, 18 Nov 2022 01:16:23 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id az20-20020a05620a171400b006ec771d8f89sm2086377qkb.112.2022.11.18.01.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 01:16:22 -0800 (PST)
Date:   Fri, 18 Nov 2022 01:16:20 -0800 (PST)
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
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 3/3] mm,thp,rmap: clean up the end of
 __split_huge_pmd_locked()
In-Reply-To: <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com>
Message-ID: <2f4afe60-40d2-706c-af21-914fbbbd164@google.com>
References: <5f52de70-975-e94f-f141-543765736181@google.com> <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com>
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
---
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

