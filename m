Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776E174FE46
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 06:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjGLEgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 00:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjGLEgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 00:36:07 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71DC139
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 21:36:05 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5701eaf0d04so72803017b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 21:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689136565; x=1691728565;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rNkuOnMiPA5uKMNmzDSZhkkEhVwG+08I0Sc1INz+wy8=;
        b=FFbzGiP1Hn/cx8QOOnqnR11nIjqgT83mtNZkbCUQnSq5LrblamhVfpvB+UeJbyZW1s
         y4J6XTFnK8fA2dLUAHHtBip6qAhzoi/1hVVGt2YPDhBzcNtIdNEwDD9zadVtdk/xueRH
         ZKLjXaeVhHWhvtWyuu/YKxYZxvMKkRUX8OZHqVf6Z3jPZZZJRTzTUXJQXMXyRqkMOflu
         Wsa6cYIz8XLnnJEBGqzhXR/oYVqaIyb5OBPuZhbuAADdjSajptwPQTErMBx4XyNaSU8b
         s7pjxVInyPyp25nFk59wK/5ndqw3B7p/EJhYwYVyO8aZGxHmDzIQpJw9VHF7rxxbYyvE
         Gp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689136565; x=1691728565;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rNkuOnMiPA5uKMNmzDSZhkkEhVwG+08I0Sc1INz+wy8=;
        b=Giy9qcg1vdnW6WJi9BwmnvWaxclcKVa+/itlMst0yVSZzvrZ8xDHUZOpMejeyNu0/B
         aarFTkXNYOAIUViDWLUW5YuqxmWqurw4DpvkAxQPCksexLHOCje6dNesN0H0nFhWJAq9
         iMoIgXLNVb0Qg6HARdNxlB8QKWHvaoOPGY6Kzlc/wZPnp3qCIp8Sr7ySlAeEfJDn4Wcm
         Qbm6V4pvVPzK2oI1Uu63AQ5gVMKFIJDLrqGwDjJvwFvwaBUHS0DAbxoxw58vu7GSfwV+
         p+/iZICLX7PngyjhjryVO/frVAEDrWxjyZg8XSjhleWTx8vrYE+hsOv2Pf5JowksFLEE
         eyXA==
X-Gm-Message-State: ABy/qLbaVNQFNuRMRqRIKGQJqYeF1eHtVNDKBY9b/Rmm0kz0gTeU2ghE
        8Xcqm9RTCCki/C/muho4YzSW3A==
X-Google-Smtp-Source: APBJJlFtIJlcayIhMEpj3vHnt3xsOXLGUeoHM39mGyyz8wsLsKOn5HDkQrRum1Ly6OBtEql+IV2D3A==
X-Received: by 2002:a0d:e88d:0:b0:577:606c:284b with SMTP id r135-20020a0de88d000000b00577606c284bmr15146586ywe.16.1689136564850;
        Tue, 11 Jul 2023 21:36:04 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m124-20020a817182000000b0056d0709e0besm968571ywc.129.2023.07.11.21.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 21:36:04 -0700 (PDT)
Date:   Tue, 11 Jul 2023 21:35:59 -0700 (PDT)
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
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3 05/13] powerpc: add pte_free_defer() for pgtables sharing
 page
In-Reply-To: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com>
Message-ID: <6e3ca5f1-334d-4b14-b92d-fc8e99914fcb@google.com>
References: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add powerpc-specific pte_free_defer(), to free table page via call_rcu().
pte_free_defer() will be called inside khugepaged's retract_page_tables()
loop, where allocating extra memory cannot be relied upon.  This precedes
the generic version to avoid build breakage from incompatible pgtable_t.

This is awkward because the struct page contains only one rcu_head, but
that page may be shared between PTE_FRAG_NR pagetables, each wanting to
use the rcu_head at the same time.  But powerpc never reuses a fragment
once it has been freed: so mark the page Active in pte_free_defer(),
before calling pte_fragment_free() directly; and there call_rcu() to
pte_free_now() when last fragment is freed and the page is PageActive.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/powerpc/include/asm/pgalloc.h |  4 ++++
 arch/powerpc/mm/pgtable-frag.c     | 29 ++++++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/pgalloc.h b/arch/powerpc/include/asm/pgalloc.h
index 3360cad78ace..3a971e2a8c73 100644
--- a/arch/powerpc/include/asm/pgalloc.h
+++ b/arch/powerpc/include/asm/pgalloc.h
@@ -45,6 +45,10 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
 	pte_fragment_free((unsigned long *)ptepage, 0);
 }
 
+/* arch use pte_free_defer() implementation in arch/powerpc/mm/pgtable-frag.c */
+#define pte_free_defer pte_free_defer
+void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable);
+
 /*
  * Functions that deal with pagetables that could be at any level of
  * the table need to be passed an "index_size" so they know how to
diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
index 20652daa1d7e..0c6b68130025 100644
--- a/arch/powerpc/mm/pgtable-frag.c
+++ b/arch/powerpc/mm/pgtable-frag.c
@@ -106,6 +106,15 @@ pte_t *pte_fragment_alloc(struct mm_struct *mm, int kernel)
 	return __alloc_for_ptecache(mm, kernel);
 }
 
+static void pte_free_now(struct rcu_head *head)
+{
+	struct page *page;
+
+	page = container_of(head, struct page, rcu_head);
+	pgtable_pte_page_dtor(page);
+	__free_page(page);
+}
+
 void pte_fragment_free(unsigned long *table, int kernel)
 {
 	struct page *page = virt_to_page(table);
@@ -115,8 +124,22 @@ void pte_fragment_free(unsigned long *table, int kernel)
 
 	BUG_ON(atomic_read(&page->pt_frag_refcount) <= 0);
 	if (atomic_dec_and_test(&page->pt_frag_refcount)) {
-		if (!kernel)
-			pgtable_pte_page_dtor(page);
-		__free_page(page);
+		if (kernel)
+			__free_page(page);
+		else if (TestClearPageActive(page))
+			call_rcu(&page->rcu_head, pte_free_now);
+		else
+			pte_free_now(&page->rcu_head);
 	}
 }
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
+{
+	struct page *page;
+
+	page = virt_to_page(pgtable);
+	SetPageActive(page);
+	pte_fragment_free((unsigned long *)pgtable, 0);
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-- 
2.35.3

