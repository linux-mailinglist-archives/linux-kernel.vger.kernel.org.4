Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60CC60BEAB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiJXXdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiJXXdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:33:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD422CB8CE
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666648441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B26mrVLxvv94GHZ4EyopRcUEqjnA0ulPrAxRLMb69GQ=;
        b=fGCwNZIBhZQ0qnHIGvefzgF/aD/vkkXd96VP7VYsZtBnlgmRINJiOqGteg4wjJysHnWIjD
        OukveRPmea9/yjGcUHb0kEkKcNQ5B8hsQ+Y70DnoCeIC/9ydDzgaPeWdriBeIr8ZXQE1ui
        b11ML/6BZ6MiPHLfC0gO3CY5aYKcvoA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-460-U2zzMCwPMj2rznDcFf-6xg-1; Mon, 24 Oct 2022 15:33:42 -0400
X-MC-Unique: U2zzMCwPMj2rznDcFf-6xg-1
Received: by mail-qv1-f72.google.com with SMTP id nn2-20020a056214358200b004bb7bc3dfdcso1270821qvb.23
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B26mrVLxvv94GHZ4EyopRcUEqjnA0ulPrAxRLMb69GQ=;
        b=fbpXo+lG6P/joxVSKXnQvchiAZATesCjlIDZC8T4dsPxKZ+RQ3Vmb6J6oWu/2MMBel
         evfFY/NcY2AU/N/F5T0c+Vyia0ObzjFPxjrOEgAUq1k4+l+8NwJLdpU90lwGKjy14HsY
         ocoHKtjjZZOc88KFMMw7tdzBcRvPge2JlfoZDT5shBr4sToQ9eFyK6JmMlAzA8zHkpZQ
         Y+0LXVKQYU3sNHFex1Wetcn4FmcTkXxNksKZQ3n9efe8Px4dNw/SahVKOIB4+mGn0FUt
         dGZBwybso4YqeMezz8BdnH6bOZLNB4oi8hzv3NnEZOJmwa7HCgfggdMSbW8DHEB/at+E
         5NIg==
X-Gm-Message-State: ACrzQf3RGlguCEcHeC22Qo+PPgcR51pyaG1H3YRuz78MDc8HKIKO0HSY
        U4njJCZjbsXPhe4jXIwhK7+SGX99hw/hxNWtyR+UQbXjdEtvs/ToEG4tB5o/OiIsajcBvtPB8nw
        3wCi533VIHU0e4QiTRaSWx+fa
X-Received: by 2002:ac8:4d5b:0:b0:39c:b6d2:b631 with SMTP id x27-20020ac84d5b000000b0039cb6d2b631mr28890941qtv.487.1666640021573;
        Mon, 24 Oct 2022 12:33:41 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6R9fk2GOMQDrYgO/fAupULF4Tu6JcWydWZM0pW5ldS7Wd85SIl/rXdo1urC1LqoxV/541nKg==
X-Received: by 2002:ac8:4d5b:0:b0:39c:b6d2:b631 with SMTP id x27-20020ac84d5b000000b0039cb6d2b631mr28890924qtv.487.1666640021327;
        Mon, 24 Oct 2022 12:33:41 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id t15-20020a05620a450f00b006cddf59a600sm545164qkp.34.2022.10.24.12.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 12:33:40 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 2/2] Revert "mm/uffd: fix warning without PTE_MARKER_UFFD_WP compiled in"
Date:   Mon, 24 Oct 2022 15:33:36 -0400
Message-Id: <20221024193336.1233616-3-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024193336.1233616-1-peterx@redhat.com>
References: <20221024193336.1233616-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With previous patch to fix the registration, we'll be safe to remove the
macro hacks now.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c  | 4 ----
 mm/memory.c   | 2 --
 mm/mprotect.c | 2 --
 3 files changed, 8 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1a7dc7b2e16c..b2fcb27f268a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5124,7 +5124,6 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 		 * unmapped and its refcount is dropped, so just clear pte here.
 		 */
 		if (unlikely(!pte_present(pte))) {
-#ifdef CONFIG_PTE_MARKER_UFFD_WP
 			/*
 			 * If the pte was wr-protected by uffd-wp in any of the
 			 * swap forms, meanwhile the caller does not want to
@@ -5136,7 +5135,6 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 				set_huge_pte_at(mm, address, ptep,
 						make_pte_marker(PTE_MARKER_UFFD_WP));
 			else
-#endif
 				huge_pte_clear(mm, address, ptep, sz);
 			spin_unlock(ptl);
 			continue;
@@ -5165,13 +5163,11 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 		tlb_remove_huge_tlb_entry(h, tlb, ptep, address);
 		if (huge_pte_dirty(pte))
 			set_page_dirty(page);
-#ifdef CONFIG_PTE_MARKER_UFFD_WP
 		/* Leave a uffd-wp pte marker if needed */
 		if (huge_pte_uffd_wp(pte) &&
 		    !(zap_flags & ZAP_FLAG_DROP_MARKER))
 			set_huge_pte_at(mm, address, ptep,
 					make_pte_marker(PTE_MARKER_UFFD_WP));
-#endif
 		hugetlb_count_sub(pages_per_huge_page(h), mm);
 		page_remove_rmap(page, vma, true);
 
diff --git a/mm/memory.c b/mm/memory.c
index 8e72f703ed99..25b12d1a7db0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1393,12 +1393,10 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
 			      unsigned long addr, pte_t *pte,
 			      struct zap_details *details, pte_t pteval)
 {
-#ifdef CONFIG_PTE_MARKER_UFFD_WP
 	if (zap_drop_file_uffd_wp(details))
 		return;
 
 	pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
-#endif
 }
 
 static unsigned long zap_pte_range(struct mmu_gather *tlb,
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 99762403cc8f..8d770855b591 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -267,7 +267,6 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 		} else {
 			/* It must be an none page, or what else?.. */
 			WARN_ON_ONCE(!pte_none(oldpte));
-#ifdef CONFIG_PTE_MARKER_UFFD_WP
 			if (unlikely(uffd_wp && !vma_is_anonymous(vma))) {
 				/*
 				 * For file-backed mem, we need to be able to
@@ -279,7 +278,6 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 					   make_pte_marker(PTE_MARKER_UFFD_WP));
 				pages++;
 			}
-#endif
 		}
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	arch_leave_lazy_mmu_mode();
-- 
2.37.3

