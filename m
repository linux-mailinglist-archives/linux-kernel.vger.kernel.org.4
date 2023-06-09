Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217A9728CD9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235551AbjFIBJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFIBJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:09:32 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56462125
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:09:31 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-786470fd7a3so464537241.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 18:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686272970; x=1688864970;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lc/g6LXQOs93yTgCiGczTkkFK+sAgodNjTysgahDEVw=;
        b=UcfhhEB8JVYtSaYNjeXN56wB9MqyMQtCQGtprQFTqjfYjEL7E7V3Iy94OMfqel1oXO
         QZIcQiOjvsa3e98AoL/nIYiIeV2XwYtBY8pjjhbDjSLvNRXQUNuQ1CEyYWBCd3xYPZVP
         trZtykP/Mof04N1VHc0lVHbgyp1EiW4pew5nO8aSYUb++iO0ncGeIIIiQK3p/c+W0yHU
         AAa6tsu0E2vKcj4HqLxwkHvPM9meFiA6K3qv+5vTGLBRG4cfgXg5/75cLxanqJajUo8o
         cFN/FNCedO3dWchgzF6syrkwFnGXauAim52zAU4uX164Btb5VfynbXsQAJloguXMP3eG
         dROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686272970; x=1688864970;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lc/g6LXQOs93yTgCiGczTkkFK+sAgodNjTysgahDEVw=;
        b=axaT44TRtnT5adueFlXqt2Nb0labDw9oSj/8uTSjE6Num/DSgY8HVkgAwxHrXVhUh1
         o1KmDlILMXr+7jvdHL1QKGS2+TuKcwaNJHYJ6lydsfPBnqV5k/cNq91dB+pdx+NZCybi
         QpQWOqcpPlJT0AZc0ZbD17msch3lglKJOpiXw1R62MGBQWRt6kGOnuUUHUNOa6/kdUi8
         bMZYiDpdzgFPInEjimAfWRbfGFXVflqGZR1kbWZp/KUQ6i85DPlzD5muelK9a9+Yw02s
         NIJwO4R+FRNRTgZ5zedua5EyO7oa9PlikcqdtPuHLcZfv++nPB+hY0ThDARn92xoIl7J
         kk+Q==
X-Gm-Message-State: AC+VfDzqbQjqY1eaTSYdb/eYyQjbSVlfErPC4Ot9zSQUzlDCU8RFqtrz
        3oj6WheFZNs1fVR5LDplA5gtdg==
X-Google-Smtp-Source: ACHHUZ5C3ZXPkFDl7beNnC8Wxo2aSMU5SCcCj/7iCu4IfWqU05s5B/rb2VYjxSOJxyLyi/equlOn5A==
X-Received: by 2002:a67:f490:0:b0:43b:1dfa:2534 with SMTP id o16-20020a67f490000000b0043b1dfa2534mr162704vsn.10.1686272970295;
        Thu, 08 Jun 2023 18:09:30 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n11-20020a25400b000000b00bb393903508sm603507yba.14.2023.06.08.18.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 18:09:29 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:09:25 -0700 (PDT)
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
Subject: [PATCH v2 03/32] mm/pgtable: kmap_local_page() instead of
 kmap_atomic()
In-Reply-To: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
Message-ID: <d74dc4b3-6a76-446f-8f5-52ae271fa07d@google.com>
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

pte_offset_map() was still using kmap_atomic(): update it to the
preferred kmap_local_page() before making further changes there, in case
we need this as a bisection point; but I doubt it can cause any trouble.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/pgtable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 8ec27fe69dc8..94235ff2706e 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -96,9 +96,9 @@ static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long address)
 
 #if defined(CONFIG_HIGHPTE)
 #define pte_offset_map(dir, address)				\
-	((pte_t *)kmap_atomic(pmd_page(*(dir))) +		\
+	((pte_t *)kmap_local_page(pmd_page(*(dir))) +		\
 	 pte_index((address)))
-#define pte_unmap(pte) kunmap_atomic((pte))
+#define pte_unmap(pte) kunmap_local((pte))
 #else
 #define pte_offset_map(dir, address)	pte_offset_kernel((dir), (address))
 #define pte_unmap(pte) ((void)(pte))	/* NOP */
-- 
2.35.3

