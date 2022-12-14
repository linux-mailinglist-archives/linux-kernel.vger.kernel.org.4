Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B1F64D0E6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 21:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiLNUPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 15:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiLNUOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 15:14:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BBF2DAA5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671048304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MJ7e/1DcKV7t12TWKKrFJ7YtUmiSHu7Oz11prJXIio4=;
        b=EsxNbnkrkNMDJf3CH9JRmlpU9TxSkl1jWZZTY/hHG8OS9Q2yPJ81iuPIth22VZzNrCfXvE
        arGQ/DAti1C95oB7cGEsi2+c+2tPeu1isucWJO4IpQgUI+p5uam+zu4shKLAPbcS/gFWoy
        3Rr6rXbry1kn39+oxMbn0+4gI8GhXE4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-346-cUu6-2BtNGu1YKtuyRbOvw-1; Wed, 14 Dec 2022 15:05:02 -0500
X-MC-Unique: cUu6-2BtNGu1YKtuyRbOvw-1
Received: by mail-qt1-f198.google.com with SMTP id cj6-20020a05622a258600b003a519d02f59so3073333qtb.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:05:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJ7e/1DcKV7t12TWKKrFJ7YtUmiSHu7Oz11prJXIio4=;
        b=jaclxfeSk09a1lndLQIj2i5DE1JVdVhj4fAD/VtGCP3cwn032QwlTRqhgkjBoJ9E2c
         rFeKyOzXofg1SrGjZnbhCVuf87xBxLDP00ZjUwCASLFo63wuRIrOu5zj39cEqkqRGihr
         juSqWXyFUBHLME7Zy6OTxFwF5vyDoZN1zP6L4jsFeHFAJWAwDmySS+/9A8fvChLs6O3j
         /C3mIwWTqR5tKyqU5Kb9iaYaU1Dc+gadFfviLx9fPjDPLGObOsY6yOcB/BvrM645USG6
         lprT9u2KRE/wGQcivTiyui+3TcB6rbFmlKeHjL+XBpW2Zf/ZzF6mPkm8+N3UT6OD/avI
         c0iA==
X-Gm-Message-State: ANoB5pnf2PQWLfPGbffCW7gWpcN96IbmUx2FdEoBYJ5/PhJLEctAx5Ds
        Tmd2qJfzDJBG9aOuJYY4rrZbZrEoPLYI6KvePe5OUBs2Cd4lU6CbvthR/2RMFSPlT8nqnXrad3e
        8hheGnPxjxoNmbi8eaY2uEUH0a/qF6/LlFrhCg+jYja7NLSMvu1qdqRYyTi/YI2kVuZGhOFEXmQ
        ==
X-Received: by 2002:a05:622a:1b89:b0:39c:da21:6c13 with SMTP id bp9-20020a05622a1b8900b0039cda216c13mr44170159qtb.21.1671048301518;
        Wed, 14 Dec 2022 12:05:01 -0800 (PST)
X-Google-Smtp-Source: AA0mqf61WATzn512XRe0RoNlnRHQ4R3JYnKWst4qaILG5dFlGhU5Ah2KHA1S4XcD4i6m0KU+szKXiQ==
X-Received: by 2002:a05:622a:1b89:b0:39c:da21:6c13 with SMTP id bp9-20020a05622a1b8900b0039cda216c13mr44170118qtb.21.1671048301045;
        Wed, 14 Dec 2022 12:05:01 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-45-70-31-26-132.dsl.bell.ca. [70.31.26.132])
        by smtp.gmail.com with ESMTPSA id l11-20020ac848cb000000b003a689a5b177sm2199352qtr.8.2022.12.14.12.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 12:05:00 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Pengfei Xu <pengfei.xu@intel.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Huang Ying <ying.huang@intel.com>
