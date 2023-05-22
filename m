Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FAB70B446
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjEVFCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjEVFCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:02:01 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906B592
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:02:00 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-55db055b412so45888387b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684731720; x=1687323720;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s/wneZk+WXTrjMA3fZuua9PXiv3fUuHnEiWoD80tgK8=;
        b=Q+WLY7Ro5SD5yNUAGTclzTje+VDS5OJwsYctg43k8TXzrg8fckZAOFDLbOpbv+Cz4d
         vusZX67zn6q4S5qUq6SfyoErvRul9hzMJrB3MRNnhQ6C5pPl/f+0Ug23z4gIrshnXudw
         uyL2XPYtPcLeaaYEa9djIcbbIiLW16k5noNko0Ixwnf5lma2IwkwvbUb6+ol9PyhD+iA
         SFpbS9+EhhrldJnU+af1fSiFWnx4LWMy4hftbnHOIsp4fFcbSzoqMd7Z+gmLZKCZGF9K
         xNYQslTPradcxr1kOt1BAZkUVCQ1AUWpnoyxrlCIdMtfrWBTqYrF1ShOS0ygR98FffYZ
         BJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684731720; x=1687323720;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s/wneZk+WXTrjMA3fZuua9PXiv3fUuHnEiWoD80tgK8=;
        b=UVhqOhp1ZjTtMF/MFt1rsG683bC2Mp/5pJngLLUlH8gPKenvlHKDWBPnolBc/NA/SD
         nnFLamK4e45IxjRJ/I9myHoJFtQiOHUOUrtyS14gnSyjVM0NTmOLTHoJSDQusivkcYKc
         HnRdOodIbuud/A3VlxK90Pn+3opdcjFbGTEJbTby680QvvHQWoYZqX6ZWBzxS/oMlkkq
         HcaIPTCHv8z9q8rttuNTAi8fQIjcqf8s75bQrZjWhdNLiP/KlhbLH06MqoZQRdAbOq/m
         B3nhtuE/he6v0kLlhZrD486NU10C+ls5nqkXFteLe13UcJUm2BWu0iTywjGuWjNXjQOr
         6xcQ==
X-Gm-Message-State: AC+VfDyDn6YFTb/tEBTOuP6KhM6fcwSKsl5xnaGhyeZDvz0ibPLzAnwU
        1k3SyfGRWCOZ0sCwS7KWlQQyPw==
X-Google-Smtp-Source: ACHHUZ62zTVVW00Kw9P1qNrMirZM+5qrpLkNDTDbJjpW5hqzfUZErYJorH+/umfKDMFCMPWuq8GGOg==
X-Received: by 2002:a0d:cc45:0:b0:55a:3502:d2ca with SMTP id o66-20020a0dcc45000000b0055a3502d2camr10051671ywd.13.1684731719564;
        Sun, 21 May 2023 22:01:59 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x67-20020a81a046000000b0054fcbf35b94sm1819620ywg.87.2023.05.21.22.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 22:01:59 -0700 (PDT)
Date:   Sun, 21 May 2023 22:01:56 -0700 (PDT)
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
Subject: [PATCH 10/31] mm/pagewalk: walk_pte_range() allow for
 pte_offset_map()
In-Reply-To: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
Message-ID: <fe383bce-929d-e3bd-df6c-1f441877a430@google.com>
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

