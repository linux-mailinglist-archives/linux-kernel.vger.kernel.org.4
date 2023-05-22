Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761C770B43F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 06:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjEVEz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 00:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjEVEzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 00:55:55 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D573BB
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 21:55:55 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-ba829e17aacso8512568276.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 21:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684731354; x=1687323354;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zTm3eSBiFsuHpLmgEmMbxBID/kzy6WIASRGS/m4xNS4=;
        b=cg30IRtt7WWBZINDX0Jv402rJAxuzmQi7sNbiwo3sAYNeuv0iwLqCdxKXUV1666arB
         iODQXo3TXBZWNrbAGBgo7JPYM/uh3QZy2aOwzrHWKdaKeQxiaTgQr+B/h0WaJumRmkZS
         EwvnPxhlE/ygC1l9PvisFRAxceZsimtF2xJnCScbrcoMyL1u1L/6wf9rDZLxnaTA3LQc
         zI7g1VSQ5r9D+qngti0qturyyoRo7eal1Od9D8FGmOBxjDKgugY3ZMq1QggviidfFbw9
         1sPnCORb05gZ3h3EwvicWZtgtg3JnoDyX2eiBh+EAi3PI8BUvp+6C/C1Nf/8YEhUgGVC
         fWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684731354; x=1687323354;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zTm3eSBiFsuHpLmgEmMbxBID/kzy6WIASRGS/m4xNS4=;
        b=JUV2Awq5oX2NO3ESgrJYMD+z+OkQXW5Et38CqVu12HuLCNxUDTgCYirhce4ntk6epm
         fT9/sjxNADTv76gKkTevx0qrLJ1szZF4DBS1iaiSadhCNv8yCkdblfhU8MKExXIqVXvn
         BF7HUF8tb+JtF8jk6S/KJ+FxAMZamq+WUaIjBfhWr0rfTuKuiQ87V3vdOrVY8KQm/KDV
         Y8sYsgu+broqd9vJP46Qxuq8B+3UP7PS47EPbPTK7fixg1S74GeVzI8gHqD8027Gv2ix
         LTy16NVoeG1AIchMIvK5vsY6FBvvHzIQM6KPFj14mRO6yhd9Wyj8mjWI0fZexarSqjNI
         AHuA==
X-Gm-Message-State: AC+VfDwh7MukIJoSrihvM6mQtALadM/AqNb4r7W2E18GAAuFeESCmgZp
        D9IbjIUFZ6uNSEzTfCooaVWGdg==
X-Google-Smtp-Source: ACHHUZ5T4JJRJ8fgbx7qxtgyN7oMDnzb0y/FhCeDxcmhIqNJgCW1YAFxxuHwFhGWjkNrnbHB22VBBQ==
X-Received: by 2002:a25:fc28:0:b0:ba8:37bd:59db with SMTP id v40-20020a25fc28000000b00ba837bd59dbmr8298369ybd.34.1684731354145;
        Sun, 21 May 2023 21:55:54 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 185-20020a2505c2000000b00babd051a405sm938658ybf.26.2023.05.21.21.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 21:55:53 -0700 (PDT)
Date:   Sun, 21 May 2023 21:55:50 -0700 (PDT)
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
Subject: [PATCH 06/31] mm/page_vma_mapped: delete bogosity in
 page_vma_mapped_walk()
In-Reply-To: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
Message-ID: <502d6743-b0bf-d848-596a-4b3f3e44de8b@google.com>
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

Revert commit a7a69d8ba88d ("mm/thp: another PVMW_SYNC fix in
page_vma_mapped_walk()"): I was proud of that "Aha!" commit at the time,
but in revisiting page_vma_mapped_walk() for pte_offset_map() failure,
that block raised a doubt: and it now seems utterly bogus.  The prior
map_pte() has taken ptl unconditionally when PVMW_SYNC: I must have
forgotten that when making the change.  It did no harm, but could not
have fixed a BUG or WARN, and is hard to reconcile with coming changes.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/page_vma_mapped.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 64aff6718bdb..007dc7456f0e 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -275,10 +275,6 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 				goto restart;
 			}
 			pvmw->pte++;
-			if ((pvmw->flags & PVMW_SYNC) && !pvmw->ptl) {
-				pvmw->ptl = pte_lockptr(mm, pvmw->pmd);
-				spin_lock(pvmw->ptl);
-			}
 		} while (pte_none(*pvmw->pte));
 
 		if (!pvmw->ptl) {
-- 
2.35.3

