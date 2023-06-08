Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB6372884B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbjFHTYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236509AbjFHTYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:24:19 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966563592
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 12:23:40 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-565a63087e9so9111197b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 12:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686252220; x=1688844220;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qDN5tZO3L77JzaZm0GUojeVr1G6nDfqvfBbmKnfTG1k=;
        b=bsqS2HsoK/j3AkqW2YwOMMKXyawvBNLxJHVA5gOfV85QJu1lSu6OT/EudsU4V/Y2rp
         SVDrhg0mebSfRzfMSx1MBgwwDrAuWoy9LCmuC/2umX7ttwWByA3dcTWU9wXJ/cBuk8p1
         IBLsaSZQWTiGTy2fVfGTVTLpxXSu83YUCgCeShfLhLQEtHAObGCmd/2pMwHoVzhnbL+s
         R/RqL9aWefb7+V22j+wCoHy3L9k9iU7LsdUzazOEG+iBjRzVfoBnNonp+eUMgHPu99EP
         wikBPo2R7DnOhGnbBte9FiJ408IVODR7hjXz04IiqDN6B3KGc/TbdicQd+c7pqZBIdYk
         E3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686252220; x=1688844220;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qDN5tZO3L77JzaZm0GUojeVr1G6nDfqvfBbmKnfTG1k=;
        b=LWFUc3e0vZYz5uio+Z+uIZmej9etMpVL2zcQ6i1N9rmJwHnX3+9/cHUpA0ko93cGvH
         4s1CFAPa5RVH+AwQ0OkdkRtAfzBqEW/NNK2TJlpv3ImFOMV9Yo0FD4SE9X+4USFqEbge
         FMMR/TQLYAhJCiKleSwC0U5gva/PVPyuFsiCUOOcI2+t6MoeOoaOWCxcXP1/j6+3spmo
         wsAVXSyeWySABcd5GAPRAa6DZZLwsDtvKLt8sHuNp2ehYkL94q7yUGQWlB1JGq2SY0xl
         g/flzRpxi8Tv/8qGQObYbgCTiNIPPjhkMnBMpsU8fGRdHAAQbhF1WCszn2rRT10kHdHm
         qlkw==
X-Gm-Message-State: AC+VfDy+734q0Os2xil3f8lcWtjV9dsIKj5fSYht9Yio6+kcpniDwRx8
        +srQN/CVJeHlctkYHqdjmRcGTg==
X-Google-Smtp-Source: ACHHUZ5B2AQmlb0Co/ti6j7UtSZsz6kvSjI4SOSm5MiJUvPHp7lW170oPhZmXl+FiXgmdx/jiLqYOA==
X-Received: by 2002:a0d:d843:0:b0:565:8c16:a0e1 with SMTP id a64-20020a0dd843000000b005658c16a0e1mr683325ywe.13.1686252219629;
        Thu, 08 Jun 2023 12:23:39 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j65-20020a0df944000000b00545a08184e0sm102947ywf.112.2023.06.08.12.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 12:23:39 -0700 (PDT)
Date:   Thu, 8 Jun 2023 12:23:35 -0700 (PDT)
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
Subject: [PATCH v2 12/23] powerpc: allow pte_offset_map[_lock]() to fail
In-Reply-To: <a4963be9-7aa6-350-66d0-2ba843e1af44@google.com>
Message-ID: <54c8b578-ca9-a0f-bfd2-d72976f8d73a@google.com>
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

In rare transient cases, not yet made possible, pte_offset_map() and
pte_offset_map_lock() may not find a page table: handle appropriately.
Balance successful pte_offset_map() with pte_unmap() where omitted.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/powerpc/mm/book3s64/hash_tlb.c     | 4 ++++
 arch/powerpc/mm/book3s64/subpage_prot.c | 2 ++
 arch/powerpc/xmon/xmon.c                | 5 ++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s64/hash_tlb.c b/arch/powerpc/mm/book3s64/hash_tlb.c
index a64ea0a7ef96..21fcad97ae80 100644
--- a/arch/powerpc/mm/book3s64/hash_tlb.c
+++ b/arch/powerpc/mm/book3s64/hash_tlb.c
@@ -239,12 +239,16 @@ void flush_hash_table_pmd_range(struct mm_struct *mm, pmd_t *pmd, unsigned long
 	local_irq_save(flags);
 	arch_enter_lazy_mmu_mode();
 	start_pte = pte_offset_map(pmd, addr);
+	if (!start_pte)
+		goto out;
 	for (pte = start_pte; pte < start_pte + PTRS_PER_PTE; pte++) {
 		unsigned long pteval = pte_val(*pte);
 		if (pteval & H_PAGE_HASHPTE)
 			hpte_need_flush(mm, addr, pte, pteval, 0);
 		addr += PAGE_SIZE;
 	}
+	pte_unmap(start_pte);
+out:
 	arch_leave_lazy_mmu_mode();
 	local_irq_restore(flags);
 }
diff --git a/arch/powerpc/mm/book3s64/subpage_prot.c b/arch/powerpc/mm/book3s64/subpage_prot.c
index b75a9fb99599..0dc85556dec5 100644
--- a/arch/powerpc/mm/book3s64/subpage_prot.c
+++ b/arch/powerpc/mm/book3s64/subpage_prot.c
@@ -71,6 +71,8 @@ static void hpte_flush_range(struct mm_struct *mm, unsigned long addr,
 	if (pmd_none(*pmd))
 		return;
 	pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+	if (!pte)
+		return;
 	arch_enter_lazy_mmu_mode();
 	for (; npages > 0; --npages) {
 		pte_update(mm, addr, pte, 0, 0, 0);
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 70c4c59a1a8f..fae747cc57d2 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3376,12 +3376,15 @@ static void show_pte(unsigned long addr)
 	printf("pmdp @ 0x%px = 0x%016lx\n", pmdp, pmd_val(*pmdp));
 
 	ptep = pte_offset_map(pmdp, addr);
-	if (pte_none(*ptep)) {
+	if (!ptep || pte_none(*ptep)) {
+		if (ptep)
+			pte_unmap(ptep);
 		printf("no valid PTE\n");
 		return;
 	}
 
 	format_pte(ptep, pte_val(*ptep));
+	pte_unmap(ptep);
 
 	sync();
 	__delay(200);
-- 
2.35.3

