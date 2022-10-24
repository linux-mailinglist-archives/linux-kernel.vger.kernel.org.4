Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76ABE60BD6B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiJXWbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiJXWan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:30:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453592D128C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666644721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vZ6z2mx7oNlRshrZTg5WSyqHxrl+GaeTDPKlsjXuMmM=;
        b=iGsbpUy3uxhqU/Jnbc1e2Sx71hGJA3WId1ZphmkDbuAlSTY2P2a4eE9E6gD4e7ts7k/psF
        mdKbDfLEiIGoeOtqjP93tdVfalf6dHOJT+5xYGgRwzQGwibI/S7tFYCIwq8578Ri5YKkkg
        moKDNPPTUrQQiVNxLDen9BKuXv1PbyM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-230-j-0xwC3zPj2lRwzI6ZAH5w-1; Mon, 24 Oct 2022 16:48:37 -0400
X-MC-Unique: j-0xwC3zPj2lRwzI6ZAH5w-1
Received: by mail-qv1-f71.google.com with SMTP id 71-20020a0c804d000000b004b2fb260447so5928547qva.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZ6z2mx7oNlRshrZTg5WSyqHxrl+GaeTDPKlsjXuMmM=;
        b=5Pg3xtCiooULxLhOORsXpMVj9dVfHVHvpi8dHXDo54+fz8jOqKAkZW5nYFzFmhnvHZ
         OpoUakchyok87L23Yop+HCQ4X94Hortt+nusQDtw20vafVleaeuipNt6or67oQd01fzZ
         dbA5z4CgSpb7ouaLNHdXgLyMlHCygNWl7WyP10pIkwwoXlCZ+yj/nSlosbGZCZgsto7q
         UZ1SmFxThwa2fYmLc+qXW0D/7ihHLCOU+0yMMJNJOf4s2shtWE3F1bWVUakoCdUPP6g+
         RxQKRcXrI1RP7rDcHzI0tlWk0zcjj8rvmUfIYgJ8CYQzoJ05T4gYQwLvZmA6s/gkrMDe
         NNhw==
X-Gm-Message-State: ACrzQf1rSvfYvHCvrfUInB/oznK6L/HDNY0X5CgkBt/iSlPHRMuSRIvW
        JPQXEULsfo5rfz2lD2+VunAdU2j2G+qd9u7Ll5Unk6CN7hj0VptKWV23Sa/viI4dlq+QkvJBq7j
        16eonSJK+aKCOTfsm7bHcIJCynGfzb6aT7AzI8sFNvowH51WVPOyGynE/8ZwMJT6S1gt+0F10MQ
        ==
X-Received: by 2002:a05:6214:b6c:b0:4bb:6747:3089 with SMTP id ey12-20020a0562140b6c00b004bb67473089mr7896759qvb.41.1666644516193;
        Mon, 24 Oct 2022 13:48:36 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6TOJBrQCGAvT7s3wRbvuxazhcJmkdpvIzFrO2mB8REtMPUwzf7bUiQBnGEcyrDxmWpKMjIKA==
X-Received: by 2002:a05:6214:b6c:b0:4bb:6747:3089 with SMTP id ey12-20020a0562140b6c00b004bb67473089mr7896733qvb.41.1666644515915;
        Mon, 24 Oct 2022 13:48:35 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id d13-20020ac8544d000000b0038d9555b580sm498531qtq.44.2022.10.24.13.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 13:48:35 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Huang Ying <ying.huang@intel.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH RFC 2/2] mm: Use pte markers for swap errors
Date:   Mon, 24 Oct 2022 16:48:30 -0400
Message-Id: <20221024204830.1342169-3-peterx@redhat.com>
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

PTE markers are ideal mechanism for things like SWP_SWAPIN_ERROR.  Using a
whole swap entry type for this purpose can be an overkill, especially if we
already have PTE markers.  Define a new bit for swapin error and replace it
with pte markers.  Then we can safely drop SWP_SWAPIN_ERROR and give one
device slot back to swap.

We used to have SWP_SWAPIN_ERROR taking the page pfn as part of the swap
entry, but it's never used.  Neither do I see how it can be useful because
normally the swapin failure should not be caused by a bad page but bad swap
device.  Drop it alongside.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/swap.h    |  6 +-----
 include/linux/swapops.h | 26 ++++++++++++++------------
 mm/memory.c             |  6 ++++--
 mm/shmem.c              |  2 +-
 mm/swapfile.c           |  2 +-
 5 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 211aeca9bfa7..fec6647a289a 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -55,10 +55,6 @@ static inline int current_is_kswapd(void)
  * actions on faults.
  */
 
