Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E697322F3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjFOXDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjFOXC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:02:58 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7947C294D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:02:55 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-bd20beffda6so36232276.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686870174; x=1689462174;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rocsqxxn2Z+cT1JHYvXfzCdKlHTpr3EP6mTFGVcBZg0=;
        b=MJTZvP19w7L3mwEdMeExhSCW1AUDkDcDZIGA09b4Lsgr6AlQ/Jre5s3pQVCVJJ7rQb
         5+EQMNtJaTaY+aRJKrCSqlImib7KZddKIew66TbvLd683FL9AyfE66fgz1T7BtZHDMm8
         2jNBCticE3VbvZxgnHDLhllKeMXxMDja6NYMekmWJVMnL0qXYLEhZcbBya6ztZKzets8
         eOxxHJ/YfIwfRnvaqFcbsGZUKRVZaOyJdqvanJIQ7D74NV/Gvoq+dfmVK1oXzh1JvH5P
         0RtdON+E/jvZHQ2QI/6IDa9W4KDnatFP6KwfH05hk8Ymf0ujYFguYsacUpxAce6WF76M
         r8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686870174; x=1689462174;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rocsqxxn2Z+cT1JHYvXfzCdKlHTpr3EP6mTFGVcBZg0=;
        b=OopcDHP9kbSMEe+zEtNgkJgJAlo0NZzCqAk0LxvYX01e7Bptk/zr2EoR6zZcOKqxM7
         D8Pi64KvYlRKKnnfHvUYTkLY8x2GK1ZbPj35Hz7IRdBo68iT1YuDfokRFbpSDEBtf10D
         utSbzKq1W3ok9fIB77mKAYxaSD6iMTPn2WBMYFbj5arZ9WkTtcfjom7Q7Kloh3IWa1iK
         KvFc2dY3ZzOVqyOeh3++yNztH3Fu3APsHqH/yXEmAAspHh/WJkqo6tCtuPtu6PlyzKdj
         sMdeHVj3+BFMCNOcdFG7SVEjbMqOE1hpIr77Y45JQ2ZZci4kclgONg90/v71UBEgesvb
         Se/A==
X-Gm-Message-State: AC+VfDxcfmW+sRqlY1cR5Pcd2j9V3CufWJHDEgAFDvENtvaDVlqhcI1+
        GZ2YTDXe2ePorRQFLHyVRwR81g==
X-Google-Smtp-Source: ACHHUZ4yNZeWVfFpqfOHWwVeKQ0LO1X5XLl6oMWM14BiamATBX7pt4vwNxCwa9vlqY3LDt6NBppgPg==
X-Received: by 2002:a81:7bd5:0:b0:56d:2dd6:c5b3 with SMTP id w204-20020a817bd5000000b0056d2dd6c5b3mr138534ywc.31.1686870174477;
        Thu, 15 Jun 2023 16:02:54 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w6-20020a0ded06000000b0056d2a19ad91sm2857020ywe.103.2023.06.15.16.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 16:02:54 -0700 (PDT)
Date:   Thu, 15 Jun 2023 16:02:43 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Nathan Chancellor <nathan@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Yu Zhao <yuzhao@google.com>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 07/23 replacement] mips: add pte_unmap() to balance
 pte_offset_map()
In-Reply-To: <76b41825-30fa-b9e8-d043-2affcba24317@google.com>
Message-ID: <addfcb3-b5f4-976e-e050-a2508e589cfe@google.com>
References: <a4963be9-7aa6-350-66d0-2ba843e1af44@google.com> <178970b0-1539-8aac-76fd-972c6c46ec17@google.com> <20230614231758.GA1503611@dev-arch.thelio-3990X> <f5526f17-9d78-f7ea-427a-7e76bfeb6b8@google.com> <344a4da-3890-45fd-607e-b5f85ca6ad48@google.com>
 <20230615155059.GB3665766@dev-arch.thelio-3990X> <76b41825-30fa-b9e8-d043-2affcba24317@google.com>
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

To keep balance in future, __update_tlb() remember to pte_unmap() after
pte_offset_map().  This is an odd case, since the caller has already done
pte_offset_map_lock(), then mips forgets the address and recalculates it;
but my two naive attempts to clean that up did more harm than good.

Tested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Hugh Dickins <hughd@google.com>
---
Andrew, please replace my mips patch, and its build warning fix patch,
in mm-unstable by this less ambitious but working replacement - thanks.

 arch/mips/mm/tlb-r4k.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 1b939abbe4ca..93c2d695588a 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -297,7 +297,7 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 	p4d_t *p4dp;
 	pud_t *pudp;
 	pmd_t *pmdp;
-	pte_t *ptep;
+	pte_t *ptep, *ptemap = NULL;
 	int idx, pid;
 
 	/*
@@ -344,7 +344,12 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 	} else
 #endif
 	{
-		ptep = pte_offset_map(pmdp, address);
+		ptemap = ptep = pte_offset_map(pmdp, address);
+		/*
+		 * update_mmu_cache() is called between pte_offset_map_lock()
+		 * and pte_unmap_unlock(), so we can assume that ptep is not
+		 * NULL here: and what should be done below if it were NULL?
+		 */
 
 #if defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
 #ifdef CONFIG_XPA
@@ -373,6 +378,9 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 	tlbw_use_hazard();
 	htw_start();
 	flush_micro_tlb_vm(vma);
+
+	if (ptemap)
+		pte_unmap(ptemap);
 	local_irq_restore(flags);
 }
 
-- 
2.35.3

