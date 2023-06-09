Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA434728D04
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237672AbjFIBWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237618AbjFIBVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:21:47 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F611FDF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:21:46 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-bb3d122a19fso1262860276.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 18:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686273706; x=1688865706;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ngswcYXh32wJZMu4ey5160LWyE599vrHnWvZmx6kKak=;
        b=DCQmA7jyE39MLlNzgNj5Fnvt6VxEVhxfR43nyr9O34TsE/NR89GCRNiD4ZoZdR4Qh/
         VVlLGnas01pgDThKof5oMLzzf1GcWd8TwEjNBhNMTY02KeG47WG7BA2R3pdxHonu/WZa
         V3CvdasgvhS1HvjB0i2UUPMQsDXJR6NqotUE643j7wgPp8AFNy/qFFWZUuLH+fdomurR
         thKNoJK95KQaiNcwFeztAb+d5ZaqpXtxhvroVgVoxsGEe35huAPILPbeWC7G/RPecM4M
         XWHbDzBCI7PfoB33hTMYlIVyb/ngBEvTOCi3mr/ilks4HMOz+anwKzwFIqfyaYnbXfBU
         DGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686273706; x=1688865706;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ngswcYXh32wJZMu4ey5160LWyE599vrHnWvZmx6kKak=;
        b=SAiSofQJRF/nlWxzRZhgeBSxX7agnwj6cK7jw0DMVcRHkv/uDdOKkaDHdlUYOsXU1E
         iSrKvOiZBC5akRbzaoJ/0kEnQDFUgfh4dDMcRwu0JdS2rOSutOeCxhonRpyu6sFl3SUj
         Z1BSMz1J8H1nQRkQfrmt4bbOk7eSldr73YL36oeISAHHHi9FVPaRZpFmDZ4L0eji5sqo
         Ie+QMUzBgGflNqCrD2yHM2zRo7o5StC26ZORynPsbVIn+qmzJiKV3UrBJH2M+nFsVhUq
         m8CvkXq8IAHticA7GuRSsJEjQJFg8j5ZChx7YvrstpZIu0TYIAqf3IAomJkrt6e313nG
         Puig==
X-Gm-Message-State: AC+VfDzg2BTBr4MPnj2kXmzg9Fzd3zjL3g3z7cIn13FLXQ9bvZeb8Qm+
        2O3VLRGITpII4yzfzYofszDgfg==
X-Google-Smtp-Source: ACHHUZ6Ffc3fQZoL4RMB14OmxVVM/4jw5aXSDM9hxxoBcUG6hRO5j/bd0jr5kM6GfmtOtWXvD7TQfA==
X-Received: by 2002:a25:f501:0:b0:bb3:9255:33e9 with SMTP id a1-20020a25f501000000b00bb3925533e9mr1145250ybe.53.1686273705789;
        Thu, 08 Jun 2023 18:21:45 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t12-20020a5b0dcc000000b00bb138b444dcsm586743ybr.36.2023.06.08.18.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 18:21:44 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:21:41 -0700 (PDT)
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
Subject: [PATCH v2 12/32] mm/vmalloc: vmalloc_to_page() use
 pte_offset_kernel()
In-Reply-To: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
Message-ID: <696386a-84f8-b33c-82e5-f865ed6eb39@google.com>
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

vmalloc_to_page() was using pte_offset_map() (followed by pte_unmap()),
but it's intended for userspace page tables: prefer pte_offset_kernel().

Signed-off-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
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

