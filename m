Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802AF728CFC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237541AbjFIBS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjFIBS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:18:56 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1816319AC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:18:55 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-ba86ea269e0so1277519276.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 18:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686273534; x=1688865534;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s/wneZk+WXTrjMA3fZuua9PXiv3fUuHnEiWoD80tgK8=;
        b=ngXLVdTpVyrnOmcx9sqd11fDN/DpMfDjRFc20sS67KuKXUBPfJVN7b54WivfwCCqcm
         2w8p0+WuKxMdG7YLSaNER90dnOHjPSlvPspYoe5kIeMhFky06+Enxr+OKG3u1lmvAOqa
         C+PVbym1M2SnYvLxMqSZg33YxKhOPm3FgR9jzQ+MnLfZGFUC2OJbbjuScpkVkepg/TEp
         276YbysaG6RpeWzjjsraxwjBqi8YR2LoYFLfcozNIrD2bqcAOk2V+q1v/295yDeTTnP9
         TfyYNMuGFwQjegWuOVfz1GKj11hEcBHgzfIvjlO8LY2ikBAtYqRoDenRCee7HmvBFb1A
         njIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686273534; x=1688865534;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s/wneZk+WXTrjMA3fZuua9PXiv3fUuHnEiWoD80tgK8=;
        b=YMauREB2g/iRaGULaR5xRwXHQNiURkiWyM9zw8gV41v7LapBeB1Q4asogV3syiepZY
         IIeeM1puuqXlhTpwsm4ZSfOLIPm2J0JoUwww824VOkPl+X2QX4sRVIdvDoXfWUFSSM/j
         dJbFrZTyFifDHtmPBf24L9GyncP3pLXw8IGuGhTZeuv0J5hfYYggiYM7YdJugrhWhE7+
         fMRsCVV+MZqIf/9ZCx23M0KPmq2ORQ83jyB8SP6Wf7fZaoJdHYSUr2ySrU4SH24IvYuz
         4hDO8G4+s5w4xlphA/0RA6KZVoTPqtDtDboipD9n480up6Q8YVnylbeCJ8gZFwkH7wK2
         WBOw==
X-Gm-Message-State: AC+VfDwwuaul5n0n5OVStHTBr9NNgrTa7Ai/T59vbwC///rjjcF5XE+a
        Fk7rOH5W1c0jI3/y11iMfeTwag==
X-Google-Smtp-Source: ACHHUZ5bBUa+IZ+zQxwNmCb4pbZbizWCezt9RItrFgkqOHN09PZD1rbRUEyPvItVL/IZu/e+lOkb4A==
X-Received: by 2002:a25:d757:0:b0:ba7:ff37:4603 with SMTP id o84-20020a25d757000000b00ba7ff374603mr1178588ybg.45.1686273534119;
        Thu, 08 Jun 2023 18:18:54 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v38-20020a25aba9000000b00b923b2935d9sm603286ybi.20.2023.06.08.18.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 18:18:53 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:18:49 -0700 (PDT)
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
Subject: [PATCH v2 10/32] mm/pagewalk: walk_pte_range() allow for
 pte_offset_map()
In-Reply-To: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
Message-ID: <3eba6f0-2b-fb66-6bb6-2ee8533e221@google.com>
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

walk_pte_range() has a no_vma option to serve walk_page_range_novma().
I don't know of any problem, but it looks safer to check for init_mm,
and use pte_offset_kernel() rather than pte_offset_map() in that case:
pte_offset_map()'s pmdval validation is intended for userspace.

Allow for its pte_offset_map() or pte_offset_map_lock() to fail, and
retry with ACTION_AGAIN if so.  Add a second check for ACTION_AGAIN
in walk_pmd_range(), to catch it after return from walk_pte_range().

Remove the pmd_trans_unstable() check after split_huge_pmd() in
walk_pmd_range(): walk_pte_range() now handles those cases safely
(and they must fail powerpc's is_hugepd() check).

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/pagewalk.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index cb23f8a15c13..64437105fe0d 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -46,15 +46,27 @@ static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	spinlock_t *ptl;
 
 	if (walk->no_vma) {
-		pte = pte_offset_map(pmd, addr);
-		err = walk_pte_range_inner(pte, addr, end, walk);
-		pte_unmap(pte);
+		/*
+		 * pte_offset_map() might apply user-specific validation.
+		 */
+		if (walk->mm == &init_mm)
+			pte = pte_offset_kernel(pmd, addr);
+		else
+			pte = pte_offset_map(pmd, addr);
+		if (pte) {
+			err = walk_pte_range_inner(pte, addr, end, walk);
+			if (walk->mm != &init_mm)
+				pte_unmap(pte);
+		}
 	} else {
 		pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
-		err = walk_pte_range_inner(pte, addr, end, walk);
-		pte_unmap_unlock(pte, ptl);
+		if (pte) {
+			err = walk_pte_range_inner(pte, addr, end, walk);
+			pte_unmap_unlock(pte, ptl);
+		}
 	}
-
+	if (!pte)
+		walk->action = ACTION_AGAIN;
 	return err;
 }
 
@@ -141,11 +153,8 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 		    !(ops->pte_entry))
 			continue;
 
-		if (walk->vma) {
+		if (walk->vma)
 			split_huge_pmd(walk->vma, pmd, addr);
-			if (pmd_trans_unstable(pmd))
-				goto again;
-		}
 
 		if (is_hugepd(__hugepd(pmd_val(*pmd))))
 			err = walk_hugepd_range((hugepd_t *)pmd, addr, next, walk, PMD_SHIFT);
@@ -153,6 +162,10 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 			err = walk_pte_range(pmd, addr, next, walk);
 		if (err)
 			break;
+
+		if (walk->action == ACTION_AGAIN)
+			goto again;
+
 	} while (pmd++, addr = next, addr != end);
 
 	return err;
-- 
2.35.3

