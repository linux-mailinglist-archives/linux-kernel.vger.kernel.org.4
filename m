Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988E474FE35
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 06:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjGLEbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 00:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjGLEa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 00:30:58 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2344E1738
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 21:30:55 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-c5f98fc4237so6097721276.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 21:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689136254; x=1691728254;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lih86tpYDD3J7zG12H/yvKEagSCLBGtcWN3xnGIcrQ8=;
        b=RBETceKTxUIdE5Wthq5VyXl1iuewXFCZtvj7DAV2aR3XnxKua3oR4hmOqLeBfiK+Bo
         QX5kHPh+nmkLT9qkicOsu2l1qxImFf+42zqUi71fI6EVfsz6Wd8j8qUrewGd84C27fQF
         z08YkGvSrNifDm+H1bjPb9jqoZlNdzHFdJ/PGyx79rM0dM13MzFCo6oGzmwGF3H2DHxK
         jhmvYEXUAQ46tN3PfeVxdIIezDCwRgqWW3fiTQ5gpTM5B8KutupuJmp6cYEM5cSz9f5W
         fLAc5DNp+0Wj3x5T2KO5EPXVkVyBxsI6lOPcm2rzPIqTF2kKG/dKpgqnKRkoKETZyp95
         sIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689136254; x=1691728254;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lih86tpYDD3J7zG12H/yvKEagSCLBGtcWN3xnGIcrQ8=;
        b=NeFuw/BeqgLXk2rj3ylVoMMKapl2ydtKrMjd7jPlx4v5z4U5pFy00VXQmuEnXx0Wms
         T/dhO6s5HKAwplALaIcaqQRa8LS6xK4Kmkwo+p528lJQalJKREhoki7bcLXuNhsUb366
         ris59f/WCyCG1GXV4Uv/Hmv2/a/wfrJQKK9zEuJRlK7/D566zm1br23gtgOBEW6prdlT
         igKVhfOHhVLAST5NJPbG0mHLwJA1QM2dklQCTp04LNfbJPoIMfH2yA5yHS2zCw28pbeN
         BMHq1BnhURCX9UlRzXqvO4Aha3CFX75MUDiu5jNGuG+m5z+MnIWFgiLkE3HL047VGiC8
         F0Hw==
X-Gm-Message-State: ABy/qLYGJwVQB8H8XuuNXwx92go0mFkc/VLY2gi9Wn/zIohVLfi5OIR+
        JjYaDryqMvp+TDuPf6/MliI6zQ==
X-Google-Smtp-Source: APBJJlG+aqkZgSinL0H+vGhJ8SPTaMZTSfjnzUjRq5ezvCFkxr+RV56UV3ToUF/QNi8B1m8dggx9Pw==
X-Received: by 2002:a25:8a06:0:b0:c3d:25af:45ec with SMTP id g6-20020a258a06000000b00c3d25af45ecmr14975706ybl.41.1689136254058;
        Tue, 11 Jul 2023 21:30:54 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b8-20020a252e48000000b00c61af359b15sm750774ybn.43.2023.07.11.21.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 21:30:53 -0700 (PDT)
Date:   Tue, 11 Jul 2023 21:30:40 -0700 (PDT)
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
Subject: [PATCH v3 01/13] mm/pgtable: add rcu_read_lock() and
 rcu_read_unlock()s
In-Reply-To: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com>
Message-ID: <d3b01da5-2a6-833c-6681-67a3e024a16f@google.com>
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

Before putting them to use (several commits later), add rcu_read_lock()
to pte_offset_map(), and rcu_read_unlock() to pte_unmap().  Make this a
separate commit, since it risks exposing imbalances: prior commits have
fixed all the known imbalances, but we may find some have been missed.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/pgtable.h | 4 ++--
 mm/pgtable-generic.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 5063b482e34f..5134edcec668 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -99,7 +99,7 @@ static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long address)
 	((pte_t *)kmap_local_page(pmd_page(*(pmd))) + pte_index((address)))
 #define pte_unmap(pte)	do {	\
 	kunmap_local((pte));	\
-	/* rcu_read_unlock() to be added later */	\
+	rcu_read_unlock();	\
 } while (0)
 #else
 static inline pte_t *__pte_map(pmd_t *pmd, unsigned long address)
@@ -108,7 +108,7 @@ static inline pte_t *__pte_map(pmd_t *pmd, unsigned long address)
 }
 static inline void pte_unmap(pte_t *pte)
 {
-	/* rcu_read_unlock() to be added later */
+	rcu_read_unlock();
 }
 #endif
 
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 4d454953046f..400e5a045848 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -236,7 +236,7 @@ pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
 {
 	pmd_t pmdval;
 
-	/* rcu_read_lock() to be added later */
+	rcu_read_lock();
 	pmdval = pmdp_get_lockless(pmd);
 	if (pmdvalp)
 		*pmdvalp = pmdval;
@@ -250,7 +250,7 @@ pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
 	}
 	return __pte_map(&pmdval, addr);
 nomap:
-	/* rcu_read_unlock() to be added later */
+	rcu_read_unlock();
 	return NULL;
 }
 
-- 
2.35.3

