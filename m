Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA9370B44C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjEVFFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjEVFFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:05:20 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04652E9
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:05:19 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-b9daef8681fso4783618276.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684731919; x=1687323919;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9fqf/aXpqllLgdqCnqVNZO09v0Ag5UU0wZCu2wmsUs=;
        b=OKj/gvd6hObldwT6K4phcbvAmhbsjul6iPbLRzKjs71jzjUwd6r3e8xCWCNZVwPENy
         0HaWB0qgO/fNnS/Ois67og8DBdTyq3v/IDNkLAR46vDKiCQUR3xPJoyU7eFLCu5OCUxu
         ene9fgjo5yHZ3AS4/uG54DbEfQUuxcpEJxYx8UgryAp+t99VA5jZFAwJV246EE9mtg1F
         OZdfnZLlti+W2fNxVTHpJKMKRYyeIyeNsz3sd1gR6zvPQCCVQ9jZz+INsTuvonpNhmYF
         Bm782lSdhp0xDJA2N1jyxGLFmtKZ57I/CBr/DUG8sWZnMiCyq1l9BTQfv5dwSU+wKfRJ
         U63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684731919; x=1687323919;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9fqf/aXpqllLgdqCnqVNZO09v0Ag5UU0wZCu2wmsUs=;
        b=FbAWxP75Sxkv1o8ghhO5EebgDFgN1xxVBnpRxQSPLVGvrZu+l4Zy5oX4Ub+Nta1gML
         OiFlWdGZFL1qZiMWfdI6XkZq5xHtKMGFLxtiJEAfbd2cgQnRMPie8pNMRi4cL+kKKV3+
         WeGvRsduYYzFT1kYASvE4wfLXwwzUAk8llXiU+CrfrvSFsRYz619og6nwrsMyaQpEjIb
         9QrOECUHZLElPEKfa448+Zy1Efab9JEbLn1aT/oPPhPFoobGfAfCI7bLBNHDazqhu6lt
         gSIhbPaWR0fLbsyqQPg4nmUwyv8mHDH/YTwpOzmrXOvEZJ6k9WqrnnmQTh3ZZKKmRRWJ
         lqLw==
X-Gm-Message-State: AC+VfDyzJ/5a8r7C55u8YS3eIQXYFk0fGH7pK7wFJ3BZ0nCOl18W77Cd
        INa1x4yvnJjjwz1rwfhnbpUn6A==
X-Google-Smtp-Source: ACHHUZ5Raj9TudeXZElbzzsJbxf03YA3/zAVWdObhAbA8Pr6yvbRJfnYmXwklG1UR7VtuXWIGmLBMQ==
X-Received: by 2002:a25:fa12:0:b0:ba8:1c9e:c77f with SMTP id b18-20020a25fa12000000b00ba81c9ec77fmr9327198ybe.22.1684731919014;
        Sun, 21 May 2023 22:05:19 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a12-20020a25938c000000b00ba87e9b5bf9sm1274482ybm.45.2023.05.21.22.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 22:05:18 -0700 (PDT)
Date:   Sun, 21 May 2023 22:05:15 -0700 (PDT)
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
Subject: [PATCH 13/31] mm/hmm: retry if pte_offset_map() fails
In-Reply-To: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
Message-ID: <2edc4657-b6ff-3d6e-2342-6b60bfccc5b@google.com>
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

hmm_vma_walk_pmd() is called through mm_walk, but already has a goto
again loop of its own, so take part in that if pte_offset_map() fails.

Signed-off-by: Hugh Dickins <hughd@google.com>
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