Subject: [PATCH 2/2] mm: Fix a few rare cases of using swapin error pte marker
Date:   Wed, 14 Dec 2022 15:04:53 -0500
Message-Id: <20221214200453.1772655-3-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221214200453.1772655-1-peterx@redhat.com>
References: <20221214200453.1772655-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch should harden commit 15520a3f0469 ("mm: use pte markers for swap
errors") on using pte markers for swapin errors on a few corner cases.

1. Propagate swapin errors across fork()s: if there're swapin errors in
   the parent mm, after fork()s the child should sigbus too when an error
   page is accessed.

2. Fix a rare condition race in pte_marker_clear() where a uffd-wp pte
   marker can be quickly switched to a swapin error.

3. Explicitly ignore swapin error pte markers in change_protection().

I mostly don't worry on (2) or (3) at all, but we should still have them.
Case (1) is special because it can potentially cause silent data corrupt on
child when parent has swapin error triggered with swapoff, but since swapin
error is rare itself already it's probably not easy to trigger either.

Currently there is a priority difference between the uffd-wp bit and the
swapin error entry, in which the swapin error always has higher
priority (e.g. we don't need to wr-protect a swapin error pte marker).

If there will be a 3rd bit introduced, we'll probably need to consider a
more involved approach so we may need to start operate on the bits.  Let's
leave that for later.

This patch is tested with case (1) explicitly where we'll get corrupted
data before in the child if there's existing swapin error pte markers, and
after patch applied the child can be rightfully killed.

We don't need to copy stable for this one since 15520a3f0469 just landed as
part of v6.2-rc1, only "Fixes" applied.

Fixes: 15520a3f0469 ("mm: use pte markers for swap errors")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c  | 3 +++
 mm/memory.c   | 8 ++++++--
 mm/mprotect.c | 8 +++++++-
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f5f445c39dbc..1e8e4eb10328 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4884,6 +4884,9 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				entry = huge_pte_clear_uffd_wp(entry);
 			set_huge_pte_at(dst, addr, dst_pte, entry);
 		} else if (unlikely(is_pte_marker(entry))) {
+			/* No swap on hugetlb */
+			WARN_ON_ONCE(
+			    is_swapin_error_entry(pte_to_swp_entry(entry)));
 			/*
 			 * We copy the pte marker only if the dst vma has
 			 * uffd-wp enabled.
diff --git a/mm/memory.c b/mm/memory.c
index 032ef700c3e8..3e836fecd035 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -828,7 +828,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 			return -EBUSY;
 		return -ENOENT;
 	} else if (is_pte_marker_entry(entry)) {
-		if (userfaultfd_wp(dst_vma))
+		if (is_swapin_error_entry(entry) || userfaultfd_wp(dst_vma))
 			set_pte_at(dst_mm, addr, dst_pte, pte);
 		return 0;
 	}
@@ -3625,8 +3625,12 @@ static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
 	/*
 	 * Be careful so that we will only recover a special uffd-wp pte into a
 	 * none pte.  Otherwise it means the pte could have changed, so retry.
+	 *
+	 * This should also cover the case where e.g. the pte changed
+	 * quickly from a PTE_MARKER_UFFD_WP into PTE_MARKER_SWAPIN_ERROR.
+	 * So is_pte_marker() check is not enough to safely drop the pte.
 	 */
-	if (is_pte_marker(*vmf->pte))
+	if (pte_same(vmf->orig_pte, *vmf->pte))
 		pte_clear(vmf->vma->vm_mm, vmf->address, vmf->pte);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	return 0;
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 093cb50f2fc4..a6f905211327 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -245,7 +245,13 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 					newpte = pte_swp_mksoft_dirty(newpte);
 				if (pte_swp_uffd_wp(oldpte))
 					newpte = pte_swp_mkuffd_wp(newpte);
-			} else if (pte_marker_entry_uffd_wp(entry)) {
+			} else if (is_pte_marker_entry(entry)) {
+				/*
+				 * Ignore swapin errors unconditionally,
+				 * because any access should sigbus anyway.
+				 */
+				if (is_swapin_error_entry(entry))
+					continue;
 				/*
 				 * If this is uffd-wp pte marker and we'd like
 				 * to unprotect it, drop it; the next page
-- 
2.37.3

