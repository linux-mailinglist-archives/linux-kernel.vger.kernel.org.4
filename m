Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50531728CE4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237263AbjFIBLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjFIBLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:11:39 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E4330F2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:11:35 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-75d4b85b3ccso117688185a.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 18:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686273094; x=1688865094;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DKO2MGlysYL+7+oQy8UdaapVjC7HViDdumwjMefUUFk=;
        b=sgrtTue3rv24LYzFS1k289BQNEsOuAchrD6cHOusSyoPb1K73NZICBU4ccdS+MDThN
         zBEewtmtI4CNAWNB55+HxFZZrtyp16opIUtn0ashIh7fwhjdgk+9O/mwLbz9OSd84hi/
         pBLFfsBUzEB4I2fW6b9r72oAK2m+QnFCxV5NwJBtw2NTKg7epNTeTUcPNH+shND90LBV
         x2i2pLMwvamhFrNXJIWV1Y51CIqpk9A6NTBVqHI51CoxyJBUf9QXsv4+sDVgvqVWsQDD
         RoswrTGcvQxNRpRSEw4ateSoH47vdZ8PWjBeC9XQHtwBxYtSov2fw90M/6dX+45eNcbK
         0hmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686273094; x=1688865094;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DKO2MGlysYL+7+oQy8UdaapVjC7HViDdumwjMefUUFk=;
        b=Lws1I3lclU1q+6zInSyGiwQzMf+Gs3PMYWrRrKQPhNDBQnhkie/51y9NANO6Kpt5Nu
         QxY5/FnkMV27SVDEkCAD0LnaPQakAnFNjLJQTKR+SjdxB5Cc5o6e/fAy7MOyq8vl0MXL
         /GuiDxek7krBnQ4qg5NfLS4X27REZr3AXxOfBd5ToXbsoJ5UieXkuWO0jrH4De0Unyfc
         s6pNQxXlZZBgWMkBVpCUdSxL9aL5AE86x47d0A9/N4KMo8XghZ1W784GIVa5ztQ9QlQT
         KnRPW2BorJV8HHBM3db/+J6yDDAKvYOLErN1DQfpX0UNNEzJtT5+zxUpkFvgHJ+pNxAH
         PS0A==
X-Gm-Message-State: AC+VfDx9AJoFaVwFy1ASMgzqQETBCROO5Wg6hBG+uGjFRvgxRqsG/lI3
        HC4rSRfTn+7KZMmtEj5NPlq47g==
X-Google-Smtp-Source: ACHHUZ43VqWz0kXy5mK3UV6S1YjsSZPeNy+eW38Rkn5m5MYDr07ka9TKGJWrHyw+7CpJWl7tn2JLMg==
X-Received: by 2002:a05:620a:a02:b0:75e:ba6e:be65 with SMTP id i2-20020a05620a0a0200b0075eba6ebe65mr6769325qka.55.1686273094097;
        Thu, 08 Jun 2023 18:11:34 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y63-20020a817d42000000b0056507de3d82sm273863ywc.104.2023.06.08.18.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 18:11:33 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:11:29 -0700 (PDT)
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
Subject: [PATCH v2 05/32] mm/filemap: allow pte_offset_map_lock() to fail
In-Reply-To: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
Message-ID: <54607cf4-ddb6-7ef3-043-1d2de1a9a71@google.com>
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

filemap_map_pages() allow pte_offset_map_lock() to fail; and remove the
pmd_devmap_trans_unstable() check from filemap_map_pmd(), which can safely
return to filemap_map_pages() and let pte_offset_map_lock() discover that.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/filemap.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 28b42ee848a4..9e129ad43e0d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3408,13 +3408,6 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct folio *folio,
 	if (pmd_none(*vmf->pmd))
 		pmd_install(mm, vmf->pmd, &vmf->prealloc_pte);
 
-	/* See comment in handle_pte_fault() */
-	if (pmd_devmap_trans_unstable(vmf->pmd)) {
-		folio_unlock(folio);
-		folio_put(folio);
-		return true;
-	}
-
 	return false;
 }
 
@@ -3501,6 +3494,11 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 
 	addr = vma->vm_start + ((start_pgoff - vma->vm_pgoff) << PAGE_SHIFT);
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
+	if (!vmf->pte) {
+		folio_unlock(folio);
+		folio_put(folio);
+		goto out;
+	}
 	do {
 again:
 		page = folio_file_page(folio, xas.xa_index);
-- 
2.35.3

