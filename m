Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD1C70B43D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 06:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjEVEye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 00:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjEVEyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 00:54:31 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699DEE9
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 21:54:29 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-561afe72a73so76337857b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 21:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684731268; x=1687323268;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DKO2MGlysYL+7+oQy8UdaapVjC7HViDdumwjMefUUFk=;
        b=J9ylJNbawMeH4tOfy11w+ZaO/6872J2rqfHP5lovPYJFW8zB72NKQpN6jeQPkFtYO5
         7RHmvMjgUcPMPHqNGnXVyrAFqE5jQbr7ovn6/CLPgFbf3l4X7M/QuLcTo+6IociOTnvp
         5CQ9bnI6x5YxJS4Rh5hvct/0Yo5JX0qxeMmK1yabPvgHVQgZYihchIYIgKApcKzJ3IRg
         ROh6CHyiaDDOL+Ex2mG/L8yyWOYTqU/rosesPvWEE4ijihe6qctq0T8BNRcL6ZpZfkCn
         M6FU+PpeRPkKqHsAb2AldyKg/94bE7H6WNY4ZFE5SlqswttpLgasmwxgkPJXNEXdyjtP
         03EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684731268; x=1687323268;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DKO2MGlysYL+7+oQy8UdaapVjC7HViDdumwjMefUUFk=;
        b=Pymt1ElQf608iFI+8jZDVJTW3E//lxwzfyY6rgB3vvX+Z1wYsH7162FejLcmsK3zj7
         LfTvtUTGfg8Xh0UN1KtmnCjq0UCIUWefKalz68eZ+bQcLys2InsYlvXXRvvFNyGj2MGY
         FP0fWktXqGVpHdlghFVlEApfHDu/H+OGgwsOIlJF6M0eTHj2xjpBRg++fabGVuD/YBLk
         rsa2XoHD1s0AOwc82FAZwC+2NG0Z9xvE/MO4868TqVIqQFW3a1HhVPgmPNLfnI1A7Eam
         N0J1m9IEzYyBbwjRPEOBLH4N0oW9lzKWSYg5g5gJmHzMnF+XvGLTmv0Y+URZULk/dl/b
         lskQ==
X-Gm-Message-State: AC+VfDxNNRvLbkBGmuE5OeTFEUQiIUT0GKbyRlW5ry6S4DbHQKmj6AII
        Zv+t2laoX3XD+xIRMmXZ4CrGDQ==
X-Google-Smtp-Source: ACHHUZ4551zDAoXcCIh8jhAd8f8X+Cxw/fLbkIrjHAC/+8ziZTZq6Fx4vtipE1QtRd7bp1hgyGTCog==
X-Received: by 2002:a81:4e97:0:b0:561:e7bb:36a1 with SMTP id c145-20020a814e97000000b00561e7bb36a1mr8839265ywb.49.1684731268515;
        Sun, 21 May 2023 21:54:28 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r190-20020a0de8c7000000b0056189f9ec2asm1803508ywe.133.2023.05.21.21.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 21:54:28 -0700 (PDT)
Date:   Sun, 21 May 2023 21:54:25 -0700 (PDT)
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
Subject: [PATCH 05/31] mm/filemap: allow pte_offset_map_lock() to fail
In-Reply-To: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
Message-ID: <3e6d4f8-9f4d-fa7e-304e-1494dddd45b@google.com>
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

