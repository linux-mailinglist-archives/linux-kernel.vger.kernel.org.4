Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6396FD5BC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 07:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjEJFB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 01:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbjEJFBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 01:01:24 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEA649D5
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 22:01:21 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-55a829411b5so62527657b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 22:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683694880; x=1686286880;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WSGFooIbg1YnCT+usP0CPskjqWFniw8CJbMJmY8IIY4=;
        b=vuo7rYDMzaDeDPZgzHMtVp+kDDpzRoF+cP2Qnr93hh+pF6J9q5tC6QhVWjQR/dpJZs
         St4YSsmW5E0SKuQmRdibMqMztrKviA12bUxhXRBvVCQgZMikD8H0uj5+E9csqviYPTTF
         W/MWYfjHA/1NssscvDoyXC6tVcA1ciumq+qFhN9YZhl/AUe/TYRGPOpbxUr3CzSoAwDs
         9ZIJx+k2kcTyg+8Yd6pO3A43gfTS5JygrpCg5CjFhHivuRBYVd+ivlToDlbyQHOK26G6
         DP8KUWo0VQTsOYmO3ProNs6agiD4J9mWFi/qWhwm90YAcZbtyMXr/cNFlm/A7CEZL/+P
         HUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683694880; x=1686286880;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WSGFooIbg1YnCT+usP0CPskjqWFniw8CJbMJmY8IIY4=;
        b=SzixfgxI5Ei2e/Rd9pwFlJE8tRzvP9H+O4+H1TQ+XXQw5sF7gkH5mAIzCOh+JcIEI3
         hFOMXVmee07undxfk+ToANPyQMox3mYrjhH0nPJAiEw46tbxgymPnfiQ+KSppMPR6DXP
         OH7LZLMdlfCa6+jHRYroWB0ok/GASUn6KRIiEKPijawuJ3O7GVQmHZnmHAEnIjIrKMsu
         Y9MJ/fVaPcC4KothoSn4tZGh/dEox39ExJH+pCcSGP23WI7EISYN62LZIyuBp1zYRXt3
         N0ifNAxUE16EI9dZ47cTx8ArWJEjZ/xFvlTfREpjrGZ25AvfTWuF0953JctDLZ4z5LU0
         zsWA==
X-Gm-Message-State: AC+VfDyeSNbGQrqm4ij6vdJSPlJkOjDTF2QTtjys+Zm9deMhtiicUZOY
        CedeOHjMH6QExXVVQD8P5MySKA==
X-Google-Smtp-Source: ACHHUZ5AoVobUeVID967V3Jmnothc2qu5Os8b3JQyJT6HUqgLFH4b1VRwh/1toL1vvMbGclLD2jjcg==
X-Received: by 2002:a0d:d4c3:0:b0:55a:9d84:2e4e with SMTP id w186-20020a0dd4c3000000b0055a9d842e4emr17674451ywd.18.1683694880477;
        Tue, 09 May 2023 22:01:20 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e2-20020a81dd02000000b00559f9e9eabcsm3815388ywn.98.2023.05.09.22.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 22:01:20 -0700 (PDT)
Date:   Tue, 9 May 2023 22:01:16 -0700 (PDT)
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
Subject: [PATCH 15/23] s390: allow pte_offset_map_lock() to fail
In-Reply-To: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
Message-ID: <94aec8fe-383f-892-dcbf-d4c14e460a7@google.com>
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

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/s390/kernel/uv.c  |  2 ++
 arch/s390/mm/gmap.c    |  2 ++
 arch/s390/mm/pgtable.c | 12 +++++++++---
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index cb2ee06df286..3c62d1b218b1 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -294,6 +294,8 @@ int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb)
 
 	rc = -ENXIO;
 	ptep = get_locked_pte(gmap->mm, uaddr, &ptelock);
+	if (!ptep)
+		goto out;
 	if (pte_present(*ptep) && !(pte_val(*ptep) & _PAGE_INVALID) && pte_write(*ptep)) {
 		page = pte_page(*ptep);
 		rc = -EAGAIN;
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index dc90d1eb0d55..d198fc9475a2 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2549,6 +2549,8 @@ static int __zap_zero_pages(pmd_t *pmd, unsigned long start,
 		spinlock_t *ptl;
 
 		ptep = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+		if (!ptep)
+			break;
 		if (is_zero_pfn(pte_pfn(*ptep)))
 			ptep_xchg_direct(walk->mm, addr, ptep, __pte(_PAGE_INVALID));
 		pte_unmap_unlock(ptep, ptl);
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 6effb24de6d9..3bd2ab2a9a34 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -829,7 +829,7 @@ int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 	default:
 		return -EFAULT;
 	}
-
+again:
 	ptl = pmd_lock(mm, pmdp);
 	if (!pmd_present(*pmdp)) {
 		spin_unlock(ptl);
@@ -850,6 +850,8 @@ int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 	spin_unlock(ptl);
 
 	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
+	if (!ptep)
+		goto again;
 	new = old = pgste_get_lock(ptep);
 	pgste_val(new) &= ~(PGSTE_GR_BIT | PGSTE_GC_BIT |
 			    PGSTE_ACC_BITS | PGSTE_FP_BIT);
@@ -938,7 +940,7 @@ int reset_guest_reference_bit(struct mm_struct *mm, unsigned long addr)
 	default:
 		return -EFAULT;
 	}
-
+again:
 	ptl = pmd_lock(mm, pmdp);
 	if (!pmd_present(*pmdp)) {
 		spin_unlock(ptl);
@@ -955,6 +957,8 @@ int reset_guest_reference_bit(struct mm_struct *mm, unsigned long addr)
 	spin_unlock(ptl);
 
 	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
+	if (!ptep)
+		goto again;
 	new = old = pgste_get_lock(ptep);
 	/* Reset guest reference bit only */
 	pgste_val(new) &= ~PGSTE_GR_BIT;
@@ -1000,7 +1004,7 @@ int get_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 	default:
 		return -EFAULT;
 	}
-
+again:
 	ptl = pmd_lock(mm, pmdp);
 	if (!pmd_present(*pmdp)) {
 		spin_unlock(ptl);
@@ -1017,6 +1021,8 @@ int get_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 	spin_unlock(ptl);
 
 	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
+	if (!ptep)
+		goto again;
 	pgste = pgste_get_lock(ptep);
 	*key = (pgste_val(pgste) & (PGSTE_ACC_BITS | PGSTE_FP_BIT)) >> 56;
 	paddr = pte_val(*ptep) & PAGE_MASK;
-- 
2.35.3

