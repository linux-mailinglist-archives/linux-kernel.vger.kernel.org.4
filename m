Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87859612D13
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 22:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiJ3Vm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 17:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJ3Vmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 17:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8157DB85D
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 14:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667166117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fX+JSCnPsldLCzmeklskU5n+7tkjCg8wbYp4w0X13YE=;
        b=Aev14zKGKoEAuo/CRNHCFyG5eUIH4cxzqg1XYrln883eftTXVUl5Q7K6U4SzyX3Tbla0LZ
        9hv+ecr8KA5mUzkkbsyi1xKi1olaLzYYB/0ers8JM3jwy9xshVqJo4vsKbsPzHTPBZnS81
        EslYcfDGHTYsrJFv1wGXk8lsRij9Go8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-434-RMyrHXN8OAG7b5_1xEMnUQ-1; Sun, 30 Oct 2022 17:41:56 -0400
X-MC-Unique: RMyrHXN8OAG7b5_1xEMnUQ-1
Received: by mail-qt1-f200.google.com with SMTP id ew11-20020a05622a514b00b003a524196d31so741426qtb.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 14:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fX+JSCnPsldLCzmeklskU5n+7tkjCg8wbYp4w0X13YE=;
        b=rcZga9bkMQe2NRlQm1lGvYOe5J2i9fM6nER+/3fYWVSXDfJm0LKuwUzvNwQFSTxAW6
         EbFsFJSAGftn1qU1IWAFY5UC3sKswd5gMYmda7k56XN7jXtInASZgNn1w+LtmeFHsoZ5
         UHNoKBjQlOzHCYpc0dOrlOhTMKL6eQYvFZ/9NGCDd4t7cIP1zgM6+RfOncmPefbWkDXN
         iFNUrI1VdXR5XExnwmgON+T0n6NIBmT+W9kKpSa7xTOVvvFqETaPjPewG6Oyk2hRwz7X
         myRMFPceY0AfLsNlL1HS4wZH966W+SwzMWWnEuEmzfcFbdhVMJeYo/aGw+CHSgntQX5A
         zJtw==
X-Gm-Message-State: ACrzQf3ckRLj/7rbmrm5NQDQiemY/OKAGenMXx3u3vHH2L/jBPsqXJXi
        wtGD7FhJJCtXhqC46hpidj2525Z0E3m6ezuzps4PDMMCVk1kVJNcK84tzJ+agL/m4QQv+gZ/d7u
        vNDF84UZdtfc0LI8pm+A7CLuy+1WZDfrcTv5UvWUeB5Jb4eJFAZeZQh+WZrPe9h2zkqFfOZPUiQ
        ==
X-Received: by 2002:ac8:455a:0:b0:3a5:2848:6684 with SMTP id z26-20020ac8455a000000b003a528486684mr151489qtn.339.1667166115707;
        Sun, 30 Oct 2022 14:41:55 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5USleFlEkZVYw3WrJWxBoYASvDZKqgoasGEWME223t3xhHNLGEwzMnQF0Osvb31iqHDNPp7A==
X-Received: by 2002:ac8:455a:0:b0:3a5:2848:6684 with SMTP id z26-20020ac8455a000000b003a528486684mr151472qtn.339.1667166115387;
        Sun, 30 Oct 2022 14:41:55 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id az42-20020a05620a172a00b006bb87c4833asm3506450qkb.109.2022.10.30.14.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 14:41:54 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com
Subject: [PATCH 1/2] mm: Always compile in pte markers
Date:   Sun, 30 Oct 2022 17:41:50 -0400
Message-Id: <20221030214151.402274-2-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221030214151.402274-1-peterx@redhat.com>
References: <20221030214151.402274-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PTE markers code is tiny and now it's enabled for most of the
distributions.  It's fine to keep it as-is, but to make a broader use of
it (e.g. replacing read error swap entry) it needs to be there always
otherwise we need special code path to take care of !PTE_MARKER case.

It'll be easier just make pte marker always exist.  Use this chance to
extend its usage to anonymous too by simply touching up some of the old
comments, because it'll be used for anonymous pages in the follow up
patches.

