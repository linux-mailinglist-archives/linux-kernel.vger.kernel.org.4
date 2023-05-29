Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE25171446D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 08:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjE2GYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 02:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjE2GYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 02:24:23 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8CB100
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 23:23:52 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-ba81f71dfefso4296192276.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 23:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685341431; x=1687933431;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2gSRrpVaV+v6oTVvWHOeguB0KnrQ/fwH26LJ25rfvoA=;
        b=mUjO4pWKJgDDKZpKrtcPe8FWu0b2JY0+TgvW1MX4OtSul/CzSbQKQ3pqCcMlWFJNGp
         gWOyHbCB9BXc3wVa0KzB77Yil0KZvLHMQCnsIsQVZ9fFzAnqckLLbO2LnWVC3QgXUA2m
         AKj7k1CX2prs/vdJ8Dux8TrJisS6znNjC1Vtrv/PsdyCPjLHWieMNw6R9XprNyEWjRCZ
         4j0MNun5Zv7iQwiFWh+o2sHynbvf1kUMSyoEE1HC9cxss3LWR7d6E9drnyGo/GZyrbJL
         X1vYzNNY1HAUAQnzj74UQMsBrtflmgqlc89omMQkyN/nWA1df9Rcpj56XseLcz9CDb7K
         rRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685341431; x=1687933431;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2gSRrpVaV+v6oTVvWHOeguB0KnrQ/fwH26LJ25rfvoA=;
        b=bfyhuat8baSHlbVL5vZ0nWX0Y4m6DavaI89nlBOrFz3r529U/BmNUUPUKsdocYNErU
         FLD5WBfjsZmoqG+Za8LdL88YD5gcFVADMkgqY9S9z+a5ibJBR7GYN4BAXeQQR3a2wvhw
         iY9btR/U/CF0v6ZnJl6hGQCm4ajge+ZolLVeXH9zKHvj95aAVTaZBtQwhyvJ7k80LJiY
         8FkYsuxOcFYXKKKcYUftVXV7Qj71gcRxniuUmf82R4E7ID6N+l7Cvpszy4CDfgx2jY2T
         2y0rg8eQhl+VlF01yRUpDV7JCCFBWHhsv/d3+0Gqc7uNU3RbTKEasKkQkUof2SgYZoRl
         PeLQ==
X-Gm-Message-State: AC+VfDzacjEr/g5UI8xJvja7t0ObkH1WXtYpAuP+z27Q0Ad1JNwwDYNm
        5/wqboCcBezk/r48HkaT2q4Nrw==
X-Google-Smtp-Source: ACHHUZ5CcwvoGgzDzBbk+Lv5ieVtVZp8uUiYjI1VJBrm/lel9oSDffzWyg8Wn1mT8OaCxHwZBaPMhA==
X-Received: by 2002:a25:aae2:0:b0:bab:fdb3:7b56 with SMTP id t89-20020a25aae2000000b00babfdb37b56mr13795477ybi.24.1685341431250;
        Sun, 28 May 2023 23:23:51 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j73-20020a25d24c000000b00bb064767a4esm503449ybg.38.2023.05.28.23.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 23:23:50 -0700 (PDT)
Date:   Sun, 28 May 2023 23:23:47 -0700 (PDT)
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
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 08/12] mm/pgtable: add pte_free_defer() for pgtable as page
In-Reply-To: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
Message-ID: <739964d-c535-4db4-90ec-2166285b4d47@google.com>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the generic pte_free_defer(), to call pte_free() via call_rcu().
pte_free_defer() will be called inside khugepaged's retract_page_tables()
loop, where allocating extra memory cannot be relied upon.  This version
suits all those architectures which use an unfragmented page for one page
table (none of whose pte_free()s use the mm arg which was passed to it).

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/pgtable.h |  2 ++
 mm/pgtable-generic.c    | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 8b0fc7fdc46f..62a8732d92f0 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -112,6 +112,8 @@ static inline void pte_unmap(pte_t *pte)
 }
 #endif
 
+void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable);
+
 /* Find an entry in the second-level page table.. */
 #ifndef pmd_offset
 static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index d28b63386cef..471697dcb244 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -13,6 +13,7 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <linux/mm_inline.h>
+#include <asm/pgalloc.h>
 #include <asm/tlb.h>
 
 /*
@@ -230,6 +231,25 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long address,
 	return pmd;
 }
 #endif
+
+/* arch define pte_free_defer in asm/pgalloc.h for its own implementation */
+#ifndef pte_free_defer
+static void pte_free_now(struct rcu_head *head)
+{
+	struct page *page;
+
+	page = container_of(head, struct page, rcu_head);
+	pte_free(NULL /* mm not passed and not used */, (pgtable_t)page);
+}
+
+void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
+{
+	struct page *page;
+
+	page = pgtable;
+	call_rcu(&page->rcu_head, pte_free_now);
+}
+#endif /* pte_free_defer */
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 #if defined(CONFIG_GUP_GET_PXX_LOW_HIGH) && \
-- 
2.35.3

