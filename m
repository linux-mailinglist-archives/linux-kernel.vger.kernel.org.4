Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214D57288A6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbjFHTdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbjFHTds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:33:48 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A142129
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 12:33:46 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-bad1ae90c2eso1048596276.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 12:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686252825; x=1688844825;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tza8VZpBdDATlz3Dj70XvbHnC1ZhEpBq1MlG3gUrqGw=;
        b=1MipXBHlCgYLfuzhfDW5ZwUI8FUsKSE60AsqsEXw+S0tSnJg5UOmjRzYFHDLdCAJt8
         yMkipeQIgxyZw78rcQRYlMT5UpzdJcWoIksfCpz/ydUZz6ZkI9xKVrX6kds0LvhIjEzt
         HS+XptOf+RYBmq4zm9J7IFzhbS7dVhum1cFHfBZOiQ+s0XEOXeKn/G9+gcrTCmXECFnx
         8UoS3IHRM3ERDzeB2SU7OV6jhVelmg9iMKHzFrc8fJmEIq5uTYUBI9N7JZJvtQPChnnD
         4+2NEzxtpjJGm4NjJthMMPpAkAfI8kDJwzbA28gjtv0iKudNeA4e3nFqgNhPbC/JEIjR
         C7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686252825; x=1688844825;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tza8VZpBdDATlz3Dj70XvbHnC1ZhEpBq1MlG3gUrqGw=;
        b=Twer0s44dElTE3uNPUEoqE5JQ1P7NO04rkW6LjQTMWbYcqV1HtZU/OXQLueyoVd8YR
         UBThm0Kt2+MseRv09KO0T/wTC7uDQevW9oSol5QsqVFg3EPem1w5ez2OmIOpGa5xSm7X
         7R2h4SxhF5hGQcSFgMR46r6EIqtTJG3ATnK6MEJfu4wibUAMNSWI3S3JOV6jLZ6aVt87
         +4U9VzT9+c3LPrAZQlUeVA0R1tM5kgQkBFEzTEb9R6LXzFatZmGHcRlDo23vfz8VGCZ1
         Mh75niEOB90NkOEwDzrBkslVF8mBZm/nXusIyjttS9efDDhAht/2eqf/e6FV8fVt8XN9
         1gdw==
X-Gm-Message-State: AC+VfDxMNCOQRDDBil23XPwoUJhL8yuSTmSpIqmDTB9VwfS1R1gTybXX
        APD7EnH6X2ymKUAb84qw08NUmg==
X-Google-Smtp-Source: ACHHUZ5fRes1KtQJuT48o2Wy/FuADD12yA75OXTij0wfUrs7MG5//8NY8cIlqChq28IRelwNgydDPg==
X-Received: by 2002:a25:868e:0:b0:bad:1055:c9fd with SMTP id z14-20020a25868e000000b00bad1055c9fdmr569763ybk.49.1686252825296;
        Thu, 08 Jun 2023 12:33:45 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e188-20020a251ec5000000b00baca49c80dcsm448503ybe.28.2023.06.08.12.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 12:33:44 -0700 (PDT)
Date:   Thu, 8 Jun 2023 12:33:40 -0700 (PDT)
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
Subject: [PATCH v2 20/23] sparc: iounit and iommu use pte_offset_kernel()
In-Reply-To: <a4963be9-7aa6-350-66d0-2ba843e1af44@google.com>
Message-ID: <99962272-12ff-975d-bf7f-7fd5d95a2df5@google.com>
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

iounit_alloc() and sbus_iommu_alloc() are working from pmd_off_k(),
so should use pte_offset_kernel() instead of pte_offset_map(), to avoid
the question of whether a pte_unmap() will be needed to balance.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/sparc/mm/io-unit.c | 2 +-
 arch/sparc/mm/iommu.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/mm/io-unit.c b/arch/sparc/mm/io-unit.c
index bf3e6d2fe5d9..133dd42570d6 100644
--- a/arch/sparc/mm/io-unit.c
+++ b/arch/sparc/mm/io-unit.c
@@ -244,7 +244,7 @@ static void *iounit_alloc(struct device *dev, size_t len,
 			long i;
 
 			pmdp = pmd_off_k(addr);
-			ptep = pte_offset_map(pmdp, addr);
+			ptep = pte_offset_kernel(pmdp, addr);
 
 			set_pte(ptep, mk_pte(virt_to_page(page), dvma_prot));
 
diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 9e3f6933ca13..3a6caef68348 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -358,7 +358,7 @@ static void *sbus_iommu_alloc(struct device *dev, size_t len,
 				__flush_page_to_ram(page);
 
 			pmdp = pmd_off_k(addr);
-			ptep = pte_offset_map(pmdp, addr);
+			ptep = pte_offset_kernel(pmdp, addr);
 
 			set_pte(ptep, mk_pte(virt_to_page(page), dvma_prot));
 		}
-- 
2.35.3