Reviewed-by: Huang Ying <ying.huang@intel.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/swap.h    | 10 +++-------
 include/linux/swapops.h | 31 -------------------------------
 mm/Kconfig              |  7 -------
 mm/memory.c             |  7 +++----
 4 files changed, 6 insertions(+), 49 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 369d7799205d..211aeca9bfa7 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -60,17 +60,13 @@ static inline int current_is_kswapd(void)
 			     SWP_MIGRATION_NUM + SWP_DEVICE_NUM + \
 			     SWP_PTE_MARKER_NUM)
 /*
- * PTE markers are used to persist information onto PTEs that are mapped with
- * file-backed memories.  As its name "PTE" hints, it should only be applied to
- * the leaves of pgtables.
+ * PTE markers are used to persist information onto PTEs that otherwise
+ * should be a none pte.  As its name "PTE" hints, it should only be
+ * applied to the leaves of pgtables.
  */
-#ifdef CONFIG_PTE_MARKER
 #define SWP_PTE_MARKER_NUM 1
 #define SWP_PTE_MARKER     (MAX_SWAPFILES + SWP_HWPOISON_NUM + \
 			    SWP_MIGRATION_NUM + SWP_DEVICE_NUM)
-#else
-#define SWP_PTE_MARKER_NUM 0
-#endif
 
 /*
  * Unaddressable device memory support. See include/linux/hmm.h and
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 3ba9bf56899d..35c1fe62d2e1 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -412,8 +412,6 @@ typedef unsigned long pte_marker;
 #define  PTE_MARKER_UFFD_WP  BIT(0)
 #define  PTE_MARKER_MASK     (PTE_MARKER_UFFD_WP)
 
-#ifdef CONFIG_PTE_MARKER
-
 static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
 {
 	return swp_entry(SWP_PTE_MARKER, marker);
@@ -434,32 +432,6 @@ static inline bool is_pte_marker(pte_t pte)
 	return is_swap_pte(pte) && is_pte_marker_entry(pte_to_swp_entry(pte));
 }
 
-#else /* CONFIG_PTE_MARKER */
-
-static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
-{
-	/* This should never be called if !CONFIG_PTE_MARKER */
-	WARN_ON_ONCE(1);
-	return swp_entry(0, 0);
-}
-
-static inline bool is_pte_marker_entry(swp_entry_t entry)
-{
-	return false;
-}
-
-static inline pte_marker pte_marker_get(swp_entry_t entry)
-{
-	return 0;
-}
-
-static inline bool is_pte_marker(pte_t pte)
-{
-	return false;
-}
-
-#endif /* CONFIG_PTE_MARKER */
-
 static inline pte_t make_pte_marker(pte_marker marker)
 {
 	return swp_entry_to_pte(make_pte_marker_entry(marker));
@@ -477,9 +449,6 @@ static inline pte_t make_pte_marker(pte_marker marker)
  * memory, kernel-only memory (including when the system is during-boot),
  * non-ram based generic file-system.  It's fine to be used even there, but the
  * extra pte marker check will be pure overhead.
- *
- * For systems configured with !CONFIG_PTE_MARKER this will be automatically
- * optimized to pte_none().
  */
 static inline int pte_none_mostly(pte_t pte)
 {
diff --git a/mm/Kconfig b/mm/Kconfig
index 57e1d8c5b505..4b28800d9be1 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1107,17 +1107,10 @@ config HAVE_ARCH_USERFAULTFD_MINOR
 	help
 	  Arch has userfaultfd minor fault support
 
-config PTE_MARKER
-	bool
-
-	help
-	  Allows to create marker PTEs for file-backed memory.
-
 config PTE_MARKER_UFFD_WP
 	bool "Userfaultfd write protection support for shmem/hugetlbfs"
 	default y
 	depends on HAVE_ARCH_USERFAULTFD_WP
-	select PTE_MARKER
 
 	help
 	  Allows to create marker PTEs for userfaultfd write protection
diff --git a/mm/memory.c b/mm/memory.c
index c5599a9279b1..63718094163f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3663,11 +3663,10 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 	unsigned long marker = pte_marker_get(entry);
 
 	/*
-	 * PTE markers should always be with file-backed memories, and the
-	 * marker should never be empty.  If anything weird happened, the best
-	 * thing to do is to kill the process along with its mm.
+	 * PTE markers should never be empty.  If anything weird happened,
+	 * the best thing to do is to kill the process along with its mm.
 	 */
-	if (WARN_ON_ONCE(vma_is_anonymous(vmf->vma) || !marker))
+	if (WARN_ON_ONCE(!marker))
 		return VM_FAULT_SIGBUS;
 
 	if (pte_marker_entry_uffd_wp(entry))
-- 
2.37.3

