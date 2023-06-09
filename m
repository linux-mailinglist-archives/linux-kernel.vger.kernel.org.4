Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE39728D07
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237606AbjFIBX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjFIBXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:23:25 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A694F18D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:23:24 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-565c7399afaso11693017b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 18:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686273804; x=1688865804;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3KTDoQQSpcjB9NQiyOQFUXOX88v07BrrKabYvpMIx6w=;
        b=PhwpDxcjLXiR7MGVaWKfABLE3dmRB3qka2k6U1l+muDGzWLhomU4qiQ57KmT6VH8qY
         ACB3DayhC4faseiipd0QCNLUtNtuFH3XTvyWMyC+FvmNiYj2hTBmc8pdfyd4XFmOfbWU
         tZooxmyCXH+STIuVMaRhFjnJtSpEto0Mxch6xRdf+bo4VO2G6a/c8gheC2mOEmzSx5zk
         ccYQOeUWSm1v0s9lMRW9nRmwt5CbXGDSvPCaqv/QLtUPzWt0If7EQ4o8TmUAMcKVROe3
         I5HEpFf63MgdvN7DdkYJ8qdg2z230og4tgBl+c7UnWgkZm/cRQnWkzi++q5rmkDVXcaG
         0vug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686273804; x=1688865804;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3KTDoQQSpcjB9NQiyOQFUXOX88v07BrrKabYvpMIx6w=;
        b=GiZd0qIQHOl9r87QXH+ZzsjIRWiv+KvxNhYDHhmgudyKY22riOcjdH3NFHbUdJD/SC
         3jg/7wMfqW9hKKhIgzUvde/s9fG3pj39i/HCdw4FEfYUv03qHXVxCqS9DOhYnD20bXBs
         Ccth8W1bMF4xm0s+mtcvuCaIzjVv5ii1QShydMK60JDjmSALoAbd1c4SnRGiJ5DTrg2A
         bcr8anlJasdgiBp8wrc1747ZLZH9IoDdPFxyBhHtNCCPjTMIHX6fzO/9Rd+Y4GIpfzrf
         XxMXoei1MN3D1sJKckPrL0QHpx9UYnM34Nx83hD7XvlkYShA8i/NxuOLfYixT6bwWPnV
         ySMA==
X-Gm-Message-State: AC+VfDxr8usE8FyZufSo6SSZXNUpodEWKNsI8b7L+KdektYVD8M2hOVG
        pj7+jsCxNDdOkaPwnyX/w1Cu8g==
X-Google-Smtp-Source: ACHHUZ5Qxg9qOQctVm9TDBIrvRBwWLkj4+fag3kdEXz2orEpq2AOsjXF+B86JD9LcmOUKUNihoCjxw==
X-Received: by 2002:a81:6743:0:b0:568:f9f0:b057 with SMTP id b64-20020a816743000000b00568f9f0b057mr1198700ywc.26.1686273803806;
        Thu, 08 Jun 2023 18:23:23 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i11-20020a0ddf0b000000b00568ab5dd873sm288724ywe.65.2023.06.08.18.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 18:23:23 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:23:19 -0700 (PDT)
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
Subject: [PATCH v2 13/32] mm/hmm: retry if pte_offset_map() fails
In-Reply-To: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
Message-ID: <d6c6dd68-25d4-653b-f94b-a45c53ee04b@google.com>
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

hmm_vma_walk_pmd() is called through mm_walk, but already has a goto
again loop of its own, so take part in that if pte_offset_map() fails.

Signed-off-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
---
 mm/hmm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/hmm.c b/mm/hmm.c
index e23043345615..b1a9159d7c92 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -381,6 +381,8 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 	}
 
 	ptep = pte_offset_map(pmdp, addr);
+	if (!ptep)
+		goto again;
 	for (; addr < end; addr += PAGE_SIZE, ptep++, hmm_pfns++) {
 		int r;
 
-- 
2.35.3

