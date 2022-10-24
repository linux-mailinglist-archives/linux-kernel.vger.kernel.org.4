Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243DC60BD99
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbiJXWkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbiJXWjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:39:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E432EF615F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666645323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DtjgD11+A1aHTX9ijK54hqLSilN13SGt8oWF8m3PTwE=;
        b=CBuUvnxkNwqNKVplwTRSKew9k6CUd9gp3TWw1ZVgpTqYfKE+zKlXXb0wzdmHQVNDr3eYA8
        i7n6ZEXQ+Je6yEfXbgezi+cCtYes7kA5/KqTyxecK9NQ9wLd56S4vYbDydEatD1iGOP9Wm
        2emm3nKtWqrNyJ7lN2QAmz2/b4HzHr4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-137-D6XI-4yAOcmMf0BzVEQIYA-1; Mon, 24 Oct 2022 16:48:46 -0400
X-MC-Unique: D6XI-4yAOcmMf0BzVEQIYA-1
Received: by mail-qt1-f198.google.com with SMTP id s14-20020a05622a1a8e00b00397eacd9c1aso7887661qtc.21
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtjgD11+A1aHTX9ijK54hqLSilN13SGt8oWF8m3PTwE=;
        b=IKMKcOlrelexkH8gcseiASICBsQR8zzKniDFdN9o3qMs6d4yk1nFP2dv9kBjwASGm/
         mKPEwqoreNG8uOYC4ubhnjEjXQgOLvJUfe7RJlMC3t4IqhrF1uk8OsT7WXBT0YqYaNzu
         O+od22A433/ERrKTQ5DJnGMkIYzOtHWpk24DLB/BQR3oMRYgV0zwkG3EyEbuoDKvhwFJ
         lDYuZUUa4+jb6ZZkmKwsn9B4f/IZ/WYHLMK7RByFkMPu6H8IqSVKOZ/bkpPmSeyzSOLz
         Dx57g6WN5RwcDoRobyonyXKadvcM+/DuwjuSAOWP1yTn5ltDDNrho/3iXp4LlvoAN9pm
         ycDw==
X-Gm-Message-State: ACrzQf0yuqeHcPs5hdjOQuArDB1IhxdWtevijdCe4/760YnrBZqJOQ55
        R57jryIG9QT8dNsiIQ5JY0xj9U0Ga+B8c4zZCBWY3n+//Wus33HyhFNjcMv8C0CcUCMYznJGKyl
        JO5x0kU0pcOfssnf6x0NzFy9nB89cXN4lfYx7EQP7yCvuRGaZ6ZvMlO/nT60ytndLVY3W09uxrA
        ==
X-Received: by 2002:a05:622a:13c8:b0:39c:c0aa:cdfa with SMTP id p8-20020a05622a13c800b0039cc0aacdfamr29059103qtk.251.1666644525095;
        Mon, 24 Oct 2022 13:48:45 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4oC3D5ScenLf0AO4sZWnMdtFGxOo0lGq1CGbaHFx86JYXFD9MW/8lK3Zu73fLeqWmyNTJMwg==
X-Received: by 2002:a05:620a:12ec:b0:6ee:9e71:190 with SMTP id f12-20020a05620a12ec00b006ee9e710190mr23862434qkl.527.1666644514574;
        Mon, 24 Oct 2022 13:48:34 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id d13-20020ac8544d000000b0038d9555b580sm498531qtq.44.2022.10.24.13.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 13:48:34 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Huang Ying <ying.huang@intel.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH RFC 1/2] mm: Always compile in pte markers
Date:   Mon, 24 Oct 2022 16:48:29 -0400
Message-Id: <20221024204830.1342169-2-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024204830.1342169-1-peterx@redhat.com>
References: <20221024204830.1342169-1-peterx@redhat.com>
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

The PTE markers code is tiny and now it's enabled for most of the
distributions.  It's fine to keep it as-is, but to make a broader use of
it (e.g. replacing read error swap entry) it needs to be there always
otherwise we need special code path to take care of !PTE_MARKER case.

It'll be easier just make pte marker always exist.  Use this chance to
extend its usage to anonymous too by simply touching up some of the old
comments, because it'll be used for anonymous pages in the follow up
patches.

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
index 86b95ccb81bb..41a6e7b23415 100644
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
index 25b12d1a7db0..71114f05a68c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3699,11 +3699,10 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
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

