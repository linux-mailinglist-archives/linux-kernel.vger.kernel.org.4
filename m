Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C8B6FD5A4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 06:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbjEJE7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 00:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbjEJE6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 00:58:55 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE5F1FD2
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 21:58:53 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-b9d881ad689so8687594276.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 21:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683694732; x=1686286732;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i7vs80eeAHoowuGiB3IXr1R0pQ52ZVhylKFRPge1iSc=;
        b=P9kK3Ha7kM6a70P/N9uB2lWXrssqQgUHBWNV/ZpJwPmg2mPzx8gUi6+Y5U3HPMDHz9
         0fAlFOi/bTART9baPPENUGYRX+MazYzuiDcAIMOosxi9lXkJsm3mNsaLjOWtnLwgcry5
         sP0r/lFyFBNCqz3voFtKwARlNZyj767HfljqLFdQYp3UaORt42cJzHdk0VN4kJ5NQH/7
         DWlXvI97puE4OaBtmUgMd/qH5Lin+XJ2aRjT13gN8vWtWVfPYNVNo8e918/mLGqALa1y
         O7U3+kDK92dAzqxBb57AmVgMsRrk/0cmMw+aKo8waotZHzpB3mgtMwAgWyIj42FB5uoU
         5erQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683694732; x=1686286732;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i7vs80eeAHoowuGiB3IXr1R0pQ52ZVhylKFRPge1iSc=;
        b=dKagHNSJhP60IthC1u6m9rVMbdJm/H13InEaVSeH87C569jdtlhEmrCMa8Ec7umuhz
         yFvm7AENMNuDWNS/dTcvNc5wfNHgLrKq3EuQ/Ya0Gwk6AE4+zFPxhcHkZ7FtDruWANz/
         s3i8h0OTJydCIAMzEqgv/B4jTzzHH229xrFblAcv0wISx/VcAXRcNKjxTF+KAJ5c0rMB
         h4E7VuSbvCgRVi2LowePPnK6OdKuKrpTVg2NpdUVZ+Evf89iGy4Nedc9DkuaufZvCwEC
         fg57+iDSpU9vQnP77Ajvn6RQHQrx7JfR3OT2WiZBstD4mFR3mhFDiRfEbtZSy1GITcFP
         78Fg==
X-Gm-Message-State: AC+VfDwX4ujmPfvFtVmKxj7Tjt7LX47UrHvRnDAbd7JyKB2Ko59R9TRm
        0UNnfZILemAQ/5DD85RcIlO6lQ==
X-Google-Smtp-Source: ACHHUZ6HrZAnm+aaG2sOhULY3F7mb+ht2GRzSsBKsJ/KT5tYwkiRpQQy7lJKEHctJdijcfVx9gaq3w==
X-Received: by 2002:a25:d352:0:b0:ba2:16b6:b11e with SMTP id e79-20020a25d352000000b00ba216b6b11emr16144172ybf.0.1683694732647;
        Tue, 09 May 2023 21:58:52 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h66-20020a252145000000b00b9550fcb12fsm3461906ybh.64.2023.05.09.21.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 21:58:52 -0700 (PDT)
Date:   Tue, 9 May 2023 21:58:48 -0700 (PDT)
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
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 13/23] powerpc/hugetlb: pte_alloc_huge()
In-Reply-To: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
Message-ID: <1a3ee4d4-a829-35d4-d94e-885d5d4d6a8a@google.com>
References: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
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

pte_alloc_map() expects to be followed by pte_unmap(), but hugetlb omits
that: to keep balance in future, use the recently added pte_alloc_huge()
instead.  huge_pte_offset() is using __find_linux_pte(), which is using
pte_offset_kernel() - don't rename that to _huge, it's more complicated.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/powerpc/mm/hugetlbpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index b900933507da..f7c683b672c1 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -183,7 +183,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 		return NULL;
 
 	if (IS_ENABLED(CONFIG_PPC_8xx) && pshift < PMD_SHIFT)
-		return pte_alloc_map(mm, (pmd_t *)hpdp, addr);
+		return pte_alloc_huge(mm, (pmd_t *)hpdp, addr);
 
 	BUG_ON(!hugepd_none(*hpdp) && !hugepd_ok(*hpdp));
 
-- 
2.35.3

