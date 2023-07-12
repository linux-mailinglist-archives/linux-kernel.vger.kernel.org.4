Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1EF74FE42
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 06:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjGLEee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 00:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjGLEec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 00:34:32 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810FB136
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 21:34:31 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-57d24970042so11457567b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 21:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689136470; x=1691728470;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7tbEFbFk5pzLjwVra+37SCseEW8dJexk2Np2YDtZH+c=;
        b=wnCVuIXuiaG32yazd1jaE3W5ihs2aq10U+0VnqC0A4M5VW9f75uDvYaKtJTiOmyaue
         Sk3Hz9lSjZsRg5VYNIu7Hn2yE63ieOx4N3x7YzoU3Buew+NClS1OfLuPLWy/xU1Be4F4
         Mj93usiX7kHcOZV19+ldiZyyL/p+CNJFiKm0gEtrogp1KtBAN0j2Dy4CImKpM6En2tcK
         aezkkRAxSKmsFJ7X4v2alSgKHi31+oMGpb01SlGprmt8mWgh7ncZkS4hJxBgagnaXOse
         tz8TLiOWqvvCKNWEav/8zM1LSgHqAZXlnZ87YVamvaqNDIExsUdGGqSiLd9h9BTV1Nu3
         hsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689136470; x=1691728470;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7tbEFbFk5pzLjwVra+37SCseEW8dJexk2Np2YDtZH+c=;
        b=MRWk4BFqaAvxXDW8cxD03kVkxDmiStVwtM7NgqNB6YEY4quHKjYN3dx2y/5QoGPS/4
         fI7udSC+1S+BOUAS8Hyp+dO+KJUZAZTBryG0hr0gKhPn0GcvexwWI0b26hTGccU3BRPR
         t7iVXX0Ogk1gb++9O89lfLONYtt3goKEc7AirClMCXHPyznk1ekMEEnt7yhL47PMZ75+
         xz2I6fVg30nfYdBPd1tKvzpk24sBS2hGsFQ/DUDyLUvbyp9GqvRIcEIMXgpicjKrpPgu
         Sjzd7Iy+IDOcBaoyeG5tymi/n+9ArVZgrG6K+fxo9LokUY1uhhuLfGc4n0c85xM+oZvQ
         ry0Q==
X-Gm-Message-State: ABy/qLbmmrqH4jNZglhMLhQpLBvu4WfVFF5kNjvMQr9LxmItNChak4B6
        I10und7O/5JPQ0CIIv3SttuoiQ==
X-Google-Smtp-Source: APBJJlGbNO1AMOmdt4OPi/Xng0KoIYGmRlccUjicbL3FXzg2JdRnfsqSYXaILeBHKbZKCy/ktJ28ZQ==
X-Received: by 2002:a81:4ecb:0:b0:57d:24e9:e7f3 with SMTP id c194-20020a814ecb000000b0057d24e9e7f3mr2850117ywb.38.1689136470494;
        Tue, 11 Jul 2023 21:34:30 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c124-20020a0dc182000000b0057a05834754sm974979ywd.75.2023.07.11.21.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 21:34:30 -0700 (PDT)
Date:   Tue, 11 Jul 2023 21:34:25 -0700 (PDT)
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
Subject: [PATCH v3 04/13] powerpc: assert_pte_locked() use
 pte_offset_map_nolock()
In-Reply-To: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com>
Message-ID: <e8d56c95-c132-a82e-5f5f-7bb1b738b057@google.com>
References: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of pte_lockptr(), use the recently added pte_offset_map_nolock()
in assert_pte_locked().  BUG if pte_offset_map_nolock() fails: this is
stricter than the previous implementation, which skipped when pmd_none()
(with a comment on khugepaged collapse transitions): but wouldn't we want
to know, if an assert_pte_locked() caller can be racing such transitions?

This mod might cause new crashes: which either expose my ignorance, or
indicate issues to be fixed, or limit the usage of assert_pte_locked().

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/powerpc/mm/pgtable.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index cb2dcdb18f8e..16b061af86d7 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -311,6 +311,8 @@ void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
+	pte_t *pte;
+	spinlock_t *ptl;
 
 	if (mm == &init_mm)
 		return;
@@ -321,16 +323,10 @@ void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 	pud = pud_offset(p4d, addr);
 	BUG_ON(pud_none(*pud));
 	pmd = pmd_offset(pud, addr);
-	/*
-	 * khugepaged to collapse normal pages to hugepage, first set
-	 * pmd to none to force page fault/gup to take mmap_lock. After
-	 * pmd is set to none, we do a pte_clear which does this assertion
-	 * so if we find pmd none, return.
-	 */
-	if (pmd_none(*pmd))
-		return;
-	BUG_ON(!pmd_present(*pmd));
-	assert_spin_locked(pte_lockptr(mm, pmd));
+	pte = pte_offset_map_nolock(mm, pmd, addr, &ptl);
+	BUG_ON(!pte);
+	assert_spin_locked(ptl);
+	pte_unmap(pte);
 }
 #endif /* CONFIG_DEBUG_VM */
 
-- 
2.35.3

