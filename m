Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABC46FD54E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 06:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbjEJEs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 00:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjEJEsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 00:48:23 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1591BD1
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 21:48:20 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-55a83e80262so100414817b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 21:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683694100; x=1686286100;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WK0F+BrKreVsJ5WKZMSSwYtM+YC+fc99jiRjqR8qAzI=;
        b=x1Kja1XThhFtvtapStbHVJ6cIUWnFQTRjS3yIZzqOBvbeW6lJ6r2OcIKehyGaLcOR9
         EO0E+0lmjwsTzqZxX1CuaA3LV6vt/w6iCNhoZh4KzBI6fttCsMHb9y2nN6JpG9VX1Pvu
         8ApPtVrHr2EJz5uY9tEAZbLvczJvLYwI/1UR0oNRlUsYV0jCTgbzXwAHPMVjgrMird8t
         M8XDWCM/7D47BFX5TCmJBag01ePrcoMjLvbNAO+qlqmYphOA1hsCm6/eE7yT79eAzjKv
         cgR618qRb92LOun4z6/AVV6yQ+EpsB9LlzYitvITxDtPFVAQvvWGldL+/y5mKG2o+OCf
         +34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683694100; x=1686286100;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WK0F+BrKreVsJ5WKZMSSwYtM+YC+fc99jiRjqR8qAzI=;
        b=dZ3YjB4Y7ora60m5RjmSR3OG2KNKHr80pmiP7x3qEMQlLnuboscKRM4xhIYrZ6LZky
         sDeBGjeSMl+wK3SsIbNLSfeDyO7dQysVOgx3LG0DE3Mvh9616Nmme9z+E9KgPkd/48ba
         Msy/2POVNzty4Z24bnlZhKvuRHXdw/Mc/apnw2xx74NyqfM8mLC+RXoKT2XSRrYo/ExH
         oRKDXrCtUEZPwTNqKs6Ebu30w5o2eJ+gw+SUoRVxYTGiMMGoX3k6fV9+3dItOO6YE5ha
         54dB4+chFsaT8WTAKxAFYPCGettoBUsH6d/8V5QA/Dea/Z65+9UFIisHW7hy6CHhdzMS
         SkTg==
X-Gm-Message-State: AC+VfDxYwsg8JgoL+wLXROluPvfuhFNgeCP438MZw7F47PWQzluUD93L
        CKk3Dvt8lHfaje5/LM4Juso/XQ==
X-Google-Smtp-Source: ACHHUZ48eni6W+ZapWVvICeeqiNsZB+sf9Vl0Czmi3DPbU/8P8IxchHCcuzQFPjInzrwD5bjAbGJ8g==
X-Received: by 2002:a0d:c741:0:b0:559:d3a0:4270 with SMTP id j62-20020a0dc741000000b00559d3a04270mr16231065ywd.34.1683694099774;
        Tue, 09 May 2023 21:48:19 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c68-20020a0df347000000b0054f83731ad2sm3844954ywf.0.2023.05.09.21.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 21:48:19 -0700 (PDT)
Date:   Tue, 9 May 2023 21:48:15 -0700 (PDT)
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
Subject: [PATCH 05/23] m68k: allow pte_offset_map[_lock]() to fail
In-Reply-To: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
Message-ID: <237c8410-ce61-94c-4260-7318ad6a4f3@google.com>
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

In rare transient cases, not yet made possible, pte_offset_map() and
pte_offset_map_lock() may not find a page table: handle appropriately.

Restructure cf_tlb_miss() with a pte_unmap() (previously omitted)
at label out, followed by one local_irq_restore() for all.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/m68k/include/asm/mmu_context.h |  6 ++--
 arch/m68k/kernel/sys_m68k.c         |  2 ++
 arch/m68k/mm/mcfmmu.c               | 52 ++++++++++++-----------------
 3 files changed, 27 insertions(+), 33 deletions(-)

diff --git a/arch/m68k/include/asm/mmu_context.h b/arch/m68k/include/asm/mmu_context.h
index 8ed6ac14d99f..141bbdfad960 100644
--- a/arch/m68k/include/asm/mmu_context.h
+++ b/arch/m68k/include/asm/mmu_context.h
@@ -99,7 +99,7 @@ static inline void load_ksp_mmu(struct task_struct *task)
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
-	pte_t *pte;
+	pte_t *pte = NULL;
 	unsigned long mmuar;
 
 	local_irq_save(flags);
@@ -139,7 +139,7 @@ static inline void load_ksp_mmu(struct task_struct *task)
 
 	pte = (mmuar >= PAGE_OFFSET) ? pte_offset_kernel(pmd, mmuar)
 				     : pte_offset_map(pmd, mmuar);
