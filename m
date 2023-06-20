Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1B1736519
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjFTHqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjFTHpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:45:41 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9151110E2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:45:32 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5703cb4bcb4so39361647b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687247132; x=1689839132;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7tbEFbFk5pzLjwVra+37SCseEW8dJexk2Np2YDtZH+c=;
        b=jZI7lGkGOA9VplRFSG9/39QEHLqEHFn81AVfRltHoq/8iNx7aAWlNrNyFe+XyF0lml
         Bnzro2qd7JBTjoGR7k3DplV7l1biYn3/LoxKNyegFiBFIRoYqaL2y+rd8Ux0pQmhTgvs
         IUPCYgX4z0WdKLSspIafzLUn3c05nMTizwc56jirtYHMfRSc/oqFfK7oTa/fwkNDoThq
         2HdR/Am0ViDDg3zBY7MZWP/MVjmD1Yx9xMfwqoDnIfAkP9LmxM3rFBDQvW9AFIfnglmj
         paE2iSuMCCu/tpYLxht5C/v0kudDdPO6A0RSV0ftjBtK/MFrCHoTJHxirOjy2uYrAODS
         XFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687247132; x=1689839132;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7tbEFbFk5pzLjwVra+37SCseEW8dJexk2Np2YDtZH+c=;
        b=BJIW9+SlLrJ+bBrEqXhzca6+Om2c2pcpsvpMWRtSruZdo1EgVEP6LXDBsYUOF/V8fr
         KTz0RU7Llmtasy7LZ7UIi2Y95g+IvXEgAuFsEXnRdouq+X40tkVtvWfSpcoSrmbgPRyW
         0JvuIaSqiDaU9lgXevwS++m6HYXxY1e8fW/AcVtDB1JErIOcA8STOmS+WgSheidz12Z0
         GslEcNm4zwETb4YNK85CS7Re6SW2Sn3ob8A8u/LhzEEcU8hNUBN/e67SR2wtTgRftERU
         3YK27pXuGjeE53ejM9vAKeCKjY7ubVgamLSZTcBA7cYMMnmBLAUf7yDS8NE5z3e0LpnT
         YQ+Q==
X-Gm-Message-State: AC+VfDy8A09wHqjW/yLWaWdP0skqDmNy0hgKC2DZ0r6Sen1FXii5V741
        zZhmwRaxaCVOJumC1FhpyTaOeQ==
X-Google-Smtp-Source: ACHHUZ6lVvN31sBriyHtQUo4iIlWjUc8vgsx+qnIrz5Kb8Jhe8UJO9QGV+cM44ErYZUti1LdEdlZpw==
X-Received: by 2002:a81:7189:0:b0:54f:9cd0:990 with SMTP id m131-20020a817189000000b0054f9cd00990mr2846044ywc.18.1687247131680;
        Tue, 20 Jun 2023 00:45:31 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o9-20020a0dcc09000000b0056d2fce4e09sm379759ywd.42.2023.06.20.00.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 00:45:31 -0700 (PDT)
Date:   Tue, 20 Jun 2023 00:45:26 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
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
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 04/12] powerpc: assert_pte_locked() use
 pte_offset_map_nolock()
In-Reply-To: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com>
Message-ID: <7ae6836b-b612-23f1-63e0-babda6e96e2c@google.com>
References: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com>
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

