Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5816F69B6BA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjBRA2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjBRA2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:28:47 -0500
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com [IPv6:2607:f8b0:4864:20::949])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421555A3A3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:28:46 -0800 (PST)
Received: by mail-ua1-x949.google.com with SMTP id j26-20020ab06cba000000b0066119a9d3bbso855914uaa.21
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LnKhelmr0oBezYImc/CiFkR5B91EfUKvE0Rbw9pLRe4=;
        b=lQipQIAGaSVcFBsRExtQaFLnPm6HAzNz2+VJbpondpycb1x3PDuXTd+i0o++TSF9er
         gxut9YhAnGbep2SPcG0jDIMVR2mq6NQ41EE/6bkL3ZaN7Gb6kf8EWJR5CwB22gEUYwsb
         dux6/8aAmRzRNX/2PmjME6f1c/ZNU7ZaQroNOMlaJyZVlnL1oAKwRpxb7/HYgt7/PydP
         lxdcZ2uDPD9axodhgg/osne68KRXEtgsS6fa3iXBXgLQZ3W+b4wOBh19dwO8qERvglmh
         y56jvQy6e2CUxUzTLyorFkYxBNBmTKZfxgrrDzoZSssQ0cO8QYft6CecYtHZ5imrv86K
         Ha7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LnKhelmr0oBezYImc/CiFkR5B91EfUKvE0Rbw9pLRe4=;
        b=t3k1eNGmgIllVmMfGbkxM2JeaQUux2IfPFoHtU9ouXRB556HeRdp57gENK4S6UlN7t
         PF3knzrOn5VEHUROtLBpUswa+freXkrJp6OjOEScCh/NMVbpvQ4yCA7idCGPijP59C6R
         UegqopOA6ECSmPol+tVNP6/sSceokL29/RMAkr8EzFzLh85CWJZJVlJiyNisWJKniHPE
         7seYOgyunXLrt3Eb4nEnziC1riril+RSQQ0o0Fl2cyXIclLseIrQsJB3KUAvB00BeYaF
         KIq+xnTPy2xd6KTDsDmLdPPNFg/HAbnuliTan9RkOftLJjcy3Wbewa39aY2+hXpk8rjQ
         6k3Q==
X-Gm-Message-State: AO0yUKUvPMPstaS5OamcopfNnBOyh/4eESrLiDHWlgfMCxwoq/jONArJ
        VbXJ70oXeHweKh1tfCcxwyLH4QRDu3K7u413
X-Google-Smtp-Source: AK7set9cfmc3rDPTjjWrEWA1g/aV5e0+YQFlWRnOBBxS/xzEKz7fRzIC1V+FfmOXZMHdILJkQVdHqDoADwXiTyis
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6130:a0a:b0:67a:2833:5ceb with SMTP
 id bx10-20020a0561300a0a00b0067a28335cebmr54247uab.0.1676680125416; Fri, 17
 Feb 2023 16:28:45 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:27:35 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-3-jthoughton@google.com>
Subject: [PATCH v2 02/46] hugetlb: remove mk_huge_pte; it is unused
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mk_huge_pte is unused and not necessary. pte_mkhuge is the appropriate
function to call to create a HugeTLB PTE (see
Documentation/mm/arch_pgtable_helpers.rst).

It is being removed now to avoid complicating the implementation of
HugeTLB high-granularity mapping.

Acked-by: Peter Xu <peterx@redhat.com>
Acked-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
index ccdbccfde148..c34893719715 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -77,11 +77,6 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 	set_huge_pte_at(mm, addr, ptep, pte_wrprotect(pte));
 }
 
-static inline pte_t mk_huge_pte(struct page *page, pgprot_t pgprot)
-{
-	return mk_pte(page, pgprot);
-}
-
 static inline int huge_pte_none(pte_t pte)
 {
 	return pte_none(pte);
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index d7f6335d3999..be2e763e956f 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -5,11 +5,6 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 
-static inline pte_t mk_huge_pte(struct page *page, pgprot_t pgprot)
-{
-	return mk_pte(page, pgprot);
-}
-
 static inline unsigned long huge_pte_write(pte_t pte)
 {
 	return pte_write(pte);
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index af59cc7bd307..fbbc53113473 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -925,7 +925,7 @@ static void __init hugetlb_basic_tests(struct pgtable_debug_args *args)
 	 * as it was previously derived from a real kernel symbol.
 	 */
 	page = pfn_to_page(args->fixed_pmd_pfn);
-	pte = mk_huge_pte(page, args->page_prot);
+	pte = mk_pte(page, args->page_prot);
 
 	WARN_ON(!huge_pte_dirty(huge_pte_mkdirty(pte)));
 	WARN_ON(!huge_pte_write(huge_pte_mkwrite(huge_pte_wrprotect(pte))));
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 792cb2e67ce5..540cdf9570d3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4899,11 +4899,10 @@ static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
 	unsigned int shift = huge_page_shift(hstate_vma(vma));
 
 	if (writable) {
-		entry = huge_pte_mkwrite(huge_pte_mkdirty(mk_huge_pte(page,
-					 vma->vm_page_prot)));
+		entry = huge_pte_mkwrite(huge_pte_mkdirty(mk_pte(page,
+						vma->vm_page_prot)));
 	} else {
-		entry = huge_pte_wrprotect(mk_huge_pte(page,
-					   vma->vm_page_prot));
+		entry = huge_pte_wrprotect(mk_pte(page, vma->vm_page_prot));
 	}
 	entry = pte_mkyoung(entry);
 	entry = arch_make_huge_pte(entry, shift, vma->vm_flags);
-- 
2.39.2.637.g21b0678d19-goog

