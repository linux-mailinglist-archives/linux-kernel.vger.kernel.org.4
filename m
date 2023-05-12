Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DDB7012DC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 01:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241173AbjELX6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 19:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240973AbjELX6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 19:58:43 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF2035A6
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:58:16 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-560def4d06dso70288487b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683935895; x=1686527895;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LVFc+Brp/nv5bcVUuCiFrcDkBMn4WnVlAUQLAdw9K1k=;
        b=f5hclik/Ew6KC4whYAG5VntaAWwKmaBWXX4bCpgRdYjBpbSj5Apr3PkSoK7/QAJd0N
         RpHxTIRW/bLimRvcbUmZjobDE/Eutpj6tvgC/Rdg9nOt+ZvW2UeGjSSNnpNfchKgE9qV
         bfsrP2dthFHNMRT6c5aCQw0Ff/JTyx0DIAtRow1fvLqu2M2UZFqFRteLQ4IPrCBhdwYv
         ZUWPKO0rlZI6hiVGzQF5WVmuVs1EGnbfoUeE09/HLSnj37gvPWFw6+cmVnJFfHK5WbAH
         YWYFfgDih13LoVhaHD+4rYuds+BE6rKkLJ/AoCA0fp0U2j35styXF7xvUDDBUZNd5sjd
         vJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683935895; x=1686527895;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LVFc+Brp/nv5bcVUuCiFrcDkBMn4WnVlAUQLAdw9K1k=;
        b=TbtE1shXhTgYQqgtGw3JnujLVp6gsuE93Ypym+2/MU6oI4QMHVk+Pj/lYhAMfxcKfC
         0a277DIEk5MkdmXPrzRK/jBQ9Jgbzcyw+M4Vmtns5PHV1mu42vFq49oO349536OVeDey
         tfzSmfQ6x9JrVSR/6s+oteridDCpNfJtV18KeZrhnWYtXfnLDbDX3woiRKrEybp7QOzy
         TXzwQXTjMbJLodW7bm7rZctqW71jcWaqeTVfoRTTlb1q40TxT+LUw2J6PAr95GNJL16Q
         KQQAfV7GrIp/3ldwvrrdNabg8f+MDT7lQXccSjF04zYXstsuQaL4tbJXstILq4vzioJg
         k6fg==
X-Gm-Message-State: AC+VfDyUX5PtylCgjMh/fE8IeE9mq1mCdTV7a5uD62RaB5YPwLGDRcn9
        PrqyK/gJJyIbxhnFLx1dpGSOLoU=
X-Google-Smtp-Source: ACHHUZ7VMsxVospQ1XLBd1n7/FkUbi+qPyj+Q+Eihu+tg6ttj97Cmt/cOaDOuPcaz9q0znnK8MBI35s=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2d3:205:ff6:108b:739d:6a1c])
 (user=pcc job=sendgmr) by 2002:a81:b285:0:b0:559:f1b0:6eb with SMTP id
 q127-20020a81b285000000b00559f1b006ebmr16091480ywh.4.1683935894947; Fri, 12
 May 2023 16:58:14 -0700 (PDT)
Date:   Fri, 12 May 2023 16:57:50 -0700
In-Reply-To: <20230512235755.1589034-1-pcc@google.com>
Message-Id: <20230512235755.1589034-2-pcc@google.com>
Mime-Version: 1.0
References: <20230512235755.1589034-1-pcc@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH 1/3] mm: Move arch_do_swap_page() call to before swap_free()
From:   Peter Collingbourne <pcc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        "=?UTF-8?q?Qun-wei=20Lin=20=28=E6=9E=97=E7=BE=A4=E5=B4=B4=29?=" 
        <Qun-wei.Lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "surenb@google.com" <surenb@google.com>,
        "david@redhat.com" <david@redhat.com>,
        "=?UTF-8?q?Chinwen=20Chang=20=28=E5=BC=B5=E9=8C=A6=E6=96=87=29?=" 
        <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "=?UTF-8?q?Kuan-Ying=20Lee=20=28=E6=9D=8E=E5=86=A0=E7=A9=8E=29?=" 
        <Kuan-Ying.Lee@mediatek.com>,
        "=?UTF-8?q?Casper=20Li=20=28=E6=9D=8E=E4=B8=AD=E6=A6=AE=29?=" 
        <casper.li@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        vincenzo.frascino@arm.com,
        Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
        eugenis@google.com, Steven Price <steven.price@arm.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c145e0b47c77 ("mm: streamline COW logic in do_swap_page()") moved
the call to swap_free() before the call to set_pte_at(), which meant that
the MTE tags could end up being freed before set_pte_at() had a chance
to restore them. One other possibility was to hook arch_do_swap_page(),
but this had a number of problems:

- The call to the hook was also after swap_free().

- The call to the hook was after the call to set_pte_at(), so there was a
  racy window where uninitialized metadata may be exposed to userspace.
  This likely also affects SPARC ADI, which implements this hook to
  restore tags.

- As a result of commit 1eba86c096e3 ("mm: change page type prior to
  adding page table entry"), we were also passing the new PTE as the
  oldpte argument, preventing the hook from knowing the swap index.

Fix all of these problems by moving the arch_do_swap_page() call before
the call to free_page(), and ensuring that we do not set orig_pte until
after the call.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://linux-review.googlesource.com/id/I6470efa669e8bd2f841049b8c61020c510678965
Cc: <stable@vger.kernel.org> # 6.1
Fixes: ca827d55ebaa ("mm, swap: Add infrastructure for saving page metadata on swap")
Fixes: 1eba86c096e3 ("mm: change page type prior to adding page table entry")
---
 mm/memory.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 01a23ad48a04..83268d287ff1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3914,19 +3914,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		}
 	}
 
-	/*
-	 * Remove the swap entry and conditionally try to free up the swapcache.
-	 * We're already holding a reference on the page but haven't mapped it
-	 * yet.
-	 */
-	swap_free(entry);
-	if (should_try_to_free_swap(folio, vma, vmf->flags))
-		folio_free_swap(folio);
-
-	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
-	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
 	pte = mk_pte(page, vma->vm_page_prot);
-
 	/*
 	 * Same logic as in do_wp_page(); however, optimize for pages that are
 	 * certainly not shared either because we just allocated them without
@@ -3946,8 +3934,21 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		pte = pte_mksoft_dirty(pte);
 	if (pte_swp_uffd_wp(vmf->orig_pte))
 		pte = pte_mkuffd_wp(pte);
+	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
 	vmf->orig_pte = pte;
 
+	/*
+	 * Remove the swap entry and conditionally try to free up the swapcache.
+	 * We're already holding a reference on the page but haven't mapped it
+	 * yet.
+	 */
+	swap_free(entry);
+	if (should_try_to_free_swap(folio, vma, vmf->flags))
+		folio_free_swap(folio);
+
+	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
+	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
+
 	/* ksm created a completely new copy */
 	if (unlikely(folio != swapcache && swapcache)) {
 		page_add_new_anon_rmap(page, vma, vmf->address);
@@ -3959,7 +3960,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	VM_BUG_ON(!folio_test_anon(folio) ||
 			(pte_write(pte) && !PageAnonExclusive(page)));
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
-	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
 
 	folio_unlock(folio);
 	if (folio != swapcache && swapcache) {
-- 
2.40.1.606.ga4b1b128d6-goog

