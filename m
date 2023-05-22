Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3D170B44A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjEVFEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjEVFEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:04:12 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EC9F4
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:04:11 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-561c1ae21e7so73851677b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684731850; x=1687323850;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gMNcXWmakk7P+zoeKodH9UUwH6aG3s17nHsuG14zY8Y=;
        b=yE9oBZ+c+KHVypY5gza4GB1+80d52bTCDbLI/Y6WgFZjswF85OgTmRueNohIKa5HCn
         RIW2Wnvd56WBT/PaJWNYgidoUhB8V5KAp9zJm+23i0kvJLcqYbw0yNLwpWS8EoUIgMXO
         0057efgR9JUAdgc/f2mkKLwhOjnHnkDDKtEeFpSuOpxEwvKhw8lEmNKs6VxGMTFXq9W5
         sSyOJRzgEjdA5DausOy5f9zrEnebUpaQfXGLkpy0BqfSupfqQaLTpS0g/cbhzJZLF6eH
         CdCRTra6FNLJCs5X7UtLw6KjHZYdHYr0T5056rVVYaa+mJu1Od1zuvThKJk70HtbvQjx
         SxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684731850; x=1687323850;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMNcXWmakk7P+zoeKodH9UUwH6aG3s17nHsuG14zY8Y=;
        b=hkiQQMZ8kbDZ8Keo5biyQe2tdLlnBWKJ+ULT9N9Q5L7A+F7aXyTg248RXQ9sfHbSXC
         3za5l5Bs23jNFVFXvzEfVC4ALwji6ZAZ3vXgb5g0HaK+dwhw3den5KyUrj0aYORalZ8t
         7SmIZtMSN8hod9x7MrEhfsR71SPhlALRbD7EzceasRPpow83yvowuONxqG7rHDIJPLoI
         8ex0JOYjpt5TOT+5bubnLViLXIBEPZVgDXEwHldlqXtFfaiYl3iBnXx27QYtfNLCvNCc
         f5sTjiVd4BVkxd7+COIYYBLZAGYs2inrERf4Ob+o8Oylp4l7oo4+hasAiFRugyTJBfpv
         lCtA==
X-Gm-Message-State: AC+VfDzpQS7hLrvOH6HVD1WY7cndSqzkUSNBHUPZpKgmukKdeHNt+psi
        eQZSVXhejlQRqqLDOnsyROgdyg==
X-Google-Smtp-Source: ACHHUZ4s2TnDnXPeA62RlJKiZrtDTHYAyZbSNbhHfgawNyc1d9fDfp4flHO3RJFgNx0d20xXc/Hleg==
X-Received: by 2002:a0d:d656:0:b0:55d:c8fb:8f61 with SMTP id y83-20020a0dd656000000b0055dc8fb8f61mr10119663ywd.7.1684731850557;
        Sun, 21 May 2023 22:04:10 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t184-20020a0dd1c1000000b00555c30ec361sm1798344ywd.143.2023.05.21.22.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 22:04:10 -0700 (PDT)
Date:   Sun, 21 May 2023 22:04:07 -0700 (PDT)
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
Subject: [PATCH 12/31] mm/vmalloc: vmalloc_to_page() use
 pte_offset_kernel()
In-Reply-To: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
Message-ID: <fc3c7ca1-6c9c-b6c-f4df-36f24b56139@google.com>
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

vmalloc_to_page() was using pte_offset_map() (followed by pte_unmap()),
but it's intended for userspace page tables: prefer pte_offset_kernel().

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/vmalloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 9683573f1225..741722d247d5 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -703,11 +703,10 @@ struct page *vmalloc_to_page(const void *vmalloc_addr)
 	if (WARN_ON_ONCE(pmd_bad(*pmd)))
 		return NULL;
 
-	ptep = pte_offset_map(pmd, addr);
+	ptep = pte_offset_kernel(pmd, addr);
 	pte = *ptep;
 	if (pte_present(pte))
 		page = pte_page(pte);
-	pte_unmap(ptep);
 
 	return page;
 }
-- 
2.35.3

