Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE57728837
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbjFHTV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbjFHTVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:21:52 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604D930C4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 12:21:18 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-565cd2fc9acso9199057b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 12:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686252072; x=1688844072;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=alKFmwAdxdkIViw1WjkjX/OCKeQtR2IpGs2zcY6rd0M=;
        b=HKd31LqvAwT3pdB9H8RTJjakAJAT9HvglTvKC+OkvKmv5VhsoaZHAtLpo2tFkCpDhK
         eaJn1uAawotb3pLd5xLGg7DzD6kDQrKAHxas7kU/r2KN0gO+8LwEgaLotjlfcSI+ExXP
         OsTJ1O2tfGB1hyPd2BGfO1Hv0XjmUpnPR5LgmonoIasqGq2fAG/aN3V/iTrXbCwGdrUM
         I50yE5ZJKvbdrlam2CeJEmfXKvbJkG9Wl49W11ZHf6B9xR5DJRVBfUy3eWMAtZhLeFU3
         MFev89ALFBnRCYsOlrl0s+V0pK/HvUPQhOTjtpCkmArqzAHuVaF4G3AF2HiTPrlcql5n
         hmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686252072; x=1688844072;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=alKFmwAdxdkIViw1WjkjX/OCKeQtR2IpGs2zcY6rd0M=;
        b=mBi/91iAv6hG8C1SnzgCzqkgUHCIw53Usi8wBiAygpVzV0IQys+3YrzBDtrP8iOB0k
         eiTWtJqPYgAJrY7KN8jmp6gk4ir4wMIT02rDyjjHFd8w8zHPxuRFHOmBI1youSotgm04
         /9SbfqPirPQI0xbJ52RVxu+YQ2eQwClatv1rxp9ifXz9zDfPObVxfdkNdCJBB7c2ykjc
         6bhXqnYgFTCN35moj4AbjkBOF1+NjADk+VPoe3RHEOvzi83ptpS60/a1+BoiXXBG4TgR
         r0ySbsJ2HTweNDBV1LgnHCfyjQYFOB4gEaw5lglWDp2f4Z83RVdQfkgsn4mCHjN82KC3
         kSsA==
X-Gm-Message-State: AC+VfDzwnNay7q6syx+NO1VRrrp/TqFgfwMvAun2oMTjN2q0JIMe5X90
        HB/dLwV0pAmlW9veUDgNLA7wAw==
X-Google-Smtp-Source: ACHHUZ6osQDL46P3M+nFsTgwfoyN2ZCBLpMaIBhxVjRNKZnry7+6/FcNKdRpu6hPkSNVLheeDpiVWQ==
X-Received: by 2002:a0d:d98f:0:b0:565:ba4b:aa81 with SMTP id b137-20020a0dd98f000000b00565ba4baa81mr612161ywe.45.1686252072277;
        Thu, 08 Jun 2023 12:21:12 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f184-20020a0ddcc1000000b00552ccda9bb3sm108635ywe.92.2023.06.08.12.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 12:21:11 -0700 (PDT)
Date:   Thu, 8 Jun 2023 12:21:07 -0700 (PDT)
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
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 10/23] parisc/hugetlb: pte_alloc_huge()
 pte_offset_huge()
In-Reply-To: <a4963be9-7aa6-350-66d0-2ba843e1af44@google.com>
Message-ID: <7963aeed-f7d2-e0-f3c6-3680c5572444@google.com>
References: <a4963be9-7aa6-350-66d0-2ba843e1af44@google.com>
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
instead; with pte_offset_huge() a better name for pte_offset_kernel().

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/parisc/mm/hugetlbpage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/mm/hugetlbpage.c b/arch/parisc/mm/hugetlbpage.c
index d1d3990b83f6..a8a1a7c1e16e 100644
--- a/arch/parisc/mm/hugetlbpage.c
+++ b/arch/parisc/mm/hugetlbpage.c
@@ -66,7 +66,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (pud) {
 		pmd = pmd_alloc(mm, pud, addr);
 		if (pmd)
-			pte = pte_alloc_map(mm, pmd, addr);
+			pte = pte_alloc_huge(mm, pmd, addr);
 	}
 	return pte;
 }
@@ -90,7 +90,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 			if (!pud_none(*pud)) {
 				pmd = pmd_offset(pud, addr);
 				if (!pmd_none(*pmd))
-					pte = pte_offset_map(pmd, addr);
+					pte = pte_offset_huge(pmd, addr);
 			}
 		}
 	}
-- 
2.35.3

