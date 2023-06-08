Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D8B72885C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbjFHT0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbjFHT0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:26:14 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE9B30FB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 12:25:48 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-bb3a77abd7bso1056884276.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 12:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686252347; x=1688844347;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OY1uPF9EWokdB4SqfwvScqZ05vH5KIzX3bnt2mFlrzM=;
        b=WSe0O+xWHB2ydCbpeLzjHJf6lubD6yWbrbalQ09CW2PLGKbnuv/YCHcTjEklbftlDZ
         Bn+TBag489vYl0Kx/QEnd/hNvW0BHOeSak/CZxA051qj0HRROKgCePvrRb9MuwQ21RPo
         UFNVPP0fFgD2zP3vXEkAAHs7IbIEd7kCFa41GIq/o5fS7gcYFt1t9fsorCogUddAyQAa
         gvgPXc4Mu6L9KlRIpGfWDTGDmUnx/ZwV5Hsai5H4jlYjdflYF6WjfS5QYRdpLJc33lMM
         tuIWNkxAGrXRoIS+Re+Ik8k2cuYZR70rphrz9RjLzYXiNApKIhKEFjqSjiunuGbiEcPL
         13ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686252347; x=1688844347;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OY1uPF9EWokdB4SqfwvScqZ05vH5KIzX3bnt2mFlrzM=;
        b=hsZrFC9EwTBxZHYAH2m4E3Szt31NeWJ2EwwqnVqXV62lbi8tSccLoGHmkfZXFrZ6lt
         Z/ER53ai79EIZO+rXEhLxHK0fBpZH9twIyj+t5KW9fxpDCyx4Yn2lmhpsnlUqtzcMYAi
         yOT0jb4saMJV0HRKUIAlouiMOGzDumx2tjMReOF/NRN4AhPXbzOtPhP0NVfJOFexuZao
         z6mFn3abf0it/FVK870AvTJxhwlkagJ9IizhCD7VzQK93nY8nqbTmkxQdAOQjVfLEPD3
         Wlw1XGwRNLu37aFIU4hJhxOLqYPHXKP+Q8hbjyY2dqoJNhHDjTCgt/AllwkTo5euUS/s
         xW/w==
X-Gm-Message-State: AC+VfDwA+ZcyLzubd25raO2TucrkoKvKFcJhNdSGCk8wxMTrD0Olbz3c
        hp+WneAcmjWBgVmuqGdo+J5WwQ==
X-Google-Smtp-Source: ACHHUZ7VI0tdmqfD7RJHlpvasneu0EKZSOUA0Xhotxo3WPVI6HmobTXuS5JzWFFLHVldGCNyYtlCDw==
X-Received: by 2002:a81:9144:0:b0:561:da0d:6488 with SMTP id i65-20020a819144000000b00561da0d6488mr460871ywg.50.1686252347196;
        Thu, 08 Jun 2023 12:25:47 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y62-20020a0dd641000000b00568938ca41bsm117859ywd.53.2023.06.08.12.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 12:25:46 -0700 (PDT)
Date:   Thu, 8 Jun 2023 12:25:42 -0700 (PDT)
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
Subject: [PATCH v2 14/23] riscv/hugetlb: pte_alloc_huge() pte_offset_huge()
In-Reply-To: <a4963be9-7aa6-350-66d0-2ba843e1af44@google.com>
Message-ID: <291f20-5947-9f5f-ec7f-96a18df336d9@google.com>
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
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosync.com>
---
 arch/riscv/mm/hugetlbpage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index e0ef56dc57b9..542883b3b49b 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -67,7 +67,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
 
 	for_each_napot_order(order) {
 		if (napot_cont_size(order) == sz) {
-			pte = pte_alloc_map(mm, pmd, addr & napot_cont_mask(order));
+			pte = pte_alloc_huge(mm, pmd, addr & napot_cont_mask(order));
 			break;
 		}
 	}
@@ -114,7 +114,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 
 	for_each_napot_order(order) {
 		if (napot_cont_size(order) == sz) {
-			pte = pte_offset_kernel(pmd, addr & napot_cont_mask(order));
+			pte = pte_offset_huge(pmd, addr & napot_cont_mask(order));
 			break;
 		}
 	}
-- 
2.35.3

