Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA9C7287AE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbjFHTLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbjFHTLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:11:10 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65912D7F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 12:11:03 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-558a79941c6so633487eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 12:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686251462; x=1688843462;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1YvWeTkG3kfP7WDkFLxY3Kk7w85fUEyISH4lFagFGGw=;
        b=zI2n2c7OkddkeoVughk/breFog0Z+EugvTVCVE29AxlIwAuw/EXjuVVrGwHMRC2bhf
         x0zQuSLbArDGG85kKSwsyOqR0pmFFom/E7xSbaqroxyuObbaGosDK+M/+SoF1AtELCEy
         bwiSK0YoqwXYs8RFX4mr6F5bpRQfVt01fhKCwqENzESWm7Dhrz7vfiQry977lpQgtzrZ
         wnC//NTYAzqdTpQsJYqSSYM/JJ1rR9aCAEjxg8RoVlpIwLkFMrqySi29YtVXSpE8PojR
         NAOs9BLAS5JJ+VzpPEvMOGrhcKbJ9tQKHA0AjGKdBMYv+rB/+u255TZMPygFcoEpIAK5
         9xvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686251462; x=1688843462;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1YvWeTkG3kfP7WDkFLxY3Kk7w85fUEyISH4lFagFGGw=;
        b=KPuW+BrmIYG1FSAZ+Pt0dKYZZ9nK8q9Jn+1sZkuW170VMsv5xsixou62ms6UNpYoMf
         jm1kVRQQpwie5ldpy+P2DkX8SZWRFk7IHSevD/nwoo6XzzX+B/2eXt87Mha/qX12AXzQ
         b0TBQiZ9rSqQ35WdOcLIZqHwOwEZVmi02dfyCOenY3GhHCJKe1OKDq3TYxoD0MPO9iVB
         9hmntQ36cWGbRkSM4PyvHoPknyjgOK3AZCQrTyxIfVJJV2Ed9yJZA2aY9ZUgFjz73dfV
         TB8lkKJ/yRaWD9yaObDs+I0Zhw7NRPGMNPYW0jrofvETBu+b8skcKVKWI7zPVTi0EAZz
         E1uA==
X-Gm-Message-State: AC+VfDxVf1jfmSwm4WSXOPHxXtl7BtL0B3eZihcOEL7tcyfEMcchAH9e
        7qlJ8vulq5USVmV32AkfveI0LQ==
X-Google-Smtp-Source: ACHHUZ5JMT1Kov7YopWmoAdbj6VCmy1YpW57EN24ghxD3DbymGPoxfTUoK+9WA1xlwUdsIzRTkW8Cg==
X-Received: by 2002:a05:6359:38f:b0:128:7ef8:805f with SMTP id eg15-20020a056359038f00b001287ef8805fmr5080226rwb.6.1686251462249;
        Thu, 08 Jun 2023 12:11:02 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a17-20020a81bb51000000b00545a08184fdsm87881ywl.141.2023.06.08.12.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 12:11:01 -0700 (PDT)
Date:   Thu, 8 Jun 2023 12:10:57 -0700 (PDT)
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
Subject: [PATCH v2 01/23] arm: allow pte_offset_map[_lock]() to fail
In-Reply-To: <a4963be9-7aa6-350-66d0-2ba843e1af44@google.com>
Message-ID: <813429a1-204a-1844-eeae-7fd72826c28@google.com>
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

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/arm/lib/uaccess_with_memcpy.c | 3 +++
 arch/arm/mm/fault-armv.c           | 5 ++++-
 arch/arm/mm/fault.c                | 3 +++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/lib/uaccess_with_memcpy.c b/arch/arm/lib/uaccess_with_memcpy.c
index e4c2677cc1e9..2f6163f05e93 100644
--- a/arch/arm/lib/uaccess_with_memcpy.c
+++ b/arch/arm/lib/uaccess_with_memcpy.c
@@ -74,6 +74,9 @@ pin_page_for_write(const void __user *_addr, pte_t **ptep, spinlock_t **ptlp)
 		return 0;
 
 	pte = pte_offset_map_lock(current->mm, pmd, addr, &ptl);
+	if (unlikely(!pte))
+		return 0;
+
 	if (unlikely(!pte_present(*pte) || !pte_young(*pte) ||
 	    !pte_write(*pte) || !pte_dirty(*pte))) {
 		pte_unmap_unlock(pte, ptl);
diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index 0e49154454a6..ca5302b0b7ee 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -117,8 +117,11 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
 	 * must use the nested version.  This also means we need to
 	 * open-code the spin-locking.
 	 */
-	ptl = pte_lockptr(vma->vm_mm, pmd);
 	pte = pte_offset_map(pmd, address);
+	if (!pte)
+		return 0;
+
+	ptl = pte_lockptr(vma->vm_mm, pmd);
 	do_pte_lock(ptl);
 
 	ret = do_adjust_pte(vma, address, pfn, pte);
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 2418f1efabd8..83598649a094 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -85,6 +85,9 @@ void show_pte(const char *lvl, struct mm_struct *mm, unsigned long addr)
 			break;
 
 		pte = pte_offset_map(pmd, addr);
+		if (!pte)
+			break;
+
 		pr_cont(", *pte=%08llx", (long long)pte_val(*pte));
 #ifndef CONFIG_ARM_LPAE
 		pr_cont(", *ppte=%08llx",
-- 
2.35.3