-	if (pte_none(*pte) || !pte_present(*pte))
+	if (!pte || pte_none(*pte) || !pte_present(*pte))
 		goto bug;
 
 	set_pte(pte, pte_mkyoung(*pte));
@@ -161,6 +161,8 @@ static inline void load_ksp_mmu(struct task_struct *task)
 bug:
 	pr_info("ksp load failed: mm=0x%p ksp=0x08%lx\n", mm, mmuar);
 end:
+	if (pte && mmuar < PAGE_OFFSET)
+		pte_unmap(pte);
 	local_irq_restore(flags);
 }
 
diff --git a/arch/m68k/kernel/sys_m68k.c b/arch/m68k/kernel/sys_m68k.c
index bd0274c7592e..c586034d2a7a 100644
--- a/arch/m68k/kernel/sys_m68k.c
+++ b/arch/m68k/kernel/sys_m68k.c
@@ -488,6 +488,8 @@ sys_atomic_cmpxchg_32(unsigned long newval, int oldval, int d3, int d4, int d5,
 		if (!pmd_present(*pmd))
 			goto bad_access;
 		pte = pte_offset_map_lock(mm, pmd, (unsigned long)mem, &ptl);
+		if (!pte)
+			goto bad_access;
 		if (!pte_present(*pte) || !pte_dirty(*pte)
 		    || !pte_write(*pte)) {
 			pte_unmap_unlock(pte, ptl);
diff --git a/arch/m68k/mm/mcfmmu.c b/arch/m68k/mm/mcfmmu.c
index 70aa0979e027..42f45abea37a 100644
--- a/arch/m68k/mm/mcfmmu.c
+++ b/arch/m68k/mm/mcfmmu.c
@@ -91,7 +91,8 @@ int cf_tlb_miss(struct pt_regs *regs, int write, int dtlb, int extension_word)
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
-	pte_t *pte;
+	pte_t *pte = NULL;
+	int ret = -1;
 	int asid;
 
 	local_irq_save(flags);
@@ -100,47 +101,33 @@ int cf_tlb_miss(struct pt_regs *regs, int write, int dtlb, int extension_word)
 		regs->pc + (extension_word * sizeof(long));
 
 	mm = (!user_mode(regs) && KMAPAREA(mmuar)) ? &init_mm : current->mm;
-	if (!mm) {
-		local_irq_restore(flags);
-		return -1;
-	}
+	if (!mm)
+		goto out;
 
 	pgd = pgd_offset(mm, mmuar);
-	if (pgd_none(*pgd))  {
-		local_irq_restore(flags);
-		return -1;
-	}
+	if (pgd_none(*pgd))
+		goto out;
 
 	p4d = p4d_offset(pgd, mmuar);
-	if (p4d_none(*p4d)) {
-		local_irq_restore(flags);
-		return -1;
-	}
+	if (p4d_none(*p4d))
+		goto out;
 
 	pud = pud_offset(p4d, mmuar);
-	if (pud_none(*pud)) {
-		local_irq_restore(flags);
-		return -1;
-	}
+	if (pud_none(*pud))
+		goto out;
 
 	pmd = pmd_offset(pud, mmuar);
-	if (pmd_none(*pmd)) {
-		local_irq_restore(flags);
-		return -1;
-	}
+	if (pmd_none(*pmd))
+		goto out;
 
 	pte = (KMAPAREA(mmuar)) ? pte_offset_kernel(pmd, mmuar)
 				: pte_offset_map(pmd, mmuar);
-	if (pte_none(*pte) || !pte_present(*pte)) {
-		local_irq_restore(flags);
-		return -1;
-	}
+	if (!pte || pte_none(*pte) || !pte_present(*pte))
+		goto out;
 
 	if (write) {
-		if (!pte_write(*pte)) {
-			local_irq_restore(flags);
-			return -1;
-		}
+		if (!pte_write(*pte))
+			goto out;
 		set_pte(pte, pte_mkdirty(*pte));
 	}
 
@@ -161,9 +148,12 @@ int cf_tlb_miss(struct pt_regs *regs, int write, int dtlb, int extension_word)
 		mmu_write(MMUOR, MMUOR_ACC | MMUOR_UAA);
 	else
 		mmu_write(MMUOR, MMUOR_ITLB | MMUOR_ACC | MMUOR_UAA);
-
+	ret = 0;
+out:
+	if (pte && !KMAPAREA(mmuar))
+		pte_unmap(pte);
 	local_irq_restore(flags);
-	return 0;
+	return ret;
 }
 
 void __init cf_bootmem_alloc(void)
-- 
2.35.3