-#define SWP_SWAPIN_ERROR_NUM 1
-#define SWP_SWAPIN_ERROR     (MAX_SWAPFILES + SWP_HWPOISON_NUM + \
-			     SWP_MIGRATION_NUM + SWP_DEVICE_NUM + \
-			     SWP_PTE_MARKER_NUM)
 /*
  * PTE markers are used to persist information onto PTEs that otherwise
  * should be a none pte.  As its name "PTE" hints, it should only be
@@ -121,7 +117,7 @@ static inline int current_is_kswapd(void)
 #define MAX_SWAPFILES \
 	((1 << MAX_SWAPFILES_SHIFT) - SWP_DEVICE_NUM - \
 	SWP_MIGRATION_NUM - SWP_HWPOISON_NUM - \
-	SWP_PTE_MARKER_NUM - SWP_SWAPIN_ERROR_NUM)
+	SWP_PTE_MARKER_NUM)
 
 /*
  * Magic header for a swap area. The first part of the union is
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 41a6e7b23415..dd087b7287b0 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -162,16 +162,6 @@ static inline void *swp_to_radix_entry(swp_entry_t entry)
 	return xa_mk_value(entry.val);
 }
 
-static inline swp_entry_t make_swapin_error_entry(struct page *page)
-{
-	return swp_entry(SWP_SWAPIN_ERROR, page_to_pfn(page));
-}
-
-static inline int is_swapin_error_entry(swp_entry_t entry)
-{
-	return swp_type(entry) == SWP_SWAPIN_ERROR;
-}
-
 #if IS_ENABLED(CONFIG_DEVICE_PRIVATE)
 static inline swp_entry_t make_readable_device_private_entry(pgoff_t offset)
 {
@@ -409,8 +399,9 @@ static inline bool is_migration_entry_dirty(swp_entry_t entry)
 
 typedef unsigned long pte_marker;
 
-#define  PTE_MARKER_UFFD_WP  BIT(0)
-#define  PTE_MARKER_MASK     (PTE_MARKER_UFFD_WP)
+#define  PTE_MARKER_UFFD_WP			BIT(0)
+#define  PTE_MARKER_SWAP_ERROR			BIT(1)
+#define  PTE_MARKER_MASK			(BIT(2) - 1)
 
 static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
 {
@@ -437,6 +428,17 @@ static inline pte_t make_pte_marker(pte_marker marker)
 	return swp_entry_to_pte(make_pte_marker_entry(marker));
 }
 
+static inline swp_entry_t make_swapin_error_entry(void)
+{
+	return make_pte_marker_entry(PTE_MARKER_SWAP_ERROR);
+}
+
+static inline int is_swapin_error_entry(swp_entry_t entry)
+{
+	return is_pte_marker_entry(entry) &&
+	    (pte_marker_get(entry) & PTE_MARKER_SWAP_ERROR);
+}
+
 /*
  * This is a special version to check pte_none() just to cover the case when
  * the pte is a pte marker.  It existed because in many cases the pte marker
diff --git a/mm/memory.c b/mm/memory.c
index 71114f05a68c..cf602c3854c3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3705,6 +3705,10 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 	if (WARN_ON_ONCE(!marker))
 		return VM_FAULT_SIGBUS;
 
+	/* Higher priority than uffd-wp when data corrupted */
+	if (marker & PTE_MARKER_SWAP_ERROR)
+		return VM_FAULT_SIGBUS;
+
 	if (pte_marker_entry_uffd_wp(entry))
 		return pte_marker_handle_uffd_wp(vmf);
 
@@ -3764,8 +3768,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			put_page(vmf->page);
 		} else if (is_hwpoison_entry(entry)) {
 			ret = VM_FAULT_HWPOISON;
-		} else if (is_swapin_error_entry(entry)) {
-			ret = VM_FAULT_SIGBUS;
 		} else if (is_pte_marker_entry(entry)) {
 			ret = handle_pte_marker(vmf);
 		} else {
diff --git a/mm/shmem.c b/mm/shmem.c
index c5f7a6668416..47dc595e98a3 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1682,7 +1682,7 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
 	swp_entry_t swapin_error;
 	void *old;
 
-	swapin_error = make_swapin_error_entry(&folio->page);
+	swapin_error = make_swapin_error_entry();
 	old = xa_cmpxchg_irq(&mapping->i_pages, index,
 			     swp_to_radix_entry(swap),
 			     swp_to_radix_entry(swapin_error), 0);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 5fc1237a9f21..13f2569a6719 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1781,7 +1781,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 		pte_t pteval;
 
 		dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
-		pteval = swp_entry_to_pte(make_swapin_error_entry(page));
+		pteval = swp_entry_to_pte(make_swapin_error_entry());
 		set_pte_at(vma->vm_mm, addr, pte, pteval);
 		swap_free(entry);
 		ret = 0;
-- 
2.37.3

