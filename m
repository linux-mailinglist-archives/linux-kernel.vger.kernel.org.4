Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1FB714439
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 08:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjE2GVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 02:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjE2GVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 02:21:37 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04329B5
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 23:21:34 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-ba86ec8047bso4309360276.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 23:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685341293; x=1687933293;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kjV6xBD8+Z39YuH4hgrLfpItULNEjB3if/M/mkAbsVQ=;
        b=rWUgEbcRxN+0lh7aV7n4UOuWoW/akkZOM/gqoHjVcxn/6hheszcuPJOLVJ4sguWyP8
         nkQlUMJmy6e/Jx9YVzvAF7u4UBrtQ7Gt8z6ETj5pN1DYiBGqn6irZMUv2C9TbfCBC78I
         xaCU0qKIPP/XwpIBhRQPgPdjxQJW6d4VJskC/kyJTtslu2euOqK8ik9oIKBYFLT0OWAQ
         hthSfePHY1Fj36lFOt87PpfGm9V25DdJkUjrx5h6k5n/1x83JounXfxF7b0VnDNmT3pg
         /B3jbAdtHb1fjyAf9CqPVGMMMvFfo7sNqLyn5ELpZamilbHqPMk5v4bK33lqW9qB8lmS
         adrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685341293; x=1687933293;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kjV6xBD8+Z39YuH4hgrLfpItULNEjB3if/M/mkAbsVQ=;
        b=GnJwADKq6FsjwvYkhnnB/HTC2KcupIJ3lw2hILwtuM7Bm64dxumjGyEC+9CEKjV48H
         osPo2emiSnswvnqmrJDbtaR8dP4oVJ7XdQnPAtnM6q4zKSyzomO4WCgUFRBjoWYAF1ev
         0vgHF1AfUGx8LQrBFqI0BuPW2605FkvylUp0vzQSUf09eeH/22olPM/dvExRQzD/EbyN
         gvNSXm7U/AcX8ogZNVujiCQ+v1tDzCypQSFiBZy0+kL3gnNXJsDcw0BQbX3aVVgna8Ju
         zTXyEgIpReYpH94u8sAyStAn7MeShPD6IgLnuHVpOHZ7QUyXphv8ADqNbLDoGUGjhYj5
         Sybw==
X-Gm-Message-State: AC+VfDy0yTr2oZBwE8G9Az5YDQNpBiC4E3w2WcI6Bg8XrJPfjujXERuv
        mWoC5egjS15RjqvMLl28C2F0Wg==
X-Google-Smtp-Source: ACHHUZ6EPD4pm5LL+EWBEb/p2RZtAUzDMPbUfE7F4FXgHJQ8XYwzEv8l0puT9pEGX6+B6Mzd+dzTzw==
X-Received: by 2002:a25:d796:0:b0:ba8:3e89:bd69 with SMTP id o144-20020a25d796000000b00ba83e89bd69mr9536233ybg.12.1685341292952;
        Sun, 28 May 2023 23:21:32 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m205-20020a2571d6000000b00ba87bc06fe5sm2712527ybc.52.2023.05.28.23.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 23:21:32 -0700 (PDT)
Date:   Sun, 28 May 2023 23:21:27 -0700 (PDT)
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
Subject: [PATCH 06/12] sparc: add pte_free_defer() for pgtables sharing
 page
In-Reply-To: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
Message-ID: <f8d84fb8-eb9-6649-7137-715c6010468c@google.com>
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

Add sparc-specific pte_free_defer(), to call pte_free() via call_rcu().
pte_free_defer() will be called inside khugepaged's retract_page_tables()
loop, where allocating extra memory cannot be relied upon.  This precedes
the generic version to avoid build breakage from incompatible pgtable_t.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/sparc/include/asm/pgalloc_64.h |  4 ++++
 arch/sparc/mm/init_64.c             | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/sparc/include/asm/pgalloc_64.h b/arch/sparc/include/asm/pgalloc_64.h
index 7b5561d17ab1..caa7632be4c2 100644
--- a/arch/sparc/include/asm/pgalloc_64.h
+++ b/arch/sparc/include/asm/pgalloc_64.h
@@ -65,6 +65,10 @@ pgtable_t pte_alloc_one(struct mm_struct *mm);
 void pte_free_kernel(struct mm_struct *mm, pte_t *pte);
 void pte_free(struct mm_struct *mm, pgtable_t ptepage);
 
+/* arch use pte_free_defer() implementation in arch/sparc/mm/init_64.c */
+#define pte_free_defer pte_free_defer
+void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable);
+
 #define pmd_populate_kernel(MM, PMD, PTE)	pmd_set(MM, PMD, PTE)
 #define pmd_populate(MM, PMD, PTE)		pmd_set(MM, PMD, PTE)
 
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 04f9db0c3111..b7c6aa085ef6 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2930,6 +2930,22 @@ void pgtable_free(void *table, bool is_page)
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static void pte_free_now(struct rcu_head *head)
+{
+	struct page *page;
+
+	page = container_of(head, struct page, rcu_head);
+	__pte_free((pgtable_t)page_to_virt(page));
+}
+
+void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
+{
+	struct page *page;
+
+	page = virt_to_page(pgtable);
+	call_rcu(&page->rcu_head, pte_free_now);
+}
+
 void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
 			  pmd_t *pmd)
 {
-- 
2.35.3

