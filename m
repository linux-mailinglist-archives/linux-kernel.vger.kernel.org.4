Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EAA728892
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjFHTbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbjFHTbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:31:42 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDC52D72
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 12:31:16 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5664b14966bso8804877b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 12:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686252675; x=1688844675;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LRrENG7fj4nSEA3qiqmp7KZ6RwcG7U0j5SldGyBNlNI=;
        b=xraoP+ub8QawPiBDd1NtmoCJ7Yde5e/+U+FNO1p7rYE1UZXZOAo1PDwcjZq5EwJthR
         dV+vHCNMFKAoTdxBpkTX1DtrPJTkyYQzzcTJ6+Hvz6BbVAyle5wD2VnxGl+fo8KRjuW1
         6lph5KG8FATG8Els+mnLkzVfzKtCZbvKkrDIrFy8tA1swRHwRpg7mlfmIfHBFYp2tEz0
         /MtFJlEM4CazKliayJD7LKXK8RlITlLW8oxbTF1Qs6fFP4vrk+enY/g6/q9Fbkg7+DmC
         flfsqeHeLuLJ1bEDqfGSKk77gUrt/I37di/bcF7XR9pfVd+mrCw58/52flYr3BiOm9us
         kFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686252675; x=1688844675;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LRrENG7fj4nSEA3qiqmp7KZ6RwcG7U0j5SldGyBNlNI=;
        b=P3E3Gh2GxTFGjSIgw4VyeqGMmBundosxNwyieNExClAI5KIgocVOxreoMXLIZ9mARB
         ss9jpbXDQXUCppjj3rbrRvVUCFZxzlfj10sZtVQs9PcgdNFnnEd2+MNILoq868xDskIg
         ffwxTthWRA+B5/8bJAkGFt8L3Y4/GX1UEGvmsqVuJfgABQ9f2cIe3NHLbvFjdeM5jbh7
         dg4ZMpYICKuF/fkTY3p+dEp2/oamj9zJqt4gEC1DwRc39mkQKuNmXl/8JPGMWUq77VKE
         GOiGxPIjoixvjKitgbS0gkTozQ4NMwLWMabmW4o1YaEj9jLaXL96acT3M3iIDKEPxsXx
         81fw==
X-Gm-Message-State: AC+VfDzIlV1TZaW9SE7KWj2CNlQx8FUjLlVUTJPym3x/xBj1e4zGb8qI
        PG2iSMJOlioPYC5kWE+VIiq0YA==
X-Google-Smtp-Source: ACHHUZ7QSwZkgLD2hJa5LAg1G48lqiWohJ5hVZ29HKnSz0REpapDpLCYy6czmfzJtz/zE4Z2iELuXA==
X-Received: by 2002:a81:8986:0:b0:561:d1ef:3723 with SMTP id z128-20020a818986000000b00561d1ef3723mr688963ywf.38.1686252675399;
        Thu, 08 Jun 2023 12:31:15 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a6-20020a816606000000b0055aaccfa2c7sm114090ywc.91.2023.06.08.12.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 12:31:14 -0700 (PDT)
Date:   Thu, 8 Jun 2023 12:31:10 -0700 (PDT)
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
Subject: [PATCH v2 18/23] sparc/hugetlb: pte_alloc_huge() pte_offset_huge()
In-Reply-To: <a4963be9-7aa6-350-66d0-2ba843e1af44@google.com>
Message-ID: <c2aeb62f-58f9-d014-ddcd-266267bd97b@google.com>
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
 arch/sparc/mm/hugetlbpage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index d8e0e3c7038d..d7018823206c 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -298,7 +298,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 		return NULL;
 	if (sz >= PMD_SIZE)
 		return (pte_t *)pmd;
-	return pte_alloc_map(mm, pmd, addr);
+	return pte_alloc_huge(mm, pmd, addr);
 }
 
 pte_t *huge_pte_offset(struct mm_struct *mm,
@@ -325,7 +325,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 		return NULL;
 	if (is_hugetlb_pmd(*pmd))
 		return (pte_t *)pmd;
-	return pte_offset_map(pmd, addr);
+	return pte_offset_huge(pmd, addr);
 }
 
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
-- 
2.35.3

